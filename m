Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C415179C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 00:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243234AbiEBWLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 18:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387829AbiEBWKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 18:10:44 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC8F1121;
        Mon,  2 May 2022 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651529234; x=1683065234;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+p2bilC194FPBJ3EhZ84ajc8No9hIc4J6p2u9fdAvuI=;
  b=Rnc+BC2ivyCa9VLJfI1yebwAusK05jtnOItLVzWsJ0HWT+Qlm2ub41Hk
   IRCH0PgePNEtAGKaflBcL+z1qu1Zqw5nGP6Zk+sZOE19NaqL7enyIo2cU
   t7Qek3jzUlu85JzCviW91hGr4hAE2Isc4SD1qRS5kKRX5tH4ZLOrtMosz
   RvDDDSnwh1n+VS3ykK4VzbtaSLT6XwLH8wwqYGQHMsddPOnKxFReE3/sI
   tw81dqfkYf+T5RXP4a054cVTOmB1zLRC5RgibtEIPi6rNBNDKjozFssNv
   u+WLtZVm0l464985+AwVK0yU241QB9YmgwUH+l1VDz28NYvDZWjzK9DXj
   g==;
X-IronPort-AV: E=Sophos;i="5.91,193,1647273600"; 
   d="scan'208";a="204240683"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2022 06:07:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3QL/V2u5Z9tHa3rV6Y9ldSxbaXZhaut63nyivn7ROFWzwgiOSR+LSP1EaVcun1Q/u06BHkv/LAK+/0G94jxwI94ZksuXu9L59ttHiJq5Q4x/GmeqQFqRyjHe2F+YOtLC6/k1Ph3rGdKSbxXeoharBFAN2xdHAdqC3kqS2VNsxXm7dLkfsexkbYqP7M1H7IDGSmWS3CcCVQQgmblDEI6fOv7xvUqg08GGSI5zTcaf8ADjjx+K1UO3sjez0fgpA83tC3W7M76NZVpyfYMPyOpvDtVJ3d5/6eRZcqcK7DtTCL0mOVtX28VDj8ToCNUltFXLYPS/+aW3RQSFXm6631pnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWU1zcAodQa0jLxSBgS1NZFyLWXl0T4b+RTjxmMzIno=;
 b=bOOhYt1aqX06yIkffV9jnnFsrSahjFdxBdPxr82tazWGGHMvB/8+cGhrlBD1PbECnwmxrELAJMN9j3yn1x3HyNxsil+AOPDYe87tMZeOXrm9mSNUGy7GhyJ8cQZl1GhMqEopl/uDkzHo9Qx81xEO6WjfDv+vaTCffccr/bHzfwDPFaEVJjtSp+U6fg384Erba0ir9YBa4msB23u3IghJeDnWW5eXtQKbEr05CM7JQbH4IX12SzXk5lVv41ZmXtr3pKyas1FfhLJr2H+uwekkeVvrU4CSup4lCiOHBppSC9WjDr0GqppwJeGrIM+RpinRVmhNw26ttBkyxRSahE19aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWU1zcAodQa0jLxSBgS1NZFyLWXl0T4b+RTjxmMzIno=;
 b=PCSsY2cyXcsvwkQEv2UuoPYH6CY8ROT6vLSsb7WbfRPyXYuPMJNM3LGjGluBUf2qFQlFNnA7K/bRfsGpjTc1EGIhP8krwRjqAfcpoEAgV0QaoSvXFoaY4XnewslOYiYqKQvYtLCKQUrlGTyqEXB6OGIq9oT2qaMwSrOV+a+ogDA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB5181.namprd04.prod.outlook.com (2603:10b6:805:f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 2 May
 2022 22:07:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 22:07:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "clm@fb.com" <clm@fb.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "agk@redhat.com" <agk@redhat.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 00/16] support non power of 2 zoned devices
Thread-Topic: [PATCH 00/16] support non power of 2 zoned devices
Thread-Index: AQHYWlBbVAcTcxyrHkCrWR4NhJ2aaA==
Date:   Mon, 2 May 2022 22:07:09 +0000
Message-ID: <PH0PR04MB74167FC8BA634A3DA09586489BC19@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CGME20220427160256eucas1p2db2b58792ffc93026d870c260767da14@eucas1p2.samsung.com>
 <20220427160255.300418-1-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 737a42a1-6be8-4ddc-e1f5-08da2c881a90
x-ms-traffictypediagnostic: SN6PR04MB5181:EE_
x-microsoft-antispam-prvs: <SN6PR04MB51816E48C7920B640CBD56BA9BC19@SN6PR04MB5181.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kqd/h6p7qnADrAZ0vPTmp/tqhmWk3UMQKEFF0+hJzb98kgf35QW8bLHflCtDtmag3Om5qn6cXZfM/J/c7ucCBM0ubkLj/OxrJ4ymQ+OTRC2PtC7r7bc10NdXwmGN5aUN6Kt4qDuJV+6tFtZqiMjeiMwBbknXdm3Hx+S2IY75lJ7CiYDxEaq+yi8LYbTq7u05zyFqsZlh0qiWfCwp9EOU/zRS7VL3fkpzakifMHF6fRbRJUisM3vUQj2SjGt34mW5bb4+QlHQhsiz9LB6V3lIfdbvUZHFb9YkQxYCq4OTq8UnsAh/oq2xIpB1T6aHU+CE3aGXgDaxDagbqQr95SOJLwTnZH6ofmNXZB+DQ3NG2P3C2q3kW9osl3xk3aS2mYl/E26H9xHVtZx/e1PxlADY3BNjlKLsXyuH53O3hqatvwKzh3v98h2tdpTSENUX5gTu9YnTQ2pj4qRo8r3/Z68TAVp60ko0q+qJfKW3rZoXmBo2YM0f+Koa2o587XdAzRKrzv+Hrmwhp3NtNCJ6B30QiwPYMuutpurvoCOojQ2FbYW1/5zMqADUZGIUdHsir510h54VX7XLZXykdKJPVyLfV+Q1DmmQ27hEwbOC6Eg3sGlHyiR3NKNtSyhh7TBWyBtd/kTSK4rEcnxHMQ/yIFkzb8qylt9kq7aSAVORqb4h05iBnAP3uimjyZIEB2rzw4/abec2otGlstG5LyQFpTbx5ItzEa1w2ycIEQUhWfFbEh0Zdu36FOvxC+B5+WDkQya3svFZ2d/q3Ild8/YpSpb5Gx/1p4u3qNWreqEsACx5Oa6vkaXtvOM59K2HBAqBDUV+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(86362001)(8676002)(4326008)(33656002)(66556008)(508600001)(66946007)(76116006)(66446008)(66476007)(966005)(55016003)(64756008)(71200400001)(54906003)(316002)(38070700005)(38100700002)(2906002)(83380400001)(186003)(7416002)(8936002)(5660300002)(921005)(9686003)(6506007)(7696005)(26005)(122000001)(52536014)(53546011)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P6ofxjqdMTFATnV/5tCxB+leHjJbejMM+tFIMKgLJfyLd33uD0ZROxfmzM?=
 =?iso-8859-1?Q?bU11gSHxNkUCgkW1bG1IZcXHStFR5UNomn51aBeQTEmsG8MzeLgwxFCRso?=
 =?iso-8859-1?Q?mGMdLRsWC2YhkLUJgqNKuAzy/Dp4Zq/32Te9z2MH9ohQntXSEPrGctU/53?=
 =?iso-8859-1?Q?OKgmFCweNwiIpRrUw/uSH4SOvNIZ4vvbR2vTXwYvF7XVTm2My+5OgYOJhp?=
 =?iso-8859-1?Q?mUUGODEGXH91CVW4jQYttQ/Soue4ncP4stS6+ftqIcfdgN+6HHjlg4BFK1?=
 =?iso-8859-1?Q?nO5ExMdAIA88aeI2z0sV0+k4GGK/TlmPVNSd5G+nIu3i0uy5vGLk5a6VK6?=
 =?iso-8859-1?Q?2yMsYVlqCvH4GSWyJhwotwfNwlfzv5JaAIUV/eOWq6ZtdEUOmDlnKajXE2?=
 =?iso-8859-1?Q?AnKmZWLzmIDMgwTxLWzQXNZtW3Vs3TeKFKqSjdg5UVpUA7XAyo8KsyvS2d?=
 =?iso-8859-1?Q?bjfTQpdCheuAK3jPRG0UO9UY4S0KROvdev//xMAIVzvWSgubDgUoXXb7uw?=
 =?iso-8859-1?Q?qcufuB1+G2kXUozBN4qpsS6HS6+/Szef1sWEvfjZtJZL4FBqR8t5aAVuM/?=
 =?iso-8859-1?Q?2fiOUSApYsENbZ4OVann5Ih+koMjkyczdvpqlNn0AGYGwmKobNyxvlSauk?=
 =?iso-8859-1?Q?tLJJvyJYn7gpTM94mou5MK5gAqYRRW8War4ZcrEj83KlaqtNb8asIGIZ2v?=
 =?iso-8859-1?Q?qyJhF/SUJ06+r0Vcpc+LgpGtDqysMBZkROy/WlKlxPRKVtZ4EkSC05kb+j?=
 =?iso-8859-1?Q?5RX9kocnheUpZG7o+kA1BtYiF5L6fBZntPBSbRxtz4hLkg1dG3clMiPIgg?=
 =?iso-8859-1?Q?qdOm0frLxyDTuUAQf2npsgHO4FJykAD2F15eyczm8OqgQHilJCwF3GSRW6?=
 =?iso-8859-1?Q?mEQ30Ig6ug4drcyqeuj88ys5HRcxHqbxuDw3zV0Ou1yEJ4J5KfbXFQM0ki?=
 =?iso-8859-1?Q?MqsZH6+/u60C8+ol+UiagA4tKn5Mnoe5f7bss/153jEU4Og+b9k6gN20vx?=
 =?iso-8859-1?Q?FKRBfTaFHvuKqfB4r4RXRyhCeoEWlxThuVTmGPNauZ34ibZn3ezPFwBo5T?=
 =?iso-8859-1?Q?ipkqS2DwVlE5xk+8TagFipMVGHLNU8qsEi57wlxZlliFx1fBpWsnBL7TL6?=
 =?iso-8859-1?Q?o8WONe35+/H/IzidR9zFCVSRugEHBvuOXk9xg4VxWWW1ZzqZ2ROJiud9yl?=
 =?iso-8859-1?Q?MtQrPcWTv80YgQDuYofPVap5xCUKyCqD+vt+oipXJMXFsskNj6FYhwHyBm?=
 =?iso-8859-1?Q?GjvMWPi3jLwrl5dcr20g7/vap3c7z4HhKriu0GFETw9d7lh2/OC1X5H+fi?=
 =?iso-8859-1?Q?+kBm7F4gifcCHCxAYJCfpJVNK8Bbgr0bNldWJXD2DX/iAvnFMmxzi1G8qR?=
 =?iso-8859-1?Q?TxAekoWB148BPQOBeRySZyl0zNXeoOGVLf+2ej5Z2pFoFgCYxUpSrgochd?=
 =?iso-8859-1?Q?TtKwTx/ermFrGJfQo+1xCVVnjv/iitwvX7jl4cJ81ezNJJsK5A85q/Yx2H?=
 =?iso-8859-1?Q?/zbNsa6lkRUTVNJB4n8rJUmNNvl5XsBYwMkpzXXybtSMbUQ6kI+ZiKGwF+?=
 =?iso-8859-1?Q?yKqTKny4tAls78Or5YNqyyeiCWtj37f+P8RJ9KLcTk/hm8Vg80ZEvXdrqh?=
 =?iso-8859-1?Q?Y07uI+3ZbszSMGFZD/aUM7oCM7OiKq/itLfKRyx8lWkudzKz7Q5pNoR1s8?=
 =?iso-8859-1?Q?XZcL3swH9jP0WNKQf1KSWHZZ/08Ama1Lu167dfSvDnb6Bwt40y+P5LTg6D?=
 =?iso-8859-1?Q?YM4F6DRUXyH9/VkSg9/vIG2+7HbNWxtgnYhRiAPlYif7nsYCuKbq8NZ7lS?=
 =?iso-8859-1?Q?ybKrrTsc5zXcuCrfBWbPCW0LGiXuOuY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737a42a1-6be8-4ddc-e1f5-08da2c881a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 22:07:09.8911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXSrpwmMcyRTXNrz68EpBiuYw5Pa+tQrKzFBtB/vEuBvZU0/1YCUZGY85gPHrGWwgqhO24XrDnLv9PFZCzRHRd43nlRi4zPyiSYm28446/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5181
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27/04/2022 09:03, Pankaj Raghav wrote:=0A=
> - Background and Motivation:=0A=
> =0A=
> The zone storage implementation in Linux, introduced since v4.10, first=
=0A=
> targetted SMR drives which have a power of 2 (po2) zone size alignment=0A=
> requirement. The po2 zone size was further imposed implicitly by the=0A=
> block layer's blk_queue_chunk_sectors(), used to prevent IO merging=0A=
> across chunks beyond the specified size, since v3.16 through commit=0A=
> 762380ad9322 ("block: add notion of a chunk size for request merging").=
=0A=
> But this same general block layer po2 requirement for blk_queue_chunk_sec=
tors()=0A=
> was removed on v5.10 through commit 07d098e6bbad ("block: allow 'chunk_se=
ctors'=0A=
> to be non-power-of-2"). NAND, which is the media used in newer zoned stor=
age=0A=
> devices, does not naturally align to po2, and so the po2 requirement=0A=
> does not make sense for those type of zone storage devices.=0A=
> =0A=
> Removing the po2 requirement from zone storage should therefore be possib=
le=0A=
> now provided that no userspace regression and no performance regressions =
are=0A=
> introduced. Stop-gap patches have been already merged into f2fs-tools to=
=0A=
> proactively not allow npo2 zone sizes until proper support is added [0].=
=0A=
> Additional kernel stop-gap patches are provided in this series for dm-zon=
ed.=0A=
> Support for npo2 zonefs and btrfs support is addressed in this series.=0A=
> =0A=
> There was an effort previously [1] to add support to non po2 devices via=
=0A=
> device level emulation but that was rejected with a final conclusion=0A=
> to add support for non po2 zoned device in the complete stack[2].=0A=
=0A=
Hey Pankaj,=0A=
=0A=
One thing I'm concerned with this patches is, once we have npo2 zones (or t=
o be precise =0A=
not fs_info->sectorsize aligned zones) we have to check on every allocation=
 if we still =0A=
have at least have fs_info->sectorsize bytes left in a zone. If not we need=
 to =0A=
explicitly finish the zone, otherwise we'll run out of max active zones. =
=0A=
=0A=
This is a problem for zoned btrfs at the moment already but it'll be even w=
orse=0A=
with npo2, because we're never implicitly finishing zones.=0A=
=0A=
See also =0A=
https://lore.kernel.org/linux-btrfs/42758829d8696a471a27f7aaeab5468f60b1565=
d.1651157034.git.naohiro.aota@wdc.com=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
