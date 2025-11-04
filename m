Return-Path: <linux-fsdevel+bounces-66877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A674C2F6E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 07:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D3A3BD7DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 06:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832B52D24A1;
	Tue,  4 Nov 2025 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="khdkmcpS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hXY3laOM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490902673AF;
	Tue,  4 Nov 2025 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762237180; cv=fail; b=t4rJepma9pRZWlN3agdFkRtma/8F9qDDEmEOwGWfPSg82lYkXSUxRfqDh7YSyKCdxqVjI+yLvmdSaOStflIZLOWsosA7pioe3NN9eG5bLjWXr4JCbDaDlNI0TkvEWh833PssIMX2Ajg9tDbgGvjbmkciQCjbcD2goscKwaAb7y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762237180; c=relaxed/simple;
	bh=vu88teKAesFOytZgo1YlEsiT1h4e/WNEAjVbYXJgjtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BdoZelSdKL/EBR3K17dsMcNJMw3Eva+7gfnUTGImPtnooBT5JUvb27l8od5n3CGnxKROU8uP4wOXdwyRUtx5i1YwtRE5cGQUn3jj79rkAat2sqgXtve8AUOOo5dFDgWw889wP8tR5kSZ741DWdaadZyyKI5mkMzfxw/cJlGPiY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=khdkmcpS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hXY3laOM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A45nT4g023674;
	Tue, 4 Nov 2025 06:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kMP3nlgUwBu6A6tVuN
	gPOEu7gc41DMqSrH2zHec7Uy0=; b=khdkmcpShcbwG7nKQILxxDd98k+fZw5nPe
	E7U+RxvEcN/T2QutsffNdIR+4L1JZBYOO9ZGwgZQKrG1ZnSzmgFmIOtAymJB8DLl
	nqqlUtp8UO1Vqkt90M8z7BGS/Cbj8kQMNChyP9L5YIyRJQh3+WhdCLaM9UXHR70g
	6mzyuKs2HPw26F44pSmfKNwvF4FvlMF94tmbKVbUDBHMSO8nQoAd5BqbhNjn539d
	yCeczbmXJ9zfNqIdh4JG25wuTVMlLnjsqirLqia1IyaGGLK+bpSy9bZwYUsL4XQG
	fp5yU8TVdjjfHYUFKWeK+8VP+XMvHmkTvGJxAgrF97iRpJx3i4lw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7bp482mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 06:18:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A464a5x021804;
	Tue, 4 Nov 2025 06:18:30 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n95rx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 06:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2kPfLlSTdLWpqMX4Ezz1VSGmhW0oaJWfoSMftU4b+FDi0Ct0nKm8FRr1DZtZqhZ41nT/ZyDXGLDbm6TlNKpCoDXoiIEq+s826ToS8lJat4PyjvQoyJ/1c8mDaCiyXPEPswT6vr1rSLPsF78+PiQyZBbut2TbDuruhCke3uBWi2he9PAPbH+QamYQ0YKcb1hI8ucI0K52EIED4TkYiWjePGSqbtrlaCdWMSrFX22L72hgvRyMz68qVjYpx4uQmouUixiaATXWx/N72Iq9VL1b9bE6d19dbM2Yl0v/7zX7Olvv49CTJtUhlRtNasyxEXnTS5UtzAxcNBlgDWPekl6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMP3nlgUwBu6A6tVuNgPOEu7gc41DMqSrH2zHec7Uy0=;
 b=RdvcJBFbN6hmeNJmE1LEpeDPbPLRQ5pfs8kbF9RVcnMkPgy7vTYjlNHh6LGHAdDkXWdLLe7EFkOsacGJPZRbiaN+OMUJmj7N4QG7NfAGFzGFMbbF7L5RfSfPglGYYPF+HqE0UtD/f+tvAOp6GS1obvBSh1oTyfc0J1fjhR1/w4GR7dY6W517rFhhgFETnnoCgzmvQKty6q2Ic1aruspRV5Kk/EEyX6NBg1Tz70mGxUw8YVha7+zPS0MqkGjZqAoVsIbv+AcDhSpIMsHtBS6BX7Uwb6BWEJKrou1947eWos4f3E9j3ArOKHpDVTAT4YQerNYI7FW3P4NU6eY6Vk5Q1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMP3nlgUwBu6A6tVuNgPOEu7gc41DMqSrH2zHec7Uy0=;
 b=hXY3laOMVYZHabRTOm4pGqidmGvrPL3TPvjXv1yA3F83mCDmHIo65fzMNYW/DEWx62nUIE11SW2DtiPpI4768KrIbJSni4JL/HJ0oBaj9wNyAV8d8G2f/0HWi7RrTKE6cT9qece9hGdTRDSS5Vt9/3Bsktb3TWt52kKmKQGhBRY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Tue, 4 Nov 2025 06:17:59 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9253.018; Tue, 4 Nov 2025
 06:17:58 +0000
Date: Tue, 4 Nov 2025 06:17:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 13/16] mm: remove non_swap_entry() and use leaf entry
 helpers instead
Message-ID: <4700dcda-13c8-4ba7-aea9-5513c01cc4a2@lucifer.local>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <b4925aeaf6b7e8255b1cf1585476b718862b8104.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4925aeaf6b7e8255b1cf1585476b718862b8104.1762171281.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::23) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS0PR10MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: eb47a228-537e-4173-a709-08de1b69e690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jAd4s+nhPYforcmtUbcQbMWMbyhGeiHuvb0VBZn1AqAC5rRYAIWD1EOJD1FJ?=
 =?us-ascii?Q?OQZvE5TjQZbOmKVbFdaRIqCnWW6T4GV2lPlZJE+Tg6ifLYoUaOcpg1r9u9VQ?=
 =?us-ascii?Q?96fmfPTUj8DbFKNKwZdDXYADFy5BaKvivvPECsvQ4dKKU4f2nmesoKiYhh8f?=
 =?us-ascii?Q?adoBy8XEtJxoa0ra38dWWu/A3LwSfeC67k7vXwgTVCY0QWx/fg9BrZjeYn5h?=
 =?us-ascii?Q?gCZ0jktR+zLwpCt7sCrjqeixbAm6TyZMR3YMNyZOrLknjPjMKX/Jp46ASNsu?=
 =?us-ascii?Q?ah5gZL6/jWsr/Ai7aFStTGMZpAGnGdnuoZnFHE/p1iJI2ErAtTzu3WTc8myX?=
 =?us-ascii?Q?p0143A+2XxFuHPXI9QqpO0MVtYfwy6Fufb9BpVg3Rma7yrIHQ6vQhxbNqk4M?=
 =?us-ascii?Q?OwqHbOgcz0Kgml9oEuQtp6+l8O27KHkcnl8fprguLQoTRDdoTbPbumT2+H2k?=
 =?us-ascii?Q?Izi8e7SUbySyBXUmAIeAVaEympE7M/q3qny+8hX1ExsxAkEOlmEJsq3Ymi0S?=
 =?us-ascii?Q?u2Pbo8MmeuXCN2xwLHbBJb2BtbBKVv8pvbilZ4k8WvFwIlKVfjatAAuHOpMJ?=
 =?us-ascii?Q?LquuN4FL08S7g6rlD/QynUbAPHjRP/dGlenjlZvTrwUSsKGA4q0dTd0Z2pkX?=
 =?us-ascii?Q?fhFitnjb/yAJeehHMsVVZG1oB5BwVhEvNVwjTO9BGxPlZgn027YBaz7cbohL?=
 =?us-ascii?Q?R1WLJdwspDHhIqScM6Xp9ii3mGqu825l+OBxHrmeCAltd79cEPXD7Qigvnks?=
 =?us-ascii?Q?1PeM2fUmRqywY2jCFvpOLGIFQLmlgkV6OsY5zQbQeWoCUmVsbNnUZUe30V42?=
 =?us-ascii?Q?yCXUgVbj8K6U8a4jCGvdxiIdJnISOHjtkYTMy5AkqN0dEejxrVXdl9s1sRip?=
 =?us-ascii?Q?+47A0CWyjqvzjW8uTBBqGBMxyXb9O/yPQFmfO3AQ91pYj9QtvXAP+L+zxP+n?=
 =?us-ascii?Q?6xFzZ7foU9BAc/LghYZnUtlaQ8+s0qnJChFBJBXtXks/dfRr5Fb9XXUlh5A0?=
 =?us-ascii?Q?q31zanYgWvBXkpvM1xez9IDcr5j4ZtC1/pbkHZpDLXHZf05D7+vjiZmQ5jOK?=
 =?us-ascii?Q?ZcYvfAYo9/bFblRjinRthmOhyAzVaK9Dr9BXYHCipPpMbdSxANzAudaSoq+Z?=
 =?us-ascii?Q?c7qejuhkPwqJgI3fHKP+DGJXuwhpD3Z2U5OiKmkimDUE3qNEZqPA1SK5Q/fi?=
 =?us-ascii?Q?8vxmpC4Lw8eMtwSRsJgMV/3bLVded2ng7cq9aFGTbXmoV+CAXhr9uMhNcOsx?=
 =?us-ascii?Q?Qt1WWEOMovVS8si7C/jgJWkjMhVI1Opmr17LvyR9SaS88xxjKeYqVr+E3tA8?=
 =?us-ascii?Q?1q4TysFxp9tuExD9VjoXg6qJ4PgpTqcAjFzPBADcnz7ck4jLCqkJkB5htDXc?=
 =?us-ascii?Q?ZO+PoZfCiYWMBYcMmhhlgNT+dMs2BiWS62pJ89S0DlHD01AHcbLnHEdlsY5c?=
 =?us-ascii?Q?c7n1uSxVQ6lPpM8olDQzEOOi2chNRXq6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n/nsU/v05I5gkQF9GqtAXF4w7T5WB4sfon0sJJwbsLykMfq7LuV5amOnFTW8?=
 =?us-ascii?Q?zJVIhVOLXrJTvzINRiiJUdwsQTgqJ5u/7bn69cAzY6bp5TDp5WrsNltl8du4?=
 =?us-ascii?Q?Rgzu27wg2nsN38jUMBwF+Y1qzRG8yiQaerxWPxIw97A5I43M8vqftGeM7ixi?=
 =?us-ascii?Q?U73CEI24P0NpUrt1BXibgpwURjbZjMGUPP/bJ+NHHLNevOhu9x/0v02779F7?=
 =?us-ascii?Q?OjF6t12Bc0XZyd/yqjw8tbLGItT83oPAX3QF29Bt5frrIqooG6lS+ZOYOyOC?=
 =?us-ascii?Q?K54qSilk/7vtRlBTXw8j12m3GkBuNwRNMCS4ycwY2b/9WVZUjLiWVTwL/JKa?=
 =?us-ascii?Q?vtL5k5fmaYAeTx54xeVdzq6dypSiTvTHdWFCsHk48K6OebGvwwuIHc1K8bCl?=
 =?us-ascii?Q?5XptTckaqDw3b23FKosjGumYsuKg42n1W3bTSNMFGkmHYWqYWmGxud5uaLY+?=
 =?us-ascii?Q?XPnjhrDPBQY9fhTREK5fKeP0DIGvw4+UvUYZgohTKXMD2GTk4ECQ5/4UvBDX?=
 =?us-ascii?Q?O38WtRJGrqNaIHVG7mMhKNH6er8MndcreZLbmck/g26kDBY6P7C2WNcqxCSV?=
 =?us-ascii?Q?Noe2LTE5EyKN1C1ZYBIghbjuNpHiRGLsopAvuwdoDIgpIa4npBAy5Oc8IxcF?=
 =?us-ascii?Q?UT1tgiFDqGkNiI8EHXusZ92G9P2hKqzuTHALJW8WUbxHE/LM6J83hB+Ov+l5?=
 =?us-ascii?Q?TJkdV0DpghG/bUWEJdVdI1bVfjg+MMs/qYsa1ar6ZpauO9wCEhnNQlpxZV0q?=
 =?us-ascii?Q?4AkH3CwtmG5DoQawHfszEbbzL71M+MctyhimlhTDFmpFMisKSxik1J5vXOnd?=
 =?us-ascii?Q?GtPVPH9ufct02LK3gFGpYLeg/H/WaKu9fKZu+clcmvdj3rddW8MqvuCT4ikv?=
 =?us-ascii?Q?vOjYpvoUOrzIR7LRnQmmJ8/XvvJQHNQUCr+boDDKvfk1altpZZUlgLTaP1wa?=
 =?us-ascii?Q?hJHzLLzd/ck9gklUDd1zhRczcOM6qsNwF5yhc8A2tRMpLB3lXQDptBpHSChM?=
 =?us-ascii?Q?SydGcCBST60qYxLI5lsPSSw6NMhA68YonzJaYb5+FHaQCpKrgUj4oFot0i2M?=
 =?us-ascii?Q?3dm4rWwFjbxbXY9F8IEW/T3OY9ov9kspIn//GDZaW+BSzKzMRDLXpyxQOAi6?=
 =?us-ascii?Q?7tvzUZK1gVl9b8bXzG/tUz3oNtDOhag1gCrivSdrjsIHtdcWK5QnqZjTS10L?=
 =?us-ascii?Q?YtrP5sQsJZZeds5lmAXlEyr8P0BD2XnHtm9L+0ctpDvORotlNG8fP4btpRqN?=
 =?us-ascii?Q?2DDYdUXj7eSxD/YKFVVo2rf3DM+7yvzEUhpCukTiH2zKX5jBUyFtjnQjbga+?=
 =?us-ascii?Q?jCC/SgcPtA6eWGAWYoTMaXN/lvX2SEjVFZjZh3nmeM1ufxeipRLG+3uOHlBo?=
 =?us-ascii?Q?WM+qhwy4YyFG6umXCvfleNX8bqnxL0uDS9OnMK7P+Dm45wm7+U+GFvWUZZ6g?=
 =?us-ascii?Q?lm5EitKI2IGOurL1JhZKcYsRQmvoifUb8ZysYvg33IkUJmXwF3S6+TdQd3Jc?=
 =?us-ascii?Q?rmqIVh6TAHSy/39mvDNO1lT9y/WA6vuK9oCZUtHdhaGR1yEgQTAGI5+hzQiZ?=
 =?us-ascii?Q?VpDsNy8EgNF8v7Q3oH7fomVLetXhxB2MyTX1lCgxftGjstX22iHN493xsDPh?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fJ/4gKrwot7aq54xli9qVCu6Cb4Hi8aYqGh4n9oysF4Ca6EGwnJA1bED4a9IS6HrneZTLKcaUbA7sJiNDZq3Gkni4Vm/+YLA3ggScmp23wyA+kjZsRlFso93xY9UdAx+H3lv8UQIKKqRylo+UolERvZe8SUdkhAIht1XFLQf12LPx20h+f3m9gXEqVMSpTIvEFDxWUvNIcRJzJP7tMvzg4v3zn3/oZgHFWj0/HLLE+m1x+YFIjduLpiQaOkLpFmVRUnS+iQV70zNS8zYb5VDL9kPJrvxMISnBIxgHQ+gJrxWLZOQ8qfRKOOYSzbG5zEze3Ppm2OI+lU4R2t3waOM/5+oYuG77hxP0L4emIXJNbvCL14iIT3mAl62h/DqNdXgQd5OFzYOluLxtdBYzhTdkpoJk2dQm+Dm69vTWV8IQOQmhFPyNKpoAHNsLGmFV1sFw4LwTEVz6Os/q5pxVovQOLONdBtTSx0AXgEgEycyD63fxsu8XVN5mHgemRs6Fepv15XcHBLpBWq00z+/Ov5ZuqUQZZda9MLkgYKyNGj//g68HNta9YVFfWSGaDUHAfOJZXCaYLnJDp0YWQHPNL5zQf4Lr4MeOhjYbjQ6Ifzypb4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb47a228-537e-4173-a709-08de1b69e690
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:17:58.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMbPtVqrlfz2T1etoU1uvL4hnaLj+472r1fjGB8AS3Zxp96MVzme/D13S6eiqWnMyaSBt21n1Eu+9rfyTQJHG8Ef6TGyvit3MJv8TnLQxOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040050
X-Authority-Analysis: v=2.4 cv=EuPfbCcA c=1 sm=1 tr=0 ts=69099ab7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=8L6ZMdIMe6pJOpmClCAA:9 a=CjuIK1q_8ugA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA0NiBTYWx0ZWRfXzkhsjndOprVv
 IzCmyTqowJbF2ZftRxBxyzwPXKLV56po/HjSTR71RPnq1eN1Wr8DKXpIMs4iZufQH2/sQljfad5
 rAFLy9xJy9W43BPNmFiVQAADdZd0/z8kNOTB3o+wosPAi0yy6GvEuO5VT2JYbgwZB6ne4sDiigM
 FcxJDNaK0613FFHynSM6E/HpR2Y9o4uhmOe5yMb6v7IPN4RE2oVoys0lcNnmxUc4bQopwrrEcnV
 sWzGtLoNZTWUS/L7gHgm7cONRa9qbLhIaOJKcyXEDGdDaa4ZL8NBybKHnw/Rls+20EKQ7ypdYF1
 oeH96R7bWUTv+zJjNZ1TKyVNKmj21Ejaod1ezUd2mPhgLOQIaegnXwqg28oDZ3q1wdnMgruXR8L
 crduvj7FDnheahWgsHEALMVRBbNJIQ==
X-Proofpoint-ORIG-GUID: AdnrKr9oKhZlv7ex3SyE4Ol5Sf-wR5Io
X-Proofpoint-GUID: AdnrKr9oKhZlv7ex3SyE4Ol5Sf-wR5Io

Hi Andrew,

One instance of over-zealous const usage in s390 here, could you apply the
attached fix-patch please to fix?

Thanks!

----8<----
From 9745904b2ac48856cc97b33d54fd42764e8e3d4a Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 4 Nov 2025 06:16:03 +0000
Subject: [PATCH] fixpatch

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/s390/mm/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 7805c5a3755e..768cffddf4c4 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -688,7 +688,7 @@ static void ptep_zap_leaf_entry(struct mm_struct *mm, leaf_entry_t entry)
 	if (leafent_is_swap(entry))
 		dec_mm_counter(mm, MM_SWAPENTS);
 	else if (leafent_is_migration(entry)) {
-		const struct folio *folio = leafent_to_folio(entry);
+		struct folio *folio = leafent_to_folio(entry);

 		dec_mm_counter(mm, mm_counter(folio));
 	}
--
2.51.0

