Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2583E482C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhHIO4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 10:56:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44954 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhHIO4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628520961; x=1660056961;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=JvQrsVPY2FhRR1h++yG25uTnNjwEygvOG7+5O+XD13nj2jTuiUsQ/GRM
   pwDEFHWL5us8tB0+g+UMoI1I8i3AAP9mnQr2pH4oxxL5pX1uvbDo75NxE
   ZX7SRuKUVRwYVfJmHKI7Zk19cvJaOG/lvorUBo9vq7LGSa++nVS8vytvm
   D/j7xdb/0FK9hD9ykPnvRfiLvRjCpYXXDgWbXg1C6/hBWv4dL7hP2jkk7
   HRnyNq5Mt9RTD/ljW+D7qUswjR3hGWGokaszjDIP9WoZZUycHgNBoj0zU
   Y5NrrF/RMrG6K5UcMFf9Yncu+wk4pkE5YG/VgPfVUW5HkiwkCFojyChlb
   w==;
X-IronPort-AV: E=Sophos;i="5.84,307,1620662400"; 
   d="scan'208";a="175899219"
Received: from mail-dm3nam07lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 22:55:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeNOajuk7pMF0xVirSa7ae+NWy+xxuGXO1WzLouGuA9yhqbGfGYYG0Efm66kiitZPZ2F/SKiflzLszOaPsSM84eLhDvd/5cL5a9hTSip+Oscj+//q3AiNr8b7/v6A6tbXCtuTBSGPlkPX09Qz7BMhwKyxGaKVXm3F/bsx0ODY1/6Kn2j24YLet3Bntpe9TRNq/N0QAyZXnkScGIPFz4JHxAnx9sS98WknJx4wVDLoP0WnTZhOjSq9CHY9ovaH2QHRjCTAIQkhtWy6wF1xFpv4RWrI67D/37RG+nwvz2SuDOp0/huxElwQ5puFs2CobUA2iXTH0m45uwf4FvbxoUEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=HnmpJjZCGh5VyEAp7qFZnxtsI1vTuELGu4DMsHw0NYL9iR4g0lfo+eMGOGoRJJSoAXtg+t2b/bFy1EYOH0yW3Luw9EPxPGWFHCWsarzUKpO52r2u2NzEsZ4KFq5YpkT77qSPKsl8bYPBNRUKVV5bXvIaRio+atlVrybfSly8EUxdLkqXk6op6KD5+eijwo/nzEdyL1UQCe3H+4ddnAay/ZrSD02a+zjkIZ+JzfasQwcbB968D601VR+XJ/h/7vg9af6+cpyNLnPtPbG1k7iYAAVpyQD5jxTXWyGut0PStqU+d0Efle/1LpS5ftJf14BzwEYnqHUzmBq2ESKrN5tgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=km8myhN5JcF51gV18iqi/5QjKm8HqhHs/GV2mQq6Wsmp0dw4E6uF1fhCG2vqOq3G0uS7lhyrAOF/oJPs4JR17OnzjSTC1PkjJqklikSt8nHe+ffkdW6SpEgeY/glS+8CLwjeX/Uja9XTtUlhxWbi0QHSKvhf8hrHYjG2zQeC0mQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7623.namprd04.prod.outlook.com (2603:10b6:510:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 14:55:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 14:55:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 5/5] block: remove the bd_bdi in struct block_device
Thread-Topic: [PATCH 5/5] block: remove the bd_bdi in struct block_device
Thread-Index: AQHXjSoW73b+VgLNx0acwS8O2TwcZA==
Date:   Mon, 9 Aug 2021 14:55:57 +0000
Message-ID: <PH0PR04MB7416DDFAE8DA52F3EEF8B7949BF69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e18c5095-9be2-4c9e-e7a3-08d95b45cbd1
x-ms-traffictypediagnostic: PH0PR04MB7623:
x-microsoft-antispam-prvs: <PH0PR04MB76234DC1013D2FB2ADCA1B7C9BF69@PH0PR04MB7623.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +QSoiOMMo1VcmDMbGPKnailPsHk5/asI4F/Mj98vaZrk0Rol39gi3wChyDJzPwHrIKGMFOO4j1hWaSbEtktCj9ZFq732fZvMPPLtj2L22IISV1vQ63efq0Xh39gvJI3NHAFXINCkNH5zK3Dh3VaMsF99HOhJ9KshAA8P6BO5f2zNNPIXdAaBn3gRAw4FgnH1ecE2iI4VJiNJ2j2DBidOUKCHCE5mIfje12UuVPM1eB5x+NSCsal+pCIUS43+o33HRXuwKNYD2AE/QhvhSCaoe3WT5SJIFla/Qf1cXdo0p1QuFg46f6/CnviAYjgtuJO9OL8hONZl9IGTQKb9tMiekYUq02t2PClBpM5FOVvl2OY5KayjYq3HVJ5q/PGYqAneE7xUb9DrtZMGIjRUzBCRc4G+4454uQzajrqrXwwLYRYjDrkvfA7biwyVDMct9mj5VlipVOn8nkiE1vtOb/Q275LM0gemTHskYNcFG51a3S1ix3+oZGKCRffoo/+tuBEbZqvf+qvwMESfx+qPIEopfNBK39mawAPJPzhItn0hNlZjcLqKtqdgmvAhUg4PklUYhveeZ6d6wOTOVFrwLsP14zj5+HioF/P0IOxSgli4FG0Tfzmr7P+xZVUh6eRuchbK8Uxym5PH1anOy2b098mtouFm0eWFi4CAuqy+pf8yRn6rIc8R7yTzpyq+k/NhifAcGMNDJ5ZiDSEV/LcfyNkPjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(8936002)(122000001)(4326008)(110136005)(2906002)(38100700002)(54906003)(6506007)(71200400001)(9686003)(55016002)(7696005)(478600001)(8676002)(19618925003)(33656002)(38070700005)(316002)(558084003)(52536014)(4270600006)(5660300002)(64756008)(186003)(66476007)(66556008)(76116006)(86362001)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/nKd4YKURQDaD6zrz7Ii3cH7a21fvwN6gblHUSNkkN2DUSZottZAzHBb5U5H?=
 =?us-ascii?Q?9VPd/QK7s/+31JEv0PRszSMqcMNTmoUlJi9mUPvEkFnlSDVkdO/ACt1qBvCO?=
 =?us-ascii?Q?w/oyP9b7NBIWgjPIX2mYmHetYs/iuQtozftU3IdWXOXxZn/cgk/witI7qpLg?=
 =?us-ascii?Q?NNm8xtCShXa5EuaaEnSjCpBeL69PqT08X8dNFPB2C9GYXNc2rxZLkr68nKzW?=
 =?us-ascii?Q?agEH4fHvs0pYdKq0w6bY775G6IlF5aElt8LjgQU1eatQLF7k/EiCX52Hx0ZZ?=
 =?us-ascii?Q?YlucW10kBwKU8J4ntZWW0KVckUiy5oKHfWEyujd1GV7aQR8OFbgm+w9M/XCD?=
 =?us-ascii?Q?9xtbolg3zkuLmEitNgKihPKSuKDLWmiiPVvPyckm2BOqU1WLV+IDyUqA69yX?=
 =?us-ascii?Q?AnffkhTvnJTuHHScOXcsxCnU6DZQmTSYxyVyXZbMLm9qRHlGjEcFOpJzH+PB?=
 =?us-ascii?Q?ZoygHplaI0xJ1PqTDe0Lkp8v/eEadnsgTyHqDfngLFTygkFQy6OUqnqfwe8X?=
 =?us-ascii?Q?KmGTfg40K9zJWMuHKYdXmJznzZ/dBEAvshW62dwT6U+Lyp1hpne0lW7Hh4q8?=
 =?us-ascii?Q?dMD0siXO9stGeXoei723KQ/HsNukHM7p7aZgatUbunuuNuZUw2v1K4ELWdVB?=
 =?us-ascii?Q?lKOBm9TtoFZA+X4PMm/AAkw3n+pzB9ziQHR8oxqFtv+vrH4UjzROM7QJRSoy?=
 =?us-ascii?Q?N5/MLGUpWz2ZgWglu+yh4RQc72rmZ7EC7Dhltw9qfXyIcM/rMDRt4cta4+Xh?=
 =?us-ascii?Q?yNxK5U3llSumBHYZpqwB4L8nb7RB026onEs/Z+8K4OxHishlMsYvCR6W3ibR?=
 =?us-ascii?Q?bmBXJkm6ovvF7QzdjdSB59ArrTBAYB+Jr3YftR4q2HLRKo6N45sR9mn1+ZhA?=
 =?us-ascii?Q?hxUq9FRmQt92H6MumS6DfY3DhqEjbBuSKC+cNrV/dTy1kbODbQvGjzDt+p26?=
 =?us-ascii?Q?Oj42QF7bgSfZJh3bucML1Gy9NpOXI2uyVSaROoRUStH6r5/blSmmLEaeyo0n?=
 =?us-ascii?Q?EOQcAYqiDIzZHz9a3EDllmJy1KHAVxA96dzuunGXhlOmqhsHosfTY2jN+WWF?=
 =?us-ascii?Q?BQ7a9aMLsTsqfP63bC0I+oXgWlclXDl/acO8Nxt58ACg2pc/icv2dOCUae97?=
 =?us-ascii?Q?FWR7RWOX7a2eL8ZqZqpj/bUF16kEO+6E2fEjcB4Smgg6ptv6MLjHl+yOfCx0?=
 =?us-ascii?Q?SycNrow4kCo1w1Js9nVLBVehJ5sZVu3e+xI4ZTezJzyvZv9qWq2G0dat/C7h?=
 =?us-ascii?Q?CuiOdk3GIjFzluQLf/mRhz+3fPuPrMDKdYahS7aNFloNWUzY7J0Sedmd0Mbm?=
 =?us-ascii?Q?g6/hpud+PQQPtvFVfVpr3uA5XIhL/mA5iI4imfoj5hdjLoM8uTdeZIH+UXnu?=
 =?us-ascii?Q?a/WWAINB/uaKu1YQMjDguYVMn+LjJrDOOasUzwPaIUlnE5T0fw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18c5095-9be2-4c9e-e7a3-08d95b45cbd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 14:55:57.8594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGZOwIgPpgv0hp5uqM9CUrVyyYpX8wTUU+c53Vm2qHybrBNaslbOkr359xu/dwauE+DWSaEchZhtEVtVpnkUXiruMxbRDKEyQZIOU2m5RTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7623
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
