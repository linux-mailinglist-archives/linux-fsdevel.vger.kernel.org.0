Return-Path: <linux-fsdevel+bounces-59939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A746B3F52F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8811A827BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 06:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5392E1F10;
	Tue,  2 Sep 2025 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vf2mEtME";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i3EETwrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDD72857CF
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793838; cv=fail; b=YhYBUiPydch60IsL5ui7tVSNLecIQGypqdztmVbg/49SGDjXZIrxwJUsCUHSuzgSPZT/GGHPxveOY0e7JP3LeQnaeVUw8Qm8dXlYmLXSdtTca81n3hhZy9TK7inTbOzqGoBHMKsCkHuB/ub9oTnmJnGIPVxx2nu2cfzMbiaUOwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793838; c=relaxed/simple;
	bh=eEQdGdZYgibi/pzff7U2K+Ut5ddVB7Pq9jvXo/eCYXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LrMTtxyRByOKOJ0SYYs7dkgRbs+fb4yx4ac2QaS/B6ZVtZ5WAUjoUfMzx8ipwzfCT8wYORCzQt/VfU7XCtltx/unNKUSn2qRvJ5dKiK3WuBALOoa6+WdKS9zO0yjNr7EMtIyed+DCYNJe0+1aCqQ2DZLWvQTQ8asV5b5Dr9kyRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vf2mEtME; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i3EETwrr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5824g0Pb007086;
	Tue, 2 Sep 2025 06:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XokZ36eiN4cd2tTQx6
	1hs0SrdYZRdX8hlQcVoMTfVxU=; b=Vf2mEtMElQJ0TbgQZ3PcmmFULeg1KsHAop
	BhOOcgHo+M2ZZckhNEBlO5Lng+oTKeYTb9gSh/YjOdgRMY5pipq+z/8ZOXJ+ZCNe
	54+el59ORLDpVPZz5kxJycaGDZfJHuwvNREf7kSeWjivnixuM/BS0hfwVmF13NOm
	I7rnxK5fiRj+nhXrPFaw0hZcuKtalq+Pf5EYjsuCfnIrxuRYaBGnI5s6jGrz/OCH
	owCSdcatbcd0/kG13eljvijL2fnfLr20XpqHNbjVeM3H/5/Xz4PV9CkCHTgd+D4Q
	FTirWDcae1p88KlowhyeBgnqCr+kebtcd7sj9mZ10UI/NZ+1cHfw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4js7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:17:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58236C5V011655;
	Tue, 2 Sep 2025 06:17:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrerbpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:17:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj6yUGxeW7mpIe4X2BpQgznZOZApOoTTVvNev1m5uRbsPQyBut3LBMLe8JlH2QJPKgXJoAihdmrYzCYoqsNY5R8a6cL4YvHDEznYIEYC8izmoLBc/Vc0OLz4EJiw1EUI2qKGCaTaUBO2XoitcvvRPMLl4VjR6zX7Pe8/s7w8oriEpbmZoiFaos6FtkFlzxzs30Nk9yDqwL86WZOZ3qNIAmeACEL2pls2FdqWo5R8q0WTJRnMAfGHqNXYat7KAoG6xtg7k/BDDIK+e1YbklEPd/SO2F404sQumifbwjhfJEegLwF5oMhPyCd9OAPgZRs2PLJCxLcsnaaBS4brxWhJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XokZ36eiN4cd2tTQx61hs0SrdYZRdX8hlQcVoMTfVxU=;
 b=ZEjGgZMmn07v03vWhIbTZuGYUFzOxA+cWa7OlsS3kh1OnVmGIxYEv22sB0VK9YeVgYwNugtlT9/Q4b+X7c90zMYe7gNTRzyiz+ITf7dGxiJ65jcagiM7U6JvF5A5RhaKs8Y5usEsvxPRZpHTs4i7+xY1jhQ0fkY7O0tO9QaO9iyj6RmsFoTESpf5pkAveb4wd1WvjkpuDGCbLG7DeA56fRDVqtWmaOhcXRwLvivQZNSBHImxEqOg17lazWijv8QJccPV1urrtcgKD/s7lZlgEuEDBzGRKtvEfQnIfEaL1J8XZDRB9+m1V6lpmSpmKzl8kGSm0jX1Ki7SBxa8nBaFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XokZ36eiN4cd2tTQx61hs0SrdYZRdX8hlQcVoMTfVxU=;
 b=i3EETwrru94c1w3plBQLyCtEWuCzHjN+h2SeS4GHvOCfOvbsOZvzyPNTc5fh7u6s9D4vK79r5FNZdmK97F9c+IGzYsMVpf88cLCUhpJUl/FYauX4MzJA80CxN/XqMx0n/Vcb3HwL8Z/XGR51UebFzI28RkNtBiQr4WLp4mYkIGA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 06:17:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:17:10 +0000
Date: Tue, 2 Sep 2025 07:17:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 11/12] mm: constify assert/test functions in mm.h
Message-ID: <75fa6c34-c972-4710-b37c-a03ae797465b@lucifer.local>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <20250901205021.3573313-12-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901205021.3573313-12-max.kellermann@ionos.com>
X-ClientProxiedBy: LO4P123CA0409.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bf114e-bdda-4924-d0e3-08dde9e859a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b7Dnub+1Wk9EFLiVW9EUK73ZBhax8RWwAqKf25DCAHlEa6VFyiSfGhaiXhco?=
 =?us-ascii?Q?Xx32725AaAs7E2yN7r6Dp9tqxqA/YrRk/eXtteDRNZu70comKoeUODMceqzS?=
 =?us-ascii?Q?nwccsJTJblXrT8UxAugKUhSi34OMEyO4xevxCllhNZih6N39fLs1V7Fqd8yH?=
 =?us-ascii?Q?zp8RnpFoLXQJMvCqI5Xcxpvn7zlgJGDQovPa7vrJuCvMggMgR8VtX0BYe6gf?=
 =?us-ascii?Q?+o82kIioWGFoYh65eI5g3+xaD7TMY+dQ+yTEYSnSo0RWrYQtLuFA43mOrzaW?=
 =?us-ascii?Q?Dxo+Yz4Ed5DvRjuv8vr/Uzx9fxNCs6OwyX0Yx9+oUvRE8+FcTRpurNXf/vO0?=
 =?us-ascii?Q?m/IbBatm0uA/yDDxgtf9dTRKduF2/dehjsSESgR/FbiuSX+2zzjtOTOiTTZ0?=
 =?us-ascii?Q?DrwDnGGx5gaIF7IToAsl7aBkiu0/ytSZPXnUkTRopEDHfu5qqaRvdhsT7JcL?=
 =?us-ascii?Q?GpZuQ1AkYfCUHnMaUdeISie9kyMF6ix7SOrYzJE1G4ijf1sineX7h0lzbqHt?=
 =?us-ascii?Q?uotCOzgnGDKEJvsHE7KgyeFWhEhBakv6uyohwa1tmt3lPknwlmQK2sY1YNbr?=
 =?us-ascii?Q?l1kGU5qQVSfN277PsYL2K3g4V2RpM3uF4Q7LOQ96+rCpLv4fNEJl2+p1UjlR?=
 =?us-ascii?Q?4FYbmGMi7Qnf8U7iKuPIMzdbE4rjhDsJig+EOmwFvymt4ogVIyuQ2h/aP8H/?=
 =?us-ascii?Q?GP/OJmG38K2hFdzU2vZpI8g1I29WSNdB0WeGMHo7BG7l1aLntS5zXIW2GnJy?=
 =?us-ascii?Q?ZpCZQ8wCehTe6Phnnp8Ren0f7iCk3xzR9ktA3JFjzZvEy/PA7shrh+wk2xnP?=
 =?us-ascii?Q?8PY1j5jMb87ujJVm8y2WXam3fTbLROGMpJ+hKp4QgITCp5eU1r0p0iEj+xij?=
 =?us-ascii?Q?XDzRp1720r7CmKkU/7ik/t5bhXGPVo5hOKlhbr/R4cryVxFx9NgLbzP7Pm92?=
 =?us-ascii?Q?/Ns5dZNl7neN/1X5Wn+xyQgyiv7L5T9J5t0+j6xWYK66N7l2EPjbbaVnp6wW?=
 =?us-ascii?Q?d5vn1MGxZmzXwkXEb0s7IkCtVDrtk4ZzwrnV66C9KwchjFspXV/ZdphOIyy/?=
 =?us-ascii?Q?CkM2VjbLFe+cnNBwFQuFAj73Y0ij7cmxAcOJ/wan/VkyWXoXRcG5Y5AwkF5r?=
 =?us-ascii?Q?IPyBhmJlch4UVrpk1dpBGquEzVW56/47q1hwYrp5BZdxapSM1RwXJKScFJ6o?=
 =?us-ascii?Q?a2xN84nJNYQXnkzDoqhcdtS+c+ZgqzVKq82R4WzrYs3MT3aeEXAZB3ngmold?=
 =?us-ascii?Q?592wE+W2Sgj/zuBFogBDI+obOpbno5N16uK8Q2nqwB8ZPooj98cbJABHv/zY?=
 =?us-ascii?Q?amXTvJC6bzIwuQif3/DSC+54VDvUO5m6e8KbIJmFWzmxkjem2GYcuidAgE7h?=
 =?us-ascii?Q?4H/IKKE5J28R7qEOT99szuyLxxAUJIn4rsPQk0xvxXKd+iEAkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oxCaNrfcbM0PO3SRFuDqOhYFg7ZzZ1RBMQOdeusJnyiDhK12uywiVj2RPy+y?=
 =?us-ascii?Q?rUYVkBGnw5rPRhP6t8R8J+nsaNOGD1tvf3F1mwyYshpS+y56TYo1lOYHMS1R?=
 =?us-ascii?Q?IcHVw9EoZx9ugnZw4HsmtuG6cBJXCgKQpVmUH2P9nTz18FPeLg/ELtR0MzbT?=
 =?us-ascii?Q?G3pOeO9uwrs9mp4ZRuzEccY/M7Y8WbHGlouMVHjV1Ol6R55GV7XjJ4yown/4?=
 =?us-ascii?Q?v0GhkKDMfyWCARcXH05Tdoxepa0z3ED6hAuHu+2loeJzm8DEYbpbXURJZSIo?=
 =?us-ascii?Q?BctU4fxzjysyEM/9T6E3aZ/bVsxhtX6+4ePuw+Vo8LXd7kjrdtFSjIPUhN1L?=
 =?us-ascii?Q?qPPcNhBA5PwmFfAo5rM37tCnTe4Y9KT7DcuGUUJSoAIENbC8GzfHbIaDVzka?=
 =?us-ascii?Q?E6107hM9MSzS+NNrCMJWbD3Sw3KLifOEzqT+iWLJSt+723OtnBc8qRBbkHUh?=
 =?us-ascii?Q?rVhVKjJOyt7nEQyQw4S0VHsTiWFHOClq1Pe/+FoCce+2pA0riwsPdBWFKnu8?=
 =?us-ascii?Q?G+Dn2IJt8pLm8VeK7k3hONAXY33ZwTraUYaEptG29AKqPoMsxzp2hrq6WrH2?=
 =?us-ascii?Q?hjs5MMLKOHmZXTKSkUAQpVMUqtaz9Xt9TmvL9BTFQU5Hi57LUtWj4nlGyiPw?=
 =?us-ascii?Q?XOFMVfSi6NP7FvVw3TrmO3Eq7q17ZbF14pYpdZuT3g13J/nz5STVyVbBWbrA?=
 =?us-ascii?Q?jE9HdgFNyllDiJpHjJvbPwZXLeG4Wwvt+udkxyUmMzTf3eSuOmXD8RUSAOZN?=
 =?us-ascii?Q?p9IZAOVrnPikuAkYcZnPiWIm13USF3yD6aQ+50mOlZVOtBeFWtwW7UuP5a4I?=
 =?us-ascii?Q?eOZBjGi0eeUmjxrdMXofV730IH+9r3AWSSgfr6Il4Gr2En7Ujj/XlHs9CcA3?=
 =?us-ascii?Q?koKz0/HsGvKVZYnJ6Y9j3fGtyS8H0KmOMeMhcIU/PhcV1hkiJCX5wLNDoMXp?=
 =?us-ascii?Q?UdnrZuS7yIsDg04pTpFUIgK/LsrY5ODk4kxZ9abFLmQTG4MbIaQS2QTtV18e?=
 =?us-ascii?Q?SLDtHYyY9U+NO4kunnri/kQ3mnkHIyVCCO8vO72gEdi4MPI82FcrdbPW5fLf?=
 =?us-ascii?Q?7BqXKRycj+aTBL1xk9MtwOm9Ad4bSj7MOIpEEeACBY41QI/qalhui6wqwW14?=
 =?us-ascii?Q?9Dd3olopGhm5gzcFAWqZUrK5FCiFnkqCDxBz5hqv6r4BYv9wRHZNAGA6xf2b?=
 =?us-ascii?Q?OKtLRdc1k4Ae3Xj0d3+PWjqYMANaKFKh8apI/CuhSpygxqujkOxdgbks8TiV?=
 =?us-ascii?Q?YUv0TKjtBAIsxB8aYe9bYgOvxF3Otwyg7aTW0xe9aNpj4+/wSiONGZmQltE2?=
 =?us-ascii?Q?WjGr/OWNrZ8HHe/xIMahMx28ki0NjoUYXUrqGM6d8GaoI+t2RCmIqOMHPfZd?=
 =?us-ascii?Q?dL7S4WBRCrelQqKnZkxi+ckSIaqV63K0QwiEuWMvkSaJ5EADf6uiTI66hx9a?=
 =?us-ascii?Q?gp/yUB6XpJMbDdse+f9gI1jYJEsl50F5ZACHxAJpZvk1fhdSDzui65V54GXo?=
 =?us-ascii?Q?NHtmct8PuhW196rwgY/6Ppkg7H+O5tpxrGz8AoenndouTU3y1BeR9F4FpGma?=
 =?us-ascii?Q?3/3S2SCoOVRPymFmQV67JnCYcayQbmvSKNRON4pCWzAm//DymrN+BTdTyvrE?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vt5u+GSGYruw665JRJqSVKOvZnHAMjjCvPQvGCtCSApA8esSiWItbT3LQ/D2EcctYJdUbCIBj6tARslFNY/j/KZo911ZWaeCpteIH6OXjXfP0DMdwQUg7Jojk4I18FHf+eKBfN3ZkvYGIKyqXb6xpT+mjzjzY/ThPqqbhIDyDYKSQ+fD/xZbvgHNCuK052BHdUVBbtWn4/CbhI3UgI+srVESnID5eELxcxPomn7Voq6vHbJAgGxBArldlKQHT/En8h7/Zpdqu90LwzxcFiATHIFh90ZxUlhi9GT/vSx1Zx0Juq/VBQzO7TSwHfyUr6/UVx5AB1M92U2yqO4MkFy9N/5OBBbNM1mFdGQ+JiMtggSHq+0XhXOKYBmR9OdPyDs3ug2XG8heOIxa21Cq2jkT/Ntdzf0gbN6HFJ2mF3Sqie87vvkqeK1jZ2gnVS3DHBdf0MfVC9oBhgd7v0OdyrNsReWLhR8XOngD7ceDY9hWsBXhneoBX5FHPVqvayTnmq6p2WMC+QV6u8m+asvNBes7pwgIFOsHBs5JoDiasEjtuTlRz06LEz+15bsUgixYM47v8GPQ2pgpH2VC0ojPVEvenoijNu5usZT6TlLffyxV9dc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bf114e-bdda-4924-d0e3-08dde9e859a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:17:10.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWjZ0qZGYWAJUh4VU8W4hPE3vtI1s/61SZ9U59IZIIJN2kbz2AHXjA801lQ6Ho1cmqdn4oLDmWvu1qRFjy4hJ5CgPYVay1LdmV/Xwx1QYbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020060
X-Proofpoint-ORIG-GUID: CZZmqA8dYUSI_0vsu36ukBKJ1LcRUek-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfX4LxxQ4XIU0we
 +YfMRsortaKU0eKQgRmt8g1uRpVvumMFZFM1heMTGiRC3Ln0SjXJWRKVa8PFPsv7iHCyLfYC//g
 Ykba7AcSON2X1RUaATUpeQGRBaN4f1QhvTLMEXk6lfxavzDY1+I0K/dt5SnuLZfmx1w9EsYPnp1
 zQ5WdEWp19ZP6HXAjJtEt9e4xP4fvrIUk0BY8IYplrgm4jQ0WH5o3DWN427ZhCzLp14AvwUckrK
 kiVXpt57UMqx3VU4brrgmBoDjC8c8WEKBi4XW3faRK0r0PWUd/bPPTTDsJvysc9ONpGTQKP8rzx
 AQKqDKp/rUOe3uACSa/QtXf2kf9yqBClVOQ1Z5acVxTNRFIA3Kf1+xIZmJoeo+yBcX4Pm74d0+K
 n3MV78Ao4zx7Io0md/caLiyqKLlXcg==
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b68beb b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=yPCof4ZbAAAA:8
 a=pA8CFdUwdwjoRa51m-wA:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22 cc=ntf
 awl=host:12068
X-Proofpoint-GUID: CZZmqA8dYUSI_0vsu36ukBKJ1LcRUek-

On Mon, Sep 01, 2025 at 10:50:20PM +0200, Max Kellermann wrote:
> For improved const-correctness.
>
> We select certain assert and test functions which either invoke each
> other, functions that are already const-ified, or no further
> functions.
>
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 23864c3519d6..c3767688771c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -703,7 +703,7 @@ static inline void release_fault_lock(struct vm_fault *vmf)
>  		mmap_read_unlock(vmf->vma->vm_mm);
>  }
>
> -static inline void assert_fault_locked(struct vm_fault *vmf)
> +static inline void assert_fault_locked(const struct vm_fault *vmf)
>  {
>  	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
>  		vma_assert_locked(vmf->vma);
> @@ -716,7 +716,7 @@ static inline void release_fault_lock(struct vm_fault *vmf)
>  	mmap_read_unlock(vmf->vma->vm_mm);
>  }
>
> -static inline void assert_fault_locked(struct vm_fault *vmf)
> +static inline void assert_fault_locked(const struct vm_fault *vmf)
>  {
>  	mmap_assert_locked(vmf->vma->vm_mm);
>  }
> @@ -859,7 +859,7 @@ static inline bool vma_is_initial_stack(const struct vm_area_struct *vma)
>  		vma->vm_end >= vma->vm_mm->start_stack;
>  }
>
> -static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
> +static inline bool vma_is_temporary_stack(const struct vm_area_struct *vma)
>  {
>  	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
>
> @@ -873,7 +873,7 @@ static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
>  	return false;
>  }
>
> -static inline bool vma_is_foreign(struct vm_area_struct *vma)
> +static inline bool vma_is_foreign(const struct vm_area_struct *vma)
>  {
>  	if (!current->mm)
>  		return true;
> @@ -884,7 +884,7 @@ static inline bool vma_is_foreign(struct vm_area_struct *vma)
>  	return false;
>  }
>
> -static inline bool vma_is_accessible(struct vm_area_struct *vma)
> +static inline bool vma_is_accessible(const struct vm_area_struct *vma)
>  {
>  	return vma->vm_flags & VM_ACCESS_FLAGS;
>  }
> @@ -895,7 +895,7 @@ static inline bool is_shared_maywrite(vm_flags_t vm_flags)
>  		(VM_SHARED | VM_MAYWRITE);
>  }
>
> -static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
> +static inline bool vma_is_shared_maywrite(const struct vm_area_struct *vma)
>  {
>  	return is_shared_maywrite(vma->vm_flags);
>  }
> @@ -1839,7 +1839,7 @@ static inline struct folio *pfn_folio(unsigned long pfn)
>  }
>
>  #ifdef CONFIG_MMU
> -static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
> +static inline pte_t mk_pte(const struct page *page, pgprot_t pgprot)
>  {
>  	return pfn_pte(page_to_pfn(page), pgprot);
>  }
> @@ -1854,7 +1854,7 @@ static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
>   *
>   * Return: A page table entry suitable for mapping this folio.
>   */
> -static inline pte_t folio_mk_pte(struct folio *folio, pgprot_t pgprot)
> +static inline pte_t folio_mk_pte(const struct folio *folio, pgprot_t pgprot)
>  {
>  	return pfn_pte(folio_pfn(folio), pgprot);
>  }
> @@ -1870,7 +1870,7 @@ static inline pte_t folio_mk_pte(struct folio *folio, pgprot_t pgprot)
>   *
>   * Return: A page table entry suitable for mapping this folio.
>   */
> -static inline pmd_t folio_mk_pmd(struct folio *folio, pgprot_t pgprot)
> +static inline pmd_t folio_mk_pmd(const struct folio *folio, pgprot_t pgprot)
>  {
>  	return pmd_mkhuge(pfn_pmd(folio_pfn(folio), pgprot));
>  }
> @@ -1886,7 +1886,7 @@ static inline pmd_t folio_mk_pmd(struct folio *folio, pgprot_t pgprot)
>   *
>   * Return: A page table entry suitable for mapping this folio.
>   */
> -static inline pud_t folio_mk_pud(struct folio *folio, pgprot_t pgprot)
> +static inline pud_t folio_mk_pud(const struct folio *folio, pgprot_t pgprot)
>  {
>  	return pud_mkhuge(pfn_pud(folio_pfn(folio), pgprot));
>  }
> @@ -3488,7 +3488,7 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
>  	return mtree_load(&mm->mm_mt, addr);
>  }
>
> -static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
> +static inline unsigned long stack_guard_start_gap(const struct vm_area_struct *vma)
>  {
>  	if (vma->vm_flags & VM_GROWSDOWN)
>  		return stack_guard_gap;
> @@ -3500,7 +3500,7 @@ static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
>  	return 0;
>  }
>
> -static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
> +static inline unsigned long vm_start_gap(const struct vm_area_struct *vma)
>  {
>  	unsigned long gap = stack_guard_start_gap(vma);
>  	unsigned long vm_start = vma->vm_start;
> @@ -3511,7 +3511,7 @@ static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
>  	return vm_start;
>  }
>
> -static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
> +static inline unsigned long vm_end_gap(const struct vm_area_struct *vma)
>  {
>  	unsigned long vm_end = vma->vm_end;
>
> @@ -3523,7 +3523,7 @@ static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
>  	return vm_end;
>  }
>
> -static inline unsigned long vma_pages(struct vm_area_struct *vma)
> +static inline unsigned long vma_pages(const struct vm_area_struct *vma)
>  {
>  	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>  }
> @@ -3540,7 +3540,7 @@ static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
>  	return vma;
>  }
>
> -static inline bool range_in_vma(struct vm_area_struct *vma,
> +static inline bool range_in_vma(const struct vm_area_struct *vma,
>  				unsigned long start, unsigned long end)
>  {
>  	return (vma && vma->vm_start <= start && end <= vma->vm_end);
> @@ -3656,7 +3656,7 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
>   * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
>   * a (NUMA hinting) fault is required.
>   */
> -static inline bool gup_can_follow_protnone(struct vm_area_struct *vma,
> +static inline bool gup_can_follow_protnone(const struct vm_area_struct *vma,
>  					   unsigned int flags)
>  {
>  	/*
> @@ -3786,7 +3786,7 @@ static inline bool debug_guardpage_enabled(void)
>  	return static_branch_unlikely(&_debug_guardpage_enabled);
>  }
>
> -static inline bool page_is_guard(struct page *page)
> +static inline bool page_is_guard(const struct page *page)
>  {
>  	if (!debug_guardpage_enabled())
>  		return false;
> @@ -3817,7 +3817,7 @@ static inline void debug_pagealloc_map_pages(struct page *page, int numpages) {}
>  static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages) {}
>  static inline unsigned int debug_guardpage_minorder(void) { return 0; }
>  static inline bool debug_guardpage_enabled(void) { return false; }
> -static inline bool page_is_guard(struct page *page) { return false; }
> +static inline bool page_is_guard(const struct page *page) { return false; }
>  static inline bool set_page_guard(struct zone *zone, struct page *page,
>  			unsigned int order) { return false; }
>  static inline void clear_page_guard(struct zone *zone, struct page *page,
> @@ -3899,7 +3899,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
>  #endif
>
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
> +static inline unsigned long vmem_altmap_offset(const struct vmem_altmap *altmap)
>  {
>  	/* number of pfns from base where pfn_to_page() is valid */
>  	if (altmap)
> @@ -3913,7 +3913,7 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
>  	altmap->alloc -= nr_pfns;
>  }
>  #else
> -static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
> +static inline unsigned long vmem_altmap_offset(const struct vmem_altmap *altmap)
>  {
>  	return 0;
>  }
> --
> 2.47.2
>

