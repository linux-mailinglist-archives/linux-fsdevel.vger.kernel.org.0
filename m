Return-Path: <linux-fsdevel+bounces-55296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC85B09570
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 22:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152F53BC658
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 20:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56072248A8;
	Thu, 17 Jul 2025 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oM3XU5co";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TCixtGIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F421DE4E1;
	Thu, 17 Jul 2025 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782869; cv=fail; b=PWsnjQfyHOBZWpMpXpLdD8WsItrUusIfhwfIsJF2dqWQENcjSOjb0haHrEXLw7K0ChwX9OuSAj5xj7sMfSAyoqx4OkgqS+Lc0mR7rOA1xgiDSMvnT23M4DzdFYoaRMK8SrZKfe1MXez17roygjMeEsRJXaiDBqPCCtimywB8sHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782869; c=relaxed/simple;
	bh=fqjVvzI0w/W2d5wP49/I2w3iBwhOgTKQ64YKwtcE5uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RPmUDgrzGBhDe8VzTr3bl2bQcDgKJEqwVp8hMBwWdyEfTJH53PbiE9G15G6iLWe5k39DvY8gbufzXwAtD/n+WGSmU1z5rU+LCteB65s+GAnYCe5FkqgE66e8Zh1RrVJAd61UjVYMhBKpRFhCvJxyhXG+2Up2BkBB7SPSl0RVnr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oM3XU5co; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TCixtGIl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJXmmX014615;
	Thu, 17 Jul 2025 20:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UZtrUL5iItC6ra0O2C
	JAEdwcdn3RWad/n/yY2dKpStk=; b=oM3XU5coHFb1ymM1reSBdm36ireMZPL9s/
	AWfntBn4LWLqpu4xNaVgVit5Cr7ny0JHTiZFkTe+hGGtivDOCfXeH7DnennaCfAl
	Zac60p+wAxMcvarS1Tu3i2moYydOX2ESRBHLVKk3fPoSTLck814PKZ1sgPImaKGE
	EmMJ/Tfptybqg32F3FQPj/9VFJOjpvRCyx9cyKE+Kw1XaRaflG0UBRZlExipKED0
	KPWvsp2wNkmCWio3AhZEK7iUK8fXe7syeOoHCyOcc1lJDD+r+sRrZ20zL6N0tbTc
	5VU1s0xD/o5j3QVY2lm/mg22PYINhevaDdAy0vq0nS9TGLuBl5NQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfcfdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 20:07:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HIdUmn024636;
	Thu, 17 Jul 2025 20:07:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5d5tdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 20:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPmWh8O/QwrfozmawuoadnWruiSHOFVAzWl8UhGtjY4gXp5AZzXiGKVfRWwrWfRHP+PoaHzqG1OHdGT82x5yeuUFdWUo2s9Yb0rUUKFTkvxTRrRCTUg3CpMF8MfdHGnu8M0yOyxDebRcVSw+BxhPUZPJGEEPFcOnnCsbwhguF9deLynBAlxLejKgyA75HOdQ0t9ttweYgxD/Y4cXQwe8Y+SDrPxWnBdQG05+gjkhuffFwGXwn6N7LFVHnl2sFX+i7yEYrcI6LsBeHNYz0xqBhpBi5j5iguSBc7opZXn7uuVhSIG0RXGmgoVzHHNcm9G1CgrC04uaVjR9FqzjYgMKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZtrUL5iItC6ra0O2CJAEdwcdn3RWad/n/yY2dKpStk=;
 b=fb318Qfq0Opoy95IYJ88XwDgXZzlrAku+7DVOiPMnZ955PAAAFmMuFEkP/8JA0JLI4jUlY282knMluoETmmPPmInlWr5VE5mmMuwA/RT2+HsHSmkKTj7ljIMjwok2FrMCdtj5po58e3vpRdxHIW7r4rOb+dW4i+uSSYuJn/cU5huSHOlTQ01Nx55yTLdtY1pC5cgTwd2WGCaptSemwqUoPD+B7V4WfDaDPL/sAKGw/GIYyULgVz2m5iTGobS+oPfkQnaB8P5TQnQgBS2LIjfHKy7As5DSHgsYZwsApiVvedDebZPpog+3iKVMPmQBaj9uVhk+H1PBqeMK9A7s8oPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZtrUL5iItC6ra0O2CJAEdwcdn3RWad/n/yY2dKpStk=;
 b=TCixtGIlsap+PLUeNVOQMHZfSP6A1RWZHskAOc8J511sZJbsSCosiOvS/ky7GU7jv+4v3jiZ2mJ05Vb+APdpD9mJJdFS3OfRrRTGezfJdR6FcaKC6++MQRLBKdm1hHULflhw2ChSXxEb0HtDIKvztnrrXD4wrnGu+AAIyBKLlIc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4406.namprd10.prod.outlook.com (2603:10b6:510:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Thu, 17 Jul
 2025 20:07:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 20:07:03 +0000
Date: Thu, 17 Jul 2025 21:07:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>,
        David Vrabel <david.vrabel@citrix.com>
Subject: Re: [PATCH v2 9/9] mm: rename vm_ops->find_special_page() to
 vm_ops->find_normal_page()
Message-ID: <4f7bf35f-ed83-4db0-8b93-5333eca7c6a5@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-10-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-10-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0440.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 54349686-1320-4a7e-ff9e-08ddc56d7f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TeB9PSCqX4Y0DwjcV6jCr53iZ/y1G8bHmf+r0nR8eVPoJGUxXvpFvfMuhqgA?=
 =?us-ascii?Q?rp7Qk60NBcvQUtL4zUif3KuC0np+Ga3zaXvmpOAbzWgKR95xIAnyDDyIHbUV?=
 =?us-ascii?Q?wWoer84loXo9TJUNLRlC1Wln86ckHjvxahE5Mykm3chTbI05hNRPdjVviEFN?=
 =?us-ascii?Q?sTjHx3rUFK/8fNnzu6fmpKO537DjYPjqClRJpshd1aU2Nm0RxZua4hDMcEi8?=
 =?us-ascii?Q?ct0vC13Vu3K1BaG5NuGlrXQnt1A1E3gaHupxIYXUGjNfvjt0uPNTvFqB70NP?=
 =?us-ascii?Q?JZYvi+JMOJCY7rAfOTut5EHDDEDxILMMgDX0c8c+BCYvPcod3Cay+hnH+EhE?=
 =?us-ascii?Q?EAMJnZQVqHBy1adnNKRGFVzVEfQ4MyRAYUDV+ftGDTxuEAkCnkzeOn/NoWga?=
 =?us-ascii?Q?pq/K8tO6o8eMrkuTQOt2Bil+uReuruzEIQp5Gc5pIut+27QDDMIbtveBiURN?=
 =?us-ascii?Q?oYQnTVHEhBwK5y5pmKWmpU65eW8fUElMEXeqymB9vpifChUPQoRbY4WKEdlL?=
 =?us-ascii?Q?fsLusWTZzeunj4dGmSu4v2oSnN6YeLj6vlGHvUuG4GDqUcT/uzSihjV+W5gs?=
 =?us-ascii?Q?XAQXFnXjStaF+jNRE+nR+M/zuImfydUpjx3SgnXVFB65gJ5FYc3rbQgnctiN?=
 =?us-ascii?Q?paDuqtrvIMtD6jrf51YDmkXEoDGQ/BVV2qdYE3se1R/Au/BN3e7Cq3yz8jhK?=
 =?us-ascii?Q?fzBaosmJY8L1bwNf/7jslheB5+O49UkiuFB+jMj/HAkbHDUxT+6JCoZKG7+D?=
 =?us-ascii?Q?xnyNfOemOMoKDGtCBbZL9uNKHozmOMZV8kciGgdJ9/MPXruaQLRKb9eIyWwb?=
 =?us-ascii?Q?qVqDFUSXnUFSh1k0afK0panEvfaQDOJJ2G+nvIKnwqt3qGU5RGOcTdgz5CDf?=
 =?us-ascii?Q?P4aKwbsSoRDbxVt5KotjQgPyaZYLbj5sg+e0RDdZxJRS7fB3IXd/zNVj4iSK?=
 =?us-ascii?Q?fBz/75meT9LKzq3Uf/9XYouyNEwuDTi6NjPOpfLpQ3kwMt7TBqGBHjIVDHcH?=
 =?us-ascii?Q?9KjddS+HHBrz2kHOhNrc2wc5dOFbtC0C6I/AOtA/mqa27tkPKAE1jR2BxcyN?=
 =?us-ascii?Q?XKMwrH/Z1pj3vfpEF2YF0oR2P/ZGC0/GHAt7QbsiwtbZswmG8ZIIOf3ZXSvI?=
 =?us-ascii?Q?2CRntNUBA9+zNjMaT+fouWF/qAo7h/pVdmCCyNH/7c/9ddt3emZmp25LEg11?=
 =?us-ascii?Q?K0InlV3zSkoliUok4wTLs80BKY6Kb0SWNWDAeYtWBjK/baN8iujwy00q8b42?=
 =?us-ascii?Q?J3ezcLBzIUorYzuduQP487aDpcrNzFidm2JM/G81+z1sVSq/g3WLtbRvaaEO?=
 =?us-ascii?Q?G6xtRc/q7NBl/VYaAtIVRcqpNSpI6zC3MfGhjaIvZJKfb44en22dcHsBZ7Id?=
 =?us-ascii?Q?JELKYw65j8rkJiy4jcpEPEhnVKGLeUyd9R4vCuoCyXlPZDuPOY4rAAy5tkEa?=
 =?us-ascii?Q?q0EnqNoW2Zk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m+X6acEzaxLuBKHYh3DUo3kfdQ7AsLVqe/D61HQEkB36AMSc5Y02j6iWot2q?=
 =?us-ascii?Q?1bEU5PCerZ9klJkwIsWUc0vMs+aojlBAgF3/tLCxUX/CYM6e+/xOisjKzR0Z?=
 =?us-ascii?Q?lx6uVg8qV+IVHmACF0aPflUkDTwgBloiZgxD6ET005fmCb+1Y7PCXk0rDX82?=
 =?us-ascii?Q?gIb3aqenFPR3hnGepTKLF1kWwii09aLkmDjSRFNLMDSVPDEsD+GqT1FBrNnU?=
 =?us-ascii?Q?G7JC2Jms0pJ3l97SAWxNYMsU+Yzi9zkrL4NeOjGATIdhrqONsziueOqKtKKc?=
 =?us-ascii?Q?R3zIBehWLAxEqZ12A4AyX3x1aYGaHkLty+4Ec91Stpdn3zvQvcLrwCUm+t2M?=
 =?us-ascii?Q?XUqjw4JgcdwNE2dqHz23EAlG8bRyTtrnneAcDXxVeNSg+GVf1n5DRqjsr4I7?=
 =?us-ascii?Q?5wUawWboMD02Jys1GzVhJbsuBCwQ5gDZVjiveDZi6UjHlbBzU+ga9aiSD+fR?=
 =?us-ascii?Q?dUZIxXPnvKh1m2e92jt91iBbhVsT5Jg+7A/pz2OmhaEYI/RdILc3A02q6YIf?=
 =?us-ascii?Q?OPcCY2lII+rRAviezX/vpBsMIAgvFGjoxgsf7zqjv9c/0W0W9Nt5gp2Uodlh?=
 =?us-ascii?Q?vI2okxVzsqqun1OUkJsh03f0W02BLZ/0ZUzMo4/KmXqDPCTK9Cymjffy1ZTN?=
 =?us-ascii?Q?Gxl2Q9P1Etdi1h7IYbpFeq6IBb4ZzZEb7O9gQZLWAjFKl4rWeWcLXLSPxXLs?=
 =?us-ascii?Q?owzxu69XJbVnYchH9jJs9P37L7oiKDeA1e6Th48M/DmgcpcXC87Qp0NTNLq1?=
 =?us-ascii?Q?+GdaW+I7JZqfcxSFTnYKuKYmz6vzBk/AojrilE7E9S/dM7ak6ffzkSJQOA0z?=
 =?us-ascii?Q?9qeoq+3F+ljXtbcQn1rRBp5yzWBQNzPYZMH0kHAJ3Wr/VJ/vU48dNI61xHl3?=
 =?us-ascii?Q?UuUovtmL8rh56XsxSUyK6is4Lmz5SnHu1xccZO7JswiO6r5aCpiDZAyLziuV?=
 =?us-ascii?Q?i/nTGBvd0zpl+vjwXFEKkO1UeBOxYaQGFMQEvt2DdKaOu+ScoEIcwdcJEccm?=
 =?us-ascii?Q?T+cKUWIVqWufFzcVIzXQ9jz+dCOfKS7z9SH9kcRi6SDMJYi50vi0M4D4jGfv?=
 =?us-ascii?Q?B9jOICCcuQpjgra0DUSgdSVDZKdDfHy7da8YpsjhDkeandiu9nIH6KLOii8+?=
 =?us-ascii?Q?muvj8K6qAdSLgQtqkzF36+tdtB42M7dDRhr5Uq9MbsZA3XEwoDGExAnTd4Du?=
 =?us-ascii?Q?xodld/yRF7Q6/79OoY+aFOw8udlTab/7Z5KgZxxgsSUAvUIpZWC5qj/QXdpi?=
 =?us-ascii?Q?O75Pnk8wzy+VdUXIygzznsoxBFTJrnGMlcoP3zyY+hT2e7o+AN1n2N7kcRSZ?=
 =?us-ascii?Q?jy39H9sXNT4ETWa5rWs+9fG3N0q599Vky2UCIrereTYo335gHoN3V3hbJCT6?=
 =?us-ascii?Q?kJyJPGyMS/4gwCZ6/qSGfSv+VoCPM+yyF9YWz/k2dsfaP/OD/4Vd2pNdaoH9?=
 =?us-ascii?Q?UeXDJ3uoUDMpzIMTj/SR06LBsiUOvnY4tqLghHMwCGpkBjHLJvIS2vIuk8b2?=
 =?us-ascii?Q?LBLAXhvRT8CbFv2bNfkU3gIctzl/flhqpo2IdEeP5dJ4B1MJNPvxObcCMj0k?=
 =?us-ascii?Q?cW/tc5OG09s6vGYKQ/87iUt6aafP3DspBKJ8nK4jREyeaoWzzELJeU798tSf?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wiLewFR5E1w/gxxxwAykJTQB/dC+l6UO/zYS1C+tJrB1zNZHdqIUostumrukNlPoqjB7l6tcaJHxxoCjorLrqhs7BcqLGsud/THswtEZjB1949JLRP2ZjKrzEaBWXtW+ESNkEFs6Y8Q3p5UkEAEFe0pDGJp0AjeOjbulJhXvpDi9Yry6i5S19oZvA9BdwfUiQVtGN/1f+8SlHynm9N6aJbpoJKt3SFG/LdzszC62OxFjVOqeV408l7cDhzSZraTQiWgyAsTQvdTc9bANsZ35vDc+ToTu1VhTQjMn01D7d0ir9Mfo+gpJseDu2g2YFu0GL8e/gsM4Jhc3KKerpMp6UbiPiDH8pIbJl3ahwuFdUPxHifmCC6O0ZdrN6qdPPwNGHgwafHUiaRtrD3l/cayDKqku6Xg05ZUG3HvPmOkWeEWmzrHpAdqbPV4bQw90DuGYPbN3uzccW1fvSbeakIDC+y0WmjZfkODqyeqx3rNkOIKiwAtTBJ97mLG30schuEpWCS43Xr8RmJrx3xtrHncot8kwbKFBEvByec7w0rU3vcJHOQ7FyPWn+sRFjImc4cg/u9S3wr1kEbFfYVRpdV6Z178qxZ1bx+hgB7RXYbB5jSg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54349686-1320-4a7e-ff9e-08ddc56d7f80
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 20:07:03.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMM9/cKsNUQVWyJCQA+L7v37pv6mhCdIoA2P7n8+x/ztj3/gjG+1hAuCmaJAaCgUh+bpDeG3tHV8VJlkfrs3Lx6MrK4TbYT/kreKZOtoqNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170177
X-Proofpoint-GUID: RonLbbOwBr131IoNq25BWXnk_7kx-bPY
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=687957ec b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=tHz9FfFoAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=oG9WTLIYOA6OTJ5yO9QA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: RonLbbOwBr131IoNq25BWXnk_7kx-bPY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE3OCBTYWx0ZWRfX3VQ4AoIEP+XQ ggOauXb2cRAYfEA43XE0ehP4ceVbWgDpsCbW857YCFzWxDPK0+Y9l1BrQ/Kota6mlCkT9/WDMil 5YaP9xUTGb5jQd4u3wtkvyEOrpIGgYsh532hjYq1kB36RkyCb+e1igyU8lYuzmviKOVvFDxJGhy
 Sx6JsgSZtl6mlDfSUr2RbPJPVbOsAgn9sMgJU57Gx9bWgYQE9cU7TkjaL5YO6rvokrSXzIV37TD 8/B6rs59kX9mTKeLWpYgJNEkkrtGbvjUi9mfkYONwj8ZN5hNFbsUlG6RE3RMhpUMk4T1V+bv3vc YG8HG/H51mJsjMEhn6xcEfSUVay0U1pJNZiYkco8LF0GqF6PyAmr3+KgmbPYLRYY1fpH5Gg+1RL
 0I38rtNcVIT4awbTJtffKoE23ZgpBIo1XmY3AzNWmFad1TkGEheao06YKSTTOSCQdShsF5D7

On Thu, Jul 17, 2025 at 01:52:12PM +0200, David Hildenbrand wrote:
> ... and hide it behind a kconfig option. There is really no need for
> any !xen code to perform this check.

Lovely :)

>
> The naming is a bit off: we want to find the "normal" page when a PTE
> was marked "special". So it's really not "finding a special" page.
>
> Improve the documentation, and add a comment in the code where XEN ends
> up performing the pte_mkspecial() through a hypercall. More details can
> be found in commit 923b2919e2c3 ("xen/gntdev: mark userspace PTEs as
> special on x86 PV guests").
>
> Cc: David Vrabel <david.vrabel@citrix.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Yes, yes thank you thank you! This is long overdue. Glorious.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  drivers/xen/Kconfig              |  1 +
>  drivers/xen/gntdev.c             |  5 +++--
>  include/linux/mm.h               | 18 +++++++++++++-----
>  mm/Kconfig                       |  2 ++
>  mm/memory.c                      | 12 ++++++++++--
>  tools/testing/vma/vma_internal.h | 18 +++++++++++++-----
>  6 files changed, 42 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 24f485827e039..f9a35ed266ecf 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -138,6 +138,7 @@ config XEN_GNTDEV
>  	depends on XEN
>  	default m
>  	select MMU_NOTIFIER
> +	select FIND_NORMAL_PAGE
>  	help
>  	  Allows userspace processes to use grants.
>
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index 61faea1f06630..d1bc0dae2cdf9 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -309,6 +309,7 @@ static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
>  	BUG_ON(pgnr >= map->count);
>  	pte_maddr = arbitrary_virt_to_machine(pte).maddr;
>
> +	/* Note: this will perform a pte_mkspecial() through the hypercall. */
>  	gnttab_set_map_op(&map->map_ops[pgnr], pte_maddr, flags,
>  			  map->grants[pgnr].ref,
>  			  map->grants[pgnr].domid);
> @@ -516,7 +517,7 @@ static void gntdev_vma_close(struct vm_area_struct *vma)
>  	gntdev_put_map(priv, map);
>  }
>
> -static struct page *gntdev_vma_find_special_page(struct vm_area_struct *vma,
> +static struct page *gntdev_vma_find_normal_page(struct vm_area_struct *vma,
>  						 unsigned long addr)
>  {
>  	struct gntdev_grant_map *map = vma->vm_private_data;
> @@ -527,7 +528,7 @@ static struct page *gntdev_vma_find_special_page(struct vm_area_struct *vma,
>  static const struct vm_operations_struct gntdev_vmops = {
>  	.open = gntdev_vma_open,
>  	.close = gntdev_vma_close,
> -	.find_special_page = gntdev_vma_find_special_page,
> +	.find_normal_page = gntdev_vma_find_normal_page,
>  };
>
>  /* ------------------------------------------------------------------ */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0eb991262fbbf..036800514aa90 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -648,13 +648,21 @@ struct vm_operations_struct {
>  	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
>  					unsigned long addr, pgoff_t *ilx);
>  #endif
> +#ifdef CONFIG_FIND_NORMAL_PAGE
>  	/*
> -	 * Called by vm_normal_page() for special PTEs to find the
> -	 * page for @addr.  This is useful if the default behavior
> -	 * (using pte_page()) would not find the correct page.
> +	 * Called by vm_normal_page() for special PTEs in @vma at @addr. This
> +	 * allows for returning a "normal" page from vm_normal_page() even
> +	 * though the PTE indicates that the "struct page" either does not exist
> +	 * or should not be touched: "special".
> +	 *
> +	 * Do not add new users: this really only works when a "normal" page
> +	 * was mapped, but then the PTE got changed to something weird (+
> +	 * marked special) that would not make pte_pfn() identify the originally
> +	 * inserted page.

Yes great, glad to quarantine this.

>  	 */
> -	struct page *(*find_special_page)(struct vm_area_struct *vma,
> -					  unsigned long addr);
> +	struct page *(*find_normal_page)(struct vm_area_struct *vma,
> +					 unsigned long addr);
> +#endif /* CONFIG_FIND_NORMAL_PAGE */
>  };
>
>  #ifdef CONFIG_NUMA_BALANCING
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0287e8d94aea7..82c281b4f6937 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1397,6 +1397,8 @@ config PT_RECLAIM
>
>  	  Note: now only empty user PTE page table pages will be reclaimed.
>
> +config FIND_NORMAL_PAGE
> +	def_bool n
>
>  source "mm/damon/Kconfig"
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 00a0d7ae3ba4a..52804ca343261 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -613,6 +613,12 @@ static void print_bad_page_map(struct vm_area_struct *vma,
>   * trivial. Secondly, an architecture may not have a spare page table
>   * entry bit, which requires a more complicated scheme, described below.
>   *
> + * With CONFIG_FIND_NORMAL_PAGE, we might have the "special" bit set on
> + * page table entries that actually map "normal" pages: however, that page
> + * cannot be looked up through the PFN stored in the page table entry, but
> + * instead will be looked up through vm_ops->find_normal_page(). So far, this
> + * only applies to PTEs.
> + *
>   * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
>   * special mapping (even if there are underlying and valid "struct pages").
>   * COWed pages of a VM_PFNMAP are always normal.
> @@ -710,8 +716,10 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  	unsigned long pfn = pte_pfn(pte);
>
>  	if (unlikely(pte_special(pte))) {
> -		if (vma->vm_ops && vma->vm_ops->find_special_page)
> -			return vma->vm_ops->find_special_page(vma, addr);
> +#ifdef CONFIG_FIND_NORMAL_PAGE
> +		if (vma->vm_ops && vma->vm_ops->find_normal_page)
> +			return vma->vm_ops->find_normal_page(vma, addr);
> +#endif /* CONFIG_FIND_NORMAL_PAGE */
>  		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>  			return NULL;
>  		if (is_zero_pfn(pfn))
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 0fe52fd6782bf..8646af15a5fc0 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -467,13 +467,21 @@ struct vm_operations_struct {
>  	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
>  					unsigned long addr, pgoff_t *ilx);
>  #endif
> +#ifdef CONFIG_FIND_NORMAL_PAGE
>  	/*
> -	 * Called by vm_normal_page() for special PTEs to find the
> -	 * page for @addr.  This is useful if the default behavior
> -	 * (using pte_page()) would not find the correct page.
> +	 * Called by vm_normal_page() for special PTEs in @vma at @addr. This
> +	 * allows for returning a "normal" page from vm_normal_page() even
> +	 * though the PTE indicates that the "struct page" either does not exist
> +	 * or should not be touched: "special".
> +	 *
> +	 * Do not add new users: this really only works when a "normal" page
> +	 * was mapped, but then the PTE got changed to something weird (+
> +	 * marked special) that would not make pte_pfn() identify the originally
> +	 * inserted page.

Also glorious.

>  	 */
> -	struct page *(*find_special_page)(struct vm_area_struct *vma,
> -					  unsigned long addr);
> +	struct page *(*find_normal_page)(struct vm_area_struct *vma,
> +					 unsigned long addr);
> +#endif /* CONFIG_FIND_NORMAL_PAGE */
>  };
>
>  struct vm_unmapped_area_info {
> --
> 2.50.1
>

