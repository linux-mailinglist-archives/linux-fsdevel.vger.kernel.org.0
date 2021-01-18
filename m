Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913212FADDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 00:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbhARXxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 18:53:21 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16639 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732553AbhARXxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 18:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611013999; x=1642549999;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=stTU6vT+J5fIrfG70/m/yVWU6xkxGGUCjYq1ClW50HU=;
  b=Z1HiGtYNo6f9CTJ37Hmz9G/sFaVjx7P9BJwrEhY1BQVRY+a9mTMWGk4S
   Eq/vo+U8tJ5bCnMAkVCj0qWhCXGHYDO+03yU0IfrepP9ZpAYudOPg45JH
   JHCD3b+AGttW0tNxAFkyUQ72QiedlKlrTrbaa0JGEl1Orfrge5WMg8dQI
   bPi/UaYdTQ/Q0f0gbgjXL/i/1UC/fsj7jOyZa7PmkU/eGCGT3yA0v/vwK
   Hk75B/O6Cd964BqlRkfoYI5fCQXggCOrqq9dCNX0GeRYzb8+ITd6kHl1r
   t+23lTdyxGJdys+yS253R+E8+wxHFQyDO4720fjVXVL33Uwz0oHVDCxU9
   A==;
IronPort-SDR: gCL3kMFCTNRRZni558Ep3u1YaCFV2qPaMGUivuqxwV0kJ/NPKZbJAIG4CTCYPCOp/V167uhDTN
 NP8cr7EZR+BqOTU/Q9jP/RHOR0F0USbwfdwFURKaKg1hJ6vKXshmYnf2HwYc2QQzxrbDPAoJaW
 zr7ozgxFJnY/4W7OESc3AC4JDZrKlXtde0vG4C3OLnutOuLDEmpJKpafKMSBIqNP5ERtA4I+Cp
 jocdsp3x7wGakkVhb3HCL6fXFDgs8NhQSVog1kGiDy9KoRDZHSimjjjBdkzkwT/fCXAwGe9lsv
 8CU=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="268059931"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 07:52:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InBdQLGSCAIFVN3PEYJyv0a+FuduqPQvV+fN3JMcwLxVBq7h8cyrP5Hrzn4y2avmjQXsjbN4MJoHAB/PDHzDl0pgs1brtmZz0E09ZjF82u5GdHM0vxBbwuaDVVL8knhUurnHRPNVOUqh1RTlm/Bl67sI5kidkYok4a/4iUN5K4XD0Fls6+/ilTfaDPlYEdkL5lRkDx7bKtPr5LsOhuStEiz18PHhOLrhvtA6RhnF7s5XCs1xtyJHMYkFT5/Z75ds90P3eBFsgSc4aBISjk5TZjHNCRykkss/+2w39dqNoQcNDCHCiJh45tao/NhlNXDPs2VJ79EATzkvgTlUTZs/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCItTiH0/+8py7xDfgYQwp26pBvt6CMJwg2CZR0+dRU=;
 b=BORvtwo6mavt5zJ8gK1Fk9nUD2GN9ztHNjALEzDi1+do+ssi0viV4Loqu5wPuUpboiIJRx0Dw1Ivud80Ufg/yEo0KVWBdYQr7VFoXP8EdtZRkMIqqUWt1pfdOTHqm63je0lHkI3FWRzofNlIaFcBFLFirAYJNdNX2YRpcf8fvSEi0YNL+1OpNG5Qk6dM8MmPbCidUzF0dkWacotXlXLecZXgQ1sT3D8nvz49ClSD0SpPXjRmh2R6yRhT8riXyzuMYg4Hs7Te9ap6l8qbT34Z8U9n+21wmuz7abwJLIK76RnDVj54jopg5hGPbYg8Rlaz9DdCzfuEaZcgGcEldbPK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCItTiH0/+8py7xDfgYQwp26pBvt6CMJwg2CZR0+dRU=;
 b=q85KuM0Vt6tNWJEZ822ben5GL2q8KKju5kkJshciO09Vhgu1O5/lBkxct9P4E8F1xrmeFTxARzUKvAVt6Gi4eAMW9wq+ZX5kR96ZpHrh9A0OS2Z8r3jykbIYsp0WjUMPlmX40/wBwWBtXeLztJImWNa9hoo3R1myhSIEcW9aeMU=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4532.namprd04.prod.outlook.com (2603:10b6:208:4f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Mon, 18 Jan
 2021 23:52:10 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 23:52:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        'Jens Axboe ' <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] block: Add bio_limit
Thread-Topic: [PATCH] block: Add bio_limit
Thread-Index: AQHW6q5ic5cEsC3uN0OcO1GSc7nleQ==
Date:   Mon, 18 Jan 2021 23:52:10 +0000
Message-ID: <BL0PR04MB6514A4BFE2EA5AE59795E586E7A40@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210114194706.1905866-1-willy@infradead.org>
 <20210118181338.GA11002@lst.de>
 <20210118181712.GC2260413@casper.infradead.org>
 <20210118183113.GA11473@lst.de>
 <20210118192048.GF2260413@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:65ee:945c:c1cd:2690]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fcd12de7-5754-42b0-ef2c-08d8bc0c1210
x-ms-traffictypediagnostic: BL0PR04MB4532:
x-microsoft-antispam-prvs: <BL0PR04MB453206A9F02E4A26EB8647A4E7A40@BL0PR04MB4532.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4o5QFARkMdPkIkWVk+4QYLkPYgOVlQKGjmZUIIdm7Cf5uDKVd7q5oRsM5cjleyAT1mnOL0ribS3Ut+Qwocb6UphZZp+mTSxb/1QbTPeldC3WKbVykGaOZawfHf8htwdK8Q+S5M2DSDp2MX8m1SQAzdHvlGZB/lVcQ8gyygb8knkzRrXp+ZGRuqhF3xrnYxixFcv9E2i4hN+y/8a/QOpFhksUpHZNXiUbbaGPqE2DuApAaDcQkQYbWbA3IjTkW3YnUQ6vgnrD1K7h9TkO1/FlVmIFliGHjlbmwLTdUK/Di5wRk6TwNNxBZ7jHVNXuPnJKuCBiJDCz5SypI5vIJXT599VIBgq3Of/7899LiWFcAU16MBwltsrBQ/40tooyNax62HYML6GgXcuo3YC2JydgVkKjtFndNYKxXMhAztPYKnaKMTZJjM4fVDP3RFbtiuztxxQIjn+O83ykA9wkzF4e4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(55016002)(66556008)(9686003)(54906003)(71200400001)(186003)(66476007)(110136005)(53546011)(316002)(83380400001)(5660300002)(2906002)(8676002)(66946007)(76116006)(33656002)(91956017)(8936002)(6506007)(52536014)(7696005)(86362001)(966005)(4326008)(478600001)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+dYh7FMxdMSKzI3TytU7oq0abuIs/iOmzJWU/coBdqNG+B9yKjVolw2p0xnh?=
 =?us-ascii?Q?8/FrduuPIc8YbO57Kb0ZLFAv0NEBGYAB7ez0XBeglt0qEkhBDj4xl9m8Ysao?=
 =?us-ascii?Q?B4D4BsTMxSO8CsQLaJsTyXFIbjZQyB76gN4BCHPCYhQFLt/lZaURdNjYksMf?=
 =?us-ascii?Q?jayH0gZrz+sh1WlYonbZx5A4oJM6qjHtz0K+0l2JWRpsRIPJMTQG5bGEJL8F?=
 =?us-ascii?Q?gOzIE/2IH1fEBHUxZZ+bVHJgcXL2QdjbyAmccRwHwQoy+/yxs5jmdfMUjfQg?=
 =?us-ascii?Q?DnraBJl3j9ex3TahQZLbxDMr17DNb9HwfD9ucU0qc5/CKUhap6Q4dv71IxrD?=
 =?us-ascii?Q?nG9G6iVRoYaCRswK1rANCA3Gls7q8/DwdoDbjYW5CTVJT7oNU7a+j81CQhA6?=
 =?us-ascii?Q?Ib4zss1uqC86+WAPjKtQ8SNWaTLdOZTBJp50AwypTTEcCdki4wGfx2iOMoMZ?=
 =?us-ascii?Q?nfZKrg0qWAbpHqH6VH3TNOwDsyBUJa3XdlUG6WCE66v43qmvpDZTRFVlRtFK?=
 =?us-ascii?Q?bG0X8178YwqQ35BT8ZBFMTeUeaP2WhYNkcvl3GwxvL5XIT2yjPBy7p85i85z?=
 =?us-ascii?Q?B2b/k3ruW87tSB6JquUBYIsG9Q/JBtbhLYJR9WWxH7rDqXWJH31cYdqUdNRu?=
 =?us-ascii?Q?MnDzpcXZPeZRLuxqZf+Ta2YAlMoUW4gv8uq9QxUplwbqqpjCuClwBSJoqoKl?=
 =?us-ascii?Q?nhKPS2CVTDsXxNV7DFXukuM0kL2anPImixLl664MoMFf9/1OXuuu8fRAitLh?=
 =?us-ascii?Q?PpaHP4NA+hRCc2LhduFhIf3U3B7quBGEngDVlN5Kcuye7k+SgSMiFF3cRO8x?=
 =?us-ascii?Q?8kfM5dCOKuZjSzAwWfUjEH18exD0S14XmpJzlYoJqSY7WANhkDOIZsOQALcd?=
 =?us-ascii?Q?ZlnoCapMWDu93Pr47n3fBN+QIy7BvcGCEPpN3lkWhfzVyoiaBfpeQNktgcjQ?=
 =?us-ascii?Q?DYZIOffViColr4BmEm+GsxVXhaTL0KZzQ4LooVdPfQeq0q261r5FSaFwkAyo?=
 =?us-ascii?Q?J08dFWduG2/BzA6DdrqakxeLScefh8qEbLcwCZigATntXnOG86Rj+qsDY7hX?=
 =?us-ascii?Q?9otw0AuJCu70RoNIhn9BGHxu/SCa8noDaqpjvJY/18+9rWNycGoToe/3Jq+n?=
 =?us-ascii?Q?AzhzIrnYSxF35uTGxDuDW/7DwwxbLDspRg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd12de7-5754-42b0-ef2c-08d8bc0c1210
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 23:52:10.0519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWcGTm8veD0MJH/vVRVD4b4Z8WbVkWQ55RR6O3mJRQ6YMU6yOS58xnVi7KEOauDuWgf++h/+hhIP2DUFwKXJEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4532
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/01/19 4:26, Matthew Wilcox wrote:=0A=
> On Mon, Jan 18, 2021 at 07:31:13PM +0100, Christoph Hellwig wrote:=0A=
>> On Mon, Jan 18, 2021 at 06:17:12PM +0000, Matthew Wilcox wrote:=0A=
>>> On Mon, Jan 18, 2021 at 07:13:38PM +0100, Christoph Hellwig wrote:=0A=
>>>> On Thu, Jan 14, 2021 at 07:47:06PM +0000, Matthew Wilcox (Oracle) wrot=
e:=0A=
>>>>> It's often inconvenient to use BIO_MAX_PAGES due to min() requiring t=
he=0A=
>>>>> sign to be the same.  Introduce bio_limit() and change BIO_MAX_PAGES =
to=0A=
>>>>> be unsigned to make it easier for the users.=0A=
>>>>>=0A=
>>>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>=0A=
>>>>=0A=
>>>> I like the helper, but I'm not too happy with the naming.  Why not=0A=
>>>> something like bio_guess_nr_segs() or similar?=0A=
>>>=0A=
>>> This feels like it's a comment on an entirely different patch, like thi=
s one:=0A=
>>>=0A=
>>> https://git.infradead.org/users/willy/pagecache.git/commitdiff/fe9841de=
be24e15100359acadd0b561bbb2dceb1=0A=
>>>=0A=
>>> bio_limit() doesn't guess anything, it just clamps the argument to=0A=
>>> BIO_MAX_PAGES (which is itself misnamed; it's BIO_MAX_SEGS now)=0A=
>>=0A=
>> No, it was for thi patch.  Yes, it divides and clamps.  Which is sort of=
=0A=
>> a guess as often we might need less of them.  That being said I'm not=0A=
>> very fond of my suggestion either, but limit sounds wrong as well.=0A=
> =0A=
> bio_limit() doesn't divide.  Some of the callers divide.=0A=
> =0A=
> +static inline unsigned int bio_limit(unsigned int nr_segs)=0A=
> +{=0A=
> +       return min(nr_segs, BIO_MAX_PAGES);=0A=
> +}=0A=
> =0A=
> I'd rather the callers didn't have to worry about this at all (just pass=
=0A=
> in a number and then deal with however many bvecs you were given), but=0A=
> there are callers which depend on the current if-too-big-return-NULL=0A=
> behaviour, and I don't want to track all of those down and fix them.=0A=
> =0A=
> I chose limit because it's imposing the bio's limit.  Could be called=0A=
> bio_clamp(), but the bio also doesn't impose a minimum, so that seemed=0A=
> wrong.=0A=
> =0A=
=0A=
What about calling it bio_max_bvecs() or bio_max_segs() ? Together with ren=
aming=0A=
BIO_MAX_PAGES to BIO_MAX_SEGS or BIO_MAX_BVECS, things would be clear on wh=
at=0A=
this is referring to. Since these days one bvec is one seg, but segment is =
more=0A=
struct request layer while bvec is more BIO layer, I would lean toward usin=
g=0A=
bvec for naming this one, but either way would be fine I think.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
