import discord
from discord.ext import commands
import subprocess
import asyncio
import logging
import os

# Cau hinh logging de theo doi cac hoat dong
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(message)s')

# Tao bot voi intents
intents = discord.Intents.default()
intents.message_content = True
intents.typing = False
intents.presences = False

# Sử dụng commands.Bot thay vì discord.Bot
client = commands.Bot(command_prefix="!", intents=intents)

# Luu tru thong tin nguoi dung va ket noi SSH
user_authenticated = {}  # Luu tru trang thai xac thuc cua nguoi dung
user_connections = {}    # Luu tru ket noi SSH cua nguoi dung

# Mat khau dang nhap cho bot
PASSWORD = "huy"

# Kiem tra nguoi dung da xac thuc chua
def is_authenticated(user_id):
    return user_authenticated.get(user_id, False)

# Ham ket noi SSH va chay lenh lien tuc
async def run_command_streaming(ssh_host: str, password: str, port: str, command: str, channel):
    """Chay lenh trong SSH va gui ket qua theo dong (streaming)"""
    ssh_command = f"sshpass -p {password} ssh -p {port} {ssh_host} '{command}'"
    
    # Tao subprocess de chay lenh
    process = subprocess.Popen(ssh_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

    # Doc output cua lenh va gui tung dong vao Discord
    while True:
        output = process.stdout.readline()
        if output == '' and process.poll() is not None:
            break
        if output:
            await channel.send(output.strip())
    
    # Kiem tra loi tu stderr
    error = process.stderr.read()
    if error:
        await channel.send(f"Loi: {error.strip()}")

# Lenh /login de yeu cau nguoi dung nhap mat khau
@client.command(name="login")
async def login(ctx, password: str):
    """Lenh de nguoi dung dang nhap bang mat khau"""
    if password == PASSWORD:
        user_authenticated[ctx.author.id] = True
        await ctx.send("Ban da dang nhap thanh cong! Hay ket noi voi SSH va chay lenh.", ephemeral=True)
    else:
        await ctx.send("Mat khau sai. Vui long thu lai.", ephemeral=True)

# Lenh /connect de ket noi SSH
@client.command(name="connect")
async def connect(ctx, ssh_host: str, password: str, port: str):
    """Ket noi vao may chu SSH va xac thuc ket noi"""
    if not is_authenticated(ctx.author.id):
        await ctx.send("Ban chua dang nhap. Vui long su dung lenh `/login <mat khau>` truoc.", ephemeral=True)
        return

    # Luu ket noi SSH
    user_connections[ctx.author.id] = {"ssh_host": ssh_host, "password": password, "port": port}
    await ctx.send(f"Da ket noi den {ssh_host} qua cong {port}.", ephemeral=True)

# Lenh /tmate de ket noi tmate session
@client.command(name="tmate")
async def tmate(ctx, tmate_session: str, password: str):
    """Ket noi vao phien tmate voi session ID"""
    if not is_authenticated(ctx.author.id):
        await ctx.send("Ban chua dang nhap. Vui long su dung lenh `/login <mat khau>` truoc.", ephemeral=True)
        return

    # Luu thong tin tmate
    user_connections[ctx.author.id] = {"ssh_host": tmate_session, "password": password, "port": "22"}  # Mac dinh port tmate la 22
    await ctx.send(f"Da ket noi toi phien tmate {tmate_session}. Ban co the chay lenh bang /run.", ephemeral=True)

# Lenh /run de chay lenh trong SSH hoac tmate
@client.command(name="run")
async def run(ctx, command: str):
    """Chay lenh trong SSH da ket noi hoac tmate"""
    if not is_authenticated(ctx.author.id):
        await ctx.send("Ban chua dang nhap. Vui long su dung lenh `/login <mat khau>` truoc.", ephemeral=True)
        return

    connection = user_connections.get(ctx.author.id)
    if not connection:
        await ctx.send("Ban chua ket noi toi SSH hoac tmate. Hay su dung lenh `/connect <ssh_host> <mat khau> <port>` hoac `/tmate <session_id> <mat khau>` de ket noi.", ephemeral=True)
        return

    # Gui lenh va nhan ket qua theo dong (streaming)
    await ctx.send(f"Dang chay lenh: `{command}`", ephemeral=True)
    await run_command_streaming(connection["ssh_host"], connection["password"], connection["port"], command, ctx.channel)

# Lang nghe su kien khi bot da san sang
@client.event
async def on_ready():
    logging.info(f'Bot da dang nhap thanh cong voi tai khoan: {client.user}')

# Chay bot
client.run('MTI5ODUwMzM1NzMyOTA0NzYzNg.G6lfNx.PGl9xgNLTLtcrui8-j8Yfx8DZs3atBimge8_Yo')
