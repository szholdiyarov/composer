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
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else   
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �&Y �][����3��:/��3����T�榨� �x��wo������d.��8�agW�R	J���굾�:�7�'��ʍ��4��|
�4M�(M"�w���(��(M���1��R#?�9����vZ�}Y��v��\��(�G�O|?�������4^f2".�?E�t%�2��oϠ�2.�?�^ɿ�Y���4��%)���P�w_{�{�h�\�Z�9�%���}��S���p��)E*���k��O'^���r�I�8
�"�;y?=�{4�b$�ԗZ���w�O�x��z���C�1�O#��9��`���M��}�e��X�$l�sY��|�t|ԧ)��\��(�EQ�'����^�������"^��8�>��xq,�)��p�u'6d�&�B�z�lC��E�T)M��(�2�I}a,0���F)�[e�ւ6U�	�e���i�ϯ}�`!���x�	Z��Աc���#��sݧ(��h��:���OYz8�l%�n���Ri&������Ł��"�-T?�%�^|��}��+��K��ww�o�_�ۋ�K�O�?���at5�W
>J�wWǯ׉=��+��������@+�_
�^�Y���l�Z~Y����\�@(k�R�Y��2C�gͥ�m-��0\M�nO�0�BE�r��,�Դ�����A4��F �<��5L���x�Fdb�P�S�S�&mdq���!9�G��9����'��6̅;g�ヸ��B��b�Mn1�zn���A�!⊠���x�ŌG�!��z�?�[��Q��܂���@��W~�N��"r����;i�2�̢l�5�H�X��`a�}� ď�������E�I>�{o-�+����g��x�P����P�ȀS}U���ÛC����F�v#a����+6F�L��~�A�ڀv�,g%�U.܎Pޕ��e��(nugJ7s-j6:p����{B.rp��G�'3�;�A�_�� \�?�[ix⹲� ����"ב.�ˢ�N�rІobd��<�� �-��hӁ����H���Jy�2��E��#�ס��L�Il�@�0�"�l�Qs^?���߰����!���-���&���>d�b��F<g�x��r]�a���l��ݚY~��g�����G���K������>����>�������k�/�
�w�;�ׁzd�7�;u��%�-��=q��%��|�!G�8*�#F��P�1��	���#;� � GS�.����̽?�H�?�������J�gF�D���d�{'ZL��%p*k�9jXC"ԗ������ۻr��,�{��c��"�s1����V���( ͽ���K���2�,\�թ� �����&́�m���9�zKӔ3#gh�ˋ"�?�|^ o秋�8^���X{x�gB��Z���C]��;����6%�|�H�9��A�A�9lQ��Qt�f��LH��5>�8�hQ�y��k�_8
r���M��X����sS��gr]K���m3�>�P�0Y����O�K�ߵ����������R�!��Y���=�?B�h��e���������\����s/�%�����/������+U�O�����O��$�^@�lqt�"���4e�"����Q~�d�b4�z�W���](C���?���(������?|�'��&�<i�'�ˬ�YB�+"�8�0��(�������ll��m3b2n�I���-�/�eK֓�9�6��s�i��nG�sln���_n�ۭ �Q���R��a���^���f�O��_
>J���CV��T���_5�W�����f�O������������T�_)x[�����{3��#�C��)���h��t��>���ʡc����f�M���� ���&s�;P�\��#�.�CL2����ܚ�=���a�|�P��I��N���lXo&�w�A�1hJ�x\(�R��;Y�c옞�'Zט#m�G��lp�H:����9;'�8���c� N��9aH΁ ҳo��-LC^���Νp�n��3Զ��$tpaA�ܠ�w�=Ο��={2hBU'���F�����z�_@�I���u���N�,�Ҳ��h�����j*8���1���Y��e�$d��9Ɋ�����O�K��3���������3�*�/U�_��U����o�����-�.��*�/�����?F�d��������+��s��w��;N�>����C��W.���I/�~�a04�|�!��� <g]�\E���,�8, �Ϣ4K��]e��~(C����!4�W�_� �Oe®ȯV+U���؜����=�i�m����?��)����H�	�S����;����^����=��n�c�Vi�ہ�8"��	�y� ���`�ʇ7y��)%�v�Y���n<��8���÷��8�Gi���/o��������?T��w9�P���/3
��'�J�K�{�����Ǘ����q���_>R�/-�X�8z\Xɿ��?�>_�IW�?e�S�����Y�X�ql�t�b)��(�s	��l<!p�u<�Y�	ǷY���j��4�!���p��S5����`�����x�����	���m,� �r�+�5�D�|����j@.�l�uw�9��+>��z*�F��Qc&�:e^3�Z������p�i�a��3���}m�`�`f���ϻ����r�w�]���w��P�x��Q^�e����A��B�D���C	�i�7����J�k�_�c������s Vrt�"^c	K ��o����>z�gI ����1v?n���IUZ.�wIU��72���F�o��a=������@C��~شs�ā�ɧ>;�S�żx��Զ�1���t�o�0��"F�E7Ӭ����	5��D�Xo�Ql�f:Gm᭸h.)�74L��(g=�@�p[�G1��#�Fz�H��9}��H,̹����p�wk�ʹ�Q�њ����)�,Ԧϩ��;�t�3r�¼�kԥΈ$������>X�.k�����9�ۻ����=��"�v6�8�9g��r����b ��P�0�)��v���K4�[�3ۧwKkUׇ��9^(i���}��i9�;�����R�[��^��>G�PZ��%ʐ�������JW��������߯�����k���;��4r�����>|�ǽ��O�9�b�Ql �-y�:��u �{�Q��}�4�I�r�?�z�!Dbl'�����>���$���ld�l�k��e+=5%���ʱkiBÐNe3&ɜ��ep*7<��k����q�W��k�A@O7�x�~gw������f��9r5��Z�lޥ�ݴo���<k$���Ž������Z�-Xr�\���������i4l����BEا���<�)>�������Q���+���O>����������j����2�������?+���Q��W����5��F���]`.��1���\.��������Q]�����+��������b������T�+��?�6McX���P$K��3E">�3ഋ#���>ྏP��9���.0�ʐ�+�ߏ���j��\��(-S���o�S3��N_`�Мznl[�b�7�H[��ɋ��A4������7�;��%k��0�}����p���C�[WpD�S�޵t����MN1���Je�iͫ�?��s?-�?J�̿�G����������/�U��*[?�
+����e~���~���\9j�id����d������B�I��k�1�E\���5re/��}����N�x����"��UM�.�7<�iv��]��W�:��OO?L�t�}�ƿh�$�����\1p#{�}�e�ڕ[���5jG�kWř��lE0]��W��d?������e�����jWN�������$��v坺`/6������Kvu��֧����ڞ.��fiGŨp훻�AE�[_�v�<�|W�ʰ��v���ꂨ��MCTEtn:r�U ���C�O^�}<��"ͮ��(�תJr�#��Q����8���G�v��}��]t�~O�u�?(��Z[���-����a{�F�S���g���{�yˤ�>��zq�W5��zT��bw��ӫ�ݮ�������R�������k~�rQm�a�������|�o�i������^O�,u�p��l���d�@�I�ު=<��69B�GF�l���� }T�#���-��⶧n��y8�b�u.2|Wo�&�U�+�7�H��hȊ��أ�*��o�t�?>m*������6���+Ó8[�[;���>{R��CE?��'�P�������]m��d���rx.\%�� �1����뺗�u�麭{ߔ\{���֭=�މ	jBL0�%h�$h�����~R�4��H���#
1Q?�m��lg�9;����M�����ҧ��������<z��t�<��|��J�4D�
�g�d��ERx6��v��F��L,u)���ønm��1�ѓ�5Y^�ޗ�t�[]�o���4+�cѥ� l�^ ��k@�>��g6�	9���	�B>�h���*K�����������pM4'�F��~� 4��23i�aX�����h�mf�f��xdɈ���麩k�v�X%�;��8�^=<�ߡ$A��Mf�#�m![H�)Z��O�KP/U�*ۑ���fqθ	G�胉�f��8���)��GBdV���q]�����7k��>���b�4d�:*�·*�%�C�n���h�,GS䃍��0�}��� mN�����L6��pz48���)�� ��w��#?��i>���:��b'�/*;T�Ӫ,��{0�����Tk5�.s�렖N�B�A7��SIG�x��~�����~�-�3z:��Ƌ��oFB�����]ѯ}��ߕ��^�
�qjM1�0��]� �,��>��k�㒻��e��1�3�t=l��3����E]䢹@٢F)�<(��v�f� �r�	�Z]�����L^�����smo_��먒�lAU8n�0��~�\��{�=8����'i�L~�I��2�1p^�c�N�qPo�4cosb�1��U~��k�\:>u�os�X����K���kQQ�or�v!�۵�9�eWg��ɩ|E���c�����G��+�G��|�M6���[u���Ǎ���~�A�����?�~���C��vb�����~��W;��T���H��wy\Հ�t� `�m/�������<`��m_���G�WA<��<��=<� '�:{{��;�����n�f�{������.=���A�P�
�V����	�¡:���`7.�x�Ə΁���g�A�>=qn���O@jrƦ����=��0G`$�Sܼ^���9�EE.Ag�]���l��0&���su�0�O!|0�x緙��(,��]>Pm9"���aw,Qv���f���vs�BD��N��f���)˽\�~�J�tA=L���0�b�z����d3����3�mN6t��$�g���9
SJt��0Q��i:KG;��zL���Dx�,�g��fQe��A_�46SE�E&�R�S�g�=J�7JyQ��a9Um	1!����`!�m�TU�X6�^/��8���K!
�ri?r��)�	k3am&�*LX��v;d ,�/�6�����]��[j�p��=5WB֭j��	��E�5%q�A@y��+�d��v�l��z\��Z���M�	��<�
m��h�H()f�d���	�8��̰ä�t93-8�v$�b-���u����X����&L�~`���X%�ZVj�X+��ҟ�E�,VӼx-�%�(i��i�yϰ�U��D�No'�B.H����!�c"�n���+K���e��3ʲ��l�R ˥�o�S)~w���i&?�|�G�E?õ��|�C�Y�կ��a��j�M*X�S����|*WVU�ܦ�,8#�y�(Q:\HUEӴ��㙖��S�=�3�K�%�z��GӾ!Ih]>F�
��i�:������MZ�SY�j1�݉*h?��U*���\�)�{�j��%�>WU\xo�%�HY�������WP�(����[.�����!A�M�I�3Ԛ����J��[xa�a5�+Ѣ���k'��r��7��FbRM 9�>����dM�"�Ue$�&�Jg���)��٥�6a�Ї�-V��i��
0�d�^�_k,!�ل��!��- ��lHꎏH���ʵ	)��ꞡ�&E�A	�'Y�4����i�l��f�l��l�p#�9QpMA��yU�>�[�ڀ֠S��kWl����~��2y��� 9t�ۧ�Cg��_9]U�g+��j�.p]�ms�b�;m�F�p���jj�������研,ոtt#��8^i�4:�q'���Ҽ�Vk�WZ���zB?÷���(<��'5Y�-'��lM�6䡛��k`�ᇟC�>��úM��9g�3kWA`�{��%s�4(�yV�U̖C�@����Z�c�<��,��i��S\V��ypW�/F>sz2+f�z�@t�'ʪ��L���Y ��f$}�Q��Y����GnE^�^��Z����[��R`���R���C�h����� �"	���t�B��[��g+;��p�Z�H����Ƣ���h�0�%k8z�`�K{�8�NZLOc�YS��{��A$�D��)��M��/�^��F,�J�.�▖h��D+�DCH�C�^��B"(t���-��G�s���I�+���a�B�S�C#{0p ���-&��|���q�����xH7��51"�%j���A�!�no<�`UW��b4SˑL#�a0җ����}B�.P����������a҂]�+[�k�a��9��!�	�}��-Q�")D�#��u�LS &�Co9���>.մb/��}��i�m�q�Ǻv�����t��)�������i�����ݡ�:��z贕a��xX�=,��[�O���޿���,�I��D�VD2S��Q
W�H���\���1/;���@����3�<X��u��E��$&���
��"�͚����x[��3��0jSI`bJى�!2(��d
G�vJ�Ԗ+�0���������]&�xY�p#�QnO���0<�}Q8]JI���t0do,6�!
��<��.�	�[j���g��;(EyrHԕ(t��+}t���<@�^�,���G��U����I^�È�2	��g�~����%��;��&&�$ι �ɒ�V��r�n���]�z��]�ye�6�8�ߌ�Pޏ{6ⷒS�>�S6�c���J!��l��f�.Ķ�(�����i���Q�h���tÔ��8��W**�i������>�%~���%A�oAlB�Ne����;��J�r�\�h��<NB'�+,7�"��]�>��7�Z/��i�~�[/=������Ky��C����fW���|7;ͦ�Տ�����w��>����,	87�>���<Hw_z�������oz��7���'������'����Sq�8��[׮4�~�W&W�t��FӉjh:�F��W~�c�|��;���8=�x�7���=	�N��(���)j�N��Yj�6�Ӧv��N�&`�lj������H�i��iS;mj����>����yh��e�^8�r��%���,4�6y�m!t�����o=fb褏���!��<��5�E���n��3�?�ڟRm��m�q�g<�#p$���d��zmj��2O˞3cG[�93�� {Z�=g�6�8.Ü�#��=���13��q��Z[����G���y\�R�����v����d��m�/���  