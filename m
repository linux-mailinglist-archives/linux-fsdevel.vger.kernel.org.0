Return-Path: <linux-fsdevel+bounces-65413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 071FBC04D12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86CF1AA3312
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D4F2F12CE;
	Fri, 24 Oct 2025 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BI1e621t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aKfaQaN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CD2EC08E;
	Fri, 24 Oct 2025 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291840; cv=fail; b=XPahSl/t2Mqn42UmixiQYoktQuPegi0/FsdUkdK2l4ck/vd6xIg0r6vwYtxpYRvJ49MIQ4cRCYdmDiqzb+c8pWJSOVQwY5azuYCWBUIBKfeAl8M1i+h5wpw9BS4k3LMKa7gITdPhUtUnql6MmSyFt/PXE9VaFOcxIgwkx7FPSRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291840; c=relaxed/simple;
	bh=+oWAHpiUVXOfy4HgRSlmVIa4luxFDq4bRLzsKmLrJiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qilD/Hat342Rrt+IIf/FCjnffGg0fIJDgiseyzS4igBpzb8cgfdvPqLWejIfDtsZlp0I5FVqI8YBeG9kaz+DP6dcvgu/15rV0kJCWlll6Xn9ahPWZR9MqoE01pymZagbmcT0YHaCsfy60kRKN45sKVpWrhqzewc6z+UJCNZGcRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BI1e621t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aKfaQaN8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NXd1021319;
	Fri, 24 Oct 2025 07:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6PSEhOi7eZLDMasl8HHg9o2bFL3lohwaoNuT0NlQYTQ=; b=
	BI1e621tctte6/mFTH2e0Z7XDAV9576uGmu/UaMnNERzSsYyLkDK/Hbwdg+T5JTy
	P2NZzedhKwE4QGE76/rtU5qmSMJfm2Uw+5tJCa56aQiJDxpblRlRmO5MvfUphir9
	ZTIh3LncoWdbrUz6Lr4vxafTIZ/Z+qZ9K8DMKXG76CGykfqsPcRLPeKIULZrevyz
	pqENS4esm+lUMtiYQB7++Oq/tGfiVpoHhZwN8hd5/8cA7o8mDwhiLW6LrR0Q6KTp
	6IdnCRXUniOsRCULN11r7DCs+RXBdErVzwHlHWVNUMwU8Dz7FcHhOBV1FT8Qoinv
	UICwm7z91oNRmARIBr6WkQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvcyc5jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O7WQQr035638;
	Fri, 24 Oct 2025 07:41:58 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgm4xq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aoq26NHqCDFWaNWYM/PLsye4YghU+9oeWLRqXk7ErSDg2uFc8pgFb2vax7LEn3KtzbU+QgOkDhN7xolhHWCWSUVAUAXpHcdUx302VkO+1s0APwXwW4k8VI4SXbIbChzj/5P6ZnC8NdRzL8XT6oY1TJsKK8OXPDBTDcaavss0AfAn+NDzQl4WSs5G3+2PdQY/ehP9HtqB6R71j3O0alOnqADt5pAxYsVQjscdN5GpP9evXyTVkeFLxTX/7q0XPaXmIBgzpkybj7VSjD7V6+XXIMVBnYX02E1qP5d9YBf2IZcVKs2m/ZqHDC1/QuONfUJ8Nr+AKiLMGaH3kGOfszr/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PSEhOi7eZLDMasl8HHg9o2bFL3lohwaoNuT0NlQYTQ=;
 b=Q8UIeD8mNjTJMPungWl2qTlATJsDKpvU4sx8EAvOZiU6vbdGqOf2/6X8RS4elTb3/JljjqO7OZENjYRYIycx3kUdInS6Ylmfv4zyHZrq78t2Et6jBUKXyDYjJBhskAGvt5Z4nAFW4mInT+v2A/qWpsqypiQe3sTnJrDeURphDzymZ4Yix+C9d0TBNIf/cDPRt8LD1rzvwGVrN8XBzdqCHOsY3jGj9FJx8Ydkzxk3WdYcG5d61QNhFx0nYGLcDme0mCa+kARgL3Lq5OO8cK4S5v4bkssirpv9jY/hVqkzkDEfo7vpOF8XcWtRDnrZZ2vVJSPB+BtBkfppHPQHPsT2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PSEhOi7eZLDMasl8HHg9o2bFL3lohwaoNuT0NlQYTQ=;
 b=aKfaQaN8AOKj5Cg2YbFKyY0g4DTSUgWGTzDcshsjFtG398GaM+BIdif6BO9bfcMptRFXHvY7LpmF86VWUiEcI+b6EJkSOiOQpoP6tK5LUJeRWPHzy1Iq/dbbe1O3+i7F1iqsJmEgQTA5xkd4Pa1a2nDiMN+m/SJK6h0VSZsps2E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:41:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:41:52 +0000
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
Subject: [RFC PATCH 04/12] mm: use get_pte_swap_entry() in debug pgtable + remove is_swap_pte()
Date: Fri, 24 Oct 2025 08:41:20 +0100
Message-ID: <835fb97062ff69fa5092933549c10cc4c7d539ff.1761288179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0177.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f4c208-0d42-4238-24c3-08de12d0cc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Bazu3trIPinYVDmPRe5LTQzFmD5PxuXYoUjSjMZa3MtXO+FTE+16eDKlKZD?=
 =?us-ascii?Q?vg4FOFkq2RBlwIA/gK4+8kz6Uf0E206LeqMMclqCNfY1EQLGwY4aOdUUfoFQ?=
 =?us-ascii?Q?6336DbbTw+jNpaqbv3W2LRvapF0m6cJtX8JWUSC4/ach534JW8aNBCKOzPAy?=
 =?us-ascii?Q?orln0rRVrci2718cbBSVr3OoiAVmfoRuYlY7IcBef81wLE96Vt3o7iesZSNy?=
 =?us-ascii?Q?yajLNZeR/R3UZ6cPYIyeU6hAhlgo7PkTNUpd7HthEa5hg9/2BurN63/cPbWD?=
 =?us-ascii?Q?Dg4bZqN2MsqhiYwXI+abb3zWisVSjQ0rdGKrQ4EeF6f/ztPwnXqPNC4IL8N/?=
 =?us-ascii?Q?e8WSwN4da9t3zzpLQa9WcJKvJDht4u09kkHu5aZf1x5D+q/HWyd5L1dROvLh?=
 =?us-ascii?Q?ZdUtYFBlYELbS0fFW9NZazeaSYbQLdYVDDEKkYfKTh+1WRAZUs8kBcWWHhq7?=
 =?us-ascii?Q?NzrQr6V5qOR+2ooC9mu03LuJNXP+127KlyCQkmEojKYExjkvvdidHhDCtuSy?=
 =?us-ascii?Q?yft0bhoShdmFLqxVkTz69DlaMeWixBa8Mw/MFgrE1aUj3ii4qQmShw9hkRid?=
 =?us-ascii?Q?feggz1c5N1T2OQVhY6a8a0Z7uslldAWm+oEMlNQKyWNgvpXCsDyYD1r2YQVq?=
 =?us-ascii?Q?Ych58rTLlOfAY6LdsBR9U6PumNbC42uEwRkE3AypbUZswbLRVa8Veof71Av8?=
 =?us-ascii?Q?LPUhKRJYBSYiQb1QIFgvzpd4vSddiakCE0XJAPou6etPtC5LAqwyCwYn8k4B?=
 =?us-ascii?Q?VBkE/JVQvod4PIG/2Kzlg6H/N3s+QNthz6nNFwW9vi8hJIdWrxndLlsOY3gJ?=
 =?us-ascii?Q?uNwsgJUn+RrbrCSOhJHXY4RvYxYfnTcXHrDcwB/qhBdNpMMGPdBkhdvs8LC1?=
 =?us-ascii?Q?+Lh/uXkxCHyGoXyJi8EcL/U4zIbXSaPNG8177h/SXs7lHXjk9itAjpO04D45?=
 =?us-ascii?Q?sBrix6V7nhfuMUOb0Q0GvJkMfkP1eltwjWs1vLwqGPOyq2zvNqMDnzxRbVye?=
 =?us-ascii?Q?x9K/SPVLtL90ACtcJ4tssPkacz6ID8EswzPRW4ilHdCgWlc5xb9jZIeOZAIy?=
 =?us-ascii?Q?tKoWQ5xqtmIG8SzEVviYvwtM/5+QizoA7EyAKGTyWb19OTmuAeeViQ5tWVJr?=
 =?us-ascii?Q?U0vVbooVdsGGrHgkrSMMsV+Yqf0+dxCEDNoC42lYgRpIFwxnv+I40tltiU0R?=
 =?us-ascii?Q?MJJDoyjKbx1Q0JrPzkEHXpJgnSrEn1crbBGLUanF1ywCIXvkULDP9WEF6iXD?=
 =?us-ascii?Q?FlhNy3zoGONioXAM975D2H9NLlHzNke0B34FQPHoxTTG9eTnlXorw79ngNcr?=
 =?us-ascii?Q?7DsxI4u5Y9Hyym9Znut28ASydL+cOX8eMD9ZF2UxibwIpeVvEy1TgFJlIZiU?=
 =?us-ascii?Q?TpzKffM9acy5yxBEup8ZojdAGQa5b392F/axjp6BnL427+4j6dePLHM8167A?=
 =?us-ascii?Q?Zm076n47f1cEF1G3FRbCp0M5JtTYFq3y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EIDDyHyIIl7mKOL+U/Bkb3Q6Q2zxemmlyjb7e1WjWPQtAZR4RQiIa++HzuUs?=
 =?us-ascii?Q?v3fGCoynsgzi9MrF04bpQ6znMHJVj0+8fHfT3Ztrp3grwwLxWQ1JzC1ozP1U?=
 =?us-ascii?Q?VCYDW2euHJUFkt3s+rhuZEbwDcqlXW4nG8WdCoR64bq62G4Ujlc/VFShwJdH?=
 =?us-ascii?Q?4w4CasL9GghzN11LlPI0fyWY79uHLgpGlh6hwGg956vGstz7Awz9ArEMSXgX?=
 =?us-ascii?Q?Bktz8FlkQj8OM6nMxxrr9aiHbySAZrZMtTa2oKPLjP1bPsXUhDGoyM9+yv8M?=
 =?us-ascii?Q?stbXGxLyHes5kKY2D/Ikc0Mk7a1Mfesq8CpYtpeePo69S1FCAJdSMcSiDmJD?=
 =?us-ascii?Q?CStctiFCiQ83qImeMLHdblS6u9/3Feg8a5LMEliIN0dASzGHIXYegYTVvxMV?=
 =?us-ascii?Q?Sr8WYibSviVdL0ak82GhLBOxjYM5pkMkOPrQkks41k4QCDjvGvvlI9AvZJlb?=
 =?us-ascii?Q?mUQwZGwKePCohhYY6FMSKqgvB01/bvZtYhvPcpTbq0cOTqQIsRTRKeqarNkV?=
 =?us-ascii?Q?6efwwl1EsRhS2v3olO+sQIwEwvEHXA0oxB0aMlR1Y8IOaSsZWcDMKtUrnD/V?=
 =?us-ascii?Q?1dJ25zsFGTPXxV5C0c3gBTurT4FvLnPmYDPdCEYY4usnpWhrWIQ2Mt3GQvYh?=
 =?us-ascii?Q?sa5MhXgNGtkULY9AAdxAZQ88dD5vWnk46/IOf/FMPXzplbXvFetC6+EEe6SK?=
 =?us-ascii?Q?1FXVBKSBTpfoMfY8tR2ldlEVIVFYPI+NFRjGrr/02+A0eabMaHbo6R9A8/wu?=
 =?us-ascii?Q?NIkiUh4nNhl9ec3LdlV7ksN2F0QeuhtEBxv5vg11Ev7d+RNJp9pGpyuIvqwc?=
 =?us-ascii?Q?CoCwyD9pSCYQXviYufjD1guMa/mDmPYz8mqRLzBXMLQmLCR6f+1dZkBlYqUy?=
 =?us-ascii?Q?0l/Dh5LnFN94ZqB7LwkgyLTNv2MnsUNiznbTdX9wcLvDGOUJzLJL2BUZpLfg?=
 =?us-ascii?Q?pm+Dzvhfe1dUo9fjnBNNESubRFE+lkygJ7DXQnkSvcaUZV0wDk4fO1wF7AmQ?=
 =?us-ascii?Q?vim9XVMz4YHZe7GYCbfusyDHmTIiLxokYmAsuT4utXBjnXL6S5hkGkuWtDcB?=
 =?us-ascii?Q?vMRsT/afE6c3PVrnG5Mw9gzHgngBIdN3lhuk1h57tP1UMpBWPFQLNHqxVpCj?=
 =?us-ascii?Q?+FR+G7iWgyQ6bTnVgX2zB4ZGqq4B5pN4QE+czQrZCPGVmuvhuSQmMs6A7duK?=
 =?us-ascii?Q?cfI+Ao6LGe9AKBgDLAo3n4TqHt2hjCGeZ08QZDyclNY+OVFmwCooMkrPnkjt?=
 =?us-ascii?Q?26RiE/t4poszJwSMD/wRKoLOgkQiPZqoaIOwQ3Chn/UOQAg/i2mjzGVFSEy1?=
 =?us-ascii?Q?mG8KdlopakIVrBAOhkbjzn2MmP1l0XfYsLW+FQG3CKliZ97DXtCAirRm/wxk?=
 =?us-ascii?Q?ir2BLi/gfzCBde+/qZwg9sir5eKnsyPOrFPovh5c6WX58C66nKiJXJpLbtW/?=
 =?us-ascii?Q?N8IBUortQwU37n08KexMXSYnAPGFjM24ky8c8xPDCkayxB2iL76YwV0G7BEN?=
 =?us-ascii?Q?2ijATbAwsr7p+K83zI+PwYU8kLFK/9lifw2I5r7LPlkfKX/iFREebqg0Yek1?=
 =?us-ascii?Q?p8oQNHzStdC61F1785g1zj8hPW/m8/aOYAUDXS6WqtjemSuB3zHmoVz/zBs3?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fWnBTL2bP5M31Kkq81q607Ertf8xR3Ba4ByS3bsPbtysn+YA6Qmd3Q//E3+ZMr9fpKTcUQEjLEMUXn2ABUFu7LW07cpSHQeXJKTawcQdyk7S4hig8m4f2MIqw7D7hDomq1rPE7YRG2+aSH6CvN53pORNS++yJuf2AL1JohDHPAgIFCVLMWc5lcNF23bmgBBXDlelSK9jvCzD6of4T3kzDmJptxvcVWLypV4n8QSBsVVXCpCIfitYtw9NqfFvl29FW6zqNGoqAxNcoy6GHSq5LAAjiefgKE2+OMWUa3OLE8iNIr/NEDi6EHxr40l38LyBu8IwPBG+6s41ihx1W5y0YrQet5c9LPfTU/5Ispl3tGHXsViXo5yn0gIWpgNg9FtiC6ZasdJ2mc6QHENiqzDRNTbFH5VCDNJFsvSIPk71rcPtHFXo7xug3kQsPYkGByalv/CBSkUNVz98N7kshMNaeX2lpp3dRwhvPj3QPKvU5myKID9/Q7sAgHlicTamgfOJDIkCpHV/nElvTi49L9muQiAA479T/mzH7AhUu3ytNwGle5qp4wEdjiPxS5hv8VUzbVi7i9Qeu6ZQWq1VClv0C6ZTxguNNLjlO8V62LJwpSA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f4c208-0d42-4238-24c3-08de12d0cc39
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:41:52.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiCll/lzdx+aMgvWEsDn0UXg6WabXW8I9xhYcg5GICfFKzAzbyIqvqCtUvU+CDoy5wy4WxFZj0Gk40N1+wjt3Hk7LiMlGAUmNCRUQ2hYDhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240066
X-Authority-Analysis: v=2.4 cv=GqlPO01C c=1 sm=1 tr=0 ts=68fb2dc8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=6AwdJQH9h9PE9E3eZvYA:9 cc=ntf awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX7oy9gVABop61
 9LFeymCnm1cHl86rPRfRxjdQH3nsxTSFeHGFLzG0wDC5lsOl6uTpgsjxq/l0zMfD1uhSufyAya+
 6uD+TdKuk0jIxNo5gzKxtI8SY/lIbw9HnvW1txOWIkeMBDkA66DIumcQscXqsLhLZG+i9lpx1ux
 3cG6Fb9pqUw7UNQApXT+rCsV9186qZtBbdpgys6tHRGyo2z2ufSH0vcdlM7nqhto9MqQ+fHeZei
 c73su37WanuGyaSY5KAPwr50RsP4tZ+hZI06XrQDBPZ7sLSkW6PrRwvdbn16Lh3ssfKR96iah7P
 ALyBKpffTBpSX8MJF1RRSQdX9s0r7DkdU84kZWOG6rM4jQl1xr6CQG9XBQZABYUg2kpFHr4PAH9
 bwPxuqX4XpgJEazS5PA1peGCgxavGrsRik5B1oHAWQR9w0jDjZw=
X-Proofpoint-GUID: zREnyNvqJlg_GkEM-LzfX0gUS4zhZJCZ
X-Proofpoint-ORIG-GUID: zREnyNvqJlg_GkEM-LzfX0gUS4zhZJCZ

Replace invocations of is_swap_pte() with get_pte_swap_entry() in
mm/debug_vm_pgtable.c.

We update the test code to use a 'true' swap entry throughout so we are
guaranteed this is not a non-swap entry, so all asserts continue to operate
correctly.

With this change in place, we no longer use is_swap_pte() anywhere, so
remove it.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/swapops.h |  6 ------
 mm/debug_vm_pgtable.c   | 18 +++++++++---------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index a557b0e7f05c..728e27e834be 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -120,12 +120,6 @@ static inline unsigned long swp_offset_pfn(swp_entry_t entry)
 	return swp_offset(entry) & SWP_PFN_MASK;
 }
 
-/* check whether a pte points to a swap entry */
-static inline int is_swap_pte(pte_t pte)
-{
-	return !pte_none(pte) && !pte_present(pte);
-}
-
 /*
  * Convert the arch-dependent pte representation of a swp_entry_t into an
  * arch-independent swp_entry_t.
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 830107b6dd08..d4b2835569ce 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -701,13 +701,14 @@ static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
 static void __init pte_swap_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pte_t pte;
+	swp_entry_t entry;
 
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
 
 	pr_debug("Validating PTE swap soft dirty\n");
 	pte = swp_entry_to_pte(args->swp_entry);
-	WARN_ON(!is_swap_pte(pte));
+	WARN_ON(!get_pte_swap_entry(pte, &entry));
 
 	WARN_ON(!pte_swp_soft_dirty(pte_swp_mksoft_dirty(pte)));
 	WARN_ON(pte_swp_soft_dirty(pte_swp_clear_soft_dirty(pte)));
@@ -763,20 +764,18 @@ static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
 
 	pte = swp_entry_to_pte(entry);
 	WARN_ON(pte_swp_exclusive(pte));
-	WARN_ON(!is_swap_pte(pte));
-	entry2 = pte_to_swp_entry(pte);
+	WARN_ON(!get_pte_swap_entry(pte, &entry2));
 	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
 
 	pte = pte_swp_mkexclusive(pte);
 	WARN_ON(!pte_swp_exclusive(pte));
-	WARN_ON(!is_swap_pte(pte));
+	WARN_ON(!get_pte_swap_entry(pte, &entry2));
 	WARN_ON(pte_swp_soft_dirty(pte));
-	entry2 = pte_to_swp_entry(pte);
 	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
 
 	pte = pte_swp_clear_exclusive(pte);
 	WARN_ON(pte_swp_exclusive(pte));
-	WARN_ON(!is_swap_pte(pte));
+	WARN_ON(!get_pte_swap_entry(pte, &entry2));
 	entry2 = pte_to_swp_entry(pte);
 	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
 }
@@ -784,11 +783,12 @@ static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
 static void __init pte_swap_tests(struct pgtable_debug_args *args)
 {
 	swp_entry_t arch_entry;
+	swp_entry_t entry;
 	pte_t pte1, pte2;
 
 	pr_debug("Validating PTE swap\n");
 	pte1 = swp_entry_to_pte(args->swp_entry);
-	WARN_ON(!is_swap_pte(pte1));
+	WARN_ON(!get_pte_swap_entry(pte1, &entry));
 
 	arch_entry = __pte_to_swp_entry(pte1);
 	pte2 = __swp_entry_to_pte(arch_entry);
@@ -1205,8 +1205,8 @@ static int __init init_args(struct pgtable_debug_args *args)
 
 	/* See generic_max_swapfile_size(): probe the maximum offset */
 	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
-	/* Create a swp entry with all possible bits set */
-	args->swp_entry = swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1, max_swap_offset);
+	/* Create a swp entry with all possible bits set while still being swap. */
+	args->swp_entry = swp_entry(MAX_SWAPFILES - 1, max_swap_offset);
 
 	/*
 	 * Allocate (huge) pages because some of the tests need to access
-- 
2.51.0


