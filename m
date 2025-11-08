Return-Path: <linux-fsdevel+bounces-67536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE4C4307E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D06D4E637C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C170D23506F;
	Sat,  8 Nov 2025 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OnM5mLJB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LkX6gcNf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC523D28F;
	Sat,  8 Nov 2025 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621844; cv=fail; b=P5fFswXZpW4TJz1xReAUTQPuyDaMzgHL0owZMe27elM3fVivLyMS2oA0WcngTAhmEmdsO6DZ6qrIRew1iEb0eBeFAe+1I46uNFx8azcLFt2KGXe9+ObFqQ+vt5MJNUEk+QwgpyJKmub97NSten7FKwlFaIN1UyY6kVqxox9KvCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621844; c=relaxed/simple;
	bh=wEswhEPB/UrhDyPK9C9sI1IHFlT5+kgMCKmd18ehtZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTSG1PypHSeHWOULNzW/IiVbCLP4FQQ68zzNYnXw5KFG8eiU/x8mPwtDsgP31nvAn4QBWt9e87IZ4+LWTb643lrJ9Lkkdm5tDtTGdW60LFhSUcTJHaQW3O8KMuZ5zsBCu6iYUsomFDgdUJ2aoaUMe0L7XBZG5zH9CUN1ksXzz0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OnM5mLJB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LkX6gcNf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GfF1A008827;
	Sat, 8 Nov 2025 17:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ES+ODnUpx6m2BxJg2i8m0/ywBdmg7etQq70a9R7KC9k=; b=
	OnM5mLJBkADXw8RlxMX7twRcHtpTl+zG1wc6SN4kyUJWzjQKT3q0L6YgNPQ8CYTC
	5PvvWgv6sy/ifF9YcX8j1UP4m6X5eC/0UNkfvxx7G/d/XOaVuCtYJ4GzfiqI8G+I
	nHnaqFoK4WrZ1sD2qpClJsjDGvHmkpCJohQVY8TkzvgM3E4pTcNP0AzaGzno+Pwx
	2a00L6McD8VIiRh26JuCMv2VTzyKbYq1Rop7jus8mrW6/wB2SULi8R/0GsZ19fMM
	ilujjboZZ8PzlfDnceB7NnXMcQ5EMVr1CvTfzV7Yj7iG8O1V+QFdKsddg3UAoFjP
	iOGYO52Oriy/wzARImJ0iw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aa9k8g0j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8FUqDV020358;
	Sat, 8 Nov 2025 17:09:20 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va6pmxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtHwMzWUlOiGCYDT3yPWdtJuUkAxEPzDA+LZYrzhqTh6hRW0Ok0cK+9jh+xqOjYRhH0UgaS6SLlLMfvZewt9iL46HbH9SUDagTskQORqDzGbFUem+NAFvzu2OLXwqE5S2mrjg76D7c2ssrvAXmv1M7AvAVThr8NzLGe4nyv6K+NlRRpy4BYkTS70oftylOChRahDtjY0mxwgoeYxvZ0ideAtNR2yBco31BjGiNMB9Hqj13BzBB4FBbxs4y/saa7nWBeQQyvtXxNhTeaq4nJlzS/xWskM6L8PiE4PIx0D3awvT1gRUi1qUsSx+QKHfAeeIWifHnMnEYmACTsWIdZ6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES+ODnUpx6m2BxJg2i8m0/ywBdmg7etQq70a9R7KC9k=;
 b=eKBCtqwLIEf57PM2pJ8JYRG/KBPy05YAcht8DBk8xJG49gyWPp/Zmne/gfuDCbHjwQ6982Jz3NMxe2AAjvFS1PqjC3RUa87Poj1nfp3rdKt3PwVj2Nzr6qeNg+yA4pFJ1rbJcruleh+1bsm/ZJG81ppYaNs02EUckOKkUD4O27yHbwqPd0l2mZXxQav39cXUORA7PzhIwwM8phDGotbrfpX+6ioIGZA9VT26CqsFxYJKmTLftPB4a6L+MsOsM858ueO9Larzov+P1pGj3bHlYViYMA/xSg0+8HTADV8SvpAhWTuf4OTJeLlMS1xTNYVZj/h/pa13FeT+b7UV7ng2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES+ODnUpx6m2BxJg2i8m0/ywBdmg7etQq70a9R7KC9k=;
 b=LkX6gcNfUA2YOykfjoq8ukOy3qOHQixZ5gDOAL/ObS6+p3F8X/L5durtS6UlpZk51aHjERlv7cMkzrbH76/LRjVY1cbDTibwOvH7Ucjc87zHT0ykUw7V/CYpxj7i+2Oki9GpiZRQ+b4fqoSTaKAPMwvOaec6gHPUTQQ7uo0f6UU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:15 +0000
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
Subject: [PATCH v2 09/16] mm/huge_memory: refactor change_huge_pmd() non-present logic
Date: Sat,  8 Nov 2025 17:08:23 +0000
Message-ID: <faa2f6c652ebf5201292c12b8b05e5a18bf0a16a.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0652.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: 242f6bd5-0ad0-4e5d-2dcc-08de1ee98bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NQ2vAalz9bBOjio0XpIoArxJ7+RHb9fU04aVwX2Cx3IexUQFVz6weBtXuw98?=
 =?us-ascii?Q?d4sn08LHAsZqFzG2n3jUYANt8RyTMLzv3o3F3S3OaLRpjworcMK3ZxO26Wrt?=
 =?us-ascii?Q?IcqFb+5qztTqV8allNbhbN/xujsPqJaQWwot758u37DZiHS56bzHwA7OfYIq?=
 =?us-ascii?Q?jdi6fTNKJ1/f0sUaPo5IDrFZ1Dp6sVVNoOuWWGVq0G8Ol2uaRZcpwJGVZUGt?=
 =?us-ascii?Q?blHrLcRGJ1J/H1eZ9RlRTksP69CrEWM5sq0ZGLL0A1aAvqTQgGvT3bhPn1G1?=
 =?us-ascii?Q?UD1zf2kwaHfWtBRIKfGdyb2bvT1Dw78eoFpHvFKpe5MTvUupHJqCqTeNhwoE?=
 =?us-ascii?Q?9evaljdEOxrPIjfZJNHwfZrv8I/6yv7CkcpVZxIVy/EaAaHkYwpGZuUrIks5?=
 =?us-ascii?Q?RPQi32xs8Ets+Khckm2393c6f+uXypUItNFjXulw0p6F/XZ0sQZrvznVqcrN?=
 =?us-ascii?Q?o7rNh9HYJZaEQKwVHjw3F/Eox0L8D60jjaqwhXvAK3lBc3v/W3v3SzrgJ79T?=
 =?us-ascii?Q?vvOn5uoiJ8UhwIcJL7QODj+/mi5YrK1l4r8fizU2/ZyKcF6EvVfNGCyOpEie?=
 =?us-ascii?Q?ggo6TPNBrrv0R+1Ne3BWzQav0StMYqVaQ2T76E2bzNGdcr21p7jxiQuCCq06?=
 =?us-ascii?Q?FFtSJN6bIGWKA7cbWKu3ggcmQh54Oup8DCzegN2gcNtaCVk7PsDKAe3/yECe?=
 =?us-ascii?Q?DAAM/Hsn1qXcHkf9CJlbPFRzfqT+bzCr5T3nMzZ072F1VEwJM4IhN8OHY0hg?=
 =?us-ascii?Q?YqFKvDa6iWGvDZTleRYV/FXpw/vT/W2MFuq7hu0K5zrMsvoJEa6nXwKZV2ZP?=
 =?us-ascii?Q?+dUsVRXGi8jOwxeklEAuzOHnrsNKkV8/zwDf2PYJlzesrtwVQS/qYRN1Og6d?=
 =?us-ascii?Q?TeIu4vK3bOuuPbOMFtP40yd7PNGndIpRfoa1cG8B/0Rq9Saq9KomyG9AyX9a?=
 =?us-ascii?Q?bIcDV7uAPr6me1vqvsVpqdZMiehWAstek3bG3eaiWYiK/dvlXG0jkL1Ag/X0?=
 =?us-ascii?Q?Zun2P4CIQ1JfVlusI7x9dlF6KqJRsdbkueT6hXt5Fr8rce432gka7He9vhg6?=
 =?us-ascii?Q?hgkDgafCYL0xLEXfRWAdgnxCiCyc15zJ03l56NixTXogIShcXv8boIBE1xSP?=
 =?us-ascii?Q?kAeKGAWMOW4TPn+v0GMvo8FBNRPEqvxdTx2DVgNCv9lHKtCePdP8doplOGDq?=
 =?us-ascii?Q?ckVrE0DoCiJWYyTqUkJQq28wiFIeZgPfsAkvDyMJgMojLkaoPTr8nm30pkNh?=
 =?us-ascii?Q?LDE9B27iKzJXnzY9Gx7VjZkZgr1m8fKG0StARZC8/05k3ABHZ80W6hulkQUg?=
 =?us-ascii?Q?H02hNRlILkw1aKFBNm0FrdoOoGAfQVDr+JCREeiQObhann0LYwmYkgpKxwZw?=
 =?us-ascii?Q?UdX143Rll+sBZOosb1HdhzS1ppsSP5WDO/V67+HLS0WhG4Q6pO+k9mtzNPGQ?=
 =?us-ascii?Q?OANtDH2kXawF8cLcoaT7sQyxCzuszlKp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XJjrJfnEg27XE0U+MYvckQNKlrtQtQXmIrQCijxlMjvPtSueBlJCfu7ahAbu?=
 =?us-ascii?Q?yKY+Il+Lc+nkza26X0aoF8A3DIBaCavpUxmSEiVthm6oaEtLPl72WoOOJAcY?=
 =?us-ascii?Q?Og+RHnZR8ph3d30X5BbVhO968UJxN0c2q5SCqf3ew0okHIq/pCOv5lSHUj6k?=
 =?us-ascii?Q?hj0KduALUJBDUh6AhK/7i6Mj26ku/VrrvB1ES+UzVicvbTAG/ocGCoIpUbVW?=
 =?us-ascii?Q?h0D96DnZbwSB7S7XI3C46VC/nrGdhmlLvEOVnnm69oqRe8eRrMRMg9xfiAFc?=
 =?us-ascii?Q?BZj2yBfZYyE1NyCvmTrK6+b5ITilz/0lZU7pskIkECBOVgZrfdG3A7acs0/T?=
 =?us-ascii?Q?Png5euzBnrrEGxGePcy4BQzX3/FMgPfyNDBKdLBiOkAgmV0r1VJrOxehSHXg?=
 =?us-ascii?Q?cKckD/ii0sfWvgPQpoSMppFc/FqEfN+TuhND3YQJWTncv+FqqtpDO8vihv6B?=
 =?us-ascii?Q?1Ijqx0+FiGbGAZwg5StZNQe8m5hLUP7apiGveEb7mFYkjBWnueJwIF00NF/8?=
 =?us-ascii?Q?mOKH7o2mSC57yZiYLxkxZQxnIJItzy9X7dBqvUedbUdo/qsT4jc9zOvhwtAt?=
 =?us-ascii?Q?aWZHbNFegdnayeKz/6xaozXQXoWD5lbnxzrobthsUfYjcJQwqNaedXrTRtxJ?=
 =?us-ascii?Q?jVKjK56ndqEJmIq3yN8cscmA8bkEfQY3kkV5SvDoWNNCDI19Uaa5lQiFleMe?=
 =?us-ascii?Q?FeHHkBllUPVMSZKtdNpnl09SQdowX/11n7Y3bL8YZJB408UPS7VjWcdBcL+s?=
 =?us-ascii?Q?BMQbLGeMSWjrkKWE/Mv9F0rPgzTMhEITduFpvEsuGuKW5CzOZj4GC1g7D7DU?=
 =?us-ascii?Q?vghM3xyVBSZDus2j//BqHYltPC2fdNoD2GaiMcPwyXWzyP/RGmdglC0ypTXe?=
 =?us-ascii?Q?rBV3t+3mViWVi3Uf1/CF+DKWNn1JKIHM8HJIke4+CkfTYNizoetyu/+XeRD4?=
 =?us-ascii?Q?rthqbezUwHV9yYauOVneo+U1k2gFeHMZ3bzodan5woP+So8qI0RQYrdULgsz?=
 =?us-ascii?Q?Wbnm4rZNx/fBbVYob4sc6ekwF4XgUuSfRZbATEwVjW2wE0bNXl+qbinrgDMh?=
 =?us-ascii?Q?UJ+9ek/yM1YdLs86O6w0Cg7H+yYnPhH0hvXAAWZ2FmAhQMgNVaY3kb0BtPDC?=
 =?us-ascii?Q?OFFsBSlsU11rqhLCbvWckAo7mJKmVz+SJB5s8AoFSMJzWeofKFmPh7wLBrR2?=
 =?us-ascii?Q?PPaRZ2r6kKGB0bq/LEzmYsz6iVAUdosxPAktLPi4QeiSnBWE9j6jeSY2GVqv?=
 =?us-ascii?Q?PV3jnz87/b0X7obFQNVWqeXQeFa5DYZlorZLuvxaXA2ZB2NhcFqGt3njiqZi?=
 =?us-ascii?Q?k25Y8RF/Og4eak0b9UpxTBNNvrTKgaq/G97CY8eQrPl2oLI/0nqrOd0tOZEi?=
 =?us-ascii?Q?3EB0B/sZJbzZnVfhviYNxFKus/BbmohGUIaeKU8blPP2egPDQD38ooW2f2Hn?=
 =?us-ascii?Q?90C4bEi2ovB2WWF8OPlCp7ZN89xC548jBI6qvfky38CeHOjr4Jy9FiUT7fpP?=
 =?us-ascii?Q?0shSwI+UFvQSp5KPMTCcMvFNwyeymy9B6isG+IX+zMHfJ1loR97zYDQpHfDQ?=
 =?us-ascii?Q?sqTnmRorJqn742rgv9gpw9U0ahE/OA38yATBnW9htfD7bOMv7Sb93NRhaIDO?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t66THdOwnKf3Ska6WeV0Zxl05lIKfcOX3StwSi8/nar6MGB7YPRxLDAPCnXDrsy5eUAjFeii/OEw3FOABIUodV0Nq7kK3q8g3S5DTWpIbe1aD+amUYDtDs013F0OMARN4Fp3vJBkMRZkAn0y0vqybfPqCbqPKzZFc9Lx+oXh0wKZKkI97zfULuVetCRTiVacVtcQwB5w94OAB/g/KYgJbseofkuuING+IJBXgVMPqHUPExw18suaEv/EQJlAJxUztED8mNPutkLdaUmjYU2R7ykCrvKuRmqq6ATYQAJUU++iCY+boIxwx90bHeRETpf5Tr30c90NRmrBb+v0x2ZTUltXpJvxpRqIuGSxU/n0nHZHLVLNP8yNSjycEBbNAUb/FK20hGh0K8jqysElJqS7hFDairhItNvrGuvAMV81Cq9dzkgMtuLVNr7ieSzBjCp5k32S5qyWTmch7eIGpO5Q0Yik+NCkZcywQ5ylpK/N3YpvxPm7ZoEsLQD8s5vp7QgkXBubDw3nC35vkEp1kN5Sf1Pg+xhqd8nGXgRDqT3jvkAvp+6H9Eju9uW7mbDGd7IysM6CabpZ+82OqY+DeKj7nYBkYiHIV6ivE4BXuyHtXMA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242f6bd5-0ad0-4e5d-2dcc-08de1ee98bbf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:15.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBl9znN11xDezq5/sK3cIjYlef7vctQCNwgY4AVV9HLC7g1UG8ZoBn+7rQz/eJQ9nD4iy1D/2gMnwlkeiymICOwRJD/W2mhBrDheJRNZFjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDEzNCBTYWx0ZWRfXyt4f+F2U5dc4
 setjwsSoO6I9+ZdCCKEJ+6mFVmT5VdLIIZi4IeSBoBdgkze7OLW3I7Qm38JKiRiRO+K/NxRc1p6
 P/qFT9AWulzhmaDFVspNpT5d4Vqdp6aW573TU9yXqAOdRC5lvoTzoyp7Dh+2o5H5TRxpZbAWS1g
 OsQMGhxZKGFcI+x0aai4/K849vgADQZi6s8MjxITsMuSTA3/S6zQghOBjZPv2xWdt9I0ph2L4Ll
 klh7K3KAPwyJVoGTT0LVXFf5ra13XToERhcZSInRZUQ97/Cx0VeqIgA2/nvgfn5iCrOCmP+xbc1
 mimygRZEz+KGrGlwppu75iLjEYw60wmTYnVVTCayZowKvkR44rCI6dYuH/SUpP4ZMfdaxs5+yR1
 p986iBTtOC3O1FL1qoMXV/hrXrtKhw==
X-Proofpoint-ORIG-GUID: byv2T6MxfRUczHHbX0zqXEgFXZiXvsW1
X-Authority-Analysis: v=2.4 cv=U4ufzOru c=1 sm=1 tr=0 ts=690f7941 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=gAL6uhOEssAPNySJDCYA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-GUID: byv2T6MxfRUczHHbX0zqXEgFXZiXvsW1

Similar to copy_huge_pmd(), there is a large mass of open-coded logic for
the CONFIG_ARCH_ENABLE_THP_MIGRATION non-present entry case that does not
use thp_migration_supported() consistently.

Resolve this by separating out this logic and introduce
change_non_present_huge_pmd().

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 72 ++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 31116d69e289..40a8a2c1e080 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2499,6 +2499,42 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	return false;
 }
 
+static void change_non_present_huge_pmd(struct mm_struct *mm,
+		unsigned long addr, pmd_t *pmd, bool uffd_wp,
+		bool uffd_wp_resolve)
+{
+	swp_entry_t entry = pmd_to_swp_entry(*pmd);
+	struct folio *folio = pfn_swap_entry_folio(entry);
+	pmd_t newpmd;
+
+	VM_WARN_ON(!is_pmd_non_present_folio_entry(*pmd));
+	if (is_writable_migration_entry(entry)) {
+		/*
+		 * A protection check is difficult so
+		 * just be safe and disable write
+		 */
+		if (folio_test_anon(folio))
+			entry = make_readable_exclusive_migration_entry(swp_offset(entry));
+		else
+			entry = make_readable_migration_entry(swp_offset(entry));
+		newpmd = swp_entry_to_pmd(entry);
+		if (pmd_swp_soft_dirty(*pmd))
+			newpmd = pmd_swp_mksoft_dirty(newpmd);
+	} else if (is_writable_device_private_entry(entry)) {
+		entry = make_readable_device_private_entry(swp_offset(entry));
+		newpmd = swp_entry_to_pmd(entry);
+	} else {
+		newpmd = *pmd;
+	}
+
+	if (uffd_wp)
+		newpmd = pmd_swp_mkuffd_wp(newpmd);
+	else if (uffd_wp_resolve)
+		newpmd = pmd_swp_clear_uffd_wp(newpmd);
+	if (!pmd_same(*pmd, newpmd))
+		set_pmd_at(mm, addr, pmd, newpmd);
+}
+
 /*
  * Returns
  *  - 0 if PMD could not be locked
@@ -2527,41 +2563,11 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	if (!ptl)
 		return 0;
 
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-	if (is_swap_pmd(*pmd)) {
-		swp_entry_t entry = pmd_to_swp_entry(*pmd);
-		struct folio *folio = pfn_swap_entry_folio(entry);
-		pmd_t newpmd;
-
-		VM_WARN_ON(!is_pmd_non_present_folio_entry(*pmd));
-		if (is_writable_migration_entry(entry)) {
-			/*
-			 * A protection check is difficult so
-			 * just be safe and disable write
-			 */
-			if (folio_test_anon(folio))
-				entry = make_readable_exclusive_migration_entry(swp_offset(entry));
-			else
-				entry = make_readable_migration_entry(swp_offset(entry));
-			newpmd = swp_entry_to_pmd(entry);
-			if (pmd_swp_soft_dirty(*pmd))
-				newpmd = pmd_swp_mksoft_dirty(newpmd);
-		} else if (is_writable_device_private_entry(entry)) {
-			entry = make_readable_device_private_entry(swp_offset(entry));
-			newpmd = swp_entry_to_pmd(entry);
-		} else {
-			newpmd = *pmd;
-		}
-
-		if (uffd_wp)
-			newpmd = pmd_swp_mkuffd_wp(newpmd);
-		else if (uffd_wp_resolve)
-			newpmd = pmd_swp_clear_uffd_wp(newpmd);
-		if (!pmd_same(*pmd, newpmd))
-			set_pmd_at(mm, addr, pmd, newpmd);
+	if (thp_migration_supported() && is_swap_pmd(*pmd)) {
+		change_non_present_huge_pmd(mm, addr, pmd, uffd_wp,
+					    uffd_wp_resolve);
 		goto unlock;
 	}
-#endif
 
 	if (prot_numa) {
 
-- 
2.51.0


