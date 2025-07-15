Return-Path: <linux-fsdevel+bounces-54983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3936B0615F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D84C1C4309E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2837120408A;
	Tue, 15 Jul 2025 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LgZStqb4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n8yRDLzF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620C1FBE87;
	Tue, 15 Jul 2025 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589805; cv=fail; b=KPC8fMZGOR21kFi3CfayFq9chaKOOd5Znx0v1Fyq0KIMA3TfKmeksa0R1lObLP2MzAynafVyQp3a2TqvrX5mPukF88B2Md5kmLBVmPu44WgdlAv/V7J3H6yXXt06SG5mwILMPWbW6z90FpzOZS2/fXtQC/Z5q+P3oC+96/+7RE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589805; c=relaxed/simple;
	bh=gw/+boOx+c3n3RsbkTz5tq+d9VVA+6xuCkoxpSaSiiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VdiXRLgCcS3Ledb43cP2LpgPYjzi1/JCEJE8oqBgm+7Ql47F0pFCZDjnAylP1Zv5qkI5wsDHmzBFBw6anUfMPPDU1hG++GJQWbjwRVsSVfc+TJoHgL+wIX2WGIMjAOWJdh+JSlBDYa3zdOuS9mqYTsPE6TYKv5hoAM3IZ4PR6OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LgZStqb4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n8yRDLzF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZZka004054;
	Tue, 15 Jul 2025 14:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Cd47mD82/fry9+/NR3
	WN4IIWHKyo0dBa3vx6Tf3rvQc=; b=LgZStqb4dBGDA8eQvB7Xw4Hx4Gl/p/8AaB
	uHyRtcG6qeKgml12G1sE9ierQ7tn2Lk94jwMqeiWmzoyNHRtZHHA4zu246H1mCAO
	ANxrLab6dJKNhcuulOiX8pvWe+bwCjybaUHYh1N2tZfsOhiYIEUJuRucSe9XdMlT
	7fq5aU5qYHxpbCIINp/W5UIw4YfXY1rYj0UXztA9EeTEDXKCVe/nVb28ZEeoOfh6
	Q+NaczHmt9BChx3X1AnUjntydDxt1UXFe09BR3N2XQ45n0HbmlrMqBBwSu7krt8X
	DhFLB4eXmpy0ch1pGxWhQn0UEepU41reaRBr+bG+6dIRQ0Mu4+/g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7y0k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:29:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FD65Nx023974;
	Tue, 15 Jul 2025 14:29:15 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a1qqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:29:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYOVq4tlZSVf9XEGGy1IOdj/u668vBBM+qHavi2e6uCR0qULIlO0fY3nlHqQizLw2BG19RKQ5BQ5FbfIAIR11CS7OnizDf0ZZfOqsqxYZ2jVTvGn9oXPEijSSzLzvGwohJnn8vkoVpqSx4ASvVrsEKq27+Vx5lWkPn+NbjpmJrOp4NVfoNsFNulKZiDcL5A3g98jVs8jvnRtoCYrubLx2CZmXM+6MBGz4e3+NV+zzknZF8FwCB4r8gMz0pOuKztmtdqt25XHB6qXNEdGEJzU4XT+82vTcdoiJr7QpxduCm8rTy9MoR95Gj7CCptm9yhlimSeLiSn2bWsk+10sfW3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cd47mD82/fry9+/NR3WN4IIWHKyo0dBa3vx6Tf3rvQc=;
 b=ogBsJ1vagtB87yfCVRCajkllLMK1No5AE4ndXQwJXLj2AE9xa13qlzq4e8IcM5gO1f9j6aD+q5UVqTs9Il+DdcAvA28jzee44XMKMoxHhCDNcxRK7V8tzz+tLnPVqaTEZQWhWyvMSneok1TIT8p0kK4xzTMVsVmUgiz3VX2/jHVPmCiCVICkp9QMd1qWSm9PS0AAdhP5CeAMQTW8VUHaR/70vo5U/LxYKLEqGTsl1ZjXOFqGMALTWu1CAg9k7A4m6jcZuRoT4NoeTNbGalsr6ph5dGOTkSOvfpiXjEJOkpmlcOYFHK8ZCwJaIuI7o/NpZOk4A8jsOYrgHji3MhOFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd47mD82/fry9+/NR3WN4IIWHKyo0dBa3vx6Tf3rvQc=;
 b=n8yRDLzFUX5pKv7QDmDCxo0QFWaghWc0Mm88r78o6x0T/Qqrvx2Z9N64y4EcoRXRJ5AA56GEY9B//TAMkWtjNH0qTAX4hjsr2Dub3ImwbSbCkqytQ+QyxFWPY+JcUkLp7OJCpJwDPkpnvmjq4Yt8mn4T52Bh43FC6O3nfLn7xWY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 14:29:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 14:29:12 +0000
Date: Tue, 15 Jul 2025 15:29:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
        gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 2/5] huge_memory: add
 huge_zero_page_shrinker_(init|exit) function
Message-ID: <762c0b08-f5a5-4e76-8203-70514de6b5c8@lucifer.local>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-3-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707142319.319642-3-kernel@pankajraghav.com>
X-ClientProxiedBy: LO4P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb684bb-b9a6-4937-7aa5-08ddc3abf7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1UrL0UIrCgK6cGFuEK1rp3aN5bElV7OJHEs+lp0k9leOJ4LXq6r/UW+4GHkA?=
 =?us-ascii?Q?GAzfqox7vT6VIGmcCprPp3yk0GzFraLvFrinRwgphcgXVETQa8+L2AeulayZ?=
 =?us-ascii?Q?MNwyy27gSkpP0af2fnwxd0wGsJiEEZUZd07KL32+Y+S3DnfDFUCC0sP4/vGZ?=
 =?us-ascii?Q?tBHbOt6Mog1DwpWpzkOCDwVy2di/nK8cSDG9WnR1eM2aDHq4Hr53PPIEgOoU?=
 =?us-ascii?Q?JvbokztoBHaKIB/258ToaelkWrvG+wy+jybUVDLuId3fQbxbT26oIutdKLaQ?=
 =?us-ascii?Q?OZS4d5rrmvz4d9v0R/zuxzwxf6SRSf470a2LJu3o7NV1ugz9nJ3LkIJMdGyu?=
 =?us-ascii?Q?vjhcb6rsUK2GBhWgOUDk/b+h4OuRxyoGU59l5D5PykCEwHsWDOtJ+WioA4c+?=
 =?us-ascii?Q?Vf9I8TQub6c4eytPMZ5rmLcNr6o2i8HKEdcajabmdcp/LzDHR03jdHcBcQGo?=
 =?us-ascii?Q?l8luHI6DEUujzu30Zfc5IhoEhClNrtsEBvGI3Sf9XaeYxAjVVNBqn3ASlYu8?=
 =?us-ascii?Q?AAUE6Ah/H3paaZkZN/8//rSH7xP1FGOAyZxpxKENGc75dAul4dM+/VcSN4to?=
 =?us-ascii?Q?LhvLM/GI2xukHxY1uRzsKjK1//hT9PVyK+17qaNwI6i/cTDwiGa+jf/L5dbj?=
 =?us-ascii?Q?UBa0Km5R+cfoGeykhXGU6b5CLvYk40vFQz/iRq/o6B/ffYYhwfWnjAO4ONA2?=
 =?us-ascii?Q?QthYwJFY+/7rLh/dl/ZalxwYpM0KPYUgQyz3SGCN0wR0ImlMZDd07/4WIc10?=
 =?us-ascii?Q?0D3D70sNj4j7AOSlUPIao50O+/pIlifjl0ETns7fyZUZO5tZO7FXNXNK75mU?=
 =?us-ascii?Q?RYrWE2edtd7Z0jvSRAky5ULRzwZOAHLEw0ZKN1Rj3JzSc5ULHoiTCWPEba2w?=
 =?us-ascii?Q?iv4FvGw995f5oTpxmujDmIhoSLNQHgllIKGNFkHgWunwgUwoIWAu+jkvX83G?=
 =?us-ascii?Q?TzWi8ON7dQSG8hhi+/NO3xFxVQoF6cn+EMwpccJ4reVHlrb0VqEUWQgUvnjU?=
 =?us-ascii?Q?pRaLW1LCnOmzwn/QVFJlwXamADUsiDdW9GSAYXh1VtZl654WVXeLPn67JrdC?=
 =?us-ascii?Q?BMnSqHewPyJfwxwRwboBntbc5vkSCKJtF9RtDJcuoDzVdjPuN3/452CVXtAA?=
 =?us-ascii?Q?C4Nv/yltmQwVnihJzUaeGpik970oG/nSFhecJSQtKvqiIjN6SteLniZCZWJB?=
 =?us-ascii?Q?+VofnkdOPcAjfQaJk6PDIGqPJHqqWXEo+RWLwvgM3rCAAnnUfLutT907qr0H?=
 =?us-ascii?Q?MNhDAJLj7y3tZV6DR2pJBlM60wcXDQgeT9Dy/j90lJdcgk6I5V0TXNfUf68b?=
 =?us-ascii?Q?sk+j+DqfPzuilb9E9zBcprPz6GsLEMPyvlHHHP49BxJ1occePWHO/5yF70QA?=
 =?us-ascii?Q?gs35waMWCl0QiTCtmu0DHpXJdl3mtT0XCNpEyivDfEi5MdmQ2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T82CpRL7hQIOoPU45C5yeTwD7i4+M4hkmebXqN/Ndw0xrEy6HFN/z6QK1Gml?=
 =?us-ascii?Q?aui7hWxydIxMEary8/AU8sfsEdFlrodYCVPgfupFiV2J+J10wv7r+IGcedqz?=
 =?us-ascii?Q?prGJxCvBFbCGpNjuyMyXaFVoXkQ7+4P3jizbAIjfuS//Jkvt9sThKwiOUX8F?=
 =?us-ascii?Q?RNynRDboBqz/UwR6suZYMgyLseCE0roLLwZ/MkV/5xZfEk+u+d/UxHPOFHBl?=
 =?us-ascii?Q?QB1GSPCR4b8Y8jAhP0qFaCZ70qOcjuLArFaD9ddJXlB3wa2ql76mFPX09bjx?=
 =?us-ascii?Q?h2vvppleqv11gEhykXCZS6wPh5GN+hMnLfhVq/Vs9RMS280P7+oIQogsz2W1?=
 =?us-ascii?Q?9gHpLnavqlctyLJqTHLUeiOkyon8pKWMExKYg4YIxpNJavTQ7xoEYrEGifSU?=
 =?us-ascii?Q?FOQRgDm9tWRCndF085uoxO+pBPZVSYPhGHFDGW7fBStdeDIgDr/8zETelXSf?=
 =?us-ascii?Q?69T7VDlV5juujli5lhmR2xBWgmxtrF1T/PvAr50ihm/bCs9LdCUVd5I0s2+k?=
 =?us-ascii?Q?x4gu6qwBFjRmmGojdl6mp2/W2ItvZHrtaZMeM4rg+EevStqPOc+6r99rYOcz?=
 =?us-ascii?Q?nD7RHR6RJ/EsNWcj1MeYmOiF5eYLgW5unJICuDRUsv4sb1vFtP5vBfoLzkmC?=
 =?us-ascii?Q?Yqij5d4Y/M/sv2xHqhmxEl1DqlKDyg//n2f9z4BqfyxJHOlc9wsJddgsHGlr?=
 =?us-ascii?Q?nNwZMV22QiDJFWFThkOIRt/mzoTvYWQFbUG4waSoIoA6tqGQmArJCzI/MJNF?=
 =?us-ascii?Q?xoI0MSTJubRWFvhVhe+ALdDWkcY/oLl0TEFIhAGP2N1XIEadLbT0kCwb+Ttz?=
 =?us-ascii?Q?j+M7wmDN6gsdqjEd03aKMmBSrcSPohZH3lOZwAzHXiPzW4VM5gJr8SVBYiHB?=
 =?us-ascii?Q?eHV0PA5E2romq7GgLAJS5pCyaoikcVZrrx8PDUsBkCWEl+s9jXHwoTMXshU7?=
 =?us-ascii?Q?B+dHjTFV4aalqHIC9PE5tazri1iI+TJu+4p0o0+6BzzHxXn3SNvXiPuMYBld?=
 =?us-ascii?Q?lYdc54NAeGoaTClg4+nDXrYO1N3KKDhWA5mJgqF2igQpZyD0/SeWQaFr6HNP?=
 =?us-ascii?Q?IQxQXXV8tlKcxB0uVkxoyNVKQ5WGr/omV1/w3rm0BISNyYWomLLz2MOvY8m/?=
 =?us-ascii?Q?sv4gFRevyF/xVeW0a/7PRLLRjjWKtUAtWO4sWCOMfosL+LUGlAjsmS9kAf+T?=
 =?us-ascii?Q?pttF84SUalRq6pBIoEASMev5SFpdivmP6w6NZNFIYlJRfQKl8yV6u7mkZxU2?=
 =?us-ascii?Q?W1Xi7su3bieHik90i4IiDeVF8fwmFIK45r8txH7edVD0ztpdp0NMq+NvGhSH?=
 =?us-ascii?Q?s7sJvqtUqXv1tEMF8icCRT63fbHjnzoSJp+rfEg7NOiARGX4fde61GgfZxtS?=
 =?us-ascii?Q?WrQ87m4mrW6pmepPPmfd2A6yJbWKNwqeMYq20YLZ9i+fjHRIo//4ehd4756E?=
 =?us-ascii?Q?7Nr9mgOIuPcQaw7+V1OA01CqVSQpiOlJy3bBH20w6VWgVBF2uk068qMC2Oxr?=
 =?us-ascii?Q?NPc+gGjlEReJ8uoWxEnKtNNSpbSsJ51h1eL6A0VjxeDRegS+hKoHgypv1woP?=
 =?us-ascii?Q?pAFOZZs1g8lLE+KNMvS3X5cAbZCI/K5xgOa7VuwA4gJzV7uOCZkIs1cF1jqU?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	obtQhNB0ObGuM/86ACEqbwhBknZjMmpo7Toib+ADA9N9Qh7QXkxQwTpFbtapdvKxeVH7YVUMbF8StIsy5/W9iyElWZucULZ3v1dVpirhJwK1k3bWvM6w0q02qUohJdfLbqKiOtdr8VNfnGErpjSS1L2RGDu0pJAh/t+j9tWzKdKTTEpd1WGYVrZM/3xWfk8O/ARPGE/D87jZ3RGkwZ92qeJ83HOj+Iv4BBH8lfHjtWd35lrpT4qv2AGB0UuvlT/a2go/2MSMwjrMMiMgKuQS3h9Kv+0n04BLfrQ4GNLvUkt8Oi01SUHhOSeMvl+dIOyCxATUidd8nflpyuqw2BBB1hiowbeDI1b+HgOz6ocqy0bO/bbv/6rsyNdzG4DbyNo4dYeFx0wZe6VByspeI/TYOyOqyRx9Z7ssRTLOPYsvqm+jFvPLwGnNHVjfqoT0JWeH9YFECFWj0V5qUiKM9aZHYX1SJo/+fo5rGpSWb0ZUlqfhHb/tz3WNfyyC12d0Gt3XcBAV5z5xSQQVZM4tC/R66jijMlvw5Wky9vyWp9iUu1y6JuFM+6XJ042DWpk82YD5QG16D5EduTADBq9EWJkETTPDaHim+rLRNHsm8CznDRE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb684bb-b9a6-4937-7aa5-08ddc3abf7c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:29:12.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miyTW5HmoXmu8SOJsRYbi0Uj5L7ZGsyJcD8H5gMpuChFex2cNd5mvMDmoMVFp6kV0PeN9s/jaoHw4rdgDbKt3tncC6SXokkJpNL5vF/zWjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150133
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=687665bc b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=hD80L64hAAAA:8 a=yPCof4ZbAAAA:8 a=xwYtO5t5E-HEfjGqImgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: W6q2SOKf7GGf912c9WXS2H_HLU10-vDa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMyBTYWx0ZWRfX1poP6+okrMoX 6pf+pI1sLQlrwfz45Ny9ztOf6yVU3flwQQ9NKeTYWZ0tkHxiBPc/IHFd2+9NBQ3RksdZWrOCsQ2 A88MWxUiYRFeaNXlVy1f1c8ug9+X2Eqofe+6sO+aGixAbql0SsPmE7SRC/CYYQiiuhrh56Nr0Ep
 lXS7B71cz6lXcVUgHpOmm5HOAnBfo6Jf+wtXZT86NnZgx6BGxdYSbz/Nxs8pEyDQ+qOMVLp61+U 7XKoRtNzj0oAYu896uqKUbhUl4ErmbYD6AEG+mcge5jp9b8HXXglZlPQQTXslQj0r1noCIHoHWq +sIHtOHKgeH1zKRZUOBBG99LurkIJUVz87TedwW9q7Wl/tWUTKX5aOJ0jYdN10ai1eMh+tVqBHc
 6p569sow4xj+DEi1uiAz311h8qkyqN6ObrdrPgdq3dkhAoCEI+e1bZToHvFMNNGAUHkoRNmL
X-Proofpoint-GUID: W6q2SOKf7GGf912c9WXS2H_HLU10-vDa

Nit on subject, function -> functions.

On Mon, Jul 07, 2025 at 04:23:16PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> Add huge_zero_page_shrinker_init() and huge_zero_page_shrinker_exit().
> As shrinker will not be needed when static PMD zero page is enabled,
> these two functions can be a no-op.
>
> This is a preparation patch for static PMD zero page. No functional
> changes.

This is nitty stuff, but I think this is a little unclear, maybe something
like:

	We will soon be determining whether to use a shrinker depending on
	whether a static PMD zero page is available, therefore abstract out
	shrink initialisation and teardown such that we can more easily
	handle both the shrinker and static PMD zero page cases.

>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Other than nits, this LGTM, so with those addressed:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d3e66136e41a..101b67ab2eb6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -289,6 +289,24 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
>  }
>
>  static struct shrinker *huge_zero_page_shrinker;
> +static int huge_zero_page_shrinker_init(void)
> +{
> +	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
> +	if (!huge_zero_page_shrinker)
> +		return -ENOMEM;
> +
> +	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
> +	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
> +	shrinker_register(huge_zero_page_shrinker);
> +	return 0;
> +}
> +
> +static void huge_zero_page_shrinker_exit(void)
> +{
> +	shrinker_free(huge_zero_page_shrinker);
> +	return;
> +}
> +
>
>  #ifdef CONFIG_SYSFS
>  static ssize_t enabled_show(struct kobject *kobj,
> @@ -850,33 +868,31 @@ static inline void hugepage_exit_sysfs(struct kobject *hugepage_kobj)
>
>  static int __init thp_shrinker_init(void)
>  {
> -	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
> -	if (!huge_zero_page_shrinker)
> -		return -ENOMEM;
> +	int ret = 0;

Kinda no point in initialising to zero, unless...

>
>  	deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
>  						 SHRINKER_MEMCG_AWARE |
>  						 SHRINKER_NONSLAB,
>  						 "thp-deferred_split");
> -	if (!deferred_split_shrinker) {
> -		shrinker_free(huge_zero_page_shrinker);
> +	if (!deferred_split_shrinker)
>  		return -ENOMEM;
> -	}
> -
> -	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
> -	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
> -	shrinker_register(huge_zero_page_shrinker);
>
>  	deferred_split_shrinker->count_objects = deferred_split_count;
>  	deferred_split_shrinker->scan_objects = deferred_split_scan;
>  	shrinker_register(deferred_split_shrinker);
>
> +	ret = huge_zero_page_shrinker_init();
> +	if (ret) {
> +		shrinker_free(deferred_split_shrinker);
> +		return ret;
> +	}

... you change this to:

	if (ret)
		shrinker_free(deferred_split_shrinker);

	return ret;

But it's not a big deal. Maybe I'd rename ret -> err if you keep things as
they are (but don't init to 0).

> +
>  	return 0;
>  }
>
>  static void __init thp_shrinker_exit(void)
>  {
> -	shrinker_free(huge_zero_page_shrinker);
> +	huge_zero_page_shrinker_exit();
>  	shrinker_free(deferred_split_shrinker);
>  }
>
> --
> 2.49.0
>

