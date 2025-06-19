Return-Path: <linux-fsdevel+bounces-52232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6E3AE0582
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 14:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC4D17BBB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F030254867;
	Thu, 19 Jun 2025 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X+y7S7sa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j9SzMw/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2B253F2D;
	Thu, 19 Jun 2025 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335613; cv=fail; b=O4CAeUMbksmfFrqaEumRxt3BSl5kOs1tVROlNSoA0VBf98a7UPi2utvMOZwvbrmELhzdUef+3I02UwTKsMw+okBE2ipUVmoJ3vZkyxIM8pd5rHsEfSHG52CE4SEUfqOEJ3N+PVTcaPBFx1qZiXCfzbT+hcZDf/ZhAmOrQbfvgQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335613; c=relaxed/simple;
	bh=D2EAd58zmafDFmxE+Iwm0cZp57bjSp/ij3ExDUQ1Rig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LTUqgWUpe4MADDBo01aieOUwzwpeCYHSLAMCUW4iPf7bJgYa7EfED6rAoVAfg5iguOGyrbJG7wU3ClE3DmLUCtyv9VN4tP96mDZvQDHQElpvwerBLwAqh6Saoh8/7MK0kzD5iomNsJaYotqf6Pd7P9GcSjxW1qvod+iqGMkaUks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X+y7S7sa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j9SzMw/B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J0fwEQ017514;
	Thu, 19 Jun 2025 12:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pDLCdvRhJukDRJUM3A
	uzmEiPsGcfzG5rO/ieMPZpaBU=; b=X+y7S7saxnK1ruUIpBJM2ZEm7qKqbIPRr3
	S1KtBB12zDoXAlQohSP2jWSS/RbxGkT9mi6YPWSsrqolmn04z0669AYnOMcCnQLv
	8ZCEMVvgUKUJW89/Zo+zj9JWtJ1OV+FhdGg53ts646JhWSZKsZbPmy+IYbL+qHF/
	EPoNplXn+1Ajj6x4CYFkEThXS+9DrTvmcbK7UTzUKpOIFiQA0pOBIVbOEvxngNYk
	1V7D8cTKCfWDHaEaF7aiSpskDovVEeFfkeP3CSPcditN/NY7/IXQthtO6HSoYPwq
	8rFrqnp5aNWGcWW2kwiRvs7W77x1Zf40kzHsYGUYt/fDdo59t3+g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r8tnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 12:18:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55JB1GRl038324;
	Thu, 19 Jun 2025 12:18:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhbuetx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 12:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH1/v69sZ4MDMynipLK5sVUSgWmzmHlfbQYMfOE/eeA4+sn/Ub69Bk5ElW8OcRlk/YSBEd5NM2+n7Xxr6oam1WYOagA/e/DAl62PPJLR+K5chfmR9FErLa4nrHc1wxC5ZvwEF3fDp+Lsz5OTXxgBVGApu3qNPhUsiQgcv8uXmeUEKwe4tgnTMmubbc8LY9olGsrJehfE7Vkh0gpKjHnK2SVlt48VobR3MG7yXxo/qf58DnOJRodHr3sCi4g0XbirdsHgLzCUg66dHe0iWmnVI0EepuhCNHJYgOfdb0ggtoMYloG4jfPUBcChjt+N4Lj0JFZUJ6SGmYCRMlJUP4gKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDLCdvRhJukDRJUM3AuzmEiPsGcfzG5rO/ieMPZpaBU=;
 b=LrTeQSEJUo1hwBMMvdPJAnrEbYSQ6JtQexQaWUhBa3irI1sJnslOdTqhlMOAdJbomQ1NpBaEkS3tJiVtODxWbIunSsdhKED/CAkStuL7xDvubDjtuQGQ5Gic1Xq2/4Art+gfjOc3gd7pRIuRDv6ysCloIlz4migutupup1WVTRfj8iomlM3Obls77+4bkx79YevG2B3HhAsydlKEg3d5j2HbMS3GwI18Y3ChUjj8cRkR19iWYhPI7I1f8eMRu+dNhhRmp/mR7kBGTmxFk6olWwApqJyJ7u+lPzFEyQtgR0QKfiIBAyovKVoK/Okz9tgbc/LnfmlEjL3onWxryj813w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDLCdvRhJukDRJUM3AuzmEiPsGcfzG5rO/ieMPZpaBU=;
 b=j9SzMw/BOeIF30+TB1HoiShCYAh+4WMwKETDTogOYwrWnMKYW6o4sr/B5mL5NowKU3RVh4eJZF2Yv6MAyFJeIzSVygO+vEwDMC6A2mCE2MguFLlYzxi7N07SuS/KdaiZRkrGI+Mbb1AiC1QMFhZSUmSm615xDpyHOmSaYPlX2Ns=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPFDC03D7E75.namprd10.prod.outlook.com (2603:10b6:518:1::7ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 19 Jun
 2025 12:18:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 12:18:31 +0000
Date: Thu, 19 Jun 2025 13:18:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: change vm_get_page_prot() to accept vm_flags_t
 argument
Message-ID: <17ec7435-4928-4e8f-b95b-a9b166c76e8a@lucifer.local>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
 <fad65354-804e-447f-9779-2c69a87f3e4d@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad65354-804e-447f-9779-2c69a87f3e4d@suse.cz>
X-ClientProxiedBy: LO4P265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPFDC03D7E75:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1eead2-d6d1-4aa5-0b57-08ddaf2b6794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hLK2xEXGs+AqGzEkm3f99mqpenhhMaB+BL+ZedWWuriPuzgPwujyzPV3WI30?=
 =?us-ascii?Q?gugimqPYuJe4+zMSgHa8lFSFuTxfZKIa+dyW0kcEGdBWf3Qi+xOU3Rn4dC6d?=
 =?us-ascii?Q?XXUt/z3cilBVDtd5k9+Fygwf++BAX7aT4QYOlcy1oZc1tctIa+2YIp26yPq2?=
 =?us-ascii?Q?2KfEjf6ZG4UHPwjQ9rT1zQMavf2aJgF3dmy97meCVGkM5C4InPxC995rwZtN?=
 =?us-ascii?Q?wOy/BJ6rhyIFRNZlyVsgho1zDuov6Nsz6HYSSfQvG/emf/0skmzCz5ruwvOs?=
 =?us-ascii?Q?Y8BK64BS0VrN9wzlgtnZN+1EFu8+hXEifH3PZq61zOO8yi4BDLgLhsjeFgRV?=
 =?us-ascii?Q?gW/OiU8TqyhC2ne8D1ph2r9hnXzLemXDL9UxeufYPwcLx6PyCCnMb32mnAoT?=
 =?us-ascii?Q?iFCEd2+6ZSbouxaQwNqke/adkSWBDuLeZ7LLBdTP8fufHJfyPBWZnJC9pSDH?=
 =?us-ascii?Q?R4BVGCMHgLbdq1sxdW1Olm5aspNT41ueauCn5lI25kJPi4oR5CyzGI4ufRzD?=
 =?us-ascii?Q?hyZgKKKpIxPpv6XyeKvzN7Ugc84uy8HUQah+wUhL1jLL07AWMgM5HVEjj3H9?=
 =?us-ascii?Q?BZ4z8VQKLlEROCK33Kx6C+gpE9LXHkD/hYyvweigDBGv7LTFSQL2JoQXEql3?=
 =?us-ascii?Q?DmvQ8yyhZuGKQCeX7I86hDGpfROKGXIsMRC1xYQr6AH7wh/qIDdIBQXnnSIR?=
 =?us-ascii?Q?v8aWN06x3RlnzjfMp8anKwAByNAD75Juo9J3LDqDZyP1xOLuoQBxGYFJOKEE?=
 =?us-ascii?Q?fKYx5zJ6SVZCnJyyjy8AGwsxewwKIVLVXZfyKmQGbKZKZdc6OPrHmqkKvnOi?=
 =?us-ascii?Q?D/JuQL6eLYLU1HquISksTsLC0uMVmK0toVnGu3i5qiFRda47Pv/BRRpKxz/p?=
 =?us-ascii?Q?y3fB6FVFOgsfwB3iOeBjxEhxpOWKCPGjRX1tosoYsE1jqaL+RDKC7TO2wyRN?=
 =?us-ascii?Q?o9CSA8le2fTLAansXFrNGZktJOjEdHudCgOg6fK3eRj18aK/QRVkQ97B+ZZK?=
 =?us-ascii?Q?TjJFP4ejLc+Ds/G6D17GGVFLBbsUemVW3IA9sjYRrJMAnpAeY3xO0RtkKEqE?=
 =?us-ascii?Q?W16wXqjq9nTeMl0HIst7JtcBrdAAMnN0h1RWeld6/iHPY7Tlcj6kxU/Cklz9?=
 =?us-ascii?Q?Ke4p3kOdkML6ulGiiA+vpJ7rmYq4zIIVIwK7jIkJdSv09WGlh0zDX6N9+FAo?=
 =?us-ascii?Q?mWTg+AWwOQd7nqZVPJDxLwGbUvUuBkAM1lLm218JVXg/G9DaI5RlTfu6OW/u?=
 =?us-ascii?Q?PPA6IWM39S7OmkJcRPgV2P3RzKkkVEOtlALXkM84f5hb83+PLS1TczbbRR8Z?=
 =?us-ascii?Q?pZaKXeOBWtep8ZFyDvH7Ocd9BiWJyV2Q65Lc4hTTu/mdtq8RhQuFy86nOKSm?=
 =?us-ascii?Q?c5YO8KB63MnaGG8YBINLcgQqT8VMG5N07DUn+W8CJmGTETv9KVBmmyLQHjlx?=
 =?us-ascii?Q?NvgFuqYqFlw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dIJcE0OjDqB3hRTudTcY4rdlGCIypQbA6dyAfxrDoYUaR0JHcGss4eG1K/1/?=
 =?us-ascii?Q?dwve6xx/oj1dky04FVQeQR1CE2kNdsmlDtkX1EFr6UqgOED/KFYHMgY/JE9F?=
 =?us-ascii?Q?xOVThLIaMUYDqQaCve+taK7aWOz1MULULrQgH+Zee4IfxAnj0CRWmjNgec3F?=
 =?us-ascii?Q?jz4QAyBofMXNtqPJXwC3ACQzHytoBpTE2N65vRuS+K6jj71Tw4FwCggNwdPD?=
 =?us-ascii?Q?8IHmkm2f2JjVBLQRKQnFWqm1zzY7uosTcaNPx8cQkW+7u5S6HHE7lfRrCpF+?=
 =?us-ascii?Q?eeD9yu3XXf+OhPa52RcvZAl7Ho9QjODDtmp4rVyZc35EOfxADdKI3AHa6MGB?=
 =?us-ascii?Q?kDrU+gqX7tTooKqCmNh6lF7ml3zDv/X02RKIvIvnJUo4WZT5XNk/O7coYI60?=
 =?us-ascii?Q?aZ9Tt8GevFyLbU/38hWMIU9uI9t4INA22BuiJZc1rnCCSorx8AOlvdMN+X/k?=
 =?us-ascii?Q?0ju5FLwOt4pvvUqED9wI/rG/UyGX5ihRNE8Q8EYcaYKwuFYFDE+GL8cDYxsp?=
 =?us-ascii?Q?LvDAf28m0Tbx32RHPcGv0PVJL7TxXFKToPwNP5aPdBCDIiuRYFLswno5Cocu?=
 =?us-ascii?Q?PjLQIMQfPVcGJsHZsj5t+vgYp5pErXKlAH8mTfNZOmZX3E/IiYBfeBEF/sMX?=
 =?us-ascii?Q?h6IQAkeJV+Wh4qevhKI09hpwUZChPs5BfxwHpdBdYRhD3XloBChAxjMyAVYo?=
 =?us-ascii?Q?yMOKHBzewL05MqM6U4eTnhyxzU5L28gH0H7dCeZabcv1Dqqrm6m4hnOXiN9a?=
 =?us-ascii?Q?Pk+eCI/76VDJC+9naZ5x6zYo0AsS3lk9E6cntcHptqMft+lPEQ9HcvlsaK4o?=
 =?us-ascii?Q?0fch7ujYchCCQV5NiQHYK8JtKthRwGgOKws8wklA44kFvdeb7+DG8BXzjGdi?=
 =?us-ascii?Q?aV/NJmoJU1eKKl3xmSud+/Pc94zsKXbsCbM8IFOMlXcZTg7qe/5goRE9lSt5?=
 =?us-ascii?Q?aIG8o0Rcw9ahpmeZW+HerXtH+2SwArbk2g5ibgsIFvqIP1/zebDlrgz3vPgb?=
 =?us-ascii?Q?W/+jS29n4ULgrpHvCmm/q/J5A2LP/qcI0wwdHBl80qANmdyKD9VCnPO/I1OA?=
 =?us-ascii?Q?0jt7TIhSfPcC47X1whSJasRTwTw73zoeCDqxXma9p5YKPgUOUmSSlvIEsBhd?=
 =?us-ascii?Q?wDgnDMSZVVTxVvWwiplKq86dsiD4/yr/MFmJMvmHdsVWn2kbD+pSEt8/dOth?=
 =?us-ascii?Q?wsqd1N3HMoCdTD4t5JDxXGfI0XIqhpulCtFPQRyF05Uu5WYBxFO5R4Am10Oj?=
 =?us-ascii?Q?dswW5QKGOuFm/4eT1UTzUVMlJ+6HuNZGNzn8Lk9U8emde8OPrSys3rEz47v0?=
 =?us-ascii?Q?cc1wD4eCrmYp7VGRUCkT5Ocr6IExwoRlaWzN0DzTFPNrZmZxE3q64MISEDsm?=
 =?us-ascii?Q?8hr3g/k9OVLxzRftcBIrOikIHE2MlXpcMp+Ln7iceVKWhDcsRqHgzKLX78ft?=
 =?us-ascii?Q?+gw5WxDpAXzmm9AZoPawVjqGi/wmBGHmJ94Scf3j+h+J67zHhlskLXiEZI4Y?=
 =?us-ascii?Q?IVb7dhopDor2cfcF7dkEidAkghUI7kSHj9rfOA1I+XEY91LUExCBjw7/oGlT?=
 =?us-ascii?Q?FTzwCljaPWfQyGnygStj4I6oqXmWTFcNtIhHFI322v24lVbxYM0WiJxuF0L+?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uxQtvx4K6yC1JmBBIKTdetOPgVN2ECQmmeMgH+Hjq7zwXE5dxTpsv4MNuUiFzpwV1Qg9CXgOfuiQG3JfrMMnGEcO9jOF6NoqZDlpZxlSJPACMI7w9FQqjoLZOWMMcXZIhzF7ZA7eyz+arjIVV7cCqR/+eNzl9kfDlK3osNFlyu/2eOv4s0M2H3m0vaFEbGX8lkL0kagR5Hp13MnThTfwTRDfWZKAJ/Q27PrKE7hCI1d/Fjry/VshUwa/zbQp+nLXdOzH7jmPoecThlxxZQtoCsqvPXahb2//3PspyHfmtAR9CpfnvdGnESP6FahMdhwFdqzcsM4+mtnR7ZO6oQ9M250ZCyLMmA1LS7zJ5HqZRWYOUHbc6DU8PUhR7ELsZQXvVZWwdOW167GGPuCborSttPQvjDbwgq9gLa+Y5meHzIAxTy2PVhiEFbbTEtdtXNQ6a5zfPEWLGnGe66/iOhUb+9sVwrINAAq1A/kGmPHnET4rqBodlq+TnrGYbRM5YaxX0+MyNRjx3smZIb24fGu8itJ9an8lgZFXQnYMDUI+mbcElJ2o8HsrKFs27KHNQzkEKxEW6NEaHpFjBfROEAK9V2xfJEUYo/r/AKsbpa5LAmE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1eead2-d6d1-4aa5-0b57-08ddaf2b6794
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 12:18:31.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yem2f1QtlN14Nafvzqj1AJz6V3GzfWj/WTq0HcHT0pc+23LeslTzuk5rqwsWImB1qOqZMRZ2mJA8heUawcIxNM90R0urma2K6I+qwFLgswY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFDC03D7E75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_04,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506190103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEwMyBTYWx0ZWRfX/sujbZkQKWXJ oSHicfAVbIGc60S6L0/PgJz4ycBESH6847dCZ56rYXfIlY7+/dr/YuXDKBVyyG0lIZ8tY97W6dv rIbFOXFz9N9wchBZNC5cuEzDjzaSjfzrqqIAaOAItldlIcckGUn8F+MPMNEq9tMiJWCOl9Nut33
 HZS5i4yqrFnQosz8MMqTYxSM1FCczZ3urkci8IDfvDgJ8kisbN9cPMDrLMkiUwfnqm1wQGLVkTh GBZ5MWLWYJV1LkGfrHyfcXy4oWYwVW8AIehRX7HtC55GnDAO9zAkXOYLoh+xsTXLpnHPScDhTWN 7a/2Osm90A/+koh2IGg6AC+sDWCslXia4Ekes332X7VRB9mXvMcy+HEudyV+P8OWlIuoDGXlaPO
 t05wm+qHiqT9Ybk0WNdy8D+x8CWLXtAkgGLCFdgohB/qW4n/ZgOpau0Ff8jNOBDtr2e1Vz6f
X-Proofpoint-GUID: JXzKr9ojKc7_KDfANnz-HsNWCxia1PZj
X-Proofpoint-ORIG-GUID: JXzKr9ojKc7_KDfANnz-HsNWCxia1PZj
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=6854001b b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=kANka7OCNmWSMdJVyp8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206

On Thu, Jun 19, 2025 at 01:31:50PM +0200, Vlastimil Babka wrote:
> On 6/18/25 21:42, Lorenzo Stoakes wrote:
> > We abstract the type of the VMA flags to vm_flags_t, however in may places
> > it is simply assumed this is unsigned long, which is simply incorrect.
> >
> > At the moment this is simply an incongruity, however in future we plan to
> > change this type and therefore this change is a critical requirement for
> > doing so.
> >
> > Overall, this patch does not introduce any functional change.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> > diff --git a/arch/powerpc/include/asm/book3s/64/pkeys.h b/arch/powerpc/include/asm/book3s/64/pkeys.h
> > index 5b178139f3c0..6f2075636591 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pkeys.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pkeys.h
> > @@ -4,8 +4,9 @@
> >  #define _ASM_POWERPC_BOOK3S_64_PKEYS_H
> >
> >  #include <asm/book3s/64/hash-pkey.h>
> > +#include <linux/mm_types.h>
>
> Hopefully not causing a circular header include.

Well bots should say if so :) these headers would surely be broken if that were
the case.

However, since the only caller is arch/powerpc/mm/book3s64/pgtable.c and that
already imports mm_types.h I will drop this to be safe.

>
> > -static inline u64 vmflag_to_pte_pkey_bits(u64 vm_flags)
> > +static inline u64 vmflag_to_pte_pkey_bits(vm_flags_t vm_flags)
>
> Is this change rather for patch 3? It's not changing vm_get_page_prot().
> OTOH git grep shows me you missed:

No it's necessary as it's called by vm_get_page_prot().

>
> arch/powerpc/mm/book3s64/pgtable.c:pgprot_t vm_get_page_prot(unsigned long
> vm_flags)

Ugh I checked and double checked this and yet somehow... :)

Let me send a fix-patch for removing the include and converting this.

>
> With that sorted out, feel free to add:
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Thanks!

Thanks!

