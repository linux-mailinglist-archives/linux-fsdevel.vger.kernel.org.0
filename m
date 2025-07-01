Return-Path: <linux-fsdevel+bounces-53473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397B2AEF60A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F4B17C0BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A6271450;
	Tue,  1 Jul 2025 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UXPHlKIB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hQXzgGiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EC23185E;
	Tue,  1 Jul 2025 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367906; cv=fail; b=OlL6R8ipVFUzBPV2716m89/QeciV9AynqBbnpraKc7IEAlpzDDQgVBTtXUzWNBvUFkYRFA4tBGUaKUUK4j/40y5oEgjAIs0N2IXIW1VEmO1IA0XP7pqWNoo3NVzsG8IhqPMN81wnDfDOIvNsAf6CYViRP7xG7lBySX9Ds7QkqYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367906; c=relaxed/simple;
	bh=MKSr9ZIMDUWYsxZan/MMazAV4E6qhg8dVJAJstzx+M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JIWP96EwIPcRoyJ+KF+jwKhlKpnHknRzR9i9Q997JGVshdfmiTfTaYVNexlIIQsNDmxsGeDepEPCK3Oo2YNNQevu2moK9cO0n5OGdoQWndgua61urlS3DOd9d63eLbt9hEOtH0pl96hWvwkPUx+52iue3CHJwGBwOdoIoa5MLjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UXPHlKIB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hQXzgGiJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611Mulm012619;
	Tue, 1 Jul 2025 11:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=n+UuwJy2nwLKv6wJQa
	YXeDf/fMTKMPsHH7vstDNUWJ0=; b=UXPHlKIBOh/qFWSdxBUSqAO6yI7Xco08XH
	4gjJ1CXMDxJAkvYU8VrjCymYNSpUhLXpSWCZHrH88beFXy5xw3so6A04f764ZAl5
	+AyyCNdCu9sMIRiwdSOJuMtIu2Lce5o3na1/GwxfbO333nevzq0Wv40p9sCKxnyW
	9UQsVZMcZDxPjqoFETSuc0RevNDn5WjgOT+JOa/vrPv7QztLv06b7X1ooo/5ECGW
	xLVaiAyRoBFD3Dqavq09owr1w/EBkj7R8yX7HjBVKtf7+4HsKH1oG0TsgN/ABF11
	AR6fPPt831IGGqNFoB2LC/TtcASUmfu1kIMZeTavXTDJBEreAlog==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfcgu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 11:03:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5619XiFU011487;
	Tue, 1 Jul 2025 11:03:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9btfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 11:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2XuZFhW2Si9cgz0n3dBCiTnY4dBob8QxzMuDE8ImRt2o5S9Cqc6j1HfE2QUtQot0h7ckuD/gDUtoaVBPRz0HCH+UcYV8mSgmtHp43VtTDENW31zzP4xxTt3FXIquDTODTNrv0OxI9qWXLNIIA81TPqe+EISM4ftX8G9vfrKioXmtR0S0bfVWURxjiMB0ToiaPUbw1pqlsGPUxgZkUtYMbkm2J4gqcIigU/cBHBqCQs5PVoSQCbp9cUdEY3KpjBNzmv0o392SQfn6h1XqbmHP2MW76DXgOtBFkv/wFa3KZQ1zYDLodbck1qqI78xp3wc8Smk6n3KXnhWPJMuc1n+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+UuwJy2nwLKv6wJQaYXeDf/fMTKMPsHH7vstDNUWJ0=;
 b=kMmIqtGtcjx8O3TtlXdJuRMsQapv4G3BL3JPodJp4PeXM4I5Q2X17qx777fO6Q+93l0AnhgRrQxubPw1dwYD8I0w6+FClIYj9H7Yo3aJ2r+EKXFYX1jgjpX6m7/6+VJhezeuh9/JimJ91E7RoHd7Gh/v04jY0gq9kpMkKkFHJlBYkUwAKQ4tjxOlqkZYTVFJiGnIcUUuFsdcJlJ7ByIM/91VHziXaOjlGL9eYM6CHAX+ft5uq+uUTG1QbiGTTRGAX4Zis8hJhS3qknQsM4m93lBYxJzLKxlnpcA/SdmCsFv78A0Lk1ekc6nT2t3Z/DT6y77Hdz9maM64KMd9imVlQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+UuwJy2nwLKv6wJQaYXeDf/fMTKMPsHH7vstDNUWJ0=;
 b=hQXzgGiJ4Iz3ZuK+H8O0zmM9zOqB+571C3i5rzeYPXivpcMLC7m7sg+qEBsSWCNvzvpZrWLOoqOfk1zr3r3cBmNMTfDeejb67e1HHywn9FkAw1OHRJ9plVGRHEXqw2X49e/RZ2R1xWvub/KtCefHUbgZ0IV3t+djnNJKh/U/xdI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 11:03:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 11:03:30 +0000
Date: Tue, 1 Jul 2025 12:03:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
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
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 17/29] mm/page_isolation: drop __folio_test_movable()
 check for large folios
Message-ID: <58b36226-59ff-4d8b-a1f3-71170b42b795@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-18-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-18-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0309.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: b1262766-4266-4ff5-af46-08ddb88eea09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZSHEQJvz2TRLcvWqim1T1SHCl+qTQPQiRxqRP1gdmfrxH/z3yIIxWvaVkr45?=
 =?us-ascii?Q?MaDz64CKyx0k4SizjAUduAh85S83LIs5GRKKVMDJ22Rk6iNEC1zay8f7rr1C?=
 =?us-ascii?Q?dpAt7Ypeipf/UugdxRtvoiLrCX/RacCD0soMFzoelA9eOYzqcdEpyTma5qMw?=
 =?us-ascii?Q?VTJk7KFCU5rz+2n27lu19lrH+xs912S3xVJmkfB108GzrvmTbgoKj7o/3nkc?=
 =?us-ascii?Q?XDVb3lp2nf3j0H3XrdEHhrJpRWfhU3Cs9VBh0LsicG7mERk5hr8T4pZmlPx2?=
 =?us-ascii?Q?FImu/YFHiluB+K03FmgtKhV5JeTT/gwQL6Sva/j+zb7sKh9F6KpJW9RjFRGw?=
 =?us-ascii?Q?yXx/cQPWLswbFub+NHADQBpEy/Ck/OzAFHo6v9T7auiE8A7d+pxJDhn7855H?=
 =?us-ascii?Q?zRsfBweZ5DPfGWzZfeTs647NRuq50CrG4bYGtipDCofzrY4lHXwyy5GCdRvX?=
 =?us-ascii?Q?fY1VkMtin66cJTMLTAetXDYrR8dGoEdFNF5eEBoFqmYPCqfGRX0HcItDcMjg?=
 =?us-ascii?Q?GSebAeeGTRHDtOVK3Rs9UsHgyCllHdjR+7gkQAfpnWGqsxtDFiArJU6KtNAq?=
 =?us-ascii?Q?Q1fg3VyHnG9nixSLuJbZqZggAY6LXiZD9Hg6fR6M5t0RRkcPCN27iQyCJ551?=
 =?us-ascii?Q?Vbl5fQNJBWckNFw6K+Qac/mWNtK6QJBq8iGUKH/fU3H+nPGbJxeW8P9TUGBd?=
 =?us-ascii?Q?ApDvNVD30+vUilZXjW3McafdnE1Mj+h5fSHJ8uMkKKzyKI4ietoZatCOFeK2?=
 =?us-ascii?Q?cL5LTUONfwE4WciSn4i7KEo+5GWsGIeaWBpDWjyF+/oeECiEQYrWtLviXtVy?=
 =?us-ascii?Q?zIQdNiOwueVczNsrqEX+tbkw4NOtyAxlfLyIyd2cHCmOj6bOYp0rS8WPVPl0?=
 =?us-ascii?Q?cNZYvYVPYlciZY3uXUwtHP1Gxmigsm6plx92viwmbIH1WAUg9XLjSPcedmU8?=
 =?us-ascii?Q?yb9ylvtPUOmcrzvREgvYApnXM0TV2GjYb/55F2rf5T40DthWQWcvSTQmqBhE?=
 =?us-ascii?Q?FrAq8mPi4nPVCQK8bBFplHXY/B0PNA40RFUX8PnmWfbK1l3pSrcxSMVEgwim?=
 =?us-ascii?Q?1xMzK1S+cpbk8YdaV+yyrhWuE9e+3+38CNtmxlYOWKX6LBQmRU6x+zkAP9uV?=
 =?us-ascii?Q?yuVQTk7oQw65p1WH4uONx6NutPfFH023zLI1rRkhm1We7rjjwxKtjgNW1fkI?=
 =?us-ascii?Q?m0d13zwaRwUR080A3pqLZUAmXfHnPvEJiPZoYt0iAMkCgHy023ErVwhT1OMx?=
 =?us-ascii?Q?2ifea7/YxhYv9ONmJpWWAJYg5RkF4DmAYoh83XUKMlSwKMM2n/adX7rzI6m2?=
 =?us-ascii?Q?K8bA4HxR2tqLWtxK9yvJW+3m8EkvOtS0PMgAuAP+6Ok7T/i5EpQF7Jhb6LUc?=
 =?us-ascii?Q?h5NDyVTDt6mqq0kARV3R8oMb3PiIFa7psY1c91RUf5BB83I17P9czMj64FhS?=
 =?us-ascii?Q?uqBO5dwtNhc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KNj19yIta1SjkdM8ai4WXH6DTG231D1u9P06WzsbVR/W+gBaZk2o6rwzTP7s?=
 =?us-ascii?Q?COFCmTV9bz4kF+3JQrZzIQsstaXEA0JMVAkB+uL9lZ4bqf+nyyV4VxYfcOg5?=
 =?us-ascii?Q?G+Tq3YDWhDcgeUfpAAXySYqsOaQ9pMF0SO5oBGw8r43bSyS921D4YTRu5nY3?=
 =?us-ascii?Q?0uj9d+ffVCWsJ3X66FNytJmIA+TumQ8hQ8XulTUrukJZitTF6IEd7lJi3v0h?=
 =?us-ascii?Q?IHNXbFs+iIhqySwKibEmbBfPDoUQEmgXZkCfMcJp0u7m5D1vHq6+0k0/erHJ?=
 =?us-ascii?Q?UoFj9ZGjMwG9VsxTaLjlsv4xwSOy8a/zoG1h+MIdPGdzpdRVB00PyN2jWL5j?=
 =?us-ascii?Q?mxQIm1dKUbYJ93rLSCE/E5/paxeAYa3r3LJ7I7XonFH6sk2Zrt2OwM4kbRAC?=
 =?us-ascii?Q?kQ2HLi8I2wqlRYwW98CbbZLtgxdJQ9gP2Cmt85erz1ZUQQzZyiRLBTVeSBx2?=
 =?us-ascii?Q?NtRwqvKtqq9bi0hNoduC2zgSajHUv2W2AWR0uatE0oPxz6BN8E1eMiBJKWTe?=
 =?us-ascii?Q?RXFmTCo9NmIWQsa+Zgsqg0FmZbvHiiJVK368X4FAbHBnMpiK+drHCKj+D3k5?=
 =?us-ascii?Q?Uj5++eeqgu+b1Hub4OQkDMI26mp7snlPe+/dtUr8ENp63ymOMwecm1X2GxfZ?=
 =?us-ascii?Q?8NLLRI6N0JwCZ5fpJGIFClL8M15pxxzN1fHn+viGhPUKkCzE3S6gwGdpFRgj?=
 =?us-ascii?Q?n6nhIM3ZQOGLdRiYA3Pc9d4/hqcLSyNcnAJWWVUMDNOSwf1wcHNitWpQ6ndB?=
 =?us-ascii?Q?rW7PDQeMZ9oOCqMm+4xuzH6q65eR4ZhyL3nmOKQWHxgpujHQgeqSJbwJ3G4Q?=
 =?us-ascii?Q?cT+pLaQ+IQ0oeFBZpZKfEiu56d+wMzva4dm1UWbxgiLszUAQZ3eWuenZ/m/z?=
 =?us-ascii?Q?lCX0Cn+gU/x68YAFzWtzyZOgOmg2R32h3m4kCD/9tdEOZo66zsVk2T6lABQn?=
 =?us-ascii?Q?RAw5RkvtRp+wEp4pIdNbS2vFwcsT2yqxbFTsc3b9XClMnEDUYRLtk85zeicD?=
 =?us-ascii?Q?ufppjQ8geTR2MFSsuPor1BZfjbTRL0PqDiQmOIUVNxVJlssOfOhoBqfJlrNo?=
 =?us-ascii?Q?4UsyxoyT3ljzE9zcFYhNgfKXOX8RZ1oxDbgXHeR4lhd62u0ncgudYUe1QruH?=
 =?us-ascii?Q?8UPuYkK6/rQwD3Vc+MQBRkGucQv/6gJCAwDmBh9wU6B5AH5J1mqYoteUikWk?=
 =?us-ascii?Q?RLI/3J/K7Yz2iTdTx/dQMZHcEOYcZaqk1GPAvmcsn2XjDLEx23Fv/q8KzOMF?=
 =?us-ascii?Q?Skx4DAO/vVN8u8GAFg5RW79KMwTzv8Cg5YjS/zmjC0wHsX0Hd9v7x5he0msU?=
 =?us-ascii?Q?0zwGSFsEh4ctfEXRLRl4c6P+/lLwCO1YMW2hrEOJveavypOUpL+R4aI7DreW?=
 =?us-ascii?Q?YSo5qx3VpAx+OEJXQQqmtae0d0mimus1Qy8egkJXAA/Tm08hTCpJ8ZvLG7WQ?=
 =?us-ascii?Q?fw/gmdJmFWQoUsDknQE3wKu6PqZfDUbDFXD0mdd4XFEX8uCOd0QXvjUN29dM?=
 =?us-ascii?Q?OKi/4Xgd4lGv+Ml294S7WltH4zif272WmWJlDS7MymaOex+J+qlXZNgK+8mZ?=
 =?us-ascii?Q?7VcKWpiKbI5G5hKTsyfhhutWk3DmG46h/YrfYXEsNNJtz/BUcaK8xp9GvZ63?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7OKmcjNk+pLdbcpza2Q+GtgUE5hUhfzXkZ+/BcUBdJ8nHhDeR7g7Q+xJ0GTh202Oi8Qs/GJV6slIyXBZnzEfXknVRTqVKkpEqYwc2vmkxOJOUIHJuHECglrHrFsvtJL660cr5EmI97psRdxDPfdtYngGXIyR88MM7hoK9CvTsA3rXFeTu5hILg8VmV4bmasGTeIVZB8K+HoPaQIpxPdTahWwgFNhHSpYnu6qEh4wqNeaOnnOa1ABJh+x4aLKuEdxHNZOqIXauKTPFEwpmjG2c1ITi/ezjYPiBJeq7ux1P4jGrdJHDiT8Up4yXIY01ePxkTjXJCk65g4/737zXPRLnJWrXc9+MjRlfX5Y6K+1gSPkT+5fQW2JwZrBZtwcALa0jgIA2R6994fiRtLZmyTEUfqsesVAGUcXwPtP4xWF1ofKhX/gmVscMNWGsNE0n53h5koIUOeMN8NfhUPdjKIpthrtzX3C7LQRd+j8ftVDwtCIc6jLNKotZ/SK5kpAooV4KFLfxb2mvgnMHgBrFEZxAEvQ8f6XwJXMEEmhqFGbzUTthxZ8j7cyWa09BM6KaROz0WLnKRAI/0HJ5CCDVXQCybJfOBwSEExrevmzFg/OHXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1262766-4266-4ff5-af46-08ddb88eea09
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 11:03:30.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA3Q706SkMZjFVAFNwmmxJWZ2pqkSYeNBxrT+OBKZu1tlFY41GsjQMZh7fS12pkM/PZgZCqIY21qVjjgbgY7biDABVFgUsqhSXNIfthPTl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010067
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6863c08c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=lSS7JiqdiDly39mhEWcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: mkNk4q2Jgav9rNm4ed7FldtVL9pdx8oM
X-Proofpoint-ORIG-GUID: mkNk4q2Jgav9rNm4ed7FldtVL9pdx8oM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2NiBTYWx0ZWRfX7TcXQr38VlNO 12z4i2zTKFM5nC78hdq3R6UhcClyCI9zqj8XPDpVMuMolgNEx3dN1uRXgPtpX6wj/dFA9YmpKQa QWDwZRTy9W1h3C/RLdo8BPxOfhIm1WiZu2IzXofBkzABg1jyZvAcIQEhWQn28v2HaRn+QJxdMNW
 6Ew2e62H5Io9aeVDYU1wM/o9U2yvbGoudt7adgMUNyLpfOAfkVi5zFCYjvCK8lFej52VxBYaMJ4 Gv4O+hrGPrpeIYXWNOHXrpDqP4neP5ApQTTAEKX9qEuDyiFLOmsv7BaLpn97lyMLFg2MvQGCSqV gsLwXwmQfIb5yVu8BV+nbf6iz3pyi6spEAYE+HHc/UJabu+1kg0NchVQDCHAFEcIFRH7JbwyEDz
 gHFHHJarss86gjBxL/d4Sj3N7KKm60BjwIBmrALIUQBCpyr3BxMEFnW9M669lwmsLEWlzDE6

On Mon, Jun 30, 2025 at 02:59:58PM +0200, David Hildenbrand wrote:
> Currently, we only support migration of individual movable_ops pages, so
> we can not run into that.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Seems sensible, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Maybe worth adding a VM_WARN_ON_ONCE() just in case? Or do you think not worth it?

> ---
>  mm/page_isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b97b965b3ed01..f72b6cd38b958 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -92,7 +92,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
>  				h = size_to_hstate(folio_size(folio));
>  				if (h && !hugepage_migration_supported(h))
>  					return page;
> -			} else if (!folio_test_lru(folio) && !__folio_test_movable(folio)) {
> +			} else if (!folio_test_lru(folio)) {
>  				return page;
>  			}
>
> --
> 2.49.0
>

