Return-Path: <linux-fsdevel+bounces-53434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F1EAEF0F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633D017CA83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AA626B2A6;
	Tue,  1 Jul 2025 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FLUonhg9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bz7EAKXi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446FA1E5701;
	Tue,  1 Jul 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358183; cv=fail; b=WtcLj3w6tf5mWXE6TXVN7wn1g9uKccvqIYvbdYSHxayPONR21Wp99Mn1wL+w4tMFBvhE8grpkTBj9UoW0QajO2y5JD7L/e4nvB3ED50GAOw7UxEG9XHeCgxqKO0tFFbh9C9yOnnRr31/ejTEiFrJxKNfMQIpuFakELIWOxX3aZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358183; c=relaxed/simple;
	bh=dbzoeJOCKgtGn65IMcRfAs0IIcIiNfcA/Xf3RnO8BmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UW8ry5ITlo+P11PaSqzTaDQ24BbI8rjUvBY4vTkMkkhKMVwcZLood6JljwG8IlCBx6n2QO1XL4ovvjNGijWv7rv11/rz5tmMqbselqx16L7CXbQfB1jxrppdtT479IuO80TGR9hk+JYHkmbQ7BXKlac5xgsgbmERJxCQSDttuhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FLUonhg9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bz7EAKXi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611Mu6S012622;
	Tue, 1 Jul 2025 08:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=msUYveAMgd8FBS/RRc
	Rv3K36CiEQhRREUKTDAVkmZDQ=; b=FLUonhg9lpDgq4LlsfYQDr/fSUA5o9gv2K
	uCSkhd2I0t0fvD6TpMtR49lMgQ0/XSFW6sYTR9j8y31+wmX7uOO6GmYvAZmAQMVc
	1R08eBzAHsER/wQgIeaQHmDEy1Uv1V2oLAxXUFUn4j+a5wO8Azgd7US/kHAEuOeK
	V7MfQFgaR4KVeSykcwx/Pt+IqOqLc0SwPPQSDX4Z9Q6T7NfHj84tuxcgG9A55gH0
	sqBldmxSVBt9mzy8cEndloWAZRiAQLFste6NzRoIkD3HC9fnjZ97izN6mujEYNMV
	D+urpHeoPNBXdKpO+qxZE2Y7CZORhK6e4geRWkrNHsbpmL4PRs/A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfc6f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 08:21:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5617aSMd029824;
	Tue, 1 Jul 2025 08:21:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9e9bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 08:21:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9XM57lybjpsbZD5SUz5w5DHi+s6+5dPvtv1aRZ2lzVLNpLQQWQ7ysbgsTZCLt1f0SO/BON9nq/6Svhe9H87MN3MDt1tH6CvQmZI1ARoP1aKcZXRhtHx868J+DaQUZniHGbftPF/vKnshYPB3TH+TMlpSx0YwG90l3XGAOaVcqT0zIsyPMaZIqqyT0TBRvJb9FLGxQxxc3zGZxyLce8LrNjQ9RGRUHNRs5qF+BZCMuDjEE9QKBq6T7v5/cvscYKAquNGLd2OV9WlediOG05jc8jiVkrV9u4dXk/g4YHWmjPjvn62Li6LZsNn+6wJIdIwCki1xgglTNkV2gSGZ7CSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msUYveAMgd8FBS/RRcRv3K36CiEQhRREUKTDAVkmZDQ=;
 b=Z0bzZGlCg+adHTQYV0iW8DmRB3U02tp0iC7+bH52eAcrxNCpsUduPwxrk43h7LzRAjc69Mk/eNioVNyuwb9jC3kJwEIn3jYxeSkfwbP9daBzsQ0ptnxf/jQQBT2NavtADhF6oSfBjFBoUdXX6G0CHUKM5q3IIlOY98Tj2dfoPpAeBU1Qptf02XBzSXqOfWJ2AJLuu04RU+yaDd9MBNQhu0kkV+bvpBufwze2bLJkhyPK3anHURXNuqa65t1y4+lJoj4iNHfnW+YLK7IMMqyq1s1XS7CeF7UM1UXaY5so8v07VJhA0aG/qbUPEX8daalwmkcRU7RrtHCPqd+qz5QYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msUYveAMgd8FBS/RRcRv3K36CiEQhRREUKTDAVkmZDQ=;
 b=Bz7EAKXieTQLOHRhpxeDE6jTChjzg82NOaf1fJsz3ISYLjDM8LkNFJuvSRCmmq4VfKZn6VCY8LFvPhGcILdlct8TnNkG50mejQwUBphPyzHvt0nQ6e4NMQOe8ErFjsGYMk+UqHVQUSMVsClN5Uhasg8y7soeHtJKPp9U6s8Rub0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6492.namprd10.prod.outlook.com (2603:10b6:930:5c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 08:21:13 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 08:21:13 +0000
Date: Tue, 1 Jul 2025 17:20:54 +0900
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
Subject: Re: [PATCH v1 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Message-ID: <aGOaZipvGhb6GqjU@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-13-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-13-david@redhat.com>
X-ClientProxiedBy: SE2P216CA0166.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: c74877c2-cc9c-46a3-e121-08ddb8783de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k5ia7rY0kp4oYnc0cCVJoM/pjhqZjhnsIA1C9dOvUmoDKH9G8JX+GM9nKVWc?=
 =?us-ascii?Q?Yq42xTgD9+DewUhSOh1Nwdvzn+39a8fOPrhkZvauRoiXlZPcGeNRdtdnQ/od?=
 =?us-ascii?Q?np0iR0bH3Nc0wGmqbtZNSxD58jWk3zDa9dmYyqvZLFFcuWtaJPdzjA6erEUq?=
 =?us-ascii?Q?W/HMu4p2QlBgcbQ8QRpzfxehak3YEEI+w2dHbZECOcEjAntqi0BqmzhslOns?=
 =?us-ascii?Q?S/y7bxLqTsnoeNPAcDBwzRX5SNdnQBtJr1lfWTAVmd9uPJN7wQqtL+hjfVVA?=
 =?us-ascii?Q?vDsz1m9QR58nqBvtYe9ekR/SoSQtCBzYisUNIittlEwhM0g2qAq18JbYdQ8n?=
 =?us-ascii?Q?/DKk32zkwJ1EVHQmQ6C7rCO3Qps1bVvcH32buZNE0U+JrqeVjp/iBbbUC9fM?=
 =?us-ascii?Q?CCQRmhyYzQWlTDuZsU1eZw0hhHLDYr0fm0oKuiMdGk8WjT1iGGRJ3EESi43m?=
 =?us-ascii?Q?M851E1s1u/7G9ACQdQsaRkP/0UCt5cY1PwcWRnevYpcou+hzhcb3P4AIyBAV?=
 =?us-ascii?Q?frbiVPIas0+f7h2wr4+8u6QKPdHXgGwiNexixPHtYGYQKwCfuH4Ztozyk/kR?=
 =?us-ascii?Q?CcGLTRdBHrpMcbHqE+9P+7EPAAbG97K0euIuUD7nCdluejvoCamStht/2lqP?=
 =?us-ascii?Q?bEj52rsbwPPdXKyvTZ0GoeBW2ZuSen/7E+iU5a6CCFI3TY3S+73aSiYFqMTV?=
 =?us-ascii?Q?kxhn1kjX0mJLncIwccsWvx+CUwo7HLKmMPT4Zb2UEA6sgWDlKMXsGlF0rbfe?=
 =?us-ascii?Q?KtJIE26omkRogwYHwA/tJ5XLuPbAJP1Yi5iygltfIVOABIc91q2BPTklQO/6?=
 =?us-ascii?Q?EtsMmQHF9OWUAdWMWNzcCJpclAccU9ZSdVzTN46dIqSqEhCSG4b7lu3845GY?=
 =?us-ascii?Q?mgkl7kk9kI7rUsL2EQKkbJ/6ixIJ+fLY+Z6jfygeeDZ+ZbisrXWfJ2pfLWKH?=
 =?us-ascii?Q?MXX8iBlf0Pu0vdXU58sqrrR+wc4NUUFdsTjdHd+bKPm+yeJDZvAu5sBGZPmM?=
 =?us-ascii?Q?II68KGsdmGpU+rtbNRlVcNeuE5/jpGhmfD2huPKeKJ5p0NKrv5xLHciscaDY?=
 =?us-ascii?Q?aJ8ny12P61AnwI2me9HaCbc7fqXhqVqk9OZe+IoSTKVjw9F2v0AS7IZ+hPrF?=
 =?us-ascii?Q?zfs2xnEmmu84XgbtzLLG3o0cpTNhMEUTQMrevtILFxGSdXV5LEp7XTf7zKHY?=
 =?us-ascii?Q?ljaL6jL29vvFXWakcVtqqthV121gB2EppOZxcpnNSYuMOmIKfAJq8MgoU5tA?=
 =?us-ascii?Q?I/YebSHoKBnfQNVCEbeHA8E1yjedaej1sv8m9wFGR76fHdlF1yiH6ylVFY3S?=
 =?us-ascii?Q?7D1A0cYgPXnQOzZyYXZCv18+FbUsLQ/DVs3/gYgtvWILR8bLlgBb6nBlSCqd?=
 =?us-ascii?Q?Hrta5ousCF0UIzhYOKruBIMof0PxUj7+0tzQf9mcbd1SMo4oBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qXdPZzNqpSvOvMPM2CAQztQkPVRLbzuxJb83RdpTq0JSpdvayFmYesZNgjwh?=
 =?us-ascii?Q?oCqMSMw/KToWGfjR2cotgws71iXKtxBSP4GXEUPFRSEiMSl+70XPynVa0bA9?=
 =?us-ascii?Q?z6rvxvD9kksOy9sZexRElUyNYtN5EK8xVlSuoaEChARe/Wp4UsUxuXESGBrQ?=
 =?us-ascii?Q?QyTynxu8EISY9VsDLd1VV5JgzF61JaQc732H7AQBIcSUviYFmxTY9LdhucIh?=
 =?us-ascii?Q?is2Sw55jpPCrggOl+kdQIU1SO8q2vtkpmAuve8kWwJiHXXdGfTyutShrtePd?=
 =?us-ascii?Q?nHGYSQWOd6ZkwUGxhhkT79jzAAM8Eq9Jr2JW5J96LPB5BgzK7j2/t8SwdI28?=
 =?us-ascii?Q?0AXg4CVM1mzfGrIl5uDbdq6LbYVwKTvgYBSv/lrPUZY4G17IRNjOQ2yXl+VK?=
 =?us-ascii?Q?ulQvkPXiX7v4A9VQF+Hq0L7OgHu3xjphixfDJGflBFF06VXCS6aFS7FLmooW?=
 =?us-ascii?Q?YWFxQsZScK0CabEpjkq/OTlUp5sqNCA8dhSAdAHlKroGAsoAQZuw4FR1DzG8?=
 =?us-ascii?Q?hoRlO7eKFrX9cpVuvnSx3A0ZdOBh8p88hIlf1McJyPKFNfls4I2GwMgmsdAw?=
 =?us-ascii?Q?QoYHcslgiyyHuNMtQrUf2tY2gJM/vKXxprpRl16wtXR4Cs7AiEerX0TkExWk?=
 =?us-ascii?Q?g+oxhaXG/sFZ3VPppt4EBckkHbUowQRYMOanVViDFu1YjqnpdP8k8v9dIhFH?=
 =?us-ascii?Q?NDN3Q5ZluyBPrahnD1GPEZfj39SsvNG7rPCZ4b1DnImlFe//Fdd5S+EvnEL5?=
 =?us-ascii?Q?pnoy6OFdVo/ZrowPukrbFEKQ8OIlajaHqCxehgVI5aCQ7MYDhgkOp0eppGTv?=
 =?us-ascii?Q?VtL4ifRvRM4q3tAHeOY4/8NTKdeqVfO4MXpmLhidxbzkgv14F1WtWnewzdma?=
 =?us-ascii?Q?Xcj8yWQ7XTMJcKodi4I8dBUbaBef19xTofS2OoVjiW3NCHiw9vrdHgy6t7+I?=
 =?us-ascii?Q?o/7oueXC11aNo+ALSeYAXBVB5awdXKKeaCpeQI4jUbB7A1KMdebinluydV/t?=
 =?us-ascii?Q?fXAGcsyvLY2OQ94oruag70sjZuRmzjj0l9MBqArar5MRnwr9VJtv46/qxFRa?=
 =?us-ascii?Q?j3Q/Yd3QPwHCPurRvZpLM4w5wiFN/Lxhz+hbSpccQ21lFJ6dUAgBlw454oQS?=
 =?us-ascii?Q?byhDfWYbrv3Pq1WUKM1sXNLoMI6c3VQeZ6b8kNQ/SXl3kK4/YXLKciPUqUTk?=
 =?us-ascii?Q?VkP3/RzIx0CgmAALCu03BieBAlmPSaUR81++g3n4fhvVe56Qn+ESvCJBhAhZ?=
 =?us-ascii?Q?S6JXny/I0KntyQFkMQbuqZUzoWe2HGgyd/KOJMdXJRaGgK0gl6SuV+xIGrKZ?=
 =?us-ascii?Q?TYmMLuMG7kHn8BNy6pWicc6xOfU3BX+jFxOR7L5kjrYHXJAMUxcfUSFyLJQ/?=
 =?us-ascii?Q?OboQakuwYtZL2tIO+cdOZ7bg6snI1q4p681/aHVu0UOmJnMmtxBCvUOEuw0l?=
 =?us-ascii?Q?cnJHHdUuVR7c+43iNUp/M/dD7OyZjoBLi5LARIyxG6+g7JsBuccj256rIrKm?=
 =?us-ascii?Q?QRJ0I2l/bsw2F87Z3u8+3sagAfwDyY7uIYtwTIyVcraNgtDbgZegyEqn2c0d?=
 =?us-ascii?Q?toI7wmAddAMzvuXk62sKJ/7V6QlQwVL9+y+kUG0L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AFCwjWwxHC9qIZCxKLQ+qdH+Ao/MCF21aRpa8IhgEbOQRV8oY9kTmU71vGwuiWNiqTWoSWZnClhyW19D6QkrPx2LEke1SR9L1vpZkrrqPEBz8S0w9aZzTxZZfIoDFV6dPTHLFRa6PIbUzQmIx6cqWEVMklhtSKK96GfZFatxgbaonyeoFMX2xHDoWl/AFMk+uWaJ2wRD3qjtLTkPF+QGRhi6zy6olXJ6fOpV5X6fpqGWUoWU+hNoEgM3gSpCJD86UL5oPwaUAIo2xeJQ0gf49GcrNLx2LNM7pdCh68twyrBHUxXsBawnJZ8zHiR+1V9pBSO7E+GsC7Bk4r7i2vng8rC2Qap7kDVMhr0ikVt/lwoAlvrq0FALr+15fdMJruPQf/Rytbr7XTL6GAsnsW5dwbwKMRRSRUyKqmqg26SZcIVEUbKNhAhFWKmnG5V9GHhftfuEtV/EJwC4o6XqL8hFkBV5LP/EzV99/FcI8A5YDHlz6U3pTDoO6HSYmM/FSsLAsGwH6mqw+W4lF9qXjBQgHQmejzy8/4qBTipM/O7i6bpi73N151Lq4snEicpyK/sR37jTAORs0qOqwkHh32cd0M6sjD1AnBf+gTm44xJ6hVI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74877c2-cc9c-46a3-e121-08ddb8783de8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 08:21:13.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jxdtI1qKKa6b84daUbqwXEOYMLm63YEPK/HpD1OMue6LoPqmkNjvAa2iTfheku7lM1JFOIutqdgaJwowTH/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010047
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=68639a7d cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=fL7OHvYZNNEL-N8vEQ4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: VWapkhxLSNUqD7L91QvAf57ULFlihHkh
X-Proofpoint-ORIG-GUID: VWapkhxLSNUqD7L91QvAf57ULFlihHkh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA0OCBTYWx0ZWRfX7zB6XtHQyfhb w1hkueGJJnNlcR1f8sFgLcjpd05cKz+Vk1XP4MYwSaOARmNtrKQDA3TaVDJCDI+THmSlEoytGYO +48fpXouOC+8ZEMyBt01E39LV6qFtLcE6ynj6Q7K/jaXVGlxVo7UgXm+JkcgJxpy2HjShMMv8g+
 ClmsrdUbYn7YwiRr0H0vtA+YvDhfZ8m3i0Qzyxslsh55pKXfRVdnd95xK+civUHcvobgqM3CHFl Kb30jsSjfAs5nMfMEd0xdGWSLsmqymIpMZ9lTSew0j2Qkp6wxt1wOtK0bz7a4MHEuWh3OTYbVNB 5pxnXKxN9irmKH5tbSVOLj4dy6DWMooCFVKADz7E3ZcDBw7q6uF5p8UNnTK9M2HWBgbXzVW5Cjl
 WCTU3wqgt6P07JcpA1xPgrNapSej4DS/5I7lZRx8weyBX1dcTJYGD7/srLy4h5qNhtAQEKHU

On Mon, Jun 30, 2025 at 02:59:53PM +0200, David Hildenbrand wrote:
> Instead, let's check in the callbacks if the page was already destroyed,
> which can be checked by looking at zpdesc->zspage (see reset_zpdesc()).
> 
> If we detect that the page was destroyed:
> 
> (1) Fail isolation, just like the migration core would
> 
> (2) Fake migration success just like the migration core would
> 
> In the putback case there is nothing to do, as we don't do anything just
> like the migration core would do.
>
> In the future, we should look into not letting these pages get destroyed
> while they are isolated -- and instead delaying that to the
> putback/migration call. Add a TODO for that.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Looks correct to me.
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

