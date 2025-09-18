Return-Path: <linux-fsdevel+bounces-62086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACBFB83B7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 11:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09C9C7B525F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 09:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82D630103A;
	Thu, 18 Sep 2025 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NhJZ56zj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ica6ggx9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7853002B7;
	Thu, 18 Sep 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186785; cv=fail; b=LN8rXsbmx+d78q7jzoKev8iEByDl8ssABK/zxpaN7CfG0Tjx6l50WT6EN9COINIy6q05s7hu/yKqMEYTkruIIUakuRxGvq4Gczb8BVDtZJCVRSAfdKfFVw/qUVZNZrDTSekPH28+/umeiE84d/pCh+JrsY7rQpW4dbYLfW0ITag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186785; c=relaxed/simple;
	bh=iNd0WUCDjsOW17qHGBhA+LBNRg2yQiMI849y+UhBDPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dm8NIFpB/3LBlbMc/9WG5jp2G0AfxXWpLi7LmQbNhla1++DoasM/sOrCJiqocV8BJOtNR2cL9Vr8Vt2eIJLAiWKVd7PuNYQevo/vk4Lb3+m5p7bqAz+HLFZYgTzb7qFlJr85XAaykP6nkXDj0rZkRIs9/eQgWVSshLXw9R4I/Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NhJZ56zj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ica6ggx9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7ftMI002490;
	Thu, 18 Sep 2025 09:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4XV/YSwwCubHadBNTV
	DiN9OAKiJyfI2V0Xa0jt+E6a8=; b=NhJZ56zjnuE7i+b/d3nAKSTEUDcpSZqCaP
	Xa3CiosOkIPA31bKUsr/PoZQqmxUK3MIithlp7qh5MUWH9frN1krHXlmhFLsO9aR
	34MF2i4n1ECKo6m0dKzDaEiLUKueHqTSMr+N/mxp0dXSQ7lVYqXmZ57g2FiwfCwY
	McAyEsbbHMzscOjVR3aIT68Y0tVN7B0GAd2ZFAnpt8CXIUJOh689us46hA3rrRPn
	aczBpaQP40sK7Xj/8SlxBkQX5iXH0N47hu6NCuxfay8FSN02/sHcVdghaCuUkHvA
	YIMogWpVTNXoTLtOJoNonexZBVJ0s+s3p0SSxPcHOBybFx9uG4zQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9319s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 09:12:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7uIMx033667;
	Thu, 18 Sep 2025 09:12:16 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ets0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 09:12:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqfWpaEEvhLMQH3x6TMecUtPYmQyBMoMh5JZZWjUvebgcq47YWSfC9tXQ93akfei0Y0/+gTnaExgbKPNR5inhdYlf71+B6wv3lnbfBLf9XHtFfJA3j6CA+QD2HNJLA4Zb/IOj2uaxYB3n0Kw/VZXG0N06H5jbqoF7EEF6wSH3vaHlRNgj8V53W7H+YjxrMR+ax9ILTs0Ude7L4/BLpenQuhOw7DTh3RJqVw7eUsTHNjUEq23BUKfi0utfm1bGcizomYbz0AKYSMdMp6z9fVvx/SzfR+Qyj69esEVZSDBSxX8RQk037fcaO6V+k/+0DYaMgBjSE2qqTB0l5wVb5u5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XV/YSwwCubHadBNTVDiN9OAKiJyfI2V0Xa0jt+E6a8=;
 b=e3UYAmcrxI4EN4Ku2oOg92w3a2f8arlQLEFmHl9wE62B+ofSE8CMZFrIOeVN0Htb2hXdSigOBbZv+Kf7C4n3pY2aFSJHVvCY9wK7Ypcx/jwlEZGv5m3tiONBl0NOFQI+cX/MzeICLwa+CRC46ySOqFoMqS9h2Nd3kQz+VFt1fE5s24RTy7/OgYi/tVnxlUQKOYxkj1UO0iM0GPc0Uh2vgE59MEIgg1dF4daw98zutOfZmOllrWANsF92oXWSUCJqdx05PTQGlY7vdw9/X36jMDooyt3I4w2QpmPeCCw7EatZM+wUNDS6WlszrPw+ZDuvQ+rpB31cdtjvRDe1NwD/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XV/YSwwCubHadBNTVDiN9OAKiJyfI2V0Xa0jt+E6a8=;
 b=ica6ggx95kdnZxlrESYe2bEoFSBgo24JE/phK10Ci0qmWXSkV8avf/F2bvUTVqyz95IukT35BE+HvpqIlLZqidaBT3EV9ABt95SnFoDgcFe8kOdBYIdIof0hwj+lsGIRBNS5Ico8uHWglPqyRVB0YL/Y6AjJ9nQhyLwzM/OWFSk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB5991.namprd10.prod.outlook.com (2603:10b6:8:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:12:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 09:12:12 +0000
Date: Thu, 18 Sep 2025 10:12:10 +0100
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
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 08/14] mm: introduce io_remap_pfn_range_[prepare,
 complete]()
Message-ID: <2cf129c4-627b-4a78-9ec3-cf43c95cf17d@lucifer.local>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
 <cb6c0222fefba19d4dddd2c9a35aa0b6d7ab3a6e.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb6c0222fefba19d4dddd2c9a35aa0b6d7ab3a6e.1758135681.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc0521a-b371-4771-5109-08ddf69373e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YPMUMS9SJ5G7Pl32cKc247A/E/8qeylpqC6U4AbOiXCOqtolfsHCGtquoqQl?=
 =?us-ascii?Q?SpYTxYCi94H6YmekVFHDurIPSyr9Al2pRKtBRJWgzNhWD5NVDzFxYQ5rP0q0?=
 =?us-ascii?Q?KiRDTXbq0s5rlfgc6PRlwVqAjNPltFwPGMcZUv0ol8U+GJHb7qkX2q+pPbok?=
 =?us-ascii?Q?1Gmok5RrnD8ch2czbuYSYo1BEcH69vXbm2f+4AXFaQgy3dhJZp8P48LvW3c+?=
 =?us-ascii?Q?fIzt4wQ7K95gogATNqdrxX3FJA8YOutfIUzBQIXQsMmioCabp+wyHqdCpF3o?=
 =?us-ascii?Q?IPh5ZeEVfiLtz634bzfwBmCEl1idtKwa+iO2Gbzd2nDvxRGJyhoTvr+6DouA?=
 =?us-ascii?Q?Ddgd4ZuIBX8gbaATMW3uwfLj3ZFWBWHREkdUaNGQ8qXEZ9PUnLK+l4X1QTKk?=
 =?us-ascii?Q?4w4TSsLuHI1wJS1g365rMrRq2uJnRIjfm/psFcQ7S6vo5Z7jzf2ZXFesC5/E?=
 =?us-ascii?Q?UUMHraVwCUX4nLXEFcpQbQWdPM3JTl3gSlAuaY3pQiIAfT2V1iwMc3WFZtAj?=
 =?us-ascii?Q?995TWmc3ORLi/Pr3JKBww0Vj5HZbLjTCgA3xUaEBWy2EDpp44CCYfko7Kbkl?=
 =?us-ascii?Q?VGTgIfg+foH1l4wLfMK5YtYggSfEd8oTCL9QJ+R8xmXFeoyHJtjXKkzJYEzl?=
 =?us-ascii?Q?Ryjo8FlIMGD69TPjhC9PInTVrOVPCXwavLwF7qGzTN5Yp7thkscQc7kItCK9?=
 =?us-ascii?Q?OVp97XLKot+LfloCUSkg3D2y3K+0myOlPOKE6R/fInMaUSh+cDedGboZGijB?=
 =?us-ascii?Q?wCL7tr+zJpGIITa1Hdglgy2R+SaRQAHYNYN+YbyWV3DvdBcnuxNVcF64+zZr?=
 =?us-ascii?Q?+5JV3bF/8jV/+PXKdf31bqegG0Vq7GDNYVzt+tsyS2P3dPUHs+bRBGCsSDv+?=
 =?us-ascii?Q?h+mvb1tqQ38Vcl8oLNUZijtM7eMEfCoiFXaatJUk5+PTACXCqQn8MsjSVX+4?=
 =?us-ascii?Q?G8UgVchJyc7mGD8bCRtT6Dahx0Xn5duUdaIHpOyKQFOqOiZM7ejFj2rfZF8Y?=
 =?us-ascii?Q?KDAvEMnJ/GVzvMATVXugGzYqZSWicv0Q0NSMpX11QLb//HcD3Mp4YYSH0uid?=
 =?us-ascii?Q?F0pO4wJ4nBczxJc+ajNS6kZGvhQA9ReB9KE6qeQBXAT+19WoE7CE4xCE/eci?=
 =?us-ascii?Q?ZU13OG7hLAe8H9DC4kCPnDvtsBgFHwLiW0WDoTx7WtMeyynKJWanm0pF8Q5J?=
 =?us-ascii?Q?OUq351i8opDKSbJIJhGFv4L6/lAQe+jiOaaOeEd9Hy0lsWFSQOXsknXNeIBd?=
 =?us-ascii?Q?1dL9lwTnZqsdOMA9UlZ/floAYe6pwD6QyO6cZAO3OL1vQcJoSUzjM8hfqwIW?=
 =?us-ascii?Q?bywRe4dvmlmt0r/9GkkXOCjpz0womlqsT81na7JxgCCXRRwaR73g4nxrUDBL?=
 =?us-ascii?Q?rW9PGPfTWN6bY+JQvI78KLmAjfpDVJjY69U08AcAFrEILT0WLtmIy+0fqLWR?=
 =?us-ascii?Q?ep8hraEs4vE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J6z6vH2/B63KCzRf1oXGXILZVJP5WUtyH7dHiPn7/7TdbEikGCzBsdmUmPlN?=
 =?us-ascii?Q?eKJIRQsr/YlgqJ+mdx9tQJf/KR8TDwtw7rqp9y0g1cAKqpj2XSGyKUlR9Dop?=
 =?us-ascii?Q?RT2KtJ31IPE9QG/r9HodgZsESttHZW78pmt5Hfwa7ivawexQioCrYejvnH6A?=
 =?us-ascii?Q?kcxG0pD+AGHiPQCFXStsVYZwoi4j95t92iuMoKVYgEQv+tOVFGu+QRRERHTj?=
 =?us-ascii?Q?RxyRZzkfWngwVL5CSuEfpcJlmeFxy4NkpmxVNOuwggdS28fFs1zuAcWipwv4?=
 =?us-ascii?Q?ihTxatwUCmNj2XH2jNBeFEK80/Rx4oXyg488U89IR2J3HusK+Kw1XxWy0EUe?=
 =?us-ascii?Q?YPABIgti+Ea9ehhvMdxCz0rOxhhxy7eucx0bKUMtWYCcSVIWl/fNEU3r50aC?=
 =?us-ascii?Q?eCTL33NsjMybV45LPari0M8TMlS6aQGlUwsHb16WUgichCCOlVeEWPP+d9NE?=
 =?us-ascii?Q?xQFh7yQzPsxVTU1XNg13Oc1e9QwBzVMsOdQpGS77bHHRze/pqygE4a8NK/cC?=
 =?us-ascii?Q?mLY1ANTY5Sw1r2Hxougs3qK3Z/YNcci7MWddjAO5iGH8BgRW9mA1RWKJ2/RI?=
 =?us-ascii?Q?514RyMmVfjWmBYnB8W0g6ixzsS1XhIL3t+afcZ8GWy9BFsMABNpz0a4ZpR7u?=
 =?us-ascii?Q?lvFzWocQdbfgbaaFnS065qWab6U9hyI5sRqSmVrqBgrsWLIfh2L8sXQ370wU?=
 =?us-ascii?Q?fEbgs2N3Ch/svtSrKDrsNFzmpfk+HkoXKqUkbJnJsthqrCFZAE2FNK3WJJ3h?=
 =?us-ascii?Q?fIPagUDgQ8EpyG5b2AR03ftLwjbWd6V8XMskSHo3vEbC1nuhjg7Z1pCnwZZQ?=
 =?us-ascii?Q?Oc3VYNrgXAY60X/sfBnWSckikZZ7vT0NGkUF5YmEnoSKHYvt23k96fzw0akW?=
 =?us-ascii?Q?Kx+kl9n9YmYZcXZCJK3lhyAcvbErll0/ccmQuV+rmuemkccJXMEzbf7Zpbli?=
 =?us-ascii?Q?KdVWcd2QO1BCVl4/l+Wxw1ViOc5vffNGIknrXBHHXGcY4gQYHJbb3dgcFn/m?=
 =?us-ascii?Q?BrkuHwOib117JCUVIvcaDAee+o8dsHg0UQp9Ilma0P7RoB8ZvoJr3obP84Pz?=
 =?us-ascii?Q?7pspaS7W+c5hgdJGY7ypjiTfFa4A7KZnikEhw05PdHke0schWFqS6lBU90R2?=
 =?us-ascii?Q?khOjxOQk6GIdJNg6MGInj+bJc5w0AdZ7M7OI0A7bNWlpIlPjZpI449P81f8m?=
 =?us-ascii?Q?XpnTUfGLj0yRUka0/xBd9juSTlunImAaZcVGuPzP2HWayNhPplrjgkbaUbqx?=
 =?us-ascii?Q?RCHR1a+DqpNsKRrdj/vc47yzMlBPuw+idfmIBaeIIk5dlRRSAHz/XtQj9Src?=
 =?us-ascii?Q?Y7bsrHntvIXLBW0j9/62mmAq4M6FVLkQjV+UL0lLpC9KaJJffxHv/p3OmWn6?=
 =?us-ascii?Q?PL7NOKIjUybXqurk5iVo20Uvrh9lvp1L9EI9hrp6NcJ2N2Nh5uj1X7tungc4?=
 =?us-ascii?Q?bD4i/q1Rm0K/IYUs34L6/wQ0FbYH91YXPtrW9nWWl+Z7Cz+Byj5NreCio9Pd?=
 =?us-ascii?Q?23Ny6Gif9FlZAGz5zN284EMVxslTjOXWW2AevjYeSqOmQuKrrYNwK2wdStYt?=
 =?us-ascii?Q?PfJrnIxNGk/2JkjnXkZkOeNqGOGbdEYkhDQJSsm+7Vpng7r9MpfA4/KavyXn?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CCS1W4tVWAmJqwsocAoUD+fGIc75iw4DqClI981kwcrRKfBBKOKPAxCbDWbT/eey/2xwJQ/x/wHW9/PJWRvfWOMneCtXSA8rbudIKDh39iJYjOswUdeAnhFRHIX+zZVzlCKg7myBKqcYtysZsUqYi8y/Z2uPcY9gJX6vHUHmxs1nNn0f5lnRzdgte3UMmUneqjOGpfi1syk9NM+IKjtX+4LzLRIqzqNb9vaAeYdFkI7Pe8JJ3ffWPCvoZvrriv1kV9yX19FtcjnRjRRk3+NoXCRFYysS755/jE1twXs0LgCKh3PMuQA4AgTyzVPOa59V4jLNae1QwYfAj3tL9T8ueAmwrKbsBXAXiA904UU2mzRhyPPz4VxwXobj98PjsFdYGZp/uvZgsPLpTnOPYqMbi8FE4647vPKh2Wt3JWUNQzkNHd1tsF6SMalB9QYTD+W9yFhUX7vYdhcS9yhyJcbDEnSBkO2y4ZiOdye5WSSgr9mlhgLzxv6RgsbbUbxGcKGyswk1pFjI9bRtEbTB1V1TjugOniwinNp3FFNlzPIjy3NTQ9/KI8aBcFNZiq1/rbiWefIuIfE7EEcBYkfBshERWEhX5WvuwSKiw4HuXjAJgH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc0521a-b371-4771-5109-08ddf69373e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:12:12.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afi3v7PupA2QBjTL6eoy+Wzr0/5D2FEXlHbW5U6mPmxMeZY23T84+ewGkO41pU58tXW7PtNGAi/9ljmlZcQQluNRqdg3ZLLK4fG43mPi/fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180084
X-Proofpoint-ORIG-GUID: pgT7gmKePjCDmEhmjYl2IC7c65Zz9pzK
X-Proofpoint-GUID: pgT7gmKePjCDmEhmjYl2IC7c65Zz9pzK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwLsLGFo7YpyW
 EaJsatwWFgCQvvSttee3vou/Qt0R6PLeE/QgIGeY5C0HLCS45R1LpQ9NeLpEJb24iFeSYNn/VB1
 437wXbVN5ZTfvw+tOiCyDExryR5qyFADV6fkxscmYNwsRvENjVzOpzSuP5rAWV3w7EJRBLgyDdO
 nVaOS+JwDQ/7UwRF/k7iQANDUJYrq+kzHgUOlUI7vH0yIX874yGeEe9p8SJGtYsQ/epJ5yQU/qY
 q1rriUfHwBWpznlOIm6N8FhJRxnLnKf0Pp/2G5JxicGr+ZbR9+poWf0Rq0Dcx4XP/4/zwSw7H1z
 PjUUuSekU0GjKn067P/sdgItQJRdOEVnaTqRfW3Ncu8qwc0IGUESBgUH/9jgqrRGQsgI9shSa3s
 ytGofoab
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cbccf1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Qzu-K-EdHhc5Hhb8t48A:9
 a=CjuIK1q_8ugA:10

Hi Andrew,

Could you also apply the below, so we propagate the fact that we don't need
io_remap_pfn_range_prot()?

Cheers, Lorenzo

----8<----
From cc311eeb5b155601e3223797000f13e07b28bc30 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Thu, 18 Sep 2025 07:43:21 +0100
Subject: [PATCH] fixup io_remap_pfn_range_[prepare, complete]

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index 085e34f84bae..38607b2821d9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1670,7 +1670,7 @@ static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
 		pgprot_t orig_prot)
 {
 	const unsigned long pfn = io_remap_pfn_range_pfn(orig_pfn, size);
-	const pgprot_t prot = io_remap_pfn_range_prot(orig_prot);
+	const pgprot_t prot = pgprot_decrypted(orig_prot);

 	return remap_pfn_range_complete(vma, addr, pfn, size, prot);
 }
--
2.51.0

