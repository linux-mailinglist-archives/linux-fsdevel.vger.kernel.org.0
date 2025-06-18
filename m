Return-Path: <linux-fsdevel+bounces-52111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B468CADF720
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE4C1BC2AFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1F1C84A2;
	Wed, 18 Jun 2025 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ox21sP0O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TS+8Tp/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE1219301;
	Wed, 18 Jun 2025 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275974; cv=fail; b=evDVszJH4jBI00Af5ye7lbQuYCYSPNa8yX/snGezMjJinUYA3TbdJtTfj3urF+9nGAUM7hOtlt9zn2xan2eNgCH6nmbLTe3tHr9V+BYe9JgCogTlZBXQyVDttoddisla91oUihkz0GAhVG6XGY8CJbIm7Vwt6l2rNyJ2bGmvfYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275974; c=relaxed/simple;
	bh=Yd/0aK1k3OhJKh0xBFhoYbbmAEkBN82ZmVPhuRZdV2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jQjFuXVJQYNLV9volejn+tgsfaMRQgw3DEkXwZVTHQj+JHFruKWi4R16lGBw+4fls0HU8Z41nBbTALaXcv9unLwBGhZ5jOMNfhNhl0Z2c4otkARajN9FQGtRIXyecT3PdNCrOqYnYavTy28uwNBVKgPVok+fmTQknWVhuaQYm0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ox21sP0O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TS+8Tp/R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IHfc4Y003149;
	Wed, 18 Jun 2025 19:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=On0QOp6TGe3sv9uOeSzyuzryVxrjpvTmLUF9fwQpwC8=; b=
	ox21sP0Ok9yaTA0aND2G/8wF9JNCNi6NsgzgdoTxWkCaHKNws9beISJTbqSGwEW4
	E3wpw7+InD9PLpfYWGqAUzL100IVXe9yz+kt6ABhE3WRErxcUGnLnJoSzLQFBslX
	jewaHnTMjxSF7zp5P16q+VY92BXlSw/0Lh898aUxePOAXGr4HHce0ophL1ph+uKI
	aohLxVU1Tqm7tmdV+B6/JY6JBjC2GM80FATlSw+Wfr3eBtAAFLSIBqa1nOTV4Ytb
	kvhACuZsyp5FHrFxrLOblU5CfH5ixSqZTm0+hwOjwnLk77Wu7VIeCan+rpxFKMDS
	zgjygVtEHWHw7pL+3NSmpQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47b23xv3k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 19:43:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55IIbnN8035067;
	Wed, 18 Jun 2025 19:43:27 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012065.outbound.protection.outlook.com [40.107.200.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhau6sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 19:43:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgX8UvZiFYkt1zFPZpcYnpSHb8Lm0Iqb7pWkvi8LQ4cQdYjVH2433hXgZfKod3dTdodpUg+mFSmtPDBy6PzdZkjfepWw29EGoAesbpg/iJU+HUWa60/zGra9DrspJpSI8ZigVmOXHcelDBjRfpRf5S3zswO2TAZRQqKp+2cPVDKBXfIcGfPb66MaarxyHRkAl9FAH+pDggdJlGIAWKOwyTBKgL1Q+BLz/JAMe1wkKGLHrv6TbpalZrSgjJiIv0VrCptoD2wH9NqK7P4N2uL4lx+5b9B2NXu9DS5rA+hZUTzgWhZ9erd/eLiE3rUD1wKASE8cqP5cqUNi7tuRjSyB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On0QOp6TGe3sv9uOeSzyuzryVxrjpvTmLUF9fwQpwC8=;
 b=tlzvzXuFYMNHqXdmG8DdqB0EVbd5GieWlId0DeLB9h5auz/WGJw0/EFrq4a7h5FcdY6VhuW4bc4CTkvQbiHscE45g3OG59FaG3cwoC7B/LC709QFhunu1bfdnK4h5DY9hErfiBTILuDp5yXIqVJT1XpEpX5NlGgBoCydeAzYjeL5ggwWXNeeelP4rDRpG+ap0Lr8KYmTjolDP55q4LspQpAAAje6cF4aLvhEGU2Ol6OucFW6pbFlVC72plbR+YWtOGkADImigPcnM99MTxe/AszaRKgiOlMvhNmf7xLlxcuwECta1mHu/oZJxpQn1sdxyp2KljBzNCzKonyWkvnRag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On0QOp6TGe3sv9uOeSzyuzryVxrjpvTmLUF9fwQpwC8=;
 b=TS+8Tp/RLdsUiJAm63qjMMHj3TsXOZs5HRTZ3a+Brg4l2BOCgjkUnci/CLayXl8mFhDlI3VVNCCiHjUkh8JlXrs5Dvq22WRefNsLf3DKPs6Yh96Bw8Bc3BBirjuY02FSHDU4U8rvrA+NFWx8ybxC9VDMcKb6xG1zyB7LYxo6AwY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6717.namprd10.prod.outlook.com (2603:10b6:8:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 19:43:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 19:43:19 +0000
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
Subject: [PATCH 2/3] mm: update core kernel code to use vm_flags_t consistently
Date: Wed, 18 Jun 2025 20:42:53 +0100
Message-ID: <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0659.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ba9b7e-628b-4c46-32f1-08ddaea06097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o0Dy4rrsJ377Hq/llMck+illG8CSudk8yR5L5gA8ga9vquMw46pYjIX5MVPd?=
 =?us-ascii?Q?UM+y19j6RmjxqhOCUKEOXZCeLd1uabz/1GwoDoiCaoklCzIOav5+aVwILeqA?=
 =?us-ascii?Q?bzxPEF3VUvMrHsp2XQR2+nO8R1FPcFmX8tiMcTGBhyjuALmCuKgtrsF4lNnh?=
 =?us-ascii?Q?GRgTXgLBWCOwz5+99x7eC+ffFMU1cc1ZlhcFXpLNVSNtZropkSaqeJ/z4+Z2?=
 =?us-ascii?Q?yzwQ+rjfHpGib7e4zZun8o3ljx4GToAPaTs7fYyuWsnAkroY18JxRFMWeTnv?=
 =?us-ascii?Q?fRq4U+q9spBh3zJf/kLecLWXrRgwgOphOzdZqK+DkOdt8z45RaqE7UokMk3k?=
 =?us-ascii?Q?Q4OuWT6xjQ8oaiB2bu7QULjJgwhqB5SscEdDDMU0aTOviUvIvGVt1qVFOFaR?=
 =?us-ascii?Q?53vHAGywcQXpDeTAnD9hhL+auF842VTpAh/v1YgVY8CGrBr5aycUL4aJhD7d?=
 =?us-ascii?Q?b8tT37hZYngspwDRD6/U+r6R0i+vJM76yW7mZya6c7nVol9UnH6ySFC3Vji0?=
 =?us-ascii?Q?s2O44/gDrV0mq00bfr02gURD10xUQxKkI1puxfzBzTu3D9wS0/Mf0uvg5WHv?=
 =?us-ascii?Q?G8djolCa25RL69I9qXSFDu+Goqin9T0SV+bgDPDNMBYjUVwxOTwaULz/vlun?=
 =?us-ascii?Q?4zVkKH691VbZk4RYcxZkxWRgHwwc+OUkrKpsVAQcy0a4JvrgS5PUTwjImKo+?=
 =?us-ascii?Q?fArwaUO4Ok2HmG2HqvXqETfiZMO0c4LgJivoRQu3uiGdq9muZhI1gwFWCCSG?=
 =?us-ascii?Q?HskU6xS/fCxYt7JNWDTUcET7wDOrSYVmeCOhpWq/elHRt3GoE0R1iM6Im4kx?=
 =?us-ascii?Q?pAd7veFfAA5dY1BklUx+fQQO7HLKluUP2JiE66ZJdLZWvlQjK1Hu7fnuMTg+?=
 =?us-ascii?Q?6ExBzOWqo9u6vxWzrQSLNi3TNkyfxgkCycPW1vb3NvjnJ2+9E98w9o7PUhTS?=
 =?us-ascii?Q?soYk9UkvPePLGtDYUvageVNybIbrxOSn6gqzvG6OXRDsxJwY7LfH/cJM5ooL?=
 =?us-ascii?Q?KrBi4NdRwYAxfaC90EgkCEHFzu9u37YM/kgbedrv5H46XJYu7hYzY+A4FTwu?=
 =?us-ascii?Q?0u6gV6umNJ8nkQtFZkoychYViDV06kdZo+YAmvh/7LCw6gW1oGY6ADICQUZr?=
 =?us-ascii?Q?BJQSFqgQZhwwYCrnps2bmSyiXyJKt8YQMmkQO+6fvFXo3YWGXsi/Zk9sga0S?=
 =?us-ascii?Q?wONQrc6TUWinz7sQjXDe28K289vu3WXve7fHfIzqfUHh9ng3k5vSAHVgmU2a?=
 =?us-ascii?Q?pUiljh/CpnTuFxNJYg9gAXPoE3k+LSN9wzLWPAiSu4GkFGIsRmxDvAR1/dTb?=
 =?us-ascii?Q?o2QaKBSdOPEg1zu06iRx387ANFgDpIxAjsm/xW4dj6DOBLchk98kYNrrL/AS?=
 =?us-ascii?Q?HJasxbVqOXxtfMCQ1ioeB9EhmfCYGUwI4JxTaP946erDQ9ucqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55ViH6wOvpVjufB+QBU0+ThMrWyLThe4jg2hoOP9FlrXWUL7oPYl0B/WgHbV?=
 =?us-ascii?Q?m3gISpxG4pjm8LnDeIRECRz1mjSlCjJEDRdHrWEsZkMuTr2eVq4cMpTCRrzR?=
 =?us-ascii?Q?jRPhOU+Mj7lCckzPL1BVkzzxBGJPEb3ekPBvfhKDP4/yaB5rnjFNCg49B0MB?=
 =?us-ascii?Q?zKSy+PlnzHtEmuu3YOz/H6vpqz1pRH4+CG1xny7qBgyu/cEOlEcDBFchoV+z?=
 =?us-ascii?Q?rMrlDJ9gt3ZxLH5q2Gvo8FK3nZDnPgJRSzCwww4Zqg3Wp56LIhQBlb2F9TVi?=
 =?us-ascii?Q?ATViqQqAwSTI37cV8RUq9NXK4ckMjWu6prccWKH/C+0nt6Go+VK7UIFvz1KQ?=
 =?us-ascii?Q?lWr1iTJEuLY0Z2AcLfiMlMzBbfnxwaAecEcK/Q48pVyeAQUtdtr6N3RZy29o?=
 =?us-ascii?Q?kdtf1JXYwnHKaCVq6Q93Tr8MM30bM5AubMwn8zkOGFEJSKiCMTCQVD9m0G3t?=
 =?us-ascii?Q?aIK9/2pt+Gu2N6fThc7yk8LykLuaaHrCAVhPDZmq1co0hBJd4tbgtkjuo10j?=
 =?us-ascii?Q?KQ80+FkZtJlH0+EQKqn7V6upAqP10bQtgh4nRjfA9BcjqNcDvKyuZamkSLUk?=
 =?us-ascii?Q?1/o9SeWcL+vgNw4F+PZKccNTF9Iadp6YsoBKwF1JYIh/1R9ZbZZjO1FYrjJL?=
 =?us-ascii?Q?mP2z/DDRYR+YEsXZL2o7q9qOcJCS7SM0i912Z16fZnc2U1YlfWzDm8kEAu6v?=
 =?us-ascii?Q?JDhzK+ofOio+/bTmM2TLY6YC8DkxpPX+SRO9Hdzc1bcxOOoW1dwImxWMu7td?=
 =?us-ascii?Q?ENs9dGH0BwX1yP823rs28GWuDvPFoqpy3kQ990CqUXR2gBK6jtAQp9lWwhnf?=
 =?us-ascii?Q?zDSevlbILnQu4wy9YBvcfZLOHWMJXJpX4rHAiAO15bMuHpiVq2JNVj3QJK8b?=
 =?us-ascii?Q?NeLEy16eca/F4alQ7Bl0KgXwu/x8ocGHvIxwmzxQIWdJqNJJi5qsSlGJIW1o?=
 =?us-ascii?Q?tnAIbL9sIgnN502feSLryBhb7ZbMt/E+a0fmOlISn98WJ6vJuJQ/ZJHe9+OV?=
 =?us-ascii?Q?FpycVkM0OV4ucqfYxSL3vYHOK3SxDJaIhAakpQDOTdbGv9Hu9QsTKUHWzUUH?=
 =?us-ascii?Q?TubCvYOuKjAkknGuB6JVQ9SWMnxyu8mKclUtNF2l8HxKszWl/o/x2JmyixJG?=
 =?us-ascii?Q?L4sLcEpI5J1UNYk9Cn5HQPi1kT5n+ZCGtbRDBhSXDYwsk18SJxwCmI1pDfFT?=
 =?us-ascii?Q?dQQqWw6anLSa55MJoViNnEiROMU86mur35jrENtMOBp3qz3b1kogh0N1zawy?=
 =?us-ascii?Q?o4ammhdpR5DtngGNQ9p7uiYAncRUQC/mDho1xxuVPPs1rIYePSrJspJKzVQH?=
 =?us-ascii?Q?+lOeE8iyY29ix7wXCt5dF2rbn0SHpE2aySOFyFnp12M6PLvvp+GgLn0cY/Y3?=
 =?us-ascii?Q?lfsfVuKKxmCvSvuKntJBWdxT7bH0t+xqEiF3no2gaVy/JPoT1ASx9T/xoGFj?=
 =?us-ascii?Q?NsYfDu4ZmLLZviaAuwOwjkLci0EGFREz2ksVfjUNFJiWgmy/7dfze0iqgi2X?=
 =?us-ascii?Q?G/ZFBs5YBNyBSKYjlnN9w8p3dXbaGsYpdYX1+/pFHmIXRFQQtUpjiQ0Fzuis?=
 =?us-ascii?Q?Z9pdhSbpBO2SRqYlhIXYZ55+ihyDYJRRwpx5qzk+6BdDh2fvcgeSwouks9+5?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1MaUNTugCYaXT9l3k26cq0qBo3D8/E4Ki+shfBQiFxCQWLxnLjRERQAA7M8Gu32TW8cSmnNu5hbyzIkLFrQP4F8CcDTcAnSvNV7+HqZ2ssQrJDaF7pQrGf3p93q5DwhMPu0n9OGM28c7vl61HFtY1lgvRbFGqeq3kv0mTJB/BJIwXeqcYBHglj8NZgcka6kKBpp8XYvURySTTBT7MifzqBASrQ6sBc7M+XvaizevfAyuZeiVYGTXCR2v2PvjtOlVHMqTBpZ1bMnSGJpnhaSlCZSXV0aHUBzVcWioxwy44F+V2GQ/VJGfuDYK7MiisXuhy6TmmkmI9zN7S5oroov2p4JFcLScIl5UaNRkGQOeVHDMBJE3TvHVa0q4v8sLnpGDqF5FBAVf6iaBWpy2o7U1SLcpJbjfa8vTBebjO+SwhhHCWPJl7NL4rkITZDWO7vVQ9mGY6xMJauEdnTaxb/tRVcSoQDWRviNfZWzjrtT2AfTPom66QQWThoCJHp81OrfHJhf2phFB4qUZgh3vp4rkZ+LgBUt9NpC4yb5DKfQsGnomQm+19KhyqiEy3Ty6IAVhyoKmv2EjqeZGt6BhU7KLM6oR4eOoUxEqtk+q77zS3N0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ba9b7e-628b-4c46-32f1-08ddaea06097
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 19:43:19.8115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1U2ksMU0qHec/N2NL02Ia8VYpK0WcmAuWjUmUKqorZPFtEsWof41U7+3zBoVzIx1d4UMpQE6dL+t6Awwe/G5ZyjmVoa28+a1Hex42jGuq5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE2OCBTYWx0ZWRfX+zGfSbpKkOfg Hooe8q5FV44LD6vl15P899Gkq9uVDtOskh61cMj623qP3TP/v8MZd5kOliJGUG0xI56Nmu+emAP O0R9IXHev9A7BrKAiPaVeh0YmiKSut6hxj7m+itxjs3JyLT1xUit3pJU+TPxBwokxwK7ilQZQNk
 jAyQI1S80Cc8yzygTqbMsZGu6PzuHTSbGAnwzUZceULKLGG3efdJHyhm3G9q0d0IVX3J6LOZ7ut m5oIu/C3CeDwZogs0UTPTDe8bDEl8C31XUCuMiNgPtcfH5O+5YgAokc8zxOQS2L6OC3k+7kLUPT pnaOO3MqStnSgamIf/WQLW9wJCWtgBlyqNrmpuSpcOCmsc395NgsyFWH4XKPW4CN7xVuaK8W4oe
 4Tl4z5TBNT81X+k22wtbXz60USKRUlMUtuu0vtIVMR23t5TwH88RrWHMNXAhy0o87ROnUj4q
X-Authority-Analysis: v=2.4 cv=DM2P4zNb c=1 sm=1 tr=0 ts=685316e0 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=1YEBisa1uP9SQcPctC4A:9
X-Proofpoint-GUID: lAEIYs4ld15TFv9_Q-bXz40bi7gwsUoN
X-Proofpoint-ORIG-GUID: lAEIYs4ld15TFv9_Q-bXz40bi7gwsUoN

The core kernel code is currently very inconsistent in its use of
vm_flags_t vs. unsigned long. This prevents us from changing the type of
vm_flags_t in the future and is simply not correct, so correct this.

While this results in rather a lot of churn, it is a critical pre-requisite
for a future planned change to VMA flag type.

Additionally, update VMA userland tests to account for the changes.

To make review easier and to break things into smaller parts, driver and
architecture-specific changes is left for a subsequent commit.

The code has been adjusted to cascade the changes across all calling code
as far as is needed.

We will adjust architecture-specific and driver code in a subsequent patch.

Overall, this patch does not introduce any functional change.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/exec.c                        |   2 +-
 fs/userfaultfd.c                 |   2 +-
 include/linux/coredump.h         |   2 +-
 include/linux/huge_mm.h          |  12 +-
 include/linux/khugepaged.h       |   4 +-
 include/linux/ksm.h              |   4 +-
 include/linux/memfd.h            |   4 +-
 include/linux/mm.h               |   6 +-
 include/linux/mm_types.h         |   2 +-
 include/linux/mman.h             |   4 +-
 include/linux/rmap.h             |   4 +-
 include/linux/userfaultfd_k.h    |   4 +-
 include/trace/events/fs_dax.h    |   6 +-
 mm/debug.c                       |   2 +-
 mm/execmem.c                     |   8 +-
 mm/filemap.c                     |   2 +-
 mm/gup.c                         |   2 +-
 mm/huge_memory.c                 |   2 +-
 mm/hugetlb.c                     |   4 +-
 mm/internal.h                    |   4 +-
 mm/khugepaged.c                  |   4 +-
 mm/ksm.c                         |   2 +-
 mm/madvise.c                     |   4 +-
 mm/mapping_dirty_helpers.c       |   2 +-
 mm/memfd.c                       |   8 +-
 mm/memory.c                      |   4 +-
 mm/mmap.c                        |  16 +-
 mm/mprotect.c                    |   8 +-
 mm/mremap.c                      |   2 +-
 mm/nommu.c                       |  12 +-
 mm/rmap.c                        |   4 +-
 mm/shmem.c                       |   6 +-
 mm/userfaultfd.c                 |  14 +-
 mm/vma.c                         |  78 ++++-----
 mm/vma.h                         |  16 +-
 mm/vmscan.c                      |   4 +-
 tools/testing/vma/vma.c          | 266 +++++++++++++++----------------
 tools/testing/vma/vma_internal.h |   8 +-
 38 files changed, 269 insertions(+), 269 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1f5fdd2e096e..d7aaf78c2a8f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -601,7 +601,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = bprm->vma;
 	struct vm_area_struct *prev = NULL;
-	unsigned long vm_flags;
+	vm_flags_t vm_flags;
 	unsigned long stack_base;
 	unsigned long stack_size;
 	unsigned long stack_expand;
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index a8867508bef6..d8b2692a5072 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1242,7 +1242,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	int ret;
 	struct uffdio_register uffdio_register;
 	struct uffdio_register __user *user_uffdio_register;
-	unsigned long vm_flags;
+	vm_flags_t vm_flags;
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end;
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 76e41805b92d..c504b0faecc2 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -10,7 +10,7 @@
 #ifdef CONFIG_COREDUMP
 struct core_vma_metadata {
 	unsigned long start, end;
-	unsigned long flags;
+	vm_flags_t flags;
 	unsigned long dump_size;
 	unsigned long pgoff;
 	struct file   *file;
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 35e34e6a98a2..8f1b15213f61 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -263,7 +263,7 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 }
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
-					 unsigned long vm_flags,
+					 vm_flags_t vm_flags,
 					 unsigned long tva_flags,
 					 unsigned long orders);
 
@@ -284,7 +284,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
  */
 static inline
 unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
-				       unsigned long vm_flags,
+				       vm_flags_t vm_flags,
 				       unsigned long tva_flags,
 				       unsigned long orders)
 {
@@ -319,7 +319,7 @@ struct thpsize {
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
 
 static inline bool vma_thp_disabled(struct vm_area_struct *vma,
-		unsigned long vm_flags)
+		vm_flags_t vm_flags)
 {
 	/*
 	 * Explicitly disabled through madvise or prctl, or some
@@ -431,7 +431,7 @@ change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			__split_huge_pud(__vma, __pud, __address);	\
 	}  while (0)
 
-int hugepage_madvise(struct vm_area_struct *vma, unsigned long *vm_flags,
+int hugepage_madvise(struct vm_area_struct *vma, vm_flags_t *vm_flags,
 		     int advice);
 int madvise_collapse(struct vm_area_struct *vma,
 		     struct vm_area_struct **prev,
@@ -521,7 +521,7 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 }
 
 static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
-					unsigned long vm_flags,
+					vm_flags_t vm_flags,
 					unsigned long tva_flags,
 					unsigned long orders)
 {
@@ -590,7 +590,7 @@ static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
 	do { } while (0)
 
 static inline int hugepage_madvise(struct vm_area_struct *vma,
-				   unsigned long *vm_flags, int advice)
+				   vm_flags_t *vm_flags, int advice)
 {
 	return -EINVAL;
 }
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index b8d69cfbb58b..ff6120463745 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -12,7 +12,7 @@ extern int start_stop_khugepaged(void);
 extern void __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
 extern void khugepaged_enter_vma(struct vm_area_struct *vma,
-				 unsigned long vm_flags);
+				 vm_flags_t vm_flags);
 extern void khugepaged_min_free_kbytes_update(void);
 extern bool current_is_khugepaged(void);
 extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
@@ -37,7 +37,7 @@ static inline void khugepaged_exit(struct mm_struct *mm)
 {
 }
 static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
-					unsigned long vm_flags)
+					vm_flags_t vm_flags)
 {
 }
 static inline int collapse_pte_mapped_thp(struct mm_struct *mm,
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 51787f0b0208..c17b955e7b0b 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -16,7 +16,7 @@
 
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, int advice, unsigned long *vm_flags);
+		unsigned long end, int advice, vm_flags_t *vm_flags);
 vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
 			 vm_flags_t vm_flags);
 int ksm_enable_merge_any(struct mm_struct *mm);
@@ -133,7 +133,7 @@ static inline void collect_procs_ksm(const struct folio *folio,
 
 #ifdef CONFIG_MMU
 static inline int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, int advice, unsigned long *vm_flags)
+		unsigned long end, int advice, vm_flags_t *vm_flags)
 {
 	return 0;
 }
diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index 246daadbfde8..6f606d9573c3 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -14,7 +14,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
  * We also update VMA flags if appropriate by manipulating the VMA flags pointed
  * to by vm_flags_ptr.
  */
-int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr);
+int memfd_check_seals_mmap(struct file *file, vm_flags_t *vm_flags_ptr);
 #else
 static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
 {
@@ -25,7 +25,7 @@ static inline struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 	return ERR_PTR(-EINVAL);
 }
 static inline int memfd_check_seals_mmap(struct file *file,
-					 unsigned long *vm_flags_ptr)
+					 vm_flags_t *vm_flags_ptr)
 {
 	return 0;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7a7cd2e1b2af..0e0549f3d681 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2564,7 +2564,7 @@ extern long change_protection(struct mmu_gather *tlb,
 			      unsigned long end, unsigned long cp_flags);
 extern int mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	  struct vm_area_struct *vma, struct vm_area_struct **pprev,
-	  unsigned long start, unsigned long end, unsigned long newflags);
+	  unsigned long start, unsigned long end, vm_flags_t newflags);
 
 /*
  * doesn't attempt to fault and will return short.
@@ -3321,9 +3321,9 @@ extern void vm_stat_account(struct mm_struct *, vm_flags_t, long npages);
 
 extern bool vma_is_special_mapping(const struct vm_area_struct *vma,
 				   const struct vm_special_mapping *sm);
-extern struct vm_area_struct *_install_special_mapping(struct mm_struct *mm,
+struct vm_area_struct *_install_special_mapping(struct mm_struct *mm,
 				   unsigned long addr, unsigned long len,
-				   unsigned long flags,
+				   vm_flags_t vm_flags,
 				   const struct vm_special_mapping *spec);
 
 unsigned long randomize_stack_top(unsigned long stack_top);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d6b91e8a66d6..804d269a4f5e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1081,7 +1081,7 @@ struct mm_struct {
 		unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
 		unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
 		unsigned long stack_vm;	   /* VM_STACK */
-		unsigned long def_flags;
+		vm_flags_t def_flags;
 
 		/**
 		 * @write_protect_seq: Locked when any thread is write
diff --git a/include/linux/mman.h b/include/linux/mman.h
index f4c6346a8fcd..de9e8e6229a4 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -137,7 +137,7 @@ static inline bool arch_validate_flags(unsigned long flags)
 /*
  * Combine the mmap "prot" argument into "vm_flags" used internally.
  */
-static inline unsigned long
+static inline vm_flags_t
 calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
 {
 	return _calc_vm_trans(prot, PROT_READ,  VM_READ ) |
@@ -149,7 +149,7 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
 /*
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
-static inline unsigned long
+static inline vm_flags_t
 calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 6d2b3fbe2df0..45904ff413ab 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -897,7 +897,7 @@ static inline int folio_try_share_anon_rmap_pmd(struct folio *folio,
  * Called from mm/vmscan.c to handle paging out
  */
 int folio_referenced(struct folio *, int is_locked,
-			struct mem_cgroup *memcg, unsigned long *vm_flags);
+			struct mem_cgroup *memcg, vm_flags_t *vm_flags);
 
 void try_to_migrate(struct folio *folio, enum ttu_flags flags);
 void try_to_unmap(struct folio *, enum ttu_flags flags);
@@ -1029,7 +1029,7 @@ struct anon_vma *folio_lock_anon_vma_read(const struct folio *folio,
 
 static inline int folio_referenced(struct folio *folio, int is_locked,
 				  struct mem_cgroup *memcg,
-				  unsigned long *vm_flags)
+				  vm_flags_t *vm_flags)
 {
 	*vm_flags = 0;
 	return 0;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ccad58602846..df85330bcfa6 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -209,7 +209,7 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 }
 
 static inline bool vma_can_userfault(struct vm_area_struct *vma,
-				     unsigned long vm_flags,
+				     vm_flags_t vm_flags,
 				     bool wp_async)
 {
 	vm_flags &= __VM_UFFD_FLAGS;
@@ -281,7 +281,7 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 
 int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 			       struct vm_area_struct *vma,
-			       unsigned long vm_flags,
+			       vm_flags_t vm_flags,
 			       unsigned long start, unsigned long end,
 			       bool wp_async);
 
diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
index 76b56f78abb0..50ebc1290ab0 100644
--- a/include/trace/events/fs_dax.h
+++ b/include/trace/events/fs_dax.h
@@ -15,7 +15,7 @@ DECLARE_EVENT_CLASS(dax_pmd_fault_class,
 		__field(unsigned long, ino)
 		__field(unsigned long, vm_start)
 		__field(unsigned long, vm_end)
-		__field(unsigned long, vm_flags)
+		__field(vm_flags_t, vm_flags)
 		__field(unsigned long, address)
 		__field(pgoff_t, pgoff)
 		__field(pgoff_t, max_pgoff)
@@ -67,7 +67,7 @@ DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
 	TP_ARGS(inode, vmf, zero_folio, radix_entry),
 	TP_STRUCT__entry(
 		__field(unsigned long, ino)
-		__field(unsigned long, vm_flags)
+		__field(vm_flags_t, vm_flags)
 		__field(unsigned long, address)
 		__field(struct folio *, zero_folio)
 		__field(void *, radix_entry)
@@ -107,7 +107,7 @@ DECLARE_EVENT_CLASS(dax_pte_fault_class,
 	TP_ARGS(inode, vmf, result),
 	TP_STRUCT__entry(
 		__field(unsigned long, ino)
-		__field(unsigned long, vm_flags)
+		__field(vm_flags_t, vm_flags)
 		__field(unsigned long, address)
 		__field(pgoff_t, pgoff)
 		__field(dev_t, dev)
diff --git a/mm/debug.c b/mm/debug.c
index 907382257062..e2973e1b3812 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -290,7 +290,7 @@ void dump_vmg(const struct vma_merge_struct *vmg, const char *reason)
 		vmg->vmi, vmg->vmi ? vma_iter_addr(vmg->vmi) : 0,
 		vmg->vmi ? vma_iter_end(vmg->vmi) : 0,
 		vmg->prev, vmg->middle, vmg->next, vmg->target,
-		vmg->start, vmg->end, vmg->flags,
+		vmg->start, vmg->end, vmg->vm_flags,
 		vmg->file, vmg->anon_vma, vmg->policy,
 #ifdef CONFIG_USERFAULTFD
 		vmg->uffd_ctx.ctx,
diff --git a/mm/execmem.c b/mm/execmem.c
index 9720ac2dfa41..bd95ff6a1d03 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -26,7 +26,7 @@ static struct execmem_info default_execmem_info __ro_after_init;
 
 #ifdef CONFIG_MMU
 static void *execmem_vmalloc(struct execmem_range *range, size_t size,
-			     pgprot_t pgprot, unsigned long vm_flags)
+			     pgprot_t pgprot, vm_flags_t vm_flags)
 {
 	bool kasan = range->flags & EXECMEM_KASAN_SHADOW;
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_NOWARN;
@@ -82,7 +82,7 @@ struct vm_struct *execmem_vmap(size_t size)
 }
 #else
 static void *execmem_vmalloc(struct execmem_range *range, size_t size,
-			     pgprot_t pgprot, unsigned long vm_flags)
+			     pgprot_t pgprot, vm_flags_t vm_flags)
 {
 	return vmalloc(size);
 }
@@ -284,7 +284,7 @@ void execmem_cache_make_ro(void)
 
 static int execmem_cache_populate(struct execmem_range *range, size_t size)
 {
-	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
+	vm_flags_t vm_flags = VM_ALLOW_HUGE_VMAP;
 	struct vm_struct *vm;
 	size_t alloc_size;
 	int err = -ENOMEM;
@@ -407,7 +407,7 @@ void *execmem_alloc(enum execmem_type type, size_t size)
 {
 	struct execmem_range *range = &execmem_info->ranges[type];
 	bool use_cache = range->flags & EXECMEM_ROX_CACHE;
-	unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
+	vm_flags_t vm_flags = VM_FLUSH_RESET_PERMS;
 	pgprot_t pgprot = range->pgprot;
 	void *p;
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 93fbc2ef232a..ccbfc3cef426 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3216,7 +3216,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct address_space *mapping = file->f_mapping;
 	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
 	struct file *fpin = NULL;
-	unsigned long vm_flags = vmf->vma->vm_flags;
+	vm_flags_t vm_flags = vmf->vma->vm_flags;
 	unsigned short mmap_miss;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/mm/gup.c b/mm/gup.c
index 6888e871a74a..30d320719fa2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2002,7 +2002,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 {
 	struct vm_area_struct *vma;
 	bool must_unlock = false;
-	unsigned long vm_flags;
+	vm_flags_t vm_flags;
 	long i;
 
 	if (!nr_pages)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8e0e3cfd9f22..ce130225a8e5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -98,7 +98,7 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 }
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
-					 unsigned long vm_flags,
+					 vm_flags_t vm_flags,
 					 unsigned long tva_flags,
 					 unsigned long orders)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3d61ec17c15a..ff768a170d0e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7465,8 +7465,8 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	unsigned long s_end = sbase + PUD_SIZE;
 
 	/* Allow segments to share if only one is marked locked */
-	unsigned long vm_flags = vma->vm_flags & ~VM_LOCKED_MASK;
-	unsigned long svm_flags = svma->vm_flags & ~VM_LOCKED_MASK;
+	vm_flags_t vm_flags = vma->vm_flags & ~VM_LOCKED_MASK;
+	vm_flags_t svm_flags = svma->vm_flags & ~VM_LOCKED_MASK;
 
 	/*
 	 * match the virtual addresses, permission and the alignment of the
diff --git a/mm/internal.h b/mm/internal.h
index feda91c9b3f4..506c6fc8b6dc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -930,7 +930,7 @@ extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *locked);
 extern long faultin_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, bool write, int *locked);
-extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
+extern bool mlock_future_ok(struct mm_struct *mm, vm_flags_t vm_flags,
 			       unsigned long bytes);
 
 /*
@@ -1360,7 +1360,7 @@ int migrate_device_coherent_folio(struct folio *folio);
 
 struct vm_struct *__get_vm_area_node(unsigned long size,
 				     unsigned long align, unsigned long shift,
-				     unsigned long flags, unsigned long start,
+				     vm_flags_t vm_flags, unsigned long start,
 				     unsigned long end, int node, gfp_t gfp_mask,
 				     const void *caller);
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d45d08b521f6..3495a20cef5e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -347,7 +347,7 @@ struct attribute_group khugepaged_attr_group = {
 #endif /* CONFIG_SYSFS */
 
 int hugepage_madvise(struct vm_area_struct *vma,
-		     unsigned long *vm_flags, int advice)
+		     vm_flags_t *vm_flags, int advice)
 {
 	switch (advice) {
 	case MADV_HUGEPAGE:
@@ -470,7 +470,7 @@ void __khugepaged_enter(struct mm_struct *mm)
 }
 
 void khugepaged_enter_vma(struct vm_area_struct *vma,
-			  unsigned long vm_flags)
+			  vm_flags_t vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    hugepage_pmd_enabled()) {
diff --git a/mm/ksm.c b/mm/ksm.c
index 18b3690bb69a..ef73b25fd65a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2840,7 +2840,7 @@ int ksm_disable(struct mm_struct *mm)
 }
 
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, int advice, unsigned long *vm_flags)
+		unsigned long end, int advice, vm_flags_t *vm_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	int err;
diff --git a/mm/madvise.c b/mm/madvise.c
index 0970623a0e98..070132f9842b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -130,7 +130,7 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
  */
 static int madvise_update_vma(struct vm_area_struct *vma,
 			      struct vm_area_struct **prev, unsigned long start,
-			      unsigned long end, unsigned long new_flags,
+			      unsigned long end, vm_flags_t new_flags,
 			      struct anon_vma_name *anon_name)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -1258,7 +1258,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 	int behavior = arg->behavior;
 	int error;
 	struct anon_vma_name *anon_name;
-	unsigned long new_flags = vma->vm_flags;
+	vm_flags_t new_flags = vma->vm_flags;
 
 	if (unlikely(!can_modify_vma_madv(vma, behavior)))
 		return -EPERM;
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 208b428d29da..c193de6cb23a 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -218,7 +218,7 @@ static void wp_clean_post_vma(struct mm_walk *walk)
 static int wp_clean_test_walk(unsigned long start, unsigned long end,
 			      struct mm_walk *walk)
 {
-	unsigned long vm_flags = READ_ONCE(walk->vma->vm_flags);
+	vm_flags_t vm_flags = READ_ONCE(walk->vma->vm_flags);
 
 	/* Skip non-applicable VMAs */
 	if ((vm_flags & (VM_SHARED | VM_MAYWRITE | VM_HUGETLB)) !=
diff --git a/mm/memfd.c b/mm/memfd.c
index 65a107f72e39..b558c4c3bd27 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -332,10 +332,10 @@ static inline bool is_write_sealed(unsigned int seals)
 	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
 }
 
-static int check_write_seal(unsigned long *vm_flags_ptr)
+static int check_write_seal(vm_flags_t *vm_flags_ptr)
 {
-	unsigned long vm_flags = *vm_flags_ptr;
-	unsigned long mask = vm_flags & (VM_SHARED | VM_WRITE);
+	vm_flags_t vm_flags = *vm_flags_ptr;
+	vm_flags_t mask = vm_flags & (VM_SHARED | VM_WRITE);
 
 	/* If a private mapping then writability is irrelevant. */
 	if (!(mask & VM_SHARED))
@@ -357,7 +357,7 @@ static int check_write_seal(unsigned long *vm_flags_ptr)
 	return 0;
 }
 
-int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr)
+int memfd_check_seals_mmap(struct file *file, vm_flags_t *vm_flags_ptr)
 {
 	int err = 0;
 	unsigned int *seals_ptr = memfd_file_seals_ptr(file);
diff --git a/mm/memory.c b/mm/memory.c
index 0163d127cece..0f9b32a20e5b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -784,7 +784,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *dst_vma,
 		struct vm_area_struct *src_vma, unsigned long addr, int *rss)
 {
-	unsigned long vm_flags = dst_vma->vm_flags;
+	vm_flags_t vm_flags = dst_vma->vm_flags;
 	pte_t orig_pte = ptep_get(src_pte);
 	pte_t pte = orig_pte;
 	struct folio *folio;
@@ -6106,7 +6106,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		.gfp_mask = __get_fault_gfp_mask(vma),
 	};
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long vm_flags = vma->vm_flags;
+	vm_flags_t vm_flags = vma->vm_flags;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	vm_fault_t ret;
diff --git a/mm/mmap.c b/mm/mmap.c
index 09c563c95112..8f92cf10b656 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -80,7 +80,7 @@ core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 /* Update vma->vm_page_prot to reflect vma->vm_flags. */
 void vma_set_page_prot(struct vm_area_struct *vma)
 {
-	unsigned long vm_flags = vma->vm_flags;
+	vm_flags_t vm_flags = vma->vm_flags;
 	pgprot_t vm_page_prot;
 
 	vm_page_prot = vm_pgprot_modify(vma->vm_page_prot, vm_flags);
@@ -228,12 +228,12 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
 	return hint;
 }
 
-bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
+bool mlock_future_ok(struct mm_struct *mm, vm_flags_t vm_flags,
 			unsigned long bytes)
 {
 	unsigned long locked_pages, limit_pages;
 
-	if (!(flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
+	if (!(vm_flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
 		return true;
 
 	locked_pages = bytes >> PAGE_SHIFT;
@@ -1207,7 +1207,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	return ret;
 }
 
-int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
+int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
@@ -1224,7 +1224,7 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 		return 0;
 
 	/* Until we need other flags, refuse anything except VM_EXEC. */
-	if ((flags & (~VM_EXEC)) != 0)
+	if ((vm_flags & (~VM_EXEC)) != 0)
 		return -EINVAL;
 
 	if (mmap_write_lock_killable(mm))
@@ -1239,7 +1239,7 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 		goto munmap_failed;
 
 	vma = vma_prev(&vmi);
-	ret = do_brk_flags(&vmi, vma, addr, len, flags);
+	ret = do_brk_flags(&vmi, vma, addr, len, vm_flags);
 	populate = ((mm->def_flags & VM_LOCKED) != 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
@@ -1444,7 +1444,7 @@ static vm_fault_t special_mapping_fault(struct vm_fault *vmf)
 static struct vm_area_struct *__install_special_mapping(
 	struct mm_struct *mm,
 	unsigned long addr, unsigned long len,
-	unsigned long vm_flags, void *priv,
+	vm_flags_t vm_flags, void *priv,
 	const struct vm_operations_struct *ops)
 {
 	int ret;
@@ -1496,7 +1496,7 @@ bool vma_is_special_mapping(const struct vm_area_struct *vma,
 struct vm_area_struct *_install_special_mapping(
 	struct mm_struct *mm,
 	unsigned long addr, unsigned long len,
-	unsigned long vm_flags, const struct vm_special_mapping *spec)
+	vm_flags_t vm_flags, const struct vm_special_mapping *spec)
 {
 	return __install_special_mapping(mm, addr, len, vm_flags, (void *)spec,
 					&special_mapping_vmops);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 00d598942771..88709c01177b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -596,10 +596,10 @@ static const struct mm_walk_ops prot_none_walk_ops = {
 int
 mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	       struct vm_area_struct *vma, struct vm_area_struct **pprev,
-	       unsigned long start, unsigned long end, unsigned long newflags)
+	       unsigned long start, unsigned long end, vm_flags_t newflags)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long oldflags = READ_ONCE(vma->vm_flags);
+	vm_flags_t oldflags = READ_ONCE(vma->vm_flags);
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned int mm_cp_flags = 0;
 	unsigned long charged = 0;
@@ -774,8 +774,8 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	nstart = start;
 	tmp = vma->vm_start;
 	for_each_vma_range(vmi, vma, end) {
-		unsigned long mask_off_old_flags;
-		unsigned long newflags;
+		vm_flags_t mask_off_old_flags;
+		vm_flags_t newflags;
 		int new_vma_pkey;
 
 		if (vma->vm_start != tmp) {
diff --git a/mm/mremap.c b/mm/mremap.c
index 81b9383c1ba2..b31740f77b84 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1536,7 +1536,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	struct vm_area_struct *vma = vrm->vma;
 	unsigned long old_addr = vrm->addr;
 	unsigned long old_len = vrm->old_len;
-	unsigned long dummy = vma->vm_flags;
+	vm_flags_t dummy = vma->vm_flags;
 
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
diff --git a/mm/nommu.c b/mm/nommu.c
index b624acec6d2e..87e1acab0d64 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -126,7 +126,7 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 
 void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		unsigned long start, unsigned long end, gfp_t gfp_mask,
-		pgprot_t prot, unsigned long vm_flags, int node,
+		pgprot_t prot, vm_flags_t vm_flags, int node,
 		const void *caller)
 {
 	return __vmalloc_noprof(size, gfp_mask);
@@ -844,12 +844,12 @@ static int validate_mmap_request(struct file *file,
  * we've determined that we can make the mapping, now translate what we
  * now know into VMA flags
  */
-static unsigned long determine_vm_flags(struct file *file,
-					unsigned long prot,
-					unsigned long flags,
-					unsigned long capabilities)
+static vm_flags_t determine_vm_flags(struct file *file,
+		unsigned long prot,
+		unsigned long flags,
+		unsigned long capabilities)
 {
-	unsigned long vm_flags;
+	vm_flags_t vm_flags;
 
 	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
 
diff --git a/mm/rmap.c b/mm/rmap.c
index fd160ddaa980..3b74bb19c11d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -839,7 +839,7 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address)
 struct folio_referenced_arg {
 	int mapcount;
 	int referenced;
-	unsigned long vm_flags;
+	vm_flags_t vm_flags;
 	struct mem_cgroup *memcg;
 };
 
@@ -984,7 +984,7 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
  * the function bailed out due to rmap lock contention.
  */
 int folio_referenced(struct folio *folio, int is_locked,
-		     struct mem_cgroup *memcg, unsigned long *vm_flags)
+		     struct mem_cgroup *memcg, vm_flags_t *vm_flags)
 {
 	bool we_locked = false;
 	struct folio_referenced_arg pra = {
diff --git a/mm/shmem.c b/mm/shmem.c
index 0bc30dafad90..41af8aa959c8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -627,7 +627,7 @@ static unsigned int shmem_get_orders_within_size(struct inode *inode,
 static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 					      loff_t write_end, bool shmem_huge_force,
 					      struct vm_area_struct *vma,
-					      unsigned long vm_flags)
+					      vm_flags_t vm_flags)
 {
 	unsigned int maybe_pmd_order = HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER ?
 		0 : BIT(HPAGE_PMD_ORDER);
@@ -874,7 +874,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 					      loff_t write_end, bool shmem_huge_force,
 					      struct vm_area_struct *vma,
-					      unsigned long vm_flags)
+					      vm_flags_t vm_flags)
 {
 	return 0;
 }
@@ -1777,7 +1777,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 {
 	unsigned long mask = READ_ONCE(huge_shmem_orders_always);
 	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
-	unsigned long vm_flags = vma ? vma->vm_flags : 0;
+	vm_flags_t vm_flags = vma ? vma->vm_flags : 0;
 	unsigned int global_orders;
 
 	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags)))
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 879505c6996f..83c122c5a97b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1895,11 +1895,11 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 }
 
 static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
-				     vm_flags_t flags)
+				     vm_flags_t vm_flags)
 {
-	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
+	const bool uffd_wp_changed = (vma->vm_flags ^ vm_flags) & VM_UFFD_WP;
 
-	vm_flags_reset(vma, flags);
+	vm_flags_reset(vma, vm_flags);
 	/*
 	 * For shared mappings, we want to enable writenotify while
 	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
@@ -1911,12 +1911,12 @@ static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
 
 static void userfaultfd_set_ctx(struct vm_area_struct *vma,
 				struct userfaultfd_ctx *ctx,
-				unsigned long flags)
+				vm_flags_t vm_flags)
 {
 	vma_start_write(vma);
 	vma->vm_userfaultfd_ctx = (struct vm_userfaultfd_ctx){ctx};
 	userfaultfd_set_vm_flags(vma,
-				 (vma->vm_flags & ~__VM_UFFD_FLAGS) | flags);
+				 (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags);
 }
 
 void userfaultfd_reset_ctx(struct vm_area_struct *vma)
@@ -1962,14 +1962,14 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 /* Assumes mmap write lock taken, and mm_struct pinned. */
 int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 			       struct vm_area_struct *vma,
-			       unsigned long vm_flags,
+			       vm_flags_t vm_flags,
 			       unsigned long start, unsigned long end,
 			       bool wp_async)
 {
 	VMA_ITERATOR(vmi, ctx->mm, start);
 	struct vm_area_struct *prev = vma_prev(&vmi);
 	unsigned long vma_end;
-	unsigned long new_flags;
+	vm_flags_t new_flags;
 
 	if (vma->vm_start < start)
 		prev = vma;
diff --git a/mm/vma.c b/mm/vma.c
index 5d35adadf2b5..13794a0ac5fe 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -15,7 +15,7 @@ struct mmap_state {
 	unsigned long end;
 	pgoff_t pgoff;
 	unsigned long pglen;
-	unsigned long flags;
+	vm_flags_t vm_flags;
 	struct file *file;
 	pgprot_t page_prot;
 
@@ -34,7 +34,7 @@ struct mmap_state {
 	struct maple_tree mt_detach;
 };
 
-#define MMAP_STATE(name, mm_, vmi_, addr_, len_, pgoff_, flags_, file_) \
+#define MMAP_STATE(name, mm_, vmi_, addr_, len_, pgoff_, vm_flags_, file_) \
 	struct mmap_state name = {					\
 		.mm = mm_,						\
 		.vmi = vmi_,						\
@@ -42,9 +42,9 @@ struct mmap_state {
 		.end = (addr_) + (len_),				\
 		.pgoff = pgoff_,					\
 		.pglen = PHYS_PFN(len_),				\
-		.flags = flags_,					\
+		.vm_flags = vm_flags_,					\
 		.file = file_,						\
-		.page_prot = vm_get_page_prot(flags_),			\
+		.page_prot = vm_get_page_prot(vm_flags_),		\
 	}
 
 #define VMG_MMAP_STATE(name, map_, vma_)				\
@@ -53,7 +53,7 @@ struct mmap_state {
 		.vmi = (map_)->vmi,					\
 		.start = (map_)->addr,					\
 		.end = (map_)->end,					\
-		.flags = (map_)->flags,					\
+		.vm_flags = (map_)->vm_flags,				\
 		.pgoff = (map_)->pgoff,					\
 		.file = (map_)->file,					\
 		.prev = (map_)->prev,					\
@@ -76,7 +76,7 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 	 * the kernel to generate new VMAs when old one could be
 	 * extended instead.
 	 */
-	if ((vma->vm_flags ^ vmg->flags) & ~VM_SOFTDIRTY)
+	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_SOFTDIRTY)
 		return false;
 	if (vma->vm_file != vmg->file)
 		return false;
@@ -823,7 +823,7 @@ struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *vmg)
 	 * furthermost left or right side of the VMA, then we have no chance of
 	 * merging and should abort.
 	 */
-	if (vmg->flags & VM_SPECIAL || (!left_side && !right_side))
+	if (vmg->vm_flags & VM_SPECIAL || (!left_side && !right_side))
 		return NULL;
 
 	if (left_side)
@@ -953,7 +953,7 @@ struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *vmg)
 	if (err || commit_merge(vmg))
 		goto abort;
 
-	khugepaged_enter_vma(vmg->target, vmg->flags);
+	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
 
@@ -1035,7 +1035,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	vmg->state = VMA_MERGE_NOMERGE;
 
 	/* Special VMAs are unmergeable, also if no prev/next. */
-	if ((vmg->flags & VM_SPECIAL) || (!prev && !next))
+	if ((vmg->vm_flags & VM_SPECIAL) || (!prev && !next))
 		return NULL;
 
 	can_merge_left = can_vma_merge_left(vmg);
@@ -1073,7 +1073,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	 * following VMA if we have VMAs on both sides.
 	 */
 	if (vmg->target && !vma_expand(vmg)) {
-		khugepaged_enter_vma(vmg->target, vmg->flags);
+		khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 		vmg->state = VMA_MERGE_SUCCESS;
 		return vmg->target;
 	}
@@ -1620,11 +1620,11 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 struct vm_area_struct *vma_modify_flags(
 	struct vma_iterator *vmi, struct vm_area_struct *prev,
 	struct vm_area_struct *vma, unsigned long start, unsigned long end,
-	unsigned long new_flags)
+	vm_flags_t vm_flags)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
 
-	vmg.flags = new_flags;
+	vmg.vm_flags = vm_flags;
 
 	return vma_modify(&vmg);
 }
@@ -1635,12 +1635,12 @@ struct vm_area_struct
 		       struct vm_area_struct *vma,
 		       unsigned long start,
 		       unsigned long end,
-		       unsigned long new_flags,
+		       vm_flags_t vm_flags,
 		       struct anon_vma_name *new_name)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
 
-	vmg.flags = new_flags;
+	vmg.vm_flags = vm_flags;
 	vmg.anon_name = new_name;
 
 	return vma_modify(&vmg);
@@ -1665,13 +1665,13 @@ struct vm_area_struct
 		       struct vm_area_struct *prev,
 		       struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end,
-		       unsigned long new_flags,
+		       vm_flags_t vm_flags,
 		       struct vm_userfaultfd_ctx new_ctx,
 		       bool give_up_on_oom)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
 
-	vmg.flags = new_flags;
+	vmg.vm_flags = vm_flags;
 	vmg.uffd_ctx = new_ctx;
 	if (give_up_on_oom)
 		vmg.give_up_on_oom = true;
@@ -2376,11 +2376,11 @@ static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
 	}
 
 	/* Check against address space limit. */
-	if (!may_expand_vm(map->mm, map->flags, map->pglen - vms->nr_pages))
+	if (!may_expand_vm(map->mm, map->vm_flags, map->pglen - vms->nr_pages))
 		return -ENOMEM;
 
 	/* Private writable mapping: check memory availability. */
-	if (accountable_mapping(map->file, map->flags)) {
+	if (accountable_mapping(map->file, map->vm_flags)) {
 		map->charged = map->pglen;
 		map->charged -= vms->nr_accounted;
 		if (map->charged) {
@@ -2390,7 +2390,7 @@ static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
 		}
 
 		vms->nr_accounted = 0;
-		map->flags |= VM_ACCOUNT;
+		map->vm_flags |= VM_ACCOUNT;
 	}
 
 	/*
@@ -2434,11 +2434,11 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 	 * Drivers should not permit writability when previously it was
 	 * disallowed.
 	 */
-	VM_WARN_ON_ONCE(map->flags != vma->vm_flags &&
-			!(map->flags & VM_MAYWRITE) &&
+	VM_WARN_ON_ONCE(map->vm_flags != vma->vm_flags &&
+			!(map->vm_flags & VM_MAYWRITE) &&
 			(vma->vm_flags & VM_MAYWRITE));
 
-	map->flags = vma->vm_flags;
+	map->vm_flags = vma->vm_flags;
 
 	return 0;
 }
@@ -2469,7 +2469,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 
 	vma_iter_config(vmi, map->addr, map->end);
 	vma_set_range(vma, map->addr, map->end, map->pgoff);
-	vm_flags_init(vma, map->flags);
+	vm_flags_init(vma, map->vm_flags);
 	vma->vm_page_prot = map->page_prot;
 
 	if (vma_iter_prealloc(vmi, vma)) {
@@ -2479,7 +2479,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 
 	if (map->file)
 		error = __mmap_new_file_vma(map, vma);
-	else if (map->flags & VM_SHARED)
+	else if (map->vm_flags & VM_SHARED)
 		error = shmem_zero_setup(vma);
 	else
 		vma_set_anonymous(vma);
@@ -2489,7 +2489,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 
 #ifdef CONFIG_SPARC64
 	/* TODO: Fix SPARC ADI! */
-	WARN_ON_ONCE(!arch_validate_flags(map->flags));
+	WARN_ON_ONCE(!arch_validate_flags(map->vm_flags));
 #endif
 
 	/* Lock the VMA since it is modified after insertion into VMA tree */
@@ -2503,7 +2503,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	 * call covers the non-merge case.
 	 */
 	if (!vma_is_anonymous(vma))
-		khugepaged_enter_vma(vma, map->flags);
+		khugepaged_enter_vma(vma, map->vm_flags);
 	*vmap = vma;
 	return 0;
 
@@ -2524,7 +2524,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = map->mm;
-	unsigned long vm_flags = vma->vm_flags;
+	vm_flags_t vm_flags = vma->vm_flags;
 
 	perf_event_mmap(vma);
 
@@ -2577,7 +2577,7 @@ static int call_mmap_prepare(struct mmap_state *map)
 
 		.pgoff = map->pgoff,
 		.file = map->file,
-		.vm_flags = map->flags,
+		.vm_flags = map->vm_flags,
 		.page_prot = map->page_prot,
 	};
 
@@ -2589,7 +2589,7 @@ static int call_mmap_prepare(struct mmap_state *map)
 	/* Update fields permitted to be changed. */
 	map->pgoff = desc.pgoff;
 	map->file = desc.file;
-	map->flags = desc.vm_flags;
+	map->vm_flags = desc.vm_flags;
 	map->page_prot = desc.page_prot;
 	/* User-defined fields. */
 	map->vm_ops = desc.vm_ops;
@@ -2608,7 +2608,7 @@ static void set_vma_user_defined_fields(struct vm_area_struct *vma,
 
 static void update_ksm_flags(struct mmap_state *map)
 {
-	map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
+	map->vm_flags = ksm_vma_flags(map->mm, map->file, map->vm_flags);
 }
 
 /*
@@ -2759,14 +2759,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
  * @addr: The start address
  * @len: The length of the increase
  * @vma: The vma,
- * @flags: The VMA Flags
+ * @vm_flags: The VMA Flags
  *
  * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the flags
  * do not match then create a new anonymous VMA.  Eventually we may be able to
  * do some brk-specific accounting here.
  */
 int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		 unsigned long addr, unsigned long len, unsigned long flags)
+		 unsigned long addr, unsigned long len, vm_flags_t vm_flags)
 {
 	struct mm_struct *mm = current->mm;
 
@@ -2774,9 +2774,9 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
 	 */
-	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
-	flags = ksm_vma_flags(mm, NULL, flags);
-	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
+	vm_flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	vm_flags = ksm_vma_flags(mm, NULL, vm_flags);
+	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
 	if (mm->map_count > sysctl_max_map_count)
@@ -2790,7 +2790,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
 	if (vma && vma->vm_end == addr) {
-		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
+		VMG_STATE(vmg, mm, vmi, addr, addr + len, vm_flags, PHYS_PFN(addr));
 
 		vmg.prev = vma;
 		/* vmi is positioned at prev, which this mode expects. */
@@ -2811,8 +2811,8 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	vma_set_anonymous(vma);
 	vma_set_range(vma, addr, addr + len, addr >> PAGE_SHIFT);
-	vm_flags_init(vma, flags);
-	vma->vm_page_prot = vm_get_page_prot(flags);
+	vm_flags_init(vma, vm_flags);
+	vma->vm_page_prot = vm_get_page_prot(vm_flags);
 	vma_start_write(vma);
 	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
 		goto mas_store_fail;
@@ -2823,7 +2823,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	perf_event_mmap(vma);
 	mm->total_vm += len >> PAGE_SHIFT;
 	mm->data_vm += len >> PAGE_SHIFT;
-	if (flags & VM_LOCKED)
+	if (vm_flags & VM_LOCKED)
 		mm->locked_vm += (len >> PAGE_SHIFT);
 	vm_flags_set(vma, VM_SOFTDIRTY);
 	return 0;
diff --git a/mm/vma.h b/mm/vma.h
index 392548ccfb96..269bfba36557 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -98,7 +98,7 @@ struct vma_merge_struct {
 	unsigned long end;
 	pgoff_t pgoff;
 
-	unsigned long flags;
+	vm_flags_t vm_flags;
 	struct file *file;
 	struct anon_vma *anon_vma;
 	struct mempolicy *policy;
@@ -164,13 +164,13 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 	return vma->vm_pgoff + PHYS_PFN(addr - vma->vm_start);
 }
 
-#define VMG_STATE(name, mm_, vmi_, start_, end_, flags_, pgoff_)	\
+#define VMG_STATE(name, mm_, vmi_, start_, end_, vm_flags_, pgoff_)	\
 	struct vma_merge_struct name = {				\
 		.mm = mm_,						\
 		.vmi = vmi_,						\
 		.start = start_,					\
 		.end = end_,						\
-		.flags = flags_,					\
+		.vm_flags = vm_flags_,					\
 		.pgoff = pgoff_,					\
 		.state = VMA_MERGE_START,				\
 	}
@@ -184,7 +184,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 		.next = NULL,					\
 		.start = start_,				\
 		.end = end_,					\
-		.flags = vma_->vm_flags,			\
+		.vm_flags = vma_->vm_flags,			\
 		.pgoff = vma_pgoff_offset(vma_, start_),	\
 		.file = vma_->vm_file,				\
 		.anon_vma = vma_->anon_vma,			\
@@ -288,7 +288,7 @@ __must_check struct vm_area_struct
 *vma_modify_flags(struct vma_iterator *vmi,
 		struct vm_area_struct *prev, struct vm_area_struct *vma,
 		unsigned long start, unsigned long end,
-		unsigned long new_flags);
+		vm_flags_t vm_flags);
 
 /* We are about to modify the VMA's flags and/or anon_name. */
 __must_check struct vm_area_struct
@@ -297,7 +297,7 @@ __must_check struct vm_area_struct
 		       struct vm_area_struct *vma,
 		       unsigned long start,
 		       unsigned long end,
-		       unsigned long new_flags,
+		       vm_flags_t vm_flags,
 		       struct anon_vma_name *new_name);
 
 /* We are about to modify the VMA's memory policy. */
@@ -314,7 +314,7 @@ __must_check struct vm_area_struct
 		       struct vm_area_struct *prev,
 		       struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end,
-		       unsigned long new_flags,
+		       vm_flags_t vm_flags,
 		       struct vm_userfaultfd_ctx new_ctx,
 		       bool give_up_on_oom);
 
@@ -378,7 +378,7 @@ static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma
 }
 
 #ifdef CONFIG_MMU
-static inline pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
+static inline pgprot_t vm_pgprot_modify(pgprot_t oldprot, vm_flags_t vm_flags)
 {
 	return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index efc818a0bbec..c86a2495138a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -907,7 +907,7 @@ static enum folio_references folio_check_references(struct folio *folio,
 						  struct scan_control *sc)
 {
 	int referenced_ptes, referenced_folio;
-	unsigned long vm_flags;
+	vm_flags_t vm_flags;
 
 	referenced_ptes = folio_referenced(folio, 1, sc->target_mem_cgroup,
 					   &vm_flags);
@@ -2120,7 +2120,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 {
 	unsigned long nr_taken;
 	unsigned long nr_scanned;
-	unsigned long vm_flags;
+	vm_flags_t vm_flags;
 	LIST_HEAD(l_hold);	/* The folios which were snipped off */
 	LIST_HEAD(l_active);
 	LIST_HEAD(l_inactive);
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 61a67aa6977c..645ee841f43d 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -65,7 +65,7 @@ static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 					unsigned long start,
 					unsigned long end,
 					pgoff_t pgoff,
-					vm_flags_t flags)
+					vm_flags_t vm_flags)
 {
 	struct vm_area_struct *ret = vm_area_alloc(mm);
 
@@ -75,7 +75,7 @@ static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 	ret->vm_start = start;
 	ret->vm_end = end;
 	ret->vm_pgoff = pgoff;
-	ret->__vm_flags = flags;
+	ret->__vm_flags = vm_flags;
 	vma_assert_detached(ret);
 
 	return ret;
@@ -103,9 +103,9 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 						 unsigned long start,
 						 unsigned long end,
 						 pgoff_t pgoff,
-						 vm_flags_t flags)
+						 vm_flags_t vm_flags)
 {
-	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, flags);
+	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, vm_flags);
 
 	if (vma == NULL)
 		return NULL;
@@ -172,7 +172,7 @@ static int expand_existing(struct vma_merge_struct *vmg)
  * specified new range.
  */
 static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
-			  unsigned long end, pgoff_t pgoff, vm_flags_t flags)
+			  unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags)
 {
 	vma_iter_set(vmg->vmi, start);
 
@@ -184,7 +184,7 @@ static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
 	vmg->start = start;
 	vmg->end = end;
 	vmg->pgoff = pgoff;
-	vmg->flags = flags;
+	vmg->vm_flags = vm_flags;
 
 	vmg->just_expand = false;
 	vmg->__remove_middle = false;
@@ -195,10 +195,10 @@ static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
 
 /* Helper function to set both the VMG range and its anon_vma. */
 static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long start,
-				   unsigned long end, pgoff_t pgoff, vm_flags_t flags,
+				   unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
 				   struct anon_vma *anon_vma)
 {
-	vmg_set_range(vmg, start, end, pgoff, flags);
+	vmg_set_range(vmg, start, end, pgoff, vm_flags);
 	vmg->anon_vma = anon_vma;
 }
 
@@ -211,12 +211,12 @@ static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long s
 static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
 						struct vma_merge_struct *vmg,
 						unsigned long start, unsigned long end,
-						pgoff_t pgoff, vm_flags_t flags,
+						pgoff_t pgoff, vm_flags_t vm_flags,
 						bool *was_merged)
 {
 	struct vm_area_struct *merged;
 
-	vmg_set_range(vmg, start, end, pgoff, flags);
+	vmg_set_range(vmg, start, end, pgoff, vm_flags);
 
 	merged = merge_new(vmg);
 	if (merged) {
@@ -229,7 +229,7 @@ static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
 
 	ASSERT_EQ(vmg->state, VMA_MERGE_NOMERGE);
 
-	return alloc_and_link_vma(mm, start, end, pgoff, flags);
+	return alloc_and_link_vma(mm, start, end, pgoff, vm_flags);
 }
 
 /*
@@ -301,17 +301,17 @@ static void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
 static bool test_simple_merge(void)
 {
 	struct vm_area_struct *vma;
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
-	struct vm_area_struct *vma_left = alloc_vma(&mm, 0, 0x1000, 0, flags);
-	struct vm_area_struct *vma_right = alloc_vma(&mm, 0x2000, 0x3000, 2, flags);
+	struct vm_area_struct *vma_left = alloc_vma(&mm, 0, 0x1000, 0, vm_flags);
+	struct vm_area_struct *vma_right = alloc_vma(&mm, 0x2000, 0x3000, 2, vm_flags);
 	VMA_ITERATOR(vmi, &mm, 0x1000);
 	struct vma_merge_struct vmg = {
 		.mm = &mm,
 		.vmi = &vmi,
 		.start = 0x1000,
 		.end = 0x2000,
-		.flags = flags,
+		.vm_flags = vm_flags,
 		.pgoff = 1,
 	};
 
@@ -324,7 +324,7 @@ static bool test_simple_merge(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
-	ASSERT_EQ(vma->vm_flags, flags);
+	ASSERT_EQ(vma->vm_flags, vm_flags);
 
 	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
@@ -335,9 +335,9 @@ static bool test_simple_merge(void)
 static bool test_simple_modify(void)
 {
 	struct vm_area_struct *vma;
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
-	struct vm_area_struct *init_vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
+	struct vm_area_struct *init_vma = alloc_vma(&mm, 0, 0x3000, 0, vm_flags);
 	VMA_ITERATOR(vmi, &mm, 0x1000);
 
 	ASSERT_FALSE(attach_vma(&mm, init_vma));
@@ -394,9 +394,9 @@ static bool test_simple_modify(void)
 
 static bool test_simple_expand(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
-	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x1000, 0, flags);
+	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x1000, 0, vm_flags);
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vma_merge_struct vmg = {
 		.vmi = &vmi,
@@ -422,9 +422,9 @@ static bool test_simple_expand(void)
 
 static bool test_simple_shrink(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
-	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
+	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x3000, 0, vm_flags);
 	VMA_ITERATOR(vmi, &mm, 0);
 
 	ASSERT_FALSE(attach_vma(&mm, vma));
@@ -443,7 +443,7 @@ static bool test_simple_shrink(void)
 
 static bool test_merge_new(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vma_merge_struct vmg = {
@@ -473,18 +473,18 @@ static bool test_merge_new(void)
 	 * 0123456789abc
 	 * AA B       CC
 	 */
-	vma_a = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
+	vma_a = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
 	ASSERT_NE(vma_a, NULL);
 	/* We give each VMA a single avc so we can test anon_vma duplication. */
 	INIT_LIST_HEAD(&vma_a->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_a.same_vma, &vma_a->anon_vma_chain);
 
-	vma_b = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, flags);
+	vma_b = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vm_flags);
 	ASSERT_NE(vma_b, NULL);
 	INIT_LIST_HEAD(&vma_b->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_b.same_vma, &vma_b->anon_vma_chain);
 
-	vma_c = alloc_and_link_vma(&mm, 0xb000, 0xc000, 0xb, flags);
+	vma_c = alloc_and_link_vma(&mm, 0xb000, 0xc000, 0xb, vm_flags);
 	ASSERT_NE(vma_c, NULL);
 	INIT_LIST_HEAD(&vma_c->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_c.same_vma, &vma_c->anon_vma_chain);
@@ -495,7 +495,7 @@ static bool test_merge_new(void)
 	 * 0123456789abc
 	 * AA B   **  CC
 	 */
-	vma_d = try_merge_new_vma(&mm, &vmg, 0x7000, 0x9000, 7, flags, &merged);
+	vma_d = try_merge_new_vma(&mm, &vmg, 0x7000, 0x9000, 7, vm_flags, &merged);
 	ASSERT_NE(vma_d, NULL);
 	INIT_LIST_HEAD(&vma_d->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_d.same_vma, &vma_d->anon_vma_chain);
@@ -510,7 +510,7 @@ static bool test_merge_new(void)
 	 */
 	vma_a->vm_ops = &vm_ops; /* This should have no impact. */
 	vma_b->anon_vma = &dummy_anon_vma;
-	vma = try_merge_new_vma(&mm, &vmg, 0x2000, 0x3000, 2, flags, &merged);
+	vma = try_merge_new_vma(&mm, &vmg, 0x2000, 0x3000, 2, vm_flags, &merged);
 	ASSERT_EQ(vma, vma_a);
 	/* Merge with A, delete B. */
 	ASSERT_TRUE(merged);
@@ -527,7 +527,7 @@ static bool test_merge_new(void)
 	 * 0123456789abc
 	 * AAAA*  DD  CC
 	 */
-	vma = try_merge_new_vma(&mm, &vmg, 0x4000, 0x5000, 4, flags, &merged);
+	vma = try_merge_new_vma(&mm, &vmg, 0x4000, 0x5000, 4, vm_flags, &merged);
 	ASSERT_EQ(vma, vma_a);
 	/* Extend A. */
 	ASSERT_TRUE(merged);
@@ -546,7 +546,7 @@ static bool test_merge_new(void)
 	 */
 	vma_d->anon_vma = &dummy_anon_vma;
 	vma_d->vm_ops = &vm_ops; /* This should have no impact. */
-	vma = try_merge_new_vma(&mm, &vmg, 0x6000, 0x7000, 6, flags, &merged);
+	vma = try_merge_new_vma(&mm, &vmg, 0x6000, 0x7000, 6, vm_flags, &merged);
 	ASSERT_EQ(vma, vma_d);
 	/* Prepend. */
 	ASSERT_TRUE(merged);
@@ -564,7 +564,7 @@ static bool test_merge_new(void)
 	 * AAAAA*DDD  CC
 	 */
 	vma_d->vm_ops = NULL; /* This would otherwise degrade the merge. */
-	vma = try_merge_new_vma(&mm, &vmg, 0x5000, 0x6000, 5, flags, &merged);
+	vma = try_merge_new_vma(&mm, &vmg, 0x5000, 0x6000, 5, vm_flags, &merged);
 	ASSERT_EQ(vma, vma_a);
 	/* Merge with A, delete D. */
 	ASSERT_TRUE(merged);
@@ -582,7 +582,7 @@ static bool test_merge_new(void)
 	 * AAAAAAAAA *CC
 	 */
 	vma_c->anon_vma = &dummy_anon_vma;
-	vma = try_merge_new_vma(&mm, &vmg, 0xa000, 0xb000, 0xa, flags, &merged);
+	vma = try_merge_new_vma(&mm, &vmg, 0xa000, 0xb000, 0xa, vm_flags, &merged);
 	ASSERT_EQ(vma, vma_c);
 	/* Prepend C. */
 	ASSERT_TRUE(merged);
@@ -599,7 +599,7 @@ static bool test_merge_new(void)
 	 * 0123456789abc
 	 * AAAAAAAAA*CCC
 	 */
-	vma = try_merge_new_vma(&mm, &vmg, 0x9000, 0xa000, 0x9, flags, &merged);
+	vma = try_merge_new_vma(&mm, &vmg, 0x9000, 0xa000, 0x9, vm_flags, &merged);
 	ASSERT_EQ(vma, vma_a);
 	/* Extend A and delete C. */
 	ASSERT_TRUE(merged);
@@ -639,7 +639,7 @@ static bool test_merge_new(void)
 
 static bool test_vma_merge_special_flags(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vma_merge_struct vmg = {
@@ -661,7 +661,7 @@ static bool test_vma_merge_special_flags(void)
 	 * 01234
 	 * AAA
 	 */
-	vma_left = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_left = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
 	ASSERT_NE(vma_left, NULL);
 
 	/* 1. Set up new VMA with special flag that would otherwise merge. */
@@ -672,12 +672,12 @@ static bool test_vma_merge_special_flags(void)
 	 *
 	 * This should merge if not for the VM_SPECIAL flag.
 	 */
-	vmg_set_range(&vmg, 0x3000, 0x4000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x4000, 3, vm_flags);
 	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
 		vm_flags_t special_flag = special_flags[i];
 
-		vma_left->__vm_flags = flags | special_flag;
-		vmg.flags = flags | special_flag;
+		vma_left->__vm_flags = vm_flags | special_flag;
+		vmg.vm_flags = vm_flags | special_flag;
 		vma = merge_new(&vmg);
 		ASSERT_EQ(vma, NULL);
 		ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
@@ -691,15 +691,15 @@ static bool test_vma_merge_special_flags(void)
 	 *
 	 * Create a VMA to modify.
 	 */
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vm_flags);
 	ASSERT_NE(vma, NULL);
 	vmg.middle = vma;
 
 	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
 		vm_flags_t special_flag = special_flags[i];
 
-		vma_left->__vm_flags = flags | special_flag;
-		vmg.flags = flags | special_flag;
+		vma_left->__vm_flags = vm_flags | special_flag;
+		vmg.vm_flags = vm_flags | special_flag;
 		vma = merge_existing(&vmg);
 		ASSERT_EQ(vma, NULL);
 		ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
@@ -711,7 +711,7 @@ static bool test_vma_merge_special_flags(void)
 
 static bool test_vma_merge_with_close(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vma_merge_struct vmg = {
@@ -791,11 +791,11 @@ static bool test_vma_merge_with_close(void)
 	 * PPPPPPNNN
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, vm_flags);
 	vma_next->vm_ops = &vm_ops;
 
-	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, vm_flags);
 	ASSERT_EQ(merge_new(&vmg), vma_prev);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
@@ -816,11 +816,11 @@ static bool test_vma_merge_with_close(void)
 	 * proceed.
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
 	vma->vm_ops = &vm_ops;
 
-	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, vm_flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
 
@@ -844,11 +844,11 @@ static bool test_vma_merge_with_close(void)
 	 * proceed.
 	 */
 
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, vm_flags);
 	vma->vm_ops = &vm_ops;
 
-	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, vm_flags);
 	vmg.middle = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
 	/*
@@ -872,12 +872,12 @@ static bool test_vma_merge_with_close(void)
 	 * PPPVVNNNN
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, vm_flags);
 	vma->vm_ops = &vm_ops;
 
-	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, vm_flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
 
@@ -898,12 +898,12 @@ static bool test_vma_merge_with_close(void)
 	 * PPPPPNNNN
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, vm_flags);
 	vma_next->vm_ops = &vm_ops;
 
-	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, vm_flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
 
@@ -920,15 +920,15 @@ static bool test_vma_merge_with_close(void)
 
 static bool test_vma_merge_new_with_close(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vma_merge_struct vmg = {
 		.mm = &mm,
 		.vmi = &vmi,
 	};
-	struct vm_area_struct *vma_prev = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
-	struct vm_area_struct *vma_next = alloc_and_link_vma(&mm, 0x5000, 0x7000, 5, flags);
+	struct vm_area_struct *vma_prev = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
+	struct vm_area_struct *vma_next = alloc_and_link_vma(&mm, 0x5000, 0x7000, 5, vm_flags);
 	const struct vm_operations_struct vm_ops = {
 		.close = dummy_close,
 	};
@@ -958,7 +958,7 @@ static bool test_vma_merge_new_with_close(void)
 	vma_prev->vm_ops = &vm_ops;
 	vma_next->vm_ops = &vm_ops;
 
-	vmg_set_range(&vmg, 0x2000, 0x5000, 2, flags);
+	vmg_set_range(&vmg, 0x2000, 0x5000, 2, vm_flags);
 	vma = merge_new(&vmg);
 	ASSERT_NE(vma, NULL);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
@@ -975,7 +975,7 @@ static bool test_vma_merge_new_with_close(void)
 
 static bool test_merge_existing(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vm_area_struct *vma, *vma_prev, *vma_next;
@@ -998,11 +998,11 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 *   VNNNNNN
 	 */
-	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
+	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
-	vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, flags, &dummy_anon_vma);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, vm_flags, &dummy_anon_vma);
 	vmg.middle = vma;
 	vmg.prev = vma;
 	vma_set_dummy_anon_vma(vma, &avc);
@@ -1032,10 +1032,10 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 *   NNNNNNN
 	 */
-	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
+	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
-	vmg_set_range_anon_vma(&vmg, 0x2000, 0x6000, 2, flags, &dummy_anon_vma);
+	vmg_set_range_anon_vma(&vmg, 0x2000, 0x6000, 2, vm_flags, &dummy_anon_vma);
 	vmg.middle = vma;
 	vma_set_dummy_anon_vma(vma, &avc);
 	ASSERT_EQ(merge_existing(&vmg), vma_next);
@@ -1060,11 +1060,11 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPV
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
-	vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, flags, &dummy_anon_vma);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, vm_flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
 	vma_set_dummy_anon_vma(vma, &avc);
@@ -1094,10 +1094,10 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPP
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
-	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, flags, &dummy_anon_vma);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
 	vma_set_dummy_anon_vma(vma, &avc);
@@ -1123,11 +1123,11 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPPPPP
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
-	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, flags, &dummy_anon_vma);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, vm_flags);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
 	vma_set_dummy_anon_vma(vma, &avc);
@@ -1158,41 +1158,41 @@ static bool test_merge_existing(void)
 	 * PPPVVVVVNNN
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, vm_flags);
 
-	vmg_set_range(&vmg, 0x4000, 0x5000, 4, flags);
+	vmg_set_range(&vmg, 0x4000, 0x5000, 4, vm_flags);
 	vmg.prev = vma;
 	vmg.middle = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
 	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
-	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
+	vmg_set_range(&vmg, 0x5000, 0x6000, 5, vm_flags);
 	vmg.prev = vma;
 	vmg.middle = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
 	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
-	vmg_set_range(&vmg, 0x6000, 0x7000, 6, flags);
+	vmg_set_range(&vmg, 0x6000, 0x7000, 6, vm_flags);
 	vmg.prev = vma;
 	vmg.middle = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
 	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
-	vmg_set_range(&vmg, 0x4000, 0x7000, 4, flags);
+	vmg_set_range(&vmg, 0x4000, 0x7000, 4, vm_flags);
 	vmg.prev = vma;
 	vmg.middle = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
 	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
-	vmg_set_range(&vmg, 0x4000, 0x6000, 4, flags);
+	vmg_set_range(&vmg, 0x4000, 0x6000, 4, vm_flags);
 	vmg.prev = vma;
 	vmg.middle = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
 	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
-	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
+	vmg_set_range(&vmg, 0x5000, 0x6000, 5, vm_flags);
 	vmg.prev = vma;
 	vmg.middle = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
@@ -1205,7 +1205,7 @@ static bool test_merge_existing(void)
 
 static bool test_anon_vma_non_mergeable(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vm_area_struct *vma, *vma_prev, *vma_next;
@@ -1229,9 +1229,9 @@ static bool test_anon_vma_non_mergeable(void)
 	 * 0123456789
 	 * PPPPPPPNNN
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, vm_flags);
 
 	/*
 	 * Give both prev and next single anon_vma_chain fields, so they will
@@ -1239,7 +1239,7 @@ static bool test_anon_vma_non_mergeable(void)
 	 *
 	 * However, when prev is compared to next, the merge should fail.
 	 */
-	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, flags, NULL);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, NULL);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
 	vma_set_dummy_anon_vma(vma_prev, &dummy_anon_vma_chain_1);
@@ -1267,10 +1267,10 @@ static bool test_anon_vma_non_mergeable(void)
 	 * 0123456789
 	 * PPPPPPPNNN
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, vm_flags);
 
-	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, flags, NULL);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, NULL);
 	vmg.prev = vma_prev;
 	vma_set_dummy_anon_vma(vma_prev, &dummy_anon_vma_chain_1);
 	__vma_set_dummy_anon_vma(vma_next, &dummy_anon_vma_chain_2, &dummy_anon_vma_2);
@@ -1292,7 +1292,7 @@ static bool test_anon_vma_non_mergeable(void)
 
 static bool test_dup_anon_vma(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vma_merge_struct vmg = {
@@ -1313,11 +1313,11 @@ static bool test_dup_anon_vma(void)
 	 * This covers new VMA merging, as these operations amount to a VMA
 	 * expand.
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
 	vma_next->anon_vma = &dummy_anon_vma;
 
-	vmg_set_range(&vmg, 0, 0x5000, 0, flags);
+	vmg_set_range(&vmg, 0, 0x5000, 0, vm_flags);
 	vmg.target = vma_prev;
 	vmg.next = vma_next;
 
@@ -1339,16 +1339,16 @@ static bool test_dup_anon_vma(void)
 	 *  extend   delete  delete
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, vm_flags);
 
 	/* Initialise avc so mergeability check passes. */
 	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain.same_vma, &vma_next->anon_vma_chain);
 
 	vma_next->anon_vma = &dummy_anon_vma;
-	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, vm_flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
 
@@ -1372,12 +1372,12 @@ static bool test_dup_anon_vma(void)
 	 *  extend   delete  delete
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, vm_flags);
 	vmg.anon_vma = &dummy_anon_vma;
 	vma_set_dummy_anon_vma(vma, &dummy_anon_vma_chain);
-	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, vm_flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
 
@@ -1401,11 +1401,11 @@ static bool test_dup_anon_vma(void)
 	 *  extend shrink/delete
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, vm_flags);
 
 	vma_set_dummy_anon_vma(vma, &dummy_anon_vma_chain);
-	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, vm_flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
 
@@ -1429,11 +1429,11 @@ static bool test_dup_anon_vma(void)
 	 * shrink/delete extend
 	 */
 
-	vma = alloc_and_link_vma(&mm, 0, 0x5000, 0, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
+	vma = alloc_and_link_vma(&mm, 0, 0x5000, 0, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, vm_flags);
 
 	vma_set_dummy_anon_vma(vma, &dummy_anon_vma_chain);
-	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, vm_flags);
 	vmg.prev = vma;
 	vmg.middle = vma;
 
@@ -1452,7 +1452,7 @@ static bool test_dup_anon_vma(void)
 
 static bool test_vmi_prealloc_fail(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vma_merge_struct vmg = {
@@ -1468,11 +1468,11 @@ static bool test_vmi_prealloc_fail(void)
 	 * the duplicated anon_vma is unlinked.
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
 	vma->anon_vma = &dummy_anon_vma;
 
-	vmg_set_range_anon_vma(&vmg, 0x3000, 0x5000, 3, flags, &dummy_anon_vma);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x5000, 3, vm_flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
 	vma_set_dummy_anon_vma(vma, &avc);
@@ -1496,11 +1496,11 @@ static bool test_vmi_prealloc_fail(void)
 	 * performed in this case too.
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
 	vma->anon_vma = &dummy_anon_vma;
 
-	vmg_set_range(&vmg, 0, 0x5000, 3, flags);
+	vmg_set_range(&vmg, 0, 0x5000, 3, vm_flags);
 	vmg.target = vma_prev;
 	vmg.next = vma;
 
@@ -1518,13 +1518,13 @@ static bool test_vmi_prealloc_fail(void)
 
 static bool test_merge_extend(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0x1000);
 	struct vm_area_struct *vma;
 
-	vma = alloc_and_link_vma(&mm, 0, 0x1000, 0, flags);
-	alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, flags);
+	vma = alloc_and_link_vma(&mm, 0, 0x1000, 0, vm_flags);
+	alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vm_flags);
 
 	/*
 	 * Extend a VMA into the gap between itself and the following VMA.
@@ -1548,7 +1548,7 @@ static bool test_merge_extend(void)
 
 static bool test_copy_vma(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	bool need_locks = false;
 	bool relocate_anon = false;
@@ -1557,7 +1557,7 @@ static bool test_copy_vma(void)
 
 	/* Move backwards and do not merge. */
 
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
 	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks, &relocate_anon);
 	ASSERT_NE(vma_new, vma);
 	ASSERT_EQ(vma_new->vm_start, 0);
@@ -1569,8 +1569,8 @@ static bool test_copy_vma(void)
 
 	/* Move a VMA into position next to another and merge the two. */
 
-	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, flags);
+	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vm_flags);
 	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks, &relocate_anon);
 	vma_assert_attached(vma_new);
 
@@ -1582,11 +1582,11 @@ static bool test_copy_vma(void)
 
 static bool test_expand_only_mode(void)
 {
-	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vm_area_struct *vma_prev, *vma;
-	VMG_STATE(vmg, &mm, &vmi, 0x5000, 0x9000, flags, 5);
+	VMG_STATE(vmg, &mm, &vmi, 0x5000, 0x9000, vm_flags, 5);
 
 	/*
 	 * Place a VMA prior to the one we're expanding so we assert that we do
@@ -1594,14 +1594,14 @@ static bool test_expand_only_mode(void)
 	 * have, through the use of the just_expand flag, indicated we do not
 	 * need to do so.
 	 */
-	alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
+	alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
 
 	/*
 	 * We will be positioned at the prev VMA, but looking to expand to
 	 * 0x9000.
 	 */
 	vma_iter_set(&vmi, 0x3000);
-	vma_prev = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
 	vmg.prev = vma_prev;
 	vmg.just_expand = true;
 
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 4e3a2f1ac09e..7919d7141537 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1089,7 +1089,7 @@ static inline bool mpol_equal(struct mempolicy *, struct mempolicy *)
 }
 
 static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
-			  unsigned long vm_flags)
+			  vm_flags_t vm_flags)
 {
 	(void)vma;
 	(void)vm_flags;
@@ -1205,7 +1205,7 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
 /* Update vma->vm_page_prot to reflect vma->vm_flags. */
 static inline void vma_set_page_prot(struct vm_area_struct *vma)
 {
-	unsigned long vm_flags = vma->vm_flags;
+	vm_flags_t vm_flags = vma->vm_flags;
 	pgprot_t vm_page_prot;
 
 	/* testing: we inline vm_pgprot_modify() to avoid clash with vma.h. */
@@ -1285,12 +1285,12 @@ static inline bool capable(int cap)
 	return true;
 }
 
-static inline bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
+static inline bool mlock_future_ok(struct mm_struct *mm, vm_flags_t vm_flags,
 			unsigned long bytes)
 {
 	unsigned long locked_pages, limit_pages;
 
-	if (!(flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
+	if (!(vm_flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
 		return true;
 
 	locked_pages = bytes >> PAGE_SHIFT;
-- 
2.49.0


