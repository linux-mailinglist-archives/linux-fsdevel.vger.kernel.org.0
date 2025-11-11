Return-Path: <linux-fsdevel+bounces-67856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA745C4C18F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC643B4446
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DBE2E8E06;
	Tue, 11 Nov 2025 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b8dQKQ8S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pgwYxhL+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210134D38B;
	Tue, 11 Nov 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845445; cv=fail; b=mwJV5LaMpn+umYCO8UcnwflUdH0CsB1EacE1crvWtAp3eoeySrUSwd43g0oByST1QHJJDylKJEvzmhWhmCXsVwN2pTFInAH1UardfVETzyqz19GeEfXsg85sRCv+h/eeh4mZwrguiCWnw6iloGwDBY+GZTfUK+MfWK69f61z86E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845445; c=relaxed/simple;
	bh=sc40a4w7PzciT8uyHVqYWePYpKVLSHw3q84ZnR04QW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e2EPiZGqDyEVNT7WvGmFqjw19jAEnHKIRU80tX7R9Umv26I+XeAQ+YX9SBLOaK49F+jOOz6Eq/RbXE/+kU2/tKp6jbxYJcZciFcKIDybt9pjdIs1ZY3ujv1BglaRZ4kiPuHPtqKCu8isx2rVQzKM9zYiXyIYwIm1kA++p4Zmjio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b8dQKQ8S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pgwYxhL+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB78ahJ023225;
	Tue, 11 Nov 2025 07:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BTodb0D5Hw0k1VXHAj
	dGtk2ipP1emfftetzV/s8gXTs=; b=b8dQKQ8Sd4yBVzjr08hQwGeZJr/D59zGZr
	ndsMDqg2g1vM6cVd9YiKFIHpi3fl2Kbgy3ajH7XDwONHylK4tpLowKOccr9kXPHd
	4r7T77H7SflBA2RtXjquZcdJjJUo3FJqpnS3X6asft+6K0Bz7ChC5HkcVgZNxrkR
	7NjQBRWQeZaDDku85v3FSS5snp7IFVayXYInFotUpyDwvWW0e/pFb30D3/0nh2ob
	1W7op2/zEpyroeqWKDbSO/nUn4uQjCyI8UKNVkosYmnoUHEbdjOoS0V6Yladxp1a
	VAiTmSQVRS8DfBEaNwhyCHclKMA8R46XJz/U+P2jnevKmAfAw6ig==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abwkar7pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 07:16:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6RALA000763;
	Tue, 11 Nov 2025 07:16:23 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vad6a6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 07:16:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giqIWxQ5OTdo2uQ9MEFgQdgi6v2E/IO2oO3ApYUqagD3QMvToM8jm8RvHOCgDo/pAxJKAqEB1tHtl6NvHeWaBbzSDXYlNRPPYmI76jc8yq+p9/5+5clx7uPf6jWzBYOvLGDePdBrWDMEZwgGNG7cmZdQ4LJQKFtpwlBqoQb6snu3jW+TRtKqpqIKnV3Ec22CLp7MrZX+9gOq0nDI267UQJ5TMOoq4O7YIDLrU06sRbWnTiXNt/nJLMgunV7RuKxlS/O1F5V4vFFjvInIn/mietZyy5a9jK2l6d60rp5YANSfJgOFcIUW7+1LzsehTO+6KqWn/TqFWlRpsywJ9lI0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTodb0D5Hw0k1VXHAjdGtk2ipP1emfftetzV/s8gXTs=;
 b=wVsRhj0HG7zyHMqcSjAJeUkD8/7FLr+N0SgKsaa+bACBXXr72WHSe3nmYw+Fxfeoksz3k8Z042UlLgKY3dYhsUZ0cmkHtUAA1dbY675IwhqF0DhsuWMdtDou6PBbpaR01MGkLSMv7DboxD8j1cDkhB7L2xGQrwj/w+T62zXrLhdyiuJM2yFNonQ6mXREMYxMxPmUUUnZnGBydhOEVfK1t7G28mpp70cz/cKtkT+Kd7b7x/VOsg4zvHMRflWw9giDotJ3vo4JFW11+vTVjfv9SK1S81m9gkG3lb4AtrtUFBQ7oAY1iN+7/ifISZsRGrf6pbTowO8Y24Dqlbz4inrf9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTodb0D5Hw0k1VXHAjdGtk2ipP1emfftetzV/s8gXTs=;
 b=pgwYxhL+hb/0BMaRY+I7Izr070lPON7vQWEV+yBAH4fcFeBb+pGwtYFbjSeU+O6x5kYqFE2xcx2pKW7BykFQgHGeckds7fQIboWYfE0VRKQIPvdI1UQJyRkV+iw1kV7sJ9OtCFmtqefpxVr8q1wGvVzQtZv9AoA2LcIPHz8s0KY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA0PR10MB6426.namprd10.prod.outlook.com (2603:10b6:806:2c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:16:20 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:16:20 +0000
Date: Tue, 11 Nov 2025 07:16:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v3 02/16] mm: introduce leaf entry type and use to
 simplify leaf entry logic
Message-ID: <66b35154-860e-4586-ac30-160e688e1bc4@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
 <CBBF1711-5881-4B5A-ADE6-1D86C0E94296@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBBF1711-5881-4B5A-ADE6-1D86C0E94296@nvidia.com>
X-ClientProxiedBy: LO4P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::7) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA0PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: a5368719-4de2-480c-afc3-08de20f2367a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i5HKm2+C0uINL7aFQekJeb0nF9JqSeEy5pqNqjt/RtkwcTdsjpFV2yC8olTD?=
 =?us-ascii?Q?1Kh2BoHAG5MVOQchqkR8QIQM6dDjBJcSEDBK+f1TBPHBWYwCwXW0vb3UTJbj?=
 =?us-ascii?Q?k4l17F4uVnANFESPh4LirOUbEDVqXFRWQh+je7xDwN6BzWtvwnviAX42b21f?=
 =?us-ascii?Q?R7FlRsL+9Sf64/0vi6vLHV5zJq3UHmmIFKpYfBRbnBHvJtlbrj0ASpTzXhKH?=
 =?us-ascii?Q?yEQRLRxDv+p3r85XcOPYZ9NpldGEgRRoFQln/lhZy6oXp7YsOvONxBA2Lq8B?=
 =?us-ascii?Q?Vf9J53c6kIbA6axeyW8Tu7nVhLuBkZ1ccNNg6TwU7vGWTbErC5kGFHLovW84?=
 =?us-ascii?Q?qii7qsK/jz8ba4Qvp8qClbpPDAVYnMVGuW0RLqOCsHlkW5yr9xzXaOGfES1r?=
 =?us-ascii?Q?osCkxT9hrz3dnEe7qITUZSKPpJx2RhUeLJMm4mMlNdEinOHSF0OTDXeOV5B2?=
 =?us-ascii?Q?xaQjVX1r4R/sY+d/In+wRG8aHiZdzOq9qnPH67IQtFEC9ZsLUnZJ3RydN0QU?=
 =?us-ascii?Q?wpNLxwalgF/ashVw6v871XoIVlCjkxj5hRZdwPg4fQWoyDadaGivbuwwrA1D?=
 =?us-ascii?Q?9ifgD7HmtFSVBbR1KeY+vZ+0WEM8Jbg6kCJyoYalttBaZu5Ze/nvbC0+2I6Q?=
 =?us-ascii?Q?sgs09M5U07T09kJWn8ShtMaaqXr3s0C0RD9kYBkOpBko/JMzxEzvN/afiwgw?=
 =?us-ascii?Q?IOo/1837ehEhThWT3kPSGBOQNw56pdwoVe4RSwiCIZPFVZL1UVVfISREEqpw?=
 =?us-ascii?Q?2AMPZr3wrcydYQePC09topf8WzBAlokY151m3bBaqDjfdpeGA7EMz60tlddO?=
 =?us-ascii?Q?vOUqW1Id2oq4FaU+pciHI5wmJVqjwdqO877ReUlbyzKm3XMsK0060wRPu6AK?=
 =?us-ascii?Q?7JfNcQ5yFu+30zIt9XOhICpOWHewPcRxPkV2QfR2RGayFD6hDPmhUpG9+sWN?=
 =?us-ascii?Q?6taBtngNEz3foCK9S0RelzvxzapHWwnQCKpHKTUCc64ctZlF5nakCE4llcIA?=
 =?us-ascii?Q?tmrZCNgC9clJqRbJM6tqb/D+jA++wWl5eEKvIMWUizn6RXy5ANRoFnCXTdj3?=
 =?us-ascii?Q?/1fvRjbTD+5P6yGQVLRjPB7c8O4bfGArMoqBXTeV4AkVmSF2s7y4AZifHXlR?=
 =?us-ascii?Q?rkUiVBlYn2t0ARE4HeFZfkyIojdcmfAXWu86rYfDcnpnGyFr8gxSTbK46Ewu?=
 =?us-ascii?Q?knWNV4O3lETDaB4kcCJzk1MOU/qYlYWBltLjA/ym9u4JrbPiXoLgpTBvEBZu?=
 =?us-ascii?Q?l9TM+GadZ5Yag4VpwBXB5FLBYxnBDxYS8Rgwy/0XdQ9lBpGGLBVvmPgrhID6?=
 =?us-ascii?Q?hDz2/cehCFJu9ALJ/oW6sD3JOifi7f8hx4evaxaLGXcqCxGoOD7b2w6NSd2j?=
 =?us-ascii?Q?QyaL/TMnJwo+WmdZhA52kWHU3EfDQMAFrFz+e/gyql0XKbuOtWkJD42NWkLh?=
 =?us-ascii?Q?WQriXQTV2Lcg0o+3WrTSRa9ocenRnh7b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wait/XyVSyZJGuRR+2ecORLtMPx7GgFPlA1lwdSHO73IDt/dwFTFzc7lyT/b?=
 =?us-ascii?Q?jsK9rWlH63Cw3wVhHgfAky6FtFg0IOz06WWnBCpWTe4ObWjRgySOC8EXF4+4?=
 =?us-ascii?Q?M7Uadx7QtO0YOVNW//tnZ1yQqH0Swc4JcxuK5QwmoqySo9G6mEZwDjOoHCmd?=
 =?us-ascii?Q?goN1wXsRCri9dT3zzWowuVKZmPi/CcMepb3LwVKKqJ/ZQjTBwHVKknVxdG8x?=
 =?us-ascii?Q?n0Wi9NqJkp5hTzoaO0BAymFFxLRkSfTBpMMjf1tPG3nsTybkLVbB8Dj5OINs?=
 =?us-ascii?Q?Zw79Q8KHfCU4/PSEbB/TpMZeMHxS8KIrjAD/qC1c/bWDgM28LuqG3/7geGgH?=
 =?us-ascii?Q?WtFwAE+Nc3oUXCDRjxqy6mWsylN4ZP1HcorMzMiUyP42kQkrtUogYbQXnnJ4?=
 =?us-ascii?Q?PVmSEWXEcJ0nqgf0orx79zw7DrK3T6IXoz8oRkJWBPz/olknEsZI1wgYS7UG?=
 =?us-ascii?Q?HQRrNvRyHZ74ivRzVo0dSWO4fhzQulWuILTiaJlF364sPu1CVhgqp0qmKru9?=
 =?us-ascii?Q?iMa0a5lFW3QKSGWY4GPgNnpmQ5roR9dki9RfGLHm0K41JSm+znHuctV/UiV9?=
 =?us-ascii?Q?GIBaKK9wkhBJESzqP/HbNjsxoz4Xgb23mFsrIPdGJDLeJxrXHk4qAe98UOEJ?=
 =?us-ascii?Q?M/G9N/Ph/mwdR5NX/DKCqHvbuR01ebpq2UOKf0M96InnO9pJLNB2TdpagI4U?=
 =?us-ascii?Q?pv+bZD0mt8RLYNWJ27yv9GMF5Ifac3Gq9EKg5275odiAXFuuh+SdI3E7nuz+?=
 =?us-ascii?Q?ymJuybwESyaZ/ZBKx6lLLj35MzQG6cPxXZSuuDNELzgUfoTWE3QLYxEC3cnj?=
 =?us-ascii?Q?Y2Gcv4c8OzuHt9lNhQajo6iqERTOgHCh0uzqGVti5WYfv0gnDOdIxhh0I7Uk?=
 =?us-ascii?Q?iS2fpllzgcWTc8N/nyJ9c4dcuDQ+aa3elPm0kUZK+StNYoWmjxDPB3B7kPyP?=
 =?us-ascii?Q?5guAJkZK/16Fi5DOoSBAGgL50WIATquqHjTYLp+v/qqBex2eVI5vtLQDFOdp?=
 =?us-ascii?Q?NTsUKZLlK4v8m8VesismqhCwAkY1rJ0qC0Ie5yiUjmwcqKGeOy+98B/oIIJZ?=
 =?us-ascii?Q?vmCR/fFaBTOxni2/4MfQwoGyntAl/vXEVVUxVB8403XZzaaVxkm9OAcWRzZD?=
 =?us-ascii?Q?Z7zpQQEVSxzZOd3x6Q47tmwW1AJMGbly9XyGtqvdkiPVfZpKrfioSyTm9DaB?=
 =?us-ascii?Q?iYmcFYzHIroO6ymtgtqohEo+Sng8qNo8+Gb8XeZ3b0AQ9lwFxJraCwbMWt1A?=
 =?us-ascii?Q?HJIegCD9tBNsYL1ckD1s3o0MOF1jMZHTVGpSIBBZcDcCLpg+iKow4yg3UXki?=
 =?us-ascii?Q?BfnR4Q/OJpUEDJO/SQTLJH0Ni9UWYnrWbrRUQdg8X7mLiaBvqGmllYFBUGc3?=
 =?us-ascii?Q?VZAy3sKGf0s0DsPemqLkI0Y2n2hOqffJ5qRecGsCY+hbSnZ8KzhZwofc7sJI?=
 =?us-ascii?Q?lRzSlz7BlFnDuSRw2j522zXNedB9ayHmdNm26bfavHFJZONRORcH5qTrGPIv?=
 =?us-ascii?Q?hNcCEYI3AfJ10k7QakMT8IJRBLpSlybCDFSiYgpR2JMGdwv/B/37Q0UsDQ6L?=
 =?us-ascii?Q?yOz1WQ/dKMS8ev2b4N9rMghQ/LOxZhez9eAGT7N9OjP6dgCpEV/D3tt6kfYz?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	32YpCFuaZqDhtny5MSUkDIRvsFj95RsNf/prJq8FgEW9k4hxhEEDhtvGdq3lgn0Anidr4qZF0Pt2GnG1aiTbNPbeTkeA5Bp+WC3pdXeVaaIgP1jZRpzhhEGKZLnloQsnPYv4cO+GAHKOKNAnCfSjYi6yLUKvXY0wEySI9Da6Hmjpv5JpNSnAuCITxaR536EIaF9vP2QO97c8iNZ7s/fl1Uiz9n4cNlE/55aaV3/EM5cZiJaGz8duc8f/hF6flW4eFuhOvZNf6We9DNU12/RTtEl/s3qr4cyATguKQ2iwvmuQyqzJWdjRxrf+MGRoPHl8r7DrQxbihDq5tVdN6yuV5+lbD7C8m+SAuwlzKgpC5FCaVicWWyKr+F8n2dwQ0pIAWc+FzSbIJ0RtEwUewplvuV5bbC7x2DhHb33FlPGm3mwqKrBAD06D1/uC4tsKh7JP8AO3Xcm4Es2IctgytQDMWDYUawU+tjqs8fh9SWjNk8rzt5Hewu05MaSYB2m0h7C9t6K/IMGoJL7Ixl75r6cbYAOHwVphNOpLxbyaV6KAucs9w84W1RH7Um7l0iee+PbbzFlQmzA4nyJm4fKQoLptalS+HusYTFVqojV1msbVfJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5368719-4de2-480c-afc3-08de20f2367a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:16:20.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6pQtWRJsTIu2E/ZySeM+WD/P+BNlC9ZRauNELbBkxFg8Zw21+5CxMMF8glTbDTOVDq3u/HwUTAZyJTLWfwyUFO+6PNIA9jOb7Mry/Os/Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511110055
X-Proofpoint-GUID: hrzeW9yx_0u8acfijWXgv02sAAtK22E-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDAyNiBTYWx0ZWRfX2vNPD3GZ+QYA
 RwdqEfS1uXyDZGL4P2bhAZtBNJghEH3LxjNeHEC6BGKkpaAB5Q80lSD/JjS/mMCIVVdCF+xe1by
 xEsCPaFAGWsWIUD1Fbkw3zYYxTU9an3cOkx5n3vDxYkzHNIg59W1bkrDceUpKaACQemLrsqncaz
 866bP7RtzKXl8LUUwoMVzYs0STpTPucz1Ro22IoyFBXh4GLvoXTpVb9nueX2kdDKaDBnd3DP0LC
 7npKuhVBI/2bZj/yX8vMDSLf+FuQM4+1l6xtxAbUFCFrwFkwuGjwj2p/plES/9GIBwd8QRm9kE6
 13VNgrofTsf0U9D1cPojvb7c1oY5MBsshIKi/fpGK5yqaxq8UpeUdjawxAEcqMmV9+wbGTcQA9/
 fE1ZJpSf3tRGaWQzm1PutwxjtK4mFO1/LahFNqXYUgLBk0KmPzk=
X-Proofpoint-ORIG-GUID: hrzeW9yx_0u8acfijWXgv02sAAtK22E-
X-Authority-Analysis: v=2.4 cv=BMu+bVQG c=1 sm=1 tr=0 ts=6912e2c9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MQJKnruJNZAUxG_lAR0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13634

On Mon, Nov 10, 2025 at 10:25:40PM -0500, Zi Yan wrote:
> On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:
>
> > The kernel maintains leaf page table entries which contain either:
> >
> > - Nothing ('none' entries)
> > - Present entries (that is stuff the hardware can navigate without fault)
>
> This is not true for:
>
> 1. pXX_protnone(), where _PAGE_PROTNONE flag also means pXX_present() is
> true, but hardware would still trigger a fault.

Sigh. I'm very well aware of this, I've commented on this issue at length
in discussions on-list and off.

But for good or pad we decided to hack in protnone this way. As far as the
kernel is concerned they _are_ present.

Yes, technically, they're not, and will result in a fault, and will result in
the whole NUMA balancing hint mechanism firing off.

But I feel like it only adds noise and confusion to get into all that here,
frankly.

> 2. pmd_present() where _PAGE_PSE also means a present PMD (see the comment
> in pmd_present()).

Right, and here we go again with another 'wise decision'. That's just intensely
gross, and one I wasn't aware of.

But again, I'm not really interested in asterixing all of these.

'As far as the kernel is concerned' these are present. We have to lie in the bed
we made AFAIC.

>
> This commit log needs to be updated.

No it doesn't. As per the above, we have literally decided to treat these as if
they were present in cases where, in fact, they're not.

Note that to be thorough here I'd have to go through every single architecture
and check every single caveat that exists in pXX_present() and pXX_none().

Because I guarantee you there will be some oddities there.

Is that a good use of my or anybody else's time?

I think we have to draw the pedantry line somewhere.

>
> > - Everything else that will cause a fault which the kernel handles
>
> This is not true because of the reasons above.

I covered this off in the above. I'm not really that interested in adding
additional noise here, sorry.

As a compromise - if I have to respin - I can add a very brief comment like

	* Note that there are exceptions such as protnone which for
	everything but the kernel fault handler ought to be treated as
	present but are in fact not. For avoidance of doubt, soft leaf
	entries treat pXX_none() and pXX_present() as the authoritative
	determinants of whether a page table entry is empty/present,
	regardless of hacked-in implementation details.

Note how _already_ saying stuff like this adds confusion and 'wtf'. THis is
what I'm trying to avoid.

But if I have to respin, can add that.


>
> How should we categorize these non-present to HW but present to SW entries,
> like protnone and under splitting PMDs? Strictly speaking, they are
> softleaf entries, but that would require more changes to the kernel code
> and pXX_present() means HW present.

No they're not strictly speaking softleaf entries at all. These page table
entries use every single bit except present/PSE. The softleaf abstraction
does not retain all of these bits, and then it becomes impossible to
determine which is 'present' in a software sense or not.

We categorise pXX_present() leaf page table entries as... being present,
even if past kernel developers decided to hack in cases which are present
as far as the HW faulting mechanism is concerned, piling yet more confusion
on everything.

We made our bed on this and have to lie in it. There are numerous places
where in page table code to all intents and purposes it looks like we're
literally testing for hw-present entries whereas in fact we are not.

So I don't think it is beneficial to do anything more on this other than
perhaps updating _this_ commit message on respin.

>
> To not make this series more complicated, I think updating commit log
> and comments to use pXX_present() instead of HW present might be
> the easiest way out. We can revisit pXX_present() vs HW present later.

No, there's nothing to revisit AFAIC.

I'm not going to go through and update every single mention of faulting to
account for that.

I think it's an unreasonable level of pedantry.

>
> OK, I will focus on code review now.

Thanks.

