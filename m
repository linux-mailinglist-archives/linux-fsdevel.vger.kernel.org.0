Return-Path: <linux-fsdevel+bounces-57556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF21BB233EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD7D7B87F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067D32FD1DC;
	Tue, 12 Aug 2025 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p4xoVN6K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KTCLpyiN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF792F5481;
	Tue, 12 Aug 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023662; cv=fail; b=POsAi0n+cT3iHKOEAeQBKh65Ork8HAv5kYDrGdLfGFtALpvJG2OX3WxshK1A4zUXAfLrRXWDQOozIy7bzVD5sLC2upGb354THkm2s+DPy6W8PRolv1AVGMicp5zpH7vhAduLWJGxGLsj5tSjHVIyTwbtZRJ/h7QHpYuzitUV3BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023662; c=relaxed/simple;
	bh=zH8hN4I7QovvX7LT9GMJEAPvb6paI8u/SNqTyA/JaqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tqF1IJ6UUGBENe7FvOlbMnQ661JSfhFH3YH3YLxSFNE2EiEsOY0uzstJGhb1IkwtzsACHrFi5E20LxSM2grLsEodWKIQO/wHnoRHEDtC7K2cRs+eb5o5bgVIi09/ky3WzClZlovB9id02znaaDU1/79oKA0rsHxwZQUOplvxXmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p4xoVN6K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KTCLpyiN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDCJ3a003986;
	Tue, 12 Aug 2025 18:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3gcxJ7Z2tmSqKNFv/g
	Et4p907iBlTJJXkhGa7WvVgV4=; b=p4xoVN6K6mC8xOQSoivqfVeMkrCBGTxFnp
	iyiqEQxUKEsIQrMcL4UUXrK2zv6CzPr9OPj7pswN+FA4tavw1+8p2jWkZlrfsfTT
	6anRHXMP3+b39rz6HGQ03l8F/GEoZn6PTOk9h6yx0FYKKRO/RYcaaPIY5Zp+2rLO
	G9ZL9ZznIVFVkpDS0uCc614IyqUjw9P9POlhVM9ZuflP8yi7nxQuFkqw4PvUgZAy
	aJ/Omn8AMwg1zILpTlES5xFncybIMFYnSzy3Sg2Xa2ydpVQRz204u6sDa1K65UGM
	kgcUOeWXon+z005lZaAf0WdV39UJsC7axSiH8s9mCrFgiLAmzP8w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvrfwc1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 18:33:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CI0BnY038739;
	Tue, 12 Aug 2025 18:33:21 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgvs5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 18:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwAjE0ZJlYTVzV+9sMVoBizwXREjyMPbeEr9KbmwUx0FpugyfoanpkNMebsrwUOwh2yzKhX3qcTHpT+RWVe98MTdFoBS1GmsIXOWPC/6sMBM3atIursLo4sYkJIHzwjFUgbAjXnwfSIRjC3iiiPbXVDukY+jKiib07e4ilsmNFkUILNlXhyR7i/ZuE7hQ28AT8QQ8o5+qWHq7/UzTfMSqajh/a7q4Lx/2Urs+/+NdJNj8FROulKf933SL6/5P2PU6L40r4P48sOiHYuB/RRVDjTnQEj3J/0Pv9bTiVsbqhLfFpNlbrJn9LviumUtB3yk5xSFlCWaSS4hNCJJxwzhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gcxJ7Z2tmSqKNFv/gEt4p907iBlTJJXkhGa7WvVgV4=;
 b=wDAcNScA5KNJR7CFi1T7O37PtlRsZXCpHrLzVaLGMEyCiIZ36UD0HHhksbALHrHCKbeUtuZP9HQj1REaQmjUV7TG572B8y7w4EqR2MfVtY7xcmHL3EI/Xcpceu5xM83fy9xR92sfWTywMX9qUm71ZaMMDEqC668w9EHzVD5yrTLMIXVxBljotlhkC1lc2YuqaTQfLvqmD5yEKlc5FABqz9W+jvJB9Ral50NQ+N3MySCHHAaAvTjj/+9oHHRdk4NAiTcrOfcn6hyjUpDU6z/vZWbwKPNu+35EPFvnZvDCvtqxcJocHeKXYJZzFyJLlokOKv0IceLm3avxlVDnL742zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gcxJ7Z2tmSqKNFv/gEt4p907iBlTJJXkhGa7WvVgV4=;
 b=KTCLpyiNcxrldgzmLKjPnmmi/2vQHkxEXq/9gw+qPTQklJjuDI8VQ0kniJHnyiOf6E9c4UTJp18BHPLXyRPPIwAMosNrx5pjD8xW1O9hkvxymrHHtUTKxjSkDyKc9vMbjl4vR5kVaQZPaoI4wVuFuHqe7au0agWIX1bFMuqh9mA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB7463.namprd10.prod.outlook.com (2603:10b6:610:181::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 18:33:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 18:33:17 +0000
Date: Tue, 12 Aug 2025 19:33:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Subject: Re: [PATCH v3 07/11] mm/rmap: convert "enum rmap_level" to "enum
 pgtable_level"
Message-ID: <591fb720-0826-498b-9370-20500242855e@lucifer.local>
References: <20250811112631.759341-1-david@redhat.com>
 <20250811112631.759341-8-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811112631.759341-8-david@redhat.com>
X-ClientProxiedBy: GV2PEPF0000452A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::34f) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: b4253f5d-5d68-4b72-fc5f-08ddd9ceb493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8zFfm+BiblF4pNY+2SbK9xHMqJXP3e3i9JUcAPGXj777BiUiEz/pNg2cZAdz?=
 =?us-ascii?Q?ZYRA8bR1jklpwBItaZLgW0qGH7GxrIRqExjq07l5xp55jzZqzJSnKAqq05kn?=
 =?us-ascii?Q?GTtw1v9hs7XGsGiPUxCG+z/l25H7Pg2nzOOcOxiVfiH3/NgDZS1unNG4Bb2l?=
 =?us-ascii?Q?CBnANTISc5PtzJKiF2nM3tN0I15TciAjQwOGV8AO+7p8p8xQxsx/2bW5Bnr4?=
 =?us-ascii?Q?26doiHuExoxlLtis8AsH4XD9VftBohvmC3p+5YdP4ehjzTTi4YMJb/7+Hdz9?=
 =?us-ascii?Q?UVWyTBgWeKYgUehR1lLxGVQaYz5nNRWXbY5tY5PkAjsic22fEOVYQdHeHnBl?=
 =?us-ascii?Q?jMsGCAJpdjXonXfkTZ6SI4kXGcHw8BxCVMIsAq45QwZaceOGeO/8VuRhVWMT?=
 =?us-ascii?Q?Rqk5PgkMuzrPCj7H0rBYtvcv0BzusxXOH8EP2yRR5gbzfmii53ZU1KkRBr4N?=
 =?us-ascii?Q?02JlGBybsXRb7/jNj2elF7IzuMGMGhALoyTdR4lwty84tDF6X3Xd8zohdqqF?=
 =?us-ascii?Q?c/7kVvH4UkptDSZNwrmwzxZeeKEG4OclV72hkHk5c0u88qYk8tW2w5rtSBST?=
 =?us-ascii?Q?tfatAxTrUR6hpZF+Aj//Lr5BY/1sYXAXwqtWRPvJYvAa1HbbhBVbfMvsdoh/?=
 =?us-ascii?Q?DVBgaSKVFOCBtret4wYfRidiGFVTHEJMEQt5ihFgsB7LS3LJmYBJVKZMMesa?=
 =?us-ascii?Q?XKfhlYduQ+mkfz5WpcpXYZHEPO46gJHLmrim7QV0e1VnPL/tV82Eh15k0qxN?=
 =?us-ascii?Q?7rfUjqjlheTPX9Unc3Ft4JPHyBdtlRHVC15zJNSMWW8LS/8b/N4ps4fBVP03?=
 =?us-ascii?Q?fE7oOBz74qu/vVOJ0ymzfvDCJ6zlDYeh2EBe6onS6tsiH07+0CfI+QV9wISC?=
 =?us-ascii?Q?iFg3vaS6BuDUXpYqToqY6vswi10Rml2810M30Bobs7voWQ+w9+mfs+uNwl0t?=
 =?us-ascii?Q?Pxc1CoRk72wobN/9nB0Eq7zJIM+PlbLXuoEmirWyG2LKxtXWWOJEOK62A3fe?=
 =?us-ascii?Q?q/AANQRUV1SjNV4PrH7aMNfVy7RGpPeDeWJJfzHixp0ND/VVjSGKMBk/vkbE?=
 =?us-ascii?Q?dDXRzHMgNoEKyofMB7fmJ1k05XsX/2Lioc1ae6BK+fatNQUqcxnB8jc5+4FS?=
 =?us-ascii?Q?fEvMRjVpEjg8NPSLCl0mv7RN2seDaM966yQrFmxxos6wYVh0Lc/B+fBKLF4T?=
 =?us-ascii?Q?1zVLwfdCPuwgOiBZYDBEi3hfoBnzvy7/MeJeeUjkT09xxtAjo4Twl9pp5Gs8?=
 =?us-ascii?Q?vBj37q1oK+Am05Z3Yn1Uoxq3tXKeyAPgzGCcmjFaLZ+5M7CZtl0rfYU15eRy?=
 =?us-ascii?Q?xRoc7eEPxjJzSXoOR8V9REDXUWcjgMBSY8n/NDvM1N/raOVXlGQTb+tN5dB8?=
 =?us-ascii?Q?y4MAymgAt258htdNvOJjSXJnoNugILKYAGAWDRBOHaSWIislhHG7GPmYvNHu?=
 =?us-ascii?Q?MTYbpqA/MnU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aLyQtl7fIqddYKZCIZzWW3zFSbDkYpkJoXP/k738Gc8LH9w4zUAQ+I4kFdTY?=
 =?us-ascii?Q?CuZw/AsbigPGLrXthXaEIiDjS2t2/bjw2vpRTKS5V7zSAyyP1F/CEd321N5S?=
 =?us-ascii?Q?o8ZcMdgZA66ZScYbcW3Cj1F6DrBA9MFReeRLEx411a40vJVPjTX+bRUYVVai?=
 =?us-ascii?Q?kzhRV7RjEOf1J0R/qZy1kfJ3NNvEjwDzRApQGsFMd8NzJXZFRnXHgMpZRXL0?=
 =?us-ascii?Q?uGyz4qgsSEcd7hCgHgEo0eNfFA1aQLfawqxeIcbcNHUiI0wPHycNFJ3yQ900?=
 =?us-ascii?Q?zUI6+rQ9BnqymGpqlAV8d2ZertEaqdyPziGIchHUD8ak30OkHCgtxqUQbZj6?=
 =?us-ascii?Q?1hHfP1DkzX3WK37kFf3VfL12pYOZ+eKQ6WKnR7u9jG/iRwa7Ak/7rfRRSaPZ?=
 =?us-ascii?Q?FJXTc1n/YbQk9Q1qje66EsGE9sZGpQNGNVYJvR+F0jOnyuHyzr1M6ciaUdBv?=
 =?us-ascii?Q?9lt1l5nolAnz5FG/03MLmMF7wUtlztDeGZa9guEZBUjdxPXkp7xMLvscjcI0?=
 =?us-ascii?Q?eYZ4QTUEfbLhv1b6Dkq9NrDEqRsNbToTReZtp/WuHndBCdZJCD5J7/zHTA0g?=
 =?us-ascii?Q?VDuLt2sUfOXtqYU/qE2cBGw8knrawxo9s8VGXHwEZwyLwyC+NfWMtgnuhX4U?=
 =?us-ascii?Q?pLIxka6F4Y18Emw4QUJRQRG7rX3XoKkQw4dcxDOnzHB4+hdNoaDW5DnhwVAf?=
 =?us-ascii?Q?zglmLtXFXtwRfchJ1gkIASz8JY1voN2e6uT3OvCvQtEflxeRjNx+AkluzsAC?=
 =?us-ascii?Q?dyZLmo8Wc7pK6LL39vpxq3K5jiPpC05V7nW8AKT6DuXHxOY0qmIQgzMzq/Ez?=
 =?us-ascii?Q?ZWkdcczmV6YK10donCuk+F3hj1wxFvJE0vyeDTv+X4BL6NVIRrXJRazDpCq8?=
 =?us-ascii?Q?Jdk5mFFM08qj3aVXhRW3Bp09ixR5cn+UZyNoz1BM9EmA8VUSIZEwrdcLelM5?=
 =?us-ascii?Q?qLaZzfpla/kuRksR8DuyxGd7kBLEBjSHJKzYT0qlx3FQyq3cMtZIuJIUJ+tp?=
 =?us-ascii?Q?mZADD8VTtz6A587Q/icmT5U6uagEJac6dTmhOUfcGDKNNhqnYPYQDtjCplML?=
 =?us-ascii?Q?LUh5x0aGN1f47LGp1gBV1SSMz/0zZ8pzisz+i6NKPsBDSBWUD4j4A68+FNkS?=
 =?us-ascii?Q?CPQlQ1RfYtQ5sPywU8LrOA/fHEQCS/vJBCfZadw9cVmA7LATmJcFVlFiYn78?=
 =?us-ascii?Q?IglMA0aszXjB1xd5xIdyyT3ckoy1tLzzkGZ2UDRCn8+kr1W6b+ZiO6BDOP2N?=
 =?us-ascii?Q?Dv0PqsG77bDgidNOf6kvghA0HY7Ez0ike5RocnSOjFyhEZFrUTn+4NF4sHgX?=
 =?us-ascii?Q?6gb6XaLrygKeWJPsbCNUkD3dKL/ZpnrGusqOis/05EQSiHh72W2Lt03yxijS?=
 =?us-ascii?Q?o36f6CneMJGkCV9FnBzMhUV0VDw96lLk7uUgecOHIodS8YHbLXD5AzvetbyV?=
 =?us-ascii?Q?onVkA+rGQWyLiK++BN9fkNepjkER/DPgmFgXnIldx//v+zki7QPjNY26Ozw1?=
 =?us-ascii?Q?bFH+Ia/j0jGeun3hCrdXPHbQYdboBbMdX3y767gGqRaInxdS0yHA35xQuDek?=
 =?us-ascii?Q?mdRE+rsy3DsfP3LSVJsIRNUMozme4KFCrG4tqTngLnK8kMio6TOM5Lzo1km4?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mg39jv9qhTetBFQNR3ePtwEP4fh7jq1w1qwwXZh6oy1Oxq62ztzAZQCcc/0PZFJ+keEXGvPWmeDKE0YHsmNI2MVAsXxDM3sJ1seTFLEBEBR1SbhsQMZCeNJVEtyMDprA/30i2GwkdRX0/alTBjIOpDvLFQQ06OrPsLlZVrnh0Er/2WSZvPRaVQ2FERZ8lQws2+uM3JygWO/Xln88RQFEzGEjSTlL500wS70g722RHfLEQDgy8yU5OtlNfHLs4M8eOLMOfBSLK4G5k0KHOXlCwdXacZTolWgZ+L0+n8chJLJDLCtynN4ju6b8ps1iVvOw1ZaAMeSKjnvEgAUbzlqKhyhVF+Tk7srGJQdBkQxKIIqGKK37ICEpQNAcX89b/R+gdiRkQC1qPoVzlsQZQB7Tqrirzd0zSGVCqVTe9mWTKtyEsl2WsyS2x04O93LsMrFaz1RscFo5UPQoGS6kRCIZGKjm/UILT4Qqy2S5I0ic4wsCibbiRjV1VtR1ZB3BE0dR8Gc1hF8wLYPpIKVClStu5qLOBiIZ7t7PjbniLGLjusOhgR/aL0I9kr6k2oKdN8qqEWEJ4jFrEFuPlZgXRVLpZHR5YLv0jJ+owJFlP3BPlb4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4253f5d-5d68-4b72-fc5f-08ddd9ceb493
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 18:33:17.4450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6KY0I9LS+EtKksmUqWqQJz7Y75oLqVIHgjeeTF1czFy7bVhJ+r7ON/LV9Q1/ql7Fw2EUW5+L9kLsqARVzPPkbIa8SrIAUt7GHdVJRNJvkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7463
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120178
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=689b88f1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=0PFBOgZE1WxlEsiV2qEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-ORIG-GUID: bgZcvZi0vonzO1P5AjdHkMXTK-4mkVi5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE3NyBTYWx0ZWRfX+bOWrtwkpaUz
 6Wrr+OBL5oeqDorpNJyQZm4IWDPRX5SFr199Z2Kb5R/P19vxXvtQCCBmo+xlYqqIHciouUR/tpZ
 fMf8ASbt9apjM3crYAFoK34+c3emO0ALt52lSnUOUuvpGplFojg82wASZuXcwwvtxD0HBGiSYTj
 pQ3kvN2CsraGBRyJIT40urk/4bCurgepWlOIxvbjTWsGmzgHgotY8ICY3micLK2acBwZktJoOoy
 IG9U6s7IyPJKz5Tir+nBmUUMtdJMntd7cvMd0bO00EIQ5ZqSzu3Njy9rtS9c6MIOv/5WYxHtd9t
 HtTFR+z9eMEyb40iN1KWCFL8KmeAHjJ1V1hJgIuHnk/u7nqwFf6C95c/98uSGwlQ6jvaKj9+Y9Q
 PpaNG1Ce0wpLqBTeZBnucvO8Ph+ce0WK6ImuCt3d18z5Mm5Zajk2pViTrl+l6OZnDzgpNdnW
X-Proofpoint-GUID: bgZcvZi0vonzO1P5AjdHkMXTK-4mkVi5

On Mon, Aug 11, 2025 at 01:26:27PM +0200, David Hildenbrand wrote:
> Let's factor it out, and convert all checks for unsupported levels to
> BUILD_BUG(). The code is written in a way such that force-inlining will
> optimize out the levels.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Nice cleanup! This LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/pgtable.h |  8 ++++++
>  include/linux/rmap.h    | 60 +++++++++++++++++++----------------------
>  mm/rmap.c               | 56 +++++++++++++++++++++-----------------
>  3 files changed, 66 insertions(+), 58 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 4c035637eeb77..bff5c4241bf2e 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1958,6 +1958,14 @@ static inline bool arch_has_pfn_modify_check(void)
>  /* Page-Table Modification Mask */
>  typedef unsigned int pgtbl_mod_mask;
>
> +enum pgtable_level {
> +	PGTABLE_LEVEL_PTE = 0,
> +	PGTABLE_LEVEL_PMD,
> +	PGTABLE_LEVEL_PUD,
> +	PGTABLE_LEVEL_P4D,
> +	PGTABLE_LEVEL_PGD,
> +};
> +
>  #endif /* !__ASSEMBLY__ */
>
>  #if !defined(MAX_POSSIBLE_PHYSMEM_BITS) && !defined(CONFIG_64BIT)
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 6cd020eea37a2..9d40d127bdb78 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -394,18 +394,8 @@ typedef int __bitwise rmap_t;
>  /* The anonymous (sub)page is exclusive to a single process. */
>  #define RMAP_EXCLUSIVE		((__force rmap_t)BIT(0))
>
> -/*
> - * Internally, we're using an enum to specify the granularity. We make the
> - * compiler emit specialized code for each granularity.
> - */
> -enum rmap_level {
> -	RMAP_LEVEL_PTE = 0,
> -	RMAP_LEVEL_PMD,
> -	RMAP_LEVEL_PUD,
> -};
> -
>  static inline void __folio_rmap_sanity_checks(const struct folio *folio,
> -		const struct page *page, int nr_pages, enum rmap_level level)
> +		const struct page *page, int nr_pages, enum pgtable_level level)
>  {
>  	/* hugetlb folios are handled separately. */
>  	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
> @@ -427,18 +417,18 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
>  	VM_WARN_ON_FOLIO(page_folio(page + nr_pages - 1) != folio, folio);
>
>  	switch (level) {
> -	case RMAP_LEVEL_PTE:
> +	case PGTABLE_LEVEL_PTE:
>  		break;
> -	case RMAP_LEVEL_PMD:
> +	case PGTABLE_LEVEL_PMD:
>  		/*
>  		 * We don't support folios larger than a single PMD yet. So
> -		 * when RMAP_LEVEL_PMD is set, we assume that we are creating
> +		 * when PGTABLE_LEVEL_PMD is set, we assume that we are creating
>  		 * a single "entire" mapping of the folio.
>  		 */
>  		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
>  		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
>  		break;
> -	case RMAP_LEVEL_PUD:
> +	case PGTABLE_LEVEL_PUD:
>  		/*
>  		 * Assume that we are creating a single "entire" mapping of the
>  		 * folio.
> @@ -447,7 +437,7 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
>  		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
>  		break;
>  	default:
> -		VM_WARN_ON_ONCE(true);
> +		BUILD_BUG();
>  	}
>
>  	/*
> @@ -567,14 +557,14 @@ static inline void hugetlb_remove_rmap(struct folio *folio)
>
>  static __always_inline void __folio_dup_file_rmap(struct folio *folio,
>  		struct page *page, int nr_pages, struct vm_area_struct *dst_vma,
> -		enum rmap_level level)
> +		enum pgtable_level level)
>  {
>  	const int orig_nr_pages = nr_pages;
>
>  	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
>
>  	switch (level) {
> -	case RMAP_LEVEL_PTE:
> +	case PGTABLE_LEVEL_PTE:
>  		if (!folio_test_large(folio)) {
>  			atomic_inc(&folio->_mapcount);
>  			break;
> @@ -587,11 +577,13 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
>  		}
>  		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
>  		break;
> -	case RMAP_LEVEL_PMD:
> -	case RMAP_LEVEL_PUD:
> +	case PGTABLE_LEVEL_PMD:
> +	case PGTABLE_LEVEL_PUD:
>  		atomic_inc(&folio->_entire_mapcount);
>  		folio_inc_large_mapcount(folio, dst_vma);
>  		break;
> +	default:
> +		BUILD_BUG();
>  	}
>  }
>
> @@ -609,13 +601,13 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
>  static inline void folio_dup_file_rmap_ptes(struct folio *folio,
>  		struct page *page, int nr_pages, struct vm_area_struct *dst_vma)
>  {
> -	__folio_dup_file_rmap(folio, page, nr_pages, dst_vma, RMAP_LEVEL_PTE);
> +	__folio_dup_file_rmap(folio, page, nr_pages, dst_vma, PGTABLE_LEVEL_PTE);
>  }
>
>  static __always_inline void folio_dup_file_rmap_pte(struct folio *folio,
>  		struct page *page, struct vm_area_struct *dst_vma)
>  {
> -	__folio_dup_file_rmap(folio, page, 1, dst_vma, RMAP_LEVEL_PTE);
> +	__folio_dup_file_rmap(folio, page, 1, dst_vma, PGTABLE_LEVEL_PTE);
>  }
>
>  /**
> @@ -632,7 +624,7 @@ static inline void folio_dup_file_rmap_pmd(struct folio *folio,
>  		struct page *page, struct vm_area_struct *dst_vma)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, dst_vma, RMAP_LEVEL_PTE);
> +	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, dst_vma, PGTABLE_LEVEL_PTE);
>  #else
>  	WARN_ON_ONCE(true);
>  #endif
> @@ -640,7 +632,7 @@ static inline void folio_dup_file_rmap_pmd(struct folio *folio,
>
>  static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
>  		struct page *page, int nr_pages, struct vm_area_struct *dst_vma,
> -		struct vm_area_struct *src_vma, enum rmap_level level)
> +		struct vm_area_struct *src_vma, enum pgtable_level level)
>  {
>  	const int orig_nr_pages = nr_pages;
>  	bool maybe_pinned;
> @@ -665,7 +657,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
>  	 * copying if the folio maybe pinned.
>  	 */
>  	switch (level) {
> -	case RMAP_LEVEL_PTE:
> +	case PGTABLE_LEVEL_PTE:
>  		if (unlikely(maybe_pinned)) {
>  			for (i = 0; i < nr_pages; i++)
>  				if (PageAnonExclusive(page + i))
> @@ -687,8 +679,8 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
>  		} while (page++, --nr_pages > 0);
>  		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
>  		break;
> -	case RMAP_LEVEL_PMD:
> -	case RMAP_LEVEL_PUD:
> +	case PGTABLE_LEVEL_PMD:
> +	case PGTABLE_LEVEL_PUD:
>  		if (PageAnonExclusive(page)) {
>  			if (unlikely(maybe_pinned))
>  				return -EBUSY;
> @@ -697,6 +689,8 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
>  		atomic_inc(&folio->_entire_mapcount);
>  		folio_inc_large_mapcount(folio, dst_vma);
>  		break;
> +	default:
> +		BUILD_BUG();
>  	}
>  	return 0;
>  }
> @@ -730,7 +724,7 @@ static inline int folio_try_dup_anon_rmap_ptes(struct folio *folio,
>  		struct vm_area_struct *src_vma)
>  {
>  	return __folio_try_dup_anon_rmap(folio, page, nr_pages, dst_vma,
> -					 src_vma, RMAP_LEVEL_PTE);
> +					 src_vma, PGTABLE_LEVEL_PTE);
>  }
>
>  static __always_inline int folio_try_dup_anon_rmap_pte(struct folio *folio,
> @@ -738,7 +732,7 @@ static __always_inline int folio_try_dup_anon_rmap_pte(struct folio *folio,
>  		struct vm_area_struct *src_vma)
>  {
>  	return __folio_try_dup_anon_rmap(folio, page, 1, dst_vma, src_vma,
> -					 RMAP_LEVEL_PTE);
> +					 PGTABLE_LEVEL_PTE);
>  }
>
>  /**
> @@ -770,7 +764,7 @@ static inline int folio_try_dup_anon_rmap_pmd(struct folio *folio,
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	return __folio_try_dup_anon_rmap(folio, page, HPAGE_PMD_NR, dst_vma,
> -					 src_vma, RMAP_LEVEL_PMD);
> +					 src_vma, PGTABLE_LEVEL_PMD);
>  #else
>  	WARN_ON_ONCE(true);
>  	return -EBUSY;
> @@ -778,7 +772,7 @@ static inline int folio_try_dup_anon_rmap_pmd(struct folio *folio,
>  }
>
>  static __always_inline int __folio_try_share_anon_rmap(struct folio *folio,
> -		struct page *page, int nr_pages, enum rmap_level level)
> +		struct page *page, int nr_pages, enum pgtable_level level)
>  {
>  	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>  	VM_WARN_ON_FOLIO(!PageAnonExclusive(page), folio);
> @@ -873,7 +867,7 @@ static __always_inline int __folio_try_share_anon_rmap(struct folio *folio,
>  static inline int folio_try_share_anon_rmap_pte(struct folio *folio,
>  		struct page *page)
>  {
> -	return __folio_try_share_anon_rmap(folio, page, 1, RMAP_LEVEL_PTE);
> +	return __folio_try_share_anon_rmap(folio, page, 1, PGTABLE_LEVEL_PTE);
>  }
>
>  /**
> @@ -904,7 +898,7 @@ static inline int folio_try_share_anon_rmap_pmd(struct folio *folio,
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	return __folio_try_share_anon_rmap(folio, page, HPAGE_PMD_NR,
> -					   RMAP_LEVEL_PMD);
> +					   PGTABLE_LEVEL_PMD);
>  #else
>  	WARN_ON_ONCE(true);
>  	return -EBUSY;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 84a8d8b02ef77..0e9c4041f8687 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1265,7 +1265,7 @@ static void __folio_mod_stat(struct folio *folio, int nr, int nr_pmdmapped)
>
>  static __always_inline void __folio_add_rmap(struct folio *folio,
>  		struct page *page, int nr_pages, struct vm_area_struct *vma,
> -		enum rmap_level level)
> +		enum pgtable_level level)
>  {
>  	atomic_t *mapped = &folio->_nr_pages_mapped;
>  	const int orig_nr_pages = nr_pages;
> @@ -1274,7 +1274,7 @@ static __always_inline void __folio_add_rmap(struct folio *folio,
>  	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
>
>  	switch (level) {
> -	case RMAP_LEVEL_PTE:
> +	case PGTABLE_LEVEL_PTE:
>  		if (!folio_test_large(folio)) {
>  			nr = atomic_inc_and_test(&folio->_mapcount);
>  			break;
> @@ -1300,11 +1300,11 @@ static __always_inline void __folio_add_rmap(struct folio *folio,
>
>  		folio_add_large_mapcount(folio, orig_nr_pages, vma);
>  		break;
> -	case RMAP_LEVEL_PMD:
> -	case RMAP_LEVEL_PUD:
> +	case PGTABLE_LEVEL_PMD:
> +	case PGTABLE_LEVEL_PUD:
>  		first = atomic_inc_and_test(&folio->_entire_mapcount);
>  		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
> -			if (level == RMAP_LEVEL_PMD && first)
> +			if (level == PGTABLE_LEVEL_PMD && first)
>  				nr_pmdmapped = folio_large_nr_pages(folio);
>  			nr = folio_inc_return_large_mapcount(folio, vma);
>  			if (nr == 1)
> @@ -1323,7 +1323,7 @@ static __always_inline void __folio_add_rmap(struct folio *folio,
>  				 * We only track PMD mappings of PMD-sized
>  				 * folios separately.
>  				 */
> -				if (level == RMAP_LEVEL_PMD)
> +				if (level == PGTABLE_LEVEL_PMD)
>  					nr_pmdmapped = nr_pages;
>  				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
>  				/* Raced ahead of a remove and another add? */
> @@ -1336,6 +1336,8 @@ static __always_inline void __folio_add_rmap(struct folio *folio,
>  		}
>  		folio_inc_large_mapcount(folio, vma);
>  		break;
> +	default:
> +		BUILD_BUG();
>  	}
>  	__folio_mod_stat(folio, nr, nr_pmdmapped);
>  }
> @@ -1427,7 +1429,7 @@ static void __page_check_anon_rmap(const struct folio *folio,
>
>  static __always_inline void __folio_add_anon_rmap(struct folio *folio,
>  		struct page *page, int nr_pages, struct vm_area_struct *vma,
> -		unsigned long address, rmap_t flags, enum rmap_level level)
> +		unsigned long address, rmap_t flags, enum pgtable_level level)
>  {
>  	int i;
>
> @@ -1440,20 +1442,22 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
>
>  	if (flags & RMAP_EXCLUSIVE) {
>  		switch (level) {
> -		case RMAP_LEVEL_PTE:
> +		case PGTABLE_LEVEL_PTE:
>  			for (i = 0; i < nr_pages; i++)
>  				SetPageAnonExclusive(page + i);
>  			break;
> -		case RMAP_LEVEL_PMD:
> +		case PGTABLE_LEVEL_PMD:
>  			SetPageAnonExclusive(page);
>  			break;
> -		case RMAP_LEVEL_PUD:
> +		case PGTABLE_LEVEL_PUD:
>  			/*
>  			 * Keep the compiler happy, we don't support anonymous
>  			 * PUD mappings.
>  			 */
>  			WARN_ON_ONCE(1);
>  			break;
> +		default:
> +			BUILD_BUG();
>  		}
>  	}
>
> @@ -1507,7 +1511,7 @@ void folio_add_anon_rmap_ptes(struct folio *folio, struct page *page,
>  		rmap_t flags)
>  {
>  	__folio_add_anon_rmap(folio, page, nr_pages, vma, address, flags,
> -			      RMAP_LEVEL_PTE);
> +			      PGTABLE_LEVEL_PTE);
>  }
>
>  /**
> @@ -1528,7 +1532,7 @@ void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	__folio_add_anon_rmap(folio, page, HPAGE_PMD_NR, vma, address, flags,
> -			      RMAP_LEVEL_PMD);
> +			      PGTABLE_LEVEL_PMD);
>  #else
>  	WARN_ON_ONCE(true);
>  #endif
> @@ -1609,7 +1613,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>
>  static __always_inline void __folio_add_file_rmap(struct folio *folio,
>  		struct page *page, int nr_pages, struct vm_area_struct *vma,
> -		enum rmap_level level)
> +		enum pgtable_level level)
>  {
>  	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
>
> @@ -1634,7 +1638,7 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
>  void folio_add_file_rmap_ptes(struct folio *folio, struct page *page,
>  		int nr_pages, struct vm_area_struct *vma)
>  {
> -	__folio_add_file_rmap(folio, page, nr_pages, vma, RMAP_LEVEL_PTE);
> +	__folio_add_file_rmap(folio, page, nr_pages, vma, PGTABLE_LEVEL_PTE);
>  }
>
>  /**
> @@ -1651,7 +1655,7 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
>  		struct vm_area_struct *vma)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	__folio_add_file_rmap(folio, page, HPAGE_PMD_NR, vma, RMAP_LEVEL_PMD);
> +	__folio_add_file_rmap(folio, page, HPAGE_PMD_NR, vma, PGTABLE_LEVEL_PMD);
>  #else
>  	WARN_ON_ONCE(true);
>  #endif
> @@ -1672,7 +1676,7 @@ void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
>  {
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
>  	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
> -	__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
> +	__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, PGTABLE_LEVEL_PUD);
>  #else
>  	WARN_ON_ONCE(true);
>  #endif
> @@ -1680,7 +1684,7 @@ void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
>
>  static __always_inline void __folio_remove_rmap(struct folio *folio,
>  		struct page *page, int nr_pages, struct vm_area_struct *vma,
> -		enum rmap_level level)
> +		enum pgtable_level level)
>  {
>  	atomic_t *mapped = &folio->_nr_pages_mapped;
>  	int last = 0, nr = 0, nr_pmdmapped = 0;
> @@ -1689,7 +1693,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>  	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
>
>  	switch (level) {
> -	case RMAP_LEVEL_PTE:
> +	case PGTABLE_LEVEL_PTE:
>  		if (!folio_test_large(folio)) {
>  			nr = atomic_add_negative(-1, &folio->_mapcount);
>  			break;
> @@ -1719,11 +1723,11 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>
>  		partially_mapped = nr && atomic_read(mapped);
>  		break;
> -	case RMAP_LEVEL_PMD:
> -	case RMAP_LEVEL_PUD:
> +	case PGTABLE_LEVEL_PMD:
> +	case PGTABLE_LEVEL_PUD:
>  		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
>  			last = atomic_add_negative(-1, &folio->_entire_mapcount);
> -			if (level == RMAP_LEVEL_PMD && last)
> +			if (level == PGTABLE_LEVEL_PMD && last)
>  				nr_pmdmapped = folio_large_nr_pages(folio);
>  			nr = folio_dec_return_large_mapcount(folio, vma);
>  			if (!nr) {
> @@ -1743,7 +1747,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>  			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
>  			if (likely(nr < ENTIRELY_MAPPED)) {
>  				nr_pages = folio_large_nr_pages(folio);
> -				if (level == RMAP_LEVEL_PMD)
> +				if (level == PGTABLE_LEVEL_PMD)
>  					nr_pmdmapped = nr_pages;
>  				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
>  				/* Raced ahead of another remove and an add? */
> @@ -1757,6 +1761,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>
>  		partially_mapped = nr && nr < nr_pmdmapped;
>  		break;
> +	default:
> +		BUILD_BUG();
>  	}
>
>  	/*
> @@ -1796,7 +1802,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>  void folio_remove_rmap_ptes(struct folio *folio, struct page *page,
>  		int nr_pages, struct vm_area_struct *vma)
>  {
> -	__folio_remove_rmap(folio, page, nr_pages, vma, RMAP_LEVEL_PTE);
> +	__folio_remove_rmap(folio, page, nr_pages, vma, PGTABLE_LEVEL_PTE);
>  }
>
>  /**
> @@ -1813,7 +1819,7 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
>  		struct vm_area_struct *vma)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	__folio_remove_rmap(folio, page, HPAGE_PMD_NR, vma, RMAP_LEVEL_PMD);
> +	__folio_remove_rmap(folio, page, HPAGE_PMD_NR, vma, PGTABLE_LEVEL_PMD);
>  #else
>  	WARN_ON_ONCE(true);
>  #endif
> @@ -1834,7 +1840,7 @@ void folio_remove_rmap_pud(struct folio *folio, struct page *page,
>  {
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
>  	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
> -	__folio_remove_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
> +	__folio_remove_rmap(folio, page, HPAGE_PUD_NR, vma, PGTABLE_LEVEL_PUD);
>  #else
>  	WARN_ON_ONCE(true);
>  #endif
> --
> 2.50.1
>

