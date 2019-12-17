Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262C4121F31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 01:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfLQAF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 19:05:29 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23210 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfLQAF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576541150; x=1608077150;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2PmHSI0Nprcs/ZKv5fFso4JHklq2EPCpdFTkVjFNelE=;
  b=AE2AF/XLO5Pe5q+S/FZEPNX+WFzKkofu2Sq9UO/DarHHOzbuKqB5PfiZ
   CJpbyAXMSEKaYQbixspgwt3lFR0mCZhwgoohB8gxnPh4W5ysmmTLdqf4c
   I8SJSgcY1PyaBB+0E/93G0T90Ws8KPo5s7ZLu66zfzzQFZE0MUBzxmchF
   LTjFqwqGImD1LDOfC2wpYMG4drlqRwp4df+h5til2WQRfc3McoNkVOa/y
   JsBr8GtRqg04x6xjwAG8Prx/k0kQwCQ0iNIQt5sk8G2A5QzGL7MfMROsm
   ahZgEaf6sRwJQALTCNBvfTaOfRHN8ubkbesVCUP53mNApYnNzCB8blAUh
   w==;
IronPort-SDR: iR4V63Q0GnxHSqfoOF77tJ5ti16YnuTPdFhLfc4xgTpl3GMyyKErkI3psyCjEyHgle/+E7Q3zQ
 9S1vlciQMM1AgxndTBy27+ISpuxwtaLaKlbgjoe/VTTe2w1jb+gL4n0ERU0nuM25AyrO/5DGcr
 +NBZqqhL+8+rCzp2ufN07PYzqsALemTsWlIhrLNAr9oaCxxuIXOrooxNTv4aHvZC0GZczEN497
 0rUdIKCapIwCT1cQr/cY5tHuu4J8wPywSdeeZToJPVs3G6JSEBAVbcD2uuvpZ3lAMJW7ohk7iJ
 MH0=
X-IronPort-AV: E=Sophos;i="5.69,323,1571673600"; 
   d="scan'208";a="227064706"
Received: from mail-cys01nam02lp2058.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.58])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2019 08:05:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwO/fcas1nmM45GCpRYdDPyWyPgtiiEP1eaHiTNmdS2RWKjm/Y/gr6IxfMU8YRoY80NYqbdAMHnLz6jaAEqrOtIJURum0hpVVkVafKPzqv9l8KvBfsdcuPZMdJYrZZS3TG6sfpR0gOmWG3hk/b1IpBpzOpJz6COtWneLWfMsaD+OvwV6oozSLkScoHhDgp37s2AfeQ6XptAprKuTCol60pr4vHC+VWnnxE4oXkZUBVEF/NHob3jlQbAstqmNg5q/5vN1yxfLOYJ+sXpAZwNphwJ/XXKuUnEtzcZYSOEQ79Ui590qxzNZxhko8AmDp305OucMBH00ACBoVIDUepkqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PmHSI0Nprcs/ZKv5fFso4JHklq2EPCpdFTkVjFNelE=;
 b=Hndtlk8xEbxRQbouWPt2BlZ0qGWqmvYzdGvmTXVvyf3lMxp4GQVQNe0Bu3eR9tU00cSxIf7tBZuOKd5jSoznN76+iOabOeg+Qrd4c34pADgcBzMR87DiHi2hXNkU/v5zJaafSjUgXxYh4iDzmh15ROYEpXoIkoELnOhyQp8NSWko8YzVhl1QnC3ZoNAbeGREtixv6HAgRE5K26Ese6x+s/nIoFoZc7Q0JWpUN5hYoO/ivx5ziHtzL3jl6WV2TgRnUWMUj6ipdM91iU0CngRE27Ck4Kx4HuE+rYAW9XLaEAqGUtKOUI6fQbaA2kMp9bMqXvinPjzXyOsoEl9ILiQFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PmHSI0Nprcs/ZKv5fFso4JHklq2EPCpdFTkVjFNelE=;
 b=UbnXaDFZBOOF1ZtTnhglfMqTdZCmoddOW34otouzcfDoJthERb425O9MZ0mfNHoCuJXZMsgzHzkSvYiKQjVaxZXlgeZRqDSq572OA8/ZizkzWlYI0HLdOiuwobGoHKbxGEW+tpK5Q8SLTHT5U6F6wjyq2+O491n36aHW254PCrQ=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4454.namprd04.prod.outlook.com (52.135.239.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Tue, 17 Dec 2019 00:05:25 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 00:05:25 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/2] New zonefs file system
Thread-Topic: [PATCH 0/2] New zonefs file system
Thread-Index: AQHVsRth1IpCuMwSZ02s8MNISyP74A==
Date:   Tue, 17 Dec 2019 00:05:25 +0000
Message-ID: <BYAPR04MB58166C2F8C7DAFE4686F2DECE7500@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <29fb138e-e9e5-5905-5422-4454c956e685@metux.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7543cd5-7aa4-4c65-3b5b-08d78284d176
x-ms-traffictypediagnostic: BYAPR04MB4454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4454507662377A82322E2A63E7500@BYAPR04MB4454.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(71200400001)(9686003)(52536014)(33656002)(5660300002)(66574012)(55016002)(6506007)(53546011)(7696005)(66556008)(91956017)(66446008)(64756008)(66476007)(76116006)(66946007)(86362001)(26005)(54906003)(8936002)(81166006)(2906002)(8676002)(4326008)(81156014)(110136005)(186003)(478600001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4454;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DY0JKQI50cezyM0kNboM7DdIdhprh9b4e6ON2wc0YZbafpSrKP1Cjk5nHb6jCEfcvJThlcXn3UBfo5kWMe30RzxTgJc/k1sR3opOC8Gu/HB31OvPaDzd+SdoCzWkjXv95VihOiCUBvyC5uRChJs2FzF5lRTLLywBECaeDycR6oTahHSLHiauMLaEwxZlfSno0pr1YtgdkzCuPy1uh1n7z1c9UTUxFvEAF8NoyyIFBZFlpLfgk7zZe+lfaX+PrqmeB8mSdbqr+tJ5msoORJj+sDScbb8DnLsx6K1rFDz5OJzf9OzdNEQmEXjmtPGe14Bx/kZ9/rOfybJ5M5BaTLJ9v2oZUvM731U87dqTj8jOdhePWKuxXxalZm5tBi85/A2DKjGoKHbRGrHEeufSh2HQ88+mxsoXTgCEGbqdc5x017/2LQ7nKJoLI3LDAtFscnPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7543cd5-7aa4-4c65-3b5b-08d78284d176
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 00:05:25.6155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15IF1SYqBRCMepeNWA9wuCV4uFXU/XPLiD00oRhPmiBJNs4YXltb+JC64Piobxg2D1B0AD5BFtl8Q0AvBG1BMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4454
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/16 17:19, Enrico Weigelt, metux IT consult wrote:=0A=
> On 12.12.19 19:38, Damien Le Moal wrote:=0A=
> =0A=
> Hi,=0A=
> =0A=
>> zonefs is a very simple file system exposing each zone of a zoned block=
=0A=
>> device as a file. Unlike a regular file system with zoned block device=
=0A=
>> support (e.g. f2fs or the on-going btrfs effort), zonefs does not hide=
=0A=
>> the sequential write constraint of zoned block devices to the user.=0A=
> =0A=
> Just curious: what's the exact definition of "zoned" here ?=0A=
> Something like partitions ?=0A=
=0A=
As Carlos commented already, a zoned block device is Linux abstraction=0A=
used to handle SMR HDDs (Shingled Magnetic Recording). These disks=0A=
expose an LBA range that is divided into zones that can only be written=0A=
sequentially for host-managed models. Other models such as host-aware or=0A=
drive-managed allow random writes to all zones at the cost of potential=0A=
serious performance degradation due to disk internal garbage collection=0A=
of zones (similarly to an SSD handling of erase blocks).=0A=
=0A=
While today zoned block devices exist on the market only in the form of=0A=
SMR disks, NVMe SSDs will also soon be available with the completion of=0A=
the Zoned Namespace specifications.=0A=
=0A=
Zoning of block devices has several advantages: higher capacities for=0A=
HDDs and more predictable and lower IO latencies for SSDs (almost no=0A=
internal GC/weir leveling needed). But taking full advantage of these=0A=
devices require software changes on the host due to the sequential write=0A=
constraint imposed by the devices interface.=0A=
=0A=
> Can these files then also serve as block devices for other filesystems ?=
=0A=
> Just a funny idea: could we handle partitions by a file system ?=0A=
> =0A=
> Even more funny idea: give file systems block device ops, so they can=0A=
> be directly used as such (w/o explicitly using loopdev) ;-)=0A=
=0A=
This is outside the scope of this thread, so let's not start a=0A=
discussion about this here. Start a new thread !=0A=
=0A=
>> Files representing sequential write zones of the device must be written=
=0A=
>> sequentially starting from the end of the file (append only writes).=0A=
> =0A=
> So, these files can only be accessed like a tape ?=0A=
=0A=
Writes must be sequential within a zone but reads can be random to any=0A=
writen LBA.=0A=
=0A=
> Assuming you're working ontop of standard block devices anyways (instead=
=0A=
> of tape-like media ;-)) - why introducing such a limitation ?=0A=
=0A=
See above: the limitation is physical, by the device, so that different=0A=
improvements can be achieved depending on the storage medium being used=0A=
(increased capacity, lower latencies, lower over provisioning, etc)=0A=
=0A=
> =0A=
>> zonefs is not a POSIX compliant file system. It's goal is to simplify=0A=
>> the implementation of zoned block devices support in applications by=0A=
>> replacing raw block device file accesses with a richer file based API,=
=0A=
>> avoiding relying on direct block device file ioctls which may=0A=
>> be more obscure to developers. =0A=
> =0A=
> ioctls ?=0A=
> =0A=
> Last time I checked, block devices could be easily accessed via plain=0A=
> file ops (read, write, seek, ...). You can basically treat them just=0A=
> like big files of fixed size.=0A=
=0A=
I was not clear, my apologies. I am refering here to the zoned block=0A=
device related ioctls defined in include/uapi/linux/blkzoned.h. These=0A=
ioctls allow an application to manage the device zones (obtain zone=0A=
information, erase zones, etc). These ioctls trigger issuing zone=0A=
related commands to the device. These commands are defined by the ZBC=0A=
and ZAC standards for SCSI and ATA, and NVMe Zoned Namespace in the very=0A=
near future.=0A=
=0A=
>> One example of this approach is the=0A=
>> implementation of LSM (log-structured merge) tree structures (such as=0A=
>> used in RocksDB and LevelDB)=0A=
> =0A=
> The same LevelDB as used eg. in Chrome browser, which destroys itself=0A=
> every time a little temporary problem (eg. disk full) occours ?=0A=
> If that's the usecase I'd rather use an simple in-memory table instead=0A=
> and and enough swap, as leveldb isn't reliable enough for persistent=0A=
> data anyways :p=0A=
=0A=
The intent of my comment was not to advocate for or discuss the merits=0A=
of any particular KV implementation. I was only pointing out that zonefs=0A=
does not come in a void and that we do have use cases for it and did the=0A=
work on some user space software to validate it. Leveldb and RocksDB are=0A=
the 2 LSM-tree based KV stores we worked on as they are very popular and=0A=
widely used.=0A=
=0A=
>> on zoned block devices by allowing SSTables=0A=
>> to be stored in a zone file similarly to a regular file system rather=0A=
>> than as a range of sectors of a zoned device. The introduction of the=0A=
>> higher level construct "one file is one zone" can help reducing the=0A=
>> amount of changes needed in the application while at the same time=0A=
>> allowing the use of zoned block devices with various programming=0A=
>> languages other than C.=0A=
> =0A=
> Why not just simply use files on a suited filesystem (w/ low block io=0A=
> overhead) or LVM volumes ?=0A=
=0A=
Using a file system compliant with zoned block device constraint such as=0A=
f2fs or btrfs (on-going work) is certainly a valid approach. However,=0A=
this may not be the most optimal one if the application being used as a=0A=
mostly sequential write behavior. LSM-tree based KV stores fall into=0A=
this category: SSTables are large (several MB) and always written=0A=
sequentially. There are not random writes, which facilitates supporting=0A=
directly zoned block devices without the need for a file system which=0A=
would add a GC background process and degrade performance. As mentioned=0A=
in the cover letter, zonefs goal is to facilitate the implementation of=0A=
this support compared toa pure raw block device use.=0A=
=0A=
> =0A=
> =0A=
> --mtx=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
