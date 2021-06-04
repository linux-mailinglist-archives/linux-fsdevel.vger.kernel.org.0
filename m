Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98DB39B42A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhFDHnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 03:43:51 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:15160 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229958AbhFDHnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:43:50 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1547e0iG008658;
        Fri, 4 Jun 2021 07:42:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0064b401.pphosted.com with ESMTP id 38y3b3gh4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Jun 2021 07:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgXDWK4B01X5zNuWGK8fvvi4P37tPCrYIYa7AQIHFUm6Jj8/GUIjSpddNGuTn6zHwY4ogGqCVyGec0Bycl8Cz9QyHK00fC45pcLZYvvBMZid/4pIf3OHMc5L3Y5Td8xdv8JfYMN8cGuKgLiu1/ANZ/Z1cHWlo0sxZX3VomK9VFEl8ERMNinmnFAzQfoJYvV/F76VS71qnFnhxdGNXpJq07GBJw8ZD+G/eiIBYxrH0LM7bQYGlSAxp+iELYz2+5N5qKR/A2dBbxtwg/Nmnnnq4wCG7bCO60H6A/UXQwMRD+/lWbO3R8asEOucl5eVrD6n3vlq8VAlmAIDKNlp+VpBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa14XTAMdbTGUKbhNcVrGuOqmMLt3im3EC+loFFrkLI=;
 b=FiU5Q1Xh//Zv8Z7SzyWa/TUjR3xHNI/JF5AQDwu/5pb2fWaq0ELDZoHPeDEAhH/RJJZwSKZTQYl0NsQOKO+5vnbdTuKHzJDWk0z9hzMe9s7AmONEj1ze+Mysf48SrWkHO2uqCgB2e0TbzBTNeuoNnuiNrNZIHBRMtZ9mzYT0ZZzn2PyH+X3N0Aq6Dso0JPQOxMLNXEbreY0cNVJjO5mipdXAeQSv+lIfA9odDvPcB5e+ItgdlRJRU3F3476s+gvQCaV70zrvPoPUlgJ+rDpJXnPX7Wa8VjRWl2kVp3r9A402Y1F2jdwanW7+PkwQS0Q8E+G4VzOxXvX6mS4f6JEJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa14XTAMdbTGUKbhNcVrGuOqmMLt3im3EC+loFFrkLI=;
 b=lcm185WtHfHXvE7WfVe7CEzTej8DnySPNy+vPYKT6qZI3Cz2L4oLDKQho1QOJeOQq3VD8kjfRxWnPagp7qKwTbE833akH9UOvuxo96AbzkmD6Hiq7oEWSoii2XsPAxx6t/Jns8FFm8eUhxF251FjhovcXWb0ZEk9gi6fYz50HT0=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM6PR11MB3596.namprd11.prod.outlook.com (2603:10b6:5:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 07:42:01 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18%7]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 07:42:01 +0000
From:   qiang.zhang@windriver.com
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] eventfd: convert global percpu eventfd_wake_count to ctx percpu eventfd_wake_count
Date:   Fri,  4 Jun 2021 15:42:12 +0800
Message-Id: <20210604074212.17808-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0027.apcprd03.prod.outlook.com
 (2603:1096:203:c9::14) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HKAPR03CA0027.apcprd03.prod.outlook.com (2603:1096:203:c9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Fri, 4 Jun 2021 07:42:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce3f3d63-0c08-4e2e-cd6c-08d9272c3d98
X-MS-TrafficTypeDiagnostic: DM6PR11MB3596:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3596F910652DE26E55804F27FF3B9@DM6PR11MB3596.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40pjgK1W72+i60GCGXvcTSf7n5l+Ei+8wzp5t2+AhblfgjGWqRLGBBamU7tVs0b1V1BrD2QXrgwH/imnCjZgcZiAeqWz/Q07qrisFaUW6YHZ3Y2jkUM4B+pvZY9MqocDN7OHswnpwGc4lk85eYTOFk9XeztAXptFRfP85DEJfZTflUqTDH99VofCXWixUcOG1Wu1nsc4umlYPC+6PY+EzIkmis8/dU3OirchFdBOct+yOajb+K6iamIZr1KOJghZLIpfkqts+shrSD1LCkouPoBIm059UKCGz06Vatq85bb+H5unpQOX+QEiEVFYs6sOEQKJfWcVjAc7CGwwEQJltMQb8XFSUiET8jbJt+8XNf3hHzYI8ta1Rq9PqGjF5xvepx5x4toJKlLga+ukptU4uZJF99yFcUHn+srCRk8A6szXXjzAkyttPdmYC440ExpuU5qgM6KU3lYP9h7Jvhupz79oQHOraXlbcHT1/3PDfdakgpM4Nqg6VSf5IyJeH5Pbd+ZKY0tEawv7ogLOrmHLEV2ttL87oFZtX1h8qeVRzGhRW/53nu3pYuCr2zqAcjy7pcRxOVn68PEBGIUV/u3Ft4zrhL+UiN68YmNMLASANENKsdtmO0K2keSxuQQv4f4BnfstwpD+Sq+wgYx+zZWe8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39850400004)(376002)(366004)(6666004)(6486002)(66476007)(66556008)(66946007)(5660300002)(83380400001)(16526019)(186003)(1076003)(52116002)(8676002)(6506007)(26005)(8936002)(38100700002)(9686003)(956004)(478600001)(316002)(6512007)(36756003)(38350700002)(4326008)(2616005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FlAjOAh/gKRHI/jQyWEz1iKz6OPItESGQbRcbHxSeKZNNReb6+Ha5xwN0+Kf?=
 =?us-ascii?Q?uMV6GxbS8z4Z0CwSKYEsLhyAOKZlQ3VXuIdf9+cEV8J9aXAq0QJ655waiGks?=
 =?us-ascii?Q?dDxX9r+cDYlgfN6fzU4HW1jKBGlxJJjAZ2bRDJxleNxifRAZzvPhoI9Z42sX?=
 =?us-ascii?Q?Nuc9U1CVY+ckq5NCb1eNqTjNUMTqRPQ+Xs+oKhoEo0eoc6MlpTdGR+M+IY1w?=
 =?us-ascii?Q?vkqr7CXyOjmNKCXsKRqx05+OLf1wwqIDPV76voKF4sWpYGJRrUjXUtgtnjJw?=
 =?us-ascii?Q?BoXTN5QkGiWyTF++kFN8H3t5ApthgDfYmmIPgl+CBzV/3uVSBrkPSMqbQOz4?=
 =?us-ascii?Q?6aLAkOlk7XANsPjMzsga/8A6KwTBFHPEpfmou55qzUEwHhHZNeYez8Y9hAP0?=
 =?us-ascii?Q?R3/PMrlQjZ+E/rg/Z/zB+rmyG3aTQrsV5nJ5Hhrk4KIY5/0nnoCejfz9yFPE?=
 =?us-ascii?Q?DoMtMfC5vCDj2rDfZk6IJrAgktoYgvkyrDURNQfyGKJMjuL0X4rhZKzpb7tZ?=
 =?us-ascii?Q?Cfdyx8yyqAfe49z0N/pYGVgTxSOWIKzJSG3JWbEj4imV7iNjokYE+bve3tdn?=
 =?us-ascii?Q?+ziU2GPrXTvniH7x6Jzrf5fSEZ6QDEq6NXgDOJAq8kpVoKkxeq2FKhcfanal?=
 =?us-ascii?Q?C67rivgkWJSY1o0vamTtw+Kt2qH8RGs/CMS1S3d0ruiQOcOznqn5u3sVE+PQ?=
 =?us-ascii?Q?VDUoXSxK0Mn7oIr0BMv2A471hWF57fDu1Zz0k8kRY+Nzi9/+r8iiaLcbfgJF?=
 =?us-ascii?Q?j+PTOFHkTSRtFkNqY8HRscrKAWnINiB9HQ/wBrkfTLheqr3uMAkUvtMpo67e?=
 =?us-ascii?Q?WmsvcrAd3xONcODkJQcxFramzi9qeP4MfkMo3VnFJ10sGNqQfkT+ULHVDaFD?=
 =?us-ascii?Q?gpKo/pYk5WXy0AK1wjYfy47OVpy1U1ga0A2T2K6euBCPPCuXIXVpfc6C7fjR?=
 =?us-ascii?Q?C5whG+uinpWs40MYs3Mmyg96G6yYb/7LXrPXzFvR9xVKJj+DOU+55a0iLfz1?=
 =?us-ascii?Q?CKT2VfJeBr+0gyHOiLt55UJJmFe/upPHRFLZOeLCBak1s4yBVw+kFjJuRzBb?=
 =?us-ascii?Q?1g2sicSaUGkiYyIIXO+CM6irusfHospC8qb4oshgJYplyaamn/JTqEszT7I3?=
 =?us-ascii?Q?T95s514FdMe5zBYH8IRpeXmZBis713dFsmIIjxBIGMczSBu+E5IyOMnjCx6y?=
 =?us-ascii?Q?GbJb+6tHpPo5BChfDx/ZC5fAt/3TKsUFgE4Ss9tBhpJGaKR1nAixdJXsFsIE?=
 =?us-ascii?Q?yXwBMPlYcR728w8ijX9XIQc09UHz5ZyVucyXOaJrzQzFZUsZctozSdISzif9?=
 =?us-ascii?Q?aPe1+vhNhxmEXwnrBOyH92d9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3f3d63-0c08-4e2e-cd6c-08d9272c3d98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 07:42:01.6503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKIOa0Key3LGv0BiCX+Lh1TVMYwnMMHTUatVG6gW7gNZDI3dvFP/hsr5gVyej9wX51TUZcJ3N+a+xyL3JoqEocm9MgGRwHnawP8wYN2ADrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3596
X-Proofpoint-GUID: fNsY8tGY4-Wi58D1dCEsQbDKQcdrjOE6
X-Proofpoint-ORIG-GUID: fNsY8tGY4-Wi58D1dCEsQbDKQcdrjOE6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_04:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040060
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

In RT system, the spinlock_irq be replaced by rt_mutex, when
call eventfd_signal(), if the current task is preempted after
increasing the current CPU eventfd_wake_count, when other task
run on this CPU and  call eventfd_signal(), find this CPU
eventfd_wake_count is not zero, will trigger warning and direct
return, miss wakeup.
In no-RT system, even if the eventfd_signal() call is nested, if
if it's different eventfd_ctx object, it is not happen deadlock.

Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 fs/aio.c                |  2 +-
 fs/eventfd.c            | 21 +++++++++++++++++----
 include/linux/eventfd.h |  9 ++-------
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 76ce0cc3ee4e..b45983d5d35a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
 		req->done = true;
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
+		if (iocb->ki_eventfd && eventfd_signal_count(iocb->ki_eventfd)) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..ef92d3dedde8 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -25,7 +25,6 @@
 #include <linux/idr.h>
 #include <linux/uio.h>
 
-DEFINE_PER_CPU(int, eventfd_wake_count);
 
 static DEFINE_IDA(eventfd_ida);
 
@@ -43,8 +42,15 @@ struct eventfd_ctx {
 	__u64 count;
 	unsigned int flags;
 	int id;
+	int __percpu *eventfd_wake_count;
 };
 
+inline bool eventfd_signal_count(struct eventfd_ctx *ctx)
+{
+	return this_cpu_read(*ctx->eventfd_wake_count);
+}
+EXPORT_SYMBOL_GPL(eventfd_signal_count);
+
 /**
  * eventfd_signal - Adds @n to the eventfd counter.
  * @ctx: [in] Pointer to the eventfd context.
@@ -71,17 +77,17 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * it returns true, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(this_cpu_read(*ctx->eventfd_wake_count)))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	this_cpu_inc(eventfd_wake_count);
+	this_cpu_inc(*ctx->eventfd_wake_count);
 	if (ULLONG_MAX - ctx->count < n)
 		n = ULLONG_MAX - ctx->count;
 	ctx->count += n;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	this_cpu_dec(eventfd_wake_count);
+	this_cpu_dec(*ctx->eventfd_wake_count);
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 
 	return n;
@@ -92,6 +98,9 @@ static void eventfd_free_ctx(struct eventfd_ctx *ctx)
 {
 	if (ctx->id >= 0)
 		ida_simple_remove(&eventfd_ida, ctx->id);
+
+	if (ctx->eventfd_wake_count)
+		free_percpu(ctx->eventfd_wake_count);
 	kfree(ctx);
 }
 
@@ -421,6 +430,10 @@ static int do_eventfd(unsigned int count, int flags)
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->eventfd_wake_count = alloc_percpu(int);
+	if (!ctx->eventfd_wake_count)
+		goto err;
+
 	kref_init(&ctx->kref);
 	init_waitqueue_head(&ctx->wqh);
 	ctx->count = count;
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index fa0a524baed0..1deda815ef1b 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -43,12 +43,7 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *w
 				  __u64 *cnt);
 void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
 
-DECLARE_PER_CPU(int, eventfd_wake_count);
-
-static inline bool eventfd_signal_count(void)
-{
-	return this_cpu_read(eventfd_wake_count);
-}
+inline bool eventfd_signal_count(struct eventfd_ctx *ctx);
 
 #else /* CONFIG_EVENTFD */
 
@@ -78,7 +73,7 @@ static inline int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx,
 	return -ENOSYS;
 }
 
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_count(struct eventfd_ctx *ctx)
 {
 	return false;
 }
-- 
2.17.1

