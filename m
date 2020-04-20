Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7F1AFF36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 02:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDTAgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 20:36:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:40383 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgDTAgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 20:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587342994; x=1618878994;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NHoxqvu6ARrJTpTrHlhN44HoEeP3h9rMOV1ueAFOWXA=;
  b=ZcHPfttkf1/IrHl0pXaEaSIGzqSMu+vPoNYZmU4FEkeevLCALrcsQ73t
   b25SILfN1OL2LMareWP0Lcaa1aiwzNimU58oVH0kGMORqK35aCM/qMnR6
   5j/iKRgOmW8EPL1N+WxdxCuek+VrX1e0HmX5CPRqkMcK0w6GiJ1rvDi9x
   9FKwfWdvU2/OGXS0ps32+KGNjq7HGV4HC5roP4Cs9JkpixKI1FI2tjEgH
   6p1kDU4YLRF9vrP/FZmEK6KwxESunef8Vas5tvywGV/kKLj0w6S6wl7Yq
   TcpvD5l/dhNmYSJfZPB9WY9fmFEaQ9d3vaJ7XwNIPGfAN2ulPdKPg90ax
   A==;
IronPort-SDR: CUDFUsD5HdvqwcJDCAcXXZ1kskZ/M0wmNmGmqQ23OQYFBqQEUYn0KB2f5CF0eUT8IkDe5zbepj
 DV6Mm4ad7TEsukqHw4OQfu0Pl8rIPdZjBA6K6iXdHDfx4YHOlHpNOpP3IN/wtyg68M7OPhw5u/
 Z6zybwoY1KEGFcxmlf6uFgoH5DKJ3churphIpT6KEaC3/xgqcOd2pYe1qahb7ZFt7oYw1Lg3Ku
 z55npCfQab44TRJE4qgGWbh4v4VNhgmNY1DCv4vF3i0zC9kkaVVzrAwPHEUIh0MozUaOQZnwbF
 DFM=
X-IronPort-AV: E=Sophos;i="5.72,405,1580745600"; 
   d="scan'208";a="135670300"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 08:36:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYVZjHn0oJl30tQ+KxHiRHuEardPu7r7uM58xgZCeaaTCsq/1QZqM9Hx083Qg+WtJK7dC/moer7lGcgW168UyFkXSgw0/6ISGEt7SaZ0KaTndoopoXQxqfBGsojUG+WuIeIWrUeTtGw2v4xp3wkT9w4EJfxEie3yP0ljNffZ+Nl5MuYB/IqSGOwDUc4QZwZ2osjpBcAQonIUA8GtYMUvH2h8NE0IvX7NKSaJgH92LTXwDnAk5S410gAh3dgIqKEBSUjmlGAsP2noog04pGMw+ydeEYGn2h6dHWlm/OREnoI2ZgP8txzdtlVZiCAMRqz0UdDbUgxnBnDp/PyZeX3SSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHoxqvu6ARrJTpTrHlhN44HoEeP3h9rMOV1ueAFOWXA=;
 b=UVVTV2GThJJ0577srxbxTHNi/28LKSgB28tFTuI9Z9BqMPsZNnVYdDPq/C6i0kF30qNTvfR63r76D0QHzHCxAh/wmJmB3noooA7gIdW3Q1kiAVq3Sy53QyWtjeoKhASybXe+GyoG/kF0zviUdZk9N27d33mdWf7oN5XjPtmMsSoQltEjeWusHJQHhztkKKDTY40rQRgx+b/QPqZfaaIQVvHf8ZO/VcaPgS+lle2a14Uw+gKqhuOZae+VKOajkGbzhU27Osfs7KMV/Xx+SKs1SBW/5soK8b+ov8k5cU8lfQnFrqPWlo8x1Oy17zO0sUjjX2n0CGzbvjYbFR7Dxy5EGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHoxqvu6ARrJTpTrHlhN44HoEeP3h9rMOV1ueAFOWXA=;
 b=os81D9eEV2JCvFJuBA6LIMozSAjVRc+Xx0DAMakvW09HI+dDwjarjEh/GrZoV9fxm2+vBlaLOoWAYtTPFJeDYX6JXYxK4AEDl9gwsHIbgQBqIKMGLKAnmL/dSiGywCuizAV5f/gGZs/KV4YF/vSv6XuuKOPslVoSjB8aXSLQJkM=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6817.namprd04.prod.outlook.com (2603:10b6:a03:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Mon, 20 Apr
 2020 00:36:31 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 00:36:31 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v7 11/11] zonefs: use REQ_OP_ZONE_APPEND for sync DIO
Thread-Topic: [PATCH v7 11/11] zonefs: use REQ_OP_ZONE_APPEND for sync DIO
Thread-Index: AQHWFLH/oha8bCji8kajTN1HdQMUaQ==
Date:   Mon, 20 Apr 2020 00:36:31 +0000
Message-ID: <BY5PR04MB6900950CE84F2EC9593CFC6DE7D40@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417121536.5393-12-johannes.thumshirn@wdc.com>
 <8d7c021f-d518-b6e4-7308-daaf9a1c7992@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ca82c3f-3d1a-4fd5-8f1c-08d7e4c2df5f
x-ms-traffictypediagnostic: BY5PR04MB6817:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6817440319E6DEF05A8D5897E7D40@BY5PR04MB6817.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(53546011)(26005)(71200400001)(110136005)(7696005)(54906003)(33656002)(316002)(76116006)(66446008)(52536014)(66556008)(186003)(9686003)(64756008)(4326008)(6506007)(55016002)(66476007)(66946007)(478600001)(81156014)(8676002)(7416002)(8936002)(86362001)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLoORsZcuc7zzPWinG8uTaJsuQrWg9gc3PFLyXkJ67JufoiEKL9DjhQlXZstYjriVT8PtXjOJUghcHNM72wxpnkWRk3QPAhUnxLzAm8lpTnorhsB24N/OippiPHKm8SVUdgPqUZMQFDU30mrBzBz7ZGgyj1H1DiNRJQQMiuKrqoJw6wthE7YyieGDjI4PwuKU6LPYP4sfhQ9wcz3ISM3F4xnCNmIRexMHzJRJa3QqNjOVVEVGsbiH+9Pa6x9zmpKE3/SZGk4qlWEQkK2W9JGmTQ+kz/u49JzXYHP5fxr82qGsQYZjLD5AqNX5j10X3EZdED04vb2ja20+2NfVmlgLlICGZkYiQekpZ0wXx0YxlD2ffaDJPYxbmhgWC5+t4Damq6or/7IL2YVkLw6wzVjg7bHcOUnNjjy4bFsgwjHXhzVwTYoNdsc9Db8Rqun/iA2
x-ms-exchange-antispam-messagedata: KV1UtkqV6091I8hcwl494zmBGRDh1PGIrq5Z7Os1glocxJt6X2ZCxBZbaNYKc60l1zl4PWjAmBh6I1ur7VmosRInxvSqJJf4zXl3FW0nRzO7bzK6IWK0gnXZroxqeq2qdsbhCzNitehE/RECnfjLbg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca82c3f-3d1a-4fd5-8f1c-08d7e4c2df5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 00:36:31.6991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlAKh34MOZGFj/mNBCpQ8+4HTJ11xR05jhnt3eSC8rL+wY2jee6pyOf/Gy+I1SLQqSxI9jQssAXSNaWc+tDkIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6817
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/19 6:45, Bart Van Assche wrote:=0A=
> On 4/17/20 5:15 AM, Johannes Thumshirn wrote:=0A=
>> Synchronous direct I/O to a sequential write only zone can be issued usi=
ng=0A=
>> the new REQ_OP_ZONE_APPEND request operation. As dispatching multiple=0A=
>> BIOs can potentially result in reordering, we cannot support asynchronou=
s=0A=
>> IO via this interface.=0A=
>>=0A=
>> We also can only dispatch up to queue_max_zone_append_sectors() via the=
=0A=
>> new zone-append method and have to return a short write back to user-spa=
ce=0A=
>> in case an IO larger than queue_max_zone_append_sectors() has been issue=
d.=0A=
> =0A=
> Is this patch the only patch that adds a user space interface through =0A=
> which REQ_OP_ZONE_APPEND operations can be submitted? Has it been =0A=
> considered to make it possible to submit REQ_OP_ZONE_APPEND operations =
=0A=
> through the asynchronous I/O mechanism?=0A=
=0A=
Yes, we have looked into it. We do have some hack-ish code working for that=
. For=0A=
the initial feature post though, we didn't want to add that part to facilit=
ate=0A=
reviews and also because we need more work to cleanly handle zone append in=
 the=0A=
aio code (that code is written assuming that BIOs can always be split and s=
o=0A=
never returns short writes).=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
