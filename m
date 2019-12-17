Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893C5121F97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 01:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfLQAUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 19:20:45 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45029 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfLQAUp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576542053; x=1608078053;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Eu0rL98um6plbfsXUSs7Vk5T4pbHYTBd22mx5X8nuf0=;
  b=Ot0f5JmnV2jwPHTse/pYmkpyb2cuIYhtnhf+u6+ZrJGHcO9HM0W5I3RH
   utrapO7RtXfGS80wEJYU2APDV0BvinSOJSbED6LkAPRHXrUSxNHOAPw45
   Gr2Bj18xJGoe0UZr95BuhctkYtTNhLxZKNgJ58sWeAg3rI2ckX2AXdVYI
   Kde/XxEVW985VdL8cVxp5xe5O2GBsAZxLehBOaMrEcvoqz/q1nyN5BGCt
   7l29j14jTFI7jXrocC4S/lyb2XQFWBx38YmtAzIAJKKBRS2Aro0M309Qs
   prLAwm0J0MeesRsT24Pimw+XE0umLsotNSD6z3BYxpB8o2wuxV6BaEDs8
   g==;
IronPort-SDR: ibkbMQLVLEQKiywF3p70Ra3IUNjr31UxBN3Io0vyRiQ4UkWSMWYWl1lEZ8P03IrdAVUOlO6KJM
 8gcb1ozaIQ87kq1T+TFJpMsszkYbQOBLKbBsSkW1o0QyXtXsLJYAqs0MdDLyI+q3iw6BO08RxL
 Zs9zLQ1oImSgMAZWmtQzc+FULQmslbqvy8FYCu7LKz81k0TNJWJJuqD0B3U4d6iSoR6ilOTutx
 +BZsev2vT+yyAR4fQzv0Iq0PwwzrDUIcM2jTscs4BpTXGQD/xuZ20tcGfFWLm72oRvxKP5F31W
 AJ4=
X-IronPort-AV: E=Sophos;i="5.69,323,1571673600"; 
   d="scan'208";a="227065455"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2019 08:20:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4/U7Gs+X70NBns/XSuzyCxauNSCi61EdqV6a9qz1//8iF1B7PK1UL5DxkBoGgzHSPIpapm9VEjeh6Gn8etrtFNOKQYdLHWAupIcEjDJXo7ccJapohluAh3YarPfMrTjWfhqjHVCLZC8bduRJ+z0hbe2CbAcNibbWIheSrs1GCab4ZxOUC5qjI9kYkPHK2/Z+KVSSL5RXahp5W13ZnD/dZeTd4vtEfgU2+M2EVqu2qXOTTwUDkdp2z7pZIWTAd/ekOY1pueRRANooThDnAQCBqGE63IaISKMgOoXgkEVfidEXiXlA27cUp2satJOXavvkEQ2e+pnPbSR2Z+exHXPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87atRzY5QUto1Mv5zm7xb8q1aIPhbsXr5tDpnlnkp18=;
 b=QISM5v7wyKNnwDSX+JRsokkzsZbWNkb3lNAhZiwK6nPAve662JmefNpPHTadg/lb7kHleLbJKHVoG5uFMhKUB33disKMWQ4XgPLqb7ap9QCp+xGg4R012yubgMRRzqqBkYTrcuKS4+eBdBYJltmCKeG26uc+1ZcVSSv5+BDHgW5XD0s2nOc53cNvM7JO1LqZDoNQPQkvbJsdDSBnAZINvBo40dE4WDnWajNgAzFotPnE5Py5LffTiJTghBpOqTfTIxZAvYArhqlphUi3guBy2fpakylYfW9jZxEDjPWMN1NpXIbH1+fPtTco5sI2nfk62s8K66xi4l4wyDy/VfQTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87atRzY5QUto1Mv5zm7xb8q1aIPhbsXr5tDpnlnkp18=;
 b=Ta2Y5RcU0Y0KR8jdTotxH0rzslCtKlMRLiY5xI+S2wJZCy3DwYM2zqhXd5qD0+4gcU0M3Zb87ftoG7guRFlTRgLXpy4BbrQaUW1Ksj0QNPT6RnpqAqXfhUyV2yuS1QWXXa+r2d4uk75JZbj9hnZYWsjEYr0aipahAaRbYB9bcyY=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5862.namprd04.prod.outlook.com (20.179.58.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 00:20:39 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 00:20:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hannes Reinecke <hare@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 2/2] zonefs: Add documentation
Thread-Topic: [PATCH 2/2] zonefs: Add documentation
Thread-Index: AQHVsRtda3tYiDe0ykqzYv1adE6QJA==
Date:   Tue, 17 Dec 2019 00:20:39 +0000
Message-ID: <BYAPR04MB58163947495EED3B30815CCAE7500@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <20191212183816.102402-3-damien.lemoal@wdc.com>
 <8fe28905-aae5-bfb4-d6ac-f09d7244059e@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a7773cf-6ff8-481f-a51f-08d78286f22f
x-ms-traffictypediagnostic: BYAPR04MB5862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5862662435568F97652D97CFE7500@BYAPR04MB5862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(189003)(4326008)(8936002)(86362001)(71200400001)(8676002)(81156014)(81166006)(55016002)(2906002)(33656002)(54906003)(5660300002)(478600001)(52536014)(7696005)(110136005)(26005)(53546011)(6506007)(91956017)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(186003)(316002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5862;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZHciWfmN/Kbak5jH92/Iz4U8UZV5seUiN+7l0tVIUq/K5JozT/imWbikbiVclX3JNQFAYndQdccHhJils6vMnek5vz25JL9ZwChDr1NeNt9Lj9lgPwYKewVKTMVu0CYFnn6oW7Q9BPKh+N3Jsy3mveuTzGVpAbN7aksDDceAPQC6qm+RBgFIRSjdxlBZndvMt/SKY2WnuMqCkilylZNSJ+mKuQws8IvjBdkc6hHTs4IgAiZlMiwj5W2DsaE9VymRBwhMLxshDSoryvRvK2ei6GgX2l6ld31BCYTlMDKkKn49Ial7GevIcfZvFmQfZdnfh9U9LPWwQsXr34YfINHHR+LlWYSTD/yw2KwDvddv2nCEpoo9LvJokpAQG3ONyOb4/otQ0+vt8leRokDplcQA3QTeiqQC/lbEOdo/65jMiOcUg74f3rFT6XClE6NiqiKt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7773cf-6ff8-481f-a51f-08d78286f22f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 00:20:39.4912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTfQ2/gP9AVYVLw41HmWk6XhEWHVk1pjNF2n/KR8cerEQ4MpJFi/eftGRfM/yaJ4Yf7nLeWC8lLyANnJ1oG9ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5862
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/16 17:38, Hannes Reinecke wrote:=0A=
> On 12/12/19 7:38 PM, Damien Le Moal wrote:=0A=
>> Add the new file Documentation/filesystems/zonefs.txt to document zonefs=
=0A=
>> principles and user-space tool usage.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>   Documentation/filesystems/zonefs.txt | 150 +++++++++++++++++++++++++++=
=0A=
>>   MAINTAINERS                          |   1 +=0A=
>>   2 files changed, 151 insertions(+)=0A=
>>   create mode 100644 Documentation/filesystems/zonefs.txt=0A=
>>=0A=
>> diff --git a/Documentation/filesystems/zonefs.txt b/Documentation/filesy=
stems/zonefs.txt=0A=
>> new file mode 100644=0A=
>> index 000000000000..e5d798f4087d=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/filesystems/zonefs.txt=0A=
>> @@ -0,0 +1,150 @@=0A=
>> +ZoneFS - Zone filesystem for Zoned block devices=0A=
>> +=0A=
>> +Overview=0A=
>> +=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>> +=0A=
>> +zonefs is a very simple file system exposing each zone of a zoned block=
 device=0A=
>> +as a file. Unlike a regular file system with zoned block device support=
 (e.g.=0A=
>> +f2fs), zonefs does not hide the sequential write constraint of zoned bl=
ock=0A=
>> +devices to the user. Files representing sequential write zones of the d=
evice=0A=
>> +must be written sequentially starting from the end of the file (append =
only=0A=
>> +writes).=0A=
>> +=0A=
>> +As such, zonefs is in essence closer to a raw block device access inter=
face=0A=
>> +than to a full featured POSIX file system. The goal of zonefs is to sim=
plify=0A=
>> +the implementation of zoned block devices support in applications by re=
placing=0A=
>> +raw block device file accesses with a richer file API, avoiding relying=
 on=0A=
>> +direct block device file ioctls which may be more obscure to developers=
. One=0A=
>> +example of this approach is the implementation of LSM (log-structured m=
erge)=0A=
>> +tree structures (such as used in RocksDB and LevelDB) on zoned block de=
vices by=0A=
>> +allowing SSTables to be stored in a zone file similarly to a regular fi=
le system=0A=
>> +rather than as a range of sectors of the entire disk. The introduction =
of the=0A=
>> +higher level construct "one file is one zone" can help reducing the amo=
unt of=0A=
>> +changes needed in the application as well as introducing support for di=
fferent=0A=
>> +application programming languages.=0A=
>> +=0A=
>> +zonefs on-disk metadata is reduced to a super block which persistently =
stores a=0A=
>> +magic number and optional features flags and values. On mount, zonefs u=
ses=0A=
>> +blkdev_report_zones() to obtain the device zone configuration and popul=
ates=0A=
>> +the mount point with a static file tree solely based on this informatio=
n.=0A=
>> +E.g. file sizes come from the device zone type and write pointer offset=
 managed=0A=
>> +by the device itself.=0A=
>> +=0A=
>> +The zone files created on mount have the following characteristics.=0A=
>> +1) Files representing zones of the same type are grouped together=0A=
>> +   under the same sub-directory:=0A=
>> +  * For conventional zones, the sub-directory "cnv" is used.=0A=
>> +  * For sequential write zones, the sub-directory "seq" is used.=0A=
>> +  These two directories are the only directories that exist in zonefs. =
Users=0A=
>> +  cannot create other directories and cannot rename nor delete the "cnv=
" and=0A=
>> +  "seq" sub-directories.=0A=
>> +2) The name of zone files is the number of the file within the zone typ=
e=0A=
>> +   sub-directory, in order of increasing zone start sector.=0A=
>> +3) The size of conventional zone files is fixed to the device zone size=
.=0A=
>> +   Conventional zone files cannot be truncated.=0A=
>> +4) The size of sequential zone files represent the file's zone write po=
inter=0A=
>> +   position relative to the zone start sector. Truncating these files i=
s=0A=
>> +   allowed only down to 0, in wich case, the zone is reset to rewind th=
e file=0A=
>> +   zone write pointer position to the start of the zone, or up to the z=
one size,=0A=
>> +   in which case the file's zone is transitioned to the FULL state (fin=
ish zone=0A=
>> +   operation).=0A=
>> +5) All read and write operations to files are not allowed beyond the fi=
le zone=0A=
>> +   size. Any access exceeding the zone size is failed with the -EFBIG e=
rror.=0A=
>> +6) Creating, deleting, renaming or modifying any attribute of files and=
=0A=
>> +   sub-directories is not allowed.=0A=
>> +=0A=
>> +Several optional features of zonefs can be enabled at format time.=0A=
>> +* Conventional zone aggregation: ranges of contiguous conventional zone=
s can be=0A=
>> +  agregated into a single larger file instead of the default one file p=
er zone.=0A=
>> +* File ownership: The owner UID and GID of zone files is by default 0 (=
root)=0A=
>> +  but can be changed to any valid UID/GID.=0A=
>> +* File access permissions: the default 640 access permissions can be ch=
anged.=0A=
>> +=0A=
> =0A=
> Please mention the 'direct writes only to sequential zones' restriction.=
=0A=
=0A=
Yes, indeed, this is missing. Will add it.=0A=
=0A=
> =0A=
> Cheers,=0A=
> =0A=
> Hannes=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
