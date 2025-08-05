Return-Path: <linux-fsdevel+bounces-56755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DA5B1B523
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 15:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00FA23B7F07
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC75E27701E;
	Tue,  5 Aug 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p6GO5N5t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hqcaqp9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991E275863;
	Tue,  5 Aug 2025 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401324; cv=fail; b=HNu2NzfS5jZ46vUFv3ZHrHUzG+9mPQII9gIF/INwbzmIyENJnLjIh1kuRnFSpFiLuxRlf2oehuKeCTIdKDNECfl5r/kMM72EqA8Gr/ioPWwphdiud/th9nSqYYxshENzpDj4sW3cmENtE2CmiyVfEQKrmgymUYDTVMmU/mfkK38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401324; c=relaxed/simple;
	bh=4FDTZkrDrMAqriwlUHqLwsFKp5N6qUHyjRN4D5xP+t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lr/O3rV5i/gBLxaPV13NG5H880JknAy5FF2bCvT25HJb4MJCoOVMM34RWruRV0DjEzvpag0VAoWUwpRGk0EN6jZZwT+wYCH521t/SB6V2FCa3Hoo7X7/31LEU1yDXcykgfjz3LjsiCVt4kPD7zLJIsXulO1h52IJRRLVGilAp18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p6GO5N5t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hqcaqp9O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CrnoR007305;
	Tue, 5 Aug 2025 13:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UH57J/OB88MMUofJZf
	wx4YxFRGiwhkSXVKz38h1wO6E=; b=p6GO5N5tIhpCpNEC3Pn5yM3GO2bfdlBnsn
	yAi2wzfsDFu6YAkI1cPLNIfBg4vii8jxRTZGOtQ1Ych52xAXqjlteKrDr1Vau5B0
	afTbSrFWGlpzpjvIT+IOxaWVJqPMbRpgO7cLuUyl9mUmymMSDPFiqFwlMSP5JDba
	26cNIiIGyJd7aYiuIz21QQ0CTODU909jwhbdTk4/6UG8My1NSaw/9yRyxN2Rws52
	9DOmPxQ0V79tRbrsbjjQ2iiHF/ayk9TVTQ63MXuXLYNeZ9prV/9glMlGXvaZy3xY
	7eOxFzzRM/htSz8JbWDLu2kneP08u4AGR97a5WB1TVeb7QW9/zIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489994mt2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 13:40:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575CADGr028877;
	Tue, 5 Aug 2025 13:40:48 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48a7qdxnd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 13:40:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU6g7LP9KKcjrUBGRDbV6DquUcKU63QqLHyI6H/DIFRW2YgBBQ7K9o0Q3OyR9LFb3QZ5al6fvfMQz5/O36eUZhrbwp/+PV8ZfSz9J/yyhiUhelbRxmbgb01oqBEfGVprzbHBBCBhwWu7XlMrZLSY35RwXRj5UGFRmO7eOvKobugNdV3ntiASPhKWM6jNJ0hBIlFTjbChlYirheXzc6uP+N1Ydm8AGuEt7Zs3fyuibDnYR4bC2Vu9u/Gp7k6gSZb2G6EeRx0iR37klnoGchFtrRfvOQXuMkzFDXtzmiz46QS6gs/k5veBKUQDGm8F94i+IuJH0csKeS5a659GrQ460A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH57J/OB88MMUofJZfwx4YxFRGiwhkSXVKz38h1wO6E=;
 b=XIPMPXH6x8HlLi61eO+FjBYekFq4Y4b6bhrP2T8gODtUgPD0C0+hbskeZ4OA6jXzHw0ESLSieDXfZLOTQRwgIDZvSmgkyG2OENOZ5vRejjn2BX4nDLcLAlxLrmTIxL0/ALZGNlV3eEOZ1CMRW2FI9iQzpodXHFmtbWp++YE1BLbq2VdHU86hWVqFT5XHvm5M8QecfiMSIq+EGy1McUg0WnWrdYzgJFgZC2X1IbjbntZcoWtFQPljbLoE+s7xWpGrc5Gu8nJk2vp+SiCXMuRuzIRqa9PtbZ+Imt2+m0+IK30hBiiVe/alprPtQN1NJR3Y3ruGF6gZ7HakcZTUgcofiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH57J/OB88MMUofJZfwx4YxFRGiwhkSXVKz38h1wO6E=;
 b=hqcaqp9O+66+gd8BVZ4NgecLrkYzwjd/JJyfVdOefsejXoN3x9kfoK/lEl3FqCFAfgjB2pSGFFlgHvoTdKGbf4o9Y6vK+2CbMEyEj57Gyi20O3LmDiijaRKA7kg4y6bjMEnVl1e6wb2K1kiC7qDq87a0KvFLk6YaVqJGFUIwI5c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6367.namprd10.prod.outlook.com (2603:10b6:806:257::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 13:40:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 13:40:40 +0000
Date: Tue, 5 Aug 2025 14:40:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
        linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 3/5] mm: add static huge zero folio
Message-ID: <057eb808-1820-4e70-b13c-a020cc6efcd1@lucifer.local>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-4-kernel@pankajraghav.com>
 <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
 <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
 <6ff6fc46-49f1-49b0-b7e4-4cb37ec10a57@lucifer.local>
 <bc6cdb11-41fc-486b-9c39-17254f00d751@redhat.com>
 <dwkcsytrcauf24634bsx6dm2wxofaxxaa4jwsu5xszmtje3gin@7dzzzn6opjor>
 <ca35da97-13d1-49f1-95b0-b8b9c8a7f540@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca35da97-13d1-49f1-95b0-b8b9c8a7f540@redhat.com>
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d53060-186a-49e0-f396-08ddd425aae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zqGwRtxTvij2nO0yrY0mTtCLoyFDFmbdrqykTgoyiVwihNN5fQcVsx59k7+q?=
 =?us-ascii?Q?sMpOjdjMl6meoE2eVkgMbvYTyCBWDImSWrcYVv2h0zk/9LTPU+I5+m7W6fyx?=
 =?us-ascii?Q?/cN0Q8ab+mhPh1xt2akhF5406jPK6IWOTWcGYCElZikS1jm1ar3fJPRNKfud?=
 =?us-ascii?Q?GZTOe3K4x9lKqSZsbpIAkrPKlppCm98UED4C8Tm2Mw6wb1lAyQ4jPuXB/EpQ?=
 =?us-ascii?Q?bGdf6T/dxeuOGMRp4V8G/AoQgTVnnisY7Wy2uRU/wloEZAHiMj0Q1OpGtd2F?=
 =?us-ascii?Q?K47lgOEiWjNmXETXRJbvLrcCzMA7j3PE3B1zZ7tc7Cv0kkqtAjQtHy58b+5F?=
 =?us-ascii?Q?YGN3V5/mtvzGb8iYdnzdPf5vp03mxGz9tdOV5hviAZVXtqyx3SGhR4u9bUMf?=
 =?us-ascii?Q?P0VXwdzRQYGkzacUsuAi44LgzSzvoppb+kvS6+yhR2ua685sauyD6b6AbkoB?=
 =?us-ascii?Q?3Y2EQGHWoicHOjHDps0GrLzKpouSMwSlvsQYKdo9Snuna4ZVtAz9HVo78pVJ?=
 =?us-ascii?Q?wRRxCEPeDdhOwkYDZq0tpuAhZNI16alaxAQbGrvYrw5W7tAwzFDJxADW5MXN?=
 =?us-ascii?Q?SjvRqHymrmbqaMZueZ5QPI4ra4LIl73aI09LFZqFHjBCH0Heb7jG8ENHPdj+?=
 =?us-ascii?Q?gyyRPnIeegjINrAMTUTZLRsRWQTkbCHgP8cJGjwgEcTWMRXMmyKUNIc9T44o?=
 =?us-ascii?Q?YysT5LiI7KY66Dclz/Su2RujRqdpTdKdVP7ucQZ/osXK2L9emNg3UE9XxXpB?=
 =?us-ascii?Q?RhK4SnUMmRgLuYFXfEf6tPVJdfjtFUyyEe3MPYTb4sseblvrktTmmaJY+uAM?=
 =?us-ascii?Q?fKKAbAqpqCBmdtxpO5gkMJZgyImiSWNhiKkn73d1Fy5RQbgh80oSUKtMN3si?=
 =?us-ascii?Q?uiVk+NCJAfZkJoHVLT98x7YH4bs43K8tf6zpu9B3gV8uBR/TGrGLQq3WRk68?=
 =?us-ascii?Q?fX6yneglPMb12i9/jIyYkq49cRmeXtW1bLJV5N+4ilKHJnMHvmKpsyPLBwBs?=
 =?us-ascii?Q?1Ib6u8NE8qvo9Wejbe/zFXiQy4T5hLOmRwYhJqjt5iJv3Mf7lmMMEXofhuir?=
 =?us-ascii?Q?KSUJXPxrd6uEjnsuHbdUCK6QDLWUK3VTt9VSWHDCD0MX+XQuDw9BIxFB1VUI?=
 =?us-ascii?Q?kyf8dV7u2FFIIs0dEAcTjQDxQG6gJnnbxT8A7Xb0xHng37Fb53Te6+b88HFU?=
 =?us-ascii?Q?7SxzzVg6wP6gDTRM2YinqzDr3L0uMi0YFQhPrFnWF/198xCXkG6fS/kXvpOg?=
 =?us-ascii?Q?jFB7U2EaL85wg7tCkRxtmfE7YKrs65dqktqt33+aJsHxs1La0Y2jZJSSyBTW?=
 =?us-ascii?Q?Uj5lAseYg2iZAZHPQWF2xm0AXPBNAWIG4/lWpX9mpq4XvkoP2nHmAnKfwVG0?=
 =?us-ascii?Q?3/HgOQ4Da9BkAqSAJHAfIcn/Ev8E/dB+g9NdqWFN+Hlxk8vcQ3v7WgZuciqo?=
 =?us-ascii?Q?x/bh2jsbssw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7sJdPpjaRBertUrozyU6DvefSI8O7Se6XjvweNrKFwcMbOxGOD4dLGQEU/ny?=
 =?us-ascii?Q?Ep1Bc8JMgmvRxVcJLI8mIlhk1+jcwYiPSBMT+3jGUkjQLiAfaFbhIIxldwpQ?=
 =?us-ascii?Q?5BIpNk8fG502EKBU5erGW7tNX5cngHIc+DkYkoqrf80KcQ9auh8Gf0Ooj/43?=
 =?us-ascii?Q?amAFOirsFc4Ic/9QHHXNGFpu3oGmoy0SdE22fkAcPUi90F/v0ueDysu2fx2r?=
 =?us-ascii?Q?HFZ+vlmmi8sooUYl7b7OUgVbcOV9M9gbHE6O7nJ6eneZ1VAnRaicBzPewZ7G?=
 =?us-ascii?Q?BtVA7zwAEB+GUNV7+npglOj672H4BJ+UrxYm54AsdC9gAQgIScSl9SEKWWAb?=
 =?us-ascii?Q?5BOMExQrLZprylxt40be7K8G7sPpE3GIzrBXgM1+yd07CzaprvvbGGwgKoID?=
 =?us-ascii?Q?QmmVcSBRVtGiJ8VZJ1O5HpYO4CROrKejsaOLsYS3qPHhWQjGAtqiXmIYXzm1?=
 =?us-ascii?Q?ESTvpm37Oo7g6ggcjpvJ8KUsYaqAqFdI137b81I2JEUp9npOiee5tQxJcXXf?=
 =?us-ascii?Q?u5siZ9MClspeK6ZEcaVF4JMQalvV+h/ntEpbvRSf7Xc00uLvctl6HY3Yi8XY?=
 =?us-ascii?Q?vYcaR1lEtU3L5Df3g5Y7Nquve1cQSGe5HBJ9yJalac39PZVREMarsi8N09fo?=
 =?us-ascii?Q?MRsT/4xeDyw+20bgrKSYJF8W+JzjI7emmHwtzNcy9S611eGEJvFgd7V+j+si?=
 =?us-ascii?Q?kItgqdGgs8g2usCSBd0DcIGWGeZ/sOH5v3I3ELMzqrv4HjLVBoEJ/gfOQTlK?=
 =?us-ascii?Q?77HaH50MdNMToz/30MsolXedIyx8jJaTj5MAc53VawL6p0bjoyCvK795aN6M?=
 =?us-ascii?Q?EOMs/mvuEP3Zz1ZEvmHTt0IkjxMafGykXEhp3Bd/RugDDBv5Hp/qCFj+OCmB?=
 =?us-ascii?Q?6JHFl2dhirIdA3/fV0CgMTE4Ls/FO0pSyBIX2qrNLrQTEIvVOTriU4PMaRTY?=
 =?us-ascii?Q?2RJKkbxBRcvmts4pkF7OiJTUojEF5YYCuMkeMQDiYrpcC9xoQ93Kpv3b1V5J?=
 =?us-ascii?Q?dhHlnh+jUS9eVQDzy8bD05brVdKcy/3Hwqrm1ZEIN+YerKyRrDUXmvjly9vl?=
 =?us-ascii?Q?m5Yqq78NXfHByG4LCwhuYmnPqWuRB3u0wFtsRe5BQYqUPAEjJE/xGj8a4Wyz?=
 =?us-ascii?Q?fNNAK3BHATLVpRLN3oylNmb5nbEzZSNkKUWdZyb5c4PACyRXKeWUORH2S/Bk?=
 =?us-ascii?Q?fIkvBfj7c1NUTQQZK0vIaJdjFH5HpT9+Ih4aCTWHgFXIktfJUbjEk4Dgn/5o?=
 =?us-ascii?Q?iRvWa0TZzpC9DwM3CBOZrjPDvQ1uZalVORrX2AlWxZ0RoTiAvZk4wSX8kgm3?=
 =?us-ascii?Q?p2wHjWB/dO9ECoFDeTloguE6CUBtLlmGDOwXJ0T3AKKbTuONhcnzrMusXRnl?=
 =?us-ascii?Q?+kVTxb18wV/ywmWv0NLU1QrG89FO6fDruCwlZtoI9rzdl6ZjKOV62QktFIaS?=
 =?us-ascii?Q?ZCbvlv+NZQEkY7RfpLPoKUyzipjGuaGFhfUghVOOr7wUi4t8MMO/HQYo2ZiL?=
 =?us-ascii?Q?IA7T7Yp0+WTrRyYMIpTez7UJhkXlMiivHnqyUa8XS31/akgRUfJILqUaoBBU?=
 =?us-ascii?Q?d8RUf3UZPVSlG14sG90XQpmKgqF/ePXQK/dVKKBucYwg1uK1nMUH+x9kyJyY?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TAkGbpkZvr068Zemad1gsi6z6bPwE5RsLu2Cpbpl3d1oBSQnJLcCG9AYPG/mmPxlHfXBB0k5+9l7VIF+/OCrvq4pygfeaFrV1/2iYGSuFaTKPxpQTlonETmw60L3qXonRuK4rao8KYoro43fqqUngWXuTX9AXE02YDTljtmvNqj5LCKZcso1jweMRk3N00HoOWhEQozTdDtVLOSdA6DkjCfp1k2kTZXsSng1ObdHMhAi3/QCTawY6MT675X+sHTemtt6E3JsRCdlploFgWhD781qihXPMr9mF9iLs97Vd1rXWQYEEiaokiiLr6W1pUcch2cbTGUgd9ln9epgaTgCNdSvjT440sE9cOnUaNwRNw+BoZuOFKA2eGZXXWzYaep4Bbu7/+Abq1LDm3fZBkyRIvR+4FZBwdqPG++/5cfQwToz1/yL74ROeR056yJZq2I1Wrkg94gjwT8msV3s2ozS+t/xXYrQrITyhOI2rnTOLMaiZgAdmPDfpIoU8hQiTX4Ex2uHIGksPPC7pF8Xx40m1KHBR34Ph0KSA4XplSOSNvM+Aw87/Oh2rhFkTO9gVQqcEzuQY3t4WIY0sl8jI0C3ghAsk1cWcp3vdqbBGZlDUag=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d53060-186a-49e0-f396-08ddd425aae0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 13:40:40.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n5cbrII8HUZoPcNI2Y8aRA43fJO9jp7s2Z8GtEAoms23fR9lP9PLb+WvxSM7V8MfWfSFCNoXlDicKAGp1UA7+P5ZXr7rSgSoP7y3yAFY24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6367
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508050100
X-Proofpoint-ORIG-GUID: PK8BKxmvlZbtJubZT-pTK6sYkuOMwjkU
X-Authority-Analysis: v=2.4 cv=HY4UTjE8 c=1 sm=1 tr=0 ts=689209e1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=gMyM4voaWrrt3ZUMIEUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5OSBTYWx0ZWRfX5okKe+c8wydM
 0UyfvDpVy4u+htUbr5Kigj+MAnAouhKftzmuMFY8ShA9a7iDK1WEaeZrKzBzFQCYgdmLR3eW1sy
 7oh6nsUSHL0HbjKJ8iZ3olETyO6juJUQrU77u5Bir7rvRM90UX9HIWHVCbzSK0zthi4g2h5SsZD
 GCKBCrzZBXAEp6BuZc5PUhXFZZsiCgci7Hzmu3hxyCYDQRmqpoqlfLhbp5P1QB/L5SI3Wan9Bey
 46+b0hePVwj2yxG/rjOoSqO1xcGlR/15LTls+luX18A9cslpVQo+SeOpE3+pEwpARlT+tbPu5F7
 PoVLKmQfe2pIMtZgt+2wu/ud4FA90XbPgLgDflhUr8uqpvUmvwLHnrGi/bYJvhlOqxE0JpGh0iT
 08kmJ5ulXpD0QGa21ZHn1ga0JEUyLLPRbj80ZM1xpZOCZffdGhY9A41rO9GrFknk70/jSXsH
X-Proofpoint-GUID: PK8BKxmvlZbtJubZT-pTK6sYkuOMwjkU

On Tue, Aug 05, 2025 at 02:10:39PM +0200, David Hildenbrand wrote:
> On 05.08.25 13:40, Pankaj Raghav (Samsung) wrote:
> > Thanks a lot Lorenzo and David for the feedback and quick iteration on
> > the patchset. I really like the number of lines of code has been
> > steadily reducing since the first version :)
> >
> > I will fold the changes in the next series.
> >
> > <snip>
> > > > > @@ -866,9 +866,14 @@ static int __init thp_shrinker_init(void)
> > > > >    	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
> > > > >    	shrinker_register(huge_zero_folio_shrinker);
> > > > > -	deferred_split_shrinker->count_objects = deferred_split_count;
> > > > > -	deferred_split_shrinker->scan_objects = deferred_split_scan;
> > > > > -	shrinker_register(deferred_split_shrinker);
> > > > > +	if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO)) {
> > > > > +		if (!get_huge_zero_folio())
> > > > > +			pr_warn("Allocating static huge zero folio failed\n");
> > > > > +	} else {
> > > > > +		deferred_split_shrinker->count_objects = deferred_split_count;
> > > > > +		deferred_split_shrinker->scan_objects = deferred_split_scan;
> > > > > +		shrinker_register(deferred_split_shrinker);
> > > > > +	}
> > > > >    	return 0;
> > > > >    }
> > > > > --
> > > > > 2.50.1
> > > > >
> > > > >
> > > > > Now, one thing I do not like is that we have "ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO" but
> > > > > then have a user-selectable option.
> > > > >
> > > > > Should we just get rid of ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO?
> > > >
> >
> > One of the early feedbacks from Lorenzo was that there might be some
> > architectures that has PMD size > 2M might enable this by mistake. So
> > the ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO was introduced as an extra
> > precaution apart from user selectable CONFIG_STATIC_HUGE_ZERO_FOLIO.
>

Oh yeah so I did :P forgot I said that.

> People will find creative ways to mis-configure their system no matter what
> you try :)

I think with an explicit config flag, this won't be _broken_ so much as
wasteful, so therefore not really an issue.

>
> So I think best we can do is document it carefully.

Yup, well always :)

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

