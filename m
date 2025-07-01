Return-Path: <linux-fsdevel+bounces-53469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1D3AEF55A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A029A4A3BC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CB92701A3;
	Tue,  1 Jul 2025 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XzdrWEgl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ig+J+gWq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211A1DED52;
	Tue,  1 Jul 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366554; cv=fail; b=tmzaFjjnC76HngqxVftPN0Lia9GNnGAFpS28zGnuCVs7ITwZpBgvgRPvuQ9v2SwMDvAwsnzJ17nPnqh+t2mnJ4jD/RzXKBErJrhjhXs/LMy6+Qd/2afK68H/C4SQ4LTiEqkfi6SOrRNsDPKObY9Zbd1Nch+bofig62gPKkpMhSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366554; c=relaxed/simple;
	bh=xlh8XqZvE2tZGT5orwf3wrCaerOXHPbe3+v4/2rZtUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tIpgm+/UJbmmoewqa21WX6ri/k8WhOtSxfQMMk3Bj/ezt+EpHeE2tbmvimXtW688XkP2wbZUplw8mUDyX8A0V5y6bctHKie+TjKT/tKQ3UIP1ZNJ7IT5EM+KpV/Lr1qThj56G1uwWIcbZ2OROPbMWnjgS5dK83nbZjF+yDiO478=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XzdrWEgl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ig+J+gWq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611MhbK005225;
	Tue, 1 Jul 2025 10:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UYpOo/4zGEOWBInKX2
	Psgmr652jFbADI+NfnPql+vZA=; b=XzdrWEglq8e7LQze46tj7n/nSDYIniW9dW
	hy0wYiJdM2MTwhB/CaViekuU3JrSj/bzC3T8eW2Oz8pw+z/8LKIbzuWrSwAtIAjv
	dXd/+i2uWLqopPYXWG8/p82aANNvmf1FoYXUI8ljn2Oc7GwfX1N87TyAX72dbhMS
	WNLXI18uxq5GdKi8giERE41dzUDrVeGGzEuWuv/DccFwguzueURWKXL2WXIwWDE0
	6Q0X/FSgjhsVZkO0R+hH3iEhYQlDAytB3e/tokqi0ypzE6kkqPni6EcXrku6eZJs
	lT+5LELcFDCmil+mjxAhYKNaV7931Fwnp9SvWHUqcJsYk1O5w/fg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af4g6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:41:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56197doT017659;
	Tue, 1 Jul 2025 10:41:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1eb30f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:41:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtZ7HvRubhFRjwXFaGte+ByFDd5Ib562Vbswtq4LJdEy2bx1xMV5XbMLgI8ZPs8NaU19fNCHwFdqZczBCmZDe4YbfGSkAlGCqWfS/RLdXIls+njwDsHwgbzpbDdz+TVybmeiFVshOfEaqxXzX/fVfRlTqmCXLuIEBapdI27rn4oydDyOJEctkpt4jOldlkwygUZVIiTy4ufN2XAUbCock+VoYEYhvj4NrwAnwiYHzeRyL1111l6G259DsYkRn4r/+0EERKxx4j+whckeUizBd5DQXr/QeJlk1QjgD+zgjV4ZIfFMO9UgejDNprTv0nkp3LRcsgPj3ddLU/5A3xSONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYpOo/4zGEOWBInKX2Psgmr652jFbADI+NfnPql+vZA=;
 b=q3NoVECDUoagqDAvqD7YOjxcIYC3hI2mgqUiAFjFQKOVUhMoSK6IGj0fRMWsTxBd+1X8KZTfKalLLAv9YjgY919LFCdF0e2TVZuPaSAzgBBgtK+Q5mieevKjMfX2AT7rxbmvM9baNHgbODrRPJ928kHSmdGnRWZIScuur0rtwQZ6BP9BgunbAHu8qyCPlT8eQjMoNG0ONwwDHOkQidZ6XlcJbuteviv2KYtnh5GHofWjSjMK5c1FfXkYjvFlp384r1R1TItR+YDqZhLKVcTHi17UbHwOGQ58iVB5sGtcO5nDzvqR/HUxuL7PhpNFhyASGFi52cFE5no2seYn0gHrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYpOo/4zGEOWBInKX2Psgmr652jFbADI+NfnPql+vZA=;
 b=Ig+J+gWqK/GiUpO1y3VP1Gtv03mGfpBv3sTd0+zzYzEvg+qUldPgurT3LDV/GYxnrWxNYT7nGj/nf65KqsTGRd3qyZkeuceMa5rn4u8O0SpTOIS1PU1t5kaxHK82DDSGHvmTQo7dqaDgHSL8/q/zSMTPCt/21oIdggQrY3ocWuw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8373.namprd10.prod.outlook.com (2603:10b6:208:565::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 1 Jul
 2025 10:40:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 10:40:57 +0000
Date: Tue, 1 Jul 2025 11:40:53 +0100
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
Message-ID: <4d1d7aa7-15c7-4c2c-8cd7-0853dcde7940@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-14-david@redhat.com>
 <65804db3-71c0-47ff-8189-6a1587d4a0cc@lucifer.local>
 <94333692-0093-4351-a081-13e202dd2322@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94333692-0093-4351-a081-13e202dd2322@redhat.com>
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 559feccb-8ebd-412a-e2c5-08ddb88bc370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YZTtYkCuLQCErTTVioKMPUAXhVloE/RcCU8wskSrOtJlKB93YToH+ai0l1y/?=
 =?us-ascii?Q?irJKU0BsTOkqPr7Ms4zDCzP4WOfLj65o0Elt6wMPUORYivs5i+O6C4fwoC3i?=
 =?us-ascii?Q?sMeKZYnyhUbbO0DaR7WrXEYEr/XvQpXpNdU+Mz0oLxbq/epKLeEo888JBiD3?=
 =?us-ascii?Q?slNd8oh8Fg14VICmfSLrv/RJb92/qZ3AezJentJMJgpYmEaA3V/WdZamCdfn?=
 =?us-ascii?Q?1geNF4RXXFFYftxIwlfDbKr2pZhnLxpdKNe9NngPUNbtTJS1MAXCiB5QGtiS?=
 =?us-ascii?Q?HuqPwx6vjMZ1NZwtjacz43pn/Qx8xK2yO3l8lv8CwiuUwnDvA5HCIeZI7Dj9?=
 =?us-ascii?Q?dSrl/2nGAzKtBYrl9JBkZM3C3ZXpJlftnm5cCB0SBHvoo/xxUYfkYLB2KR8O?=
 =?us-ascii?Q?N0AdTwsOOSnGsmdaAhAFOqCko2e8ZwRTRH38nakZRRlvwoFiqZXw/nn7C1FS?=
 =?us-ascii?Q?i09NWNXWwCzHudkChZYnMAg3xcPS8cIgkY2vlwYZWTFcz2+cAddYxuZD0pVq?=
 =?us-ascii?Q?ejr2XWG6ApoXYQSFs4h5fr2DMItmSvegCCw9r0Oym9jsoZ4tWY0gwbHFTdmV?=
 =?us-ascii?Q?nuiLDDugQyumcNKjwoV7cGNcQMayInovq3qEGGzRhFyO7W+aHgDy3YHguT71?=
 =?us-ascii?Q?dAXqzAX6bGV/FUrloDsAmVd82OX9aAxRvfnKhsuJxkYdH2diW0kcalu0wpqY?=
 =?us-ascii?Q?/Jchc0b40DEn0yVjibScE3xA2ldM9a/6Oz+PBMccL2GiuPOQulxTatXBMS7V?=
 =?us-ascii?Q?mT+KhispxpOyQ6+SXG4Q6d6ILHmgkCi61JaF3J/sLGGwE7Nft66b66ryWbZJ?=
 =?us-ascii?Q?sk9VVjzcKGrr1L+d6qdKVV68scItgfuudBuzt3Avo5vJnmJTNn/BWsH8x1mn?=
 =?us-ascii?Q?VkXSzujWM+UsVQy/YsGnZolCyZbvn5Y+TAtaazMJEec0UzyVCmX8pn7i1DrR?=
 =?us-ascii?Q?5eMhtwY4r+keTnFZ47cd6byWOoEIhhugRciso58aELF4YLp+BCj5KWTkrP0z?=
 =?us-ascii?Q?EymYhQLd/nNeUovIrnut7FID8wGqMJnmLnS0ENM/IeXbaE1+uFXyeGLrBF32?=
 =?us-ascii?Q?sHFFv0HCRoeG7Jjme0ueL9wEcq50AWcLBq2iUCFWYD5g6nKfvyog6tkvRksB?=
 =?us-ascii?Q?Mi/aoP8mGKl0z/joQtLTp5YCFdTwDRhWYG3lejBqYCumC3kdK28IXdQCP+Td?=
 =?us-ascii?Q?ePImcVY9GF4hP6eFPWLU5vn190dLmS96wuSlG11HvZWJupdC7LqdThSL4M16?=
 =?us-ascii?Q?8zwTWPsghdkAx/pHCjdyBz/VZJ9k2eXUHASf+FHVcky7rT7r/n1qHIhzvz/K?=
 =?us-ascii?Q?Se6Xau1+sEOx0tqu3aBwR7EGU13iaoqZChPOOAfic2JWFnQisTPWNFndsfE2?=
 =?us-ascii?Q?2lO3ryp5RZb+5nCn+x+funWA0eMqkxMRgmCTlkcuTricOqvopijRbxblFYPU?=
 =?us-ascii?Q?yJOoTri/rYo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55BC8YPsRho3qNy0jPS/uK5/lJAmZ6vRC9CHPEX8pSleq8X27N+k1g7bV8MJ?=
 =?us-ascii?Q?S/+ZwNMNTu/WkawODuoa0GifTEQzcs0ihA6YZNCZyhorINcfuYj3s91taDk7?=
 =?us-ascii?Q?o7H7dDiJfcvzKcJRUUVOS3X/yd7qGaTLfrfiwwKEhrVLxX1qHazVYmy1uyvV?=
 =?us-ascii?Q?YynlAf8Noa0U5n/1Cuhy2Jb62MjOr6grG0jlttjZbbDOTbVkvbJ0dCg1e83p?=
 =?us-ascii?Q?5Vc90DpXOTGCtCQ++bmwF+ZBtkpQ6BSDFqgeJARrqBDgwt1b2CV9dfyTmtKD?=
 =?us-ascii?Q?clclBNGNEdH2Y7ZLDdQAlhqn+2yPO37QTPKD/jkjhStwNhkKPfiWwRk7BBpS?=
 =?us-ascii?Q?cdtGJdnnGhHJxWvbCjnNcRPeYEHad+JlYfPSDWdvo1eENwcW15j7nMe3Yfdp?=
 =?us-ascii?Q?G+xApHDWTuH2NC3Y6lKIFAndI3/T+ydTglogmnOOVS6/fJqRgcByuPEelhC9?=
 =?us-ascii?Q?FQyWaXBfoINuEfogWAy/3t6yB8xJE/POls6h23ODvXxd97Eflq11Yz/rIK6N?=
 =?us-ascii?Q?mfQqAocQiWxxHUVyjzAth/4eqErrcL8TH0NHZwLOjhuWhHXPiCBSAR6OUISD?=
 =?us-ascii?Q?b6OZTcTpQMRFWC0AjKw6MygaA+ouCyMJ4fqV9q3GdlRyt9DrYGYJmWxC5Dyf?=
 =?us-ascii?Q?4BIOu55b6dLh3+5DvmnluQYMoPwO+iyw6nVK4h03QjxXuTGTKP7y4wAi3k7T?=
 =?us-ascii?Q?r8aVgaHtwe3gHg4EmM/AxmJZNJcfZ85eh4BAt4Q7pGCwlRDZDhVP0dm/+dbq?=
 =?us-ascii?Q?G+dLSiE/q2SPf7mt6qs71rDOwgXja9Fkg4PFw5LslgV1TA/5AoVwXdr0CHFV?=
 =?us-ascii?Q?Z0QdxTVCH+bV1AdO5TVE+1fnuvNJZ0KA7jhRMbcvsfUbJXLpVeZsQtAMqt7h?=
 =?us-ascii?Q?SdCKi2ixuo3zoemoVY2ILbDqHDWYyCuMC1AHlKNrzo8MlUocSZ/dypVO03e0?=
 =?us-ascii?Q?+UGDRptvDqDa8D1+ddwh/3yW3A5NVBbTCnkTptw7p9GmuJU2SKEha/5kkteh?=
 =?us-ascii?Q?NKoae7gmLRpr/ypD5Wv9Q4cxePaFhzSSzzbYhJQgmTVjSqoNL09LDRD/Dlxl?=
 =?us-ascii?Q?FAPdC6ZCABeCW8Mmd0veCE/7Kh3eZhgm4foCbIC255QNlAbHFo6lHjrLoMUs?=
 =?us-ascii?Q?KQj2QUzCMM/dys4BHYXxS31zT05R9YP3gRMuEa7+dB8wpeZ6kQKDBqXpM5gY?=
 =?us-ascii?Q?2MfvbcPu3tFHT0KmrnLz/AzAx2UPRV1ENlcXqbys3gvf1HB1h2l2SQoT3HLn?=
 =?us-ascii?Q?qyxeBwylIjYS+d4K3u8Y8Es8a8VvAw+iq4A9z1Pzv+wZnN2U215NMdiWLynG?=
 =?us-ascii?Q?HvOhau/fohLPcZI4isnkKIFG63X0OdXr7zLSbjo3IfSOVMk7CnoLd6e0lRUQ?=
 =?us-ascii?Q?BywYcz24hGCiFxByphwgxoFS27S3jyozwKvi/7WvJOby53ligiaLHgNpJA70?=
 =?us-ascii?Q?sQm2f/Dy6E8pubrrwukzCe1BnnSgNQmz7egTPWkT4WDB6OYAR8KNUSsqAK+g?=
 =?us-ascii?Q?b0htqTM0SMuw8bjXIiYG3uFAwfFUgk1RHP0dJWFA1RupjrFo4s7nPI8LR6vW?=
 =?us-ascii?Q?b4+OQ8MCHBrmtaoQPnzreIq40m0rtd8PLAHg+EEqz6FMmOwRZLkiR8QdSf8M?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s9toQYz9XDwDyHbaJ6YtJfla+NQwUG9GBaU0dmWIcyAGtDt3wLS3i8Hehy8nHnytFTrxh0JTfAsQko3MFAbNFSqM8P1d0UAWIfOFe2asOHmfLF8CgGg0kvK708e4ItJhi2968bx0TaVr7zGAQqSumTQnkOC1D4xkKIzXWgwTj7swjslQgCMG1PJHvK7N+TDG76WNbuDS1LY2Cmfw4xPadeyKWv2VyTmXHdDM4DkU+9t1eeNeLke70FEPefnGSUW/RXorom4s/I6tUSoiWO8geEoJw8DuOVrcW+GYYwfoz9Hnn6lnBDQUgKOsI5J1OirV9+SA7+unH3GupzpbLnWKK71VCPoMxorUXBHWL5uE0gRczJqC8SEdaq1NZkSu1xMF2UrL19tQi9JOL1F1Dq55XiyDMUzSrljgNgi+O7fBaGlFsFQ00EBAR7SZFGqvJkTPHqPXDAFPmEtkQYt+Os4CVhKCoMRxHF/A5tjoS79iwlA1JfkeTTL7aJ5l+NKQIjvk0oYP+734GZRZ9t51oxjRPnoZCm1ggn7T5V+bLn1EoF5nE12etKml8JK6b6S9jg2684aHUoI+XiLJ9ivMx7O/Eyy0oXjTClYx5cqdqRvzvYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559feccb-8ebd-412a-e2c5-08ddb88bc370
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:40:57.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qe7T2zldRYG/9khD0BmxE6XZUMedgzwu9Pi/d8udLgVjk6mjql7sJ8C/IoZQiEldEca9D/mhhY3G72QKMrgz7PX4gL9zNd9bmMrm5Ct9UuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010064
X-Proofpoint-ORIG-GUID: xxZHXxJ9W7wMnQhwpdSEUkqPKKCG3bGk
X-Proofpoint-GUID: xxZHXxJ9W7wMnQhwpdSEUkqPKKCG3bGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2NCBTYWx0ZWRfX5+lRbUbGo/bH N9y+nOk1694kzOetfEw4igeufKHEkvFCCbwBq3aOhFmG8/qXvhaE36Cxrs0WQ6Xg9kCRxNsqawp yoQcYEfrDQBnK5W1pMznn+AcJMdC2bmVS0359gfOer+0/6a4agJkBY1xrrLdaVxqJjqkC11NxxF
 KsBwMiFTVNL1gsogwY7oVjwlOHSHyzpQg3LubD4VyPeIo4IJ9LOHo+98gjIZkO62TOJO9emxu2d oeqHvddUyXVxkvs/tK8mgengWH32qSBpR/UcVuCwxAjwAiyWBXtYmSxd2D6/txQJnKaISgORYWd v9onJ2HEJj2vloTrkXsOatzRZHWXhUi84wrsReOIuQ8QpAqKlyp1fiTSEpDVYBKlRK/dbUzevo5
 t1a/zqzNN5BaOy7mXeQI0p63/0xVldM6rQUJIqc/QWtHWFR+w514Gvwy3Ejl/BufX1naYSRi
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6863bb3e b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=wyPSOzCGDw41dE3tS0IA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13216

On Tue, Jul 01, 2025 at 12:19:47PM +0200, David Hildenbrand wrote:
> On 01.07.25 12:03, Lorenzo Stoakes wrote:
> > On Mon, Jun 30, 2025 at 02:59:54PM +0200, David Hildenbrand wrote:
> > > We can just look at the balloon device (stored in page->private), to see
> > > if the page is still part of the balloon.
> > >
> > > As isolated balloon pages cannot get released (they are taken off the
> > > balloon list while isolated), we don't have to worry about this case in
> > > the putback and migration callback. Add a WARN_ON_ONCE for now.
> > >
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > Seems reasonable, one comment below re: comment.
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > > ---
> > >   include/linux/balloon_compaction.h |  4 +---
> > >   mm/balloon_compaction.c            | 11 +++++++++++
> > >   2 files changed, 12 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> > > index bfc6e50bd004b..9bce8e9f5018c 100644
> > > --- a/include/linux/balloon_compaction.h
> > > +++ b/include/linux/balloon_compaction.h
> > > @@ -136,10 +136,8 @@ static inline gfp_t balloon_mapping_gfp_mask(void)
> > >    */
> > >   static inline void balloon_page_finalize(struct page *page)
> > >   {
> > > -	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
> > > -		__ClearPageMovable(page);
> > > +	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
> > >   		set_page_private(page, 0);
> > > -	}
> > >   	/* PageOffline is sticky until the page is freed to the buddy. */
> > >   }
> > >
> > > diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> > > index ec176bdb8a78b..e4f1a122d786b 100644
> > > --- a/mm/balloon_compaction.c
> > > +++ b/mm/balloon_compaction.c
> > > @@ -206,6 +206,9 @@ static bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
> > >   	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
> > >   	unsigned long flags;
> > >
> > > +	if (!b_dev_info)
> > > +		return false;
> > > +
> > >   	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> > >   	list_del(&page->lru);
> > >   	b_dev_info->isolated_pages++;
> > > @@ -219,6 +222,10 @@ static void balloon_page_putback(struct page *page)
> > >   	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
> > >   	unsigned long flags;
> > >
> > > +	/* Isolated balloon pages cannot get deflated. */
> > > +	if (WARN_ON_ONCE(!b_dev_info))
> > > +		return;
> > > +
> > >   	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> > >   	list_add(&page->lru, &b_dev_info->pages);
> > >   	b_dev_info->isolated_pages--;
> > > @@ -234,6 +241,10 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
> > >   	VM_BUG_ON_PAGE(!PageLocked(page), page);
> > >   	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
> > >
> > > +	/* Isolated balloon pages cannot get deflated. */
> >
> > Hm do you mean migrated?
>
> Well, they can get migrated, obviously :)

Right yeah we isolate to migrate :P

I guess I was confused by the 'get' deflated, wrongly thinking putback was doing
this (I got confused about terminology), but I see in balloon_page_dequeue() we
balloon_page_finalize() which sets page->private = NULL which is what
balloon_page_device() returns.

OK I guess this is fine... :)

An aside, unrelated tot his series: it'd be nice to use 'deflate' consistently
in this code. We do __count_vm_event(BALLOON_DEFLATE) in
balloon_page_list_dequeue() but say 'deflate' nowhere else... well before this
patch :)

>
> Deflation would be the other code path where we would remove a balloon page
> from the balloon, and invalidate page->private, suddenly seeing !b_dev_info
> here.

ACtually it's 'balloon' not b_dev_info. Kind of out of scope for this patch but
would be good to rename.

>
> But that cannot happen, as isolation takes them off the balloon list. So
> deflating the balloon cannot find them until un-isolated.

Ack.

>
> --
> Cheers,
>
> David / dhildenb
>

