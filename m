Return-Path: <linux-fsdevel+bounces-66362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0861AC1CF48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 20:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54B504E3675
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBC13563FE;
	Wed, 29 Oct 2025 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZJmIdAvg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vT+o5IzL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06637A3C7;
	Wed, 29 Oct 2025 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765060; cv=fail; b=H7apon/93DYNv0N65Qcb7Ef3EazWrQnEHlR+/BeQH6IQRMDkTc1lqi9cVipyHHj7y4Ab0QJcVvSHf5JjTewxjvIhveR5iTZiVJ39I3MujZTcYjR1OTocSDkxYpj0TB1/+uLZYoiu2kk1HJtlefeFW3x0l0EDgdEB9RB7nt5Au2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765060; c=relaxed/simple;
	bh=LYOFgedrfVchF+U+FyyhdLjsg2aUs1znj882vlxs4pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q1WuezKzXxd4HMins0QuHVeQuw2ttURl2GuJpkmkZvq0aHlGHbtnuKFRSJdpKLmqFkHJMhC/Uq9nBIacIOy+CG5gNIXB2THQEc/rguGj7NSGm3s1Yp+suVjaGrzbUc09NhK2fgLmzhqAWf12UmXWc4q3d3xka3RowiMxuGY+Q7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZJmIdAvg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vT+o5IzL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TIpLtP022639;
	Wed, 29 Oct 2025 19:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9YCdbBT4C3x48lHxxP
	GMs4vmB6W3ENZ5gRo0YStsGdY=; b=ZJmIdAvgjvidUUyOodLUNJWqYSLHHUittw
	C8Mffwq07A4Zol2B8/shTS9HFIZDbs4a1dNSQezQr4QdtjXbz4piYdwI7xlokYV1
	f4sNcWvJmEJ9CcbZvldYjKDURrFe8kqb3IOmCK4YWxahSSSLdl4RLfzPojDiY6G7
	fNIPM3GusjakYw2CvFna5gIOPXETPhPLnlaN7XAYLxm1cpr8fzX9NMAorC1JrA4/
	h3X26RY6zWqpY+xF890hJipTNvU8fooUP1DcwiPyzdLt2BGIooJUeMIa8m7hEYU2
	JZzmpZMfqY2hUMjJsLUK39HMTnEg8BC6lG2pArX40QmEFO27DiGQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3bgkt0q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 19:10:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59THTb2S015899;
	Wed, 29 Oct 2025 19:10:07 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34q839yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 19:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiRJQzz4sdh79YIc6RQdB1srY49H8h3mVrXx47ER5+FmbTZ9FPzNnPck3lsx0oPyLwE4/b+ZFwZzYZNwZbu8JJt5bEJomsrOksdjcsi0xWYWz21eoBPk25DAtll7kjUIH2K6s3vwPsK2F9a7GuvhfCOpW+BNOte6RRutPq/BEM7+g+IHVWyafgnpBX36yNxk1qm6Io5vn4mnElz+49HvoAlHiQbZRKsuTxlPIVcWs2om/6dbjTlN4bA+AkY38W+7qYBCnebnEM5cy3xuJFNueVjK+T+V8xgFaH18eymzt1XlTyAZ0u59GU8OWzVkw6lXwsdbp7VyPaKuWv+M5ZIFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YCdbBT4C3x48lHxxPGMs4vmB6W3ENZ5gRo0YStsGdY=;
 b=tNL/IK8jQxB5++DU2Totk5LFTxbDRVMV371UTqCL6LT0bF2nY0SmEZponJuywQDpbPuHJGG0YO+RGy0Lw7v1KCdGZh8XWOALCZ+Wa8yJ1gSDIhRbJuIqTyzO9ohuxiJPqLD0e6xCrZjt8TM/hUN34tfN5TWHmg9bMYSDsVR1PvSLdl7W9ZuYs/SC4TGGAtQ+eILiiMNgn8HMDYqobXrSJjQMDyiO5xpIfjZlBOn92qcwvHkk/67gPGF2MPkD+W0x+RE07ddIz0BGXuJGl4BIicjZEbo2VV6T0q8BPzEfimyKXiKuF5K4TKp8s7tYZwyTIJVN/uXdRnp6gSNENZpR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YCdbBT4C3x48lHxxPGMs4vmB6W3ENZ5gRo0YStsGdY=;
 b=vT+o5IzLt4g8pnwEDOU6eN+R8YdNfVveeSgmYq1wgL0x6E5R1g38fu7vl7TOdMfZK5oRUsmCakl0bdaV/4FflkGeprWw8S1HEyfsRcnGnfKlpE9dj6VyRRHTWZk8gO1BsVEZ4F172Fs/XLkx3ez03FSfoGGxFL9SML9/Dk8As5U=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB5918.namprd10.prod.outlook.com (2603:10b6:8:ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Wed, 29 Oct 2025 19:10:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 19:10:01 +0000
Date: Wed, 29 Oct 2025 19:09:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap
 confusion
Message-ID: <4fd565b5-1540-40bc-9cbb-29724f93a4d2@lucifer.local>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <20251027160923.GF760669@ziepe.ca>
 <8d4da271-472b-4a32-9e51-3ff4d8c2e232@lucifer.local>
 <20251028124817.GH760669@ziepe.ca>
 <ce71f42f-e80d-4bae-9b8d-d09fe8bd1527@lucifer.local>
 <20251029141048.GN760669@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029141048.GN760669@ziepe.ca>
X-ClientProxiedBy: LO4P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b218c49-ee11-4898-3c71-08de171ec2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9oDRlUaOZEY8iYgond0KWjyi64gwZ+QSo+xhtV2FbJCs9VSgIdkHVeblODUA?=
 =?us-ascii?Q?bpihgOLJrkAFLm+BL413ajaWIn19d3cS/l6+yeBVdmXcrRaqiJE6FqOAkw2z?=
 =?us-ascii?Q?EDJgnR6Fp9uX+LNqQcH/6qCBUn3Qs9ciwppOzSg1vJo/7KR/PAXqEI1oyay6?=
 =?us-ascii?Q?0eDADAo6sxv9Euxi0YFbhRKb1MnsmUajD1YDW/72zqa8Sw7PU9C8VpdWrk4X?=
 =?us-ascii?Q?J5Pw4W5ZeMCxH8welGnIuKH0wu1L8RUo1xsj+UUt7OXqEU9jHJu3/xLTiwHg?=
 =?us-ascii?Q?6XsCKoFKvmNHWNxo1zXdYYbR/KpH5nXj1oVE3AeSD8LRD95R4gVqzHLUpVw7?=
 =?us-ascii?Q?OdPPArIDMVjml+5bsN256vNQy85y4IhyqVaKR12d8HY3HUq5o9qkG0jspej9?=
 =?us-ascii?Q?7j5AeyBKkumbeRSDo9ZjyLFHXg5GsMrbyWXcutmwK9itafzkCicGAmdKswPX?=
 =?us-ascii?Q?EgU3n2fw5oeeAUw5qiVAimguylekxJ9bQAaqFh6tfpzFIJ20hv8s1BHQYowB?=
 =?us-ascii?Q?IhOINAfuTlt8E7WACSr1xTwN9/H+A+QDrq7DMMC5pxpGm93UiU5kyNEj+COh?=
 =?us-ascii?Q?rM8XudPxqFp1vyFgwDO0Cxfi+vJ7nK52i0w8WRjnF5OKwFHL6V20TuxfHOdO?=
 =?us-ascii?Q?+wHEG5X5jG1ekN70OQth+ZmNnmBr8+m04yyf4FYY76I38Bx9mh1/wheamT63?=
 =?us-ascii?Q?6A3wVdX8xI7P2v6jIaTtK4ZFDbARwstarJbeOvHgVPjx3aEt7gqtl8fOmN7+?=
 =?us-ascii?Q?T43CLjbJKUa2un+J9iwaCmsoUruZg2AAfA10rno9PgqnkZ3nl5Cu/w3Yrvdw?=
 =?us-ascii?Q?QfF7lG3lrV2q2k7DFkyWkCaVjVSZfyr0krj464IfhQx8OUz/Ak9alf4QKLrf?=
 =?us-ascii?Q?Xhd9bp6wMAPTbzuE4TB7MzI6Us5rgjhpczqbL7dE8HR3K3YMiAlwUTm0CHcY?=
 =?us-ascii?Q?702hitfx+Lmue+hnhAsDSdijC+YDD8o+T1IeoKqBqsqM1XOb87LZmgYpD0Fs?=
 =?us-ascii?Q?woIA62G+J3jLZXs0ATao3ikRVuE4byTtNZcSWZt9CR3/EbgP/1t+/ydjeDRe?=
 =?us-ascii?Q?5Sl39dTVsp7nv6b2NKiyr8EW8g6mooKG4elKDTDpGMF899yt/ogjH9+otfa5?=
 =?us-ascii?Q?FK3+fyzOh3NlXc2JKyBzqwRhVZ/Wsftf2PtIsJxuA3b9LczKqu+1QayTuBrA?=
 =?us-ascii?Q?d+xI+RcbH+zfTS5/C04a74sMR4fL4tXIE0+nsp4iOaTJwPGCqgJc+mDFGYqe?=
 =?us-ascii?Q?KUINfetEyC5lZE4ZJJWIKijGzcNrTCiZnkNkorTjekzQ7A0zno9j6af/dfy8?=
 =?us-ascii?Q?6rip0PvYoJrr+Zhz5NQkEueYiRuVRt/beneH5nMOe/G6C//CNnpIACSN2nMc?=
 =?us-ascii?Q?bDrzmpSwgOCRMx43AQqUn3Dg1E5j9EWTdkfuBuG39/Q9G1e/ipym+5sWNFgh?=
 =?us-ascii?Q?vVbsXP2/bmv1ELPAn+i8cN1ayuY7JMo/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RWzny+BTNPxjv6wjuD3rPNq/bQGlHg25bWGHnLmghU/MIizkOsoBAVHpHeKt?=
 =?us-ascii?Q?N8pC5jGxAzwUzKinUTovKfGOtwDS8578hg3URKkAZUM/jN4LBR0r3bchfYtK?=
 =?us-ascii?Q?E1v7lH47Z5+9yaUxnQU13Ksv5rF49S88FlVGe61cNuzIuf98MoKAay700A5Y?=
 =?us-ascii?Q?7rY195U/RiKXhaBxY04QaeVtZduw4zae5rjLMetHpf659vIyz0w0bqZwamMQ?=
 =?us-ascii?Q?A4chDNZFXP/VeYu4k7EAluykdiOUh+7msvic5UY3ghN/qDlDBn39HDGryX7z?=
 =?us-ascii?Q?yJeEGjwHj4UchY6VdSf75uW6ZWqp2v74cHoxtlqoPipiiu5SIJOyCdDV0zAN?=
 =?us-ascii?Q?w6Kp1pcqDJn1R01xVVUvnrFKOro5cCAPbLIjG9fOTx09WUnQwvxcHsnKJQXU?=
 =?us-ascii?Q?7QpkjffkZzLa6o1J3aGzDfJ7atXnYan3jtuScPLlrbw6/fg2q/8vNiv8o2xJ?=
 =?us-ascii?Q?Ee6PNafuZAmyLRQOUFpJtnFvp9F31WPsht3YHiZBgyRABLAqYOa/26Roaibz?=
 =?us-ascii?Q?rXSuCaivJJJdH5SGUpRUjlUdS89UflGekkXyfCyutT9WmUB9hoonMLtEv1SS?=
 =?us-ascii?Q?bpAaapkwygOfVN8MPYlf+aosBMt4BT2HtcNOBHu23pq6DDqoS37aC//Cwyre?=
 =?us-ascii?Q?7qVvhV/YYYEad4tFaIFoHjRI0WLWbe/P1ZDO/leby8VV3JWz9U1v0IVFx7Pw?=
 =?us-ascii?Q?PqwrHQew00MjSepM0fgIdFBgjTv1+GNHtwGirqdL7o//8RMj+pXrqWWEoVd2?=
 =?us-ascii?Q?LzcX/ev5htRgv4YW/B2Zk7o61WtVgZcz2/4ueigGBtyejSZedDfSgou2k3VO?=
 =?us-ascii?Q?khoXYhY5mxpmriUsMJU8tFSTe7dg59PyI1ul+QpOmiD0bbRyqOfUXwW2/F1l?=
 =?us-ascii?Q?kkQPqxf1uweQPQ37aWNxWNCvEd/UshF60Nfrn/JB9yhzylG+WJlA69nTyOIR?=
 =?us-ascii?Q?z/ppigDv32u2FLgWFRQaWHLqXFcNL5zJ//zKn7hAsFPi6NXCwGN+ZkAtq00c?=
 =?us-ascii?Q?kbVsGBDTsd8fP91gQhGUG//QocZY06Qp4eArdHceqWDuqhamKaZVbN4KyHQH?=
 =?us-ascii?Q?SuYCYBJoyC7UzunCb1n/Cq6FiIBhDofpER3ie4v27iGNmH5vVS9jrPMv3mOz?=
 =?us-ascii?Q?xsiEvyvq0JmA6++r+K/rQdk8ysFegIYGnSgm4IbxruDfz03XaHVE8arJ8P/w?=
 =?us-ascii?Q?heHTIi7MvZh/Hbb+TK5d5wdIMHc8Xg0d2KMZrGNYmtEKbpb1vwDJk5xBy0ec?=
 =?us-ascii?Q?MwgSejXTgO5gb+HeuWokmr5SlMfiCwrK68kUixcGvSWvaxMjbwdCc7V8zgRT?=
 =?us-ascii?Q?N4ibB1N7kUzWwFnK2cJYQhowXju2QabOwESkaL7nk7qpU1NeHkbqdRsvGp4K?=
 =?us-ascii?Q?w8SEBs2hJhV3IYnGz1Nw+U9etPU6IGM0buK7jNbSg9ytVdwE7SNPP0b+GIoS?=
 =?us-ascii?Q?E5GWgD7AGUE+KC0JqEgztxCmxIu2TfH6iLnl0k3XIZAe+vWkCxyg2h1Hv1nl?=
 =?us-ascii?Q?w5Qdwat89jHC97G0b6Oiz4rsq2XZKCHO8zkYvjKFufKcWZdDTIZhXVqIrt5d?=
 =?us-ascii?Q?+9ja3HlYsendhGX3kudbp3zVtG7jHLPRxd4+ukGwM/0K+IZs6aS5W8A5qWLp?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4IYiktsguhZD6F2/8WW94awwDK/1K/HjUZoqTsbFMN762VzGZmg9Xv+XMbdJflW0CS/3FTXIfOPuTVdjiJziZug1fyexsdRv14lzSSNWE+STUsxXsPie5O2oog5UupsBN0hIyzU402YPDZLPec7R5Yn3va/G/tLdyPPLd3ipUt4zYT+SvMc9f3n56YkPNfiAUL7I1LnUabh2bTneae1/CpXi6wWcsKwaeH6dDfYCfDVQctQGzES6F+5GkI0KJtC7WpqyrNf4i0nH+/WRKGP94/6Q1NIRwBMmhajEDdT4DRcQx4/K8jTPHbIxxj7Bdg8AA7k0SG7AK7pO0srzarcJjXXTXuF7hgXaqQqYp+zWf5ptNv04pGXEaVP7AJgazD0g4Wf8XN9+dhtYPkvo5D4M9+TusG/+ev4rBlQSFpXekDglKxJCdXQiewr9N/Zg+G4TfLpZgp+r98aZO4YF11EUUJenhSn+y2ZFuxS0hnPbdf8oXt8GaaI2gU5b8fY6Wi8lTVZGgcu9Dag1TGSOTOlUZQE6PsqtqnOgAj+f9JDybhO5o2LcHedUfkoBpVOwNaM5pC7pFNYYqWr/vp8D7k1cpjyavo8heC6ug/Pd73/Ucws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b218c49-ee11-4898-3c71-08de171ec2c9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:10:01.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9w6jnZjgfPF17Z35VmVaGE9nLlwDzDOLqk5t+GsZxstJFLEArk/5m1I0z/Yd4YV7uo6FoYneYX7t4yBKlaTyT+vfYhEWXazFlE1pcDgthns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290153
X-Authority-Analysis: v=2.4 cv=Y4b1cxeN c=1 sm=1 tr=0 ts=69026690 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0V0InIxXz04UIqz-YlEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12124
X-Proofpoint-GUID: VbH3HU8-jBB3mITwnS31E90be4Y7fZYk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAyOCBTYWx0ZWRfX2Yz62RAMqkid
 5npPjWx4KQe0teRvc2osEPZ0D6RS1JpbYHJuDbKSECG0VFjD3YWRsziTC0vaI+21LPV6F/4G8VA
 zCT9kvAWP59fUMVQDBxMtFu5BacWAqZUYaPIJJCRpc4iJsn9wJspDinjl0iUZ2BzV3iy7VoyiFD
 FgNafgFQZzwuXjdhATvL4cU28r2S7MgzoQfKUbGI0vTnRbRy5VVGTDdezJjwWV4Xn8iFk1W/xVv
 /jHO5WmYlN5djAd6Q4Kk1cWCQjyaxxxf1Ihi4SCxSImQO5X9VtDhqg5qi9Q3Nx9ZmTjJ/3qSBLl
 P2u2Ykck2qo/oUE99Qd3BJoOp714PNlkQWB5lbROKP3XnvgmcQp6y9vwy5DVu+O7YHICpDgU66y
 M5gTIgX5iSLdKjJ3XbTWhnJHLCC5dbEruCW//v/ORfAgQ6bbHtk=
X-Proofpoint-ORIG-GUID: VbH3HU8-jBB3mITwnS31E90be4Y7fZYk

On Wed, Oct 29, 2025 at 11:10:48AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 28, 2025 at 06:20:54PM +0000, Lorenzo Stoakes wrote:
> > > > And use the new type right away.
> > >
> > > Then the followup series is cleaning away swap_entry_t as a name.
> >
> > OK so you're good with the typedef? This would be quite nice actually as we
> > could then use leaf_entry_t in all the core leafent_xxx() logic ahead of
> > time and reduce confusion _there_ and effectively document that swp_entry_t
> > is just badly named.
>
> Yeah, I think so, a commit message explaining it is temporary and a
> future series will mechanically rename it away and this is
> preparation.
>
> > I mean I'm not so sure that's all that useful, you often want to skip over
> > things that are 'none' entries without doing this conversion.
>
> Maybe go directly from a pte to the leaf entry type for this check?
>
> #define __swp_type(x) ((x).val >> (64 - SWP_TYPE_BITS))
>
> That's basically free on most arches..

That's nice, I guess we could throw in a pte_present() check there and just grab
the type out direct like that

>
> > We could use the concept of 'none is an empty leaf_entry_t' more thoroughly
> > internally in functions though.
> >
> > I will see what I can do.
>
> Sure, maybe something works out
>
> Though if we want to keep them seperate then maybe pte_is_leafent() is
> the right name for pte_none(). Reads so much better like this:
>
> if (pte_is_leafent(pte)) {

Ah so this would amount to !pte_is_present()

>     leafent_t leaf = leafent_from_pte(pte)
>
>      if (leafent_is_swap(leaf)) {..}

And yeah... that is nice you know... :)

> }

>
> > > Then this:
> > >
> > >   pmd_is_present_or_leafent(pmd)
> >
> > A PMD can be present and contain an entry pointing at a PTE table so I'm
> > not sure that helps... naming is hard :)
>
> pmd_is_leaf_or_leafent()
>
> In the PTE API we are calling present entries that are address, not
> tables, leafs.

Hmm I think pmd_is_present_or_leafent() is clearer actually on second
thoughts :)

Still feel a desire to shove a 'huge' in there though but then it's getting
wordy... :)

Let me play around...

>
> Jason

Cheers, Lorenzo

