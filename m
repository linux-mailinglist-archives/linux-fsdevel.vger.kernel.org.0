Return-Path: <linux-fsdevel+bounces-65568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A80C07CD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 20:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0EA3AF975
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 18:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA4534677C;
	Fri, 24 Oct 2025 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f1bhevJb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XKbhdnJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1799616F0FE;
	Fri, 24 Oct 2025 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331544; cv=fail; b=Mid5aVjTCtCg8lW9sg1YjtF3X8BWAkIaIIWeT0HiDuIgAILcujcyBAnKXI6MKg/NFuRImLnWgob/QQFMISDuApIUEz/yxN5QmWRs7/2GnU6k/fPhxsoj64uZ1DBGE49IN0B61IPAK65mbZX6Rz3y3+0i/P6nVMEe3J7Z+M8he3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331544; c=relaxed/simple;
	bh=sR5xDp96Afo2L6OI0/meja10BfhtjIjNh4rBzMU0Cy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i3++llPCNFwwI2cRKo5Hncg6Vz4/WwgOMisAaKNg0dQ3FmFGouyo5nie/Gn/RBGLpUnQ88rmvoNhpXVUi6HYKqgbuENCfSsvPfJCj2+t4qrqhwuYd5lhzER1ZV9BkPnLP2iz2Vmjpq/wya5aZ/CkyfD6PKhU5jepZ9rVKCnfEG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f1bhevJb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XKbhdnJB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OINDiU011453;
	Fri, 24 Oct 2025 18:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UKtFvKETlyUXEZZDzV
	Uj++4BQUXao5xJZfmoglt6tuM=; b=f1bhevJbvsQLTTe8zsdEy2wap4T4MixFvd
	+lE0pPjYu51hqyPRxt+fOISraA8vUbObmIAwu0b1KG0oiJ0b6Y7YLScd3CeBX2Tf
	WN9Mgk32nhb00M4VnjOtZPrzsvjkRDccYtSHHeI9AVKA0sLypk71wZnrgrbP6wKn
	eoG9qpCDQYDaVPBC3ETc8DD3H4DB9WjG2kNsXRqWGUfeHpFVe7dVgSO9IqxtXn+2
	NtTsLpqkJxCAvIQDTQHoncR74FFgmuRYklcDVA9Pt0nCKAoHTr6Y5VfBP/tFn18o
	xWGxp4dAnLb4HWKzy/rywAMdWfFOeKYgcWbDnuOwFyilt529k18w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvd0wdxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 18:44:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OHp8jO004553;
	Fri, 24 Oct 2025 18:44:48 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bg8g2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 18:44:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qB4PaZlpIP85HY/ZIVYS04VXcMrjTZasGKG2/iGPPRAnECtK11q7y5Hcu09ViqTysZb+fTtsvhVUioivECmY+IqTfAf3AAc/CQICjJik+5TGKIByZb47FwNZYxxs47qz/r4skOmjuuKio6ZAiz4FKT9wZ9Lno0ZNBixBV24wF9BKUpbbZcellLyiYdodrVLcJcFFb5Zq+ui6z7sU//WH4fSE3VzIlr/u7v9clSlgjZZhM8ifn2V6I8NOQIGHFc34UlPGJo0SiC5TnQZrfXGl5qSj+jwhI+bZkv6Tqf536S/E7chFrZGW41RCEbJFRK60usmcCvpbvvJVRArM+PnIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKtFvKETlyUXEZZDzVUj++4BQUXao5xJZfmoglt6tuM=;
 b=BSmC0CzsdSTPc+kIlSu18DYLKrhN9fUGfTEYOW0+WNPoWgbJgtuH8mPMy81Mz9EZ0wjPqkQGgaotFjV0EcSwYlklBsdoGXd9snqGHdYxKl6awYIrGnUPiLJ0FqpQnPqEpIsLr3Ehk8NLRddygVlTn/dtPE0ub2v5RWtIVkAgDVKZ2KIX3iSqw4OUqS9A6kyhjx4pl+KlPB7D8rrNzbwVS8YlZVk0jiD8wRnpAbwzbYACsHNTBIrmQ9IICmblYzOgUdFyzZdiX6SfOOYLPxPHHxI/Kvh4oyeyOELZh/DFrZcExxcmRy74Zb5iSqp6XCCgHimpDup0FHCyYLRO62Z4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKtFvKETlyUXEZZDzVUj++4BQUXao5xJZfmoglt6tuM=;
 b=XKbhdnJBZlfzpem/VBvvA4H4so3gEB2lkfa5+GiUrSpYzcmEVAJdw9/wKpMJANUqZskeb+Q+BvGPOUQutRYMiNb3e2gmLOOdsZFK9ddlqp/DOSopYQ1XIHy19cv3Urr44yWxwT3yFtRzdN0Q6kxNsiQq0C4xHdMe47oJj8+7TcU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4331.namprd10.prod.outlook.com (2603:10b6:5:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:44:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:44:43 +0000
Date: Fri, 24 Oct 2025 19:44:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Gregory Price <gourry@gourry.net>
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
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 09/12] mm/huge_memory: refactor change_huge_pmd()
 non-present logic
Message-ID: <2563f7e1-347c-4e62-9c03-98805c6aa446@lucifer.local>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <282c5f993e61ca57a764a84d0abb96e355dee852.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPvIPqEfnxxQ7duJ@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPvIPqEfnxxQ7duJ@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: LO4P123CA0662.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bc5510-1622-4c70-0c22-08de132d65af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cg4farPAMZ3y0z36cC0FGTZRcOcLtlFaM4oDM/2irLEHMCQm52e97CbiROIj?=
 =?us-ascii?Q?TJjkTQ6Hg4sO6QpQF4xQgKzJ105HfpDO46kPPlb1Tfr8cVN2SM5NAeVC4b2d?=
 =?us-ascii?Q?M/46tQBE+WopvvD3/p/Rx3OF6C1tYIc+5YQ9FofiMMbMcsZ/8IhANFOMA6QR?=
 =?us-ascii?Q?z7Jtcb1WxH6ITloZ5iXAlM9fHnWrVFuIDe4hXshwy5P46wlCns5XBuwwDm4k?=
 =?us-ascii?Q?DFH3k1x4xKXKZJJVKHZn8k1T3rvv+LUHUkD82SBdusE5/auhq5wfVvaB3o0G?=
 =?us-ascii?Q?rpeD46o9WjZJmmtptFsamUXiOPj+5atw3U9i7vF76EPZEywKiGcRM77uPrEU?=
 =?us-ascii?Q?ZiBU3U4UwShNu6qXmgr8joiQ9kJtX+8EmCWMGqC734v8lmTuZS9H5oskCFm3?=
 =?us-ascii?Q?1BlaeWWowNpoD5PfrFPzN3afGpdVwp7nnCCI9upllvXnunidkH0ndcUPNzzb?=
 =?us-ascii?Q?emUhaApe19GN8ZR58TpEB2XgnwNyS6pDuRDNgY/FRe/X9y9n3HXkNt82Cge/?=
 =?us-ascii?Q?Ke+9LaTbszk0m4VALUB/6AYaJOeX9M3O+jyvi+Rj0eYq7UlfxzlGM/6aks9g?=
 =?us-ascii?Q?zl8Fv6xC5bM4ZaXfkG+KCMvZAPecvuDctHzVuqVBj7X5r+mqP4grZDLcc1nM?=
 =?us-ascii?Q?/jUsUddo+cCcTyBwKpg2DqSjVu/VIkBy0E2U7hHHg0pPWPHSuLB2PQhWMYJy?=
 =?us-ascii?Q?eYeX37pt86MLFar4h7dbTSwrhad2lSv/Dzgv5eMMOlc1S3Rv0Wg8fhO1wfQn?=
 =?us-ascii?Q?7kxXa8lC0OGIXzZlLCOuIATnjZrNyaDQKeXMxan0jywn0giQWYJwabD/m/hV?=
 =?us-ascii?Q?WTcIh6L4A+xU7u7Ny4LOpK68+cgW07MMJAjFtgvu8juTsO/sQcCUf6aFf150?=
 =?us-ascii?Q?QWqdAaN4WfRtSicCEpHjRhYQ4Nfbif4NIO71hjDqBFJQL8aQuFkO6QAIYB6t?=
 =?us-ascii?Q?OmszEPK2To8jhji1xTbaPlrUmPGonhnr47P5cjRxPafOphfwqrzCH0Tuxv/B?=
 =?us-ascii?Q?Ym/y6VG1t/HcwtBT82EMcwpN0Xc3kBgq9u/I6VZF7wdnbxVCnIytMgrBEznn?=
 =?us-ascii?Q?ZG13L6OnYPF8GspMa/xamBQpHWKMWxayr4W0vdaS1ntVhIANLmi7ZfI8VAuG?=
 =?us-ascii?Q?Th+CHR3wYjWTeRl1DfHsqc/oLRfjsmgzw4n8p66UGeMzBZ6S/cas/D08p1ka?=
 =?us-ascii?Q?Y5McZ4GZAaEmKMibsM4ZKYC1NlJzVwmj9y5/KLKreUUJDmvatFl+uTKpuph0?=
 =?us-ascii?Q?Vx5fxFE+Q0snLbjfRsu59K2dKDzMU82fGPu8p4Bl5awi2cWOzhFgJj1LZNtV?=
 =?us-ascii?Q?DcQz2dI3nFWQQOQdz+1sqgz8hDOf6+Fep+o00G9EJrEh9RVDB2WH0y4OoVfb?=
 =?us-ascii?Q?RE4OZgeAuw8T2HCAh/7UnGSFlhJYHSo1gLxT9v2y67QR2XArFctxoyimqzm+?=
 =?us-ascii?Q?+I9MQ5jSHNTCwNPCH71/jHPYbjLW4ObW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U+D0VA41YjQVRO2fdcdT7h08G2uNfsrwcqmdxRudhJxEY/b9Jo3quvPLMv60?=
 =?us-ascii?Q?eJ4J3Pe8kePXH5sYzLw+JuZlpYcQC9sqxbs9XzhB5DPG8VKJc2oEjMBKaRIt?=
 =?us-ascii?Q?ff15NPLOoEKwWSpQW6T8NkAZAsH6U3E9ToDhXw0nMUaNR5hifxYnKFij3xmb?=
 =?us-ascii?Q?B9gB7d+SxihKZs5xDCwH0cnsnDBw5BhVH6v5+gNVkYSEgAHOP4DUzcmtdZuz?=
 =?us-ascii?Q?Cp1ZcHPCmXrWabd+2aXQiLlSELYjdENjZ0+TS6iEbpxizzGAPNu/O7zYzad7?=
 =?us-ascii?Q?U1V0L7Z6Z3aIobF/c6wLGTtb/RmuJT040QcyZJhym/Ycr7iSjHpGMRjUbEgI?=
 =?us-ascii?Q?h02IipJuBN8O03fo5y5F2aQMrAN0DH5HtENuwC63UCZs+bxD1QGj0/9kibyy?=
 =?us-ascii?Q?glG1pZqZxRJykL0Xq3xYuNp+gowxiTiDLOwVS5YQSjRtBtxJ2NmSBmtWmOox?=
 =?us-ascii?Q?UJiwCMVAgOcXWkvhlfzPbJAtqa0ziXY5Q6+SHS4+znsLMZ0DgeYNWws0QQ3y?=
 =?us-ascii?Q?3QI1FNYg6wJ3UK9XkKB3LWZlPRmJ+SCHvyzXAvmydUgSePhvmUgD1VYwYpDH?=
 =?us-ascii?Q?Ans61kE7mr8WUdETwV9qp0ZEV3dm2L30uGWEuzwII426j6iMvwRXSK6fAcKr?=
 =?us-ascii?Q?Gj6LEA4o/osIOs0et0sI5/u+yiT0Ig4VI+QkpevUs4cEcvp0Y6rc45RP1hb9?=
 =?us-ascii?Q?DOnMjBmIX4Q5Q4R7BRrkrzrxLY3Tp1zl5y0fV3EqYzeh+NF89mpEAF3zSpla?=
 =?us-ascii?Q?9tp35R1QtSXfGxkGofU/+R3bx9kSsfQJ7ro6Lz+InFhsLXMfs/UeM2y4mnVn?=
 =?us-ascii?Q?SntcNE9rHXq6Toc+vYtQgP0S1FC+5tElDeui1ELIhZONZkFqILSgS2TVyYJl?=
 =?us-ascii?Q?K2NudYPeASDlLasQ5LlEz9248aQAXgDzZv5zueRFLZkHuyIhFMwwavvPEIdK?=
 =?us-ascii?Q?YNJxTbqR1RMcIeHc9EPrqR9i+jxCTjIeM8gMuR04aOABw2ZqWNqlyUyBK2Ro?=
 =?us-ascii?Q?Wq03gwM2FoFozwoZ/LplHssFx/19Ckwycgr1Vjnws7wAUNsUBoI2kc9ql4aq?=
 =?us-ascii?Q?QNh616SmYv+CkO74KnbPb98KD8TGiW2FaAcNHhr/5qM8bLm1DEfEfS+NjC8f?=
 =?us-ascii?Q?HEI27Bo0tKHYEK9EggQxezmb2u+iOagDIvz2Aj2KgiJNNdM+uuIx+cixGvCg?=
 =?us-ascii?Q?bFjMn3I7BB/djZ2cB3hRPeolE+lMDKsCbHxWhBIUPbsLCs4Z1uEzf8om7hbn?=
 =?us-ascii?Q?6crZ9Z2UlO+KOFxayyY22Fe4BeTiGvIHj3hNu3bgPEUn758KWHo/QJaLR0AB?=
 =?us-ascii?Q?0KNs7JP4Vv5KNxxVNu2P+lkD06BEKyblZDjLKQzZrh37daPAKIFYlhphUTc/?=
 =?us-ascii?Q?62eyq+juLMiI7nn/+3sWQJCjoOsuriOMYEMi4ZWpzD/lnK2hMNAtVp9Bzk8e?=
 =?us-ascii?Q?lgzNS1QbIocmo62suqFThIDRUQP2F+LxkzKB3WekeGDZazUbB85sJE4oHs7g?=
 =?us-ascii?Q?yqOx51cLOok7LPogb0wzOv0TwhpX+oeaCeu3Q+jAAaqwmcbGY3ZewMFxASe+?=
 =?us-ascii?Q?cqS1lcIh06IXvfp0veNd7IBKmBHCb39cw3F9PqbuZ9FgnbQI/YlI34sCW+82?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q2FHWjIKVryMk6OEhO6pa5zG+lhwvOeFw4aZclKsEg//qdqp98+noreQGkEUFZHkZ1l3BAQa5KUhBkiWpTtmSEVM1RXb1ML31Z5o+77ujFQlIL2cr4hcWm2XuN5YfOYC/yvaMDGZlkMe+8/9oHmNU808UE8UbdDAkAtgTIMAuy2CHIR+lgGW/I+jfVzJVaiVeOwyDvCC4qDCUwSusOEReEqz3pk5vGI9NU0b5NEZLdbheOvGUsNrL2DTNBOP8gQgZMSr8WeMH+6c9Z+wUVnCQAJ9Oh0hC2ZFNcSuYXqmude9dI+eGAsFV7DDi8iWkfNetAV+ZeNhQf8LKI1zOAPsUip7WmEZNh+ooHpu54BrCM2n5NBIN/QDkf/1t5zFNc/T3dUFl0aiqjx/zUvxjGfCWAQ7Ocoa4svL+ofAhEA1QeCBYyDTVJTs+J6UUubcebr41JzU9g0nl3MQvzVOQOZ9tE4YMKo72eu5DkOgzStx6zAhGqmWD7z3ncJWzPZRD/rAb7gIPG1/pgYF/sHtNpkTguWTu+QX7RkOKxndZYitIgBKXfLReGq1Pataa+B/TWJ8FOXwmF8qqnApAUS14crXkVACfRU6PhEAFdBiXQY/EvA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bc5510-1622-4c70-0c22-08de132d65af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:44:43.4282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwiJffldfE9gYvSCEKiguI3y+uC8Ka9Mmfm4M4CCbxuz+ieS/RH7JXo2HLEB/CMRllKoyGo5FX8YUqG1jpq+lE7fVrMDBZWQ1Wz6q0JcYmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240169
X-Proofpoint-ORIG-GUID: s39Gr7M4LIZK_7p0ptii725ZKuehu5qF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfXwTPDLcr22r6G
 1HYbI/Xw47hHVtrIF0FwRvlJLB5BhabcswuRt42TVNuyM1uaAWcyfNy99Jf/wLYXgUWaaCGJoGl
 uxjQBWhTQ8FMo2lndRQv8ljeJq6q3EfedDvXeaPDfO9gSGHVX31jpSL7shoFfj+eJyDO9cWNrE+
 bWbXzMgYsaVwyCpQYIu9a4fs//DwctTSIG4USMWMd/4LBKdRkBCA8gd+QKvHtpxWRt8wySX23NI
 YrTpJs/6zZvJnPIgVYOuXy5TmB8nZUmaTIk+T1x6Re08+zDy5IFn7S2yfNUVcFy4zCEJbESdOYT
 iZGeDZ9tnoIewY+/bv4yuqqa/+S5rBwaCLu/uuPQKz0JOEyKVrNLw8rd9aO7ldEtVQWQbZGPPGK
 AUtQ27fbP1OJSoVMLsVCeqXp9+c6Xw==
X-Proofpoint-GUID: s39Gr7M4LIZK_7p0ptii725ZKuehu5qF
X-Authority-Analysis: v=2.4 cv=D9RK6/Rj c=1 sm=1 tr=0 ts=68fbc920 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=sqH0XcB6KZf9jAxATR0A:9 a=CjuIK1q_8ugA:10

On Fri, Oct 24, 2025 at 02:41:02PM -0400, Gregory Price wrote:
> On Fri, Oct 24, 2025 at 08:41:25AM +0100, Lorenzo Stoakes wrote:
> > Similar to copy_huge_pmd(), there is a large mass of open-coded logic for
> > the CONFIG_ARCH_ENABLE_THP_MIGRATION non-present entry case that does not
> > use thp_migration_supported() consistently.
> >
> > Resolve this by separating out this logic and introduce
> > change_non_present_huge_pmd().
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> --- >8
>
> > +	if (thp_migration_supported() && is_swap_pmd(*pmd)) {
> > +		change_non_present_huge_pmd(mm, addr, pmd, uffd_wp,
> > +					    uffd_wp_resolve);
>
> You point out the original code doesn't have thp_migration_supported()
>
> is this a bug? or is it benign and just leads to it failing (nicely)
> deeper in the stack?
>
> If it's a bug, maybe this patch should be pulled out ahead of the rest?

No it's not a bug, I mean it does:

#ifdef CONFIG_ARCH_ENBLE_THP_MIGRATION
if (is_swap_pmd(*pmd)) {
	...
}
#endif

Instead of the much nicer:

if (thp_migration_supported() && is_swap_pmd(*pmd)) {
}

Given:

static inline bool thp_migration_supported(void)
{
	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
}

You can see it's equivalent except we rely on compiler removing dead code when
we use thp_migration_supported() obviously (which is fine)

>
> ~Gregory

Cheers, Lorenzo

