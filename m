Return-Path: <linux-fsdevel+bounces-59296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ECFB3703B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 18:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DED688515
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5B313E3F;
	Tue, 26 Aug 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fMVo3yq0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G+hkOH/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1172C15B6;
	Tue, 26 Aug 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225631; cv=fail; b=L8RhB+2SHXTpZsFX2/aPPOqP0MDmLqN6dFhKcJMyjlBWk0Flq1Nf69WkHV0GUDmR8/PbaUIoPrNMSVuNugIMho14XbDzi72Ut3Rg9VtSAY2UapM1waOxs3llrQjCse17y05KjtOHHuWhC+UX/IAj6OYUN2WHL1q0OxYCh3tEC2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225631; c=relaxed/simple;
	bh=R2dHI/SU9VFh2X+U+PShOtfazCfO5U2EKB70zohKkh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q6kfg7PoWD3GXvJ8uH/1s1HCRiDSeiW8yS085bm97W/RNb66DmcbIG3IZEDmBG6n0g8bMZpH4eodwgN+SFp4r8BJPMXjGNgexahJfg+ToKPNcpwlp0x/oy90lozJKo0n+/AFk2s2gkMrm43SLtP3I2k4fc2MMsL/iZU+Ck1GFyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fMVo3yq0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G+hkOH/Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFCA5e015587;
	Tue, 26 Aug 2025 16:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=R2dHI/SU9VFh2X+U+P
	ShOtfazCfO5U2EKB70zohKkh0=; b=fMVo3yq09aQGV+HAQGztVCJmdVZZzgAsnq
	J/lPzQ+wX8SacXMkCDOoca5W+xSYEwyF+4q8r6rgY5r4JfyfoWR3dbBYfWa/lBNu
	eMUj9DKhAz6sKrir1Z1lrDb1P3OmsCnt6D980edC6iVwPEi4sXDpoAfFqidayq7D
	GXjXq+D8fTx5PNmp6iRHEeLuei0y+ZvtNxNmVtIE1UzXsvuY2h4RPiqckSyf5jwD
	4QWHfDVXVOM/iTqIo1uNHxSvV3cJ/D/oFDo4pHM/7i4VYVdcDrZg2x6fvkSZTCOx
	BpkJFse3EQf6D6ZoRUJTScDUPLKnSydDeldV+v2Ljtz0H+g6+SmQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e24wre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 16:26:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QGFqv4027035;
	Tue, 26 Aug 2025 16:26:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q439nyvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 16:26:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBniM3M2AWIIbg2K9ilQQBYtOSAcZnbaveZxLrL7X2aXy+AlS5Ye9Ul2YQdS7dHw60+L/2jqY2MZ9Z32sr1DAJRZd/BdEouCBGxptTBUT8UHLKMk/zDXiI+zDX3Ewt0yZENFIQhibEI7eQQDEZriHBNWOFM/2VujZ7jGl/bI4OyoWurnZrz1hI9zAKRxsnR6IJoTO2YArCwk3RJyERc694nHZkmFo7UZl0JCbqsyzvH8CejEVksP9FZAFMFjeKeF+aiQ+aTsuzojMc63uw7xZD4uXIeix3E3dnEmSQJ93fLfWIlYTTk/ZgkIvUUsB35TIlAMKW3dZWjrYGDfDId5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2dHI/SU9VFh2X+U+PShOtfazCfO5U2EKB70zohKkh0=;
 b=k+cUTk0b7Ch+qP/cDsfc4BxSa/CsWjgE3NIos5Bcmnb3dp2hIpCfLJmEUUOFA6v/h87IDIlPihjG1O4w/rCsxxbWJrDKTpxvyirI3SMUifsnXBlU+worYRAG8PDxSaizWV272onWItK4R936FBEXYL00srTVeufvuzyNy9XxeWafgRaxyc3UtmacIOfKVo+8cSurffQhinjytcpJst1s5QT7B6UoTKydTa2KdBR47YWa4t2JEnd0oXDddbz6BkqNQZVvyGhIsDLBpDX9U4qUB7zE8JLVriQQKsqZx4lV5XigjJl90YaYYi4YA6FteQDw0peJK0bK/ZmX/SSNI4/jMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2dHI/SU9VFh2X+U+PShOtfazCfO5U2EKB70zohKkh0=;
 b=G+hkOH/QDxQxeMGUnBS9QFscET/xXLWRh30JfM+Oflklz8rfOnMgA/FG0qkk9dVwu4ovgXCTxng5w5NsThf3JOk8V+56nodpoK2rFFIzbB+r40/9KbHLCcRZ97kDfLH8ss5Swu0IWxDFzG6ZFcFLTS0a2iOmCb1QNIDJg7GGOlA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7374.namprd10.prod.outlook.com (2603:10b6:8:eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Tue, 26 Aug
 2025 16:26:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 16:26:21 +0000
Date: Tue, 26 Aug 2025 17:26:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
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
        Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
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
Subject: Re: [PATCH 08/10] mm: update fork mm->flags initialisation to use
 bitmap
Message-ID: <8cc0b687-326c-4e8e-9a32-4e101c898e2a@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <9fb8954a7a0f0184f012a8e66f8565bcbab014ba.1755012943.git.lorenzo.stoakes@oracle.com>
 <73a39f45-e10c-42f8-819b-7289733eae03@redhat.com>
 <d4f8346d-42eb-48db-962d-6bc0fc348510@lucifer.local>
 <d39e029a-8c12-42fb-8046-8e4a568134dc@redhat.com>
 <1743164d-c2d2-44a1-a2a9-aeeed8c13bc8@lucifer.local>
 <e91f7a38-3b17-4a0c-aedb-8b404d40cf59@redhat.com>
 <9e7f5149-afb7-4e94-b231-78876c41a438@lucifer.local>
 <49df1a2a-7c5b-4ada-98b8-8d7871fd7228@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49df1a2a-7c5b-4ada-98b8-8d7871fd7228@redhat.com>
X-ClientProxiedBy: LO4P123CA0065.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f373dc8-719d-44fd-f94d-08dde4bd4ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DrhvFH+fjHsC0LFawyh2gWEFEwJsV7XbewNM6WoDmvfYPzx1eD270kNjx4xz?=
 =?us-ascii?Q?6UNOG362xTYI34jfLHD5eDf3Z/ltGWD59lKfWH3SrkRRskIh4tTaEchDjFlX?=
 =?us-ascii?Q?AA0Qfl+xKhcA4CGE+d7cd0qmyT2a/I4g7aB49ft7EFEbG8Uv+Prppzk9MffR?=
 =?us-ascii?Q?0Lo/KlTECNmFfICS6FixJbou2FwAjDPzEb7LLLD5f1LUrSdYOkhU07TY/TG1?=
 =?us-ascii?Q?QZjic16CS1578gGHHVOMMMbZmZkjKF9v1r+NE6bCUeUhC/B21tx1DhLe/aZ+?=
 =?us-ascii?Q?d0mSJYNml3ihyNNgA0uFZtm1DwgitBmUNhYlZL/R0RruWakFViRYIDyEalLt?=
 =?us-ascii?Q?GWCrIxF+HgB+6sM/Zh+NPUBUZXo53q9InRX9xrMQkyo7d5k2C7sdQqo1cLao?=
 =?us-ascii?Q?h+dvhvALiJ8tp1xyAr0EcR9vB/kqTFtHPuI8qw6I+Bb8gImgfLWeZPALvHFn?=
 =?us-ascii?Q?DckBgzqJo241cKEwNVLLymjftAlwK90kzplcdHYOHQN1o8i9ezzwVvNCNrzv?=
 =?us-ascii?Q?76u6iyUG9AP8Nef9Rcl1WB+AyiWmjJd3CtENtTGtrGK73k/fmktPZY6fzziV?=
 =?us-ascii?Q?d6qhednf8bGo6mwRjLlNDE56IR+i9l7IUzcmpI+VM0UM2Tk02ee/KlHmHvsG?=
 =?us-ascii?Q?Ya2ImSNSxX+Ad6UQs1IabM0IrMfOsrwO+N+DUFhRvwrlU4u+U9YaKoncuPL6?=
 =?us-ascii?Q?pkNz+Z8HHzzUULxnWet3sDbXpfe6U5/SUlx9+Rzcodu/QZSMJInkxUjEcz/R?=
 =?us-ascii?Q?1Dzv3RDph5pS5wnzZKdXaUGsSa6DG3ak34b0SA1U3tmIr972ybHZMl4bzPvc?=
 =?us-ascii?Q?6ZwUiFGJrix76GJwXO705qyjYvdbrDUe0ysV/0mY5tMPV1lyBXOiZNc9ML0+?=
 =?us-ascii?Q?FWevcEaOIcyhSpfC8zkKaCyyvmdhAHSgTnyFPCjdkM6atOOmM0y8L8hjxKBb?=
 =?us-ascii?Q?4TWXZmZ9OmjWiBsRbYGM/2MhxlVdKLPYbWHznoHg8CQltLkTnA4Q2+Jv1tDF?=
 =?us-ascii?Q?rm0fWMhR72k/qPIvbdfFo7FByFixYAtI5gbjGfZ5KhTKdmiQWRXkVX97XTvZ?=
 =?us-ascii?Q?5tiQUTBwGEG+Klf7dc+YdHkhv4evqCKhbkTvZjd9xN9VS2JUmPoTme9oIZCW?=
 =?us-ascii?Q?mZ7QcxFDavlNuKL0dMFeEac/lcxc2wfgu/vUaoVE1cSYPBPA8dmJOY+UuNiK?=
 =?us-ascii?Q?5jeR4Qo+vIMTTrRZfRgIloQ0cqMPVBDNpcg5aB+7XG2hDlYA95kf4o6DDe5P?=
 =?us-ascii?Q?+Y52BN8cJGrbA6womYhiW6RLLtyRCI5gYpWHXYhpz7G3JecXEIQLtaYQx3Mo?=
 =?us-ascii?Q?I9++4Fwn46hqn4kpznI/sKp37Qi2eo8CFi+QsUCcPVTcl0HOh12Y/yyAICMt?=
 =?us-ascii?Q?7ewxjT/11ZulORMFx+IwgwwMdgaxkgkvrhYFjyfNhP0yXmB2VomcaY4SjaFG?=
 =?us-ascii?Q?GuBqQocDvSc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S9NoxvQe7gEfwUyv2aFNLfg7ltxkmT+tQsMlnT90VgorwwGU+hZYqXGkOFRN?=
 =?us-ascii?Q?t7Dsv8xFIblurTXBiTvDu6tBHkmu4ISxrHpUYk4PIcEbUNQxEb0RCE100CPu?=
 =?us-ascii?Q?Bfnq/dbVHT2YkMgQRSmRNRZgaf/RU2W3EmwDZODfZdiulFRGrzvhsd10DUcg?=
 =?us-ascii?Q?aJzM5jI5HeTygCmgO0XK7Ns1oH6MJxNWNTuT/iUmTpwsGk6hs39ma48VPRa0?=
 =?us-ascii?Q?j1hWqgPJXBGFBxvwQ/+PiCCkKByqhKhLS9HbsTu7y4Xl5wIS3WFpJjnrJP3a?=
 =?us-ascii?Q?pLx2Nyj9kucxJIEJygH4lsfNE3Jq246ZfSiulhraC+/Zeiy31Ujex8HXxXyP?=
 =?us-ascii?Q?gLYYFjJtDoJa2d/LuUNjcv+4GRO6wlqYwXeKIYdowmhxOKHD37PRHFi27KF7?=
 =?us-ascii?Q?Ne3cQNnfRhpRFQgN9VeujImvW4Io94zbF6YPn8fiMnCMQm+7hQUlZo0v8VUU?=
 =?us-ascii?Q?ntkAlif9seiAQnPTkhYURwh3wAh/6sfEY7rcxkEzWJhJiNCojCxLXMHWfjsx?=
 =?us-ascii?Q?ec658ZP974UeQRuTBm0GjOnqDCv4XjPhJAvHIqPXD2Xr1jpL5lEwyLhAjMEL?=
 =?us-ascii?Q?KATzHo3cQ3vxBCcGiEmZzDoQ4Rqgu0A/A3VhmWozpCF4ss3ynbIzEPnkoY9D?=
 =?us-ascii?Q?MK5SzN1Hq9W/akMCJN/2OBb9+sEAEXYZcEvDL3DxTTFOH3N5B+YdpnEwNQMZ?=
 =?us-ascii?Q?znBmvFNqDzgkXZPHaW3lGjh1rZTGPGb6C9HXvUCqpcmjbpxQ8hop785JYOVc?=
 =?us-ascii?Q?rks78shTQVFt/bs+s6nSVEVSGBp5BTxQHASPFyRTocSGtUYCRpAHUMgSpyTM?=
 =?us-ascii?Q?vPF6zC8xu2NWxfc17TyyuDEQna6VDGIFg81hHUsET7py4NpZysTUUVQo2WdE?=
 =?us-ascii?Q?6SZpZXnkFL1CUps5yZ6CakF/mAC92YPXq9fiEEwhL3twAwXLEBkPDK4YU3tp?=
 =?us-ascii?Q?2EzsbumZ7YmRJzJpcU/Ux42+h3BQbNVInaUDG2wH/dZFgh1uDQWl8bPu4YT0?=
 =?us-ascii?Q?z5z8I0wTYC95Dhq1ve1hatsxhozxxdV7zTI34zgGAyAt+ppP2hXCzr9oGGxx?=
 =?us-ascii?Q?q66tlkE06ibpQhz6RyJVqTn6tQoEI7mdkoPdjQw+ujYPbrICXAlIey4nxGB/?=
 =?us-ascii?Q?Z25ThXkVh75eP5nen6srC/cXHSXga1uSlSdJYBT3+izM1UH8K4/Olv97Ovx4?=
 =?us-ascii?Q?HBZA+IW+XkaBnEY75LLHjxGTA3f6I+8c8x9zcCwEqMDmuCj7OPdr7BntrdhA?=
 =?us-ascii?Q?u5j7y5Ltx0H+ovD3GZVmqX5ozTSJoFKcj4gAhpJXLw0o9e/4obooy1ouIY7s?=
 =?us-ascii?Q?W/aJ3vwAkzJmFzDiknsfMzF/zSSa6Jne1Zvy/ChYBSxlTmZEJrt2R96f17be?=
 =?us-ascii?Q?/5WwQrJgnBWM2wnedz8jK9vwnb3NO8wjudDwYOkKFk7h3oY1L7kBQzSh1MfX?=
 =?us-ascii?Q?gI9AUSwORM05MUWKG30Y6EbIIpvZQrlbLncHdeVf04AqTsq6gGsf86VsH4kY?=
 =?us-ascii?Q?LzHQKAhdEz/cIIip6VEPwA1KLobYfrQ3YDHB/Nw2kcJ+BUF/B9BXxuH2MQ3e?=
 =?us-ascii?Q?/WKLBbgoDO5ivH8MIZCn+NpwcWoMS5IwiKQztXTorfDfq7aSqvF9JcColQh/?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z/rjGqTT5xfeYgR+gbxLVYGBqZJO6R//EAO3zHXalFmAzux18tAJcvDatVQz/68gLGWiCxfm2Kz9pwgkrhDWO8+xUzCOPtI4HO7DGLm69V02nSFinKsH4JqBepfYv3RG/Wfd3YAsWs6fIgALfkeT8mWQ72bwbG3B9wE9VxOEZTSvA1ba3/9NWp66lhEWw+9EZZk9sVRV3hwNQq3iTZZPwJjeOXK26D6+QWaje7L2X9BIrDDpHS72Z4Os5NsgX2RM0UNBNOofMp0CAIqv8sCqCi8PMgZval+glFDcSYIbA2Iwxq6s0zmuz6SwW7Do8e64y6HcgnRhyEA2H6bo9DrsKwlFa9yHZMcicpm0lxW3Ou052gGs6S489mxCCds9p2dCd42rsUJsbGsBCdgDETrpReSA1wUCxeC1QCcvTSOx5q0tXD0ciDjjovOibOwyOU4jgBY61/y/LtjRNZOQgx+DNlJNnVOfkm++0SpOcqFTMwg7/BrI+X9Sou+kYmuFEu86OzqpnsGktljExhIArs5OSoMSohMD8Psq0MOUQTRzVeoZtii5tb7kKAbnL+TACydzHvBhNi4BvpVZiOzdNniPjYnmjj+dV7yI47Haz0H9QLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f373dc8-719d-44fd-f94d-08dde4bd4ac4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 16:26:21.1935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRUXnThsbPmhkhteYPJOtu9J/RAf4a+NOFDCV+kWqopEQ8vp+lnR0wXSVUwVFRVxYva7aO6D16goKtDasfxd5qv++U9bq8pZH2LpVz2TKAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=874 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508260144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfXzC4PLckmXgL6
 A50oCy/ZV6XkSZT+IXgoe9JIE8+PpJ1RJ59LpU/avzXxASfFZFuiDiV0gEEh2X2SH4X9eu1BTyt
 TTWXFIZfCEHdVlBBWLnG13Z6ogY7FdJmGR2I0hw1HGO+8xwLYu49yPl2fn5Zly6WQGUMffBCt8u
 0TRIkMpU+fk5vpZqVEVNGHtPBL7y3n9A5CYJX76umUXvca7yUBVHNOZUfUkoIw+zCl9nOUSvFhL
 l1U8tSU7FQLVArsAvFdG68iiylW3GCXbiqpXuKEhRe3QoE0kliDeuw/qzLvSjkY1PraGE9/6fz+
 k3JYz6aEWdv0cBhRDhZV5onv6Tf+3t1TKdBP7ZitAgZ002SS01vfIB94QoDLwsO0/qdbH5uFHYS
 QyZybtH+
X-Proofpoint-ORIG-GUID: crvmaLrdPasG_m_bveo5C2GKcDKrFH5q
X-Proofpoint-GUID: crvmaLrdPasG_m_bveo5C2GKcDKrFH5q
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68ade035 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=tz00E6j9x_Cuw3vMqpAA:9
 a=CjuIK1q_8ugA:10

On Tue, Aug 26, 2025 at 05:53:36PM +0200, David Hildenbrand wrote:
> > OK right I see, in both cases BIT(32) is going to cause a warning on 32-bit.
> >
> > I was wrong in thinking (u64)(1UL << 32) would get fixed up because of the
> > outer cast I guess.
> >
> > This was the mistake here, so fine, we could do it this way.
> >
> > I guess I'll have to respin the series at this point.
>
> Let me think again: assuming someone would mess up the BIT() thing and
> convert back to 1 << NR, your variant would catch it on 32bit I guess.

Yeah and it should also catch the BIT() case albeit via warning :P

>
> So given I was primarily confused by the "u64" when talking about 32it, no
> need for a full resend of this series just to clean this up.

Yeah this isn't _terrible_ I don't think, although I was labouring under a
misapprehension (understandable - hopefully :) in the way the casting would
work, but of course you're right the ub would happen _prior_ to the u64 cast.

Anyway I think net we're getting the same result, and the comment makes clear
the intent, so I think yeah sort of fine as-is.

But I take your point absolutely :)

Cheers, Lorenzo

