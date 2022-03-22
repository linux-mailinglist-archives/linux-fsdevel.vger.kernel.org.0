Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171E44E456D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 18:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiCVRs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 13:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiCVRs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:48:28 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCE72898A;
        Tue, 22 Mar 2022 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647971218; x=1679507218;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hO9pdw75N71/GokPPRjCAgcdS1K970OhUSoBqnjSlbs=;
  b=cpN/RwGc5/AdN+6t4UtPQe8H/zZ1C7gnqavnydtnP53yJfi+NG7Gu1Zg
   SYGBY3Bss9MW9ZMto7t1iAxT69EFLyeNE9hcu/V2rpVy9eUaesMb+5sE2
   2PCqjgut4M5lEYYBVpUezPRpWzJsQinCqxXxrvZl1VucEX6y2inIt8MDO
   SxuVZbHVQBvtFSOAdmn+yev7ktw8aSBMK0PYXqJXO1hqM67EOJlOEJhRQ
   E7SjBOYPeNHCmgLhkMiXGD8bQs1tTnvilH5qfiDIeVCfhLthLX5BW58m/
   R1XLXRik8soAZO5PTBQZYGlv9FExwcwOL4TPSt37l+Ju4SiTu1zxF7S3v
   w==;
X-IronPort-AV: E=Sophos;i="5.90,202,1643644800"; 
   d="scan'208";a="195988077"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 01:46:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPAEhpIcTM+dyvlE4UTK0EzJ43ST07wgb281cwGa2JQdtX9N6BuECEeS3+GmxA3spKCjWN1USf243vFKHhxbEEEcZQ4UopP8IjP06vbPce0ux3Bid+pmxBaLvLdVNgXHSjS61z04lRBeUBLYcOIkjpkY2hRS8SpIGiuxnvnwjAw6jyeSBaae5Vl0xEwjXbnEFGxAvyKjGINDm89AvRnLMg5M6E14/twHw/bSygGGdS4qd753TEqaQEZ8fExuyAYrq5ZW0CrYs1aecuWcb6EDvaTIdU1/mCgwj3c7I/Vipce719ODcKx5qA2hQwOK6zQDm/XlHMk2g3LBWASpZUYJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCkOctwH6J28RwGUleiXeSaedNsjYPmGSFCi8MSmy4I=;
 b=lmCqgq0k91c559Xo6qYqESf9uvgitC02PBnbjALUZ0ck410ni0aazXO/9LBjFRGCAVUMYAHDo0PS2p35x+3P9jEBGJLr9hxLkT8meE6iUnImDLH6d/769JqccER0nHWkjzFqxf6Rw3UM2y9n0D/kRdvmSAli/g7bMzT+ZoUXCppV4LDSx8gUgzjw6ii7iwxQ/JmwFXOTUYMVLcsJbyNByX8uUooUWXDG/6tSbFcTxaVAPc0S7JFlwNHX2qq9OtLxyD3TryUszV1An4r5RC6OG2FPSHniIqXZvnUOUqa1RbuZaFdzFzTCiL5wI91zto37XiB5+jZei76qI3znZh3nHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCkOctwH6J28RwGUleiXeSaedNsjYPmGSFCi8MSmy4I=;
 b=0CACf8olhoY7+L/n4WYnfKIIIVulxjTWL33nt00fvkuPosaStHfv/73jpl2YBO1+3DahMDFf/3yGaQvjI1HU+OpB7axxiDOgztMM1OyinswUXeGkDTrt6B3CMwC5I2LWByGbsdbOp9zbFCpdn20QMjh++pHUh8aQM1AHMUGAh+8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0586.namprd04.prod.outlook.com (2603:10b6:3:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 17:46:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 17:46:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: RFC: cleanup btrfs bio handling
Thread-Topic: RFC: cleanup btrfs bio handling
Thread-Index: AQHYPgVg2Hma/Kgk+kChWP+dPxzkkg==
Date:   Tue, 22 Mar 2022 17:46:58 +0000
Message-ID: <PH0PR04MB741624E9ED98EF9F163E6E2F9B179@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220322155606.1267165-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 817d10f9-988d-42ad-7698-08da0c2bf660
x-ms-traffictypediagnostic: DM5PR04MB0586:EE_
x-microsoft-antispam-prvs: <DM5PR04MB058673F6BDCABE82F37D2B969B179@DM5PR04MB0586.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TiQyUswAlPKRf2ufyhTLxKqc2utHX5cXqLYmK6eK8SmXdmw5Qu0xSwHq7hUW6bInSAnHzmsuh3WyeJnD3585WYTj9kAwh15XeSgib1uS3r76WMTLdRrpD97SVXldwWtjJyhshmQ2Z3uUX3Kb6cTOMqQD4g9X+YGsAFeHnlmtqReaVqiaDNFvZjArex25325VQhQjOToTgcQEk81Xr1DVPNaKmYmeS3ZVRI6RZggxyljiR4b4S7SNPzN9gngXBtlvqVfdkJ1ZZVR8m1lAK+DsGE/fDNBVo9d3FwcH4qaHt0+Qd3r1gtRkaC97v8jKjhSd9HEx6htOX5h57SOtiQ02G+4CRkfOJ5h2uYlyo6T/5W6d78u63ANUABBSUOZiNMSK8+4NjT7CoOd6GN5oEK9KcTPHToGwJCeB5R1XJup6PaTnv5cCVRQ7TNS0GucLi3v2XKgFcOAnAh1JTBV0rqgaZX+iAzFR032Hj+DMWxfGbBAYuSnxR/HYK29GJRgepd90I7x/w+snh75ivvNezdobkfjiJlOl5ooaco5KWVdogbyo6z7PgEoY23jgZDuw93D5fGwwNu/vRLFzxY+v69LPea942Wz+u4rUzv2LDWlfKbgAOKYiNxai73gw2Q8A8ojw77qOjlJgjORJdmkqbH8bsrvWHhC/cLm68AuD8dYEB01VNj5OP9xGiKQe4hia+nt05XUtYtnpchs+rPINxASmSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(82960400001)(33656002)(38070700005)(38100700002)(91956017)(122000001)(316002)(508600001)(5660300002)(4744005)(8936002)(52536014)(4326008)(8676002)(66556008)(76116006)(2906002)(66476007)(66946007)(66446008)(64756008)(54906003)(6506007)(7696005)(9686003)(53546011)(55016003)(186003)(26005)(83380400001)(110136005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qwfxc/lebG4zAv2NKKA9LqTIHi1zMuhmJl1S2tezlZNAbPbIO2x4Oqp1RU3q?=
 =?us-ascii?Q?orSDyoJnN9V50fkS/pBcTm7E8Nr7ZEJy4FHjlFnOFpFGw+Gg2FCmfzfAdCTj?=
 =?us-ascii?Q?NQpSNfqOWYMSmoDY7ZydCNfMBiVzOAVg3LXQeUJzLIstuF5GPiShKpehpCpR?=
 =?us-ascii?Q?2Cv0noN/eDSteHS/UIb4DpoITlMLkAHYe6RGGm5BAVHSGejrAmFYXey/wkdh?=
 =?us-ascii?Q?5jzTMAQ22sGgnSXS1LXDQ5v//W2Ee2gaAOEaakMd5yc+ym2PSF9sYUSTrKTe?=
 =?us-ascii?Q?ZG6LVCWxdGBmI5HkCuldOoW3bi0TiW96oWDPjAUAUEWe68JFPM9Hpyez3RBm?=
 =?us-ascii?Q?wfe781yX3rSTC51H0ffwl/neM5+Sq3aG+08Gh11nC1/bg13Nn6bNwbaHTSIc?=
 =?us-ascii?Q?ERAdeOvVEI+l7KdqYcHcuMwg6KiGikdRKTSAim22Y5rpbqpP3P+I7M3q93fI?=
 =?us-ascii?Q?Drq/6HEBwkdHF8rKqVDbPhg7dMhXclWADXc2V3fdCFTccEcthN6kqhuY3ZVV?=
 =?us-ascii?Q?+p8u/BIsOjZVGybeh0cRinvWT3C9BDHdB8VwjQM27m461FDGjfino3rV6+WD?=
 =?us-ascii?Q?/J2DsalpaEPPPY40qiUi3pghHn6mCwPXqtWsX40/Oau+iS/SSWebjbWL2Cte?=
 =?us-ascii?Q?vvtwsLOomnnYFwFJEvbQFPLndNv1N4LwdK439pmS1suTKUi+132KKF9Od+mK?=
 =?us-ascii?Q?5YnMVUHnDJDs//4ZmwYvb8kulXPLhoDIhapfUguX7VD7FYiDWyYDseSOmaLR?=
 =?us-ascii?Q?deXAVkF2TTsqqpwJb8qUAK4dAsM4c+F00LiXx+4GtpRqWuCZnIJv/qhw56ku?=
 =?us-ascii?Q?xzmortq+V8kJg3ctl868bvVIGnXsG4pFxHb1wFk7ttRw1tet5WbulOsv4C0S?=
 =?us-ascii?Q?qO6mMDbEHtcUMoWhYWE4hV4IcFoqr2rfaVxie9ACRFZwNSsj996AAmAVcAai?=
 =?us-ascii?Q?olNkId07tsWTRsyTUwunH0LVUtAJ7DOEkxH17gFECJX15I87xsrFoU2lw3Df?=
 =?us-ascii?Q?3NEYua3X3VfIcJpoG3O5iOIukmS9S7K6dIeoWaVygSUUwo9BHBdwP6pYVKxg?=
 =?us-ascii?Q?tEc7yUYdOJHHHlCmwRZQStUr0HD8cCIBgQAMEXxgLA9ey7Hl3svQwcsRVV3k?=
 =?us-ascii?Q?IUKVHJwK3K0Ax3lEoCeZoKylV0kzIYlB69KpCHQ9y0V7o7xs+VERADYnDx37?=
 =?us-ascii?Q?6UKig6Ylln6dmctOCoOUQd2SzQna84tjMcvfuATB6MzkeVRrmMJ3v/m12Rk6?=
 =?us-ascii?Q?GEF3gJ8+pEA6cTnOr6rsGZw9rVm+4U6AXhu+TsGNJ+X22EIKg4bc/Wf5041D?=
 =?us-ascii?Q?G9PBZFYgcP9OwYcdtB4uv99fmM7Iv0tNNdsLY8MYLKnoW3ERac0sU1qV5A7G?=
 =?us-ascii?Q?VSOVnpRPQpZyCQ+om1Mst5iRnjh9mz+WZBk/6bZP4aouoRZSJ89avouFF6D9?=
 =?us-ascii?Q?FD70LsWzwySMxy7T6w+Ct8snw4Btj2qg0l4WF5CKtJIyyDbPEKGdBQdHxPsh?=
 =?us-ascii?Q?D0LbOc1OssxlYNI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817d10f9-988d-42ad-7698-08da0c2bf660
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 17:46:58.1116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4A/lJtJLWLcNbdaonByRDxHHstNaL/TYQA6Zia6H5ESl5IpgjBLB5X0ZTaMLZ4Z+AmGXUByZLqee3G7njE2B7dbGqQAi9gMxwywlXQkcz68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0586
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/2022 16:56, Christoph Hellwig wrote:=0A=
> All this is pretty rough.  It survices a xfstests auto group run on=0A=
> a default file system config, though.=0A=
> =0A=
> The tree is based on Jens' for-next tree as it started with the bio=0A=
> cleanups, and will need a rebase once 5.18-rc1 is out.=0A=
=0A=
JFYI I've run this through xfstests on zoned null_blk here as well=0A=
and it's looking good so far. I.e. no noticeable regressions found.=0A=
=0A=
I'll look deeper into the series (just had a quick fly over by now)=0A=
tomorrow with fresh eyes.=0A=
