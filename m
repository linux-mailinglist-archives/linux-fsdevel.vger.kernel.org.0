Return-Path: <linux-fsdevel+bounces-67458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 381ECC40D1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 17:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5738A4F63C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB2335080;
	Fri,  7 Nov 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VdLTQ+D7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0BzE8KaL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DD2F362F;
	Fri,  7 Nov 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531998; cv=fail; b=Q2CGFvH+IHYMtIT6Edmq6zmTLhufd6UK6vSeVRejqEb9uc6KXFifOPmmSCTgyzzsCqDr/Vg2r3yEuT1OS4uci+jakG8JwOJXdIhBJ7IMEwTaXUOGAYh4V2qRh3N5VMqkvJJ7YKJm9E6mlVHbQAvJ0D0YlcYwHAszgP9ZyAAoXms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531998; c=relaxed/simple;
	bh=qn5qIfmpycSqEyRcz6sssVTF/NCtteWM6OZIPWcWfFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ejSPg9ieJDVQMsIqaHtjXuawLfr5FNtraSbGsbTKF8kK91NWdvJQA+vY6ge3JaT/nFFrth496EUzwG1seOj2+Z7AENG2Qc8lJX0z806FFW3BAMmjPyUuqCgs4/iZ32XxjCbqc+2DQ99V6q46UQQahlDniR6s4B8X1ubftIXk4GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VdLTQ+D7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0BzE8KaL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7FdSpN024547;
	Fri, 7 Nov 2025 16:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zDOwsmrldMeSsYVNVkxs/CpC56gl7bJMghCyJp3/nww=; b=
	VdLTQ+D7ZOUrzqmuGZAahdj2h9m564A8dphZh3YIvkW7pYvDKDjJ5+36hmWxdTth
	jnPeD+k4zJZ/vODbC3UAjx1mj4Pn/j5QO2rdS7/va7PHXyB1x4tA5hFM4xmTV78u
	aV2DaJHQ9HQLGUTJ6gz2Nmt+CkTaHV+rmZ8AM2dJ6wkJqy7BhZZ97G30zOeV1i3H
	pmpeWWz15QPpKKb8JT0bh2wEI4hcfntMdGLXr0WjGoLibgmvyvKIeZACraP3KBv3
	sPjPuQHvlEe7y35quleYVK2bkvCWy/sMgwssC2TysrsdOqUap2cNFxUnfxQcoDHW
	ORrMCWVv98RnZ+RGSaeavA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9kkr8251-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:12:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7Ee2HL039707;
	Fri, 7 Nov 2025 16:12:08 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ndpvwt-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:12:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzL3Pt94Yat2RhpeDLb1UyK0Y49GWIu8sq5SBZG2KCHXzSbWJPnssHGESBPZHK/5T4VZ6unyglWSX4nzFsa3l0u92kwmoE1wHm7Sf8sypbXZQIXiV4R2y+uoloR5dYHVZsbq73VnKrCK1DINOG8mtaBpSwFdnzHjldf61fMw9OWpTquuqgwLh1PAOhhKRDVDWUkDJ0et8JFddK4C2M7/JkXoXM/xErzn8Z5rQIwIgOr5tEnjFYFQrWJdsTps748mz9UEbnZ2fHM1qpBqn6hzbRkQFEHrnnT2ANspCgQIVgtFUUj/5U0Se3vU6Pbylnfu5yDNaw/tCFQ5amZo7xqHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDOwsmrldMeSsYVNVkxs/CpC56gl7bJMghCyJp3/nww=;
 b=s9VpG84rHw7lKVk7eDchA2jiXPpZquc6lib8FfYUBqtikgG6XtVPlcMl+BJ+uSmCfU9Eyu9V+Hg7uAjhEWEnRskvuAbwqcFdwxXfCtQ7UrpPIsutUKunDXbvCqpc9l30bGB0tum+Lp3X/tTgvW8z6UT1cXbl7bwpd7OGgMiaJLd6XwDwyfy0DaRsIC1jy5YpMt3ZSGX5cdIzMCmgY806GBXGrxy4QudgqNNUjkRrupBNm7+mXpv0lgtogH2QEmgAVcTzBSLBQFeJ6HX7h5nf3cQAtpINytbv2nA+EsL0uIYSAylFG88dEdvfn4YwPYBIezyb5Zm2JNToUbzRLPKBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDOwsmrldMeSsYVNVkxs/CpC56gl7bJMghCyJp3/nww=;
 b=0BzE8KaLnoyjkxvdg07avb+LxRxeu8IoDyG4Ks/1kGS6yxoVHlWKQwcG0bG+TQjrP8hSqdvAxyqUw1jm5ItqnBhdxW8o3/gQG9wqbigSYa/2iWlJXhYZ+OWJBJT8lVkPyC/BIDnQ6rshL4D42789eiIa4K0sgRBEwA0MKfjZVUc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPFADA73EAD2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 16:12:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:12:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: [PATCH v3 3/8] mm: implement sticky VMA flags
Date: Fri,  7 Nov 2025 16:11:48 +0000
Message-ID: <1ee529ff912f71b3460d0d21bc5b32ca89d63513.1762531708.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0625.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPFADA73EAD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 90feea04-aa86-409b-2469-08de1e186476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Vthzw8qQYnTH+Wb8ZSm7EdLVfdsf1Eq/4AGlrCH/kbuG8lCH4UGagC1dwU4?=
 =?us-ascii?Q?NxnTTjuVRt0GbDrcUcdlld0r5jfIJRnnXPhykmjp249RxAzfRMBz504TmO72?=
 =?us-ascii?Q?g0KFLsJ0ujZeJFRpwZn8WZ0VDPcQW4BvJ/eWn6yG2pyNAowJ7MXwe/qaEuTe?=
 =?us-ascii?Q?eexyvB1QWVGceZZr89+EpJkUIM8WFGCW5e2iC2IYi6fKLxJl6xr8rooNBJX1?=
 =?us-ascii?Q?3V/Yr8E9iYTuJgoLsScI/ZfzbC62IyffSoVI7yNNzGJoTe1/31/V1V5j+h3E?=
 =?us-ascii?Q?ZhC36bGen4TZw4b3rHRKRTmbmmX3YixGD5SEyAWGsqMXBCdbSjicDXZIWfuU?=
 =?us-ascii?Q?g57SJkoHRkBVTytBqEHZBvzE+3zAMJg8RM8psBNbUmi3np7VNLYL45hyE1W1?=
 =?us-ascii?Q?FEhkGjxwpADgfQhWRLXwT54gVds/n+WRQbAKZcPB052139Ry+0Ts1r0+Pbv6?=
 =?us-ascii?Q?Qjv9dIFtusnLxe1k3R7apobyBubFlrRDmzN016LEmR9ClLoImTWtR2TTtdXw?=
 =?us-ascii?Q?qCfwdagf6QN/zf0/SM01+ZlDbpWiUWxWZlUkWZLYqhwdcnUpyxwbAQiTlMHm?=
 =?us-ascii?Q?JIT8xu3Zy/SqY+lsBhp3Rf37DR4i4XYlxev7QHJLmaE/Q+dBOn+oP2W7+nj4?=
 =?us-ascii?Q?xhKhXwpaC4cxkzvpKplnICzv8FFAqgrw361cL76fhcYwq0T+k8TLaE/mzTSy?=
 =?us-ascii?Q?e14fM1qZrdHeI1S13/e1iGIkMKnL1pHFdoSYSYIMH3WTW/uR7VmvBLtx4u0N?=
 =?us-ascii?Q?eEINN76m5RPlTOlEoBe2rOSjrUkqovg4VflT7lbFLOJn6VDOGCRKV+BBxK6Z?=
 =?us-ascii?Q?Hs/kYpgSejdifx9YbDTENUZBRBkglBJS+lj8vq51/3Fp5dp8w+G0LIkenkIO?=
 =?us-ascii?Q?2HJxn+x6tYxlZM5SMKQ+TGKVUNUCs0u8PFPCqE7kT+xdAJd+gs1AqQRoQ5Is?=
 =?us-ascii?Q?SGf6XdRnFKMHScfs9flIOWgaQXHrXly0XNnO8mE8wi5xqccZK4yH0O9ImEHm?=
 =?us-ascii?Q?+sT71xfvshVyzjOsCYiYYofU/j8G0fx3yKyQHq+8HtPr2ZP4Vwp6KRUHLdY/?=
 =?us-ascii?Q?MkLzcvFyZJiaiyAFN9Q1zIu75x1sXR1SyuUCCGZmcg1CG6v8yInKbFNGsy1o?=
 =?us-ascii?Q?V1Ud0IEkTODLU9U/HgxbQv6RrETaFmqYzQbieSjkRzlJaifdqEVYre2M4w2i?=
 =?us-ascii?Q?2Tr5wKW9kjZj+upuHOyN9vnkqYTM7AtIdwjn0vsIDpimP2Yj1cGrWtsr/+fi?=
 =?us-ascii?Q?QYnf81lL4im9lFoeM/6dgOlRlpxeoL0A4ktAyEee39lxQECsCgb/tyrmblzg?=
 =?us-ascii?Q?93F81NCvyV78LDePnqncQMYElhbGNTeFTgMj+5ZpUqTQOix52+cc2/KOOic5?=
 =?us-ascii?Q?RW8E7mtvnBnLR0nEw6qwwAjsW/+Sx4MIYgOVm8AX21JlLYRHz/BfCQd26agR?=
 =?us-ascii?Q?fQNTtI/AzZdYgbxEnNwC8GIDuV5yrB9f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bZslwbxM1bt2QqQ26N+BnoGUha+evW67dfQd5Vf6PKslh6Vx8vbE2rC/DTbv?=
 =?us-ascii?Q?sllcEnF1REAex78h9Ec3dGEKhCf+uKMYgxYR58C5M+D6MuHfZOGS/3D7ireq?=
 =?us-ascii?Q?I5HJhjzmaMmqjoT0z+5AJYdPGB3GX1lEM87e5Gv5NCPK6eHLBQb6xRujeTAR?=
 =?us-ascii?Q?q1+xWPmfSTm3Zey0jdnyP3yhmc48fbjx9i4cmaE3j1Vjyt0+DRac3BDaYm2r?=
 =?us-ascii?Q?ChVzbpHa8A0tp6Dw0hak1fq6gPRbZe7O/6DyGceOXQWtFGRpZHPt63l5uS+p?=
 =?us-ascii?Q?KFts/gGnmmMq/YTpI/BA6Ehx9qN86lNoQnSA4eVim6zLv19cJI4ytE3uvgse?=
 =?us-ascii?Q?umMyi/1KFuu5brys75CEauoHwC02cQN9m9alBDIB+OqiP88BgWeY1EzgcaSr?=
 =?us-ascii?Q?+9pqh8er0vFxh2YtwawouaxpFG7UinvTL9vhvtDtFnsB+u9GyfwKjdlx9hft?=
 =?us-ascii?Q?UR7VyCTD6aQiS8kF21EEthUKe5MSlsZcrdvpXLPkjqhgBkgvmm3XbL3IvvhA?=
 =?us-ascii?Q?r5kZLtA71LGOWbOXgo+S95rkk9w+XQB1NZ/zhA69GQluahVtx1wo6jsFpPus?=
 =?us-ascii?Q?9EGn6q7I9DI93I8K2Vg1FvXDoX/6EM5OT42oveWbAlY/hqSRi3XaauwbBCg9?=
 =?us-ascii?Q?HNcTwUzJ5fiaIkZE0FvDZN0WNLNnHoeH1orPZc3/AyCTY4ED0QI0i/IkHMn1?=
 =?us-ascii?Q?Gs5/E+SEzT5QkXvU9Ki7dIpiPz4ioPQ0bNJ4p5+KkwiH8B9nIBsvjkjVKKSh?=
 =?us-ascii?Q?EgGEgaxhnpyHCbAwMA601h6Z8eZ6IQ0giUxDmWGT9lvTKfOeV8wdzJsvv9sg?=
 =?us-ascii?Q?r35O1XDFa+8qLw3Z5amlbyvgyHlFf+suFWLPVO5IEF+3DUW5qHaQcP1qV93p?=
 =?us-ascii?Q?5FSxfrzf3ppo+Z0MGCVKN4FtM2gy/oM9tM33b/N8z9u2xAJ3OgQf9JgmEjvv?=
 =?us-ascii?Q?+UA+m8rKaeeBWA3iAaK6ACfHuawFA2DnCjLu0cSVoSICdk0ngtqOQIQXKiSP?=
 =?us-ascii?Q?BkPM2u+2K9aLn4Jk9mkRztUa5/DIs05mkf/dwbrai9YVzJ3dLjLiKANo9mfU?=
 =?us-ascii?Q?Ew+j0EhGx7y2VZkGZJ+fozzUOvGHjf2JN8PmwzHPDNXfzEQU3wlXxztjGFoo?=
 =?us-ascii?Q?bngtjLodUz3F1jZOzEAUElzMRnXDY8cVg0gVkto1FcPiYsIZe9lqDgDFnqN5?=
 =?us-ascii?Q?4J90dLEVn8dF9c80OyUVIHXsHfMcPrteCQiS/20NBnZmVretoxJqSrXhPBSY?=
 =?us-ascii?Q?3SVZIMgwrAZMMZawHEDp567hXLMZ2u0qAq4pLldIsdhNulIHGDBBuqJpjcJe?=
 =?us-ascii?Q?3TE3S0gvDdvSgDDAulw+QUqvDmU2Xs3CYhJrjh1/K0NWQIx+HDq2DOLBFoki?=
 =?us-ascii?Q?IjxQAZJLz/JTupCMpIbpmwMzUqtNWkDChG/PmM6edHOwH0+vxjdRbqtNYaOp?=
 =?us-ascii?Q?1+TIvRwRWnkMdIGw4oRVRdyJKf82SqhkfFIbuzmjp9LuN+gCx5ShzaS8Zw0q?=
 =?us-ascii?Q?P8hHEhcCpFhqplVO4/nVA4FiZvrXbn/+g/yTRtGvijV7dhmhTEOGTg9ttyfd?=
 =?us-ascii?Q?b5EKIKCaE19vDZHHsYbEWBdFbR45amlkgeN+LevKBOYjk7EXviXawLnirEGo?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2FQ9BYGYoqm+pv04jNrDlPysJLmeREWCbL1RZCPhCo6qPIHJmKFtrXCSCN2ol1PmFGWDEL0B42E79H0KcpXhW6MziJF+71U+kk7BPJmwqDpHH+Yjd6FPGZrCbD+/d9QVU+HuVEu8KVOY9EdSaO7rFCwhsYnAwNGREoF9/UVeFBWZXLp56twNmsbI0rSGkVQCXqkGy0uOoM1Dj4aaxfCxutdO/jseMDZvegIvqiaDNx64JuOG/m+E9ULfLye+bwgN1aKC7DvXj+lkpGzNc6QRsjenqDankWmGXGgTw3SpKFqUV0lLB2/Z8MMkMi7wt/RSCS0NfG8Es1Yxpq84fyJMnZMi/ILhqOaHPBCOR26EQHQ/2pmzFXT8mT3fH/snJPA4+eV/jp/IrznLMXDAeEcH3gLriPmgkCo2wiW7QVRC8adrEH6iz8bXGTYnjIEu5gj9Hi2pZlmw3Fv5bSha9XesF7LZr4U9xAcf/0KFh+xE+4Q/z7wMko/W0TF2ylvWT5x3I7j53dyO5czbXH2GNUvxHheTWaitppsgu0+nJyzxKDMWh+B6wK6ZrlXYbek7d6mMhk+BhDUTl6e1ODB/rHy+Qv5lfTLt5JhPJoMJeA7CZaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90feea04-aa86-409b-2469-08de1e186476
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:12:04.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OznCNwKLDQ/dyyvRouDEnjfjWzOdIpI6vykrjfxAco0cxoAgwJjPLUuvY9FrST9YQGlD7Sw6kLWQvgu1Xlgcl4/Dm46JTdijFbM08VKzePY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFADA73EAD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070133
X-Authority-Analysis: v=2.4 cv=O9I0fR9W c=1 sm=1 tr=0 ts=690e1a59 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=JsHXQtKHbWk1tuTe2PkA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDEyOSBTYWx0ZWRfX4wyFDVDKvOK4
 6C6FRyy6jTBV2q/aeWrdz9PkbeKawa0NdGZGVknMxuPdgQWac2x0jVBOJyoI5agf0w6owo99J/Z
 Jq3UeRcf8RQtQLtdTzTUXlLbhKXGK3IcmjZMuFKjCfD2qgrbwZc7PYlreWeoRFs5gi6Ry30wJHR
 h+CLw/YVrfsjKxhzoedZ/Wk05+r1i06s7X92e2xFXTehkpRlPWjgP3xwLhPvERKLSIjDK94IPvJ
 FKSfKDKq9gft5RR/ACA3byaLgHIB2at8Ep9Or0T1tzKg17aGp08Ato8hvMiRo+wpaQEH5keWWqr
 Mlu96m4sVdLZ9kb3dD+gt3DqnxUuQLHnGVWV10ZXk+62tgvSiFPIIf4HRfrmAeLvQElosPBibaE
 WvUVT3RkWXbz8+R0EpX5ux1bLBm7Aw==
X-Proofpoint-ORIG-GUID: CNfKredBGVCDvPcxaiLLrghyyvsFeAQY
X-Proofpoint-GUID: CNfKredBGVCDvPcxaiLLrghyyvsFeAQY

It is useful to be able to designate that certain flags are 'sticky', that
is, if two VMAs are merged one with a flag of this nature and one without,
the merged VMA sets this flag.

As a result we ignore these flags for the purposes of determining VMA flag
differences between VMAs being considered for merge.

This patch therefore updates the VMA merge logic to perform this action,
with flags possessing this property being described in the VM_STICKY
bitmap.

Those flags which ought to be ignored for the purposes of VMA merge are
described in the VM_IGNORE_MERGE bitmap, which the VMA merge logic is also
updated to use.

As part of this change we place VM_SOFTDIRTY in VM_IGNORE_MERGE as it
already had this behaviour, alongside VM_STICKY as sticky flags by
implication must not disallow merge.

Ultimately it seems that we should make VM_SOFTDIRTY a sticky flag in its
own right, but this change is out of scope for this series.

The only sticky flag designated as such is VM_MAYBE_GUARD, so as a result
of this change, once the VMA flag is set upon guard region installation,
VMAs with guard ranges will now not have their merge behaviour impacted as
a result and can be freely merged with other VMAs without VM_MAYBE_GUARD
set.

We also update the VMA userland tests to account for the changes.

Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               | 29 +++++++++++++++++++++++++++++
 mm/vma.c                         | 22 ++++++++++++----------
 tools/testing/vma/vma_internal.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 699566c21ff7..6c1c459e9acb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -527,6 +527,35 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
 
+/*
+ * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
+ * possesses it but the other does not, the merged VMA should nonetheless have
+ * applied to it:
+ *
+ * VM_MAYBE_GUARD - If a VMA may have guard regions in place it implies that
+ *                  mapped page tables may contain metadata not described by the
+ *                  VMA and thus any merged VMA may also contain this metadata,
+ *                  and thus we must make this flag sticky.
+ */
+#define VM_STICKY VM_MAYBE_GUARD
+
+/*
+ * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
+ * of these flags and the other not does not preclude a merge.
+ *
+ * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
+ *                dirty bit -- the caller should mark merged VMA as dirty. If
+ *                dirty bit won't be excluded from comparison, we increase
+ *                pressure on the memory system forcing the kernel to generate
+ *                new VMAs when old one could be extended instead.
+ *
+ *    VM_STICKY - If one VMA has flags which most be 'sticky', that is ones
+ *                which should propagate to all VMAs, but the other does not,
+ *                the merge should still proceed with the merge logic applying
+ *                sticky flags to the final VMA.
+ */
+#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
diff --git a/mm/vma.c b/mm/vma.c
index 0c5e391fe2e2..6cb082bc5e29 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -89,15 +89,7 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 
 	if (!mpol_equal(vmg->policy, vma_policy(vma)))
 		return false;
-	/*
-	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
-	 * match the flags but dirty bit -- the caller should mark
-	 * merged VMA as dirty. If dirty bit won't be excluded from
-	 * comparison, we increase pressure on the memory system forcing
-	 * the kernel to generate new VMAs when old one could be
-	 * extended instead.
-	 */
-	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_SOFTDIRTY)
+	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_IGNORE_MERGE)
 		return false;
 	if (vma->vm_file != vmg->file)
 		return false;
@@ -808,6 +800,7 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
 static __must_check struct vm_area_struct *vma_merge_existing_range(
 		struct vma_merge_struct *vmg)
 {
+	vm_flags_t sticky_flags = vmg->vm_flags & VM_STICKY;
 	struct vm_area_struct *middle = vmg->middle;
 	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *next;
@@ -900,11 +893,13 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (merge_right) {
 		vma_start_write(next);
 		vmg->target = next;
+		sticky_flags |= (next->vm_flags & VM_STICKY);
 	}
 
 	if (merge_left) {
 		vma_start_write(prev);
 		vmg->target = prev;
+		sticky_flags |= (prev->vm_flags & VM_STICKY);
 	}
 
 	if (merge_both) {
@@ -974,6 +969,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
+	vm_flags_set(vmg->target, sticky_flags);
 	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
@@ -1124,6 +1120,10 @@ int vma_expand(struct vma_merge_struct *vmg)
 	bool remove_next = false;
 	struct vm_area_struct *target = vmg->target;
 	struct vm_area_struct *next = vmg->next;
+	vm_flags_t sticky_flags;
+
+	sticky_flags = vmg->vm_flags & VM_STICKY;
+	sticky_flags |= target->vm_flags & VM_STICKY;
 
 	VM_WARN_ON_VMG(!target, vmg);
 
@@ -1133,6 +1133,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (next && (target != next) && (vmg->end == next->vm_end)) {
 		int ret;
 
+		sticky_flags |= next->vm_flags & VM_STICKY;
 		remove_next = true;
 		/* This should already have been checked by this point. */
 		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
@@ -1159,6 +1160,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (commit_merge(vmg))
 		goto nomem;
 
+	vm_flags_set(target, sticky_flags);
 	return 0;
 
 nomem:
@@ -1902,7 +1904,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
 	return a->vm_end == b->vm_start &&
 		mpol_equal(vma_policy(a), vma_policy(b)) &&
 		a->vm_file == b->vm_file &&
-		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SOFTDIRTY)) &&
+		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_IGNORE_MERGE)) &&
 		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
 }
 
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 46acb4df45de..a54990aa3009 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -117,6 +117,35 @@ extern unsigned long dac_mmap_min_addr;
 #define VM_SEALED	VM_NONE
 #endif
 
+/*
+ * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
+ * possesses it but the other does not, the merged VMA should nonetheless have
+ * applied to it:
+ *
+ * VM_MAYBE_GUARD - If a VMA may have guard regions in place it implies that
+ *                  mapped page tables may contain metadata not described by the
+ *                  VMA and thus any merged VMA may also contain this metadata,
+ *                  and thus we must make this flag sticky.
+ */
+#define VM_STICKY VM_MAYBE_GUARD
+
+/*
+ * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
+ * of these flags and the other not does not preclude a merge.
+ *
+ * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
+ *                dirty bit -- the caller should mark merged VMA as dirty. If
+ *                dirty bit won't be excluded from comparison, we increase
+ *                pressure on the memory system forcing the kernel to generate
+ *                new VMAs when old one could be extended instead.
+ *
+ *    VM_STICKY - If one VMA has flags which most be 'sticky', that is ones
+ *                which should propagate to all VMAs, but the other does not,
+ *                the merge should still proceed with the merge logic applying
+ *                sticky flags to the final VMA.
+ */
+#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
+
 #define FIRST_USER_ADDRESS	0UL
 #define USER_PGTABLES_CEILING	0UL
 
-- 
2.51.0


