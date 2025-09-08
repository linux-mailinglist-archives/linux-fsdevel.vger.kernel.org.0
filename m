Return-Path: <linux-fsdevel+bounces-60537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CB4B490D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB76E188D9D2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ACC30CD81;
	Mon,  8 Sep 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sv1Q+2Tl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S5Zy4ymB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3348222568;
	Mon,  8 Sep 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340690; cv=fail; b=Ylb3ntPcJvyvQy5Sv1ka/aD52fDlIXqNwEAvj82yK8a6jZC/9hDkVt8DAkHgCt7Th338eccUMLrypwWCG51iXdR04xu0skmCaeU89uXXuxy6NdUIy0lD+R98l/nDw1J4ULlTdScYijPavumWvZP66I1g6LCm90Jy+83Tqc8jnO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340690; c=relaxed/simple;
	bh=xm4ldqf1GS7HodVHdhqhN0rXfPxStGq5ExGJ88PRBAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oldVVvg/lmLuWQi8OoUHHEAGLmMb4xZHEeBUGklAX+AFjqpCuLFL7T+a/6nIASjyQczBMZEjnz0vv7sTE6wQy8XCcjFRxsNgtNaX9QotllkRa0NrnWHKNSTVMg2bHXDJSv5sfOPvln6cFW1ZNsTUedNjGrw00a77aubiBt/MR+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sv1Q+2Tl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S5Zy4ymB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588E1q5N009108;
	Mon, 8 Sep 2025 14:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4fmgHEvWsc1of1sfG0
	2vuCJKV2a5CD8X/51YBEaloFU=; b=Sv1Q+2Tl//xnhdrLaD5O/Kai+E1xsRtkeq
	I2TOYePSf3Zat6kBtMOByEoRUfiast6xUhD/+pXKZaskQu+URu/4rWxwR6kNS9Yc
	sR7leYQzCAWhhEqtFBihH0UjnrZX/AU/2uKWPQ1v+Im14whN3CKSGyUMLsYAF/eP
	Q28ZDqij1r8tem/25cg/mXgrohUU+pUv0M0f8T7V1SlKGTS3G/S3aQbdNLsaS5U6
	S7iuBpYl5q5Ya5302scvWagyyTZzzaGvY7lMMWg1Dw0o4GTeh7bsENV7jJB4Nb/5
	3JLm1KAtqb6NXjtjm1lGJ9TjeO5duJGmJiUDrHPvZzczrlKvHQXw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49202ur3rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:09:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588DuCZt030242;
	Mon, 8 Sep 2025 14:09:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd98932-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:09:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sACYVFWSSQ0B2nxD6zewFOkcrzhXk6MyGmuN55uikbFqTy889WzMa94/uJR09G3t8lwkxwDrzQQ+VV53ddRI+hcS2QJDBOebD9sa3zViApg2C3cT19hUrfnOCFCNjlP6J4zlzLCMmLgIZnEPSNvNssDqt1eBl7tZtHe0SpnaJGOV5Jyhe3R9NuXydMOEcbkK6Nhr2ssl3xOilQFsw6V6gnPB/crjw+RdK1GKL9Lyzd1VUJmW3Bf9PWmjBo59rHaFNbRd6TQvF0VsqVFDxRMGbfqURmH6kN1TCJ2BTMzCG/sTT4Rk8NKYJZVArAfbPu/e9FjU5ZYZDn2p5BbTo88sRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fmgHEvWsc1of1sfG02vuCJKV2a5CD8X/51YBEaloFU=;
 b=Z4Mo3TC3cs2q/RuKp1yXlVkDvvMTvLi9i8nln3E7czzk9vNUiXWQgqbfEu3E0FNd/9p3rM00s5btQmNi9J6u0YOcl2M2jN2QmAU3k0H2Lbqu3tD9WDsHMiE+4sA57dhGBYQ6W7IRltKbz2+92/KWyV5mwjSVSADkI5ZJmHDWsAph4eP4XwaHFFvENqQxQqtiMmO/74bVUt0bLXQTJGy7V4gc5396+sqYSMSJo3sHMcuJl4SS9OEyamsZptFm5etpwcsRY98G2GZiqDfWNM9/+x8Cq/CxP05NioKHLRzvFiXlsB8HNOXmpTExZJB1RgWEtEOOEKZFC2KQwk6sD2U7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fmgHEvWsc1of1sfG02vuCJKV2a5CD8X/51YBEaloFU=;
 b=S5Zy4ymBU3AGe/Pn7RYk0sOJhJnQBe4K5Zl7daDNDCZCT+39Je3eXRn3+uiAU8HQIhRxGMm8w3LRghSp2+549+x4qdJ9eFWuAz8FJCy2oOeFk+WMAAx/hf1Crq4nCNEUULhYXiwhqPg7M2sXvv0jekgVDGyTbiVTlIJL0NpW2AU=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CH3PR10MB7959.namprd10.prod.outlook.com (2603:10b6:610:1c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 14:09:45 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 14:09:45 +0000
Date: Mon, 8 Sep 2025 15:09:43 +0100
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
Subject: Re: [PATCH 03/16] mm: add vma_desc_size(), vma_desc_pages() helpers
Message-ID: <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
 <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
 <20250908133224.GE616306@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908133224.GE616306@nvidia.com>
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CH3PR10MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0b4958-a33a-4c86-b4e8-08ddeee15d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EdLjd+PgSOPfCAyygO+i7lOx6b0k6Z+apTTBD/Qx27zzGX7u/Vi0aX2zMRNF?=
 =?us-ascii?Q?sNqZHpohk/mqDer3n9YFhYsM7jDp+OSnaBR/IfTIjfyDWAV1nPFZauBz6oXP?=
 =?us-ascii?Q?N4VUzUva0i/ATfGNQLDrJIMq4Bs6fJKWmAyhoYdxRt8AOGYzDRQQFtb79Bkc?=
 =?us-ascii?Q?5WZfuHk3i8U3N0QBwuUEe/2VpMqmAQbkhiI+JiKb3tNJ5B2keR+kiYs+CaLI?=
 =?us-ascii?Q?t7EaOtjUQJJBsliiRRh/mJwoDREC10OnPZhoNUMPjNnvWtCRcm1QS9dD/CPZ?=
 =?us-ascii?Q?KxNqdIyCBJSHZMmp9/19A31X+iL4wqWMwqFTr4hMA8o4EP42JBx+ISPmDN3b?=
 =?us-ascii?Q?qfMOtPSsO6QTLGFBOiSd0UZzGLkztdAaGf6d98bCNPya/RKwq+rkTJA6xGg9?=
 =?us-ascii?Q?oHJ3A3dynlPhkFDmd9LSoye2/mRBFJPirfX9bcpk1i2NKVs5yikS+NMO/Sy3?=
 =?us-ascii?Q?fnrT36g3w25D3hUBx4nbp/ANTwyQEmGlaT9ug7wkgHuKgZLa3QYjiEAHdrQI?=
 =?us-ascii?Q?7ecdHJA58ehK8abx35HE56P/Wqy9GgT+nNL+B5yE/Fxsr5qldHuVlXm/HD1L?=
 =?us-ascii?Q?YBRci8n1JdWW/SUo/P+p8OhHdsMwpFw+HKmLumtHyOYHzzn2n/Iwt2OFSjgH?=
 =?us-ascii?Q?7iLwCdV811UB0dTPhKStATtGPIrVdJVxXladTBgyvTUeJcSdUbUDNJcaYHIH?=
 =?us-ascii?Q?0JJY1b0AtVoAkoMcpkNGbruExM0vdmtN23ksvFo7LUGVrQO4DpBAacaWvRgd?=
 =?us-ascii?Q?vUzA9DaTyOAwrC8MdPM5F/IiFImnIwVxWFHCstYgGdnZ4fYvzxoBku7pMOvI?=
 =?us-ascii?Q?FEo1UcsbgYnY+KGpv7EpGrtXWMK2tuimaOuDtHE+CQn5sdNc4mZhX40hPRzR?=
 =?us-ascii?Q?MgogajqOqkcKZlvSKygcUOCa/awPeK6BJUFnfXge7L6N8nujYfIx15x53hOj?=
 =?us-ascii?Q?zm5PzavY8sMVRrTL6yBwSRUZIMCox99h0m85GEQg/OfdjWRBSHlXzj04Ozqe?=
 =?us-ascii?Q?Keu833ydhr4ggHlgvinox5eGy0EW/Lx9x9b+Mv8x3z69lEylVADsCtuAaBFg?=
 =?us-ascii?Q?wGXwaPVLaFhD6pF6GqGLPQXgDb7hDYxCKJwplBlFw2r0ihWdyQjaOzQGVMcz?=
 =?us-ascii?Q?h/KSB2hk3Mj9szK1jPNoEt7dMwyqOz3kGqvwYSs9qPUSonMfb9MvqviUOTSb?=
 =?us-ascii?Q?kjczG4dzQmKohfqUOG1ap3q27PrTTpa0n9a/AWoLooIPc2JaBv/7LfzcwICd?=
 =?us-ascii?Q?85fCM6dFOOcDCQfybT3WhwNUEoMVxIT5E90jC9l/F6NLWvdkvng8frUUaXpJ?=
 =?us-ascii?Q?cfrJm/vdWkzfUQELvS6m4VTwB3D3tgKeaRJn/baxjVmE6KSMPrGkGyMA/LsZ?=
 =?us-ascii?Q?QfypQzQpqXcJqjJUa6U2pL2xKlQ3r0VC709JILyjBA9ymyNFCPbmWFSI4f2I?=
 =?us-ascii?Q?0fBFQAegDpA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P/UmXTTeedtjxFpovN32AaZL+Hq//Wu49TpKq7JNqaVhd8LSZKG7zN92xytq?=
 =?us-ascii?Q?ZHB9uiSw9Xw5l9XUtTt7aSKjPtakVs6+hRh7HKdMpKbrsSGp9WnuC4N+s1Fu?=
 =?us-ascii?Q?V/LxkRb8u9leqmAM6ua/50Igc5LOsWZHDJEldnIbWPh777hRGhhiRN6wPG68?=
 =?us-ascii?Q?UvXmaOxDHJ5aAGR7YYfvG9P2IBKCAnA8FUKyU4QPkcG7HBZ5naiywFct2cZK?=
 =?us-ascii?Q?kNKRwlWBAbWBU32okncDMZnfRvIFNxSdlmZpONzipqlvGofrWWu/c3VjtY7B?=
 =?us-ascii?Q?N3iANAZ4WA05l4rhDfgNbZAnlD/1o16LJtRU2orveJqzpjrzF3G9284kOvx8?=
 =?us-ascii?Q?KkvIOuHt+KNZotaUmd3hVgvEXm+6lVPx2T/QsBkzxGz41h3iyeTu5ZEBycAZ?=
 =?us-ascii?Q?8hxCiaZVVPzAEgLefjdZOKEM/AlzniaRAmLEy6YXnwMgZc4D5GV4NiHa1Ymm?=
 =?us-ascii?Q?G427KGgzrKOmfEUmr/bps96Gwv2l3Iux7ETZ+wtmLaqREBBMBTvtnRXbEDuX?=
 =?us-ascii?Q?t55zYWOxmc+9tg7fJCKzQF8ywD/wJu62J13XfwpMU1zgQEoUjrZkUI8OHWsh?=
 =?us-ascii?Q?SqAWl7zOu0bCivXdQBusNickHK5CyXpxLYF7G+5slfEZMhsCtuK4cB0XE/7Y?=
 =?us-ascii?Q?iOTe7RSsh1LNKQPSTxfLMsGAUGhWjVEhMhSEcYzEO5D8R8ZP0Zs1QqaH7POz?=
 =?us-ascii?Q?4EDgSrSJ8MgPwV8x/+HCSP5nXzJVHRjpdbAp9oGdfc74l+uhbXPOEgLxfkuH?=
 =?us-ascii?Q?EUyDs0MTKWkskoV4mz06sSixCP9jwgOhSdIQJ7qFU/aOWZk4Z1WZF6rPaeyY?=
 =?us-ascii?Q?Xtc2QwqxthyyeWxOvxlEci9LTHgpQpAvXKUfr8S/6XRFlAtFp4p35wrvTFag?=
 =?us-ascii?Q?2AtnGw+mVKgYgvoLVfN04uO32cd6ej8AthFZIsNRAJ2P0zpMVz6DOHXzv2hw?=
 =?us-ascii?Q?yd8KcktCBiLQlJvM6b8PPQKGFZDvtAq5rwaY59t2aA729uzcBYDKmIoJXCj2?=
 =?us-ascii?Q?CZKNEQuPzUynj97EmvneLQrjpxG3wK7HoF2KUsnJNHvIDhnlshQynmnUCb8H?=
 =?us-ascii?Q?QHE6344H9v9Aeht3O0UrDV4dHTxW+vi1GbgMsMPVTaUrmrpCuGFZDseujCur?=
 =?us-ascii?Q?z9tzVCCdR20G6ikGrrupFHqalBUQe4G9sdqgZiiQWYoD1DRkAvDd1jaHhxyD?=
 =?us-ascii?Q?6C9jLr0A4Cfy4BJzC8gSO028TPAIvx3fQhEUN3ZLGONSRv8TLva2Hss6q1nW?=
 =?us-ascii?Q?cebaNyFFdHWN0M2ppyUadlFroTRBcA7PVD5MtgfcG7ikuxLrYt93i3pe+lUX?=
 =?us-ascii?Q?5wGuwH0M+Ut3MtLf8E4R/noqmJYz8rFS10MIwwnnyzzOIKTgYwBu3thRMzd9?=
 =?us-ascii?Q?1PCtnJCrPq6JHvlyea44BBK9CQtNkBYlmFtOt3Cc/VxI6Dza6HGPDKPqMWB2?=
 =?us-ascii?Q?QPzU0PoOfUHg5U2yAEaTSQQ1vG+5bFezY1yKRUPSqyn9GuJYhSHNdS4mys3F?=
 =?us-ascii?Q?0y3EEX8HGTavmvsr9nazoO1nm4BDE5C56TuLy6z+ZhFmWJDAi2zOhkIY3Jq8?=
 =?us-ascii?Q?cBqWvZoMI58heXsU++pWo3POh8BWztaRp4ObDUJNSk9Ds6sOZUSc0IgdNfNo?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RLZJdv37Ffmw4bnglUHwohZab39RHND+piblOh/ebrS2V6FBvX9q203VwORHD4yFrL+hOUJSfAqUpGcbKjdpJVhuZtXfnngr1aaOoWSG+VLDRd1xTTWEfpRieQJsqzHE+ckPG88mi8MifxdcBg7E+MAP2w891ttN/72CzwD5ofAJAcg+/JoPhGaMBqbbuAdpssusIAd6OT0gwt5gRg5p2+ULCxLw7FfcOHb5QEn4k8R2UhFgXUIDrqnBpRjkNSIOOIlu9e8OavFxjDsR1ucGg5aXcEtOji0KJ8cZp9o3DWy8M4YospWvdvzJz74jWY9BR3KVszvHn/F1tOJDs+KAs0Xtsmo5crINx/2VWrFj8O9DZLffuBpqzNiBIw0RcPG9CfnRByRwYB0z6yqM3UBrcrcu5u7oVwzrexLRO7GPuZ2Syl9efHyUWw3qnVhpEAA34meGswcn3JAamuzrpL8EYi0pSwfju324cwMvp9YkJ19Y8TwE5uvW/zMKrTKmRhkZi50faXL9fbesXJ9SIXQJlZRzgmQIwv4HChcNlF1VnkBOPRxMzHBTUGD/k9T1Eq1aG3NbUz4r5NU8v+jAK3pd/81UCp47xVpc0xsXXK1tVuU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0b4958-a33a-4c86-b4e8-08ddeee15d1f
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:09:45.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrPsBGpKKQypuQ4zuT/3YgPGgp8LWoY5PjSXglHBSovM5zVd5kghXYraL88nWDPM5S1Lvc0CG4B6R/5pAVF04j6uNHgrrLVBa70DQ3UDCOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=875 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEzNSBTYWx0ZWRfX4DazJPVj7rx2
 CtnBmiJRkp7VPxPsTuumHxIlWCtkkOT87sOXQRldt9b0c3q2P3qTHbNTJOOHHviFcZmlWZoLrzv
 FF4GpkW6AdGo6xGBdvh15sF3KQaFXqEJ8hRe4YrBz+i+COONZ1jMzCBZVBatd+TMRaynNUh7jWk
 UXxJ+ofbUPN70AIRYR+Q2hfiDmfdCXTwK7y3cYlC08dH+jxDpt9HHwXSWYXrh+M9vWjuXODQOCV
 TUSATPk4xTtUUUdli8JjWFo6UlgF9tK1aE6kvK8FBmeMGUULbt1lZ+rBih81OB/XAInDLhUi6kg
 Oa9V6j2pG5TFxkzDqjs1yxTVtS/Q30oy/cyjRoNzI7dkjaVlofp+36TafUJPZ2rrEGuOBxqUJm+
 Z6IYsypL
X-Proofpoint-GUID: NiMKq0tBFlEia4G_gAmc0y708ZuvdZrJ
X-Proofpoint-ORIG-GUID: NiMKq0tBFlEia4G_gAmc0y708ZuvdZrJ
X-Authority-Analysis: v=2.4 cv=HN3DFptv c=1 sm=1 tr=0 ts=68bee3b2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=lrOGBHhT5SPghq54ymoA:9
 a=CjuIK1q_8ugA:10

On Mon, Sep 08, 2025 at 10:32:24AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 02:12:00PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Sep 08, 2025 at 09:51:01AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Sep 08, 2025 at 12:10:34PM +0100, Lorenzo Stoakes wrote:
> > > >  static int secretmem_mmap_prepare(struct vm_area_desc *desc)
> > > >  {
> > > > -	const unsigned long len = desc->end - desc->start;
> > > > +	const unsigned long len = vma_desc_size(desc);
> > > >
> > > >  	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> > > >  		return -EINVAL;
> > >
> > > I wonder if we should have some helper for this shared check too, it
> > > is a bit tricky with the two flags. Forced-shared checks are pretty
> > > common.
> >
> > Sure can add.
> >
> > >
> > > vma_desc_must_be_shared(desc) ?
> >
> > Maybe _could_be_shared()?
>
> It is not could, it is must.

I mean VM_MAYSHARE is a nonsense anyway, but _in theory_ VM_MAYSHARE &&
!VM_SHARE means we _could_ share it.

But in reality of course this isn't a real thing.

Perhaps vma_desc_is_shared() or something, I obviously don't want to get stuck
on semantics here :) [he says, while getting obviously stuck on semantics] :P

>
> Perhaps
>
> !vma_desc_cowable()
>
> Is what many drivers are really trying to assert.

Well no, because:

static inline bool is_cow_mapping(vm_flags_t flags)
{
	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
}

Read-only means !CoW.

Hey we've made a rod for own backs! Again!

>
> Jason

Cheers, Lorenzo

