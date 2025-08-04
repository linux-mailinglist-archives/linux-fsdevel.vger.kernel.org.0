Return-Path: <linux-fsdevel+bounces-56670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD95EB1A830
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 18:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4F8C4E1E7D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AA2246769;
	Mon,  4 Aug 2025 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cFlCLdth";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AJZ0jRT0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A528643E;
	Mon,  4 Aug 2025 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326315; cv=fail; b=PwP4YQIQPCq8oHzs4X0q4zeGSB7Gblqm8J1t8pA9Npcw9n5zTPpGZ2+2TwahoENXLj/h+zmgDSPe0zGIK4I89n7Cl+4cO4aD3t8gRZ+59Ht9MHdLIFjx9YPhLHyAtekzVgnuXQiej5xGYfgmMcHtObEb1dfc/Fv3OtJmoOpzpwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326315; c=relaxed/simple;
	bh=nq7K7S9xBI6epbJKui0sVl2vC2ZPOA3u+iuQkk6dT1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h6lwC+T6F/BiBiO7kB0PyRfNANduHx6haoHXFGrEtLnDVg0wKs24lnGWwAFMHBleKzY+zvQpIBRziT89H6hhMqj3QNBJ9hVyTH/er0egOwg3rv1/cfQvDybVexF4tnQ6EDxKZhaFInEreTgPDYjiPYKnLXq5b1IHz8I9shV2CGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cFlCLdth; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AJZ0jRT0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6Wdg028481;
	Mon, 4 Aug 2025 16:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QmxZz93E68izW6GCnM
	irXsAcAbdRX/he7rLHGAn5W7Q=; b=cFlCLdthTVTzRYmNMPj/FHHCsFQAqPPH0S
	P73VJpPJ+K1YXm/FoPzlTQ1rn89VRoV6X5z+Nc1ku5Ac5Vnv888wY29B7MGaUblw
	xfOXZ+B6w1OQFhu5Ap753+qZSlrr9riJiG5kU1V2tiA1FaqcRaxi53A5LnpO2cji
	iMctPZy85UFZZ8cMusrGv4iqybhGIr+TGgNikazXaw5KYSgX9R9H5jBhO8HYLsZm
	8HpZuvEEgo3T+eqrD29b0I1G8PvrYH5N81hBlazX0Vwwr4RfL45DPCfTRrPDfeh7
	cTAWdVJWVR5Wq8UKYEoKx7dXlEpJzDlk5KmTg76ow8iuY5QcEveA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4899f4u1sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 16:50:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574GbsN2015053;
	Mon, 4 Aug 2025 16:50:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7q0wm7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 16:50:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuKBdut3Pyv3ypKmc6QrdX6wznEXYwy3AplqMaQjrHZVdAETRrgJtvRdepEtWDCwN9NpnZxPgi/uIL0eSY007g+O8ej+MmKcfBR8/fCOLqp61IvydA8i2O9DQgk4BJWvaZcGf+oVwFaJhdwbvjgcZiR0uZaMuNQeEN0B/F20RIz37O+x+PKF1+8B3JNH18SPa6/zTZu93RkdILBIxjf9AAC2tNU4AFpFrPlnzAVNCHgmQ72uj2IW4/GKD5Y48fz5b71qjbJ3K2O7gunbiC0Y7vCsIjpYFKiUJOqKzbW4J0IcqCDb96Bm29qmpg81OtZAUC5WIJaS5kG7nM2wHO7bAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmxZz93E68izW6GCnMirXsAcAbdRX/he7rLHGAn5W7Q=;
 b=jSJiuEzJtOeObJM/nA/2zxQRWDICVUkIvefNnYmA7x7TUNjRICXKNzdK3Wn1qMcapDVAb2wFgBTgy0/rLPFRHHvBlQV71BE4P1T1iNOizcjff2g1dmPE8XIh3SYBn2JUHeiBaYHng10j98GN14F0+w5DJ1+WLyGdHsyucMNKlRnA+hF7ZuE71rWphhuG47V7T5VQk/iIHT0TOKXJvryaPNX8PgRB2fx6Wf9/YF43+6o5sadGDeD2rPK57juaV/wEWSEoQnJ0fQZC8hDPM58xpkoVVTlZFdPJJSOu082kVf7bs4gBmW0E+HkODoHxbGige53FpJr/kxXSbzIUjMPRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmxZz93E68izW6GCnMirXsAcAbdRX/he7rLHGAn5W7Q=;
 b=AJZ0jRT0uZKYnOzQpodsdRH7awFybGLOtE6SxER3ZYTkmVC+gMWrGDrZfO1cDAT3GIavYCqSq9F7njumN8NSIfcotq1i3FX9T7qbdEDZMd8RaJ0NsAaE4lpWmb8cujexTZfOh/x78MPa578A8QT4qQOhW/GQA2Rcsz9LqQx6v4k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6706.namprd10.prod.outlook.com (2603:10b6:930:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 16:50:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 16:50:49 +0000
Date: Mon, 4 Aug 2025 17:50:46 +0100
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
        linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
        linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 4/5]  mm: add largest_zero_folio() routine
Message-ID: <bcb9940a-18ae-48e6-b000-53fca461fff8@lucifer.local>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-5-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804121356.572917-5-kernel@pankajraghav.com>
X-ClientProxiedBy: AM0PR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 8169085f-229a-4c86-3ffa-08ddd37710a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5SQe2V71EIfRKJOA6sfRho2USVFIiQCvngt8crjYxvUiwFFia4YFCYa0fXsf?=
 =?us-ascii?Q?kD2a/yl0FzmMnXPoZ8rh1MiXOnkxOzLhDDRwkrUPXxtzEVTox/zI8syDEuZD?=
 =?us-ascii?Q?Ryv3jrNRuJF6uhBSSRvNxuXpndG9NyK0N2IepRqczfmh7X7LjuoErzDA9sIl?=
 =?us-ascii?Q?3uyhNGoXg1+HneW4iUjxJ2JgcxCQnjJntlai2erNoixlkZy9U/fb+WUUTo+k?=
 =?us-ascii?Q?JAFpY3kHF3Lvv4FDu81MakR6CG3d5MFUELkD8npJyZnHpfmyOMdYC3tpsbpa?=
 =?us-ascii?Q?MofXvIavIWnSFM2GQVRS5hkqSoLvJnse+liy82MR5mm8P3lJDGBWDnwB5dz5?=
 =?us-ascii?Q?if5TayhjY5nrbZ5cUz7hfncpWHfqnpMh1vxEpeIbKndjFXcUUO+ymLlTH/iD?=
 =?us-ascii?Q?P5FxpB+bF2qMH8rJojfz8u6ErXGaGF/60fv9o0Z2zVrGTEBm34XmYppu++qZ?=
 =?us-ascii?Q?a5fs6vZ1clAd4XdFptYizw1VEKUslrTVYMK+PM/VEcVi2uKF4iUvISzmfS2M?=
 =?us-ascii?Q?SRQw+5XONegR5GUU2ryXA3fAKMZbjhro9g/2zb6E/U77f6ZGO/jldcr2zRIJ?=
 =?us-ascii?Q?AD97iRJYv3NbmVJHefUtrMflxl4yMIwrNVMqSMVLEpmGrbB3yV1op4aWHxP/?=
 =?us-ascii?Q?kVPZSdNlCrfR4zcQV14U+nvb0djM7PvW+S/22Bu86tugj4bnjOPI4c56kGS3?=
 =?us-ascii?Q?ZPVRUHd4I4cbaHUbgUV3QO7IUylsxZVgRmzefGxwSl7W11xpnQ39QVVHsP0l?=
 =?us-ascii?Q?zI7SsH45kNQF6/GcaD3URc1/IOLkutcu2jiWnaiBhr0vYr6VfsmxLD30udYk?=
 =?us-ascii?Q?bT+UkvU/sadJBROjesWev+/95zVW9H7X6joj6JnGzYRRP19w1bJ9klADSkCx?=
 =?us-ascii?Q?rAxUKvo4VezAW+E2CHmTEOa56Xsr+LKI2/HqMfTMVO+X2EJkESmtbsUrMevU?=
 =?us-ascii?Q?A5R8QSGMsPqzZYDAsPG2ByNYiznBYE/KKcUIUeuxOM3cQi68mexn8EusLtwh?=
 =?us-ascii?Q?mZyYOt/xH/X7TGRm1nvz3pyhpDrnsllLOSk88v7i/FE77rJiVgxTQ5VOyI/E?=
 =?us-ascii?Q?n6IBaB/jmXJO1EjW9j+mUO8zOcTIgLWGbTJ8IAzjKcLdvVZD1ZtwWVufmv3I?=
 =?us-ascii?Q?rt9qUVFOgT1D6vzDPlriJnKT7awYlNa5k/jtENOEs5cAeflD1rMP9IUNjBTN?=
 =?us-ascii?Q?8ssS2yltiv6DnO+psDTL5tMgkoyQhpGNPxgDGrvnbY6JcqsH+lxCiuJ3yUrx?=
 =?us-ascii?Q?0CDRvBAGQK3ntaT8cucpjMdkxX62GYUVco+5BVkvJ/ssfxvY6ePqjFj/pdry?=
 =?us-ascii?Q?vaGdimM983WMZ4T/mxquIO2gKHUD/Ceo+I8uRbZv7MLyvizzP/ngcOXD+odv?=
 =?us-ascii?Q?0ZEakuGZDBY6cbAyxBhCxfNaPP37Lvnt9FXiqOYdWFLffRkVrnVmCmb9Ca7B?=
 =?us-ascii?Q?coRefS3UQZU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vQ1hKdW44yD7jovthv3PXDJ2szPJ6aImA8c+D+XGNWZR5vQLerkCQ8q+jERX?=
 =?us-ascii?Q?A6m8NmVFonPExIOL5itYAXtLE9bRXBU4YPv/tyyq5E6WUJ9T/4zUDzVuxrsV?=
 =?us-ascii?Q?n8Hp/MGdeDlDnWmHPvyLg+4kyUeRBu6MFpr4FU6q+tXz75jf/f4hq9/PkWh+?=
 =?us-ascii?Q?tNyz1p1IiBVZIWfhk/HldrK7nXUhwY4pn183z08nV6Yq8ZAiHZwivN2HzvXb?=
 =?us-ascii?Q?1kxFQEJ+eYb0R3eUc2J9UFYmvQMDXsdDqt7Ok8NimpIDa97ehIIIuH17wqNR?=
 =?us-ascii?Q?sgwUlzFMdJYqN9NCgq61TQQ0B6s6+ePaB6iE2cthAbvEcwHf1PE+hz8hAytv?=
 =?us-ascii?Q?0t8AXvhiqIMZJsfR8oQ7KPpO/s6W/+OpHsn73sNPpIuleYbJJqqgxSVxFwEB?=
 =?us-ascii?Q?mCLA0zCI9gRqM2xqXzvIoZYD5p+Eiwr/keFrId3sFDVUFAiKmHSRj7JUrCNx?=
 =?us-ascii?Q?NWF/lGoLbG2fAk8YI76LIKOHvR9E0kC+frH7Nw/b2FcmDyPJuRudhHeuKbo2?=
 =?us-ascii?Q?Zl8m2kI1C+N+2tK+8JW6vn4Y+/dU2kNtoSiI5WG6UX+0GUnVdozjch1bWnCg?=
 =?us-ascii?Q?07PA6WgjC+Dep0GRWjM0bNwhB5+rDdvCMgiBkOl+fIq+KixLHE91bK0ouT77?=
 =?us-ascii?Q?N+puUPUmyz7LDaOXNgInIwHTlc31ItoRFEDNt4xsh9gIDJbmOagu3bBka/Lr?=
 =?us-ascii?Q?I8DSidGdJkZ6em/dM3ZaKYD807R+/R5c6Z3JM4thJz1gJqwRtX4MRC28rxfY?=
 =?us-ascii?Q?g9Jz+I+l5UhnixEGgxDEZqY6XbUTfjEQaUcXyzvky1ggU1P5eGZXITww3hP5?=
 =?us-ascii?Q?E4euUBjqlOmwS+H/t1KYIbpWv5tbYbxa2ADq50UE3b908LQepsMrPbBtuqp2?=
 =?us-ascii?Q?rXOrWfpQVl3A6IBt+Ta91RCnSV9bMEy54nuVFgxZCFrts/sImGYjJNti090x?=
 =?us-ascii?Q?X6w1inf4Hn+X1OPyY+ugPrvRvpAcDKv9TqNVtXgC1hi1zcb8bND6o1Bl3ttO?=
 =?us-ascii?Q?McUQ8KXwBpkDh6xsqNxOaET+5EJKnp/0rpI4ByTOFBxuJVao/QFtNiikQ9vM?=
 =?us-ascii?Q?l06KxJitLP8wP0zDKhR3ws5EzBvL61iRZA2rtBGEMrbjJ7Z5nn4yJbUFn1gz?=
 =?us-ascii?Q?cSR/ji4fjuEzoh+O81BkJlsOBHEfeGsw95nng+xE2tMU9gvCQ3f+Fw8yX30w?=
 =?us-ascii?Q?VwyN9PmyqpSU8SY7a0u9GdX9QewDhBxmihtkZpVEW9UHLKx/FEugA/0m3Ia6?=
 =?us-ascii?Q?6tiBHHoBXj73HYq87ep+m7D3FgGIVo6yorioKynV8DMHXsZ0f7htkohpxI+Z?=
 =?us-ascii?Q?N9qR7kZnQY0PqQ8yEnUQb0+B6QWXUHg3OXvaSdOHXGXIsrdlhQMGpd1ohQQA?=
 =?us-ascii?Q?KZQ/uN2I9sx/3/9JJRG9WxFsbmu8ctVoG/asXHIZ097m1cSNKU6nHfea//ja?=
 =?us-ascii?Q?IzOu3MrvsAZEJ8xAum8UGv3B8p0AsDEK0Z4Lls2LgvfAW8oZ3JF3RCXB6KYt?=
 =?us-ascii?Q?VnlnPkl/96tJ2xqFch3vC6e9aaVwbKxEoaXrDlYVf6M6tV797Qkj4J+9TkmR?=
 =?us-ascii?Q?aO0pSfFE0i188MuUHUfbRspTyUyj9z2B++KWDq42UwZPvoi1ujhd9fcpHgK1?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8ROQEGZO2h6VcLQpHQqk0a5q0MnPgyjbhaktjI6aDd92YmNViH+qs1dNs+5RDCcp3PzhOZdzmMFJPPYRWa3YEUks8qfTSSjyjaOnuh+/jeU2CDPaBMa+IErKmNVcW1aD/uUM46H0wuqwDQlC7KEYib4qCZ9BoFVXPSpfSYWu2nmqaePkfE/6vuXGk6HGQWYHARZ3lv6HUsaX//pYt8ZHn8t+bKUa25j3NpxqHGX+Us83Akp0x5hDIMfh8mRNkX3pqmcaaiQTgg7KvHDB82Es3vlBfDQWKZcbXY6qeFxTM6nRyoeLtCHXA7e/KbSaUHH2wG+Bu0rX1jgcxM2xWnTUsmFXveYRk380hVKK12A4ibPdebyNvqwK8JABNY7Na54NZaKfApv359siLG061n7F1t1G/pvfx0s8l6J0LQDOMe0/ZFr7708iuYCcwuYIvPdTcaCsXWyNcwFvB8hLaA4xyd1kfsVXzREbZnz7uJYew5WgpJgVXYolclDd6fx4222zQhX1x0rzYsRVJyTqdSscSetHyD/VqUi1opllK8nUJ4tgGRrMCIwBRfE+PihiUnvyrj+UAizo/ZAWWJLRtoJj4I8dkMzMvXJmMuW6Zxl4CiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8169085f-229a-4c86-3ffa-08ddd37710a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 16:50:49.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exu4GaDQDBoCDBU3HXbusARHSPhA3uzk61lZnOTmbjd0aG0hWvJ8HfGW1c7WE7zSxHSLPqhXyWLkoCDaRDax/zazqaTxkOY2yJo52PQ/IvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_07,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508040094
X-Proofpoint-ORIG-GUID: IyHylka0VvEdp0macjL-M9G7j-7sybUE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA5NCBTYWx0ZWRfX16lv6ShSOoW9
 /cvvqurZZiR8/LSVsdonvZhtNpP0PPTl29vJ11geurLU0XIUEdGTwlK6bXNYOrLGSsdnVqsZF7n
 utifROnHhacJU7s4I+nt5af5ksEZUB9Es+5Cgl2OLBam0dlJpzLhqGm7ic+7aa1dG6juNb2l7+R
 cCyK15WVpsWDVwlEcjf/8tV0k2vSY5RQdH7v4wXfRCzLtoTqPCQRm3e39UJw5gCEsuKErnvbnHZ
 EUwBXIWxr/g92NFjBZAkaA7YAM2cOM/mpt5A+3FhcVAf+aDRKjnc5n4Fwlf4iz/SK7rZkbvYlP9
 Qu7q6I5G/ssMw2cjq9u6vuDRGswXayBCZ/VesaTO+t1qKN14WusD/q4FWqphtub0ayLOZDg6MXg
 5gxcvXO36k8prWY+ekSEdZKIsqx+3mSPw+sEvyU5Jf/3dG+5x3xc8+7DRSEn47vfDhwOzh5O
X-Proofpoint-GUID: IyHylka0VvEdp0macjL-M9G7j-7sybUE
X-Authority-Analysis: v=2.4 cv=daaA3WXe c=1 sm=1 tr=0 ts=6890e4f2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=Fsyk7P7osebQm2GacrUA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12066

On Mon, Aug 04, 2025 at 02:13:55PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> Add largest_zero_folio() routine so that huge_zero_folio can be
> used directly when CONFIG_STATIC_HUGE_ZERO_FOLIO is enabled. This will
> return ZERO_PAGE folio if CONFIG_STATIC_HUGE_ZERO_FOLIO is disabled or
> if we failed to allocate a huge_zero_folio.
>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

This looks good to me minus nit + comment below, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/huge_mm.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 78ebceb61d0e..c44a6736704b 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -716,4 +716,21 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
>  	return split_folio_to_list_to_order(folio, NULL, new_order);
>  }
>
> +/*

Maybe let's make this a kernel doc comment?

> + * largest_zero_folio - Get the largest zero size folio available
> + *
> + * This function will return huge_zero_folio if CONFIG_STATIC_HUGE_ZERO_FOLIO
> + * is enabled. Otherwise, a ZERO_PAGE folio is returned.
> + *
> + * Deduce the size of the folio with folio_size instead of assuming the
> + * folio size.
> + */
> +static inline struct folio *largest_zero_folio(void)
> +{
> +	struct folio *folio = get_static_huge_zero_folio();
> +
> +	if (folio)
> +		return folio;
> +	return page_folio(ZERO_PAGE(0));

Feels like we should have this in a wrapper function somewhere. Then again it
seems people generally always open-code 'ZERO_PAGE(0)' anyway so maybe this is
sort of the 'way things are done'? :P

> +}
>  #endif /* _LINUX_HUGE_MM_H */
> --
> 2.49.0
>

