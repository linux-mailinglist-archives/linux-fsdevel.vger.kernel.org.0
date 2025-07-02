Return-Path: <linux-fsdevel+bounces-53622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320B9AF11BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7290C3BF01A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB7E253938;
	Wed,  2 Jul 2025 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o0bRHuAW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oJ6KMBx6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D0225776;
	Wed,  2 Jul 2025 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451776; cv=fail; b=YwZtQ1aWWUf/rUHCM21IcfdGvyE+IZxKkIkNTwI3JTHvifUvhH+crXCagC+ioSV+nkCz6iwlWKJdc0wUBTVyHg43tIBFftppDb38Om1bMYJZ/u7IHvMAGLp66cgrI0sA+pI3G+bHYtgHmISwoFFiTHlKs3Ukyw8hl7oYPDBhvsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451776; c=relaxed/simple;
	bh=CixyK5JCVZOt3qs9Aoj6KUvCZT938QW+VI7EPFNtR9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=reqI65X0ve/qODJRWR9dDfj8BPj0dSyu6IpPShrjKZCzQ648OV6CRFvCv+yJrQpeNhR2V1QoJZ1qOJi2F/7DNKGIRZFrUANPePKS8wxdkj9642t6UqWqxlAF0oLnXzh8WJtfZ7eZwRZCT8zPBYTmzdeWYf6uz3Y9TJzLk41tlfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o0bRHuAW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oJ6KMBx6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627Majo026819;
	Wed, 2 Jul 2025 10:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wNNrLIEBbKBJHDU5Ry
	ea1Ip0GL/BcOtItqxYelkgc6s=; b=o0bRHuAWUSwUkxbFw4yLTcl1B2pOu9oPP9
	dDwM8vBb96LibnEiSl9ndHpDFQHz0MtECqDH86+jIGSgF2R2yLV6ht9e2+qWdqCE
	zbe3VqbeQnjnN1yd6AzR2Wch84mh3nEncSLmDbB6CutOtgh7iahCrcX3Vh6nelZB
	euoS8Mkbd+Ik4zBls92xwbtEIbTet15IK+rZo+15wrWFy91xAjeQkeF6Wb06YlAD
	X5PSu7PcukNyxY/K64DrgApxvUuSQbrw8gUntn/acw8qiMeA6/9glX8bjhG07D9R
	pIPxvbC8uJW16ZBgKCy2RRLXSnRFxWfG5ZnVxIFb5QJ1kKJD90uw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfekkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 10:21:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5628XStW019579;
	Wed, 2 Jul 2025 10:21:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uasag7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 10:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt+xWqebBcwzHmSrELALTT7Toq0/PN75g4z+xmwLUOp1N3c2myERnJcH5u0W+xSpby+bQqoOq2fiawo0XVrgfIB8Lc/L7Y1tcnuoKxZTJBsv0GpFpDOZBqXTcy1pDOl05CUd8RP8al4XSQ45gifoGX6N20gNEPZtLPvqHczwIBGTVCPh/A2Qj6VFqPfaoUiT3K9bE/1UFTTVJT0TCMRDLfWmt+s6jRe96bPzLS9NzCTDPSw+0+j//v7BImkTALRsGzQXpAcU2suj8MdTdUXf5ygjOPtcs/1Oen7a3NxsMGSR0EHPEXCs1YX/x5Dllf89hAguoh2wvxn1zdA9bceUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNNrLIEBbKBJHDU5Ryea1Ip0GL/BcOtItqxYelkgc6s=;
 b=s8+a3VkRdpCQT9chenagJ/vz+HOUSjxV3doqNISIFHGIpdC73Obhu2O3yiItKpfsaaH8OkBoaTNalBzc/LZsubbddz2AkDPtFyPdvPQRO/mxeBnlyPOqbY7I9tMKc19gbHvKikP6ekYkenDPF58wOXE031Q9wJ28u+pyJy9AKHRrqVZC/WN6ufoRa/DJyLbKN8H234hxRsTDpMBbPwjBNvqpbsOaQ1oJ1Yx0AyAdemXDAslhm98ZIArX5JDLIrb98e5RzdFVsFfTdATCordh4CWxEQIEL0WD+H5bdTEsK9bjdDFdLflM3LcaldbEerSfy0CA77yjOMFAmXzau1abHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNNrLIEBbKBJHDU5Ryea1Ip0GL/BcOtItqxYelkgc6s=;
 b=oJ6KMBx6b5bUM6oQliQeS65jLCN4eMi/2XEQFCscTtbADN3FLaM3khEjreux8KWAUSealI2H0fAuPK9ahujFp+tnJ/3Ik+iUBr0fHtISRzM6+NrermsEOShsriivxPryyC0dLr7xctkBADWz89mPiRyfeOmxQ9Z1nQVjT1lEfbA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB6265.namprd10.prod.outlook.com (2603:10b6:208:3a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 10:21:13 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 10:21:07 +0000
Date: Wed, 2 Jul 2025 19:20:48 +0900
From: Harry Yoo <harry.yoo@oracle.com>
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
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Subject: Re: [PATCH v1 18/29] mm: remove __folio_test_movable()
Message-ID: <aGUIACa5JyuBKrAA@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-19-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-19-david@redhat.com>
X-ClientProxiedBy: SEWP216CA0064.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9429d8-020a-4a77-65d0-08ddb952284a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tVLpWmaREtm+2wC14w0PeEz0g03MfTGENtYlReMIspSgBywGFwMvnzk0FZM6?=
 =?us-ascii?Q?1Sqxjd9WnhBqtPlWTmgvruo4UsHcrANaiUoWrpjyqxjAVWRHKWKY7HiNTKqM?=
 =?us-ascii?Q?8gIzgghXZ+K3prHl813QmOhRBrJeoDrgUa6DGbKxmrgr6XAKP5KrX+crwsLy?=
 =?us-ascii?Q?eOPLakdu16H2AjykWlW833Nv82fSyR7hSxnSsUI0I4145JEWJa0vO+5QBaTs?=
 =?us-ascii?Q?gf4IKz1Hxjogz76qnojcPPHZ6cUbsJxUygxczu+6956Sl3jS1wtNtUBML7qZ?=
 =?us-ascii?Q?Iy8h29hoFAVY7cPMsGBBHQv9JvoWr9zknyXA4cq8Yujv0fLpAozMV31p1YeW?=
 =?us-ascii?Q?2Fvo0YfyOIYuQAmBuraA3a4ZrA39U5+dvDBslcmq9vJImEOoZYtr25UjSbC5?=
 =?us-ascii?Q?iNwIlRggYGXpGmSqqxsfKpflRPyrMuJm4yaHQqe++lmB+jBwf6kVznhebRXg?=
 =?us-ascii?Q?phoLRYWWBoDI5LsIj7Or6ZDlHBmdfGkq0kUEwjsdisHNwOZuMICUBFcg8s8f?=
 =?us-ascii?Q?gTLAmbx7SBiZy9Asu6P9b+tnTiKrrw6WmqaxpU98re1GbFGYspmJTQ4YN095?=
 =?us-ascii?Q?KGkrqLnxm1PDLHepfeZIw+bd0AawXD972SHFWA+WifrPIe2QR8AINhg0hObl?=
 =?us-ascii?Q?OAYl0QfjvBlNGbCOFP7CcpES6cj/liy1sz6yvA5dFklF2mBWj4bjyAcqsxDH?=
 =?us-ascii?Q?49z6iAY1klVvsBKFsB7AiKEDSqravcZgzSq+HHl0iPqC/wVXgJ4ETg9cQ0IG?=
 =?us-ascii?Q?dlvDHnf57Y7Boa1ICd1aQl3IEV+LV6U/xbPdr3HAQlQNjwWLI0yzBQU6giNV?=
 =?us-ascii?Q?BfdkGlk7AAu2qDKW/urSvlrWAxU8an26fszQFQeYLd0BTIfOzsPKgMhmEgxV?=
 =?us-ascii?Q?1d+eseRcwYoPtyiALkqemJkydtTY13sV+DaZXz6w3lbtj3KJnkT9Xtv2H+1x?=
 =?us-ascii?Q?2DSdginIrZAuzI/2iXrT03me4LA1kht7L3tB4KKYPewtSbT5tJtlQkuq5y0x?=
 =?us-ascii?Q?cBTj/hpAYxiy0cVeDWlyh0Zi2ei3FjBosOFN5ZIagsprLItIYHBli6LtNm2p?=
 =?us-ascii?Q?jpKWh8Zqi9CW9YQdpFKg6vN72cg2KXBmRhfvZfRUrM0/whVPgVKoDo8hFPFy?=
 =?us-ascii?Q?Mg/AIr3Rt+HZHQDbMN16q6RhSs8W+yDAJUyZ7jqe487yKAz2fnfXUswlMp1p?=
 =?us-ascii?Q?gDKFsSYrRoIDVlSGPRO1Q4ee1jhPWrJtj82Rz+Ph/Vfp9DaJRVs142KeG6rY?=
 =?us-ascii?Q?JxqM01LdKrJ6V2s7gOqv3/cNy2H/DOv5Dkr4nl6aHNlNhG2xKjN/X4p8o6q8?=
 =?us-ascii?Q?VGeJoNVX7kklZSKcrqRb050dYkV+GCWjQ94DduxFENNKkJcgdG/Lh9urbjJW?=
 =?us-ascii?Q?lXWnv4G0xfMDn7cT2/XFEFdr8B9L4kq937r49zQ4gtnO/ZzV1Rt5pOALGlCy?=
 =?us-ascii?Q?YPtFSTmGxyE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dwT6QWCPKYJgWDTNZIHyLlScVvtE4EZ6lxo1L1ji4ldiuKSyM641uTllD9NJ?=
 =?us-ascii?Q?V2thhPFu16mnkPMdgIYYpz2XyFC/vRXT6W+PThg4qmkGlQNQeStqluG3qUMx?=
 =?us-ascii?Q?Qm3y0I1tvjX/+45Sc3VFwG04H3/npAeFwjlHrqDFaESZtT3RTBIbdjzk42Lo?=
 =?us-ascii?Q?eElJ2f+GtDVmb27nxVL5u1z2YjmGYj1AQf65iFniy+9B0/mfdqT8pEJ7Dkrh?=
 =?us-ascii?Q?EEHyvyJNibS9sNIHGy9w86RpN2JPFg7eJRZmrnLMKYCgFk5hstbCPS0OoyAj?=
 =?us-ascii?Q?1DH6kymSa2twl7kIVK4WZkt1homj+DygQCU7z4J/XOFFMrCj1/B+iOiBAz9M?=
 =?us-ascii?Q?4MbMlogWBR4liQop1guZeuTeSten2zFXj5ZwgPB/2MIyl8lDMh0e5SZva5ne?=
 =?us-ascii?Q?P8IzLGHkC5kP3BXpXfSNBEZJf4xKc910BYokLNWwi1Yeja+Mb63vCQfmBdz8?=
 =?us-ascii?Q?Kl06I76cvEBzKUWRUJbkbyJB6YZ/47m3qlPwy1ewlWEbwDvYIZQIOds++cKu?=
 =?us-ascii?Q?rmS8IP/VN5O8OfSNLSO3XFS2elezh6F5o8AHKLoNfBk2hGsTvDXpFDkWPO89?=
 =?us-ascii?Q?+5z5XfhDC7tGJVOV5/bvFfGmzpYVZyMkk9CP0ILLRW55iYQKRrr5vRrSvLZ9?=
 =?us-ascii?Q?0s6jvu4HtSBofcxpLpgmdUl5xSAuCvM+efPSkrnV4gj108mvxSvGozAA+U/S?=
 =?us-ascii?Q?48Fb/Jjz9G3CUjWUD4+BCAJqGhMeDzEp6im/MnyaNNU4ZKzUSQxet4jGKT+j?=
 =?us-ascii?Q?oQ/vulKGR2EzQY+8t9xHaN3quu6CEYzp+c2gELDIA6qeGaLuy3wsL5O+9dKU?=
 =?us-ascii?Q?itOhNknacLFEOY5340OxpTUbQnF2tJ8mYYjmNyhgP/uRqZu4aIzUt0FVJJfq?=
 =?us-ascii?Q?B15MUalb6z6lP/NbMyHr54LeHxCXLhGMiQ/M1ZJPjTptwDqfa0eSdr3ZfPev?=
 =?us-ascii?Q?ycIZwZm7eGIACynSCvHpuymE9EbCHb6JeOFdq96jEr85lCBaPrVV2YQRf3Uc?=
 =?us-ascii?Q?ybmBxc+gqloNdzxoEa0H3XysuabQ+1+GgCMc4FDTC2axRnjdWGk9ztTBL6VD?=
 =?us-ascii?Q?N6i4WZkt4RgCNUhjt+5BNOy3ByyA7zuq7N+guV41XRBDnjPQHuiVWiyrzQ6O?=
 =?us-ascii?Q?9Ui3ZZfS6J9gZOlrtbycDDzntqBYeE86fijlQlsO/Oc1lgw6YWbQUpcYpUiw?=
 =?us-ascii?Q?fUonykikg3C1Rrm0uUeWzSPFCHnUA+zwOorYtOwOLv+QTAlTN+4bCU4CgoSO?=
 =?us-ascii?Q?qzhIH4VRJ7RQlfzvIjqWuwvN5DEcC0pQSapk1ofUWUZ0W6AOUhdFn7kZMSCp?=
 =?us-ascii?Q?Svhq1quny2MAI/2t91GJGyQpE2+K4a72T3vl6fMNAbCCviPnGFhZ7Ak7D/fq?=
 =?us-ascii?Q?dEAylgW51OWvIYyzOSo2FcBk7xz+Jkp3iHGkZim0Ts6+cddJHG/kxUOpmqxO?=
 =?us-ascii?Q?Qxbh+WeoCWvA3GHi/fzzzOPv24p1tMmcl9jQ4WH4k6ZUYZn2xcTnkW1L6Id+?=
 =?us-ascii?Q?zFMQFl3ewsfw2+zb5++uhJOL+gWCuDNHWtsrME+hJTzJn3gZunlu883+dsoV?=
 =?us-ascii?Q?4mBnhZ8qguZBQA6YVCkHGQsSQ9ZFkkCfRRvbGOoq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eQYMl5mRPtKeS7WwJztn9pSktWgljR+xJK4pneYlzS8taiZjwyD4j+LVs3Y95qpwYUwusvulqc4+8hkyoQQAj3ax01QDzxSWk3mD/R5saRCN485qqaUVIYPsHXJZRlDdzvra592VIDxlPDSU0TKobTtgIlxMLALoT6U93SBHuqEt6QwReT2y+vULz7fWj7RGLMNfNolJlDvDMPt/T/63+MwdrUvNUPdKZMaWf6UAMoI9KfGblqQcw38piqRjglyZxwOG526hMNoOGbVR069Ff/DF89NUbV+lzC8JeR91+P/2YRmvl27mAow9jPyhkui2/qWf6x9zjZezA9IZFIvaF3PIgKjTIa2Ov4d8j4F7L5+Yz3MAJoCxhR2a4KZz3XGZ1/JDbwjbsfav0H7jFVzXhp6fyi9R3GQBCgQnFKPiZeYIdpC3X0ywW13wJ8nH9vYpdQff1N6cIi8NuQLt6KERj8EBBaRYAQKSfOfHUtKxFPVgPP/nd8/1iXFg6GSfV44pk7Vd9dBka0e5qbOIzaVInw2TC4KarHwDGNv5DgIasyUmfFWbtvuJjwpuSYvv+D3Ltc8e2DQrL7k3jTOuOqCPMNRjWRkccs7tOULdP/9eLqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9429d8-020a-4a77-65d0-08ddb952284a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:21:07.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyu7jOhwlJuYk6No3+GNjfEBFGs2DuQPjrc80iiKi3rOXZNWx+vlMcqLrKbOMiI2MXOQ2L6S0s6vs+R4Gq00TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6265
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020084
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=68650820 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=7-PkP8X-7sgTA8Hho6sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: k3K8WZq9CQUXN6QilE1MYLy0GdvnnCmc
X-Proofpoint-ORIG-GUID: k3K8WZq9CQUXN6QilE1MYLy0GdvnnCmc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA4NCBTYWx0ZWRfX4YHBEXBn12R2 gyxRu0Zl0Q4TZB9hEJC8bM8OyWkfiNrawUKv00PepFyOsx/8rrG5rFQxTWaaZNAQwnd5nQ7/zMb 0My81bECURKcHVJjv9w64XHBRtiMmsT+5j2kVLNqBCGQ4D07QTZKNV3wZ3jMcz1q2vwSf+Yk26S
 lXuJOdif7833i3e/nTs/Z7VFhsHPbcoGG7TTTVKzkVSvkLCt7uljTUpmX7LKNTO2d8SbuF9sr4U 0dYnZ9xeDd9MZoItiyM7twvpHb8zBNO1JsnSOvWSfj16fu1ax4psWkL8C3uyOqz598g17B7dpPy 295wN+ofzt/bU7Nt8tfGdxhXRdlb4l7StfWu+sm6lz+hP7r4OqbcB2wCQbWuti+vDsxMAlu/elE
 RuBeHqv8kAi8LNz8+OsU1KUSReYyMXfDhe6/TzryrUZgH7hl03gK8VxQTwZktm9m3KssWd3K

On Mon, Jun 30, 2025 at 02:59:59PM +0200, David Hildenbrand wrote:
> Convert to page_has_movable_ops(). While at it, cleanup relevant code
> a bit.
> 
> The data_race() in migrate_folio_unmap() is questionable: we already
> hold a page reference, and concurrent modifications can no longer
> happen (iow: __ClearPageMovable() no longer exists). Drop it for now,
> we'll rework page_has_movable_ops() soon either way to no longer
> rely on page->mapping.
> 
> Wherever we cast from folio to page now is a clear sign that this
> code has to be decoupled.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

LGTM

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 098bcc821fc74..103dfc729a823 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1658,9 +1658,11 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  	unsigned int noreclaim_flag;
>  
>  	list_for_each_entry_safe(folio, next, folio_list, lru) {
> +		/* TODO: these pages should not even appear in this list. */
> +		if (page_has_movable_ops(&folio->page))
> +			continue;

Looking forward to see how this TODO will be addressed :)

-- 
Cheers,
Harry / Hyeonggon

