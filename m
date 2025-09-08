Return-Path: <linux-fsdevel+bounces-60507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41101B48B99
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5319D342173
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C1A3043D2;
	Mon,  8 Sep 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V2ELfmPU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kaNCp8a8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC23043A1;
	Mon,  8 Sep 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329957; cv=fail; b=JIV8+kCVo7Ezh70LvpBUFO77iZ7WietEDuqwlAghgyM52juBkvjYahl2udiGCasiyRbEBUzkbisTNq8Te/qtz3wETCeTnAcWxo6ztqHNFMiteQJMvLMt/KR6oFZg/TR5XtLG3xyWKBo/YmJFLdx4DAZ+cN6h3VWB9Re9wjLU7+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329957; c=relaxed/simple;
	bh=bFrXutpBdWcvaBp6/EHUkQ3D1+dYtEpDoNMRn6zo1Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NZSQ/iV/3vXRvVi+9N4h/LB6nHaIgWJnDHSwI6i8mQOCkIKkw4eriAU3z4epeWsg6TxBpa5qxw61upCMDT7pAGXGRND/eGdi1b3EpuHwp2n/F11BoKYZKq5bvSwpzNqD/GAUXmFgq4JpVK9z4V1Ep/Jhj6HVF/9GFvUBLIsnXpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V2ELfmPU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kaNCp8a8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588B9NC9008176;
	Mon, 8 Sep 2025 11:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9v/S0HijuZx48o0CV+CH9/1aWShLqW/UqAjNwlpndr8=; b=
	V2ELfmPU2kY/LUCNvzouSkcKBlKHVNkj3Ui8Fq5fscRnhAVIPU17McfztqFD+/qF
	wyI9s0snYYFRnXY2fuWqa4miH4Opd9QHTY+PURAtg/mP4XmK+DkPY5a6HE7Ir+jY
	KVb397+xRqjPJ6V+TrwFp4Y7EbaN1wrrTmK+kfr41a8/iv5apimJ2lJ3N6qIgVQs
	szWc1+YdTuS9fIV9FdabOA4zJi1tBHJfm1pqjhzGkgXsnUIBdzS6EDcFRhHdJXfl
	VwvNXQCqiIlzQ3a/y4h57PHAsrgmSSK3iggFwQffIzmRaGfPukif8dvLur9/7xUP
	FAuqts23rAEWOEKfWAvJ0w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491x16g04h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588AV27I002883;
	Mon, 8 Sep 2025 11:11:57 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdej0pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5b3v8Fqla5Op8JSTQKU1rTpLCQUs/vZ6Lq1l1bAyjLkyxockwR/cp7+Q2K1slXKmUb5Irk92LC3MA11mM4eI+UvsGz71/fux63JemtoGhcZpg70EbetUDF5XVR+Eg1BCPm3jOyMd/amzFUknLewdfsIXfQXjIl9SXmvFdYNo4CSIOc8EGiDd4ZKOR+4cwF/Up9rrKhAJsL9A36wnqbz0cjWFEgiFJhqlqWmltOu9dYOJfnHmZ2Y/L+7VpaS22zqM23IFEVfEX0p+jOKY7SFMfbgw8BDQBVDi3oX72dSpg9Wg/dJ3tPjwJqyJn6ml/cUqPhpfJcngFFiItRMYpuvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9v/S0HijuZx48o0CV+CH9/1aWShLqW/UqAjNwlpndr8=;
 b=Y8Z/18NLFaiQdW3Tz/Kqn7XRlpHh4nEFs/KOMfyEH+rOPgTUoRdtyj5E9elejhZwdTubhmijP+5L/TOAynDD6SgWKFOPKsA76v8uYm3dWZrOlbpSNYe/L8GbtrX1q5ERK/Irjw2v8+Xhnaezl/r+qEx8Ms+vvISh1mEjJ2MpLi8eD+fhZ3yMKYAqP/DlvbDyZbiXm1MrFeFJMCnLJLdwJJcBMe1T/b5AgFS1TDVRoLlIYHmH5x7Vxfz3ZBcyf0N6p+qgJNFINiYeo75XCCZy3xJ6dDXFUeusC082mtEs5xKuJZscnPwkrg3NG+0Q7SYjweJW7R9XLRuRkpfsCZCLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v/S0HijuZx48o0CV+CH9/1aWShLqW/UqAjNwlpndr8=;
 b=kaNCp8a8JGqXKwH4BQ+uxVi1BKupXTjR1nSLJTnlokQ9rIAim1KZBT1oUZNsTLskQAWz6c9SpD5t0gnUwQ/to5FewrgJgqh5M4SVDLlXRRuv7ZK1rZ70kM0wJqh3nKzPm+BYg/xQl0l3O0ddPt7D4v5nJdH+iHmIBGZSXJLkLhA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6588.namprd10.prod.outlook.com (2603:10b6:930:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:11:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:11:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 12/16] mm: update resctl to use mmap_prepare, mmap_complete, mmap_abort
Date: Mon,  8 Sep 2025 12:10:43 +0100
Message-ID: <d9e9407d2ee4119c83a704a80763e5344afb42f5.1757329751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0006.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: eed5b1b8-e6ea-4d3f-dd40-08ddeec880a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?smSZkV50Tz4r5m+JGVasLtnD63A381c4uH2h22Bxp9UUpvC3pDTXFFJQO9/B?=
 =?us-ascii?Q?j9kLMJIEa5H60C04DZu0Zm7zxBImu25m99AD7sB1diap0sR30WwWRVBKp33E?=
 =?us-ascii?Q?p0Ik2jY0+z4GTCcgvCzrhJ9U9IJjJ/exaF4NakR2KlXlAvN9JhHmfqcUuz6z?=
 =?us-ascii?Q?MonsJBbaitHdjgxMc79jXGMwoCd5+jqCFNGIWQkxV7mHrv4GSPkdQeNjF8h2?=
 =?us-ascii?Q?b3RYf5zZ3WZIqlig6jkxjL6StIjA324G8PgO3eib2drg+4tLt5L7Qk+9hJLD?=
 =?us-ascii?Q?SixXLZIXnmkgY5YzOXPV76If7tsz+Kg5OQylGPuqup5YNt+vmDJstQ9x+T79?=
 =?us-ascii?Q?rOclpFysbMdRBYXWY5hQiDFWUIDK3rAJrp0tdgZiryNiItVa2C/YVI2iMBFk?=
 =?us-ascii?Q?DzrBPuAuXJQpgo9yPx2u0Ozh7pfY+VZ/aGu3RbtHFTQZmjjwGRUbfUqyLvja?=
 =?us-ascii?Q?DlLLjgcq8D6VcPiUFMvDMvtnXucNHn9I2nCGLQ98fhNsDwh4pI1IIZ1kVDRK?=
 =?us-ascii?Q?rWzdQ/5PxrasSmpIAoiulfsoker/8QbvnMqOwNzym6zs+E7xJLSPB0owNKqz?=
 =?us-ascii?Q?AcpL0dXTagX7+yLXttAoLZoAoh+hq80zNs/YKj0B6nX//FOBIQC//XufHPXY?=
 =?us-ascii?Q?pX+KEHU93J92Br6WG6XNSwnPRhNZHu4BH66zyori7jalk5z7MU8zpjIa0Zo8?=
 =?us-ascii?Q?Gz5AolD4yRgCMEfGeCMqGGOaoP3e7NXXWVBgDxewbh85Ebavpmcl1Hv77Uml?=
 =?us-ascii?Q?0XgAm/cvq+hLyc1mZzxKB51t3Uj9TagDunQPmUkVujO0BvJharJlx445dxIY?=
 =?us-ascii?Q?XaQZwq2ahXBkFeAyngLAk+r305+wKa+Vve1K2vjWqOSDY3N+TN/LJ12jKAsQ?=
 =?us-ascii?Q?9HSbxAXsx560x+DP0BTrg53d+9em6+Iemz9lDs7z5PVWUyhOVAiC5gA5jaeA?=
 =?us-ascii?Q?pWJ0RuYcwPSDta8BU8UitfEjFgJBOYI9NrqYb4yzdwwjLUEQfeR5TOLjLn2F?=
 =?us-ascii?Q?rEo1Fjj+byX5P7oNzG2mY2ffA10aSV7aX7TSdIoHG1lU4JXYYoZIghhw4UNN?=
 =?us-ascii?Q?238AarrQlL8AI4Y4BTLAtYs5hy0sVBQNBrshHBhoK8COa8F4qUv2VkEJpCPn?=
 =?us-ascii?Q?fsv+kQpjoQmKAYTkhT/+u5Rf8Un8hMUn9qe3IleBIN1kdZjPTNpkG5ZfpAdL?=
 =?us-ascii?Q?9Zxutq5jaBI7B4eE3JDwQsh/p/vNxstjkcX8eFU/WD3fxmQj8bWj7DBuoxjS?=
 =?us-ascii?Q?vLCSPdMpQY0cBHj+6zIiPHB+Am89UcyUQVTSF5eNMwA7Gw8SwYM/kUShKtvZ?=
 =?us-ascii?Q?jpwDxpB9ZqKn8rMqELN8FH04AzvFpgV2sklXrj2khfCjF6TsKjLj5pZkeyht?=
 =?us-ascii?Q?gWKWnC+JZzjCeFHbI0biCBVheTp6q4meUBSlsu6yzSfjxj1xlnWK6e33BtoJ?=
 =?us-ascii?Q?7u37vjPlI3o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tba97pnUb3SXA8JlAETIHZjtb+G7nlp5yNiCayFMmCheIScmbwH0TubckHQl?=
 =?us-ascii?Q?4p56xnkTk4hu4FAZTcsVP0sxpv8vHxWYR1doL8wByCCwPS3Sk2MMXI2/ApfJ?=
 =?us-ascii?Q?wTjUiO+/HgnJPQSCMtVR2inLtz250S16Ur4N/9aHgmJiGllXRT+FaDLbUVFF?=
 =?us-ascii?Q?NenBEo5QTZy0W5Zn0xBNCknqYujN61DeOENduZ+G45TNcE5MTG1J1+OfUB/i?=
 =?us-ascii?Q?JFTWQ+oZoKLJ1z+VMcFq2iOgZjizBsshoKF7q2aZzK3dBaBMIrlWb/Qb26P7?=
 =?us-ascii?Q?kaT3X/9OdS6uGKRM5uDC6xM8NlxEqC6G6jS0CYcEGY9eZZpOdO0XlNqSTwax?=
 =?us-ascii?Q?Qu9IjgLZvggH8EJXI8N+qolSRbcQzFD4bDP3v/40O6P+XDBsDCUmMHluxD3P?=
 =?us-ascii?Q?rbYG3inM6x0LX6hN4J0UcKcnvziY8qo/08PLNz2GY4q07BThdkqQlhNmKUd9?=
 =?us-ascii?Q?SFWrnGLVwPUXVj9tHhhIuAi+INcl5t1/G4/2mhJ8Oa0+qn5aIc6hrYxrxkGG?=
 =?us-ascii?Q?jCeB381JL0fAofo4snS9pmjJ3qe5aZBJ2nak89i6W2Utt/iw1FaUPkj2otmO?=
 =?us-ascii?Q?EulHT8uyWAaX1E7daV4EfXocOQqa4IeYWHbekCtnFkaaTXHYn5pzsMKMKDLg?=
 =?us-ascii?Q?uk5KhA7eeobAbEXZ0xgjiH2T0prSFtVZ/BFDK+nA/S5rgZAjXrBehzEmkq5Q?=
 =?us-ascii?Q?4q0447QQvQIOCbq3/IWMMUatdJiFjTeqV8Kxlmb8o8exRDmVASA6XzFf6l7t?=
 =?us-ascii?Q?6fVjtpKAVhGnptC0mMlGKXg7iGasPWcyIB958gJtf+u2nYcdwuNRvpghjUrN?=
 =?us-ascii?Q?5D4R4HkJIR7vBrOpJa5x0K9hIWJGsa2QKweVpLjleEdvHNjqja4O8kGAUlNs?=
 =?us-ascii?Q?McHCq/43cQg99uwEZ2p2PRfcM8Y8AW9/TvIBYoKRAlGm38z39bV79B17PHet?=
 =?us-ascii?Q?yqGKP5k7kZqKZaDpGUgODnnbDI+K+sjXuW6xFLHybVTg16FQ7DVmXepv5Ms3?=
 =?us-ascii?Q?kUbGF+LdsJJh3FwMY8nFWY3AkhQL6Nu8gWuI0eUQ14JHROY5rN6lfdtgmIFL?=
 =?us-ascii?Q?5zERDZS6yLrSMIoBPjE6S++lfvu+0OMKSp7Qfy19EC351Q6odYZb9YsLlewM?=
 =?us-ascii?Q?fgYagqgVUqCfQfW96TegbEk/Pbcq79ZgKtHfyuFlCFvFtmY/DOs34V4mRK8S?=
 =?us-ascii?Q?tAZXchLCqDnlxY1ogKghN2OubZjdKF5grlYcYXjRYaLT68Q163h2711EGUqW?=
 =?us-ascii?Q?2VI5DVCTJi7lXJjk3xVtrNePDT+iqEuuLNliqIS6Dr/l1ZP28ZzkSts8CENo?=
 =?us-ascii?Q?MHir+BXETraFQtC2xgnu3lf2S7IcbhIY0H8EpEOa1zMxS3Njusu5n3MmBxLs?=
 =?us-ascii?Q?Vk14Zf6SR+q5XnVMKZEFEyY/FtYW4s1BF5nw9A8Gjy+/eDevwwwQ+7LrKQOc?=
 =?us-ascii?Q?px4syMKnD5atEH932iOZhoa5JWPWb16vMTt81vnFzSV7vXOrt8ffLb3E0WLg?=
 =?us-ascii?Q?sCXfzqZnOvsiuG3fZMXeroBmETmTtE8Ul5aDN1hpHL1R5k/ucsIo6SV/v4xo?=
 =?us-ascii?Q?RFo7Wtaj3r9qIJ7pK5l4yWeGfVrZWTuzND7Wz0F7SJ+7fYV7ilOtFAPy1o02?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4sPCf1Z/h5aFVxNUI3t1Co4pPqv0ZaLESmGpPe/2AqyXEhVeJ2Pgi29ODvWrVpvH2+QA5norv282ffyFzV44QCrlIq7hR+g9K5gIvoA0kkMckRp/BIbNt0UzESr6vdtg2iAY2+JLIikGypO7vAwbuWoCNMKrxebIUp86L+8+Er5ZKjZiCp6c3yI8s5oToeH4VqV5Au31N/DnNl+lUPOAsX7d0bIO85LbFPT9vgwAFauJT+5TfrgH8Ee8fCntX1ySI+gr69/t8FAuoe74Qrxx1Aek7hLslrqc1fhoHaxnOPWu/J4/bTXab+ftFBrCkOC7MrUpJcCL7G4ZVq37os6AfJ9HNLuC1zUbfngDtjDmLW9ivRpRDwDSZqE+Z/J4wJ88DlX7Am5OqtNBGkOV8090MRNcy3+c54e7zUDjHrn8+Esp7hh0R/UTQBj8aCUyDzEJqyWwQ8867FeWDNJBd0oFEeDnvfvLdos1a1Eyfj8s3EKDlapyzhsz//PVMeWULxVEe7kzzaIa1p9tsYw0vBnldo08fKr3CpHf3YS+vd+J0OrgKsaUDcCbL3aRkmeYF5T28iu2+92U8BkL5LQImk3xffz4BP7WL5RjEB/BZpuCamo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed5b1b8-e6ea-4d3f-dd40-08ddeec880a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:11:47.7638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkD8+sCiAxO0EG56FY/W61YI/t5QnwZniGkk/Uz8TKh77S8jhoHgqz8UJnNBljgZwKBXucX9Er8rdVL68gKdKm/NsjEBICwDjJbmWdN27aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080113
X-Authority-Analysis: v=2.4 cv=ULPdHDfy c=1 sm=1 tr=0 ts=68beb9fe b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=myPxDGlX7jRLdnKhP7EA:9 cc=ntf
 awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDExMiBTYWx0ZWRfX1IzPi2/mzBSH
 NQLTB73zSYiMOqMev356n6xD93bUFENUh4Uj0WLSsNVj+FY+1Za4Y0O4c8AEhD4hSI11JQOFuks
 rEJ3JXYNz90+mz8LaFWbBm13ECQJSKBhcClWyctfxS8idUmD5avu0Kc5Gz4OzSobJztwxIpELtZ
 2vUuPOOI/YsOFbOKM81shVVuIEngO3S4pWCXYXssYI2u99xorw2JmRyo9MAlTYwmQjLY61z1uZA
 bTMfsT681ov0Us2wAh0PdNSS8iRPp/ZMCGWzvLWCCAvaTJ0hLnbbr7enzzp7QOKoJKvTXcM/9R5
 XAaAGeqVmD0Y55oTaTtJ6CXshkGYxCvpEUuSyOHn19mBtFBEIfKB5Aj/huIwhK7ygK/s6LOqWdZ
 h+yKbHhzxdJPeDegLfkQkhb0CrV+cA==
X-Proofpoint-GUID: 62qJ_PJK6dKNARN2HkIbo2Fmi-nXKqvL
X-Proofpoint-ORIG-GUID: 62qJ_PJK6dKNARN2HkIbo2Fmi-nXKqvL

resctl uses remap_pfn_range(), but holds a mutex over the
operation. Therefore, establish the mutex in mmap_prepare(), release it in
mmap_complete() and release it in mmap_abort() should the operation fail.

Otherwise, we simply make use of the remap_pfn_range_[prepare/complete]()
remap PFN range variants in an ordinary way.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/resctrl/pseudo_lock.c | 56 +++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index 87bbc2605de1..6d18ffde6a94 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -995,7 +995,8 @@ static const struct vm_operations_struct pseudo_mmap_ops = {
 	.mremap = pseudo_lock_dev_mremap,
 };
 
-static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
+static int pseudo_lock_dev_mmap_complete(struct file *filp, struct vm_area_struct *vma,
+					 const void *context)
 {
 	unsigned long vsize = vma->vm_end - vma->vm_start;
 	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
@@ -1004,6 +1005,40 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
 	unsigned long physical;
 	unsigned long psize;
 
+	rdtgrp = filp->private_data;
+	plr = rdtgrp->plr;
+
+	physical = __pa(plr->kmem) >> PAGE_SHIFT;
+	psize = plr->size - off;
+
+	memset(plr->kmem + off, 0, vsize);
+
+	if (remap_pfn_range_complete(vma, vma->vm_start, physical + vma->vm_pgoff,
+			    vsize, vma->vm_page_prot)) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -EAGAIN;
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
+static void pseudo_lock_dev_mmap_abort(const struct file *filp,
+				       const void *vm_private_data,
+				       const void *context)
+{
+	mutex_unlock(&rdtgroup_mutex);
+}
+
+static int pseudo_lock_dev_mmap_prepare(struct vm_area_desc *desc)
+{
+	unsigned long vsize = vma_desc_size(desc);
+	unsigned long off = desc->pgoff << PAGE_SHIFT;
+	struct file *filp = desc->file;
+	struct pseudo_lock_region *plr;
+	struct rdtgroup *rdtgrp;
+	unsigned long psize;
+
 	mutex_lock(&rdtgroup_mutex);
 
 	rdtgrp = filp->private_data;
@@ -1031,7 +1066,6 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
-	physical = __pa(plr->kmem) >> PAGE_SHIFT;
 	psize = plr->size - off;
 
 	if (off > plr->size) {
@@ -1043,7 +1077,7 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
 	 * Ensure changes are carried directly to the memory being mapped,
 	 * do not allow copy-on-write mapping.
 	 */
-	if (!(vma->vm_flags & VM_SHARED)) {
+	if (!(desc->vm_flags & VM_SHARED)) {
 		mutex_unlock(&rdtgroup_mutex);
 		return -EINVAL;
 	}
@@ -1053,15 +1087,11 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
 		return -ENOSPC;
 	}
 
-	memset(plr->kmem + off, 0, vsize);
+	/* No CoW allowed so don't need to specify pfn. */
+	remap_pfn_range_prepare(desc, 0);
+	desc->vm_ops = &pseudo_mmap_ops;
 
-	if (remap_pfn_range(vma, vma->vm_start, physical + vma->vm_pgoff,
-			    vsize, vma->vm_page_prot)) {
-		mutex_unlock(&rdtgroup_mutex);
-		return -EAGAIN;
-	}
-	vma->vm_ops = &pseudo_mmap_ops;
-	mutex_unlock(&rdtgroup_mutex);
+	/* mutex will be release in mmap_complete or mmap_abort. */
 	return 0;
 }
 
@@ -1071,7 +1101,9 @@ static const struct file_operations pseudo_lock_dev_fops = {
 	.write =	NULL,
 	.open =		pseudo_lock_dev_open,
 	.release =	pseudo_lock_dev_release,
-	.mmap =		pseudo_lock_dev_mmap,
+	.mmap_prepare =	pseudo_lock_dev_mmap_prepare,
+	.mmap_complete = pseudo_lock_dev_mmap_complete,
+	.mmap_abort =	pseudo_lock_dev_mmap_abort,
 };
 
 int rdt_pseudo_lock_init(void)
-- 
2.51.0


