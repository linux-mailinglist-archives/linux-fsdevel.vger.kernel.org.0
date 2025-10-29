Return-Path: <linux-fsdevel+bounces-66351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1C4C1C9C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 18:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 074B14E5840
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D77354AE5;
	Wed, 29 Oct 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GkfIxomz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gTFz4jbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637AE346763;
	Wed, 29 Oct 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760319; cv=fail; b=hsXpfQ+GrCpAi0xA5TBKjKTZL59q117RJKT5WNGAXtQfYYjuLyfnd2HZiHMAEV8dl4v0Cd/AELhWxuUBR70DdCri7g53xlSGiUbPv9Sq4zAUDQ7DqjkR92ffmCKeg6JSrf4XcMha0N+RjaBparE46Peh7cYMEs+JBlQfHY0bY/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760319; c=relaxed/simple;
	bh=ZX5QVnqaXpLNhexduGQbmiwpN+jknfTkDVg8alzAkGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NVq96JdIwAz6TPAcRYDlTfQYwwM97u4BiX1rAq0nsKLc3MteK8vYSyupXAyKwSsuaJ75hcADiesif9RIycDuet1vpX9fXnJZMgzRHyH3jSwHLEGv1w9uR1nMx3PVb7XCMemwRc6Ad9yuWrt36TMehSIix/WWJT2Zt7/cGZXVRMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GkfIxomz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gTFz4jbA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGfuN1006721;
	Wed, 29 Oct 2025 17:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jYOLNCwz8SReylhnkpI5hwP4xmygsf7yo0eBnuZo3zQ=; b=
	GkfIxomzVJqBAloEDZGA0B9Jro69sjve/ez0yWbTpLuDIymdBzP782sEkYIkEIB4
	4cpNCgRtvROenL0Mor9wP1yjEBr6f0QoHT6kZRossFKk7EupE8HXWody0zl/EEcJ
	KRSRkznFEMcup2wuq2ivH8mHAeq9fX1u24lNDNnx1R+3bKdq7przblNZTcy951iL
	Zyur63r6CzumYhLAMkd2xNrGVZkzXThQabY96tj89YIDwNngwBUV0Yxqma2G0dJl
	P4Nfvdtyy9UwAhyYyPOOl1WOiOK0mjVubhpakLGbWJ4OPVu1RIVQjmuOeiieeMGg
	JGL6rEWMoTHt36qPEa5BYg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3cbthr7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 17:50:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TH1KdK031648;
	Wed, 29 Oct 2025 17:50:05 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34ec96s7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 17:50:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uT2cNgu51gQvH8c/aDcLE7tx8xI2U4BM5uRA/pJZz9M/Yn192VzcNnaSbdnmRYN5P3U6rW/D2mdAy//9zN3wseZqpLxORDXRlNWWHH9dUGstHgxud8Q3ha1+4ZxIQNuJwNqf7oLcQl/2M/Ma2sCsDPbIdaY3H7mU/uqvPkfPrhe/MzbIZ+wcYlux9mtnH+gZakIBNtSvPwd+zcJEg3Vg886iNovsCEtixTwW5/oYA13GwDNKLcczUNw7HwOXwu+MjrS5M2Oy1FK5KYMcfj7Cy7e09mv9zI7wexZou+rhILmhgLnkO0dEG++QGiTCcdNAbx0UVOI9JWnlJekzxGfjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYOLNCwz8SReylhnkpI5hwP4xmygsf7yo0eBnuZo3zQ=;
 b=wyLPOzuoFAZP9CLTJkRdgk1bA0uslZSKzN8OW81aVrOTrNJpamo//rQt1seCp93mlSUL8eq6TqvtINdhu8tA/NgjnbRYYPnYqAnWtGc9B3nK9hS/Z+3x1XErJzOnu1RmMbQs1tMX/i7HZQPnFU3Hs88s8IJdU2OfOXPl/Hory0qQu4xeDNkSSXFC/hb4XumHOKP+gNkbuPZSC2zCggEpAPAL1SAxBShSXJ85/mlkjEq3Rzr0Gi/7CCS9hSkhr7hHt4lqcx08RmWCHqVGR7OsLs6ds0E4qtq7DaQ3U3JmJi6ELzVFytG9PMjj115iL8SaESjb26IKMV1jX9wC+9HblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYOLNCwz8SReylhnkpI5hwP4xmygsf7yo0eBnuZo3zQ=;
 b=gTFz4jbA0un73GCBIoBJimdh8q/ve6JZe+Vf99uBt2WN2xGKvrCrrCBOGdxb3E4kkIVwM9UUVLUm961uQra8syrN7AnMMf/ddy6zGm09ngukwGFPknBVhqifCSpjNEo61+5h9qNdw6AuDcjb3dOa0i52EKrPhjy3wyyHsVgcNXA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4298.namprd10.prod.outlook.com (2603:10b6:5:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:49:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 17:49:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/4] mm: introduce VMA flags bitmap type
Date: Wed, 29 Oct 2025 17:49:37 +0000
Message-ID: <9ecb6d4f37092353af7a9dee74f1d7e5cff40383.1761757731.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0191.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 8506f0d7-84a7-4c48-a989-08de17138d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0oAVHbRewQMRLW2yEctNSQPVBfc/PaYDTHwg54HMLOddrC/SeGB2X/SBb9zs?=
 =?us-ascii?Q?5k/0/8PulKSMB6etpsqeSnpfVb55RErMDGqrn2KG5d4uwBjc29ITBcjH+pb5?=
 =?us-ascii?Q?vazKYMQJ58E0q3gIMQzVx+ERx1ufCClFS0Rr9fU5DJAysG0lwoMKZzUCKKKQ?=
 =?us-ascii?Q?vVDkD5BP7+VmSYhNwLkOOKY5IwUe1nXZHxZA3IgxPRnVuQ4zE77WmzrafC01?=
 =?us-ascii?Q?AROgLTgj6jQV5vPWb84yOZB18WnQ4SkINbGNTZRkFFEn8gleTlLetonXiNG/?=
 =?us-ascii?Q?mSbRxn5XNSUEFuix5r7DRstEcaiFnhpMjpsblgMx6jftS8nVR3k3CAMgiukY?=
 =?us-ascii?Q?PxbfM9xcKRkph7Vvw0kh2J6o+/31SaOTx8EJmjf0SHmK+ZWfIcGUPfZBAb0m?=
 =?us-ascii?Q?ADDQ+quBt9sWgpJKtoX3dPwF3gzsCdP9aJk+c420bbb3Qn0VJ3e1cN2o0LVt?=
 =?us-ascii?Q?SUMZcAOG9Le1cBtKIVuAgHs3kP4gy12/XS6Eb8pKBbU0B4VklgUJhg/JRUVB?=
 =?us-ascii?Q?NLFZ6BJ6EY1hoMqHPWb2Wm3JtPaLAXyu0kSli14knZaxWaCLDFnnNiJoefbO?=
 =?us-ascii?Q?ZFglhYaXWmQdGd8mTg7PdDiPK7vanRqWr7/KPOR3HNtkFC4THNS/yoio+jdQ?=
 =?us-ascii?Q?B67dYBxV5t+rykduEMLv3mNaI+b8541u+JszqkZPDbgxubBXscl2YHHJ3fl+?=
 =?us-ascii?Q?L/ca7CrQ3s1yT5LHLEfYqVqlJ3KcWa8wuDtt0WKrk9vKFAdK2Pg5aV3UdW6y?=
 =?us-ascii?Q?jxcF0jcuhPe0700xi3WNkIpUsII0EAaqKKcD25ulPgFBC1v+rbeScgQUQdWX?=
 =?us-ascii?Q?mxFPNHtYEzRfxY2zAFizA327Ce1irULTltZ+hlNBdl3R51B3IZfnKUzL+2na?=
 =?us-ascii?Q?Dw7gbR4zoiuUpW4UCc0bvM0jWDmntYC/Q2Jh/scNmPd8T8QVJVlKlWty3n2y?=
 =?us-ascii?Q?NZr3Un+0G4JuVXqG9Q+xyMxoEfDNLRHqrghJ6AziuzjDQg+AFLDmvJOSdhaW?=
 =?us-ascii?Q?/PbYNlLkVbX+iuH3OgqG0+w6Be3JrFRyhShwtxpoC64e8Gdb+ide0ayJuTd+?=
 =?us-ascii?Q?D0KasTQdwACKW4tMjttmZzrgqEzhEl0VBReq0/du9+bxYbK1tqJTjVIn91c8?=
 =?us-ascii?Q?ucsgQNjYcYfTDzeS3ha30LlsAXmSWQCv0KJsRJFETlqjQdSoo8mhpNCiZb1/?=
 =?us-ascii?Q?JIuhEU0DZBPgtqBIZcO2rY9ijA+EsZuWM12b8ULvW6RdkPWEtKcz1N2jSeC/?=
 =?us-ascii?Q?/wOAspZK1QGfRoLe6bfAd1iFTlT9b0DxCmJ6co8tH2q1VQqohF3USvkI5Nc7?=
 =?us-ascii?Q?QBIzy+xhRB/2xOm7NdLUGq1wFoObWcfP5nV/zpsw7AVnsxxQo6L3qaQA8t+G?=
 =?us-ascii?Q?+sv3MV5fNZaPMcmxsk5O/3xUU9OifZJkTmz8FQIYeP56TztYl8nPhzGhmARn?=
 =?us-ascii?Q?fYYtsE91TlPasymd71RdG0PuXPZ6cFNa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cdei1rOkgyLQ32OUZ5zwJvrMXuDkrqZ3bUvdoE5rY08zGwcibU7D44Wcr0V2?=
 =?us-ascii?Q?YedWt3TlZugGxq51mk/OHaHvHbRzijMBoHkiiUWVOxkACred0PA5Fo1eUyFj?=
 =?us-ascii?Q?2uFFls5g3b5mwUF2TctLXZ43sGR8zd3Zek9AIeIebj/ToWxG96zA2JrGbG4z?=
 =?us-ascii?Q?J0Cd9A5CeJXgftCPOIZVJn6HBpNUzqnewen0zGnAJkcdHqrQV962HUax/3uI?=
 =?us-ascii?Q?6Z6ooxaGr/YDFTVd4I8FlEa6TIqCSiM7VeTH5xLz9d4yNYp7o77IfQfDfJav?=
 =?us-ascii?Q?XSJRBrRrgPHfYicU/V8pXm0p283+M2HveKwH7dfJInTwgmgq3nlP8cPmbAIt?=
 =?us-ascii?Q?5ZdUO1wDgKqamlZd2BvVamu8x2IxWctCkrQ5tQS+skTpODGM6BSAJ6je781q?=
 =?us-ascii?Q?w/q8xhW2tfRCMyAnuwFTr0rPUtKTWE7MxT0PNtoWQ2LAvRZwjHgH25ShHYi1?=
 =?us-ascii?Q?h948+T7OUABeOHKdCY3zYj82u3jMGHOl6SFzRL1Mu4NteYHfajyEXtg34263?=
 =?us-ascii?Q?WnyQRK3i6OCDZWlOASGraO6+QiYxfZKGJfObT6QENz+l3TLv/eVdkXIHzOju?=
 =?us-ascii?Q?JjmOZXzIb8JlY0y6fMH3N0DfN487v47awSt5IJWlmpexgwrvRUc5r4WkBNW4?=
 =?us-ascii?Q?20cOQXVTv7PwrS3eZzcBXyRlJq+VS2jn54VrtDmLQuIy1/43TV6+NAXxZff5?=
 =?us-ascii?Q?W6E/rBWMeVvGrk39vFNiUdt3J4ititp4cUX0VXS3iTxXzaMa4Myj0UhN2CfY?=
 =?us-ascii?Q?MHpHIo3BjhKOFtpqsWbdss5eqE9IIxamdS0xROKMesfbgBYv5LEEVhhq4tHM?=
 =?us-ascii?Q?y6EqDD3skUf4qgl59Zmkk0xOS4H/mL1jvXugR53+AK1gp3mDmaRKA0LG2nTr?=
 =?us-ascii?Q?gWVte6NZWSh5xNfWlV34Y8C/7W4waiE93l4+vVW51CMXhL4ZCLOJObDFOBAF?=
 =?us-ascii?Q?ER7Hmt6pdtlKbmOGACStJME+S6PVS6mDeuDjJTUFyAkEWUGSyDSlIwQj1eV6?=
 =?us-ascii?Q?FT54xZlGe+4kPQ3f1TA5F3PAeMH//sdEZGFjGIQ4+N5u/B4taeErNgiEqGcF?=
 =?us-ascii?Q?kzGhNASd0pbjlPg6KnEN3ZNHQvp61KTM3foUDIsxYVRWoIosvIHMbhGWi3pL?=
 =?us-ascii?Q?KcBem77aGxIufT9rSyLBGICY5xtCjDr3FMo+fAtdAFIyWeZgVs/k1SDeIPhI?=
 =?us-ascii?Q?vr0xWGCpBHRI9nKCoUeFDqW3XpGtodfRib5ywdksZhZxbT3PmC4FtckU/1js?=
 =?us-ascii?Q?e+vUWOph3zNI8n1Cd1XVvB5hlXohRC0f9V+zoZw/Dv+ZC870H5Kcoepprux6?=
 =?us-ascii?Q?92C1+QIQU5Yub8J1b2PvuJNzfqK0fjjRjQCX9lC7/dg8vjwz/Zc49Vl1tFcW?=
 =?us-ascii?Q?ObR1hH4C3CJwBLVL36bacq43XOTu4UaudDG1GUk+TDY/RavnNOauL1XtVhnH?=
 =?us-ascii?Q?Mzc4V4Zng74t/c7EiwrhfCvNGnB3Wkoje9PQntEpSk+ZzXjuXkSWV+A2gYer?=
 =?us-ascii?Q?y1KIlPVQyIuZDd5rwslGY08pg6ch8T+V5KI3IC07dTbu5gMjHMXPGaT8DGRl?=
 =?us-ascii?Q?yJFPb0h6ylk+qS6+SJoJQya/vKK1lYAzsborA/ormFlsl1+Eb6yN5PxHZTE2?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F53RGOC+MMlOYc+mnETceLIG7DGHm4B2hAj2ukCNUfJwZ+UPrK7ZJq5U8OOqr4t8Mby0X1mgk8BpNkuTiq+Es8L8ru5idZJM4XpcCnH0AhkPLMe+0sZpMLROaalYZemBXTE4Dc+7jXBNUrpvoztFhT9ZCCZYwF9g4EKgW5DWutvo43FCDmbOH468wBQ3pTTFI5aajuKphAQxp/wjyjF2VY01r47Bx0anfu+opQA3Ci6q5owo5YnYf27b4rWnbyJkqNMtOzRxW5sQ/6AOcXUa8mSLmGUsINQ8IxUbL7aYt1KJyBgGEngZAyqWuh7MrPqqsh2Ho3prKSlk8pdOjNyQYJAKn6CVnL5Lyff+0RFEJTSuLqNNNGq1ChAIQPdOTO5rsPk0SFw84Byw0cn/1s3Zm9hodpYhsmYdulM2bg8TP8bpKf4EzG3gRl5qiX6MBtX/bRHj4Dh6wcWZJeGzLagFAZztppRPyblxN5vX8nZ4NEu3wqfXzlhCZovMucwoerffJHHRhWsz2f8gUs1Sum6vqlQECv6zbgNQ2nzAZVnOO9K/oYZyZjStklHDKBPE5HB6mZ4M1DmM1GGvsGEqBnpT0Rb+o+mkHzmOqIkqaybk9o0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8506f0d7-84a7-4c48-a989-08de17138d27
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:49:47.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Mn/U6ljhdrQlPZtNWd1WCy8efxdzkmwOo/Wl75LbM16ruOhXGoq55S9gQBvvwg9xVuRcbSH67YYcIQXqGaXjh+K/ByevNn6U+yaEIPG6UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290142
X-Proofpoint-GUID: HK2X5qra8vUneDIethBc7d2FrajyRmac
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAzNSBTYWx0ZWRfXzNZRGPPxAsVz
 9uSuYZ/qwcNbfaRG+CTMN+JZhUds0utNQZzQB4WWAe+i/1HK+XUdVbxbIlTzoRGPLwKChFZ3jSL
 fs+5oNbvLJeItAJxdQL00tzHJ9Edcxh0M6m/hyuy5sHQmdWfuF5GRVbzcyLdl5EMuVKIwJ0w9bW
 N/IsmO8TeE1h3mVU5yrxiN/l9wtZJe2hklGzkJQTyFi/m2NbXzL7AFbh6gupFxpU9KymwHYnhlq
 f8TP4woHZJ3Jer8cbGisb5/x6A7BFQtfPY/v/bR/onJwXyy2abxkOiTBNaDoVlul0SaIVMhvmHJ
 k2dcnpWnfBpEQAGDB1xFx+pPQwS2JuKN2nHiiBjmg4GTHlZjtXtYQXyr7cs6S1Ew1ADhayFrFia
 4ae0DwxTlNNQIApsADvUcJyAXsHnDAU3L1yhD2ym2kusbJHjivA=
X-Authority-Analysis: v=2.4 cv=A8Nh/qWG c=1 sm=1 tr=0 ts=690253ce b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=0Oz8gO2ziicdouQhmPcA:9 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: HK2X5qra8vUneDIethBc7d2FrajyRmac

It is useful to transition to using a bitmap for VMA flags so we can avoid
running out of flags, especially for 32-bit kernels which are constrained
to 32 flags, necessitating some features to be limited to 64-bit kernels
only.

By doing so, we remove any constraint on the number of VMA flags moving
forwards no matter the platform and can decide in future to extend beyond
64 if required.

We start by declaring an opaque types, vma_flags_t (which resembles
mm_struct flags of type mm_flags_t), setting it to precisely the same size
as vm_flags_t, and place it in union with vm_flags in the VMA declaration.

We additionally update struct vm_area_desc equivalently placing the new
opaque type in union with vm_flags.

This change therefore does not impact the size of struct vm_area_struct or
struct vm_area_desc.

In order for the change to be iterative and to avoid impacting performance,
we designate VM_xxx declared bitmap flag values as those which must exist
in the first system word of the VMA flags bitmap.

We therefore declare vma_flags_clear_all(), vma_flags_overwrite_word(),
vma_flags_overwrite_word(), vma_flags_overwrite_word_once(),
vma_flags_set_word() and vma_flags_clear_word() in order to allow us to
update the existing vm_flags_*() functions to utilise these helpers.

This is a stepping stone towards converting users to the VMA flags bitmap
and behaves precisely as before.

By doing this, we can eliminate the existing private vma->__vm_flags field
in the vma->vm_flags union and replace it with the newly introduced opaque
type vma_flags, which we call flags so we refer to the new bitmap field as
vma->flags.

We additionally update the VMA userland test declarations to implement the
same changes there.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               |  14 ++-
 include/linux/mm_types.h         |  64 +++++++++++++-
 tools/testing/vma/vma.c          |  20 ++---
 tools/testing/vma/vma_internal.h | 143 ++++++++++++++++++++++++++-----
 4 files changed, 202 insertions(+), 39 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bb0d8a1d1d73..d4853b4f1c7b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -921,7 +921,8 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 static inline void vm_flags_init(struct vm_area_struct *vma,
 				 vm_flags_t flags)
 {
-	ACCESS_PRIVATE(vma, __vm_flags) = flags;
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word(&vma->flags, flags);
 }
 
 /*
@@ -940,21 +941,26 @@ static inline void vm_flags_reset_once(struct vm_area_struct *vma,
 				       vm_flags_t flags)
 {
 	vma_assert_write_locked(vma);
-	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
+	/*
+	 * The user should only be interested in avoiding reordering of
+	 * assignment to the first word.
+	 */
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word_once(&vma->flags, flags);
 }
 
 static inline void vm_flags_set(struct vm_area_struct *vma,
 				vm_flags_t flags)
 {
 	vma_start_write(vma);
-	ACCESS_PRIVATE(vma, __vm_flags) |= flags;
+	vma_flags_set_word(&vma->flags, flags);
 }
 
 static inline void vm_flags_clear(struct vm_area_struct *vma,
 				  vm_flags_t flags)
 {
 	vma_start_write(vma);
-	ACCESS_PRIVATE(vma, __vm_flags) &= ~flags;
+	vma_flags_clear_word(&vma->flags, flags);
 }
 
 /*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b47bd829ec9d..1106d012289f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -823,6 +823,15 @@ struct mmap_action {
 	bool hide_from_rmap_until_complete :1;
 };
 
+/*
+ * Opaque type representing current VMA (vm_area_struct) flag state. Must be
+ * accessed via vma_flags_xxx() helper functions.
+ */
+#define NUM_VMA_FLAG_BITS BITS_PER_LONG
+typedef struct {
+	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
+} __private vma_flags_t;
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
@@ -840,7 +849,10 @@ struct vm_area_desc {
 	/* Mutable fields. Populated with initial state. */
 	pgoff_t pgoff;
 	struct file *vm_file;
-	vm_flags_t vm_flags;
+	union {
+		vm_flags_t vm_flags;
+		vma_flags_t vma_flags;
+	};
 	pgprot_t page_prot;
 
 	/* Write-only fields. */
@@ -885,10 +897,12 @@ struct vm_area_struct {
 	/*
 	 * Flags, see mm.h.
 	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
+	 * Preferably, use vma_flags_xxx() functions.
 	 */
 	union {
+		/* Temporary while VMA flags are being converted. */
 		const vm_flags_t vm_flags;
-		vm_flags_t __private __vm_flags;
+		vma_flags_t flags;
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
@@ -969,6 +983,52 @@ struct vm_area_struct {
 #endif
 } __randomize_layout;
 
+/* Clears all bits in the VMA flags bitmap, non-atomically. */
+static inline void vma_flags_clear_all(vma_flags_t *flags)
+{
+	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Copy value to the first system word of VMA flags, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
+{
+	*ACCESS_PRIVATE(flags, __vma_flags) = value;
+}
+
+/*
+ * Copy value to the first system word of VMA flags ONCE, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	WRITE_ONCE(*bitmap, value);
+}
+
+/* Update the first system word of VMA flags setting bits, non-atomically. */
+static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap |= value;
+}
+
+/* Update the first system word of VMA flags clearing bits, non-atomically. */
+static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap &= ~value;
+}
+
 #ifdef CONFIG_NUMA
 #define vma_policy(vma) ((vma)->vm_policy)
 #else
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index ee9d3547c421..fc77fa3f66f0 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -69,18 +69,18 @@ static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 					pgoff_t pgoff,
 					vm_flags_t vm_flags)
 {
-	struct vm_area_struct *ret = vm_area_alloc(mm);
+	struct vm_area_struct *vma = vm_area_alloc(mm);
 
-	if (ret == NULL)
+	if (vma == NULL)
 		return NULL;
 
-	ret->vm_start = start;
-	ret->vm_end = end;
-	ret->vm_pgoff = pgoff;
-	ret->__vm_flags = vm_flags;
-	vma_assert_detached(ret);
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+	vm_flags_reset(vma, vm_flags);
+	vma_assert_detached(vma);
 
-	return ret;
+	return vma;
 }
 
 /* Helper function to allocate a VMA and link it to the tree. */
@@ -713,7 +713,7 @@ static bool test_vma_merge_special_flags(void)
 	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
 		vm_flags_t special_flag = special_flags[i];
 
-		vma_left->__vm_flags = vm_flags | special_flag;
+		vm_flags_reset(vma_left, vm_flags | special_flag);
 		vmg.vm_flags = vm_flags | special_flag;
 		vma = merge_new(&vmg);
 		ASSERT_EQ(vma, NULL);
@@ -735,7 +735,7 @@ static bool test_vma_merge_special_flags(void)
 	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
 		vm_flags_t special_flag = special_flags[i];
 
-		vma_left->__vm_flags = vm_flags | special_flag;
+		vm_flags_reset(vma_left, vm_flags | special_flag);
 		vmg.vm_flags = vm_flags | special_flag;
 		vma = merge_existing(&vmg);
 		ASSERT_EQ(vma, NULL);
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 7868c419191b..c455c60f9caa 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -549,6 +549,15 @@ typedef struct {
 	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
 } mm_flags_t;
 
+/*
+ * Opaque type representing current VMA (vm_area_struct) flag state. Must be
+ * accessed via vma_flags_xxx() helper functions.
+ */
+#define NUM_VMA_FLAG_BITS BITS_PER_LONG
+typedef struct {
+	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
+} __private vma_flags_t;
+
 struct mm_struct {
 	struct maple_tree mm_mt;
 	int map_count;			/* number of VMAs */
@@ -633,7 +642,10 @@ struct vm_area_desc {
 	/* Mutable fields. Populated with initial state. */
 	pgoff_t pgoff;
 	struct file *vm_file;
-	vm_flags_t vm_flags;
+	union {
+		vm_flags_t vm_flags;
+		vma_flags_t vma_flags;
+	};
 	pgprot_t page_prot;
 
 	/* Write-only fields. */
@@ -679,7 +691,7 @@ struct vm_area_struct {
 	 */
 	union {
 		const vm_flags_t vm_flags;
-		vm_flags_t __private __vm_flags;
+		vma_flags_t flags;
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
@@ -1386,26 +1398,6 @@ static inline bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags,
 	return true;
 }
 
-static inline void vm_flags_init(struct vm_area_struct *vma,
-				 vm_flags_t flags)
-{
-	vma->__vm_flags = flags;
-}
-
-static inline void vm_flags_set(struct vm_area_struct *vma,
-				vm_flags_t flags)
-{
-	vma_start_write(vma);
-	vma->__vm_flags |= flags;
-}
-
-static inline void vm_flags_clear(struct vm_area_struct *vma,
-				  vm_flags_t flags)
-{
-	vma_start_write(vma);
-	vma->__vm_flags &= ~flags;
-}
-
 static inline int shmem_zero_setup(struct vm_area_struct *vma)
 {
 	return 0;
@@ -1562,13 +1554,118 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 {
 }
 
-# define ACCESS_PRIVATE(p, member) ((p)->member)
+#define ACCESS_PRIVATE(p, member) ((p)->member)
+
+#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
+
+static __always_inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
+{
+	unsigned int len = bitmap_size(nbits);
+
+	if (small_const_nbits(nbits))
+		*dst = 0;
+	else
+		memset(dst, 0, len);
+}
 
 static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
 {
 	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
 }
 
+/* Clears all bits in the VMA flags bitmap, non-atomically. */
+static inline void vma_flags_clear_all(vma_flags_t *flags)
+{
+	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Copy value to the first system word of VMA flags, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
+{
+	*ACCESS_PRIVATE(flags, __vma_flags) = value;
+}
+
+/*
+ * Copy value to the first system word of VMA flags ONCE, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	WRITE_ONCE(*bitmap, value);
+}
+
+/* Update the first system word of VMA flags setting bits, non-atomically. */
+static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap |= value;
+}
+
+/* Update the first system word of VMA flags clearing bits, non-atomically. */
+static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap &= ~value;
+}
+
+
+/* Use when VMA is not part of the VMA tree and needs no locking */
+static inline void vm_flags_init(struct vm_area_struct *vma,
+				 vm_flags_t flags)
+{
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word(&vma->flags, flags);
+}
+
+/*
+ * Use when VMA is part of the VMA tree and modifications need coordination
+ * Note: vm_flags_reset and vm_flags_reset_once do not lock the vma and
+ * it should be locked explicitly beforehand.
+ */
+static inline void vm_flags_reset(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	vma_assert_write_locked(vma);
+	vm_flags_init(vma, flags);
+}
+
+static inline void vm_flags_reset_once(struct vm_area_struct *vma,
+				       vm_flags_t flags)
+{
+	vma_assert_write_locked(vma);
+	/*
+	 * The user should only be interested in avoiding reordering of
+	 * assignment to the first word.
+	 */
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word_once(&vma->flags, flags);
+}
+
+static inline void vm_flags_set(struct vm_area_struct *vma,
+				vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma_flags_set_word(&vma->flags, flags);
+}
+
+static inline void vm_flags_clear(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma_flags_clear_word(&vma->flags, flags);
+}
+
 /*
  * Denies creating a writable executable mapping or gaining executable permissions.
  *
-- 
2.51.0


