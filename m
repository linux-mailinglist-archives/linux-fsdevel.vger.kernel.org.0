Return-Path: <linux-fsdevel+bounces-59219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B66FFB36B00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD951C44FA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984C4356900;
	Tue, 26 Aug 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DdcWdKdG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J77MkVi1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E1341AA6;
	Tue, 26 Aug 2025 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218147; cv=fail; b=nAIwmHN6feJKITA0fxk+jvXJp2r9iwmKjyIoQsBi9EcOnWxGWYCRR8rg6+yEvNlaygk9wfTnnVbDVbBy0zU8wx1rca/T4jHlq6XzfSvLvmhlDYkfeKs4fAtWsIk0ZEAYIPQ0LL7DksmpCHF6Xx3LW8bTuynD6hKHGKMJ6ecizP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218147; c=relaxed/simple;
	bh=ejssl9ghuN3arC2XW1ID4SeVHxL7EekH67mNXb5eEfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kYQFsCGlIzoW7WHgJUo8+FMRll9MJkHKftc/s++qI/MgwBwIUSw6zb8r+R8Z38xGZ4bCOB5bwws0xLfn6adbf4R1OYL7gT6oY7clGlvN8gAxzbQAh6iY8lIm2RkKfyK1vcDeL2BJuh6qQ5aKJiWxw/Hqe6cwtzbn6QV50R0rre4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DdcWdKdG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J77MkVi1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCH25A022437;
	Tue, 26 Aug 2025 14:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XoM4ONvzIFYK05FsbF
	wZqF33YF3O2cdzbLyPUAO++vI=; b=DdcWdKdGoPrZaw2eSdy8uNU1T+hGFTdUGf
	ntOyOkN6TAibhr0SZW1AkFMx8Sf9NVD7jK78Hxg2WcneEjdaZrtPC7slqn53v2N+
	AvihcW/lVvySl+Z6aaKVGo/ZQ/+YqG190l0GMOIGX3GHE1A4c6YKY6dB45B/BUcE
	S+KgnI1wSIe/eLKr/uRdB2eoThoaK6WzeubbAh9sAXKKys0O27iNR92f7A0ZT5ix
	F41ifPP8C6D6J12ZTTEodxRR79+AtyMwEB3J51Y50TiFTeO1dqIJFeS+t8RspeXu
	1O2TgyhiUUtFpTvWxfBGF9P0e6NHQ4pCrLi3Xcq6T0guLBLt6pxw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q678vhr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 14:21:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QE8Nwo005065;
	Tue, 26 Aug 2025 14:21:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q439sbb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 14:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEW3/am/8nVSy1gOcC5/XCYaPxQglF7Na+2kVdnFmVYA+oAmXpUZ1VvCqAQCU4KI8LGvMuwDwmOTbLtgwnXZX0Mf9lSmekcXm+cSTbNePry7uWh0NaUsVhxqDMRhjFWzDfk/dNy/Bm7sljX/yK7q4Eo1nnxRAgXMlq7lJ1dbqtH9NHfpP3gDiWve1W1C6ro0LggavJRtmpIxjh3IrKPLT3Vdzay/fHwc43VM42oMhrqcvRy9HAvRy5H7oRo2EDSxT/QWxNNFhOQ9484jOgHVR1R09LV5HFE28m6oTFDp4asy3rZno/lAy/DR/NVevG3MT+I7S5QJSkHt3jBuS0eYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoM4ONvzIFYK05FsbFwZqF33YF3O2cdzbLyPUAO++vI=;
 b=lIoFhsq1sym6czeeoJm1MmU6g9VL/0VsDvtMjH7Nc07cgRT0diqFqpaSRRtZrueTluLpQUkb0A1FOLiI4W0Q4YBZ5UIObexUW9lkmbCGiwZ7hvEvRSHqqWtvFtPggFxLs7FiHhimlHgLk1pQQJrFjwKJvx1ILibvpgC4alxf+jSx/YuE0OsPQ8cpEJmrqUs/zlv5NeEGgyPSUGNTd/WJqw0WJ0vEOvRFJtKIiZqlH8I06OW7HsOEA9tBApenJ/37UUBPiRkufrHZ3TCTo/Yw4OpYmZxlR48rRGe7rSJeqh7cZDWeTYvrWtMjYgSVoqywWk4r424vU8aDHHoq4Pw/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoM4ONvzIFYK05FsbFwZqF33YF3O2cdzbLyPUAO++vI=;
 b=J77MkVi1Xaz+HurCaYQPc5MwoeKeocWSX6ijtxrE5kQC63s86s0Ax9mvPjypbPHrceBstOf353tXd6+CGq/wCaiLo+5qwhkqxSLEeB66BzH/+Cbn74t8+8goOYlXbDySA3ytalHi7eZa7u0mMTw3olKB/QQ/ShFuLQ9oa+xKsI4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8084.namprd10.prod.outlook.com (2603:10b6:408:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 14:21:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 14:21:31 +0000
Date: Tue, 26 Aug 2025 15:21:28 +0100
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
Message-ID: <d4f8346d-42eb-48db-962d-6bc0fc348510@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <9fb8954a7a0f0184f012a8e66f8565bcbab014ba.1755012943.git.lorenzo.stoakes@oracle.com>
 <73a39f45-e10c-42f8-819b-7289733eae03@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a39f45-e10c-42f8-819b-7289733eae03@redhat.com>
X-ClientProxiedBy: LO6P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 3369b24b-8394-4dcd-c5a8-08dde4abda94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SESGGSUZsjHlgtc5/mzhDmohVW/UKSDi7acoTdA8Idq9ROAedyaowyPnX5W7?=
 =?us-ascii?Q?bcmziDI0vP3xDh44W+ahNI61qU7bLxcz2sLZn8Ngo+sKcBLIxyyQXUtzAwmO?=
 =?us-ascii?Q?aJjNHWIuDcSZY2/CK2QwEj5/iIIY4vKD1UTJBv71cc4fC0Uy9Ra6WeCRD8HJ?=
 =?us-ascii?Q?HPr2DnHGve2ywh4d2YNIa3LAjRHfsJhNO9QMDJV1JDNbQXBaUWT4JNHb8dGX?=
 =?us-ascii?Q?xLFSHTeVFD4O7t/96k77mJ7haIXjSE2D6QSS8EmHLnUeL9iGvkBeq6eW5OrY?=
 =?us-ascii?Q?0DKNpETyQlHE+7AGTieyItT0Y3YxVPg0DOIDFeu035E/7OovFdiVb8Wj37P7?=
 =?us-ascii?Q?KoZjXHByEv2JFzswTq2xiaIJ6ryE35w/DoLwhObb3Ar601HS0Gz2hqOdP6j4?=
 =?us-ascii?Q?TuWHvZ+mNOb9Y2SC0f8VHThKQ1rABHSM3JF7sAgKLftpwQOJpwmBm2XMW6S+?=
 =?us-ascii?Q?ACLrzAexNgjl2j77Xkzu0z0F+XBIOlaMdMVZwnjF2bHXX4OtKh/hnqAQzEqu?=
 =?us-ascii?Q?OGndOeaZmh7JMNaEYgzJhHBRi+GbJ870g0CRSdVnKn2h5wqjVFuYoTMAdvKs?=
 =?us-ascii?Q?Qa6W1MRp5enGU5rCFEvKyJ2eVFAkygWfbRwX+R/j5savqFjF0wUc544TrsWx?=
 =?us-ascii?Q?MQbzenn0gBrkdm+8R1Khme1X2aoDKwBwJI7IBJIga8rQqwrhdToa09XN/pIB?=
 =?us-ascii?Q?BLR+4ms7Ls4j1pcVE/Oskvef61xqlrDNRNmbPZCCTey1V7uf1OHJcufknOVO?=
 =?us-ascii?Q?JNXSLuzlM9Te6VLOVGeSw9LYo+Nz3BEmC0Un2SkomXWMnsOH9sO9MXKtFKEr?=
 =?us-ascii?Q?ymaqTegGRdLNMbZBMvUdAN3zNyYFrj9uT5mhXc6eY3o0trAkhI4fym76FrO0?=
 =?us-ascii?Q?Qy9o2S28Jjx1/riTVsMDfVf2/yPHnRkW23m8ln7gg/0Dq1lcsyqG3s0WJScp?=
 =?us-ascii?Q?UQqzWfXgRNPZ9G7d4qp3CzS0/T2OUv2OFimrdjSspthARp3IFem/tvOmiT+d?=
 =?us-ascii?Q?PLULBtr6+K/i8TiNjGS1gZYO3n0Ed95aaBdLSyi5iJPuG1BQLJz5rlf4Zmyz?=
 =?us-ascii?Q?AWkqXphYF1p8pTDhigSbSEEkGnUUNzPPa+X/zedh3IT7W4x5zT55gFTSz1/K?=
 =?us-ascii?Q?hNvUh+4q9t2FB87OVQitdhDA7t5gHqSLuUUtGsAqeq/JM7PcMav2fsZ3iZoq?=
 =?us-ascii?Q?WfaMYtueOo1H1xncgz+mkOC8yGp1LKkflWZBH7DyW2dtD1JbDE1NweIvTzWg?=
 =?us-ascii?Q?zCbT9L5twm1OO+ZdHvrLmmHEwRJcSxGmjoiToqANB6ExSGt1+RCsGs3X8dia?=
 =?us-ascii?Q?nB41fIjWy2bHjkBxuWUVM/iKbofaGcwlk3U0t76hCF/NItg1d074zFK2/x8z?=
 =?us-ascii?Q?8VrZf6vLoMOBZqEv98QuU8dXI/RM1knq+2OBScz2Q37F1WLvpaNq0z9Mg4C8?=
 =?us-ascii?Q?iLVMpGyQTSI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?05jB8+QOlLQK7GMdWglv3uL2GYUKLOVxhxIhXvQAABu19hb4kj6UJMKkJ/kT?=
 =?us-ascii?Q?5EU11hTfp5RcLoFMF4FG4z8/E+3aX9UTdzOG0MtuPCYrett89qRcCNNX0/zb?=
 =?us-ascii?Q?NISyvk+g40C6wHn42TqkT/E3PnNz2yHtba8bVvtLaBEILd1oRziiudWs6E9L?=
 =?us-ascii?Q?DxyTsbTkblStlEXOpgDQTV9ggltYJRxhHHztdj4dLId6t/1grSJYVskq6TBF?=
 =?us-ascii?Q?DovmpBSDG7cBVyFebriv5JSoIsfCwYaZhUhPK/EWUuCHJEkYwDRq4JL6eWhY?=
 =?us-ascii?Q?UO8w6+v10Un4zpgKG/c07yLiccOYPhNTVhBr76IF2XV9pLRIsDudPmoGiWZm?=
 =?us-ascii?Q?6AdCQ/W/9K/RcGpetatz2naFgigFoQo0lDMPPyJGiHqwXpBEV2Pe60dQ5wpC?=
 =?us-ascii?Q?UKScSv1NOIQ13ySiYiFlPH2C8VV5SsNA+ar28Vtgiygd3lqFrrzK6tP0N914?=
 =?us-ascii?Q?15NUkgECFrr4moTzqmAehDgf4ZOGAbfcLGJaXnyzOSPDWT2uw73j6AZ4hj5u?=
 =?us-ascii?Q?iwc/i1wG/hWglOpKX+5Wdwyk+zu/NhE8KCbwhQCUN32IlxsBNqePv6ToadRc?=
 =?us-ascii?Q?GNSeJHBbtfMxS21QiSKPYf8sESdYEjx37lMqVmQeDMtl3byC90vgT00Go462?=
 =?us-ascii?Q?oNJoB6+e7lX+QLZ6NObUYFTFsNRS7hU06QDI77e5HE+InixrIWbqpnFr/nd8?=
 =?us-ascii?Q?uxk4CnDZr7nJFLCR3X5ZOTTh5aBWJ31d+3xKPO32sEkdoAOHJPELZDWNJ+WY?=
 =?us-ascii?Q?1+94Zq8rG+aH6SAtQA+HC5WGLoSmyq2Um98Eu+eQMoA9+o55vYJ35sGTidrj?=
 =?us-ascii?Q?Ui7T0DeQCUEE9IWhk7vevRyqlmEA/T2zBFF0YflBRsi9lVNGpqT2x8vjZwxE?=
 =?us-ascii?Q?QZ/M344RAYmjk2fQ5Zfeju93YJlrc2eU8pjHX7YuK1+S3M5K8KH2TTeMxNoL?=
 =?us-ascii?Q?9vdxvqBWMum2zexvNP1WGg1i0qStn7VFDebeeHYBVEkJdWCUprfzWBLOZJgn?=
 =?us-ascii?Q?lrRil1BbYXkSMvBfsEVU4BnR8KhOGfqijoQUIQjuKHN6yXYonzkheBLSsLu6?=
 =?us-ascii?Q?7uJzIN0Mu7RKAATYWZxAA7AiIp8RXfKDjD4Zba2aLxHxEEnoYMptcGB7gn+E?=
 =?us-ascii?Q?R7vEoWlK0np7GGvlmir1qmlmUrxZ1CPzGbinGJFxJ42GRL0Nd426a1LG+wPB?=
 =?us-ascii?Q?enplcnik7NsQT6hLBKyzaLsHCdthw2BoR89DrQcHbWcjxZmWoHtsLegAHwHW?=
 =?us-ascii?Q?1X7Jlg7AIsi4RtBEqP9eupOpdS6VpNeTVkVPAJR2wCRnXp7QsZBomxnbU8vB?=
 =?us-ascii?Q?9Jw8A5UbVFJ5wg81Rl6vdcyGLTlCmpcKg1lmijB9nm4/eO3QJ81ktzNKzX+7?=
 =?us-ascii?Q?EpE3aIAaJJb+20Lmb1VB9V2X5VHX4XtH1mpU3eeRDwLvF6pZ5MGKcD2pehoR?=
 =?us-ascii?Q?TuP+4E/bU7dgkyr9X38HRYgiagbqylQC1Gjyf+Rf+on+HlQMf5w9t5jrWgru?=
 =?us-ascii?Q?H3TX0fK+1w584ViTOtxqARp/qbOffKwmNK1hEpcCjFKdFCyXhJPqPgpEns90?=
 =?us-ascii?Q?EcDZiLgZN1WPGTTDiQqoWhLdRCIheUDX83n9eeoWrwIsBt7nG2Safa1d69Cv?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OVTt8g34TZlRNzauot/6qWlR6HZhewNDen9Yrs82HqaJ2IcBK5/dIrcKnHxu21vNElaY7wv8dhjaUfA0qCkRJlTWzVUfA2bke4bRGQcqkswOoeqI2oll/Snv8GSJqTLNSwTiPx6nKtfnlsJZraW5FgB9pODW8O+XUe3FeW0PwJxS4D2/EErzfuOZ7I2rpAEkZXy/9UJlIe+dPNprqTZ4a1AoTdDfcGRxI126/rmzzRuczR4WRzrm95U5Qrx25vE2xDgn4FhvugqCnuaWeJszxIEJxfzLpWuKaTp0xM0nb464tFQ8kRjImVf4BJkV8OrpnKoEvSctgbEiOc8rip6/mxyOGO1lIuj9hOU7jPESEAdov8cG0CIHuuaw6/DTkZL3hF1h/BrqSMMnk6TLiiMYA8t5cHZg94UNGqhAudz9qWLytBU9Us0uqln72ooCsDWYO8ypktzs5Nj2oTamps+vR2vjkefjciNWdxlplIBn2uBLcLk/7+h1KQ9futE8e4x2NIB4E9XXK3AY+u4M34D6MicFjxpiC/7dNOCOGOqUE5szuVzS3V4Xw3/h9ywVbo851ees0shCwZQFmQzzjaexhMJRkgedMY7koH9WnNYSJJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3369b24b-8394-4dcd-c5a8-08dde4abda94
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:21:31.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYSetEc7mwDkEeK//UmjE7XLrOS/TrMXtpv0poQMyNOaKGGps9jXIUtmYUT0AYaP4TIl/2nuEwccPdUifUPqm1enhj7OtyuaN6a26Sg2FL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260125
X-Proofpoint-GUID: lav0GmRnfN_7C6Wa7vu30twD7JewO7PM
X-Proofpoint-ORIG-GUID: lav0GmRnfN_7C6Wa7vu30twD7JewO7PM
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68adc2f2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=uteFWKwLDzXGDGXyEYEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfXznfofIsaJF0x
 0BJSSH3ysH/w3XrvRlI17+/HCxMjGbXJtF4N6nUBaSZCaRagc7adIeK+4EpWmOji/JdsqWdywyW
 kV607be32iUpox4aa/SDq4IzP5bbP7vjRqpPs9u67oJqWmIbMJEysAiRiVk9gB6zG8MNhmlfkU2
 7YWztm/xIOzRhAfO67SIs2wO4Yx7y5rPvVlBPpaw9KDeN5PP3jEh0c9EowxDcLyA77J9ZKYdTsE
 LK6dbqwJmkYGtcQL8FMSsrJ1IxI6QU43pSxJGLVqjCO6v5u9Zv6TWzpVqOdg6ncJUpj4qq8m+R+
 SHEiRitazeOgsRAhM4OxgXs5FfRq9S6DJ3ss11KPetaHmvgCK44TdnJEbwqA45ZlAjNaaM5lLAT
 +85oRtj1

On Tue, Aug 26, 2025 at 03:12:08PM +0200, David Hildenbrand wrote:
> On 12.08.25 17:44, Lorenzo Stoakes wrote:
> > We now need to account for flag initialisation on fork. We retain the
> > existing logic as much as we can, but dub the existing flag mask legacy.
> >
> > These flags are therefore required to fit in the first 32-bits of the flags
> > field.
> >
> > However, further flag propagation upon fork can be implemented in mm_init()
> > on a per-flag basis.
> >
> > We ensure we clear the entire bitmap prior to setting it, and use
> > __mm_flags_get_word() and __mm_flags_set_word() to manipulate these legacy
> > fields efficiently.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   include/linux/mm_types.h | 13 ++++++++++---
> >   kernel/fork.c            |  7 +++++--
> >   2 files changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 38b3fa927997..25577ab39094 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1820,16 +1820,23 @@ enum {
> >   #define MMF_TOPDOWN		31	/* mm searches top down by default */
> >   #define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
> > -#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> > +#define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> >   				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
> >   				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
> > -static inline unsigned long mmf_init_flags(unsigned long flags)
> > +/* Legacy flags must fit within 32 bits. */
> > +static_assert((u64)MMF_INIT_LEGACY_MASK <= (u64)UINT_MAX);
>
> Why not use the magic number 32 you are mentioning in the comment? :)

Meh I mean UINT_MAX works as a good 'any bit' mask and this will work on
both 32-bit and 64-bit systems.

>
> static_assert((u32)MMF_INIT_LEGACY_MASK != MMF_INIT_LEGACY_MASK);

On 32-bit that'd not work would it?

Kinda the point here is that the issue would get picked up on either.

I think with the comment above it's fine as-is! :)

>
> > +
> > +/*
> > + * Initialise legacy flags according to masks, propagating selected flags on
> > + * fork. Further flag manipulation can be performed by the caller.
>
> It's weird not reading "initialize", but I am afraid the kernel is already
> tainted :P
>
> t14s: ~/git/linux nth_page $ git grep "initialise" | wc -l
> 1778
> t14s: ~/git/linux nth_page $ git grep "initialize" | wc -l
> 22043

British English in the kernel will survive if I have anything to do with it
;)

>
> Besides the assert simplification
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

>
> --
> Cheers
>
> David / dhildenb
>

