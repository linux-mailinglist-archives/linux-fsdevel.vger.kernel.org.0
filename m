Return-Path: <linux-fsdevel+bounces-68494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0042C5D5EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36D1035DBC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E0316907;
	Fri, 14 Nov 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c5cizqb1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RBlwhwqE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040713161A5;
	Fri, 14 Nov 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126956; cv=fail; b=F2s13lwQbKZko6lSbsvmlrwPZgGWXAW3XAS6bQUhxxJr2bf8JOKeZJjLOrrkyRzeYhEnQKs6FzUNumr4lJyPDM5ipCY6/Ww/qGVsz96W11PWjsbyZLIrzpiiBe3G/6G8LUF70XS/zGw1CexlCpIO2XTkFSoip+EDxdJ7GEVU2E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126956; c=relaxed/simple;
	bh=Xr3fRXElPUknMVIeKH6nCdYhBhNPPxzHOOYYIsdcgg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rOKODKoMG9owV+bsamovAl+GXcDump9qdkDcA9Kdy8xH+nnU4HoJdJATWk4QBQTWcIgqvcmsNRQGk4/oqh30+dr66vZ2gkvdTHSE2lUHu43jnojevknYPbdI6tAwhv7ZuQbVzsUmuvwmGPQHTqHXrINd7Yb/JYThADcnfEgu7DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c5cizqb1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RBlwhwqE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECuCjJ008858;
	Fri, 14 Nov 2025 13:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ayAiCkLV2y1JDJm7p9tMJG37MIxO8VGfUUkffaDPp+4=; b=
	c5cizqb1MzJ2Xd0/E+dLcZ32Dy8zxSaBA7mo/ag3aJeO6YNQIjvQob13RilnVO6L
	IJ3i47ItBeiY2Vl45NJEaCAPmDH9xU4QhHRviR8YFkpm2a4ZqrIWF20L4K2L8+dv
	YQydR8prTW4LDqOUJbc85xFMD+DQ9Lxr5JNBjqyQKLaIUoFEuNu4xIMm2bUpInca
	iAVf06t4404s7vLsWK3teF3cUlTTNyogy4lyE+iY/JRKZlQOtG0lsFC6pT3w+HeI
	Yooa2B+J0UNFU6xSsc0SFG8gSsu2hf2UfaeP0uQUzqZTEVTAUoFOsRm6hPuNXopH
	pK4+Dn95XVqtWqLt+sMmdA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8v15ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 13:26:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECPACh038491;
	Fri, 14 Nov 2025 13:26:39 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vadgv4s-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 13:26:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKh0xzqFG1Wtf++zqJFQhL1quKhOUnYyFqlZjh+P5ZBLH2uARKJ4/g+5ineF1YQCrMWfqQYUtDzB27q0W9E71bJ1GrjstLz+lCGpA+MsOP7HTGukT0KJMVmdO0q6YsB8B+JfJ4qoN7CULTW5pQZPjBYLnmc8xTIaBMn8/S0Kpt3p8GCP5bDhQ+n3jsMDNrkuhFEzcBdyaFbRjmBzZbqpA9GephMR/P89u1HSenbSZ5Dp0HAcitPZvkV/+wantGxtt9uFRzGkpny/CQ4/xFDW41dn2U0qqH2P24yThtA/F0rmlVwKSrIiVa6B36svsoT/487Ou/fqmGrFrOKKMONUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayAiCkLV2y1JDJm7p9tMJG37MIxO8VGfUUkffaDPp+4=;
 b=ebKb/K2wfdUJ/wAIvlptu5flZbL0pDJiW9L28DP8jxOB6q7YnVUDBYxR4W9IKh1IMMnrwjJiWeIZNW55G73TG/cPWAn4d1Cvg7bnmg+7NnG35g5acCD1wauKEjEdNU5Siq8QQhH6bDic4q8xDbbfELSgWLCNybocRjrPUwx//36Qaj65kKj8Y6BSql5leNFAjKeQkpTGgxODRQMbT3bpPMTJUaDWIAATLh0s0iBUFuqbpVWBrLg2pUyqIi/cRclEkZXldAQ0OxlzDLV1S21eB+0sdQm2hRg8orVu8tJ7wLof4q4WL7d/3Dm8Y8g7ecKKA2qn2FTeIXCi02PkdnjygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayAiCkLV2y1JDJm7p9tMJG37MIxO8VGfUUkffaDPp+4=;
 b=RBlwhwqEWTaNH17Wj7he12DE1vcR+M+H7N6BYG8GhK3qv9BSjH3o6k4zwxnCPj9P5uomj8jrx3XZAeW0FJz0mS3WC8VkHaYIjYNHck8iFF2g/1+ha/Up+vBLqHdOt/ol8EBYC8roXGR7cAlwwutPUF6ohyDJUzyipt2BKZi6H/g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA6PR10MB8061.namprd10.prod.outlook.com (2603:10b6:806:43a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 13:26:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 13:26:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 2/4] mm: simplify and rename mm flags function for clarity
Date: Fri, 14 Nov 2025 13:26:09 +0000
Message-ID: <a319a71d57a2af3930051c46dad954d03d55857d.1763126447.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0238.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA6PR10MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 5416f6a7-f305-42c6-aee4-08de23816e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I3LzEX2HqXHLpcONSbFNcXlNPrJHuNcldOQdLJtveJzbSy/3F9NE9lFBbybb?=
 =?us-ascii?Q?HU72nLirW36yqEgWf6VYBdxzKSa2Hs3aP1g1hII6ES48WT7NMK+SgUxXaaqH?=
 =?us-ascii?Q?H7heYhk1z9Y2w9VGgV+p4EowyyP/9aMNP3lE6u9TCwwC15WYKokDCLehliOL?=
 =?us-ascii?Q?oC6thtUc+NzJY9fb67ooWcAmrctZQFgD8ZsKZYfW6uzhiX/KELukHKv62UXT?=
 =?us-ascii?Q?89u93NhwBcjWcZI4zTEj/4Bs1LbF6KqYJeK03dvft6jHUSmcg1X2YZZt8Kp5?=
 =?us-ascii?Q?1Iai5tzmgCsxe3eJ/Bk4+aYozBB9t7vNGejXae3QoKhz9J/vlXP9bXXZCuZD?=
 =?us-ascii?Q?xETaSEv0NdlvE7OTBY9zginJX9GyLBRMWqZtq+aG6C3AcNdiQB82gGNUHcfL?=
 =?us-ascii?Q?Mk/oIPUYNxJwHCpaA3rY6qTIyD5BGlUPCUCdmBGGpyuc7WKcQdtb9Y/Hc3Nb?=
 =?us-ascii?Q?oL7u/u/h/7xuu/dAv5Nb4BA2878ZQEai+kAb6LSP0l3Mn/mZiYue8E585QPo?=
 =?us-ascii?Q?vmUy/91LEb7wX4uepLIiTTZJWAYFJGp9uKRXX0NLOxcWndyLwUAo0+N1f9uT?=
 =?us-ascii?Q?Qo/lv9CuhZ3Tb4nJduEg9pjafIqT804s9O2RMD6boMQM1cUdjENKjTFj5+lP?=
 =?us-ascii?Q?9kRePAq/ajGn+re/ZORKC7gB+EV+giTf8EE6S/dtdvlp67c56G2DGdBzCKS7?=
 =?us-ascii?Q?HmU+Dkg0DILaN34LgG4lgzhWy+9pNBODJhet5M831hGcs8Qge86vgu3FsGKL?=
 =?us-ascii?Q?eFNPKkg2c65cmymO78pISOCoAp7eSjvL/MvR9J0lMlckWdutgSv3dV+bjUvu?=
 =?us-ascii?Q?jXDwpXyIco/MXhg6eppxkYMhHshDr4fQIBUJVSIu5JAQmSiDBhq/WCjI1so6?=
 =?us-ascii?Q?6zCykJWqoe4Vj56yZNGVUon47BFus1UUNAR84Fyv49ToqA9CKPaHUWMPi+dL?=
 =?us-ascii?Q?eKHvwkUs+4AALD8681KALl99Ltf0PX1ZM8tmwjQ1tFvG73bI4eI31j8ArTjY?=
 =?us-ascii?Q?pR2Nj2N5++HSOktcEzTQQ+olEXNiKVV+cdLu3goQVLx3AiN/t0Bza4hgHe0j?=
 =?us-ascii?Q?WH6wAGsGqJywDOfCxAcDxLy8Jd1hjRSHd4pBU9FfUFasvE9RB+k6wlAtr7av?=
 =?us-ascii?Q?LSCxxNal/yxyJQDjSuESAZYnlHYBJujh9HU0b+hArnJcUcqqxzNavOLkN+sr?=
 =?us-ascii?Q?f74fbtqbJpsJY03x95qQpy594wKxqrtAp3XKbsiZR2mCv0IdKYCqzRfYI1VS?=
 =?us-ascii?Q?yjXK6rlSIaX0V8P9qykYH8KyAsYrj/q2N0zo2Ukf1BAygqCWQK+4ngXkR/QA?=
 =?us-ascii?Q?m9pl4DXzKOpZCC6iUaWQApgd6tOY5lh7IXVA4vTq8joV2W6LphvHwZIoLS8P?=
 =?us-ascii?Q?jI5BSnEx0DsAmguZfmjyPkQpq0itXmdWBMSrvYtshafDlT42+jWW39zoYSFq?=
 =?us-ascii?Q?aekqVu2L/kC2EJf8rYAq9c4ztaFo3gd7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ttMz2rVZE219gehItwugE6y2b8fGkBnLUTdS8IsN+IEKKcCb4jzZt9APntE?=
 =?us-ascii?Q?uWoBBMu/Kd1wLs0hWNDXcEqfkVOW1iXncOp3qjLuwmG2ukNO+0xJmJavPJ3N?=
 =?us-ascii?Q?ZTXG7M1/SOfLoeLRsZrsM9u8GNKj2qTNNlAvq/9yojtStPJsvxx1IjBMbXbn?=
 =?us-ascii?Q?GAPVVXcryEE/u7jSl+cD8CRM0WbbgeJXPBy4BhxW8E6usQj5IWqoPfJEcuAe?=
 =?us-ascii?Q?YpFcAo49qeGBlmhERf6fiqJSxePoxElsiNg5j4HFZLPXUBnPFGnQr7k4VC5g?=
 =?us-ascii?Q?fAw6QXsgRAMa9A1klxgir7A9Owa51+eeNZ6U7WuM7MGSnYCxi0NL48BAKQqT?=
 =?us-ascii?Q?fcJOxvflnGLvj5LLhQ4Zl+azEI+iO5Jg9bGlDHTxkkTfw5A441tI9DXLn0Xr?=
 =?us-ascii?Q?f7Q1pRhpw48hbUdO1THtUSOlKtAAleDS32fy7u4eAq8hGmg12iEMqtB8XpqH?=
 =?us-ascii?Q?itisfVCWrt9mJyzL1929zzbXWb9zNMLmSo2yvtzBu1ZUe6DpIPzPJLReNWKa?=
 =?us-ascii?Q?+2a1A8Ga1bN2Zbr5SEVlRQ20AUY7QelCC4mLzQjMLCmAAFV7Ea0YDlrqekh5?=
 =?us-ascii?Q?0q1+40ra2GpwFvPhjT9BA9T17XdL090FULTojVlzOqee8JRcuCxl/Uhhfuf7?=
 =?us-ascii?Q?2F7fAmbrmwDK9CtgJa6MdNESWROKcPOZioLfXIlqFQuL16TRZkRKWZcFuku4?=
 =?us-ascii?Q?u8+ElvSvRYXHlJptYQ4y0Fbo+K3Pe7LY4mg6H4Z8CdLhuN3tpqwrQjRW4jaQ?=
 =?us-ascii?Q?PxeSD9IzWIcZIv9IRo5SREr4y6DP7aok0W+TtFFXnMZB/NuhkVz7KolrBX8U?=
 =?us-ascii?Q?TSex9MOVYcthU/Zn7ex/SLzgvVG1wKV1dv20nEOxnrw447XZTGnKSRJZSCFp?=
 =?us-ascii?Q?zykGGcPJghVa4t3HfXrawNfjUaJQwQnAF5EpPje6wddS0qLwHVCiOwZ5n5wy?=
 =?us-ascii?Q?LiBAFZro0mtkWJohXKjEIAJoN5viO2pxfwa0TDDBBTKB6DFOqp/Fgmm6ZQox?=
 =?us-ascii?Q?XgrKZuNIhCMo+XWdwmCAsuyv//wCC6Ip/rSttVzgxwDM86OlnW9D5Fv+gRN7?=
 =?us-ascii?Q?0Am7+a5KFmk02Gkic3sm1ACgvQkJUlFVnoWridBVs3TVfjuGTPBrKst7c3dr?=
 =?us-ascii?Q?93UF9LcnYLIW+CXa7PCeXueg/HP/F8ELxVFKlPKq2CK+eLA/kck8ajJZA3oI?=
 =?us-ascii?Q?xedLtU8J8q9aHxSwEnPBgJJ5iMVGS9JpAVZE8OBxDKHGyhqKp3Xu7a+cSPTH?=
 =?us-ascii?Q?/FN2R9pnOFyoqvbCzqOmLNVrE3BDqv6CwN0h7AP5qkV3MVJpIggkykMu3nP0?=
 =?us-ascii?Q?4G4b+fW2jH+dc1wsFJFxa/xbELJgM6/n5MTqHEXTX4m4IOyaFvxWLAp1YqYa?=
 =?us-ascii?Q?2sWK3UwxSbl/gThn/hwT6NaqkRBYZj9LaynqbhhMpUOEIZXGILKdAR/73aX+?=
 =?us-ascii?Q?6dkhkqrLq8k5ONG/J1VLNbrUTsGloXM8b3P1Nmn0oYt0d3o0IiwzJ1UEBKJ9?=
 =?us-ascii?Q?u3ncfuhurXiGtU8id+FS9x16EEKPFCd82fNpjwSi6pERy5MDsfr9hwxfqQAb?=
 =?us-ascii?Q?pCs8T8rgjdG+T+6fgwZFw9XnVDdiuIv/OG9J3Omu7/QdZr3I/htx6KUjY1Ng?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C6I8BJn0SMRXEKqEETQs/VikK/fIy/GgBasPW4QPx6lDgJW4nnD4AepbMQfb6Llf+VrWjGLq8Nr0oTl8hCrcOjAswExBj0zEg17ASQfLkkQ9u125bCBBpNWNWJRDpIwvhsQzDcNULqCEyjw+ARQn8QbAZJBBQ0yhkjJMFsf2QazGnzIxMF6mxQGq9e5OMtJGk7uoIfeVemFVfuuoRqut/lbek6Q8ohNF3nybpRqyz9fYnKGC2HM2V+69Sas4w4cpF+8ppZitwCvjDFazqx4oX1d0FJ1ekhjKFgO/9KLHz6Gu7TBdHr44LvtZ+hfJtxK057M9LGwI5wmpoUZrwtVPVAVQydpZP5d0Hb7CDAEgpDxUjGIb0ZdNyqeiV5/RJr56kIh50dDksb8UTcUY6ob0Nma2vf6nWdG1SNOM0WefqOehyWNntMQMeHL0BwJ8LepihA4BS3lCdoRojVkK4mOIj5UkmzyysDtgr3e0OWmbYELPHL1WE7Dz56rJsOEDvpVUN4EvFPwu8OPu2g2CJ0P6sF98Uq5h2f9GMFDDCDGgT4F0AxJnY/wBOmVA+WYF59Z4CLf33P4U8uvX/vKzzkS2m9dOPlcrQBLbZ1a451ltz1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5416f6a7-f305-42c6-aee4-08de23816e27
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 13:26:33.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75TBqUmAlLedJJWFNCjDfGjhf5hEoUFcm7Yr1KzwLnH76a5e24aNvifiopJ4xVCDgOSi5YMkKHinkeDwg+h75LaEQejhyTEvNhQdnwWKtxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511140107
X-Authority-Analysis: v=2.4 cv=YP6SCBGx c=1 sm=1 tr=0 ts=69172e11 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=IW01juKAgdGzpw-y0VQA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: q0drY204amb4pgCA3VeLW0WDOoRuzPi4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX1ALloA0ElOXy
 UaHDw5grc7+rT6cZR5lZBSB0tBjtWu10jWM50p2a/n3TtSgPBpEDa8kEaCPxYvSg4e3BZ7Qrzpu
 OfMkgluD2Oek4m3MkFsK1v2pcl40emYwkdySaSNLDe2F8pyHLY8pS7vuWTOAnqA3m6SUqeGQQ5T
 N3EgJEwyraqkmM5zgHvUDUVafz+CTmysoIM4aJa2MjOYRdKVfYwoNn7QA8f0bGoKaGkGt8b9lud
 UzCT9d4vGUvcWYAmbzrwt4DpwTWOnV3tgQeMH3afTvNs8Rm0wk32LksivZ0QqGzBFv/CZJQt4RM
 YRRlKVdD2CfmqFMcpxMG7WUaSvwL+X4FUWVu/PfBjo19nkthSXSFvoPlnmd6cMZtFaMpcgyn9xA
 Wq3VwsfsnuDZMXG+wccw/OcI6ZPd7Q==
X-Proofpoint-GUID: q0drY204amb4pgCA3VeLW0WDOoRuzPi4

The __mm_flags_set_word() function is slightly ambiguous - we use 'set' to
refer to setting individual bits (such as in mm_flags_set()) but here we
use it to refer to overwriting the value altogether.

Rename it to __mm_flags_overwrite_word() to eliminate this ambiguity.

We additionally simplify the functions, eliminating unnecessary
bitmap_xxx() operations (the compiler would have optimised these out but
it's worth being as clear as we can be here).

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_types.h | 14 +++++---------
 kernel/fork.c            |  4 ++--
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4f66a3206a63..3550672e0f9e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1314,15 +1314,13 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };
 
-/* Set the first system word of mm flags, non-atomically. */
-static inline void __mm_flags_set_word(struct mm_struct *mm, unsigned long value)
+/* Copy value to the first system word of mm flags, non-atomically. */
+static inline void __mm_flags_overwrite_word(struct mm_struct *mm, unsigned long value)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(&mm->flags, __mm_flags);
-
-	bitmap_copy(bitmap, &value, BITS_PER_LONG);
+	*ACCESS_PRIVATE(&mm->flags, __mm_flags) = value;
 }
 
-/* Obtain a read-only view of the bitmap. */
+/* Obtain a read-only view of the mm flags bitmap. */
 static inline const unsigned long *__mm_flags_get_bitmap(const struct mm_struct *mm)
 {
 	return (const unsigned long *)ACCESS_PRIVATE(&mm->flags, __mm_flags);
@@ -1331,9 +1329,7 @@ static inline const unsigned long *__mm_flags_get_bitmap(const struct mm_struct
 /* Read the first system word of mm flags, non-atomically. */
 static inline unsigned long __mm_flags_get_word(const struct mm_struct *mm)
 {
-	const unsigned long *bitmap = __mm_flags_get_bitmap(mm);
-
-	return bitmap_read(bitmap, 0, BITS_PER_LONG);
+	return *__mm_flags_get_bitmap(mm);
 }
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index dd0bb5fe4305..5e3309a2332c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1061,10 +1061,10 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (current->mm) {
 		unsigned long flags = __mm_flags_get_word(current->mm);
 
-		__mm_flags_set_word(mm, mmf_init_legacy_flags(flags));
+		__mm_flags_overwrite_word(mm, mmf_init_legacy_flags(flags));
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
 	} else {
-		__mm_flags_set_word(mm, default_dump_filter);
+		__mm_flags_overwrite_word(mm, default_dump_filter);
 		mm->def_flags = 0;
 	}
 
-- 
2.51.0


