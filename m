Return-Path: <linux-fsdevel+bounces-53463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F6DAEF47E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C757417D0A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09DD2737F5;
	Tue,  1 Jul 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K8gQi8qy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RO/YvSMF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083A2737FB;
	Tue,  1 Jul 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364341; cv=fail; b=EtLUkLZ+0+Wvr9+Vh25e5O3xccj5l3paV4hzEoh6b01HCUeBtTTcIg3Pmrg3XJicbF/+fouZD/M3XbvBNpP9q2qg/gKtsj7sXcJbJOzfGyw6Csb5YVs/9vgdLrLo936r0lgZPvsVO7+TkcK8hm9hwZLT10G+3KrlWBGdgBVNMlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364341; c=relaxed/simple;
	bh=SgTLpsdTVGXhao/8jN8i1Qe/OQPTOaS78+UXoCrBm/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rG6+ECJVfPI5o40vZARp1IiK2YsxdwzP+0iLBzAWBxt0UpN1lwc/BBq4uaiaT0RKcX8oi1hxQw+C/HfODgNr6M4bQkJTFJFqfT722qHJq6GV01O9ba1ebnIh47a8jJmScZKm01+MP6voKaK9+bMoJZz4bReG4FR53ByzTXa+V+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K8gQi8qy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RO/YvSMF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611N1bF008588;
	Tue, 1 Jul 2025 10:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mQj2A2jEZtS3kZVhPp
	pfk5KAcaU4YJ0C9HUswLujEhs=; b=K8gQi8qy5nf6UD7cRblQYgNHAClO3cS+v4
	wWkC2dNiihsBPv7GA5+cvF3b0sR4UeF8cJvn/Wz9mTseayDTob8Oj4SNjgdhxAoI
	CquY1H/JuvJxmGLK/wKYP3U5Gzx7f2xYibTwTO5/29VaCoY+qdLKx1LIDiHmXwE5
	UGc3BmReGKTD3bzlnv0xZyBYadL9NrEr0SpqVxuoGbPQKrGDnN36fxetkNfTkhKO
	tN+vqCNUtY27a4Jx/sol4VSXB21hMdyIEkR4KsQXEv+PqWy/mwuWEHHmyklM9Pzs
	7TZn/f0qcExjBWoG4jlO9AkDpES+bELQJR7dNNIId8JQolr3zRXw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766cfem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:04:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5619TiYT005908;
	Tue, 1 Jul 2025 10:04:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ugsnt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:04:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xE3TjRRwElxYvoba+a5hA8iyYZJNfZF1Byte7w9onCU+bfeUrcRx8vzB8KPrx8qjqwDu1i6RJxzMZWPGr08SjgIM566vPmqlKdldfWe1Zv+fotIeC2tFd5gNU92rlJcZ+YvE9LqdGyosAefXlTmM1U9UNEYxQv0Gn8vKcv9slihT6GerX0MBpLGhSBPT+4Cec35MWhESIaqw4BBKZz7Xq5c9sWhXKfbjunQVTTe8Ef3pE+m2Q6Fd+uqmoutp+4FHMCA2bEN1LZQ9sXfDAN4c/KU1dLcocMwLb4nhXbw1V6Eiczs4XeE2UCeSKU3pDzsH/wBqVWiatSG+6CRcig3Vhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQj2A2jEZtS3kZVhPppfk5KAcaU4YJ0C9HUswLujEhs=;
 b=B0DAp+CVR5qgd/uSN6bUwKCAVwwFz3FsSvs4wqsaNhjpCUBp6P12ARjHhypHNwrKS1zUGFjIsMR6znNn7dSnnONxgloX6Q36sOgqd/ruw6+/J5sQcDVX3qzS2mDZ1zRHAkYbatxZBfMXeZnXlM7GcNMQm9ZYbMIw0AgCM7AREN4fnC1Rlqg+X/j0qLa3AofF3AiqkBlyOzgWQrYrU45kGxV+eqH5FgxEsIhhQvXEC3YVT5R1gV+T+Jt2F07MrRCNzxhIQZpJbDGhEHpgR6gAiR9ywQCnX5q9uLHGdJYyLwIssqIK0t3QoDM6kK6aOVYa+GWjPiRw4lhJnBp0SShmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQj2A2jEZtS3kZVhPppfk5KAcaU4YJ0C9HUswLujEhs=;
 b=RO/YvSMFV9+Jcj/y1yCKrp63F26SOujPMKgZSJSDl0+I2ADokH3n/e1o6rF3M3wnX9Zj7meKNIo3fQKDg0YSuAkzMQDIJTeL7HDf/jOqKiOL8RSqlYKFkDYzfb63sIbcY3hYC4luzXIPI2rG7Uy1JjH6RTei3odRdw5sv7PzLVk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF8337777B9.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 10:04:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 10:04:00 +0000
Date: Tue, 1 Jul 2025 11:03:58 +0100
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
Subject: Re: [PATCH v1 13/29] mm/balloon_compaction: stop using
 __ClearPageMovable()
Message-ID: <65804db3-71c0-47ff-8189-6a1587d4a0cc@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-14-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-14-david@redhat.com>
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF8337777B9:EE_
X-MS-Office365-Filtering-Correlation-Id: 03390a08-8835-4fbd-94ce-08ddb8869a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BEKUe/UiQbp3hc9L3KWZPI0LM2AAr9Ce8Ufcg+aKM50SHQVqy0KnWAuUvB6l?=
 =?us-ascii?Q?zoe+Cki3dc8cNmtPW9X8rJCzVYLmFd1GBG4N0E2wgL1DZrv0zCo1FZtKGhx7?=
 =?us-ascii?Q?V5xpLbD0gtxQogpl2FVrcqkwoUtdzUUkY8cASf8Vglz9AMfLktVxEUB2X5k5?=
 =?us-ascii?Q?Qf9O9XSwUaFlgn4+jERpwPp4u5cqNSrgKkJfSx4ZXgIGVhY+KjVnz1qTdNpf?=
 =?us-ascii?Q?alXMAeOgvpP5i1JEuLK6nvs6D9ObrSHOlVjKIOZxLNJtyOb8GJAdrG9hkhKF?=
 =?us-ascii?Q?tvGkf4Zo/Dmv5BOvz4xdncan22WDiA8U1slZSIiwuExkE0Rwtwn/5cqNSewf?=
 =?us-ascii?Q?sIyVMsD2nb8SDevcVGUw4Z6Fp/TOYRY6rjst3B9zDAaX6KGakUqrtqTgjoTI?=
 =?us-ascii?Q?fFafJco439xya+loGD+Q7UXZaPSZlTot5GTyYfwdIUtSqoGoGJtqT98KG3Wt?=
 =?us-ascii?Q?vPmLZ8hd/Cmxg8CXB9kO7yRdpV5A2jlD7lI2mQDPP+9biuwFM9BwkTqdCEDV?=
 =?us-ascii?Q?yRzJI4GkOnXowl5yZtEL9SCQeawwmhs4ZXhni+0ORsfcEIuuXUtWwNDxZKjb?=
 =?us-ascii?Q?LRNBHPRqX2VcRHskXeFvicMT8tykPuE+Fart0mZKpkGFw1Eu8MRGC2n96Hfk?=
 =?us-ascii?Q?UNJQQw0KVToAVxHmaDYOtv39zidGcFHcY60eZtVnznPP3YHlZrNrXqChKwiQ?=
 =?us-ascii?Q?/XUbehOLa+ot6VLVrLcFkg0HIe2Kie5VO9tkOR2Jfak1AzCM03rQ2oUiCpqN?=
 =?us-ascii?Q?LHA/IBa60xl2sz4pAzRa1qs4B78C1naQr5+bjXNkHYF/w6qLGcHrruembNCm?=
 =?us-ascii?Q?y2yjXbkcSsMgVfMTZufRsMAkW2u28yoB1OIkqRtlGjZaM9UFR5d5odzyPnKc?=
 =?us-ascii?Q?PeJFkuWlP7Z0rx6d8dWjIw4F3Lc3KeFyL/ljaticKraMqc+9aTQutk7brX57?=
 =?us-ascii?Q?TZfr/U5G0Tf+TdTExrB3GLtwMjESkdsr6xfAqajMCmOgazOcnXTkMbPEyk5x?=
 =?us-ascii?Q?gOZG9M2Pvq/g1N6TqSPcTiwSpMob/YZrAUGhys6pRMRDVY2F5stE+SuUE01N?=
 =?us-ascii?Q?9Wej16mBSfSctELsTdKEhqCogiIOJmqCM0lNi0+jgZ+whCcr8QUuiv8xRlVc?=
 =?us-ascii?Q?x18rTEsi2mGwUkcsvX9pHuJtvT/cY3U9sJMAsHUckq7vjdTLfK5PLe9jE/C+?=
 =?us-ascii?Q?+UDp4yhXdvYvMMdf+Aq/HCvC/vsrmEVab0FfeKzKdpc1iwD6P02PiFxUUPuY?=
 =?us-ascii?Q?bJ3SwGFUULnGFY2qF5DJMZkI/Ow5pmU9b5CLrSVbIzHLneOBllagYjj5ILhc?=
 =?us-ascii?Q?n9z5WZrBvHnO9hI7LdrCe+Pbf+9KAfb+Sh37ue5i/0uI0ATcMZy16NDW5V/Z?=
 =?us-ascii?Q?JdF88uZUITv+sXwtDCa2vvne8Fi10enHSwQ7EBoWyNM9TNaN35PVX68DeAat?=
 =?us-ascii?Q?VnXbTCwQj9o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pjyZfnfih191tL59d9GKu8/YHEizPMGYA+DJGgSs/f3ATVxBRkkLyjD3Kfuz?=
 =?us-ascii?Q?xVFg3yeNCSKCg9iOoTNRyn0AatlApon1P2oB4PDxzHz6bB02G2nShBqYj0Sh?=
 =?us-ascii?Q?L8v20E36SNuA375x0kVDbaZ1WlfBoYoQSd8gdYOMmaFfh0l9lOLp7JUMg56K?=
 =?us-ascii?Q?aURNnIWB4OF3IVywuWVNVRRBOrKkkL8+MMAloAgpeVAxkCLFMH8l3cSEtdCZ?=
 =?us-ascii?Q?YzGmBFt22KdGDDCRDo2UTJWytGUrJ18ayxxb+x0tvoXlhRUNzi4/gxTNqPSr?=
 =?us-ascii?Q?OPSt+CeLmnXoMNE3iElmVV/Pi/zO2yrZTeE7kY6FUHrVXz4PNDrjTA2F9Gcl?=
 =?us-ascii?Q?PhZ+Atgkz2PsLapz4q2mOme2KC7bF8E8qvCl4K1lChEERoGPdAQIAADd+JBX?=
 =?us-ascii?Q?batvyHneIpkdANnzIRv68oIVW8fIxXsit+OTieeX6wn5r0ozEa+mAcYHl7ey?=
 =?us-ascii?Q?IT/J5aYQSYuOkmgn1jGWxSryeu0Q0PYJQHgpy1+HU0S5P3pZm5aGEhWTcACv?=
 =?us-ascii?Q?6Y1WXZAklg9qKqLLgPAYEcEiYjnOKiaSbD0d8UeaH4oIl3RctUV6pP8l6/Rg?=
 =?us-ascii?Q?y6giikn+JrrZBbOOYvz3cOcbWgslr5M5ArSWpWZrB9fmoWjat1abMa2y9kfD?=
 =?us-ascii?Q?R4BwBXAB37zSkhUKGW/0EhJzSQFfy3iY1W8bH5PFF8E5z7mXoktn2kx0KoQ5?=
 =?us-ascii?Q?RnF+qyK1b2c1F7p6LOZ2smRO+3KZ1WKFp/SOIw9QS9AW0HHYW+VdEl/WL6YO?=
 =?us-ascii?Q?xRNP83yBKT6MhpNsTtvIHEwu7hnJQs8mzUHfLQF/MH93eWOHP0jMNnRbuDPG?=
 =?us-ascii?Q?GeUgDIYaL/i8p00wmK/UTDflGd09mwefMJwOTuwX0YEkAAYmb201FHCRPJAQ?=
 =?us-ascii?Q?FABIbIniNSg0PmdMVuFiQ5LvRQSJy22lXEtAlycnZn4pi9uRQFM1QkgiUgXS?=
 =?us-ascii?Q?Ya5+CWcAgTHIHmK00bC9hfhiPehPb5dorByFgpa1If4GgGwjit85jXKHq+K/?=
 =?us-ascii?Q?fmNG4wxr46jB2JJ7h/BRwlI3aRqTztBUlPihcw3unMfugdtsW7RX/U22EiHa?=
 =?us-ascii?Q?+JgL4sR2aOzSpFPfU1ZcFARwh2zkkMgNZXEhpbYxyjkw87QZS/HfSCB38Vdn?=
 =?us-ascii?Q?ipcN+IE69KiDfEnj8LxNRjiAyidIIdFjRvB6MUiU4EAHMHLABxTjsuIWZ+jW?=
 =?us-ascii?Q?PtNxxpFJ0WCiWtF9JJXPr4zN+AV9qwXDgqnFtxFthaL8YhuFnSmnLoPsBpNP?=
 =?us-ascii?Q?ovCbeE0sKjRK9uLe2YuajLD7mHnmsaHC2y1ZmdbnIdbQMG/JPXMkYGdzA7AC?=
 =?us-ascii?Q?+T9UgwrDiPeRlO699xWaolWUL0gXGT9zoI+RqpLPfeTBfjK2pWQnLaXi+d3L?=
 =?us-ascii?Q?sS7x7Jl0tRSpxAqJD9Svjo7pJzIe9ON2HIyUFWn2Mbdp9+rLsWB1NmUxPY+/?=
 =?us-ascii?Q?Qa/8yHtIAnty7X/isiMo+N8adaFPbTFOEAEABEl+RUEgn0Vt1qXr7xNP3a6g?=
 =?us-ascii?Q?T6RxOYvZVtOsjMvfSPYsu5goOl3fRr/XuAqq/83rdCDb/fFlCwxDBMOQBcAM?=
 =?us-ascii?Q?Gu1tkD3C/Qf53BtEI9cCZq65pZ26rJeA03uYjs1la10odk+FGmq5bOS9IKuN?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	meywF8FFtmguFLEo4U+RuhsTzhCyK1TWjXoY7hgoBcS1QQQJelmKj5Il7TyMzLFhTlbi3MGQWRBI7XGdq1aKq3A4UtWplg4L9AK+gDm3NU1+jnaOr/qZCGRqHi1aRQIee0zVC+gsBonoAPBQN1p/EDZGYQbtRrmFzkV8BhAhwT3oqDpf4RplqvIM6AJ6mAODojuZtWD4QxP1J5lm+e9f/n1dN/awBZGlsAOtAIZEQBWlK5cyk6jb5D9HQyTdFo1Hf3VCUDhVf5yh89tc1HazSku3haYwCUeKEvhoOrYmbG6IFRTKDPsOcoyeYjZ57EpSgLrhQFT3lxO/QJT5VQoeu6KqndOqnIeKMUYv1uoE2zmHzZfQitg3AWs7RAvkdN7hGMt5uoUckfNXCigLhoDKiS/+6rtOk1jUnO85n/ML720hvogri6bs8X7QAu27MZCfWQmCyNSq4m5b2P8c7PIYi//eANz6OeTAv03dRG9GAJrhn3D+7usTZsZNXsVkUxwFZjWzUE3D/3gM5fMSsiN4rqZS4U8qiFik7n+01SKo/Nl93fgTMsVCodf5vUI6BBvnZ59ZAYRnMzy6zpTA6qm8Fb1LSbkZXSXQa/bVLn1dc5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03390a08-8835-4fbd-94ce-08ddb8869a00
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:04:00.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9hp8x8EecEkAkrg2Vaa9/C8Yd0r7/HZut/js2SnIOQv9Nc9x2qoDxrFgYrWtHiksTSr4LTRm34CqUhqkv2+qtm3WdNl9QbGzSRCNR0V2nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8337777B9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010060
X-Proofpoint-GUID: n__H7PrE-zdWfxHNHryt89-46FXVsW-u
X-Proofpoint-ORIG-GUID: n__H7PrE-zdWfxHNHryt89-46FXVsW-u
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6863b295 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=j7oEd8P2PXKous34eYQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2MCBTYWx0ZWRfX0ZRbC9LvAdrt oivIO0veyHKC+krgWeCaKjZZ356lneJblJDCUNHIKPHmmDDlJw2m+Z+CUFr25MAq7hGa9WeXrtQ qTkaj1TEZZ7zARowyGR7vT9l/cOPr46FxxmKJCmAYy7KnLlKDBv/4ZDyQELzFv724sSBMFtFlPl
 DP98kcCmy9ZYMZdnCs1+SlOe3k+lFPkgaoATsAjrrbYzrm2+iMqi1FV5DC9MiOo4CNehYwB9//C 7y+XjQzw61/Kjwehy0ZwaNHCiVMzGaCi/3EjyBQJTyr7b/Y6kHZOQFh7WZXFU4IW9NvW9Ms/5Zu qmVhR3xWTbKVy6yITDbgh4gPN8vReILIvCAT0GMVlIms39gclr0zI8ctkmaEL/bg0zB+ML591RE
 l2iflBMnGGlPpsh92mIGeg2kA4JXuQy0o/bx+sineUq27Rp2m+CpVKmG3j5x94GRiy5xCJVJ

On Mon, Jun 30, 2025 at 02:59:54PM +0200, David Hildenbrand wrote:
> We can just look at the balloon device (stored in page->private), to see
> if the page is still part of the balloon.
>
> As isolated balloon pages cannot get released (they are taken off the
> balloon list while isolated), we don't have to worry about this case in
> the putback and migration callback. Add a WARN_ON_ONCE for now.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Seems reasonable, one comment below re: comment.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/balloon_compaction.h |  4 +---
>  mm/balloon_compaction.c            | 11 +++++++++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index bfc6e50bd004b..9bce8e9f5018c 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -136,10 +136,8 @@ static inline gfp_t balloon_mapping_gfp_mask(void)
>   */
>  static inline void balloon_page_finalize(struct page *page)
>  {
> -	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
> -		__ClearPageMovable(page);
> +	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
>  		set_page_private(page, 0);
> -	}
>  	/* PageOffline is sticky until the page is freed to the buddy. */
>  }
>
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index ec176bdb8a78b..e4f1a122d786b 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -206,6 +206,9 @@ static bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
>  	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
>  	unsigned long flags;
>
> +	if (!b_dev_info)
> +		return false;
> +
>  	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
>  	list_del(&page->lru);
>  	b_dev_info->isolated_pages++;
> @@ -219,6 +222,10 @@ static void balloon_page_putback(struct page *page)
>  	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
>  	unsigned long flags;
>
> +	/* Isolated balloon pages cannot get deflated. */
> +	if (WARN_ON_ONCE(!b_dev_info))
> +		return;
> +
>  	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
>  	list_add(&page->lru, &b_dev_info->pages);
>  	b_dev_info->isolated_pages--;
> @@ -234,6 +241,10 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
>
> +	/* Isolated balloon pages cannot get deflated. */

Hm do you mean migrated?

> +	if (WARN_ON_ONCE(!balloon))
> +		return -EAGAIN;
> +
>  	return balloon->migratepage(balloon, newpage, page, mode);
>  }
>
> --
> 2.49.0
>

