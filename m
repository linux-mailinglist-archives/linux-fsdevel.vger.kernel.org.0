Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 249FD69F99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 01:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbfGOXx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 19:53:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52460 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731359AbfGOXx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 19:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563234806; x=1594770806;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=B513hqxlwnv30JRUucMdWAVn82DvB39BEfWCW3Ktpz4=;
  b=HpnqOjIruYa0AiE+dKVr9FH1WO80MuEth9uIWOt6Y6dN0weEU5W0r75l
   r3jz95OWNgacb96bD4G0QoyNXqS9r+G54EHpJQHbBQAbf5yLRBPDWE+qt
   j5bteDacCnQpdxdsAhUqpfYRAw6UlYcBIZ1OJkFy3OXFkKa40m+T+0Lmx
   fS3E1wpsVGzgRKwl8ryQ5aOt+gbPHeqsKReXgKkqYEAc1lNfaMS0S5Glc
   cXyRphngC5WDDsZCYAwgHzHrcPEiYmfpLUd74x8VKhYQALvy+wx6VLGCD
   vbfdaAX2Fx6ifZcNuMxQg/HerVip1+sSCHA1+rI0azoncsRoEpt1Zvf8i
   g==;
IronPort-SDR: 5LiRR+jMDG8hlirxYsgO46+ezpeaGzM0FbaQLFNMf02zZ0UZJrHmfpdRG4P20YdX9YRuXJ0US8
 80HYTawB60LyKcedTeOoYmNWYA1pGZupBwDO6hL0aDMGjE2p9FGdLTtmR+n77g459CrWTToQCm
 fMK42p2wEUD/MrcdKhPSvsEzkd0K1c/8UES77KQZVzmaMyg5PP/PZ+mqjpKVGvzePYzEe5eGo7
 PvzZtWLaRhINVet66OHr1MUepsquo3Rkj+n/6AtUZOOYwYLoZy5Hy3o+F14ayQZihYWYcHUfRx
 J10=
X-IronPort-AV: E=Sophos;i="5.63,494,1557158400"; 
   d="scan'208";a="114256764"
Received: from mail-dm3nam05lp2057.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.57])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2019 07:53:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4HPvp/7YAjYZD0gcrkfm5+yrY8SBA/Xw+NuT9/sBj1mnGLmYFQJD9odHlL2sWf6h+6j/ZCTypuqEcAiUtZF5yW4sYj693GhxN9Geuad5uWlygiAnmbg44TSk7t8bLeGtPxI3XvifIqAHHAnWU5T1KxZitEVz+Z0nTEzC0eByYlY5CMzQ8l6BGSKTtiax/tCt3KTbHDHXUYluYSfHCnPk6VJgoWKJUNy4pOBRCqO900Ybg328ojQcT1nc79DKqHyEL4c17OuX8rrrEg6950I6RZPpD+h/tjYsH1gCUTvYu5QtDEL4oBOrggxghRrkMYZksUIFOXBPWfpKIqHTMWhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B513hqxlwnv30JRUucMdWAVn82DvB39BEfWCW3Ktpz4=;
 b=fURRSvOJEp0T7jmujqskm8spRPx1ok1ObHSj4I0p8SsLMKbJL8a9Q5DPKcofCzF9c/1fj0NT2YIo2sr1mZYVa2ARKCChxNI2WywFrLbXDGW3Z4dZqhJpSf9w1KV8JK1TpN02D8GtdRlb30fdZZIZWKb+I3BKI0HM02njlt8jHmg1IOjxxMjcfIxZenZxbGf5nB5nSXSq3k6q4QvK62MK2D+wrJHAgzO/jKMNprXUs3cwFOyUuox4WI7wuUzfisvGHLs5Lzq1J4POsz1dacbqry6j0TeXiTAOo0jw+vmVMDTH7oRHScmV5GhPp1gg1t9uBaWtBnYiglyDahjimrF/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B513hqxlwnv30JRUucMdWAVn82DvB39BEfWCW3Ktpz4=;
 b=lGmiT/P1CQvZGgtrmtF7DzZf9gqyNfEvIx6AHERu4xc6aWcKeXdVT7ga+9hrqUGuK6dZ0ibyQHnl2PV4ad0IOcI0QYwrfXlDAiSz/ZnYMHZfkFyBZ1VUAxuKn/TRGPp01Q7cLuqlu6DvQb9fX3KbAR0L71j/oq2IGvcLXDR7sEU=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5686.namprd04.prod.outlook.com (20.179.57.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.13; Mon, 15 Jul 2019 23:53:23 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 23:53:23 +0000
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
Date:   Mon, 15 Jul 2019 23:53:23 +0000
Message-ID: <BYAPR04MB58168662947D0573419EAD0FE7CF0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
 <1562951415.2741.18.camel@dubeyko.com>
 <BYAPR04MB5816F3DE20A3C82B82192B94E7F20@BYAPR04MB5816.namprd04.prod.outlook.com>
 <1563209654.2741.39.camel@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 921c6726-cccb-4075-bd5b-08d7097f9f48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5686;
x-ms-traffictypediagnostic: BYAPR04MB5686:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB5686EF3788B7287980EA7539E7CF0@BYAPR04MB5686.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(6116002)(966005)(25786009)(478600001)(3846002)(102836004)(86362001)(71190400001)(8676002)(8936002)(6436002)(68736007)(2201001)(66556008)(53546011)(6506007)(14454004)(74316002)(186003)(33656002)(26005)(476003)(446003)(305945005)(76176011)(54906003)(7696005)(2906002)(76116006)(229853002)(256004)(53936002)(9686003)(52536014)(7736002)(14444005)(66446008)(316002)(2501003)(4326008)(110136005)(6246003)(66946007)(5660300002)(71200400001)(64756008)(486006)(66066001)(6306002)(99286004)(55016002)(91956017)(66476007)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5686;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QeFkvGzC95+b/KLxlERnzYpUp0ElZBhf3b8gc/w/T2w2oMU2VW88wIJxfjKdfRHDgAmzoqL2rKvmNzuYV0I6AMJeDXXICzgrO6uPk5Dc8RlyzWKMzLQbMTYTQtrJQ0FZ1vic3Mv20v5rj0D5uCjE0UvAMf2Lvis04FsYy5HEQUvtU29s7Nal9gPqHEYCYJm9v5cgZo69IRyfwMlihweb2fZtnBB3JbG6EB9s7Fw5rReY6Kj4LQkQTPwePfQCdNf3ypFDzzja8okpLpRlH7uIqxG//JlsGdZQni7gmImXNg3PMjCyr3qwDKrrO1wHIhtHUdj9d6q7+94/y5ytv12lgcTBiekDCi2z3hNlv+rvia2bBsVpMRG5VSyPjRNDYNOcixiG9GNPhy2/FCgBbyxsMogkocVJ386TsYseiXNIpxQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921c6726-cccb-4075-bd5b-08d7097f9f48
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 23:53:23.1277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5686
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/07/16 1:54, Viacheslav Dubeyko wrote:=0A=
[...]=0A=
>>> Do you have in mind some special use-case?=0A=
>> As the commit message mentions, zonefs is not a traditional file=0A=
>> system by any=0A=
>> mean and much closer to a raw block device access interface than=0A=
>> anything else.=0A=
>> This is the entire point of this exercise: allow replacing the raw=0A=
>> block device=0A=
>> accesses with the easier to use file system API. Raw block device=0A=
>> access is also=0A=
>> file API so one could argue that this is nonsense. What I mean here=0A=
>> is that by=0A=
>> abstracting zones with files, the user does not need to do the zone=0A=
>> configuration discovery with ioctl(BLKREPORTZONES), does not need to=0A=
>> do explicit=0A=
>> zone resets with ioctl(BLKRESETZONE), does not have to "start from=0A=
>> one sector=0A=
>> and write sequentially from there" management for write() calls (i.e.=0A=
>> seeks),=0A=
>> etc. This is all replaced with the file abstraction: directory entry=0A=
>> list=0A=
>> replace zone information, truncate() replace zone reset, file current=0A=
>> position=0A=
>> replaces the application zone write pointer management.=0A=
>>=0A=
>> This simplifies implementing support of applications for zoned block=0A=
>> devices,=0A=
>> but only in cases where said applications:=0A=
>> 1) Operate with large files=0A=
>> 2) have no or only minimal need for random writes=0A=
>>=0A=
>> A perfect match for this as mentioned in the commit message are LSM-=0A=
>> tree based=0A=
>> applications such as LevelDB or RocksDB. Other examples, related,=0A=
>> include=0A=
>> Bluestore distributed object store which uses RocksDB but still has a=0A=
>> bluefs=0A=
>> layer that could be replaced with zonefs.=0A=
>>=0A=
>> As an illustration of this, Ting Yao of Huazhong University of=0A=
>> Science and=0A=
>> Technology (China) and her team modified LevelDB to work with zonefs.=0A=
>> The early=0A=
>> prototype code is on github here: https://github.com/PDS-Lab/GearDB/t=0A=
>> ree/zonefs=0A=
>>=0A=
>> LSM-Tree applications typically operate on large files, in the same=0A=
>> range as=0A=
>> zoned block device zone size (e.g. 256 MB or so). While this is=0A=
>> generally a=0A=
>> parameter that can be changed, the use of zonefs and zoned block=0A=
>> device forces=0A=
>> using the zone size as the SSTable file maximum size. This can have=0A=
>> an impact on=0A=
>> the DB performance depending on the device type, but that is another=0A=
>> discussion.=0A=
>> The point here is the code simplifications that zonefs allows.=0A=
>>=0A=
>> For more general purpose use cases (small files, lots of random=0A=
>> modifications),=0A=
>> we already have the dm-zoned device mapper and f2fs support and we=0A=
>> are also=0A=
>> currently working on btrfs support. These solutions are in my opinion=0A=
>> more=0A=
>> appropriate than zonefs to address the points you raised.=0A=
>>=0A=
> =0A=
> Sounds pretty reasonable. But I still have two worries.=0A=
> =0A=
> First of all, even modest file system could contain about 100K files on=
=0A=
> a volume. So, if our zone is 256 MB then we need in 24 TB storage=0A=
> device for 100K files. Even if we consider some special use-case of=0A=
> database, for example, then it's pretty easy to imagine the creation a=0A=
> lot of files. So, are we ready to provide such huge storage devices=0A=
> (especially, for the case of SSDs)?=0A=
=0A=
The small file use case you are describing is not zonefs target use case. I=
t=0A=
does not make any sense to discuss small files in the context of zonefs. If=
=0A=
small file is the use case needed for an application, then a "normal" file=
=0A=
system should be use such as f2fs or btrfs (zoned block device support is b=
eing=0A=
worked on, see patches posted on btrfs list).=0A=
=0A=
As mentioned previously, zonefs goal is to represent zones of a zoned block=
=0A=
device with files, thus providing a simple abstraction one file =3D=3D one =
zone and=0A=
simplifying application implementation. And this means that the only sensib=
le=0A=
use case for zonefs is applications using large container like files. LSM-t=
ree=0A=
based applications being a very good match in this respect.=0A=
=0A=
> Secondly, the allocation scheme is too simplified for my taste and it=0A=
> could create a significant fragmentation of a volume. Again, 256 MB is=0A=
> pretty big size. So, I assume that, mostly, it will be allocated only=0A=
> one zone at first for a created file. If file grows then it means that=0A=
> it will need to allocate the two contigous zones and to move the file's=
=0A=
> content. Finally, it sounds for me that it is possible to create a lot=0A=
> of holes and to achieve the volume state when it exists a lot of free=0A=
> space but files will be unable to grow and it will be impossible to add=
=0A=
> a new data on the volume. Have you made an estimation of the suggested=0A=
> allocation scheme?=0A=
=0A=
What do you mean allocation scheme ? There is none ! one file =3D=3D one zo=
ne and=0A=
all files are fully provisioned and allocated on mount. zonefs does not all=
ow=0A=
the creation of files and there is no dynamic "block allocation". Again, pl=
ease=0A=
do not consider zonefs as a normal file system. It is closer to a raw block=
=0A=
device interface than to a fully featured file system.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
