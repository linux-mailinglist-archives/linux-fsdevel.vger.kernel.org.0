Return-Path: <linux-fsdevel+bounces-53498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09450AEF917
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31281179193
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E938B26C398;
	Tue,  1 Jul 2025 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iDUGoLL3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="htbIWZ5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900154A23;
	Tue,  1 Jul 2025 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374015; cv=fail; b=Kd7/9rur1DtYSlgkPodRyQF0K2JsoPNl1Sho+F7HFyrWbjPVbx2Ghie8LwvHnE+bXbtclFZ8EnBEG55QUh75HECXKsTtmxF5a7Py9EPTHYLBTK5XHIsrkShxuO30LYkAUKVGmcK1w90A5DndC9vXdruileSEkalji1CCROD5EtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374015; c=relaxed/simple;
	bh=9OwzdpqJS2xaEi3C0Iq5dNW+loWspV0LnKJebIK4CDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PRHJ8dlGs30zMtxTh4xmnvM6pzawybPsvAnlCVbLPaiWSmncKO1niqwrgmcwq1uucCpe+w07ATz9RymonU1wYkzkbVHIOyTWYCvMwbsg5Xsg7CG0E6iDgvk60WWn/D94g/xavbwwXoIJhS7r89H8pG5/0jdMUlkwemgOuuNhoPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iDUGoLL3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=htbIWZ5Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561C63qL008588;
	Tue, 1 Jul 2025 12:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3/V+ucYoOO36W+bWI7
	tOwPdw/6RWKBcop9XTLHDCU4s=; b=iDUGoLL3KjZoyQjvQ95mVYAgCDZvDoc81O
	CEwRY55IRyOhia6D5LW6Uso3NvcDn8SR3G1A1i4nEBYySU2hhRu1I1Wf1BwoV9PZ
	DWr3LFhawV/nPMgWGYPakmMZlg/7JGv84HTomGvv1X/5QEbKGZplBRd4dmTF9pfF
	bmiOophZPeYrIIl8V52KCGN8C7WZLfh9Sa3Vze/paAHeLkGZ8rNxeCtuXfXUlXPp
	YNi3g53eH50s/RL2DAM1GX1gW8y69j9Z/sGb+/hz0yC8JXg62xnu4+MeVksAXaS2
	+x15Es7Hjvn5cr8bsp/sxBp0LAg3f2pY06Srjq7y6tocSqfdN/uw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766cq1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 12:44:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561CcAJu017418;
	Tue, 1 Jul 2025 12:44:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1efdwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 12:44:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L65NQCBZScmeoA2G9yyO7KDQgB2LTXqYieJoFJVa3geqrS4t+FDrc6jI9NYkStKnK2EONz78qL/rSlpUXsFpBgedi9IQmBIcj0oUHX4jZZrpAZ0mETcRsSmxqj534lb9efwubxqvnSocB+oDxiix49k7m9P2SWvzBqXFirHPgNO//LQPLKH2s9XQmCugxDlscDxnXludoUWnRZnHuHuIE7g9Ws1bpd4+M4+6djhpmIaZG4Vbg8YDKSQ88dSrcHNHKXTKGSDSnAkvfiqKA6HXQbNrFdTu2VMLDJBeT/ObPtoAJgouV+MyOvrmC7SO5IvivzMk/S3uO8R/TAgoXZQYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/V+ucYoOO36W+bWI7tOwPdw/6RWKBcop9XTLHDCU4s=;
 b=jWwVmrr5ZXaPU80P0QTwSrG8ESLFntORnWlSbBB/bPeL0RrhwaRyfpkPfl4/5xOQcMt+nd6t40D/ESmFY9rpKf3+TBRof8HFrXIrMvjkXOk18fm80bzjvDo4ci+EhDC10BJthBQWvyOvpKqCs75IhP5AcYE4VhEvd7X0WQ0EMKd8p+Ok21EXD4s6KVAqY90TVE7I8vSPGelWTCDRl7PU9l88JVwFBOkPVnNpLf/DrolQ5ADwcfvd31Kh9tG83y/S5eM2NsLXzebH+sG4AcmxMM81n9vTcz+fJcmbBAQUah2P3sI4LVT7PmgWtPEbY83bCMoc0m/vX0CRKGFiX8kqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/V+ucYoOO36W+bWI7tOwPdw/6RWKBcop9XTLHDCU4s=;
 b=htbIWZ5ZAJ1tIoqqeHZ3lqXxN/RV16H9MEsGBL3/TDL3WT4oKmmC6eBf9FYAvWHrqOEb7XCzJs3OWecxYcvEHtpIw4L41tgvoyl/b00LM3w4c7C1WDaZucr+8tqwFuosrMhr8drj4733sGZ9BJxNSExo+mkz+eE8vaHdhqyT6FQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB4846.namprd10.prod.outlook.com (2603:10b6:5:38c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 12:44:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 12:44:51 +0000
Date: Tue, 1 Jul 2025 13:44:48 +0100
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
Subject: Re: [PATCH v1 20/29] mm: convert "movable" flag in page->mapping to
 a page flag
Message-ID: <0150bc5a-1275-4205-8d85-82364ecabbda@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-21-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-21-david@redhat.com>
X-ClientProxiedBy: LO6P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7f0dfe-d7e2-424f-4247-08ddb89d122c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I6N1p1pNc+dNSB+CS3My50PSZkC1ahM+l+Q2s1in/nC4SdwdqIb09/sZDMfr?=
 =?us-ascii?Q?u/4W2WsRzRcsFC4ZNz/v30b5GDlCUKm8Rjt3eCHKRxKDyOCfYeNaepr8yies?=
 =?us-ascii?Q?0Cb7Q83JggpoXRw3sg34rpB9TrLZ8K15g4WZK7ib6zMzBcNlRD9gzxOMUvks?=
 =?us-ascii?Q?Ldq25GCbTTNF+XkfufC3Z2//S96jWTD/qG8kPYG4NqgFYAO8EpPl7aDV6EJ+?=
 =?us-ascii?Q?XINTbGqDmHPp3Y36oVwg5cBgl/HjpqYE0ZvWiwKi/OW3hK79lIYcYdiJKOf9?=
 =?us-ascii?Q?kW02jepG7xBl3DfwDbjAESNbkiwipZQX3S4kPN1tdg9Lkr/CA44wxoBPA3K5?=
 =?us-ascii?Q?JQYERohwpcjkMz9WJYAPxncvBWKk9sJ29Tf0P5/VlslcSYa9UtkRFvLGxrS5?=
 =?us-ascii?Q?NlFgIrmuQ/iGwPZ30zTRla/t06qLrSYnCgwMhCcaHkLMBN4ICwwqdjSD1U2h?=
 =?us-ascii?Q?ADGZ3goxTZ0RwZg1FrymM1Ra4gNNIQhoDN+BlSnrN7A1LLBjmeHsouhKCI7o?=
 =?us-ascii?Q?RwgLU2lG6G1NeUVB8G44aQUe7ImbpRHG/tzc9lLMaXmQCjpSNFuz+XzNeygR?=
 =?us-ascii?Q?U+YbFJ52nDHtgoyHUhObr7aCWPMd1l6fKdg3mYvoVhm+DxJTXfaaqM91YUKJ?=
 =?us-ascii?Q?vBrHYEdMUZTgLW9RSua5YDzto3aSZQpf0tWDOJv1ujG8vd2hHPfUUoL6XmDs?=
 =?us-ascii?Q?N4Ano5a3FZIYssW3dNWrawDLcjAWzuFN5arrHruMzOYF+IwmfyAYpbf6J4Ns?=
 =?us-ascii?Q?exrNAfxOk6QbCsutzAd4D8TqPsjvbnNCcvQ4MI19Q3sjBJ1q1QIK+DCmHH6D?=
 =?us-ascii?Q?KteXSX4A0N6oV7cXL0ooqwCPplbXPL6TKUfZJiJFLVNMlPLpxF3xGzobaPKn?=
 =?us-ascii?Q?gNVOmrpuNgPstzl8yT7p/8GCYdohGXJW42AHlAYnx1rkhW4bz5vi41+y9Gsh?=
 =?us-ascii?Q?scyrCiTDwl8JGG4dnP2ekIrbm1zRkEpyUW2RJ5lo0xTNx51/NeWz4g3fD0ib?=
 =?us-ascii?Q?CmGrh7GS2copJKKJ+fKz5r1E+u5TgYgl47RqGUuncPqxNMqiF2AzNnxRuUye?=
 =?us-ascii?Q?1qDj6+pJn06vxeljVJ6k53VFoz2pDMAvd1phntSg/o538IBtsQUj49iV6dHG?=
 =?us-ascii?Q?L+vSfcwhujb12jk+1j3WGwK3Y90Kr0zwTIKkCtYzhJmJQxLs+QmzqHA6aIRT?=
 =?us-ascii?Q?egAV6ANZgqXyKHZxcHdwouhqzA1nujna6B+7/vTOEN6UQAxw1buYXjVvgmzV?=
 =?us-ascii?Q?R0dxi7tqOpfxIPHHVqPrU8w1r0Sz20mQbBme2nMxf4X1NPZrOLC9msMhr2P5?=
 =?us-ascii?Q?wmKzbQZ71LwltMHo8V+LXUpGWff2fuGh+yBUtJ9tf0Mb9xREgBI5oqwq7xu2?=
 =?us-ascii?Q?i+TWsjeS4uOqYDpC95dU7zdZnq/DlsDnxbFKwuoVkW4VH1x67ruam9XefEFO?=
 =?us-ascii?Q?qjfb2alsXbg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vtrVB39zj+slVwKVTa0/oVCWlHZtIh+ddwb0rdmpepJyYv9IPx0uirut3M9D?=
 =?us-ascii?Q?Y80qq8kjLNlXrV/qNgjOBaNSmZni525i1HlwKzS9iJlLX/3KSCEDD9RBApDO?=
 =?us-ascii?Q?JaJnM0CfEcADiBD5LbxB6qaGFIwkrDA9TsxqrH5XBihlUrNSozQWIXPdaXIz?=
 =?us-ascii?Q?CTrbVx3p1pDmXADvqLA6gEzk6yTFPwWzoHpgXjaqBh+V++aVxY8M40a+4fY/?=
 =?us-ascii?Q?z0Pyuz4mvP1pEOX8bwHwaLxti2txvsoBjmVlFt1euD4IwMCefLNE6e5jNOA9?=
 =?us-ascii?Q?y42OyWZo0/eyuCqAGzLO+sZm0mhFjuhmoWJK0uSV54EEOq5vKcexRcPKMxjc?=
 =?us-ascii?Q?7F+MnZwKa7wMfUNIdei61rLZ5gKqC26uNKoRd6fmreiwYeKRDi8BT4yNWXs6?=
 =?us-ascii?Q?CHBHWJw/4y60yFG87f4fdMvka43oTFiJ43vRvE9C03TenpAPAFok3jLuc8vl?=
 =?us-ascii?Q?28sSeJbKdmhb0lBIJzSzoC7UHuazAqyriREt9Y5D09BisbbgkIxuwYus9kUM?=
 =?us-ascii?Q?poFrM1CzXBk18PkVRGHD671ofGrFKwxTMNOsPorYxEBFstBkOAbl/35pNUUr?=
 =?us-ascii?Q?2m7PMy9kSP2zBM1DZo8DqoDZ/8lZCsch7JZlB/Om6gOzSbWJhX4iz4jwhwj1?=
 =?us-ascii?Q?tGd8h+gvtlKvaA24RBod1zVWWrtTRIcoz/ASK+ZQvmNpNwYGlHZ9f9kOjBIa?=
 =?us-ascii?Q?eKxO9aLbiyE9kwyIxkkjaOQBNcKEAgdNrGP2/ITJa255IxqtEFdtTAJw3E3L?=
 =?us-ascii?Q?WJlQUWH6oLmT31Jfzc7/uBp+BknpjASXOgcbEarA8OIxCGcmSR14xOTxnbV+?=
 =?us-ascii?Q?sbPG6phBQ/cG34VTaBQzgOCFDPGTdNvn5rhM3frTDuyXe5VHo/NnR80j7GY1?=
 =?us-ascii?Q?RHaXDPJlaBfU3U3fNWM/xNibHdoEcrVEC5NUnz4+8oNizyUvOmzT3Hrof0G3?=
 =?us-ascii?Q?LaJQN0hPhDvFP8o2TiBwfKjf+bLV81/ycxdXwJ2G/AVE/eavvSLRs64EgQ6o?=
 =?us-ascii?Q?WZlz6POq7M71ek9eGAlaR2G1cbDBZZ6gTYB/7pz+OWjSVEAKSm/YHzmbGAqh?=
 =?us-ascii?Q?Fk8QM/kIzR6+XohRrDINBgiD+q+Ybu+6Rm9XGVLLT3VyZYbNFEKMOeGQ5v3L?=
 =?us-ascii?Q?bADI0mYYy9tsTE3Z6TBCormMpHv8JDki1KIG0iDNF98HvevaRvPGwxg9/CSQ?=
 =?us-ascii?Q?rMe+3MzlBwzCYlqyMNZp31lyzcDAUesJkqQFmfBuy8yuJo8mGBgPR07Mp4v4?=
 =?us-ascii?Q?zyWObkjvU4lAEVdJN1faESlE6gbzqsNZYho1NzZlYiTVI+akm7A/vmBD6dOK?=
 =?us-ascii?Q?jSQnE4qbBTL/uux9sf73uF0gv8/T6O8KIRBJD6xz2w+xKIBQLXHf6YQH3IQe?=
 =?us-ascii?Q?41najp568N1DaM/XVR1bbJkoO3s82m35M3fgIem5f3KukTkycWlkv6pX1mni?=
 =?us-ascii?Q?DAP4CwR2jZN0deTdhlwnSQCOzvKvgQadaBv6hz6uWV039uzQOTDr6wnRaahl?=
 =?us-ascii?Q?PShdOuti+F7rnh0ajVdEnUpblSDnr+n1GfhXVDqY06OSeN5YFMOEDJP7clz1?=
 =?us-ascii?Q?cFVNomitWLKkUGWHJjxJtsyiJIlFnHjYBvjZIMjunw1GJ8EpAUcqigsh3uiH?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fxr+9ZF86xKjyi/0nKRGZ9g+Pvu0MYKnszr4j8XAuJ7MKTFs+Vax+h9G5jTIz78JE6/VyqjBbm/3vmbgT8YiL0D+HnC8gvIFMAU+BQZoSxjVX55UR0ISOa+eQEM1bwgvJsPqmNF5xo1lSyj6OmEkSYgcWXcLSSEgSsiGsS6/Uz3L9BQoQdd0QLGeVtj1Vn2o1mxn0mjZALhAPiqfBndmzKgESzr0z5lP6o3iT9xxuAyI9Dxo9LvRUy2WXHBk1bzMNfM7mlVyensASeDlv7jYpdEFJV3QLG/cdmS4BRKtkQVTckQ8jP5cjb+x881m0tCy9Lc7BxpB0vX2+lyba9zuDivzUIlBMvZLIHtJjPuE34RH/WDmmJOevK5LC5iMXrTmaa6nS8PwCvIWCdbzeUYB7yzhKBs5D5bxfLX01qJaK60BjUborDdzal2n9P317/jj7WLR38uDXCB0eVnDN4qpiojD8xmnw8iK7uT/DI7cy8ZwtzmtJQo47eJDk3+rDjPpGbkNl0vhjNwf+vUM47ZYhnxXifc/mSLyxEeqU+T95RJrhtc/yNNpZx3Itugdn7tG0Bl9N5OJoZ3gMZP1aF1dDN4tmS6GU8bJI5KtjLrnieg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7f0dfe-d7e2-424f-4247-08ddb89d122c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 12:44:51.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aW47r7w74NNq0VfdVR4EehWhp61BMObM4WAxDFsjJ2KvJg6fKv4szDB6/wulUeLDLKWK9NVmrk17qrjt1ReF7AwQNhcGNgiLEm3hLftQiBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010080
X-Proofpoint-GUID: i2_NeoCze5FojO6ikNGVqB38NEkbn2q3
X-Proofpoint-ORIG-GUID: i2_NeoCze5FojO6ikNGVqB38NEkbn2q3
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6863d848 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=luEh2wFf_zq8CptdRe4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13216
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA4MCBTYWx0ZWRfXwmDk1QNn48mV XmyoxFb4oM7BMWZ5sdz1BehM6x6yQlX/yj3VxwePlSJBPzFiIkewmpUoJ6XgNSrwEqf8nPx2MmW BFOQ1rBDT5Tx9Jauhj4LKbAkbh+RoOnwUA1BB6/b13TMM5lw3yvjzYVIv6WH/JjwMWrHJxLDkqW
 fadbgzUB6DdOa5W2CE9x2h1vqLbTE+BG7iLRLlp5/2UWhH9zEsayxmhgqfpFF4gFt4rCxSAGgki uVOmsa+I55bTie384/NKi+OnuqL5ZKXKib2mMciYBSv4wtVgWMaWMjGjCuy5LSQ1Wjq04MLS9Nk stUpl9+qFxUUNCNzc32KErm65gVCCkJgjarLQ5Pd0wplXxLYfbPQ87VylfErBGgvR3iY8t/o8tI
 VDkMdbQvqRoKvHPofDLZlyNYwzwl75ih0IUzwKOBSOJElRu2HCasoRLA0J0KktuTULCFXS0v

On Mon, Jun 30, 2025 at 03:00:01PM +0200, David Hildenbrand wrote:
> Instead, let's use a page flag. As the page flag can result in
> false-positives, glue it to the page types for which we
> support/implement movable_ops page migration.
>
> The flag reused by PageMovableOps() might be sued by other pages, so

I assume 'used' not 'sued' :P

> warning in case it is set in page_has_movable_ops() might result in
> false-positive warnings.

Worth mentioning that it's PG_uptodate. Also probably worth putting a proviso
here that we're safe to use it for movable ops pages because it's used to track
file system state.

>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Seems reasonable though, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/balloon_compaction.h |  2 +-
>  include/linux/migrate.h            |  8 -----
>  include/linux/page-flags.h         | 52 ++++++++++++++++++++++++------
>  mm/compaction.c                    |  6 ----
>  mm/zpdesc.h                        |  2 +-
>  5 files changed, 44 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index a8a1706cc56f3..b222b0737c466 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -92,7 +92,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
>  				       struct page *page)
>  {
>  	__SetPageOffline(page);
> -	__SetPageMovable(page);
> +	SetPageMovableOps(page);
>  	set_page_private(page, (unsigned long)balloon);
>  	list_add(&page->lru, &balloon->pages);
>  }
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 6aece3f3c8be8..acadd41e0b5cf 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -103,14 +103,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
>
>  #endif /* CONFIG_MIGRATION */
>
> -#ifdef CONFIG_COMPACTION
> -void __SetPageMovable(struct page *page);
> -#else
> -static inline void __SetPageMovable(struct page *page)
> -{
> -}
> -#endif
> -
>  #ifdef CONFIG_NUMA_BALANCING
>  int migrate_misplaced_folio_prepare(struct folio *folio,
>  		struct vm_area_struct *vma, int node);
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4c27ebb689e3c..016a6e6fa428a 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -170,6 +170,11 @@ enum pageflags {
>  	/* non-lru isolated movable page */
>  	PG_isolated = PG_reclaim,
>
> +#ifdef CONFIG_MIGRATION
> +	/* this is a movable_ops page (for selected typed pages only) */
> +	PG_movable_ops = PG_uptodate,
> +#endif
> +
>  	/* Only valid for buddy pages. Used to track pages that are reported */
>  	PG_reported = PG_uptodate,
>
> @@ -698,9 +703,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>   * bit; and then folio->mapping points, not to an anon_vma, but to a private
>   * structure which KSM associates with that merged page.  See ksm.h.
>   *
> - * PAGE_MAPPING_KSM without PAGE_MAPPING_ANON is used for non-lru movable
> - * page and then folio->mapping points to a struct movable_operations.
> - *
>   * Please note that, confusingly, "folio_mapping" refers to the inode
>   * address_space which maps the folio from disk; whereas "folio_mapped"
>   * refers to user virtual address space into which the folio is mapped.
> @@ -743,13 +745,6 @@ static __always_inline bool PageAnon(const struct page *page)
>  {
>  	return folio_test_anon(page_folio(page));
>  }
> -
> -static __always_inline bool page_has_movable_ops(const struct page *page)
> -{
> -	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
> -				PAGE_MAPPING_MOVABLE;
> -}
> -
>  #ifdef CONFIG_KSM
>  /*
>   * A KSM page is one of those write-protected "shared pages" or "merged pages"
> @@ -1133,6 +1128,43 @@ bool is_free_buddy_page(const struct page *page);
>
>  PAGEFLAG(Isolated, isolated, PF_ANY);
>
> +#ifdef CONFIG_MIGRATION
> +/*
> + * This page is migratable through movable_ops (for selected typed pages
> + * only).
> + *
> + * Page migration of such pages might fail, for example, if the page is
> + * already isolated by somebody else, or if the page is about to get freed.
> + *
> + * While a subsystem might set selected typed pages that support page migration
> + * as being movable through movable_ops, it must never clear this flag.
> + *
> + * This flag is only cleared when the page is freed back to the buddy.
> + *
> + * Only selected page types support this flag (see page_movable_ops()) and
> + * the flag might be used in other context for other pages. Always use
> + * page_has_movable_ops() instead.
> + */
> +PAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
> +#else
> +PAGEFLAG_FALSE(MovableOps, movable_ops);
> +#endif
> +
> +/**
> + * page_has_movable_ops - test for a movable_ops page
> + * @page The page to test.
> + *
> + * Test whether this is a movable_ops page. Such pages will stay that
> + * way until freed.
> + *
> + * Returns true if this is a movable_ops page, otherwise false.
> + */
> +static inline bool page_has_movable_ops(const struct page *page)
> +{
> +	return PageMovableOps(page) &&
> +	       (PageOffline(page) || PageZsmalloc(page));
> +}
> +
>  static __always_inline int PageAnonExclusive(const struct page *page)
>  {
>  	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 348eb754cb227..349f4ea0ec3e5 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -114,12 +114,6 @@ static unsigned long release_free_list(struct list_head *freepages)
>  }
>
>  #ifdef CONFIG_COMPACTION
> -void __SetPageMovable(struct page *page)
> -{
> -	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	page->mapping = (void *)(PAGE_MAPPING_MOVABLE);
> -}
> -EXPORT_SYMBOL(__SetPageMovable);
>
>  /* Do not skip compaction more than 64 times */
>  #define COMPACT_MAX_DEFER_SHIFT 6
> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> index 6855d9e2732d8..25bf5ea0beb83 100644
> --- a/mm/zpdesc.h
> +++ b/mm/zpdesc.h
> @@ -154,7 +154,7 @@ static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
>
>  static inline void __zpdesc_set_movable(struct zpdesc *zpdesc)
>  {
> -	__SetPageMovable(zpdesc_page(zpdesc));
> +	SetPageMovableOps(zpdesc_page(zpdesc));
>  }
>
>  static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
> --
> 2.49.0
>

