Return-Path: <linux-fsdevel+bounces-67193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A85C37966
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 20:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC79D3B5B46
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 19:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31713446A7;
	Wed,  5 Nov 2025 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uh3ekq0X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oEohbvK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D232D44E;
	Wed,  5 Nov 2025 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372550; cv=fail; b=GiNdJg3nU/tUpw7+3hcCluoeYbL6btubHqIfPaoZeMIzmFckPEzMDECw9V4dLFtKGasEMjegMpaSgdiFdsV5bJy46foh151dhzjsmm5rMYhqMI+0v8ddPgwzkNQltzhl0sO+nqEeDwCJ0rs66J9GVyfRxQm2pMKo9esbWdmKh7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372550; c=relaxed/simple;
	bh=UKfo0XzdT/UR1CN77MwEIvxgLqx4Bqzn1WBhZdkM4XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S8amf5owNAIiE0f08rofHJxpkyWa28m8SSug0EpjKx3vBzQsRoWMdMK7Nt9Y08m135Ji82Un3H36BvPTUR3QmHl4O7tgXHi+ZInpJdB7N/FUTtCzZF0up+qUmbFrcfVtDOQulZNiK3uwh6vtjW9sHefhkTdcuP344V0OLqdQAeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uh3ekq0X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oEohbvK2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HdmFl017480;
	Wed, 5 Nov 2025 19:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UKfo0XzdT/UR1CN77M
	wEIvxgLqx4Bqzn1WBhZdkM4XY=; b=Uh3ekq0XGCms4SChVWeBr/GrAcVnUEwhJY
	vh/hGEP4w5iXzCubZ3KrgifnB5H27heesOxxGt3giGzpSSU2Y7bLJYGKJ3HxyG6g
	KFbVg74zgPclkNaLPtY0PxP8Bgt7q0OhXkHN6FrWWXNyNw97Q8EN6K9ND8jQLZf8
	ut9aA1tBfn/N11v/RiB4RhqHcVw07pKOhb4ztHlWk2znWFHlhaGsuA2VWMBZiPUS
	5MLSMZ1DOyK0CeFhjD+UR/ao8MLRrFfhkPDjcyzvgpjT7OHcyYH7aoznjl8HM8H7
	uhp9Xhj29VNmtibbWpMe5WWtKKF3c8nChTwnurvAJH9505TfFQvA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8b5yr9fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 19:54:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5Js1l7002636;
	Wed, 5 Nov 2025 19:54:48 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nf181n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 19:54:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFyoTA224xWzGfAN0DYKhpyb/jOMGr2/Sr8nWTjg+AJKo6Do23CqsIvnlbrp+tiPEWCk0FJsGYi13CFQPCgLYv9YTOYqrILVUqji7fwIPKH4v+USLijdBaUOQlFpJPVI4w2ecAjZaB3jQ4xeVd1rofmwd3lnhNFCUTabnrEqBaSFWx2qzSgtthoW7j9f4crmYYnYDh7qY0PXVvbN2hbsm86r4JrcvQ1HMlwklw6t3Pb9nRmvPZ79IGro2sKCp9tzOVj9vYt/YZgEJBFv6p2fcihZwM2ZdbvAYcN571m/sgbp962Qdm5fPJ6VUHney3J3lBcLRGQRSGcO3hV1D7tlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKfo0XzdT/UR1CN77MwEIvxgLqx4Bqzn1WBhZdkM4XY=;
 b=WN3GmM9OA7XCPnBGewh1L5FlsY8vt+bl/LgriZVZo6ze6q6R0R+tZUjRBJRIB94BSp5pECYjt99Fe5HtzDzMsjb2hn9Au/rU1VXmwIQ391kt3vHPN2aw/W396hMnZD6bJWjUXRP/fhgosDjcwHI86kp9xY1pDx8CLN+AgZ0oBZ+8wajSHwRPmVJ4RcOq70pJBqzgrc/vFbxrA0kv1mV3pOBkr65SKwWWDvRU3WW83hXltfHp/5a8fD2X5zPux2Pda1yf/z6zhnj8PXvJo+3vxyddIVFydwbSCUo21aTuYGchXVsH1LPwF8ZkiwOG8Wa3ZBjBe4cIzyg2yK2cQeyF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKfo0XzdT/UR1CN77MwEIvxgLqx4Bqzn1WBhZdkM4XY=;
 b=oEohbvK296DKU+srLHE9xS3Q/KfGKffy1Aq2YChT5X8gY3JEN5DJeYkrCr1RNRCbggAS/SImFay/K/uJBmmXCSE0UECNvinJ3jdTeNnUqTgPOJESrnj4O6XICrcZ54aphPJnRRakSt9sNgtZ8jKnPz7nBDydB7hB+CwdYAvKEMY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4215.namprd10.prod.outlook.com (2603:10b6:610:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 19:54:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 19:54:44 +0000
Date: Wed, 5 Nov 2025 19:54:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Gregory Price <gourry@gourry.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
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
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <ceaeeed6-c1b2-4b28-a94c-83660c7ab257@lucifer.local>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQtiUPwhY5brDrna@gourry-fedora-PF4VCD3F>
 <20251105172115.GQ1204670@ziepe.ca>
 <03e363c3-638a-4017-99c2-b6668ca8d25a@lucifer.local>
 <20251105181648.GR1204670@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105181648.GR1204670@ziepe.ca>
X-ClientProxiedBy: LO4P265CA0040.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b322123-b277-4f96-3270-08de1ca52acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?25NZHcrL2DsN3ZdB0kqzY4wXFdDw9IwjjVfQK44P6xUiQ3pr6WZrrgfEh8YA?=
 =?us-ascii?Q?g8ejGijkIngwmE4uyEv+9o8PROV15I8TFi54+R/cRllFrrv/f3p1xQ3+SuYv?=
 =?us-ascii?Q?R6P1MMIZwABJRi0D3PBT9kcv4DWpvFJufW4re+bI7rZWWufS6LATnSLzsDvT?=
 =?us-ascii?Q?hqEnpbTl18wmtYTKGoW/btBHrm/crHtXODzMnRYvlQ7FPpREd8nUJd2I1pdV?=
 =?us-ascii?Q?ldCPufM6aTelxyhzDCdoZ8gAGqtWlyqkP/h4Fc4dy3CJ5EwTTaGysXqb4E4C?=
 =?us-ascii?Q?Yy+ncs03FNNqIGhEhYWcadk+urPUPuZojo9QHPzChq6eCin0FR6cQL39g5bt?=
 =?us-ascii?Q?PlkOcVcdM76U8k6BAjIuI/XuOU+X7nMOrVg0PLAZSUcVpCrj5lR2O+44snYv?=
 =?us-ascii?Q?OBOvyxXxyERxNaRp95z7ZlEpFhFD6a3/VRiCKbHsO2aX5hx0TXtnJ4GxxFg/?=
 =?us-ascii?Q?7e90m+TOg2CE1SG8/3UqrwF6CNIikzOZ0SWl3GEF3h0Px0cvPE/A1XtAIIWZ?=
 =?us-ascii?Q?q20+aGYGsf9poXfXMz8aQYApV/DW11HIlToe3xZ130EUMsQUSmQRiUHN83oM?=
 =?us-ascii?Q?wdivLf1tiN8qdWWj3ux3rQ+YtP3XiFgAiQod97KD2ec7nwtxQ90PofJXjAuC?=
 =?us-ascii?Q?AK1fQ863sqK7/PH45A6BzehVZ1Sjoz/ofaBfC+b/PMNJFB7Mj6LTL21OyHmu?=
 =?us-ascii?Q?8RQ3wP4TGbjUV0ZcfZmEygOlrjKll7bJjQFKrpsU3OEJQWtLfBqKL0V7X98R?=
 =?us-ascii?Q?17USrFhRDyGE8cz7/hnicPD2W2+AiVTWBaGbpegnwQsaqcq9ZRBenzN4ncaR?=
 =?us-ascii?Q?YStFFGJP/bvfUWkKliIRqfALg5BZbXV3g1a3EFYdOEDoOI62DekLkhN4NIfM?=
 =?us-ascii?Q?OeuiLI4p9SpBKIJTK6gAt6zqaeJHVlT/Gs1Zz1tivyj598/qOpJRSAAFLS7E?=
 =?us-ascii?Q?WMQiPBlHcffe9y/1pKVmIIFuX6SZMtoSVnTCgsvnCY0fk7D720GV1xFc31qQ?=
 =?us-ascii?Q?D1uo5myMhS+FKjrF8JkD6hwzV4t6iTPHyFkGO6Bo7LSjrrituanR13+SnoQY?=
 =?us-ascii?Q?XfXZg11KJ5KZULohaCKrh3jgK6Ky/pEvQfUD3ox5uT57WeujoGWS4IjbB1V5?=
 =?us-ascii?Q?hK7pDn1uNx2+lmNrnNZiiJ3gS8CCjhSQfY0ASXUBJnY+72VFeZGeoWDWKjoI?=
 =?us-ascii?Q?IYbNxpob6pxSeQZdTYq5PGVXooyTqO3Rjfl4alW4z07yrhAxXLaaL/+ix0MB?=
 =?us-ascii?Q?9m7XZLlNNNDHHW4Mz07sadLMIKJA4WW6r9nGxu8zMhA2pE18VnK5gSShakvY?=
 =?us-ascii?Q?8p21Uw95VlcpuNhrOjTKsVeh+yVxrddqeUFFfS/+GiTMNmInZ+eYODmjAY2V?=
 =?us-ascii?Q?F4KSBFhus0v1wXu6z+p9YKu+PT6LUu7eQj7dGkm/fQ5Wv2d2EuGzfu35T+hE?=
 =?us-ascii?Q?Gjmsq8ZYMQWVYxZq06j1hR90XYQhLx88?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CaM493eYzo5p5IWJMInE/X4TFWcdQtaI3wROz3OQmhXBdnaLBSY6zfh7Vjml?=
 =?us-ascii?Q?XGNpr3rxDn2741sJ4PwWl6I+X5i73hgFi7pZATEsyc6Jrfd0/ikP04dK1zck?=
 =?us-ascii?Q?zbuqoch4eIevVy2kgjMZbtLyvCIMPJrsx71R7+B/oms3JNJEOJ/u89GbQAB5?=
 =?us-ascii?Q?HmuK8GVs50N6IHiZRwMFnNEi0A+YppU2urlGkMjTvBXa+/bKQgTg9rOjojaJ?=
 =?us-ascii?Q?j2b+Of63wTyQojChjpOt13Nd9CedldsVwv+Kh7g1xRmOrB2ey5+WHDBQmoWE?=
 =?us-ascii?Q?DkqCTObA0zMaJqmZ5KBv9bfEdGtiLz5nxk9qcReqe/IqEpDEpekJce81i0N1?=
 =?us-ascii?Q?vkFofYJQq9FRK0aKpP3uCe9W5LvuIkZn9zzj4Umb0sU7L/3zI5+4pd8HH9/0?=
 =?us-ascii?Q?0NkaeSRSTncqSwS1EpAxm152Hc/lvZlgJ1z4ca+yfqlBplSZzwzsSEZL5Rgt?=
 =?us-ascii?Q?jdMfJY4N6ZHnZa3gwTEf/HbLrpa/ua3NQsGWNy15krab1BfQ81Cf7u3n39Ix?=
 =?us-ascii?Q?BNB0OUCC5rTSUnWlMr3BPrSBnySvsf4ROQCtYZqcwV2BscTss/qI/jILTkW6?=
 =?us-ascii?Q?HwjJhNHm+xZIcPj6qu3duecpHmvSyAJZxSshgCzGKBzRPv1/YCJhVGVLnleQ?=
 =?us-ascii?Q?SYrSIsnHcA+725ucHIguCHWco6FZH3INwPP9ffAWZ1mbrq4ALxNECOq1sQ+u?=
 =?us-ascii?Q?5Fuwxo1VkHjR2bUJ4baw1BBMYIaIz4FdGYGBkMdAuiOetelDAzkEKp1YE2kM?=
 =?us-ascii?Q?KbE1ZwoVzUbjkJGfzJYSx4KPmpUJh24jiBjKIbBGoHBzLuP2SIASITuCtcWC?=
 =?us-ascii?Q?InWJhVbEEZW7kGVKXvtBAQAxahVR9iCuBBCqOWLZ+uRW1N7RnzPGPzrygOuY?=
 =?us-ascii?Q?YypuopU6kEPZ1LHuAQacGtq5rOxr4uX9pNivPH3p8glQfyXVJaGtqUUvIO3a?=
 =?us-ascii?Q?SnjtfhfMhMTYItMRVvlzB44uHDL0z6cHGtvr4zGsdDwf6Odfr8xntZKHIvbh?=
 =?us-ascii?Q?NNMxx41tNGwqDgpRmLkzwnArfLtYYmafRcBJj1JoO+N19/7Yd2ObzUEO3llY?=
 =?us-ascii?Q?Ltpa9Wl3AUmUJWC94t963v2TMWMKCzeAXxsJm+65BJNirWxiVbCozwXoUu1r?=
 =?us-ascii?Q?WJIjf5EeqlLglcLC2T7zfcHcdRuDdE0DKdqpPYSpvvshxoHB94VZIG244WkY?=
 =?us-ascii?Q?8a6ci3vrWpWuZ4SxK8EBvW1n5J9nTX6tZbYWNRUjNas1pcqNTHGMhHlIAGzX?=
 =?us-ascii?Q?mq8wI6iesuqzOhdIBK8I5euGOZ2mFiojdIQEUyrnRQu0A4j+W64aBJPFgywg?=
 =?us-ascii?Q?T1j0CME7liIF2FfaYxf3iNRTeeBGnsXpbbTJn2hILxrbwheG+JHBwdFlG79K?=
 =?us-ascii?Q?ZnOteugUpMw94fKkt3XIwrZsCrf5UUBeSdX5/4zGqFfCupz72M0WfTIZpDlQ?=
 =?us-ascii?Q?6LO8oJWcpPkLGM48dS+cfBC08k3oZ6glzWj6wutY7VRT7ae0MHVtPmlIjxj2?=
 =?us-ascii?Q?vGJB2+cVSVuiqnh+VnAEWjojvEiHg2eg6lAGditCvsCXlF+iqvS+Tqfrinqk?=
 =?us-ascii?Q?6gWxRs1X57G1bXi9zuR/mB4+naUWJ+X3bYu2y+cxGXlrnhBbz9ma6bxNl516?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zJKAYMMlPgFBXU8rKFPhwZ04Gupc4YjgpbDh2Svy/v8/gi2NwLnWkYHI0JR138u2hbRJ4/dui525fmoKZX/StCdQUroXQEOPXj0w2omlM2xioVFXcLK5WIcpHkbcwvTBgl/t+ptuQD4FtZWfFdl03Tfn0Omb4zKwXynvuyc4i7ywg4GFnnp+tq5eX/N+ykhwLfD02BAdn17Ts4RRqV2EbOUynTlYUudYXmU1/3/fuNIgsd6V6T/qFsDES9ZlJ882e2bPSl1Y4psTtzstJV58d2g8TIl2z3YPWoX/w/Wd3plw4PuP5P/gbGurZwd7Xc7LrqLC9B6OnoSrSZVhHcU06ff3CJAttFOXczvR0rnfFL5OdVCo1Eal8ghGqztP3ZUi9np3z/WDqjaN1xOZcOuOZ7s7ZeTfP2ALCOI29PVeBtkSkE+GjggO4MrLoV51BrItnCvElxZlkHdIqkWtKW0c1IgyC5rUG+oIXJu445qIWePALnj0JDiQ0Y7Khr6XXg8tJYgGii2kLLXyfBVBYcDyfhmIt2KUgkPECAFRCdyxDEsslWz6Pdmu/IAtNGp57W0CRab3vu+R2ea619NKSe/bqM7Fyy1jOJXLgiGdHIn4LPU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b322123-b277-4f96-3270-08de1ca52acf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 19:54:44.7459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuSwlmMQY9ish0sctg4KJCluI7jU7xSidW+g3zWU2FofCVRtuPBexyxbqCmeZncH+odyMSU4YEMEREDFEzBppvbip2b03dlijNr/Jzwaf2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050155
X-Authority-Analysis: v=2.4 cv=IcKKmGqa c=1 sm=1 tr=0 ts=690bab89 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=41lSK_Vzy6uchruTzqkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: i9MQkfOVwHTJYTi_34fWcpAj7TIqBjml
X-Proofpoint-GUID: i9MQkfOVwHTJYTi_34fWcpAj7TIqBjml
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzOCBTYWx0ZWRfX0ByxnUdkphzn
 U9U9oJJLGCPl015CdvjiMFxPtiF5eYNW6soy6KaI3DAOh7IiyyfiLlo5L2VogHyu21JswRzNTNr
 HNcuE/rBhw+L2XoLT1v1K4SinmnXhL92qKs5M8l6MiYd0Xmtll6EZVeeEb90ZoF2ayjtUM+7Zch
 /jh2SwiYVVL9oT1L6AhT0mml+Og/VrM7s2bkxbzRh7WTE2O4gBTA9q212qvZFF0bCtwesMuhAjn
 l0vjLJyWuqbTN3K6sqO/ZEadPWNn82Afm+XwqaqlbHdMzxdEqYnnDCWI5NHlUj6Q+M6/EGVQPXP
 QoXZIZ+VPBXDMKokDEaEO4mV7nyVYYv/iVpIdPDTzmC8CEzhl3ln6U3DweL4KUIBEhAQoE1+1An
 og+LvATfNkAyWzBXtVLv6nzDZEOKk+6ahVDKMr+rzqRPSTio310=

On Wed, Nov 05, 2025 at 02:16:48PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 05, 2025 at 05:32:29PM +0000, Lorenzo Stoakes wrote:
>
> > Obviously heavily influenced by your great feedback, but I really did try to
> > build it in a way that tried to simplify as much as possible.
>
> My main remark, and it is not something you should necessarily do
> anything about, but pte_none() can be given a consistent name too:
>
> leafent_is_none_pte(pte)
>
> Which is definted to be identical to:
>
> leafent_is_none(leafent_from_pte(pte))
>
> But presumably faster.
>
> Jason

Hm one nitpicky thing with this is I have tended to use pte_ or pmd_ prefixes
for pte/pmd _tests_, as leafent_xxx() ultimately either deals with leaf entries
or results in a leaf entry.

I do get the desire to get away from the pte_none() stuff though :) The fact we
wrap up none entries in to leaf entries goes a long way towards this in any case
I think! :)

Cheers, Lorenzo

