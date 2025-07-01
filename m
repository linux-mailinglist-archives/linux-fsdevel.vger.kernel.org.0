Return-Path: <linux-fsdevel+bounces-53418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22623AEEE7A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7DE7ADFCB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 06:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C35242D95;
	Tue,  1 Jul 2025 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xhgwbh35";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lVHpd38K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4F199385;
	Tue,  1 Jul 2025 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751350659; cv=fail; b=uW2oxMkPootPYG3t1E0v7msvj/6PIJLaOlXI3xW0hSalQoliE8WeMW2ehkF4BRSh+uh/Dn6z7lHo/JpCIPthg2in/7Nfj3Tozg+0epBycw2dCnDX27RpRnuD1QYjz9Qj5EhtFRpBk2MPoZCUSlBmsre3+2dBbDMJoN6jGzg82R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751350659; c=relaxed/simple;
	bh=u8lqmnH4lHd88SYvYpXPooNa6Pve17i0oH8L8B/Ij2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LZqjT9p7UOLbcVL6RZYMqylx9baz2Sz9Raak/5iC85tkk8OqhSJMveG6HzUw2n/4jzLOzRAarF3AS+by50Tg0aYVT1FmG/EMooNtv8J3NV6qvmaqn7CRmweH8RW+8iNNEnoG5IOTa1nSy9jenJjBlJnxU/jL1LEgZwPsRBUZQXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xhgwbh35; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lVHpd38K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611Msor005251;
	Tue, 1 Jul 2025 06:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PbfbYLOOcrwxczaz3q
	yfDXe2R6eZYjAiNcshTcUs88k=; b=Xhgwbh35zys/WyC6nKCCKQpGET+1CpHyAx
	SDLeLs6KP1dN6E1kP+7UQDYEyG8l7ejEhAE51eT4xkjpNYQ3xDS25qUesCJzn6q5
	hD2ICdrXkR+AX7kkAD4ulY3G/5cAsNMYsrqoqpAaczlGQjnG4JKQnZsh4sSlA1V/
	Uutc7vZtEDDQHx7LPt9F6ZOnrrYwPlkqJ6Qn+yRh2LlsYTP+gp1ZvoaaCq/GrIM8
	7XIC8p/oN3B0uSIgviUi2FU2DEImm2IHk2fyaVmfKu+VEJBDV7JzmTWrT92GhwUk
	vT+cgUlOP3bv5ed5SD3RHwOGmWZz1kPuhrPwOabQPYCEX4Ev9c3g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af3y0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 06:14:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5615Te27025811;
	Tue, 1 Jul 2025 06:14:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9aj88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 06:14:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stlltpYK3liyYmIIo1kjLcGC9p94gjCiz3Ye4vTZWsw5tWzQlrg8z/Y9RB0sFER+y34QgsSb05x1tXIREAr0W3gnRK8Np3avSqGXhGvIgWZZyYtNzOZ3fMNxdW7ktu9YaFPDIDZ8KN7Xcuu06A8gRLiXp0awRkhufNYKRHKmoflP3tZOXJ0h3WBnkVhKnMiv/ZfRgm57ICPbtiWYirq1G43tMburo2Xk7hPmrSfMGWsEDCva+11F+mC+ns/qCED3OigmLRF/LtWewwWkqRRdJiAw4JXhoPuR57LcnN1uFfX/dMmnTvQOQGeUBJEV3jRK9RSHZ+5pCqDmRxlu5QhovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbfbYLOOcrwxczaz3qyfDXe2R6eZYjAiNcshTcUs88k=;
 b=ZvkWBf77tOkfogmwvtnT2dWmxJbwrqXs17WQ0WsuKydZLkEtJ5XLaQoAjsKqCZAs1yqHQdHD1eS9VBOeDnDMjNoJ/KAP1JaxHFeDg98CeiZ4DRZN0ytfobBIO9fBv5Zui6+gze30XoU3lWUmD9fY887uezFcLN4H8IMrDmdDIh4k4bo6IGVOlv+n1knUQPZ5iXf1+VmYOFarha4VZUxtGV9q2a9vSg0LxCPyShUHoWg2jfTdhuC959a3kA7/Qe0HAU+wM9S5l2qick+Qv9QjRorFCbq9kh+pOOMY1jY8Huvye7Q4ktlPqcv/jaFurpEqVsuIIic8iMIQhPaTorTLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbfbYLOOcrwxczaz3qyfDXe2R6eZYjAiNcshTcUs88k=;
 b=lVHpd38K7JbVTeaV9ewDgdI4cwSkgccxe/fOnFjTdWFCcoHymm9NyVisQGmRvhSvdQeHEUw6azkxc/upRm3CaasJN5piu0vC6cBl4n+CekSE3BDpi+RyQYK+z24jmRjhWV1dKqaHwoN1ueAo/KQy6ROlOlLMwMp1PAoZ46RRq/o=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB7067.namprd10.prod.outlook.com (2603:10b6:8:145::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 06:13:57 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 06:13:56 +0000
Date: Tue, 1 Jul 2025 15:13:43 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
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
Subject: Re: [PATCH v1 05/29] mm/balloon_compaction: make PageOffline sticky
 until the page is freed
Message-ID: <aGN8l3-a7GeFhFlz@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-6-david@redhat.com>
 <6a6cde69-23de-4727-abd7-bae4c0918643@lucifer.local>
 <595C96DA-C652-455F-91DB-F7893B95124B@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <595C96DA-C652-455F-91DB-F7893B95124B@nvidia.com>
X-ClientProxiedBy: SEWP216CA0007.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c701ed-01c5-40f7-4ce7-08ddb8667601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AXySWg5FyTCbUF1Q7ax/tNvzvz4FVig0jNcY1gZgeg7LzggXlqOY9E+ai3xj?=
 =?us-ascii?Q?gT6m26S77RngcKTvLoYt4ewwtEi3og6b+XyvVuxyF1BrDr+PIFdMXRnkXwyM?=
 =?us-ascii?Q?xSkLEMxXRcg4FFO+NtS8+ssQ0mGCVKK0RiWbJKPrySlDEYtT4vjciVuq0rjl?=
 =?us-ascii?Q?tmkQGLojAS7JfBU7FQkPy2doHcSfPM8IsQtRqCuFWUIaMLiBwKAP6ScUiEd9?=
 =?us-ascii?Q?dRUEZXrFDgj0q3ylY6khv5KpJK+HKGCi8cULOWKe6TI2lbzr6wiJ2pY5JBp7?=
 =?us-ascii?Q?Wads4gV11/g4VPypvZX10c+7DV4kkJBolIsmEfI6Bjt3m2YNYdjmRlYm/btz?=
 =?us-ascii?Q?02ZdUCLoDXFTuIGp+oiZiA3/X0ycI8a9fo4NGLVLEeHPgp1iVwOZeLs7Wq0D?=
 =?us-ascii?Q?xv0pLr/t/eHXmySnugjoPEpPmuhrSa3KNq9ary+b+QbpoFX9FXPgUha90dz3?=
 =?us-ascii?Q?ZnC2gPSjdv4Qgq3xuSZ5+9QCiL9n3ej66MNcz/0g/Si5wqTgnYkaRfApECAN?=
 =?us-ascii?Q?dEQq1C2s1YoEOkbmh5n/JLcv8UbIJAoVxexs+nxLk0qW2D+ZWlLpbUkxmBjd?=
 =?us-ascii?Q?8d3sb41kx3l5/PShhFD3QdwdhiRL+1mM3HY1hPUXUTf7k7fLnECBC+QbFKJA?=
 =?us-ascii?Q?dS4+g2AV4PEspPZRfApkjgv+20Z5Rs6OxArZw+/Hi5RMDZ1dfSh74YEl3L8o?=
 =?us-ascii?Q?88NoX586ZjWDicmHIB4Uk9UXiiw+x1MKITxdjp/RcS3DLWGTYU9V7s4DzYng?=
 =?us-ascii?Q?pTcI8AWAWnSJ0iC8r9X/z0YB+UwZrW8UehqrjIlqbYLMJmJHjGRqMRQkveUU?=
 =?us-ascii?Q?/AM1/bwX7asSuYxbrh1OIwg/T4CxGingu8NBdsogjAIkMIiz2CS2vP7gC0wh?=
 =?us-ascii?Q?hHE5dvgUZo/9EAVIxz0+BXJ3fkFUpAVmE7e9MYkAakobFZLGzHnzFplVB8/U?=
 =?us-ascii?Q?n2d0fnlXx8MRSRZEbEbMYjnXIE1zfRk//jQJQmB6e4Pioca2bsRVZ5Ei/SBC?=
 =?us-ascii?Q?iVu3QQZe7NXHk7AwrcW+CXBxo2SJnJrDrlkzzieGbsVp/pPYGX2hhEO0RlWd?=
 =?us-ascii?Q?09PukKIEJR+cz6hBdVYxKOY70KPliqKm8+OzEoNAl7BuU8WydIxzWCuBDWhf?=
 =?us-ascii?Q?eoW5h4XGLGZECMjqUQfVjf09bHcCJHtA0ZgkBy59IHHxlzq/eF3xu6PFywyo?=
 =?us-ascii?Q?DxTR+Arkl4h9eJZvO3awvoXC12U9fEnaCHQCiQO0NhZClUfne1fTf6lcc3Z6?=
 =?us-ascii?Q?dcwjptSz6NmA3zL4lP4i1QI7KdYUorn/Gyhf1rCx0YX2Qsh59mP9PuM8y0Eg?=
 =?us-ascii?Q?QUpmBGQyOaLaDlgMEOGjInsNRgiaW0WelIooBhcdlsVwt5r+BYRMWfo/EvbP?=
 =?us-ascii?Q?qVmud7U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AFhk87y/MGa6HAFjKtdlRx0KRQEXwa2vl3gEKK8DueXJf7vZimZSDFVzHaYR?=
 =?us-ascii?Q?VOp4UHqR7OMpE+itiqUOLTRrfb9AnkbW+ZbetFUzLWUceQW6uOApHqHEJbHf?=
 =?us-ascii?Q?/kRrURNzRvKGJvgVyKUkVKBrBbYnnVq9Y/O6dpYCX5kMjBG1BYFPZ0eK2fpw?=
 =?us-ascii?Q?dMaJByxkAHwd2f9H2aGZf2fSxQWzFdLwU9Xe7QuGLoqlt6YN3BoMK/Gi72xL?=
 =?us-ascii?Q?0PXJo4R+UEhWX16Vgvt4NJ4Ry0UY4hZX9Gxov+5e/61H+Xu0giRx6HzqdIOt?=
 =?us-ascii?Q?Te8Z4v3bVqQCW6YEUR4OYcsxq3OoCDDCmuW6SI020M51iDkNUqOvHtrldHlE?=
 =?us-ascii?Q?3NIp/+9s3xaUsIR2XoYwOWT79XKIADR5paPkF5JaujUG9vevhPH+XfnnnN6y?=
 =?us-ascii?Q?K10oq/vMC7jFeP9KmcE/nIiVFODO4dCQ4CAx30L4CFyuAYiP+aPs9XXDRVDK?=
 =?us-ascii?Q?TgH+qOQJVlOIxb/sytUfb/q7hniBPo40PR+GVMtPw1sP0HMSDgPAvRX5zkkZ?=
 =?us-ascii?Q?QJs6glrbTACydSkrpU54N550y7W3JrQhKvlFd0AV1eDIVnKnS90qb9jHEu7k?=
 =?us-ascii?Q?mEBXz8Hlpv51+qPNwHRvvz0dV8PpSK30CYPN0Gzvp2engtnIwso6awJNBePT?=
 =?us-ascii?Q?Q/dAPMIb+R0FfbQQerbzIJ5d879iRYihilAmBNilYQ/k1eOZTtEMq0iUs6Qf?=
 =?us-ascii?Q?Lo/CazAcHh+CJpK3emxH5Ix27TNLTDUu1qe8RtvlaBQNOd3DpyyCzCy0RUUe?=
 =?us-ascii?Q?hwPgxZqHR4n8DjVA7213BEe8z2g+cylJ0zFkXJqJvQkC892mdprBgCuTwoRi?=
 =?us-ascii?Q?xyNc/xobM8PZHLkl+kUjQpOVsirRgKYNREkp8b/yBATOBY3d67lNW4V+L7fL?=
 =?us-ascii?Q?96DIFIFZJKLZeCZNUl53sl+hLZaD97tNZtCSDH0kEUgrfHMZw1Qp3hPzkkd0?=
 =?us-ascii?Q?XAn0gBeqqQjeF0Jn2jI1I7iZx8TqZLnrKF6G4Uh2lftI3t7/sve7zT+tJEEP?=
 =?us-ascii?Q?axvrDOHcPqZN4uUH8GBFV5Pk5mCo023UXCZx25QU1ZUL6h1Ox1hzNoJwhtZJ?=
 =?us-ascii?Q?woSgaOrGZDgDTJYMBaI+4WLYk5Zh2ofTi7GC1kcqK09p3MvrdTkedRZpI0YF?=
 =?us-ascii?Q?uUW25nX9WI8ha/lAx2L5sFYhUzGWtUTSpsCQHZ9HMesT1DpRmFvkJAxED2fY?=
 =?us-ascii?Q?MIbG5TaHoaV/Jb1Y/JfS4nnZ5HPX3fRfOBPMxWvdPN2WJm1SZGQ8EpC5ge7C?=
 =?us-ascii?Q?E1sLB2okuYAfkj1fz/vLDUc5tq/JPpvj71a1MlIqZW8xivhkuu2VVWhomEJH?=
 =?us-ascii?Q?dZYCyNzyYTCpRFJdFxwDwIesLCUt726/puDMF7ME2/9JFtzWhmlNpznJ2vuR?=
 =?us-ascii?Q?RMhwcY2YLFr5/daFujGn0SWWa8TyqmTT0dkRNEv3yKZdgcn2CZik7S9xtqRI?=
 =?us-ascii?Q?6SkNClTggm0yli8fJ+DyfALdRQbvYsRL7JryUUEYQF9qNtcY2mHHCZtkxgOZ?=
 =?us-ascii?Q?COezoP8OCQH7V66qQ7wPeW0k34Gxc7A7WVD0ZGcIIxQkm2ZAEJymJ8ot/vfc?=
 =?us-ascii?Q?DkwKCmH4orEXBtrZ2x8iYTh34MGELqLdFpzarSrP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hDkO181hCiRO8nY/hRHyyj1ScFqZ834376WbLzYsEHuenvBYgX//e7U6W8RHUXOarj7wWL+C8gRZh4uGn9CbnxnZ/6oVqhlf2VUu/qRjtyCc+zkgxMLA6N6dxbKC1jiGHd/h8eoyIwfXIXZ7IJGKkfP0APAIJLWb8YOlw4518RDVUcmnueHoBBiPDCgUJ+zuBplOZACzwZ8NLPpb7b3DyRv0E5pkt9cZn6wsK+2nfhtLMT0MFjwkbN7Cg0dFFTXMjuHr8msnepSu/kJBoWTwYn9ho+MBzF7dLrdSLPCLebORZY21dxyGoGinIj47x3js07qnql3ZJLJgAlShr47oDsnuZde4XP0qPn8IJYHpcLMk4Pl6oS0tcov/875xH3cRj+ll44QmiocqmN3d0tlvxfi7wmNYgzePxbzeRMlzkkXiGoQzwKGF9tNFtebG7RsLN+mSWdDnZ+7bgybx4/eUkgq7ByS8nyLERB+FFFWg1TM89zqOVrpAWGgxRa1N1L3M3gViEhCG0FqNQeneSnll+wg+1YQxdfDCPBp4/O43JwFI5ISjOoxmntsx40iZ+1PVO6ZQ8EjnP5dpgdfmalUPoY6pvRQpgbhVsSHfzyIHuT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c701ed-01c5-40f7-4ce7-08ddb8667601
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 06:13:56.4250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elZ9teS7DsRuzfEst3XIOWsTL/lUKyoE58hZOBu1svF/RlL6HAr8TRD1xYpVxhsL7ke71zoE+zZ5XZx+uq0nfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010032
X-Proofpoint-ORIG-GUID: h9LeWkKDtOFU4G5ZSme9-D4p_wCm6mrj
X-Proofpoint-GUID: h9LeWkKDtOFU4G5ZSme9-D4p_wCm6mrj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAzMiBTYWx0ZWRfX7lccg4u2qGpq 6bE7lXEX+sgHDB1iRVsl51S0AYgadQfHWUj6bxeQdYb1dg8I1esNWpqwfCP64zeU9dlZDHDgPRL opetPrGhCnngl6TM0iGikCCrdhB+Pcktht5Gl6jyNV2j3IUUCq1W0TtaYMSfv01CK0VUCl1tAvI
 CVKVlZ13drvi2U+MHerruA5oEHHJhaw92YfoiR3leqPityoIvt9BLjf4p1aHHo6nTXzLiSQerz3 iSC0YxSqQAh/uee0H0JYVzfz6+tjNU3x0GjjxSJ+D7z/Id8mpjt9EcaZs82GLxaotb8UkegznE8 BvAEqZDT0tII1p7Re6gIK2/kkD3HQ66P5b5fq+4akC3PNoxtTIK1ORPFc6OkUppSUCCE8bYLngy
 iYYPK53giHN3nHk7WuDbDypyYzCNrKUpdcCh0yO3WUcPRFJAK/vjuq9VspaGd6N0Ag7/qsTx
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=68637cae cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=P-IC7800AAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Yjkf2zvtm9G3cYgrPQ0A:9 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22

On Mon, Jun 30, 2025 at 12:14:01PM -0400, Zi Yan wrote:
> On 30 Jun 2025, at 12:01, Lorenzo Stoakes wrote:
> 
> > On Mon, Jun 30, 2025 at 02:59:46PM +0200, David Hildenbrand wrote:
> >> Let the page freeing code handle clearing the page type.
> >
> > Why is this advantageous? We want to keep the page marked offline for longer?
> >
> >>
> >> Acked-by: Zi Yan <ziy@nvidia.com>
> >> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > On assumption this UINT_MAX stuff is sane :)) I mean this is straightforward I
> > guess:
> 
> This is how page type is cleared.
> See: https://elixir.bootlin.com/linux/v6.15.4/source/include/linux/page-flags.h#L1013.
> 
> I agree with you that patch 4 should have a comment in free_pages_prepare()
> about what the code is for and why UINT_MAX is used.

Or instead of comment, maybe something like this:

/* Clear any page type */
static __always_inline void __ClearPageType(struct page *page)
{
	VM_WARN_ON_ONCE_PAGE(!page_has_type(page), page);
	page->page_type = UINT_MAX;
}

in patch 4:

if (unlikely(page_has_type(page)))
	__ClearPageType(page);

-- 
Cheers,
Harry / Hyeonggon

