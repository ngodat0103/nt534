from diagrams import Diagram, Cluster, Edge
from diagrams.onprem.network import Internet
from diagrams.onprem.compute import Server
from diagrams.generic.os import Ubuntu

with Diagram("VirtualBox Network", filename="network_diagram", outformat="png", show=False):
    internet = Internet("Internet")

    with Cluster("Host-Only Network: 192.168.56.0/24"):
        squid_proxy = Server("Squid Proxy\n192.168.56.10")
        virus_server = Server("Virus Server (ICAP)\n192.168.56.11")
        client = Ubuntu("Ubuntu Desktop Client\n192.168.56.30")
        dlp_app = Server("DLP Application\n192.168.56.1")

    # Connections
    client >> squid_proxy
    squid_proxy >> Edge(label="ICAP (Downloads)") >> virus_server
    squid_proxy >> Edge(label="ICAP (Uploads)") >> dlp_app
    squid_proxy >> internet