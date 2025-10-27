Return-Path: <linux-fsdevel+bounces-65736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C29C0F44F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23DE8347A9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886C313269;
	Mon, 27 Oct 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LjhhKiuM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QXDPTIi5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A81E4AE;
	Mon, 27 Oct 2025 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582488; cv=fail; b=EGjDJ/PV44mOOSj1lNl+n5rU1NTWUrs2TJbIFP2GE0XctH5g9dXwk2t3ABuTOCVp2h5bkPbtwW6K3PUJNokFDatzIIHK+ueednAfFYJGnznw5XWmtc02AtwY2L8pBkbRYDcNo0KA3+VOO1DNYsXwLvZ0nFiWMS61WARJ1PIAWuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582488; c=relaxed/simple;
	bh=8be8++egxeOytR5yW+2QqjhBjlBZvqwx+q47MgCbjrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kcLGuOqFcwUQOK4qUcPmWzy+p+Zu/Ul/g70l1dHDKRN1Ew5zWTwRAF8a5mvbzOHklXk77SvS0+vb+fry+9hbkrnNq4oQb/gf9J5E+8GuF5CwXGcuWgWjViCV+S64hGJ0hPgUaOKe3XFKa3rY0nomwqY3z2eqCOi/bFkWNnA40Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LjhhKiuM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QXDPTIi5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDY8E3019610;
	Mon, 27 Oct 2025 16:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tsbL5mkn4Qb9VMSpU5
	bRzP+0TJvqAV+0sg9maeMM4LI=; b=LjhhKiuMHjRFjZwoGBwnj6Zt0HOaYV8hg2
	q1a48i6/vSZZpb4E5tp9m+AzKb2Q4LHQJhHyrnec6kKgm1gCmVGRpwKUPEidQr8E
	MUmMAauaiAiimsocVsla6KY5L3qxhFwHgIOKeQZrlLDpFnvJ+0IrLTb0nlN1L+xm
	MMF6BLBq53zyTfOLuoE8cSiezbX8+jnO6MhNcQkN/2KRVl3g9LG86BNN0DtTio7I
	5IgECXUbzlb0WDDwgmmDF9YLhIzJhaKLITElJYLSDhSjRWl3dGtw0/pdFypQYoZ7
	QiIqVdmrU8f+MH8RiHwSZ6tBUeapVWTZ4RyB3mUgF9KYMJDwAo5g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a23gvhb8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 16:27:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59REe10G034835;
	Mon, 27 Oct 2025 16:27:01 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a19pedd2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 16:27:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmxQNRzOmoKzF17K8knsosgkt2rUqybNbyD0SQSM4pSSvlCxRBEAb7Pw3F/3ypPHRJHlROi9GsAQ+0qh+Eszej2El/JtNuag5XaiEb5DlDZzbA/xyB7CcUwnHOQfwZX0/KuZcRQ3lJWLF6JLSHnseNeE1rJvqkBUhiH+d7Fk6Ww7sWoVgcUR7uMD04NaJCYCvr3K47agrOXRLv1F8Xihutu7jP9Q2mBr5tUt3b/h/61D1t/+WkvQk6hbn8gN/U8b7i908HFC/lhyWBkvOA00kkii4RsjncLAOVy+Uu6X7Y/HVZZeMI19C+EDQJovvlCUWX78+utqQyASA7D1YGrs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsbL5mkn4Qb9VMSpU5bRzP+0TJvqAV+0sg9maeMM4LI=;
 b=OOVSZVVXV02/znfvQ/p40KSCAARlddgQh9nEsK4VRh/5OxM3zMc02Uyz6t0n3iws7wyDIZuZMFPdwLTHOP4rOAmKV2c0BRUeFpLPRw6F3Az0wWq+nMi1+7iJuCbnvsq2dSv+2/ogd0ppbTbP7kEVb6owIPo8Ve+IAKvKOv9qdqSgFGSn5EuJPllMKYfJrDGF+EX990n3KV4CnbuIh8zkyFw+7CmvfqmkbkKuHhUVFtQJxacfbUHjA5P04o3jgETiin3v4Kuo/pqrm4b3e+/RrKnxJK9GKanpm8pr9JJgvoM1k3pHZxtBZBVLCv4CE1BFT8cKE38L36mghI3cWrPz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsbL5mkn4Qb9VMSpU5bRzP+0TJvqAV+0sg9maeMM4LI=;
 b=QXDPTIi5+18sfNvCqREahMfVKkdS+1vnnH/0FhewEY33OBTjhvKcl5lBqQhnEe/fXS6eZaXoyqIfI+s8AyEZsU+tRLcbRuPbgwojjWLqJurJc5p/wWuVlq1wI8eVuE0KoT05OBtKboxWuHxZI0Qn/8BT1fUssKsMj6rX7HFOr9Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB6373.namprd10.prod.outlook.com (2603:10b6:a03:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 16:26:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 16:26:56 +0000
Date: Mon, 27 Oct 2025 16:26:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Gregory Price <gourry@gourry.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Leon Romanovsky <leon@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 05/12] fs/proc/task_mmu: refactor pagemap_pmd_range()
Message-ID: <27a5ea4e-155c-40d1-87d7-e27e98b4871d@lucifer.local>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <2ce1da8c64bf2f831938d711b047b2eba0fa9f32.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
 <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
 <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>
 <aPvjfo1hVlb_WBcz@gourry-fedora-PF4VCD3F>
 <20251027161146.GG760669@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027161146.GG760669@ziepe.ca>
X-ClientProxiedBy: LO4P123CA0143.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a85911-a3d6-4c4b-3c8f-08de1575a51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZSE5I+iMpQL6enf7StU/h53UsrkROmUwht2kLtL588dMwW3msUike18PNDHJ?=
 =?us-ascii?Q?sgICs/qzkFSU6lt+Fz8CqejWNR/VXwec1IkdfdlgdduknIizCy9NmHFOWXrE?=
 =?us-ascii?Q?aBRV5HyPbEdd5P2qlCBkU1OBXmEqqy1pvuQHJu7P5oZHIiWZyYzaJ4238/kZ?=
 =?us-ascii?Q?tHsIAjq3iwOSvTLVN79yQaFjVjwfWw9nvQHgWMxaq0yZBew8YzezIGnRGtiu?=
 =?us-ascii?Q?FckF6gcY94SQQftprGkxo5vSB8HqXOrCptY6h8SC77WG1lv8eQHz4LJ6Bnyz?=
 =?us-ascii?Q?TMt7Q6fe5WHDaIm0c+R+3gpeFZpBEr64425idlt/fJi2ysxZkoZBcooD4hcm?=
 =?us-ascii?Q?J1NO4kCiKEknul2UPDQF8XM9O7gDLKytwJoxjadYrORdnFtH+1Leksyj/g4D?=
 =?us-ascii?Q?nANPNc20cOoxj9tVG+hPQDQqqKL8opl9ZFiknVw4zn6jslqJImCxD8p0juCN?=
 =?us-ascii?Q?/OUKPMMoy8O7ImQMYU6ECxE2DSZqtukGbQ2aC5IT3IkOn7f5kTrC/S7F3b8B?=
 =?us-ascii?Q?T1/oWtPweQLcwCrQkd39IBM3Xox3oLTp+Cvsmw1plNRz+/EwJfEXEWWibJMF?=
 =?us-ascii?Q?xgjR0BLWWOqO4WqV7Iare9J7XYGGtQe0MI3fSOVCJwPWf238tBRWVEfug0jp?=
 =?us-ascii?Q?pxrhFkeYTx2RCCI3xAlpjEJYLtUeYvxV06b2Zcj5G05MEhwXnmWoicwsUr3U?=
 =?us-ascii?Q?EZ+KQWSIyirXeO2ASDfspM0VreBOqbaB9UZIypSNVVilIHaDaLPzFZI7i4oa?=
 =?us-ascii?Q?+Yb088X9Uux/i35J7KEqUK82G3xA4B4XLUmzaY7AB3QGjoKOTaWSsIhKZMOp?=
 =?us-ascii?Q?T5rIvYxfCiav7TsUV0PUe3Rfiw4PknXpGU0vU8BdDVjRA9AmHPIQbQ5Il0X0?=
 =?us-ascii?Q?nCfQKriNQUnbrFddcGTefYTwGLtgxqdP9tup6PVOOqkRjG6OdR1j5a9rUJN0?=
 =?us-ascii?Q?pRfA3TYsxGlp6QqPh/XqqZEA8GKeYTXox9iwQpTkhOWI3g6m1VW3jhP7dYrg?=
 =?us-ascii?Q?uqHX40TwZtN3tJf+PRO8QpZ1RYGRWSNeYJ1xL8bftghuxbf0Ipyqkh4y7eOe?=
 =?us-ascii?Q?MLMU+SavyL9ftSg6y0+1MiK6twOR9qVEzjkLx4t1INcNrKXpaOdnmd+cVAtg?=
 =?us-ascii?Q?6fL7v5TCPfO9uXJPfKEBZTN8LOOXCZdF/wpnrPO50SwTxUQij6KGc8e3Egr+?=
 =?us-ascii?Q?7J3oVV7JGntOKRo8EdsuAKFgCajdCONWu54q6a2kkwDbKAf5YNUk9NWxfJWz?=
 =?us-ascii?Q?jzU6NbIeoEh0TA+4aM1eth4b9XJ70jWFCqF1mFIHnz8Zt0ARk9sdDFVJI7gX?=
 =?us-ascii?Q?63HMaQlDfePTQFH/B9noaFw79YgI4qNjno0SV1stnNG8kpjrwYR3P3L1fNM7?=
 =?us-ascii?Q?USurM8vkl7OtgY3Do+1/XvRVvG9YjA2qk+0lWIyYEA+GAZ+5OEZyUmzIM7PU?=
 =?us-ascii?Q?UTRrJ94uAQowEaBcc4J4nIptHY6fcuDO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7iWoP7JZKT8FdjRDY98luYHlMRu68Xgt7544j1dJJ6sLZ8O9vgCnThXIxErc?=
 =?us-ascii?Q?G4nIYsXB+6gmkX855tT0wcdOvJsZ+NbJ9r8vxwPY7L0k+iPejuwhsuu/cDJD?=
 =?us-ascii?Q?5/zQaQZOhANY5Wi4M7ZJUYshM5ZyDwKJPbY/FHqA7OaKSyt4+yyt3yxEMl0z?=
 =?us-ascii?Q?j415d+P798LUfiSgP/AEtPLCRjf7LDM75pHcoDTnggzJitTgV2fAVfVt9RJQ?=
 =?us-ascii?Q?mJtbX1zA30dyB3v7v3t8t+iVg5V38eNVt9ryGvtGky+wSm7H/+Yo8KqK/kWJ?=
 =?us-ascii?Q?/Z5UHx8RUSzgMqCxrQ6r6cX0SCzkKWqrLheGeKStnq1NcYWEdwhsCOWFFz0U?=
 =?us-ascii?Q?fomUTl2VDM0L3AnDoUnfLaKutGLdRTM8ZlYK2LiZN04SRWthEfHMn3rf3FbI?=
 =?us-ascii?Q?34mwwZSoC/0GGQiZzXvQjY2u3StogRUZTUQ5bU9kNpzF9utRd9r0koHhPquY?=
 =?us-ascii?Q?uJQGwx75083FiIAjtLsidAf+b6hYoxqGb7cKyQdd2S2Zl0c6QSZFjom6ABEp?=
 =?us-ascii?Q?TN87fvYiiRlZ1TssWpcqCJHTcPTWsLhuqjQ3pl5E8s8Y1XsD0neweK3ZmbMT?=
 =?us-ascii?Q?ofE9BSGRcpyVA4mkz2CAAKCZUnMCex83+tKiWOSDPX0PaQQUOZdBdWG33MfO?=
 =?us-ascii?Q?4jOLUeh3/PlS7zXOakJjJENTc0WJGWwD8dUapjnppHAGUJLFJnnH0O7GUKQW?=
 =?us-ascii?Q?gBXWyzVYcWDXcsOTBm+t+KjaWgVwLFCdCaNLL2M9agYdG88ZEA+CoNG6FmlB?=
 =?us-ascii?Q?Ty60dwvhITPxj/W55u1efz3ueNHoBFv/2jMoZExPp41SQvVU/hltDF09lG2y?=
 =?us-ascii?Q?Uc1Va0fGEXHRyoYw4zRcZLMu07bronII9lW2KT1rECcRXmNFPVI2gYAoh9ZF?=
 =?us-ascii?Q?a+HeBOIuE+JVTO2DvhLUHXps+6oYQ6uI8lz6xmwHaitAO0cTaPntISinGr31?=
 =?us-ascii?Q?mXTRX73bKF92nKHlVt0P61s4/c9vif7OQn7MoRuidhbIEcI4EtCFj3HUAj+4?=
 =?us-ascii?Q?Ltp35Mi07W83nnXjnMknFIxdterP4ou+YPfz4f8sf8wrZzFC0PrMeZ6+SZ8v?=
 =?us-ascii?Q?gfFSYLkCy7DUZItWKUusfVPOB0A+iavFu8kWp76w+2SleZ/r6koIZBYttbxp?=
 =?us-ascii?Q?HZ1ciljTTYqV27af26tszIaktuLiKFTbkHOnU/tHNuAwnrMLAx7vjvZF12mB?=
 =?us-ascii?Q?clXDrdpB6OEcbvSlhE+rsLUgcFi7+F+/AJxK7dAr8Y+pQ0jNkh+I+2srdhHa?=
 =?us-ascii?Q?upSmcELiHqDnVXucm1Gni6kAqD2UUXqDbb0fxQBEcJa64woEsjVvWTMHL0i0?=
 =?us-ascii?Q?nJyNamhx1riKBgJV18keOFXQrgbcNmUuR5VybeIfoJwprU0jv3y2RC1Ff8sx?=
 =?us-ascii?Q?ABEcTp1q0Z3JJUF7IC63ar/GbYdTj9uN32gPIxd1nEUyeM3xxv/YxGfGtBSp?=
 =?us-ascii?Q?GlHNkICMHYXU3079GsF20cos9fnYnLXauIx+UgAq5Vai4eaVCm4RlJNPS2qY?=
 =?us-ascii?Q?mXjeAYZ68FX85D8oYDiXyP74FQdX4L3Xl5aI3OhDLtYZN5C2tjfvA2J02vRs?=
 =?us-ascii?Q?jBte0Y2gCXQ+9g1P9uQA/Zd9Ypk+t2MdGGzKWwyBvTxCQPT3TR56qWySs7AZ?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PS73iFzloUi/XgsI1gxyCczhyxdyN7fhL3IXS0dN5Pkaaa4dgrhacOX+eE31RYHT5xKHy2NnFMl9slfOWmNqVtl3vohDyoTxDLfFMtezBoRdm2xfQc5bPAWI9nzVM3W/5PxJJ7y0v8ZgtB/b+JuMx0ZNhCXLEyCckc4ICsvWs2m8rulRw7s0cTJGP3kkQaID3l+gfMA22Tyj0aUZVJ/bJZQvUsRKpTmhVJhvVp3SdW3r5gT2SxKTguVUyV9164TYsYFlQZjReQCThRBrUp2Un/uTKHXpEBQ0TFA+oxLKYSLKZxCBn5ifdOP6u+hpxfgQ72OZwVQFgSPvBKh04Bvlvsi/CG1Q2Awk+yfGIPDGUTJmbOnsnYnObYG8HXWlx5SRhgIH/e7qBK+4jXpLfp1zFA4DwpOuIj07r+hEHO0H5Iattu9rF921CvZHqfvRAd5fWd9zcQuMy2Ic+5NoWcVvk39TvYxgeUH1gqDWn5nD0/pWASkBGzJTWiM1vkD47cd05D1WjyKYF2S5eN+CX/lmLceVitwy/pEnRRYdU+JsRdUtrWSptV+3eVeu7o2JIA6aCc4qf0Lx72WwXWMWZyzHQ7trdeoORmCGvov5XmF3wAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a85911-a3d6-4c4b-3c8f-08de1575a51e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 16:26:55.9476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EF5k4is4X5fI8jjDu9605Rx8k1JMXLElL6yRR3RbJd6R5nQZm8buyMrgRokTCZ8JofJsV1tXVbixvAGY2EXYCIjGpZTdFn+R7YenTPVqEg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270152
X-Proofpoint-GUID: y4KY9iUDiBVxw5ctYvy3x0o-sGDNFNCF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1OCBTYWx0ZWRfX/aBVF3OBnirL
 Rlotrc+NtG/odvUiZQR0m+0DBjGFGtsg90YqoPORFTXfkBx/aynHw2snceIyNHwS7W6lAcd0xUr
 T2YEBohMgd+v9ZL3NO7e960PdmGjbGBB95FwT8/+2xd7dvNYPL/WpBc2WUpHTw7lDyDiStX+xXK
 2NC9KUOPYP1SAdfhFTwGuGUoM7wCtXCLQXxX2pBu8S0Is7+FYsiQBpH/9YuicLRFErBwegKvLVv
 w0JG43YU+/eYN+fpnnuf6sNupmHrvBmKaj06lEyj0IXzkLkoqPdIfg/BSxcIU8QXGBP48aHrYel
 ajhzuYEOykTPgxXYa0VntwGGLo7JVBs6CEvhpgWLn/obtsBFGviB6Fu5B1+wZTY/RAfMOUg87Om
 jgsTQI/w+HPYjB0jYR4/AKZlRvDit2jy0xJqbYuau+I2ImRiQ2c=
X-Authority-Analysis: v=2.4 cv=HsN72kTS c=1 sm=1 tr=0 ts=68ff9d55 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Wn8KB9XMXtpZ0aPKzHgA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: y4KY9iUDiBVxw5ctYvy3x0o-sGDNFNCF

On Mon, Oct 27, 2025 at 01:11:46PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 24, 2025 at 04:37:18PM -0400, Gregory Price wrote:
> > On Fri, Oct 24, 2025 at 09:15:59PM +0100, Lorenzo Stoakes wrote:
> > > On Fri, Oct 24, 2025 at 03:12:08PM -0400, Gregory Price wrote:
> > >
> > > So maybe actually that isn't too bad of an idea...
> > >
> > > Could also be
> > >
> > > nonpresent_or_swap_t but that's kinda icky...
> >
> > clearly we need:
> >
> > union {
> > 	swp_entry_t swap;
> > 	nonpresent_entry_t np;
> > 	pony_entry_t pony;
> > 	plum_emtry_t beer;
> > } leaf_entry_t;

I think Greg meant this as a joke [correct me if wrong] :) that was my
impression anyway (see original end of email...)

> >
> > with
> >
> > leaf_type whats_that_pte(leaf_entry_t);
>
> I think if you are going to try to rename swp_entry_t that is a pretty

Will reply elsewhere, but yes that's the intent.

> good idea. Maybe swleaf_entry_t to pace emphasis that it is not used

I get the point but that's kinda a horrible name visually.

sw_leaf_entry_t too... yeah maybe we can just put the software bit in a comment
maybe :)


> by the HW page table walker would be a good compromise to the ugly
> 'non-present entry' term.

I like leaf_entry_t name-wise.

I don't love the union.

How would we determine what type it is, we'd have to have some
generic_leaf_entry_t type or something to contain the swap type field and then
cast and... is it worth it?

Intent of non-present was to refer to not-swap swapentry. It's already a
convention that exists, e.g. is_pmd_non_present_folio_entry().

>
> Jason
>

Cheers, Lorenzo

