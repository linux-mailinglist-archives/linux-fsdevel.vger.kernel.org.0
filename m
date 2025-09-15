Return-Path: <linux-fsdevel+bounces-61297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FCBB575B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D245D1889005
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 10:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D05A2FB0B8;
	Mon, 15 Sep 2025 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zbqepl2h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lNOx8fG5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BD2ED15C;
	Mon, 15 Sep 2025 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931028; cv=fail; b=foDjzk6VEirnYtGRv7L8qSjVZ9D2P3l1fTm/rO9gJ+h/pw2stn669X3xhZuIRJKkl/Yp0ikK1reZTxYOraCFnqIY6UuhGbgUUh5KX/RQXKYKgPYh8lfkV39JIv+T3868etfrTiFIRDz/4/8dnwkH6sI6S2cwdxiIJy1UZUhhzsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931028; c=relaxed/simple;
	bh=b9KgWiPd4u8XatNDlMFt16nZZer04YsBkcUf0PrIcwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HdHhaDatf+7XYNUWg1ReZW4htIpxTjuRvsoiRiJosOGVVEmj8FtF9rI6MwspZzIK7Xtt3XCpSf2RbZnLbkCliqB3Kurn+q5yUNBUtFr7uN0I2WXah8+I3Q+yWiNhh0gUiON84zti31Wi7LTI8HtAQstg98AShwswpDuIcWQWkKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zbqepl2h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lNOx8fG5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6fx20018066;
	Mon, 15 Sep 2025 10:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=931YDy1+BLx2DCO7kE
	gLsRNIq/id9/0hoehxfKwHkBA=; b=Zbqepl2hslpy/rd2fFOB8BGtVrkP2Ehcrq
	5HIGfM4WafYuesA6GNoSU2sUwl2eVYr2NmCihYUtJAEEg1YPxolKI0OKEjq7Pe3A
	v+gonVoy3op+8kUNfXDEWxHwGpDCiZtxNOhQp5KHrnl2UVJbQ1jvf9nbPH7+Dsqr
	3fD9W90i5EazsZ8fxIG9qNLzlwcr0iRNXON1YnmusNqSz1w7JfpLmiVJiXBK7Hv+
	i6GKlIAQAJZXmJzZ30T37T3EKIHISXlk/xwUhr7XbhDdSYAIpdBSW5f7kErO3jQ3
	v+MGytV8p/5UQRTHzdo1C7V0GcOwsbqrQowoqqJy4C8hfEbapS6g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y72t28x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:09:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8G3ZY037281;
	Mon, 15 Sep 2025 10:09:36 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2h2ymp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x68cyyRpzzmYZtQKHTwlM+NAACR94lkqcmx+t3D2jrzFDfLH11FDmi28/8ZPqnkb+nPu9qSKTvWRz+QxjiWjTNld46pZmywb1lZpYSYkarKgzbUGSt9mJvk7nGY3n0yOVYkPeFx54X6nmwoANVDEkeo8CqsUP8ncHXClZXUEnXVnoVZsHTnzF09m4VcfsaWbCWbXgFl0Y7VL/h8QKICHhAy7bbrHD0EwwGSPrYplRl3MvkXT9gNZ9d+3wVOj0eT0bFmg9OQMnOeBxV1vR7Gnj5JXdnbtVwH0x4ev1yCPDGHYTuhSpM89zpkKTSO/UZP7rgI/LR8QDsMOY1d1/9A6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=931YDy1+BLx2DCO7kEgLsRNIq/id9/0hoehxfKwHkBA=;
 b=t8797E3Vl9IfzXJNwgIlGEfJIzZ9NdYz3aQAdKw1djh01O31JZOh32MITVVs3diXuIrKqVz2ta9VwmNYdJCA18iKJikHyXO9bsbkt/XkSh2Hf8mCBiG+tdL+PDjGCbxFC64daMeOyp/+xnDT/VkChvHaztTF9nTkndfFKyXzCYTt1Cw9lBDucJR77c3G3aw+pbinLlToptM3xMWu2L4VBmy+yXp4H0K/DsKGBQChEdqJ5t6J8wPRTyNXjh/Jl7EnDQ6zAkEUKdHW57/A0VDocYi1PEXiJXqd7+bhyIdFa00eHpZ91PNP91DS8lqaGLVKDP2HX/khKLJwGkVfkST/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=931YDy1+BLx2DCO7kEgLsRNIq/id9/0hoehxfKwHkBA=;
 b=lNOx8fG5HsLnK5vZzPn/vx2NT6LzFBUDg1uFhcOvETUb0CxlK0k0sgae3p62+D5Ufr9ImryWco4LzERjzDKVDOtS8tPTQvjV4zOMYMWJKxUQlBPr/CwFsF9uLAavidHbPO2HR8aNf3xmKYszjnkM37QTgQ1KXOigDbP0tCzX0lE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFC31902354.namprd10.prod.outlook.com (2603:10b6:f:fc00::d47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 10:09:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 10:09:33 +0000
Date: Mon, 15 Sep 2025 11:09:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
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
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
Message-ID: <4ce3adda-6351-4530-92aa-103acf638004@lucifer.local>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0388.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFC31902354:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1009c3-1da3-49ef-201e-08ddf43ff7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aING2/uF/9xBoXRk7H2i0ddV9mVhiMHC97Pg2inPQ8YFjh881Dfd9Om4xY/D?=
 =?us-ascii?Q?MAi+EyhnFdBnDhUhtMl4rUwZW+Ue3kDrbUJJoF1DgL9DyMDYghFsUFDrXAp5?=
 =?us-ascii?Q?PojRgYH8oT3QAUK/TfzOUPS9/7hozANIkrwzEQbyqa0JM+0g9hTswTfjmLV8?=
 =?us-ascii?Q?b32Zvz6Mb263WPPDBPfRhM9kO8CrtDf24s3HvANgDkYIdvfIHwiuhGJxpgYV?=
 =?us-ascii?Q?xxqUlvPmsE/vX5bX8VYptpcCXndydkLD8gfGTj1yaNFSGKnSsdVE2I7szQSV?=
 =?us-ascii?Q?wTfI9B03Bje+WD8+S3OSYWO0B0oT6KC1gNcmLlhIsnyD/Xdb7PZaQuMVVUO3?=
 =?us-ascii?Q?x6cmOStRRU9sFhulEFBV1muPehaDwt1yyS4dBGK6Iuq8m/NFzE6nlxghiSWp?=
 =?us-ascii?Q?sHuVXgqgeUzpgB98s0f0COPJO4q+e+LRtffc/d082cycsuPYJl/3o1v3o0ZZ?=
 =?us-ascii?Q?sgfo8L2SD697Ldrh/HbpTwYX0pJbhHu6X8nSNKiaieKhaP7GBRRClWyAH9wH?=
 =?us-ascii?Q?lw0nnLBfZJt3X9v/fhQbMns4KPOQEdMzWAIqgC0qa0DHEXA3EsMNtPCMN2E0?=
 =?us-ascii?Q?aYxQ/Roi401kb3mXQuaCmgP/7V6yDZ4c5SiDDiL4p6Ke6DLnQ0eyan3bpWSP?=
 =?us-ascii?Q?pQJTmYqEGnBBlGK+y3BD1k+AwbUuMxv6aJdxBVAmTdf8BnaoU7vJJ1Zm+ADU?=
 =?us-ascii?Q?MFEUaQY3DlByZHHVBdt8EeTgA5QO2h77mlDcm7Ck1js+3cRLjAIx9j0IYnCu?=
 =?us-ascii?Q?VfPS9/t/hMrtTVAKV9GCNvpBwxS2Jjm/+sgim0l1BBo/hUyyXadMpQHlF9WR?=
 =?us-ascii?Q?v9PzSyOM+Vd8NXfWlHYgGE10iW5k3XtsJWctSDNuXQNg/rLStAYG2Dn+I6Jh?=
 =?us-ascii?Q?RjsYM0GLXaUcjxpiRqJ+d1oXucJU58GaWlYEx6ci3K6FbnqMqX9Z3oYBd1/g?=
 =?us-ascii?Q?4DwZOtgsZL/IRcJwfgY5ImtYLoEWdcAVq50G6tQtT9xL5TxZy3WhOy7Eapwe?=
 =?us-ascii?Q?1IlV9DpaE6t6Wfv+iQOYjWuLbkvHjtoaH3pf1RVZm3lTm+ou5qs80yxS7zcf?=
 =?us-ascii?Q?2zGsQwMQAWIEHImvCVP9xtQA8Ly3cg8BA/+EkHaxzGtqZsvKbdlUqWN+c5n5?=
 =?us-ascii?Q?4iidcMpiR9gjcWseljSh9LE0MNAb38qHt2Cjf5dw20/ing89QZLLiPJ5EVQc?=
 =?us-ascii?Q?g7squswM02Tqmd9xlFQP44so5ps9lyc7rdxStmGx+Jg+kWpeBNtiejQ8Gw9U?=
 =?us-ascii?Q?Re+JKxiZSYVLPNQNAP6DSh3eINKi9DbhR2kS4AzY3kh+D3QVCGutRnZoEaKD?=
 =?us-ascii?Q?m91DMA5JzLyrnbZp3IvXROdW8Cx0nnB6uezoUO1xKPdAr8g6vS7EaTSStfkK?=
 =?us-ascii?Q?FtzfJh/50zt2Bf6W4vo35LIPnfsH5OiG+dQB2ZzO7N7A1aTopIeoxp8jEjFI?=
 =?us-ascii?Q?IZCfzGL35nE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l5SApZcaWgytmT+O2wdql8UrhGWK1KHYPEIax7WFvTzbxvcQlluCU70UsUUn?=
 =?us-ascii?Q?w8ibQ8DEcJOvBnTbfadZ6c8i8vmNA2UyrIjMQUdQWzuaso52EbUeXbZ9s1ex?=
 =?us-ascii?Q?8dnqRTKuVAK+uvfw9d1TkNKfubmer/dqvZxvVjSOlwo9MbBu+Q2IgeVqJ4O2?=
 =?us-ascii?Q?sboZ+vbTYkiFvLayyX4xaEcHOVmfu72rKyOXTsgMSexQDV86N3/pFsNUT+TO?=
 =?us-ascii?Q?bTtKrSf3M27ctv3c8mLbZG3bSw8fs5ZHq/8N4pIAO3b5R5gOXHUq/GzzOEcu?=
 =?us-ascii?Q?0IkueSuXLxm3wljOBPA/moMMcP84mSzsulsVmYP5c0bKGIm7bQ42pHnR3a8Y?=
 =?us-ascii?Q?vDJWcZckY18JEb1CKNJjjaP8V1RVq1yi/6GIoEBxjsLI5bu7ZtcsUqiLZBJr?=
 =?us-ascii?Q?LjX9npjEjd9znLMhVxPvM9K/pfx30k9azDzlIh1Vp20q1z0HFkcOGDvSm9ON?=
 =?us-ascii?Q?dWdlBRyG9Rl2ZjP8IdLgOEz9Dymoa5tJ2UZfAto0+V1oOAj6StYErL8uySWc?=
 =?us-ascii?Q?EZ/5AVH0N0BO0jNrgIcjP144MuCtrztrt8zHZyfpMTpInZWpCItlJPhCrtBT?=
 =?us-ascii?Q?QWLqBllGB1pmSGDkq1OxyxG2OiIvuZzLubl+DirxRSojm62NUZ4jBJmpEyxa?=
 =?us-ascii?Q?JY21JoL5Sijyme6HlQ75b62H4eW+yBcSwo15xbs94EoFT3nIVYV/Ox7D+qJn?=
 =?us-ascii?Q?zHNX4h6+4yCDQ1dFmEtpZyPIFQSKJanLET03bTf7fyIUN2Y7LSQ8aXxS7WTX?=
 =?us-ascii?Q?u/VGt+0Pn0gQ20HkuJgoCYjrIuwYP8VUtDKuH/RulHBJCa5gqAYVDe6ypMXS?=
 =?us-ascii?Q?Q/ZgUbxsGn09JEtkWXNekAZaeV0lm9JAwevGmvH17W/EJnWJU+UiuOkLsb1B?=
 =?us-ascii?Q?A2kxM02FnuvnAhTYVBGBDFkWH5UPxlSHj9vo4U/VFFnjjSJLM8URdrPHrUkj?=
 =?us-ascii?Q?uvCV+pWICpT/7XRGWHcRXPGpG9Fr4DOj2QCpeXwSCqUMPd+sUBMaDpfNWJa4?=
 =?us-ascii?Q?rpBBL9qE/jt7z/eb27rP0rMUXBtPY37IBT6fk+8oX1bzzTYRpPsc63V1dj66?=
 =?us-ascii?Q?zgKPnh/TTEcXiz8hy6c/+E7xoO12NhDZlu6w+p6tAookRCkAICDJPj7v5/6r?=
 =?us-ascii?Q?av4SQh4aC/nzKh/N0i0zfRSjb8zhv7GWM3MubDsOG46ppS7S+W8PnBdNzqC5?=
 =?us-ascii?Q?U0QwI5RSMHDi/wrMFLxup+WMBWTuo2hNY8xlSLQ8HEKIjT+Dnv/XGzfCVZeV?=
 =?us-ascii?Q?s/+vi/B6SrZ2g/g8MQeThDrxE6BN6q2DloXzgBcfKKOXO0P8EhnDxnVUinPA?=
 =?us-ascii?Q?OFhCfn1DdzKsXvg5W7EdYWbR7cnzNwZd6SRzqJnDg/1szyl9xFWmTlmYJqeb?=
 =?us-ascii?Q?KHA96B0vHh7AEW+GmdVaMJs0vNfSPHE9hqOUxlpoJAL5WEVLcM3pnxqugU2+?=
 =?us-ascii?Q?9p3qqxTtyaQk1+4+oonoh4lgMxgFgs96vDXgm9bvRFW5eFb8w9XW9YYyjsST?=
 =?us-ascii?Q?zPCSY6fA4AP6JacrCrhCHpPm9rnENviAjUDjlFTx1Q7/rkYmsu4jN8+rIh8t?=
 =?us-ascii?Q?A7WPmzEPpfeVp/p0RLSebPaBrxgiHOZRwRCYmuGR2Xf2mBc35EejGpGp37PO?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	StCnvRVbVCrm2Eh1wTfqSl77MHmLxpTG2WVF8CHDM+LYDDJY6BM0uR8+MnTUXJXcU3J/LsvwdEEEg6LQd0j5lcI5IJL3ypvRXsCk/mL/asz+Yak4j3z7Vm6UQ55hc8k3ViNvy5iXrO4/ZbO2AY9F3jzVdRpQHxQxot4FQato1u026i3K+c0TOGZ8SMpiENk/L2mhP+c5HhnarxnM1vZ57sN7TRamPdAETey2puRa3QY1z/ihCkJVFnhIyZzrEF/cmq2vX/fFpJLVKoxQPnYN7I5Lt+HnAyKTZk3BO80gux97U5o/pQ1t5wtQuUsEuLBE7VtRdbdkrsXHck0QP4dKVvdFqr6c9+sTxAXqG37nRMM5l2TgRhM1aBc/7fOhPJNpbd9WmMeZqnNtUUaio99+BX/0CbMqlLiFuNHJHsVaggyuEihGFognfYHK40ytCajum3CpfYgX+QI9dj43tZnIyxboP07xKUYdBsP2B6gNZS4Ukq6v2Jn0xssfjvJeJ0qDZ09RszMKDyh0Ynu00pm6yk0xV9dXdaqtnN8uJG4K3h90NXUhtC/MmQ3sGflJ9vcITLg5AjJSt4YqP3WEYw5wkAIm8jCaa84ujfJ63w0oAvQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1009c3-1da3-49ef-201e-08ddf43ff7db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:09:33.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MADsbPSpS1KWoILo7RcPc1t1iZe23xtMss1u65s/iIdjedB0fThxMrlMYQFl5ijYj8+6MOkf+ou9gUQMWIs8dRO+1jgTb71vq45lZYToSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC31902354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150095
X-Authority-Analysis: v=2.4 cv=F9lXdrhN c=1 sm=1 tr=0 ts=68c7e5e2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CVgPsPjdnkoEphA2I1cA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083
X-Proofpoint-ORIG-GUID: zQsXecpqG3qwOmvdKedr1kkNTKk6oKcx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMyBTYWx0ZWRfXzNPf6sMEUueM
 zeMPQRgq1O6ORT5H7qAKYGbLks1qHTtx4impfrL/Ho8CsIFsKPKFu5jwmYJr6PjLVmt7mI0yovN
 iokOtVO17zDWpNdM7EBtH11UTuA9eLUyaCafaqWlWnGOrbUyLGrSX5Mn1sZw4ywW2za9O4b0sXP
 UyDofLf6yD9UXw0OZspkMeTfhCTIwAzaWIbMjPAHoGf0Wf8Z7JgVXCV0sQ9t3xY4RES3mOVs9Xc
 aOYorZG/iJh2GQD+sgkLCJhv5sgtDhHtCiQfkildv6gPjGmJbHmFXxduYNXbKtB0uCVTLK0/Pv3
 TGGtG95OTruFrU5UzQqW/0uzLXwBr+/KGOWDboQaCxX1LCissZZgjouKIDBeeYgGMFC/deqeyPS
 uAnpD/WIGkZnnSWkb6BrJ3+YN1R9pQ==
X-Proofpoint-GUID: zQsXecpqG3qwOmvdKedr1kkNTKk6oKcx

Hi Andrew,

Could you apply the below fixpatch?

Thanks, Lorenzo

----8<----
From 35b96b949b44397c744b18f10b40a9989d4a92d2 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 15 Sep 2025 11:01:06 +0100
Subject: [PATCH] mm: fix incorrect mixedmap implementation

This was typo'd due to staring too long at the cramfs implementation.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/util.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 9bfef9509d35..23a2ec675344 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1364,15 +1364,14 @@ int mmap_action_complete(struct mmap_action *action,
 		unsigned long pgnum = 0;
 		unsigned long pfn = action->mixedmap.pfn;
 		unsigned long addr = action->mixedmap.addr;
-		unsigned long vaddr = vma->vm_start;

 		VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MIXEDMAP));

 		for (; pgnum < action->mixedmap.num_pages;
-		    pgnum++, pfn++, addr += PAGE_SIZE, vaddr += PAGE_SIZE) {
+		    pgnum++, pfn++, addr += PAGE_SIZE) {
 			vm_fault_t vmf;

-			vmf = vmf_insert_mixed(vma, vaddr, addr);
+			vmf = vmf_insert_mixed(vma, addr, pfn);
 			if (vmf & VM_FAULT_ERROR) {
 				err = vm_fault_to_errno(vmf, 0);
 				break;
--
2.51.0

