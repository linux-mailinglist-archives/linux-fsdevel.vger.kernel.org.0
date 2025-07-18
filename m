Return-Path: <linux-fsdevel+bounces-55430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0819B0A489
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 14:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB6D5C045E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AF52D9ED5;
	Fri, 18 Jul 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UXHIe5FE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wabWJv+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491ECA4B;
	Fri, 18 Jul 2025 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843397; cv=fail; b=P2789uCs4xbSRSnWKk0BGM7mkbf3Zyl5WRInoFfup5EAyWwrx1cbC0x+MBE8p4g2+dfjr/46DgV1qWHfYrpbqJfHl2WxbHSGEXZFs6ajEK6LwYPGA8REf8lUn1xl/Llim3bG+ZGvXxfs6Zi5WeWhak1mZQjP4HPKjWBwqEDzzGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843397; c=relaxed/simple;
	bh=okyU6so4Y6U6Cxf1wi54bm8wXBjvDILqsnwW/XJ/f3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gaXXXm0+/uURwJkvetQ5ACLX/rJGQWgNQbWzgit32abxnyJ10GzvCLtwntHbPTfsPS33dTFMLbv/xleUsddppz6Jc+up/p6bwA3UjDRZPiculeaDMVwSXb8uRbj1/roVR4Jdsnqp5LcYlq919f8k43hohAovT0Bxg/sglBq/NuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UXHIe5FE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wabWJv+R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8ftmX029581;
	Fri, 18 Jul 2025 12:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TmvTUqPjlEs7fok8DB
	Er+TcikK3ijSQz27Xumyz+SaY=; b=UXHIe5FE4HVseyC//aQt8EDCM3FyrX3pCW
	FMz+btPbNmd4G258n3YR9o1/JoWNLY6GQct7izXQvAQ85bYthbsUFUo+5ORkHkyo
	wMYF19UAzd/oUFU9DbWznhkU4IlcWOnDHD/gfkRYHe778B0sN69k09NDhw++L7bV
	O0x3IKbQ89IiR2kYxFSme67M+eElsXPNuLw6D/bMGanHDA8G4JSaoi0WP4xIw3R3
	FrRkR7DbeQi6zuoudQVZHBTbKRQ5UtffjNEO97pTZOzADQKkJ+aFtysr9RwsY73c
	/uC2HlIY+mBynbXMwtZMXne5QXcyMkdlaC2nu6npJElqen0X+6Fg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4vx9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 12:55:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ICK6xb028963;
	Fri, 18 Jul 2025 12:55:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dqsg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 12:55:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPJMqILfTgS5CKvh/edpG6gM1OFtWm+tN/0mcDDI3CJ7jfwnBFICTEkAEHuZgtGlpGf8pLWyXjta+G7OFM2LFp3UHmVCEAbtW3bx0VxWUo9JXWUzJu7xSj/gEEqGFOawP9mhOacq0E8flsl55BpSPETaIT/1lHfk7ty2b3k9zKvPVL2HTXk34kddq2Msqb1WvIyHNdBj87ehr1AckktQj+6sA7kSCJNpuHw61KUJbVPDbKNR+OIasBAu/EabQ6Jzj2hZuhq6OIibpwM6V91nbrBQu+da+zQvZ3/czLgyqyl9zM6oO1fga0QORGA0PTqo4FSHr1scLgR9jX7rUiVSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmvTUqPjlEs7fok8DBEr+TcikK3ijSQz27Xumyz+SaY=;
 b=qV3s5Dw681Tu4r+JKgMVYdqqRsUimk49RjbSVvkOJKin4iuNNyQ0kSidon+OxdBdYRGo7hJzl0XHz8sZzpzuhQ10cMFK/RKnk0x6jhx4k7vtLYAgZvP9KkqQ5pNQR/DuBaS2mzlp2ee8vyHgxfRXEltxWtK/amMV+PoC7eahGIiYgKxBzI8qJriygNhWG489ECQEqW8U6QfXU12Vl82j8E63UvaDytR1A9CELxDjgN3hX380/EkSjCjj5lPKbQqmoEX+JlEdZdGocwPxGk3TBB6yr+7cjn0PgegwX8dtW69xxL9e9Iaz4UTo1OoFojHEpqaTocJq7BwiU6TicgaH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmvTUqPjlEs7fok8DBEr+TcikK3ijSQz27Xumyz+SaY=;
 b=wabWJv+RCvl3AQRDLwCHSYUtF/UfvGD/7S/yAyH7isM3j9MllK6b86ReOHrHwjss/QhVLAzfhk8Sy12GYO4vlgkIrqhqRcFq9J2oeVBVfBZhg8kGMndwegSVPYl4rNiRZcIkFv3xMT4H+G+nkahS7Z+WFThtELn9k43EUk5YVTE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB4856.namprd10.prod.outlook.com (2603:10b6:408:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Fri, 18 Jul
 2025 12:55:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 12:55:48 +0000
Date: Fri, 18 Jul 2025 13:55:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 6/9] mm/memory: convert print_bad_pte() to
 print_bad_page_map()
Message-ID: <432662e3-e043-41cc-b7a2-acf14387eb95@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-7-david@redhat.com>
 <73702a7c-d0a9-4028-8c82-226602eb3286@lucifer.local>
 <c93f873c-813e-42c9-ba01-93c2fa22fb8d@redhat.com>
 <200da552-4fc7-44d8-bbea-1669b4b45cf5@lucifer.local>
 <c8b9c805-2760-4b90-951a-3666cad6a4a4@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b9c805-2760-4b90-951a-3666cad6a4a4@redhat.com>
X-ClientProxiedBy: LO4P123CA0412.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dce15d-7ed5-4082-2e41-08ddc5fa6b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JuwQlKdQId0iwKShQUvO/walD4lLHTkvn4GbKPoIFg9AHRu1OKXH+NZGsTuW?=
 =?us-ascii?Q?5J3feircrg7HrbctS5SsihS0cFSUYZqa51+tR9upDkaa3AXfJbjoZZgVTSr7?=
 =?us-ascii?Q?A/a0KimqUE4AgmM+kbyRCfubc28Y4cHxJ4zDOEi7b0T3a23GDVIBIJAuLFXo?=
 =?us-ascii?Q?/NJrKD+JcRU3M2Y3yQ3nYarwr2lAiez5IJAA1Phzpwl7NVNqxaL96d6Rd7Li?=
 =?us-ascii?Q?Dggavl9d0kMqWTKsw1GAuvwJ2ps3EJnggk7RqHGXTZrnwD7wMW4mJMlEele/?=
 =?us-ascii?Q?nCy+b0We7rOHRe+DtHQYTnIlndc8LdV6QWMyEHJogk2x8TuCFWeoqj4HH2yA?=
 =?us-ascii?Q?Ta93L6s+KpYwRqgmjWB/ZgfiZ7abXYdnMQqy3kqDNzVwE18vLsJHLmkjyrKD?=
 =?us-ascii?Q?t7PNGO0e2EDGalUhmjYu8Wlo2E0Gig+2bVU5x4WTpd5cxAq+tVNTgYA7PhkX?=
 =?us-ascii?Q?r1DQIiiHdcKq2n8kc7OFbqJL17Qv4kO1CRZxnnLl4WOPiPBOS4NyFZInt29i?=
 =?us-ascii?Q?C9emkpRRkFYOgpEHutrivIX2LdR8VDFBDLNiNQ1EUU6R06E2VRl6TcOcWmq5?=
 =?us-ascii?Q?aIZMZR+DIt7B1hceY1LGv8lZzfCd7CmTprOG14StBU6AzyuMVcTZwVyskyCc?=
 =?us-ascii?Q?mCK/1rsC6fUG7QBX/sVr2zSYV51tPtUY7L5tjRYDHUu8gu1lFHSrwtfxUF1Z?=
 =?us-ascii?Q?bmk9b1ABwxL0dQfRMLL5N9r8aw7Mml/Cmu0PmEbAzpLNw6inMJnXHFNHTCDM?=
 =?us-ascii?Q?Y8NfaL2apt8289tqc4dsCSPezLpHTVvoWce69SP5DrqeXGSFAp7C2Pfnh1Ds?=
 =?us-ascii?Q?M0Kca/4saRRJTD83podOzf8eX6qBXznbfWoKeDU5Xdc7iMv2l8TkBUw5ooXn?=
 =?us-ascii?Q?Ao1wJBcx+Wc6W8JD6F9ty/e+kaH80sERxiWkU8XbAE5hJZZrg686PYeryUdL?=
 =?us-ascii?Q?9zvC6qZ2e6A1AuPMO/sqRG5MKYfSADCeh87VnPOAoi0bmt7Iy1+5YB2cGHc/?=
 =?us-ascii?Q?745fEuLjBr7EYGR8IkcHBTLUciaoSowPXSLJXiRdTjO3CEb2JmvW/vmzQSMz?=
 =?us-ascii?Q?8GmeFrnZ8S5lrQf9oRK6+AOQx1og+s72QcOAAlEXft9NVVjPnJ4L47HcT+s6?=
 =?us-ascii?Q?+2R0Pwi8Qt3HHiTnHqibogyQc8B82hSI2F6MWBxMAFQ0FM8mMsSvY/hoOeNk?=
 =?us-ascii?Q?FWpJFzeGvcxt1CfLjS5GYBpXKH27q1HYRTnXs161PnyyDyWxt3RI5aiA9J48?=
 =?us-ascii?Q?8hV95KpM+u0tsb20FIWu9HTJp723N97/LXtPJ8/+ZgvvSOZsUHCnTh8RW8SF?=
 =?us-ascii?Q?JW80qoffgWhwpPyZfs5Sog/B6DI5WdjQYp5sHoGsPy11vT7QgtakGuMdjLir?=
 =?us-ascii?Q?9MN+wgXveNKLlFITBWKjPN9taLPw+cFRqjImYYpwU6XyJh/U+Ap8y0NgIGKo?=
 =?us-ascii?Q?BjW4DTphXJ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?adOYPH95f4CYmwvri8POYf54mk9KfzbXWqJlOcsCvBW/QRR92SVoGbQby9sU?=
 =?us-ascii?Q?MZRaYqSODWiGMZx4s2f83RAKf/LbOBKubRYfmxc4NaxMq57wHI3pbHXMOi5W?=
 =?us-ascii?Q?T77FhLoyBNOSk0aSBFW2uOFm8AogLsEQRQx6dwJdHg0QPlnEdsQemKRUmkWN?=
 =?us-ascii?Q?1GK+gyIghbCYFEz/pvANPAmAo+C91T41OA24pVSnHOdadc5kPGye33H9Orqh?=
 =?us-ascii?Q?5VJa6+AlFeqRb3uvpuTOTVAtV/oC5GSrFy+RYj1aF+z63caGyPJw4YJaIKcT?=
 =?us-ascii?Q?NNfacBw3RzrtnLiycTPLyNwi4Y6BXgWj8g6PrJgNw0uOQiBcDfuF1XNYPUZ+?=
 =?us-ascii?Q?LeWL2J+JoCb7rhSm2OZMnlXTNeitXhtGHma88BQ/rAa+9GhER+82czMZB4do?=
 =?us-ascii?Q?s9ZvWuYDKjM/4cKEsxVddpPi5yToD6kH5PSZfqjZuG5/R5a9UqezfqGEWa0o?=
 =?us-ascii?Q?NFYC9lFhy6b3Q65NhOak8y3+Tm+pK0SDNNQqIu9oOjBmZ6yRQwGZAMwstmBD?=
 =?us-ascii?Q?FRL4o+kv/kBxH1qeSKdLLAnxvPflsgxTeqhHluU8VAU7TRAYCnY+ni+bnU54?=
 =?us-ascii?Q?M29sezxqjRJ2jTPmQnX6jVSEisROTIsjGqP/v/knbzqRuBL7xMMrLHbSlLgH?=
 =?us-ascii?Q?x798lccVVAxweeYRmyTQBqGeuJagOq95ogZ1K7rIKtnLdHSajbGtsK3gxpzM?=
 =?us-ascii?Q?J165cPNozfnYh1R/UYEtuuUd6xo9wvb+O2qSLOaTEBujs+HtNl3U/2XlbLXv?=
 =?us-ascii?Q?QvKUeAq4wMvJZ9jPUaQBinGCA9ut19HjoANYOSFHXbBlTYRNOOALxkBqJWs3?=
 =?us-ascii?Q?Q7lsivoHLgu4/uBogbAfG5gkVeERt1CS1ZJj+F0MG7cqhqYUnBvPMgAu2OqC?=
 =?us-ascii?Q?f63GA2dnQIdUnxuMiqEK1FRajAYdsblXg0dc3gLGYj8qXEVKjKnZKy4pDlFu?=
 =?us-ascii?Q?CXqpFMQAl8gws8f6I2DvavkWl+1gmjIqndjWYTPSvg4hfTtnnXVtUsk0A3m9?=
 =?us-ascii?Q?yjvHugEUxdbwAYAbptTRf4Em4nMMrEjm41BzwR+os+AD1hV6eV82zX3D52PD?=
 =?us-ascii?Q?0OzSSwTR5o7f1W1fJkpTHHHt10eFXWeEycTGywiCcpXl6PoYbBJLl48pxB6D?=
 =?us-ascii?Q?zIQA4FNFphd7gZMDvK9vxfcdQnpUcRn1hUrVXfoJkaeTqY7cvRpfexXk/75i?=
 =?us-ascii?Q?fwvbYoILGWhlWU5HeyhF+GPbfYM25rrhiNks206+ZqFiAnSKwB9tYySH+EMg?=
 =?us-ascii?Q?wZhXXds+UNe5BhpT8zL3lPrtakSoRHk+9vUijwz1ofxRQiy7IC4RYcyhS8yE?=
 =?us-ascii?Q?7YrRa14m3kpVPZ1kvoHInWrBT3sURq/fPqBV9iqS4nCQ/TFYjWEUHeym9wdW?=
 =?us-ascii?Q?4xJWakOFMIJcsNp0A0UrKZTQDMyZu+57Byn9J6L6l7bfPlM0uUCxz9TD3/sV?=
 =?us-ascii?Q?PkBULoerh67GGICSPlJVfJTdUJd4jDtPCogqomlHEXdT5H1vNgfJk0XF226L?=
 =?us-ascii?Q?wNsB+Wu2gFkBB3QN/FFZFFxUMMe6Bv72Y6F9zu6bKowpexCQOkzU0GuPHdQD?=
 =?us-ascii?Q?jI0jHhplO81CqEbphaQbsxNbL+BOm4Ir/LjHhRohnd3scJ16tFIM+Bjr+/DI?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bQi/blQ5TreDNtQGoCNiOuPpYINtq8rQkf0QPC0Ew7+SDGbsulGBRyYle/PKoQOXigcnzSJvF/YPOPTGfKFcmyk52G3hudOs8P+bb0iL7vij1CbSAq0ihTOBi9MyuK2G/aR/WsYcgeD15tZ1OgzFyHSyCC+v4J22waUQlMLqAaAGc4y5KNFSrc//ZfAyi/McIsBd6yHRy9Oo1t5TdAtHoK6FrDllIfo/3lmK4w0OidS50Fyz0gVfY9cUake53Yzt1xQ+/1BJFEXel2A6R3acQMYm/soPUdmyfUaz6h4woWtsBj/oX6NnKqbibighW8FRIrjhKVXQOtf2IKgwCoxTGWlLx0ZaL9nRYsDwtt7/AYni2T7+3QpBzPA9GX0ORiq/ntxQGg45ZLhzYGs4oKsSfLVHPv08tPwv2YQzC7LN+JoZvRYd3Ay75eyhFTkqTX26JGUq1aZErFAkwZVWp4DNamO6LAur8je3i+r9VtJaBnsq+3lg/zcGoZzg3TKPe1fco2xrcDneeLF5CPVb3yQ+i8BE6JJr6bdJ4OLk6sZotORSARHKXkiJnTNHVdCF2uhhQG3TOeLbta2BWFfLQDhcu2NGdW9jGI1aJjZEakPKOEw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dce15d-7ed5-4082-2e41-08ddc5fa6b36
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 12:55:48.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3CAyD4IZQSwr5sGbaX71EQuq4gk+aHZtkXPevmajIg9XEDb8H71Moy3r53t3J8slwvOKpzYgGjx3b87LUk3GKwtEVHfiurReT1Sf0+uGI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180099
X-Proofpoint-ORIG-GUID: uGpoQVOhkyqH1X_YASMYiVDzrYENKSDL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA5OSBTYWx0ZWRfX5BulZZ8Te9jT ozM6BV3k0F6zz/rpkzeO81UFw55n4HEjts+Ffe280pYp60znOTeVizG4ll6NJn43aP/gRtLSkQ4 7TTb0OTMVndOLYoG/UfiXyWZdlS2BOqDr6rB79RwPvv0qmlZ23Od8lvE5xlLzvsa79qghII4cdW
 PfJgTKPTZfOZFOimIHl+gtpnOtVzSgBDSgV8sGCs6qhnBpCns3FRT96zGNz8hBSY7UYbFzGFSwK 1jkMDf5buhVk5fLlBNJoEb+4j4Jru5DtBQmdlBZzLABQiUPvLWOzphm/f3Z8YCuTubMl7KHhpQo wBhLx2bvu2LZaQCkk9yHA+AYXogc4EaBJZwrfDJ2zyuCYywY1rt+DfSSGXiZTz4jhEaWGDWBdGP
 x3lv7mTctgDhpzQ9r3f+IC8JNiti3gKA7q1rfS3wdEDZ6KSjsuKawqIgYVyU6TWXRVTSubiR
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=687a4459 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=6pjpunfwH4-nTKEnJ2MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: uGpoQVOhkyqH1X_YASMYiVDzrYENKSDL

On Fri, Jul 18, 2025 at 01:04:30PM +0200, David Hildenbrand wrote:
> >
> > Yeah sorry I was in 'what locks do we need' mode and hadn't shifted back here,
> > but I guess the intent is that the caller _must_ hold this lock.
> >
> > I know it's nitty and annoying (sorry!) but as asserting seems to not be a
> > possibility here, could we spell these out as a series of points like:
> >
> > /*
> >   * The caller MUST hold the following locks:
> >   *
> >   * - Leaf page table lock
> >   * - Appropriate VMA lock to keep VMA stable
> >   */
> >
> > I don't _actually_ think you need the rmap lock then, as none of the page tables
> > you access would be impacted by any rmap action afaict, with these locks held.
>
> I don't enjoy wrong comments ;)
>
> This can be called from rmap code when doing a vm_normal_page() while
> holding the PTL.

OK so this is just underlining the confusion here (not your fault! I mean in
general with page table code, really).

Would this possibly work better then?:

/*
 * The caller MUST prevent page table teardown (by holding mmap, vma or rmap lock)
 * and MUST hold the leaf page table lock.
 */

>
> Really, I think we are over-thinking a helper that is triggered in specific
> context when the world is about to collide.

Indeed, but I think it's important to be clear as to what is required for this
to work (even though, as I understand it, we're already in trouble and if page
tables are corrupted or something like this we may even NULL ptr deref anyway so
it's best effort).

>
> This is not your general-purpose API.
>
> Maybe I should have never added a comment. Maybe I should just not have done
> this patch, because I really don't want to do more than the bare minimum to
> print_bad_page_map().

No no David no :P come back to the light sir...

This is a good patch I don't mean to dissuade you, I just want to make things
clear in a confusing bit of the kernel as we in mm as usual make life hard for
ourselves...

I think the locking comment _is_ important, as for far too long in mm we've had
_implicit_ understanding of where the locks should be at any given time, which
constantly blows up underneath us.

I'd rather keep things as clear as possible so even the intellectually
challenged such as myself are subject to less confusion.

Anyway TL;DR if you do something similar to suggestion above it's all good. Just
needs clarification.

>
> Because I deeply detest it, and no comments we will add will change that.

So do I! *clinks glass* but yes, it's horrid. But there's value in improving
quality of horrid code and refactoring to the least-worst version.

And we can attack it in a more serious way later.

[snip]

> > > > > +static void print_bad_page_map(struct vm_area_struct *vma,
> > > > > +		unsigned long addr, unsigned long long entry, struct page *page)
> > > > > +{
> > > > > +	struct address_space *mapping;
> > > > > +	pgoff_t index;
> > > > > +
> > > > > +	if (is_bad_page_map_ratelimited())
> > > > > +		return;
> > > > >
> > > > >    	mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
> > > > >    	index = linear_page_index(vma, addr);
> > > > >
> > > > > -	pr_alert("BUG: Bad page map in process %s  pte:%08llx pmd:%08llx\n",
> > > > > -		 current->comm,
> > > > > -		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
> > > > > +	pr_alert("BUG: Bad page map in process %s  entry:%08llx", current->comm, entry);
> > > >
> > > > Sort of wonder if this is even useful if you don't know what the 'entry'
> > > > is? But I guess the dump below will tell you.
> > >
> > > You probably missed in the patch description:
> > >
> > > "Whether it is a PTE or something else will usually become obvious from the
> > > page table dump or from the dumped stack. If ever required in the future, we
> > > could pass the entry level type similar to "enum rmap_level". For now, let's
> > > keep it simple."
> >
> > Yeah sorry I glossed over the commit msg, and now I pay for it ;) OK this
> > is fine then.
>
> Let me play with indicating the page table level, but it's the kind of stuff
> I wouldn't want to do in this series here.

Sure understood. I don't mean to hold this up with nits. Am happy to be
flexible, just thinking out loud generally.

>
> > >
> > > >
> > > > Then we have VM_IO, which strictly must not have an associated page right?
> > >
> > > VM_IO just means read/write side-effects, I think you could have ones with
> > > an memmap easily ... e.g., memory section (128MiB) spanning both memory and
> > > MMIO regions.
> >
> > Hmm, but why not have two separate VMAs? I guess I need to look into more
> > what this flag actually effects.
>
> Oh, I meant, that we might have a "struct page" for MMIO memory (pfn_valid()
> == true).
>
> In a MIXEDMAP that will get refcounted. Not sure if there are users that use
> VM_IO in a MIXEDMAP, I would assume so but didn't check.
>
> So VM_IO doesn't really interact with vm_normal_page(), really. It's all
> about PFNMAP and MIXEDMAP.

Thanks, yeah am thinking more broadly about VM_SPECIAL here. May go off and do
some work on that... VM_UNMERGEABLE might be better.

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

