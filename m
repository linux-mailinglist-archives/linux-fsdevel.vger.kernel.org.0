Return-Path: <linux-fsdevel+bounces-55428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE59B0A464
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 14:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B280188DD3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2FC2DBF46;
	Fri, 18 Jul 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CjwURbBf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r/XN7axK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31121F4190;
	Fri, 18 Jul 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752842632; cv=fail; b=dwKi0ZrF7dXXaJZPkz3+oaJMrCGsdDows/Nor6sBIA8HJb8RHHF6iE2gyf99jRUnG1doMHIEgKxghUiQ1RweyD2YyZKH8LC9zccEda/iwyoAW3lD7yo6D86fxHTPw1ejZ3g24K+i3ee8T5t5OVBTMfBx2nv8jHUMzzns3F+5SiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752842632; c=relaxed/simple;
	bh=AFKwIjFF6nOrnWwRhK3Q/HQ4BNN8ECzlVnhqvfMnCS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bchD59boUeg/b6xy95NdAOht/0TnDLolCQ9OBxhw9qKHrnRiqFGLhvhUKRUCU+F2SEeJvPDRRI4gBDRT8yBzvOh/vs1MCEQNFloJ04ZBH/0NOeAj3TakgrZt/CdQGfzlo4eUmn3AAliyKeDx4Rl91TCkmt5yuDxFCUsQ6romY4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CjwURbBf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r/XN7axK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8fxkc029116;
	Fri, 18 Jul 2025 12:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vFgzdYPM7LzE4PNfxE
	PqeYxW64NBKFxNzTZGolft0us=; b=CjwURbBfnWDg6Kx8PHLyL5qjbzV8Nrk8Tr
	p73MU4UVDFvbapcnRPZoHaYF3ddmJOUep+oRrUFiKN39Vog/QwoSKc9sNwwaWpvG
	b8NyinHKlarseausNTcZHzoqh1YobaZqw9q1jvYh6QZ4BGo/5KF4ygmaZBu5T7zy
	3A03UIWUcGo5b3Wfphqyyl/x0D41z5c2WAzkF05VEz9i6LWEOYVIqnzDnJ17VD57
	VMQDZOO75SdOppAUw5K6jG0CO523vSTmPHIVPiKzj5q88Otama1YLJ77CTgTFdwp
	vyBXPoW+BW44ztupgtqtzO2CkCLTKqL02208wOoE2tI7dYnGVcjQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfdk3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 12:43:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ICFHoP024007;
	Fri, 18 Jul 2025 12:43:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dys6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 12:43:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yw6IiWyOa4mCRBV2n1TM6uySMs5RiPk3kX09rB3R30gK+xrCT5BiLHcp4lN5agGvdEJY214jwD/KuAzj/bRYGQhEvuvu9Hvt0UZ3CQXH6XmAAfY5As+L1Jxe8y2L7GtUy7GWXmboVwE/Kjc1bYPRF1P/+YVIMugMPXR5KmTjqXq7IZ+w8GyoXlTTyCBedIlbcpNgdttdmnA+eOvXNeTUFLsk+k9YwL1V5Nl0kTJcNxOhHF3/4kF2TDQ+6mDst06vUsPRw9/B5IJKnEzUXYnTvCZf5lS+d+kftgG9aH1Ug5Gw+cn02rpdRcc0DX2uzfB8Nojch0SQEnFyH1wbzCtYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFgzdYPM7LzE4PNfxEPqeYxW64NBKFxNzTZGolft0us=;
 b=ySErTJ7VnuN3+PLcygKCjUkTdQyRy72R/2oeWdgLLGORrVewp9tp0yLeC4AkMp8AebEf6WLagp6hjX/sVteWD++zfV6HXjJ6j7ek2LEv0P9j4QQ+kpqROwFJWgP1hdbkfhfqXHsK+tGu7VWLpdLnWtjhiSlO8V6zpVxFKqzbId1rDNGLPUsp9WwjQfG3pv7MsWX3dvegVvQv9S8wTgKhajhoHvcF5K3jGdk2rtkvhnFflUShFOPcB/+r9INXO2hoPVoWjrq0j6Fds9xjG7R0qcKoQOn/RpFolEdJZPj/3zj8DpjqiN8EymWxFGS7aKaQmDeM4tQsZaGRjerjDMKkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFgzdYPM7LzE4PNfxEPqeYxW64NBKFxNzTZGolft0us=;
 b=r/XN7axK4DCRc7JWyINd7LcFsAr2wMZnGnkgZq0kWnMfpZUP+7Q5AvAnZxfqL1vpg15/Sr5AmTPrDAKzr6eXuX3gBFqmU095Yv1QQWDdw50UGCViN9LMfBiN/C9kIxKLNd4GyB0VwMDG/iWs+JjMFm54Ke6RseZ/3Al/UW0MZsQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4210.namprd10.prod.outlook.com (2603:10b6:a03:201::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 12:43:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 12:43:09 +0000
Date: Fri, 18 Jul 2025 13:43:06 +0100
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
Subject: Re: [PATCH v2 7/9] mm/memory: factor out common code from
 vm_normal_page_*()
Message-ID: <eab1eb16-b99b-4d6b-9539-545d62ed1d5d@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-8-david@redhat.com>
 <1aef6483-18e6-463b-a197-34dd32dd6fbd@lucifer.local>
 <50190a14-78fb-4a4a-82fa-d7b887aa4754@lucifer.local>
 <b7457b96-2b78-4202-8380-4c7cd70767b9@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7457b96-2b78-4202-8380-4c7cd70767b9@redhat.com>
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: f2de1d06-e475-4a14-ddc5-08ddc5f8a666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+VA0/2MtEdx5Vj+kdc/VAEtz5QLxVqZ/5B/vjt3M1OyjGanpKYAf1hoGt+aI?=
 =?us-ascii?Q?femXLHS6UbiJ5qUbLUt0R51c4DmiD4hoCo2eZgSyr4NuLyCP84csmh9u4hya?=
 =?us-ascii?Q?bvIL8jjYRQtY0R/vvsqjSiF5l4GlzPg4BnBnZr60WWOJgOHmlm2Nv67sNt36?=
 =?us-ascii?Q?3vbLLqDFUVgPXi40BJtrxZqHEfrrxuDjKOSepwpXKFNRUr+sUJ1XNd4K6gXD?=
 =?us-ascii?Q?gcyB6SEks48pD2LnW9KCS2ksCx0ny9q64WIMQSA+W+xU2y+M7O87pMLJTApq?=
 =?us-ascii?Q?xgR87tiKm2iMZMqbQ9lDm4kBOQjD7em8iIm0HwyJAd35AAuvO1aWoTfOZb5u?=
 =?us-ascii?Q?8avLbRH2UYrB55ZnmHjbiTrxeaRAZZfFs5xOFUDUgdbrBskSYFt56q9v7+k9?=
 =?us-ascii?Q?BTpUizckfo2ZFxm/wHWqc27E9xPLKOYM36RK6evu37lPhG8011Vuy2yx+ryy?=
 =?us-ascii?Q?cSmqF2NnLykg4+olf2NNkOMshzd5rJSp+NveujZ6kHyskC8KpGWIdJxMjcbv?=
 =?us-ascii?Q?PeCejr+GeI7BISNdI72DeWaJrABp2Ne0BD+4F2KZJZvqUGSJYZpzhx1TCk8E?=
 =?us-ascii?Q?pMAhx7Z3yUjADK6fjbdkSwIe7r3Cg4QAxXnLNyxb7VjY//t/mcJ5uxx28GGp?=
 =?us-ascii?Q?r1m/N7Qu4W614CjJpM2UqVPy6KaeUfIuMFHzxYm3ig49CgQ/O9dM0ek5SUT9?=
 =?us-ascii?Q?dq61NnSrrDkJC6Wjntn9yp3g46oANjDQOLH3thBq9jDUbJIkAQeYSKTwHfcY?=
 =?us-ascii?Q?CuiyRuqaZzyp1eYDP2WtFKqPSSay+RqbMHtKeKXF+94e9b3bqLoGGSKoGW58?=
 =?us-ascii?Q?2y+04Nw7Y679NTUnBhaPYmzYi8tp0f7ZXf1lzNalxAGcPhVUbmzcNT0btCYI?=
 =?us-ascii?Q?Asj8BxZRKiL2TU/trkBekPIt544xvnbNhtsxztR/0LYPBwtNZm9fEVi4XZcU?=
 =?us-ascii?Q?lbfs18nvT+8Um1P62eLV7RYd5sccWyKo3g2L6yXZocMcwxnOxTzQdopbQy5K?=
 =?us-ascii?Q?utNkLHhVawv9bn3iKurbnDfyPnewYdLO2G9LzxqWXowqKUvUheCMe9wZayPy?=
 =?us-ascii?Q?eq3p3r0Pmu3eOTIxkiRFZgLVh/n3Y370f8M/PoneyVpPTXWOp3iDp09YsggW?=
 =?us-ascii?Q?rmgcPVVVvUJKLReQx+/xMMW3v2vFS4Q0d+7bV1eFsdEsIJGLuHiwmDiGEHeU?=
 =?us-ascii?Q?LcRywS0Tu8rIJVNG1mKFQjtizDuScnkjYc3Tlr66CqwMKhY9L2r5gaR6xFdj?=
 =?us-ascii?Q?nCbjJZelKUGamlodAgpL/oy1skWVOhm7TaWfBAw4HL5EoxSs49uwydrnPq+T?=
 =?us-ascii?Q?moW4eK5S3Hod6Qd1QUfRHyZxwnnqmGZvN71DjIuQI/vOHtgSihZvL+jjIm9O?=
 =?us-ascii?Q?s1WNU3b4Tg1SSJOsocMhW2gd2lr3ekuuHq98OEXMi3jl0kbCY9Wggo7Fr8A3?=
 =?us-ascii?Q?HhWlQawZ4YI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z0FP4vRqfh5QYX68b65EGBlQU4HYOxnvXjpFqoFKsliUJdSboY7gDEYFa+QU?=
 =?us-ascii?Q?B10Sll8b7K1/deAkILl4PpiqC7LO4zksOn6PAWKrql9xJ3/oDO9COCPWAxec?=
 =?us-ascii?Q?vMfXhkvsmKwcwxVXiF6jJ1ctDRaBV0dObP5e3CfKfM6PzgmiFrkg+AJQ8U1Y?=
 =?us-ascii?Q?P8zfLmm53v7BpujgdoqfquENCkbo9pjDTROn9bqOrZCsKdmwd/2Nh22omhIi?=
 =?us-ascii?Q?nyVO0G+scDqh/LMA7TIXHb3mBW/02rFGhcKXF0dh0BUR68oP0MolVS6Br3nL?=
 =?us-ascii?Q?RbRDo4qtOZgvo4D16TptMFsui5ZxYhCfvfy2cMzjPMTr7LFWtoC5GfEJV85M?=
 =?us-ascii?Q?mFiwKKWJvzLn8PgYLta2+6QTTvxIM/Ui9hxCqZJ6ZTgmg7kWi09ks/760oUK?=
 =?us-ascii?Q?ts1V4nO2qt65t7/aNw43RXFmGmz6QqsI1cPFB2u9BR8MwZDPQ9xnNWBimn3v?=
 =?us-ascii?Q?jbGGHeHpQImxg/sjY3WAR3fIJgBsYPB/EZcrDip7THnLgCIfMntrNjKlvB92?=
 =?us-ascii?Q?h8tf8ayCEv18XvpgFQlRe/Ty04BslFPyoWrYvOwBpKFChOKc3mNZ1U8bHmLU?=
 =?us-ascii?Q?bIeBJsQfAQqT8NzXOBIJ+DK/SyCbOMBnpV3YZsJV0iY6Owt+GAlx3ZPhtXw+?=
 =?us-ascii?Q?W9Eog2SxmtwaQBasQcrdQBswsZ/w5Gz3K40fyoVZ7/oOhW9zOExvccdq2O1Q?=
 =?us-ascii?Q?PfGgliJ6gWNLAkLY61YcApKbj3JOwFfBvKmNF5U3jyX2KVGL7LpAIjFrISVg?=
 =?us-ascii?Q?5ad92KmUj+PSMGZrO77DGhR5dZRtEhMvjmr0DEatLGiVE+5uRCIMi/ef2pfU?=
 =?us-ascii?Q?WswbPlO6qwSTN7BbIazPfFhrTNlhgpe4aCWbfRnhY+IPhpdkKItmSlVG63cg?=
 =?us-ascii?Q?WlnKyVq2FT7O/rhdHsyavrCQmhWNpKzCa6n7VkL7I7C7a81bkktWlOpoJUNm?=
 =?us-ascii?Q?0bdYHZu/dOwQ52FlHwyjkq/r/77En+mhiKyj/HmgYTPk1quubzdQRkUVwJQ/?=
 =?us-ascii?Q?VC272RjwKnPYy7eyIfVMfK1l82t9D52CR246zLILrjtwu2FhaqHg02twtGL7?=
 =?us-ascii?Q?RkvSivBdyJjGfX/j3xVu9AG2Qp/9K3R5KugFx1cYJ//gXe3NxcS0szH2p3J5?=
 =?us-ascii?Q?fXtq4oiTbny5VU0yFrPbH/UBndbGWXP/XK2mid/KD+KY4lMWQNLZy7sE4e/g?=
 =?us-ascii?Q?N6Gx9bSOll+qWg3Q21oz7DVZJrfLUyMu5GwDj3YCvz/TV+fgd61IBGnKm5dv?=
 =?us-ascii?Q?weiSPNq3xZHfccMxAfQ/8OdmWv+uy/2Qi1zq6nZVYFbQoHP9n+MZNELLHiUr?=
 =?us-ascii?Q?2/4Qn9J5+c/r5PDfF/8DD6ikWwgcwadAtaEwdLcvE3KG8VO3wCXbnlA/DSm8?=
 =?us-ascii?Q?j0MAjZtEAUMvCcrESeDom3+F5+6i0p1qp5pHWWYRwpOajENxzGAlYx0sHwDG?=
 =?us-ascii?Q?9IDV2TfgRrj0E9clWEhEiSy8e4kazJAYQaWG73ys9jfexiy30WCLTPeGZeeK?=
 =?us-ascii?Q?zSbj1C5uaDpizD2QmKZ4wMlNGbbCm7bxyFY4f/xD8E8vnOnT2aTkRTeyhwqI?=
 =?us-ascii?Q?HFjyDfJDaTdq4eHmMeDxcEMA7H94jD7mk4M8DdnBvDsnhBwGP/oql3F46F5u?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gpgpJ9BCbE/Aecz/0S+PuuUH40KHqT76FE4FRh7lZgRcFa32IWBTR4dECei8UDUoty3fEMT++eSx35KVbIaIOLTVAbUGGTyyt+4TMygd2hrX6tRonI4qC9Yh1RNXVoPs1UhS06VMgiAAg63Wodymq1X+mRO1fOgvJgip97BD+s8hYibh4yMaAgTSPtyWD+vm+EqB5Bn2LtIiNB3Wk+SeMHmUNoHUFcb4gAeXVfJSW1+h5g8mZBG+oFabK0/ojWJMbF6u/IF/CtvWUeMxte8ifTT51HWj8O4xg3zHjqkQBlHqCh+yTkGUl2jZidbU04saVEpp0FkX8ZO41eOTJ7Pfab94kHf1ymnpWTn7iRJLxdeEvJ1Rc5yB0XhFo7Q92BKSfIE7me+eh2d2uHGajkJoohSUhJiVsb0Rt8Pc6YSNaVnr27Apc5+z9/FpUlbldimrbH6ravvM/f4yo5MS6Ky22OY6F/XCJzQbae0b8ZrlkDRbtGFvdfQrT2bEf66xLA9OJCVNgS31twYsE2+Uyl6r0sdvgJjqg2OIE5sTegUpjC6RVQC/asaA327WyVHOJjDUaPX5MgRVxvWgLyWzCnHggOm+uV3en+OhmLbUzy3skc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2de1d06-e475-4a14-ddc5-08ddc5f8a666
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 12:43:09.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkFdDKD1u4DB0W0COOc4v5YF42nnLGiEJtxkac+QbvotXO0GZevkmurz2JrdYxWo9CRvmy+ysnYwllGtTBtGL1OxtC4xQPgZzjeitA1VMUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180097
X-Proofpoint-GUID: Rw7iBOSwcFJtBBtL1549o5R9h3LpwVUm
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=687a4162 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=-JV06nNTu74H9xXfO2IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Rw7iBOSwcFJtBBtL1549o5R9h3LpwVUm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA5NyBTYWx0ZWRfX1ZDNuIRl2M8x 8+th0zDcNV/TBgehsSEL5WABXbGDpfYcbDn0vtEScSZSGzzdM4zi4DYz61p32mZf3k9Im9FGAw6 v2XkfVM9NMzPiLmqXCfoJZrXFS0/6UT321ZdkygHtIslC4z3bx1VfIAleY1tl+08DedHE+Lb/Jl
 A+Fwp2W77qLlt76wyyqKqb4f+uxsNt6LQQK5yee42yOKwUAbgPUztMn41MuLldoccPgCRvmOAM3 Fcu+ZOqc1jEU9Jy4wy9wywPo9CLlPrP0MNyRpOKk/hCAAg0Ee3JRn9TO1XbUsshylHytM67+qMO vjzTuJC2exL3mkVVSAwpcRWGmxHPICvGfL1aJrA1oMHzEO+VUFF0Jsz+GY0+wNGaO3HE7GlYaqu
 rAUm1fkd2qadH4HPW7MDh7OtJ2cUNOAYmEMLIJ7yJL599dqylNociFbUlYzs+q0cW17JSLo4

On Thu, Jul 17, 2025 at 10:03:44PM +0200, David Hildenbrand wrote:
> On 17.07.25 21:55, Lorenzo Stoakes wrote:
> > On Thu, Jul 17, 2025 at 08:51:51PM +0100, Lorenzo Stoakes wrote:
> > > > @@ -721,37 +772,21 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > > >   		print_bad_page_map(vma, addr, pmd_val(pmd), NULL);
> > > >   		return NULL;
> > > >   	}
> > > > -
> > > > -	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
> > > > -		if (vma->vm_flags & VM_MIXEDMAP) {
> > > > -			if (!pfn_valid(pfn))
> > > > -				return NULL;
> > > > -			goto out;
> > > > -		} else {
> > > > -			unsigned long off;
> > > > -			off = (addr - vma->vm_start) >> PAGE_SHIFT;
> > > > -			if (pfn == vma->vm_pgoff + off)
> > > > -				return NULL;
> > > > -			if (!is_cow_mapping(vma->vm_flags))
> > > > -				return NULL;
> > > > -		}
> > > > -	}
> > > > -
> > > > -	if (is_huge_zero_pfn(pfn))
> > > > -		return NULL;
> > > > -	if (unlikely(pfn > highest_memmap_pfn)) {
> > > > -		print_bad_page_map(vma, addr, pmd_val(pmd), NULL);
> > > > -		return NULL;
> > > > -	}
> > > > -
> > > > -	/*
> > > > -	 * NOTE! We still have PageReserved() pages in the page tables.
> > > > -	 * eg. VDSO mappings can cause them to exist.
> > > > -	 */
> > > > -out:
> > > > -	return pfn_to_page(pfn);
> > > > +	return vm_normal_page_pfn(vma, addr, pfn, pmd_val(pmd));
> > >
> > > Hmm this seems broken, because you're now making these special on arches with
> > > pte_special() right? But then you're invoking the not-special function?
> > >
> > > Also for non-pte_special() arches you're kind of implying they _maybe_ could be
> > > special.
> >
> > OK sorry the diff caught me out here, you explicitly handle the pmd_special()
> > case here, duplicatively (yuck).
> >
> > Maybe you fix this up in a later patch :)
>
> I had that, but the conditions depend on the level, meaning: unnecessary
> checks for pte/pmd/pud level.
>
> I had a variant where I would pass "bool special" into vm_normal_page_pfn(),
> but I didn't like it.
>
> To optimize out, I would have to provide a "level" argument, and did not
> convince myself yet that that is a good idea at this point.

Yeah fair enough. That probably isn't worth it or might end up making things
even more ugly.

We must keep things within the realms of good taste...

See other mail for a suggestion... I think this is just an awkward function
whatever way round.

>
> --
> Cheers,
>
> David / dhildenb
>

