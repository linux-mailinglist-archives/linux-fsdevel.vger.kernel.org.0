Return-Path: <linux-fsdevel+bounces-55295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63486B09564
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 22:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1514E1C20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 20:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011C2223316;
	Thu, 17 Jul 2025 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EBsVVt+3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="agmug8V9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974EA223DE9;
	Thu, 17 Jul 2025 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782648; cv=fail; b=cnz9OLf/clsaw8Xtew5x8ZC6J1attAIR8w0OCHtXtw/Wqhi9mbZY/Y+2ElbCH4gfJXBu0y3bcUbt4fx1ZWVbiTuihXmGPto4nyenOtQhB4/LsvEcpWsV8/Oc6ACWxp1yKayuEcaaODVksoWLcVyKp6VCrvrBTDkkFCAKwkGBe4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782648; c=relaxed/simple;
	bh=dDJKM04QDp1xXkSZok8I+IopMdnDMP+vO01V/kq1v68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b9AwcXHi8+1I8MpXius471XsdD59mezxJSUcIgqhqmJAkjm39IkiQyhb31NMFAHYrb7qJiH7UQu5C352bY+Xn78NAnr7scHnbWV4/tiadqjgR11aEL4UeI/OkXVAAAdFsdCoIdJmFQeps2IHpmwhwKrffrQYZ5Gg4KPCqHpDuRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EBsVVt+3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=agmug8V9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJXnFZ014639;
	Thu, 17 Jul 2025 20:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BPmqIkFYa4DxTKgv8X
	wSshFpi+qeYU3CmTihr48sTaU=; b=EBsVVt+31y2rg6sTjPNoYT7NZBJbbsom1k
	Qg1SXEpIhCvDGaz0lQXJPllqU+y14rbjAp6Qcu+VF1bqSmYyxNHKx4R/vSOWmWyQ
	LJh+2koiSBD39+Wyor6/FjFq99VjnJbm1IH6dXfiMZzs7ZoH2Vax/T4K/r141Pz+
	XUQDK19WiZ3+TFOlb0RK7QweBlKCcyEJWp8qlsXjeQJgQ3nZ5pfKbPbA1BOgE3cF
	rp5oVTVujaDPZYwPbiYEt9aVEE7eoUJTZdK+tpetEox2019NBvXTTjWmiQSRDxKS
	YHodtkHeOsZnk0+i5miTaGw8xBwWIy8p10PwBp1ozqh3i3PhMGWg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfcf5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 20:03:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HIVAil030299;
	Thu, 17 Jul 2025 20:03:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5d56bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 20:03:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJQvCglQqgFSkCWITQ0Ztjpc7+dHF0GP1okMw+e5OmAFtizzeI4BpodQyo7LcoSNCnDAdNXGpryXCF9eYbQblZBR97o4GdbOrYMh3BDPIx1y6GOk251CosGwBSV5QObTwklBqdxwp4RzjwfGXsUKzyjN78hHkV6/52tlwkEan0waC7l9zWL1l0MpJQcZGq2rcChVoZd3zWPU7vwMG4+mxVUfBaWcL4iJJVrhPoOH7qKPbn81aRm5490o7Kj6ZWJy1jtolWzu7I5LoegmhmrCngbcdo77lm9g7r1AgEdZz2UpvmVEFRau+oslJvvh01//nbwtKB/tSv/0EPJd50/skQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPmqIkFYa4DxTKgv8XwSshFpi+qeYU3CmTihr48sTaU=;
 b=w5A9bX00QebSRkVfed7VHtoAYYC0XllJis6qHd7VQ+6feqSyPCOkkUuwSY/ykOqUv57c4JXUkFYi+I0ttifIE/JwWHKg3Id/rEh6LU/EdORAOBk7RB37uixb7Tp/7TmkfSBrW6YYTeNJoWmU7mFLRpnW8oxbStkVpIeWBwqFutQJBXy4Z/WDw3GDANiI+9T/CsNArokOohrGHtXYAm9o2vxHTbNxGISVsK6FNv+J6Nzaf6yfDL1GeLbtTnZFIj9mxv1+1ACJtnIiiM5CT1NaXvDekugOdym+GWz6TzUkP3fowFkSJ6gR6QzmXSfB3zQDPgIGN+B4189ozbo0mt7n0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPmqIkFYa4DxTKgv8XwSshFpi+qeYU3CmTihr48sTaU=;
 b=agmug8V9NMnggP2U6mpaIXwmO+j39uwC6+3nwjOqOxUtQ9/Y+ubFMsVtsWfPzi+Z/1pXQo+5+f0K0tKekhRzeLkXHyddJ1qdaFpV8VsUpBbOKk/id5kYQ/A97j9mFeYdALIFrdGlNZ0zGtBFgJckhxZ0UfFMQlHI987UzGxLxbE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB4823.namprd10.prod.outlook.com (2603:10b6:408:12d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 20:03:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 20:03:27 +0000
Date: Thu, 17 Jul 2025 21:03:24 +0100
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
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 8/9] mm: introduce and use vm_normal_page_pud()
Message-ID: <4750f39e-279b-4806-9eee-73f9fcc58187@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-9-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-9-david@redhat.com>
X-ClientProxiedBy: LO2P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB4823:EE_
X-MS-Office365-Filtering-Correlation-Id: d9645e33-b8a6-488f-f7c1-08ddc56cfe65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7+KragAeqx0FMSNkdaX1kUCGgoGqQwoToLJe5iS4F/tH5S9s/tJBPcUtIx0a?=
 =?us-ascii?Q?vCHXM42ZSCMorpZP90HiM+seSJ0SUYmQIYOK787/mqGR5KRqzSYpxvyx8NLY?=
 =?us-ascii?Q?xn824xhci6+9Hot+LJjfAuP4ylegOqN+qLZKQSigbQaIwlmkbcp4Z/UaYWLi?=
 =?us-ascii?Q?FEuFDionfiIix8m+0JeHYgrOCMlLl5kBMmr4bamihfmfrR9lzSi9Gqsvcm5y?=
 =?us-ascii?Q?JhmKiSgNQV1trMuZkc8g+a6TxbzhSXtRUVlqdhzuCfg5QbGsAfpjgXZdZKIw?=
 =?us-ascii?Q?Q25qcutyc4mI5XMOqKVPcQ0stCWGuQNnbv7V50GE3GE6p3wqyLR1D/oNPa51?=
 =?us-ascii?Q?eHXrIdHCjFlzvdwtUdjxwD6bhyWeSf7RCuATk/nXnBkeqH1f4f82Xeeu5YBG?=
 =?us-ascii?Q?93MhZEYt5Tm2jEIwwla69am+Bwh5/T9JeuZfkYsOOCzO2kjfJXyZXcl8t2vy?=
 =?us-ascii?Q?0GEiVrSa8vCHRhE2khDqelpmSO9Gzhtoifdekf+u6pE3rxdh42vB2cSfG5Ho?=
 =?us-ascii?Q?RNm/YbXjN1BZr4a64BrnUAVM/+tsCr6XV4i4JvS1vWEqoUwA5fMtvKrLqi7k?=
 =?us-ascii?Q?xWJl4UCn9+30r3L77OsUAHqS4tmw351y6Lzgym9mH8s4XdzsYgwyEw0hdn78?=
 =?us-ascii?Q?867MBKw1OJ7LvPGbrECCH4m0vTnGJDxprNqO3X8H1joQgbIP+Aa4ZHSILfwp?=
 =?us-ascii?Q?Wjzjdf/Nip30cSe7/LNL4eysf3cR+TMDNaMdKrMMHYRAGtQOYsRGi7td+Ix3?=
 =?us-ascii?Q?1ry53RF0RqoFL9WWImp6zRZfioUKQb5DeKhZROVaD3I6WEfHJ3+N8eiwu4vI?=
 =?us-ascii?Q?biomGABoSfPUrS+6ysaxl3Vx37dfRzuvxF0SsZUjSYtYye1slPqgVwLZxD9q?=
 =?us-ascii?Q?P+sUrJ838mt+ez5WTIO0UNJ1C+hAcBgX2wOeEGrMoteRmqvokNgwdlhXbItJ?=
 =?us-ascii?Q?wmC8CT1NmM9j7uwF6Oni3ky89zAws7S+V/91Ku1DF91PnSPR1mJl2rkGSGg9?=
 =?us-ascii?Q?iiX4g2gUo0Ef0lR3BTcEWzPosRTSTHiH9gjk/AdPe63aDWgms9NEEkWfYN5j?=
 =?us-ascii?Q?mJtc4Y2v98Jb+/tElebcPL4i95hzqk4RwNk4SLYH6E7A5MduAbF6/UzsYg3x?=
 =?us-ascii?Q?fdSQrAuOqTVgZJiJ9I7nVJFEprYGThiBnpYQEgiJbX4LWvSPbE7rg8KMZ9bc?=
 =?us-ascii?Q?7gHbkYXmRFsbP4u4F3tYcvj5GzO1KaioWW01qiAgrZ8+PrHQErkvxlDHGmSR?=
 =?us-ascii?Q?Cf7OyB691dWo0cEDX2wBcaHv05ECHN5QD2O/dRB89WzGfpiIzSK05D10QQS9?=
 =?us-ascii?Q?o/9R7MELSIILw+lsXzt3BbNW3RlNWu1fyR5b7VUj52fclQEbtFCwyBIouyzY?=
 =?us-ascii?Q?SF4JdOm7Ne7n0rdVetwUUrm/Kxi4PK+e3i8GQPKunObqHWQ+B3zoJ+whciRG?=
 =?us-ascii?Q?zEH3a/N2Psg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V6XvGjMvyNQaOGzxhBgSiE3om5A4ltQf1p9zPkLBFNI6d6JBryEwWFowWgXl?=
 =?us-ascii?Q?kp893DvW0N/CGtweTRHMsWboI5f6O/tdOal6y75RKXPVfHcICcPz10Oqm1DL?=
 =?us-ascii?Q?yVbE7D5YW+1xF8pkr+mwq+NjhouLixZdGcCZbHBWxuBxRh1oc0NI8CXFXEe1?=
 =?us-ascii?Q?tClgo1ro6K3K1rPwecrPsNXs1jV9iFhmHWuPxTpZ5Qy7SW38DFP34I+RGX4/?=
 =?us-ascii?Q?Z8MBf5YZTITM3s5PibeyhycSclFAjGWgAMyt+Ab3Lizvl35+KbC2YIOascZF?=
 =?us-ascii?Q?DsMlwKR9j31eIUj/uy1fA9yC4HJTljw8pvSthNA+YfcQISsFhVWkLq/hwO1I?=
 =?us-ascii?Q?Q1UTE3Xp2LBJyHAD2wNch8qzl9sX8PGGoyvPXyyT4Ci5rrWlK+C/Ql2uURbs?=
 =?us-ascii?Q?nqoad8pT5uQs8fLSNum1Ui87ljgF5L08rL8cwBEPSzXpi68hJjNmxZ6ulYCY?=
 =?us-ascii?Q?/zHfsshJ2ofNLf40X23FM40ixKbZ64iuExymtjD6tmN/AH4x4jpzlHG+Y4I/?=
 =?us-ascii?Q?VWYj997kkD0XOY+2Cz9luLPXbLXt5eKr9h3oSyZQFgHAEhN8n9bu1CQ+iLF+?=
 =?us-ascii?Q?p8OKZdDw16bxkPpGFNUXxDD0mUiGhfUH8ci1RzWZBwQsceQ0nCH9+ZOLHgYJ?=
 =?us-ascii?Q?MeD6HhggD4kSwOqDWoosOy/uVuBKXKA255ekQv/zrQ6q81phBfcyHmZ/mjnO?=
 =?us-ascii?Q?9VEyaI35ZrodoEoWcBLr/2Ibh8Y/dwtmM6gyUGefdKfFjAWoV8omOFiZz+N0?=
 =?us-ascii?Q?QrDpRlS9XSs2BRMsyGZRDdM5FBVRUSRMxXfo8wOF9neqDUuaceESvKCPohNm?=
 =?us-ascii?Q?PGYhShX3Ucfk5QY7dU9w7lVSjuYPh67k1+rPSbAwGW+cklYo0Shv+Nq1BpaK?=
 =?us-ascii?Q?fjLezDzYdE1QhMPD09nPyg/ee52CK+OjCYFpKaIHh8h+gtQsjbS7XpdMwlt+?=
 =?us-ascii?Q?FaZb41drVJREWPdORhn+79Nxjx4zhCZx5YlgmjlyhaTwJAdTQ9wB5JmhMsGZ?=
 =?us-ascii?Q?ZPYL7qCXEYZVXpuXCa6C3o9FlxViyCqs73jA/HrsmJwE0F2jPxmznwxZb16x?=
 =?us-ascii?Q?DokfdLd94KBOLwxwAZiLKe/Rm1QEFZVLIw6eGuj0XT39CGW06KSAdp1APm3L?=
 =?us-ascii?Q?B8lXqmW37m0CLlT9QoGh707GvAiMkAVw7SDhbjgzHIWoHYYPkWtqFsP5Jlmx?=
 =?us-ascii?Q?9ZVffZbKddHjs16vAY2lwckJ4K+5K3DifIf0PxZ4Pd/nADVBfvvFrVnNWiPj?=
 =?us-ascii?Q?nqYdXBT1PmJsrNhFDNbN7QRSpKVkUu+gnu58cT0STs2/bO1vsHLHF39FhBIH?=
 =?us-ascii?Q?4okDDVN58Y85hwczlxDoLwEFheqTHXZuXAbhr2OHmgvLWseJeIPMKOGtTXFy?=
 =?us-ascii?Q?EkK+hMk2XoQiraJPqn8HSbBTsaeIXllI4lan4rFvdFFUk3KfwLKEoiCrpG7B?=
 =?us-ascii?Q?0fLo0y2BLa0M8qU79nTXe8qW2onmJUbVJk5t1EvEj+sv2wlJWH5zHpN+YMPc?=
 =?us-ascii?Q?Rf1rc5GaXj81jaBdl4beSLv078FRMyBOYDh5+1YSKkTZnjUYd4iCEcDT5eTJ?=
 =?us-ascii?Q?5svg9H0aoL4Z/GCGmwVgFaxHgfZ5ZIKjb21MhIOd9lIF69Xw1lrqT47J62EE?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yjbGCamHIovXJQkuvfD95140CIxhM/1tfIAiTGiEV4GHAW8NGPgGd2dIBaHntS8KnIhFE8cr7oIKtdgDdYjCQXL3+1E/57m5EzYq0SRJwVvctxhynglfUs3WW01x1Wm7sA/yawtd3ZpH2BQ3o6Tcw7IJSQkwmkNkKohn02CQVTkeCVroIZd8cRgzMHqSmTZUsCeKGWld0anJugDG+GXqLjI9jM4aVgbvBiT05Wok1wYaF9wUMlfAszY2ehQ7GR2vE5SIdS47C3wnlVVbgUDj5c/xUKlBS0k8ZZYPdVon/Xo8mOSiMSGpnRlQZAXcQ/vuEAfhe0a+c6ecAj9oNiDi3utMc657lZUeaMBLFY+i8/jYbf/1WhaNOPDvgrCV5/heTWMbLsZSX179u1+jI2YE19KFgfNfp180fcekOzFoRCOviNOlcmtwRkOL2bchlc06FyoS3WrLhMsjYGqgB8yuZ8oB6tqRz5oj3K7cbavWOJkTM5ayZ2lsKo/Z/RIT+anXSJoPwdUWQIgBMye07S+Zmr7gQxeFzFGSLK9RyFGJAw8+5Chd2C3HjQtyWTJkvO1+dhSGbFPaF5/UWndzRxhsdHI7OTkCbw21VEX3tEdg36Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9645e33-b8a6-488f-f7c1-08ddc56cfe65
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 20:03:27.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxmZBjvmimSN+tdgTH9GPWqnXzjeYeqmw7jRv3d3A+GbY+0eBUkbmXbMvZBwMb5amMMqhbzy4X/uy/3YFlEddNPyh45FVrhYcKG4B1JHrfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507170177
X-Proofpoint-GUID: K4O2RgHUzsCTtWb3ndUf0gsBWLBpQKo9
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=68795713 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=_vYpphbN4_vJ8DAqhOgA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: K4O2RgHUzsCTtWb3ndUf0gsBWLBpQKo9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE3NyBTYWx0ZWRfX49V4FwNvX4JM OGXxnxbbvc8K+HTLxHjUVAYGlnop1Kj3TD313wMAAJNG4a9SYVoCTcUFizevSCNg9UxIcjWLFec lKJiRHx2aMdemMGGdOYcL38FAZ4dcBgaJoYaeqxj+9Yg3s1+kUReA8fP0UtinpOyJ4hjg+AiSTJ
 q3xoQJ4gcN77XBqpl4uVhXeHkkA0DpJRmWufQmBC6IH40Trn3Sva4arr5gnX1AIvRedO1W78mKy VURVceCBNDRMfUkfjJF3Fa57QK8eUPuwTZPBEEe4jMgljPpibO2K0MIb46iK2Yx/SkqxWx51HaY iF6jpFXLc7qrfOi1UesA0SXyINJwGYRWaXvEN47C4CGyD1r4aJHnA9xtkeL5Pnz/uiX6caJtLpK
 trfxLweB+Dlw9nCnUeiLgUQIaIgDY3Xj5VX9vmh2uTblQ7j72MMeDbHdq75Y1Af+5bBje5zs

On Thu, Jul 17, 2025 at 01:52:11PM +0200, David Hildenbrand wrote:
> Let's introduce vm_normal_page_pud(), which ends up being fairly simple
> because of our new common helpers and there not being a PUD-sized zero
> folio.
>
> Use vm_normal_page_pud() in folio_walk_start() to resolve a TODO,
> structuring the code like the other (pmd/pte) cases. Defer
> introducing vm_normal_folio_pud() until really used.

I mean fine :P but does anybody really use this?

>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Seems ok to me, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h |  2 ++
>  mm/memory.c        | 27 +++++++++++++++++++++++++++
>  mm/pagewalk.c      | 20 ++++++++++----------
>  3 files changed, 39 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index abc47f1f307fb..0eb991262fbbf 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2349,6 +2349,8 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
>  				  unsigned long addr, pmd_t pmd);
>  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>  				pmd_t pmd);
> +struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
> +		pud_t pud);
>
>  void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
>  		  unsigned long size);
> diff --git a/mm/memory.c b/mm/memory.c
> index c43ae5e4d7644..00a0d7ae3ba4a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -796,6 +796,33 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
>  		return page_folio(page);
>  	return NULL;
>  }
> +
> +/**
> + * vm_normal_page_pud() - Get the "struct page" associated with a PUD
> + * @vma: The VMA mapping the @pud.
> + * @addr: The address where the @pud is mapped.
> + * @pud: The PUD.
> + *
> + * Get the "struct page" associated with a PUD. See vm_normal_page_pfn()
> + * for details.
> + *
> + * Return: Returns the "struct page" if this is a "normal" mapping. Returns
> + *	   NULL if this is a "special" mapping.
> + */
> +struct page *vm_normal_page_pud(struct vm_area_struct *vma,
> +		unsigned long addr, pud_t pud)
> +{
> +	unsigned long pfn = pud_pfn(pud);
> +
> +	if (unlikely(pud_special(pud))) {
> +		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> +			return NULL;
> +
> +		print_bad_page_map(vma, addr, pud_val(pud), NULL);
> +		return NULL;
> +	}
> +	return vm_normal_page_pfn(vma, addr, pfn, pud_val(pud));
> +}
>  #endif
>
>  /**
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 648038247a8d2..c6753d370ff4e 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -902,23 +902,23 @@ struct folio *folio_walk_start(struct folio_walk *fw,
>  		fw->pudp = pudp;
>  		fw->pud = pud;
>
> -		/*
> -		 * TODO: FW_MIGRATION support for PUD migration entries
> -		 * once there are relevant users.
> -		 */
> -		if (!pud_present(pud) || pud_special(pud)) {
> +		if (pud_none(pud)) {
>  			spin_unlock(ptl);
>  			goto not_found;
> -		} else if (!pud_leaf(pud)) {
> +		} else if (pud_present(pud) && !pud_leaf(pud)) {
>  			spin_unlock(ptl);
>  			goto pmd_table;
> +		} else if (pud_present(pud)) {
> +			page = vm_normal_page_pud(vma, addr, pud);
> +			if (page)
> +				goto found;
>  		}
>  		/*
> -		 * TODO: vm_normal_page_pud() will be handy once we want to
> -		 * support PUD mappings in VM_PFNMAP|VM_MIXEDMAP VMAs.
> +		 * TODO: FW_MIGRATION support for PUD migration entries
> +		 * once there are relevant users.
>  		 */
> -		page = pud_page(pud);
> -		goto found;
> +		spin_unlock(ptl);
> +		goto not_found;
>  	}
>
>  pmd_table:
> --
> 2.50.1
>

