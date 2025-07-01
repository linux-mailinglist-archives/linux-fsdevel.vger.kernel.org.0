Return-Path: <linux-fsdevel+bounces-53503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A7AEF96D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F681C0572F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44FD274B4A;
	Tue,  1 Jul 2025 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nypnoae1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="znTuhqUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829652749D6;
	Tue,  1 Jul 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374580; cv=fail; b=TaP+2wMzybhChvmx6+H2f6qJAk8CxmdEbQNahqh5EMIJLFeqImUCHQ8AYrJQz0AH+9M7LHybwaiPAGKPGe8gd6a3pFSEMHFk2l2d3oGiiWC+iEONTn0eSQMDZAoqyESnUznhN4DmXj6YMTnMqqMSVNsTTBp0i33JUvxMxEeetpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374580; c=relaxed/simple;
	bh=PXW3yq2zaOQLpbJKopwDCRsZxsGzNfvwDPqAzMUhEIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MrU5bY16Pe/UR8cUMQU7I+jheb/9GtXESxraXA2ZgNzxwaG5IXciTFr+oIRYTdTQjB7WGGPhTxcHtbvUN6+Qn7dbQ7yH8b5g3LuiJ37Iqr5w9Rc/vZPxzgXrYQ05xnZ5QInAWi0WwkEw+py5stY8egQcmjYrZQ7NNXs2DWmV+OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nypnoae1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=znTuhqUA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561CEInY005225;
	Tue, 1 Jul 2025 12:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BapwkHW5bwJAvHC/C4
	6Hy6wdL1vo0/RuWui/YZKD8wA=; b=Nypnoae1OwtaIBYDWKg7EdrDi5PpFwnnA+
	iROp398Th8j3PqpX3OZkN4/V5WmUf2p+V1LZRy+UDJva15oUfQwK2I4Ofp4p5/pD
	YCkvOi08/jbM6SNI7Z4pU/H4DS5D/DEZvUh9TaBAmekJ8OEYbNqWLHvmvUzZQxG9
	WdWKi5IaYC4T72MHzRZx/hAQAyDZPRQPq+2izlQ6i4O1shZ+O5d0HpKCIel6CfpJ
	f/sXlilsx4Lbok+aYFm/oJDTI+PyGEb7SRKxb6pvRBRfj5pOn6YMdlA/k4JEPkI+
	8OyzxaBVa3K1WGvEebFOAma1MwRfKlLk3E72nX1wxAwfnBdMJNdQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af4pu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 12:54:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561BdF4b011516;
	Tue, 1 Jul 2025 12:54:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9fr4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 12:54:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZCDqLupF0lYQ6Orgz5T6H7hTVSnmnvyhcELwTraCEvE9U0zEfcuquyXXzSy+/MpUx5vlgNQiig/KTLUlgna1Yn5DVtC7TiG5k2Hr1hQRwSFSVQXTcsdjT48PHmNgGwqI1E/02i5Nh1NIiJSCQnQ0FLVrmnuJY8bl4L54AoClAWr3230xB8CJsATh1EYNueC9c7Tusxms3ig1nbvuUUw7mLyrP4kG32r6bpOrTX1ieU3Rvggx3L7VH60Ps6+2R+7ik8zHRKjR2l57aVgYGj8pCiPAyiYf7aTkz/YfhdHs6IgCtwDSVcM3eTi7S1aXwBDEEXgw06QTDulDg2pzzb4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BapwkHW5bwJAvHC/C46Hy6wdL1vo0/RuWui/YZKD8wA=;
 b=L5Ss/cDreNxZRtWgdoqhXl7+jnHfJT9SEJgKF8kmvE99yyLn8Az+NbX7ryauIp+0ttGqkzPExPL9MH1R5BlQz67/vB6+ayIIKajCl/XYJbTAqjWX9ZVrKj0HtSC5oPXEsZ96z66pAqhtf4v7boMdAM+nMzQ6NqLbiBT3bt9ZwncoTWJja2CIWrIAqjbWnAfZCgE8xh9+LmEtC0AFtxmnA2YTcYKg/FPprdrdBXgFwR4tqCvFknx/8TyUWd467LHiMMLnSR+vse44TtjsPYzh/RbvHYqsO1F2x0DYMcaA+rLlLHnPnDqYpiRFGXNXVJx/IjttNKcRqgsF+k1ksB58QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BapwkHW5bwJAvHC/C46Hy6wdL1vo0/RuWui/YZKD8wA=;
 b=znTuhqUAbjANv2iJes3tR9idoVDJCti5S3Njsz8MIQfO+e7d92p0ud50X+G6/MbCes6RG0H21YWHPBpwc+4s6mhI8XQPVczHrfDPFacSx5FeDOIj8TnnWKYxBOk/R8QrqikxoPnli13wLd5lahZY5Py7zJSpL0PigO4jzR/yy0Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6524.namprd10.prod.outlook.com (2603:10b6:806:2a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Tue, 1 Jul
 2025 12:54:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 12:54:46 +0000
Date: Tue, 1 Jul 2025 13:54:44 +0100
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
Subject: Re: [PATCH v1 22/29] mm/page-flags: rename PAGE_MAPPING_MOVABLE to
 PAGE_MAPPING_ANON_KSM
Message-ID: <5357d4d9-d817-4351-9927-bcd03794964c@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-23-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-23-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0542.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 85828f5b-826c-4800-bba2-08ddb89e74ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7SDGgdP+1TcivbUO7iykjzRXqOTIFNo2f27nXqCXn1m+geJ4G97khWuz/pwb?=
 =?us-ascii?Q?jvQidO+BC5AvL/IMz37ijdBkZE8ZbwRNzUxNyXi0r+Y5QWdHg8oAv/bJJ4Tg?=
 =?us-ascii?Q?O0J0hzo41q4OU0RZMe3v4QtdUlgXWZVUPv00/m7YddrOH970cSxo1BQeClmY?=
 =?us-ascii?Q?barv0402zkG/vqN6fR8ZbCszOSEvXoLcW8OOWFNVMXlIQG+r8t9WCSCcBrmm?=
 =?us-ascii?Q?+zUJD6EK49+6+MFUfQm7rjE/vn1rEBTlE/k96uVPCSUALdUl9geeRCA5uKzV?=
 =?us-ascii?Q?uimWOU5QS6wAurh4l6ZuH9Ubsxsn4diRS5ZH9aMgqPJf2YPgDuU8na5HWRfA?=
 =?us-ascii?Q?8gx0U4izApEv+5TyIcnIpJYf11IokrMMuoCqeAYCCLYOsiubByhY+vqyjHeG?=
 =?us-ascii?Q?GDy+bcXrwjGr50Pzsd51W4Jz9SJG3Bg3PVKo2VX0QDA622h3c6tMRwJQD+0p?=
 =?us-ascii?Q?mLhucqmxYVLChtXaLC66ZAVdv5Q0cMSM8EMeFSVSqjYxM4MJwouKtDiXG2WZ?=
 =?us-ascii?Q?OZlzcfUbJrqN8DDrqNSjuNqxE39FA0s8OmxwAc+4+OPMYeJtauDbVzGugYXr?=
 =?us-ascii?Q?GKDXInBmu+Q/QcHPGJ1R7Fr3XTXg7QoltwPsf7n9qhQ3+I0YdHUTYUdfZw1N?=
 =?us-ascii?Q?grUadxgeRUAAjzpY8y8cau5ygeF+sk6saY1BNYMBIZpkcGDXVlLjQlOewIrA?=
 =?us-ascii?Q?9FrI0Q/9QkCiTE4zyyvmRYFpaDIG9IR+3KzVq0xRDadvPjlC+MUPTsEVJDgf?=
 =?us-ascii?Q?3gpLkb/d2bJI/kpJcrWC+TbsAZSSK5b2IPkg1NVNEIM8d1RIEdpvO9re6BT5?=
 =?us-ascii?Q?Ek5sU/F//gIG+yH2gcKFdi039Aipfvalk9DcQz2e6ADIB2yFdDNJOGzAZmdl?=
 =?us-ascii?Q?S4/mheodF8Tfd+3r+H1sOX8zCSAV2tf+YFxMt4U5sgmzjHqiEYvGYWoRBVFK?=
 =?us-ascii?Q?mI9qGY3ewb38gQZ1MEJi6rz8XWb2M+k7mCfhop4kodzJPBHzeai7hBtnZIKs?=
 =?us-ascii?Q?y0/Zwrkx3Hs6G4FZmDfPC//tZfxZdNt9xBHAlektVixNl+QX/SIPvV3PC7Z4?=
 =?us-ascii?Q?2UavUngIRpM9Uo9KRDr2Jx15/ZHu7DkhDvmQvcZIALUQgi4jZlXFxMcuY83a?=
 =?us-ascii?Q?kIUWDveMCllVQ9T9UvQKP+aQiSgpIkzRb6eW3TIyOQSTA7Fkou3Im/U7Tbfq?=
 =?us-ascii?Q?1YoTHqSaHkn6z4rYqtHOvbLP7fXoGv3H0x3sfELigFgardwhPfHCHFk27WZ0?=
 =?us-ascii?Q?a+lJ4UPT9+Iuk4s3m4CkxvkC1X3CYzK7a/xaehCoOvGzApLmkXQ6EaSgFCvF?=
 =?us-ascii?Q?B8OCxteQvfoRh4Th+huF89fpG1OHaFGF04n6W2f5Ybm0329eJUnulalZ3pYe?=
 =?us-ascii?Q?hQnqexL6twpBVK56bUGHFW/GWegcIWtZ3w2aXtUtSyMUQPRhDZtbfawfoWqa?=
 =?us-ascii?Q?has7xqM4l7M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nsjRHb4gXAeL20aq7tMuKnG5oyy8UCYT9BfEviCNHDOkxeLuZOF517tgPogF?=
 =?us-ascii?Q?gn7itnU4jPug/ga/ytg1S/FhGwFVrVxkWc4u3YT61vX12TxOGhkhINxN59rT?=
 =?us-ascii?Q?vPPbs28PKsntMrmkJxenL/w44p7MDdOu0YMsjKXkyWZJofWoou7JAbclUQS7?=
 =?us-ascii?Q?BIJra2XWEKGJKK+F3hajo0gY1or6TZu7cSuAmwikF5i0mnUDuznEvfpi2VwI?=
 =?us-ascii?Q?iJMSNAII9tTe0XjKl3WEml7rbIeUFn7F1ao1cg5UWr1Ii1x34vWroFTx4FaT?=
 =?us-ascii?Q?W+/5Gm5r5VHZ3rVR6HC4pxG2Xk+5QLjiWTvD7WVh+cNznauLWVCuyfIlSFg+?=
 =?us-ascii?Q?DZ7SIGF85Q+uhhgylCL2kNPq32beBuYxvbtrktxjAd4rWBg9KbcHOHVjauOY?=
 =?us-ascii?Q?Jz2MP+C9FKxBAPJ8oOkAqCZ9ZZwbrh001e3xyFFyhKFna070sDodUzicQW4f?=
 =?us-ascii?Q?yO7hv0F5olXIBQPBg/UT0J96VRh1XmQNURUaMY7Vnm/iPxZ9vJgiTiCMzbVH?=
 =?us-ascii?Q?qlOYK8TKMsouXZbCPsnieJ/QNE6BwoUDIaiNvfeU7IStOEHo5AKFIGNKRUgR?=
 =?us-ascii?Q?sX7+V3ZyLzmyfKNkgCJc41w8TDsORNZTOidix2sqIZ7cpYEI3g0/widw9lxD?=
 =?us-ascii?Q?h5h/V3QE+E3Vp4QtlyBOaeZ36JhrWvmFtuQS58KHfgR6EX98yCdzQBRTRM/c?=
 =?us-ascii?Q?KF1U9oT2ve0PptWx2EYq/DoAo4XVxp4/pomCjel8Y5JEV0EVBoZb+r37Cfn8?=
 =?us-ascii?Q?qY6oa9I7ZsV5OisADjfLQ1wBfKCpPsRMoxqVubmJs+su5P/nlfOwlx+RBbem?=
 =?us-ascii?Q?vhafHximafMmBshmNSLLawLUbN03JZdcmMjXhWhNfSsoc0pfYp8BqX59rGoz?=
 =?us-ascii?Q?zre/eQADFCKa/XCeCGNQOXctT9oSHT+psbBDRhyo5f2ZuibhHDQ3+A9rZbfB?=
 =?us-ascii?Q?+GZh4Kv9GnkYzMc46owPrxEfeOrVjPPrdHJdHMsI4VwMFdXWTtDSj7Hx42kC?=
 =?us-ascii?Q?yJUyUV+vsgi93xl6D7CjQKnLppL7DH6j/77uyhwAz1u5v4FUtcqqBd62dBld?=
 =?us-ascii?Q?uJUPuF2c7PAQ7WaBBuxuk0nwbQK66dPWCOhjUEHcaFxx6BhK9CxAl2FvOo/d?=
 =?us-ascii?Q?MaRjYF4JY0vgiS3DaT4cMUCoxmxUcFqcpcxwv4StqGrnAmDoE6yh+sZ3d8FH?=
 =?us-ascii?Q?3FySCPfYxFuskc/PfbTVElle+CWLhy39QXSVD5kBCmtez5qyjpl0sJbS8dEy?=
 =?us-ascii?Q?HUSjVev6u7yKyuorGIw7YNFheqpybr1B5AcH4+nABV2nrSuhPwRDK+sa3T3T?=
 =?us-ascii?Q?7GWWAuRORLcxI5NuLZusW23xIO96SzdX9sTcp1cG6zz4I6bI8N2Ko/Ig/6Wu?=
 =?us-ascii?Q?ZmjG8IKhvwYTEANQb4Bin7ysyqKd3nISZmWaRN9NzkhrPQwVvzGrbbKo6U3w?=
 =?us-ascii?Q?Ih1saBNzDIbqwChcjiTUzdL7ldcEWs5R4rmgLxS0kzKu87dVXOqvCWSjob4Q?=
 =?us-ascii?Q?HO5GM7mYhNdLZKZGH8DoLS1uutGll0mimLS9kdBMxDj2yc5y+1/qbS8mhQkT?=
 =?us-ascii?Q?ozAGqUi/7QkfSl0ANQP/AD4i5xWlzF3Ers+Ih6h8ML40YGBAcIiDXAOHfgIV?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zXkStvBheCcuw+DaSI9yO79l+gR8w+T74PbQ8Fl1PcIk8P7K23t6u1462EgxAo9jNzeQ9dyIUTIRMFCWZSYP3xZvtyj9QKfT5awAgiq1kk56QCQT3DQhd18B+b4dEub2RVn8Zs66yRpzMLo/bwZq4e0D4vFUBataX5Yb3m9dQeWv+zfB7kClzefEPRcISS3nl25CiHRcMX4LAePcNJ+JqeBdFDoCBYYkXbGO1h8LBTUC9tKqUvnrLuPiZZxAnBadjxminb+0JLGlx2Ow5lsa8hbB+C1YZitzN7NYypIB1f+89eIyQBb+QxW8XzslA48XmE1RC8Wy9hsg1ApQEjxWcR1Q2RLK/OeuY+pc8NAht+WVMNy85JSkHUpvs3U7qYSZUsgYEEDJm69VjLBGjHd7kaUiJaamee/wgVhV3K0C6BNnBBqe9HyMmliTuSw/3oeYRLH60bscAIGzEnagmsRs0SFn+x4i0P2N+Bn9/Qn/8lqtEN762IEzR67csObnUK28Toiiv2tvQlsfwvY0FrPY4AsW+lcns52YwLU1zaMSh6FH4wrjtRHmw5SVjvYPP7vXV9yI0gpCh3IvgMOEhxB/t9SoELPeUU+lngh2/iJtk9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85828f5b-826c-4800-bba2-08ddb89e74ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 12:54:46.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFh8kYRnkT44nTnIB0lUcAcfz1dOjaEviVEpY9vW2fwWTXEcoIYWreybpV4GehLnxMtvisLR44Z7JwqHqOKu6X7G+k8nwtsVO5VC3RO01uM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010082
X-Proofpoint-ORIG-GUID: 6DACwjNE4S4w9ILPEBJ9-MbcqFj_1KWe
X-Proofpoint-GUID: 6DACwjNE4S4w9ILPEBJ9-MbcqFj_1KWe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA4MSBTYWx0ZWRfXxWiwQNloWOmW RYdWiokMBsy/TpbFUB7xgZIUbEK5O0hTriP4AWGiALSF/RGPdkhjwEYzKRLkK+cLGp37vu0Fwiz KbRkD6OB4/P+SftI4BPYFCnJ8AbAy0mlU2d/aTJZNdcQgLQ/fLr/HneiBqpe1o6lV1fLisFtaC1
 mBmgHexW19II7yywcPOkRByTNRce7LdrR2djfxwANLS7RZNdUBMJBL5SksVPVtJBaN/SniJusga LQfsRTrWrC+8+8d9ukUDshn1OKFSABJBeHEXg+jwUUHET9P9VGMHYoElVfks1Mxd4QvCaRnMOzD sfY20X3srghuVI6dMLR7XDxknBhZLwaVUApE3SRagyfjwmnHNCjOxxr9qxBvG8/KYQZZftiNpE4
 JUb5na7JNRFALMQnnxL5VWu/anY4TlkXNS5lzF0IRy2yMEG+tGvVvS7GmgvIHWYRVMjx5Nd7
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6863da9a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=wG82Xu0MxRqGbWdlqRAA:9 a=CjuIK1q_8ugA:10

On Mon, Jun 30, 2025 at 03:00:03PM +0200, David Hildenbrand wrote:
> KSM is the only remaining user, let's rename the flag. While at it,
> adjust to remaining page -> folio in the doc.

Hm I wonder if we could just ideally have this be a separate flag rather than a
bitwise combination, however I bet there's code that does somehow rely on this.

I know for sure there's code that has to do a folio_test_ksm() on something
folio_test_anon()'d because the latter isn't sufficient.

But this is one for the future I guess :)

Nice: re change to folio, that is a nice cleanup based on fact you've now made
the per-page mapping op stuff not be part of this.

>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/page-flags.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index aa48b05536bca..abed972e902e1 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -697,10 +697,10 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>   * folio->mapping points to its anon_vma, not to a struct address_space;
>   * with the PAGE_MAPPING_ANON bit set to distinguish it.  See rmap.h.
>   *
> - * On an anonymous page in a VM_MERGEABLE area, if CONFIG_KSM is enabled,
> - * the PAGE_MAPPING_MOVABLE bit may be set along with the PAGE_MAPPING_ANON
> + * On an anonymous folio in a VM_MERGEABLE area, if CONFIG_KSM is enabled,
> + * the PAGE_MAPPING_ANON_KSM bit may be set along with the PAGE_MAPPING_ANON
>   * bit; and then folio->mapping points, not to an anon_vma, but to a private
> - * structure which KSM associates with that merged page.  See ksm.h.
> + * structure which KSM associates with that merged folio.  See ksm.h.
>   *
>   * Please note that, confusingly, "folio_mapping" refers to the inode
>   * address_space which maps the folio from disk; whereas "folio_mapped"
> @@ -714,9 +714,9 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>   * See mm/slab.h.
>   */
>  #define PAGE_MAPPING_ANON	0x1
> -#define PAGE_MAPPING_MOVABLE	0x2
> -#define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
> -#define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
> +#define PAGE_MAPPING_ANON_KSM	0x2
> +#define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
> +#define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
>
>  static __always_inline bool folio_mapping_flags(const struct folio *folio)
>  {
> --
> 2.49.0
>

