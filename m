Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFAE86ED1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2019 03:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfGTBHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 21:07:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:3831 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbfGTBHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 21:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563584849; x=1595120849;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hvs9TpJN/IgL8iQjVgde25TIHChlpeqVBmu8qMDF+Yk=;
  b=fu397SX5viSg6ghSkYeXgMyqgh+euXzg8y247O23ALrhsHlJX2EB3Wm/
   yhDoRUURjZhho38BzPUenWt+wFkoKp7rTd5zCuZ/8aDBMxD47Wj7BEOng
   Btgrrn1ZL1WvTmG5Ju0UFpUI4lcje/dLN03DJ1yUAZmwOwYuekYgAL9pM
   /vSalAe2RLTFSzRwBqspmAuXaDs0hTJ1WY/dEd4JKf5CU9oJ8YDriUf5D
   Vl/eRAIrlbHWCyzkKQW6zd67XLeg4VJNrJzH7FMGQCbtxm/p55sz3ATQY
   SPTcy0i5VepXpPSUytKHPXTN6fj7CR12W+OZDcBJ/ufXTNJdztfQHWXtP
   Q==;
IronPort-SDR: 40aOzMwhpRnWFCOlu0WApFtb5mWGl33t5rMCtchdRvf0R7rsB0bxZhVaaH20C9mOZvi0lPD6r/
 KaNB7OUZ85bKBbv0EKCfw7sSWym9Rv+VdqlyEWCWNg9aFcboObUfYbj0zl95+WzZUexE1yEMdI
 zcxO0jJao8uBUr3pUzgcC9XQjb/egSsvQLh3VnWpWkQO84ZpWqbtc/eNAO74eUrk3M24j4TdJW
 z/+rTsb9HN61nimbjScsMUDyPXCa5On1T0Z2BdXnL83OhPrrLB5KcbGUV0G1l6I1LEQk1lJpuy
 IbQ=
X-IronPort-AV: E=Sophos;i="5.64,284,1559491200"; 
   d="scan'208";a="115146907"
Received: from mail-dm3nam03lp2054.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.54])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2019 09:07:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9uim/QkdKcjmvrK1I127nA69F0lImaVRlD0U45qI+0k69QKvENjahPcL38elbNguqPrbQpWuKmzQHsq1e7pQ764L9+cn6SnH5YP/B/9QczOPmMWlNiv8QiMubctPwFxqVjKkfK4uP3GE0c18M/XUdHlVHVunWWk/5f1GRFrMLQ8DSeY2wC4W/57v4I8oNGd/aeMSa5t//zfTnyDlSoPmAieFuxF/yMP/TGzDsch6TVBishbJPZyqU5uFfyLROPSTGUJArdnH+5CV6D+XCgA6q8Uo7XcCeinAifMfso2qU5LplBWTx/w4qpmhXh7MovZaZdvyt5i8GbTZcKJbyRK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kpp7lS2MjPOIu7vfAJsdB8F2Tj+k51ebloDV9SsLYyg=;
 b=P5+qtowKlmovvv4KCLJu2PcrrkG5f3Ssp3pP6trVTqTLs+BmAS3FTiUHyuNc9g1Noja7oyKkNI14BVEOMcey0IrYxZoLXnmVyLDAx7KTXh4CEBZw+PYcOT+5yNUjBnDRdHPTU8MZH+aak0G+MpXX12N5q0nuPTLQXOfHVH3/2u9anHjhHhp9ZCwREn/+JrSUMhAEhv9puPID2Kq7sZk5fAeCUYVTWZEKm/fDckG4Ja8ZHLMhCXgEhjxsEio225aKc7OG8q/8dQH5F3G5s9sfV1d37Cf0DppYuh+59u1teQwIiZSBv9ShpQahz3/hnRRtadaUDV0qF7rSW1lQiwUF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kpp7lS2MjPOIu7vfAJsdB8F2Tj+k51ebloDV9SsLYyg=;
 b=Xg62BlX+W6b9PrrfOBU6T8wJkuLIAmkFGm17qHDIqV3xzLIentuQo8qWWLWBP1IkB6ZKyyyuVjZ6ftvPYN1lYP2NGWQDPheNMNBq2u9ZK+g3cQ/LF5MMHoU4tqQBq4VqVEL+4/KQoUN06PDo+zTRwd5QVPXjaR43KeZaFD0oSQ0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5845.namprd04.prod.outlook.com (20.179.59.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Sat, 20 Jul 2019 01:07:25 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2094.013; Sat, 20 Jul 2019
 01:07:25 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jeff Moyer <jmoyer@redhat.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Ting Yao <d201577678@hust.edu.cn>
Subject: Re: [PATCH RFC] fs: New zonefs file system
Thread-Topic: [PATCH RFC] fs: New zonefs file system
Thread-Index: AQHVOF31k+9+55ZdEkmKABdH1mzidg==
Date:   Sat, 20 Jul 2019 01:07:25 +0000
Message-ID: <BYAPR04MB5816A2630B1EBC0696CBEC71E7CA0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
 <x49zhlbe8li.fsf@segfault.boston.devel.redhat.com>
 <BYAPR04MB5816B59932372E2D97330308E7C80@BYAPR04MB5816.namprd04.prod.outlook.com>
 <x49h87iqexz.fsf@segfault.boston.devel.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1943eb3e-4b00-44c3-6ee4-08d70caea0cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5845;
x-ms-traffictypediagnostic: BYAPR04MB5845:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB58457A1DA621CD54AE89F922E7CA0@BYAPR04MB5845.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0104247462
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(14454004)(68736007)(8676002)(8936002)(305945005)(7736002)(54906003)(71190400001)(71200400001)(6436002)(186003)(99286004)(66556008)(66476007)(64756008)(66446008)(476003)(81156014)(81166006)(6306002)(55016002)(2906002)(76116006)(66946007)(91956017)(446003)(9686003)(14444005)(256004)(6916009)(6246003)(966005)(478600001)(66066001)(7696005)(52536014)(53936002)(486006)(76176011)(25786009)(6506007)(4326008)(229853002)(53546011)(3846002)(316002)(6116002)(86362001)(26005)(74316002)(102836004)(33656002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5845;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sffIEWl95e4ERJzmbClrHYiiIPOZwiygoNJztFMelotmISbqlDDUOcNYaR+oB8hveelJuOownKMJkJaoMe2+JttuNr3pYukncimLNjZaaOTet8ZwWRAD7llut0MTAcj3FcameiysQObcotVyRhk2REkisusVXb87i28bRxOavVK+KW6SBLsZj5jOXxodS6Y4jKgnIa/tyAsYeiDUZ33KAa8OvykM+KHifwyJM6XFnmsNuGSySWA98UKdSB4H6ooEi67ocGsfwqpNvV9zWMj8sCPtgRKl/L/yPTWZnQ/A12HDwWOMEyYyPPoztgSpRBaCYaj1ytLYr+lHZ2JSNjTPAj90jl268xQxajuTnVtbilG3vPeNhHhOTS7b8IbAIaSECLAA9kDzS0amFkYjDX0hdZpimqO93chphqRKBz8bIIQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1943eb3e-4b00-44c3-6ee4-08d70caea0cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2019 01:07:25.6294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5845
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/07/19 23:25, Jeff Moyer wrote:=0A=
> Hi, Damien,=0A=
> =0A=
> Thanks for your well-considered response.=0A=
> =0A=
> Damien Le Moal <Damien.LeMoal@wdc.com> writes:=0A=
> =0A=
>> Jeff,=0A=
>>=0A=
>> On 2019/07/18 23:11, Jeff Moyer wrote:=0A=
>>> Hi, Damien,=0A=
>>>=0A=
>>> Did you consider creating a shared library?  I bet that would also=0A=
>>> ease application adoption for the use cases you're interested in, and=
=0A=
>>> would have similar performance.=0A=
>>>=0A=
>>> -Jeff=0A=
>>=0A=
>> Yes, it would, but to a lesser extent since system calls would need to b=
e=0A=
>> replaced with library calls. Earlier work on LevelDB by Ting used the li=
brary=0A=
>> approach with libzbc, not quite a "libzonefs" but close enough. Working =
with=0A=
>> LevelDB code gave me the idea for zonefs. Compared to a library, the add=
ed=0A=
>> benefits are that specific language bindings are not a problem and furth=
er=0A=
>> simplify the code changes needed to support zoned block devices. In the =
case of=0A=
>> LevelDB for instance, C++ is used and file accesses are using streams, w=
hich=0A=
>> makes using a library a little difficult, and necessitates more changes =
just for=0A=
>> the internal application API itself. The needed changes spread beyond th=
e device=0A=
>> access API.=0A=
>>=0A=
>> This is I think the main advantage of this simple in-kernel FS over a li=
brary:=0A=
>> the developer can focus on zone block device specific needs (write seque=
ntial=0A=
>> pattern and garbage collection) and forget about the device access parts=
 as the=0A=
>> standard system calls API can be used.=0A=
> =0A=
> OK, I can see how a file system eases adoption across multiple=0A=
> languages, and may, in some cases, be easier to adopt by applications.=0A=
> However, I'm not a fan of the file system interface for this usage.=0A=
> Once you present a file system, there are certain expectations from=0A=
> users, and this fs breaks most of them.=0A=
=0A=
Yes, that is true. zonefs differs significantly from regular file systems. =
But I=0A=
would argue that breaking the users expectation is OK because that would ha=
ppen=0A=
only and only if the user does not understand the hardware it is dealing wi=
th. I=0A=
still get emails regularly about mkfs.ext4 not working with SMR drives :)=
=0A=
In other words, since kernel 4.10 and exposure of HM SRM HDDs as regular bl=
ock=0A=
device files, we already are in a sense breaking legacy user expectations=
=0A=
regarding the devices under device files... So I am not too worried about t=
his=0A=
point.=0A=
=0A=
If zonefs makes it into the kernel, I probably will be getting more emails =
about=0A=
"it does not work !" until SMR drive users out there understand what they a=
re=0A=
dealing with. We are making a serious effort with documenting everything re=
lated=0A=
to zoned block devices. See https://zonedstorage.io. zonefs, if included in=
 the=0A=
kernel, will be part of that documentation effort. Of note is that this=0A=
documentation is external to the kernel, we still need to increase our=0A=
contribution to the kernel docs for zoned block devices. And we will.=0A=
=0A=
> I'll throw out another suggestion that may or may not work (I haven't=0A=
> given it much thought).  Would it be possible to create a device mapper=
=0A=
> target that would export each zone as a separate block device?  I=0A=
> understand that wouldn't help with the write pointer management, but it=
=0A=
> would allow you to create a single "file" for each zone.=0A=
=0A=
Well, I do not think you need a new device mapper for this. dm-linear suppo=
rts=0A=
zoned block devices and will happily allow mapping a single zone and expose=
 a=0A=
block device file for it. My problem with this approach is that SMR drives =
are=0A=
huge, and getting bigger. A 15 TB drive has 55380 zones of 256 MB. Upcoming=
 20=0A=
TB drives have more than 75000 zones. Using dm-linear or any per-zone devic=
e=0A=
mapper target would create a huge resources pressure as the amount of memor=
y=0A=
alone that would be used per zone would be much higher than with a file sys=
tem=0A=
and the setup would also take far longer to complete compared to zonefs mou=
nt.=0A=
=0A=
>> Another approach I considered is using FUSE, but went for a regular (alb=
eit=0A=
>> simple) in-kernel approach due to performance concerns. While any differ=
ence in=0A=
>> performance for SMR HDDs would probably not be noticeable, performance w=
ould=0A=
>> likely be lower for upcoming NVMe zonenamespace devices compared to the=
=0A=
>> in-kernel approach.=0A=
>>=0A=
>> But granted, most of the arguments I can put forward for an in-kernel FS=
=0A=
>> solution vs a user shared library solution are mostly subjective. I thin=
k though=0A=
>> that having support directly provided by the kernel brings zoned block d=
evices=0A=
>> into the "mainstream storage options" rather than having them perceived =
as=0A=
>> fringe solutions that need additional libraries to work correctly. Zoned=
 block=0A=
>> devices are not going away and may in fact become more mainstream as=0A=
>> implementing higher capacities more and more depends on the sequential w=
rite=0A=
>> interface.=0A=
> =0A=
> A file system like this would further cement in my mind that zoned block=
=0A=
> devices are not maintstream storage options.  I guess this part is=0A=
> highly subjective.  :)=0A=
=0A=
Yes, it is subjective :) Many (even large scale) data centers are already=
=0A=
switching to "all SMR" backend storage, relying on traditional block device=
s=0A=
(SSDs mostly) for active data. For these systems, SMR is a mainstream solut=
ion.=0A=
=0A=
When saying "mainstream", I was referring more to the software needed to us=
e=0A=
these drives rather than the drives as a solution. zonefs allows mapping th=
e=0A=
zone sequential write constraint to a known concept: file append write. And=
 in=0A=
this sense, I think we can consider zonefs as progress.=0A=
=0A=
Ideally, I would not bother with this at all and point people to Btrtfs (wo=
rk in=0A=
progress) or XFS (next in the pipeline) for using an FS on zoned block devi=
ces.=0A=
But there is definitely a tendency for many distributed applications to try=
 to=0A=
do without any file system at all (Ceph -> Bluestore is one example). And a=
s=0A=
mentioned before, some other use cases where a fully POSIX compliant file s=
ystem=0A=
is not really necessary at all (LevelDB, RocksDB). zonefs fits in the middl=
e=0A=
ground here between removing the normal file system and going to raw block=
=0A=
device. Bluestore has "bluefs" underneath rocksdb after all. One cannot rea=
lly=0A=
never go directly raw block device and in most cases some level of abstract=
ion=0A=
(space management) is needed. That is where zonefs fits.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
