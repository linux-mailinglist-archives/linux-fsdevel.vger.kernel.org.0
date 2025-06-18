Return-Path: <linux-fsdevel+bounces-52108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 443A3ADF712
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878D01BC0D72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF4D219301;
	Wed, 18 Jun 2025 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FY+T1DN7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P0byQP8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C691E1FF1B4;
	Wed, 18 Jun 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275925; cv=fail; b=JOfe3D13Pln/S0pc0JtDcusWNjqhcZvcGjf72OjrIXOFYB70sSpBnjOOH9xOVvhZhToyewfqYUZuHdtTU8S4my6/ayTuy1DoaU1VCyGxVXgN3nax489GBu0cyJBwQbhzbA/mHqu5CtHGpvZO1yFAXMxhlIq/0lLC4Hz765y1O+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275925; c=relaxed/simple;
	bh=BjV1zEkb8LClkZfkZOHnGw96LNE5ByPJy2HcRLiPrDE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MBE+fddshfWLniiMnY75FjoVQ4GK4bHpgxW+If8BvjgivWIflOSMMs8+NQkdxpRPsq5WuBvn5CNV9mFsiryeNm5JoTpQpNTWGvSiDy4DJt/+N0/aAb5SQeA638AxjxeFqwFBmy8WtCC/KAfBYuo2cJU3/XdnM0FFrMKDtbBucgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FY+T1DN7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P0byQP8H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IHgleH006749;
	Wed, 18 Jun 2025 19:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=yrg87gczH0XgXBRm
	PVoml8JCGG20MCa48kFEiejCuXU=; b=FY+T1DN76zKGuIA9WrNfSjAur63HVThH
	XsF75iiF85dIMiIESLHl8ffBib1/c/RyxKIdI7H8Gw9p5M4bjbsJQY6xLChqYYY+
	Pv2/zSIm4oVDXHkfOJCHsWmZVJuqrwmgHe8imirZU747XnQvyTJOcb0NQcmhBSm5
	Rg6vcMPFYfThZOFNI2Rx8vVnghpw0gP2vesSmsR5W0EHSren4LXTcWc8L2LVQvK+
	flQ0oVn6hdK3uVNIOQGAfo1FLpueVsFRqsmitREtTOIGHhTxequeVlP7oKOzS9Qf
	aVU2fAP6jWx0Ud8hA3E8IMXBfOm9CyakNcgbl8xMNne/U159E2Tc8g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd8hyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 19:43:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55IHxTWh035207;
	Wed, 18 Jun 2025 19:43:20 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhau6qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 19:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVWcx/Egy9zyWA+8ddNlfJoL+TE/BE3w/245ruf+4PiXMVgfkDyb/3wTAmOZqTJwUjgoIX+qOaV4bMqkkVI/rs3uPLcd9WyOTlFE9WauPSiTsGprcSz8GtlLZeoiW7UV7WK8uhV41UHxSPyyGA19t6i7yE0bD1mxFD/y9bEe9L5sfDI0TDCiPQ/kfX8S7l9vKEBFQ9vyRjJ2Wa9M3noyRyAe9PYRKePn3NAtzuL9esW58GHqkX7Lu3/QXk3gyN7gAkCnQZqFaSCWXhOV2lySY+3XBObPsaNIac9ySREitKz8Yv+iU3f2EE7ibAfLl5CLE8NIb85BEkKNr+7LqeJ2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrg87gczH0XgXBRmPVoml8JCGG20MCa48kFEiejCuXU=;
 b=SWklYj3a1h2QR/WnxlTQBMdrELRYL6i+RriOSHrnwveT+Y8mspfzByYFxxHwejrgHYCZlDnk053d0CXZlFJRyWNYxuuYAQ45QU2dpxfon2tS1N5eAZphSBQ8W2oTdXTSbuOAkMcxC4ggpXnP8jEhD0A3yUmRs2tPwZWCeCaOiDfXr7o3IVsA0R6dlFWH24by39pXyarQWwjataIG3eF16g+LlpjohJmCWQd1jaw1UKO2WaKR8seLkxa2dDBBMyY8f3SZo/H/NjcTPemBI1rI5w+D7Hikfcj+6zs5dlHqrewuDuUd0VqscewKW+Kqmv5M6DJ7gzL+XAhzYQg1ZZufEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrg87gczH0XgXBRmPVoml8JCGG20MCa48kFEiejCuXU=;
 b=P0byQP8Hm7UAaczaJkYGaGgTm9c8a+f8Mz3aS07StkRvHOPz2J7gf/9iZq4oyjWUzAsMv0fiT6A6L8oiIZFVocG+uKDBdHq3+cZcZXhDvA1bPyTKH1zpWI7ld6z+LkftF7AVogEzZ4rUqwzfyh693cqhy+vaB1+3J6XSCd4ctzU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6717.namprd10.prod.outlook.com (2603:10b6:8:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 19:43:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 19:43:14 +0000
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
Subject: [PATCH 0/3] use vm_flags_t consistently
Date: Wed, 18 Jun 2025 20:42:51 +0100
Message-ID: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0668.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c2def5-dc5b-479b-e208-08ddaea05d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?diq+n8GJFnctf++hYFbgXaWF75xJQf4qp/hdz+bzN38YOmS+sn2Yp+81gyH+?=
 =?us-ascii?Q?t15as7T15q5saoQ/Rok8RppA3JuZHZcVCcyXN8AcYYWdi6G9PDYuBOmMiknn?=
 =?us-ascii?Q?XKlgl0jYyaHQw4jAiWxm78nNe9CP4qqh8S3vnPFwZqL7gdjuCL9uNJtpQx3T?=
 =?us-ascii?Q?DyW4RiyOVTWwlZ4j0hA9kNDHF8SFZg6FIeluln3sTC4tS2FLeCLvr+nkvBpF?=
 =?us-ascii?Q?qHbf9bcyMcdx7oCv6CixIXL2ao4gNUJtuFioMu5NGf9I3GUYwrQMeK9iAGP/?=
 =?us-ascii?Q?OojGHX5COIKvyhD60CIM3co5dMaqD4vWJSAT0G22aHnI+qV3EPaHGqm9nltw?=
 =?us-ascii?Q?vXgm0SFh+a2LwKp4hOqV4MEuBLLXMC3IxLwR+lcr+LmaZ1dXEY3+ovDIoE6X?=
 =?us-ascii?Q?sCwA0DnovAuc6hrQCPMONL0jLnbAu17tlmdPt4tTn75iO2/bkNJMD/5RpFfU?=
 =?us-ascii?Q?836cRWk1VOZoHbqPnRzQOX/WFNNN1b70g0e+AMokv6UNLNN0fbhC4YOg+QsX?=
 =?us-ascii?Q?6v+QX7UqgXEqqxD6Du069AzdzBUHDBdKo6T9TfFjwkEV9dYbZfI9HCw505o1?=
 =?us-ascii?Q?u+siddh/raO/ziCVIzROTHmD+Lu1uPO6fIAefJawDeTrrpBQrN3N2Z32NXnO?=
 =?us-ascii?Q?KoHGgnmpJzt8IoxBv19ntTcWhc9Xp2ZaEKCkaRDaE0j7ffv1Ke4VUPGCi0Vg?=
 =?us-ascii?Q?cTgHItQqNUY3VJGbM/sTuRJqndnmR1jaJG6vRnBaTkWu9dnDmljFgiGJEuE/?=
 =?us-ascii?Q?BhMbztxIaiUpLLpMEFq6RC46GLgK/EHEk8zZQgCJC7tVjeuR+LzMfdGFJ+HP?=
 =?us-ascii?Q?b6UexUeZ/VIAM2In0bqDnWRWw/i3haSo1mLJe7+CUv/iwqrNCahOSNaPNCDJ?=
 =?us-ascii?Q?Fi572BVwwMuqlkQrXFO4kRniMfZFY/eOzPV7P0gZTbrtEL0v+77+NNATwP3w?=
 =?us-ascii?Q?gOIsUm3JjESwcKZhyi3TSTAiZLbQWH0Onv5kAz6QNa1gQ75olDIvsMnXUbVx?=
 =?us-ascii?Q?PmMIls+2yiaynxeqaomy69d3zwYkI/iOONv5YFE0l9EIzXl8rzF6cBHYlZ70?=
 =?us-ascii?Q?WFUnQVLGns+ycHoJIuIbuDC9U9mOca+jtvmIq/R4ARSNTsWGqxvqWd29wsMe?=
 =?us-ascii?Q?VtEzehuTaXE2jxsLtr23bOuJjIXb168fbhbE5U4uqH13LmpoGzNMo5BrYIS6?=
 =?us-ascii?Q?1K3axbs5LKkdrNoxk7jaWORRSlsxggEDLdnNwBm9P8zx1lJBf9UEr53JikIZ?=
 =?us-ascii?Q?D1+mPv/TLgqF5+awLD7bc4sdMCm/nXh+S9Sh9MdCvTS2soGriHRx745kAJWR?=
 =?us-ascii?Q?NHkrWWd2NAtybgPa6Qv+febmpx6EKmhLatKJQ4xuGX8iELY3l7z6TPS0RMHn?=
 =?us-ascii?Q?4l9egvkCjY/QpmfSSwWpn6pKuf/EYUrxy6UKjIVyTHfXBkEcGINm7tZcrV5O?=
 =?us-ascii?Q?wqOAMcF6Wlg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qkNL9VtHswPdC3wPE4Yt89Tfkig3brXJO6R2lHzGbywKr6O+oxMBGF0djHH8?=
 =?us-ascii?Q?WesxSSX4j56XpkWNpdT4Zm/r4r6xAdxTxPXWSvluX4cl3OjoWmAKYZP2+Ehu?=
 =?us-ascii?Q?rIgruDQiprhoUiLF73WduVQSeyqIMrjcH9j8poYa9wjdyhUDZJby35VBeAoC?=
 =?us-ascii?Q?sXRP/d2y2hWoMT4nbLaQwQQQASSMcUfSDY62KzVBZIO08EIvrCFLRX+CNj3K?=
 =?us-ascii?Q?VjMa+SomzfxojACYngPspJ4Ouv7CifG/eoV3p8OkpSVfwD8ZAKncUyLFpIV5?=
 =?us-ascii?Q?0tkNREIh1qyxjOq1g+4fH3rROQ6XQUQcsxqN6TN1JAzWSY8aQt+dcBbAVnob?=
 =?us-ascii?Q?IdNz3pnq63OiWSl/5DtsYc6qAcDIm/UtmE/cM8aRC2pUnXny6cjt74MVbdsE?=
 =?us-ascii?Q?y7I55d5fIbXzY5xD5LkSAUJAzpfJ/ivSaaGnE1eKkbnAQy8ihbEAmo3xFSLQ?=
 =?us-ascii?Q?XO0UCZo/iQldJN2mGEuMti95IeTeuv8oLg8uw6lLHp5HVThqbkYuwKPSYY0n?=
 =?us-ascii?Q?ahwRgNGFUisses6O8vI9tE+3rDIWUPG3oRjBuddSBvw3IxOLAdojlUCVDf0I?=
 =?us-ascii?Q?20BlJvW78jR1nVe/WhlrsRhmCVEOC4TQ72uAoxaoVT280GjspwUF86VQGdFc?=
 =?us-ascii?Q?/L+pHuYVcM5ed5uNKIX7HzA/6UA90XNW/iDKHBYyqd7ayH3SZltSz7Nf5sgs?=
 =?us-ascii?Q?NXWOkgFafK/N/eKbwy5pIKpLI4KdXYB+Alk1zGJZO6NxEpbypW1KyuIPxnlV?=
 =?us-ascii?Q?SJLF769Q2XFqx/mtyOmBJLbdkrrHwvBg50hFsAVElFENvBomJufBhCctxbK8?=
 =?us-ascii?Q?towhprmBbPwc/nvqudjUkxHGo1wZ1k1HcaO6EkvXy7Gr2kF9diIulfGT7+GY?=
 =?us-ascii?Q?aRCQCbZXkD0aGcO8dplziNJdi7EZ0CTs9JYH+fMW8n74mVLy0b/Fwf/iOVnW?=
 =?us-ascii?Q?bERDWQ4WJxYyHG9S50G0b3aziPb9Ro6B/V+R8jGitm9j2tafMoOwFFX2Hu3D?=
 =?us-ascii?Q?QzfUPBSCxgYic5oJ/okyY105k3d2iYAeoS6X4jTdzdUWY7BtscIeY119/0mz?=
 =?us-ascii?Q?EnRbxe2KYQlgPAYYQvZzcfD4tBAr4ffFYKLRppaWR5nLbsVIFIDevA/Pqf1P?=
 =?us-ascii?Q?yu3r6kkAwgtD/5BPPXRybXbt1qnpVslGupNuHpRCkFkIcX8gzvz7GAh4UfZ1?=
 =?us-ascii?Q?WmUzviMka4tWjGJKv8eW3ybB7f0Q6XDwDB+IvgpS3adsDULEGmIgJ8EMeJCh?=
 =?us-ascii?Q?0tugvDKvkeiKpxI5UXr5aKei9t0KRXOQ0ELWNeJj2ObomypaUT/09otkqXOU?=
 =?us-ascii?Q?fjPeXz9VTLjHVPGBuzJooyhhj8rbZZapKeY7QNvelWMbU7ykwQI+CPEopqsL?=
 =?us-ascii?Q?chaDiH1DVwIfyydsbATUq4Pyg7do2S/9klWPjcwUCPFw6sHmhIO69tNsJhYZ?=
 =?us-ascii?Q?prXmJgEDgLaHDoy/xvNygYv8eXif1o3NWrl3mDXi3AleXV3zA+t6aJ0rs6yu?=
 =?us-ascii?Q?4nC4f5McKQ4WVuGEb2LyVrK2L5TMtJ7zlPeAdE3I6lQBrvbUMEY1QLzkCY5n?=
 =?us-ascii?Q?Q3ZElUXv+dD2Ibr6ZDenodMnsqD8bPDN8KFb6FvcV4/Z/7Gq7zRNxDQLvWtj?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ywZ1HMpEYWrepWLr8n7M4Yf/EW8OPFG84C4ytXcbxwRso1erVnu9YEC/AOnPdieJ+cWhV8foW67I21owhQc1Ca8X+VM14Q+up5JcJVG0frFWJn6myrA71oznoWIlHh9fp4pcIeYryII9/YxovTTNdERZFMjAxW0QLwDeCMjKNpnzG4ULf0PVUHlalzTZU78XnhsLbyZOxo+le5JqBGp6j7NDVIcKtvoRM3Fq4SZg8x0dt+4xYIMGIbGvMn0Zww4fV7/H7+0nD8GcPoWb3vgrVdT+oMVkRNRjFkgRo7kBxQVzFQPoUmT+EIJ8wndnnWSsJb4AKq3xoWPcglFbhW0D8wXam+X2BjK0Jljq5thIypXT1vOdzhML+kJ8fsWs+M5LF8N9I8DIMIuBfg+lsR1KtV74t1sADA8mmfLDF0SktfnF2ywBsmCn6yXqW5e2q7uXM4i6AbhSo9B4HcYXQhX5kZ8m1xd8pgiEeCK48WZQ+eI4xrjMCaipvnJ57sS3Vslv7ybO0BBqkdD1DvLWQRpo74pClp9gZi3Jz3e2gHaOrU749fHBvkOZR3tThCYG23TNc10H/VLNiCyZX4TTTrCrk09oL6rWAztB8eGSWf50soM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c2def5-dc5b-479b-e208-08ddaea05d48
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 19:43:14.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WycuWVL7WaEDRmyRr9zxHm0KZPx9olQxjr2kOZwPYACydWxXQf0VsBaHjkuM1K5Vvng8XMIyghycUTb2mk9Qe5uGosRV5YMuFb/E7iXrBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180168
X-Proofpoint-GUID: DHm04YQjAbuX5l0aq7rx4nPKWBKms25a
X-Proofpoint-ORIG-GUID: DHm04YQjAbuX5l0aq7rx4nPKWBKms25a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE2OCBTYWx0ZWRfX+3+IwAzv2A0Q +XqtEeFAfaGWqjhsV1rew3PUUzT7CmUZdtGmG5HA/iREyyKJf6+hR2YWOd+OKMUUL9hXFAWcdGD 7ceZ1IqA4XzeohzVGGGkgiGAaVqSkLYc20ga8/PcjivTVK+LnTEA8Cwn2hdz+lKrCH5r/dhdHE1
 JTptK5OxbV/x4kHtZR0MlsscK6dtya9vznWj00D2Uio1pRa/p1PmANiKrkTKGY3vILMhA9jmy9U Yj7gsWpsSivVz2Isx1gZYPbWpfCZyytc9VVNnuFd9JtGnvWncJPaoSgjHu+HZp2icbNDBBE5yne XBv6sLx8PWthiEloDcCvnPhbNcLOiRwnP2J08RKZ9RU8UBqfItGEKuxu/VvylRwU2snj/xaWz9t
 ujShdpoMPjMUy4qdgRh0ebvo0UiDeOriU+1c9sfvqNYo4a1WixxK1o9I4YpWksL0w3Uz1Cgc
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=685316d9 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=4p3oXL0rtZZixOW6OUIA:9

The VMA flags field vma->vm_flags is of type vm_flags_t. Right now this is
exactly equivalent to unsigned long, but it should not be assumed to be.

Much code that references vma->vm_flags already correctly uses vm_flags_t,
but a fairly large chunk of code simply uses unsigned long and assumes that
the two are equivalent.

This series corrects that and has us use vm_flags_t consistently.

This series is motivated by the desire to, in a future series, adjust
vm_flags_t to be a u64 regardless of whether the kernel is 32-bit or 64-bit
in order to deal with the VMA flag exhaustion issue and avoid all the
various problems that arise from it (being unable to use certain features
in 32-bit, being unable to add new flags except for 64-bit, etc.)

This is therefore a critical first step towards that goal. At any rate,
using the correct type is of value regardless.

We additionally take the opportunity to refer to VMA flags as vm_flags
where possible to make clear what we're referring to.

Overall, this series does not introduce any functional change.

Lorenzo Stoakes (3):
  mm: change vm_get_page_prot() to accept vm_flags_t argument
  mm: update core kernel code to use vm_flags_t consistently
  mm: update architecture and driver code to use vm_flags_t

 arch/arm/mm/fault.c                        |   2 +-
 arch/arm64/include/asm/mman.h              |  10 +-
 arch/arm64/mm/fault.c                      |   2 +-
 arch/arm64/mm/mmap.c                       |   2 +-
 arch/arm64/mm/mmu.c                        |   2 +-
 arch/powerpc/include/asm/book3s/64/pkeys.h |   3 +-
 arch/powerpc/include/asm/mman.h            |   2 +-
 arch/powerpc/include/asm/pkeys.h           |   4 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c         |   2 +-
 arch/sparc/include/asm/mman.h              |   4 +-
 arch/sparc/mm/init_64.c                    |   2 +-
 arch/x86/kernel/cpu/sgx/encl.c             |   8 +-
 arch/x86/kernel/cpu/sgx/encl.h             |   2 +-
 arch/x86/mm/pgprot.c                       |   2 +-
 fs/exec.c                                  |   2 +-
 fs/userfaultfd.c                           |   2 +-
 include/linux/coredump.h                   |   2 +-
 include/linux/huge_mm.h                    |  12 +-
 include/linux/khugepaged.h                 |   4 +-
 include/linux/ksm.h                        |   4 +-
 include/linux/memfd.h                      |   4 +-
 include/linux/mm.h                         |  10 +-
 include/linux/mm_types.h                   |   2 +-
 include/linux/mman.h                       |   4 +-
 include/linux/pgtable.h                    |   2 +-
 include/linux/rmap.h                       |   4 +-
 include/linux/userfaultfd_k.h              |   4 +-
 include/trace/events/fs_dax.h              |   6 +-
 mm/debug.c                                 |   2 +-
 mm/execmem.c                               |   8 +-
 mm/filemap.c                               |   2 +-
 mm/gup.c                                   |   2 +-
 mm/huge_memory.c                           |   2 +-
 mm/hugetlb.c                               |   4 +-
 mm/internal.h                              |   4 +-
 mm/khugepaged.c                            |   4 +-
 mm/ksm.c                                   |   2 +-
 mm/madvise.c                               |   4 +-
 mm/mapping_dirty_helpers.c                 |   2 +-
 mm/memfd.c                                 |   8 +-
 mm/memory.c                                |   4 +-
 mm/mmap.c                                  |  16 +-
 mm/mprotect.c                              |   8 +-
 mm/mremap.c                                |   2 +-
 mm/nommu.c                                 |  12 +-
 mm/rmap.c                                  |   4 +-
 mm/shmem.c                                 |   6 +-
 mm/userfaultfd.c                           |  14 +-
 mm/vma.c                                   |  78 +++---
 mm/vma.h                                   |  16 +-
 mm/vmscan.c                                |   4 +-
 tools/testing/vma/vma.c                    | 266 ++++++++++-----------
 tools/testing/vma/vma_internal.h           |  12 +-
 53 files changed, 298 insertions(+), 297 deletions(-)

--
2.49.0

