Return-Path: <linux-fsdevel+bounces-67851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B326FC4BFCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6AC420665
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CB134B42F;
	Tue, 11 Nov 2025 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hWuSkFRi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hpjfb2mX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E832957B6;
	Tue, 11 Nov 2025 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844229; cv=fail; b=pR/RWhB191a+nysqR0pH9WnVoRv5BYHawDqrau8W4uxYLQ99QGTsfqNE3DMdFC9Gs4TC8ZjFjHocwEM6HmSpn00LpZDaiQO4Cusr0VI5nEV65le4EP1o2oGIShbwHhhalurWGgl/bK7f3MgQAlERjGFP0I8EuovjDQF6A0v/29Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844229; c=relaxed/simple;
	bh=u1GLTAbxKh55KjCDb30drdbNruh+sj8M6TWhhr6dkn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k03b9ITdqNepc1Dhh2OnLVxdk782h/Nd221I/IzmLkgYLnxBHK5x+XUf2ytZ5fJnO/ZXnR0woZhg+byyeB5qfNP+CnRoSz4DO5kdNeynEPoAZp4WVNTmiPLwT62vKDFnuTBjh1yYJTVgOc56NfpV8nagzlnjmygD1eQIFwu3f9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hWuSkFRi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hpjfb2mX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5mD6k011742;
	Tue, 11 Nov 2025 06:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=u1GLTAbxKh55KjCDb30drdbNruh+sj8M6TWhhr6dkn0=; b=
	hWuSkFRiSoxw1Ig5BP98ff6iM28tuk9sFAxcftF64bHJjZQ8bE1GSZmhbxKlqrHT
	mZQPpHDSdyegHByTKDVpLmE4wNC4AsQLPiav8s5fzqdARNq0FkgKKbva0TuO8PuT
	1wjdb6Gm6JP8bXd0kiwkvO6G+XkXRk5A/0UzzRpTjvNxxBMwdo7a37zLYUXAcMQj
	9Cu0mtcGnqVp11pFus6io2pyMLBX8yfOONQM94O6yCFO1IuplIkxG5L7JhwJKDbz
	361MYDrngRBRDwqqGNGF/hHzQtB6Z+uDeQ3o+SI2u2qoBsZSitPZs2GFZ7/bOk0S
	iImpTRkivBib2e7+tPMoNg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abwn7r76m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 06:55:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB4wxBq039999;
	Tue, 11 Nov 2025 06:55:08 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va953qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 06:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+fV6A1RdXkehpp5qmjmJe5ybLKl+9Ojri8we4PdWB1xchqHZ4p0NOAh8mBuLb5viiug4ON3hxQVFyhWV/tI6n0D2Jyk34ujzjQw1kmfsIgTjpEZG3C2kRACYLYhRoFFh+z9hT3zIGXTYpBWxWtOIYI6TPteGvxJmYfbXMFWegRmu0MKT2f3ElQP21cycuzIVRThpS/B4CeQA/43ovlcSg4l4nuIbuXU8lm+Ha1JCdtVPgAuMa55d22tQVibcBQrHH6A5j7cPz41ufDhpWW3olYjF874ebDHMBA//rsr7GgmgVCw3iQZtWINnaT5IYlS8K1ZpS0UYnBACGzwn+NlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1GLTAbxKh55KjCDb30drdbNruh+sj8M6TWhhr6dkn0=;
 b=Xti9z5mVtib21B329X7Ov7CREMYCIA5/cY+lF38EOGMQMkgNg9QHDyuOX9KJZBeqiCu/5A2HlfKRlFvEq3HnClZE61fETi/7chIvfz/rmGzTdSxQ2QWqnDDwfc6ZXA//WItQIWaGeoyg/J5uAlPRR20E8eIrVcM6xLYN4plCDim3jv0WB2EPvylxflOgxPoG8Hc4Q7SIv+wZ4VCH5Wg28cbnkBXwz8tpbkJUFhefLCihX3s30g5vkQoZJ4SBh/X8C13zyxCaERr8+w2aEzv0ISKDMoKJwkTuS8O0qAfebqP9NsXyL6PWzBxC+6uMw8kzu9+QXOj720Z7KTtJMhenhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1GLTAbxKh55KjCDb30drdbNruh+sj8M6TWhhr6dkn0=;
 b=Hpjfb2mX3lcsLkA9yNuiACZIzVefzdqe534mVRBq6+oyidWtNqC2eByTzBzonFY0QkjaBaz1dYPY+PcqmllwGG8AIfTDxB37BFb3RI/dRH61UMztDA9U8F252CT2t0UXWsQ0lV8PD/1ids3pD9ONqWiVfetG/eS8yEKzDgb+2is=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH8PR10MB6528.namprd10.prod.outlook.com (2603:10b6:510:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Tue, 11 Nov
 2025 06:55:05 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:55:05 +0000
Date: Tue, 11 Nov 2025 06:55:03 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
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
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, SeongJae Park <sj@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-ID: <0982d090-692a-44e3-b960-963d46c12332@lucifer.local>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com>
 <5b60f6e8-7eab-4518-808a-b34331662da5@lucifer.local>
 <CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
 <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
 <c9e3ad0e-02ef-077c-c12c-f72057eb7817@google.com>
 <CAMgjq7BT8+Vs+7=G5PUS5wsxAhWVzDTGLX5g3mXMpTJ8PFSbxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7BT8+Vs+7=G5PUS5wsxAhWVzDTGLX5g3mXMpTJ8PFSbxA@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0481.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::6) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH8PR10MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6816f5-9bdd-441c-4745-08de20ef3e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm5EYlFLSERGNDVPdlBhcDczcy9VaWNsVG00TkNpUjBUbURIWXU4dVQ2Sm1Q?=
 =?utf-8?B?UVM2N2d0WCtZZFZpTWlQa04xdk10ZzhCclNEWFVIK0ZMMzlONnpwZ3NTL01L?=
 =?utf-8?B?QjI3TDVmVjZDU2wxUzFoQWNRaEJEbHowR2NnQ01PZW1HVzNHa1ZKMWJWOWtN?=
 =?utf-8?B?NjJuaVMwYXBNaXBlcDZXRTV4bzEwRWZPTUo3NXlZZW9tTUJ0bjBhMHc2WUtX?=
 =?utf-8?B?eXRUNjVVejFQOVFrTnhjbDZ2eGZPc2xMMXhvUzRKY0Q5NFRvSWxiNjNGUVBk?=
 =?utf-8?B?eWVnbHFFTmZWbGRxT3FhalBiM2xoaHovMStkNFIvemRPallqK3loL2ZhV0ZS?=
 =?utf-8?B?VmVuUGxUVFJFVmNMc0VzbkQzZXlXcGQxUUFCZ0xIMGhSNW9rWlM5MmxkNTFV?=
 =?utf-8?B?d2FhLzlBTTEvS0MwN0xNajdTbjJCS3hPSnJmdFByd01paWlsZ3lMdUtBajBI?=
 =?utf-8?B?R0JNZS9QUDdPMzQrWVloQnM1TEcvamxhM3BpbU9VbUtPais4TnV2MG5XZ1JJ?=
 =?utf-8?B?WW5KNzIvUElMWURUWjFrN1VodGp5Q2JqQlYva0s0NlRlR2JBSkR0SHI5Mkpz?=
 =?utf-8?B?WlBBTWxsUFJEMjg3Z0Y0SG5hNDVXRDhZN0FBWGxiT1NCRzc5ZzhvdjlkMnIy?=
 =?utf-8?B?RXhvRTVma0U4empYckV5L3hoQitYQ3R0cTQ4L3A3NkNOTmxOS3VPSldYd1Qy?=
 =?utf-8?B?aTc1djU0dy92V24wdk40SjJBb2xyUDdwMW5tR1NWOVZXTFlDaTVvMFlYQ2Ir?=
 =?utf-8?B?RXZPUEFMVkZsRmFkb0VJNkI2b3B6Q1dSY0VjN1pjUGRtSi9uQnZ6UUFBbkVh?=
 =?utf-8?B?SEdHekR3U1dtUTlIOGJSMjFlck5uQWo1MjM5TkdWNzc3UnFlNkJhbWUwVkJm?=
 =?utf-8?B?c2VnYWJyTWJ4VmxteTlQMWtXUkppY2NZdzQ5eU1kN1pxN3JXdVVTdkxSUTlT?=
 =?utf-8?B?Q3NKbnhxaWJHNjNoYWpXbGVlZzBBKzU3VVYzWDJlZHgyOHVOOWNxR2xMMUE5?=
 =?utf-8?B?czlZZW1rNDlTVTRqME1kbU5tNzg2NUdZb3pDSlRoYlNpYzhLTmZKSWE1RlVX?=
 =?utf-8?B?cnV1K1JWNXMvNHBvditUckV3NnJoY2hlbHhLSDlwbzNSNURlYkVaY1ZBY3Fv?=
 =?utf-8?B?a1VCOWpjbmNvMlFoYVBLUFRORzZ1c1dCQTNGQi9sbzUrUUJRMmVXbFUwR2g3?=
 =?utf-8?B?QlZhMTMvYXRHS3NaQld3ckFiSVdXQUhXdWhRa3ZuZUQ5bDEycWF1ZEF2L2RL?=
 =?utf-8?B?NFBsbndzcU9Dc0srcUdTRERCR3JWZ25heUxOREQ0NXMvOGJRY1dic1pQdnFm?=
 =?utf-8?B?OUV5clN2K3dvbERTbkdtNkIvNGRpNjRnS2FjZnpDWnNOaDg0YU9HUmJZVVN5?=
 =?utf-8?B?VythSEpLNXFJQUVQcFdxVmFlVDZXY251UHpWSTRLaldQRzFwVFFjVkszS24z?=
 =?utf-8?B?cjVXT0M3K2RUV2ZjZHF1SHNxczF3cG1ZYmQyMzN6SU1oMEc2QmljOWNDSmc1?=
 =?utf-8?B?Qyt4eWlvdGNVQlFMSlFLb0Y5ZDR0ZmFKSEkrT1dEa3lFd1BDdFpsbjNMbGNZ?=
 =?utf-8?B?b2hXWnVyTDQxTGRZSDlQNFA3bTcxYlZ1Q1dsU05PbUVCdHlnS2YydmRhRHU2?=
 =?utf-8?B?LzJkNko1b2dCTlgvakRqbGNlTGFuNllGZzhOWmkvOEM0QWxxZW0rVlpnNVFs?=
 =?utf-8?B?NFBPKy9oT0ZoTzhUQUI1MXBsNDFTWXdWajdiamc2Z05TQ0lkanFzQWdkSENI?=
 =?utf-8?B?RDVua1p0Y3dYSG85NnN5RFZnVUQxbGRqVlZBUTJxWlcyUnBBLzhzUzNDcU9B?=
 =?utf-8?B?RHZsR1h4WDJRYkhmN0JkVlFEcXNGbEpLY3BRdEdINnhJd21BWEt1eU1oa2RJ?=
 =?utf-8?B?SGNLZVNuRDh1UGMwZHI4bk5rcEFsQm80WXhkNTdEUFdrc09NK0dINUtZQUdH?=
 =?utf-8?Q?sUg3mYK4WzvxAoXKHMAC2wgEU56kUNi7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1p3bDlqQmI5VzcycjNMdktaQjNFTllWZ2Via1VkdEFqUHUzMnJteE92M1hH?=
 =?utf-8?B?UUF3Y093bGFXRTh6L2UwVjg5RWxhNEovNzhNRkxrcFJsZHpKbjZtRjVsYy95?=
 =?utf-8?B?R1Jvd0pqOHY4UjVNRTAveU1EZVJpUDJtU0I1MytuZU5qV090bms3NDRLb1RR?=
 =?utf-8?B?cGpsRTVoY3NlR1UrUmt0WVRpQjhCTGlGS2FKVHFudzh5em9jRjFUZWV6ZWhQ?=
 =?utf-8?B?ZllUREtER1FJLzBCVU5tOFE3MkNsQlNvbytjUVZ6WmpQMXFhaHVIWWJkbjFR?=
 =?utf-8?B?eWFLaWhnOVVTMlNUMmZxSllaWGIrMFhkbWgzUE9aVnhNMGJ5NXRMZTZxKzIr?=
 =?utf-8?B?enhZLzkrSzd5L05tcEtraHVxcGFjdUFPbk01VEc1YmgzbUw1S0tZaWlKb3Vm?=
 =?utf-8?B?RU44ckk5NGkzQisvODRNd3FXTG01amxKOXgrcUtTUmQ0TUhYK3JXS2pYbXh4?=
 =?utf-8?B?dUcrTzgyVHFnY2FhTHMrWXZsSUk2czNhbHBuWHdrK0xxby9uY3FpZ21LZktU?=
 =?utf-8?B?Qzl0S3Q0Yk9Kd0JCNGVhb2VOVmxqWDBNNFpkZm1CVGdLYXBCVTd2L0JySXJ1?=
 =?utf-8?B?MXlrRGtNYlJVZkJEL3JFbWtrSEI2N0FVY1BnVmVGTEJvVzFSeGY4TktqTno5?=
 =?utf-8?B?a3dUZ2hudHltMjlzdHRPT2U3WlI1aE9Dai9lQkJhTFNEQm5ZUks5aTF2YkxG?=
 =?utf-8?B?VUtSOXc3U2hWc2pmaWsxK3kwcUVqTC9rN3RBNnF1UTNRMmNRdTFuNWJ3VnVi?=
 =?utf-8?B?citteHl5eGpUOWRNQ1M0TlpuYk9odTF2T3l6ZmV0ZCszZnozMHJYaC9XRGxC?=
 =?utf-8?B?ZjFFNDhTT0NqL25jcmZVZTE2OG9hQzhvOE56VHZYNFdQcHQyY0I5UGhZTlB5?=
 =?utf-8?B?T0JhVllkMmtLb0IvMVJFSWxpRGVVYkp2ZURtTGF3Ymt0T3NvWC9wSDhNUGY0?=
 =?utf-8?B?OGkrdzByZXVzK2pkQlhTZHY0SnJWTkF5R2kwVmx0K1hNeWQzeUlEY2pkaWtV?=
 =?utf-8?B?UytIbHJVMlBjZnROQ0hRd21udVkyQzNWMWNxK0ZRa2RUL3d1RUx3V3dPemxH?=
 =?utf-8?B?U2xZdEdGdnBxOGJRd0ZuZHgwcVJ3eTd1M3lEaWtJZnZyRnM5NVJDT3VvOFh1?=
 =?utf-8?B?ZnZiR1ZBcTByZFBXbWNWMEYyRG1OR1J5bkpZWkxzQkRFM3pCQzVJK1FpakRX?=
 =?utf-8?B?YndJSlplQURORmpUWGIrTzUwYnM4WU9kWnR5b2pLMlRIaC9wREZzWTVROE1N?=
 =?utf-8?B?OEhuek02SjdwRitPT2xwTDdLRlYyTkcwZzRSNWErQmRlV091Vjc4cEI0NzV0?=
 =?utf-8?B?V211RzlJbzRsZWZvaXVpdU1VbnIrYlB0TlIyUFZhSjY0VTh6ejNwZm51QXUv?=
 =?utf-8?B?RG5EZno5M2lCdTcySTlOK0kyd0tZSnNGazlxaFZZd3Y5dzBzSVVtT1FSbWI0?=
 =?utf-8?B?MSthdVBOaVNqZ3p0M0dHR2wrMkovSkVZU0Y3RjV5VEVTT1dVUWdzRVgvTVBE?=
 =?utf-8?B?VUxkRE5Idk0xNTlUd1VidjJrcmJSRWVkUk0wNmsvNC9nWFE5S0crVSt0a3Fu?=
 =?utf-8?B?VllNSTJOK3lIMnFSbGZucURmcStUckN6WFRJQU52STFWMUtjc2JudER2NUoy?=
 =?utf-8?B?dUZYTG5IbmFrQ2d6b0E1SU9EZDM4bFpGaXNHZzNBSkxiLzN6a3NqMkdKQjc4?=
 =?utf-8?B?enVpUlB0ZmNseWpoVmdPWGFvSFdDL3JKTUROMVkySTFEWm1TbFZJL1ZqRnA0?=
 =?utf-8?B?dk5sNzkycGJjeVdBNHhHRjNIc1FBMUg2SVpYdlM4Q1NGQlFtVGdPRUw2SlBS?=
 =?utf-8?B?MWZDa2tsVnpOVmJhUWFJVDlGdUozSnMxMTJoOEwwWUNwVlc1ejQ3Ym5VNVda?=
 =?utf-8?B?SWdjZjJnaWdsYk1lK0pSb3dHVVVUT3BJYVcwQi9SS3F1a2xvUG1raU40amN5?=
 =?utf-8?B?ZTVuRVFpV1lyMDIwalNTSG44Tm41NjRXOENLek5kK3htNTJ2QjB0a1RNZ2xn?=
 =?utf-8?B?VGdSWVphdXFYQno0eldaMFNyTVExQ3ZrK21HNXpIc2NUUUhNYkJidmZsTVBB?=
 =?utf-8?B?ZlIvYzVPSEN6RTdlM1NBM3dFc0NReHVoQlAyY2dNS0JIMUFZOXE1Z2UxQnFw?=
 =?utf-8?B?dFlFZldzdzFJMW5XRE9kaHYzaGpxWFFZWmNRS1IzR21KVmJEOHVVUDMrQUVr?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IO1QYrPcQKp1Bd2yQ1wO4DVQAupLgAv0k/Mifaz/cixSlrW83Q3JryCBUisYHmeAcSX92vLXJH4gX79dwy0lU8M3AbsqyLm4gNL5ryTOFpQOyOrzWvgGagTBlmFCOFBnCqw+nUgTLcJ7Fm3ZRtzFlHb6PgjA/XBT3v3AP1hWhpuRKJD+r3W2X9o2nj9cb685A0icbWvWQobMR0E0VVJbERBXVi2Bw81DtHnpNQydku9VGZqgg9MgK4kBIq9dnXDrvWd8HNb/WwYSQH3Mzvg/5OT5PrnA88D3qLx90REOtp/Os97mnZW88/qtWdvaarF6SMBR7S2NILehImweJRstvnvD/1yzRC172NofTWYnTys3iv5XKbO/f98DDNZG+SiMcRLhtUiq685GEIwxF58w03kpQtEIspKUbgbmeXAr8j6fnM+aSzRulau58BK08476mDWs+0z11xpMO6x2LaorvhYlEB8TXTn03uWJzqAkieiSrcCdThkkIgzHt2Z/gceNF62ESAunmW2Udbbs2Gy2lUBqwQIJN9QdaK4m3xpgMKEuCUlH5vdrZmWXt6ZmJg1pGnnyTZbh/5kmlRlhvQZ7J6qVylk33wNBtsNusVaNYIE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6816f5-9bdd-441c-4745-08de20ef3e6d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:55:05.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yymc+eVKMVWl4ihl+uG82kid0pZ6GuSAuNCtpatY3/L/kj2Jp/eHpG1BIb8SRGcBi7RFxa5YNeoZd9EGVPYcozXR63lXmUNOhJE3DG8zkTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110052
X-Proofpoint-ORIG-GUID: VelTA5OBuCz8RnS2TXoKTFVi6ZuliF2E
X-Proofpoint-GUID: VelTA5OBuCz8RnS2TXoKTFVi6ZuliF2E
X-Authority-Analysis: v=2.4 cv=YIGSCBGx c=1 sm=1 tr=0 ts=6912ddcd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=VsbJs1mHcVtRR8QvdcQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDAyNiBTYWx0ZWRfX7qwn0L77qpuJ
 l6IT8Lmxr0Azi51Gw0LFX+xVGx/ja9PP/QmD9WhexWzewErlM7vmZUFuOjnLpgI3joXM0X3/CnV
 mY/B3IKFMj/3m8lKMHzn/XFulahag1i5qmcqne1YdLAa115xXaX2OHpzHhb8hPVckOgJ11Hd5EA
 7uEvCXUtKMd5PrrNo4RuYEiQouvPi89fZoPuNPZq93K42pxd/kIy4A7nw6ml8I7h0qMg9sA+4LS
 u9dTpR16V7V4aNf/mrUjGA/kdy0uYV1fUedUsHX13z1w3YEtHfb31sRdhbRGqSS4P8Suv00rjib
 UejwEO9OOQEh91OJzquSuylOlHpWD27rCblATeqS+QaMS4MFdmz64RFzxwGo7vQm5zcqRsMgQCQ
 lFdpcnutHDxCIz3g/xmOnsGK1wVeow==

On Tue, Nov 11, 2025 at 12:16:51PM +0800, Kairui Song wrote:
> On Tue, Nov 11, 2025 at 8:09 AM Hugh Dickins <hughd@google.com> wrote:
> > On Mon, 10 Nov 2025, Lorenzo Stoakes wrote:
> > > On Mon, Nov 10, 2025 at 03:04:48AM -0800, Chris Li wrote:
> > > >
> > > > That is actually the reason to give the swap table change more
> > > > priority. Just saying.
> > >
> > > I'm sorry but this is not a reasonable request. I am being as empathetic and
> > > kind as I can be here, but this series is proceeding without arbitrary delay.
> > >
> > > I will do everything I can to accommodate any concerns or issues you may have
> > > here _within reason_ :)
> >
> > But Lorenzo, have you even tested your series properly yet, with
> > swapping and folio migration and huge pages and tmpfs under load?
> > Please do.
> >
> > I haven't had time to bisect yet, maybe there's nothing more needed
> > than a one-liner fix somewhere; but from my experience it is not yet
> > ready for inclusion in mm and next - it stops testing other folks' work.
> >
> > I haven't tried today's v3, but from the cover letter of differences,
> > it didn't look like much of importance is fixed since v2: which
> > (after a profusion of "Bad swap offet entry 3ffffffffffff" messages,
>
> I also noticed the 0x3fff... issue in V2:
> https://lore.kernel.org/all/CAMgjq7AP383YfU3L5ZxJ9U3x-vRPnEkEUtmnPdXD29HiNC8OrA@mail.gmail.com/
>
> The issue is caused by removing the pte_none check, that could result
> in issues like this, so that check has to stay I think, at least for
> the swap part.
>
> It seems V3 has fixed it, I can have a try later.

It does fix it, it was not only the pte_none() thing, also the swap logic has a
totally insane 'let's pretend a PTE none entry is a swap entry' function. Ahem.

I think somewhat forgiveable to miss that :)

>
> I also hope we can keep the swap entry part untouched, Overloading
> swap entry for things like migration looks odd indeed, but setting and
> getting a PTE as swap entry seems clean and easy to understand.

Not completely untouched, as swap logic interacts inevitably with soft leaves -
you might have a softleaf in the page table entry.

But I do intend to keep swp_entry_t for actual swap stuff as discussed with
Chris.

> Existing usage of swap entries is quite logically consistent and
> stable, we might need to do some cleanup for swap but having a
> standalone type and define is very helpful.

I'm not sure how incredibly consistent or beautiful it is looking at the swap
code :) but I don't desire to churn for the sake of it and have no intent other
than doing the minimum there.

Thanks, Lorenzo

