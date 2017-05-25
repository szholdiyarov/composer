(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-baseimage:x86_64-0.1.0
docker tag hyperledger/fabric-baseimage:x86_64-0.1.0 hyperledger/fabric-baseimage:latest

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin")   open http://localhost:8080
            ;;
"Linux")    if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                 xdg-open http://localhost:8080
	        elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
                       #elif other types bla bla
	        else   
		            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
            ;;
*)          echo "Playground not launched - this OS is currently not supported "
            ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �&Y �[o�0�yxᥐ�p�21�BJ�AI`�S��&�Ҳ��}v� !a]�j�$�$r9�o���c���M;�� ���������u�]�w���"�"_DA�B��':�#��5��(e�(�0 �[)���^����G(�%Po�/"�Sd�H� ��ޚ�pj�7 �gm���b:��{k����)��zf���[���1L|�F����� h�F��v$zid6����(�ɳkYӵ���!����"�1N`&#m�Y�#�%�4�_�9��)Z�F�7
6�ڄ��Mm��M�6�7+��l.dY3��&��pi�cِG�q��jF1^�ӹ1H|�$q�Z�É�9�vnE�V����t>1y%+��|��T|~:��U8���L*��r�5<�7ުW�?�ˣ�65���P%�TE!�a��ŝ�ȫ&���]��ڷ$\��E�C�!
ݖ��h�6hD.�!�~�ˀ8�C&~�4p�f�*�t���s���_�f�Z�ߩl�+����Q��|�N[��#u�PuRő:��N$�i� ���	���>�cr�,pp�\ե��h���-y�Ϸ<H�G����QH?A���Ā�lH�n/���p?s�� w+��� gnx�g�uȸ��C��,7*O�������]j
�n�C�����/O@{�8�s� *kaJ�M֕z�*m��X(6P�b��K"��,�
�����e��ļ���㡬�_�(��Oy�~��ǧ���`0��`0��`0��`0���'�` (  