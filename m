Return-Path: <linux-fsdevel+bounces-52234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F416AE05CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 14:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1951B1BC551A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C7B23E34C;
	Thu, 19 Jun 2025 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XO43vF+G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NfBpI/Ko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A823B60C;
	Thu, 19 Jun 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750336067; cv=fail; b=Vd+XkI+lmiWdbEsAZ12wx9lIZ4prcosVHlzkN7489hjf9Pjr8/ioKQzNCLlEYiwLW3WUUmc41PjtOUrD0SSNqAq7LWnmHS5IUaceVJuZsZ3YkxrABASKoG4VrlYbwvwnd1BMf4OKH1Rf/3ALk2MBVRvYaHyw6K9j3QyhvhyBi/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750336067; c=relaxed/simple;
	bh=1k5J6/3qG9alvhQldZfyc9e2HbUhJYIzXA1zMlPVWQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MtDBat7j2qgYM+KvlKViuEzq5DtKpICwS5D0jZHAV/skH+l4P3NiPCNqt1Xe9sxZ2BtVd7b/BdDcShyDDBGak570ud233KpaQ0m6TC0t1RWZm4vvSRdrW2vIzrESPO5FymqErqiSnRd4tc3UX2UWs1Oxbf6Pt8B2DfpUoM6l5wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XO43vF+G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NfBpI/Ko; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J0gHhQ031929;
	Thu, 19 Jun 2025 12:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HaF/f9XoUpXlvXZhKI
	WyaLYcygannOmBqUtqOhrRhOY=; b=XO43vF+Go3uMMVdyajEutmubopIfg9UfSO
	rn/T+XMGY8yOgr9aqTrg9p1V+RglUIB0ZjoDynLpbCIsWhMBQf3WiMkUqb4y0T4+
	aYYWaK4llP/1aCUEe3r9VhUdC5wLq+WXgyWj0CReLXEyiPjUDm7iXSh5EKNz09CT
	nDOZfREOgP0vUHlKitlkZFiKBoLJxnlLJ83VYKUHWvdtGgJUID1+HiuBlGgPAOp5
	Gx39pxBtJ6BtF3iY3Nz/RkTE67OnSdGwb85sVmVJ/iT6n0cgGBvUKgm+jbVdtG7e
	gVjLKjMyQ2gdH//sOM4oIqgT3YLPHmU/mO0PVg4F4wJ5Yx4E12sQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900f1v0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 12:26:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55JB1HFc009836;
	Thu, 19 Jun 2025 12:26:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhjbxsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 12:26:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rB6q06LmOxtk/JCXn8uZQLlOUW+v1LozmOkMucoLFipXmi1eKxvg/vrcP0q9wMFJtdx0SJo1qfIy7zgArcLp3vjjuN54Wt9VvzHvzscpSRawqKzfzoIvK113kUJ48UV6PBtRhKti6t/dr7x3VLxtl7fiTks9Q11rJ4rjgctGwpYnpnGSy4IfPWkqAU67pthwcnjwY8woOUGKbhR5+RHNF/PBfUd5vkLSPFIWLW43XN+jugI1z3492PScFwEKJqNp8sBim+J7UlNMabPzTON1tZY6b0fOy8kQ4wlHfACEBCztE4DQLZVDtosFSN7wb7hLEX7Tq/DLrYO28LSQlsiRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaF/f9XoUpXlvXZhKIWyaLYcygannOmBqUtqOhrRhOY=;
 b=XCuOX2tWEBCiggk46yvoZmryiTD7uc3ibQeZNpU8cCiQoQDVyckisge1ukehVvb5XW666COuwBAMZGzNF+x67VXwU3oSzLRvVBattV33V4KwJqd2bdv5A1Z0XCvSVksG4FIk2QDqOzM2Tc8KZTfU/3opl+NUCe/N34XvGhdMha22ttVt1vPV3G1WVtatZVTRqXJJT5xsDFPKmG5EGJFtL++Mc4w9vkHs62oU6AX6sQXvISfqKIstfZtCqDfwOnJ0K+CfYF5uX0ZinvEcpg3rfRDSuyHyzkQQDK2bPCwxKy+BphrqxetgEREYgUt3RzdGst1qW/5aLBtr+eM9yAnjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaF/f9XoUpXlvXZhKIWyaLYcygannOmBqUtqOhrRhOY=;
 b=NfBpI/KoUHR7H1dEbNrmnMqetSSltq5Mx6lxL9AF5JtPAYo4beiXLKcASop2UjWDf1d6EPG9qm1e5FlAhyUdp/Ar4jrRvCE6U0YgAnW9+zO9sFVaYWd3p79rXsnAbgTF27VOEPcR0HDII/y3+7bNjlnSxjlaN2t+eIZoXeQIXTg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF5F7E4AFD5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Thu, 19 Jun
 2025 12:26:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 12:26:02 +0000
Date: Thu, 19 Jun 2025 13:25:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: change vm_get_page_prot() to accept vm_flags_t
 argument
Message-ID: <552f88e1-2df8-4e95-92b8-812f7c8db829@lucifer.local>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO3P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF5F7E4AFD5:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc3feab-a870-440c-d88e-08ddaf2c7459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p/h2GEMNbRZZchcHRJuFNA7wlfLGGQyKcBPriU/MSwjpCkgDahRIMz9GwqaQ?=
 =?us-ascii?Q?g+kCM47D1xuskO1EiXzTo15rvOro+hmxXLdglTeh6KrZHEk4a7DCcc1xAN9K?=
 =?us-ascii?Q?p4wGRPhptcGFzEHm3IsxParT6fOSxV0aBn2cMCYUJx3Nrky70KUAK86NdjCt?=
 =?us-ascii?Q?Ckzbws6vLfMj1E7VppeVve3OnfW1mAhREPrkrO11mFdM38yNIzI31WiCl140?=
 =?us-ascii?Q?o+HlMSG3f6wlZI+4ZKuTDlsozszjghonjtkPlAktvkwbdapGJVQPEx3b+19D?=
 =?us-ascii?Q?ngIotKHnQ/ELfJXqCccx0J1glaxo2beGfPTyQZQX1nT2Ld9CkFyscc31D/mL?=
 =?us-ascii?Q?1jx0V/S5zOtZJMbq9LwcLAqwQC6WjIr4oLEkMjsKifRUsIsjUlmeKRPJFAar?=
 =?us-ascii?Q?GQZg5QvWmcNYDqlqAN5Y97+kO9FRVeGo23ihxsivP8fHGz16dWJP7fYAaZAP?=
 =?us-ascii?Q?BL/NcN4Y4adhhqreDCng0CJi4XffaEoO0Z2D3dmwddPw3NVrtMf1ZKC0IJlt?=
 =?us-ascii?Q?+cDsAYpRoYPM9maAsGXUNhyxQ/MwXIZbD3k6uQ963ZIUKIPT+cngr4RnoSkJ?=
 =?us-ascii?Q?ID3xLvvvzBwE8WyYL1xEEJnfAcfFrCUGpUcmvfB+ZYOTMyyeDIZFi/dTpTLx?=
 =?us-ascii?Q?AZKAocdwToa2UEf4zrKcF72oX88UaWmvHFN71en3CbQeCeD304fnrMzPPjo+?=
 =?us-ascii?Q?MBb/xufh1SPXeIc5OmKq/TyyWxxAgWXb4Jcx//rSwnSyWSajHaxpqLCqMEHp?=
 =?us-ascii?Q?Goq8x7T99YG4Chq1umNsURzU1EP8rmNsh7moam2cMXC/ZZTcFh08vzFuTEkZ?=
 =?us-ascii?Q?+f6WpkXzqJSYGBFr17ZOJAZnLXTBIwSBYJYxUQfktdJeq7x/L/uMIaI3d0ep?=
 =?us-ascii?Q?8HS/zvt3WOxqn0o6ILUZ9AZ73r3Bzx+7L9bZII39oFCtx1TTGIP9CIXPSb8B?=
 =?us-ascii?Q?683zOVA/eqFaNx/v7wcpe2x2IcSm9CY4wOQMyOJQmCx8lHeUX0lqTZ/2hVXz?=
 =?us-ascii?Q?3qT5uKY6+A8hkntBiwt3DXawubMblxO3F0rwVOy7wTJFh+vo5JjjSFA/rytZ?=
 =?us-ascii?Q?nYoX1iG1lfKBxNmgT7SkSM0zlZt4Wx3GOGozXzj79EeE5tcadYu26huEXixW?=
 =?us-ascii?Q?yLDn9BMrXb0P4ZZpvwTzP0L3hXFtxpzTHb1u/owdGBYF4BOBzDDjy84EOR77?=
 =?us-ascii?Q?pbmcV/zYSswU/g93ozZuSXCQZ++90sllOt7y1tHdBnllwcT4KYBQ+CKOAcQU?=
 =?us-ascii?Q?+AzYr3pA4ntzYmcXDrpyrRNRj+0Sr3Xo93jL4NuadDGwJlm1MPA65MCyuDJA?=
 =?us-ascii?Q?U75sp4/P11Yz3HHpO9szRMMko3XBfAGi69EilTO6mR/Ym3GpLchdtRQFVu1f?=
 =?us-ascii?Q?JJLc9G3eAWkvTjCOgmH4axiwb+p7zVjA/3TNAgETpf0AEPXKuSum56CumvHl?=
 =?us-ascii?Q?RORR+Mlhxc4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fnPUXLX+KPlRFuHvrjY51WfL6G+WeASl0zOOyceTSfBKRf6gxcL98zHjTMdv?=
 =?us-ascii?Q?YVFA/pd9iNYLjR6NnQtm4KedAkYFSymGBmskDV9By6Wp0xPDyS1CT7gKisHM?=
 =?us-ascii?Q?Si+EF3m1Qh1ZsYBiHWF57RaXeTVqU/nXVl4R6KHhF3lMYWWRSoTkGnirIzZY?=
 =?us-ascii?Q?UCt2yq4/U3VORu2cKZBLJv2cQQzoB6PXg6TK+W41w5S81bdtFdKWAiDgsWQ3?=
 =?us-ascii?Q?yCyh8Yle8++UbRsW7weMwfylmfmz41vR1p3UIcQml3fxE3NFssTK1uYledU1?=
 =?us-ascii?Q?FqwbHa93POV3SMhjgfHZ4DictzmGMWV90DmnwbKw+x8xUwvGEYbFJ4r+Jtzg?=
 =?us-ascii?Q?fq/DN6zbqGicIpoG8Qm1vZAHQtagdtw+qijui654aha9sZYL4aY7lskTQnZG?=
 =?us-ascii?Q?CLAwqmhFeUtiUqfwOx3Zz8EVcevX141tbEVbQA/a73nz4PCoqeMLLRhtwQGM?=
 =?us-ascii?Q?emdGuPskjeQNy1Zycm/xz/kWryS62fJJvLo2dV2wvoCel+GKKDphY7yY+38O?=
 =?us-ascii?Q?iClwsE9J4CBVBi2WDHQ2PNsQgq0+Zt42x3hxSlEh/t7QmZyz9iw/OIovxMAx?=
 =?us-ascii?Q?1ba6gLogYpGvKN/0njgN3oaN5SCR+DqFnmOO7QLrQB9wZRCBRBFeuOQBWlkk?=
 =?us-ascii?Q?45QABwjtQSofdv2GSCyPMSfaOk8Vm+GoRyKsEMi3ARLClD8A6zlFYVlfN11q?=
 =?us-ascii?Q?SIPpzw0kCvcGIyEfVTRAx8RGN8NZbii8IQLAU+Ty3SNTpVEzFlu8Kla2lpnI?=
 =?us-ascii?Q?HIKEvAAmJ8cAmsyjUVwXTsksBNlkf9951b9nVFn+vaqR7nD9UQO8bouJau8j?=
 =?us-ascii?Q?+zQuV6omYGRnCHR/fXezon4hwyds2Y/qwoSSC0xtYD5h4D1qbgtNAf9eD85Q?=
 =?us-ascii?Q?wPV+lVxRIShxO2SRirdpbJ+6c9qcB+JOiBVRf121bFH+tHBXpbnztpzDQoXI?=
 =?us-ascii?Q?y7sS3VsWPjelTh1RRebuKvQxjbEqd4IZWI4CPaYE5c+KW5MuxXhWqX21Oujl?=
 =?us-ascii?Q?SyMIU8bCFmNK8fnExmYBYKgf6HtQubO/l0lQnNbR3KiTrbwA3w/rZfaxqHlH?=
 =?us-ascii?Q?0QOck8cGDrWljm0Db5tECD+uakfD+3dXGRvNhBjhyyq+CCp9A2BXGtJponyf?=
 =?us-ascii?Q?xnoumVud/hyKOeZv/GilZMqrF+pmA41FKzV9Kvc+eKbUakGcD5UV83+K40z0?=
 =?us-ascii?Q?zNaaEhjHdJJacknD4cWwh6HPJKO9ZkWWrmCnx8op3UduYL+maylbTPejp0xq?=
 =?us-ascii?Q?yiBB2fScxPZoe+rSS9k/7SPvSmPR9YaxKUzSwqvLdgKQH+q7pB/ng4S9dI1c?=
 =?us-ascii?Q?vSGeOpwaDdubB6WnX1NFb58OQeNgntSVdqRj/16Iw7DBV7IhpyK9+3QZ6AXc?=
 =?us-ascii?Q?QnIGq406Vdbf9u1mLzDUhl9+Td/t/o6FUh4npTNOtvLcRPZ+7whllcJtuObm?=
 =?us-ascii?Q?LKfeRETrJERo0jmect4MxT3XXYEqDRZfr5r34uXT+UWTT/GVhyRT0yJAAoK0?=
 =?us-ascii?Q?t7WziRXafbUiEzkoelWdqvmaeuihI1q9uY+IQ0VC0tI7CVASswEW5gHVPJp6?=
 =?us-ascii?Q?G8PH7aUPeiXynkTIYsRWlILXK1dJIZbHIrJrWHddcVpj55s/lWBotegu2lZa?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pNI4p6mtqHRC61IBLNmdeFHxAmIHoJiQvv7DoI3gaRA2XOIylNYIi0+hAS3iQcdX0ZOvxgvCirB4T+N2ABLz854RBS/t8AgWcYGfe9Bkp7aMMCC9GnQfVD9WZguo9aFunOMby4Qw5DLc56XKHFz7iQdgfGkCwkQpT3npy5uo5WRsDhXXgfHM9LcnbvGHYjm+09HKEOtgjhQy41cStGj7JiMGFFp51nCXvQ0+XsuxX2ierHBUzVyf6Bp3GUFu97NC6cImtOyrcrWS21UiuGD1TC8LBc7+/7E/XtQY5umjhayyODxDBRmQp7Pnf1lD23mG+TAgX+jI+iOjN7QWM4RGudSOVp1rfnaVoAc8TZuAlxcSPcmeio/Gbrkc97RzYj1xVXJns52hCwmnGAqyhebWAvANI0FsJIb9UCy6kef0bUL/DDgdeT31McxIpie7unLQ1CqOuNu0I9K1kMZdXp8CyfH4ArhTb5h24qORz1T/6ZcHSI1JhhCVokOU1NT++49xZV5MIgu9GhC/wVQUjH+s7Cs+xx+ndQov4TkRe+9dbpylEQHcQllbzs3sE0enGzOQMTs3f1kTu/YPa3CsJkX3UKnSWR2DRjEHJgSbz0YJWKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc3feab-a870-440c-d88e-08ddaf2c7459
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 12:26:02.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uluBsfI/Ie5+bfp0xtd22pvUxCTrKuOgyi2GfoQQK0NFUkWp0ZYEFyNQM9BlegcYk5z0zEWyhcJpC0FoMFcjrqdAx/kZqYWr9CM6JkWjOMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF5F7E4AFD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_04,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506190103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEwMyBTYWx0ZWRfX5npQ5uM/za/y dzh+24CAiGVqr77lZPtsS8q12/BFrRKuX6ahvFV3KsiKYbRucyst5c1aULMd3RrnLN6lIZSvB1/ SZNk1qEIpHcDvh/nzhTbkYJTlB9F5hDMApcNTqvR6YAiyfo6QSsr6TMQmIePpYtAVnTLb4aMqJs
 YH8typw1mXK7vGsNRU9M3uehVQp8dKyUJ1xtfp8IUhfVLx9leiF5CLIiU2fZQFWu92Ue1nEAGhE J6PQQ6jx0DGJ3qof8mNX9YySEiuz8Op/RW5c2qtYjQWC1ibGurdOnt7GpfY7tImU2cz7rgb/H36 ONSDspK4E/ngQDyGBLF1BU+s4DbEo3BixnMR2fYEz6LdzI5p/CLOYkipWT5AiLTp9F2wfSvZDtw
 0GYW7DEDgVzTKfaYZ67NsusYBoi3NUU9ZsUe5binKqY/UrFO94aNXPQXuhX2/T94MkRf0jJQ
X-Proofpoint-ORIG-GUID: TzSSvx7L0nxbBDvFqrDn26gB0so9QgaV
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=685401df b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ZboOWojKNFcjWZ1uWMIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: TzSSvx7L0nxbBDvFqrDn26gB0so9QgaV

Hi Andrew,

I enclose a quick fix-patch to address a case I missed and to avoid any risk of
circular dependency in a header include.

Thanks to Vlastimil and Oscar for spotting this! :)

Cheers, Lorenzo

----8<----
From d66fe0b934098ccc2ba45f739277fffe86c91442 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Thu, 19 Jun 2025 13:21:15 +0100
Subject: [PATCH] mm: add missing vm_get_page_prot() instance, remove include

I missed a case for powerpc, also remove #include (that is not in practice
necessary) to avoid any risk of circular dependency.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/powerpc/include/asm/book3s/64/pkeys.h | 1 -
 arch/powerpc/mm/book3s64/pgtable.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pkeys.h b/arch/powerpc/include/asm/book3s/64/pkeys.h
index 6f2075636591..ff911b4251d9 100644
--- a/arch/powerpc/include/asm/book3s/64/pkeys.h
+++ b/arch/powerpc/include/asm/book3s/64/pkeys.h
@@ -4,7 +4,6 @@
 #define _ASM_POWERPC_BOOK3S_64_PKEYS_H

 #include <asm/book3s/64/hash-pkey.h>
-#include <linux/mm_types.h>

 static inline u64 vmflag_to_pte_pkey_bits(vm_flags_t vm_flags)
 {
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index b38cd0b6af13..c9431ae7f78a 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -642,7 +642,7 @@ unsigned long memremap_compat_align(void)
 EXPORT_SYMBOL_GPL(memremap_compat_align);
 #endif

-pgprot_t vm_get_page_prot(unsigned long vm_flags)
+pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
 {
 	unsigned long prot;

--
2.49.0

