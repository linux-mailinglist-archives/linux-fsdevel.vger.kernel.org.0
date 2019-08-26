Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C2F9C86A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 06:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfHZEc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 00:32:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:36974 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfHZEc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 00:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566793976; x=1598329976;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=95vk5KOMVEdMcbqiClCdl32v3QmU6u7qglje+NjI1n8=;
  b=WDmASDzEeDWE5U5yNXJsAHvMgSKCxNnS1UTehlCrRjCOv2KdZojSvsDQ
   6nMpYlV2+ZGZHm9ebEUqvZHDmZnQzrJDiUk21qeY6z0k3GADGG/G78qdW
   UUWSnRAkeGEt98OMOew51jlB+Yj5/bzRhQMoTGVDUVJ6kXkSp6lspQiUg
   Ud2/1lZFxdlEGWC4xxgRflXZ9OHQq9wTV9/kIKo2gRGvwxTbLK79LOzB7
   buYVuzVLnBwtl14DrqnfgMIqitO54vuvgavq9tomt6kxiUhCX3H/x03GB
   naN7TWU48ldUEgNkathBL8VMgkvFUxN8v0FuSjFJUUF4fstxzFuCBvxrS
   A==;
IronPort-SDR: 2AN62+8WVyLvcafzg5/qcEh/JxmTK59x18CMg92fUh05YcGKIzdmR80lT2QsvszLpBRAdtTCQi
 1zKpgLh2Yj1HVlB36hbzYCecIilKVwsdm9Ea44hlSElfQIeiixZkJn7aqhxImtCwxD2qxvzWcT
 kf9dckFMDeB6pzvc/3L/nsKTmzwMlTPbNTiTGMBraXPgPlTgTKgD4w2nbkV3ol+WTeq0cCVVAr
 SF6jm7hXM8IkMcMvFbgOGlNr831V/ByCZQqFpH1IHODr2wPX/ZiLfKJOyIpgrWRWY5ej7tHkO+
 bfo=
X-IronPort-AV: E=Sophos;i="5.64,431,1559491200"; 
   d="scan'208";a="121221713"
Received: from mail-by2nam05lp2052.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.52])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2019 12:32:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrKIIjeCeZiJ87coq2Sdi9NklGBUsr4949M0u3IWtw6eCGtC/8M3t8nsHXYtSEW3tXHf/b1bsyhvmRVEckbU8+k0LKExvq8fCz15KxMQFDkDj7OziLuPKVxIhRSFbmy/aa3HIRW7qyOLfLPwF1krRuZ3kZsSQRsJbbZjbU1Yzq4Xu39COsIBFG6Y/8pRjUoirrY3WOr+eZu1ihg+FsRCmH7HPH9Ov/YS71D00HPYtFxQNt7gaO6oxRN5vxPK0logTHJ68mRa+2Y0kFgdmdC+k1Ihqg6XpFGw7UE4p9MB/8PdV+L0e29QwtADFhsLIctUbyIP06AUdb4MOvQG8JTZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPO3C2G8xrNCE210c8txDeEf3BBTVUQCQVyJVycgLDg=;
 b=YZ3sfU1rqk5oNxzlx18iXJpIIg3AqpELgs7JRyfaRITPs3aZ5uqjAQQ5LbQcDCs+nD3c0jHv2CuvTm6it6kOfRUp/+DRoSdLAuXG3rHB6eNQydtRSZ8sEnNa6ZzYjQXh6rAYIp95E8OS98pLQhsdopmsERr6yCRk8r3BdpYDPpEl4pmwMS4z0D2x8rhLi0QdwljAToVXhbk2Aadl4bZxqQHWi1SGsl3L6TyYa2iXkTYALwNdFdoK0i1abqzvSHlzOyZ4FxscO7duYFOiGvbS2dMHP3/kLUVQ0O39BQiuCIe4/REPO7SZGz6opeq/TlWSwB5AkoFN6VkMrShcoEJ07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPO3C2G8xrNCE210c8txDeEf3BBTVUQCQVyJVycgLDg=;
 b=k4XVWL5JBWIPWV6TV4R5XVP9SIi+s8+bZAJ8elpb2sXEaadxQ6R2atwB3S/CQgRv1rFeoKoz/2L9JXAfGWTFrzpeon5drRTYZxjkG9TEVjqq5GRC/TFmCrTWv2Pqus7aOFz+e7NeTMzkEeo+KQ7fueYA08AxokAeGfC0e98TWUk=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4165.namprd04.prod.outlook.com (20.176.250.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.20; Mon, 26 Aug 2019 04:32:54 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 04:32:54 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hannes Reinecke <hare@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
CC:     Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH V3] fs: New zonefs file system
Thread-Topic: [PATCH V3] fs: New zonefs file system
Thread-Index: AQHVV+6BGBTM4G0GmU+CLBAUhcNmkA==
Date:   Mon, 26 Aug 2019 04:32:54 +0000
Message-ID: <BYAPR04MB58163E078011B720CADF653BE7A10@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190821070308.28665-1-damien.lemoal@wdc.com>
 <5b52c0d5-fc9c-f671-a31f-7b828c767788@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0138dad9-89cf-46cb-2e9d-08d729de7680
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4165;
x-ms-traffictypediagnostic: BYAPR04MB4165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4165D01BCE4382222FE65603E7A10@BYAPR04MB4165.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(199004)(189003)(86362001)(316002)(66556008)(66476007)(478600001)(66446008)(76116006)(66946007)(229853002)(91956017)(64756008)(33656002)(102836004)(66066001)(53546011)(6506007)(305945005)(26005)(7736002)(6436002)(74316002)(53936002)(71200400001)(3846002)(8936002)(186003)(6116002)(9686003)(81156014)(81166006)(486006)(76176011)(55016002)(8676002)(2501003)(99286004)(7696005)(14454004)(52536014)(14444005)(256004)(71190400001)(25786009)(2201001)(5660300002)(4326008)(2906002)(446003)(6246003)(110136005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4165;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EBQmdnpdTO0b4AoqLi7d5QnL60DHauQeP4Nzjw7xFFEhdGbQMNsS9EkAV2hByBEeL3X8AwkxCbVZLP4aW2lVhyh/76DWp3mGiumjutHogicNqVJ+L04SlxK4Qi+ORIuuF2ei1enMD2j25C0GpbUfUmM9U8bHE/dkDzhpT9gYy6q0xQa3ZJOFw3RrYpPgyKFQjUKS2Q3WwveqhMjuuZ/wMl4BjmhrQKhtYTifqYdf2xD59wNe85WrB8sDyajWAzfU1aBq1LvXwjqZ2GfCy4s6bBHcrtZjm0Fl2CKai8tzXXVjH8QJom4p+OPOCOKCUsP47uEzxa8CGX7zKpxVU75G2udZwbBjXSrCaiJVzTa9r9oDDwcI7hS4BajqsL9cjvCv83NuRLyMp/0cGK37vWXWd5FrqAfgqSGOlHNtAjUORsM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0138dad9-89cf-46cb-2e9d-08d729de7680
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 04:32:54.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gBp4bUJlG719QLhnoy42JBdrM8vR8vAhWLetVXdVWs4qitXkFY0mY0qs4bb+YtGSS1z4k7McMEYLSkk8E2XniA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4165
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hannes,=0A=
=0A=
On 2019/08/23 19:12, Hannes Reinecke wrote:=0A=
> On 8/21/19 9:03 AM, Damien Le Moal wrote:=0A=
[...]>> @@ -261,6 +262,7 @@ source "fs/romfs/Kconfig"=0A=
>>  source "fs/pstore/Kconfig"=0A=
>>  source "fs/sysv/Kconfig"=0A=
>>  source "fs/ufs/Kconfig"=0A=
>> +source "fs/ufs/Kconfig"=0A=
>>  =0A=
>>  endif # MISC_FILESYSTEMS=0A=
>>  =0A=
> Hmm?=0A=
> Duplicate line?=0A=
=0A=
Ooops... Something is wrong with my rebase since there is no need to touch =
this=0A=
file. Will check.=0A=
=0A=
> =0A=
>> diff --git a/fs/Makefile b/fs/Makefile=0A=
>> index d60089fd689b..7d3c90e1ad79 100644=0A=
>> --- a/fs/Makefile=0A=
>> +++ b/fs/Makefile=0A=
>> @@ -130,3 +130,4 @@ obj-$(CONFIG_F2FS_FS)		+=3D f2fs/=0A=
>>  obj-$(CONFIG_CEPH_FS)		+=3D ceph/=0A=
>>  obj-$(CONFIG_PSTORE)		+=3D pstore/=0A=
>>  obj-$(CONFIG_EFIVAR_FS)		+=3D efivarfs/=0A=
>> +obj-$(CONFIG_ZONEFS_FS)		+=3D zonefs/=0A=
>> diff --git a/fs/zonefs/Kconfig b/fs/zonefs/Kconfig=0A=
>> new file mode 100644=0A=
>> index 000000000000..6490547e9763=0A=
>> --- /dev/null=0A=
>> +++ b/fs/zonefs/Kconfig=0A=
>> @@ -0,0 +1,9 @@=0A=
>> +config ZONEFS_FS=0A=
>> +	tristate "zonefs filesystem support"=0A=
>> +	depends on BLOCK=0A=
>> +	depends on BLK_DEV_ZONED=0A=
>> +	help=0A=
>> +	  zonefs is a simple File System which exposes zones of a zoned block=
=0A=
>> +	  device as files.=0A=
>> +=0A=
>> +	  If unsure, say N.=0A=
>> diff --git a/fs/zonefs/Makefile b/fs/zonefs/Makefile=0A=
>> new file mode 100644=0A=
>> index 000000000000..75a380aa1ae1=0A=
>> --- /dev/null=0A=
>> +++ b/fs/zonefs/Makefile=0A=
>> @@ -0,0 +1,4 @@=0A=
>> +# SPDX-License-Identifier: GPL-2.0=0A=
>> +obj-$(CONFIG_ZONEFS_FS) +=3D zonefs.o=0A=
>> +=0A=
>> +zonefs-y	:=3D super.o=0A=
>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..5521c21fd34b=0A=
>> --- /dev/null=0A=
>> +++ b/fs/zonefs/super.c=0A=
> [ .. ]=0A=
> =0A=
> That whole thing looks good to me (with my limited fs skills :-),=0A=
> however, some things I'd like to have clarified:=0A=
> =0A=
> - zone state handling:=0A=
> While you do have some handling for offline zones, I'm missing a=0A=
> handling during normal I/O. Surely a zone can go offline via other means=
=0A=
> (like the admin calling nasty user-space programs), which then would=0A=
> result in an I/O error in the filesystem.=0A=
> Shouldn't we handle this case when doing error handling?=0A=
=0A=
Yes, we could. But whatever we do, the only solution is to return an IO err=
or to=0A=
the user for any IO request directed at an offline zone. Without the specia=
l=0A=
offline zone handling code, the drive fails all read/write request to the=
=0A=
offline zone, resulting in the same behavior. So I do not see this as criti=
cal=0A=
and could be later improvements.=0A=
=0A=
But I can see that for a file representing an offline zone, changing the fi=
le=0A=
size to 0 and/or removing all access rights to the file would be a good ide=
a.=0A=
=0A=
> IE shouldn't we look at the zone state when doing a REPORT ZONES, and=0A=
> update it if required?=0A=
=0A=
That is what the error handling path should do, yes.=0A=
=0A=
> Similarly: How do we present zones which are not accessible? Will they=0A=
> still show up in the directory? I think they should, but we should be=0A=
> returning an error to userspace like EPERM or somesuch.=0A=
=0A=
Right now, they are not added to the directory as files, so not visible.=0A=
However, that is a mistake since if zones go offline between 2 mounts, the =
file=0A=
names will shift, which is of course not acceptable. I will fix that and ex=
pose=0A=
even offline zones files, but make them not accessible.=0A=
=0A=
> - zone sizes:=0A=
> From what I've seen sequential zones can be appended to, ie they'll=0A=
> start off at 0 and will increase in size. Conventional zones, OTOH,=0A=
> apparently always have a fixed size. Is that correct?=0A=
=0A=
Yes, correct. Conventional zone files have a fixed size (the zone size or t=
he=0A=
sum of all contiguous conventional zones for aggregated mount) and cannot b=
e=0A=
truncated. They can be overwritten randomly.=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
