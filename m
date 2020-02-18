Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBD161FA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 04:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgBRDqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 22:46:37 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9809 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgBRDqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581997595; x=1613533595;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wXfaSZCeSNxTy3FkTII7UTLfc0aIQW1qIv2A/zko3tQ=;
  b=LgMnBp+TjtM5lP/8H9yBYM9/2UHySX374cbqD+n4VRHPpdKs1JNSBi+R
   LXhxNuhZWsbUs3IK34mcsHtGbCLZSIIDQ6cY2QMhyLDxAK62TF1QXFLSZ
   vxjjmH6etHkvt1GB4+X5IoKKXfOPcfB2o0x31h18miIHW+numTNhY/rJt
   KwoExsX7LyJyLqKF7xNgBoIx+s2hGIlDddvsCQQ7vvI1ETkLS8RcCWatJ
   YQ0QMPpBurUlmYR5CyYImapRVB+VgmbWGq1H1Q9HcHlQyX+5elMD1Jbd+
   oQhdzcDuRZcYWobggNQBJC6ViVSw2c/vd4OeA6m7ojpgD0u6T80Rsgf6F
   Q==;
IronPort-SDR: dnlKyu4cQC6ZGYQgZU9x/w4bxNWCUsQfLcXNOPfcEBxWZC4fHexv/Z/0A7XzKqsM9oB04mpjUx
 jNEl8iBxb/gJ+2d9xu8Ng7JmjI3wf8AAeSfNwF/4GH3ktRHCrucQu9sdsleVmbpJEwanzdSgXQ
 3IHd61nPcJ9dNvA9AaWfWD9gwGV3uL6hWwhz/g1RrxFqNSdytukjliifhF7Swfo0dbHoTNrq8C
 aMZNrJHWbAfcQwmG8n1Zmhl7kB4axPk+Jc3qECvVgSGDGOy8gAU6iyrkCPmH8R1EKxecI2gOrC
 Pj4=
X-IronPort-AV: E=Sophos;i="5.70,455,1574092800"; 
   d="scan'208";a="130053896"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2020 11:46:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGL8y0aYDiIK7AzpmlUMHqg7NSLnzU1SoU8MEd9HpuZwCWu+39zuJgluq0rWWrYcMlZxQjNPop39+lCvkSFJgSRq4GOHc5AtqMvgzrhGiQmC3VzD85NWaESzBpdmFCq7g1ooNDXBXH5gnVIxBS6n6U+DFzrUKF6ltzS0/yiJVMOf2VsbMA4pahSOWLuyZ8tignZ3cc7I54AYrdJJ1iZcyauciyUT8AWfvkA+S147gYvASTo3EeIwnn/LxRKeZl2hqh3fk+39M/Imk6qy05Vi67DHYCk8F2MO3pxfHtz/7lCozGSc240AbIUUx0H5pox7LSb1fpEnQYVslY+INx6CNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe1e2BJu1Q5HRI5wJ/T8kuhiqXk+7695gjrWHqIwU4k=;
 b=Z3EmK8y7TNOnWvk32vKkzfOFLbkNHtwd6wglX3OS2UjseYpiguirnB93CNrDJxin+T38j6ypCxSz7Sm9Y7gIoz7XTT/VcntanvH+sDxW/7PEJhhJLqSePo7kTuLyosHANUvLptVEl8Sj30+59ddpT3QsRE/TLy9Mxtweu/nF/iD9WxHL7CXxCvqOAbnkIN+wkQg4ZDgqe1S/SEp++dlNybyTdgXz886peYx7JWv56UVy7wZH9iisNSG7OH7fIowAktLxukWTItCRomlMe9queKxTmFWchye5lfVO5vth7tS1LZ0BJ1RZLVJVflk2jJbyPZ4Aulk3AI2nNh+cN3YJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe1e2BJu1Q5HRI5wJ/T8kuhiqXk+7695gjrWHqIwU4k=;
 b=tSkikbmXB7gIUwjkH1ZouvmvVkqd3ZKWjAot8o/NNmAiVzRqeZK+gBXZNZvOa+uzOXl0H7CMkDyqq1/tKfZPv7YZ0VDIC6C75MQkZBK1VUFQ7uNfpZz/cjGxAXHc8GVlrDs9kHpLVHxHVeddPJ7WcdxhSSf4ZYTDOgi3PGac5F0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5287.namprd04.prod.outlook.com (20.178.48.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 03:46:33 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 03:46:33 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH 44/44] docs: filesystems: convert zonefs.txt to ReST
Thread-Topic: [PATCH 44/44] docs: filesystems: convert zonefs.txt to ReST
Thread-Index: AQHV5a0X87AdVAFJLEWETcsvId33Ig==
Date:   Tue, 18 Feb 2020 03:46:32 +0000
Message-ID: <BYAPR04MB581677BD8AB65AFEE14E50DFE7110@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
 <42a7cfcd19f6b904a9a3188fd4af71bed5050052.1581955849.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f8b6c55-6c19-4404-acfd-08d7b4252570
x-ms-traffictypediagnostic: BYAPR04MB5287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5287BA84D2B25440727EE83EE7110@BYAPR04MB5287.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(189003)(9686003)(81166006)(81156014)(8676002)(66946007)(76116006)(26005)(8936002)(66446008)(66476007)(64756008)(91956017)(66556008)(86362001)(7696005)(316002)(186003)(478600001)(53546011)(52536014)(5660300002)(4001150100001)(33656002)(54906003)(4326008)(2906002)(71200400001)(6506007)(110136005)(55016002)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5287;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+bWCTL1MQbIGs7LpXrRdFC9b/qQf1s+Wh2QnIluvpINS3CRlMpexM9QYjQehBtMgArCqwfOh0APbISHd9PBGIts8aAqldxKl9jzvnum1gJsbzm/OiSQr6CLnrkmZatCjF8N+x0PLx7orN+r81iakGRRASByg/TvvM9H2MWpSPw/2v5dX/xLv+VOOwGL7+g14sRLl+Nh6jTb17tByCsbLatsV6zrq78zZFPcLm/PogSrejVRb/pDXyJ2/L7eQ+X5pG2IJwETNqCZefie4fsDOZ64g4JKCnvNF+ncy4/x0yK7JGjy+hE+Z5a4Pu59v3qPXUVWuc/MX4f5R/+DbOAtNScGEEo15kfZa8AH8hkFnbMmUmgY70Rcv3jjCYJP0iE9e1hwRl/3PBeQQL05tvrNsAgWXzlzLsyiz5UaoNZS4SVBXfYDOVF1vqvd3fejn1FakU4Z/DgRmJdx4f1uMZALXeIdNos2r0eeElviKMvCV97z/0IfnhyNEFbAWt0Aofxb
x-ms-exchange-antispam-messagedata: JNK1iUXFyz7uukW7EUaw7SEPU6xPtaN3VY3867ml15dP4305vKKkNV/+snU0H/vY8qh0jp8XzMrGVzEog18+coQKQOWL1kZEIAhhsb9owKrVFftmzvuT8jB8H5eJk9dzbMcHlUDegv8rT2yC51/yFg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8b6c55-6c19-4404-acfd-08d7b4252570
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 03:46:32.9436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kw8Kbx8d57s+Ggnb2pw99pAqW9D6Pee3zPHXsejkLIL305vOx/wSgeGM3GaAnSffLF3SWWaf9otBDgbBxMEcxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5287
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/02/18 1:12, Mauro Carvalho Chehab wrote:=0A=
> - Add a SPDX header;=0A=
> - Add a document title;=0A=
> - Some whitespace fixes and new line breaks;=0A=
> - Mark literal blocks as such;=0A=
> - Add it to filesystems/index.rst.=0A=
> =0A=
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0A=
=0A=
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
> ---=0A=
>  Documentation/filesystems/index.rst           |   1 +=0A=
>  .../filesystems/{zonefs.txt =3D> zonefs.rst}    | 106 ++++++++++--------=
=0A=
>  2 files changed, 58 insertions(+), 49 deletions(-)=0A=
>  rename Documentation/filesystems/{zonefs.txt =3D> zonefs.rst} (90%)=0A=
> =0A=
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesyst=
ems/index.rst=0A=
> index ec03cb4d7353..53f46a88e6ec 100644=0A=
> --- a/Documentation/filesystems/index.rst=0A=
> +++ b/Documentation/filesystems/index.rst=0A=
> @@ -95,3 +95,4 @@ Documentation for filesystem implementations.=0A=
>     udf=0A=
>     virtiofs=0A=
>     vfat=0A=
> +   zonefs=0A=
> diff --git a/Documentation/filesystems/zonefs.txt b/Documentation/filesys=
tems/zonefs.rst=0A=
> similarity index 90%=0A=
> rename from Documentation/filesystems/zonefs.txt=0A=
> rename to Documentation/filesystems/zonefs.rst=0A=
> index 935bf22031ca..7e733e751e98 100644=0A=
> --- a/Documentation/filesystems/zonefs.txt=0A=
> +++ b/Documentation/filesystems/zonefs.rst=0A=
> @@ -1,4 +1,8 @@=0A=
> +.. SPDX-License-Identifier: GPL-2.0=0A=
> +=0A=
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>  ZoneFS - Zone filesystem for Zoned block devices=0A=
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>  =0A=
>  Introduction=0A=
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> @@ -29,6 +33,7 @@ Zoned block devices=0A=
>  Zoned storage devices belong to a class of storage devices with an addre=
ss=0A=
>  space that is divided into zones. A zone is a group of consecutive LBAs =
and all=0A=
>  zones are contiguous (there are no LBA gaps). Zones may have different t=
ypes.=0A=
> +=0A=
>  * Conventional zones: there are no access constraints to LBAs belonging =
to=0A=
>    conventional zones. Any read or write access can be executed, similarl=
y to a=0A=
>    regular block device.=0A=
> @@ -158,6 +163,7 @@ Format options=0A=
>  --------------=0A=
>  =0A=
>  Several optional features of zonefs can be enabled at format time.=0A=
> +=0A=
>  * Conventional zone aggregation: ranges of contiguous conventional zones=
 can be=0A=
>    aggregated into a single larger file instead of the default one file p=
er zone.=0A=
>  * File ownership: The owner UID and GID of zone files is by default 0 (r=
oot)=0A=
> @@ -249,7 +255,7 @@ permissions.=0A=
>  Further action taken by zonefs I/O error recovery can be controlled by t=
he user=0A=
>  with the "errors=3Dxxx" mount option. The table below summarizes the res=
ult of=0A=
>  zonefs I/O error processing depending on the mount option and on the zon=
e=0A=
> -conditions.=0A=
> +conditions::=0A=
>  =0A=
>      +--------------+-----------+----------------------------------------=
-+=0A=
>      |              |           |            Post error state            =
 |=0A=
> @@ -275,6 +281,7 @@ conditions.=0A=
>      +--------------+-----------+----------------------------------------=
-+=0A=
>  =0A=
>  Further notes:=0A=
> +=0A=
>  * The "errors=3Dremount-ro" mount option is the default behavior of zone=
fs I/O=0A=
>    error processing if no errors mount option is specified.=0A=
>  * With the "errors=3Dremount-ro" mount option, the change of the file ac=
cess=0A=
> @@ -302,6 +309,7 @@ Mount options=0A=
>  zonefs define the "errors=3D<behavior>" mount option to allow the user t=
o specify=0A=
>  zonefs behavior in response to I/O errors, inode size inconsistencies or=
 zone=0A=
>  condition chages. The defined behaviors are as follow:=0A=
> +=0A=
>  * remount-ro (default)=0A=
>  * zone-ro=0A=
>  * zone-offline=0A=
> @@ -325,78 +333,78 @@ Examples=0A=
>  --------=0A=
>  =0A=
>  The following formats a 15TB host-managed SMR HDD with 256 MB zones=0A=
> -with the conventional zones aggregation feature enabled.=0A=
> +with the conventional zones aggregation feature enabled::=0A=
>  =0A=
> -# mkzonefs -o aggr_cnv /dev/sdX=0A=
> -# mount -t zonefs /dev/sdX /mnt=0A=
> -# ls -l /mnt/=0A=
> -total 0=0A=
> -dr-xr-xr-x 2 root root     1 Nov 25 13:23 cnv=0A=
> -dr-xr-xr-x 2 root root 55356 Nov 25 13:23 seq=0A=
> +    # mkzonefs -o aggr_cnv /dev/sdX=0A=
> +    # mount -t zonefs /dev/sdX /mnt=0A=
> +    # ls -l /mnt/=0A=
> +    total 0=0A=
> +    dr-xr-xr-x 2 root root     1 Nov 25 13:23 cnv=0A=
> +    dr-xr-xr-x 2 root root 55356 Nov 25 13:23 seq=0A=
>  =0A=
>  The size of the zone files sub-directories indicate the number of files=
=0A=
>  existing for each type of zones. In this example, there is only one=0A=
>  conventional zone file (all conventional zones are aggregated under a si=
ngle=0A=
> -file).=0A=
> +file)::=0A=
>  =0A=
> -# ls -l /mnt/cnv=0A=
> -total 137101312=0A=
> --rw-r----- 1 root root 140391743488 Nov 25 13:23 0=0A=
> +    # ls -l /mnt/cnv=0A=
> +    total 137101312=0A=
> +    -rw-r----- 1 root root 140391743488 Nov 25 13:23 0=0A=
>  =0A=
> -This aggregated conventional zone file can be used as a regular file.=0A=
> +This aggregated conventional zone file can be used as a regular file::=
=0A=
>  =0A=
> -# mkfs.ext4 /mnt/cnv/0=0A=
> -# mount -o loop /mnt/cnv/0 /data=0A=
> +    # mkfs.ext4 /mnt/cnv/0=0A=
> +    # mount -o loop /mnt/cnv/0 /data=0A=
>  =0A=
>  The "seq" sub-directory grouping files for sequential write zones has in=
 this=0A=
> -example 55356 zones.=0A=
> +example 55356 zones::=0A=
>  =0A=
> -# ls -lv /mnt/seq=0A=
> -total 14511243264=0A=
> --rw-r----- 1 root root 0 Nov 25 13:23 0=0A=
> --rw-r----- 1 root root 0 Nov 25 13:23 1=0A=
> --rw-r----- 1 root root 0 Nov 25 13:23 2=0A=
> -...=0A=
> --rw-r----- 1 root root 0 Nov 25 13:23 55354=0A=
> --rw-r----- 1 root root 0 Nov 25 13:23 55355=0A=
> +    # ls -lv /mnt/seq=0A=
> +    total 14511243264=0A=
> +    -rw-r----- 1 root root 0 Nov 25 13:23 0=0A=
> +    -rw-r----- 1 root root 0 Nov 25 13:23 1=0A=
> +    -rw-r----- 1 root root 0 Nov 25 13:23 2=0A=
> +    ...=0A=
> +    -rw-r----- 1 root root 0 Nov 25 13:23 55354=0A=
> +    -rw-r----- 1 root root 0 Nov 25 13:23 55355=0A=
>  =0A=
>  For sequential write zone files, the file size changes as data is append=
ed at=0A=
> -the end of the file, similarly to any regular file system.=0A=
> +the end of the file, similarly to any regular file system::=0A=
>  =0A=
> -# dd if=3D/dev/zero of=3D/mnt/seq/0 bs=3D4096 count=3D1 conv=3Dnotrunc o=
flag=3Ddirect=0A=
> -1+0 records in=0A=
> -1+0 records out=0A=
> -4096 bytes (4.1 kB, 4.0 KiB) copied, 0.00044121 s, 9.3 MB/s=0A=
> +    # dd if=3D/dev/zero of=3D/mnt/seq/0 bs=3D4096 count=3D1 conv=3Dnotru=
nc oflag=3Ddirect=0A=
> +    1+0 records in=0A=
> +    1+0 records out=0A=
> +    4096 bytes (4.1 kB, 4.0 KiB) copied, 0.00044121 s, 9.3 MB/s=0A=
>  =0A=
> -# ls -l /mnt/seq/0=0A=
> --rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/seq/0=0A=
> +    # ls -l /mnt/seq/0=0A=
> +    -rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/seq/0=0A=
>  =0A=
>  The written file can be truncated to the zone size, preventing any furth=
er=0A=
> -write operation.=0A=
> +write operation::=0A=
>  =0A=
> -# truncate -s 268435456 /mnt/seq/0=0A=
> -# ls -l /mnt/seq/0=0A=
> --rw-r----- 1 root root 268435456 Nov 25 13:49 /mnt/seq/0=0A=
> +    # truncate -s 268435456 /mnt/seq/0=0A=
> +    # ls -l /mnt/seq/0=0A=
> +    -rw-r----- 1 root root 268435456 Nov 25 13:49 /mnt/seq/0=0A=
>  =0A=
>  Truncation to 0 size allows freeing the file zone storage space and rest=
art=0A=
> -append-writes to the file.=0A=
> +append-writes to the file::=0A=
>  =0A=
> -# truncate -s 0 /mnt/seq/0=0A=
> -# ls -l /mnt/seq/0=0A=
> --rw-r----- 1 root root 0 Nov 25 13:49 /mnt/seq/0=0A=
> +    # truncate -s 0 /mnt/seq/0=0A=
> +    # ls -l /mnt/seq/0=0A=
> +    -rw-r----- 1 root root 0 Nov 25 13:49 /mnt/seq/0=0A=
>  =0A=
>  Since files are statically mapped to zones on the disk, the number of bl=
ocks of=0A=
> -a file as reported by stat() and fstat() indicates the size of the file =
zone.=0A=
> +a file as reported by stat() and fstat() indicates the size of the file =
zone::=0A=
>  =0A=
> -# stat /mnt/seq/0=0A=
> -  File: /mnt/seq/0=0A=
> -  Size: 0         	Blocks: 524288     IO Block: 4096   regular empty fil=
e=0A=
> -Device: 870h/2160d	Inode: 50431       Links: 1=0A=
> -Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)=
=0A=
> -Access: 2019-11-25 13:23:57.048971997 +0900=0A=
> -Modify: 2019-11-25 13:52:25.553805765 +0900=0A=
> -Change: 2019-11-25 13:52:25.553805765 +0900=0A=
> - Birth: -=0A=
> +    # stat /mnt/seq/0=0A=
> +    File: /mnt/seq/0=0A=
> +    Size: 0         	Blocks: 524288     IO Block: 4096   regular empty f=
ile=0A=
> +    Device: 870h/2160d	Inode: 50431       Links: 1=0A=
> +    Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    r=
oot)=0A=
> +    Access: 2019-11-25 13:23:57.048971997 +0900=0A=
> +    Modify: 2019-11-25 13:52:25.553805765 +0900=0A=
> +    Change: 2019-11-25 13:52:25.553805765 +0900=0A=
> +    Birth: -=0A=
>  =0A=
>  The number of blocks of the file ("Blocks") in units of 512B blocks give=
s the=0A=
>  maximum file size of 524288 * 512 B =3D 256 MB, corresponding to the dev=
ice zone=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
