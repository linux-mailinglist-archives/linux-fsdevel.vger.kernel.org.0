Return-Path: <linux-fsdevel+bounces-65418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946A6C04D96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0853ADC2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3F2FB994;
	Fri, 24 Oct 2025 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J8mbKl//";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aPFXuxvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472A2FB092;
	Fri, 24 Oct 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291855; cv=fail; b=Zi+ODBoZFyw1V2P6icVpIeRA60MqcopCA4/264GUnn75XCLsS3x3etr5kGa+lChKmuq2+yp2ccXjnCii3s/4Am5ClP5r/u0YQmo/e6LVBVMJaQZQLo5tNTcjb8REc/i2GiZJKnAqVGYUUvCY+dsO2poEVS83JqT0JmgaXKWma5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291855; c=relaxed/simple;
	bh=8lT1HGM1rw7PXOalGgPCF+L2lU8rcxc2IOvwp6WAJSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p6ZSmIMX+cQAJH5L8B+z1/riCc1FOi8alUQFfrMAVJRrdXmlfbbys+iTDo1LYmchS0+z7DO1+KfB2M7Mi1WcmgN3t/Ivs/FZeQ+OImenLBE5L7M/Df4rP0c4wjwaplM2rI5th6Fqb+2OtPHkR7cI/kphfSf/u9j4DWlRd3+54Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J8mbKl//; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aPFXuxvM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NaoQ013827;
	Fri, 24 Oct 2025 07:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AoYmJWsB+N/I5jfbsRQfX74Q7w7LUl+HZ/ElB9RDX/U=; b=
	J8mbKl//8RdoTiquuG1yKmg/lAJXpDVk8MMyWIMhwXZBnBe4agfV4Yz8ltwkmU5w
	eIUHeY3A8jNLhxZPhoSqrAqjnfubRAXQdeL7AhJvDbUvH1e1vBq0bHCi/2tzH2Qz
	TmjHOhc5Mt0ut2GZZs7XUX8u6hk3epDE0MQgplDwKpFy9UezYhRb8ivMuPnXTDj0
	4/ptI1oC7IyCAgKpBbGaYfwGkCLcvAZGt912XuzaIpsgB18oko23MNQ/THfQQ0Rb
	Cze4/+MqObfQ9wTInsNweGF5P5QLd6UKH2wiKz9+SpjcgXIkQWXvR4L5GU1uZadv
	Kitj9Tk9fOzLww4mBhZwqw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ykah1vee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O5USHI022309;
	Fri, 24 Oct 2025 07:42:11 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgmc63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/7a3L068k3ZxkmwCqKjBFqhFYW0aRpkDF+jFWJFvMuCRBCJi2/afL6irHsV/fhpDDpbubZdAMReqkFYo/CxgMju3BaDBZ13HQKGED22IrCYmhfeq0WDet/RgGtdqwgOmhjZvfjvrKmJPah3xeAryikBtmL5Do1H4lV3hZcUPJ3Se8XeBi2vr29hA6cH6pVyEgopWR4c/jQwfqdaG1fQzW9cT8kirKcNK1Jzhs/E4Z/pf9OBYcMYuJHPrmAZo+D2F3RT7cSoPtBfwtMKYARRFWZq4+SGYq9lUfnqIs2pa3MMn071FbQ7PPHG2Duk5B0Vul0HgrgAwcKb4bePzZKkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoYmJWsB+N/I5jfbsRQfX74Q7w7LUl+HZ/ElB9RDX/U=;
 b=W2athsI2/XrAqgoCAqjoL8b53kic7lregraNAo2l7sqq6d0Owh52aYPsTq5EYsWVmDGjK4ewf6+7q7CiP40dL3GinzbYzz5UrHPiX/WbcFXWCwlFvKfDlrGsNrD+PpVwIgs+KwAZkZIPm/MPWTFVhTI+eMqLE7S/ruS73B+GcGB2UIAvyWxFjxVSLtaSDMqrRVsDfTHXuJRll2Sbe+VquqzTbhOAmKiLG7dt3y11RUoTMMlvVhgNpcM61vct79pP3jJkd5NFHOS0XAmYC0hOCvMqUUZwonnTvFeSzIg6gxe6e+4fIScStmBLhOXtrmFqz4VLPEZmX8R4uoBqFEnd9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoYmJWsB+N/I5jfbsRQfX74Q7w7LUl+HZ/ElB9RDX/U=;
 b=aPFXuxvMOCb4xYRn9cjhTx3iQvwyF8Q7c2yffZhDdZKFIm0kL3zyRM0pXFVFy5q4QE+Q2B8uFd22B9vNu4cgONOlIhYtFs/Y80DCaSY7/iSZvjjCLG18asFyxCoiKnBACCAIzsE3D7o8O73brnxdPR8z11q9hvRc7TR1YftqqSs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:42:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:42:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
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
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 08/12] mm/huge_memory: refactor copy_huge_pmd() non-present logic
Date: Fri, 24 Oct 2025 08:41:24 +0100
Message-ID: <d578c86d96040f070a1be88441fccf262b92647e.1761288179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E52.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::2a) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d0506f-3809-4f2e-2a6e-08de12d0d4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DOQM8+w+MIBdxLT2Y6nHV3SZOM2KpmFCmGDwq0SnIsbfdLYnmlRcnz/y/h5m?=
 =?us-ascii?Q?5lrP4Z6BtYqecPJrAYkSWaasbAcxY3B3zTBD9SjJRRNtt2R69uFJV9VbHGwx?=
 =?us-ascii?Q?sWrAX5T1j1R9I95QXYS0cO9qpoz8PZl5V3wDb57AqMsC6oN78MyOQmXiQCbI?=
 =?us-ascii?Q?tWM3YaFMwEhpZhEX4hNg190eEzT0oJaIJfIYzn+OpIrqMxZ2Y304kF/oaUL3?=
 =?us-ascii?Q?ypN5UbCobdeRKWpdg332IOZkCKc9onnz8a85LEt9u950UfIcMScLaGe0YN0X?=
 =?us-ascii?Q?8BFfTPpEps4zlkSX1wcuj94xxQtBQmUy2+G/QdV2wFStNBc8OX8rvsAQTs9O?=
 =?us-ascii?Q?ku7EiPfcXZvRjatTkrab/Kzwnz9rRIVFB9f72QAcOB5rl8WpT80kxctGydV9?=
 =?us-ascii?Q?k9yUr3FTDgmF/pOI4IYeZb0xLmyIXI1XmUiaQ5IvDXHtfXKjluLRfIeMew9S?=
 =?us-ascii?Q?7GwqhukoyqYT8BF3zXA7V+A+VYDXswpXpvkWSMpgIG72JXYPQxmzB3EagtP0?=
 =?us-ascii?Q?khoxwKAzWoJOJRTJvQGABz+uqsx8svfRIbnhZmn/1g6phI3boDQa/k1d6ZIa?=
 =?us-ascii?Q?u57hUCs/FXphAla2ADI+vRswBb0FecxRSk5j72vtwD/OVU1sVrfCjwQpgj+7?=
 =?us-ascii?Q?pYmJBWE8iZ4mHMghF1LSYxssV15/YKdVFadiHkIJciurV4XV/CbT/OHBxjhr?=
 =?us-ascii?Q?DC8UHlqhwj1CyxyenwSzh/TEJXX9J+Ky4bHokIHdus+qqcaSD7Gn6c4oeWpM?=
 =?us-ascii?Q?BG6s57lZOK553aPp5AZiqixsZcGBAzzHdsH8geedke5qrL68VWjSGiKu/IIZ?=
 =?us-ascii?Q?5OS3FEd9kmjsOnJY0wV2dz6XgI7bfcqhidyOosZ49VJ74BONyu3ZzVij2C5W?=
 =?us-ascii?Q?RVFA5P2EyRUw6Tz27SHtMgYwrRf4PVhdgMTyDJLwWH8nzLVB2abVyQN7ycZg?=
 =?us-ascii?Q?GU0H4EgHce5cDoVrWdpU4TzbjAzxPVzMYT5X5lOu5wJZ4X7YPpFuSIZSmkSQ?=
 =?us-ascii?Q?BcMHfBFQn8ewusQ30Reg45zC7ZnpDDbcRgmc1LlRjICjRBXfnZR6DTR/tpr+?=
 =?us-ascii?Q?vYgm+fUTo45lN7dmffHTQuH5kidVzUqgaN4Gr3HJZfMVGwqggdRL6M0Tf09A?=
 =?us-ascii?Q?xUxuTjMh1SWUgFadfwNLKTMEr1J5I4VwoQVL5VREEp2c1gtq79wuesM8rdmd?=
 =?us-ascii?Q?mleONhDn0PwBMFDSQGxy9arODET4pv8X5/ckCRXq7UDWXouqw4HGk87J+s0P?=
 =?us-ascii?Q?Q54HDCCAKGxX5Hb1uEG2pL5Np7sxW4mIjP3emxpS7cjTjb0uAYVubq9fgqyT?=
 =?us-ascii?Q?cDMMzi1Kq/HqqePoUbHuXTOUhJF7eSB25KOrOczu42mkc4+JX7f9iyCkX3jr?=
 =?us-ascii?Q?MEQu+DSvaavRsMHvHD2gYjlfaVgUBlm69HsvcHwSslorIfrncxsKSan3zJP8?=
 =?us-ascii?Q?zsT06OuSG37cCeFKRO8xx7Ijz/VaRpaQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7DmDmWfIH2s5i/29Ij+WaknhIg8PsD/WVDoiqvTZaKX44HKLv8euWtV6vu2t?=
 =?us-ascii?Q?zDWWzdHJLIuGCqZjbjuEZO7N/h6oNONnNVdyDAmYsaf7/ATj5p65votz67dq?=
 =?us-ascii?Q?ZCyVyC/QyplofOuyrepYUy4ALyYEXLcYvDyQjRmljMx0001A2sxSHKDUZSRW?=
 =?us-ascii?Q?n5T/1HBuPisw89ScvE2ijSvI4cc3dSbaCLlB2SE30XIG1Lv1aPC3LhpSOl2a?=
 =?us-ascii?Q?d8gBc6uvHWSt3fEe1Tp3a/3VH97xlgY6gs14dt2dnJ+1NCW9F+jt4aEf/zmL?=
 =?us-ascii?Q?NumPvB+CABY/fchey+5pG9ty0ikYOH+Wr75o0ipiTGqQDL1OLiCKIDKxyJpN?=
 =?us-ascii?Q?ocx6Bwn5390bQzLk5hfCLlu2iWfR14mqnQgZorDSh/9ardT6+DexxtmnQnba?=
 =?us-ascii?Q?E/oww711MFz5Hx91wQLl4+GWajfX2MU40xaDG1/cwQFktEDi12dfm/G7AKwG?=
 =?us-ascii?Q?9+DepxfzfwMOaVCMX0Cu/unc2F1nBjJgh9XRGiwYR1kTsQZsgxenxB0jaXwZ?=
 =?us-ascii?Q?bKHSJ1gr1EuQAcIUjdbQP9skC7ppNcZNVsJNtiLkJACxUazu4RCOwIrk6pYP?=
 =?us-ascii?Q?U98xlUx+2urksA7yrRuabI4ObPgDzNMbEGd4HAAo8BFwyAC9gsOnEugGAoy3?=
 =?us-ascii?Q?zclvBAFhuNcFU7l6fopx3Ff+tPm6vDiWbJ/rjP95zeki+pQj9z6UDMjAxlx9?=
 =?us-ascii?Q?HTU9UI0K750S/L9UybYpba6czGs4tKMT+OP8p5a7sQsZE9Gnl4WlrRGpaJTK?=
 =?us-ascii?Q?2aqZBeHxpbn/VXQBGmAWOMYVVLsy7uhfKxouJPK9YX6eM2KpLmjH28yCcdqf?=
 =?us-ascii?Q?Gbs/Q59UOCtIQqQY30iQkKUcbpqYBvXUUEbsS6wazk2zaofih69UMQ6Fep6G?=
 =?us-ascii?Q?KfD6ZjGtNCveVTnvbu5VFcgwK6pbeAIapa8Rxcjisf2mQH3LhOEkzqdrmQJQ?=
 =?us-ascii?Q?M1nWVkG3QNp3PfdQxqjULelZekofem1/vJs9nies96e8IbX8C2nw24UNLEGs?=
 =?us-ascii?Q?gNxKGzkVNby/zXPTEEg3OSzHlGj4mdt11eqH2lOk52BYtpK/eiP4aPAkgBSv?=
 =?us-ascii?Q?i2SUCDJ/5QlMBqyRIeTmjhcf1YhkfiSDsdfQjw+6NjWZON5/TsSHij5XCmUI?=
 =?us-ascii?Q?mE5cHMxYdsJLSrIT5/ay+jfVMfHAzNQrBtKIxjuEiVqxRYrIliDsi1v9q5qE?=
 =?us-ascii?Q?zLtqj3hVFPI92pA2p650UAXpf+rwF6CQ5qA3BUQw6omZb7T//WLjCVpv+3tz?=
 =?us-ascii?Q?4SSOF/1zsafCdgXZ5pjI4x1ORQM+WppGIAi0qv7FFLCHDOhLXNA+5tqJ/7ID?=
 =?us-ascii?Q?bK6nTzSbimZUxYzJyALlEIRekbrtW/5lRdcSYC1shpmAFkqtVlKZ4LjMymJw?=
 =?us-ascii?Q?sftZJzQ652Symz7USZ6ax3FxOdlXs70EnIWBAYLgH9CbEEIcKfLbeahIusdm?=
 =?us-ascii?Q?/Wc0jyPwit0G2yi4aXB471MspLw7acm1txkUmNaNd/c99wDV8I/u4oFstt1I?=
 =?us-ascii?Q?3124LTI+qGhks3nbuhrCFvcVbjfzXJRv0o6z+HeIX3zFVlAEGXzwBGiu0fD7?=
 =?us-ascii?Q?fZrHU15+RCmxRmOKzoCs4rLth+NB5OTtXKD4sfwU3yOcCtNaajL2mfbiU0At?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AMmAZqfNwXcPu4WZYXNU11ezV6lK0xmf7PefqDnQXNYCbRwS8KQpGJgsz4k897N4gOSyBmgNhnuh3Dt8KGcxSvuuJOVfB7ygpVigrirVirqywrT/3vg7eP3rv1hbjwOm13nb9V8W96ZU/J/ohSQG++30yXOqwHKPWfhvTRg86W1Z87QOo2MEh/KltrC5xJ/iK9Hmy9EZVYyPjgSrr0dBGc7UbTa8zdnDuGtWbpxKucOnvsDLaozwiXiS/NtSkFNnm7CMqb2HRJNf3zV4nXDwH+gsuEpNyuHOeOb3540mULUFBapstZSarskxtmkzm1ai5iqRRhMXhwlv/VKQdb+LavwRMafqDKoFXcU5jnu/CAIYvVFYd88byF5hiwXQmRxLKM3lTMODHaaxhhVJw2w3+89EnDwY8vXNbPoeuoTmCUbR9RY+ySclDee5Bo6sSj3/8dRSd0iGplO5DHHLvoCCRVjoxm9n+rbt41SJhqRGiOWmv5mcPkbPnGPvWRNV1u0RuCFxyjQk81ZgUmUNw7N5BJFwOrCtYL94Myu5ZotAsoD4RbIFcrnnnX8tFJ9/CNBD9xTfMD3/TzMpTVIfZ79SzB74jpJTS70B2V2n/yvyf5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d0506f-3809-4f2e-2a6e-08de12d0d4ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:42:06.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPRRkgO2HfIPVZ5IRWhq6a9euQiAB+7VfcnMNVLY4wbW9QrX+xXHIiVUgjnCu0X6mbJJZFq7KFn/Oonxjn4s3uSvWcGE2mZgzkelrYn4Hns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240066
X-Proofpoint-ORIG-GUID: K9ShTx8KlTkAEplRQw8l-amsYUBq07Ag
X-Authority-Analysis: v=2.4 cv=XJc9iAhE c=1 sm=1 tr=0 ts=68fb2dd4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=9UmCEYkwnbpDqGD1g-YA:9 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEwMiBTYWx0ZWRfX0a8Piq0Ak/Zk
 I023GXMF/kUQrfptU1DkjOKMVEqOG9TAq2Fb2Hp2WOf013DWr2BDJJ5sOQirF2jt3vA7xRBCLXf
 wrvCJTgGrE1fzWAqGEI19a+nRgwVBlWRyqdwFohsDPqJpCJW0lWFurwwcVfjpcJIVtb9V3G1LZs
 l9Wf7U/pPDh6SStHgGBKvJeoDtKc2SYXaS9K5A3/6jd5r7neYeIuxFAf7a21vwYCtt8FWbyRe8d
 SGCThCKvaD1ALJKvyEv4wAM6IRE4fp+p9A9fB4N0z7bu6ztzFiNyUPMdPmMD01IbmF/wq8XKUbr
 HzWatRQM6XDuMsTLOi1+vjgSntruEyZriS3ugIzfQOtFYaT4kgJ5wBSIJZmQyOrqmOF1lWJ0WJ+
 qmFJH+X8ziDKxq9mjiyAr24R5lnEKphe7QQPl2P2MdHlcDDrckc=
X-Proofpoint-GUID: K9ShTx8KlTkAEplRQw8l-amsYUBq07Ag

Right now we are inconsistent in our use of thp_migration_supported():

static inline bool thp_migration_supported(void)
{
	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
}

And simply having arbitrary and ugly #ifdef
CONFIG_ARCH_ENABLE_THP_MIGRATION blocks in code.

This is exhibited in copy_huge_pmd(), which inserts a large #ifdef
CONFIG_ARCH_ENABLE_THP_MIGRATION block and an if-branch which is difficult
to follow

It's difficult to follow the logic of such a large function and the
non-present PMD logic is clearly separate as it sits in a giant if-branch.

Therefore this patch both separates out the logic and utilises
thp_migration_supported().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 109 +++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e0fe1c3e01c9..755d38f82aec 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1773,6 +1773,62 @@ void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pmd(vma, addr, pmd);
 }
 
+static void copy_huge_non_present_pmd(
+		struct mm_struct *dst_mm, struct mm_struct *src_mm,
+		pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
+		struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+		pmd_t pmd, pgtable_t pgtable)
+{
+	swp_entry_t entry = pmd_to_swp_entry(pmd);
+	struct folio *src_folio;
+
+	VM_WARN_ON(!is_pmd_non_present_folio_entry(pmd));
+
+	if (is_writable_migration_entry(entry) ||
+	    is_readable_exclusive_migration_entry(entry)) {
+		entry = make_readable_migration_entry(swp_offset(entry));
+		pmd = swp_entry_to_pmd(entry);
+		if (pmd_swp_soft_dirty(*src_pmd))
+			pmd = pmd_swp_mksoft_dirty(pmd);
+		if (pmd_swp_uffd_wp(*src_pmd))
+			pmd = pmd_swp_mkuffd_wp(pmd);
+		set_pmd_at(src_mm, addr, src_pmd, pmd);
+	} else if (is_device_private_entry(entry)) {
+		/*
+		 * For device private entries, since there are no
+		 * read exclusive entries, writable = !readable
+		 */
+		if (is_writable_device_private_entry(entry)) {
+			entry = make_readable_device_private_entry(swp_offset(entry));
+			pmd = swp_entry_to_pmd(entry);
+
+			if (pmd_swp_soft_dirty(*src_pmd))
+				pmd = pmd_swp_mksoft_dirty(pmd);
+			if (pmd_swp_uffd_wp(*src_pmd))
+				pmd = pmd_swp_mkuffd_wp(pmd);
+			set_pmd_at(src_mm, addr, src_pmd, pmd);
+		}
+
+		src_folio = pfn_swap_entry_folio(entry);
+		VM_WARN_ON(!folio_test_large(src_folio));
+
+		folio_get(src_folio);
+		/*
+		 * folio_try_dup_anon_rmap_pmd does not fail for
+		 * device private entries.
+		 */
+		folio_try_dup_anon_rmap_pmd(src_folio, &src_folio->page,
+					    dst_vma, src_vma);
+	}
+
+	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+	mm_inc_nr_ptes(dst_mm);
+	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	if (!userfaultfd_wp(dst_vma))
+		pmd = pmd_swp_clear_uffd_wp(pmd);
+	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
+}
+
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
@@ -1818,59 +1874,12 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	ret = -EAGAIN;
 	pmd = *src_pmd;
 
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-	if (unlikely(is_swap_pmd(pmd))) {
-		swp_entry_t entry = pmd_to_swp_entry(pmd);
-
-		VM_WARN_ON(!is_pmd_non_present_folio_entry(pmd));
-
-		if (is_writable_migration_entry(entry) ||
-		    is_readable_exclusive_migration_entry(entry)) {
-			entry = make_readable_migration_entry(swp_offset(entry));
-			pmd = swp_entry_to_pmd(entry);
-			if (pmd_swp_soft_dirty(*src_pmd))
-				pmd = pmd_swp_mksoft_dirty(pmd);
-			if (pmd_swp_uffd_wp(*src_pmd))
-				pmd = pmd_swp_mkuffd_wp(pmd);
-			set_pmd_at(src_mm, addr, src_pmd, pmd);
-		} else if (is_device_private_entry(entry)) {
-			/*
-			 * For device private entries, since there are no
-			 * read exclusive entries, writable = !readable
-			 */
-			if (is_writable_device_private_entry(entry)) {
-				entry = make_readable_device_private_entry(swp_offset(entry));
-				pmd = swp_entry_to_pmd(entry);
-
-				if (pmd_swp_soft_dirty(*src_pmd))
-					pmd = pmd_swp_mksoft_dirty(pmd);
-				if (pmd_swp_uffd_wp(*src_pmd))
-					pmd = pmd_swp_mkuffd_wp(pmd);
-				set_pmd_at(src_mm, addr, src_pmd, pmd);
-			}
-
-			src_folio = pfn_swap_entry_folio(entry);
-			VM_WARN_ON(!folio_test_large(src_folio));
-
-			folio_get(src_folio);
-			/*
-			 * folio_try_dup_anon_rmap_pmd does not fail for
-			 * device private entries.
-			 */
-			folio_try_dup_anon_rmap_pmd(src_folio, &src_folio->page,
-							dst_vma, src_vma);
-		}
-
-		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-		mm_inc_nr_ptes(dst_mm);
-		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
-		if (!userfaultfd_wp(dst_vma))
-			pmd = pmd_swp_clear_uffd_wp(pmd);
-		set_pmd_at(dst_mm, addr, dst_pmd, pmd);
+	if (unlikely(thp_migration_supported() && is_swap_pmd(pmd))) {
+		copy_huge_non_present_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
+					  dst_vma, src_vma, pmd, pgtable);
 		ret = 0;
 		goto out_unlock;
 	}
-#endif
 
 	if (unlikely(!pmd_trans_huge(pmd))) {
 		pte_free(dst_mm, pgtable);
-- 
2.51.0


