Return-Path: <linux-fsdevel+bounces-65415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0260FC04D27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031F01890422
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36D02F7ADB;
	Fri, 24 Oct 2025 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Htc76sZi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GALQlpdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED852EB849;
	Fri, 24 Oct 2025 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291846; cv=fail; b=aICvkouahKwMWlGARZXKzebziX3TXWO61G7aLSuOzREYeJwmH7vji2TzgK9R3ZaypU8tSdLBizje4MCWOqMpStbNnLUIikai+59rScZPwzwnH88+DxMX2S3CDjG1aPNGwRCeG5KCovpUw+i8ZeRLetuspXrxqw6f3Jz48zc47Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291846; c=relaxed/simple;
	bh=BWkkOCDw4VNBmessRhk2oTHisMhSBnSWQP0uF8S8r8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=psaabaLJ7x+XwRmoiZ6VBbI5Dgt+PoHufX05Fp2e5AFIiNgdOlflHAM7K0msDC3UdBdIAm+boTsW/oHmhfnOy+4skMRg5MH6iuHTUUZF0dlrjCw840utuRMNJ+4a4ST7OkVd782gz1JoAzjQCW+Q0S1g0IJVGdbREn9axGOz3+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Htc76sZi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GALQlpdr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NY5m013823;
	Fri, 24 Oct 2025 07:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=a+0mdXY9CnP7r1mo1tK6ljpG5PNWWDn4EcgtuPgLWFA=; b=
	Htc76sZiwWD7ee9hvzVN7MhcQ7lz4RpVJ/7tKyKuZSYEsVlcrNruYyoNQy/JZASP
	eIThVq1xiit6wmDnyG8+Hw+vlawibKy/+qSYfz1fMsiKxxEuGSraPiQ9/9gLGM6W
	TtDGfB4hI5LA/eEgvYV879UmjbAqhLoO5NeVlsX/HufP0wvORDQwjsjeDE2o0Npa
	zMTMgrEAfgoHd6m6DUyuH9ENPkMaC7zO52oun9uzoNJymblg9iJOi+7CmKb/DXxT
	SOY/lmN3fnYY4D79nJvh4Uax4Po+/KBEMD1d61+RB/94CPd9uH89D2By/qDOu2R9
	nxqwkBdHQdGz6wkQGVrBgw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ykah1veb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O78TLf022277;
	Fri, 24 Oct 2025 07:42:04 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgmc2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBgv4cVWxqGC9nnobIuJ9ZARGttXq/6kc4VZPnv9ULh8DMkBzxMflXhgo38Cn+11uuOqQhLKRjdWj5aNdfcr59pJA3HN50sEx+CteI7MrfEYRigJ/JvanwMFQe3YKZKaKjXPRvYaWg2mfbYHp3hfS/1Xa+1xOotTJxa4uolFkd3L71KMu6VVJxSxf72IkCbLw9SuJlVD4KfYDftNdkrzmaAJv7h4zQ49Jqa8q/RJy1p+s5EPugHBAiWkJrpJSEwiZjGhwtOY/fHmS2sa7AZ0cYHAuqjJaF8hY0s0cjnrgTpk0ytjAPnx4+JOOTEdtdw2ZPIv3YY2WvZzRDOSJaACYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+0mdXY9CnP7r1mo1tK6ljpG5PNWWDn4EcgtuPgLWFA=;
 b=oxaxAzCpUb741aQRADlXk+vVqiFXj6XAGcL9bIUj27cMPEFE6m23dIJwuX+wvhJvfhxKSrbS8NgF4SwM/0q55yz6gm9YVsqkeDDsUzVt70Ko79eIgJ4D3BNRwAbeA5Wtgd58Br2X96PsaHeXUMD3VcKX+eGPslylptKXJpqTmUeDiAIBnx1IlWgE0C3LO1fnTeAe7m7T8iI1NhLM85BZC44wTiZwZKORIywmy4BQJMUqNP1xxJPj35KjUDvENrkM3aRa0kuNYoHXaCowMtE1IV5ubawzWEzyIN3eNlr5Gi+YkERnOiJdlrrNYt0ma/NWVr8D9f9G6ZEp+G+X21pGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+0mdXY9CnP7r1mo1tK6ljpG5PNWWDn4EcgtuPgLWFA=;
 b=GALQlpdr+wtq88mf0BaLu4RnGT7yGscFDkygH6TIRLaLZfb228muyA7eh9ryglZ6Fam/do0mmL/pP0HcFpPpAPEH4lxxgNdyfyZjjGpvvbCMU3IuZtoOoEru2j9lodwWmGsFQtAPwMWpN7Qi6otraAqN13mE4bDegJXCZc3D5Xk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:42:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:42:00 +0000
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
Subject: [RFC PATCH 06/12] mm: avoid unnecessary use of is_swap_pmd()
Date: Fri, 24 Oct 2025 08:41:22 +0100
Message-ID: <7702eec12584bb3332b0013a8372f0f61e006886.1761288179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea57e26-2e50-4106-2e88-08de12d0d0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DvjS6yoi+iUv7kZ4ABHZaTKmpLtifKSKg26EtG19qmwSo9u3OZGBs/jYjA40?=
 =?us-ascii?Q?ooWU/mNHH+enhWbSSLSwiMqdjioWJwFNC82p/0FnHWC/gFxDbtJ22wXKHilU?=
 =?us-ascii?Q?yngOcrYdzcj2jIieXD0sbKHMrVqD+BV90nytHWIewSkl9NgNxGHSxUbz11N4?=
 =?us-ascii?Q?RG9+uc4M+gh3e8BIrs8BF2wp83+UAEqfggwXfIhePhJwZ8q7k6BRg2UsJ059?=
 =?us-ascii?Q?Tzw/+MW4IN2ZHY/hE8C7mv0mBxaAgx0zuzJq+8cpvJ1TD0BoMkRZZAoXgSW1?=
 =?us-ascii?Q?2GipaootsY5aaK663S/tr7Ur/+1DafeaiiuOkxAEJsILie4jobkC6qeTwdNM?=
 =?us-ascii?Q?sJ9NvjoyIB4EmKyCdl423Q9mtrx34c+JQGYL7ZD921tsdTrSMf9uThOyeICV?=
 =?us-ascii?Q?qNwTOheMeUivaIHNDY1FNZgq2JFoXSPPV08S+vNXXWlj37imDnJ2xQgVxskw?=
 =?us-ascii?Q?R3WO7JE+iZ1U+cK9MaPs3zTQQyyJWMDPp8w9eZLT2EMQBPwNPAgD6zEl6cuE?=
 =?us-ascii?Q?MnRfsJ6Z3XQH9Trd9IGeGFCLIPsAg1OrhktxnoZ9HF8FUqsxDSNcX1Oh23UC?=
 =?us-ascii?Q?U3NjQ0Hc7tZskYALuTK5EZfdOzes6c4NrEKV36D6bXW07jRTHjYOwqKneenM?=
 =?us-ascii?Q?rtq84KR5EzVz+l5S0GFRwk9GA4BThnvZmun9BwjiRzMfEe8Gy1s/xpblPkDm?=
 =?us-ascii?Q?wlUKLr4IQZlcbF946NTTssM2E3bQW378F7M6ZL2HPD3eQO/l8Qciuz+HiZki?=
 =?us-ascii?Q?BYjs7bTMJhl9z3py1JGDSALXjKPDDIwdJ7PNENyX1hVgvEkar0poyvjtMbwo?=
 =?us-ascii?Q?GR08xiHc5Jr0wC2CxbmoXjYwO0Q1BlllS4ZZqlHogMwEQhtHXmWenLg54JX3?=
 =?us-ascii?Q?0GffkOPPGUzRZ7oDnmbEn3QDoXIpUTDOe8BvyVtDU7OKb27LgCnr+lV73O2+?=
 =?us-ascii?Q?S1IDSU2sMHsdtiyD52QrUagfBtnkeoPiTqocRoVfliNdNhu1fFvF2hctEDja?=
 =?us-ascii?Q?+T/FkG41ECfQZl4PsEPUK7xcsbWVZRcHL+oABpSIqGWgl9ida4B27xUo6KqG?=
 =?us-ascii?Q?UH5vf6zOaKqlR/3O+MKqjwvIVZ13Sv1J3lLgonFLfnh/NKTLZzIGexCo3UvL?=
 =?us-ascii?Q?UazrsRJggX6vcCvOwcxNuk6XowTrky6+GYqmwZ3iRcaJ9C5So6IUOc3sf8zW?=
 =?us-ascii?Q?KghUynqbPh/blp1fAv8kFQfUKdem5ISiFCkJ8ZHMx4Ssps4ZoYcWde1G96RP?=
 =?us-ascii?Q?tU/Kjyrj4jtdZmnn8cXEQHdD04uaQd0Jua9TJxcnrfuncazopVAXXWySx0aS?=
 =?us-ascii?Q?nO8cfoWM23eKaIa5gyw2JbAqIRQHm5149TEEAlR2qK9ywJmIjvLiunRheIlB?=
 =?us-ascii?Q?g7dcj8JNw29X6zqxeC24PYdoTSvoUyCZyW2hLoyEfky6Z9j0qsvG9JtFzLjd?=
 =?us-ascii?Q?Dp98888CUtnDadSRk4kYz1mM98xwou5a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UhxxJOoz46UDuK/klyp8X4+jZacQXUR7elXPbdtR9hfTqTmxY+QVimmzILPh?=
 =?us-ascii?Q?dA6KtrKOvba0JX8QFQNhw3tyjiLXJnJCfWzWD2KfUk7USwUlD+UJ1SpKq5fN?=
 =?us-ascii?Q?1RoeMvGZnFqGUsCjL8l/bWo4zWf/a8HB50HCcks6gpYAkZWY/wZSSQkzXIoT?=
 =?us-ascii?Q?Qmpkc3T31G6yo7rurkgvciyGef9KtKKn3TZZMOkpoczIofyomt8kRrfjERA/?=
 =?us-ascii?Q?BXsuRzBSyDT/6ZsdeRfuy2rqbXYQwOTtvqU8RGbpuFVxbA80WpcQ68BDAh+K?=
 =?us-ascii?Q?7QhVYk13dxZwbEOaLnaYJt3K0C2mk7LrVYDOAtTTggQX4nIV/DBBa2D7NdQe?=
 =?us-ascii?Q?hLYnD6VlsJtNOm4PKUn/Zjr/zIJ7y/ZOdFNnHel2bt1QeTcA2Y1Tk5jo94wp?=
 =?us-ascii?Q?EL9J4aUH6sWFaHtDyKGAFRhxt+orpPhSer7/x/TLzw5JCPGhtThL+QFPVdtI?=
 =?us-ascii?Q?g8OYYuM74aJ0hf4F0EUhJhKmMpXRqHVLCpUwpdSMsxt3SRKm972qeaIghQFk?=
 =?us-ascii?Q?OTYhh9DIf+DLi+nFiueiI9IzJR+yaPH0dvXRMYCyUHMBiecxtmtmmkp5A0HM?=
 =?us-ascii?Q?wMitJ6ZB1o19rkj01EvL6hLJAh0rOSVdUIaUUDMEnzDYzkHgjBoK7ZtvO0ek?=
 =?us-ascii?Q?HDee6pHnJ2mHPx+HokX55hH0FfZlZyiHFAdqxJs+KY5J8U9oxuwIjsIHA9pi?=
 =?us-ascii?Q?FNwRv1plZZx506oILM3MzpwutGd8N+fXRC2IoUFIp9ycjAfXnLnpHCmSK//R?=
 =?us-ascii?Q?t+9dZ2A0CxSah4+Vqbt+H3KJUJHJWiMx3yq9dtqMwhfUS/hPBesdaBVxYqAx?=
 =?us-ascii?Q?2/Cc0mcfRUgD/ZqZqc9oTlGvl/JvBYNiKQcRPyxGXzPrLDxmpwj+XZCicIEh?=
 =?us-ascii?Q?K01TqDXOHYwrNkDqgiCfZMTTJy9Z8ZrFlO9n/N//y2REVxtlbTP0aN2e4TSs?=
 =?us-ascii?Q?LsQxu4IQ97tNkwIwRMbrT27kPs8JeVMT2+7GKasn5Wo0zq1j+RWCpUFDS4wL?=
 =?us-ascii?Q?WI6xSE2AUkyhrgCs5grwcJy1ij8kSZIF+HlDKIUhvfIQMY5epxsQt4JUQGcc?=
 =?us-ascii?Q?GIe7meTUk/pZ9CYsUjjnYu39YHB3141k5IBDPHHye0e0NMqvjgkSXaFKoPpe?=
 =?us-ascii?Q?BvMIki9r5tq15ALFcrRjVUll7/F5t7+4CUn9y7yjowWrL8rdsLKAmnu3H7Z4?=
 =?us-ascii?Q?t5Y166QdDWksmAnMiylLdB1kIaEyKhYtgn4rEJra5rs5X2MxLDZk6eSi2nSB?=
 =?us-ascii?Q?F2zCTC+JyxfZ6bgzsgwYewLv9VCblg9xO8jYirBB/+Ee4L92RfVfZSpsS//w?=
 =?us-ascii?Q?oBL76YcuQ3PvbZDHtPYnZljLUoLhpXrnTuC/PoP93B0e+V596fTNJ+ddicxF?=
 =?us-ascii?Q?eCZs9ah6i3Z0/rHs5oCjAyVk7grUz3D7Mf1pg71BhPTYLwDLDCL4DPmg20bi?=
 =?us-ascii?Q?WzNfoIjQ1++QStuYiACBO0BZM8XM0f46+du0q1/cBPzIc01GeR/4rM63FcfI?=
 =?us-ascii?Q?2j9ZQP7HJecxUJcH86ZOTGoJrEwLPKKXrAXnq3Z06wEDAiDD8Sv3VkQidHFo?=
 =?us-ascii?Q?Mdh8oM/sIndm7mzsfLx9Y3cdCb8jMHDoAsrc9X+iroQr688watC1bTYsqGnD?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UoOCkVHfcVbPhzvb3+g4BflUaDsgVW7ZAuJRA8jT2nZ6HalGTUr9tS5IgF7ezXSFxnfGVf9aK8+s3PvAnwWaPTWsqhDdPX+BUvVpZwxJz1jy1sPwsTeBMmcqwAnONncl6OS2VcjXZ+BCQABDqQbEr7AvbtQeMPmbwdPvroprTlp1+Im/dwhO2aWAhnPcT+MtkR4Avx0+WmmbzbKggG71c+vW4geOcaiBJox9FnepZjcya1YlIr0PUVp0ewRAcvP1pqfZJiStmI+hfVDx7dj+TPzRch9eL3w4rMdrmPVr5iqlpTpPp+aD49zPZfaspz3vRJ14N/Z+4d4xQIEZs/vD5bWLQ28KT/vobW1o6s1GxgWv3pWpTo3HkKTYbl+X1DR7Xx1p8QyWAT/xV90NS+KIR/ShhuE5LlXX6pdlmnXvIeHsETiuHbHzn0QAjDYG3WkNvAQN5Zl4GQ1XngKSV3NMwiWSLGMmpdjKXHtXdSVpXl4OPamOSInX7uJ99vGVqrk7OrBr5adrL7oAYddbYE+jmXsMG19aphZZpocOCdvX5zGH2dWIZDFei7lfh4hvS5QrpAz0vUOg3Gpu1N7zQ7KlbIWN967z9mbaDag7Bhw7L/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea57e26-2e50-4106-2e88-08de12d0d0cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:42:00.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZRQwukZlTpUXKThw3jw1U4RIQfojhTWJYslyIOBSqW4JaK1xf3nM22oVUx7epIGeaQD7glxx6Zjg2d206pvQw6nE+iri5WSww2ESh9O7AM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240066
X-Proofpoint-ORIG-GUID: GrRxZas3sQSKPXQRBR8XA5ZcPmgJbEnV
X-Authority-Analysis: v=2.4 cv=XJc9iAhE c=1 sm=1 tr=0 ts=68fb2dce b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=96_WKPqrBKIKR3zHGkMA:9 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEwMiBTYWx0ZWRfXxvGiUkQV9A8Q
 uy1BJ0g7IOKd+CkxiW5lZR3auvvV5VWj7pWSkD90qkvTgPCDN2AkXImdnGPBc0IBH3gxuxVNNV/
 tEGKcPG3jPwidpUYSofWUK3V5dsDpOAuJRMk9NHXxnOK1PpaC/iJNhobAP2klpSnyIgsPj7jgCA
 HbJq1UJ29tNG4tJFq1P5a/Zo489NWBVHKA1l+fiiEQj2yiKUImGQpJg/kgHhmgwdJ9aS0v7g9Cj
 AiM51fY5w0AXbRSrCq/TZ4XF82JbOyiIG5dMaFJ03jLB1nkaocblLJaqG9Tr8GA22YYNpy3VUMi
 VqycPTKBrxKyilOXlJSX2F4zmT+elBVjqigJhyu8L6hLaVdq/lFgt3puOtaBQwvzCzOi/acpEG3
 gGPbkEKj+gLtW4/c3/SMnq6qsVRoSQ9KQ8ZEXHNUb4zz47sXfd4=
X-Proofpoint-GUID: GrRxZas3sQSKPXQRBR8XA5ZcPmgJbEnV

PMD 'non-swap' swap entries are currently used for PMD-level migration
entries and device private entries.

To add to the confusion in this terminology we use is_swap_pmd() in an
inconsistent way similar to how is_swap_pte() was being used - sometimes
adopting the convention that pmd_none(), !pmd_present() implies PMD 'swap'
entry, sometimes not.

This patch handles the low-hanging fruit of cases where we can simply
substitute other predicates for is_swap_pmd().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c      | 15 ++++++++++---
 include/linux/swapops.h | 16 +++++++++++--
 mm/huge_memory.c        |  4 +++-
 mm/memory.c             | 50 +++++++++++++++++++++++------------------
 mm/page_table_check.c   | 12 ++++++----
 5 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3c8be2579253..1c32a0e2b965 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1059,10 +1059,12 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	bool present = false;
 	struct folio *folio;
 
+	if (pmd_none(*pmd))
+		return;
 	if (pmd_present(*pmd)) {
 		page = vm_normal_page_pmd(vma, addr, *pmd);
 		present = true;
-	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
+	} else if (unlikely(thp_migration_supported())) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
 
 		if (is_pfn_swap_entry(entry))
@@ -1999,6 +2001,9 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
+	if (pmd_none(pmd))
+		goto populate_pagemap;
+
 	if (pmd_present(pmd)) {
 		page = pmd_page(pmd);
 
@@ -2009,7 +2014,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 			flags |= PM_UFFD_WP;
 		if (pm->show_pfn)
 			frame = pmd_pfn(pmd) + idx;
-	} else if (thp_migration_supported() && is_swap_pmd(pmd)) {
+	} else if (thp_migration_supported()) {
 		swp_entry_t entry = pmd_to_swp_entry(pmd);
 		unsigned long offset;
 
@@ -2036,6 +2041,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 			flags |= PM_FILE;
 	}
 
+populate_pagemap:
 	for (; addr != end; addr += PAGE_SIZE, idx++) {
 		u64 cur_flags = flags;
 		pagemap_entry_t pme;
@@ -2396,6 +2402,9 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 {
 	unsigned long categories = PAGE_IS_HUGE;
 
+	if (pmd_none(pmd))
+		return categories;
+
 	if (pmd_present(pmd)) {
 		struct page *page;
 
@@ -2413,7 +2422,7 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_PFNZERO;
 		if (pmd_soft_dirty(pmd))
 			categories |= PAGE_IS_SOFT_DIRTY;
-	} else if (is_swap_pmd(pmd)) {
+	} else {
 		swp_entry_t swp;
 
 		categories |= PAGE_IS_SWAPPED;
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 728e27e834be..8642e590504a 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -573,7 +573,13 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 
 static inline int is_pmd_migration_entry(pmd_t pmd)
 {
-	return is_swap_pmd(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
+	swp_entry_t entry;
+
+	if (pmd_present(pmd))
+		return 0;
+
+	entry = pmd_to_swp_entry(pmd);
+	return is_migration_entry(entry);
 }
 #else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
@@ -621,7 +627,13 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
  */
 static inline int is_pmd_device_private_entry(pmd_t pmd)
 {
-	return is_swap_pmd(pmd) && is_device_private_entry(pmd_to_swp_entry(pmd));
+	swp_entry_t entry;
+
+	if (pmd_present(pmd))
+		return 0;
+
+	entry = pmd_to_swp_entry(pmd);
+	return is_device_private_entry(entry);
 }
 
 #else /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 370ecfd6a182..a59718f85ec3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2428,9 +2428,11 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 
 static pmd_t clear_uffd_wp_pmd(pmd_t pmd)
 {
+	if (pmd_none(pmd))
+		return pmd;
 	if (pmd_present(pmd))
 		pmd = pmd_clear_uffd_wp(pmd);
-	else if (is_swap_pmd(pmd))
+	else
 		pmd = pmd_swp_clear_uffd_wp(pmd);
 
 	return pmd;
diff --git a/mm/memory.c b/mm/memory.c
index 19615bcf234f..83828548ef5f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1375,6 +1375,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		next = pmd_addr_end(addr, end);
 		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
 			int err;
+
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
 					    addr, dst_vma, src_vma);
@@ -6331,35 +6332,40 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (pmd_none(*vmf.pmd) &&
 	    thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_ORDER)) {
 		ret = create_huge_pmd(&vmf);
-		if (!(ret & VM_FAULT_FALLBACK))
+		if (ret & VM_FAULT_FALLBACK)
+			goto fallback;
+		else
 			return ret;
-	} else {
-		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
+	}
 
-		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
-			if (is_pmd_device_private_entry(vmf.orig_pmd))
-				return do_huge_pmd_device_private(&vmf);
+	vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
+	if (pmd_none(vmf.orig_pmd))
+		goto fallback;
 
-			if (is_pmd_migration_entry(vmf.orig_pmd))
-				pmd_migration_entry_wait(mm, vmf.pmd);
-			return 0;
-		}
-		if (pmd_trans_huge(vmf.orig_pmd)) {
-			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
-				return do_huge_pmd_numa_page(&vmf);
+	if (unlikely(!pmd_present(vmf.orig_pmd))) {
+		if (is_pmd_device_private_entry(vmf.orig_pmd))
+			return do_huge_pmd_device_private(&vmf);
 
-			if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-			    !pmd_write(vmf.orig_pmd)) {
-				ret = wp_huge_pmd(&vmf);
-				if (!(ret & VM_FAULT_FALLBACK))
-					return ret;
-			} else {
-				huge_pmd_set_accessed(&vmf);
-				return 0;
-			}
+		if (is_pmd_migration_entry(vmf.orig_pmd))
+			pmd_migration_entry_wait(mm, vmf.pmd);
+		return 0;
+	}
+	if (pmd_trans_huge(vmf.orig_pmd)) {
+		if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
+			return do_huge_pmd_numa_page(&vmf);
+
+		if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
+		    !pmd_write(vmf.orig_pmd)) {
+			ret = wp_huge_pmd(&vmf);
+			if (!(ret & VM_FAULT_FALLBACK))
+				return ret;
+		} else {
+			huge_pmd_set_accessed(&vmf);
+			return 0;
 		}
 	}
 
+fallback:
 	return handle_pte_fault(&vmf);
 }
 
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 43f75d2f7c36..f5f25e120f69 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -215,10 +215,14 @@ EXPORT_SYMBOL(__page_table_check_ptes_set);
 
 static inline void page_table_check_pmd_flags(pmd_t pmd)
 {
-	if (pmd_present(pmd) && pmd_uffd_wp(pmd))
-		WARN_ON_ONCE(pmd_write(pmd));
-	else if (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd))
-		WARN_ON_ONCE(swap_cached_writable(pmd_to_swp_entry(pmd)));
+	if (pmd_present(pmd)) {
+		if (pmd_uffd_wp(pmd))
+			WARN_ON_ONCE(pmd_write(pmd));
+	} else if (pmd_swp_uffd_wp(pmd)) {
+		swp_entry_t entry = pmd_to_swp_entry(pmd);
+
+		WARN_ON_ONCE(swap_cached_writable(entry));
+	}
 }
 
 void __page_table_check_pmds_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd,
-- 
2.51.0


