Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79114CC690
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 20:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiCCTwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 14:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiCCTwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:52:32 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD601A3629;
        Thu,  3 Mar 2022 11:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646337103; x=1677873103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J4mFKrKLe521XNwU66a+a3FOvtuEuR/pABc2dgzJVd8=;
  b=Sdcwf06vwpfrJpDSbGB6k1743M81DzR1pTbVm7HbXqsMKH2foil8KdqH
   65zmGPGFpiHs1rfeLflYoUuWEClSez+/XQZ0ex0UhMfjPjX2Rpx3P14Zb
   aPG9lZ/YHvSEdnw9uTxuDtlX4mNPQcY74uaUoNMWpRCIdNSPbl7IGZcv0
   WZj9QrkWHUkSCGS3tqZNf29u5A4kOV21YERln6b2Reqg9FYFxhusWYWWK
   10bELk8BzLE6oSkIOr5i/MaA3bTJuBveQQ+j8ZazcMgPybFfw1bVOa7g7
   XpUFOCOI7ny+GtyHey94v38l1u9/F8TlqMCMTo3UjRA2BXNcJSj9UZxQj
   g==;
X-IronPort-AV: E=Sophos;i="5.90,153,1643644800"; 
   d="scan'208";a="199263378"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2022 03:51:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJxo1OoWuRedbmoiwEej8PQIsiQCbpj8gPBjXhJJbsmhDjmal9RWe+gKObSEdAZpvHzJ89UZLedQSrU3M3zsDgq2EdemtBgpuAiyR+h3RU+Yc9xmsBRScz5y6bOwRCI4jWs3T1MeBK3F/im+ZCOs2dCwxxk7lJElmr3kgV41OHF0Irjgy9UCT+BzWsPGd6+8j7XfzUjF9uBsCIl24/A0kO+t8vlNVEC127cGl8Ou2sgWCuoCYwDOoA7YN9Fth+knETfTYaBY+fWjfOY4xDfBMTC+Lo9kuubUq6VTH4pnmnUXmhR/yv4PB7Yb0M+c8k/Q2ZUmHOdc8wq2zUfr4qKGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4mFKrKLe521XNwU66a+a3FOvtuEuR/pABc2dgzJVd8=;
 b=gkOo4cwkZd51qoHeSX5e020FuO24nzfnoHJkHiJqNy7M915VRBxXKFDElS9bP9MhMKTuhGCacI/theuZE11sh1xz+rS/9SULwTLrmfk0smZhoxiVHZSFJWlOYHQ6/5bbEWCT82SuV7Hhb3wcYpCNZoGcfc+/ITf/qNDmbo5W9kqQa5wx5gon7f8Dr0pNqiEsSZ7bP7GRnyPfCQ8X/tOPu4MFfmbhSLkSxY+upsnwWIkwlLZvdJkrxzrn26IhG0BMUA3zCi3s8MfHyJ5KoCjaY0xTHcURnaRWl4u90l+pnBhfyZdalezQ4vqSSa7gapDOpu0EBQBpt3a+zdFdlj7Zvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4mFKrKLe521XNwU66a+a3FOvtuEuR/pABc2dgzJVd8=;
 b=ulqZecRpBgXyajJVlqzdMLwZaahBTTnYHuRIw58Y3vAZ6eU4bSQuboABE0RU4TaX0Rf5dW5nOQfENAsWlfbIdqtw59f86S7k63wxGDhtq9W1lA69H1gN5y2Dx4wc8Kl2ftIbAxEmFahIoEkSO7tg96BFulXQA3nLMs8t3C+DNkg=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by PH0PR04MB7640.namprd04.prod.outlook.com (2603:10b6:510:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 19:51:37 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::5cb9:fb30:fba:1e1c]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::5cb9:fb30:fba:1e1c%4]) with mapi id 15.20.5038.016; Thu, 3 Mar 2022
 19:51:37 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: RE: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmotDjh/nK/9UCnXW/KPy7zfqytIu+AgAAQCQCAADesAIAAVbsAgAAHhgCAAB4NgIAAIsKQ
Date:   Thu, 3 Mar 2022 19:51:36 +0000
Message-ID: <BYAPR04MB4968506D0A8CAB26AC266F8DF1049@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
        <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
        <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
        <CGME20220303094915uscas1p20491e1e17088cfe8acda899a77dce98b@uscas1p2.samsung.com>
        <8386a6b9-3f06-0963-a132-5562b9c93283@wdc.com>
        <20220303145551.GA7057@bgt-140510-bm01>
        <4526a529-4faa-388a-a873-3dfe92b0279b@wdc.com>
 <20220303171025.GA11082@bgt-140510-bm01>
In-Reply-To: <20220303171025.GA11082@bgt-140510-bm01>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd9360b2-a154-4839-473a-08d9fd4f3a39
x-ms-traffictypediagnostic: PH0PR04MB7640:EE_
x-microsoft-antispam-prvs: <PH0PR04MB764079ACAB0C2C8D1E60AADAF1049@PH0PR04MB7640.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KgrRzafRLNg2Ly7oK9bsjAwTt2XjQsh/qk7b6fjxFvNECKscTY3CizcSg7L80B/up7IDy2vA0lNpEGi36jCFDk35xkdj5mk2p6cY/E5JmLjVrh5cPBIzvUze0wzSAxe63WK3PcYdcuijEez2jo6HHW53e68eGOYz22+5yON/TCDiLQJxYFxL4zOFPhQRGnBI+oplsZfD2efUQAZSLxT96IDB7gEXvRxyQzCaWSgB+Jvqgn71XC1dQR4d4qGHbYiPb/sKR2zMlaqRuJHuNS2WJgFo3oRqmGEuTibSLTKB80KZfSiEfA4Ui30xmY74hVHt2yIJvqvLCgc7eW8wUfJCVfrkfRL4Ju+A9yHx4G2P2AgfrNUztIbZ4Xndngwkfu6pU5sUvhT5sPQ7pTxHJ/wqxJs3FaRNwvXPjyjw+tKSaoo25KrDZ/D/ZP0VTkQGLCZ9z9+YTsNxeWaj9gqQ6tknAJafXC9TbgzqdIuqUqPqcH9H/syKcarz9+zDSvEF/cucC77zRZZqlMYsa2CpHwFZHQ/NZOamCnUF4ua61kPrwXK6APeMLuGPbKuEooNdj72B0pdiusfYOz0C6x9fqIS2i6rTHvyJizYWmRPI/qTNh2Wv+c+Y0TkWIui3B3Qk9XkwQ9cuIwynyLx4FBOSM4EHc7oyEL9hM9NbJzM0ZMxQRefvXIL4mxAfRCqvsOffUv68tUsRi52ULPGmCoMPeJAIWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(4326008)(38100700002)(8676002)(66946007)(66556008)(64756008)(66446008)(66476007)(122000001)(83380400001)(33656002)(26005)(2906002)(52536014)(186003)(5660300002)(7416002)(82960400001)(9686003)(8936002)(55016003)(85182001)(110136005)(6636002)(54906003)(85202003)(86362001)(76116006)(71200400001)(38070700005)(508600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGMrNlY1ZHJVWkFPTEFCZFNVdHJ0ZFBJUGpHWHFVS05RQ3ZIck9VUnRqdzZB?=
 =?utf-8?B?a21pb2ZtMEF4NWZEVmJNRzhzbHRKMndVYWlkZElLSm9UU3ZsYVZuZm9PT2ZW?=
 =?utf-8?B?dmhyRmwvaGIwZjBaUDB5MkpTWUp5cWMvL0pETnB6K0pjcnRaY0F5SlZXcWVV?=
 =?utf-8?B?anNVVTAyR3ZDV05PdzdUV2NtZFJzUG1VdE1DT0c4MFRkblNIYUdQdUNjNEtz?=
 =?utf-8?B?WHJ6R3FrbjNyOVYxbUZBWmcyZnpDMThJenk1V1gvSTdZcE9JNFU2Nm5JOWcz?=
 =?utf-8?B?c0NPbEFGd1ZUMm9xUTBvcHNDWVFnRE43R2RSQXN3bU1VTlN0aUVja29EWHps?=
 =?utf-8?B?ZVhlN0lSbFdFYVU4dDFxaWxzbDBUR2ZOYU5kc2FVS2s4QnZ6NzVrdUlhaWRJ?=
 =?utf-8?B?MFdZNnBuSHF5aEtMNzJQUFVMQ2xhblBwMTN1VkYxbFVFdjNDa0ZHMi82SHpw?=
 =?utf-8?B?blNKTC9IaDk0KzIvSzZzUkRVd1pRMVU1ajVsZmY1SG9oYmdmRUFrckxDZlR6?=
 =?utf-8?B?bzExcjhxdm94ZUZ2cjlxdCtVRGtjZkpOVjRHaHFOeE05RWZvK3dkOEVnYlBB?=
 =?utf-8?B?bDlDWGRGbVNkekZBd2xZQmJEMTBYSlhUUlVMTHN1TWhJbmJRTGxBUE1xVHMx?=
 =?utf-8?B?cXlNRjRLMnFhUGVqT2lGSSt5ZUZlTEQvMXQ2cUl6M01SbzhpbEpCWUt1bDBR?=
 =?utf-8?B?bU90ZVhJVU9ZVURzMWxGS0EyTjdGUjNjeHgxU3A5aUFtV01nMkZoM3ZwTmIv?=
 =?utf-8?B?NWZtOTRuUnRoTzlCcExQeHJLcmREdEZUZm5TSEVZc28vZFNiZ1ZzcW9CQStm?=
 =?utf-8?B?bzBkV1liN2IzL2RVT2JiSWNTMGh6d2NwNDRmUXUrU1N3SUhHNW4rR0RPQjNU?=
 =?utf-8?B?cVlkWnAyMWFlQ0cxSkNMZ3ZzU2pRY2JmZDR4c3RUdmpNdUYyVDlXL2xXVVJ5?=
 =?utf-8?B?dlZyS2kyVHZtc1I5WDhlMVFDK0FvRForK2xpNlRuUXBaQS9vTm5VRUVDRXQ0?=
 =?utf-8?B?S0RmeXNjaEFIc0FwMFdXODdSMXdiUnFZV3RUcVdEYS96cmlzWFlYaHhGN2FC?=
 =?utf-8?B?MldMeWluZjBWNHZveFZZbnNpd0d1c1hIdlJDOCtOU1d5VnFWaURqUlFZMVVo?=
 =?utf-8?B?TmFzMVZyQi9vNXJvbUdaSlhaNFBvSS9WZ2V5bmtscStaQTNvYTBiWWNrZlI3?=
 =?utf-8?B?dCtCWERqM1FOYVBTdURsYmkyUXYvdEdvSGVWY3p3VXlGZlZubnRDM2VhaWVS?=
 =?utf-8?B?VEtoZnYzSklPdFNzczhWbzVQSGNITGVwNzgzVWZGMzdkdUNoSjNFd3hCVmpD?=
 =?utf-8?B?MWdZaDZOVHMzc29naUVxMTFvc1dHTnJHSkUyaUUwL2JvdzQ1KzRaMXA4UW9S?=
 =?utf-8?B?M0Frazh6dWRTbERUSDgwMnJwQWhZS3lKVVJYUVhZS2F1elVDemFRaCs5TlJz?=
 =?utf-8?B?Z3lsMVdWRko4WGpQZVIvMDB3YmZoZWJZLzlJNlVPRHpqZCtodHVWVk9WMXBU?=
 =?utf-8?B?b2N3bmt2LzFKZzZLZ2grZVp5MlBOZ3hVV3VidzB6ZG9BbUw1Vm9palhVaFNL?=
 =?utf-8?B?SVRMWHhaWDI4NTZkbXRpOWJxNHZxU2Z2TmFlZzUvdDJzNWYydTM0QVJRb2JP?=
 =?utf-8?B?akpPV1FuK3k0cnRoOFAyRlJKdDJJNlp0ZFZNVXRMajU1Wi9DencwMmg5NHp2?=
 =?utf-8?B?TEJReHVNUGlwdkIrL2FsOE9pektzK2JXNXBuVUtJTFpyZVQxNU9ncXJ5clFF?=
 =?utf-8?B?d3ZNc3Z1VXJTbmpCbTZnNmErZkh3RktsRy9keFU4Uko5OGt4TEM2VlU3N3di?=
 =?utf-8?B?WTdEN2xzczB4Z2hiZjFmUHVUT2ZNQzFwalVXRlVFRHV3QXE0bWZsR1ViMGU0?=
 =?utf-8?B?UkcxUTVvQ2ZrclJ3bEx0WG9wa0ZQTFAybjhFNEpub2tMS0Z4M3pMM2t0Rm1n?=
 =?utf-8?B?K00yNDE1cHgzVXdMU0pFN1Q4Y2grelREZWVhT2lvUmczc2wyZmNhQiszc1JG?=
 =?utf-8?B?VmpWOW0xN2VhYk5mSG1xakk1bWxIanMvWlFiK2hPbTNJem5RaDBHVmM5enZQ?=
 =?utf-8?B?RnptWDlLNnNHM0ZRUE9SUlduVzNlRnRTMXAzREdpaEF0ODdGR0h1cHB3Nnpr?=
 =?utf-8?B?bTNmRUpsVmtaLzdsL0cyQmRUblBrUmlOTXFlYmQwUHNuZW1vR0NzYVRmQWRL?=
 =?utf-8?Q?AaIrbh3vCwxs9/NEOUMcK50=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9360b2-a154-4839-473a-08d9fd4f3a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 19:51:36.9149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5KKxqK8VQsXGIT5Akax9BVqrit3R7bAmobMxCjmDBhitiJP92tmGlg+oYgIvybffRSgqOl0UYdBLemQC0dkig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7640
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBTb3VuZHMgbGlrZSB5b3Ugdm9sdW50ZXJlZCB0byB0ZWFjaCB6b25lZCBzdG9yYWdlIHVzZSAx
MDEuIENhbiB5b3UgdGVhY2ggbWUNCj4gaG93IHRvIGNhbGN1bGF0ZSBhbiBMQkEgb2Zmc2V0IGdp
dmVuIGEgem9uZSBudW1iZXIgd2hlbiB6b25lIGNhcGFjaXR5IGlzIG5vdA0KPiBlcXVhbCB0byB6
b25lIHNpemU/DQoNCnpvbmVzaXplX3BvdyA9IHg7IC8vIGUuZy4sIHggPSAzMiBpZiAyR2lCIFpv
bmUgc2l6ZSAvdyA1MTJCIGJsb2NrIHNpemUNCnpvbmVfaWQgPSB5OyAvLyB2YWxpZCB6b25lIGlk
DQoNCnN0cnVjdCBibGtfem9uZSB6b25lID0gem9uZXNbem9uZV9pZF07IC8vIHpvbmVzIGlzIGEg
bGluZWFyIGFycmF5IG9mIGJsa196b25lIHN0cnVjdHMgdGhhdCBob2xkcyBwZXIgem9uZSBpbmZv
cm1hdGlvbi4NCg0KV2l0aCB0aGF0LCBvbmUgY2FuIGRvIHRoZSBmb2xsb3dpbmcNCjFhKSBmaXJz
dF9sYmFfb2Zfem9uZSA9ICB6b25lX2lkIDw8IHpvbmVzaXplX3BvdzsNCjFiKSBmaXJzdF9sYmFf
b2Zfem9uZSA9IHpvbmUuc3RhcnQ7DQoyYSkgbmV4dF93cml0ZWFibGVfbGJhID0gKHpvbmVpZCA8
PCB6b25lc2l6ZV9wb3cpICsgem9uZS53cDsNCjJiKSBuZXh0X3dyaXRlYWJsZV9sYmEgPSB6b25l
LnN0YXJ0ICsgem9uZS53cDsNCjMpICAgd3JpdGVhYmxlX2xiYXNfbGVmdCA9IHpvbmUubGVuIC0g
em9uZS53cDsNCjQpICAgbGJhc193cml0dGVuID0gem9uZS53cCAtIDE7DQoNCj4gVGhlIHNlY29u
ZCB0aGluZyBJIHdvdWxkIGxpa2UgdG8ga25vdyBpcyB3aGF0IGhhcHBlbnMgd2hlbiBhbiBhcHBs
aWNhdGlvbg0KPiB3YW50cyB0byBtYXAgYW4gb2JqZWN0IHRoYXQgc3BhbnMgbXVsdGlwbGUgY29u
c2VjdXRpdmUgem9uZXMuIERvZXMgdGhlDQo+IGFwcGxpY2F0aW9uIGhhdmUgdG8gYmUgYXdhcmUg
b2YgdGhlIGRpZmZlcmVuY2UgaW4gem9uZSBjYXBhY2l0eSBhbmQgem9uZSBzaXplPw0KDQpUaGUg
em9uZWQgbmFtZXNwYWNlIGNvbW1hbmQgc2V0IHNwZWNpZmljYXRpb24gZG9lcyBub3QgYWxsb3cg
dmFyaWFibGUgem9uZSBzaXplLiBUaGUgem9uZSBzaXplIGlzIGZpeGVkIGZvciBhbGwgem9uZXMg
aW4gYSBuYW1lc3BhY2UuIE9ubHkgdGhlIHpvbmUgY2FwYWNpdHkgaGFzIHRoZSBjYXBhYmlsaXR5
IHRvIGJlIHZhcmlhYmxlLiBVc3VhbGx5LCB0aGUgem9uZSBjYXBhY2l0eSBpcyBmaXhlZCwgSSBo
YXZlIG5vdCB5ZXQgc2VlbiBpbXBsZW1lbnRhdGlvbnMgdGhhdCBoYXZlIHZhcmlhYmxlIHpvbmUg
Y2FwYWNpdGllcy4NCg0KQW4gYXBwbGljYXRpb24gdGhhdCB3YW50cyB0byBwbGFjZSBhIHNpbmds
ZSBvYmplY3QgYWNyb3NzIGEgc2V0IG9mIHpvbmVzIHdvdWxkIGhhdmUgdG8gYmUgZXhwbGljaXRs
eSBoYW5kbGVkIGJ5IHRoZSBhcHBsaWNhdGlvbi4gRS5nLiwgYXMgd2VsbCBhcyB0aGUgYXBwbGlj
YXRpb24sIHNob3VsZCBiZSBhd2FyZSBvZiBhIHpvbmUncyBjYXBhY2l0eSwgaXQgc2hvdWxkIGFs
c28gYmUgYXdhcmUgdGhhdCBpdCBzaG91bGQgcmVzZXQgdGhlIHNldCBvZiB6b25lcyBhbmQgbm90
IGEgc2luZ2xlIHpvbmUuIEkuZS4sIHRoZSBhcHBsaWNhdGlvbiBtdXN0IGFsd2F5cyBiZSBhd2Fy
ZSBvZiB0aGUgem9uZXMgaXQgdXNlcy4NCg0KSG93ZXZlciwgYW4gZW5kLXVzZXIgYXBwbGljYXRp
b24gc2hvdWxkIG5vdCAoaW4gbXkgb3BpbmlvbikgaGF2ZSB0byBkZWFsIHdpdGggdGhpcy4gSXQg
c2hvdWxkIHVzZSBoZWxwZXIgZnVuY3Rpb25zIGZyb20gYSBsaWJyYXJ5IHRoYXQgcHJvdmlkZXMg
dGhlIGFwcHJvcHJpYXRlIGFic3RyYWN0aW9uIHRvIHRoZSBhcHBsaWNhdGlvbiwgc3VjaCB0aGF0
IHRoZSBhcHBsaWNhdGlvbnMgZG9uJ3QgaGF2ZSB0byBjYXJlIGFib3V0IGVpdGhlciBzcGVjaWZp
YyB6b25lIGNhcGFjaXR5L3NpemUsIG9yIG11bHRpcGxlIHJlc2V0cy4gVGhpcyBpcyBzaW1pbGFy
IHRvIGhvdyBmaWxlIHN5c3RlbXMgd29yayB3aXRoIGZpbGUgc3lzdGVtIHNlbWFudGljcy4gRm9y
IGV4YW1wbGUsIGEgZmlsZSBjYW4gc3BhbiBtdWx0aXBsZSBleHRlbnRzIG9uIGRpc2ssIGJ1dCBh
bGwgYW4gYXBwbGljYXRpb24gc2VlcyBpcyB0aGUgZmlsZSBzZW1hbnRpY3MuIA0KDQo=
