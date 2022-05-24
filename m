Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07D653230F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 08:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiEXGYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 02:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiEXGYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 02:24:21 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B586C544;
        Mon, 23 May 2022 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653373461; x=1684909461;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=h8awxSKt1yvhhtgaUWnfFanpR6QdisPHEkzw/6SkWrX8JIcFCas/x7vF
   0M95yhHd+UE1eNKSNlWc53n+u52ZUlBCGtAfD7Bo8FBK7ZgtpAc7RnNX+
   cpZsCGDu2XrU/X68OB3zEaaOFITunD5tX4rm30grQOrhzMRREIaFRpuP+
   ouB4ZoGnBCS3JiJCrBdtbH2x88+9dRS3W67SbQhXOBrL6SsNovIjoe8Yg
   zda5/EKZhJ3+mjBcRv65plYUhrcF2i1tx5N4Z+GsSv3YxrhNcU/mqJYx9
   CzsMheeL0XkV1faqn5vWMXr+4OojuwHGAAfVuWKB+ALcDmV23ddnXxlMh
   A==;
X-IronPort-AV: E=Sophos;i="5.91,248,1647273600"; 
   d="scan'208";a="313248374"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2022 14:24:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrffhNwsCkdQ9ChesxjCgT9IJqWqmP8/5NNYG8Mn6HyponceZC1FTv3CSt27KF85zdyM2UjGHyFt+2MdyHKWLoS2gWo41InpnD8t4Uzm90zoJ2+w6UFASrsitZVRPUS0/7YOYqLkogXVouUZkTX+3cNjNuDRnH3v6InbPRvl5kUXt9ayCmG9M1JidXnSKk8o/tWUXSPCwQJdNUzQsomKwbxy25sbUhcYimC5h2IngeuZ3PxBgojthxjaXE85h5qXvjPQXkptbkNEPDs58nWK6dymnMWT9gFSQbpSqKS5q7hF7LDCOWt/9xYBWMaVarqwoPAye1MWjw4n14oLxbfEsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=M2WhKbk9H+Xd74a12kUrf3r1jIb0LYBjk4DVfCx65Q5hk6GsQWuR7kLFeXEHvMyQaEfuEFobJJoM0od1SdJnej+98znYfXH6k/YiLsvI+K79CMbKqSJVK3+bB8ivqcjt3CEfQwI4HtHNWRRpWn5eEqd9GWG+1kPHB5JRgSd37zKXD6XmCTgzV/BVZhujw7U42ydJ7Lem+02n/uN/nJaBswgB9d/bccPl4Wl+BEXA9AZ/t3KcIBD/uRKcHOu0frKfmd2V9cyUIp9Idy1fFyxcp7+AG3bgrJUA+Jz/0rfsvILv3io09ylziV41TFiH9Xo/4SdBXKNMlPiNMNISaAvOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bgo+7Y5ZG18raiMIH9HJCdDykRR91RfKIGjQtFmUkcakDqRdkfHGblIK1rfbxHP2HJABxF1HBIt9PaJUde3VmN1fuHrXBr5JfCJpq/N5xXFpl7N7/i9h0yBJRAJ4u2nu9SkiR1md3hXXqywIszLPxDd4vP66ijQxzfrVyt9WmkM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6879.namprd04.prod.outlook.com (2603:10b6:208:1f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 06:24:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 06:24:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Keith Busch <kbusch@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Kernel Team <Kernel-team@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/6] block/bio: remove duplicate append pages code
Thread-Topic: [PATCHv3 1/6] block/bio: remove duplicate append pages code
Thread-Index: AQHYbuhdKx+IZk9PD0i6Lastm8QuZg==
Date:   Tue, 24 May 2022 06:24:17 +0000
Message-ID: <PH0PR04MB741612B9B9A98F31634DB8339BD79@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-2-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69a44874-4a0a-407c-ef4c-08da3d4e07bf
x-ms-traffictypediagnostic: MN2PR04MB6879:EE_
x-microsoft-antispam-prvs: <MN2PR04MB687938A4B65AC9073E282BCD9BD79@MN2PR04MB6879.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MrTuzRxsSSH6yLcQoXcBxwdmAbgl8X51vk9T0A6sw6eOageWBC9sbg6JDx+K+oo2nNxIs3ktgh3W7BgBeExSGxtkKP2wX5hOGZpYwvOTmpj/tTzk1X+vkzGal2XGhXXFZL0iNEbp+yzLZsFlkeimS8ObPQ8qDjFg65StUZUkR/2oICw2gPTp2uMlmGh0N8lDJAKZ/cIB+fqhkveZNzI/qLlUfwCUpi54eNrTTGkUQeS9XzOi9o+QDQDtPzbasMzkeJErfrpxe2WSUqeZC8K0XTj2ePpVJJtjAy1wU99j036DD96eCZKYl6z2tl0snCxRPxKc2F5uzk/4zXSMvJce8xNeu/Aqfm/yxKSitx5enfWX2JZoVoKVqb89f06GtNDb+ehsAfUZB+5k4/CvuWZu+3ssCJQC1QmijiWSCJ+D2bELM6ruauKtKVQIeTyobcrg6OMCBHHRrf0a//YIE5MJCCvEFUZ7AgKdeiWPYMbQPXcOR+ep8uJDmHt66OHbr0omwSV/dTqhM0a4/djQTHGK6E8eXScXa/vBLQGLJfMqZIkpyj6lpH7yIrt8273Fnm4RZyDL3198fh0OoZ4EaovMcwp1B1yQLNgR416uxRbtELLstjJ5+Ra5HX+Eg+eRIVipYX3KPcEC/C1LvexJnWFpC0uJVds9IrKnw2JVtAEvurt2Or9N00ajAAs5MmOj/+b+aYcMybLxrzpuaUYo92Fqyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(82960400001)(33656002)(122000001)(508600001)(38070700005)(26005)(9686003)(7696005)(71200400001)(55016003)(558084003)(38100700002)(86362001)(64756008)(76116006)(91956017)(4270600006)(19618925003)(52536014)(5660300002)(316002)(66556008)(66446008)(110136005)(66476007)(2906002)(8936002)(66946007)(54906003)(186003)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XOPKgRW8c5Y5f0b6VHheuIE2VbrzeKOJxq7Tf3u5AtVF7incbYA2ELOx061e?=
 =?us-ascii?Q?vKQ41NEhL1XPXX94/o/lJg+bFyzOJOX6DM3BY7w/o29t4SpUrqBbzNFyRD0q?=
 =?us-ascii?Q?i8L1aXA974J1b8dgkgkKEw25vZdhT9aIjaecCIZur5K61GqKytEVM7NsA1+y?=
 =?us-ascii?Q?KmmJG9RP2veXhrRl3/LLc4TXMynMOcYNwnkpbF8FJDcrsc1RMDPFQPIyqWiO?=
 =?us-ascii?Q?xt9fDr6kbZFyW5hfOXneYqi6SPibo7+pmFZ8eYhh58i4io1rDLfx/Pc4bccJ?=
 =?us-ascii?Q?7eaJuhMP7i8xCbUkV/Hli14uA+FtHQnFUyxeVTV+87jSDvbUo8715vx2x4F1?=
 =?us-ascii?Q?nPayuYAGiX5xzAd5QVjCOw03neqAz69yO/HRfwrpeWzZHhJdD/bo9rfyWKf6?=
 =?us-ascii?Q?EnbpuYqIxwuIrX97GvQrnc4A+P08SkyGDvScl0tUCUw5mtjf4ql9+kRBT1k0?=
 =?us-ascii?Q?buHZA0MIIefMboYizzZJbhHWFjL9QbqfD3JhJ+cZ77j2qmoZeGPSZGndXqC+?=
 =?us-ascii?Q?iOd7AqCTSiAx01r0Rey+asV3J8KJZ7CYMenG66SiMu0gs9O6rHmryPWyVxrX?=
 =?us-ascii?Q?RLokbHpDYlEU7M5LhSp8Ra6PDhlGM4bi/3usOQKKuT/oga1jnewNTZZioCvr?=
 =?us-ascii?Q?0PaAJCd6XmhlrmPYaFuWkoTmjL/gfBm+lfqYFazXE3PFqUEDJHzSoAc4YzkB?=
 =?us-ascii?Q?zpUNp9C9W73MqmrBv37qMMcP4I7kLyPJWSrm+xkr/NYFKQczaccw3BKHxQa2?=
 =?us-ascii?Q?leflbY3ePXuNuPvUogH1NZZneskY8Kbt9IsnkqzVN6AX5klS3A8Glcc92FXN?=
 =?us-ascii?Q?pbgXTjbA1WIeU3iI2lRsWEw9EgKHmJhtyui5WZ+SLKNd+bIDlZzEkAPDGkCN?=
 =?us-ascii?Q?c6coeBIKZPZ/eNCKiHGYqHfVOtDXC28s8W+YrBEHssxuh7ZRru2LLPHEW7EC?=
 =?us-ascii?Q?m5o1M4mYDNk3s227fOpIqvDCReZ+4tSKRq4CiueQn7d2auVGWKjqTFc3U5GY?=
 =?us-ascii?Q?39SfEYmsJ1ZXlNCp+y+bNjl2T7XcDiSkOMCzZElzMjaO/wekBUpgFCi30zMX?=
 =?us-ascii?Q?MWaNMaT6775LymfaIY+yjmYnQqiCjZ87ubUra+9ny+jRo3f/+9iEvX0brVJj?=
 =?us-ascii?Q?asD3R04ouZ9TMxK8Lx347+lIsBhus1Fm4Zl7ezbxV5k8ZdevwSkQPrMf5GWR?=
 =?us-ascii?Q?tfY3mRMxQQEPw2itG8u9pL8nqn8ILkUlT3LTsErN3R6vLvzVtz0S/pTn7TNS?=
 =?us-ascii?Q?3f+HG/MpVvNUPLlkJiKk6eaWdl2c5UwKOh9+A7YuCfAN07pDuyFsK6dxv7BM?=
 =?us-ascii?Q?QvAKOhvowIbLGQD6TQtxdQxL3PA4RAU5XzFSjMtuKEdKprDUucCRYHIjYevw?=
 =?us-ascii?Q?+6GlMW9P2HaJB5N+q4Ne2qjkgX6xnVAvyhABK7flxJoBbGxZ6spGnHE9B5Qn?=
 =?us-ascii?Q?MOcWPOeA6AkYn9txVeInE5YiXs6mDKqMiFmMTLk9epkZjNBI0b0tEL4zihWs?=
 =?us-ascii?Q?0zGCTs9q1yERcClflXuFqvVmULmtx8rpvkAc/JKRzMJapS0M3dFG9BXsjAie?=
 =?us-ascii?Q?iJNOVu/hThl1j4NzD36p9udzWXVz+4eo1FJ+KBNDFN3H+WQ6liMqjfp3kdsI?=
 =?us-ascii?Q?7SQiag4svejuHGU36Ejz50hEuZ2uJUWrjEgOi6MVl/iCY/eN39JljkDoOIEY?=
 =?us-ascii?Q?FjKmnlTvRyg/wQQA5r1HdA7IenkuAz8LaklmU9nAvCIF63GDTpuOg5YdHHmG?=
 =?us-ascii?Q?PKJ87GYZb8CSm/hTgwLk3jJUaa2Q7awq3gMRMqp6/zI5XJE68ai6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a44874-4a0a-407c-ef4c-08da3d4e07bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 06:24:17.2484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdxazvfAjRlfPW9rvCsD4ucvqsVoT+N2zjS08oMtazqCl4ZFn5YypT4/pTGlttiPqRdMBKmjbYXR8TmdZYnz5KMfU8C9VSpjSRr49P+N+qM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6879
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
