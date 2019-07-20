Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F81C6EE22
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2019 09:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfGTHPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jul 2019 03:15:32 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53556 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfGTHPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jul 2019 03:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563606932; x=1595142932;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uJ4zyuaWc4smF1VrBKuj3rHJgmNTbz31eRr19/gjvWY=;
  b=ORfl44Yi9LpnIl9kZHvUidYzUVs9zaJTWtqVxgEU9WV/a9BMZewfkZOK
   qtmrpU6Jgfc5t07BmXfNLLaCrtxij8JVfqF5hJKzrrgF34AuimlM+PUkb
   HGxU48dbU5Fyas0IoNh+F7PJ/U49sqKBXvFYIVqxPhTiODPBGRQv7dpqR
   g9xKjuz4jnu7jUAazMxCrSZaj3vrFevwKWRgEUfzXalKSJ42XjWvBbEGe
   bn0Ih0CL6anYWpn1xRzFyq1BZBraadmbIeH5xJoQrDmiUB3zwAFSARoUt
   JD68FHUrxgmNMQaMqVXeSe8VnjG5JO3BFVYTNcIsqhRZ9UjX0ZBf9XYUw
   Q==;
IronPort-SDR: fCeiNLh/iSjw+W4QeBkKD2861ryS7A3poXL+P7WaSg2tlK4jmg4CO0v11mAqqXqKgAACoaTNUd
 QIvbaXvVj/xEIaAHF7nbOxBQiVX+zd9VVN658PNQSNxkIWm1Y3NoF9ajF90cMdaz//gJX8PnjW
 eMj559z3Yf8Ge2FeyR0lL5g1B5+eqoStdmr/vhzrMXi891hgmvs5wGiGyWfJQYnTTUvqsTjY1R
 Pe8kFYumKIonXvmVL8do80S+nYg5ah3Vd1rxvneu35+jA6K/NKzl14O6TzhmnOjMUHVyyAXO5c
 e3A=
X-IronPort-AV: E=Sophos;i="5.64,285,1559491200"; 
   d="scan'208";a="113561529"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2019 15:15:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDqsp1e1HM8kBNzu7QpTLDXfp/ffG0HyDFKFPkjYyhDOMADWMVrXs/4QmcR8rWz5co48HnaHdwnsHNBGnhtaCjSXoN5SLf+QCwyLrSC+ToartzjpBkKtHVBp91G421MNnyT3V7RyZ5BV29JOj+FaXawcU1Ui4vloVAK9XSUc1U356Q3pi2JrKlWnwOpyJWovm4sWM3bKWBVVNPlnUYRSG4HrmHxfI+C3AaM4Z+0CowzdnyUSQ7e5rOumtnP+k5F065xGa3Ft2vtrKfR0a+qJAUbJ7UxRF5DOFo0sJFKbHF5pj18897SV2cVnTxEx2yWgRTwk0/+jZb3dJ4QkSGPJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ4zyuaWc4smF1VrBKuj3rHJgmNTbz31eRr19/gjvWY=;
 b=ZKlRUH6+iJxo/qDZpWNQt/STjbxFI9DP+298yShxSuh5QYTzknYz3c9N5S+pBV/Qka/JmEHVO1jF+xjdyRyaiVWU2hALjaki5R2Zn6TeQ2uY6QfO7jBaKoipZoczeLlyEmb5Cwj4WoXBi8eBTaB0aOeyBmq90/ELeZ/VBXQ3WZGIHloC+UjV3P568o+Ze3A2vAKexK9ruc3MevHDUgxf0HmKNc3z2CNl09FYrMPlHbEmAM7VAZlMOCQtmZSy7EMjJ7t9gR7KGO9cBvHIIsNIspnYUY1ORrJ66V24LmeX8sAOYoiI20Sh5Ue/UX8Oc2sd92s/aKl8yycKUhGYMd10MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ4zyuaWc4smF1VrBKuj3rHJgmNTbz31eRr19/gjvWY=;
 b=OJQXZreo8aeZNmcwuUshUPjPlz2fhlaaifnbOu/IUnTl/T+YamPPTb+tL9uCXAPym52cB9tCVsGFMKpWAKVGjaHAFmeUFEc4SmEBfDqqBsDpA4ixlTAhg3HPmWcrxNfmjBCi+nWF6YyvUesmu2wRcOuAwWGgEg8vXa9OFbiyVNM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB6248.namprd04.prod.outlook.com (20.178.235.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Sat, 20 Jul 2019 07:15:26 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2094.013; Sat, 20 Jul 2019
 07:15:26 +0000
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
Date:   Sat, 20 Jul 2019 07:15:26 +0000
Message-ID: <BYAPR04MB58164A7ACFD3B6331404ECA3E7CA0@BYAPR04MB5816.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: f63b61c3-686d-49ea-4b4f-08d70ce209e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6248;
x-ms-traffictypediagnostic: BYAPR04MB6248:
x-microsoft-antispam-prvs: <BYAPR04MB62481945EF1F8C87A99070F0E7CA0@BYAPR04MB6248.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0104247462
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(189003)(199004)(3846002)(25786009)(6116002)(99286004)(4326008)(6916009)(476003)(446003)(478600001)(2906002)(66066001)(6506007)(53546011)(102836004)(68736007)(7696005)(76176011)(486006)(14454004)(229853002)(33656002)(26005)(186003)(8676002)(53936002)(14444005)(256004)(86362001)(6436002)(5660300002)(66946007)(91956017)(76116006)(55016002)(66556008)(66476007)(64756008)(71200400001)(71190400001)(66446008)(305945005)(74316002)(9686003)(7736002)(8936002)(81166006)(81156014)(54906003)(52536014)(316002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6248;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2WlhD2ZiH82ASLcBb5X3K1EgFH44rhzwYJRP63xMC+sBPcesy6zChvf3Nt9iJSoAk7CdOrdNfV+ytn0Gwo2AW3BGs8cRh8Df7TyBwTjjKVOpy/8QowaE7chxE8BeeDr2V8TVJYkFKKIvWALSvpbvJxP9GZCbi7FljUR/RrYPt9GVXlkLQfrWmXJgUFU95DTdL4VufCtykLCzCK/D+rmH0LUDb32wjMAsqzz1pzPCY4Goebqs/GV/kT5dFYHhiHah7m9/tbzJVscLHYn1jXDx6pznlgIyypa/Eve9LzBNhWTXF3NS77FNWfsp+iV2pILGVz4NWOdM8GntFwvH5wQKuieTN5QQlxEKGXPwGxMFrZSb7OgcZw5/r+btr9pe4Xmckuf3JEuVthlemk9mIMgAbCOJNnArUOOk1xC4Fs/bUbI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63b61c3-686d-49ea-4b4f-08d70ce209e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2019 07:15:26.3011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6248
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff,=0A=
=0A=
On 2019/07/19 23:25, Jeff Moyer wrote:=0A=
> OK, I can see how a file system eases adoption across multiple=0A=
> languages, and may, in some cases, be easier to adopt by applications.=0A=
> However, I'm not a fan of the file system interface for this usage.=0A=
> Once you present a file system, there are certain expectations from=0A=
> users, and this fs breaks most of them.=0A=
=0A=
Your comments got me thinking more about zonefs specifications/features and=
 I am=0A=
now wondering if I am not pushing this too far in terms of simplicity. So h=
ere=0A=
is a new RFC/Question to chew on... While keeping as a target the concept o=
f=0A=
"file =3D=3D zone" or as close to it as possible, what do you think zonefs =
minimal=0A=
feature set should be ?=0A=
=0A=
One idea I have since a while back now is this:=0A=
1) If a zone is unused, do not show a file for it. This means adding a dyna=
mic=0A=
"zone allocation" code and supporting O_CREAT on open, unlink, etc. So have=
 more=0A=
normal file system calls behave as with a normal FS.=0A=
2) Allow file names to be decided by the user instead of using a fixed name=
s.=0A=
Again, have O_CREAT behave as expected=0A=
3) Potentially allow files to grow beyond a single zone, while keeping the =
space=0A=
allocation unit as a zone.=0A=
=0A=
Thinking of our current LevelDB/RocksDB use cases, (1) and (2) would allow =
even=0A=
further simplifying the support code since with these, the SSTable file=0A=
management can essentially stay completely untouched.=0A=
=0A=
(3) is not necessary for LSM-Tree type use cases since typically zones are =
large=0A=
and so aligning SSTables to zones the most efficient approach. However, I c=
an=0A=
see other use cases that would benefit from (3). One example would be=0A=
Surveillance system video recording or any system dealing with high bitrate=
=0A=
Video. E.g. A 256 MB zone size is only 100s of high definition broadcasting=
 (20=0A=
Mbps or so). SO managing storage space in such big chunks is OK with such u=
se cases.=0A=
=0A=
These 3 additional features would make zonefs much closer to a regular FS=
=0A=
behavior while keeping its IO path simple enough to be in par with fast raw=
=0A=
block device accesses. Additional metadata management, completely absent fo=
r=0A=
now, would be needed though. But by not allowing directories (flat namespac=
e),=0A=
this metadata management would be reduced to an inode table and a bitmap fo=
r=0A=
zone use management. Anything beyond these features and I think we would be=
=0A=
better off with a regular file system.=0A=
=0A=
Thoughts ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
