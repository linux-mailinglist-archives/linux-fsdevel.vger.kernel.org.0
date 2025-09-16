Return-Path: <linux-fsdevel+bounces-61814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFD6B5A009
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020021C05920
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC39D287506;
	Tue, 16 Sep 2025 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lb4pATuA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qrEhxZYF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C5265CA8;
	Tue, 16 Sep 2025 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045827; cv=fail; b=MucVKmbzWl0O/xC1ExZNpsOlwrbjszrvIofVFXHckJEtjnKYipwRosLAHEkSPdPw033eHX+LMybeqx4d0xERzcZeSNxb9/ko2jJIHTsqxQVG1SLmT6ewjMmOVoDBJ97OjJrOplgZbEeP9f/QGbNp8PKw51jJrWuodBJ6475EgTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045827; c=relaxed/simple;
	bh=rh/7Mt6LePBdNrYT5x4U3wY9rHE/OD4yGilW46vUSpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q8RT9+D0zvXwFGKM7Tt22ZKWpXJBtBg7MRzjODrRCptnwrAYTQ25hBuBbdV4DoJFqKIp1E+Ii7QCOtP+1aVo16EzOuQ2T4RWZM7NhgpxN2i+6H59nNKGc+IP8cfds7m5DQ4Xx8Qdu55CIE7j8peaTN7tZXnxyWduyVQxRSDqM5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lb4pATuA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qrEhxZYF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GHtwrO005615;
	Tue, 16 Sep 2025 18:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xz+Z82U/O8OJmhyWPo
	qrstTDXlMFSWqi3gaQCvK4De8=; b=Lb4pATuA8IJl2yspTnlta6rfQnq0y0GQbr
	Dxr1b04akAsLge1iRckIBhCnTG3ZcjSO+9QkzEQEaoiW4Ob1akwDWssFw9gunMgr
	hAy73Z5qrvoTkNZP9+yDWI1mTcn8RBfHNNiqzRuMa9uZTHOuvdVRM7VEQg3cWggF
	MkOEPbj4R4mNFyhFDJNhx04l6AedClsOgNzDP+9uUm8obZjm35MNmLtqFvtX/fLx
	Bb6UX3PabiGDB0mz8x0lVYKHDwix3ST+AYNtEr0nn5GlKYo7rmoFUo3cbRZwKngp
	nP8bcjxcPIXJzYfyS6K3T4ISOR94keU4JD/i4QcTQ3/hFB8sx+lw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49515v56sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 18:02:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GHJ0pt001628;
	Tue, 16 Sep 2025 18:02:47 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2cyxdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 18:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/4KOyBYp8eZsVZG54GJ7vw/IgpVjlXiLDkICgWPENDwGRPSoc/BAQIi0RJadDY+/lVr00OWriBvfX3+1hornINVWxW+ml8w49eGUeO1vvsrqcfCwHH2+c8SMLIymBvpZCfyToJPMWvIVg0klv+I0R3QI3ky/rshSM8fpI4qWSinehWGQ9ZNTshjgueOP5jZJDJIQ5wMr0kr1mkWFgirpwKijhP9LAgxuo5uslYY7E5xsFIoC4fWVCxbxwwvlEvc7wzs5pwDaG9cDdDtp4ob5Txu3g/1FhfdlraZ3RXAuLUF9auZset5bBvAl3jh1uuPYVpKHKENtr5IJQGAeFC68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz+Z82U/O8OJmhyWPoqrstTDXlMFSWqi3gaQCvK4De8=;
 b=Jx+rwtvbqLAaj4kjO4c6mbxF5YHvtpAmTcZDevfOPPOJqr8k6lZlCvRV7Ajqg8QxOtfnPzr2mH8wwef+DawyL1SApZoa+J0sxDPJRd5ymjvYxhw9M9gbDkWLY6UCz2P1tlD0l5w9+BRrNcLQ5T87AnpGv9RGNhV34tZ72doD6pLX+NKrz1XlIDJL+1V4RM70RBy/Ut82a7jbXKVIACLgN15hQTzYuBZhdVDBlFDekIQ9vGgRLpmAIkbuq+AOrPcsG/QUyU0sBJYRlrH6wECClgW6NY+0u+8WdXjIMcngVVRmmsJ5G1dfSTkB77mSP+GbNmsLMTlBnKEcTyao9OX5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz+Z82U/O8OJmhyWPoqrstTDXlMFSWqi3gaQCvK4De8=;
 b=qrEhxZYFjsl4P8u+tlTECvpO0AxNNxjOREjIxwdYnJZmDJKDUK2LusOuo5XkjU/XmONriCzzAHQ1KWjldanGYMtAab+HnSiiLK+ZGw0MOpPh0DCWFWEXLPFsXOhkhSZ+MOY6NV9lMnLy0mQv0/ZU45hqSnbYxessfhuXR7sp4g0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7695.namprd10.prod.outlook.com (2603:10b6:510:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 18:02:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 18:02:43 +0000
Date: Tue, 16 Sep 2025 19:02:41 +0100
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
        kasan-dev@googlegroups.com, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 12/13] mm: update resctl to use mmap_prepare
Message-ID: <ef36f24a-2076-42e8-b9b0-0a64238d15d4@lucifer.local>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <381a62d6a76ce68c00b25c82805ec1e20ef8cf81.1758031792.git.lorenzo.stoakes@oracle.com>
 <20250916174027.GT1086830@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916174027.GT1086830@nvidia.com>
X-ClientProxiedBy: LO4P265CA0071.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e33a949-0a24-4846-693e-08ddf54b3bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xjjE82MOfLNkUhf3ogu9z4FDMyapqZj4ebjBY8Hk3PctZ7F69XaNgIc/uiIC?=
 =?us-ascii?Q?oPmTW1sVLIdoEJw7rlSHd1Qb5cf/My71Tr4LIsUCkAkdF1peGJA3jYHuH8qa?=
 =?us-ascii?Q?pJ5L5xZkEXiCPIPYMAId1/4uvB6jp7ZixUeN/Gl+pHfA81eEpzBAAYR52nTW?=
 =?us-ascii?Q?cgIoF89eGTGfrByqdcp+FAtg3BsvRlbniVWihAah8eBgTDmf+IwFL1QlAgSZ?=
 =?us-ascii?Q?lp485vzmnk+yKK4vid9DXvZ6wxLK4kQom7e30Z91L6iMUf7qOHxIsqOYtH52?=
 =?us-ascii?Q?SI8wTAnC89ZJ/fr00Qg3J4ShNI2PFD1cu6M/2+sHvnVgjIq7WXlAl5EeuR4V?=
 =?us-ascii?Q?7DXJWdn6bbXnqxCtUMHCudWYX0huFs2LsA/1b/2C1yd3YnqiAXmDhxp/E4hD?=
 =?us-ascii?Q?E2RmVktCAopROMLjAdglKJj/PEL0UjFY2B0tKE5VDQxZYbkr2Z/TKTHZiLDW?=
 =?us-ascii?Q?ISobTVQDoagGPxfUlyXM1c9x6G0f7veB7snq+Oq6LLfGXQGH0tYfdJrcJp6m?=
 =?us-ascii?Q?40v/jI3xs+uNSiY05+olrUPuYIujfkG+K7CA4SiJBCuHFjftdTslscphRjXt?=
 =?us-ascii?Q?7YOrdCVco9+3kgOfUDjbUTapYVGQSwih2BDTGn7ObC9M6kY0Qktyg+YcXRhT?=
 =?us-ascii?Q?kEbPpueKYvwBCKWwRDJtHi2RAikOhG8IAhmvuZbgmGaWTpx6PI8vc3j8DGKJ?=
 =?us-ascii?Q?uWrLI16/iLOACbebkXz6UszfGjqPTjA4Hn+ozrLdh4dd38+KbSJwBAnDAlSy?=
 =?us-ascii?Q?WVEGBFdyZacpLBWSYoy3HX5//7yRV4TTrRA/78PS9AKWJ74jWcLJPJA0ZRIn?=
 =?us-ascii?Q?a0tvHnm2K9jEp9BbOPoYaVNXWVGWDXBSAIpxvtjmKJAdiVCnfgr0wcO4hxzC?=
 =?us-ascii?Q?nbQMrSZ/EJsRcO+B8B21+5n5kFJyzkRWfz4RmgaYO0F7vUR3S0jTHbouyISI?=
 =?us-ascii?Q?VUIMuw+2PCaYpp5w31G/I36oCS7erWsf8sXdpJLaQRMnWb3GclQnZqQin0lv?=
 =?us-ascii?Q?+DsbqcOaP9AjlPUzPegMSqj32zcDzYtRbcoj7v/f/QLktTOKranpGaRPhJGx?=
 =?us-ascii?Q?Od0FMP5zrDkQCzTmVB8zxWAHQuRG+rAGt36RTLlDBhEtH0MPpPzy3wrjGvpp?=
 =?us-ascii?Q?WRpTWB/m4AtBttvC+os2I2evsnnW4KZhlCI301k5pM2GQUhseCfUetSeuKHb?=
 =?us-ascii?Q?S9qMSP2h8JogdzaSfFXoz7UGRQRoUaE0tJTE2QXsNHbE+FbMI9lPWSE5g5G7?=
 =?us-ascii?Q?U5svTNwnk+H3MjX0UMY+cE4Plq03X3QE0IAZjlst3uRQwyJe81p8UGflEy6K?=
 =?us-ascii?Q?ixcsowhds5zOjJaFntr2SBQCAjWGEnhHsZ5ME5g5VkwFdugGBpgyJTHsXPTB?=
 =?us-ascii?Q?2k8IS1UdhWVNRYYJy8g/p3NGT2m6GMNsSrJ0Hjc/dVigS5YRy00IA5Z3FKf5?=
 =?us-ascii?Q?ppj72m+9uVE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XHRHg2C10YsL3LnGTblK1tzOLGufx0EsZK7grNQbzCn1VK9uFXXqFyLPLlnu?=
 =?us-ascii?Q?WubJJ26SfgNHfXPdrbijJbnoeEntK0mVlKA/CXbVWh9a9sR8FwPb089ecme6?=
 =?us-ascii?Q?ixl3k3ueQMDEbFjgRLxepVZN/tRLs1u5s9wwxDmeGmIVTNRjHCQfGIAW4wkj?=
 =?us-ascii?Q?Vowpv9DNwya+lGUtlPvcns9oGuGi9wW6b8eCk2DwmM+7PbS+WbNQYK+Fd57b?=
 =?us-ascii?Q?LyubsNYDk2RNAmhQdsQaPkMeaNigkdlch5go1Gfn6XOXlWPwyaoO7dIvTpMx?=
 =?us-ascii?Q?hPpirttbM7EkEE2dRZu9KrbSh5Zcx+Y9Ivt8VwRAxBd0/A5YnYBHAxny3eD5?=
 =?us-ascii?Q?Xs1aERknCJDpRGAD3kva4fMzjwYT3lB2TQ4MTz2fECbNm+eYkg3UFd7UZ40B?=
 =?us-ascii?Q?oC+5a9ZeCYLL5YuszXu7Hygga9McMMY+92RLlGdOhvFqPWpCuPzeQg4Yxjro?=
 =?us-ascii?Q?Mt+ogqO977C1IKMhVwRwFGd9/ECaSU8234BmQgWtMj8sjbn229ou1Pbi28lO?=
 =?us-ascii?Q?DoF0eM9V43DJ+JRpgs43cWtWoBREDNgnDEcPm0zAAJrwSqorAq3a2ybMzRy/?=
 =?us-ascii?Q?maN5oadpf8R4oRohpGXam1bAuyBtepyZrbzMwOEEoWk0YdW8mFZ0ahGnHj3/?=
 =?us-ascii?Q?QiT1PQGeUlh5MkmmjCof4ZF0zLTvd5ER58DzyATN6aTsTXl4tlptjxmwiZHD?=
 =?us-ascii?Q?9HoN6jW0/DJDM3agWyDbDK0flSD7ZN2mZAQc5rNY9GNaDASNAC4CRp2h5vaN?=
 =?us-ascii?Q?zZRe7VkoQFlWXRkUfrJLB2x4OYFCPVKgXBEkP0oMKDPWDvq126oC4ZgFiDYj?=
 =?us-ascii?Q?tH98rhQ7roiW+zRWrK5bwfr/xX11sRzCR6I5TQYVdtY0ygSvOkzd7vKKc0Qu?=
 =?us-ascii?Q?7NvJmaxTRBdbfohI2hBTDup6aAbc/LOcAX5YYCaoBG8Abafk2nZXyebqiQq4?=
 =?us-ascii?Q?GRxKvYdU2n/DJrGYVTPmyAhqTuK/udKmI8jO0W0hYYx21XZ6Z61m0yUsuRKn?=
 =?us-ascii?Q?YV7BtnDrNsFGb4v9MVHI/iRauhIWD/EZQPuQcEZykor7hD2bchyWOU01QaIa?=
 =?us-ascii?Q?o33Yjk2gDmhK5yNzvMzehxMntDi7WY33n5L7H33hIIYFeBMUVBaYrdi53YeJ?=
 =?us-ascii?Q?17lN5pOAeLG3xMty2WF+etnz6U/XnkzG7/MLRslntZexmMRDVq5IYN3w4Kh+?=
 =?us-ascii?Q?mlz0esRtv2TNechTih+eZDH/Dys4JljEK9UcyfDhrBpM5JPyE9oiG5R/d/r7?=
 =?us-ascii?Q?yqjC40sb4bO52Plp9hAFpuoBgVoIl+f/kH1Klto5oabE3Kbw6UB84nndqPJk?=
 =?us-ascii?Q?+YFFV0UPid38hd76GHhEbuCMkYVmP4qxbS4zuQcMjZZX0Lu+3TQznT6263jz?=
 =?us-ascii?Q?87inlUXSQjmw0pDSf8SWADWtZ2aR9g7o98n4lAxUJLlt+N9w2FbQkgS4zwVZ?=
 =?us-ascii?Q?xCF6//WPT7gb8tpJvfMwTpA6EMpKkqrLBRfOWNfZvTGEvsEhlizQ8iCfMlNr?=
 =?us-ascii?Q?wCbp5APJqck6EL5he1QUcAt+nqbU35zkSpjeCqKiyFToJf3ARYi1Q7M2JndP?=
 =?us-ascii?Q?S8Ba7sVPGyp79Ql5w7VTmNeHT9A4+sLzK4UdLo4U8tj8xK9dRuMOmha+tS3y?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RSE1Ee8EobaWtuC+44AQP31Y3aIB0f7W2HnPJqLibDt4uILNckFoIW0hVTx45ic/6LYJ842Xi306X/8m8UiIVghYp5TlV0Sm1q7nO+Pv4vGfV//fOSBDXTN4RXgFKNt4f/Fb1G1Pn0b92UIvzm6SYIfMHfrurMcFxsqpueFWrhtO8pOJdw8VzN3nlRQFUNdMBWtYdk+UKtKpk4PoohU1ly8LID9OL6SuGgD9JlAo9QPZBVgw7Hl8BdE3w2XwSYOVwukY6ZYScyVNe1HMUxbF9Iec095DnqnVdb6fFFR6mO39aQsyD1TZ8BfPtoQULVbQ/wvSSV5nDSIZgdwh8Jr51SytVW16yUO96CBFhOKDz0/pkuJxx9iLEmUouttItomyxkRLv/xRav7fIiBL+HZi/E8g4jPYDrJDHH0dkxEGz374mxb84HfJCJFWji3IaBluaSmsQ8nZQa3PgBhrZp7HwxRg1L7I8A/KjMQVnvRazzLOZ4d373xdejWMCUAH9e4EhtxHkGT/4hwA1wl5iwQZ8WdMW/s3bjFy2CFI0pKhyuCWmNAJZBzrpqx09P/V8k2k0I8C8WP5qjdnDPieUpwHqPSyaDlYOvU08KcpCuAirVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e33a949-0a24-4846-693e-08ddf54b3bac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 18:02:42.9782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2Of1oR9ioRNOH6XzNT3rYAIAr3lOtD1n/43RssDpXkHw3jFlZm9uxSAyx8BxKjkhe0IelvRYJGbG7E0n1BgjYQIN9i+BKroUCOyJ6CRYmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509160167
X-Proofpoint-GUID: 7JGEZG8HB2M9FRN2nThAgNFav9Hiy3JQ
X-Authority-Analysis: v=2.4 cv=RtzFLDmK c=1 sm=1 tr=0 ts=68c9a649 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=Ikd4Dj_1AAAA:8 a=QKhW7uEfI7EPC8uQ3rsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMyBTYWx0ZWRfXz4wtpq8o/mM6
 gYOm7na02Hdkh8cBwypi19QdlmlnHBiLbTVikP8z8NWYMXGiMA0xJ4BT3aF0pIvkCAQYRk/0HQM
 BF+6JQCGnpPyzQqdeB0vBUG5UcSCwGRZKDA+QIwzIm8Zwe/7hrroOW8XiiKm+b8IJ0WGfUTqufM
 hO628hfJzlaNvoLqhbtCj7tbwEQ6SnwT+XT1TJ5y2A4CNgFSE+oNG4cQ6Vb16Bl0oCk2luAyD89
 RfzGkSAA0CfCEAU/4Mzui+ghwQX5PG27B7z9TZRGSioxCZ3GFfvuCHQNdYCPZ9DpoIlrHmArDgK
 gvZjyNSGtPpS35yNO8yEHUY7u9f/6nlih3pZu8tOrQu6mKuBU5k8bO6lK+grC+sspIDlu+8//MJ
 ZMBMDrM1
X-Proofpoint-ORIG-GUID: 7JGEZG8HB2M9FRN2nThAgNFav9Hiy3JQ

On Tue, Sep 16, 2025 at 02:40:27PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 16, 2025 at 03:11:58PM +0100, Lorenzo Stoakes wrote:
> > Make use of the ability to specify a remap action within mmap_prepare to
> > update the resctl pseudo-lock to use mmap_prepare in favour of the
> > deprecated mmap hook.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> > ---
> >  fs/resctrl/pseudo_lock.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks for this + all other tags, very much appreciated! :)

>
> Jason

Cheers, Lorenzo

