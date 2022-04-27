Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BC9511496
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiD0Jkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 05:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiD0Jkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:40:39 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2099.outbound.protection.outlook.com [40.92.98.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35A132A9C4;
        Wed, 27 Apr 2022 02:35:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF8eist3BeGnw2okzMhBlEXBYQ86ke1E1HsIcRazA43Vr++ywJ2hu7ro1vEluEOewyyGD8W/14/nbOgzU0u9hsW8Ompukq8x9/euYemDGioNWb6iKxdOqCdhkSyIQMudeuk6JJaOuM9Bji9gMyvPwV2W5VHveC0NcxDCvuA0xQ5zLgGnXxardC8V0to1n4IEgMKVUmB67MogapD3BcRsqVwoa0ryIKTokP8k2ReUHbwwCqTGK6goRbzquZAbH7rONH2QeYj6i4I3tKgfJTwTBrA4UBy1NaStkxNa5TdVTiJtnjSE3exS0i4nJHNL/IXD9+RerQw8/UwCH/74UQo3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYOSDO1EaBzlZL56RBtIoBiE3dkjQghDZmFBS3BP0FE=;
 b=BQMPoCjebPa+H9vvxVTug5jNbvwdKTw6GMmAWAcSktCc9TqvvzAax8iDGIwxi+1R3cPwhjJG6IX4RI4mIIkEWkWTWR6fGb5HJVkCDVLfbJ0CVGrYT9LgDDG7bZMqRF+VsH16G8W/xaPT4+DORaKqrdNgYMJK30izR5syb7rw2wXULigRp7JAkU+H+RK0sCbXGb0O52QpX1w6f2z/4UV83vWrYeXefI0outAia/7YGwr07PgXjwqhb++hu/YMNIJXKJ7x59UfEvxSWAwauj1jm1VopQXgAGXxuFFLrv/CoLuQIyxoFPYbWvr9g1ny5YYnkNfT/MIlntZDUf46f+TUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYOSDO1EaBzlZL56RBtIoBiE3dkjQghDZmFBS3BP0FE=;
 b=FVe/nN70ObDD2xlQvqk0tWTM5/64ol5dxMeUtvBl/HRZWAabzrDTvtf7Rh/xzmlc1TBXtbaucPd+ferYe8cR15WHvQoJzlQYpSzkIyuas2B4YWSN3afpvuq5Yzh7OB6YbWNtmjNG7MI48Seeld1IunYyrd4ooYQTu3cCdUJXbXN5B+bfuPIZK+M9J1J57kzEYlAVh6BcAs5zxsAz7vqlWdAsfIN/9E5/96EgJRNc/+5mrp2YwrixLGJz4urDtDCRORmK/f6SXGWYGYrat2rIYKI2rLESz/y1Khu6ezY8NZTG15d9vI0yg8vBEcbhiSe9BhckS5OZN/VW9fdLrGfzhQ==
Received: from TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ce::9) by
 OSZP286MB0901.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:111::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Wed, 27 Apr 2022 09:32:51 +0000
Received: from TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ed8c:9e75:ddab:8c5e]) by TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ed8c:9e75:ddab:8c5e%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 09:32:51 +0000
From:   Xie Yongmei <yongmeixie@hotmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     yongmeixie@hotmail.comc, Xie Yongmei <yongmeixie@hotmail.com>
Subject: [PATCH 0/3] writeback: support dirty flush parameters per memcg
Date:   Wed, 27 Apr 2022 05:32:38 -0400
Message-ID: <TYYP286MB1115E4ABCE9016358CE0029FC5FA9@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [f1RYS5frpSIgVTi3ixYwFHXXCC7+cUsl]
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:ce::9)
X-Microsoft-Original-Message-ID: <20220427093241.108281-1-yongmeixie@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f00cf3ba-4baa-482e-145e-08da2830e673
X-MS-Exchange-SLBlob-MailProps: 3UeWkQkuiJN5OoT4RIA8t+cO3fwvMXQQeUOJZ25oMCgPM/CczD0ISSm6gfcDE1jWlM+BJGAuj4q+5vvt7ZmZPyBQfpAZtkUFzbhy1qW2R/WXHpDgKfYh822kUoE1huWo1/XGwPWRd3lSvSZ63GpyZe1j4cvIGYEYKKmwTlsTdRZuHG2WO+eBL831FyuY1B+nzyNaIIDjzk+o5xtoqsr4L1lPb2RlZf/TGi4Iy2BCM7o6rZZjzEfwkVGxV2Vh7arrvkt1XPV6G1A15+NozrDIpJctFkGGFFGCn9Xtp8AkwVcHUHpgScpmParFLaQNrH6vC8rW33SVM/UFu+N9OPM0FK48bApj5e4XA0V3qIXXg2iqKny8AiUN/DnQpaEG1yhCY4vzrjkaU6laOfORcnojCaYZaLv/w96RzrNKNGyBIxLyQ34E1+HVxXUpSEEgwewz0tfrL/L3Q/lA56DMCx1ltEPnXSrynVo8Ml97l5WyvC2EhuI4Uo72ybwqG5I5EE9alBPP05Q7LKyffvCROcfbHt6H0gdXev3sMp7tKZXkVsrYNGiJn9cAcCTW3/dBYo7mLB9m9bs939I8SJIhCI4dgt0vhGvxqGumZ96csjTpz2o5RxTUhO/cxH1zNxXsX6+SjKRJg/zzQJ1hdR7d6pdiM4ETrDcfv5ntdfL5EentvDRLAXTo5riqNvo2H7oStrCW1h66HqBq7Nz6wKlOD9tt2+j0dr6VtixYN/Eqe1MoBKZTWeAv9LhX9g==
X-MS-TrafficTypeDiagnostic: OSZP286MB0901:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3y6J6RUcnbDu5LMtnRMjs+YXBCSqt23fQcQJLslGHlYOVZGmKsOV69uyRSozgiRDnjnI1NRBlbtQD/yZQhPnemIWowgxrk3895SKjx9GvCCD/Ie16u1YmGD6EixQxV6oWLdY9qQYAfDyo76yopaYKqfJN8qN4TYxNLH8gKCdnw6M8G44A83XN0NLh2U0+fQSw8eDfr8Bm7B91aza4eYIdH11YAGTucxwa0UzDT2Pn9GuDZ7zHNFTBTFKyCuBRwKQT5r3jkhyGGJMFOICfpvLRaUbvcqT9l3FUO79q9apj6wiGhRV30Z5LltttnBp9pW/p5nace5g4K23dwOcfBC9MtiOCDxZUiR2tWQMDg+8aDVW7aldxNFEXvDuC0JnU42/4eNWtcxMWXc1tnxLC6OEKrtSdM7MUqaR10/EpK3ShtGaxEwPVlvL8QI+c+/4HAl0U4RXnuvEPaceFvCb4uNWMN3vSraJQJOWgxr9RczyDxLXlBxnkIrQb9czo0boKAcYjWbCg+7GLbNUud5ddnR715gm5ZKoyDOkEqLJkHgtz/+yBYD89HgMo0kfgZA7VKnNFEEoYiDJ7HCtvd5/kXjF5A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vm2AxYzfLlEBxdcUFY263chDmWiwXHLCtwSE9dyMzz1BZNieWJ53x4kWy6t5?=
 =?us-ascii?Q?NS2piV+VyB59jGpsKJ4Y7Xga8gc3F6RQsHqzmkKo0FLoCc6UnlhUBdyfvNno?=
 =?us-ascii?Q?eMG3mBR4yka6VBS+LV7g4Dzi6yGJZe8rvivInHdBoT4Piu0JyE0pi1tvYWN/?=
 =?us-ascii?Q?4XM/d5R8ggTGTPNiEDgnGqCgIj6c212ewvGXQU0P6Odj5nhVchy1POvnq2Lk?=
 =?us-ascii?Q?L7+NyaLX7FYdJdFLCBw6r7MK0mhkqLLILog6md/2foBOAs8n9/YaoVWtKvPy?=
 =?us-ascii?Q?mjuB5FljzvA1+2SAq9KqgVubNM/1wHZA/f9GV0QPYt0lB7NxAvyWBydR2Yr+?=
 =?us-ascii?Q?jcIsHlUhbbOD/j8IpLs1I4MZv0LQbmemU7b+0adWKWWaxxXCMTsN0WT7HpS+?=
 =?us-ascii?Q?I4nq87OSidQv8Y38fKzkd/BV0LnQ/0r67092ahukhTAOOJuWGgxHlQLquSjI?=
 =?us-ascii?Q?kd4KJ/q9qxpuTvM9GUs8wPMwJf1Rw7Zv2ZeZ90UvAB8mIhGwDtUEm3+jgTYC?=
 =?us-ascii?Q?0566yOdH2TCjLdJGJC71Ult7oakP44cqGxF4BQ15VTYF+/5hijGjzCd5GYrh?=
 =?us-ascii?Q?Cq4UY0VxQr1hKZB4IhtiVcIrMZ6fwVNcXSMbJy0oisSMNCvCqcFfauCgscgY?=
 =?us-ascii?Q?SR8mrXYZ0u5pZi29EpOIUR539nvGCFGt5COaF2a0sPdQTRrJ/eFTWTRJR2j7?=
 =?us-ascii?Q?ZIQcFpj38PL1p1PTUHbezeiVAM1tHt19t4iL+nhwhULOYk6eEgkR8JQ4jQ8r?=
 =?us-ascii?Q?pw49c7CU8JvfB1LRRAlvs/6J6oUgYgFfqhx0jxKXzR6HLnD3QyEQkXn9wscW?=
 =?us-ascii?Q?n6r0NEpKruWiK4j+Vs0AO53gTZL6VQYR2x3CZV+7uymzrx99m8jEETYfYwDK?=
 =?us-ascii?Q?HfWmuXZYpGzYmF7fVHo0fb32plpjWnTssLPNgveTGzXHCanqz5JlxIZM9MZv?=
 =?us-ascii?Q?icC6vTjS8QlSzB4b6dhjHHpXqRyFTs8qpcQMN2hPPel1zAp7idaiM/veNkjZ?=
 =?us-ascii?Q?Elv6hoBijqMOOQmvsnQT7vxCAaQWP3nVvB3SdclXwTOHxv9xZJiJ2B/rKyAs?=
 =?us-ascii?Q?1FGR5t3qbeOFZJ2amWgVxpzD7KWr3buAg0qFVhA+JyTyWlve3rTpBOws9Iwe?=
 =?us-ascii?Q?df0BUCQPXo6tZ3ieTKQTtM0woEK0/lczwUPXguBNOkZZIOnSjD/fBysR4iMA?=
 =?us-ascii?Q?BHWTdMh1TSPO4Xr8uQjGIqq/+NaHXitVz0wFJYZ6HdRpH+9D/UU7Vy9dg+oA?=
 =?us-ascii?Q?g+nTa2xjbDXyDpCJDKxdBlEM9kN+bLBEDxQRngwLN/LGlK0z5XJ/heqzHs6/?=
 =?us-ascii?Q?NdBY1fSxBV/+We/i5rrwpgrtejxeKx2k1zerCoaqltwmVJQqb8jOL3/FT0Th?=
 =?us-ascii?Q?+MGc2PsA01UgcEQFg3Yyb1SeFbziruLRS0A4KiAqxr8+KCwsyDE+Q1tlpUXe?=
 =?us-ascii?Q?VSVA1Ryh5c0=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f00cf3ba-4baa-482e-145e-08da2830e673
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 09:32:51.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB0901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When analyzing the offline applications in co-location scenario, we
found they consume memory aggressively. Sometimes, they tend to fetch
massive data from the other machine and store them in the local
directory. Offline apps usually generate visible burst pressure upon
memory subsystem, especially the download phase. Because it kept
allocating pages from memory and producing dirty pages against the
global pool and cgroup pool.

How to get rid of dirty pages smoothly is challenge to make the system
as stable as before. So we'd to tune flush behavior per cgroup level.

This patchset only provide per memcg settings. No functional change.

BTW: bdi_writeback is bridge between memcg and blckcg. This patch chooses
to include those parameters in memcg, because dirty pages affect the
efficiency of memory reclaim more intuitively.

Xie Yongmei (3):
  writeback: refine trace event balance_dirty_pages
  writeback: per memcg dirty flush
  writeback: specify writeback period and expire interval per memcg

 fs/fs-writeback.c                |  11 +-
 include/linux/memcontrol.h       |  38 +++++
 include/trace/events/writeback.h |  25 ++--
 init/Kconfig                     |   7 +
 mm/backing-dev.c                 |   4 +-
 mm/memcontrol.c                  | 250 +++++++++++++++++++++++++++++++
 mm/page-writeback.c              |  15 +-
 7 files changed, 331 insertions(+), 19 deletions(-)

-- 
2.27.0

