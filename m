Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DD1511481
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 11:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiD0Jkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 05:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiD0Jka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:40:30 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2099.outbound.protection.outlook.com [40.92.98.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0127032B244;
        Wed, 27 Apr 2022 02:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk1iTEQvyZZ+TIaKnJVmDQJP3SNFx8gtq24MvSQ/f9oSXa8b7dIal62+VGhN55KNPjh7BA5x00HjmwQAjt4PCs21551CdkkQVPQ6cJ4XpRoAZDut+93/D01efbXCBCGoYvHG+RRgrIf/QDKr7rmqRSTnKUYWs85xoGsXlx6ZNzwzVC4uWuOWYEeRv2CyfttCJKsjp7uha3lbpssbOEcJZ05xst1Zt4YDpJ/0rXyG5VylsoXC0JiX+uvYocdCI0/ckI1ipmuHoMz9MLjRRpkHKGO25boZ2y9uU4+k0pMDPvt5vMrcElUaIanL9j8vDbAA2KQdruOOVet5vDxMieif5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPiEZmeglqvoxdv72dytwOYa5duzSuYNGy6hKVgjX2A=;
 b=NiVpRTZ2e2hiWKBXzAAbE0KXbDol2sVZFDqGjeVoVzu3hBTMiY9w10wCJR3EcFFXRHo4MXGstLsDP3x9VPI9Xerpk3/AB6emmbIQzfhGU87RczXEBFZ2/V4OANDoCHmO/mc4Z6ONsyplMbLf4YMkqrz07qWU+iRQuxMBBD0nXpT6adbelWO3nbbm1nqA0m7pUJafsJSyw6oL+oQoblp3H+6O/6SWLUvT361rRw01McS+B4nRBenEZ77kSr9iWtUo0B2dXP2538A0NkMjmFEegAAxybwTqRc5MN8jOSJ3oGh2aGpRVc6PQjKt3fA+RIviD2MPk5ZCIlthEY7P/Q5PGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPiEZmeglqvoxdv72dytwOYa5duzSuYNGy6hKVgjX2A=;
 b=E6vw8BLwDfg3OD/JgPdpeHgQfKJ3b8OcahQPsei3lRYPX0eftwTUe28YoiqPsm6jL9u9D1WaCIbSJBEZtEtjtPDriqJ0MKdNwEPSl/imiQtJqGUDsMMFekwkX/37WP9pGsrZWfJm49Kg9RQIt60gAtfAM6Fkk/GHxt2ALh522r7gflI1C6UGju0Rd/2ugyT7tCYUR62MOKi2miWCpj+mV2jOqgiYRgFO95iqA+ie8RMGWmsm0njIxe6Po/rkLblmMjxptxiVMCkJuF0eytZ0ABAQOXYL6YdFgDpyJJ030Y16wZQE8IKEbNfovs/ueLrwVe2D89x8QUBbfDMwfHTybg==
Received: from TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ce::9) by
 OSZP286MB0901.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:111::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Wed, 27 Apr 2022 09:32:55 +0000
Received: from TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ed8c:9e75:ddab:8c5e]) by TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ed8c:9e75:ddab:8c5e%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 09:32:55 +0000
From:   Xie Yongmei <yongmeixie@hotmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     yongmeixie@hotmail.comc, Xie Yongmei <yongmeixie@hotmail.com>
Subject: [PATCH 1/3] writeback: refine trace event balance_dirty_pages
Date:   Wed, 27 Apr 2022 05:32:39 -0400
Message-ID: <TYYP286MB11159B3C5B4385EF013E1DDAC5FA9@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220427093241.108281-1-yongmeixie@hotmail.com>
References: <20220427093241.108281-1-yongmeixie@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [GaslTuJl2lChuSsUI9ZuT5WunlXusab6]
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:ce::9)
X-Microsoft-Original-Message-ID: <20220427093241.108281-2-yongmeixie@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b21c8d0e-e223-44cd-fd7f-08da2830e88d
X-MS-Exchange-SLBlob-MailProps: zswcL9HXbeUs2ByizIwMZz3XeV1no+ZL29OrKzEbdawTGXbg6P1LP4JFskwgMzZN22KgmCo0Y0sfqv6cA7xs9puvS6SVfqAUQ2omPFfRyr7KU1Dm+9JzU2wAMKZWg/NDg/NH/kS+U5kiEAsnT+K67WOjKF3ELEFiVN74CyKddPiSTupCfmqqI5NaqRU2dff+5A9dTWZxvBfaF4e3yWMpv6RXQfGcc6p/y90cDybRUOBI9KHWtXVJUnky7jNrWlnlVf8mMT33IXFJgssEHsnmBGYkiLJUJ828zZAaN9jtl6VrtPXxHZRv4wEBkM8r39AX+KLLISHcy/JNur6oYSa0cllDJr32fMAC/jLWMTMbMsK+vykEd9xEoKK7u/EDkezQs50Qq+xmiZ5nx8roXPbr1wVm8CqPkhOF3oudju8+j6kgRK5b6o6Un/eMpoM3+9QIhvxs3/NtjkkVZLzX/D5330xXr5qLPPrGze1QXqNirswo8U+yO4yQDduNNwcQZy1N9caBe4HWAHGjH1Yb9FXPv42BPjjmMs0O0vWK+KeGoL+ij5nQhvIfOR0+PXQG1eRS6jaNn0N5NeX3BEIUNVYQ2UJaUlPr3k1iWCHlrT2/Yytgm8Rr/s47GxCTKPnIJmhYxUZ81pTUR1g8UCoXoG8ZN8Z/4QydPC34zmvyfQkpbJMmbPxGQOXlbHP5EUTFfbtJ/QDklmIj/v7sYH9QrLj/uKCVSg8O2X+punuwNDN29oEErEx5x1olLhPTn4xlcM+f
X-MS-TrafficTypeDiagnostic: OSZP286MB0901:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQ2jrFc2J5lRJ4YiUYwHcb+rvN+hKCW3vFlImALb1I1fMNRXVm27GeiQb8uATwbZjTB9ZbQiu30ehpnsFP1dhra9DlqrovPVqe1VuF5AMZtY3TCJpOCH0aiZQTtcwp52ZHl1X2jf0u4bnfwSgNBFyLy4oRLsPljppebvdAiWywm0j8HVi/Pm4lcLkr3+tk82rs+doyOaaLHxAPfxm48rjxfWgvNihqLfr309GoLIYk/rSiUM4vBHeccohtrhVnL+rjZeP/mbBXMhtz4Fc06MzJKnnvem2iaEKxerljzkdccDKmRXU5AP+4SnG4kw7DazOF5Szbh3QR0d75Fb8r19xRsyK0W/FNO3SSxEJT2fpeJL+SycICRAD6KM+sA36kN8ZBX+ksP3D/o2kdbHhrXrAuKhVmtCYREl+Aez9KwM7DqSuN1ia5GWUSRG8zzoYUjDuNnRwaBARTQwWGho/0dZq4JfzssL3aoCuL+MXQXgofAJCeKdh7mJ2zjQ9qEZcYT3h6HckaL0V48H6ktO9Va6e4bn/jmlkAWub3BmSeOcmDHqxDrfEYxebdiGYrmaLa2j6aprfflygE2/LlM2JsRPGQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qBsyemX4oZtkBxOxmZbvU+76c+lp/m1pwMTgyzpyJjH3cuEUI8iO+2CPGhm/?=
 =?us-ascii?Q?xxG3fJf+TKCBfqp1IzoKpY+2ps9vaVi1wngID4TtnY1K9LdMOM3uIfLjVEYl?=
 =?us-ascii?Q?5DmeTI8bmRO+H9nk28xAQ0yz59EV3rrtMbepNND/UVOaDQ2bSyZ/eplki+Ql?=
 =?us-ascii?Q?yJYkDs/v1+pKxbtwj2DJ37l4hXfOPy2RmrOU6itPLEqKYnb9Vj+Z4wEbP0ZG?=
 =?us-ascii?Q?0qNXSFu7b2zHORTsPLKlkK6PiXrJxIH77T74mkFo3k7/mxsXd1psVYX6Qoq8?=
 =?us-ascii?Q?F1P8ZbpaVXNRwsM4yC/w/EhQhy4wng8aqwRTnthe0kQBMvG1XumaQ3kCI4rI?=
 =?us-ascii?Q?cnpxJGYyQLuwZS/W+4QCFXxFx7TzowWvwY4gOxpQ2wQKAS/Fhrvb5KcYOjrQ?=
 =?us-ascii?Q?s7RWNrniKaf7cZYicVVKZzw9U0AQap0ojtsZ8B+j77ONHd+uxjmQaDK7WDB4?=
 =?us-ascii?Q?0n9judQMEzDYbr36kt9/I61PlzjOfcYZ9uDhK0Lc1E7chdNgepgFmxZex/k6?=
 =?us-ascii?Q?OSD9g890sxyu8xuAlkcDjkufNCnI9uN1NJiMVdRoYSPbl8ZrXcefeE1CoyJv?=
 =?us-ascii?Q?xblUeUYXFzeUcDw4tc1XPWl4ykjhuzAuV5LMvIgBosHY+Ujt9p52orcNFXsq?=
 =?us-ascii?Q?AGh0UeFMS+x92hjVxC5hnkQbP43QkJipqMpKlfmXG6fFM11YxkkvG8fLucAv?=
 =?us-ascii?Q?gVehq1m5Kqlp5TG7D5H3yIG5fXI2cKwYfr6oSw7glmGB4babrveWOlnUUgYm?=
 =?us-ascii?Q?TwYkjJfK0XUQkvgJ2UrGO8JHxA7hdyqbhuIpMbQN4ONeoBHVnHaXLDPt1YWN?=
 =?us-ascii?Q?41sOAtWUr5JevS5KUx6ITMFf+wRKAYj3a+nrFgTdxIhP8fAZkHRj/KWhwAzm?=
 =?us-ascii?Q?bZQuau73roGAl1XPTiBAu6pguXt0pVQuZRe3k5GtXFhDoZwn+o5b1xSbwqVW?=
 =?us-ascii?Q?03LBOHWOPBxE2s1vB5FyqZuJfsPGdG54t6/QeAyZF+dXd2tRIsU34fcVpLhz?=
 =?us-ascii?Q?GxV7DRt18udUnHOm/uz9DxplNO1hTuuk2Of7deCRzy+f70nYF164g6FxxCRc?=
 =?us-ascii?Q?s1elLdyXre+biRBxY4cgH5tGdWt7hCaeuVoEfScBXTyjh5ca6A+JWG93FVBk?=
 =?us-ascii?Q?XayJckAkh+/mgX1uwGJA6rffyBaGPAW0dhwfSgBBGfdsjkf7Eyp6HO+iKRTe?=
 =?us-ascii?Q?A+mXvhXXns6C0Cf3hjPWJ8wPFuyVeKSELas65uR4Yoz08Ni0jUiTxNUepOer?=
 =?us-ascii?Q?VegaJ6wnMe9Rz4Y65bFoyx22YLxMmrg5YRC6jEe298CQUkr0pJChpL8BlAcR?=
 =?us-ascii?Q?ioYguGYQ7MRL/SqpDe/tljPu1wZMpqgagim2KdcGdrJ3LN+ltUkMlLlSKdNI?=
 =?us-ascii?Q?VR7FDLx34c7xIrjG4qP427YAAtrSOcXdK/RKKBKCzgJD98+rEhp8SAXzERVY?=
 =?us-ascii?Q?e8bnch0DfyY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b21c8d0e-e223-44cd-fd7f-08da2830e88d
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 09:32:55.4163
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

Patch set "writeback: cgroup writeback support" supports wb for
cgroups. Since then, writeback code introduces two domains to
control the dirty pages, namely global domain and cgroup domain
via pos_ratio in commit c2aa723a6093 ("writeback: implement memcg
writeback domain based throttling")

When one of domains is over freerun level of pages, it enters the
throttle code. Then it computes the position ratio for each of domains
and use the smaller one as a factor to make sure dirty rate keeping
paces with writeout speed.

Unfortunately, the trace code didn't update correspondingly. They still
use bdi as prefix to describe the part propotionally with writeout speed
(AKA feedback).

No functional change.

Signed-off-by: Xie Yongmei <yongmeixie@hotmail.com>
---
 include/trace/events/writeback.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 86b2a82da546..0394f425f832 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -624,8 +624,8 @@ TRACE_EVENT(balance_dirty_pages,
 		 unsigned long thresh,
 		 unsigned long bg_thresh,
 		 unsigned long dirty,
-		 unsigned long bdi_thresh,
-		 unsigned long bdi_dirty,
+		 unsigned long wb_thresh,
+		 unsigned long wb_dirty,
 		 unsigned long dirty_ratelimit,
 		 unsigned long task_ratelimit,
 		 unsigned long dirtied,
@@ -633,7 +633,7 @@ TRACE_EVENT(balance_dirty_pages,
 		 long pause,
 		 unsigned long start_time),
 
-	TP_ARGS(wb, thresh, bg_thresh, dirty, bdi_thresh, bdi_dirty,
+	TP_ARGS(wb, thresh, bg_thresh, dirty, wb_thresh, wb_dirty,
 		dirty_ratelimit, task_ratelimit,
 		dirtied, period, pause, start_time),
 
@@ -642,8 +642,8 @@ TRACE_EVENT(balance_dirty_pages,
 		__field(unsigned long,	limit)
 		__field(unsigned long,	setpoint)
 		__field(unsigned long,	dirty)
-		__field(unsigned long,	bdi_setpoint)
-		__field(unsigned long,	bdi_dirty)
+		__field(unsigned long,	wb_setpoint)
+		__field(unsigned long,	wb_dirty)
 		__field(unsigned long,	dirty_ratelimit)
 		__field(unsigned long,	task_ratelimit)
 		__field(unsigned int,	dirtied)
@@ -663,9 +663,9 @@ TRACE_EVENT(balance_dirty_pages,
 		__entry->setpoint	= (global_wb_domain.dirty_limit +
 						freerun) / 2;
 		__entry->dirty		= dirty;
-		__entry->bdi_setpoint	= __entry->setpoint *
-						bdi_thresh / (thresh + 1);
-		__entry->bdi_dirty	= bdi_dirty;
+		__entry->wb_setpoint	= __entry->setpoint *
+						wb_thresh / (thresh + 1);
+		__entry->wb_dirty	= wb_dirty;
 		__entry->dirty_ratelimit = KBps(dirty_ratelimit);
 		__entry->task_ratelimit	= KBps(task_ratelimit);
 		__entry->dirtied	= dirtied;
@@ -681,16 +681,17 @@ TRACE_EVENT(balance_dirty_pages,
 
 	TP_printk("bdi %s: "
 		  "limit=%lu setpoint=%lu dirty=%lu "
-		  "bdi_setpoint=%lu bdi_dirty=%lu "
+		  "wb_setpoint=%lu wb_dirty=%lu "
 		  "dirty_ratelimit=%lu task_ratelimit=%lu "
 		  "dirtied=%u dirtied_pause=%u "
-		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%lu",
+		  "paused=%lu pause=%ld period=%lu think=%ld "
+		  "cgroup_ino=%lu",
 		  __entry->bdi,
 		  __entry->limit,
 		  __entry->setpoint,
 		  __entry->dirty,
-		  __entry->bdi_setpoint,
-		  __entry->bdi_dirty,
+		  __entry->wb_setpoint,
+		  __entry->wb_dirty,
 		  __entry->dirty_ratelimit,
 		  __entry->task_ratelimit,
 		  __entry->dirtied,
-- 
2.27.0

