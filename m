Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DA9305D1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313537AbhAZWgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:36:14 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7496 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395173AbhAZTKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611688240; x=1643224240;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YGNmnRINIpG1Ldktirw1F7YWnEoLOxBb3VspVRYqkeo=;
  b=XtJKEuGFBigxznv2rxdaqxqqfKsUuFsRZ8PXJbg5nbEX1wDqVLl5OJ44
   RCI/X/otG2FxCzhBehhQiVztpU8Mzrd4qXGY0eBgNzKr0OKtylc7vHJJ8
   k+ZhU40NQigfNJQN0rI87FkDc2ZMRT40NjAgbsvh7q4Q56uhaLZdPYzWt
   tTzkge6nkCgrg8DqKdvDQNCaGf8RJRL04VOKTrgeD0EdWLzVQvNmPhDVe
   uUdZJ/topR5wf7JVMh979aW0eZRRZB2eA7y/H2nb4PII7mhJiA70LMaTx
   49W70fAiH6yvMNwBp62XV2TCiWHWshUigqzHzSRXFesWMu8vLd+lwh01S
   g==;
IronPort-SDR: ZLZpwRVXYXuqucQk4LzjqbsACPMCWjLltDd65uTVUK91NaD6NYa9szG3Yu/xxsLQnUGxZ/Hfxl
 al+ABfpuzPa/RegGoK13Q+Y08Wn3GIgdfRYZlE1re+ChX6f5XY/mfRNzI+9iGzuiI6L9J4WtLP
 xKYvv8UYajhDLdFbZvItVPrDNl0lvRE+mdFFGACL5WVrr/43A/cjIYtqbkwS8WIklV4P+m52ai
 hwtMFEtlVfYls4W7T6KZmqFO6DSbHZkgR1PatE9b9zIYFi7QUmbCYObpLc6futzOIYEXTorU5a
 qK4=
X-IronPort-AV: E=Sophos;i="5.79,377,1602518400"; 
   d="scan'208";a="158378853"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 03:09:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG2qmGpjuZXFXFiu0bfvUKd1O4ISpb3YZSvH7lopj7G2AZr5mIvaZCxg93xCcIGyzZN7V0lLkkNFpX8wTwmVNyZReZGEWgSooasTN1lhvK5YP6fq3HINdmw3wPKBTqTe/wDlkUbCbm9TLYZAwj6xukcKscEZarb5JPd1G7amfqet2BiiLf3h0+I7D7fAljjhh8kWVsTc9gS5gNRoYgPmooBXvGCQ2c9X0X9NW4EwfBCcW2am9R6nVE+FU0+sjkc4Giz/9FvgoedL+o5ZzIWE5O5kD7+hKnrmjSU//rp/tEpPIYxHS/qang/gPLlKP0hW+/+NI/ZNCpSaqgLC3diTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGNmnRINIpG1Ldktirw1F7YWnEoLOxBb3VspVRYqkeo=;
 b=H7yzhoHlHIy56Kc5rSIQSZF26D4x/4VQEFVSokSseSQTZPqp1RH6uVbPQc7pUMb8MP+Z2xLHjCajI122fT1FrwqXL8EMrskD277iKvZjyCnbNZ+idfW/Im3/GrXSSWBRAh0U/WWHvvzTXs1XSDmhhPWJmCA2if4m/gpHbBKrQvX9qa9H/CcH6MyZ171r3x5YxqIKMYyY1NUI/9CoP+GLA/PzyqCXKlsWKKmN2Dhi/WWck/OqUatbyp9xiBVhFjsftL+zuLiMpbPoxSFilrxV0CWpgY+45A5eF1+AEdZF8yWsebF/wGj3kbFUr2rOZq5c25RBPxHPOaTQAGIjhD8W+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGNmnRINIpG1Ldktirw1F7YWnEoLOxBb3VspVRYqkeo=;
 b=Ksy6ELnealbnBgmT8mPoeUlKa40k/AUv0nJviygP8ikh51UA2gOxdGE2iw++0XMwttPnw26xXO90biaop2t+Da84ywfdyKIAlR3a1nlcxE4qQBdLHbIy9we3LP6Bj5dUnAjgEde5i3yoOQytXca+YN18Qarp9VZX9BeBO0hl2EE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5895.namprd04.prod.outlook.com (2603:10b6:a03:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 26 Jan
 2021 19:09:30 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Tue, 26 Jan 2021
 19:09:29 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 01/17] zonefs: use bio_alloc in zonefs_file_dio_append
Thread-Topic: [PATCH 01/17] zonefs: use bio_alloc in zonefs_file_dio_append
Thread-Index: AQHW8/QrNhI8HyLlwU+4pUC6zgQqrw==
Date:   Tue, 26 Jan 2021 19:09:29 +0000
Message-ID: <BYAPR04MB496552BD237A2B9388B82CFC86BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210126145247.1964410-1-hch@lst.de>
 <20210126145247.1964410-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:270c:4b00:b091:5edc:1473:bf45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f35eef7-24b1-40b5-ac26-08d8c22de84a
x-ms-traffictypediagnostic: BYAPR04MB5895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5895EA71901A3B2B4198EBAC86BC9@BYAPR04MB5895.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N5D1t7fEmZ/vRNsWL3SIMc3Ot4sbmgvQI230Ws9puQQrSkHLU7QdmNi6cGMo6z/AbJK+eQGOSmvl0g0DpEvFCSiacEm3U0OSOfor1kMaTHm2KMXIR+6kbjZGjKo2FO8NFdevDiQwjJ82AVtVBA7fzkpchaEiRp38f0cIzWBXIeR1w9G0ik/lTypoLW50rpeWn/1KfAZ92+UAED1IAoshDwgj/uhsSznutl+YUp0j6FIRTnIyaPGvKnQ2oahnSOKI6UfxNzZyynVTAnW+PqbZxdwTfus6WeultlmVhuXW1N+RSFMXlojqaKUFCueH8/zSlx3xzceb6pHlv9c8DCpaa1fQYpwiNcgCzbE209PFFG4Lcyl9z9BqvzcK0F6CHQJPARNJQGaSy8eQ4/yujPsx1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(478600001)(53546011)(6506007)(7696005)(316002)(2906002)(66556008)(33656002)(4326008)(55016002)(7416002)(558084003)(110136005)(54906003)(8676002)(8936002)(9686003)(186003)(71200400001)(5660300002)(52536014)(66946007)(66446008)(64756008)(66476007)(76116006)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eI6rIzFiJ6pedp6gEywHXdT+FYQOv4L4uRq8vwaUazN5LGmbO1EWcC9OHSHy?=
 =?us-ascii?Q?c/c/DjnwUKe0q1TWZbiU2nr3r3nd8CWCRLtgoY4iQOn5w2RmnmNpg5vaUaV1?=
 =?us-ascii?Q?X6B+RQfAqBmd5rgF77e4pU0E6PIbjW7wN9oTi+dFXoJBe+YOZ2Np5s6Hityh?=
 =?us-ascii?Q?djzKvVenO3GOcaz+yVKyxDAgCkZpv19KRm/et3BXfHHgN+bOCpcG9sq9NYB3?=
 =?us-ascii?Q?p1EvfoUeNOxYW0YiffyqGcehEvZoPa7DHpCVKnIaGuERUiocudPD6XBuo7a1?=
 =?us-ascii?Q?ijGncT78qfxBeNhPnzil3nbp98vJBzJd86wn4Stgq4FlKLjpiPwoRD8L7bG2?=
 =?us-ascii?Q?c14D0Y5fqjnMVtm4+6scIMKIZH2zgNDMqJXUnIqwg1Yl/GMIxLgbw7XtV5jJ?=
 =?us-ascii?Q?IVxooGC/QM9jTrBeSryVEkCkgibYzlgUvKrJG8nkvHKseF9phqCkxKzXryTV?=
 =?us-ascii?Q?4wfQXVaswzstXOyuVkO11HBZkr3l812sjAzSPvZz1KX6zCPEFEIgMJotdClg?=
 =?us-ascii?Q?cFb/t/s2edeFlHBLSdrLIPs/cGbDUq80bYZE+7NaBf1Br9P5mf3fJcUShVgS?=
 =?us-ascii?Q?uLnkM6iFXI02D4GySlgQqKE2lIx7V7Vb1h1LGJTPy1z+z676yEkCrsnjSpNJ?=
 =?us-ascii?Q?u1IZRMTY9kvecwUao/V+2CeiFImbwUAfr73PF9ROR8b5xu4oo4PnYT9VFG4/?=
 =?us-ascii?Q?KmNaQmLx8y2wbFmlF+ypcfe4zid6rsiXPJQGWJcwJM5Qkah7wwianLbKQfW6?=
 =?us-ascii?Q?+WI3lyzGlIvqXDoCPufhaodo1w7gTeOrWSD2xHaHcxT6S4z4rlWvO+B8J5Yt?=
 =?us-ascii?Q?liIdUjW4OmbxoioAIpMSY28TMvEPlWgyPI1nkCr+0pFSYxLXc8tOgv0fXm52?=
 =?us-ascii?Q?u7yKcGNzEMvrTbyqdPDHZOqG8VOilSuqBkYtL/zqqP8jScAm8MdE5EwIaUUi?=
 =?us-ascii?Q?JWfRR5NNtWEfdWsGMOIdSqFyXhlM4dYGoeR7Jv+bKqWCOf4zawJ70rz0+EYT?=
 =?us-ascii?Q?PwYk7BYtWdg4utZNrLHUYKieb+8kGloWg+ShRguSxz8FplEMgIJOO0XhtAZ5?=
 =?us-ascii?Q?KlfdbrpKp62cb1whKV/ytqcQMgxfKTIrr7qUBl+1nVdlVPkfWzNBvMeAeNUR?=
 =?us-ascii?Q?MOvDAGfu1lbcFsBdOgeWxMeKDWhw3/SsRA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f35eef7-24b1-40b5-ac26-08d8c22de84a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 19:09:29.8430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkoUaWb/WhPq0RyTEnv292YDUor0Pva/RL40BBpOQCTXxnD9rOdFToZ4ixKO5MZqy95nepFUpZvo2MUVDYgPBLJOfNNDqjPVo1cp6us5IQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5895
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/21 7:01 AM, Christoph Hellwig wrote:=0A=
> Use bio_alloc instead of open coding it.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
=0A=
Ha Ha I was going send out a patch for this :P.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
