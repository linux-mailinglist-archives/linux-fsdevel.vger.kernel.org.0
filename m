Return-Path: <linux-fsdevel+bounces-57569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55C3B2393C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C4A171BA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EC12FE599;
	Tue, 12 Aug 2025 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TN3+SW4B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n7MDek2f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447DE282E1;
	Tue, 12 Aug 2025 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027874; cv=fail; b=qwmad1iCe6zmVSzve9OPNdPC3fvNdpyYfbwD415rdxFBGfSwlFCzoLCx/RS7hPC5DzZPJKmRX3hX3MC1yYz34DwXcyfqbq0p21fBTA1t5UiqgyxmVgZ0hGyNKJqbBnB2E7zDagyrpRGfVZtyD/dzBwtGxzLPqeX+mM+Blx6k3PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027874; c=relaxed/simple;
	bh=O9ecgwWj9EFptFEFNhRhKXg57ZUMzgTifrE4vIMWXN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ecdzEK/VlDvEM1LhrKorRwm0ta73pL7aJiEKvKTkjDOkHM57X7b+vQ28gkBoao63+6fE71Th4dxHuEjRcu1S+JFQLaAcRk8bboz01dabUZRwx7z8pQg1n6s1QA/Gb1DH1874nj9wHmYSJHtny69kFqKHS0wHi5SLyGMxB0jkAlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TN3+SW4B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n7MDek2f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CJC37i003305;
	Tue, 12 Aug 2025 19:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vC+cNKwnfXlOhdhIjE
	MvIyRCr6cTAm/bihqOKbqMuIo=; b=TN3+SW4BbKjqmcEx+x2cL2h5nmURGOTrp2
	bnsbrjSzXhFLICP0A/pojRNQUCcORCHAIYTtTeZ1hi9Q4uD6tLlQ0sQBfOCzl+Rc
	YJtuAhtY7dXwmdUUl6cUVDJd41rhS7Dz+lF1eAqUbl3PIA00336wbIG+HIyqxBqN
	n+BS8GnlbRV7mvDyothnVI6Y+5qRTuvNHQq0Dz63dy7H3MROvEyGujdxUHp5xCqr
	GEGXv1UFrd0V0wvEHVMQBm/pVhAPQ21mkMr3ZTpsqL9r/ILs9idfAlOFpEO59bcb
	5Nm/9UtgH71WM+grd000y4M845/2TMBQT1YjWHcW7WNph5MZQpfQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf5m02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 19:43:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CIi4SK009833;
	Tue, 12 Aug 2025 19:43:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgqm85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 19:43:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIiWHiEXy+ezadNwVaOtTHWGeoaqcNIl7oPLvIdubZpvW82atG4xMaYn5wCDinOISGhLu2w7BSMAfRWylDAj8B8h9/4F1bSmP9QwIJmL3d6Odo9XkKHj3IwHHaA7m1GqV3i81Ass4Y5pH4jNP0KJjhl1d0xV6THbFBhMdtLZXmjPeF6RG49wEhg19BXypRFp1BC3Aa5J8D/5LpKgmt4iYvJ/kmHLeqiyEyuHiVLmPt/E6RmBd7mH9U29bEsFG+cRizPohqwkQMDCMeF/KsOKtjlKo6N4LIwsmWiBbA8PFyscuLl9Ce9iTUMf/Lp+0/8n7wdRYrHgSqiX30+K3ya5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC+cNKwnfXlOhdhIjEMvIyRCr6cTAm/bihqOKbqMuIo=;
 b=P10RuFwObVTrDJ+EMpXZUZk3iboBqnI+78gHVZKEIOKofzOQ+WKOt5LWezbucT8Cv+ZF775uVwmOCYrijTZKNThmj2KWIfUs5oWlbDgtR+92ctOfS2D7Ubu6jRFVIu/gFcJkyqB+1Cd+qZ7ZoA7xOmxywajuCn5u7GJ6zcrqrld00b9Y4zWgLMsjWVE1CBh2QMsRx4lLTcXb+0bJJ2LzbTxe0b9KICwmTaHZ9ZeOPMj+iAGoS45wIa0XUoRLNIsupoCzMaFiu45GWiKPaWxtCpM7WEvAybN2nv5B/bk76m9GXoOSxwRdALGEbjM69M5iN8kGv2IbdqjLJca8/HDfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC+cNKwnfXlOhdhIjEMvIyRCr6cTAm/bihqOKbqMuIo=;
 b=n7MDek2fj75eBjwJwew+1m3M454Dbmqn0unjuVTMYhv7v+Tfz5UVvcnodTDXkLd13piDVl4HcEW/7mypDV0m7/1CY5mYE+GkR84GkSP8/iFLi/f3T0Mx6ZzHQGzcywGwtkJfvH3NQfT/FWZ1ItYlthjcQsog6JlNuEKTy2QDup0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 19:43:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 19:43:31 +0000
Date: Tue, 12 Aug 2025 20:43:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
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
        David Vrabel <david.vrabel@citrix.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v3 11/11] mm: rename vm_ops->find_special_page() to
 vm_ops->find_normal_page()
Message-ID: <77ed5b25-1a82-44b5-be67-698b9674547f@lucifer.local>
References: <20250811112631.759341-1-david@redhat.com>
 <20250811112631.759341-12-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811112631.759341-12-david@redhat.com>
X-ClientProxiedBy: GVZP280CA0076.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: b66055d1-a62d-4c30-62b2-08ddd9d8848f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4tCqJY6FFLzhEZFyPG/ICtr7ogd1l6C2aubIJn2uRYW8rplCUza5wzcSclaY?=
 =?us-ascii?Q?sdwNQ33mX2SlxF++ome3YUeNLUo0FO4zp1A+1tMGEBuOBnCyluadofAW+POC?=
 =?us-ascii?Q?o6SKy1p9Q4L6j9t59nlWVXubZSB3LgaXQt+dRPrdI8+LAzaVqYs3LNycy3yg?=
 =?us-ascii?Q?e8ut/Aod8pFCWWiKC0QFrgb0uBtKCz/hgczvlcYMumy69Be2uxVwb3GWircj?=
 =?us-ascii?Q?IUWjD5kKWSQXTAzEoaGVLKB9+Nt1gzFcwdB8tJa+UucL8e2OA4jm4b2YX9Jw?=
 =?us-ascii?Q?5UZ/SdlNzfDql3iQZjJhh6oQuEsCKioe34Zr9bo9PF7mRY2GOPVCBE9+naTF?=
 =?us-ascii?Q?FiGGcNXbDXaf/hS6SpRgn9uC03q5seWr0puW9hthiAodCkKospl6F4H/x4sa?=
 =?us-ascii?Q?DjOvOuJoQB8G22jaBnSUOIp2WE4all1PYU82eVuaSNppDUhrRRkaNyxchMF9?=
 =?us-ascii?Q?s3evuKr781d1nErOnA0qESdlFZcryiIr1APB5pxAcDzr2kDKEDmO8fg7f0tY?=
 =?us-ascii?Q?XEHPv/Ej/IDwhHvf0gS1uzDOqDoVZJnvZfak9f7q/YFpgfskETUiijlGjbmk?=
 =?us-ascii?Q?4wI1fmya/d898tNy4LusRmBWhHqmFUUE88rcNnG1b6nhr3cNl16iw/JIqs/i?=
 =?us-ascii?Q?AktvmMA44BnKlYeQ7/Jsb6MPQFLcqCAXokoMln4Bw4fXf8ERosgtAx2MLuGW?=
 =?us-ascii?Q?BvYEyjY8qz3V5B0x9WJEPxTySBzhfWnjfffhKcw74AxQ8BRHyMJpyT+cL+S3?=
 =?us-ascii?Q?dqHhFhoF/FfjravB461BvQIjoJPJL7QJVLykmV9ILGjq5MuEeKNg0VPh8TZf?=
 =?us-ascii?Q?US81ITPG8Zmf0fjTQnxdeTUd6R9ZIYAEaimgMSfwNpW70+3scWdH+dQtS3nR?=
 =?us-ascii?Q?p/5wopNTy7XzaBlhcfk/18ndUdpBQLc3CWAm6pNOTBP/vXZIfCXLGbvWjN5p?=
 =?us-ascii?Q?Tz71FJkyus568vLiuLx14513EwzDJ8oWStljb8irFC+DYXMJuPYBpmrDOsrw?=
 =?us-ascii?Q?gbYfIZkP1ghM9naIkrXYxpcskZDYKUyuY4gJbUdZXS3j4m3i/zwuPOWDcNB8?=
 =?us-ascii?Q?XGlDTZJlgZlSd2FVKRYk0biKjeCijyA5peJYet62VQkYsCGHX1mPj91s0DjK?=
 =?us-ascii?Q?O/VQRMnYBOKZOEjHiPrQ/LdOnESLnnieHF6pMr+30QFgCT68DNGRCMHrm/QY?=
 =?us-ascii?Q?i2BYSxAeZRJgF2/hjPwks8oz0bvqr71jRX9Dyr+HENAC/x2PTtlmEF+roKcI?=
 =?us-ascii?Q?mXtfW50/kOlFjmUGLk8jVeuX8hTbhEH+2IbVS/Z0fXGcZ/5wXsyCKaUxNubJ?=
 =?us-ascii?Q?4WYWTOGXNyWaze5Q1SmeF6wz73T2vRQuVw/ntHu+A1L/NqR8iEUeKdbbMAYS?=
 =?us-ascii?Q?GY4fd5KBkKRiTn25Bw/k7YONMx8xVV4iIn3u/xegW7SukS6vYtRgfWm0RvNx?=
 =?us-ascii?Q?aBZ8mu1EJ0k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xyQUVEQ9sPKWyZ6FncEJccIzDxX6TN7k0HYxdSaPn6TsUVp0g5MIkbbxDS0X?=
 =?us-ascii?Q?mI7lrTjTqilrSNohCYeN2CV8l81Om2SsIePF80JThloKGadVIrhAHxNgZKhi?=
 =?us-ascii?Q?ryRfHTmInCK19IhQ5TmHl/NJvtD61XFw4VWLyZKp6Tc5O9YdONmFXqTEY5bB?=
 =?us-ascii?Q?CDZSGc4aQ7Gu5aIKDLSwt58z1j96Fqc+5xBwicIjfZWM3SboqeiRGP9bNGVl?=
 =?us-ascii?Q?yt7xoKLiyOMl8aNklNB9dXLjKlKMIEnt5ZAiwN+exJEUzgDfSJV4PRIsPpnD?=
 =?us-ascii?Q?tB+1R9LNUbnZJQBZES0aiaaBWgmAYn61B7w0zm3g/yiRPTOFtJwP0gXJjDEv?=
 =?us-ascii?Q?xUEKi7oB74IAO9gHibmZzOtO7HqePXqlAgvlxpH0u8am1kemR/Q7CDCbXV8e?=
 =?us-ascii?Q?dbhbexUD/yzVHWamWAWqqi2JGO6shOpCeDvHtHE1l1VlbbzfJFfl5JqLPuYd?=
 =?us-ascii?Q?WjDWR4EbPATjRHR8cadjZ91OcPNe46ZXmZsyWmToTzVbzj0EE4xCr6+9Y2bt?=
 =?us-ascii?Q?tYLGipukc217YM9uxIIH4X03aezBb3baGfdOXxylDv84j4CO8GpwHPxYXINv?=
 =?us-ascii?Q?sKGMgKEFVZY4BsONg8oSQTdjPFdrredWxBiTc1zY2MCHuPTs1yG3VA9YKLp+?=
 =?us-ascii?Q?vAtByJVQYxyIXCXUdRrEaon8q/87eqD/hZoSnnrHlF5/HfdwYyXXNGZo4rdB?=
 =?us-ascii?Q?nKu9OlNE+pPRQx3Emd3V3E5Lvui6A5IeTx6XZiEtn3OliKZPqx+EsGFGk2PS?=
 =?us-ascii?Q?IBwInbGI1hHEsC41V+W2PON/kWSOq4xt3xr6ZLVGOvaynm3/fR9XEfH8TSeF?=
 =?us-ascii?Q?kiVzs20crazU2nGz038+wfvXs41lRrFqHkdZHljjrhjTAo5I14zJ4xwPuySp?=
 =?us-ascii?Q?hFZ3yp6Ly7zNCL/44xgqaA017pnxAuPCOZq7+Qk4ZaKNe34gYEoB4GiG5l4d?=
 =?us-ascii?Q?ofRSK3sgA8lB7aRBGR0rvAghXGIOLHB6LjznUEAlh6q3ZSNgRodnlw2sZX1S?=
 =?us-ascii?Q?HbQ0s5ZZ8g4Mx3dZv4u1ant33watBrYL75fRjhgMPWyryGAEfjG20L7ImLQU?=
 =?us-ascii?Q?d+uzCBfkrmyJLsVq66NrW/cjlmOoSyzHIt/lwMcA/mNGx/pEKkWJFM9zNeaF?=
 =?us-ascii?Q?mTzYB4P3L+bAHK2dhPSiwWVUtSTlhFiOS2fVdqeLU77MvOQcbFtudjQjXkSh?=
 =?us-ascii?Q?mKGpDBADRibTg2foWXF/01Pgk436k1yBajsvJ8x6SRICUsuBSdg1h0HPa1T5?=
 =?us-ascii?Q?QLvzceVVplve456janNZmN/2HnyoNBBpWqDs65dEoWv4ovZFsHI/eV5ZJZNb?=
 =?us-ascii?Q?B08IGNZ+RkYcuZJ3HihfdnXshpzl6sSerZj2jYJPLxVMz5HBQ0Bz/KsvNcqJ?=
 =?us-ascii?Q?1fVmYHeqBWttWWy9BtFoaD/bWvW2Z09osz6dh24hXgGCKe38yaYWbRJgsnUT?=
 =?us-ascii?Q?dDQ/KEi2j93Jvi+ZB7JZVjgg+GuGReOKu8MmAvZbHDtY10JOlaomTsnJX+04?=
 =?us-ascii?Q?ZDODJkMqqmj92C+Oan1BSbSXcFeEgDR/ZyWO8MlgfCCsReGzq92GifeXE0cL?=
 =?us-ascii?Q?4qEZmhxNYMI8lEeI5+WQ2LSGV6iZshJKNGzaAONUsfwPs7jIyrrwdm1ACS/5?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1RvRVFfXGFrdbIdYDBTQoaOtT8VB+UHrwGC0mE21+epfiG+wPsx67vL2awT0dvudVwaWzGHi/kTk2lsk5Qty2zKibsWr7QCgEQhrH8NIDcMVxjf4efp+DQ4euC0AVLXmaLGwNWRFkfYx92T6tjAL0t4dioVVlyn3qwfWAdY9PSeV/WS6U+ob0sJ79qYvj+aVA1S3boRkK356l3c26swpi/FhJZbnIaZjoKSG/PChcQt8p60NjYHrWiCsbvbUWul/B0sek1N2R+EG5kMRwZJSfEumJZQbzg7ceZjzA3519AOs0uWNctQfy8hlXv5TieKR48WkbNhkkZGs4clvXwJkGeZVD98MfcfIaTLjbNBggG6l7Wg46cpGj3B6//PKiulaQ9QIWtgdf8iQT64KQ87i4ia73WPbFfZtmAxVfZWD4Oo6SVQigIvL9dhqEMIxPRVlS7U4jb+c7IG6ri/Mc2ylPMZmLbF3398p22+Os1q+ZkObeVk7ZXTCbKtUVtrDZd8stMcM5l+FTrwtJR10fO9CRKG5+alNWJh46NCtyA1+RwIjQt5SCYLBKqvgrQCgcJpycIiKl/jMtp4zbdF0adcRkVR8jIUZmcJKjI8XMPoAjco=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66055d1-a62d-4c30-62b2-08ddd9d8848f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:43:31.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5U0LzY1neFDn6pp9C/BetH8YyXoLcyPlYbTvPPTG69ZXhwJZfxKsSEOI3XClVEDN749Okupo0r8rbkp6nVo49FTmzxS8vItrS2j7AEcHXq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120189
X-Proofpoint-GUID: 60Z0vjkLGIrZPgb25nhZCfbC_uANQV65
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE4OSBTYWx0ZWRfX9WlsKwndrOAm
 5l4Aj/wJRUaE9VWyZo+uCPG0zDBzCroKxdGlFKBckzhWcvAd310GCMAj+gOpO3Fk3rvh/nw4yBY
 h5Ux72xLxv36amyUX5LeZbDQacJfuZwDEA+W9jSNOa0JyzXi3dqhdGfwF/Ej7gGrcTFq1QT34tg
 QPgIn04W7ixeCYcEkSnk3tQ10+roAn1EBf9pmZJEkxnImlutrk97Riggqc2vts6PhWTNA4pyP8P
 9G/MLFp6Eu0IPxHDT44pUfkGwQnoImG5vJnpSSMPbKE9hcxxPDaSh68isBP4K5YraXKcMDJbdop
 VlYPN9Zb3P5QnIM/3sOoSLRKIhe55Gaf4GR6bL5xq7V8CdGI20m0tXoNWIdYJUqsy2SZq1pz6WH
 CjXOAFLyZpokNv+CLzHhySrAMkF44ashln+KR9y33YpqtcYBztHX6hO2pin3BDg10LUDzonF
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689b9969 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=tHz9FfFoAAAA:8 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=oG9WTLIYOA6OTJ5yO9QA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: 60Z0vjkLGIrZPgb25nhZCfbC_uANQV65

On Mon, Aug 11, 2025 at 01:26:31PM +0200, David Hildenbrand wrote:
> ... and hide it behind a kconfig option. There is really no need for
> any !xen code to perform this check.
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
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Oh I already reviewed it. But anyway, may as well say - THANKS fof this
it's great again :)

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
> index 1f21607656182..26f13b37c78e6 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -321,6 +321,7 @@ static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
>  	BUG_ON(pgnr >= map->count);
>  	pte_maddr = arbitrary_virt_to_machine(pte).maddr;
>
> +	/* Note: this will perform a pte_mkspecial() through the hypercall. */
>  	gnttab_set_map_op(&map->map_ops[pgnr], pte_maddr, flags,
>  			  map->grants[pgnr].ref,
>  			  map->grants[pgnr].domid);
> @@ -528,7 +529,7 @@ static void gntdev_vma_close(struct vm_area_struct *vma)
>  	gntdev_put_map(priv, map);
>  }
>
> -static struct page *gntdev_vma_find_special_page(struct vm_area_struct *vma,
> +static struct page *gntdev_vma_find_normal_page(struct vm_area_struct *vma,
>  						 unsigned long addr)
>  {
>  	struct gntdev_grant_map *map = vma->vm_private_data;
> @@ -539,7 +540,7 @@ static struct page *gntdev_vma_find_special_page(struct vm_area_struct *vma,
>  static const struct vm_operations_struct gntdev_vmops = {
>  	.open = gntdev_vma_open,
>  	.close = gntdev_vma_close,
> -	.find_special_page = gntdev_vma_find_special_page,
> +	.find_normal_page = gntdev_vma_find_normal_page,
>  };
>
>  /* ------------------------------------------------------------------ */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8ca7d2fa71343..3868ca1a25f9c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -657,13 +657,21 @@ struct vm_operations_struct {
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
> index e443fe8cd6cf2..59a04d0b2e272 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1381,6 +1381,8 @@ config PT_RECLAIM
>
>  	  Note: now only empty user PTE page table pages will be reclaimed.
>
> +config FIND_NORMAL_PAGE
> +	def_bool n
>
>  source "mm/damon/Kconfig"
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 6f806bf3cc994..002c28795d8b7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -639,6 +639,12 @@ static void print_bad_page_map(struct vm_area_struct *vma,
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
> @@ -679,8 +685,10 @@ static inline struct page *__vm_normal_page(struct vm_area_struct *vma,
>  {
>  	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
>  		if (unlikely(special)) {
> -			if (vma->vm_ops && vma->vm_ops->find_special_page)
> -				return vma->vm_ops->find_special_page(vma, addr);
> +#ifdef CONFIG_FIND_NORMAL_PAGE
> +			if (vma->vm_ops && vma->vm_ops->find_normal_page)
> +				return vma->vm_ops->find_normal_page(vma, addr);
> +#endif /* CONFIG_FIND_NORMAL_PAGE */
>  			if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>  				return NULL;
>  			if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 3639aa8dd2b06..cb1c2a8afe265 100644
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

