Return-Path: <linux-fsdevel+bounces-60497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85690B48B48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36F3189A764
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC022FC894;
	Mon,  8 Sep 2025 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M9CtjXIZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mwLqEXZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926D2FABE0;
	Mon,  8 Sep 2025 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329915; cv=fail; b=dYUecssYFRD3BhU4OkIENBlRyA28riFGimfe/KtunEgyqisOm+cz+vgMoZ21qFj1aA9NONKS0WGSxo/S/ajDXmFlkRSO2DaGJbAnFEOuWtQDJTlMNlqQ9OGC5Y/tDg3JUWwpaH8hP7vCFdyc5vrfGQ60yej3lSxEBvb6WVeOysI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329915; c=relaxed/simple;
	bh=Rad96xmPOPuAVUJU+GDHPHqUSOF25+W3DPFkIhSETEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rEltznDt5CQjuzXHsXpk3DD8O1AjcpOX0x478Q2ZI7gv9AlshOlIYwmISuSySh1OSUkuNLMLydIZF+dFLstzb2+DJO/EEZJyGr6mb4SZkHB6dpQbuOIn8rhDan4Ry5Fb71HAMuauIXpuVMHBPmP23t2r0LRAO/VABX9UN94uIK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M9CtjXIZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mwLqEXZp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588AslGp014174;
	Mon, 8 Sep 2025 11:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pL1MLIyM+lpD3P2VKweUt4QE5E6fudtOt5d2EzeVtWY=; b=
	M9CtjXIZEvdTrUmgIaMXVEftkPxdq8hM/KSr78E6SX7JblCDsLL/yQpg67fSUTZT
	4l6ZQmXAK8/bGQo4TFKCuHNGHcoKuYAP9j/vchFgzJluDSx4T50T033Dr2PnoQPt
	5m3YO8+CnXlUm+EnpG9lrqZ0Eh3d987m/Tc+lH/2Tzh/xfXuvshqRM3dkpxvwJXH
	rXTVUwdcVTgNQOZxp/WEU2NUzsw3QNt5RwKn0FR8UBKTMW/V8hlAv/3EBlShF28F
	jOra2Xbj9uXo9GDoTuAamYmjLO0L5uKSiIYIU0adyaj3ifUIdWGzf40Re4V5bCtB
	U4X0Ygi/i6Ii2nfkH1hrGA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491wt5g0xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5889Z6Rk032941;
	Mon, 8 Sep 2025 11:11:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd91qvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcuWATvRbXHpFV7MkTNlLvLjeu55leBwCPqqOsNK1PPAELDNWsg73k5OWpza21dIN970SvHDV/0PD0RykH/J6fFWFEUH6TsVQ4f8f4a+XCPe+FVjKBk2zO/IrT/HBsnm4NnDM/HR5I7g2c4Z1rglgG6XGs2cfRpRE1KAUKV15/PFdEJnp80Dl+A2OS3Cda7PQa+cth9Mm0jAHygsMuWFmzF0FfDd0PNw0370BZVOlp6PShk+Ih3SGwcL6906peRaIE3aFA27nCc3w4lqYD4lVhMY+r2kXdakCTqjx/tYi64r3AYzoyLOWLw80s4FZ9+hPv7yW4Kg3H2G+Zm05ARh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL1MLIyM+lpD3P2VKweUt4QE5E6fudtOt5d2EzeVtWY=;
 b=HMFs+uQztcVlhTTqVRtodFOXwL5DqR6AObQoCp4Zt8hwt7ZlWWuipBGdl79h4qfwHjjRuUShjq4ymPpXwYux6UC6RZhCMiqsjMvtTK3zOKhC+VtW+XaabrTH7p51Ur2q5bJCl6aEI/qQPsWaIcZy2pwBzi6+D3xCKNPPLtgG6q2WmnTODGEN0uSi7sP5vaacV5Y9jBNMZjNB8fZwmTn8vKLLCo20N+wAOxAV+2Lgy1Ou5C4PjrvaXubm6Rnk8e4oS1D8g4jmzsvwYniN/kHxRaKCyJ9SkJAIjl5MvRZpYRWfcMWduIYqCMpkKiIq6XgZXM3ag9gD5GGbb5laI/cdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL1MLIyM+lpD3P2VKweUt4QE5E6fudtOt5d2EzeVtWY=;
 b=mwLqEXZpfmFV1rwUFuoki84C4iL2D9dR80tPFrcFKKISddizVOea4a6yTjMpgnZsEwbofnAUcA2DbRrCLCZxxYqjlCfcc6j5hQrRnk7onBI5YsJyFn1EQmQ3KfN6U+RzXyGx20TlV2OyEwe1iPk/Nd2S22Ffq/moE0YpRR3z1dw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7155.namprd10.prod.outlook.com (2603:10b6:8:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:11:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:11:09 +0000
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
Subject: [PATCH 03/16] mm: add vma_desc_size(), vma_desc_pages() helpers
Date: Mon,  8 Sep 2025 12:10:34 +0100
Message-ID: <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AFD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::312) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 54edb3c3-9a1e-4bf9-f9c1-08ddeec86a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SNDLVudx6MAZQrdjunK0yS3T3zcxM7Pg44l6N5JB5ZC6Zl17rigKA5mNqYUg?=
 =?us-ascii?Q?3WtkNJuYBNcqhcD/gKi5BBrRL7tBDYJRUsKbHMAueGBpM31RjxfIdY0hv4fj?=
 =?us-ascii?Q?ardp1BC/PI8Zm5s9bpAvC7Tl93xOROeiCQyEx8PExSZZaGln3hKtfwAgLQxy?=
 =?us-ascii?Q?HhjKWWVRe413ZAqkuwaFq+aQWoXN9D9ILCPsDOkBRG282ggt4VrpuntFAmBT?=
 =?us-ascii?Q?KFr6QL4kpqS8GPhqTE/rrjfSG7dYcu0sj7li9rRmHwy9yKtxFMxbCxUZJaSn?=
 =?us-ascii?Q?Hb1ZKM0RyAY5xqEwsVz1DLQbx0yKBLkNe78hkEwmApS2cXnNCz3dP/Y3Oa0s?=
 =?us-ascii?Q?LoRPzTMG7hyBKthGiiu7wTjnpri15BoehmNnzPqp0n5fDjVfA0WmptpO3Vuu?=
 =?us-ascii?Q?8BoaCmiTZvu0o6ExXlpMW1PhbIinCaNjvMuXTuCTVtEtJGYcyOyxUUvJTeuC?=
 =?us-ascii?Q?5HR3t0McBdnkmOK/ek+J3PHcvtsq6J6yTQc9+s6HU168aYVOEG+P0yUCgwIW?=
 =?us-ascii?Q?7FknKl8AXA6Esl6Zn9U5ixe38UpM2KDdCTnhACWX49Sxqa44EJfGEhYIA5ce?=
 =?us-ascii?Q?ZaZ17a4S2aFLGCL+t+kXfteXzV0ux+H569ucX1mBKYWhwt4z4C1x2EGheE4j?=
 =?us-ascii?Q?KMPQ4DfcgzoNLIEiXuqkAjyySYDbeMIxhhwT3ZPfkpxHu8t7E2wSyXUlmcan?=
 =?us-ascii?Q?PH1NmqzltzWI95XYKvzbHvWeZSDOCrLin3UM6+YAIx5i7bDEL0LN56xqN6Ed?=
 =?us-ascii?Q?2EqNDlO1zccNqEqhwWRxuvKVe3xNyZU0eX+jP9BPEpr+MGZ55jg2ulaTiR+w?=
 =?us-ascii?Q?CIRdBeyi/F7Vlcg/3Zdhr5dhbAYliHOvP8VogU8EQRFaHiunnSrX5sfvSB+Z?=
 =?us-ascii?Q?XJdSdaymGcZh8RwYQrdvs0z8qlKCDl8OhaYbsdzVLOkYqCewab55iYiwmokO?=
 =?us-ascii?Q?F7P7KVM38TPmqviQ0VHNjJlXrXgeLnpoY8RrTeh7g4vCQinkm5wdhb0u97Bq?=
 =?us-ascii?Q?j6MQNDwknG/Blc+iwNiX86xVXGZNJBPX6ns1C+JIQCpqtHsMK0iVO/xyqIJo?=
 =?us-ascii?Q?mtVjWPdFm2S36yBYAvBFbvXycZI3c8Gs7qBEyfnnqDXfeSTkRaaprlcvUnEW?=
 =?us-ascii?Q?cNWLTinWaDNoi32vXH3OhbElYm2mVVFFtyVSzKtrmDVDl7/V7TSWl/kxbtrY?=
 =?us-ascii?Q?Iq65TL/kDB1c4pQikYy1eVJmJ3yZr0YMWAaRaQKdl4uh+VKZ9pBl0PYJZ6V4?=
 =?us-ascii?Q?KTnhCFbSF7hZnc+58g8+07x45OT+V6awg093wD0mbDnIYygs7CvAsKW6HzII?=
 =?us-ascii?Q?fsYHvVyCxhpSdg4r7Bnacrl7Qd2CT0vMboGT90s/MvSt4MKaGMPemTjpIMCs?=
 =?us-ascii?Q?jwJIU1E3z7rExzst8mQKeDiVe7i8iATFrm3aRpqhGDdTCDZE61jWmSqDoonh?=
 =?us-ascii?Q?RaiPlcpN2EI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QyyOY5pB7CUNFSAz5ub2y1JjcVjSUsIXj+wjciDDkC1CSHTjvyhWhf2Ygoxr?=
 =?us-ascii?Q?eZ29wwMi00CvHBiZFNQ99Lm2581tl5fB7fKTwLfiiVNEK2oWbEL9RACjtcDI?=
 =?us-ascii?Q?YIiJ8BhQMSY9xT+/rrdyUH80STLUiLbFDe05SugcZ0VO52Mquxpg2dC/MOBe?=
 =?us-ascii?Q?1MI9zSlKqdZETlQ7WSQ0Y9J45t6smIjNMuHRU7E/JJ5BUILws/uZQ0DWbbNg?=
 =?us-ascii?Q?EUCGP0gXPK2YBdwx+RhvkwvK6bpFK/osIxPkkbwTrKxC/M/4DuPn1fe5aZ/j?=
 =?us-ascii?Q?8H8hF8pulqseILBaIJOXB7XoCpj02aP7Qi8RU4jHTVy3VU5jys2pmP1yCUwp?=
 =?us-ascii?Q?pFn1k2JY7WYecOn5JI8FmX5z64fsur6NpiQ19CTlkGkdnaTb2kbq2tC7SWBK?=
 =?us-ascii?Q?KIi6TMyqxHozfXs2wioBFl60ByJ2O0kWgL1zAMGnVBdLyqxDEHCNE+Sn25zu?=
 =?us-ascii?Q?WWcnsBbcjYQk4gS1ppQ/RUHpaud0p9fhKvDzoa/v1t+pO94QMdJqwCh3Cw79?=
 =?us-ascii?Q?hZn5tRDr8vDe4jUMtYDquW+DBapkWwO7KWKLnSyqkdinXvccp8FPzXCcsnYd?=
 =?us-ascii?Q?5QXOohMa0d1KzXBckBKJ61YkzUue+lwu5Den9ZH4FBJeK6LuyV6h6rlPVCRh?=
 =?us-ascii?Q?fWNb0zX5VioS7YjmA1/FcubSEikxqw3c6iElrOtIcatR7go3wgWl3ykIL3go?=
 =?us-ascii?Q?Ny1IE4UL/6oSJQlfXSrYQ2PwDZpoTfrku0er1p9nzhWGOePwdQ5KJfZNS9Ok?=
 =?us-ascii?Q?B/nCjN93P+yjswgtjX532NMUfPcsXpPdUDRxI9/Z7YgukMqdCa02wQOGnDxp?=
 =?us-ascii?Q?m6IptCfRaWm8l/xrRhoO8VMZ4CIjIBo1sSnmNHcN8LPkWaVP5L953DdSYHdT?=
 =?us-ascii?Q?5h5gDduVWvWRJJUNLoEEvWvWhPEEvXrQ8q9qqk5xzIaiuTD7yWAqbmwigYWD?=
 =?us-ascii?Q?bq7pdNJFXtJGD74MlWNU7oJPyFZ4N/ozNHXKW+mqg5U4j1puAOw5Enm1d1fZ?=
 =?us-ascii?Q?0vFMmGQGpK5tlJh+saQY+kKM7xuzg+BHVrLYYnsy/hMAWwpBJjHeQlOYtnmG?=
 =?us-ascii?Q?d/NajV1WBqon2sbFfESyXlY5gCbf2kVOkmatF42B/7biw29TZtaY4F3mFyM1?=
 =?us-ascii?Q?K/rMu/k/IgLcNder1YXU7SQ/ckiwCFDLkk6YM9d2l2WdKKbHohNTFV43YQXL?=
 =?us-ascii?Q?CBQ+3FeUxoad9Lt2uAt1e0dt0fDHA7GakMMWvzvnUOrIkmb3cCHWRZm9s7fi?=
 =?us-ascii?Q?8HJ90LhvaIPXVsSV4N0bDXM9iErZq3GFY5IxNx6xkY7MntW/5DXu2bnPTq+s?=
 =?us-ascii?Q?SilCp0JilF8lOBoSlnPes8eSUqxMC5kQg4342UZD7DNv1LUzVV19JhRn0wV4?=
 =?us-ascii?Q?Haz9SWpy8EKco8U7Oh3moRogkbABp4wYCYU/JjiSqPmz5wa87uXOSows1H7j?=
 =?us-ascii?Q?1Z9p+9/6bHFptOapivptbD8rDQodXQ5ygJDoKxTo+VpEzEQb9TZQM+2Reft9?=
 =?us-ascii?Q?aNjtpzEjCpk8/LkW5k8MAy+fqrhDdIr+uhPubfvu8XRbgJztuSrMXPAZoKDO?=
 =?us-ascii?Q?cgeGfLWa2jiiF6scvaCEZF1TEWxD8JOkMQNBnKR/J5I+E8og5ZE87ftf3ELN?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	979jk3DC0p+Euz+Q5WuZdxfrlrJBxp9SKqNgYfbDAgS9m16p9m3RTexZm0lyA+EgkOFcd1h6wkBiB3AL8M5eckU6Xa/oifDUt4AVd+BfRII+FhDN+rcYOX7i5RFgVzKDFkq3L0Hc8frPyYWWmQ0vL/CHlbCT+CrHRfmxxwbX+FIPOm6iGl6h6z8mU7+46ibIOC3X1dOqhrT7wQDxuPcwdwtkjx8vzpAnPLUBBR/Ytw9evUdEBhT0VqeDq2YW773QQuIwO7PPdBvqJeUerY4zssS3uQFj6pSTVLzK99yb52o+mwNMOfmbDmsp10Im+Doi6LAt0y6wBcoMFy8oOcaStj3OcMv7oqNfn+7Wr1kDBMnbOLQvRo4R3yOSgJU2hx8JeMyyFAK+9oZQ2shqtMHzVUinzcjNqZtQ9ukAfM9NgZCSb9HVjooSenQokK09+rIGcWE93xgbjz4v3byXrggrLCIOlhhQkEbfsi05u7kCLsrU2BEDBRZlYCM2eGf5Fuzm4ZFmx+XZVYYYUdSdG4g8pR42qa0N8eiyDy8SF783E1OagynMXix5OKu77ljoyrEcMuknnXsmN5VJ04R+UIrfdYSYWUcykFiVzTHyc189wa4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54edb3c3-9a1e-4bf9-f9c1-08ddeec86a09
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:11:09.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f445uCyFEgj8OPD+QrAAOCzazPsZAgT8Byb/SdjUE/Za0oBj6TWUEWnfC9otb7i9guMfVfotP93s+H8Y4QyEBy4DedIsIZRlwFMQy1ywOlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080113
X-Authority-Analysis: v=2.4 cv=ON0n3TaB c=1 sm=1 tr=0 ts=68beb9d4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=V8PVCHvh7cpLA54rH4kA:9
X-Proofpoint-ORIG-GUID: MxsvUtBHi9mFrD-wWuHOlDcMemcF5f8r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDExMSBTYWx0ZWRfX1QuTjSbsFxLp
 VDanheOUKBZctKh84pRijwY3sdZx2yje6fYOSPV2qVl3RhZ0aWvgoKN+uSIpt3pssbSBPs2CuR+
 JnDEf/CV4oznseFUDIPf3JDNGlSL8PwUxEcsRpahxz2qCQtbgzSMGUv290TJx7jY+VwDxWnsgvH
 T0p7Bhew0oRgoCK9TYgSWScuxdvG0uHDd969vZNu80i0dL+lAMokuLQiRVKhmc5H1i6Lj9Ai8Oc
 JykTLcGtxDcsBfOHuMQaAAfTDJ8dCwAWJF8HBRmSuOM93WL/Np1qFmX55Lj1t0Im2KrxbLC5Dwb
 KkdwZLb7gGjj0MVXWcXFZ6k6dbSzWsZ6VuOYmWT6odYtsJX878NEsxqXJ69xf4a+sUU/Jxlvo89
 L+NZIUfq
X-Proofpoint-GUID: MxsvUtBHi9mFrD-wWuHOlDcMemcF5f8r

It's useful to be able to determine the size of a VMA descriptor range used
on f_op->mmap_prepare, expressed both in bytes and pages, so add helpers
for both and update code that could make use of it to do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/ntfs3/file.c    |  2 +-
 include/linux/mm.h | 10 ++++++++++
 mm/secretmem.c     |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index c1ece707b195..86eb88f62714 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -304,7 +304,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 
 	if (rw) {
 		u64 to = min_t(loff_t, i_size_read(inode),
-			       from + desc->end - desc->start);
+			       from + vma_desc_size(desc));
 
 		if (is_sparsed(ni)) {
 			/* Allocate clusters for rw map. */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a6bfa46937a8..9d4508b20be3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3560,6 +3560,16 @@ static inline unsigned long vma_pages(const struct vm_area_struct *vma)
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
+static inline unsigned long vma_desc_size(struct vm_area_desc *desc)
+{
+	return desc->end - desc->start;
+}
+
+static inline unsigned long vma_desc_pages(struct vm_area_desc *desc)
+{
+	return vma_desc_size(desc) >> PAGE_SHIFT;
+}
+
 /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 60137305bc20..62066ddb1e9c 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -120,7 +120,7 @@ static int secretmem_release(struct inode *inode, struct file *file)
 
 static int secretmem_mmap_prepare(struct vm_area_desc *desc)
 {
-	const unsigned long len = desc->end - desc->start;
+	const unsigned long len = vma_desc_size(desc);
 
 	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
-- 
2.51.0


