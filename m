Return-Path: <linux-fsdevel+bounces-57550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662C1B22FE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F73685BAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770492FDC5B;
	Tue, 12 Aug 2025 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KJ7ZivsN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JJKtCVm8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A852F83CB;
	Tue, 12 Aug 2025 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020657; cv=fail; b=o5Gjkxm1MtXVWNN/I97iLU83AByxiQs/AoCCM/ODUZAUSf05IZEZWMgoCjnyQkIpHQvkJnoOAqEnvx1w3L66nF/M5hIODMRFztUOip6HbCZu3dcN7mN6UZva/vSIxPHw0K555pSdQeaYC2DcYM7T8GAzJtuugaRQjpcbKLGV+38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020657; c=relaxed/simple;
	bh=SlxiZ3HZgA7ShL7fS+sGEtEx7fEWzpugMBQVRM28O0U=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nTjZhpQxT/GwthZboeMgWP+rRt7j2TsNUGSKyCDMfg05wajEPVmqdxbfy8T5RoXQz3OpecCu/8oMZQE8dhiuFgw8BXOsCDTrCHpCfdvEwMAB8AzDDArFg5cXdi+E2zN3jAGO6OAlSQOx2VnO/jTipMNNAfnJtyerW7aF1/k16+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KJ7ZivsN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JJKtCVm8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBx9r007838;
	Tue, 12 Aug 2025 17:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ArIHj7KNHl3qyqveLl
	U1Ri+5epa40PlP1QC2D1MYhZs=; b=KJ7ZivsNv2vVpMSBYkz2SxMVjmxUpYu4Jg
	WMYPypSxad/R5HtXxTmtyMIAWcgxgZq/QtLZfLviSj0BuWcluGQHqG3Einwh/+Xp
	f63639GQbVa4xmL+MkppzMdLKGCvG7VIrbvuZ/WnIliAfLEIURlVJEvtL4wPims8
	QMmpvP0xnETUOqA7Qejk/XgAVu9E7WJ5iIDxfPBjKT+Vy3bjC/FmmjyEstRaWk8k
	bly4e4lx357HMaIJxrosvHJpNZSamBmpFSvvLEGrTqyLgT6QMLZOTL+kLGoZit/l
	/cmh0N4LOtr63PGOerx9HDKmb4gVnXf2hIMlhzw+BZUqultraBww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvww655-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:43:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CGIU6A009657;
	Tue, 12 Aug 2025 17:43:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgk9us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+CuVjuTbRtr9mtIGPeauGBp7tJ0Pv1ZkN/RvM6nyRanCQ9alXLjvU/SMM5vgrzSPfjIAYjNwmAicGt9QsZGthPoCk6IxxhOVhLr/D1Km3DUfWYK0r9Et/UdO0NcwRGN6c0tGZFhYRqEjAzAnICGuIu77LHpClqM5wR7tuQ6/Z8waNx1wy6YGTq82vcmsK9WTg0FG1/JANf84z/mqrQDNk1mVc+G3CfLUi+97BnwxhhbgcbcsFjOY3NpAIPyIdByDxaTFyylCrBVZPYpzdEc2iV3Bx/66RekF5mLhaK4/W3ltPckopO0g+nAvnoxLv99hADnBP1ToGbN5Dh+hjZTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArIHj7KNHl3qyqveLlU1Ri+5epa40PlP1QC2D1MYhZs=;
 b=JFgHMcGBnnl3Y8OlZdCmWFG6LDVQMxt4rQ2dsT/AC/q3wj5lAOdzOpIMtYwvfmah1+8vS6YlAkpPri7n+MgKI0ifvgI6nFdqGxLkTvXfI+6U5QLXTE6MPjyLsG9Xlskv+MJAs8LZ78zGxR9yc0O5as7s1Eg2N5+qOaSyRNH7ou2xpluUNJK939sTYpH5PzpoJSDYCQistL95QEEhPDnsMVCbU7shboLzs4KIk3s6nGGF+usVcBaLihq5rgYmumKTDU+xg1rJzTB6lssCHdKLLvL//KQN37OcrE03m8jrwlgeESkRcEBYCHakqCEa8gMRfvDI+hDR+v12rjlUQMg4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArIHj7KNHl3qyqveLlU1Ri+5epa40PlP1QC2D1MYhZs=;
 b=JJKtCVm8MSOYc7mvVtxSZYB2aziYMbpdAww/DjSc2rVVcTGVso1Kr3a9pA/CZp472Es5TfoVcyV18sCaT56aagZBKqB9ld4X0Tm4LcAoRWhbTTHTSSLdLc0G7a2SRSXUQt1EUzp8ragyjVPdeg545yMtBGqRD5STjUiWAkpWnNA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4810.namprd10.prod.outlook.com (2603:10b6:806:11c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 17:43:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 17:43:27 +0000
Date: Tue, 12 Aug 2025 18:43:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 10/10] mm: replace mm->flags with bitmap entirely and set
 to 64 bits
Message-ID: <15ffaac2-9e83-4f96-8e3a-2aaebb8bb227@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <e1f6654e016d36c43959764b01355736c5cbcdf8.1755012943.git.lorenzo.stoakes@oracle.com>
 <scl3mdbh3atwaky5ae7sh2gyru6nomx6pulnifnmbj6hd4ug2n@ykbzkzo7e3bt>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <scl3mdbh3atwaky5ae7sh2gyru6nomx6pulnifnmbj6hd4ug2n@ykbzkzo7e3bt>
X-ClientProxiedBy: GVZP280CA0097.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4810:EE_
X-MS-Office365-Filtering-Correlation-Id: e724b4f3-5ac2-41b4-c820-08ddd9c7be10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GB09iGf+uc5eGf/C9RXl2vjSDGPGwXAqjyjC4/wy4hTFmeHFkSu6OQ+TxMb+?=
 =?us-ascii?Q?khqOIZsY7F+k/7P/mcC+kcadJ/WH8cVF5hn/iPy44zR3yaFy0EeeFSRK6QgQ?=
 =?us-ascii?Q?yvhIVLpSwGheN2YNtpGSaukDnTB/0xpYe0VdiXDpY+iv789syGHWauuHzB0U?=
 =?us-ascii?Q?5ELV+qspT2dLKh8iYCVDJg/Wc+qPN8quD3offIwOgI8LsD+bqDaA5PbK2atk?=
 =?us-ascii?Q?PlkjlWE2g46WiNOj5fXkuOrSiQvOswV42G4OTHcOUM2WaPlGGfTqFpXfNadT?=
 =?us-ascii?Q?TujEx/WDmKIADXybnpmiVr/+GTeiw9+G7qy7ahl1b1SBEQjh/BoDbLvoxkiA?=
 =?us-ascii?Q?rAbyTDjdKPiaCuPpvsfusNz/LXhFdeW5/lHcfyBRM2jQ1POuCD/b9fJtEktu?=
 =?us-ascii?Q?WLDfq3snK2d+2srAnIuIsG45bjfIFluBtV0gvYSlfFudPaBgljsYgmIYbHgs?=
 =?us-ascii?Q?vIfyiPOVoa6JuXjPiT+72LkcNVl1FGTS3lR4VSLD+SL26BQ0L0jm4RyimfIL?=
 =?us-ascii?Q?cTq0TlnuVcwjPw34oBZiCSU6aLvE6v/kL2H1wQy/sqHYAxS5vfILMOcJFY2f?=
 =?us-ascii?Q?cz/2BCWYY7Nsp+L9K19SRt/zrZl0VXfXZajAMzZkuG/y0qK0Xqd/Yav3Yaz+?=
 =?us-ascii?Q?7FoXTKKgeRTcY1+kmKEv1AnkIT7aqsC03XekKy9TCQ4laoaDoUrtwH/VlnG7?=
 =?us-ascii?Q?YNNHUVPFSaVJOScSUJH5mGE+O26as0cvaPTFdEvJUtCrZ4fHLj+g2ATLUPyp?=
 =?us-ascii?Q?2fOjCUvGFPUEWI3wiLac9l3TZOmOPIshFW8RbjdA4/SIfOaII9NdHttiDuNy?=
 =?us-ascii?Q?9KfeBwk1TVej53RK7SoGkhsmtpve5aL2kObPuK5/Q8Fao1yP2Qd56ypNCf9g?=
 =?us-ascii?Q?2Hh65MwIsL2WJ8n+HWxRH+l1AR+ouM0JZ4LMiSg0JorK5tM31oPSMSvhK7q3?=
 =?us-ascii?Q?n9Dh98HM42mEP/1L31ls6ybJ2QdAFTYEz4OalwZFVp+y00bBf0bP3bX62ElY?=
 =?us-ascii?Q?YT/4E2KMsBA0PVUvSIsVbhftzXUYPl/O5S2RBQwhbhk42yZm+NSae2LrkPBm?=
 =?us-ascii?Q?SPfdg0H4FpjAgGOs6sZC/jBmnn6SWNpSs200n2KcpILu2POLpe0WQ3uQl5j3?=
 =?us-ascii?Q?VS7/1ipZpoT7qCw2Q0UhwGCbLe4VEFQPBJbDfn395xkiMHEmkXms+MDfOFn3?=
 =?us-ascii?Q?WUt7dMgjM1HGisIC1MXQcZTE0kX+D8belW9pBfQlFmBQjWi2i1yl9X3dW6mj?=
 =?us-ascii?Q?0RBIJ0G5Fw1qPU1YmB6fQFHURhOrv0c0qrYIeC38sd9eXXUZTGtYCn9Q1jjs?=
 =?us-ascii?Q?cvRSLQcwj7yPKMFdXu0Vp1Hlj4btfc7YHAEN5tmfhH7U7TPULT67kBT3eDQX?=
 =?us-ascii?Q?shJQf51Bn+n/gRl0XSBXfHLpPQkTlhOPfkCGGiuuK8I8TC7oxJBXNuL13WVm?=
 =?us-ascii?Q?o4svhXE0FB329RjGRCgH94YVxbYZtq0EGbyTc/8npXOn3HW2M8s9Xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kA0hXcfJsMa0z2gnWZn0SroBroloY6f32Ptg6O8H3sitV4uBvUSXtOdVZbX8?=
 =?us-ascii?Q?Vapix3y/blbZZ/LrxjNm2IA544ghcQxft4aHdWcUtt37dmS4dKp6c7TSKuDW?=
 =?us-ascii?Q?LysMnXJN2bW56bEQod84NWbhGUMui/eRJq0dNijlrVmr6IAKFXXTA8+zRUkX?=
 =?us-ascii?Q?toR93FALGFhUHueINhPeR1x6zY+Veqri94Skp4LhDXFhWP7+1U4pvSH7+bQS?=
 =?us-ascii?Q?3LkJ4lV0qAWdroOB27nLM8tzwnG7wRerLKyigMJzDxroWVw17MjRQlEotSWF?=
 =?us-ascii?Q?QaIFZxc2Itvotbc+8HNiYhLSPU/XJoIg7WrhQbPIoDMPPjeNU3kIaans6Ls9?=
 =?us-ascii?Q?Pu3M6VdZD+GSdkx5DdnkDPUTTQZ3dQWfI7iB7QYI9DZz2bC9JvQuoKU60vhB?=
 =?us-ascii?Q?LPwMfBPIuCgps4xyLkj61mhBhP5riz+XdRzGqfXY/8pYz/chN8BABkoB0Hh/?=
 =?us-ascii?Q?3ubc1cSBWgo7uvqiE/xE/YBEdX8Xw4b5JtKxBjwdqTjj8S24DnvpUa4tcizr?=
 =?us-ascii?Q?zUr+Oo2qGhyZqbmRWjSc6ig4rvPj7vMqjuLXrU3CK6lmjJBpnD0SZ46XNxkw?=
 =?us-ascii?Q?q/LcK5Kok6oc6DsNpwoMVUapyM4+2OhZhQt34KH5RkhC0qLTeyVeKyujw6r4?=
 =?us-ascii?Q?mjKT/AybL6D44GDG/XUZH2hPCK4Tq/SEz5/nUrVhgsG9Kbf0lC5049RNf++e?=
 =?us-ascii?Q?xkOWA5ZjXi8rV118fKtT7Zf1n/pfQ5cGHJMfgi3S4yfR3slKgdjcb1cghuH1?=
 =?us-ascii?Q?QS9BuMsg9e9b7EkVYVrZRqCRsRLG6bsmjlJQsAGODEoPnyL4Xa1KAcZf6ofy?=
 =?us-ascii?Q?4Vah0mNOJW/HqzMIR5u1UycAWWtn3a1LduS2UuPYq/Lnx+MqHTkpAenYOf3T?=
 =?us-ascii?Q?GY1itKbbcJ+dRTi6WyxL81jvuVei3FV+0nu9jBt+FPR6YDdjUf1sTk8jxOam?=
 =?us-ascii?Q?NTqtphtVYD7HKud+Ux8YytN8WkT4SGihtBpVMPqxKqf8EfO/EYgD5CMgew0R?=
 =?us-ascii?Q?s0YmLAmCpsrZHolr4YFxSiFOAbO13LguRfuvbcLe+kZaUllM6iNpFKee83iA?=
 =?us-ascii?Q?E/0YQEmWlRlzdfingk1p34+paw8Y62hkbcaYxBB6vG4cNhjRiSG+OSAxHXPy?=
 =?us-ascii?Q?ve72DyEXntzJmhRYWKa0aqfONxjiKXQHBX0aUr8M1Me0KGzyKvRfggrK9mNG?=
 =?us-ascii?Q?5vjd8LiVcEnlqr1HhN1G3cVZqhoPlTG8xLEppze8171AIt6JTXFrpdK7Zn3L?=
 =?us-ascii?Q?lGu1KEGCXqgTtmOU4QFOGeKmo5fsWUl6fA0f4FGRI1bJmMocL2Avr4KZwMMf?=
 =?us-ascii?Q?iOoxK9T3MsTp+N5zNZVFYqBwIOyRRT1La0oqvFJBc6thQWFqGNvy7fteFz5l?=
 =?us-ascii?Q?VaRdRvfpk8VAFyIpwZb6HZ1TClB1oTy7zfCxPtnR8VS3ddw33KyA3gEICBXS?=
 =?us-ascii?Q?/jmusnWvLTN7BwBYFLdDGU8n0mZ5zCapb0lXsDUhmDQXHIgEFL2GPFmWsG7C?=
 =?us-ascii?Q?z6HA6Ww7TvjJv15tPvRQ04Z+FVnODppU1PN2hCr/3Z3Rnmj+tysO5aS2DOtI?=
 =?us-ascii?Q?OfUF3+5HEp3Yrs274tMLmdUkLg1xpFdR7Q8AVfJHdCmBtOJ1VlHWARcxa8Ix?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1UBjNw/Rl9ikB75H05hRWlx4JPgig9w7XxJ9xTTshypP4KP75rHqsAqVj6bwjhA4xK0keD3AuWwnfGo6E3F5JWs2Xyst8Y8P1cO3St1NIulOmydCkE+ng8PpX2o9u1nUZyn8reZ5TczBWcL22Ie4BW4iXe53ZfsMHj6JTZmxqaCJafM3sftZAynkDcFiQIKcyDGFmCwZBBvftlpNTwVwuaH+CmRoOSgCtLOlb0JYTbDs8YnE+EyyJfTGG4BUTdmi8ceXaen9onBhywaFA5A8uPTdmP5FV+ojkBMUL4dp9DGLyuqcoJJmmry0u0qCXVqx0jz2OeM0kA+JpGY5c4401Wo1mrONTMotyYSlg6ellgDyYiDCo1j9I1QL4Rt4bp5OVlDF+MXTD59ZRilL99R4fkJtsLHfQXXvodN7nXw87nkaEB9X/fXDItxzwulXwyVw+/SVDi40OByjE+Px6h6/u12y6pdckbJ3gj5bzsV6mFKW+GDdmYPtXKVn/11fFY0ZmZdP/UhN+/VsxBZiWxlYX57wCxQh2Tzijvx7AhhGLIEBkoSZXqAg5BSO7jFRPmAxzdwZg/PfGI61H5nGqDAJUJFwbCMtamE/bJcJq4JXFKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e724b4f3-5ac2-41b4-c820-08ddd9c7be10
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:43:27.0781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cvCCz1UsY6eFjROCJfWhrTlEXh5dxCTRSA15Wr3srT6ZvZWnhpJYuIpxPh8dyuTmzvARLEbS/Q7vebCA+uYrCADbKv8FJBcR5xqokAzcFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120170
X-Proofpoint-GUID: 3D5uGX-bjzgyxhqNo6NrmN-mzQb_w0fQ
X-Proofpoint-ORIG-GUID: 3D5uGX-bjzgyxhqNo6NrmN-mzQb_w0fQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE3MCBTYWx0ZWRfX8tmmLlLHKj98
 fRy7OJWMUs/XFGybKZvcjoBSpi4uMGJG5gzohOofRMXUvIzbdzXd1hQIAGw9YfUEKxOJTo20mX0
 stIwsVaVW4q4oRnpFK9+RV52lcwXlZ28I9KdzMyNOBj/eVUNRoIMTtOuek1V6FBbk6P35VzoBhU
 LIVHwEGAorwMMHFSlLMaFl+AMHDdsdmEHzBioAzWu++bewuzfaCLrSnB9o0rJEylxsRLKFGDpN2
 GBWMRhLRvCWI9dI/gx4viKdNmaUkfrOjtomTf1XX+R5MBp7aBuc2ved4PwEf2VYS6gEhwJ1R571
 gi5UKKPA32E+YV/2aERx4AC2geWK8QMTq3/I2FrceSiTaIpN+kTcrYH6Wyw50OP6JtU68Xm3oXt
 DNTyb3vMdKlMoEVOs+m7XfB/sWnpuhaVniaP/yIeYHl3bGy0aNPeQ120rU6yxKG/ejif43yE
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689b7d44 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Ef1f8lSEwX7UL4L_uaAA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069

On Tue, Aug 12, 2025 at 01:35:18PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250812 11:48]:
> > Now we have updated all users of mm->flags to use the bitmap accessors,
> > repalce it with the bitmap version entirely.
> >
> > We are then able to move to having 64 bits of mm->flags on both 32-bit and
> > 64-bit architectures.
> >
> > We also update the VMA userland tests to ensure that everything remains
> > functional there.
> >
> > No functional changes intended, other than there now being 64 bits of
> > available mm_struct flags.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> A nit below, but..
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks!

[snip]

> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > index cb1c2a8afe26..f13354bf0a1e 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -249,6 +249,14 @@ struct mutex {};
> >  #define DEFINE_MUTEX(mutexname) \
> >  	struct mutex mutexname = {}
> >
> > +#define DECLARE_BITMAP(name, bits) \
> > +	unsigned long name[BITS_TO_LONGS(bits)]
> > +
> > +#define NUM_MM_FLAG_BITS (64)
> > +typedef struct {
> > +	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
> > +} mm_flags_t;
> > +
>
> nit, This might be better in common test code?  Probably just leave it
> here until it's needed elsewhere.

Yeah, I think we need to figure this out in a more sensible way so we keep
things vaguely synced for this stuff more generally. I'll add a todo for
this!

I think fine for now, key point here is keeping the tests working.

Cheers, Lorenzo

