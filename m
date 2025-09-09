Return-Path: <linux-fsdevel+bounces-60626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC8AB4A664
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780E91C25073
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DD32797B8;
	Tue,  9 Sep 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QvVQIA+P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eZ+T2g4Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB70A24113D;
	Tue,  9 Sep 2025 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408447; cv=fail; b=UAGFnBYiBBl7UV17A7XNtI4W8NfVPwYJrvHIy4HSguixJtC9ocK16mbVTU4jbIGh6FPZEcnHn1GBsNG3dBQTkJtzJnXjJAkzv1Sx2Zhyuju93hqisfuH8FqOUwGRr1Ap+1ySfD/RLdW0+mLpez5PWITi9MAO4iGsCUErQypwccU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408447; c=relaxed/simple;
	bh=PY5rU8mKx5SDzxo+SNtwUWbUIyMOxzu1DYSyljhUxkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fl77KgGydcUrPAP+FedwAK9iPmLYVtVpftUQ7LmwJHuStfmMIgqSb84ft2VwtvNfTuw7dV1QpI4xNGuiQd3RAR2g9kiks09tCkdSVF3fpcippPRNh8Sq5fdQ5EgFbpquHBqSYpc62h4sMoDjnttXADzQ7+kLlrMBRIINb3wd3mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QvVQIA+P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eZ+T2g4Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897g04u020465;
	Tue, 9 Sep 2025 08:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=36RZ+AIO/+tQ2ivCBG
	9r/OB5HUaErkc/iF+eRwWBDb0=; b=QvVQIA+PA1gebRUKOVJQLur7TQuI4c9uPF
	mn234baBcp+x1xONXZ/RulrF5Loh1tWD4SBjgU4ZDa4ImHTGBqMe2QVi1MlwzySw
	myxZeJGbIkzVrRV7/Ez4g+7hDLXoaXX/no4gCFdsJS89JvpSLjeKuz1f4ZBFwcs0
	diB4uHW1TJgXoSepVCoK1fQn6ZyVpTOMLznC5aUpZzX+hcO40M4A5N7zV3ICiI1S
	3dVzyymWYPwlEptKdmhx5nP2gcdjxwmvolRn8n1U5faoP6IqplR1qZnUvC1gW0/V
	5l6hMjEmgyth1wB7WFEtgs4bgUjOaNMm0IRIQPXo51ZYv5aqtoeA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pe9ge2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 08:59:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5898DqIE032845;
	Tue, 9 Sep 2025 08:59:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdaapjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 08:59:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSrtdmMPyo9PKVsvCM0Hu+XHY/csvFwxA1Dzg+F29NV68810Lc8b7wVPa+ZvIfa3ZB0Alv2TwHeLh65W0BRCjfA9uOuIM9AEcebb9erz+2Nm9F5XKAxQKpd3br4EGaYXlsNoNt7b8k6aRB7r39SmoGzmj7gbWbeMRe2FwQ3pwuJZwbOzRkwERFsZkyjWBzpASY+belk5g4rlwqGFVEYdJBfmlWLEtXz/TiaJQ3LAz90lFVNOaoCFgkJS+xVYxAabvFt9jmdWwLS7NFIaHidtJJNLX//o+LfGBUkMyUc3JtuRKcz/EqHWU/hM0ZCUa8ddrjZNZHQFl0F22FhMbL4oiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36RZ+AIO/+tQ2ivCBG9r/OB5HUaErkc/iF+eRwWBDb0=;
 b=P+qjJvGrDd6drR0+T3h5qRrUuV4yksEcYN1y9PDZyjeSsOBIyjsLIt3jJ2kdJM7FgN6N1YiKdg5Z2PB/5X5wh7Tr4hCm/nOQJemvfWyQ7xWc3A8l7+1wE3Jd++ryTS/tQXJt7Bjs1bufkPzScn2BaO2IIMDHg91SlfiTBH9Nb/noBIeSsqCgax8h07sJELxO8/T3CcfRk/A0FSTKYcm4Zm4TEHZNkMOwfTBn95adxWRMDkBz79QRs/3tRtWwd/VXW1m8kalMz36zngXvzQ/f5u1jPM48AFGDoRqav+RQbfcV79HcQt9W9rBOv0XNS0BhjKwLdcGZuKLRUoCKX9BLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36RZ+AIO/+tQ2ivCBG9r/OB5HUaErkc/iF+eRwWBDb0=;
 b=eZ+T2g4ZJvViAtylRgSTBqJw4Luilr3GRQv4VRzK9bcjfAQ5iLCopLGJNaozMY58WO9cvDRXHVXu4GLZ3V+rdlUMP8LXKSQWMntWu2xsopUCdJmHrerPHoJrAS+HV4059bpzfAM2USefywykWVCj8wqpdvWV1FdLe4mB/MF+GEU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6652.namprd10.prod.outlook.com (2603:10b6:510:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:59:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 08:59:55 +0000
Date: Tue, 9 Sep 2025 09:59:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 00/16] expand mmap_prepare functionality, port more users
Message-ID: <ecffb1a8-86af-40f6-bb78-3367e2223953@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <4fbe6c51-69f4-455e-922f-acdc613108cb-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fbe6c51-69f4-455e-922f-acdc613108cb-agordeev@linux.ibm.com>
X-ClientProxiedBy: AM0PR04CA0068.eurprd04.prod.outlook.com
 (2603:10a6:208:1::45) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: bc693759-1065-46ce-b702-08ddef7f3ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?racakEGIW4Y2LxS2DZWViJ2z4kx7hYIPImh275LzsZyzwJfaJ4reyB9VHG0n?=
 =?us-ascii?Q?23kzp6MBjcnQHniFkkbQlfaKe+W4sP+ti84FZF7UjCv8G8Js2IVFhzJyfVDj?=
 =?us-ascii?Q?Aa15d2sg3/dI+7RiPSCGZawfUt4NIiztmzUv4yaJu9nkEYlV9DvpjYBjXpAP?=
 =?us-ascii?Q?PHudM5RF/ZygvwIeXdc4JcONgsXykbhxFjyuWzqMDoV9iiVxjwGyadQVYHHv?=
 =?us-ascii?Q?72M3FLPDutvyEGNKGFOYRF/Ps0bwpGAQ3r29a1Ceh99WVpueJaqY/v09z4Qx?=
 =?us-ascii?Q?9WBty+lWgZWoPH5i5iWlnT1sMlmhpQdEITxzsnTbNfLVkMz/vGkuT3bCtCTH?=
 =?us-ascii?Q?tMb+hj8yxz0IuBxGw5zdtTyIq5qJiRedc5YUME7LiBxm8cn9ZpXNN03RjMpo?=
 =?us-ascii?Q?WQL5T4B/wElBUcBQ4a7Mowjgjbt+Z4b0LYMV2pS2G4A26+sf6hshvo+qxIOg?=
 =?us-ascii?Q?XoPCCVWTSCqSfrRD99/xUH1JVWQdYtL2AOl6xriS8knHgPInHvdzJ9OYPRBL?=
 =?us-ascii?Q?m+1ApWYt1SsnR6o3lpLnDR3tdFxjwcSk458iCj0PBnK+cXt7udPT+87TObSf?=
 =?us-ascii?Q?mkPKYc0KIBe6XmFugh3OiSMamDtxTtUSmxxaJm656FfMUq0K0YtdK7Rkng6n?=
 =?us-ascii?Q?ubkex92g7SHmDT/6QVHqmshzPdlxcszUVUnjpamVgpwE1K1Wj0HJA+aHLaiU?=
 =?us-ascii?Q?UUHomeV++9LCvK55ZHDq3Btqtw7U0RNZwUDp2BfBXvdOZjUhTHEAclnSVUI5?=
 =?us-ascii?Q?wNTM3knKPkvPI12EvftfTF6E7tCqqwOl8E2RaQ6aKUef5bK2ksIAEKiAIjP2?=
 =?us-ascii?Q?djZkFDsjEYgCax7ZlZXAYhbcGAQcuaJPqI0TKX6bh8GuEzCZ8ERViJmih8wH?=
 =?us-ascii?Q?T9dy6YzjYhh66rTyYSNtbsDc2YnTo62g31xQbZAsMwNc+vtHy0uFXypWT3od?=
 =?us-ascii?Q?nur8dB19LTbdDguCKRUb4YsNSJIJySORQjmHnYNempSRs9FfqYMr4xOi/EsA?=
 =?us-ascii?Q?T4PBVQCZbw/0uA2kG/Ys3btCEwsyy7wnyhoDJvNVGSAJ6sQEBGcYVQu37iZ2?=
 =?us-ascii?Q?dx27KrdnOgPfMj6Y7TzGBEHfsRc5VMuEqBZN67HW+ZTTNh96am4sMNG0GeYP?=
 =?us-ascii?Q?WdO5lR2mxrAUqbogumf25labctiGmz0kGKkQ4bqI2JIwOONEsML5VSb9kTUF?=
 =?us-ascii?Q?cET9AAPUd82xwQoEmpJe7SDGvVwQicexyhj96JwxkLGMhpwK5zZNRUtx18R2?=
 =?us-ascii?Q?3X/hnHUnokVA8ljICjmQfjyI/bYhNL1NpR/yBrrKQ/kiIz+EsKPBcMGUFhEb?=
 =?us-ascii?Q?KnPw//FAIRnIJqcpy62KhcUVszcGueMaZPDTxjO/peLFxx5x+tw8GpTBZL3f?=
 =?us-ascii?Q?7Nj84QSPPsLB7Ndcak3SHb20MR8msiTnX+yjwYLTiAlrfZubWcqYmjrjyhJ5?=
 =?us-ascii?Q?8yMOBODwKpc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Ya3BOqunwnCvDUoWgd5igrsRATAr2mA4rdo03SO6flz5ItwM9iUIrNxvEFw?=
 =?us-ascii?Q?uBuj5cmjJgY2yfUPFOIUjYEWgZPBFtZaGw9mCuzbdUPpRjHW8Bdgn7vKYAVq?=
 =?us-ascii?Q?zIpxFoPbXANTkv6S81aioLdEsQ2YX7KN/tJcPOPd3cQSjzyHjf9D5ETgO+gC?=
 =?us-ascii?Q?ls/99UFkXlmZohPAr/XA6dSOYjX1GMDKz6ObSIfUnFEbyQgNUf9i+rDKNlmG?=
 =?us-ascii?Q?h3uZV5QipNZYeAWCVtFp0OFMGCyUN+ua1184iruh7w3fBffQiaP0XHvfjmqt?=
 =?us-ascii?Q?437DHWjzsumZAsdmHMicQzPy7nfyrCPjeW0nnnfaxSoBn2/P/FJbb9S1MVwa?=
 =?us-ascii?Q?OanzGyhyxtaV4uvRayAGkqnDZIr31Mu0FZ1yyiWwsEdTDJ3HsUvWrZDyMPrg?=
 =?us-ascii?Q?PxLGZ9ZenBF+SuCtJRsd0Tmg1vUuaRz/1kxPUOE8TPG4U2DtWINtLFBzmFig?=
 =?us-ascii?Q?tgOWCVenNe6axfMsZn1X+oTGuzrHAIkhdlZAaeiWDbEBbjQi9Xs4PieLid1J?=
 =?us-ascii?Q?KF7eNPULSbO2qt41sDFuWojI5Gkoac1JnTpfJi/hqK1t9gPpRk5e/IEstokL?=
 =?us-ascii?Q?raZjXPclI+/HglWaRChY6m1jxvgOZ5o+itnboTS5d3QCyU4LLcEy6hxm9cx8?=
 =?us-ascii?Q?wMprq4/K5qCXJpQlrxqOqqyRXhu5tvrx+mOIEGPoVhnK4kQzDuJZjvxnm1E2?=
 =?us-ascii?Q?9YGAvElM0YQUIPk0tmHEDu2wRUIwsxtyl3Q/9885AhGmeZVamx2YSF28aVdZ?=
 =?us-ascii?Q?4Chmk4sIn50y+pN74Pa1YqzTKPffQ3jUBeUE2H/X8emxjUaiqtB5Eo+Wg5dM?=
 =?us-ascii?Q?3WZ5JaS/jci2N/xd855/EXvBQ+IWXbY9Mk8G6t5ZExB53JfddLeGK4bDoAs2?=
 =?us-ascii?Q?BSo4ZlscYdcYqy6mk7wdPTNH0m4+Ib+QmbSoVSTokPZH70xl2oQPBpoqvyiz?=
 =?us-ascii?Q?5R/uWgnPywAyUpt+UzlnS2DYM72d+qLA6Zhi6/PqnaWWUnoAkcdnXmFqZB1g?=
 =?us-ascii?Q?eQfHWa55Gu+46zbs58ZQ7vhGGI2fbTFzZd1MWettOPk1xRGN05Nc6cbNuQ+D?=
 =?us-ascii?Q?t9k3wXk8QQ8PQjhHfQnUz1p72EPOODJ3m3G9TL6h2EV/QLDdeC5Sa8ljKedH?=
 =?us-ascii?Q?f130niI5WfoTRY1xWTtXodv1ZeLVRzYFfrkGQuKpotnb8LA1a6vjBFDQqunf?=
 =?us-ascii?Q?+Xu42smKf6ax9jPWQgxCNyoDmPPLtJSJlpn+B/w1HMnXWidoMEanfxw0K3dK?=
 =?us-ascii?Q?q4fzOqq9k7yIxv18dTZzMS1tOUy42vHcdBuBp+YRZzy1umgVRBuMlVutiScQ?=
 =?us-ascii?Q?YvU1Vh6QlQx4F56YpcL65aU5Kqabw5MeYhsq1FkBh/irA+Tj3ZTtgR0gAaj+?=
 =?us-ascii?Q?UFQ1u0RbXiZqKzpiwefVlFMGlmqN8ICVCee6pjei/4i1s9OK8FLvie/U5HOh?=
 =?us-ascii?Q?lQZ5uQzmYY/KQV+fEQjQfUY1UIb/4S3j9EiF7fYcv8p1mdOSPj30p/RLGI6G?=
 =?us-ascii?Q?xNqlGIgaCz3Y8r8fifGCvKSuU7WRAsi6qRmK1YD52j/LKrV459v9DLpoT8I1?=
 =?us-ascii?Q?VOlEPNBBrd0e9wSgZVKiDZmbXIdeWsMb6Pv4W3YhXGSWRgor/Mrnr2ao2Ixr?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hWSdlua/6431nNIpxVHud7+STsGH0B87Ko5I3l3RE8ErAUo9A84ctp6X1wRsHuh4sEawVhdnDcy2weCZblN0KZC4aiCPHOxItjrAK8CSFuXqCXZESeyfILNM3yYZ7P8gf2pJXLsUXKYqlHNlTZ6AIOXSo0TNQq6r/iGT2+RpWjjh0iE4HUYBQijpBtNO9lM6W1BQMR5mjXVPz/WTGBktLe5jTKTD2F/H28a7VwUfNN9cWw3KzgXE7MAFBKQc+8nxS7ad+bPn3StWtmtsZMzTFJ8bY7hxgsEvQLCnebxxJ3xqSI/eYHsqMoaGBCb4hjxEQ59Vsq5tgtv969mwuCRJZePCLT/nCtsxVGN93GU9yauDGfyD6pJtIdsq5cMKCrrwUZSY14qnICKo5aEja7ElozeSsCoeyxGUA36LynmKu2u9b/IbzgUVd6bLFw6XCj9GbwTeqVd2fmGxcYTPY1yZN7F1PqhjOHGWgXI+OhkghqA+EZ4b2DMudU6xUuGoon3NL6runqGkYfK/2UvKJek5dYqi7BPxi0wMhNSTJnn32MU+wextieFG5mEuwDulGtRBZNPm4o6vHnNseZj6MB2ZR3rTBQ0NSlbs3uceK463yfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc693759-1065-46ce-b702-08ddef7f3ec2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:59:55.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNDg8yJvph8CnjkE/HQYpINQZqbJOmD6tjZcB7pZbtIygc3n4Ww1D8xJUR+TCF8d+uK9SVHVPU4UHRMmFwidkNNaixHNqgCTmNqYxAa7Y3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090088
X-Proofpoint-GUID: YS-AWbq-L3yOnl6TTiS3_RTFiPdqOYya
X-Proofpoint-ORIG-GUID: YS-AWbq-L3yOnl6TTiS3_RTFiPdqOYya
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX0Zp8vxAQI5Mn
 ICr9xeDHnqsm5Cm+sD1vdQ+/dR2vX3ILKglqlkOszfsb6f1Te6Ac4ima8Fxf9chCP//TvU05PBk
 rvIs4pxjWbupgSpTw2JengXsDNd7ngv4n2FIS73uV07dSTLBasOs7v6bfeZFj/wTtlZF615R1Yu
 hjcYjLSHCtdJ3wLlYiikub+r3fFym5g25cCYpdmQGPk2yNIYy1kqGDqUYOzJja8L79Jz53v/Kna
 7Y1+7dZlBRSB/7g3vFbyyA86Eib6jc8tquiJUOnpqAYFeDuyq4xoANpo5fFJSD26uBGG9BAuyjs
 ybA1l1NcMq0gHu5aqInfFJ/g//QcsQSceEp+TQHqnnPa0kwogTOchrC4ZtysiwrJ0l0//83LK0Y
 QnXxmyvS
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68bfec8f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=wCinuXyLTJg1KUi0xyEA:9
 a=CjuIK1q_8ugA:10

On Tue, Sep 09, 2025 at 10:31:24AM +0200, Alexander Gordeev wrote:
> On Mon, Sep 08, 2025 at 12:10:31PM +0100, Lorenzo Stoakes wrote:
>
> Hi Lorenzo,
>
> I am getting this warning with this series applied:
>
> [Tue Sep  9 10:25:34 2025] ------------[ cut here ]------------
> [Tue Sep  9 10:25:34 2025] WARNING: CPU: 0 PID: 563 at mm/memory.c:2942 remap_pfn_range_internal+0x36e/0x420

OK yeah this is a very silly error :)

I'm asserting:

		VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) == VM_REMAP_FLAGS);

So err.. this should be:

		VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) != VM_REMAP_FLAGS);

This was a super late addition to the code and obviously I didn't test this as
well as I did the remap code in general, apologies.

Will fix on respin! :)

Cheers, Lorenzo

> [Tue Sep  9 10:25:34 2025] Modules linked in: diag288_wdt(E) watchdog(E) ghash_s390(E) des_generic(E) prng(E) aes_s390(E) des_s390(E) libdes(E) sha3_512_s390(E) sha3_256_s390(E) sha_common(E) vfio_ccw(E) mdev(E) vfio_iommu_type1(E) vfio(E) pkey(E) autofs4(E) overlay(E) squashfs(E) loop(E)
> [Tue Sep  9 10:25:34 2025] Unloaded tainted modules: hmac_s390(E):1
> [Tue Sep  9 10:25:34 2025] CPU: 0 UID: 0 PID: 563 Comm: makedumpfile Tainted: G            E       6.17.0-rc4-gcc-mmap-00410-g87e982e900f0 #288 PREEMPT
> [Tue Sep  9 10:25:34 2025] Tainted: [E]=UNSIGNED_MODULE
> [Tue Sep  9 10:25:34 2025] Hardware name: IBM 8561 T01 703 (LPAR)
> [Tue Sep  9 10:25:34 2025] Krnl PSW : 0704d00180000000 00007fffe07f5ef2 (remap_pfn_range_internal+0x372/0x420)
> [Tue Sep  9 10:25:34 2025]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> [Tue Sep  9 10:25:34 2025] Krnl GPRS: 0000000004044400 001c0f000188b024 0000000000000000 001c0f000188b022
> [Tue Sep  9 10:25:34 2025]            000078000c458120 000078000a0ca800 00000f000188b022 0000000000000711
> [Tue Sep  9 10:25:34 2025]            000003ffa6e05000 00000f000188b024 000003ffa6a05000 0000000004044400
> [Tue Sep  9 10:25:34 2025]            000003ffa7aadfa8 00007fffe2c35ea0 001c000000000000 00007f7fe0faf000
> [Tue Sep  9 10:25:34 2025] Krnl Code: 00007fffe07f5ee6: 47000700                bc      0,1792
>                                       00007fffe07f5eea: af000000                mc      0,0
>                                      #00007fffe07f5eee: af000000                mc      0,0
>                                      >00007fffe07f5ef2: a7f4ff11                brc     15,00007fffe07f5d14
>                                       00007fffe07f5ef6: b904002b                lgr     %r2,%r11
>                                       00007fffe07f5efa: c0e5000918bb    brasl   %r14,00007fffe0919070
>                                       00007fffe07f5f00: a7f4ff39                brc     15,00007fffe07f5d72
>                                       00007fffe07f5f04: e320f0c80004    lg      %r2,200(%r15)
> [Tue Sep  9 10:25:34 2025] Call Trace:
> [Tue Sep  9 10:25:34 2025]  [<00007fffe07f5ef2>] remap_pfn_range_internal+0x372/0x420
> [Tue Sep  9 10:25:34 2025]  [<00007fffe07f5fd4>] remap_pfn_range_complete+0x34/0x70
> [Tue Sep  9 10:25:34 2025]  [<00007fffe019879e>] remap_oldmem_pfn_range+0x13e/0x1a0
> [Tue Sep  9 10:25:34 2025]  [<00007fffe0bd3550>] mmap_complete_vmcore+0x520/0x7b0
> [Tue Sep  9 10:25:34 2025]  [<00007fffe077b05a>] __compat_vma_mmap_prepare+0x3ea/0x550
> [Tue Sep  9 10:25:34 2025]  [<00007fffe0ba27f0>] pde_mmap+0x160/0x1a0
> [Tue Sep  9 10:25:34 2025]  [<00007fffe0ba3750>] proc_reg_mmap+0xd0/0x180
> [Tue Sep  9 10:25:34 2025]  [<00007fffe0859904>] __mmap_new_vma+0x444/0x1290
> [Tue Sep  9 10:25:34 2025]  [<00007fffe085b0b4>] __mmap_region+0x964/0x1090
> [Tue Sep  9 10:25:34 2025]  [<00007fffe085dc7e>] mmap_region+0xde/0x250
> [Tue Sep  9 10:25:34 2025]  [<00007fffe08065fc>] do_mmap+0x80c/0xc30
> [Tue Sep  9 10:25:34 2025]  [<00007fffe077c708>] vm_mmap_pgoff+0x218/0x370
> [Tue Sep  9 10:25:34 2025]  [<00007fffe080467e>] ksys_mmap_pgoff+0x2ee/0x400
> [Tue Sep  9 10:25:34 2025]  [<00007fffe0804a3a>] __s390x_sys_old_mmap+0x15a/0x1d0
> [Tue Sep  9 10:25:34 2025]  [<00007fffe29f1cd6>] __do_syscall+0x146/0x410
> [Tue Sep  9 10:25:34 2025]  [<00007fffe2a17e1e>] system_call+0x6e/0x90
> [Tue Sep  9 10:25:34 2025] 2 locks held by makedumpfile/563:
> [Tue Sep  9 10:25:34 2025]  #0: 000078000a0caab0 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x16e/0x370
> [Tue Sep  9 10:25:34 2025]  #1: 00007fffe3864f50 (vmcore_cb_srcu){.+.+}-{0:0}, at: mmap_complete_vmcore+0x20c/0x7b0
> [Tue Sep  9 10:25:34 2025] Last Breaking-Event-Address:
> [Tue Sep  9 10:25:34 2025]  [<00007fffe07f5d0e>] remap_pfn_range_internal+0x18e/0x420
> [Tue Sep  9 10:25:34 2025] irq event stamp: 19113
> [Tue Sep  9 10:25:34 2025] hardirqs last  enabled at (19121): [<00007fffe0391910>] __up_console_sem+0xe0/0x120
> [Tue Sep  9 10:25:34 2025] hardirqs last disabled at (19128): [<00007fffe03918f2>] __up_console_sem+0xc2/0x120
> [Tue Sep  9 10:25:34 2025] softirqs last  enabled at (4934): [<00007fffe021cb8e>] handle_softirqs+0x70e/0xed0
> [Tue Sep  9 10:25:34 2025] softirqs last disabled at (3919): [<00007fffe021b670>] __irq_exit_rcu+0x2e0/0x380
> [Tue Sep  9 10:25:34 2025] ---[ end trace 0000000000000000 ]---
>
> Thanks!

