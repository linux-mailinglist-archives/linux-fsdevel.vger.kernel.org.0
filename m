Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7BE676AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2019 00:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfGLW47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 18:56:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8375 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfGLW47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 18:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562972218; x=1594508218;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6P12jD1EH+3SV/Uci3bWN2toLR3CZ0vwwIWr/81rICM=;
  b=fLdrImOC1ng1QcyUxL+tgUgjqm/1NKKz6qVNDv50TP5VULLme9sdq1Bj
   3EyjNpq0fUHccwtrkyFGjvbrDJLGMvSGB3/ZbIKpfT6k4F5ETmyi11Z/Q
   +p7ZQXQiwxQqZWZo+hjjqD/MgyIA+0NBRDOL8Ovaber4683L/CHL7ceUW
   fMBw5Ot0roQg8ripNMSl3DflsmTAKMX41trnpqVpN9eK+PzLAPw4IaAKG
   8Go043oCcAdpmFJ+UrI4Vq5RfyekPR+Podts+NjQWknUe8m4YTA4XoR0y
   NApqLbKb6444BY8mpUFNGQITBy0tq042J2GgEFx1s8FJaotl0eg+VE1gJ
   w==;
IronPort-SDR: x85vv/RvDkkVZb2ipHDxGDah+jtYes87UZZl+eqXcpH2FQ827Lrd0CEI4PlWqzMyt86xA/Wb+N
 VKbXty7gdmNFCxpLtOWZ6yN8x5d/y2QvcsZO1/++y6N+nXqHCwPS3RqnSCT2xDtnxkZ8TMhzrZ
 u0ry+B6V5Vwua8sXXaLYmhNI05Zledh1j6YVL/FxPY6p0WZGeGKGhCvbNoi/dXyYzEWscWupSF
 0jABYd6v9vGPNXJtwr9kSYDCcZf6Pv91Zer3fc8uVm7ee3Gimbi9n5qdFedvaetHrql2AK7TNR
 zlg=
X-IronPort-AV: E=Sophos;i="5.63,484,1557158400"; 
   d="scan'208";a="112930001"
Received: from mail-co1nam03lp2057.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.57])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2019 06:56:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvOfv909qHhsPPZgA8gnQyUUI+x6miKA91RjYNMsUWAPokxcOoHCxSGzpHYXuZyHzzqcWmOymmsuh7DNnJQI4yhftq2Bu5VHrR4ByI6LwHODgakJ8H0SeGUwOon7l4sPIqk4VdR2vYliDES67Cr5vDw26GwOUjM09HgDP7EoBBd9pNt0/xsNND/t56pivX7FcJNpiTqkbXUDlXSMGzvkJyO8YPIFAj2k6SaR+I/O1nKpANDTn4clcoZ5nahtddmnpogd7ItNtloYCMBxsTGPmbZVzbJRhJ6zLeAq9tst2gk50cW2Z2lpJAxsMjd//xs4HyjLiVFm5Jy/Dpvwhi80Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P12jD1EH+3SV/Uci3bWN2toLR3CZ0vwwIWr/81rICM=;
 b=U8qOaAv1Gb8Kt1cNTHMN0GyF1CRQUc6UdcJ+kFFy0v4VICN6Gxu8RUgWuzPgDNamdRmGN0/v7TsTp/dxkUZf0fMGj9HQ8WonvqLGHhOlJvzX2HbzWHgHNIKiD9+r2CXbEnR1i7fRCx02lAK1YXhEx5In8znzQlsuLlXywy7SQRsLqdRlVMBCPDT3Ed3cwnKAZAqPdW3PLjDzEAxnp2aWvht4hNyorhbG6xKjH8a98PoHwOjNlQ2uEpBdSslygVTU9djg5MKIP02rFww2PHCgUuEIfzVoLVnqsmc9m6cgd98WmiBvxq7z1duUSkxHYjdY5WAaE1wEn7rmdDX5DLq1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P12jD1EH+3SV/Uci3bWN2toLR3CZ0vwwIWr/81rICM=;
 b=P+g7mhnzgsBMjQx4I+B4kRNnhawlNZ9w/P3KyeD0Zb036PeBK5O+HsLXBoME6jFxHxEdAPDTI6uejEJUQhhe4EZwBeQQfgzR1ilH+ljm4iiKjlYtZ3SZbjLiaoMHo5iTQUYA1WHS1hvsAciFEBi724pidAyAIF2TwI1g89EhOk0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5640.namprd04.prod.outlook.com (20.179.56.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 22:56:56 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.012; Fri, 12 Jul 2019
 22:56:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Viacheslav Dubeyko <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Ting Yao <d201577678@hust.edu.cn>
Subject: Re: [PATCH RFC] fs: New zonefs file system
Thread-Topic: [PATCH RFC] fs: New zonefs file system
Thread-Index: AQHVOF31k+9+55ZdEkmKABdH1mzidg==
Date:   Fri, 12 Jul 2019 22:56:55 +0000
Message-ID: <BYAPR04MB5816F3DE20A3C82B82192B94E7F20@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
 <1562951415.2741.18.camel@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbee893a-8022-41be-c93d-08d7071c3d15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5640;
x-ms-traffictypediagnostic: BYAPR04MB5640:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB5640562D75A5F5284D294F8DE7F20@BYAPR04MB5640.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(199004)(189003)(52536014)(6246003)(81166006)(66066001)(68736007)(5660300002)(14454004)(66476007)(66446008)(64756008)(76116006)(229853002)(66946007)(9686003)(53936002)(66556008)(6436002)(91956017)(8676002)(6306002)(55016002)(2501003)(966005)(110136005)(74316002)(81156014)(54906003)(316002)(478600001)(8936002)(7736002)(76176011)(305945005)(53546011)(33656002)(446003)(6506007)(25786009)(4326008)(71190400001)(99286004)(26005)(486006)(71200400001)(102836004)(476003)(7696005)(3846002)(256004)(14444005)(6116002)(2201001)(2906002)(86362001)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5640;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nFXBrIzeQSgayZdsmxYcWie1eLBAbp7eEDTjOA+IYoM5DXmqpLqWWb06cKBDel1lMjhFVmDT2GK3rA+CJpU3B8klAngJBq4mnD2G10fbpMWaLM3DUwMZG0oVw4XS6LOPlSLqGo5BvBH0W0zqkNIjiQ75UOjnkPZ2Q+YhQ1kiCA37pd8AqqTWT57RP3Qhqt21B3FCTNeyJ+HDkbRpQXealNzYHj6dblwb8SnrsIxBHVCr0XmbqfYDFAq1soEeElQKueBj+UpShYdNo4VPpHQLXe926z1pZ+nrvoADyzUqypK1QoqJLLtiqR+O0lE7hun2AgcQRyeEfPMBrHyZFvLp/86wQ+Wydir/TAL8NYKJnvyF3lsV7sWpFtxf6uqtzJuZoRQ2LyO0ut1ibs5J/hFYa0k4xviQkoyYQ3qagJAbzyU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbee893a-8022-41be-c93d-08d7071c3d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 22:56:55.9902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5640
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/07/13 2:10, Viacheslav Dubeyko wrote:=0A=
> On Fri, 2019-07-12 at 12:00 +0900, Damien Le Moal wrote:=0A=
>> zonefs is a very simple file system exposing each zone of a zoned=0A=
>> block device as a file. This is intended to simplify implementation =0A=
> =0A=
> As far as I can see, a zone usually is pretty big in size (for example,=
=0A=
> 256MB). But [1, 2] showed that about 60% of files on a file system=0A=
> volume has size about 4KB - 128KB. Also [3] showed that modern=0A=
> application uses a very complex files' structures that are updated in=0A=
> random order. Moreover, [4] showed that=A090% of all files are not used=
=0A=
> after initial creation, those that are used are normally short-lived,=0A=
> and that if a file is not used in some manner the day after it is=0A=
> created, it will probably never be used; 1% of all files are used=0A=
> daily.=0A=
> =0A=
> It sounds for me that mostly this approach will lead to waste of zones'=
=0A=
> space. Also, the necessity to update data of the same file will be=0A=
> resulted in frequent moving of files' data from one zone to another=0A=
> one. If we are talking about SSDs then it sounds like quick and easy=0A=
> way to kill this device fast.=0A=
> =0A=
> Do you have in mind some special use-case?=0A=
=0A=
As the commit message mentions, zonefs is not a traditional file system by =
any=0A=
mean and much closer to a raw block device access interface than anything e=
lse.=0A=
This is the entire point of this exercise: allow replacing the raw block de=
vice=0A=
accesses with the easier to use file system API. Raw block device access is=
 also=0A=
file API so one could argue that this is nonsense. What I mean here is that=
 by=0A=
abstracting zones with files, the user does not need to do the zone=0A=
configuration discovery with ioctl(BLKREPORTZONES), does not need to do exp=
licit=0A=
zone resets with ioctl(BLKRESETZONE), does not have to "start from one sect=
or=0A=
and write sequentially from there" management for write() calls (i.e. seeks=
),=0A=
etc. This is all replaced with the file abstraction: directory entry list=
=0A=
replace zone information, truncate() replace zone reset, file current posit=
ion=0A=
replaces the application zone write pointer management.=0A=
=0A=
This simplifies implementing support of applications for zoned block device=
s,=0A=
but only in cases where said applications:=0A=
1) Operate with large files=0A=
2) have no or only minimal need for random writes=0A=
=0A=
A perfect match for this as mentioned in the commit message are LSM-tree ba=
sed=0A=
applications such as LevelDB or RocksDB. Other examples, related, include=
=0A=
Bluestore distributed object store which uses RocksDB but still has a bluef=
s=0A=
layer that could be replaced with zonefs.=0A=
=0A=
As an illustration of this, Ting Yao of Huazhong University of Science and=
=0A=
Technology (China) and her team modified LevelDB to work with zonefs. The e=
arly=0A=
prototype code is on github here: https://github.com/PDS-Lab/GearDB/tree/zo=
nefs=0A=
=0A=
LSM-Tree applications typically operate on large files, in the same range a=
s=0A=
zoned block device zone size (e.g. 256 MB or so). While this is generally a=
=0A=
parameter that can be changed, the use of zonefs and zoned block device for=
ces=0A=
using the zone size as the SSTable file maximum size. This can have an impa=
ct on=0A=
the DB performance depending on the device type, but that is another discus=
sion.=0A=
The point here is the code simplifications that zonefs allows.=0A=
=0A=
For more general purpose use cases (small files, lots of random modificatio=
ns),=0A=
we already have the dm-zoned device mapper and f2fs support and we are also=
=0A=
currently working on btrfs support. These solutions are in my opinion more=
=0A=
appropriate than zonefs to address the points you raised.=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
