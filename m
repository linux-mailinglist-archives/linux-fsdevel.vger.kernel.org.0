Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF605508650
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 12:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377797AbiDTKvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 06:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiDTKvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:51:11 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF8813F42
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650451705; x=1681987705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
  b=IjLSwKX9grq4p5MKG+K+4yfiUIWYwDbzqufA+gCg/5WYBpA2piE1fgpa
   DFSBV6LhIR78LbYZCyfJfPHX5GGinEwTIw42hETLTvditZF3+ZJdyoeLW
   H327PPa7MFFQaQg5sArm1EeuE2mfPVpjsagpWNa5FFt/ULkZI3Az7Oq4h
   JgKOQ9QrAR1e0tyjXMwCdDE6oHacw7U6rr6PQ5X+NrXUer2HkB2q9U3Qi
   Cfe4FK7NuVPjx+188+wMY9OzZHBLS3VujITqlFHBmN97mpZwefVJzeDda
   Iip7hjkYozgFf2T5MXgMKvvyGetDA6OAOxXFeiInRAGsoUY3jgTQymIoV
   w==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="310326944"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 18:48:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaOO8V5m9e/CWX77ZNev+SNpEZ29eta9TWp3NH7OiabLCh8YlgiO38JwOPodtsHdpuMXMWNS2RiQk7sK4mX4XhgnrQUFmtH0LxDMFkV8wXUoRvS65LDAHa/00zRtHyaa3QAHFXXd4YAT9hRHZc2iJO+2ukbTMir6jiNl/ChvdwGYOJsdBAyCL/GJ5EW9sd/GtMBmDkbmrKLvD1DY6UjojCbMY4CPTYugnWZsgsnPWpsYVror7BZ/pIjX392YJcge8jb5X2vMiGlpLw9bh5a1S2PGdfcBZTS5mm/IE6vfBhDSjQArOIybZJ8yuFzF5I0NBh0ZZ2CRs9LF2JSiX5WO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
 b=b9vjrsiDgP2KoKGTiXNtzo1PZ5lVgrlJHncfNMwyT/qwC1uTYBx46WjQrd1MJKVmmpZDMHeTMcFeH4gvXohXkJtJ/APPaVzINkGau5G7JwzNVGfa4TfkxfZVmh+X4Ejt1LzgEtDn5jasHUxLay9iGZGfU0sb3R4sYCtbGaY3XlDIK/SRN1k3caud7fMLKIcFxccty4QXtqNLdu9x494kw69EJgpUIuRzDzfKydZu6Icn1N/4ChpXBHv3asCoVdq+v18Mg2jJ9XH4BEnhcqxt/v8j+Rk3OnjAty5A6hZSyenZMynt/TQJzFGne4Q45FSYvx+bBNRsy8gme3b5+4mkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
 b=UdQuKFxB0FBKAjYZZvwEQy3HW+kneQ+ug/TUu2JHuGyA3eNCyrJiddDHVEjDn8wVAoEFLeJ30ObmtgJYZfsCI/joF0ScPnxfCQNtVVh0BxuA/GNv3N+2nHOBXJQtFqs9nbseRvEUFlazX3rAXHgNv8T8SbprIP4gIjhNseoKOsc=
Received: from BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27)
 by DM6PR04MB6623.namprd04.prod.outlook.com (2603:10b6:5:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 10:48:17 +0000
Received: from BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2]) by BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2%7]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 10:48:17 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 3/8] zonefs: Rename super block information fields
Thread-Topic: [PATCH v2 3/8] zonefs: Rename super block information fields
Thread-Index: AQHYVGAFfly7sLUgk0CLhDmOS8Ezwaz4n4cA
Date:   Wed, 20 Apr 2022 10:48:17 +0000
Message-ID: <20220420104816.GA36533@gsv>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
 <20220420023545.3814998-4-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220420023545.3814998-4-damien.lemoal@opensource.wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db71098a-8664-4b22-6db7-08da22bb4745
x-ms-traffictypediagnostic: DM6PR04MB6623:EE_
x-microsoft-antispam-prvs: <DM6PR04MB6623BB35E7D81911D07460F2EBF59@DM6PR04MB6623.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yIgMT4qvGYLq+BDEBK8B0y9ES6Vwz/BMR1hvd95O8MIYgtV4djpLgQs/Z9WigbdlzTFzBDncss1wdU3gqgzFMjBCqXXKI2NomhCoIQ4elYf7PMNvpTKLXjXXcBXrth+bFioOcjiLKomWp/41Kwtwk0WPf5f7d3Qv+PweU8EH8500X5tGIpzXqsK2W+5WPWs89NL6jkGIrNH89o4HGlm2RDISijIcwbKxaRNOghCdIKTZVttqiaf7oKy6rkfDB2S4RNs3DaUezfb+oByE4M4bVsgoIq4BMW8/q2HFwjwnOxVU+Pz88Y0uk76/++JlByH4ZA20Ny+wi57eVV1bAs6/eZU3b0Ir8Pm8fn8/kNpI/CVUifASvTNPHPuAQ78jnRbAreZeKreD7qO7JTN8x4YcONII20Cb6QqytKfvTXLlu+BYs3bgZqjN8kIGgYe5bsqqkaL934JcAanDE6egrFAsbTXdwDGf74cFAcY9qeoioXDB6YljYOF+Zg3uOrTRgKgifrKB2bX//BCWDfBMf3x4YlzAJ34fkf3NUFHO8P3AWdbFr8X5Yv4TG6IEm2pvJL1hl9a9nN7EOt+schu40BnVLmmHJoA926pVQzL9cxPR857lw30KRWQOMwyiWaWpc3v6iUEQWmDcVBYEQx8clSUqX6lfg6gzWXQS0dVYvaCZLp5czAd9I0B38I/Zufs+kxKTAcDEF1SuKO04ZDYHl9jxrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4296.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(38070700005)(5660300002)(508600001)(1076003)(6862004)(4270600006)(122000001)(2906002)(186003)(9686003)(26005)(64756008)(33716001)(82960400001)(6506007)(86362001)(6512007)(76116006)(6486002)(54906003)(558084003)(66556008)(316002)(66946007)(38100700002)(33656002)(66446008)(91956017)(8676002)(4326008)(8936002)(66476007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QUfNQ1r0MaMtOq8yZu43A8cxhyZp9oGZFxw9ir8uVumcueGtOkX95QckdN1q?=
 =?us-ascii?Q?cJSC3ATVi4b5LcLDNt5WJ+cXxW1IJ7P3MwfTRL4S/xuGl6kW1b3WiU8+MnHr?=
 =?us-ascii?Q?oUaTtbmGcwXU6tj312xIcX1VOdgxKGfSMaeg7rykID0+jUgWR/pjbwMUhAbL?=
 =?us-ascii?Q?NT/U9DIyR2NDBIFXO/NoEXblE18UD1PaXu7IGpOAxu3XH2A3QzScBETJAeNo?=
 =?us-ascii?Q?zhJa4U52CzaTI9oGQWFmq9lar2XvmIr6acDOi5reEkSAZfO7dJsik4TGzoMh?=
 =?us-ascii?Q?+Sea+N1a7EyWua6/6dI+and0Iqw/F0l4BbCAbC/N5FuAbCcUjn9odL/1by0G?=
 =?us-ascii?Q?Mf0kYHWexSnHgSeevuRNZ21DS0jd/pz59bCa1zunN0KOVEDB3BvWYAYyTkF9?=
 =?us-ascii?Q?PCHO+xS/JIKQKUiBg+IfVLeDdDdMOfUTRVKxVmikc90vvOmZl+wkV2wTh5cZ?=
 =?us-ascii?Q?v/z8A11t/JScdhDH3Dqh7iPeb2qhXU0twIgz6Zk0G1fVG9xopxMRjvhPpast?=
 =?us-ascii?Q?gYiUulcTt0tzLAoQbasBX5GXPmyl81x2lvK8uYqI+07JfDnXG+GELIK+zCeE?=
 =?us-ascii?Q?Rq1EuIILTegErD5ExFLFC+xXBLbcl4N5m0M8m9eE/3+c6tXN21Pda6xwWT5N?=
 =?us-ascii?Q?mf1EbCOw4opCcudSeopTo1DUiUBMYKto1g6+EuP5liBz+FfXzAwj89ctbgAH?=
 =?us-ascii?Q?kv4yeRB7Cr+XYiN6c8n9k8ONHUy0NIeTi4w53N6apaZTPDV0YUKCzNxPWW9R?=
 =?us-ascii?Q?wPDhN6XcLnuxah49wJRxBPmTxi4njZ9whwe7nTcDclIlXRwjArb+T65bOp1T?=
 =?us-ascii?Q?0/YKBVUzQlO5fKgX3rOpzqIQ1nuhKWAU1cHhQUFRXK2UvsqMBrqj9IgRslZ/?=
 =?us-ascii?Q?oaQ7Ki4A4tWaugFpH1vDxVs541fNxlqQHwxWiqGcU7rAalolO8n5LKpTQWe8?=
 =?us-ascii?Q?CccHEPscS6Hng5+iJfAPXpYM4oeHCsLk76zJEPF4XoZvsq7KDq9sh56YwtOI?=
 =?us-ascii?Q?aHu2kJ+f1iMlK9Q+FeILk2z6AJhjMDbxdqTr4One25KwqQCV5GkLO8hg1SqZ?=
 =?us-ascii?Q?f9TC96WuTcQm/6FtJ4ODwH5nhWjhfa4F6Kxn4uFGEVvK0cn7BNC2xJzrD0QJ?=
 =?us-ascii?Q?YNNe662lx573Xqky7yxHm7V65qp9DwTYo1gBOzgaIwXhOlvKvCmHSgjo3kjR?=
 =?us-ascii?Q?W8ovifH1ZjYtPJ3b35XcxfP/PN0BbsgLpANv0P1kfcMLRbW/35Pg5yNE3IqD?=
 =?us-ascii?Q?etA68F2CU7RJO3Z2x8UssqxAMeljgbAPypFkRPivnNGxnGW6386zWA+f2znB?=
 =?us-ascii?Q?+LwsB4xjrL9p4JYD/uSI0m8upP+sZiwdpX2RkpFX9oTM3rTXOnAyxlImsA0i?=
 =?us-ascii?Q?rE6ftM47yfQ8A/55tUsIFTnqWE+lKpEj13FsqQIyUgfndrJl2bpwA8ofhdHM?=
 =?us-ascii?Q?8yBoyrNO4GwzR4hB0xEuuJqehyOEeCLgWbAGgKnPm64uaAeWwLTEKo27VNBf?=
 =?us-ascii?Q?49h8Q0ljQ5fPvL7nWqY9IHKI0I8vsCjKjYKfnDujbH4nM8tMWHCuAqjKSBqx?=
 =?us-ascii?Q?17JaSH7bbbBBp/K9uZL1OQpbUyUXeAlJGveLM3MyPO2jMYfOnTgWocyZYn3C?=
 =?us-ascii?Q?dKKl3Ncw3upqkiQ92SkVWrLv0razuAoYYYVvYLkms8aR7XO2Hr0hSZyNBoFp?=
 =?us-ascii?Q?rJ8Ih92QgeltvM9cVoouhrfJkKtGWYmaD+sRQatP+2atGU2o/mFPw1+SmoAt?=
 =?us-ascii?Q?gukP22As6fXarhqlbrv/3eWKzwMPOdc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8DBE649482CE848B30673F545D02613@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4296.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db71098a-8664-4b22-6db7-08da22bb4745
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 10:48:17.5995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCkA66kAYsfh8PmiFS4jDUsLchGUGLt+VZRf1+EBZIrxidcYP1ZdPHun71DM49Je4cwGkli9IspHMUp2RsI5Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6623
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good to me,
Reviewed-by: Hans Holmberg <hans.holmberg@wdc.com>
