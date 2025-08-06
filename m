Return-Path: <linux-fsdevel+bounces-56875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B66BFB1CBA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F228627EF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254661F0E26;
	Wed,  6 Aug 2025 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="avRSJsrv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="okSHGX7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0454673;
	Wed,  6 Aug 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503523; cv=fail; b=HBo1lfdrEyvJItLfO79a0IqX+tFDfTi1vlHeCwdfkChLdE2g0lppY4JkAjls9f00BdfCTRE4IeVDRHxfY0XJXO0M+JfSMfB8XU6gwaqCHjGiM6Sor2ycUR7Ff3nbyF+TZOXVnBF3LTj0lPFCblUHUrCGsdmRTm7XbJr6odHbOAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503523; c=relaxed/simple;
	bh=QUb6pOWhRywGtWA3dWh/bKC0u+Smq//FepIQRP/1k8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TOIk5OrrlBcALX1RtOQRk/hrIYRZa7wZVIlZQMRkA7mCZmCPBvSd2b5h/fv/vSL2HKKntzkCNChACSCwTZ5b/lWkFuRwft+HC0xeDQkcKcc9UGiJRcjMi5xJCG/j6Y6mGeFZ0EgJM3eljW2uVwWbxMTZ7Ti7kbWIZ2oTPzAGLxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=avRSJsrv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=okSHGX7u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576GS4ok020939;
	Wed, 6 Aug 2025 18:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zmzO5Vp65jneRa1zz6
	ww3lY3S8xzvUaLXFm3V/NEOT8=; b=avRSJsrv+dkyHH6UdcbVz9UEHuaZXedubB
	MoP3YykKGEdBXxt5+rxyeR98HVKUP4W7fhBoabs5YdbRAviXaX3d0FB13kAt6e0x
	m+ysf9R1IxVdYiIWpcsU5HjEMvfOW1/jM25UIhpVzZDuwH0iwmiU/4pCwtGdkq3A
	FpWaojp07Bxvn1QcvI3Ii7U52khFlTCi0+iUI4GZAv3cclmlfCFJ5Egu+FU753mY
	z+Rdee60lvQJfaCoxEljTyD7Ca/dl8xvu2pxyRQxHdA3qbcfFNIXNuJEAraWtjYx
	DUepRRVqPQQhwWyM65xd/Ax9Vofo8ItISKevL6rJ52roUv4tLBCw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvf2ab7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 18:04:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576GjRn6028233;
	Wed, 6 Aug 2025 18:04:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwmksue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 18:04:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/GuePQJK2syeCjCK4iz8bTUYK7iB+6cs4oOZEyFG1tSBQdlTCiVSkbzc9L3uDuKMTGe8RVqcIOvJxYAdkm9gBpL5cFzuvOH/lKj7PJ9RewJmzNKIRyZp+BMRTsuP+FUIqE6OMTCZe1C5EAfUYjCxEKqBh+jQzvULbKxt/qaTybmmR2IMdk1dTgiEKyqi1fFTqHV9Gvk/ORs+p1jx2PghiNn2r14JSJeD0+xjYpwBehWF33jN2aI+bxMaZedZZxGui7C15EFgMsShld8jRluCpXqtegCtA/Ub235V1pi3twpPdl3ggUtxmzDNAe9p6bvVTyNBk+UTyQxPwGNh0TL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmzO5Vp65jneRa1zz6ww3lY3S8xzvUaLXFm3V/NEOT8=;
 b=XScWxR0yhwDboqd3bVIwuVtjNgzZY9pgEojEieS9WUIEuKrAUKRoILwcxLdZEYPKrd5AM5NvVt0/jC6Bd2JxVv1LLaXaC3g7ALnQ6xN4F34/VseSlfYIrXVxbDUQiZVupRnG+CipDFn89umLVCm3LGoTXvZpxLSdREYUyScxUOLPwmfFO5dIugzZFZleakuyvGRE7H+DpVLye573Uuw2L2/3+7ll91h9IyxT/CzJvmGj0r5j2wKrcLNyP5mro48mzkaBlpZLEHuQQ/AXDvuIQorfkU9BOIIz8TVCxUVndvZWaPXju5C3V72pR7KKKUv3ARNVMbx/5m38gdYBYUjrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmzO5Vp65jneRa1zz6ww3lY3S8xzvUaLXFm3V/NEOT8=;
 b=okSHGX7ujES9YaC5ayg5f9dHQXdU4gTtJYqAiBK3jluvvJR9B9zWLFMsBXaAaky8m/7omjYeaiVj4p6GP2RIvKy7BrIs3uU5DQ6cUotZ8O0xYF0xOUyraCEPiD/HYnvCaoe88wm7vBj2L5GjsR5vPz1BtVpsS1oF1nvaC2CP8/Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8729.namprd10.prod.outlook.com (2603:10b6:208:56b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 18:04:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 18:04:37 +0000
Date: Wed, 6 Aug 2025 19:04:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fs/proc/task_mmu: factor out proc_maps_private
 fields used by PROCMAP_QUERY
Message-ID: <01bedec6-53f8-4c1c-9c47-c943ca0f7b4b@lucifer.local>
References: <20250806155905.824388-1-surenb@google.com>
 <20250806155905.824388-3-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806155905.824388-3-surenb@google.com>
X-ClientProxiedBy: GV3P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::9)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 30dc2060-2a13-4700-7332-08ddd513b527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RmLcL6UYIAiHxCdfs1jQFVQJ0tSeM9PwxqJGv2FgsDEAXKBg1TfAM3t13oUA?=
 =?us-ascii?Q?wsGzQj0E+pFyi4pQS2LEW83MjRieRBpHJmsR3AVy5Jxd/okFStqRFM/Oyzl+?=
 =?us-ascii?Q?upy1Nv2pYYYF0G+C3kBSpJnuwXngP4/EEJhoLJkVbcnTdZrlJagnGAcY/3CJ?=
 =?us-ascii?Q?fJjQNReJzbpSHs+DrpdJxHueVVdNea4gJAWagW9gGVf8GLyp07EMupW/KeXh?=
 =?us-ascii?Q?pwUEZad2oh1ESTcDBFdVXJBeTKLsdQ32EnC7lqPz7oYGu5QmOo+8dVnzEOWd?=
 =?us-ascii?Q?frZPevyzdGDWOcDXvQCFnmup45XKi4ZJEUmccZPkyTWEfRN3S11oEy+Gj+U1?=
 =?us-ascii?Q?rXGHbiPXPkg/TqMuW3Jl3V/KhUhrZSUavV9b8URmMo8EFFTQYqXZl7z9KAbW?=
 =?us-ascii?Q?dRBN0aLfuHhomNRBrGU+ypu5ZexfAPAb//fZWTwOl4J+nTL8FIlvquzJ/N41?=
 =?us-ascii?Q?mJdRBess3NMIX6WA/1yrcHX4aMsOQTWk7ryq0xvR5JEontWQwB7nxKboT+ua?=
 =?us-ascii?Q?vHgyijksczJUTHoa6HWfLfd23fSjjAKO8SwkeZGEwJYpzIISgO/5o97l0Lwa?=
 =?us-ascii?Q?e5CHy4HVIjL/BeyfAjVeQsCOI8tvOBR8RsdiZEPbtbHU/UPQYYvTZ3/SPZDu?=
 =?us-ascii?Q?D9iyUaAl58Em765ndfgrIW8EmVL+sDSHMI5l5R8aaYm7M1DqDJujBGYbDfMu?=
 =?us-ascii?Q?oT/ROBHBHbhiL/CKfJ602zjP926dA7PTpdffKAhxZTaXCIIIgrWlilKRs1Lj?=
 =?us-ascii?Q?bm7nkgEw8S9viT4PaNvBbpHimiIO/2X4BTdbnSB6Yuj4jqBH3rsZFeIeI56+?=
 =?us-ascii?Q?udsLrbi9163n7rV5Dqm5snWcnXP7muK5XsHnW2nfNBVulHeAdt9XQ7EsbV0M?=
 =?us-ascii?Q?bHzxHG6IAjjbBK0/ndHMCT/nxkDxT50RVdjMjZAnRPI4V2K/iUbLXf7sOZHT?=
 =?us-ascii?Q?cSh9fALMLJibJCZNXcNtgH6wBS5fATd0rzRCG6bq4NxzFEZm1C1G2IwBmzbZ?=
 =?us-ascii?Q?H8iU6AN+jdYx6LNsz7oSAaDk6zDCeKFuIAQnHT8hj2cDmN7AbTVe4Py26L8w?=
 =?us-ascii?Q?Uq2TkWSUseM51ZYmBqbrnrNG5Pt7+6imFdPPKAmY/Uh0JD6qT0IYgDpiBKfq?=
 =?us-ascii?Q?ECOdISJYvxHNM5G2IGKrjlo7haC/XPvAssJ7XlHYc4zMnVGGmP9U2LJxF8l2?=
 =?us-ascii?Q?BotieErOEQm4F+7NSq+Itt7TNj567JONrNyeo7V4xgMzieyyYp5GA18GR95D?=
 =?us-ascii?Q?ZQetSUhoZ1WTMoqiQ89hN2MIEgb5UcQ9EmCKtM4feBauZFBKzGgq3LrZnxM7?=
 =?us-ascii?Q?6QnGWxwTzpzYiUZiKZCLjgNtWcY6uNjzqxp3x/XQlRH62P+5m0T5secdwgiH?=
 =?us-ascii?Q?1COmW2sn98dt48rYm9u8UCejQJnVggbg4GDxNKuJZEfAA0cKiSq5CSe7/4ch?=
 =?us-ascii?Q?AtKBeQMBM1I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wB/2AjG/hhXLLEu4qDU0Mbf/mDG17fmiJEKlxPBRzMMTkVbHtd71R1xVcqgB?=
 =?us-ascii?Q?g+4o5fdNkPoEsLyqn9bUWbzpVKZ7IHwkO7qaia9BMdGekoxvrNGqqGRryAm/?=
 =?us-ascii?Q?yRqOTLmZSm9c0DaFHO6AWPTepkSvt3H6xENTD57h78SC52jVljaS3tVMpAj9?=
 =?us-ascii?Q?qun1Y5RN2t0Dqiuobi9MSmir2EToO/Gbo1lYPFmMIGhYuLVggOugLOKllqvl?=
 =?us-ascii?Q?XQD9KPFxESKM7KqiFkLGwG9su+tcfxWVe87xq9BWGqJXa3jHrn8FQ4Q2jKKr?=
 =?us-ascii?Q?w9aX/JZfxUfpjqkhYYywpVIDh0Zrwmfct6B7AnZ+uglrBVSm4Xm5yVA7W1Nz?=
 =?us-ascii?Q?Tz/DuX0tiBCzqx7SwtRhb++3xk9O5VBJfRZnAZWiBKxiww5LkoSVXi/nkwAN?=
 =?us-ascii?Q?+N759BBnYJBS3UfeI5Nf95jgVUrD0x+RJw0oPrgRW705BcOtqY38UCb9knan?=
 =?us-ascii?Q?Qpa+D0rG5UF4vc0zI/zFHDCFhVN0DVszt+cy3GKbEi4PRq6vI1IqFofaW29G?=
 =?us-ascii?Q?lc+ONO1gjq59pASlQ5EQbDKJJMNPFn7SwYsYJb5/OUlYJ12FLNW00VAqhhuv?=
 =?us-ascii?Q?7D3kE6AlO8s7qgOAP3ma8gxI8P51TNa23uWCqVdeBByR7Wpjg5ap+XwCSYqw?=
 =?us-ascii?Q?gdzm4SqRdSKz+lXWXT/xrKbyYN2PZANXH7jMNxBrDzZwYaubcckfef+gLsBp?=
 =?us-ascii?Q?KKQ1T9gerYIKH1yxqeRdSQYDPpc9vviEa3omqAqjKMJWkNB6ybKpCeKr3Sxn?=
 =?us-ascii?Q?WJovzrMtaSriC5ueS3lqrN1x52t9vDHP1ohIkbjkH67234n8r6DTvO3+C+T/?=
 =?us-ascii?Q?YOF8YXigkrwx9XrJCK48ZHeGm/AjFj0iMplSQ7LOkhhCZNbY/Iralv5+P3dN?=
 =?us-ascii?Q?uQ3akn28vZJOnKSZwN6lDqeVgSZitvKjfow8Wx/d0txS5hgZkGgfLtmt/qf8?=
 =?us-ascii?Q?OXho9pYVrUtgjml1sDJ88BktLAByCIxIvH53opg+bel7I2LPcicPEXkmJR+E?=
 =?us-ascii?Q?6t/zS2ZBBX7RCNW78PNuICJfE3HZXcir4kv8WZGGL1+Upx1a8J/55iqJOzMf?=
 =?us-ascii?Q?E5dv2Z88vkc4Qd+JyhkL/xaGjVCF9mh1hiFAxCLnOGf6/6ckRPJgkg13UXV4?=
 =?us-ascii?Q?JgOpgaecR0D3jYaSR1xAUq56s2zy6QrCkczwBNke1IMbBFrwaDCQO/5MTIOX?=
 =?us-ascii?Q?CnADiZ5cN0YKt1gQS2eJqZzrNNYK4AqwuRKbc4959QRt5lPzULt/NscIz1rM?=
 =?us-ascii?Q?fOxfhx/3PQAKE02KPk8p5R6qhQoUr1bM4yeEsBCSs5XhXWo2nqsqJ6ZVsOrn?=
 =?us-ascii?Q?DMMT53QcMN3YO4M3XyRIs5YdAbIkbdVf1rDFQk1A1ciRCYd/dEG8+yFUeG0Z?=
 =?us-ascii?Q?fuiGq8D5Im2FxKsRSgUDrhOBGGkTfE3dtE1jp4HrGnKN8Mzhi3Drt0OwP5kC?=
 =?us-ascii?Q?f037wa/vEuuY6go6Vdcg+4xwcLBIcdKjzBAQ5ABTDtma/ub5uLaXIwc8nxkO?=
 =?us-ascii?Q?4UiCLEl84c/5sFvaGIb4vEK+KNC0GcaSOn/ZMGyqpVqMjFA+IwhaCkoIQezT?=
 =?us-ascii?Q?qQjhrl2LdOPVOvMprXxxpT6w32lXcyW4JKjvU83HWq9zd4pq/APoCO0LgMK+?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PpwdQVaqmYVKJJ9vaXUc0+VV6u1iUh8CxHjM4IB4+AOoyoggP7MBrzryNxSNrhZxv6IWlrlP70Tsrc7fxB4ZkzTfWdGoaXxD8Nq0gJriflMQpC4q4JTUkdE404YhI7zDYbeT8YYfAOjYFDmvyd8bFE+TziSky0dkJlFl+2TaHngiXRv3jgYu4hFvMTZ5mCO6uxcAzCYVg9BKpebcIWZ8nwPSLWyYKuMC9uLkNkMSaSj5aXfudxyrIN9wYVCaUQYTudqd17K2DfvkolS7RZCY+Jt7R4mCuPI0gP2/pT5EFPDDlOLLY1MfbToDHlse5U8nHAafrZiIaBaxzj9KnMP6e9aMES/l8Mhv6pOOUo9Xgc/1yLDNmM63fHuuSG4Rt2Iq9h8bc6EG4uuyStQ5XQNqQoWkcvr5dcuxeT6zb2BBinN59NoX72I9zcb3/RdazPoMqc+84nqjd2m6MYOF6P76kJcetFE53NjUQsSH8m+XyXJU7qrFTYM2BrDOhjUjuvFnLiP6e/uN7qfZ9BjHe2W+enRGEuBXw68oo+57R1eM3Tg8XHM8jo8m4/U3Bip/w3dA94bTuuXntMZLipmaVmXXa+2XIxf5cqxPk+d2UsEg0qk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30dc2060-2a13-4700-7332-08ddd513b527
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 18:04:37.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNLf4+9ljbdzk8f/Td1NLIxiTOpgUzUBjsQgweX7S/r7a+xj0KnyVUUur3OyvMTCSet6ERNGIkqNffF2FGOdfzvh88fjrIz3jd2GDKGX8+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=988
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDExOCBTYWx0ZWRfXxOm5Rl7shMLt
 BEsDhIWlejRY5pLbu/X8rvdhk2+0zpF+d3FTckNZ1rLXsDSjFhWlQul5C0cKYouSd5q7MdxpcF6
 AMSMXiRlONPdaAUCQBvTSqByPqQkL70J82w4kp/tfYi4IzPFFqhHRKUHaUMb5ROLAaTaavmI7yr
 kiF0upJDYd76ehqGL46gQ5vCgmFou6w2RIJKznh8/gfHVPivWWsX6sOgt97vjx9U64RBLRWWF79
 +XQ3vGc0IG9YogKcO5u7NmO8A1lNs2j5nYdM3DEawGJMR7EPQOocv3gDlFvHIlV+NCGjVLo4Okx
 XdYXJKJrYjK0GMlnQczWj+AwayhCoQ3l8nQi0WntsWx1a1HGXrlgMn2O9qCLPmxvnQeZ6ttSQ02
 /cJOOx00y597kok2vgMSXaL3Z3qlGrOf1XEv/leiC5UMeYRjPIvvFP7wD9EbN8fm15TtBvAX
X-Authority-Analysis: v=2.4 cv=RtTFLDmK c=1 sm=1 tr=0 ts=6893993c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=j1kfFZs84iDPi44yYjwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QP29m6POTUSaLdEbS207jw2BxpFW0GrE
X-Proofpoint-GUID: QP29m6POTUSaLdEbS207jw2BxpFW0GrE

On Wed, Aug 06, 2025 at 08:59:03AM -0700, Suren Baghdasaryan wrote:
> Refactor struct proc_maps_private so that the fields used by PROCMAP_QUERY
> ioctl are moved into a separate structure. In the next patch this allows
> ioctl to reuse some of the functions used for reading /proc/pid/maps
> without using file->private_data. This prevents concurrent modification
> of file->private_data members by ioctl and /proc/pid/maps readers.
>
> The change is pure code refactoring and has no functional changes.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  fs/proc/internal.h   | 15 ++++++----
>  fs/proc/task_mmu.c   | 70 ++++++++++++++++++++++----------------------
>  fs/proc/task_nommu.c | 14 ++++-----
>  3 files changed, 52 insertions(+), 47 deletions(-)
>
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index e737401d7383..d1598576506c 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -378,16 +378,21 @@ extern void proc_self_init(void);
>   * task_[no]mmu.c
>   */
>  struct mem_size_stats;
> -struct proc_maps_private {
> -	struct inode *inode;
> -	struct task_struct *task;
> +
> +struct proc_maps_locking_ctx {

Decent name :)

>  	struct mm_struct *mm;
> -	struct vma_iterator iter;
> -	loff_t last_pos;
>  #ifdef CONFIG_PER_VMA_LOCK
>  	bool mmap_locked;
>  	struct vm_area_struct *locked_vma;
>  #endif
> +};
> +
> +struct proc_maps_private {
> +	struct inode *inode;
> +	struct task_struct *task;
> +	struct vma_iterator iter;
> +	loff_t last_pos;
> +	struct proc_maps_locking_ctx lock_ctx;
>  #ifdef CONFIG_NUMA
>  	struct mempolicy *task_mempolicy;
>  #endif

I was going to ask why we have these in internal.h, but then noticed we have to
have a nommu version of the task_mmu stuff for museum pieces and
why-do-they-exist arches, sigh.

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ee1e4ccd33bd..45134335e086 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -132,11 +132,11 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
>
>  #ifdef CONFIG_PER_VMA_LOCK
>
> -static void unlock_vma(struct proc_maps_private *priv)
> +static void unlock_vma(struct proc_maps_locking_ctx *lock_ctx)
>  {
> -	if (priv->locked_vma) {
> -		vma_end_read(priv->locked_vma);
> -		priv->locked_vma = NULL;
> +	if (lock_ctx->locked_vma) {
> +		vma_end_read(lock_ctx->locked_vma);
> +		lock_ctx->locked_vma = NULL;
>  	}
>  }
>
> @@ -151,14 +151,14 @@ static inline bool lock_vma_range(struct seq_file *m,
>  	 * walking the vma tree under rcu read protection.
>  	 */
>  	if (m->op != &proc_pid_maps_op) {
> -		if (mmap_read_lock_killable(priv->mm))
> +		if (mmap_read_lock_killable(priv->lock_ctx.mm))
>  			return false;
>
> -		priv->mmap_locked = true;
> +		priv->lock_ctx.mmap_locked = true;
>  	} else {
>  		rcu_read_lock();
> -		priv->locked_vma = NULL;
> -		priv->mmap_locked = false;
> +		priv->lock_ctx.locked_vma = NULL;
> +		priv->lock_ctx.mmap_locked = false;
>  	}
>
>  	return true;
> @@ -166,10 +166,10 @@ static inline bool lock_vma_range(struct seq_file *m,
>
>  static inline void unlock_vma_range(struct proc_maps_private *priv)
>  {

Not sure why we have unlock_vma() parameterised by proc_maps_locking_ctx but
this is parameerised by proc_maps_private?

Seems more consistent to have both parameterised by proc_maps_locking_ctx.

Maybe we'd want lock() forms this way too for consistency?

> -	if (priv->mmap_locked) {
> -		mmap_read_unlock(priv->mm);
> +	if (priv->lock_ctx.mmap_locked) {
> +		mmap_read_unlock(priv->lock_ctx.mm);
>  	} else {
> -		unlock_vma(priv);
> +		unlock_vma(&priv->lock_ctx);
>  		rcu_read_unlock();
>  	}
>  }
> @@ -179,13 +179,13 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
>  {
>  	struct vm_area_struct *vma;
>

We reference priv->lock_ctx 3 times here, either extract as helper var or pass
in direct perhaps?

> -	if (priv->mmap_locked)
> +	if (priv->lock_ctx.mmap_locked)
>  		return vma_next(&priv->iter);
>
> -	unlock_vma(priv);
> -	vma = lock_next_vma(priv->mm, &priv->iter, last_pos);
> +	unlock_vma(&priv->lock_ctx);
> +	vma = lock_next_vma(priv->lock_ctx.mm, &priv->iter, last_pos);
>  	if (!IS_ERR_OR_NULL(vma))
> -		priv->locked_vma = vma;
> +		priv->lock_ctx.locked_vma = vma;
>
>  	return vma;
>  }
> @@ -193,14 +193,14 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
>  static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
>  					 loff_t pos)
>  {

(Also)

We reference priv->lock_ctx 3 times here, either extract as helper var or pass
in direct perhaps?

> -	if (priv->mmap_locked)
> +	if (priv->lock_ctx.mmap_locked)
>  		return false;
>
>  	rcu_read_unlock();
> -	mmap_read_lock(priv->mm);
> +	mmap_read_lock(priv->lock_ctx.mm);
>  	/* Reinitialize the iterator after taking mmap_lock */
>  	vma_iter_set(&priv->iter, pos);
> -	priv->mmap_locked = true;
> +	priv->lock_ctx.mmap_locked = true;
>
>  	return true;
>  }
> @@ -210,12 +210,12 @@ static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
>  static inline bool lock_vma_range(struct seq_file *m,
>  				  struct proc_maps_private *priv)
>  {
> -	return mmap_read_lock_killable(priv->mm) == 0;
> +	return mmap_read_lock_killable(priv->lock_ctx.mm) == 0;
>  }
>
>  static inline void unlock_vma_range(struct proc_maps_private *priv)
>  {
> -	mmap_read_unlock(priv->mm);
> +	mmap_read_unlock(priv->lock_ctx.mm);
>  }
>
>  static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
> @@ -258,7 +258,7 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
>  		*ppos = vma->vm_end;
>  	} else {
>  		*ppos = SENTINEL_VMA_GATE;
> -		vma = get_gate_vma(priv->mm);
> +		vma = get_gate_vma(priv->lock_ctx.mm);
>  	}
>
>  	return vma;
> @@ -278,7 +278,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  	if (!priv->task)
>  		return ERR_PTR(-ESRCH);
>
> -	mm = priv->mm;
> +	mm = priv->lock_ctx.mm;
>  	if (!mm || !mmget_not_zero(mm)) {
>  		put_task_struct(priv->task);
>  		priv->task = NULL;
> @@ -318,7 +318,7 @@ static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
>  static void m_stop(struct seq_file *m, void *v)
>  {
>  	struct proc_maps_private *priv = m->private;
> -	struct mm_struct *mm = priv->mm;
> +	struct mm_struct *mm = priv->lock_ctx.mm;
>
>  	if (!priv->task)
>  		return;
> @@ -339,9 +339,9 @@ static int proc_maps_open(struct inode *inode, struct file *file,
>  		return -ENOMEM;
>
>  	priv->inode = inode;
> -	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
> -	if (IS_ERR_OR_NULL(priv->mm)) {
> -		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> +	priv->lock_ctx.mm = proc_mem_open(inode, PTRACE_MODE_READ);
> +	if (IS_ERR_OR_NULL(priv->lock_ctx.mm)) {
> +		int err = priv->lock_ctx.mm ? PTR_ERR(priv->lock_ctx.mm) : -ESRCH;
>
>  		seq_release_private(inode, file);
>  		return err;
> @@ -355,8 +355,8 @@ static int proc_map_release(struct inode *inode, struct file *file)
>  	struct seq_file *seq = file->private_data;
>  	struct proc_maps_private *priv = seq->private;
>
> -	if (priv->mm)
> -		mmdrop(priv->mm);
> +	if (priv->lock_ctx.mm)
> +		mmdrop(priv->lock_ctx.mm);
>
>  	return seq_release_private(inode, file);
>  }
> @@ -610,7 +610,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	if (!!karg.build_id_size != !!karg.build_id_addr)
>  		return -EINVAL;
>
> -	mm = priv->mm;
> +	mm = priv->lock_ctx.mm;
>  	if (!mm || !mmget_not_zero(mm))
>  		return -ESRCH;
>
> @@ -1311,7 +1311,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  {
>  	struct proc_maps_private *priv = m->private;
>  	struct mem_size_stats mss = {};
> -	struct mm_struct *mm = priv->mm;
> +	struct mm_struct *mm = priv->lock_ctx.mm;

Nit, but maybe add a

	struct proc_maps_locking_ctx *lock_ctx = priv->lock_ctx;

Here to reduce 'priv->lock_ctx' stuff?

>  	struct vm_area_struct *vma;
>  	unsigned long vma_start = 0, last_vma_end = 0;
>  	int ret = 0;
> @@ -1456,9 +1456,9 @@ static int smaps_rollup_open(struct inode *inode, struct file *file)
>  		goto out_free;
>
>  	priv->inode = inode;
> -	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
> -	if (IS_ERR_OR_NULL(priv->mm)) {
> -		ret = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> +	priv->lock_ctx.mm = proc_mem_open(inode, PTRACE_MODE_READ);
> +	if (IS_ERR_OR_NULL(priv->lock_ctx.mm)) {
> +		ret = priv->lock_ctx.mm ? PTR_ERR(priv->lock_ctx.mm) : -ESRCH;
>
>  		single_release(inode, file);
>  		goto out_free;
> @@ -1476,8 +1476,8 @@ static int smaps_rollup_release(struct inode *inode, struct file *file)
>  	struct seq_file *seq = file->private_data;
>  	struct proc_maps_private *priv = seq->private;
>
> -	if (priv->mm)
> -		mmdrop(priv->mm);
> +	if (priv->lock_ctx.mm)
> +		mmdrop(priv->lock_ctx.mm);
>
>  	kfree(priv);
>  	return single_release(inode, file);
> diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
> index 59bfd61d653a..d362919f4f68 100644
> --- a/fs/proc/task_nommu.c
> +++ b/fs/proc/task_nommu.c
> @@ -204,7 +204,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  	if (!priv->task)
>  		return ERR_PTR(-ESRCH);
>
> -	mm = priv->mm;
> +	mm = priv->lock_ctx.mm;
>  	if (!mm || !mmget_not_zero(mm)) {
>  		put_task_struct(priv->task);
>  		priv->task = NULL;
> @@ -226,7 +226,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  static void m_stop(struct seq_file *m, void *v)
>  {
>  	struct proc_maps_private *priv = m->private;
> -	struct mm_struct *mm = priv->mm;

(same as above, I reviewed this upsidedown :P)

NIT, but seems sensible to have a

	struct proc_maps_locking_ctx *lock_ctx = priv->lock_ctx;

Here so we can avoid the ugly 'priv->lock_ctx' stuff below.

> +	struct mm_struct *mm = priv->lock_ctx.mm;
>
>  	if (!priv->task)
>  		return;
> @@ -259,9 +259,9 @@ static int maps_open(struct inode *inode, struct file *file,
>  		return -ENOMEM;
>
>  	priv->inode = inode;
> -	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
> -	if (IS_ERR_OR_NULL(priv->mm)) {
> -		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> +	priv->lock_ctx.mm = proc_mem_open(inode, PTRACE_MODE_READ);
> +	if (IS_ERR_OR_NULL(priv->lock_ctx.mm)) {
> +		int err = priv->lock_ctx.mm ? PTR_ERR(priv->lock_ctx.mm) : -ESRCH;

>
>  		seq_release_private(inode, file);
>  		return err;
> @@ -276,8 +276,8 @@ static int map_release(struct inode *inode, struct file *file)
>  	struct seq_file *seq = file->private_data;
>  	struct proc_maps_private *priv = seq->private;
>
> -	if (priv->mm)
> -		mmdrop(priv->mm);
> +	if (priv->lock_ctx.mm)
> +		mmdrop(priv->lock_ctx.mm);
>
>  	return seq_release_private(inode, file);
>  }
> --
> 2.50.1.565.gc32cd1483b-goog
>

