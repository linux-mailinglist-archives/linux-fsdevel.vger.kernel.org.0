Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C10D317079
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 20:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhBJTnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 14:43:17 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:14533 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhBJTmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612986158; x=1644522158;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BulIskyOmWR8YUO5p7xwhIc2L89P7SFSNBBHM0FXMM8=;
  b=Ay0WqTFO2ajlRzgwWvAtulPnJboxjPms7z6DDwgRrRa17NVFIEkpEzcI
   mE63jgZ8zHhFMcdyk/krgFQMr5jZe85JElhBXZwFGGWaBJ9G059W78iGd
   BdLG7gPooyQfXMWBPjK7afpF9beC324Q02ZOwoNgKoC93zFHuJ9fpVa2K
   J7fHOrPvG7uvlKLVymCuuB+9celYbcoxrvJDtsX5mMFLF4aPCkhiIu0g5
   7+ZXbGtWSoRXInh+ogd5owjZ3LGkgD4yNPjTO2VW4q1t91rRK/hwgFX3k
   PNwormTPP3Wo19gZtggrPe7o/yPUMjiE3I3oA6OMsd2bU4WQdAEJK7cXC
   A==;
IronPort-SDR: EmYQZrr2YU/Isfkmps4F8xMICtYgoqEZqy0CBiWXQ09gdOIs3HJkzwnRNU4SZxWilIKDRRse2Z
 DVxRCMP3WUtLaq8cEHu5ycRwTfy9YN+a3RF6h5Td52GeckkcB8USvEkF9yCcdBRJy3SxQni81G
 NIW73RF9A7hoEQxsszeY8S6L7M1Aux3VWtC8wCiFvlFzdHOVjrBHzU5Utr0oop/gpaqambHx5z
 KdQhgYXn1GqzlfgBd0l+GH1u+jZsbtu9o1HdeQidwbA5jaZLIUXzWjuosVQhl0J3omOy0HkuBK
 QuM=
X-IronPort-AV: E=Sophos;i="5.81,169,1610380800"; 
   d="scan'208";a="270173968"
Received: from mail-mw2nam08lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2021 03:41:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhtqwxaIvFH0XYaPaITH1S2his4ek+A3HE/jDl2uxfdKsFBlTKzjWlnh753ZFSwOIYYNDG2fNk5jnuuMswTU8+Kw0e/wraCvlwE1AWOu1UbU6M4XMvca4Y2ZmUepYyh7FDXKrvp01kKDKY/7pQOer7NcfuR4A1u9K98vUfRhmOxh9KHkLgdvuSDnqrF1hp0MF/kYtoJPnCPbbaE0Np1R+5/EP3vd+SE3Ia4Gj+q7r684e2gvn4RgPQgH6+2LMkaFcZlTlXql+sdKZ8UOyJi59XpMZnYJdxPXrgwYCjgZPxun9iCRW/f9qqrGqhnIF9a9HKRok2HkGwMwOHHIQ3PSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SlretfAjzcx560QmGQOqGEq7VudkE+KUqtOWATc/lw=;
 b=HiQ8mRUPgi3UzNbpakTaYNO0526l5V0k+ZuD/zWLq2dJ/DErs7aQYRdIWnqniYpRfg23tichyoGNBK74iPFGZQH91ynBTCXYGBA3rDhkCN524M98ymJV0IDP5ugGKu0KlEDGu+jM6718hQ/GblHlwASR1Il0ylNT9kwh5UHS9QczIRfRzDcMLlhX+kSC/GFTsOb4UZnNqWcJ5BOWsPnfixJfrUTOcdfusK7qVtwtP+JotnPfSb2VgKiIiIOm9NLhNt1f2bMjvdxWJvvIAeGLSUxzxgcR3PBcZqlyLtfXb773f8rjrBVicx4hVeVlOiC0eGmTu0D5/QEPMN0llz3DPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SlretfAjzcx560QmGQOqGEq7VudkE+KUqtOWATc/lw=;
 b=e3kq2ep7mXn4HH3wvY4NimROEyMh4z0oq6Ss+EZBiGeAqR+i7a4p007xMBqbByWq1sZjc8hn+e0yRgiCzpiRsHMHXRTfZiH9s77lQnVUPk+6r2UZKsjJR6IaB/q0tnw7CeRNVlHe68fd16U7cjBmN57eKjva7Mt1aOcG26wA53s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6690.namprd04.prod.outlook.com (2603:10b6:a03:22c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 10 Feb
 2021 19:41:24 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Wed, 10 Feb 2021
 19:41:24 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "clm@fb.com" <clm@fb.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 8/8] f2fs: use memcpy_to_page() in pagecache_write()
Thread-Topic: [RFC PATCH 8/8] f2fs: use memcpy_to_page() in pagecache_write()
Thread-Index: AQHW/YRMS7PNFht40kGdxxwo3+yQCQ==
Date:   Wed, 10 Feb 2021 19:41:23 +0000
Message-ID: <BYAPR04MB49659707550FE7CF7B389D92868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
 <20210207190425.38107-9-chaitanya.kulkarni@wdc.com>
 <YCQff/XYAqDUXhhQ@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd48a54c-d4ce-4a5c-01fe-08d8cdfbd97e
x-ms-traffictypediagnostic: BY5PR04MB6690:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6690B954B11B9916A2970CED868D9@BY5PR04MB6690.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pz8l9O8MKssnEwWmtgeCOWffct6B50JO2X848UbPWEmO1h3sbLsglSxse8kJml031OMChfJoK2O1xsqtttZMyftJH1k4cRIbJfJ0t8fpDR2/LoajlYcaSWXntW7dtPHnAuHxLslsDlfGGUEKRS58Vw7xYar0IKcQXTmBV+m04Qnk8IGPH+slMq97J+UpH4UpKl683mBLvRDOyz6WUwC5RS/KQ78XIrzGwPwCTQZ19UDz8RWhDXoOOIloTYT9J04UzCnzW4WagVANSL7od5AJrUnqFXhCiAYTdzpFKUIbI5pjeLv2oApl5tnsB1rJF1cdOYNEvQ7GFdg8jTjSrF38y39mlGISx+ETiUkkx/uUZWVLfkcaex8OR/jVSj9e5NTqI8hXO9OFWEPIIBDAyRaI2+eeYv3rQlU9yFHCtiVrnwo+X/WazhyTlN3qu5CQNn+KuN9zOrOTjyzWiS3ebURSir13YWJ5O6TEpYAQxiGyCY71SROdOy0cPCzCAyn+n+e4/z8XsPCNduvpE9BkjFwyNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(26005)(4326008)(53546011)(6506007)(7696005)(478600001)(186003)(2906002)(76116006)(66446008)(64756008)(66476007)(66946007)(66556008)(4744005)(8936002)(86362001)(6916009)(8676002)(7416002)(9686003)(52536014)(316002)(71200400001)(54906003)(5660300002)(83380400001)(55016002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q4cWz5bu1QbRMV/3zxOHr7LPBqLsgVci4VOA7UvJ8j+ebK7YihaKbd3+IVQp?=
 =?us-ascii?Q?SudnKnShpdWHKaY8KgY28IFsZvRBYIORLVVlWLgu4P72qCzG6y0eoku0mE2A?=
 =?us-ascii?Q?9gNIF38bqKFN/LIvUgmVoV1amOjMHjVG6hpHYCeBxODdG/VnMuJB2mqPcN27?=
 =?us-ascii?Q?iqA7RvEN4zP4mV1/KfcdRyg/OAjhYZnRLjZ6VyWhdxDtR1QYugTxnxGoC2fN?=
 =?us-ascii?Q?h6w2uDTgHqn5Zlyp5SOHX1kqW3Ehw/r9QhQWDUc21g02S0vh2VDqv9NX2lFF?=
 =?us-ascii?Q?GHLAhcLgL/bf9YT2IDpYC/1gAcoAYuHia8TRuRoLLSHbxFonLJonZPprIhD4?=
 =?us-ascii?Q?ofDmBGHrZfNLcOyHP9RTBSnObphOQYtN6vgYK7CcFGgw9DaaZ7+0ZNB9WA46?=
 =?us-ascii?Q?yZ0kGN1ANyy4RU3AHsX1EzIgrtHTu4jn8GsoEJj+9wSvXx6jRxlKlv/3CNrZ?=
 =?us-ascii?Q?TxvevJxe3iHc4YJW0s9AzouQxjUW+/91/CQL/+2L3yC/xVJLzA3sIa1VQz1C?=
 =?us-ascii?Q?aJ+ie3KpZt19jWKoPs/R/7y+tbSIQn9YaRK1X7B/0b/5QN09zckLYFQlaJdB?=
 =?us-ascii?Q?hcq02VKuD59lilnDU/R8nxIH3dvVEqbmIsq4vJBFmPqeubnSF8ox8dCkFobq?=
 =?us-ascii?Q?alPjEtif8XR2+x5Jtpq/HxmGRTlZ9tbZTJQVssH4+ZTyejDPcNtr3fFh2ETk?=
 =?us-ascii?Q?7eeVZI2SeFXr6u+KzKzfccXM0cAdeGgNw4P/48XJ/ayMYkPJgSupZnlf+wSl?=
 =?us-ascii?Q?v8/lv5hAzWq3sy5SoKFOn0zepetpK6hLOZd21xrc715NTWcb5h85yFFN9BAS?=
 =?us-ascii?Q?AsOPyMV+CoSpm8p4ocEK0lcPwgnxjPkxK+JKaFDIuzzzk5eFirT2bn4opXsB?=
 =?us-ascii?Q?vVdJOaopMNEHAfy7gdfq00wnPQg/Tn3XmSz8WLpCTCFlmBaiASNrz7gCbioS?=
 =?us-ascii?Q?l3n3wW59BTff8sPjFlx8ZsVS17GjWG6Kf3yDeKZUsQ2ZOmtxCa78XRviYjwZ?=
 =?us-ascii?Q?tO2LPpJaRl3WKyuWGcJgwV1g2GgvAbLC7bbLFt9CPi9fRLN1NsFegxtj2BGh?=
 =?us-ascii?Q?rZJfhyKR0m+5BbhvNBeyIvztTtgnJ+nc9cTifynkv+LYW5Oo3xBpnMZ9NA1O?=
 =?us-ascii?Q?8rCE1hJQtI35Tzi9jkwS6YMtxM9JxwA2K5Pm29Nctncwe6oPwaZYbsiGLLuF?=
 =?us-ascii?Q?6Lcw64uBWEcerI/m6vSzYW4hMeEiHWZk6n1YOIPFPo2bYSzDEH5DE576L7ny?=
 =?us-ascii?Q?BZpq0ibobvqHWQNarAyOX/T6mNFri7n6hfbt2qxEcMUXbCIFke7RYTzDoiCF?=
 =?us-ascii?Q?WhWGaCHs6i5HhNZFf+nOmAXm1YrySiI+1vkZAYs8n413Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd48a54c-d4ce-4a5c-01fe-08d8cdfbd97e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 19:41:24.0685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQFujcicuwCNgw3DUrKs4olOwl9cNUQgN0pWI7wMX0XuydmA5KdUXk3y2TN0I4Rzpmz8idD0Jlz56vZN1XYk5tehhOpNGzJHamDnxKXBBck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6690
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/21 10:01, Eric Biggers wrote:=0A=
> On Sun, Feb 07, 2021 at 11:04:25AM -0800, Chaitanya Kulkarni wrote:=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> No explanation in commit message?  There isn't much explanation needed fo=
r this,=0A=
> but there should be at least one sentence.=0A=
>=0A=
> Likewise for the other patches.=0A=
>=0A=
Thanks Eric for your comment.=0A=
=0A=
Sent out minimal RFC, I'll add detail explanation also having original=0A=
series=0A=
in the tree helps.=0A=
