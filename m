Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA668A5FE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 05:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfICDtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 23:49:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30175 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfICDtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 23:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1567482554; x=1599018554;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NXY/MirhTBfjoM6oHRbJaAngBfR/jgFU18BBwzpitF0=;
  b=TN2d9Vv5nvO/izkWiTi6nAf7uMM1PZ+sFSAZZCxlg7assoRVnIGqGk5N
   OifljBp5vmihJ0ZJhUGPn6UKCoLB3IF9Rj7tm5Etimed59SQDA2y361pm
   I/l14vQeexHQ3kB25vTp+QVypy3OQHG9yGoK+XEIexrE/BXxg/3Ivtts0
   WTwGG8qlljLYZyo8wlBs9P9I3hjKcGQ47T5hNfOpWIRWlJ9fslnFjNXcW
   Z+jKdRv7NYVLWQd8GKB25DW4mhKA7PA9QBSR1tltnST9XQF2xaC0eyl9B
   hkSs04qtE3NCMcfQEtgYjPQH/a9SWXcOXeFRFvYxRQnlbaUjEhTXxUy/8
   A==;
IronPort-SDR: ckaqf8n2Zl+D8qJflVLphESrKcNybVqJA7NMqiR7/GvmzOBNIjiRR6yyp90H7SevaK5h8vOn1g
 D/TzhKiU8W7Js1SzC3J/juPirjMfHNlpMPM6XW7bvmKGsIFc1IV6oqcC0JOnb6mNF+3rVvsx6T
 RbvEg9VN+2ArswfdZnj/Bg2sD6ASJHUaq/pnQJ9YzTugEvvLYZWfQR/x4uoVNW/OanaO4s6E0D
 WcClccSU3+zLnVnuIOjTF6ipaL4I0kvGTA39aTzt8Ojera+xSDAoWHFAkhX/ygO8d4sgxzoPag
 fYc=
X-IronPort-AV: E=Sophos;i="5.64,461,1559491200"; 
   d="scan'208";a="223951004"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2019 11:49:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQISKfKW3Acm7ZcGL/KDftF0qBOE6bt2i6wFBMOxQCgcIWkB/LFGSbsiaD09BpoBEoCd+R/ctVvCARFVRhBjb2Ggzeegjs8kh1bbeXMkaaHcXDeUleG7mDYMqfx9SPMRUl33PqjPAIiP0YfQDLrzt2AtyMhdoKtSqScVbAgi926leDtlJYKi2rvLXgTDu+oP2rRr4uBRcqtIEmxPg0unUdnQQibKHvK6xvDggD+PYXB0Rycxgdupyd+AH6OqtPYGNnPz+oYh9Bc3Y7z246SrcmcgHLfSQI+u38EkBLvvCToRTw+hrv9re0iTleO/2A5OESxVr7P8DhetR1H8cDIUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz3Jie9qA0jFWlt8ixBxoVeiYm3KJ/7kvjzQ992Fws=;
 b=KwjRU9NH6KvrhAW0Izq9K3jC9BQB8g3scqxJirIDd+R3w4QP0D/I58w/4T60nYm6scroz48V4gdl36oqzAa0IxL4oXFu/4SpK5GtNLYU1/MUDoOiln2vflDt+ian0Ff7VCEFx5cTWoVa2GQ50NDpFkuUUTR0n3kKks9WvWb9+L/5v0j2GVDtU44UdkqifJ3JLWGTsQSGkwUK4TaGKn/zox6BZx7o7XOHLp9MtgJZ34R8o8MjQugRKOlHXsdy8I12PTXBPYsqNSDkgbeGN95B07Fdja7WPTcIV3wwqqMUuClLzE0cxAqYwyGlbzQDWmTO7l1YFLsQRgQliY3BCtT/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz3Jie9qA0jFWlt8ixBxoVeiYm3KJ/7kvjzQ992Fws=;
 b=FHrQukhirVY6a8XixsgCKYs2epEsKcTC1b81HzWBbIZlqoZX9uGL/DFIup9wrnm9ri+7k1O/+VH5ALh+0T7yy6o2mWC/qWOp548SetWogGYqQ2KWKZt1G18RP2wN0foA5VqKkl4PhgF4rOQIJoJlbmneu6yuGhgGgu9BGrXFMto=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4854.namprd04.prod.outlook.com (52.135.232.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Tue, 3 Sep 2019 03:49:11 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::b562:7791:5467:1672]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::b562:7791:5467:1672%6]) with mapi id 15.20.2220.021; Tue, 3 Sep 2019
 03:49:11 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH V4] fs: New zonefs file system
Thread-Topic: [PATCH V4] fs: New zonefs file system
Thread-Index: AQHVW9uc9S7B9ZIieUuwphG+VS4vgg==
Date:   Tue, 3 Sep 2019 03:49:11 +0000
Message-ID: <BYAPR04MB5816D115D2AD1AF3470C2A7AE7B90@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190826065750.11674-1-damien.lemoal@wdc.com>
 <BYAPR04MB5816E881D9881D5F559A3947E7B90@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190903032601.GV5354@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9d5cfe1-1564-4ad3-7df6-08d73021ae73
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4854;
x-ms-traffictypediagnostic: BYAPR04MB4854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4854D950C02AE64DE264E272E7B90@BYAPR04MB4854.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(199004)(189003)(7736002)(446003)(14454004)(478600001)(229853002)(8936002)(6246003)(74316002)(3846002)(6116002)(476003)(81156014)(486006)(33656002)(54906003)(8676002)(81166006)(186003)(26005)(71190400001)(71200400001)(53546011)(6506007)(102836004)(7696005)(76176011)(6436002)(53946003)(316002)(256004)(14444005)(66066001)(6916009)(305945005)(2906002)(30864003)(66946007)(76116006)(64756008)(66556008)(66446008)(66476007)(5660300002)(52536014)(53936002)(91956017)(25786009)(9686003)(86362001)(4326008)(99286004)(55016002)(559001)(569006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4854;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +vztSK+yRo+f/awTegsSmzaS4aoFQYMOZFOVfKm0uzquWN6G0pxYYcMAjWWhBxOUbG8/EFTgqyZGwBbCN0J8m/SCjx++MTyGcpxzeFy0fxUj9uUeOiEzts6Pfiq6xqEhm8O5CCdmnjxB6Z3DhP1chaRJUIISNgLmp9COGdQkaui4wLiSHLyoEsfOUKyxAIk/+VwKFoAK9/HM53jxcdmQYUsBPNvOYA31vsR2r/2Nbn6ilHvQnkLs3Sn1yD2fNEP72y3CzYRoRBDfMKG9CBgSMq2Qf4zQqvn2dGL120oM09saMX/68glRU5L6WoMJaE69hdfni5Un/3/ZLk/JD3dnmoCsxZ8zjHis4zwY0vF9dOt7DfG7Pw4V8Rfoor+iGnSm4KvcPIqWYai8+AVYk+0NHuPZPfsBmd9+lVkVKuVxj3M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d5cfe1-1564-4ad3-7df6-08d73021ae73
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 03:49:11.3823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwMJkI5eNvMV6MWcq2jRtPkOEJs7PRw0Nd/hYohSmmZVbwNpTO5vRvyZg9LxJM8HHxa9bnhp0XeKqguno6rR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4854
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/09/03 12:26, Darrick J. Wong wrote:=0A=
> On Tue, Sep 03, 2019 at 12:59:17AM +0000, Damien Le Moal wrote:=0A=
>> Hi Darrick,=0A=
>>=0A=
>> Any comments on this new version ?=0A=
> =0A=
> I took a brief glance a few days ago and it looked ok wrt the iomap=0A=
> parts.  I'm assuming you received the same complaint from the kbuild=0A=
> robot as I did?=0A=
=0A=
Yes, I did receive the same complaints.=0A=
=0A=
> =0A=
>> Should I wait for the iomap code to make it to 5.4 first before trying t=
o get=0A=
>> this new FS included ?=0A=
> =0A=
> Given that the merge window apparently won't close until Sept. 29, that=
=0A=
> gives us more time to make any more minor tweaks.=0A=
=0A=
I keep monitoring your iomap-for-next branch for any change, rebasing and=
=0A=
testing if anything changes there. So far, no problems.=0A=
=0A=
> (That means 80% of a "Go for it" but I'll look more closely tomorrow ;))=
=0A=
=0A=
OK. Thank you. One question I was wondering about: All my code until now ha=
s=0A=
gone through a maintainer, even for the little parts I maintain myself=0A=
(dm-zoned). However, it seems customary for file systems to each have their=
 own=0A=
maintainer and sending PRs to Linus. So should I prepare myself for having =
a=0A=
tree specifically for zonefs and getting a signed GPG key for sending pull=
=0A=
requests ? Or given how small zonefs is, would you be willing to take zonef=
s=0A=
through the iomap tree ? The last option would be easier for me, but I do n=
ot=0A=
want to put on you any overhead :)=0A=
=0A=
Thanks !=0A=
=0A=
> =0A=
> --D=0A=
> =0A=
>> Best regards.=0A=
>>=0A=
>> On 2019/08/26 15:58, Damien Le Moal wrote:=0A=
>>> zonefs is a very simple file system exposing each zone of a zoned=0A=
>>> block device as a file. zonefs is in fact closer to a raw block device=
=0A=
>>> access interface than to a full feature POSIX file system.=0A=
>>>=0A=
>>> The goal of zonefs is to simplify implementation of zoned block device=
=0A=
>>> raw access by applications by allowing switching to the well known POSI=
X=0A=
>>> file API rather than relying on direct block device file ioctls and=0A=
>>> read/write. Zonefs, for instance, greatly simplifies the implementation=
=0A=
>>> of LSM (log-structured merge) tree structures (such as used in RocksDB=
=0A=
>>> and LevelDB) on zoned block devices by allowing SSTables to be stored i=
n=0A=
>>> a zone file similarly to a regular file system architecture, hence=0A=
>>> reducing the amount of change needed in the application.=0A=
>>>=0A=
>>> Zonefs on-disk metadata is reduced to a super block to store a magic=0A=
>>> number, a uuid and optional features flags and values. On mount, zonefs=
=0A=
>>> uses blkdev_report_zones() to obtain the device zone configuration and=
=0A=
>>> populates the mount point with a static file tree solely based on this=
=0A=
>>> information. E.g. file sizes come from zone write pointer offset manage=
d=0A=
>>> by the device itself.=0A=
>>>=0A=
>>> The zone files created on mount have the following characteristics.=0A=
>>> 1) Files representing zones of the same type are grouped together=0A=
>>>    under a common directory:=0A=
>>>   * For conventional zones, the directory "cnv" is used.=0A=
>>>   * For sequential write zones, the directory "seq" is used.=0A=
>>>   These two directories are the only directories that exist in zonefs.=
=0A=
>>>   Users cannot create other directories and cannot rename nor delete=0A=
>>>   the "cnv" and "seq" directories.=0A=
>>> 2) The name of zone files is by default the number of the file within=
=0A=
>>>    the zone type directory, in order of increasing zone start sector.=
=0A=
>>> 3) The size of conventional zone files is fixed to the device zone size=
.=0A=
>>>    Conventional zone files cannot be truncated.=0A=
>>> 4) The size of sequential zone files represent the file zone write=0A=
>>>    pointer position relative to the zone start sector. Truncating these=
=0A=
>>>    files is allowed only down to 0, in wich case, the zone is reset to=
=0A=
>>>    rewind the file zone write pointer position to the start of the zone=
.=0A=
>>> 5) All read and write operations to files are not allowed beyond the=0A=
>>>    file zone size. Any access exceeding the zone size is failed with=0A=
>>>    the -EFBIG error.=0A=
>>> 6) Creating, deleting, renaming or modifying any attribute of files=0A=
>>>    and directories is not allowed. The only exception being the file=0A=
>>>    size of sequential zone files which can be modified by write=0A=
>>>    operations or truncation to 0.=0A=
>>>=0A=
>>> Several optional features of zonefs can be enabled at format time.=0A=
>>> * Conventional zone aggregation: contiguous conventional zones can be=
=0A=
>>>   agregated into a single larger file instead of multiple per-zone=0A=
>>>   files.=0A=
>>> * File naming: the default file number file name can be switched to=0A=
>>>   using the base-10 value of the file zone start sector.=0A=
>>> * File ownership: The owner UID and GID of zone files is by default 0=
=0A=
>>>   (root) but can be changed to any valid UID/GID.=0A=
>>> * File access permissions: the default 640 access permissions can be=0A=
>>>   changed.=0A=
>>>=0A=
>>> The mkzonefs tool is used to format zonefs. This tool is available=0A=
>>> on Github at: git@github.com:damien-lemoal/zonefs-tools.git.=0A=
>>> zonefs-tools includes a simple test suite which can be run against any=
=0A=
>>> zoned block device, including null_blk block device created with zoned=
=0A=
>>> mode.=0A=
>>>=0A=
>>> Example: the following formats a host-managed SMR HDD with the=0A=
>>> conventional zone aggregation feature enabled.=0A=
>>>=0A=
>>> mkzonefs -o aggr_cnv /dev/sdX=0A=
>>> mount -t zonefs /dev/sdX /mnt=0A=
>>> ls -l /mnt/=0A=
>>> total 0=0A=
>>> dr-xr-xr-x 2 root root 0 Apr 11 13:00 cnv=0A=
>>> dr-xr-xr-x 2 root root 0 Apr 11 13:00 seq=0A=
>>>=0A=
>>> ls -l /mnt/cnv=0A=
>>> total 137363456=0A=
>>> -rw-rw---- 1 root root 140660178944 Apr 11 13:00 0=0A=
>>>=0A=
>>> ls -Fal -v /mnt/seq=0A=
>>> total 14511243264=0A=
>>> dr-xr-xr-x 2 root root 15942528 Jul 10 11:53 ./=0A=
>>> drwxr-xr-x 4 root root     1152 Jul 10 11:53 ../=0A=
>>> -rw-r----- 1 root root        0 Jul 10 11:53 0=0A=
>>> -rw-r----- 1 root root 33554432 Jul 10 13:43 1=0A=
>>> -rw-r----- 1 root root        0 Jul 10 11:53 2=0A=
>>> -rw-r----- 1 root root        0 Jul 10 11:53 3=0A=
>>> ...=0A=
>>>=0A=
>>> The aggregated conventional zone file can be used as a regular file.=0A=
>>> Operations such as the following work.=0A=
>>>=0A=
>>> mkfs.ext4 /mnt/cnv/0=0A=
>>> mount -o loop /mnt/cnv/0 /data=0A=
>>>=0A=
>>> Contains contributions from Johannes Thumshirn <jthumshirn@suse.de>=0A=
>>> and Christoph Hellwig <hch@lst.de>.=0A=
>>>=0A=
>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>> ---=0A=
>>> Changes from v3:=0A=
>>> * Enhanced super block features and reserved field handling as suggeste=
d=0A=
>>>   by Darrick.=0A=
>>> * Expose offline zones as non-accessible files to avoid zone to file=0A=
>>>   name mapping changes.=0A=
>>>=0A=
>>> Changes from v2:=0A=
>>> * Addressed comments from Darrick: Typo, added checksum to super block,=
=0A=
>>>   enhance cheks of the super block fields validity (used reserved bytes=
=0A=
>>>   and unknown features bits)=0A=
>>> * Rebased on XFS tree iomap-for-next branch=0A=
>>>=0A=
>>> Changes from v1:=0A=
>>> * Rebased on latest iomap branch iomap-5.4-merge of XFS tree at=0A=
>>>   git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git=0A=
>>> * Addressed all comments from Dave Chinner and others=0A=
>>>=0A=
>>>  MAINTAINERS                |   10 +=0A=
>>>  fs/Kconfig                 |    1 +=0A=
>>>  fs/Makefile                |    1 +=0A=
>>>  fs/zonefs/Kconfig          |    9 +=0A=
>>>  fs/zonefs/Makefile         |    4 +=0A=
>>>  fs/zonefs/super.c          | 1093 ++++++++++++++++++++++++++++++++++++=
=0A=
>>>  fs/zonefs/zonefs.h         |  185 ++++++=0A=
>>>  include/uapi/linux/magic.h |    1 +=0A=
>>>  8 files changed, 1304 insertions(+)=0A=
>>>  create mode 100644 fs/zonefs/Kconfig=0A=
>>>  create mode 100644 fs/zonefs/Makefile=0A=
>>>  create mode 100644 fs/zonefs/super.c=0A=
>>>  create mode 100644 fs/zonefs/zonefs.h=0A=
>>>=0A=
>>> diff --git a/MAINTAINERS b/MAINTAINERS=0A=
>>> index 6426db5198f0..a1b2c9836073 100644=0A=
>>> --- a/MAINTAINERS=0A=
>>> +++ b/MAINTAINERS=0A=
>>> @@ -17793,6 +17793,16 @@ L:	linux-kernel@vger.kernel.org=0A=
>>>  S:	Maintained=0A=
>>>  F:	arch/x86/kernel/cpu/zhaoxin.c=0A=
>>>  =0A=
>>> +ZONEFS FILESYSTEM=0A=
>>> +M:	Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>> +M:	Naohiro Aota <naohiro.aota@wdc.com>=0A=
>>> +R:	Johannes Thumshirn <jth@kernel.org>=0A=
>>> +L:	linux-fsdevel@vger.kernel.org=0A=
>>> +T:	git git@github.com:damien-lemoal/zonefs.git=0A=
>>> +S:	Maintained=0A=
>>> +F:	Documentation/filesystems/zonefs.txt=0A=
>>> +F:	fs/zonefs/=0A=
>>> +=0A=
>>>  ZPOOL COMPRESSED PAGE STORAGE API=0A=
>>>  M:	Dan Streetman <ddstreet@ieee.org>=0A=
>>>  L:	linux-mm@kvack.org=0A=
>>> diff --git a/fs/Kconfig b/fs/Kconfig=0A=
>>> index bfb1c6095c7a..dcaf3e07680f 100644=0A=
>>> --- a/fs/Kconfig=0A=
>>> +++ b/fs/Kconfig=0A=
>>> @@ -40,6 +40,7 @@ source "fs/ocfs2/Kconfig"=0A=
>>>  source "fs/btrfs/Kconfig"=0A=
>>>  source "fs/nilfs2/Kconfig"=0A=
>>>  source "fs/f2fs/Kconfig"=0A=
>>> +source "fs/zonefs/Kconfig"=0A=
>>>  =0A=
>>>  config FS_DAX=0A=
>>>  	bool "Direct Access (DAX) support"=0A=
>>> diff --git a/fs/Makefile b/fs/Makefile=0A=
>>> index d60089fd689b..7d3c90e1ad79 100644=0A=
>>> --- a/fs/Makefile=0A=
>>> +++ b/fs/Makefile=0A=
>>> @@ -130,3 +130,4 @@ obj-$(CONFIG_F2FS_FS)		+=3D f2fs/=0A=
>>>  obj-$(CONFIG_CEPH_FS)		+=3D ceph/=0A=
>>>  obj-$(CONFIG_PSTORE)		+=3D pstore/=0A=
>>>  obj-$(CONFIG_EFIVAR_FS)		+=3D efivarfs/=0A=
>>> +obj-$(CONFIG_ZONEFS_FS)		+=3D zonefs/=0A=
>>> diff --git a/fs/zonefs/Kconfig b/fs/zonefs/Kconfig=0A=
>>> new file mode 100644=0A=
>>> index 000000000000..6490547e9763=0A=
>>> --- /dev/null=0A=
>>> +++ b/fs/zonefs/Kconfig=0A=
>>> @@ -0,0 +1,9 @@=0A=
>>> +config ZONEFS_FS=0A=
>>> +	tristate "zonefs filesystem support"=0A=
>>> +	depends on BLOCK=0A=
>>> +	depends on BLK_DEV_ZONED=0A=
>>> +	help=0A=
>>> +	  zonefs is a simple File System which exposes zones of a zoned block=
=0A=
>>> +	  device as files.=0A=
>>> +=0A=
>>> +	  If unsure, say N.=0A=
>>> diff --git a/fs/zonefs/Makefile b/fs/zonefs/Makefile=0A=
>>> new file mode 100644=0A=
>>> index 000000000000..75a380aa1ae1=0A=
>>> --- /dev/null=0A=
>>> +++ b/fs/zonefs/Makefile=0A=
>>> @@ -0,0 +1,4 @@=0A=
>>> +# SPDX-License-Identifier: GPL-2.0=0A=
>>> +obj-$(CONFIG_ZONEFS_FS) +=3D zonefs.o=0A=
>>> +=0A=
>>> +zonefs-y	:=3D super.o=0A=
>>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
>>> new file mode 100644=0A=
>>> index 000000000000..8659878c6aec=0A=
>>> --- /dev/null=0A=
>>> +++ b/fs/zonefs/super.c=0A=
>>> @@ -0,0 +1,1093 @@=0A=
>>> +// SPDX-License-Identifier: GPL-2.0=0A=
>>> +/*=0A=
>>> + * Simple zone file system for zoned block devices.=0A=
>>> + *=0A=
>>> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.=
=0A=
>>> + */=0A=
>>> +#include <linux/module.h>=0A=
>>> +#include <linux/fs.h>=0A=
>>> +#include <linux/magic.h>=0A=
>>> +#include <linux/iomap.h>=0A=
>>> +#include <linux/init.h>=0A=
>>> +#include <linux/slab.h>=0A=
>>> +#include <linux/blkdev.h>=0A=
>>> +#include <linux/statfs.h>=0A=
>>> +#include <linux/writeback.h>=0A=
>>> +#include <linux/quotaops.h>=0A=
>>> +#include <linux/seq_file.h>=0A=
>>> +#include <linux/parser.h>=0A=
>>> +#include <linux/uio.h>=0A=
>>> +#include <linux/mman.h>=0A=
>>> +#include <linux/sched/mm.h>=0A=
>>> +#include <linux/crc32.h>=0A=
>>> +=0A=
>>> +#include "zonefs.h"=0A=
>>> +=0A=
>>> +static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff=
_t length,=0A=
>>> +			      unsigned int flags, struct iomap *iomap)=0A=
>>> +{=0A=
>>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
>>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>>> +	loff_t max_isize =3D zonefs_file_max_size(inode);=0A=
>>> +	loff_t isize;=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * For sequential zones, enforce direct IO writes. This is already=0A=
>>> +	 * checked when writes are issued, so warn about this here if we=0A=
>>> +	 * get buffered write to a sequential file inode.=0A=
>>> +	 */=0A=
>>> +	if (WARN_ON_ONCE(zonefs_file_is_seq(inode) && (flags & IOMAP_WRITE) &=
&=0A=
>>> +			 !(flags & IOMAP_DIRECT)))=0A=
>>> +		return -EIO;=0A=
>>> +=0A=
>>> +	/* An IO cannot exceed the zone size */=0A=
>>> +	if (offset >=3D max_isize)=0A=
>>> +		return -EFBIG;=0A=
>>> +=0A=
>>> +	/* All blocks are always mapped */=0A=
>>> +	mutex_lock(&zi->i_truncate_mutex);=0A=
>>> +	isize =3D i_size_read(inode);=0A=
>>> +	if (offset >=3D isize) {=0A=
>>> +		length =3D min(length, max_isize - offset);=0A=
>>> +		iomap->type =3D IOMAP_UNWRITTEN;=0A=
>>> +	} else {=0A=
>>> +		length =3D min(length, isize - offset);=0A=
>>> +		iomap->type =3D IOMAP_MAPPED;=0A=
>>> +	}=0A=
>>> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
>>> +=0A=
>>> +	iomap->offset =3D offset & (~sbi->s_blocksize_mask);=0A=
>>> +	iomap->length =3D ((offset + length + sbi->s_blocksize_mask) &=0A=
>>> +			 (~sbi->s_blocksize_mask)) - iomap->offset;=0A=
>>> +	iomap->bdev =3D inode->i_sb->s_bdev;=0A=
>>> +	iomap->addr =3D (zonefs_file_start_sector(inode) << SECTOR_SHIFT)=0A=
>>> +		      + iomap->offset;=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static const struct iomap_ops zonefs_iomap_ops =3D {=0A=
>>> +	.iomap_begin	=3D zonefs_iomap_begin,=0A=
>>> +};=0A=
>>> +=0A=
>>> +static int zonefs_readpage(struct file *unused, struct page *page)=0A=
>>> +{=0A=
>>> +	return iomap_readpage(page, &zonefs_iomap_ops);=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int zonefs_readpages(struct file *unused, struct address_space =
*mapping,=0A=
>>> +			    struct list_head *pages, unsigned int nr_pages)=0A=
>>> +{=0A=
>>> +	return iomap_readpages(mapping, pages, nr_pages, &zonefs_iomap_ops);=
=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int zonefs_map_blocks(struct iomap_writepage_ctx *wpc,=0A=
>>> +			     struct inode *inode, loff_t offset)=0A=
>>> +{=0A=
>>> +	if (offset >=3D wpc->iomap.offset &&=0A=
>>> +	    offset < wpc->iomap.offset + wpc->iomap.length)=0A=
>>> +		return 0;=0A=
>>> +=0A=
>>> +	memset(&wpc->iomap, 0, sizeof(wpc->iomap));=0A=
>>> +	return zonefs_iomap_begin(inode, offset, zonefs_file_max_size(inode),=
=0A=
>>> +				  0, &wpc->iomap);=0A=
>>> +}=0A=
>>> +=0A=
>>> +static const struct iomap_writeback_ops zonefs_writeback_ops =3D {=0A=
>>> +	.map_blocks		=3D zonefs_map_blocks,=0A=
>>> +};=0A=
>>> +=0A=
>>> +static int zonefs_writepage(struct page *page, struct writeback_contro=
l *wbc)=0A=
>>> +{=0A=
>>> +	struct iomap_writepage_ctx wpc =3D { };=0A=
>>> +=0A=
>>> +	return iomap_writepage(page, wbc, &wpc, &zonefs_writeback_ops);=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int zonefs_writepages(struct address_space *mapping,=0A=
>>> +			     struct writeback_control *wbc)=0A=
>>> +{=0A=
>>> +	struct iomap_writepage_ctx wpc =3D { };=0A=
>>> +=0A=
>>> +	return iomap_writepages(mapping, wbc, &wpc, &zonefs_writeback_ops);=
=0A=
>>> +}=0A=
>>> +=0A=
>>> +static const struct address_space_operations zonefs_file_aops =3D {=0A=
>>> +	.readpage		=3D zonefs_readpage,=0A=
>>> +	.readpages		=3D zonefs_readpages,=0A=
>>> +	.writepage		=3D zonefs_writepage,=0A=
>>> +	.writepages		=3D zonefs_writepages,=0A=
>>> +	.set_page_dirty		=3D iomap_set_page_dirty,=0A=
>>> +	.releasepage		=3D iomap_releasepage,=0A=
>>> +	.invalidatepage		=3D iomap_invalidatepage,=0A=
>>> +	.migratepage		=3D iomap_migrate_page,=0A=
>>> +	.is_partially_uptodate  =3D iomap_is_partially_uptodate,=0A=
>>> +	.error_remove_page	=3D generic_error_remove_page,=0A=
>>> +	.direct_IO		=3D noop_direct_IO,=0A=
>>> +};=0A=
>>> +=0A=
>>> +static int zonefs_seq_file_truncate(struct inode *inode)=0A=
>>> +{=0A=
>>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	inode_dio_wait(inode);=0A=
>>> +=0A=
>>> +	/* Serialize against page faults */=0A=
>>> +	down_write(&zi->i_mmap_sem);=0A=
>>> +=0A=
>>> +	/* Serialize against zonefs_iomap_begin() */=0A=
>>> +	mutex_lock(&zi->i_truncate_mutex);=0A=
>>> +=0A=
>>> +	ret =3D blkdev_reset_zones(inode->i_sb->s_bdev,=0A=
>>> +				 zonefs_file_start_sector(inode),=0A=
>>> +				 zonefs_file_max_size(inode) >> SECTOR_SHIFT,=0A=
>>> +				 GFP_NOFS);=0A=
>>> +	if (ret) {=0A=
>>> +		zonefs_err(inode->i_sb,=0A=
>>> +			   "Reset zone at %llu failed %d",=0A=
>>> +			   zonefs_file_start_sector(inode),=0A=
>>> +			   ret);=0A=
>>> +	} else {=0A=
>>> +		truncate_setsize(inode, 0);=0A=
>>> +		zi->i_wpoffset =3D 0;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
>>> +	up_write(&zi->i_mmap_sem);=0A=
>>> +=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int zonefs_inode_setattr(struct dentry *dentry, struct iattr *i=
attr)=0A=
>>> +{=0A=
>>> +	struct inode *inode =3D d_inode(dentry);=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	ret =3D setattr_prepare(dentry, iattr);=0A=
>>> +	if (ret)=0A=
>>> +		return ret;=0A=
>>> +=0A=
>>> +	if ((iattr->ia_valid & ATTR_UID &&=0A=
>>> +	     !uid_eq(iattr->ia_uid, inode->i_uid)) ||=0A=
>>> +	    (iattr->ia_valid & ATTR_GID &&=0A=
>>> +	     !gid_eq(iattr->ia_gid, inode->i_gid))) {=0A=
>>> +		ret =3D dquot_transfer(inode, iattr);=0A=
>>> +		if (ret)=0A=
>>> +			return ret;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	if (iattr->ia_valid & ATTR_SIZE) {=0A=
>>> +		/* The size of conventional zone files cannot be changed */=0A=
>>> +		if (zonefs_file_is_conv(inode))=0A=
>>> +			return -EPERM;=0A=
>>> +=0A=
>>> +		/*=0A=
>>> +		 * For sequential zone files, we can only allow truncating to=0A=
>>> +		 * 0 size which is equivalent to a zone reset.=0A=
>>> +		 */=0A=
>>> +		if (iattr->ia_size !=3D 0)=0A=
>>> +			return -EPERM;=0A=
>>> +=0A=
>>> +		ret =3D zonefs_seq_file_truncate(inode);=0A=
>>> +		if (ret)=0A=
>>> +			return ret;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	setattr_copy(inode, iattr);=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static const struct inode_operations zonefs_file_inode_operations =3D =
{=0A=
>>> +	.setattr	=3D zonefs_inode_setattr,=0A=
>>> +};=0A=
>>> +=0A=
>>> +static int zonefs_conv_file_write_and_wait(struct file *file, loff_t s=
tart,=0A=
>>> +					   loff_t end)=0A=
>>> +{=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	ret =3D file_write_and_wait_range(file, start, end);=0A=
>>> +	if (ret)=0A=
>>> +		return ret;=0A=
>>> +=0A=
>>> +	return file_check_and_advance_wb_err(file);=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int zonefs_file_fsync(struct file *file, loff_t start, loff_t e=
nd,=0A=
>>> +			     int datasync)=0A=
>>> +{=0A=
>>> +	struct inode *inode =3D file_inode(file);=0A=
>>> +	int ret =3D 0;=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Since only direct writes are allowed in sequential files, page cac=
he=0A=
>>> +	 * flush is needed only for conventional zone files.=0A=
>>> +	 */=0A=
>>> +	if (zonefs_file_is_conv(inode))=0A=
>>> +		ret =3D zonefs_conv_file_write_and_wait(file, start, end);=0A=
>>> +=0A=
>>> +	if (ret =3D=3D 0)=0A=
>>> +		ret =3D blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);=
=0A=
>>> +=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static vm_fault_t zonefs_filemap_fault(struct vm_fault *vmf)=0A=
>>> +{=0A=
>>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(file_inode(vmf->vma->vm_fil=
e));=0A=
>>> +	vm_fault_t ret;=0A=
>>> +=0A=
>>> +	down_read(&zi->i_mmap_sem);=0A=
>>> +	ret =3D filemap_fault(vmf);=0A=
>>> +	up_read(&zi->i_mmap_sem);=0A=
>>> +=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)=0A=
>>> +{=0A=
>>> +	struct inode *inode =3D file_inode(vmf->vma->vm_file);=0A=
>>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>>> +	vm_fault_t ret;=0A=
>>> +=0A=
>>> +	sb_start_pagefault(inode->i_sb);=0A=
>>> +	file_update_time(vmf->vma->vm_file);=0A=
>>> +=0A=
>>> +	/* Serialize against truncates */=0A=
>>> +	down_read(&zi->i_mmap_sem);=0A=
>>> +	ret =3D iomap_page_mkwrite(vmf, &zonefs_iomap_ops);=0A=
>>> +	up_read(&zi->i_mmap_sem);=0A=
>>> +=0A=
>>> +	sb_end_pagefault(inode->i_sb);=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static const struct vm_operations_struct zonefs_file_vm_ops =3D {=0A=
>>> +	.fault		=3D zonefs_filemap_fault,=0A=
>>> +	.map_pages	=3D filemap_map_pages,=0A=
>>> +	.page_mkwrite	=3D zonefs_filemap_page_mkwrite,=0A=
>>> +};=0A=
>>> +=0A=
>>> +static int zonefs_file_mmap(struct file *file, struct vm_area_struct *=
vma)=0A=
>>> +{=0A=
>>> +	/*=0A=
>>> +	 * Conventional zone files can be mmap-ed READ/WRITE.=0A=
>>> +	 * For sequential zone files, only readonly mappings are possible.=0A=
>>> +	 */=0A=
>>> +	if (zonefs_file_is_seq(file_inode(file)) &&=0A=
>>> +	    (vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))=0A=
>>> +		return -EINVAL;=0A=
>>> +=0A=
>>> +	file_accessed(file);=0A=
>>> +	vma->vm_ops =3D &zonefs_file_vm_ops;=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static loff_t zonefs_file_llseek(struct file *file, loff_t offset, int=
 whence)=0A=
>>> +{=0A=
>>> +	loff_t isize =3D i_size_read(file_inode(file));=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Seeks are limited to below the zone size for conventional zones=0A=
>>> +	 * and below the zone write pointer for sequential zones. In both=0A=
>>> +	 * cases, this limit is the inode size.=0A=
>>> +	 */=0A=
>>> +	return generic_file_llseek_size(file, offset, whence, isize, isize);=
=0A=
>>> +}=0A=
>>> +=0A=
>>> +static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_it=
er *to)=0A=
>>> +{=0A=
>>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
>>> +	loff_t max_pos;=0A=
>>> +	size_t count;=0A=
>>> +	ssize_t ret;=0A=
>>> +=0A=
>>> +	if (iocb->ki_pos >=3D zonefs_file_max_size(inode))=0A=
>>> +		return 0;=0A=
>>> +=0A=
>>> +	if (iocb->ki_flags & IOCB_NOWAIT) {=0A=
>>> +		if (!inode_trylock_shared(inode))=0A=
>>> +			return -EAGAIN;=0A=
>>> +	} else {=0A=
>>> +		inode_lock_shared(inode);=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	mutex_lock(&zi->i_truncate_mutex);=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Limit read operations to written data.=0A=
>>> +	 */=0A=
>>> +	max_pos =3D i_size_read(inode);=0A=
>>> +	if (iocb->ki_pos >=3D max_pos) {=0A=
>>> +		mutex_unlock(&zi->i_truncate_mutex);=0A=
>>> +		ret =3D 0;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	iov_iter_truncate(to, max_pos - iocb->ki_pos);=0A=
>>> +=0A=
>>> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
>>> +=0A=
>>> +	count =3D iov_iter_count(to);=0A=
>>> +=0A=
>>> +	if (iocb->ki_flags & IOCB_DIRECT) {=0A=
>>> +		/*=0A=
>>> +		 * Direct IO reads must be aligned to device physical sector=0A=
>>> +		 * size.=0A=
>>> +		 */=0A=
>>> +		if ((iocb->ki_pos | count) & sbi->s_blocksize_mask) {=0A=
>>> +			ret =3D -EINVAL;=0A=
>>> +		} else {=0A=
>>> +			file_accessed(iocb->ki_filp);=0A=
>>> +			ret =3D iomap_dio_rw(iocb, to, &zonefs_iomap_ops, NULL);=0A=
>>> +		}=0A=
>>> +	} else {=0A=
>>> +		ret =3D generic_file_read_iter(iocb, to);=0A=
>>> +	}=0A=
>>> +=0A=
>>> +out:=0A=
>>> +	inode_unlock_shared(inode);=0A=
>>> +=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * When a write error occurs in a sequential zone, the zone write poin=
ter=0A=
>>> + * position must be refreshed to correct the file size and zonefs inod=
e=0A=
>>> + * write pointer offset.=0A=
>>> + */=0A=
>>> +static int zonefs_seq_file_write_failed(struct inode *inode, int error=
)=0A=
>>> +{=0A=
>>> +	struct super_block *sb =3D inode->i_sb;=0A=
>>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>>> +	sector_t sector =3D zi->i_zsector;=0A=
>>> +	unsigned int nofs_flag;=0A=
>>> +	struct blk_zone zone;=0A=
>>> +	int n =3D 1, ret;=0A=
>>> +	loff_t pos;=0A=
>>> +=0A=
>>> +	zonefs_warn(sb, "Updating inode zone %llu info\n", sector);=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * blkdev_report_zones() uses GFP_KERNEL by default. Force execution =
as=0A=
>>> +	 * if GFP_NOFS was specified to no end up recusrsing into the FS on=
=0A=
>>> +	 * memory allocation.=0A=
>>> +	 */=0A=
>>> +	nofs_flag =3D memalloc_nofs_save();=0A=
>>> +	ret =3D blkdev_report_zones(sb->s_bdev, sector, &zone, &n);=0A=
>>> +	memalloc_nofs_restore(nofs_flag);=0A=
>>> +=0A=
>>> +	if (ret || !n) {=0A=
>>> +		if (!n)=0A=
>>> +			ret =3D -EIO;=0A=
>>> +		zonefs_err(sb, "Get zone %llu report failed %d\n",=0A=
>>> +			   sector, ret);=0A=
>>> +		return ret;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	pos =3D (zone.wp - zone.start) << SECTOR_SHIFT;=0A=
>>> +	zi->i_wpoffset =3D pos;=0A=
>>> +	if (i_size_read(inode) !=3D pos)=0A=
>>> +		i_size_write(inode, pos);=0A=
>>> +=0A=
>>> +	return error;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int zonefs_file_dio_write_end(struct kiocb *iocb, ssize_t size,=
=0A=
>>> +				     unsigned int flags)=0A=
>>> +{=0A=
>>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>>> +	int ret =3D 0;=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Conventional zone file size is fixed to the zone size so there=0A=
>>> +	 * is no need to do anything.=0A=
>>> +	 */=0A=
>>> +	if (zonefs_file_is_conv(inode))=0A=
>>> +		return 0;=0A=
>>> +=0A=
>>> +	mutex_lock(&zi->i_truncate_mutex);=0A=
>>> +=0A=
>>> +	if (size < 0) {=0A=
>>> +		ret =3D zonefs_seq_file_write_failed(inode, size);=0A=
>>> +	} else {=0A=
>>> +		/* Update seq file size */=0A=
>>> +		if (i_size_read(inode) < iocb->ki_pos + size)=0A=
>>> +			i_size_write(inode, iocb->ki_pos + size);=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
>>> +=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_it=
er *from)=0A=
>>> +{=0A=
>>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
>>> +	size_t count;=0A=
>>> +	ssize_t ret;=0A=
>>> +=0A=
>>> +	if (iocb->ki_flags & IOCB_NOWAIT) {=0A=
>>> +		if (!inode_trylock(inode))=0A=
>>> +			return -EAGAIN;=0A=
>>> +	} else {=0A=
>>> +		inode_lock(inode);=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	ret =3D generic_write_checks(iocb, from);=0A=
>>> +	if (ret <=3D 0)=0A=
>>> +		goto out;=0A=
>>> +=0A=
>>> +	iov_iter_truncate(from, zonefs_file_max_size(inode) - iocb->ki_pos);=
=0A=
>>> +	count =3D iov_iter_count(from);=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Direct writes must be aligned to the block size, that is, the devi=
ce=0A=
>>> +	 * physical sector size, to avoid errors when writing sequential zone=
s=0A=
>>> +	 * on 512e devices (512B logical sector, 4KB physical sectors).=0A=
>>> +	 */=0A=
>>> +	if ((iocb->ki_pos | count) & sbi->s_blocksize_mask) {=0A=
>>> +		ret =3D -EINVAL;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Enforce sequential writes (append only) in sequential zones.=0A=
>>> +	 */=0A=
>>> +	mutex_lock(&zi->i_truncate_mutex);=0A=
>>> +	if (zonefs_file_is_seq(inode) &&=0A=
>>> +	    iocb->ki_pos !=3D zi->i_wpoffset) {=0A=
>>> +		zonefs_err(inode->i_sb,=0A=
>>> +			   "Unaligned write at %llu + %zu (wp %llu)\n",=0A=
>>> +			   iocb->ki_pos, count,=0A=
>>> +			   zi->i_wpoffset);=0A=
>>> +		mutex_unlock(&zi->i_truncate_mutex);=0A=
>>> +		ret =3D -EINVAL;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
>>> +=0A=
>>> +	ret =3D iomap_dio_rw(iocb, from, &zonefs_iomap_ops,=0A=
>>> +			   zonefs_file_dio_write_end);=0A=
>>> +	if (zonefs_file_is_seq(inode) &&=0A=
>>> +	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {=0A=
>>> +		if (ret > 0)=0A=
>>> +			count =3D ret;=0A=
>>> +		mutex_lock(&zi->i_truncate_mutex);=0A=
>>> +		zi->i_wpoffset +=3D count;=0A=
>>> +		mutex_unlock(&zi->i_truncate_mutex);=0A=
>>> +	}=0A=
>>> +=0A=
>>> +out:=0A=
>>> +	inode_unlock(inode);=0A=
>>> +=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,=0A=
>>> +					  struct iov_iter *from)=0A=
>>> +{=0A=
>>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>>> +	size_t count;=0A=
>>> +	ssize_t ret;=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Direct IO writes are mandatory for sequential zones so that the=0A=
>>> +	 * write IO order is preserved.=0A=
>>> +	 */=0A=
>>> +	if (zonefs_file_is_seq(inode))=0A=
>>> +		return -EIO;=0A=
>>> +=0A=
>>> +	if (iocb->ki_flags & IOCB_NOWAIT) {=0A=
>>> +		if (!inode_trylock(inode))=0A=
>>> +			return -EAGAIN;=0A=
>>> +	} else {=0A=
>>> +		inode_lock(inode);=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	ret =3D generic_write_checks(iocb, from);=0A=
>>> +	if (ret <=3D 0)=0A=
>>> +		goto out;=0A=
>>> +=0A=
>>> +	iov_iter_truncate(from, zonefs_file_max_size(inode) - iocb->ki_pos);=
=0A=
>>> +	count =3D iov_iter_count(from);=0A=
>>> +=0A=
>>> +	ret =3D iomap_file_buffered_write(iocb, from, &zonefs_iomap_ops);=0A=
>>> +	if (ret > 0)=0A=
>>> +		iocb->ki_pos +=3D ret;=0A=
>>> +=0A=
>>> +out:=0A=
>>> +	inode_unlock(inode);=0A=
>>> +=0A=
>>> +	if (ret > 0)=0A=
>>> +		ret =3D generic_write_sync(iocb, ret);=0A=
>>> +=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_i=
ter *from)=0A=
>>> +{=0A=
>>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Check that the write operation does not go beyond the zone size.=
=0A=
>>> +	 */=0A=
>>> +	if (iocb->ki_pos >=3D zonefs_file_max_size(inode))=0A=
>>> +		return -EFBIG;=0A=
>>> +=0A=
>>> +	if (iocb->ki_flags & IOCB_DIRECT)=0A=
>>> +		return zonefs_file_dio_write(iocb, from);=0A=
>>> +=0A=
>>> +	return zonefs_file_buffered_write(iocb, from);=0A=
>>> +}=0A=
>>> +=0A=
>>> +static const struct file_operations zonefs_file_operations =3D {=0A=
>>> +	.open		=3D generic_file_open,=0A=
>>> +	.fsync		=3D zonefs_file_fsync,=0A=
>>> +	.mmap		=3D zonefs_file_mmap,=0A=
>>> +	.llseek		=3D zonefs_file_llseek,=0A=
>>> +	.read_iter	=3D zonefs_file_read_iter,=0A=
>>> +	.write_iter	=3D zonefs_file_write_iter,=0A=
>>> +	.splice_read	=3D generic_file_splice_read,=0A=
>>> +	.splice_write	=3D iter_file_splice_write,=0A=
>>> +	.iopoll		=3D iomap_dio_iopoll,=0A=
>>> +};=0A=
>>> +=0A=
>>> +=0A=
>>> +static struct kmem_cache *zonefs_inode_cachep;=0A=
>>> +=0A=
>>> +static struct inode *zonefs_alloc_inode(struct super_block *sb)=0A=
>>> +{=0A=
>>> +	struct zonefs_inode_info *zi;=0A=
>>> +=0A=
>>> +	zi =3D kmem_cache_alloc(zonefs_inode_cachep, GFP_KERNEL);=0A=
>>> +	if (!zi)=0A=
>>> +		return NULL;=0A=
>>> +=0A=
>>> +	mutex_init(&zi->i_truncate_mutex);=0A=
>>> +	init_rwsem(&zi->i_mmap_sem);=0A=
>>> +	inode_init_once(&zi->i_vnode);=0A=
>>> +=0A=
>>> +	return &zi->i_vnode;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static void zonefs_free_inode(struct inode *inode)=0A=
>>> +{=0A=
>>> +	kmem_cache_free(zonefs_inode_cachep, ZONEFS_I(inode));=0A=
>>> +}=0A=
>>> +=0A=
>>> +static struct dentry *zonefs_create_inode(struct dentry *parent,=0A=
>>> +					  const char *name,=0A=
>>> +					  struct blk_zone *zone)=0A=
>>> +{=0A=
>>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(parent->d_sb);=0A=
>>> +	struct inode *dir =3D d_inode(parent);=0A=
>>> +	struct dentry *dentry;=0A=
>>> +	struct inode *inode;=0A=
>>> +=0A=
>>> +	dentry =3D d_alloc_name(parent, name);=0A=
>>> +	if (!dentry)=0A=
>>> +		return NULL;=0A=
>>> +=0A=
>>> +	inode =3D new_inode(parent->d_sb);=0A=
>>> +	if (!inode)=0A=
>>> +		goto out_dput;=0A=
>>> +=0A=
>>> +	inode->i_ino =3D get_next_ino();=0A=
>>> +	if (zone) {=0A=
>>> +		struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>>> +=0A=
>>> +		/*=0A=
>>> +		 * Zone file: for read-only zones, do not allow writes.=0A=
>>> +		 * For offline zones, disable all accesses and set the file=0A=
>>> +		 * size to 0.=0A=
>>> +		 */=0A=
>>> +		inode->i_mode =3D S_IFREG;=0A=
>>> +		switch (zone->cond) {=0A=
>>> +		case BLK_ZONE_COND_READONLY:=0A=
>>> +			inode->i_mode |=3D sbi->s_perm & ~(0222); /* S_IWUGO */=0A=
>>> +		case BLK_ZONE_COND_OFFLINE:=0A=
>>> +			break;=0A=
>>> +		default:=0A=
>>> +			inode->i_mode |=3D sbi->s_perm;=0A=
>>> +		}=0A=
>>> +		inode->i_uid =3D sbi->s_uid;=0A=
>>> +		inode->i_gid =3D sbi->s_gid;=0A=
>>> +		zi->i_ztype =3D zonefs_zone_type(zone);=0A=
>>> +		zi->i_zsector =3D zone->start;=0A=
>>> +		zi->i_max_size =3D zone->len << SECTOR_SHIFT;=0A=
>>> +=0A=
>>> +		if (zone->cond =3D=3D BLK_ZONE_COND_OFFLINE)=0A=
>>> +			zi->i_wpoffset =3D 0;=0A=
>>> +		else if (zonefs_file_is_conv(inode))=0A=
>>> +			zi->i_wpoffset =3D zi->i_max_size;=0A=
>>> +		else=0A=
>>> +			zi->i_wpoffset =3D=0A=
>>> +				(zone->wp - zone->start) << SECTOR_SHIFT;=0A=
>>> +=0A=
>>> +		inode->i_size =3D zi->i_wpoffset;=0A=
>>> +		inode->i_blocks =3D zone->len;=0A=
>>> +		inode->i_fop =3D &zonefs_file_operations;=0A=
>>> +		inode->i_op =3D &zonefs_file_inode_operations;=0A=
>>> +		inode->i_mapping->a_ops =3D &zonefs_file_aops;=0A=
>>> +		inode->i_mapping->a_ops =3D &zonefs_file_aops;=0A=
>>> +	} else {=0A=
>>> +		/* Zone group directory */=0A=
>>> +		inode_init_owner(inode, dir, S_IFDIR | 0555);=0A=
>>> +		inode->i_fop =3D &simple_dir_operations;=0A=
>>> +		inode->i_op =3D &simple_dir_inode_operations;=0A=
>>> +		set_nlink(inode, 2);=0A=
>>> +		inc_nlink(dir);=0A=
>>> +	}=0A=
>>> +	inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D dir->i_ctime=
;=0A=
>>> +=0A=
>>> +	d_add(dentry, inode);=0A=
>>> +	d_inode(parent)->i_size +=3D sizeof(struct dentry);=0A=
>>> +=0A=
>>> +	return dentry;=0A=
>>> +=0A=
>>> +out_dput:=0A=
>>> +	dput(dentry);=0A=
>>> +	return NULL;=0A=
>>> +}=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * File system stat.=0A=
>>> + */=0A=
>>> +static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)=
=0A=
>>> +{=0A=
>>> +	struct super_block *sb =3D dentry->d_sb;=0A=
>>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>>> +	sector_t nr_sectors =3D sb->s_bdev->bd_part->nr_sects;=0A=
>>> +	enum zonefs_ztype t;=0A=
>>> +	u64 fsid;=0A=
>>> +=0A=
>>> +	buf->f_type =3D ZONEFS_MAGIC;=0A=
>>> +	buf->f_bsize =3D dentry->d_sb->s_blocksize;=0A=
>>> +	buf->f_namelen =3D ZONEFS_NAME_MAX;=0A=
>>> +=0A=
>>> +	buf->f_blocks =3D nr_sectors >> (sb->s_blocksize_bits - SECTOR_SHIFT)=
;=0A=
>>> +	buf->f_bfree =3D 0;=0A=
>>> +	buf->f_bavail =3D 0;=0A=
>>> +=0A=
>>> +	buf->f_files =3D blkdev_nr_zones(sb->s_bdev);=0A=
>>> +	for (t =3D 0 ; t < ZONEFS_ZTYPE_MAX; t++) {=0A=
>>> +		if (sbi->s_nr_zones[t])=0A=
>>> +			buf->f_files++;=0A=
>>> +	}=0A=
>>> +	buf->f_ffree =3D 0;=0A=
>>> +=0A=
>>> +	fsid =3D le64_to_cpup((void *)sbi->s_uuid.b) ^=0A=
>>> +		le64_to_cpup((void *)sbi->s_uuid.b + sizeof(u64));=0A=
>>> +	buf->f_fsid.val[0] =3D (u32)fsid;=0A=
>>> +	buf->f_fsid.val[1] =3D (u32)(fsid >> 32);=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static const struct super_operations zonefs_sops =3D {=0A=
>>> +	.alloc_inode	=3D zonefs_alloc_inode,=0A=
>>> +	.free_inode	=3D zonefs_free_inode,=0A=
>>> +	.statfs		=3D zonefs_statfs,=0A=
>>> +};=0A=
>>> +=0A=
>>> +static char *zgroups_name[ZONEFS_ZTYPE_MAX] =3D {=0A=
>>> +	"cnv",=0A=
>>> +	"seq"=0A=
>>> +};=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * Create a zone group and populate it with zone files.=0A=
>>> + */=0A=
>>> +static int zonefs_create_zgroup(struct super_block *sb, struct blk_zon=
e *zones,=0A=
>>> +				enum zonefs_ztype type)=0A=
>>> +{=0A=
>>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>>> +	struct blk_zone *zone, *next, *end;=0A=
>>> +	char name[ZONEFS_NAME_MAX];=0A=
>>> +	unsigned int nr_files =3D 0;=0A=
>>> +	struct dentry *dir;=0A=
>>> +=0A=
>>> +	/* If the group is empty, nothing to do */=0A=
>>> +	if (!sbi->s_nr_zones[type])=0A=
>>> +		return 0;=0A=
>>> +=0A=
>>> +	dir =3D zonefs_create_inode(sb->s_root, zgroups_name[type], NULL);=0A=
>>> +	if (!dir)=0A=
>>> +		return -ENOMEM;=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Note: The first zone contains the super block: skip it.=0A=
>>> +	 */=0A=
>>> +	end =3D zones + blkdev_nr_zones(sb->s_bdev);=0A=
>>> +	for (zone =3D &zones[1]; zone < end; zone =3D next) {=0A=
>>> +=0A=
>>> +		next =3D zone + 1;=0A=
>>> +		if (zonefs_zone_type(zone) !=3D type)=0A=
>>> +			continue;=0A=
>>> +=0A=
>>> +		/*=0A=
>>> +		 * For conventional zones, contiguous zones can be aggregated=0A=
>>> +		 * together to form larger files.=0A=
>>> +		 * Note that this overwrites the length of the first zone of=0A=
>>> +		 * the set of contiguous zones aggregated together.=0A=
>>> +		 * Only zones with the same condition can be agreggated so that=0A=
>>> +		 * offline zones are excluded and readonly zones are aggregated=0A=
>>> +		 * together into a read only file.=0A=
>>> +		 */=0A=
>>> +		if (type =3D=3D ZONEFS_ZTYPE_CNV &&=0A=
>>> +		    zonefs_has_feature(sbi, ZONEFS_F_AGRCNV)) {=0A=
>>> +			for (; next < end; next++) {=0A=
>>> +				if (zonefs_zone_type(next) !=3D type ||=0A=
>>> +				    next->cond !=3D zone->cond)=0A=
>>> +					break;=0A=
>>> +				zone->len +=3D next->len;=0A=
>>> +			}=0A=
>>> +		}=0A=
>>> +=0A=
>>> +		if (zonefs_has_feature(sbi, ZONEFS_F_STARTSECT_NAME))=0A=
>>> +			/* Use zone start sector as file names */=0A=
>>> +			snprintf(name, ZONEFS_NAME_MAX - 1, "%llu",=0A=
>>> +				 zone->start);=0A=
>>> +		else=0A=
>>> +			/* Use file number as file names */=0A=
>>> +			snprintf(name, ZONEFS_NAME_MAX - 1, "%u", nr_files);=0A=
>>> +		nr_files++;=0A=
>>> +=0A=
>>> +		if (!zonefs_create_inode(dir, name, zone))=0A=
>>> +			return -ENOMEM;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	zonefs_info(sb, "Zone group %d (%s), %u zones -> %u file%s\n",=0A=
>>> +		    type, zgroups_name[type], sbi->s_nr_zones[type],=0A=
>>> +		    nr_files, nr_files > 1 ? "s" : "");=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static struct blk_zone *zonefs_get_zone_info(struct super_block *sb)=
=0A=
>>> +{=0A=
>>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>>> +	struct block_device *bdev =3D sb->s_bdev;=0A=
>>> +	sector_t nr_sectors =3D bdev->bd_part->nr_sects;=0A=
>>> +	unsigned int i, n, nr_zones =3D 0;=0A=
>>> +	struct blk_zone *zones, *zone;=0A=
>>> +	sector_t sector =3D 0;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	zones =3D kvcalloc(blkdev_nr_zones(bdev),=0A=
>>> +			 sizeof(struct blk_zone), GFP_KERNEL);=0A=
>>> +	if (!zones)=0A=
>>> +		return ERR_PTR(-ENOMEM);=0A=
>>> +=0A=
>>> +	/* Get zones information */=0A=
>>> +	zone =3D zones;=0A=
>>> +	while (nr_zones < blkdev_nr_zones(bdev) &&=0A=
>>> +	       sector < nr_sectors) {=0A=
>>> +=0A=
>>> +		n =3D blkdev_nr_zones(bdev) - nr_zones;=0A=
>>> +		ret =3D blkdev_report_zones(bdev, sector, zone, &n);=0A=
>>> +		if (ret) {=0A=
>>> +			zonefs_err(sb, "Zone report failed %d\n", ret);=0A=
>>> +			goto err;=0A=
>>> +		}=0A=
>>> +		if (!n) {=0A=
>>> +			zonefs_err(sb, "No zones reported\n");=0A=
>>> +			ret =3D -EIO;=0A=
>>> +			goto err;=0A=
>>> +		}=0A=
>>> +=0A=
>>> +		for (i =3D 0; i < n; i++) {=0A=
>>> +			switch (zone->type) {=0A=
>>> +			case BLK_ZONE_TYPE_CONVENTIONAL:=0A=
>>> +				zone->wp =3D zone->start + zone->len;=0A=
>>> +				if (zone > zones)=0A=
>>> +					sbi->s_nr_zones[ZONEFS_ZTYPE_CNV]++;=0A=
>>> +				break;=0A=
>>> +			case BLK_ZONE_TYPE_SEQWRITE_REQ:=0A=
>>> +			case BLK_ZONE_TYPE_SEQWRITE_PREF:=0A=
>>> +				if (zone > zones)=0A=
>>> +					sbi->s_nr_zones[ZONEFS_ZTYPE_SEQ]++;=0A=
>>> +				break;=0A=
>>> +			default:=0A=
>>> +				zonefs_err(sb, "Unsupported zone type 0x%x\n",=0A=
>>> +					   zone->type);=0A=
>>> +				ret =3D -EIO;=0A=
>>> +				goto err;=0A=
>>> +			}=0A=
>>> +			sector +=3D zone->len;=0A=
>>> +			zone++;=0A=
>>> +		}=0A=
>>> +=0A=
>>> +		nr_zones +=3D n;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	if (sector < nr_sectors ||=0A=
>>> +	    nr_zones !=3D blkdev_nr_zones(bdev)) {=0A=
>>> +		zonefs_err(sb, "Invalid zone report\n");=0A=
>>> +		ret =3D -EIO;=0A=
>>> +		goto err;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	return zones;=0A=
>>> +=0A=
>>> +err:=0A=
>>> +	kvfree(zones);=0A=
>>> +	return ERR_PTR(ret);=0A=
>>> +}=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * Read super block information from the device.=0A=
>>> + */=0A=
>>> +static int zonefs_read_super(struct super_block *sb)=0A=
>>> +{=0A=
>>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>>> +	struct zonefs_super *super;=0A=
>>> +	struct bio bio;=0A=
>>> +	struct bio_vec bio_vec;=0A=
>>> +	struct page *page;=0A=
>>> +	u32 crc, stored_crc;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	page =3D alloc_page(GFP_KERNEL);=0A=
>>> +	if (!page)=0A=
>>> +		return -ENOMEM;=0A=
>>> +=0A=
>>> +	bio_init(&bio, &bio_vec, 1);=0A=
>>> +	bio.bi_iter.bi_sector =3D 0;=0A=
>>> +	bio_set_dev(&bio, sb->s_bdev);=0A=
>>> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);=0A=
>>> +	bio_add_page(&bio, page, PAGE_SIZE, 0);=0A=
>>> +=0A=
>>> +	ret =3D submit_bio_wait(&bio);=0A=
>>> +	if (ret)=0A=
>>> +		goto out;=0A=
>>> +=0A=
>>> +	super =3D page_address(page);=0A=
>>> +=0A=
>>> +	stored_crc =3D super->s_crc;=0A=
>>> +	super->s_crc =3D 0;=0A=
>>> +	crc =3D crc32_le(ZONEFS_MAGIC, (unsigned char *)super,=0A=
>>> +		       sizeof(struct zonefs_super));=0A=
>>> +	if (crc !=3D stored_crc) {=0A=
>>> +		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",=0A=
>>> +			   crc, stored_crc);=0A=
>>> +		ret =3D -EIO;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	ret =3D -EINVAL;=0A=
>>> +	if (le32_to_cpu(super->s_magic) !=3D ZONEFS_MAGIC)=0A=
>>> +		goto out;=0A=
>>> +=0A=
>>> +	sbi->s_features =3D le64_to_cpu(super->s_features);=0A=
>>> +	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {=0A=
>>> +		zonefs_err(sb, "Unknown features set 0x%llx\n",=0A=
>>> +			   sbi->s_features);=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +=0A=
>>> +	if (zonefs_has_feature(sbi, ZONEFS_F_UID)) {=0A=
>>> +		sbi->s_uid =3D make_kuid(current_user_ns(),=0A=
>>> +				       le32_to_cpu(super->s_uid));=0A=
>>> +		if (!uid_valid(sbi->s_uid)) {=0A=
>>> +			zonefs_err(sb, "Invalid UID feature\n");=0A=
>>> +			goto out;=0A=
>>> +		}=0A=
>>> +	}=0A=
>>> +	if (zonefs_has_feature(sbi, ZONEFS_F_GID)) {=0A=
>>> +		sbi->s_gid =3D make_kgid(current_user_ns(),=0A=
>>> +				       le32_to_cpu(super->s_gid));=0A=
>>> +		if (!gid_valid(sbi->s_gid)) {=0A=
>>> +			zonefs_err(sb, "Invalid GID feature\n");=0A=
>>> +			goto out;=0A=
>>> +		}=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	if (zonefs_has_feature(sbi, ZONEFS_F_PERM))=0A=
>>> +		sbi->s_perm =3D le32_to_cpu(super->s_perm);=0A=
>>> +=0A=
>>> +	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {=0A=
>>> +		zonefs_err(sb, "Reserved area is being used\n");=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	uuid_copy(&sbi->s_uuid, &super->s_uuid);=0A=
>>> +	ret =3D 0;=0A=
>>> +=0A=
>>> +out:=0A=
>>> +	__free_page(page);=0A=
>>> +=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * Check that the device is zoned. If it is, get the list of zones and=
 create=0A=
>>> + * sub-directories and files according to the device zone configuratio=
n.=0A=
>>> + */=0A=
>>> +static int zonefs_fill_super(struct super_block *sb, void *data, int s=
ilent)=0A=
>>> +{=0A=
>>> +	struct zonefs_sb_info *sbi;=0A=
>>> +	struct blk_zone *zones;=0A=
>>> +	struct inode *inode;=0A=
>>> +	enum zonefs_ztype t;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	/* Check device type */=0A=
>>> +	if (!bdev_is_zoned(sb->s_bdev)) {=0A=
>>> +		zonefs_err(sb, "Not a zoned block device\n");=0A=
>>> +		return -EINVAL;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	/* Initialize super block information */=0A=
>>> +	sbi =3D kzalloc(sizeof(*sbi), GFP_KERNEL);=0A=
>>> +	if (!sbi)=0A=
>>> +		return -ENOMEM;=0A=
>>> +=0A=
>>> +	sb->s_fs_info =3D sbi;=0A=
>>> +	sb->s_magic =3D ZONEFS_MAGIC;=0A=
>>> +	sb->s_maxbytes =3D MAX_LFS_FILESIZE;=0A=
>>> +	sb->s_op =3D &zonefs_sops;=0A=
>>> +	sb->s_time_gran	=3D 1;=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * The block size is always equal to the device physical sector size =
to=0A=
>>> +	 * ensure that writes on 512e disks (512B logical block and 4KB=0A=
>>> +	 * physical block) are always aligned.=0A=
>>> +	 */=0A=
>>> +	sb_set_blocksize(sb, bdev_physical_block_size(sb->s_bdev));=0A=
>>> +	sbi->s_blocksize_mask =3D sb->s_blocksize - 1;=0A=
>>> +=0A=
>>> +	sbi->s_uid =3D GLOBAL_ROOT_UID;=0A=
>>> +	sbi->s_gid =3D GLOBAL_ROOT_GID;=0A=
>>> +	sbi->s_perm =3D 0640; /* S_IRUSR | S_IWUSR | S_IRGRP */=0A=
>>> +=0A=
>>> +	ret =3D zonefs_read_super(sb);=0A=
>>> +	if (ret)=0A=
>>> +		return ret;=0A=
>>> +=0A=
>>> +	zones =3D zonefs_get_zone_info(sb);=0A=
>>> +	if (IS_ERR(zones))=0A=
>>> +		return PTR_ERR(zones);=0A=
>>> +=0A=
>>> +	pr_info("zonefs: Mounting %s, %u zones",=0A=
>>> +		sb->s_id, blkdev_nr_zones(sb->s_bdev));=0A=
>>> +=0A=
>>> +	/* Create root directory inode */=0A=
>>> +	ret =3D -ENOMEM;=0A=
>>> +	inode =3D new_inode(sb);=0A=
>>> +	if (!inode)=0A=
>>> +		goto out;=0A=
>>> +=0A=
>>> +	inode->i_ino =3D get_next_ino();=0A=
>>> +	inode->i_mode =3D S_IFDIR | 0755;=0A=
>>> +	inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D current_time=
(inode);=0A=
>>> +	inode->i_op =3D &simple_dir_inode_operations;=0A=
>>> +	inode->i_fop =3D &simple_dir_operations;=0A=
>>> +	inode->i_size =3D sizeof(struct dentry) * 2;=0A=
>>> +	set_nlink(inode, 2);=0A=
>>> +=0A=
>>> +	sb->s_root =3D d_make_root(inode);=0A=
>>> +	if (!sb->s_root)=0A=
>>> +		goto out;=0A=
>>> +=0A=
>>> +	/* Create and populate zone groups */=0A=
>>> +	for (t =3D ZONEFS_ZTYPE_CNV; t < ZONEFS_ZTYPE_MAX; t++) {=0A=
>>> +		ret =3D zonefs_create_zgroup(sb, zones, t);=0A=
>>> +		if (ret)=0A=
>>> +			break;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +out:=0A=
>>> +	kvfree(zones);=0A=
>>> +=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static struct dentry *zonefs_mount(struct file_system_type *fs_type,=
=0A=
>>> +				 int flags, const char *dev_name, void *data)=0A=
>>> +{=0A=
>>> +	return mount_bdev(fs_type, flags, dev_name, data, zonefs_fill_super);=
=0A=
>>> +}=0A=
>>> +=0A=
>>> +static void zonefs_kill_super(struct super_block *sb)=0A=
>>> +{=0A=
>>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>>> +=0A=
>>> +	kfree(sbi);=0A=
>>> +	if (sb->s_root)=0A=
>>> +		d_genocide(sb->s_root);=0A=
>>> +	kill_block_super(sb);=0A=
>>> +}=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * File system definition and registration.=0A=
>>> + */=0A=
>>> +static struct file_system_type zonefs_type =3D {=0A=
>>> +	.owner		=3D THIS_MODULE,=0A=
>>> +	.name		=3D "zonefs",=0A=
>>> +	.mount		=3D zonefs_mount,=0A=
>>> +	.kill_sb	=3D zonefs_kill_super,=0A=
>>> +	.fs_flags	=3D FS_REQUIRES_DEV,=0A=
>>> +};=0A=
>>> +=0A=
>>> +static int __init zonefs_init_inodecache(void)=0A=
>>> +{=0A=
>>> +	zonefs_inode_cachep =3D kmem_cache_create("zonefs_inode_cache",=0A=
>>> +			sizeof(struct zonefs_inode_info), 0,=0A=
>>> +			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),=0A=
>>> +			NULL);=0A=
>>> +	if (zonefs_inode_cachep =3D=3D NULL)=0A=
>>> +		return -ENOMEM;=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static void zonefs_destroy_inodecache(void)=0A=
>>> +{=0A=
>>> +	/*=0A=
>>> +	 * Make sure all delayed rcu free inodes are flushed before we=0A=
>>> +	 * destroy the inode cache.=0A=
>>> +	 */=0A=
>>> +	rcu_barrier();=0A=
>>> +	kmem_cache_destroy(zonefs_inode_cachep);=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int __init zonefs_init(void)=0A=
>>> +{=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	BUILD_BUG_ON(sizeof(struct zonefs_super) !=3D ZONEFS_SUPER_SIZE);=0A=
>>> +=0A=
>>> +	ret =3D zonefs_init_inodecache();=0A=
>>> +	if (ret)=0A=
>>> +		return ret;=0A=
>>> +=0A=
>>> +	ret =3D register_filesystem(&zonefs_type);=0A=
>>> +	if (ret) {=0A=
>>> +		zonefs_destroy_inodecache();=0A=
>>> +		return ret;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static void __exit zonefs_exit(void)=0A=
>>> +{=0A=
>>> +	zonefs_destroy_inodecache();=0A=
>>> +	unregister_filesystem(&zonefs_type);=0A=
>>> +}=0A=
>>> +=0A=
>>> +MODULE_AUTHOR("Damien Le Moal");=0A=
>>> +MODULE_DESCRIPTION("Zone file system for zoned block devices");=0A=
>>> +MODULE_LICENSE("GPL");=0A=
>>> +module_init(zonefs_init);=0A=
>>> +module_exit(zonefs_exit);=0A=
>>> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h=0A=
>>> new file mode 100644=0A=
>>> index 000000000000..5338663711b4=0A=
>>> --- /dev/null=0A=
>>> +++ b/fs/zonefs/zonefs.h=0A=
>>> @@ -0,0 +1,185 @@=0A=
>>> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>>> +/*=0A=
>>> + * Simple zone file system for zoned block devices.=0A=
>>> + *=0A=
>>> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.=
=0A=
>>> + */=0A=
>>> +#ifndef __ZONEFS_H__=0A=
>>> +#define __ZONEFS_H__=0A=
>>> +=0A=
>>> +#include <linux/fs.h>=0A=
>>> +#include <linux/magic.h>=0A=
>>> +#include <linux/uuid.h>=0A=
>>> +#include <linux/mutex.h>=0A=
>>> +#include <linux/rwsem.h>=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * Maximum length of file names: this only needs to be large enough to=
 fit=0A=
>>> + * the zone group directory names and a decimal value of the start sec=
tor of=0A=
>>> + * the zones for file names. 16 characters is plenty.=0A=
>>> + */=0A=
>>> +#define ZONEFS_NAME_MAX		16=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * Zone types: ZONEFS_ZTYPE_SEQ is used for all sequential zone types=
=0A=
>>> + * defined in linux/blkzoned.h, that is, BLK_ZONE_TYPE_SEQWRITE_REQ an=
d=0A=
>>> + * BLK_ZONE_TYPE_SEQWRITE_PREF.=0A=
>>> + */=0A=
>>> +enum zonefs_ztype {=0A=
>>> +	ZONEFS_ZTYPE_CNV,=0A=
>>> +	ZONEFS_ZTYPE_SEQ,=0A=
>>> +	ZONEFS_ZTYPE_MAX,=0A=
>>> +};=0A=
>>> +=0A=
>>> +static inline enum zonefs_ztype zonefs_zone_type(struct blk_zone *zone=
)=0A=
>>> +{=0A=
>>> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>>> +		return ZONEFS_ZTYPE_CNV;=0A=
>>> +	return ZONEFS_ZTYPE_SEQ;=0A=
>>> +}=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * Inode private data.=0A=
>>> + */=0A=
>>> +struct zonefs_inode_info {=0A=
>>> +	struct inode		i_vnode;=0A=
>>> +	enum zonefs_ztype	i_ztype;=0A=
>>> +	sector_t		i_zsector;=0A=
>>> +	loff_t			i_wpoffset;=0A=
>>> +	loff_t			i_max_size;=0A=
>>> +	struct mutex		i_truncate_mutex;=0A=
>>> +	struct rw_semaphore	i_mmap_sem;=0A=
>>> +};=0A=
>>> +=0A=
>>> +static inline struct zonefs_inode_info *ZONEFS_I(struct inode *inode)=
=0A=
>>> +{=0A=
>>> +	return container_of(inode, struct zonefs_inode_info, i_vnode);=0A=
>>> +}=0A=
>>> +=0A=
>>> +static inline bool zonefs_file_is_conv(struct inode *inode)=0A=
>>> +{=0A=
>>> +	return ZONEFS_I(inode)->i_ztype =3D=3D ZONEFS_ZTYPE_CNV;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static inline bool zonefs_file_is_seq(struct inode *inode)=0A=
>>> +{=0A=
>>> +	return ZONEFS_I(inode)->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ;=0A=
>>> +}=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * Start sector on disk of a file zone.=0A=
>>> + */=0A=
>>> +static inline loff_t zonefs_file_start_sector(struct inode *inode)=0A=
>>> +{=0A=
>>> +	return ZONEFS_I(inode)->i_zsector;=0A=
>>> +}=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * Maximum possible size of a file (i.e. the zone size).=0A=
>>> + */=0A=
>>> +static inline loff_t zonefs_file_max_size(struct inode *inode)=0A=
>>> +{=0A=
>>> +	return ZONEFS_I(inode)->i_max_size;=0A=
>>> +}=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * On-disk super block (block 0).=0A=
>>> + */=0A=
>>> +#define ZONEFS_SUPER_SIZE	4096=0A=
>>> +struct zonefs_super {=0A=
>>> +=0A=
>>> +	/* Magic number */=0A=
>>> +	__le32		s_magic;=0A=
>>> +=0A=
>>> +	/* Checksum */=0A=
>>> +	__le32		s_crc;=0A=
>>> +=0A=
>>> +	/* Features */=0A=
>>> +	__le64		s_features;=0A=
>>> +=0A=
>>> +	/* 128-bit uuid */=0A=
>>> +	uuid_t		s_uuid;=0A=
>>> +=0A=
>>> +	/* UID/GID to use for files */=0A=
>>> +	__le32		s_uid;=0A=
>>> +	__le32		s_gid;=0A=
>>> +=0A=
>>> +	/* File permissions */=0A=
>>> +	__le32		s_perm;=0A=
>>> +=0A=
>>> +	/* Padding to ZONEFS_SUPER_SIZE bytes */=0A=
>>> +	__u8		s_reserved[4052];=0A=
>>> +=0A=
>>> +} __packed;=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * Feature flags: used on disk in the s_features field of struct zonef=
s_super=0A=
>>> + * and in-memory in the s_feartures field of struct zonefs_sb_info.=0A=
>>> + */=0A=
>>> +enum zonefs_features {=0A=
>>> +	/*=0A=
>>> +	 * Use a zone start sector value as file name.=0A=
>>> +	 */=0A=
>>> +	__ZONEFS_F_STARTSECT_NAME,=0A=
>>> +	/*=0A=
>>> +	 * Aggregate contiguous conventional zones into a single file.=0A=
>>> +	 */=0A=
>>> +	__ZONEFS_F_AGRCNV,=0A=
>>> +	/*=0A=
>>> +	 * Use super block specified UID for files instead of default.=0A=
>>> +	 */=0A=
>>> +	__ZONEFS_F_UID,=0A=
>>> +	/*=0A=
>>> +	 * Use super block specified GID for files instead of default.=0A=
>>> +	 */=0A=
>>> +	__ZONEFS_F_GID,=0A=
>>> +	/*=0A=
>>> +	 * Use super block specified file permissions instead of default 640.=
=0A=
>>> +	 */=0A=
>>> +	__ZONEFS_F_PERM,=0A=
>>> +};=0A=
>>> +=0A=
>>> +#define ZONEFS_F_STARTSECT_NAME	(1ULL << __ZONEFS_F_STARTSECT_NAME)=0A=
>>> +#define ZONEFS_F_AGRCNV		(1ULL << __ZONEFS_F_AGRCNV)=0A=
>>> +#define ZONEFS_F_UID		(1ULL << __ZONEFS_F_UID)=0A=
>>> +#define ZONEFS_F_GID		(1ULL << __ZONEFS_F_GID)=0A=
>>> +#define ZONEFS_F_PERM		(1ULL << __ZONEFS_F_PERM)=0A=
>>> +=0A=
>>> +#define ZONEFS_F_DEFINED_FEATURES \=0A=
>>> +	(ZONEFS_F_STARTSECT_NAME | ZONEFS_F_AGRCNV | \=0A=
>>> +	 ZONEFS_F_UID | ZONEFS_F_GID | ZONEFS_F_PERM)=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * In-memory Super block information.=0A=
>>> + */=0A=
>>> +struct zonefs_sb_info {=0A=
>>> +=0A=
>>> +	unsigned long long	s_features;=0A=
>>> +	kuid_t			s_uid;		/* File owner UID */=0A=
>>> +	kgid_t			s_gid;		/* File owner GID */=0A=
>>> +	umode_t			s_perm;		/* File permissions */=0A=
>>> +	uuid_t			s_uuid;=0A=
>>> +=0A=
>>> +	loff_t			s_blocksize_mask;=0A=
>>> +	unsigned int		s_nr_zones[ZONEFS_ZTYPE_MAX];=0A=
>>> +};=0A=
>>> +=0A=
>>> +static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)=
=0A=
>>> +{=0A=
>>> +	return sb->s_fs_info;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static inline bool zonefs_has_feature(struct zonefs_sb_info *sbi,=0A=
>>> +				      enum zonefs_features f)=0A=
>>> +{=0A=
>>> +	return sbi->s_features & f;=0A=
>>> +}=0A=
>>> +=0A=
>>> +#define zonefs_info(sb, format, args...)	\=0A=
>>> +	pr_info("zonefs (%s): " format, sb->s_id, ## args)=0A=
>>> +#define zonefs_err(sb, format, args...)	\=0A=
>>> +	pr_err("zonefs (%s) ERROR: " format, sb->s_id, ## args)=0A=
>>> +#define zonefs_warn(sb, format, args...)	\=0A=
>>> +	pr_warn("zonefs (%s) WARN: " format, sb->s_id, ## args)=0A=
>>> +=0A=
>>> +#endif=0A=
>>> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h=0A=
>>> index 1274c692e59c..3be20c774142 100644=0A=
>>> --- a/include/uapi/linux/magic.h=0A=
>>> +++ b/include/uapi/linux/magic.h=0A=
>>> @@ -86,6 +86,7 @@=0A=
>>>  #define NSFS_MAGIC		0x6e736673=0A=
>>>  #define BPF_FS_MAGIC		0xcafe4a11=0A=
>>>  #define AAFS_MAGIC		0x5a3c69f0=0A=
>>> +#define ZONEFS_MAGIC		0x5a4f4653=0A=
>>>  =0A=
>>>  /* Since UDF 2.01 is ISO 13346 based... */=0A=
>>>  #define UDF_SUPER_MAGIC		0x15013346=0A=
>>>=0A=
>>=0A=
>>=0A=
>> -- =0A=
>> Damien Le Moal=0A=
>> Western Digital Research=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
