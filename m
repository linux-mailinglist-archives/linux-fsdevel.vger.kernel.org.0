Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7698542BA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 11:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiFHJhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 05:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiFHJhQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:37:16 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442B814B648
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654678891; x=1686214891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Mi6ovB41g6ytTJtOstRPIq2UT7MVF8j3P2xcTMmfPOg=;
  b=SSAvsdmixc25rBvali5Xo0s8vYNK/E31+Wp6kU/G9EaoScPVIAIcNVoY
   N5uNMLI4gEncaOqhIWmOHpplqkj3TYNp3BCUdg5M9Ta1FphZjqe4cCKcG
   GshkNQN8SYIMTh0qEQi+K5dhjQLQq/6JB5jZ7E1zn1KQ3IiVxsZ8IpKmk
   9KicFN9Wpt8vwuz087BfANmAwfD23Iu07wkm3OYcKVo6fTZzu6APXcVlj
   gYQAxZKF51Vz2mbwoTSO13GS+Mn7CsW35RGFsxw7UHkrRiU++jYm/ML6P
   pa/VMZ2WYPooJW2qaBYIjhJQB6jvrfi6bsHMFInzZolcRVGIYBKmHTgQM
   A==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="202580445"
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 17:01:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zfbjijf6OktqBfwIVHsQs3DO9fiXUUII4eWWWdWngUP3NSHwbBn1ld3w41gRgAv6VuSMe+T2xRKbP9ZrrulPOydW6hxdMrjeDzfNFFMBdP5aOOp7l1xtOfjLHZ/anuIrEnyfZX08GzQFsIHrdgZ7sMGkeceaNwEH7VPWtYJwrYQDhaSoCixDD37RUnmVLPSDoVo8Zj3CMYZ76Eahi7ERWz1VzO5QIXa6OeZYXYKVS6iLg9HOtjwYEV2FiSQUBeAAgjtsjGNlhA7l2xenQ4XlAAricvaa7IVbhJN6HCiFUNgJcIGqG27JwypWZIyieehc/tMStKdjF2Z/fdjsn4723A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi6ovB41g6ytTJtOstRPIq2UT7MVF8j3P2xcTMmfPOg=;
 b=PrTVVvst9nuMkaz6aL15WKkIpg53MhUjoIaCjeYJvP80cR7rFANyKHK5Db5U5oWn858o2Gk/IV0ghqYPLGDZkyv/Dl6Y7HX7aQyxKKB0osrXQzELJxSW2DFUsOMwl+WjkIkd7JqnaMRGN35iv1XMXPB/leVSNnunLgVk8dg+EweAV+qSH0ahcg6PhttVD7dZexM/FcCXrgmIyrxJSc8UClC73PFlzQ3Dzy8fJte9MikMbRVRVAn1WNKhxKUf8OGUPQHc50+SkcmEOgdjTMtYo6ApQMOtcZ0xGL8HC49uc3P2VjEtBW1qsNuWQJKM6l3Pc2ihJNOfVUMODaWKvlVTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi6ovB41g6ytTJtOstRPIq2UT7MVF8j3P2xcTMmfPOg=;
 b=kQ7qXfhkH9skmMbLKbf4W20j84gXVKk11I3Pu4XwzMX3J0I8j9VuMI/lUuK6fMSdx6Po4scca+AlT4UIGQ1B9FzYjFmIPlaFCBSLwdfk8RZcLWwRgFmzqMjL8gbqYsrjxKJ7a3ZtmcCBgUG6zZkCN82Kjk7chwEdiYy1nquyjPU=
Received: from SN4PR0401MB3582.namprd04.prod.outlook.com
 (2603:10b6:803:4c::10) by SA0PR04MB7147.namprd04.prod.outlook.com
 (2603:10b6:806:ef::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 8 Jun
 2022 09:01:29 +0000
Received: from SN4PR0401MB3582.namprd04.prod.outlook.com
 ([fe80::f8ca:eb91:bb23:af76]) by SN4PR0401MB3582.namprd04.prod.outlook.com
 ([fe80::f8ca:eb91:bb23:af76%6]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 09:01:29 +0000
From:   =?iso-8859-1?Q?J=F8rgen_Hansen?= <Jorgen.Hansen@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/3] zonefs: fix zonefs_iomap_begin() for reads
Thread-Topic: [PATCH v2 3/3] zonefs: fix zonefs_iomap_begin() for reads
Thread-Index: AQHYewTJ8mtkLdG8bEebCxeJ0HaDE61FNqMA
Date:   Wed, 8 Jun 2022 09:01:29 +0000
Message-ID: <3FCADC5D-BB6E-44D3-BF1A-0CC3C0D7A4F5@wdc.com>
References: <20220608045627.142408-1-damien.lemoal@opensource.wdc.com>
 <20220608045627.142408-4-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220608045627.142408-4-damien.lemoal@opensource.wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfeba7d0-aecb-46b9-cbd3-08da492d79c2
x-ms-traffictypediagnostic: SA0PR04MB7147:EE_
x-microsoft-antispam-prvs: <SA0PR04MB714772A6765D7FAD065835A1EFA49@SA0PR04MB7147.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKrJqw/VOMte6EusJ5edT7jYXz72PF+rgM4JGCZvqE2CwbBy8TF8scnlS0IBL/JMUU2SWlykywjtI4tztXCw7PFq/odL7WZQ666dUPzWdqXS6zf6LyGsNh9gDprVeLs2TSS2ZCImuV4faK+r9f8Ly92hxQiHPIjLoXyyPOwEXLS+4PDpZtwn6r5Z8n57x5oMDBqX9uHaOHNXOp0U0ENULTKVkJwspwr+Hkx2mbiP0Ckv+0FOIDL/3zQgMJJP+elnikwTJ3c4PTwPRJ/l+0x3rTGldCMlFpUBhrvNVcFfKg1Pv8FisWDaG9lJQFD8521oO3FD8kRLncCmmaOoP/YoNBfSf/P1wMRKktXhtA83YKX9YSKIUvd1V4NVQHAW/yaMZYp0xQwsgvECmCjPaikaYxJ0bYJPMeyA8Vm3ZQPAPDrKk5YQ5fWS3g7JLylVZd6TSLh4aLwAn3drKJh0iRyp3yXZgJpL/+qPSSAL+pwnVt1gbaSH28fgesPg1A/rDDnIPvU225AQX8A4T+AwGa7htzjbMxAgD/k7hA15UzsTDaJKY17L5InYN4ypLKUDGQn6DMJ5kzWKwQeQk6bdSeOMiW7LtX8KXoK1Nq8z9/lHG1dDdKC4h2ZTcNAU7XxEiG5YxNujy5gyKwFpIA258HGVDzF8kur9x25ku7uCnIm6pJlpBvMV74q8JopF9xNlrg5zf5QgYvlJPnwh2URvwSieVNZrlHSKtevHBltTNDXAQZs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3582.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(38070700005)(6486002)(4326008)(91956017)(76116006)(8676002)(71200400001)(122000001)(186003)(82960400001)(38100700002)(33656002)(86362001)(316002)(54906003)(66476007)(64756008)(66446008)(8936002)(6862004)(508600001)(83380400001)(5660300002)(66946007)(66556008)(558084003)(6506007)(6512007)(26005)(2906002)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZkzCvGQu9CLEy2UDMKcaYqn4A6aMKzEfdyO3rNaS/EjHQDRd6dWCrEEpKn?=
 =?iso-8859-1?Q?tkBSsgZiA3L/xP3f33D2P9plKu01KDugY6GJbAZBluBQyogP2KgjG56sla?=
 =?iso-8859-1?Q?kSHcz/jlXhGMZM/ofQkv3ZOoTz2C9YZyQHvKzRBUM9ycRnjWAHUU4K+ZGd?=
 =?iso-8859-1?Q?R61R2J2SNofb21sDD+POcC4DKiLHqqHqx574M59088jSXi8mz27F7xJZap?=
 =?iso-8859-1?Q?MMZuzIADVUcPbUgmgpBF5O9XUz0u8Lo3p8N55kAayhOge7lVkMQJH9YkF4?=
 =?iso-8859-1?Q?W5AHSKrAGxUbAAEGzgF4qSrW6IQisno00BLzTCiBLrxqXE+BMaa+vFJMrT?=
 =?iso-8859-1?Q?y1/M9p4FI7Ftc4X47uIqbCMHnxtdfC+eHTWlACRb4PYYO66DuQ0VYhXsSS?=
 =?iso-8859-1?Q?px9aQOAwWCNiYIgY9fpz6ysq9wMjtFp1yS1f9jEtC7khyMWXO7G4m2oL2b?=
 =?iso-8859-1?Q?wJtnWDG3kS/4VPqKwFTyT+o8dUsXKyCldA1OexA57cr2U6oHpb7vbsrKJ3?=
 =?iso-8859-1?Q?LO1fNqq0x4kZvuADF2mQ8COq0nhXItBKj3+OdkhbccVTmktKbK7yU/8/O+?=
 =?iso-8859-1?Q?un2g3lVWYW+htitCj52dQJaPqJXwxqWGMwZiNST8Yc7JpRS8IItn5neTys?=
 =?iso-8859-1?Q?pTv3AW4tl4L3ASd5e3Ffoa7VzajfsXBQc7JXDC2SsIii295rXNcwI/KhwJ?=
 =?iso-8859-1?Q?GtkTe08A+rgM41STXow8deEB2dnbjQVvOTDiPRR+7zPPhmTF8JQyoNpVIU?=
 =?iso-8859-1?Q?iClU3N3GC6+dy7e6IhE4NVanwpNQ2Ly4NYLNAnAQk2VLxhA76qsD6vS040?=
 =?iso-8859-1?Q?Iq5GoJvNlHw5VUJnFsmw96MeB6I8rgc/uoSiCCVemLHFkwUcWfYd5ORb2E?=
 =?iso-8859-1?Q?RZdmttfucW5nEvBFQ8kRd8sqfZxwgUpPPx3V9dmWvTfuiCXnYEnxMhQQJL?=
 =?iso-8859-1?Q?7iqnnUPm2Xo2a995hfXHpJO4jmf7vjdm9jCgs2pZ46h2RKWyGEUmmlZo3Q?=
 =?iso-8859-1?Q?lGEzkqNq2jpJOKrUEneAdJprkMGUZCNgBgy/Wf1F8dFCenAEMcPr/Ee/1H?=
 =?iso-8859-1?Q?E9IY1qH1cgygBWQlNmAto3KhD7IlS3yd6RJqt1LO6h0Zgwr0opTgSNdKva?=
 =?iso-8859-1?Q?t6jE4ztBv+WtY+FuKZC3MyqLqwYnj2P7M1HRZk6S+OX79Omu7XbwRANhUV?=
 =?iso-8859-1?Q?ujPAWReYTv/Tuo+TM93fmYPcTQQTA/WqhOau8XNkRFsckLojRONfbYtimD?=
 =?iso-8859-1?Q?309oo2FY0krqaVg/NeLZUPdqosI1Hv3yNe6DR/B40q2Y3ut+UB/HF6mRLW?=
 =?iso-8859-1?Q?z61JOK++NSelODkSAQ1bkyzvDBPSXNMNcp90eaHE52rrL5Q1NsVb3lluGF?=
 =?iso-8859-1?Q?Lp+09l1S5qEw1v5BBaLzlK+Q7heVT7MuwK+BJMKOesEaP1k7RTE7UcaKx7?=
 =?iso-8859-1?Q?Mw/zWhXMm5FL+wWQzSd3uC9eim92pU9cVJy+2h/5KB/rMAfpAiOYCB6KGx?=
 =?iso-8859-1?Q?IXigzP5+dLgh39seKI1ftBVYFQdb8rNlF4ntE3hvZJzNsVXicFSkd2mkuf?=
 =?iso-8859-1?Q?vB3MqarLv840cANrwBUEv6wLH8xAhz38BVA21H3yWyc6Yub8lNV5o7N+V0?=
 =?iso-8859-1?Q?h8rOxo/Ig3oFGwbT5wf6DZuwzgtxgYf8nb4O76FQIFO8qTjJqrQZxERl0N?=
 =?iso-8859-1?Q?NLiJtAqiEOACfFzOloxmXhtBlruYPK5+CLz6MwdPMuXTZ2G6Mesw0iC7a8?=
 =?iso-8859-1?Q?s9Zsdor+vBplMIc03uDmKVPNSYEQlze9vTlo5SqtxCLg1st8QvVScGQt9c?=
 =?iso-8859-1?Q?men9fEHq8UbBLYa0B9yNu7txfWs6+zI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <63C637A3124E3C47B7D251D9F6B25ACD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3582.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfeba7d0-aecb-46b9-cbd3-08da492d79c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 09:01:29.1043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7N7ybN7qopp8M10Bf+xFq1E3ZKSwXXoTFidEZh584w+j0aSg3Auct3VFKlqHsPkX4R1nY8VJP0HaO7oKLx/UPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7147
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the fix. I also verified that this resolves the issue, I encount=
ered originally.

Reviewed-by: Jorgen Hansen <Jorgen.Hansen@wdc.com>

