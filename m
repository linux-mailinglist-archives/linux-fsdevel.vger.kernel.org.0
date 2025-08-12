Return-Path: <linux-fsdevel+bounces-57530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F498B22DDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDA3188CA36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFC92F8BE3;
	Tue, 12 Aug 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kOdblZoh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sDsPtIaW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA124BC01;
	Tue, 12 Aug 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016387; cv=fail; b=OEVbHFZAE2DgcyANau2KPljY2jg6kgZv6fi8jM4Tyt3/3Qg8IE5izSRKj8rKnUMNNppF+dJVgzfrXVSffNq+B3Wf1Gcp1QgIEPaBWOXnQX0zgtPmvzCr0k2So3BBraZtlHESpiR0O25jmuJl6b7qJsaHLnsKNQWkhEdM3BvCAB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016387; c=relaxed/simple;
	bh=u5D8xxtOAPosLmAgK5JtbktAM9oXoUY+GFjj+SXvo2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QJtIsJjtH9A+cqOc0m51p3HrCfGCdmAnHVqIHi7w6FeunAP3ZzGHSRjpHgrYsmZvHgrK7FuIgC6YthJxQMi1Vt/PDqfXF3jzRu8vojJXKoI9km4nzjaMIhpxObXRYRj/l20HrI9u1ANAGTXhDqeplsq7Rlx6wLatUGGw8NHwtNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kOdblZoh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sDsPtIaW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBvQc015906;
	Tue, 12 Aug 2025 16:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3bkupV7amb7BU9XuoA
	5bhdESLrXPTpTpDaolQenf+G8=; b=kOdblZohiWKUEsGiEEIvFackx+pvZUUEgT
	ZilDIu6osWTltUpPRXJmLMN0YlWvWPb3Et/9sHOZ/R6HrAdibqpcSLW26YMSmxJM
	QXaYX7R4IZkDSIjtMyD4JSs9SI5rI8fl+r6WAYvGZ1YEsRCo94zcmpnnrywptA0G
	0AtQWnYIKSsiEkw6i2LNkCcplpw1xkomRObs4ZyLuYwDTyl9eU6zM3fvrEkY/3zQ
	WaU4NkYDgKRmYlu7XJorap72UhNqhQr+lpjdms35z0P0nfg2BI69NxtDqMBVMkrJ
	payQ12NDDSj2URguEejNg0wzkTdB7jN48SBa+mjO2GwC3RoqX+7w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf56t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:32:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CFq0Zl030118;
	Tue, 12 Aug 2025 16:32:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa6w99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:32:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jD43S5L+Zw4yoZ7AwdrMFx4cwQS42gGuAO79Qp3RfrIpYKTWXOMBOfQqz1Uv4HQMqCDRwAkkuQy3Z7tL8pF01hy2BOiu/uwpEeT9BPv6nCIKCHfqQBTfS02H9MpQ4UMzQvqa/D7NwnOta7HAue3I8gGoc3o7Hs5MluZwWB5UXSbTvmebzP8UM/XWJ8XreVDWWEJtdWuEcXaoFMdIwI/byhudA588lGh/8BwVfTo5tHl+VvrY294uKjmG/4t6ZMK3dw3vp3ZSg6nBKMwqVRS3GBAEaiGlUuslovbm4o0DQT+oQVMEb/f43srrCOle4bHn5MTc9arxsLJ02moGpQyHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bkupV7amb7BU9XuoA5bhdESLrXPTpTpDaolQenf+G8=;
 b=c3GpGE7MX6EXe73If59pqTt2xgJrjTjRa/VxjMK8yUIzgqiflVW+3tZw8h2ev5VcIQC9dQx9aMqBFAZYxx6y2VqHiNU3QjDqVMT85Sxb2yMOmZiVy5qSMInkrzyWT8j/D3AOr6Ep7W8K1DLBxUqK/Yir/ijG/0oFu3nVyI9+I/OqRSOGJV9hqqZJB3F8p4KJnzjERw/bM9QWplauo5Ti/ryuFuMB6yrb+gSf4XUvTUEvMYgCiKAJ9mRKHZO7s5Pfdp8yiJIS3BXdYTq2DI+Tn/ML7ZVuQQ7L4F9haYj6mp77otU/ep7qqkpAble+ebYnnAI5U74j7DNhjgEGNjOixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bkupV7amb7BU9XuoA5bhdESLrXPTpTpDaolQenf+G8=;
 b=sDsPtIaWnIGfXtUjuqPKx1kHGGOxnZiU/zS6FdTprpOTY/+cyYUfNWgZcwDf4IZ7ACGU9B2hKgaj2B/rcILm7GeD2mzlhX1p98fmEmVR5dpcIK6A/0CnANffoWCgs8xGKFiRPjqnjLjXxScsYKdGCJ4bogVxt1ChWaOd/bItCgc=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SN4PR10MB5576.namprd10.prod.outlook.com (2603:10b6:806:207::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 16:32:11 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 16:32:11 +0000
Date: Tue, 12 Aug 2025 12:32:00 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 02/10] mm: convert core mm to mm_flags_*() accessors
Message-ID: <ibymd2u52qofpqqcip6nhfmwz7zlgu5mjg6eg45gkyvi5zklmx@mndueugmtrtj>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YQBPR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::24)
 To PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SN4PR10MB5576:EE_
X-MS-Office365-Filtering-Correlation-Id: d39a0808-28c7-4acb-b604-08ddd9bdc949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?onfiQtijnOqwyEerGEjkMDYzaZVea7ffzrEX2o7obuCX7p4hoF+TMI9gcvSp?=
 =?us-ascii?Q?SHIQESiqo1hPbnYKFwjH9lfbkgqm2G0E8HyAhfnzUx96gwIrHMywzS4XlWdm?=
 =?us-ascii?Q?AvQ3SfcPQTDQxwgliyCWVyt1m6meXjlnwCzwNOASMQ/c0y3lxQTKlnjRhDPh?=
 =?us-ascii?Q?S0sQauQYbDYXA8I66eN3t5NLDBeKx3jMQpbTE98EtX6X6QNK++Xc5Zt3vR5m?=
 =?us-ascii?Q?byTcGWuSb1+Dr32gPO8G1DNafoDY+pEK0t4pRwaXtfCLNwl7Vg6Rs67vTuen?=
 =?us-ascii?Q?IYAmqjQ4zP9TFsI9ehGf5atj+S4ToFG2jkZP6iZcoqWwVPqFmC+vbPdd8mtp?=
 =?us-ascii?Q?BwzCkqIRyPp09hJ3MZVunfAnD4SV257GQWWEJodBuGr5NQYYCDqIbIzKCwap?=
 =?us-ascii?Q?Z8EnaRrGycpdCnia2dHqCf46z3aJdaBVxT7OxRaWk2+qYoe8be0jkYKfHFuT?=
 =?us-ascii?Q?xIGDibjGg5fL4xT+eU97vIIuLYErGNtIbDDeE71uPQDeKqeDJeo5laLg4mf1?=
 =?us-ascii?Q?v5O723YSX9hPfuuw1PYPKJsSk6JrzLxqsgDqJ/IVQa9RKmLV9PKQXW3vYZX/?=
 =?us-ascii?Q?r0oQHD2B+5tfcZzIOn/qeEoaV6wlZTnfWp5oDIaiDC7H5xrBckcz/QtiJ/c2?=
 =?us-ascii?Q?CmLr712rHaZUMiq57FuPcFZInWJA3cVZOV44GEyb6UA2zCqsbVo8kVuJpOWQ?=
 =?us-ascii?Q?AsFm1aUzdOHTHMD0xHJj4CN+OhXzU5hXnDan9xleJpZtoXG+K1OAb+djDBVf?=
 =?us-ascii?Q?Vgn5zNx7ykqEIpoDH7NzJ9kiikvo5G8UPMKMudWHZk3ad8um89VjGaWT68x9?=
 =?us-ascii?Q?gJ9WjLx9tCPK0DjOKrz6TfJX6WVES2HIM4/9eK2Jh5DT9fGkfNmrRg7wzJhq?=
 =?us-ascii?Q?qt16NgeQp92uPce4T05Wfj5Z64dBe3yIEZK4HdzOw5l3AAoSGZ6fbrZjgFbz?=
 =?us-ascii?Q?JRES8d+m2nKGIVHLECm/8U8l7fwnbYRE29UDphaZvcjRZNIkq+JVMuJR1CeC?=
 =?us-ascii?Q?uGOu3wEGzOYcrlIBT9yzWxDbGhCrj3dPZ5h5l2d39ILYyhNhToK+udUCYTNw?=
 =?us-ascii?Q?HC8sWCjK2uBOtqZnOXeXodOjK6s1Ypa2ztJxovyQYGAnLkec02Nlt76IyJQo?=
 =?us-ascii?Q?/cwM1MOAtbX6xtVMdZkMPNvqyS5CfRfzp796/X2XdFqnF/K0oOyMJc4eMy5O?=
 =?us-ascii?Q?qstsc1MC+BvJqATzQTheKW3mkWerlvEBaMIxpkDwebAia6BhT70fH4uISTlf?=
 =?us-ascii?Q?MO8X/e+pmxOeq82dwQIgZxSKSyvldeiWq8c4aINuYn7a/47IIv2CBt0KXSFS?=
 =?us-ascii?Q?wlI9Fa35qznPPVPRdF7VkOOdGJL/Lic8M9ndhq+hy7H0FLFXHxLQPpf+ZXke?=
 =?us-ascii?Q?V0wMsiVUvmZUktP6vtIzR8F0eUPjIKyReTHe6a3/VqgU6HU/HtRuknEFf1eD?=
 =?us-ascii?Q?9AuMi6yUuCO7xmxetD0kRdlcdf1sPkjQG3JocnAy2ScGbKRecMDt9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xFEnI5jjgsS32aY0REmuV1fZ8Fiu5cvjCUFhTl4nqKrmwis9ru7OWjW2peZr?=
 =?us-ascii?Q?Rb7NOzztmiqUkxVTgtxeY3vU/1Q2XFNuH+sJp4VKqkJp/L3UsMHljX3Q5kL9?=
 =?us-ascii?Q?YbEGMzKa+jJ0GOeYyDoMSpTyEZ7OVegIadlOv9ReZYGD1+kRUg1qd/KW8n0q?=
 =?us-ascii?Q?0t7iiVvLDT6I4pzqwuMvc+eiEM9D1svC6r37Eu3icr9HMY9xZA4+wtW07RsL?=
 =?us-ascii?Q?VO1ybPduG+dDI8vBQa2T+8T7kyxCfT3SvDGuqM5ryoZGD4iUPSV01l3br9zt?=
 =?us-ascii?Q?z5m+arzssvlGX1e/7yPdBu7RxjRmsF1+R3wCOwgiK32yTpNgpjXY7AFUm5hc?=
 =?us-ascii?Q?gxwjbrppKWDElEvGh3eFb8FImMFFoBHjsVjzubIYhsZ9Oddw4+Kd6aUTN/Vb?=
 =?us-ascii?Q?uae2HYUyEhjwpaQxEDc7EoIG3VxzM2huC0pkB3glIfQWKJZzhBBRsNX2meRc?=
 =?us-ascii?Q?pvLJ2pHF1e48S7OHM67aw96EXiH/Y42NqzwygQ4/HJGPDRqHupXF4LTcDCvD?=
 =?us-ascii?Q?xPDoI60vfiI379/2uOFsFWc+QHXRpWXMaz3AXyfntSmbEdXdUD2mo24wFXpZ?=
 =?us-ascii?Q?ZDXaXh6bMJV9bf+77rIUfQ342L98mNFXyZPpnO/DVcFuEgGqo9/cYpGtFVrw?=
 =?us-ascii?Q?Tcu+3Nh8ALFTQlh2v3SB3uN75c+dZduVN9uk68w63jarvBxOynhXrIkMbhFz?=
 =?us-ascii?Q?m1XOlGE08UHQFgjewpd01PFDjqWIAGl0WDrtfxlZKnMOAg3UDCObbIQ84UIk?=
 =?us-ascii?Q?0OEniW3oHFzEfjILDFC0I3h2n5k49dUtJs1tVjTCJnxFAOczGvrnNnSk016e?=
 =?us-ascii?Q?U3xcrYFl+hzKv18KgfYLXMyyjbw/I0kniC/2YfjYBDDfsBDv1Q66oVFPzqVZ?=
 =?us-ascii?Q?D3vD5noeZgXsBVn6FLpUSHPPK77IAcia7+ooFpLwI/5P5qxRzHQPF8fEaP03?=
 =?us-ascii?Q?lDD8Eo3KxKkJBxyeIx7fcm08hpyOfukUoSQywm+U7tHbAxHpkDdehFGDaFuz?=
 =?us-ascii?Q?jgrzAM4CRnR0s/voNCj7gs4zGqOb9hAl++B3dI1U6B4Qr/y/rUqHH2YcgW4I?=
 =?us-ascii?Q?kqH4rSVKLDr/qfki0ZlXWjzjPAUoYCtI3U67pvahgLqBqOh5YvJMOYZXlJtS?=
 =?us-ascii?Q?H2QEiNs9ri2g190hj24J6ND2s+1uTjLi+9FkRv1E2e3GVk5Wn8OkrC4mwBte?=
 =?us-ascii?Q?7co7e+3B7OyLAnCpyEq10ALiRi6mi8rPOJdB6qOpVb1BQ1prOMbT2T6HRRKe?=
 =?us-ascii?Q?rWViZQX8WQKegALWoIgzGcSMt//DXQrXOp7XGtGd+nzZmGeGovqwV9F8MhBo?=
 =?us-ascii?Q?8kgzWt8aMUWE8Exw3UjJzxPpaQN5OzwhO0IZy//BdMt/i7cnnoMAXYCoaZsw?=
 =?us-ascii?Q?colF1Pm4zM8e+wwx2JBCGDFvvutH13S47INqkRtSqpwrXtK1qqmGGYoGcNU8?=
 =?us-ascii?Q?cieVZJCtQBKhUxgBJAND/lF1hgFLioTm8DwW8c3YgjHS8pKSIo9vdZRPj9Tu?=
 =?us-ascii?Q?WbvxbjCytICdmcx572Elw10YfJP71+ZABLUGsPc1p5Z0qlp0xKvkJvd/8y94?=
 =?us-ascii?Q?MDptedkE2P5TW8aBQVtFNnwMrS2WcefWZTbp+nI8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rF8zffSNCoj7aAufyvkoLp3jJoth+RQLylBhlU30hV+7ne28X3EK/LExqJAp3QZkr9JCgjASFFJ2IZM8+sf/t1PvE7bmbPGLpmBRPquDwuhTUO5p03VbZ5Jeyis10dXIxrHohx22wQJeVqDz9llM6pfSZHBB31PgRbj7fte9nkR5nZaWx7xNIr6NJfnrl3Zvr6vUSh8U8MK35O+D/EaQAyUhcPjWFwL2rasptfkqfZBNCm0M+UTWINGqT3L1lhden5tMFLbxoLtsO1v4eP8oFCnDVIsBojW7JjFtOVZyqryjmftyk/roQhKgTFU4JIggrkyVhxRGU2fO4Bb3mODT2ypsjNA9wvC0OBXQcA6zs2igTYDCcE2wBMKlJkZCivaQVa1CumpRde44xfmegEcM8sE8JBATqf90ou+YhedAUsaaimybcAHC4bWnFQLgwNsuPc11wd3IxSILOtZWm2BkuK/P3XTUFo2D5DdTYDOJYtoOrf8DhSiXKkflnTJLsZRegnhZyfwo/gxofyIlHz1yLuWX127fyz85j5GizqcOAOgM/UGYSR1Ai38JDbTKakCzef4qB/yc3saswGXpzls/sxEVwbd5T1Cx67CFKcaf9Es=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39a0808-28c7-4acb-b604-08ddd9bdc949
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 16:32:10.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrnnSn3INNvhkzG4kXgXw+Ye2Ab3+e4db7ZZj5lMbANZbeMd4j2hpO3OWUEH2VE4UWFTH4yAjVVJqs7Rdqft2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120158
X-Proofpoint-GUID: pDWkNhQzhSr3LLr5uEDTTwy5Z8FZzEbT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1OCBTYWx0ZWRfX1VfbCEh54JfC
 hIKNqhdLZVkub4j9e0Xmm84mDQ04QIJ4ruywjZ6Z0IrswRotqokQxbFVQEtpVdRzw/5P1ad4No3
 QW+olh0tYr1XlO3Cw3aIiDAg0+VIawtkJpqWTJ7dt4Zu/fp/1U8FqCO3aZeLdPgkAaXYdW5mxo5
 pWFsBnEpkj+/E4ASbiMYzLzx/OyCtodX7bodPlt6brciol8q3Aszs9aQYptpj7SAEV2gL+V5R/8
 AmzEoG9QRffp/r7SL7v8nw/2fAEWKeWfJdEV/1oDkY+D25zge4bGmDF4hFOxp0rl7i19gApZU92
 /INHNd1i7aBEROQlmlSBlGM1qACc5fgDwhusw3NrL3QL163CHWCkokM5qS4UojjZ1DTxOa04v6Y
 8N+oeDhMn5gzA1cvtvMTKCMcLC+yavUn76bahRUd6EpSWBIzjzPEp6/ww0zbWsWz+k0da1Yp
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689b6c92 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jCXvxJfq068tc1syhhUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: pDWkNhQzhSr3LLr5uEDTTwy5Z8FZzEbT

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250812 11:47]:
> As part of the effort to move to mm->flags becoming a bitmap field, convert
> existing users to making use of the mm_flags_*() accessors which will, when
> the conversion is complete, be the only means of accessing mm_struct flags.
> 
> This will result in the debug output being that of a bitmap output, which
> will result in a minor change here, but since this is for debug only, this
> should have no bearing.
> 
> Otherwise, no functional changes intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/huge_mm.h    |  2 +-
>  include/linux/khugepaged.h |  6 ++++--
>  include/linux/ksm.h        |  6 +++---
>  include/linux/mm.h         |  2 +-
>  include/linux/mman.h       |  2 +-
>  include/linux/oom.h        |  2 +-
>  mm/debug.c                 |  4 ++--
>  mm/gup.c                   | 10 +++++-----
>  mm/huge_memory.c           |  8 ++++----
>  mm/khugepaged.c            | 10 +++++-----
>  mm/ksm.c                   | 32 ++++++++++++++++----------------
>  mm/mmap.c                  |  8 ++++----
>  mm/oom_kill.c              | 26 +++++++++++++-------------
>  mm/util.c                  |  6 +++---
>  14 files changed, 63 insertions(+), 61 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 14d424830fa8..84b7eebe0d68 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -327,7 +327,7 @@ static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>  	 * example, s390 kvm.
>  	 */
>  	return (vm_flags & VM_NOHUGEPAGE) ||
> -	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
> +	       mm_flags_test(MMF_DISABLE_THP, vma->vm_mm);
>  }
>  
>  static inline bool thp_disabled_by_hw(void)
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index ff6120463745..eb1946a70cff 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_KHUGEPAGED_H
>  #define _LINUX_KHUGEPAGED_H
>  
> +#include <linux/mm.h>
> +
>  extern unsigned int khugepaged_max_ptes_none __read_mostly;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  extern struct attribute_group khugepaged_attr_group;
> @@ -20,13 +22,13 @@ extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  
>  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
> -	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
> +	if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
>  		__khugepaged_enter(mm);
>  }
>  
>  static inline void khugepaged_exit(struct mm_struct *mm)
>  {
> -	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
> +	if (mm_flags_test(MMF_VM_HUGEPAGE, mm))
>  		__khugepaged_exit(mm);
>  }
>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index c17b955e7b0b..22e67ca7cba3 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -56,13 +56,13 @@ static inline long mm_ksm_zero_pages(struct mm_struct *mm)
>  static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
>  	/* Adding mm to ksm is best effort on fork. */
> -	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
> +	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm))
>  		__ksm_enter(mm);
>  }
>  
>  static inline int ksm_execve(struct mm_struct *mm)
>  {
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +	if (mm_flags_test(MMF_VM_MERGE_ANY, mm))
>  		return __ksm_enter(mm);
>  
>  	return 0;
> @@ -70,7 +70,7 @@ static inline int ksm_execve(struct mm_struct *mm)
>  
>  static inline void ksm_exit(struct mm_struct *mm)
>  {
> -	if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
> +	if (mm_flags_test(MMF_VM_MERGEABLE, mm))
>  		__ksm_exit(mm);
>  }
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4ed4a0b9dad6..34311ebe62cc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1949,7 +1949,7 @@ static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
>  {
>  	VM_BUG_ON(!(raw_read_seqcount(&vma->vm_mm->write_protect_seq) & 1));
>  
> -	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
> +	if (!mm_flags_test(MMF_HAS_PINNED, vma->vm_mm))
>  		return false;
>  
>  	return folio_maybe_dma_pinned(folio);
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index de9e8e6229a4..0ba8a7e8b90a 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -201,7 +201,7 @@ static inline bool arch_memory_deny_write_exec_supported(void)
>  static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
>  {
>  	/* If MDWE is disabled, we have nothing to deny. */
> -	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
> +	if (!mm_flags_test(MMF_HAS_MDWE, current->mm))
>  		return false;
>  
>  	/* If the new VMA is not executable, we have nothing to deny. */
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 1e0fc6931ce9..7b02bc1d0a7e 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -91,7 +91,7 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
>   */
>  static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
>  {
> -	if (unlikely(test_bit(MMF_UNSTABLE, &mm->flags)))
> +	if (unlikely(mm_flags_test(MMF_UNSTABLE, mm)))
>  		return VM_FAULT_SIGBUS;
>  	return 0;
>  }
> diff --git a/mm/debug.c b/mm/debug.c
> index b4388f4dcd4d..64ddb0c4b4be 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -182,7 +182,7 @@ void dump_mm(const struct mm_struct *mm)
>  		"start_code %lx end_code %lx start_data %lx end_data %lx\n"
>  		"start_brk %lx brk %lx start_stack %lx\n"
>  		"arg_start %lx arg_end %lx env_start %lx env_end %lx\n"
> -		"binfmt %px flags %lx\n"
> +		"binfmt %px flags %*pb\n"
>  #ifdef CONFIG_AIO
>  		"ioctx_table %px\n"
>  #endif
> @@ -211,7 +211,7 @@ void dump_mm(const struct mm_struct *mm)
>  		mm->start_code, mm->end_code, mm->start_data, mm->end_data,
>  		mm->start_brk, mm->brk, mm->start_stack,
>  		mm->arg_start, mm->arg_end, mm->env_start, mm->env_end,
> -		mm->binfmt, mm->flags,
> +		mm->binfmt, NUM_MM_FLAG_BITS, __mm_flags_get_bitmap(mm),
>  #ifdef CONFIG_AIO
>  		mm->ioctx_table,
>  #endif
> diff --git a/mm/gup.c b/mm/gup.c
> index adffe663594d..331d22bf7b2d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -475,10 +475,10 @@ EXPORT_SYMBOL_GPL(unpin_folios);
>   * lifecycle.  Avoid setting the bit unless necessary, or it might cause write
>   * cache bouncing on large SMP machines for concurrent pinned gups.
>   */
> -static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
> +static inline void mm_set_has_pinned_flag(struct mm_struct *mm)
>  {
> -	if (!test_bit(MMF_HAS_PINNED, mm_flags))
> -		set_bit(MMF_HAS_PINNED, mm_flags);
> +	if (!mm_flags_test(MMF_HAS_PINNED, mm))
> +		mm_flags_set(MMF_HAS_PINNED, mm);
>  }
>  
>  #ifdef CONFIG_MMU
> @@ -1693,7 +1693,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>  		mmap_assert_locked(mm);
>  
>  	if (flags & FOLL_PIN)
> -		mm_set_has_pinned_flag(&mm->flags);
> +		mm_set_has_pinned_flag(mm);
>  
>  	/*
>  	 * FOLL_PIN and FOLL_GET are mutually exclusive. Traditional behavior
> @@ -3210,7 +3210,7 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
>  		return -EINVAL;
>  
>  	if (gup_flags & FOLL_PIN)
> -		mm_set_has_pinned_flag(&current->mm->flags);
> +		mm_set_has_pinned_flag(current->mm);
>  
>  	if (!(gup_flags & FOLL_FAST_ONLY))
>  		might_lock_read(&current->mm->mmap_lock);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b8bb078a1a34..a2f476e7419a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -251,13 +251,13 @@ struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
>  	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
>  		return huge_zero_folio;
>  
> -	if (test_bit(MMF_HUGE_ZERO_FOLIO, &mm->flags))
> +	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
>  		return READ_ONCE(huge_zero_folio);
>  
>  	if (!get_huge_zero_folio())
>  		return NULL;
>  
> -	if (test_and_set_bit(MMF_HUGE_ZERO_FOLIO, &mm->flags))
> +	if (mm_flags_test_and_set(MMF_HUGE_ZERO_FOLIO, mm))
>  		put_huge_zero_folio();
>  
>  	return READ_ONCE(huge_zero_folio);
> @@ -268,7 +268,7 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
>  	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
>  		return;
>  
> -	if (test_bit(MMF_HUGE_ZERO_FOLIO, &mm->flags))
> +	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
>  		put_huge_zero_folio();
>  }
>  
> @@ -1145,7 +1145,7 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
>  
>  	off_sub = (off - ret) & (size - 1);
>  
> -	if (test_bit(MMF_TOPDOWN, &current->mm->flags) && !off_sub)
> +	if (mm_flags_test(MMF_TOPDOWN, current->mm) && !off_sub)
>  		return ret + size;
>  
>  	ret += off_sub;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6b40bdfd224c..6470e7e26c8d 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -410,7 +410,7 @@ static inline int hpage_collapse_test_exit(struct mm_struct *mm)
>  static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
>  {
>  	return hpage_collapse_test_exit(mm) ||
> -	       test_bit(MMF_DISABLE_THP, &mm->flags);
> +		mm_flags_test(MMF_DISABLE_THP, mm);
>  }
>  
>  static bool hugepage_pmd_enabled(void)
> @@ -445,7 +445,7 @@ void __khugepaged_enter(struct mm_struct *mm)
>  
>  	/* __khugepaged_exit() must not run from under us */
>  	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
> -	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags)))
> +	if (unlikely(mm_flags_test_and_set(MMF_VM_HUGEPAGE, mm)))
>  		return;
>  
>  	mm_slot = mm_slot_alloc(mm_slot_cache);
> @@ -472,7 +472,7 @@ void __khugepaged_enter(struct mm_struct *mm)
>  void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  vm_flags_t vm_flags)
>  {
> -	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> +	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
>  	    hugepage_pmd_enabled()) {
>  		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
>  					    PMD_ORDER))
> @@ -497,7 +497,7 @@ void __khugepaged_exit(struct mm_struct *mm)
>  	spin_unlock(&khugepaged_mm_lock);
>  
>  	if (free) {
> -		clear_bit(MMF_VM_HUGEPAGE, &mm->flags);
> +		mm_flags_clear(MMF_VM_HUGEPAGE, mm);
>  		mm_slot_free(mm_slot_cache, mm_slot);
>  		mmdrop(mm);
>  	} else if (mm_slot) {
> @@ -1459,7 +1459,7 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>  		/*
>  		 * Not strictly needed because the mm exited already.
>  		 *
> -		 * clear_bit(MMF_VM_HUGEPAGE, &mm->flags);
> +		 * mm_clear(mm, MMF_VM_HUGEPAGE);
>  		 */
>  
>  		/* khugepaged_mm_lock actually not necessary for the below */
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 160787bb121c..2ef29802a49b 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1217,8 +1217,8 @@ static int unmerge_and_remove_all_rmap_items(void)
>  			spin_unlock(&ksm_mmlist_lock);
>  
>  			mm_slot_free(mm_slot_cache, mm_slot);
> -			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
> -			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> +			mm_flags_clear(MMF_VM_MERGEABLE, mm);
> +			mm_flags_clear(MMF_VM_MERGE_ANY, mm);
>  			mmdrop(mm);
>  		} else
>  			spin_unlock(&ksm_mmlist_lock);
> @@ -2620,8 +2620,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  		spin_unlock(&ksm_mmlist_lock);
>  
>  		mm_slot_free(mm_slot_cache, mm_slot);
> -		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
> -		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> +		mm_flags_clear(MMF_VM_MERGEABLE, mm);
> +		mm_flags_clear(MMF_VM_MERGE_ANY, mm);
>  		mmap_read_unlock(mm);
>  		mmdrop(mm);
>  	} else {
> @@ -2742,7 +2742,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
>  vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
>  			 vm_flags_t vm_flags)
>  {
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags) &&
> +	if (mm_flags_test(MMF_VM_MERGE_ANY, mm) &&
>  	    __ksm_should_add_vma(file, vm_flags))
>  		vm_flags |= VM_MERGEABLE;
>  
> @@ -2784,16 +2784,16 @@ int ksm_enable_merge_any(struct mm_struct *mm)
>  {
>  	int err;
>  
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +	if (mm_flags_test(MMF_VM_MERGE_ANY, mm))
>  		return 0;
>  
> -	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
> +	if (!mm_flags_test(MMF_VM_MERGEABLE, mm)) {
>  		err = __ksm_enter(mm);
>  		if (err)
>  			return err;
>  	}
>  
> -	set_bit(MMF_VM_MERGE_ANY, &mm->flags);
> +	mm_flags_set(MMF_VM_MERGE_ANY, mm);
>  	ksm_add_vmas(mm);
>  
>  	return 0;
> @@ -2815,7 +2815,7 @@ int ksm_disable_merge_any(struct mm_struct *mm)
>  {
>  	int err;
>  
> -	if (!test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +	if (!mm_flags_test(MMF_VM_MERGE_ANY, mm))
>  		return 0;
>  
>  	err = ksm_del_vmas(mm);
> @@ -2824,7 +2824,7 @@ int ksm_disable_merge_any(struct mm_struct *mm)
>  		return err;
>  	}
>  
> -	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> +	mm_flags_clear(MMF_VM_MERGE_ANY, mm);
>  	return 0;
>  }
>  
> @@ -2832,9 +2832,9 @@ int ksm_disable(struct mm_struct *mm)
>  {
>  	mmap_assert_write_locked(mm);
>  
> -	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
> +	if (!mm_flags_test(MMF_VM_MERGEABLE, mm))
>  		return 0;
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +	if (mm_flags_test(MMF_VM_MERGE_ANY, mm))
>  		return ksm_disable_merge_any(mm);
>  	return ksm_del_vmas(mm);
>  }
> @@ -2852,7 +2852,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>  		if (!vma_ksm_compatible(vma))
>  			return 0;
>  
> -		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
> +		if (!mm_flags_test(MMF_VM_MERGEABLE, mm)) {
>  			err = __ksm_enter(mm);
>  			if (err)
>  				return err;
> @@ -2912,7 +2912,7 @@ int __ksm_enter(struct mm_struct *mm)
>  		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
>  	spin_unlock(&ksm_mmlist_lock);
>  
> -	set_bit(MMF_VM_MERGEABLE, &mm->flags);
> +	mm_flags_set(MMF_VM_MERGEABLE, mm);
>  	mmgrab(mm);
>  
>  	if (needs_wakeup)
> @@ -2954,8 +2954,8 @@ void __ksm_exit(struct mm_struct *mm)
>  
>  	if (easy_to_free) {
>  		mm_slot_free(mm_slot_cache, mm_slot);
> -		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> -		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
> +		mm_flags_clear(MMF_VM_MERGE_ANY, mm);
> +		mm_flags_clear(MMF_VM_MERGEABLE, mm);
>  		mmdrop(mm);
>  	} else if (mm_slot) {
>  		mmap_write_lock(mm);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7306253cc3b5..7a057e0e8da9 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -802,7 +802,7 @@ unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm, struct file *fi
>  					   unsigned long pgoff, unsigned long flags,
>  					   vm_flags_t vm_flags)
>  {
> -	if (test_bit(MMF_TOPDOWN, &mm->flags))
> +	if (mm_flags_test(MMF_TOPDOWN, mm))
>  		return arch_get_unmapped_area_topdown(filp, addr, len, pgoff,
>  						      flags, vm_flags);
>  	return arch_get_unmapped_area(filp, addr, len, pgoff, flags, vm_flags);
> @@ -1284,7 +1284,7 @@ void exit_mmap(struct mm_struct *mm)
>  	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
>  	 * because the memory has been already freed.
>  	 */
> -	set_bit(MMF_OOM_SKIP, &mm->flags);
> +	mm_flags_set(MMF_OOM_SKIP, mm);
>  	mmap_write_lock(mm);
>  	mt_clear_in_rcu(&mm->mm_mt);
>  	vma_iter_set(&vmi, vma->vm_end);
> @@ -1859,14 +1859,14 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
>  			mas_store(&vmi.mas, XA_ZERO_ENTRY);
>  			/* Avoid OOM iterating a broken tree */
> -			set_bit(MMF_OOM_SKIP, &mm->flags);
> +			mm_flags_set(MMF_OOM_SKIP, mm);
>  		}
>  		/*
>  		 * The mm_struct is going to exit, but the locks will be dropped
>  		 * first.  Set the mm_struct as unstable is advisable as it is
>  		 * not fully initialised.
>  		 */
> -		set_bit(MMF_UNSTABLE, &mm->flags);
> +		mm_flags_set(MMF_UNSTABLE, mm);
>  	}
>  out:
>  	mmap_write_unlock(mm);
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..17650f0b516e 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   *  linux/mm/oom_kill.c
> - * 
> + *
>   *  Copyright (C)  1998,2000  Rik van Riel
>   *	Thanks go out to Claus Fischer for some serious inspiration and
>   *	for goading me into coding this file...
> @@ -218,7 +218,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
>  	 */
>  	adj = (long)p->signal->oom_score_adj;
>  	if (adj == OOM_SCORE_ADJ_MIN ||
> -			test_bit(MMF_OOM_SKIP, &p->mm->flags) ||
> +			mm_flags_test(MMF_OOM_SKIP, p->mm) ||
>  			in_vfork(p)) {
>  		task_unlock(p);
>  		return LONG_MIN;
> @@ -325,7 +325,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>  	 * any memory is quite low.
>  	 */
>  	if (!is_sysrq_oom(oc) && tsk_is_oom_victim(task)) {
> -		if (test_bit(MMF_OOM_SKIP, &task->signal->oom_mm->flags))
> +		if (mm_flags_test(MMF_OOM_SKIP, task->signal->oom_mm))
>  			goto next;
>  		goto abort;
>  	}
> @@ -524,7 +524,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  	 * should imply barriers already and the reader would hit a page fault
>  	 * if it stumbled over a reaped memory.
>  	 */
> -	set_bit(MMF_UNSTABLE, &mm->flags);
> +	mm_flags_set(MMF_UNSTABLE, mm);
>  
>  	for_each_vma(vmi, vma) {
>  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
> @@ -583,7 +583,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  	 * under mmap_lock for reading because it serializes against the
>  	 * mmap_write_lock();mmap_write_unlock() cycle in exit_mmap().
>  	 */
> -	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
> +	if (mm_flags_test(MMF_OOM_SKIP, mm)) {
>  		trace_skip_task_reaping(tsk->pid);
>  		goto out_unlock;
>  	}
> @@ -619,7 +619,7 @@ static void oom_reap_task(struct task_struct *tsk)
>  		schedule_timeout_idle(HZ/10);
>  
>  	if (attempts <= MAX_OOM_REAP_RETRIES ||
> -	    test_bit(MMF_OOM_SKIP, &mm->flags))
> +	    mm_flags_test(MMF_OOM_SKIP, mm))
>  		goto done;
>  
>  	pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
> @@ -634,7 +634,7 @@ static void oom_reap_task(struct task_struct *tsk)
>  	 * Hide this mm from OOM killer because it has been either reaped or
>  	 * somebody can't call mmap_write_unlock(mm).
>  	 */
> -	set_bit(MMF_OOM_SKIP, &mm->flags);
> +	mm_flags_set(MMF_OOM_SKIP, mm);
>  
>  	/* Drop a reference taken by queue_oom_reaper */
>  	put_task_struct(tsk);
> @@ -670,7 +670,7 @@ static void wake_oom_reaper(struct timer_list *timer)
>  	unsigned long flags;
>  
>  	/* The victim managed to terminate on its own - see exit_mmap */
> -	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
> +	if (mm_flags_test(MMF_OOM_SKIP, mm)) {
>  		put_task_struct(tsk);
>  		return;
>  	}
> @@ -695,7 +695,7 @@ static void wake_oom_reaper(struct timer_list *timer)
>  static void queue_oom_reaper(struct task_struct *tsk)
>  {
>  	/* mm is already queued? */
> -	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
> +	if (mm_flags_test_and_set(MMF_OOM_REAP_QUEUED, tsk->signal->oom_mm))
>  		return;
>  
>  	get_task_struct(tsk);
> @@ -892,7 +892,7 @@ static bool task_will_free_mem(struct task_struct *task)
>  	 * This task has already been drained by the oom reaper so there are
>  	 * only small chances it will free some more
>  	 */
> -	if (test_bit(MMF_OOM_SKIP, &mm->flags))
> +	if (mm_flags_test(MMF_OOM_SKIP, mm))
>  		return false;
>  
>  	if (atomic_read(&mm->mm_users) <= 1)
> @@ -977,7 +977,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  			continue;
>  		if (is_global_init(p)) {
>  			can_oom_reap = false;
> -			set_bit(MMF_OOM_SKIP, &mm->flags);
> +			mm_flags_set(MMF_OOM_SKIP, mm);
>  			pr_info("oom killer %d (%s) has mm pinned by %d (%s)\n",
>  					task_pid_nr(victim), victim->comm,
>  					task_pid_nr(p), p->comm);
> @@ -1235,7 +1235,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  		reap = true;
>  	else {
>  		/* Error only if the work has not been done already */
> -		if (!test_bit(MMF_OOM_SKIP, &mm->flags))
> +		if (!mm_flags_test(MMF_OOM_SKIP, mm))
>  			ret = -EINVAL;
>  	}
>  	task_unlock(p);
> @@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
>  	 * possible change in exit_mmap is seen
>  	 */
> -	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
> +	if (mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
>  		ret = -EAGAIN;
>  	mmap_read_unlock(mm);
>  
> diff --git a/mm/util.c b/mm/util.c
> index f814e6a59ab1..d235b74f7aff 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -471,17 +471,17 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>  
>  	if (mmap_is_legacy(rlim_stack)) {
>  		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> -		clear_bit(MMF_TOPDOWN, &mm->flags);
> +		mm_flags_clear(MMF_TOPDOWN, mm);
>  	} else {
>  		mm->mmap_base = mmap_base(random_factor, rlim_stack);
> -		set_bit(MMF_TOPDOWN, &mm->flags);
> +		mm_flags_set(MMF_TOPDOWN, mm);
>  	}
>  }
>  #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
>  void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>  {
>  	mm->mmap_base = TASK_UNMAPPED_BASE;
> -	clear_bit(MMF_TOPDOWN, &mm->flags);
> +	mm_flags_clear(MMF_TOPDOWN, mm);
>  }
>  #endif
>  #ifdef CONFIG_MMU
> -- 
> 2.50.1
> 

