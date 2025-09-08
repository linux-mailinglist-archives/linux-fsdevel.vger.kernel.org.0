Return-Path: <linux-fsdevel+bounces-60573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 767FCB494C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15FFC4E0230
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBF930E0C3;
	Mon,  8 Sep 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gKlTZX35";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AoZDmHvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E42B9A5;
	Mon,  8 Sep 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347694; cv=fail; b=L7LDEPopH9TJGQN0fiVCsVmcw5zpvjVR3ua2PHjyrjFpDazwu6do+efOIyjZVj9DH+Z/sl895zBoBmNuDJwbbwehuf2tK2MHeJZlvEwPTPyFr5hWnwez0PWmNXJVHXxIFpBF/WFfPnep5J4XBJaQZChAW5+IfwGyKTtvuDM3zeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347694; c=relaxed/simple;
	bh=vkg4uOpMyA1aCHZb1HdSdDvASR40lnJIYliH8rngG+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R9fuSLYsDI9lsRlARlZmzi4+EODJ2ei3GTSXo1Q7EKORrO3cs2j0RXVsFYSUxwWMNLy5lVer2tjT4dx65YPeTFn72xeK6M2eUlRGmSn6/aVyRARzDbuVPne+mryXTboYWz2bGBagItPmdwhcc3zs94YmxrmHKyUVlZkPENrpx2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gKlTZX35; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AoZDmHvI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588G0Po8013207;
	Mon, 8 Sep 2025 16:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vkg4uOpMyA1aCHZb1H
	dSdDvASR40lnJIYliH8rngG+4=; b=gKlTZX35E0jgi+T2oGvmDl3mRKDhHYVLyO
	XWixaAIicqha6bfybGvro93QGNjwmxs2PgzE8lEyPfN7H8tu2kAnBeK+mN3Tb8bu
	+R7N96LbLoWSbCgskWEbKlvUWE0cfvDl7txkeh6A3cW+7iYlI/r+q3xxQbxBQtUK
	TwK/MtpNRU6F6aKjTQmWuSgLJJoYiy8uKzlkV78DdOaPOKlo9d/ztYV/QZZ/YYOe
	1U7tJF5RqhgGt8jjO6hfKvaxj8akiOzAwKqGdZJumbPJ2t8nMMYVS1MQ5fjsW13b
	dztFR+WU9fci6EBND3MxS41ZQqqezp/QMXL9XLeulgm7U3RDzmJA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49229600k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 16:07:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588F2JEP038749;
	Mon, 8 Sep 2025 16:07:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8du1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 16:07:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn3nUg74UEO2hHeVmpil15CUNdzFeEd7ssrKMnBTcYmLgtwU2xy7kYOwd+lf3gSTVF5VOft3cIPUfVDulBQUajoxMvFo69phEgPw3/b36CYBSw3yCpnvJ9AjssCPZ5vD+J7sI95NPtDNDDP9PCC7WYBlvP/TaBmH/U7CRHP6x/ROapX4xuSG+xN+rYA5GHn7b5BgVwHOb91h5yWB/co8Q3uCyjj8r0ZK6T0GuP0hFSF2UWrmaWtN1nDdFG2VHc3E9iquGHV52FX+aCKPMQDf2Cm2Ms+cbMUbYJQdAn73bwT+hb0jrYzLvZqt1HV5swXF7CsFo/4IQ/TapVoJISFL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkg4uOpMyA1aCHZb1HdSdDvASR40lnJIYliH8rngG+4=;
 b=ZdhDmb21+qXMvBpSDlpeqiGBe+R7aPDT6YsPFwXkqmVOv3GkPl6h5MQTUlLopaiH7Fz5jgHrYXZZW7gBHXy/fU6FV1kgd89Rg2U9Ey9Xt8n/zpBMqK8zC5Ry9NbodFHV3u0gz5lZoKT2fQ0VoWLy9wgOlhYqX5t6VMRZ1UPmHo2ntY0npa4ERx7Ykvm6FboPVh0qaKpMwbtu1/SPE6Kb21NuR4GQrBferfS6xoYC/XkLunmxFphnNU0wwbtwU5ZTp3Wn++O0HEWmJ2jwKMXI/dBVxufteQZqJ6+JjvVkdmdDSTLozKRvw3SbeE5Z1dDaQrE9MCRi3RM7LByu4FMPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkg4uOpMyA1aCHZb1HdSdDvASR40lnJIYliH8rngG+4=;
 b=AoZDmHvItsMZPC+cSlHHraCsFa4YhRuc5HleEKcdzrn0qCulrujVTTH+/vmSNfWtv9UaKuIJLmJrjiLPglRKzVo52y6jziYMq35uzbv37yvXgHJQQZ9YV44aKWNjZvE5QQGKeboVV3BkeM/e2H9sfDVW+IgL9Duffd117l5cUao=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8633.namprd10.prod.outlook.com (2603:10b6:208:56c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 16:07:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 16:07:14 +0000
Date: Mon, 8 Sep 2025 17:07:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
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
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 08/16] mm: add remap_pfn_range_prepare(),
 remap_pfn_range_complete()
Message-ID: <0645c8bf-4d5d-4740-beab-10157d133725@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <895d7744c693aa8744fd08e0098d16332dfb359c.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908130015.GZ616306@nvidia.com>
 <f819a3b8-7040-44fd-b1ae-f273d702eb5b@lucifer.local>
 <20250908133538.GF616306@nvidia.com>
 <34d93f7f-8bb8-4ffc-a6b9-05b68e876766@lucifer.local>
 <20250908160306.GF789684@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908160306.GF789684@nvidia.com>
X-ClientProxiedBy: LO4P265CA0195.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8633:EE_
X-MS-Office365-Filtering-Correlation-Id: 493af79d-654a-4b2a-589c-08ddeef1c691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ToaqnRm/bjzjj+siqsMkqH1rnZ9FTjtAgc9b5AaSFYB92ozB+GMwO+aq3gSN?=
 =?us-ascii?Q?rBHY6OTJkEjvjLes8cBcbZWGL8KoR3RLSs5ciY62NEdg1vYAaF/dZixBilH7?=
 =?us-ascii?Q?CWiBWTpxvQaAsOfRbw4TYYpR/a7PHaY5NA+mlyTu3bJXVqvDsHLFy19Hf2gh?=
 =?us-ascii?Q?E6kvjSyl4U4Z4KndZC4xsukCzNFaWrSm5jGEbxYZwC0JN1FXa/mI7xsRwOWW?=
 =?us-ascii?Q?PzaSxRbgjXWHNumVyXrpSuWYzEPAX3N1ttRtrTLMEqX13vy+7gYIV45srZE8?=
 =?us-ascii?Q?NqTQHulvdjnuhInVcJM77lk1tsJHfAfvLp+lUb7o4URH0lt2FdlO3SfKuCSR?=
 =?us-ascii?Q?iAFH1DoGMtPua+RAONvfi0dLZOMibeLHwhy3vZLvKFCACgrjqX3KbKKvFTkC?=
 =?us-ascii?Q?/4inNayrVg11N0EA9YlOu98012A2dAnm3B4PPtfCCxm8cOAx4xaIyIuX8/LZ?=
 =?us-ascii?Q?CqJX/0HXzfZpDNdYINvvpfAZ3JiAr+XTvtii8lB1Jyr7TEuDzc5B45CG6Pc7?=
 =?us-ascii?Q?0hIIs/Otj6u7ZTQhRO3d3Pu+5tgHnb0XyAHaLH+1OrhSVic7v+Jl/cDEReEj?=
 =?us-ascii?Q?l27Pn88eKgaSROqop4f6iqrnQtJoY6T0tDh6Fs+xxLT4r33zKpCH0wrr4HK5?=
 =?us-ascii?Q?JrvL2jV851S98ZUDBYV3cCu8ayW6LSYhQl2iwbb9/rl88UkoGGBN1/UNjMrZ?=
 =?us-ascii?Q?8Wl6mDzIMOA+G5Iog9GZXJ2d3EnWr+YsCoxVOKUGFEhlhgmz3CEzLugS3m9R?=
 =?us-ascii?Q?hryroY6cj6ttiBVq/cbMcxthV885CfGl+Aj77N/QNhYnJIXbOVhGTSZXtylT?=
 =?us-ascii?Q?IQae7gkgKXQ6r0Zb8ZMHJRSo9Zle5qEWQkS9GG2sq2mA7ib2DpAlzfIWugVH?=
 =?us-ascii?Q?ePFQpN6zInyrXJVbrxo6JonR9CfDoCUodfWgVxonw+apxQ0hNgU4wqMKu2pJ?=
 =?us-ascii?Q?7HAxAGNu6oClY5YUip+502xqAXqUN+05XFovSmRc8ApvQIw3ioWYAnYdx++F?=
 =?us-ascii?Q?+lQetdjE0HVZks6u3xqcwyhuSTUaxva9gMm/HZSgE7yA02bGvj4c5B+ssM7m?=
 =?us-ascii?Q?40GQdwU/eSLkGaxciTVWPbWPwK+E78r6JgVv7hL3ZSfTlknYEj3K1aUhOvk9?=
 =?us-ascii?Q?1An56UlluG517WI0mah6cT+iX+yHVIA8R9PadlKPhBnZYjOQoZ0G6DfD9elb?=
 =?us-ascii?Q?13Y6pWA/fgB7zfyL9rElympJ+HTR/R+hbYUAlMH3dG/Uw5sTVMSzGTCxt1vF?=
 =?us-ascii?Q?pE9fWyMvh6uyRCMWUnn8Zz77ulSsf9ArI2TUXZxx9/5Z881UbVallrVR0HW5?=
 =?us-ascii?Q?IMwNhmlGF/qXiPD+dnQqf/Cc+PSeTc7BI8TBXmZo7pxuzX6Hnu3uyAke4+9h?=
 =?us-ascii?Q?MT4D8AwR/U7tZthqd0jjQcvR3Z431bWLfT5MzFgiJDhhIAv0dyxiayLFSLVe?=
 =?us-ascii?Q?WZFNHheLlbg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cNJt5PeE0qj3nWHlTYVFNGlbdvmtP88Lz9flstmkkHS6R9IwwlpQBFEMxSP2?=
 =?us-ascii?Q?mDnIs2Kx1G8UZ8RFFBK8RRsVRBmWwfDbJSFrsLb24QeMRcxTUh5Hqu/OzfbD?=
 =?us-ascii?Q?nZ5d6w6Fvrr9ojAxziCHtsZ5Qe06/yE0DWoxuMfbL6/G5SW3oscLTFbm87bL?=
 =?us-ascii?Q?ndqAenL2q0gnCXCI2RysrePPG782vAd4NOkeaO6/KmfcT+uXid4eICBx7xJy?=
 =?us-ascii?Q?odRtGP0naf9KZ/9c/eDc8sDkjGVg1wgNBVviL//788d+H2KGAuizNHahcHGQ?=
 =?us-ascii?Q?XQcs6tPfhC+8Go/vZlCWjclyc6ihET2qrseh6uWghoVKw9+szb0qTpogWCzN?=
 =?us-ascii?Q?K/Ys/wZJGQP1xQBDtt8QtXqFrSyFEyR7zO2vag6y+oVSISMdTvAariK87wsR?=
 =?us-ascii?Q?hDO9W3QjQaJ9q2KxtZkPDoJ3B+/gicqB3z8WvXsWC4wIZwFhXLQhW97mbeB/?=
 =?us-ascii?Q?E85I/dq2b5nMYTltp3kq9pswCPjFL9Nd1Ionr81+mLzJT0whc+tqWDR7TpVv?=
 =?us-ascii?Q?JrzaKLZ/s44GobJryMxUepBZvum8pBS+4QFvhdWHKbyNclmQRKLTe7Lr3dmW?=
 =?us-ascii?Q?5ATqr/lehsK1EN9eUPKZj5QTu+tyvdjNMeKNvMMqWCYsPAUbRBx9JVjT/ugx?=
 =?us-ascii?Q?dnMOKHn7xkClDW2Z9kNOGVWGlRluvhUXLxvFvHJf9Qvk6ZdLGkCoLo1HBpPd?=
 =?us-ascii?Q?ByMUpnrS616+dcblkPlkzFlIqnN5yzbPYCBjg4GfBwEQ0GHCP0aTZkIDO3lv?=
 =?us-ascii?Q?7nYjPMk+SdAqZzyQPR0LwMzGiHT5wKUDk8YnIhPekRhKLcdcup2K6HQ6jrc6?=
 =?us-ascii?Q?cAiLmxiT6RPg+Nvmic+PkhRcot+f8bgtLdE8lAYi+R8lvOyddngPZXz26V8x?=
 =?us-ascii?Q?lyHBM5ntfELs/KMxbL8yoO2eFKOqcIabOmpkbenoILFYJ3+60IjZyUpY2WE9?=
 =?us-ascii?Q?UtX0UmQYCMbuZ5Clb4SMgjwqXbaHz85ddSn8gw9ibt4LPsNkU5BTi5dKtlr+?=
 =?us-ascii?Q?H7BadYDtMKYqI0Gz6x5m6vRTq1XSWQItEP7+wLng9kamsY3bSJ/EMESHjp9U?=
 =?us-ascii?Q?kYW4z6/at+Q0fB4QfKfwW7ZPxFIPi7/tiwPuV+jLoECFuAax18sm1xJTXCq6?=
 =?us-ascii?Q?P2SjWC0egmGVNZCetVlcRL6f6RLWtsLesjdVhaSVbuulgpCkypKOsZs4QjzM?=
 =?us-ascii?Q?pdbipKuxbdSDw5PG7bkXD6skMUSavVH1XrNGdw9ABANueVj9vJWViLYkByhF?=
 =?us-ascii?Q?4bI7xmLhl5Phuf+HxBHJU97IfD7zBBcFvXUsbjOEIh7dtRftAu8iRlQGruie?=
 =?us-ascii?Q?omi6vQD6P9OeD5DB1VD33J4f8wrbRBjLuv+K1eBG+y6vJX62dX6JKcbyxekl?=
 =?us-ascii?Q?RUYg0McEZ+vU/h5LlVw5XDnPT2dGV8JW45G2/AGbhkTF3s/J/Zxhf9Xz4mc0?=
 =?us-ascii?Q?20Cu8FnRVnbB/fhl0J/1QCdDG6naLRiY09NcsT8HM8p3ps0yt20VT0bQafVe?=
 =?us-ascii?Q?ch5u9YE8j/pmWjKZWsCOmyKARleUkrvkSsN6RzMQv3Mq+nKoGZpPd4fiadWH?=
 =?us-ascii?Q?4YBjk+X225UkOYmHeD1ZCd6bEsE+cC9SHJ3ifW9WZiUcAAAUf3Zy1Yl3zSgN?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vtFwPQivjAv7gJ0UbWRZ8AOUrkem02rfgj+IxLXHV2t0f7ig8yiO8/WvnYJTHT7odPcWwzp8E1PRWB7chNg22xZj0RasVEFPbQ15DZL6DcPATQJUthPOSGX3uTD3y6kIxkmIAzio2tYdM3bSdvt9Ukjr8BSR1xgSrT9ZePgjDBRzHOu8mdQqJpiVHyQOI3LsvDkf9B3Z8TGazd8fJAyGa/MQttywCLAMRbtg+VKjbB3fHjSPG/yLhgPLeFOyQBN9bOhTlCzEoxVRcCGMEUmbe7Td17uDZNeTViS4u6xyxtECXWhj1wGdW/pcxm2GftH8xqnMCy4Zn/WdvNqIxpVHL8Fae8RukGdFqL9w03Yb/JZk3CYr93cE4T0lzxvy+eCxRGJl/nN1Wt6GzsBZYCVIsYp29a4kZc4842fbssVEGy+V1TtyoL2g7wVlrg5EjyBJ7lUWbsBQcsY+L5vcddH7HebGUT+UsP4dvkEoJac4zmnmOw8ALOb3SgMOeIB32w0I0oOk6mT7ZDdDIxqvJJ88Z6PzCC+VFK/w0dzmdFjJxFp4BcxrcrxQ5NDulnY5g9YorQK7XwwPgVnEnG+VFG2UahxwrjSSwFHNO6M8Vm3cS/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493af79d-654a-4b2a-589c-08ddeef1c691
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:07:14.3140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ie21DXoQW5M6lSzSWmTXXOXPW5v7O6Z6wfiPsGyCyA4VnlrWBic5WKpk3BRYsdZyb0gVocDrumcaXvcjCjYQEZgDnUnP4aUGRECSdQfIGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080159
X-Proofpoint-GUID: Tb5rVtfug95g8yho8zarM7jRfVMeBtv4
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68beff3b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=E9Rh5klarhuv1F7PEQ4A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfXz1vcXODyiIEl
 xak4avoNNLhEJDnHabTH2CvsZuB2CkiOaDsQW7dzG2p3iqVabQWwqFGZkvmD+ZdG1FpJB8U25x7
 khEWZdgKpFmAdzvkTRqZAHLg+3GnPW3XiH7yaL9c2ANpyjghKdxZWwyzBIQwITmHDY/JwFNuzhI
 KaqIEZO4LfPEYweQraUD0EGJBN6RgPZlWNe3sMwMTmCwKdIhzSSDyGPi7ZccKTbRD2baRI5xBO6
 fpSPD0J7QvWVY171neJCNb5GDxdftEB2K+P56oK4qzBpoMpZDKwz0PkCkGjXQ4hLj7WcZOu0o4P
 pdabx6HBhnj4vQmrFWsc2NlIzLlx+VbhsmYEp9yj0sdB+Ie1tD5HIN66oVVLUwl6URGM9NQ63ji
 4WN0S4zzifX9ZDPrPnXYj4EGA6nUCw==
X-Proofpoint-ORIG-GUID: Tb5rVtfug95g8yho8zarM7jRfVMeBtv4

On Mon, Sep 08, 2025 at 01:03:06PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 03:18:46PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Sep 08, 2025 at 10:35:38AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Sep 08, 2025 at 02:27:12PM +0100, Lorenzo Stoakes wrote:
> > >
> > > > It's not only remap that is a concern here, people do all kinds of weird
> > > > and wonderful things in .mmap(), sometimes in combination with remap.
> > >
> > > So it should really not be split this way, complete is a badly name
> >
> > I don't understand, you think we can avoid splitting this in two? If so, I
> > disagree.
>
> I'm saying to the greatest extent possible complete should only
> populate PTEs.
>
> We should refrain from trying to use it for other things, because it
> shouldn't need to be there.

OK that sounds sensible, I will refactor to try to do only this in the
mmap_complete hook as far as is possible and see if I can use a generic function
also.

>
> > > The only example in this series didn't actually need to hold the lock.
> >
> > There's ~250 more mmap callbacks to work through. Do you provide a guarantee
> > that:
>
> I'd be happy if only a small few need something weird and everything
> else was aligned.

Ack!

>
> Jason

Cheers, Lorenzo

