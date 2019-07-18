Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 327386D705
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 01:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391700AbfGRXDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 19:03:01 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11611 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbfGRXDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563490980; x=1595026980;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ock0+kbA/AdU6ryh9QeT0HyVvIfkPCXilFpp7F+Vzog=;
  b=KEk2qk4KvN/H6fXjO/EcESdqDHOG7Ri2S7BHBL40zPRAnZp30w9jdCAB
   1ZbvFsA+QPh2oJl6cCrYzM6nzOuFR3xxoY2mazOGJG7dZWBJ0zuBACYoB
   Grzrd2NmiZVMdRKXi3wpGedoYR9XFOX2iQzw9CxO2emFg5tHr5hqKqe8w
   l7lfBmz3zq5DMtCziSmIuyZ/JtmcpS9zCdr5X18YISca2Qlf5UmuR1Ibv
   7bNexiPw+V0xSsqKhSR/0rTq5DcXNICgZhavOzaW6VZ8tcHQW+z8VC2Ug
   HRYsPumSa/llUlsq8P+s+XRa3KSjP318OOO48n0LtccPPS80EMo55jkXJ
   w==;
IronPort-SDR: AkRNWGFeLOTIfPS/VZgVhsnsNxsTwB4K4CuIElViHdaPmHxcxfACq4F3Y2THUzXbpLGaAyLT2q
 OhFCDHERYmjflPw825eyMUn3nfGVPiNz1wHAqy/XbTfqUL2KjRI+xpn6wCVeTJdB/CpBoawe0n
 srnAIl82eXNuqm71cj8avyhxug0wuvM8eFv9OqJxfHTuePrZAVc3N/R43UTcSiSLOr4gT0J8Cv
 iZdAN5gPEx+aRHBgIYzs6FOvUchPJbn3nZBGMkXWVllVTmfmSwFkOa3BZROHdnlP9oxV/E91Wi
 uvk=
X-IronPort-AV: E=Sophos;i="5.64,279,1559491200"; 
   d="scan'208";a="219875140"
Received: from mail-by2nam03lp2056.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.56])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2019 07:02:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEtzcHLbAlxLg0Z9zv/+629lsao7v6Fi3Js1SevpvTjDjWCUQrpwU8R3Zj5O7WjV6h0iW+MUYOj4FjsRUuXGnyJi0X2mFHRyI6sYVnDSb4yjstE4/E1Q/O/mbpYZeMV3EDJT7VN/ZyT3w9ec4SDZ/M5EFt0tb+Xg2cVry4RDDd61IinPZYG3TrY5git5rsXXvUne9l+uSR8STCvIHQl9eXjYvHtgMPiL+wI3zQ9dWw4sTeYsU7AgIZ/tahw/prCC9a0TChdmzMh7hYwGFPft4MlVl2pFCqMxK9tlK27+j7M3uh5GkJbi3dt+iumyuRML22QD0bpjcE3wZcy+ozlPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2jdTyYxz5U3ISxCWcKbN5anLdLDjOGm9Pqo9/1OGSM=;
 b=DPELpb1yS9cpBJxBqC4cVI3bm2bWFmJ1qgrRqcE2aHV6ilp6q2ODVq9naRlVLoLChd/PD2OjwufQWdffPAvcMEPzALJ06fqTKQjQ4lyfPSpYahYhXUoiGXJDdeByPqLxwSgXG65A1d7iwcqvjyvK1i2D8Dmbn4wv69d6tBSuiQ1/aJHfiSoirmEcFBRj2WqRhjFb/wE8+H0qc647+gsGvnm0QOxaA9O9ZPjG4DibgYFC4dnRxReod53nDSTztg9sh8jiPkWcNJsKeFtu9MvTbQMTDh80zCGulIJuND/6P8icjuPEIGcM4t1YrXreq870C4VNyHd+kIogly0pw0ChNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2jdTyYxz5U3ISxCWcKbN5anLdLDjOGm9Pqo9/1OGSM=;
 b=i717TmK3N4u6jk5AyKfT2tokQnV13upMsvtYtxU/msVjRvxKtQBZsLiXULvldgXZwOGK7ussRXMcEkm2ETyNnPpauRyg4jLQxunYjvV9RmWWV5er+tpVcsgULCfwAEWfeEUWAjxncpmaHpFfNebFzOsOFYrhh+S4KbzQ1kAgv7w=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB6038.namprd04.prod.outlook.com (20.178.233.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.12; Thu, 18 Jul 2019 23:02:43 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 23:02:43 +0000
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
Date:   Thu, 18 Jul 2019 23:02:43 +0000
Message-ID: <BYAPR04MB5816B59932372E2D97330308E7C80@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
 <x49zhlbe8li.fsf@segfault.boston.devel.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08a2ac96-dc73-494f-9375-08d70bd40abd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6038;
x-ms-traffictypediagnostic: BYAPR04MB6038:
x-microsoft-antispam-prvs: <BYAPR04MB60386885888F57CB8AE548E5E7C80@BYAPR04MB6038.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(6436002)(2906002)(478600001)(6246003)(71190400001)(71200400001)(52536014)(66946007)(74316002)(8676002)(66476007)(25786009)(81166006)(81156014)(76116006)(91956017)(86362001)(14454004)(66446008)(64756008)(66556008)(8936002)(256004)(14444005)(4326008)(3846002)(6116002)(53546011)(26005)(54906003)(316002)(9686003)(99286004)(446003)(33656002)(68736007)(53936002)(186003)(229853002)(102836004)(486006)(6506007)(7696005)(5660300002)(7736002)(6916009)(66066001)(476003)(55016002)(305945005)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6038;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: drzx3/6DWkgzds8rswmkSSl4/j3iUT0XLZ48+PfkbtDm6nai0e1IU2gV/oGfvIJl2aB6ZVOaNFBQfcYguOlptyToi/1Cw8CxvZbil0/7h+axokPAJejLNO4PnLaqKZdLOb6EEedo6g8NBnmmP5Yi0iHvg3qxtgRMnwNTlFNeAWi1Fm2B/Hh94q9BSwagh2TCl6o4jLElumfkgU+esc9LcB/oHxMsE+yUBS5KFP1DNeAmxHL8h7FcAJ14oH16vtcISyP+Y0NCdYNBjUw6C7TbxIM/cJ1kXAPuUPB+aFeaG7ydZ0jDuHwPneYtvEiiUr5LnOF9v7+qTsYOT79SORWS2cuL8i9POn+Gn1pzbOSaljeLYp+5wSYN8oki6MOiQUk6nOdIvFM6eVfz8Jt4CkzplHEVyMvCKFLrX07/9gtS2I4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a2ac96-dc73-494f-9375-08d70bd40abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 23:02:43.5983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6038
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff,=0A=
=0A=
On 2019/07/18 23:11, Jeff Moyer wrote:=0A=
> Hi, Damien,=0A=
> =0A=
> Did you consider creating a shared library?  I bet that would also=0A=
> ease application adoption for the use cases you're interested in, and=0A=
> would have similar performance.=0A=
> =0A=
> -Jeff=0A=
=0A=
Yes, it would, but to a lesser extent since system calls would need to be=
=0A=
replaced with library calls. Earlier work on LevelDB by Ting used the libra=
ry=0A=
approach with libzbc, not quite a "libzonefs" but close enough. Working wit=
h=0A=
LevelDB code gave me the idea for zonefs. Compared to a library, the added=
=0A=
benefits are that specific language bindings are not a problem and further=
=0A=
simplify the code changes needed to support zoned block devices. In the cas=
e of=0A=
LevelDB for instance, C++ is used and file accesses are using streams, whic=
h=0A=
makes using a library a little difficult, and necessitates more changes jus=
t for=0A=
the internal application API itself. The needed changes spread beyond the d=
evice=0A=
access API.=0A=
=0A=
This is I think the main advantage of this simple in-kernel FS over a libra=
ry:=0A=
the developer can focus on zone block device specific needs (write sequenti=
al=0A=
pattern and garbage collection) and forget about the device access parts as=
 the=0A=
standard system calls API can be used.=0A=
=0A=
Another approach I considered is using FUSE, but went for a regular (albeit=
=0A=
simple) in-kernel approach due to performance concerns. While any differenc=
e in=0A=
performance for SMR HDDs would probably not be noticeable, performance woul=
d=0A=
likely be lower for upcoming NVMe zonenamespace devices compared to the=0A=
in-kernel approach.=0A=
=0A=
But granted, most of the arguments I can put forward for an in-kernel FS=0A=
solution vs a user shared library solution are mostly subjective. I think t=
hough=0A=
that having support directly provided by the kernel brings zoned block devi=
ces=0A=
into the "mainstream storage options" rather than having them perceived as=
=0A=
fringe solutions that need additional libraries to work correctly. Zoned bl=
ock=0A=
devices are not going away and may in fact become more mainstream as=0A=
implementing higher capacities more and more depends on the sequential writ=
e=0A=
interface.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
