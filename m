Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6587C167B73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 12:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgBULDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 06:03:44 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45984 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgBULDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582283024; x=1613819024;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5ITXcdceLl/F7ulzSgAqFtduPoUwDRFVJ8GAMEaKJvc=;
  b=TM0ZXkdp0lOfAs//W5GVI/7hiMK9VI6RyZOmF/O+xhWrZoC5udxQZF20
   uf3ThYf/9GlDw7P8F9nIST2h06TUpOnT1oL8Tt1AQdFGHPqQh6fnjU5oc
   KEzfQmTtx/tjthv6MsVAxT18RYsmcrGQl3ILFcLaJP36MHOxAK9yQ5QV+
   pcoNTFWZXvYHo+/o+I6PWTiPzQt02tu37OzDEtwZIzmQD/twlO3BA7rr5
   HirDpqMxLgQR9V7I7gxOMYYzsRzZuRkU1kmGabbIBx7Gtes85RHAy9/H6
   qjDATY4KjcUPbh7IjuqcLTB0YKc50/4XnZ/yIrIl7Ot7p92u58bBoxpzI
   Q==;
IronPort-SDR: tDynrM+PJOb09fcSKp6Bro7FYY5Dbd6b6dzKE98bZpws/xEx95/u6H8KYk/m+ZILx5YuSSrGn9
 UN8GM+pW+LADpRJ41H33klWIWxxMTufMF7DMKwqaVPlTGw2t7bybMYGTCC7dZ7gvxvqij2pSWH
 z2wcbT7CB13q0+W6PAM5szz9GgUHlzRlAXoEtTidLgvN9yv1KYBcAJrM3pr0SmrGhwb0SOEXkI
 Z4x2dKr3+lUwa9zjqbNCEDLDvpgFSak5TnrejPe9tBYoEfQCPoA0c03X/iZn0HdHySCXRIlJef
 0F4=
X-IronPort-AV: E=Sophos;i="5.70,468,1574092800"; 
   d="scan'208";a="130892344"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 19:03:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKPvWNFfFecCqS8YTbfFITVi49ZCYUzRlUNg0HzSqVPt83hhPLIQ2Xo51O1pY2ZJYvdndQ9xUb8fcS330VKqHesLg3LjCzpq9ZEfkJtnD/02UFBow8Nz/WZGCsApwxWC0vuTY+AnCnuEAi9H9N+UOkRCKQ1ZLzd5FfAaVEKTkP5KZFXbUoGzFcP4OXJWqm6zf903XqHNIQHUyc5rrbTscfhofBL0rtNv9kEOBBPHOonDPiV418aToanvw/ZgbehTLBWYYcobjpzux0eFYAgY3qelmsc22G8P3FABgnFkpja7YbO+R6MdxcB+n0aMZJ8PbSoD/OOOv3LO/f6laOmfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWq1B1ZmeWQpQMfQ+lDVvVmTyQLqOsBf3/UCYPg1mAM=;
 b=dA2jI3s2wg7cL/+iJoI1Jnsve1DheKRofHKiwiuIqgDRVHtGV9W+N4/1OVk2Mh1cYaFKYlpusXvuT6vxlJ1DXIdfIUILMmZxXkCGikJq3XoFMYU+fMvljphaULh3JDWTsy9WVnfGZnp50np14o9BjVXDTuK2b8hMCDyLbec7Nmf8i+XT9WPM0dX0YoXjboFI5+IaEdNOMagn8lMbnjwQLq39TxshRxViwOw+NGocyaKorWfvrM1HtbY6Gb0p0Y4yj327WcP4ETPAC31RfO1M3o/nd0AylGujYOxUdmbxt+XAB/HPMW8APLrzRwjSePvWOBNX8W3GDoqqzeDpF7xp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWq1B1ZmeWQpQMfQ+lDVvVmTyQLqOsBf3/UCYPg1mAM=;
 b=SiaGiVG8jhacm8lgvoSUHgTJZKn7h1XUMe2J8P+Gz6SwKaeW9ZSWMtPsTFS5JQknuYahLesxX11rQVItaz/hTT0RbcH8+Jd/ZDh/2rso2nX2X7KmXEZNQ4kCkn5CjWcPbw8zfjQjp9Cu+KPFyNi7rPxceUp7M+hXlGWs/ZD0Yjs=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5654.namprd04.prod.outlook.com (20.179.56.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Fri, 21 Feb 2020 11:03:41 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 11:03:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH] zonefs: fix documentation typos etc.
Thread-Topic: [PATCH] zonefs: fix documentation typos etc.
Thread-Index: AQHV540Obf6Qxjjfx0mp/Sr+XffTkg==
Date:   Fri, 21 Feb 2020 11:03:41 +0000
Message-ID: <BYAPR04MB58168754A9B576CA05C9B8D2E7120@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <14e7bd16-c1ec-c863-a15c-fd4f70540d2a@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0cba573-807a-40ec-208a-08d7b6bdb647
x-ms-traffictypediagnostic: BYAPR04MB5654:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5654F383C8B9B6A90BB81B60E7120@BYAPR04MB5654.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(199004)(189003)(52536014)(2906002)(66476007)(66946007)(8936002)(8676002)(76116006)(4326008)(81166006)(66556008)(7696005)(6506007)(53546011)(64756008)(86362001)(81156014)(186003)(66446008)(316002)(54906003)(26005)(5660300002)(55016002)(71200400001)(33656002)(478600001)(110136005)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5654;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CpYKx6Pi8CTTx1V8d7WktjiLmkBWJwNakjUIPy0uI68FHwKt9cGC94+gRGP8EVg8W/j6Bz4JyfXana2ngh7khav+T4IB6nRYrO4gCBRWKGMdrhlrs3fhW2opG3a1k9HmOSusPFB2so3X+U/kjXNudK84kSt2Xx2o7btjzOy72J4KQLqaV8seCvQheuMcdtJS27ygnZf5gA6K9+oHhLPkBN6jdQxihb98XwuNKU4pUhJlN/mGowFQfXO1E8ia9IQ/UMX/ncleQEDWvuZZnP/INCVbW6zqhQvbgZDQR0M86doLHMrs80Vy1k32E87XMzKg6eZiaE4obIEn9E05UVSZAwwfwW5VtGzVTEBAoZj9kLsH19azmx8hsesyhTVTkGNtxJ+QgaWufJgYNNo9XQM4mvGoFdsLkzq4znx8wh/sWgSR3yJrXaYFTGHeplVL4pix
x-ms-exchange-antispam-messagedata: iC3eNCJ7JWXJVxd6GdSJ6/5uXkPOjLwmRONBbMKs+4iNKulXEUKuAdPag13zE/38cnXmhFcD5AVIsyMjF7HlijqXKW28n94pcyuX9FMohfKrqMxmf7G76R73j7LaGiaT7e4fl8k9Kb6Tjbp6VY0iqg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cba573-807a-40ec-208a-08d7b6bdb647
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 11:03:41.8184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: id+d4SaoMhK5huzt73BZWPo63mDYw2oyXztMqpUgSlC2ojOQwQxhq832pBOkcDSQNxO/fUcd55N5pKEfyVCang==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5654
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/02/20 10:28, Randy Dunlap wrote:=0A=
> From: Randy Dunlap <rdunlap@infradead.org>=0A=
> =0A=
> Fix typos, spellos, etc. in zonefs.txt.=0A=
> =0A=
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>=0A=
> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>=0A=
=0A=
Applied. Thanks !=0A=
=0A=
> ---=0A=
>  Documentation/filesystems/zonefs.txt |   20 ++++++++++----------=0A=
>  1 file changed, 10 insertions(+), 10 deletions(-)=0A=
> =0A=
> --- linux-next-20200219.orig/Documentation/filesystems/zonefs.txt=0A=
> +++ linux-next-20200219/Documentation/filesystems/zonefs.txt=0A=
> @@ -134,7 +134,7 @@ Sequential zone files can only be writte=0A=
>  end, that is, write operations can only be append writes. Zonefs makes n=
o=0A=
>  attempt at accepting random writes and will fail any write request that =
has a=0A=
>  start offset not corresponding to the end of the file, or to the end of =
the last=0A=
> -write issued and still in-flight (for asynchrnous I/O operations).=0A=
> +write issued and still in-flight (for asynchronous I/O operations).=0A=
>  =0A=
>  Since dirty page writeback by the page cache does not guarantee a sequen=
tial=0A=
>  write pattern, zonefs prevents buffered writes and writeable shared mapp=
ings=0A=
> @@ -142,7 +142,7 @@ on sequential files. Only direct I/O wri=0A=
>  zonefs relies on the sequential delivery of write I/O requests to the de=
vice=0A=
>  implemented by the block layer elevator. An elevator implementing the se=
quential=0A=
>  write feature for zoned block device (ELEVATOR_F_ZBD_SEQ_WRITE elevator =
feature)=0A=
> -must be used. This type of elevator (e.g. mq-deadline) is the set by def=
ault=0A=
> +must be used. This type of elevator (e.g. mq-deadline) is set by default=
=0A=
>  for zoned block devices on device initialization.=0A=
>  =0A=
>  There are no restrictions on the type of I/O used for read operations in=
=0A=
> @@ -196,7 +196,7 @@ additional conditions that result in I/O=0A=
>    may still happen in the case of a partial failure of a very large dire=
ct I/O=0A=
>    operation split into multiple BIOs/requests or asynchronous I/O operat=
ions.=0A=
>    If one of the write request within the set of sequential write request=
s=0A=
> -  issued to the device fails, all write requests after queued after it w=
ill=0A=
> +  issued to the device fails, all write requests queued after it will=0A=
>    become unaligned and fail.=0A=
>  =0A=
>  * Delayed write errors: similarly to regular block devices, if the devic=
e side=0A=
> @@ -207,7 +207,7 @@ additional conditions that result in I/O=0A=
>    causing all data to be dropped after the sector that caused the error.=
=0A=
>  =0A=
>  All I/O errors detected by zonefs are notified to the user with an error=
 code=0A=
> -return for the system call that trigered or detected the error. The reco=
very=0A=
> +return for the system call that triggered or detected the error. The rec=
overy=0A=
>  actions taken by zonefs in response to I/O errors depend on the I/O type=
 (read=0A=
>  vs write) and on the reason for the error (bad sector, unaligned writes =
or zone=0A=
>  condition change).=0A=
> @@ -222,7 +222,7 @@ condition change).=0A=
>  * A zone condition change to read-only or offline also always triggers z=
onefs=0A=
>    I/O error recovery.=0A=
>  =0A=
> -Zonefs minimal I/O error recovery may change a file size and a file acce=
ss=0A=
> +Zonefs minimal I/O error recovery may change a file size and file access=
=0A=
>  permissions.=0A=
>  =0A=
>  * File size changes:=0A=
> @@ -237,7 +237,7 @@ permissions.=0A=
>    A file size may also be reduced to reflect a delayed write error detec=
ted on=0A=
>    fsync(): in this case, the amount of data effectively written in the z=
one may=0A=
>    be less than originally indicated by the file inode size. After such I=
/O=0A=
> -  error, zonefs always fixes a file inode size to reflect the amount of =
data=0A=
> +  error, zonefs always fixes the file inode size to reflect the amount o=
f data=0A=
>    persistently stored in the file zone.=0A=
>  =0A=
>  * Access permission changes:=0A=
> @@ -281,11 +281,11 @@ Further notes:=0A=
>    permissions to read-only applies to all files. The file system is remo=
unted=0A=
>    read-only.=0A=
>  * Access permission and file size changes due to the device transitionin=
g zones=0A=
> -  to the offline condition are permanent. Remounting or reformating the =
device=0A=
> +  to the offline condition are permanent. Remounting or reformatting the=
 device=0A=
>    with mkfs.zonefs (mkzonefs) will not change back offline zone files to=
 a good=0A=
>    state.=0A=
>  * File access permission changes to read-only due to the device transiti=
oning=0A=
> -  zones to the read-only condition are permanent. Remounting or reformat=
ing=0A=
> +  zones to the read-only condition are permanent. Remounting or reformat=
ting=0A=
>    the device will not re-enable file write access.=0A=
>  * File access permission changes implied by the remount-ro, zone-ro and=
=0A=
>    zone-offline mount options are temporary for zones in a good condition=
.=0A=
> @@ -301,13 +301,13 @@ Mount options=0A=
>  =0A=
>  zonefs define the "errors=3D<behavior>" mount option to allow the user t=
o specify=0A=
>  zonefs behavior in response to I/O errors, inode size inconsistencies or=
 zone=0A=
> -condition chages. The defined behaviors are as follow:=0A=
> +condition changes. The defined behaviors are as follow:=0A=
>  * remount-ro (default)=0A=
>  * zone-ro=0A=
>  * zone-offline=0A=
>  * repair=0A=
>  =0A=
> -The I/O error actions defined for each behavior is detailed in the previ=
ous=0A=
> +The I/O error actions defined for each behavior are detailed in the prev=
ious=0A=
>  section.=0A=
>  =0A=
>  Zonefs User Space Tools=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
