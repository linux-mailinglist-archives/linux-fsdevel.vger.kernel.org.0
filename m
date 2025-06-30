Return-Path: <linux-fsdevel+bounces-53304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 906F7AED519
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 09:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792161893F20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 07:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9774B1FE45D;
	Mon, 30 Jun 2025 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EgB74A9U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l6xq/+5E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD54A23;
	Mon, 30 Jun 2025 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751266872; cv=fail; b=fpafTAe0qgeMQL6gZOHMwYmi6KZI5K9a1dW2zjGMzHYnsArA5ab1w0ssn3DAINoLKXOZAlbdNbrF/uOO8UpGGqLuSuC3g5uyrxpycx+MpGD09Fe9EAxOOp/gVzEnL4Z554yggVbJuBmLe+6Aq2Wq147RGrFDw45oZXbQsnD3dEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751266872; c=relaxed/simple;
	bh=/XHIHUXOxxszQPo+QbefyKFLNJ1HsY9IWkpb2l0ldLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I1w0eoJ0T/9s+/YoBF6kpVHsTlDMG0o0jxm2BtR1s2KZnxXzk5tQ8Q1pDtpZS/U2kDzreNi+iL3IjCMmlY8vnHA32acDzFiMON+PGdL93UHP6oKuMM/fOr4GqNBAMk2zkyo5DYohR0thC6InH+G95J6fym6DKDjWjWRyqKH8sfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EgB74A9U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l6xq/+5E; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TMxnsJ026614;
	Mon, 30 Jun 2025 06:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nrgwKHIcV4oab/uBhaReyn0hb1JDumrq3ZYTqApf0rw=; b=
	EgB74A9Uy1F+Q+F02iJxrZDD5YdwCQhZG8XDUulMrIAw/cVb6x1srJexKiIbmWV1
	302aEI6uScChwYBsfCfw5vigde5QcdHSBzBQ/T590wbU4olkAo7EZm7rGRR9c5hv
	MiktZYFAYYvX08df00Z5UFj+/TZZnRedufdOe1gQDVnmgaiJTpjNdle9mHtfDAbd
	RQ5XYSmoe0zgsn78/bjMI383EgBV3Z+RH7Ix3t32wZp7TB4WEc1wQq6C8VUraYOO
	gAick3QwiUqhmQRNG5Sf8/tqjbc09kXef2IQJUqEkZJ+itHghmYcoS5shnWb6s+7
	+sHNBCJpZHapL5Z05VYbIg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx1tdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 06:59:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55U5h9hp017045;
	Mon, 30 Jun 2025 06:59:29 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u7qf0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 06:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wu76MIFxZk35BfJ272W09pWzbbDYbTPD9sl9BE6xgUVt+UMnBjDOfGC0MF1KYQjBHCn58b1K8TvD4uJuYyQFB1i4uhowi0X9/kYU8AtpukZj/xJmmLR0taR6Lz8fQnQlUKDVA1x1Bee8Lb8mZWFw6yQ6JU4sXWZHlYWNDoWIpg+EyhN6yQQwJCfr2KM1s2R2wgp/jeS8P1ltGWDi6hgrpjRXt5DiRtD/I5avjIemgewuXAn9l5/3u/NNE6C7qP05N0XWGIizZ6UbFJjt9mpr6chWcGS5T61A5ebljQDuZN8yoDreaTV5/62/5iKhkAfP8NWzWTsYQvIVT08DcY3lQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrgwKHIcV4oab/uBhaReyn0hb1JDumrq3ZYTqApf0rw=;
 b=FFNAxY3kS1bZVgXCxAZq0uRdYjOs0OVMPKEHqQQxNVzeK9XY2pxf2oi3JSI4gum74aS76MrECNWPUgwJH2ZQBPVElt2wkG9ghehsoLYqwUdYqM1GR7n/kaU6isnNH8gNR+UT/xGmEqYATUcsxVaQIOkkTbeGhVJLcYAVLNF8S5XTs4+lWVqcWA5MBbfXpsTzS4gB1w66EtQCmFqBkA1c4BG6fG2iqoGsKK4njw4+rbNSy7Uyj62sy1zFxRRzfTYGHH9RtEoEfTrT7zCwiTfIbEXCVwohbUegYQFmWlseNffifkjtmoUvLfwHwKTsVbIeLyXB9de3iY8Ps9PDgmt8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrgwKHIcV4oab/uBhaReyn0hb1JDumrq3ZYTqApf0rw=;
 b=l6xq/+5EXG7Q95IrDoIg50ub4UlTGK+GRcDUsXj2WpF24tAgBiQcBmkbypGZjwAzXdcGFbYvNuHXb0Sz2/HYNcCqeI34evPOVutR3T5zbKbgo71MddPW+mE8Sh0y1UtE9X9voBnZ+ki4wPFAQ+BH9NslwLnsGAnAjnTb3YGB1ws=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB7155.namprd10.prod.outlook.com (2603:10b6:8:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Mon, 30 Jun
 2025 06:59:25 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 06:59:25 +0000
Date: Mon, 30 Jun 2025 15:59:12 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 04/29] mm/page_alloc: allow for making page types
 sticky until freed
Message-ID: <aGI1wLbCs2NhTCL9@hyeyoo>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-5-david@redhat.com>
 <D80D504B-20FC-4C2B-98EB-7694E9BAD64C@nvidia.com>
 <D718A3EA-89E2-4AD8-A663-2DDA129600C4@nvidia.com>
 <18ef9192-168f-4d07-a29a-952f2ce3a4f0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18ef9192-168f-4d07-a29a-952f2ce3a4f0@redhat.com>
X-ClientProxiedBy: SEWP216CA0099.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 10dc14d3-f17e-4b1c-c547-08ddb7a3a633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkkxeU8wYWxCWk5yUEVZQjdwVUJEUWh0cGxBTWJxek5IMjErZ3pGU1l5U2kv?=
 =?utf-8?B?TE1hMWRxWklSZ2wyUGV2TUlieDRRSThtS0c1V2FMSUl1VWdQWTFRV0hxSjN6?=
 =?utf-8?B?bStSVGovSmd2Wnp6UHp2aVVIU1VqaVo4bVVNZ1lITURkZHZ6Y2NrMGdMdVd6?=
 =?utf-8?B?K1ZJRmdFQk5zK3pSY1dlRCtwRVRRL0lRYmNKVjdtMjlDWXhsRExyeGxnTkJt?=
 =?utf-8?B?TDhKTUFJMjlUcmhualB0M3BGSkY5cFZmbzZZem4zRFhpc25zaGcxdzJEek9j?=
 =?utf-8?B?YmpOSks0NGhKMXRxbEh3VktMMll5czZWenZGMnRlWW1YeWtGcndTRzl5QXBG?=
 =?utf-8?B?Z3NLb2pSNVd4MUFjQUhoOVI1Wkx6eDdLVGhEMUJCY2hwTDV0WC85NVpDd05Q?=
 =?utf-8?B?a0Z6dzZwSEoycndCUEF4SlUvWFA4MEE0YktUQjJmbzRYREJLQ3hGdUdES05B?=
 =?utf-8?B?ZkNRc3lNL0dLZGFIWWx6NUMybmoybCsyU29pVVhiS3NDY1JLR2dwZnBlRnUv?=
 =?utf-8?B?b1RGSjZzV0VBcFFNUERVZWg5MkFudHRYV0N0WWQ3UGF1djFxUWNiZ2pnd3Jw?=
 =?utf-8?B?VGVaM1lWem9IQ3dMZ3VPc2FzekEvWEEycFZRSlo1UExmR29LdlFXSmtUYjhM?=
 =?utf-8?B?aFJjNzJVUGoxeVhNOHV2bFhYSloyb0RRSDhOdVNqbmZxTjQ2aUxGVWd1U2s2?=
 =?utf-8?B?eThMSFNhdks0ai9Fa3hBM0JOQkxtc2JnMGl3b1ViL3pFdytabTlGN1NweWla?=
 =?utf-8?B?UHd3MTZCUlNvSXZsN3VmOHZRQ3RXWVRTa0IwcElJRWM4cjVENFh4QnFMRmtz?=
 =?utf-8?B?SFdzTkdoOVR6Tko2QTJNWmZIUmVTRnZvNUozM0UvK3hja2NIWHNnNmZ1QStX?=
 =?utf-8?B?QVZjTElja3c1aUk3QVc1OGFFWEVvNktDNUx0eEo3dzhYdUhHbkE1cGNxa3ND?=
 =?utf-8?B?enIzSVNBV1RZRy9sYVFBbWgxR3hvOWtQSUhTMTNkczlxUUNhU2QyemRjVTFE?=
 =?utf-8?B?RVBkV3NpYnBUeHpCRXphWk5POHhhLzFKeU8yWWw3NlBtd2JPOExvQ2NlYStN?=
 =?utf-8?B?UHFPL3dmVVdiaTdUMnh6ZVVGWE8xVDhqcjIxelo5eDJlaXlwR1ZILytrTmlX?=
 =?utf-8?B?L2I5T25BZUxaWVBucFpEYTJYUGVZbk1rZVNQOGduTUhPdVJkMG5RLzhjb1JS?=
 =?utf-8?B?Z014YXI1QitxQUw4Vi9rNDRNY0RFZHllamRVZEUvZXJqbkJqUzQyc2FERWx3?=
 =?utf-8?B?SXZoRmYvbWpnUkpUdkRGZHJSNHp5R0diM0podWtQSkFiN3gwL0U0SzVvWTM3?=
 =?utf-8?B?UUZyUEdtMHJ3bndCbWxQUkZtWUN6VkQzUWFQRERwU09MelUwZWpacGRJcFNB?=
 =?utf-8?B?ODd2aUFSa04wOXAwU25xL3dFRlJCSEV2SUpOTXZRM0tpVzRwbHBJUWtMblNE?=
 =?utf-8?B?ajh0azBNWHduZVE0am1vemlFbmtiUFZkbkVDdGhJQWlOeit6N1ZYNGtYY1FM?=
 =?utf-8?B?QnpXVWJtYTRET1dxNG9rd2VOWDdWK0QxWDJHUlVVclNJOXJoWEQ4VDRLWUlX?=
 =?utf-8?B?UkhrWCtQK2QycWtpSjA5Skx4eHROUVFaUWRXR2VqM3RKcFFGZWpyZFU4NWJN?=
 =?utf-8?B?b3EzZmR6ZldJdlJHL0hWenQzT29lSENWS2Y2OWhiY2JYZDFDZFlBZERSejFO?=
 =?utf-8?B?cWZvd3FXb2xFOHNZbk5yeUJXSXpyaEVXNDZQdzVnbENHRmh5M0h4NEVYbjFH?=
 =?utf-8?B?ZTE5NWIrWVpQMWNmczh5SWhsa1FqdnZXS3hxNzY3SHMwbUt1SWlQRE9GN3BR?=
 =?utf-8?B?TXZGK3FocjRSVjRZQXgxamh4Wkk2N2g1Sk5HNDU4eU14UFpxSFBsNis1WlhQ?=
 =?utf-8?B?UEx6SUhKejlLblpmdW5aSG5jY05mVFlBZHVWUXJNeXhJR29sbERSa1BkMDVC?=
 =?utf-8?Q?wBXR7WSu3m4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2Q4aUFqRXFZVDA2YXF4SFlYZWlqakRhU2pZcE9Rd2tNbUhNTTdnNXpGOUdo?=
 =?utf-8?B?MXM0UURJcGNQdDFvb3k0b0M2bG4xb2hzdDdsdVZwZlVaN0V5T1FiR3lZWFlH?=
 =?utf-8?B?bjFGTE4wR3B1WGpaS3gzekgzS1kvcnBXYjdxVmZTZndFSmJmL1NCMlZuNWdh?=
 =?utf-8?B?M2lEbC9jd3BXeVVDalVkOHVYcU9xOWRUTVI0MzQ4b3FxUXFtb09hclZpK2dT?=
 =?utf-8?B?ZU1KQWdndklDSjhsWUdvQllOUmZZYnNnSFUydmRCN0xhcjZBay9vQ0JlR09Z?=
 =?utf-8?B?eml6b2VNYlR0eXFoOHo1RUx4OE5DcHdrZnFGOVJxL3phYzB0Qjdlbm5sMzVm?=
 =?utf-8?B?VHhEZmlqMW1kRkRBd1Bhd0MrUlkvQzJPVi9CNUlqNFBvN010N3dCQ0dsR2tZ?=
 =?utf-8?B?MkZiZFZzaFpmZ3N1dElHNGFodGlZS1hoRUdBTC8wV3A3U3hTTkNpV250SHFV?=
 =?utf-8?B?OUlZTUlnTjFGdUtLN1BXaUJ6MHVoOWFpWnpDdGMxUkpDM05oV3hFbVRxVit3?=
 =?utf-8?B?N3M3UXVDbWtUT0FLZkJKN1ZjbU1SZnhncUtkMU1JZzAyZjdpOEFYUyswZENI?=
 =?utf-8?B?SDl5b0hXVWZDQ1UzcTZKNjNTSi9Ha25yS0Y0QnMxTFRySmJwRTVTWVZ6RzZU?=
 =?utf-8?B?VFlXRzh3L0dOK0Q3RytlbFQ4TmhiZGtCeGpqd0xkU3hwSG82dkFHVldVNzdx?=
 =?utf-8?B?YjcrRjVXa0NqYVhnc2pVVitQOCt0S0FnelIxdDNubWZYQnEwSVBab00rVFA5?=
 =?utf-8?B?MG5LVGEybVdZWWhJNjRvK2NNUTFla1ZDSHdXcWg0bHpZdDFBTEdaMkpCbG5l?=
 =?utf-8?B?ekZsbkhJNWVjZSt4YXBDMCtxLzVXd1NUTkhhQlIyRGJHaVlLRFZDK1gya0xj?=
 =?utf-8?B?WEV6emZJam9CcllwVkMrdlBZY1dHbTNrM3ZtMlVhNXBoMVA3ajhjVkVDMEIx?=
 =?utf-8?B?YVQwUzk1bnFxa21wUDIxdWxVdHFVZTM2VUt4RTNpeWgwWU5YMWdmZ2UvUUdR?=
 =?utf-8?B?eXVSMDNEWlZKeWxoYVFkWFVFbTNwMmFWSWd1anVmT2NQV2NMMUxQWDJvcEFR?=
 =?utf-8?B?ZDdDL2Y5em9ESlJQcVdING5iOG94by93M3VvdXduNHpzSUdNdFdyMUFxdm80?=
 =?utf-8?B?aW5obTBBd1J1RkhseVo2VGJNR1c1OStnM2M4SnJ3aGxobldVKzRKZUx6RGxB?=
 =?utf-8?B?UnJJS2U1UFFPN1U2cTNqZzF6QStBL2NiRU5Jak9NUW8reGJpR1lvd3NIV3c5?=
 =?utf-8?B?cnJuaHp2TnhEV21wY2ZBLzRHQzlnaW5EYUV3YVpuak9jMGVwTHBIaHVubXB2?=
 =?utf-8?B?TTBuamkvWnVvd0VZRDNDZ3pzZ1BpNHYyYjcwWVc0QWhtbURSMWlwU2JDY0xt?=
 =?utf-8?B?cjFjaFZnMXlBMDk0Qi9kTE1TaE9ueURCMjNHSit4d2hPN1FOR2RaUFJZa3hW?=
 =?utf-8?B?cjYvV0NyWXNiNWU0SUZjZVB3bTRERXZjSFNDOXBtQW9QTndLNUs3am5SZzVa?=
 =?utf-8?B?Y09EcDBoOVd2eEl2Zm5qMjNROWNlMWhvYVZxUXpEUDE5eENXMDNRQml3ak4v?=
 =?utf-8?B?NFlFWHBoVmtZVWtYYUlIK2I3d3hUYlFKKzZhT3RKdS9jZ1pnT3U3REJNUUlJ?=
 =?utf-8?B?T2FVUGJRQUlWRDFUbG9iMjhqSXY1Sk56WkF6KzYyalNwSVQrQTVVMHRSWHF4?=
 =?utf-8?B?K25BN0ZSaWVpallMWnoxV1FVSFBVU0J6T3BDVkl4bEhrRnRML1BpVFFIM0ti?=
 =?utf-8?B?NWt2U3I0RkM0bjZOY1V5K0FoUXR3bko3WjhJVEZWdTBCaC9QU2JPTGNIWi92?=
 =?utf-8?B?NXJzT1B5SzlvS2wxZ0hPVFhmNWh2ZHJ4OTBRYm5nTHdQVHZYaVFCdmh5aFFU?=
 =?utf-8?B?U284UXNGaEphSE41Nnh5Zjc1ZlM0WXRvckppMHo0b1dqVURRaVBuVVhiTmxH?=
 =?utf-8?B?SDNCa2lkR0FaSkFISGFNSW5Mb24wN3ZJKzJhSWdZZUFQc0tJUFBHd3BQZGxH?=
 =?utf-8?B?WGh0eFdpaEZ5R2lLb0FMc1N4dEFOWkFucUNGM2xGbklORVRacGlFUWNYckx5?=
 =?utf-8?B?QTh1UU1CQTIwQkJHUk9KZjQ3bmFvZGVNRkpjSWl3OW40UmRONU5VWFhTcTMv?=
 =?utf-8?Q?RiN6q8ViEd0uu0cIdBLnNgaJK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hXdDICFV1C3NO+bvYGf7h56eNY0L+uo9SJ2IkgfiXrDfJ30WLW8nVzph7OGW6SmEAJqUcoLd/0HMCywntPEgZNmsnChQgfjG6o9lC8tsgbiqs2Qq5TAJZM3Oq4+NlznscIMtvbIl/B89WJrmUL8R/jzXWtMyr8JD++aOL1VFD4r3ZElqAeBfY0vW49q7suy4Z0UV2Oc/eyFHJFm/b1MmAunrlvnK8PQnjwd3/djI/ofQWEZw9rHvojHcrdK7ycygIWU9QjjnvEMR+GbDATKZU3bPlyu75PdB+orTcYO2V65tJ0vNZgUcl5JO0UacjQ9KRT8F3W6p/xXgzttLYMi5dEJ/VARsNdZ1Wb4dZYi0qKdceWnOlpbS6tOwmXb6+EWWSh7EhxqYkwKaj7yboNBuP3IH9V8iFh8ISk9WxP8qNEF13pVuEuFHFzk8mcfjubOHDSNB+PH7j3uGNm/taRGnqnw6W7W2j1oybOmcLdQsY25BeCzSkvuq9BvfhFvQwY18jCc7eP5IHqzR0QqA3OQNLRQWpYM+espbc7zqbmbpWzU8DRpZKXI73YKp2spGj4PMsGrRazbUU5yHVlVjsUFkX4ppITcC7/de7NPV93w9mUc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dc14d3-f17e-4b1c-c547-08ddb7a3a633
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 06:59:25.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nlv6hrIDQzAZoIfMLT3m9nWdinzYLzJMGqufvAm780jhjyLcH/mziKUx/lrKstwuxCjeBIlpoJ+HdRphl/wMWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300057
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1NiBTYWx0ZWRfX1xENtwAI35Br KfGLQo//hqRx7XrTZQzSx84CJM7SFEGOpI7k9x4cVYqLJeiMJPiC2OEJQhvhieki82NYEiPA44o HwM/uTi4N9ouzfFbMW8NJkF69EwZ5GpRJsZNKJyHJ4LK12QIx5ZBKuxnj5P2GrRthLd0nDQJg9c
 fpQBpMUCrzqhqoVHpLoSlOyeRVzOfGf/5PIu3WkkZYCJP05ureHKcYSWoGBmdY+Wovo/1CPkn/U ztedmfAc6pvu7XsdJOU0qnITvS43010uz+UfA2O1iqiVt7DBjFaWvGVrKfSn1WOSPVKEJJ6j/QA PqNTEUOWDbeK4pS1A0K/Tx0Z4K/0EZTWJhpPGufPmLSj6R48V1/x+Go98y6sw68Wd1VxZ3QUlPP
 OmoKrLnW/6evwA2Ow/e7H6OOOnH1IoijiSNRG8g/0NwRlbHo3RHNa3E3X/CSQtXkB1O2N4HZ
X-Proofpoint-ORIG-GUID: M5X1vQmvFv1p-cIpav6PLmSJlNXH782H
X-Proofpoint-GUID: M5X1vQmvFv1p-cIpav6PLmSJlNXH782H
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=686235d1 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=RBP8K4W0Dwo4soqGgK4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Mon, Jun 23, 2025 at 05:26:05PM +0200, David Hildenbrand wrote:
> On 18.06.25 20:08, Zi Yan wrote:
> > On 18 Jun 2025, at 14:04, Zi Yan wrote:
> > 
> > > On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
> > > 
> > > > Let's allow for not clearing a page type before freeing a page to the
> > > > buddy.
> > > > 
> > > > We'll focus on having a type set on the first page of a larger
> > > > allocation only.
> > > > 
> > > > With this change, we can reliably identify typed folios even though
> > > > they might be in the process of getting freed, which will come in handy
> > > > in migration code (at least in the transition phase).
> > > > 
> > > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > > ---
> > > >   mm/page_alloc.c | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 858bc17653af9..44e56d31cfeb1 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
> > > >   			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> > > >   		page->mapping = NULL;
> > > >   	}
> > > > +	if (unlikely(page_has_type(page)))
> > > > +		page->page_type = UINT_MAX;
> > > > +
> > > >   	if (is_check_pages_enabled()) {
> > > >   		if (free_page_is_bad(page))
> > > >   			bad++;
> > > > -- 
> > > > 2.49.0
> > > 
> > > How does this preserve page type? Isn’t page->page_type = UINT_MAX clearing
> > > page_type?
> > 
> > OK, next patch explains it. free_pages_prepare() clears page_type,
> > so that caller does not need to.
> > 
> > I think the message is better to be
> > 
> > mm/page_alloc: clear page_type at page free time
> > 
> > page_type is no longer needed to be cleared before a page is freed, as
> > page free code does that.
> > 
> > With this change, we can reliably identify typed folios even though
> > they might be in the process of getting freed, which will come in handy
> > in migration code (at least in the transition phase).
> 
> 
> I'll change it to
> 
>     mm/page_alloc: let page freeing clear any set page type
>     Currently, any user of page types must clear that type before freeing
>     a page back to the buddy, otherwise we'll run into mapcount related
>     sanity checks (because the page type currently overlays the page
>     mapcount).
>     Let's allow for not clearing the page type by page type users by letting
>     the buddy handle it instead.
>     We'll focus on having a page type set on the first page of a larger
>     allocation only.
>     With this change, we can reliably identify typed folios even though
>     they might be in the process of getting freed, which will come in handy
>     in migration code (at least in the transition phase).

Acked-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

