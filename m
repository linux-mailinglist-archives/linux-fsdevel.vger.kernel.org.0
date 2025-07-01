Return-Path: <linux-fsdevel+bounces-53520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3917AEFA5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721A74A1689
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A8F2750F2;
	Tue,  1 Jul 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lVo/pwxy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vTFT9vzv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E663B274FE8;
	Tue,  1 Jul 2025 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376086; cv=fail; b=cTYbcDbdeLixzfGwAFfk2AUrRn+Ym49sZWizpjR5G+YAaOTfEjprRAM7EaAvuPZmBgjViJp/qygOV1KO7okDplW7SbUAZ5TfJE2gaon1adaMme8z8JP/31pImHwFVKNOTseeFk76zyuXoDR9pr0tf0RdDv9RsejqfNGcdntv8kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376086; c=relaxed/simple;
	bh=rlG8hdJw1NAseZouPdSl0Ct7KsghzSoNBThErty60eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cUne4/v4yfGgkXpdSRGlTO/hKohu2pWS9p1l4+aDXPoUTRXb05eZL+Z1Vh3D/+Lksv0JqEEIZb2Gh53/Os4+A0WoHVu8bzCwAIcntHur0dQK41jTjhTNwlPku5lpyCEDd1LEkxIDtAbA1R4GC4EUVdkaafNw8nfm1YIgv76gebQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lVo/pwxy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vTFT9vzv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9CId023956;
	Tue, 1 Jul 2025 13:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=M9OtS2HWd25mlIklHS
	KOou82gkt5WdxGFQy87SOu9/g=; b=lVo/pwxydIfE6Sx2X+fMBf7LN0BlL1FiEV
	nqp2ylFNgN57utru66vqZJAwYFMoFLLtZIAysQZ4foJuPAohWqZGsE4gA9fTND9h
	vxeYUMDKrFKEyc+ZRuKO27ModVQQWZBXYzC53c4BquGmxnrdAdroDTNa85Q5q0GK
	tCt2Id8td2bMgOjumyXjkds4Rk9RcT6CnZIyH2lEsikNKEarTjMz2JOuLSawrisF
	ia1nMPc3KwAYJ5GmJlKaL7T3rUeC8OAbjuSPqdeMwzLrpDllVmfIxshRB6iy6bGy
	3gzkKx3eapIoDRAUCo2nxgDzKkpcEEdV2dVvYCGf9hMoI8CkJHuw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704cs4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:19:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561DBPVn005794;
	Tue, 1 Jul 2025 13:19:11 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uh0jj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:19:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNmMVhBwcoxkWcomG0b8b6LOObwiJLAe2fqtQQss5iIVCtKPTmD2sB1PMRvgMgSl5SOtM76wSxAGE6D40Fn4M0ewV+3VNoLzBq7bmcjofK3gKEIjgondtq3JoDIF4HcKADVpHXiLPkj0t1DYc5SULVnzM0dxBAYSZGv8DY6sBCkXnovwcIZwuEcoH5te7ehi3B9iKz/SFnDzYusfQ+7ZrjW9Dbf0TWIftQ1+Em9/H6xXb7BS4yJYj4fJzr+JrCSreOhOHyRJzyo+Gs7ti7zIkEtHXlmqd/jzUDcplUTZ+FKacNVqweDo9jCvWk2PoIaTfQP9uunj81jvJSlPNotK3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9OtS2HWd25mlIklHSKOou82gkt5WdxGFQy87SOu9/g=;
 b=ytwH4rj83ck1TWqJVUf+Ejba+geMSlcRGWWHdmi/QjamXVzE7qQEtv2j1GvKa/XBSqyRDmbn0z8NgPZjQJ4d8a0QeHoL80LEkwt99Y8nxyCZANtvJcNYvvA64sTmbZ10uSIXVeLxXEdt8EkrGJ382PCypB+OMVghdjzNDKp2F+DNoG5TtZ5suqixXQoZna5U+wuaqM6kKoFqCivKl4lLs+oIz+xTovGGRaHHNYNDF4CqlLETC9KYXm8dqWPKMY+UM1AnHMJ3qeR8ayUxzaY9AM7Bncwpj5wrRa/OQUaLq3riyFOSSsPFouzSoMPv88uFLL0AcMpABx0GoK2ajnk5jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9OtS2HWd25mlIklHSKOou82gkt5WdxGFQy87SOu9/g=;
 b=vTFT9vzvuXL3/2ZhrnxGb8lk4JGyZ41SX+1n25ML6x/ohNUypG+xw3o6I8ePZlbN2tM4p4EVcd9Qraaic5SRcXQw0HjfJaNE0PKtwvi0ZEih9omoPxj4mJyvvxGvLEH/qaY8Qffq8pfJVhVy+2JkU7HZ1yLJfrSHJwqZHNDnh4Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4503.namprd10.prod.outlook.com (2603:10b6:510:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 13:19:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 13:19:07 +0000
Date: Tue, 1 Jul 2025 14:19:05 +0100
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
Subject: Re: [PATCH v1 27/29] docs/mm: convert from "Non-LRU page migration"
 to "movable_ops page migration"
Message-ID: <8545452f-5b0b-4a6b-a473-5a5fad79f390@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-28-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-28-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0429.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4503:EE_
X-MS-Office365-Filtering-Correlation-Id: 219991cb-11c7-4a3a-6e2c-08ddb8a1dc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ci0WwJkQ9ZJ/nt5CKYtldVU22PEtnoerz0NE0JbhvX90yGUHRYxAvRqPH4cX?=
 =?us-ascii?Q?6is6cXmiY4ycuyXW9DJTl4y8HwbbVdJSNyipffL0//5OXgCTjDfwF/q1YC/S?=
 =?us-ascii?Q?SFKN3jx0hD1L8yYDYQC5VXjsN7oC+iyasbqQ6Cz5EQmYerm+Rv/aJst5G4Vx?=
 =?us-ascii?Q?smqNUBDex0cb2os1GeGE7SE6v/M0xg/22KD5Ekhxl09plf3yCInf7pzk3zHY?=
 =?us-ascii?Q?QW4FU6aGlYn9J+VFvDIktzwPzGXLexb7fkvQo1xpWNgVa7dIEtHBK40jn6MC?=
 =?us-ascii?Q?3Sslm+Pleees1iXr1E0If06FQpCdlfItJo13RsvmHCpsFgrIdBm6iH0Fm2cB?=
 =?us-ascii?Q?Mt8pzY8FtO3nAsJE8ykY4OmF2bBFSCfDJSc5ZYZTj0uKSDW251AwXFfxv20+?=
 =?us-ascii?Q?dSmUf05n7OVDiiDGYBJr3tH9759SUeeq5sMfmk9TxoOgtIXrZXZQDgpnv2JA?=
 =?us-ascii?Q?n7KHGb8Yy6SoRTCTmxoOYrgAVkwSJjWN2o0em+VP4S25teHTL2m21gYSKte8?=
 =?us-ascii?Q?Q2LoaleG+tbKDSR9Z3b4+bzKeoaadAIsgWwtZawDlPBw5IvS9uXykFbNZtxk?=
 =?us-ascii?Q?3hGXjS7ykyJHUTKFw/odr492ksCqxG+LA0XbyQGa7LAb/HfR+cLhLFOwqxNh?=
 =?us-ascii?Q?oDS3Af9e21IvuUjUOjbTPZ9JyMiS9DQKEDYbL+ESWWGm0LI5YDvBrY2zJ0oM?=
 =?us-ascii?Q?gRkLxlxbfoE3oRp/9L9vmrAxGPHml8MYAKx+ZmdrKWi/Pyguiv1UIrYxyA5p?=
 =?us-ascii?Q?LXg8zlOgv9g6+Qck+Obm9QljFS5SvAeCBMyh/G9Pi2nGNjyUgpaF/0/L4zcO?=
 =?us-ascii?Q?qJwh+Tybi3SIOIVwnXxxSuaQs2jqhhH0eKwjyGBBKB2fdFTkCVbZJjv8c2sZ?=
 =?us-ascii?Q?VyQSSiZ3NrAXvBo+r54Ww7ZpJ9fgvGFDLtzMlxZlD8+NebCB4Pn5inTv2T8L?=
 =?us-ascii?Q?IVNIY4Ny30zVpgOiWG3fsePK06G/rb8wos2L5nhRne3XSkyv9E4f5z/RQV1b?=
 =?us-ascii?Q?qa3iLicq48TSk36dGf+PospozANKcu4gT4mFaGtNFEu5k6zCsGAdJ87DCoEb?=
 =?us-ascii?Q?A0+cu6Kqdlwly4k9TNsGGtMHiSU5YNGSc3c7B0nMq6pwIJr5DtnJoaqhfsVV?=
 =?us-ascii?Q?qmbPdHH/TUc+iNNhcyxtiqpHdy00D3HVWZsgUbRIFAJwxsomNS976A1TFQy4?=
 =?us-ascii?Q?P2waW2eTzt0j4gnUtSaiHvcClD2Uk24Kiw/LkdloUb3+mmN8WoHRdudiSK31?=
 =?us-ascii?Q?0R704jjc28yYHmio8Y/PDLAp4MRVW2ywG3KY9BflgJT13XaUv7b7yq01jkJS?=
 =?us-ascii?Q?KvB7dWFOX4kGQnTQCIdsJafvHLRUuwbNXQt6rEomUORczoVVo8QIz9uM/E8z?=
 =?us-ascii?Q?0Wkr/ud0FfiHUdudQGBJGwlvjxbY5q+evH3+mwGG0luhymBlrsDRKsEof5xY?=
 =?us-ascii?Q?diiD22LE+hw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KdKqjZg7JEFzQnqXZMMItK+ZydLlaciKMpFYPLdFsNWR0tnPjoM0f9+GYZwx?=
 =?us-ascii?Q?OcJd+EzRnB5aTQRuBCV9yp7jEAMr4wYpFHVvw5F+lGWvwp5dd/3Jm9oJD5wd?=
 =?us-ascii?Q?6ljmLHlefTLtkksNNnPtAZ8F/METycRClvDS6S7dMLpcKnoB5lIT4ptm2Nvb?=
 =?us-ascii?Q?YMkeRzGLsfBCGXtq/V5cKgwq90dd89EVPv5EruXG0RkI6rKghIUXhL5keGfm?=
 =?us-ascii?Q?0kk/nLqb8nBPNqQswdX0jNcYW+VM705KVtt0/D2MFevsOoqx/lTeZ8EpQ41C?=
 =?us-ascii?Q?+LFUF47YHGexYaiyum2/ZTW2PqZ6Pc0rBMXwVzX6beTbbKo9BFgUSh5gdJSR?=
 =?us-ascii?Q?6wZUHDkfpOo1l8hD4aXD0vRP0RE6TT686KYn7NUz5wq+HGUgJb2Lmkb803Xm?=
 =?us-ascii?Q?TQlWP9ifSvplYv4zYpLpusPXDEiZJwdvlGg3qlFczrgFso6h2ZYVglm2aUnA?=
 =?us-ascii?Q?XQCtX4eGXGAf78MzbrqWJszsdMwAgHUETS2KBLXxrrEuxW4txVLOHFuFO5Jn?=
 =?us-ascii?Q?UOK7F8R+7/7l/JqS+jRYTNtYdAQH1ZDYltoaFc0ks4s3WgQ+vSS9axgA1Zbh?=
 =?us-ascii?Q?OB0iwjMlpNb2QpB9MIW/kkXI5hUQ5hqsDqWLTS2lTS5DWnI8H5cIu/FekGK8?=
 =?us-ascii?Q?FBbtenUZvr2yNVBlcyHgYaRR/IGAkmpXsWY1Q1fiE9GUkabBg5Fsuci6UQN3?=
 =?us-ascii?Q?jJtUh6JL+59pUbJdxLpyw8t+bZGWLV+p57mgTI0ezome/GjpKFa4SdK9YFjx?=
 =?us-ascii?Q?4OEvXJ5PVfQ8iuhESmVulV/8sJNkgx5++m7VfFVD9C0S1pBD/srds/yax2Is?=
 =?us-ascii?Q?qyGWzb10ReHEaPl6VQK25QsfFFUmL5liny+o+oDg1AqE9I0VniDF+XYLPorA?=
 =?us-ascii?Q?/DmX8qlxKR43kAbTtVmSjPf8KdZ39Xu2XCCSXkucE39xnJd6w+JQXBSgfcTD?=
 =?us-ascii?Q?6dvJzYV/FBDiBVbfn3eljq81212YUmzBQk4IeGK0IcKCoxUnMf858PHP17Z6?=
 =?us-ascii?Q?f2jyanywFyw65yn6xj7uOb0AgucQM4ctHCR4zHKT4ia2T3iHUUqdjFDCQhyv?=
 =?us-ascii?Q?5HoEu+owpcRFt4HtgWE8Mh/PoZTB6pXP0fuAZ4HlMjIIXZ3gwh1GTiXk/+YY?=
 =?us-ascii?Q?z7noKel8NGuvDtsiI0m5sg5ILRHwPjii3Y/T+ubp0IlqiZr80OkFhWmR/wNT?=
 =?us-ascii?Q?YchoL1cyhbgIbzQ/jPN8AGlHEA5Z5FYS2Ic1JqipsrNpCZKGvdF+wADNWpeh?=
 =?us-ascii?Q?wh41DWzz5zsOmKJ71p+gtRy8C06eupn+GkdBNyYK/ou6ywp0a5xM78yJNKVL?=
 =?us-ascii?Q?lL4/xTMWd3zxYL3mnAAQGOX1BSEsCC2QMQlcUF6Tlwpe9rPcbD9tvmjj2QaR?=
 =?us-ascii?Q?ubfbAYeoRCVnRYek4gk9RE1b/LITsBwBiZwwRZeGQJBli8zTX9gPeD5TswHl?=
 =?us-ascii?Q?Ot9lEGZazmoV5Kz+dCI9uDbocql0WKO+rydUd5zGJUr2OSPwTdoKMWdM5R3z?=
 =?us-ascii?Q?0S+YlmAxILilHzIWYeQ7HgLrHfmR+DEjcVCul3tME2ZxE37moCjDLSr9Emg5?=
 =?us-ascii?Q?TXGtY92vc7Ge9P1c+qWhFZhm4aA9ivdY8aRqZK41AMExc5909pAQYNrreFH7?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B1I62mEbykRovGaCAEqz/4L7af7kiaDLK8U+xpr1aZbRXsIMTNwXbfcSsPAliP4VX6LP+i9NDDjsuPw/Q9VOo64vqfraL4iqRdyYtibXy41eMT3RytcuZUF9RsZgMO8H1WL++lAfoeuwJ50kcHmn3vNLb0JynkAGCKtOFftGD9Q0qqSbFfi9nPEoGXZFB4yY+EQ/Z4SwTmCnnz+dLxrIJexIpDiIhCQTy/5928vBgXAbKNfMLHl8mSqMVWPNQSjKMSK3xq6ty+Oao87rjhxUNNDIevhSWNGGplhxxU3VXjYinapBmPkxdgRZkpTAYfboAO/oW6Jzj0AkXIOm8uSuxwLgQk8nr3xusg89wVmRWc6cKsyh0XQ8uppT8ZKOHN793C0kcXFR0V28U4YwSIGYFjH5CUcvkI7QGQrMTKZmp+tFJoQz+Ly6dgl2heqwHvN5Od5wh+d1PMF/SOYcQdJ2nF2icDuf82J6thq5xniqTjiPts98G07T5G1ogIjccH9e1JhpjwUWmmwhC+YNSModPa5fWn+2pTjmTpxaWpnhnH88eIGa72ot75dFYOYkgF3la3Fiv5IcShoX9y1MFcsut+mVAhXEycRZxXv4NkL2Riw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219991cb-11c7-4a3a-6e2c-08ddb8a1dc00
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:19:07.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWVHVceFw52hR1WW1uoMZ7DtkxIi+jvhTMVu/32QBx5lc4wLtO67haCJatkx3Z5SlcF1y/Pa94s7VEkcH9QXrv0JAxnk9i0QwRxAByROiwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA4NCBTYWx0ZWRfX0CktS45UIjpg irUeBGmm7/8HJlJ9Q/zapI7V9uP0zfUOqd9ojhMCyEDgRnohcpR8XnkgFe7+8exHdhFcRyvVWxv +nPYMYDiS/TjpeFaxgOEsD/ua4HjMZKc2wm4gzdiiFP6RAuyo/1WaUMu6JX50m6CX20PdaRVtfD
 JFTP2cSnIp1AdoZ3SXhYp9iDVE7YBWYvq9d15ntfd2HX8l5vIUgWIbO0yVw0fV4qyOqDhzZ52qn +t6xvvFEpxJ9/pQk3+61TgCbfAwGApeiG1neLX9MNkHStV6eFxQMfdskXuHGoh/QCcnEdJbN53p fpvBbpYuNPPqJhkJ+Oz53PzUOjH46FhqHK8FXEC1Ci0kOojMhEtBA4vrEF9dK2TRHiVCKTAZlUX
 vf70N9Vk/hwaWBLm/Y9eatRSKK9/ewaeJc3H/2zQRPN+plnBwylBON3ULAvhd2ZtHXYMdr+y
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6863e051 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=iciZ6SYYCYNhSKRyFYQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215
X-Proofpoint-GUID: txjVf6HdGi3gBlliU7wrc5Vw9T4aDGjw
X-Proofpoint-ORIG-GUID: txjVf6HdGi3gBlliU7wrc5Vw9T4aDGjw

On Mon, Jun 30, 2025 at 03:00:08PM +0200, David Hildenbrand wrote:
> Let's bring the docs up-to-date.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  Documentation/mm/page_migration.rst | 39 ++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/mm/page_migration.rst b/Documentation/mm/page_migration.rst
> index 519b35a4caf5b..d611bc21920d7 100644
> --- a/Documentation/mm/page_migration.rst
> +++ b/Documentation/mm/page_migration.rst
> @@ -146,18 +146,33 @@ Steps:
>  18. The new page is moved to the LRU and can be scanned by the swapper,
>      etc. again.
>
> -Non-LRU page migration
> -======================
> -
> -Although migration originally aimed for reducing the latency of memory
> -accesses for NUMA, compaction also uses migration to create high-order
> -pages.  For compaction purposes, it is also useful to be able to move
> -non-LRU pages, such as zsmalloc and virtio-balloon pages.
> -
> -If a driver wants to make its pages movable, it should define a struct
> -movable_operations.  It then needs to call __SetPageMovable() on each
> -page that it may be able to move.  This uses the ``page->mapping`` field,
> -so this field is not available for the driver to use for other purposes.
> +movable_ops page migration
> +==========================

Bye bye inaccurate reference to LRU :)

> +
> +Selected typed, non-folio pages (e.g., pages inflated in a memory balloon,
> +zsmalloc pages) can be migrated using the movable_ops migration framework.
> +
> +The "struct movable_operations" provide callbacks specific to a page type
> +for isolating, migrating and un-isolating (putback) these pages.
> +
> +Once a page is indicated as having movable_ops, that condition must not
> +change until the page was freed back to the buddy. This includes not
> +changing/clearing the page type and not changing/clearing the
> +PG_movable_ops page flag.
> +
> +Arbitrary drivers cannot currently make use of this framework, as it
> +requires:
> +
> +(a) a page type
> +(b) indicating them as possibly having movable_ops in page_has_movable_ops()
> +    based on the page type
> +(c) returning the movable_ops from page_has_movable_ops() based on the page
> +    type
> +(d) not reusing the PG_movable_ops and PG_movable_ops_isolated page flags
> +    for other purposes
> +
> +For example, balloon drivers can make use of this framework through the
> +balloon-compaction infrastructure residing in the core kernel.
>
>  Monitoring Migration
>  =====================
> --
> 2.49.0
>

