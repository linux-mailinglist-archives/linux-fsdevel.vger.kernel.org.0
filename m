Return-Path: <linux-fsdevel+bounces-67208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D586C3811D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 22:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DB83B5061
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 21:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB84B2D9EC7;
	Wed,  5 Nov 2025 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ioc6Jcgd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R7hiAxR7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFC2C0276;
	Wed,  5 Nov 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377957; cv=fail; b=LQr05e4Uw5VYA3m5kX5VO68QRahCr4OjNdFI+pk+0p7rHBQaza8PvPT3mKCJL45CdjJLgiqGX4G4mRQ4D+3yNXqW8k5iSkhoyzkCC8pJF57zew6DIuywp74OO6yqgY30mzvW4YEcVlzGBdqouwywMDGEkMU1J3qkPNys9rfsv4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377957; c=relaxed/simple;
	bh=rJqlQU4ip6N3g33HV/ALkfpr+jI8Z0axueQvoCUWfCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pGL+EfS/YPo5m3gJuN6J5b8sRrMCQICgSk2jyFGQDptxOMXTEY0FL2jyfPv7M7LW+/wRkw0VIi6RUmj0HBbPQB0rUrcHpykTFKgPBbwVDZZdiuetDo2je6/5E+qEFYfVjuJxFVJeqi9YyaGGPgJaLExz/4TGgpmdSJP0n0A1Aeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ioc6Jcgd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R7hiAxR7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5H9KGQ017629;
	Wed, 5 Nov 2025 21:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=rJqlQU4ip6N3g33HV/
	ALkfpr+jI8Z0axueQvoCUWfCM=; b=ioc6Jcgd6hDXstO+UTaCQesp6pPuUt4Z10
	+gUXf3NRT8T2RZusx2q4KHnY8AfF/iKSeiAO1JDaCqUa9sawqzKRsl/3xyqZpTov
	erx9qgPB8Qst/ppzKX78RDwfMR+l5xXP8Uv1F4huO6EQAMm91swOVdf6qqenDDnY
	758jVZY6y1EUWvqeEhv2hBQbbSrfBMY2TZwEVfKyGjn2ee26YX5U/jucDIcK8pso
	9nXkJePl1Hc8UbLHDmbE/2l+y/AyYtnBIdsNox5CRQln4bETo9N+ZFvPs1czg4Se
	XwhDFnchPV3YGcg2D0/R22RJsLDSjoCGvzf6oMiheYhEBQxYGQcA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aqw8jm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 21:24:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5K368T015031;
	Wed, 5 Nov 2025 21:24:56 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbagn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 21:24:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxcX230kGAgS5bvnqYtODiXx2Ir0zVU6wErfAPerCpmIouQRJnPh6tSCJoRhjWfX82Krd3sEW/PWN+g39gtYChHYCikOZStOaXuGFV5We8mtUZK7JW7oUtkumuaYWnLpSND3nhjl+lvMCfuHBok2gtzLDoNqz161Ahh7DZdycwcvNyIHNfubxd6HIr2Od2JFuWGTM+xF3AnUXQKUDxwxVLVniYP7gr/24ke5UzNh4DaPB+KTrDnPvzlWkafizBIAdp1m53s/qFgHMPOBXnxQzSvwR4+h+srpDfypIbAvox3xNijLLzcIaioy6OH+syIqqpf6R02ZuYPnU6GBUieMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJqlQU4ip6N3g33HV/ALkfpr+jI8Z0axueQvoCUWfCM=;
 b=O5W4Ng6G3uiarefMQ5uIrIy6F86hT6CFGmuXkuq80E/uB16xaxvUqht8TC2Wc5n87n2OuGJwOfJBbUs9N+DPV8dT6P8WHOuk8z5CJmWw7QrWJZCGmJf1Iag9I52kvJuU8i8cW0B9Fk0EJAA6dV9C5JYSd7mrD36cm85TbpdvR8L4DFqHyKMjzD2n96vckjn7b/+Qo8LVUqM/cm1wrHsNp1QTFccuULUBbpAG5J7Fz5HBL1QMLzrHCEAkSdt1fAUN1/TyB0x07DqDNKrf0ZxI9GhNrIIj6IO2sjBKUSLxRdWhM1mJGOfR0gc3U5PPA96wa6G6/w5wCu3Uc87k2shNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJqlQU4ip6N3g33HV/ALkfpr+jI8Z0axueQvoCUWfCM=;
 b=R7hiAxR7DXilJ0sRmh+3d1YTbr8+tIALnmUWZpsQfwJrb9+unx/wdvx8c8yMFS3SjCvADeGPTrYKLWCTaS+S3MoAN2z92pKzEqAwVMy6Ydcq2hprmEV5eh/ARDnLqPi714qdqruhIuIlkc+xFrj81Wbfukmzcv0oH1tPTSsCorA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 21:24:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 21:24:52 +0000
Date: Wed, 5 Nov 2025 21:24:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Cc: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
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
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
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
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <52dd0c85-9e06-4cb2-a9f9-71662922cba9@lucifer.local>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
 <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
 <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
 <aQus_MNi2gFyY_pL@gourry-fedora-PF4VCD3F>
 <fb718e69-8827-4226-8ab4-38d80ee07043@lucifer.local>
 <7f507cb7-f6aa-4f52-b0b5-8f0f27905122@gmail.com>
 <2d1f420e-c391-487d-a3cc-536eb62f3518@lucifer.local>
 <563246df-cca4-4d21-bad0-7269ab5a419c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563246df-cca4-4d21-bad0-7269ab5a419c@gmail.com>
X-ClientProxiedBy: LO4P265CA0253.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ab337b-5114-4a6f-3dd1-08de1cb1c1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iZcQ+3SWKW19Jsvu/yfGdl1hcgJ/BmegoD3UcV+CY5ERETT0VxI3fWwFRa1w?=
 =?us-ascii?Q?PlkD5v+pabTn1yc6/BHW1Vbw4sMZlaG9F5uYlmq94/B3DnmUCgSJK6RM/mXx?=
 =?us-ascii?Q?tTIJTkbgmKgsSP8v+wa1lzDe8UajUdY5cPrUE/2mjamJqs6n97t9IJ+pQr4o?=
 =?us-ascii?Q?IKI2dBWx3t8ETCuZ20qQyeyVbWivqYwmfrYvsZDFv60sgq4ZoaCJ8ZmHtX9o?=
 =?us-ascii?Q?VK2znImnwM403ZLGlyddvUxbaWXbR7q7UM3gTGq5HstbJ5/7klRYaCG3u3NK?=
 =?us-ascii?Q?zs/Ncza9HlHiylQxIOSk7rsAa21jE3CCFPX3tnoJvHFCWW2qd9tmKbfkNtQD?=
 =?us-ascii?Q?A/jBCQ3shr2CNG2zPZdVba86iKb4cu6qnXhTCoLIx2G9WhWURxumzYhRCD6L?=
 =?us-ascii?Q?brN4F8bP+OxqvfTwljTBMki6Ftyls9xTrqktUUeXasAlOOoXQDAVTfbYNPGi?=
 =?us-ascii?Q?dd/ZoDqshEc0jpqIFx2UQNVFF/Hx9I6NQRfvDvonzr9q745I2QrY+thmXDyf?=
 =?us-ascii?Q?tRFTIXyo5EEtsK1yYUNlQOiuYCNfHXj3YvwAoUwQLM2uY/qDefRgsHhUQTuV?=
 =?us-ascii?Q?rMxSKefZG4JrJ64uOxVO0IeoRlQlwbh6X8MGUxpKWRuCN9uV0ExEKleTef8S?=
 =?us-ascii?Q?8jG7n7oC8sWimrDUF4+kBuPL8t9gVBWOd9SqP4XeB2aB4KxqF2aqgyS1BQAm?=
 =?us-ascii?Q?xFt5G2Dcg/gEy4XmtYjP+G353TYQvEk3od999uiH4/HIy24eTB/JdvQbnfUh?=
 =?us-ascii?Q?YH+yhRTqiR2RA4YelOdL6yv1zjghgVHT5zTh/zgTlfAlkhqW40RdGtEAnFL4?=
 =?us-ascii?Q?cVZ5jKyrPAbuuD30agvueGPdjWuDHa08FgqRh0JJ2KGimYatN5woPF6/RFhA?=
 =?us-ascii?Q?XhnPUaEiiB550aTEb/RgOQuDbKhMRHIEGpdWnpQaHRBqr2SuVCcPb2Qqp5EH?=
 =?us-ascii?Q?W/RDLTqZ5UVDfnFFxFR86FOneLhLw5xfsNTXqdoQuRCL/a4S3OZnqfgXxwIe?=
 =?us-ascii?Q?ARG40LC+/qIZI0LxDq2Wc5nnUrBNQapY5dNPMxP3WPmgLD3UoO6iGhAssJEn?=
 =?us-ascii?Q?P0O4ibtq6zjXpM9mjqzEPSl71S08A/WcAuyJUh7x+eX94paeb15FAJ6e+UbA?=
 =?us-ascii?Q?OixLkUJs5DIMcOn0oWVwb7OM6CakQm6e6lRD8ePm44UX4bOaQ8JhGbaz2EeF?=
 =?us-ascii?Q?NwiEAXYyRVRLaqplwISVQVRWOfG7boAyVnspjcke55DLWFwmOz3O47gg7Zsr?=
 =?us-ascii?Q?0VSG5jHttNhiql09BBaiBgu5mJj5TUYbmXRg72OJC/fYYgMEATVL5+sqfjJB?=
 =?us-ascii?Q?ILyPAJnRBYOZFGz/Hy0Dhi3fp34DaavfzJQ09L25wDa0S/nJFWS5981/CiP2?=
 =?us-ascii?Q?DS5cuUUCcd4qD3TuII4B2CGhW0SaY29W4TOmSKwItLLogMIOFTtoQrFAZXIN?=
 =?us-ascii?Q?rLvoMMmAhqx8NtGeFlpVHe/xVPoKyUIX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aur2IweSn6Wf53GrEty9TKSm9dTtTotU/XWUpN5sioG69JZ6p2DungELMiaL?=
 =?us-ascii?Q?GIW71Z4YtmLME9EuQzBuyrOGGUfvx3wK/R0V7TfrCozWcW8e4XylCJpJhm02?=
 =?us-ascii?Q?1QXfXS3sN1T6DdCcCNPNCZaKMl/rXPwMXokUvp2H+neTFA4ci+fKNEqZcOTk?=
 =?us-ascii?Q?N05CvsuQ3ho8jkbGiN39XPKy6Qii6KwZbPKS3uSVauxk3Jme5m/JiQy+olyx?=
 =?us-ascii?Q?i/d7iKiGtVrbi4/FwhbyOi9Ddo78XmEzWEGdRuwyCKELjQtagJVvBIu/vjTV?=
 =?us-ascii?Q?4Dod5mgMfZTS5BMTJu2Y6L8VtJ4sx+eXcO2HzIQclrGihWFbDgLbf3LWCQPt?=
 =?us-ascii?Q?38iu4T1ZyBq1iqBkveMrZPgBezxYMrC+Egb+5kW5lTJR7HaNabs26LKEDVCH?=
 =?us-ascii?Q?IBxWGn5DdqxALquUjS4T4Pa9ZYjEtX3HPCLCGEqrlobu/LHGN1ohUKP8yYfX?=
 =?us-ascii?Q?noEYYESSYbUJb/WjeBC0n6W16dlaZ6MnmfDMhUR7O8oOG4jffhG3NScFDccB?=
 =?us-ascii?Q?HeJRLqGbXcNsOVzClnnK4ovcZpOvpSnX1IdtiCxvV6fEmezHK4foUn2TwqHW?=
 =?us-ascii?Q?OYg0+w1FinJet1sXUL5FeTsUNdg5A8+ayuVxOCzdEnSwZEYYHK79Rfqia7nO?=
 =?us-ascii?Q?sxAhJZZ7C70jtPgKEQjSNRUec2iP9SlHEmoRYL3EHBPYkpLFSam2h+WUOFak?=
 =?us-ascii?Q?pAkHwAJZUF7sz5Kp7Z9eJG69bKmYFMNplPN28nljeT9LfrWu4+eKhp1wouaj?=
 =?us-ascii?Q?4V8bjntA5JFT0v6x9NUrCJ5qJXRvT7dixnGtO0NI7WncquM/er3MZnc+oXgt?=
 =?us-ascii?Q?zwEjMVfw4QACcPN1JjYTGjuBnN2eiG54+87dhclFSHSZDILT2NeU+Nn8bZkH?=
 =?us-ascii?Q?0+tbkY1UEphj+ftTbVNnq9Wb7hBKLq5Zejnw/ytQdQNW8JLJQewR+9cnxTno?=
 =?us-ascii?Q?QJUfycZNZdB01ZSh5TyyYthssJYOfuXG9YXuHhcUAzwda72C49a4XfDRQ/1a?=
 =?us-ascii?Q?1JDzee9DohXAHrqJhkuyq7IV5ZdTpDL4nqvDUwqoQK4J6SfktRf+sWgRwZHf?=
 =?us-ascii?Q?y1YYshEcP735rgDI/qoiUNUvg/Ym/tQGU2s0sRg/G2p7Bqd8ZMwdzqtvjCWl?=
 =?us-ascii?Q?pi22o+NtLJ8O0M0ZzeKg+/7Tbzg+qHnPIZ4XAHaVzj1Hs8+nmleKIsKAptQN?=
 =?us-ascii?Q?Gety8DHtbFq0Au8osOfumVtFOF+sxUHKYqY/PAYRGolq9LZsBnDftTZpXZrI?=
 =?us-ascii?Q?dBrwG//VfHN529zZj8MO4c4cYAIDiKoh4loKv7zqc0B7Iq9TfsR+nHwOWH5v?=
 =?us-ascii?Q?DLxc/8fZzwlD7C0ZQf1dMo6NC++kPoVbIvJo8lj7nYFn6h2nSjgmrg700bdO?=
 =?us-ascii?Q?jHulnEXMyRHhDAd5SoCWgELm/z04+2NO1nwbsnC4rb1RdNy614zvr90pszfW?=
 =?us-ascii?Q?hJJ9V4HoLF2iIf5jY47ObWcCrEeHg/VR6o2x1dF9aQdCaFHBYVBO90UsmULY?=
 =?us-ascii?Q?lj1U6YYIKgebs0l4CscKeEKvna7zdHC9qx95hEEVmaJP4yq42lzCiRT0HENp?=
 =?us-ascii?Q?K3E0XLLVIPWa3qkTQlb+W0CTIZnhNVFcecUqNDBNZdSsFvSnsDnQ3sHGeYrN?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wRpVkKU5NO2LuvX0jXuDU4469Nh5zszNiWPV5eXisby0oNAwxV0sfgBwEn8vFmD7OKTEdjszR3GSApJs8FsHUC/hVmbK9p1lnKDO+mQCnNhBGL6F9Gu+UnaKcIsriifN5D1G1MxUzdRpl1kVTE1aNrglacFVxR8WeT1iAbFYXyDD/Flv/5/kYQcWwC9sOhH/eIX2rUAGlSSH269HNoFjHNxx7o1b4Kf2NyFduCFXKYrP6KRIo3Rw1f+NKeLjjbXpF/YryHjuBhSTusnRzFIMR+4+5ER8s+5JyO7NFDeApqnu1ziIbf4OOPr674SBp0r03S6YR5tRH8SBCb2WG+8YWDIElebExOBLtTjnyekI4j+jaSGwZGa5oQQ4coddn+JTyaYi1GxkW87ZaSPVTtmhVqm8A0CN289uRhsSxeeCa74ggQ7YTYhZDppPOqOub7dnDby+NkiGodFtaAD98160FwO0S6vtRLxtxwpTAiV7/1qO6TLhITwRGMSJujYSq0p/eYre5bRs90g9ud/Fz/t3b1BKP5PzRpS5oIZrm3PqtlEAPZNlCLBCIFyS9GoswFSKNNYMloudBvfJXhxpvtjg6FSNyM78TNnxgpKMpsVerMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ab337b-5114-4a6f-3dd1-08de1cb1c1d1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 21:24:52.0393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dg6CpCsEEp2ijWUofsQ77h2sEaNiMVwMaTlNHFTjcWhcMsf4sbsmC3nuhmUwmfuFuO8vegtGAftbZqKRT6a31MBdcGXQ1e+urO35UZK2LnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_08,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=662 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050168
X-Authority-Analysis: v=2.4 cv=NajrFmD4 c=1 sm=1 tr=0 ts=690bc0a9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=TsAl5O-2LqVuh9mVfYsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: fwABJklmdWaI7L_vBdFGh30ox8KU_mnX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX80ytXy4do+jD
 fTdHif+fT1HhUMPx3qtSd6Ha8vYaP1F/TXL5CC/vHPZ1VtOg3j+w515RMFUhEoiye3tTbov/OZm
 OdbNAXpCSoTvkkUMjsMkQjJma7qbDUiUvNmLBEjEC6XkU8yf9+4xDYJoUrOF1vYk32QR4fAhdUs
 /IlatjAEnCDBkMdTiVcmsGj1g6YoSUJPkvoD0r+mmnZZbR4iZvBihuStKbv9Vlp39Dcwt+bCmCC
 hnoBK0mTXtcvSevSGy3XnFIXOruv4JeNj43WFoBIC78NXO+2QeEOF8wFD7I0GQ3lzXf/ZzW56vg
 rrmVKpWMedD8ecxJ130k0b4OlvbPihu+PwQmS12TI3I6DPuc6LH6EnzYxSIyQUf1baSpqT8hNfl
 mExHbJ6cFEtX1Dp6OE6f+NLDlCfU4A==
X-Proofpoint-GUID: fwABJklmdWaI7L_vBdFGh30ox8KU_mnX

On Wed, Nov 05, 2025 at 10:15:51PM +0100, David Hildenbrand (Red Hat) wrote:
> On 05.11.25 22:08, Lorenzo Stoakes wrote:
> > On Wed, Nov 05, 2025 at 09:11:45PM +0100, David Hildenbrand (Red Hat) wrote:
> > > On 05.11.25 21:05, Lorenzo Stoakes wrote:
> > > > On Wed, Nov 05, 2025 at 03:01:00PM -0500, Gregory Price wrote:
> > > > > On Wed, Nov 05, 2025 at 07:52:36PM +0000, Lorenzo Stoakes wrote:
> > > > > > On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
> > > > > > > On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
> > > > > > I thought about doing this but it doesn't really work as the type is
> > > > > > _abstracted_ from the architecture-specific value, _and_ we use what is
> > > > > > currently the swp_type field to identify what this is.
> > > > > >
> > > > > > So we would lose the architecture-specific information that any 'hardware leaf'
> > > > > > entry would require and not be able to reliably identify it without losing bits.
> > > > > >
> > > > > > Trying to preserve the value _and_ correctly identify it as a present entry
> > > > > > would be difficult.
> > > > > >
> > > > > > And I _really_ didn't want to go on a deep dive through all the architectures to
> > > > > > see if we could encode it differently to allow for this.
> > > > > >
> > > > > > Rather I think it's better to differentiate between s/w + h/w leaf entries.
> > > > > >
> > > > >
> > > > > Reasonable - names are hard, but just about anything will be better than swp_entry.
> > > > >
> > > > > SWE / sw_entry seems perfectly reasonable.
> > > >
> > > > I'm not a lover of 'sw' in there it's just... eye-stabby. Is that a word?
> > > >
> > > > I am quite fond of my suggested soft_leaf_t, softleaf_xxx()
> > >
> > > We do have soft_dirty.
> > >
> > > It will get interesting with pte_swp_soft_dirty() :)
> >
> > Hmm but that's literally a swap entry, and is used against an actual PTE entry
> > not an abstracted s/w leaf entry so I doubt that'd require renaming on any
> > level.
>
> It's used on migration entries as well. Just like pte_swp_uffd_wp().
>
> So, it's ... tricky :)
>
> But maybe I am missing your point (my brain is exhausted from uffd code)

We'd either not rename it or rename it to something like pte_is_uffd_wp(). So
it's not even so relevant.

We'd probably call that something like pte_is_soft_dirty() in the soft dirty
case. The 'swp' part of that is pretty redundant.

If people were insistent on having softleaf in there we could call it
pte_softleaf_is_soft_dirty() which isn't qutie so bad. But I'd not want to put
softleaf in there anyway.

sw_entry or sw_leaf or sw_leaf_entry would all have the same weirdness.

I want it to be something that is readable + not hideous to look at but still
clear as to what it's referring too. Softleaf covers all of that off... :)

