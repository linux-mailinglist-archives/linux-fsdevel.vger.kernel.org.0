Return-Path: <linux-fsdevel+bounces-61824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D868B5A17C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 21:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5752F7B5FF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6F927CB04;
	Tue, 16 Sep 2025 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H1uJWz6N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rzBFg6mV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF1C25DAEA;
	Tue, 16 Sep 2025 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051167; cv=fail; b=MWZyd32eNrMdTPBMOrdIiuWapXUIqdwSuZj+uZdmuDIe/1bcaZLPoXrtl19+2TP6HpH/bzU9RsnQvY4Sdpnlg45kITVRIl8IgEKbGNRCp2QgHfXHoUJ5l4jskyKS/dMQEEpMxNd2wdFeGc6USMbFDbTZpiDiUSSKvCpjMepMs6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051167; c=relaxed/simple;
	bh=lPTrodf3FYRUZqbPLLWqx3p2lUQ8/iNq5aTgKZeNxIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X+wR2mW2rQPMGXngGzWVfMti+Jg5Be4wIYoD9C87sYZ8FdXoyYNq0x6nxO4xsV4yp/qNkam/FoJewYN6woD7lrbTPoUvUa+DPvEodOb5hQ9Rs8Q+8jCh0xUw08Fnf+Bcqtmq+7bbtxR4kNO9Nr9fdgCZ+sum0jZ299DDD+W9C+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H1uJWz6N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rzBFg6mV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GINJl1006691;
	Tue, 16 Sep 2025 19:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fmM3kGwC1DZVg8up3Y
	Vot4Kh6jTKFC9LjBWtH9yPTOc=; b=H1uJWz6NbLQZmSMF1RxuoFvUUKbEaHcdre
	wNMfcAXU+Prs4EXBneo93QXFkrd1AdrBXohNjv7LS+9st56bmyksM1IkSYSW8VwN
	SNDexav6n6m9uoXaQYLuBbmHBB0C947AWC1ATyKUqO+jLQlEGetTgaqphsTSkyYt
	pcbG++r/XVZol4PLJbDoQH2GKtDRrWKkZU6xcQje3lVP93jA+3BmzjZMPs92rMib
	qj3ugJPMccjPokFQG08RDqWgVV8vcD5aSxFYKqarQCTpWEJ57XaJSHvtUwk97GhH
	MXB563WJf4NVciA0t+eTjr0M/1mBCHGPnoXSwgKanxY2lkja0h8w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950nf5hn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 19:32:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GJ441W028830;
	Tue, 16 Sep 2025 19:32:03 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ctrgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 19:32:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsxq898qdbPTyf34EXzvRUmlh6ekRCzMrbV37KuctrdK2kXBnuRdeECcdC/r3/yeSMJ43tpfZHKTlYK4ll47zOIPBefg3pFVHVreqLinwQmZQFzqmCHk1t3ecJEw3r/I9MuVYYrMmZvwy+KiRmBurHakBpwgu1DFNVWQIhbX9bQlH7ywe2iGinGLy/89uIYBtm2S1VLqQ1YK6xSWdKUt5afCiRvyQuAhyyJv/GXbdcwkFBcsvFW4IUxbXCkl+d9XNUKe+DsekSlDzRIyXC641GSyFRF4xBF0EGwVj6NBL8Uz6NLdF5FsKXQq+xYMRmjbQFvE2droA4E9P7z05oIKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmM3kGwC1DZVg8up3YVot4Kh6jTKFC9LjBWtH9yPTOc=;
 b=nXinakB4LTyDwwvuZQ9MB2Drv0fg2ZHyRxC5OzzirrFvnwZE5GDdCERCoItTj8mTaUo2A0FEWdtVgtqwEpV9h54Qx7S/ZXDh6Xrjha1jrZIDnRIa+Co86HTSuX3a/lZu2oFmrAd3YqbcHDQ5tr4nNWOKeo32/DLQPklH6+ZEmPsguZXb0n2I1OS4MoCzQ6v33iyMXKMw9QusSfDpZwThxcOWZ5uHchCgb6lUOZBZpR8uZazy5CJ2tEQOXM0kuE5Y/1v1vdNBjwMRMADAhFwWljCNT7MisOxKikNZg1l/7sN+v/F+z74K1Lzm7zB5yPNzF6yHb/kBvC/qxOcmdAM87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmM3kGwC1DZVg8up3YVot4Kh6jTKFC9LjBWtH9yPTOc=;
 b=rzBFg6mVesBJwczRrM4J6pMGH1cHFqPySu5psxEcT0EHANdAYEWZFEos9lQKRVcukTXiPxGnPxE2J9Gjx9lMN4NiJgs9KxiTmqjncCAylWppwMsZZG3QN/IivoDBHZR0Df1KLvMwh164OMimuXf2bszxQntf9xPLI80qg5JYpGY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5662.namprd10.prod.outlook.com (2603:10b6:a03:3dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:31:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 19:31:55 +0000
Date: Tue, 16 Sep 2025 20:31:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
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
        kasan-dev@googlegroups.com, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 08/13] mm: add ability to take further action in
 vm_area_desc
Message-ID: <1b013d8d-47c8-4a74-8d7b-4cd8d3b8f2e2@lucifer.local>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <9171f81e64fcb94243703aa9a7da822b5f2ff302.1758031792.git.lorenzo.stoakes@oracle.com>
 <20250916172836.GQ1086830@nvidia.com>
 <1d78a0f4-5057-4c68-94d0-6e07cedf3ae7@lucifer.local>
 <20250916180854.GV1086830@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916180854.GV1086830@nvidia.com>
X-ClientProxiedBy: LO4P123CA0479.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1c2554-3191-4d84-e923-08ddf557b21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T8gcFybaVkIKxcOqXlzoPrrYtAj84pk92aE7jTmN12NCuBzzgZcApe/KM2mT?=
 =?us-ascii?Q?edoJzqYsoPWNvx1UFrNsBl5Dczy1CzWCOgQR9fu50nJUok7WVIA/6yTF1zXB?=
 =?us-ascii?Q?emtRiw07qqjIiOwlrObfGbNGrhkIHOHp4M7PHTnQnbaxKdjCQ2cPV4LpoMWg?=
 =?us-ascii?Q?BC2JBz1hP5q+EQlv8DVrt2Xxh4DLwZNnj0rCDfWhO778jH+POpe/u6jKB6m7?=
 =?us-ascii?Q?pj3jKIK81H4dWlobNEdMBb32cUdKKOYf3Li87/vgBuSb98ZIC+WJKinqAweF?=
 =?us-ascii?Q?BlG5zOqvOKzSInZ4977jk8drpQD7RCNYrMWwxX5FGD+RgdlRZjO7I5H5CV6a?=
 =?us-ascii?Q?7o9r2emx9JuPZpjtXXcrZZwWU02ARTOBKOUsTVpwskb3GAkW7iActGqBdEFO?=
 =?us-ascii?Q?3vGymFdJLwkYP7x51qNY0O3btys4MozBLQ1GklcmNe6TPzyI4ZO+O5y5zZEh?=
 =?us-ascii?Q?T8OkKnChuu4QeAUwaXO9nt/Q2VKPDJFFscw8kXkUPU53TeHuhgXAFPu10bMf?=
 =?us-ascii?Q?Prez9RqIiweYo79zMN59c2bXItOBB5X3ruVtDb7wZg+ApX3ibPPe5ND3LaEB?=
 =?us-ascii?Q?SAUZ7oMmKsVzdVtLKBcoosAr9OM+UFKlJTj62HQlnJwFr+TTjpIgiQlDMM3N?=
 =?us-ascii?Q?wYGz1j70pN4LC3mi3xw8Pc4yuQYDwZWOcrGfUD6ualIREN3PilNivyKXxNYx?=
 =?us-ascii?Q?PzzXWyE03hXnREf51W3z1Ce/kSq28FAl4XKJ9ljQwzfMckXrwrXwlVfi7IuK?=
 =?us-ascii?Q?kh3sX0aJJyQOMkjhy+/Dx8bQzoophDnpNN/HoNOio6AH84Ae52GS+S4uThmr?=
 =?us-ascii?Q?7LBWJjUQinQDnZsNNB8qZTLLFNNoPqG4VcFgPubqecfbyBm+jpOjIlbEorlf?=
 =?us-ascii?Q?2n8tya34PfCM4vrBfirc6GnBctdeV4Yth4xC3YKB0B4ZKjk3fk/czQKyZgnu?=
 =?us-ascii?Q?Yz9GHwpFJZoUlFPQnMyjCv/R8aQAZfv/gk5rGUszNJTjz1KoOE7BR9UuHRX0?=
 =?us-ascii?Q?lvqFeOuG6AQZvEGH7VlBcNZFhAQZYkdUXXg3XypVdbBgpIcIlY8/LdhKp5f4?=
 =?us-ascii?Q?x0jYyyXI10OiViiJhQFEPejILa79TKbjblxtwnsgpcdvDJWRbnqV/gte55z8?=
 =?us-ascii?Q?nc/fkFouG9LMNjPpFKSo6lGYmQPnXSZ2OsqOnS8tTaYRh+lcjFfOKSpvWKNS?=
 =?us-ascii?Q?cgqaodfS1lffRVUa4pwgtEf7AnntyDyoc35JW/JBd8rZKhvK78ldRBZ/hR4c?=
 =?us-ascii?Q?svUEZ7U56l8/Nz8YsJ1SKXktWTrjGeSCOi1rQvRHn+1y7nOCYEjiQnPR6/36?=
 =?us-ascii?Q?2aT3Sr9kH9kweJz/nlmyjmFsORmAU3kw2oMb5tFIjTiTRbcKtZzyoym4yro1?=
 =?us-ascii?Q?lifEil8gIqWReNAciWOGEtnlt8/67VWn736PElMQDK9dF3+25oQuz1+0He6e?=
 =?us-ascii?Q?zwnxMVnqCA0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xwOd7axHE1F0lA5nrxlPqwFcbb/YeDX/HD+/EZTOLqmcCic4o3S74DwPAR9T?=
 =?us-ascii?Q?MPkbdlhY01uw9eH9RLUH5MCkvsH4e3UDaKJCy0QRh83JyiyVgQqOoM7cOjpT?=
 =?us-ascii?Q?kccc9XFUp17sEWvqwibu88oWxDNrvpygHj8ScM7ADlFt+FOSrfLh/OagjNyx?=
 =?us-ascii?Q?wctlxwXvAJsw9AdNlYr2ix5ZE3MX5asy51omjgVmQSdrrdcIH1VN/HZiCiTk?=
 =?us-ascii?Q?C8hFGZIu/GGvD9cLs5rdkDVmGcjnW2rdsM2DdWPBj3I10FlhWv8aNlLPpmvj?=
 =?us-ascii?Q?pzkTFC6+qOxiCuGoVwG65w5bR5/7ZnYO+zbi5EuDbe2mqfss4YYUZnq/FhqY?=
 =?us-ascii?Q?qCpfpPoZBszXjzcam9mh14E0YdS6PYTsH6gPnd3PrGPYItBnXWVekC88Vy70?=
 =?us-ascii?Q?JWocruYqZROViOnioRnyAtohFs0PN/Ep/WHiMVVsWahBe93g/iFf8lKxpTtE?=
 =?us-ascii?Q?Bbib7U9jXKtdWtjA1hXuQY7ZacvIdxX/UVTGptVmx9CXHWnz1Y8Fxhh3IVhJ?=
 =?us-ascii?Q?3CvnEPZ5i/kFIoEb7jjH2x5IIj/bOz94olDrIhzD1Cpl6YjtjBkePK8tM6mx?=
 =?us-ascii?Q?j6lgJYtY3DPsjF0CST75Dd8ZSz7uRKgg1S9AHBUPLhltxPrp3fEiNAY8F34T?=
 =?us-ascii?Q?xH8Q/tbpXliyU+fzFairwmsANV4GuwdUsPYtxvEw7tTN0BIGX3fQscGbVF7a?=
 =?us-ascii?Q?EJyhpW+s/U4j8Dx9+6VcdxFxA3BGFLZYG/7h72KKIyZio5HSFcwDItsOmaoG?=
 =?us-ascii?Q?OgYDWIwhxKyldUFkvMFEXC3zoY6MlaKvUjZcr0dGq4z8v4gtojjB9gh7+MRn?=
 =?us-ascii?Q?aFWzqx0fKBn+qHsNw0BoEgWpnfW5c6py+Q4zguj6BG2BrnpyBSL3lGdabVSp?=
 =?us-ascii?Q?i7w0RuLENqgOapah6j4O9uOYl4FVyfpx4ht0qx2bPLJEp6uwZnlM66OfP39f?=
 =?us-ascii?Q?m71LxbdPrwcCL4hs9IS7QqoxO73+pA3qlbOfHK24X8hcRfy2Ydq/UsYkFUIL?=
 =?us-ascii?Q?4HTlySQg9KbbA/oAbjTiNFVO0VZfiZ8RObrdhwsykAwlP5w/O4mebs4fp2sj?=
 =?us-ascii?Q?9fHsD66p5C5xpPuaXVJjcSsWfsePOPncIVDLn5IXSGmRKX5QGklCfyXml9HR?=
 =?us-ascii?Q?j1K34lIxL6grHxgJbxHFywN15G+qP8gw6uWegapvEbAxIp96KMumqFrqsH5Y?=
 =?us-ascii?Q?/QuadQW3tX0sNOpBurXr+x8XeQ4A06Rhwq0C84OPAajYniEKM9bVTLK5doM3?=
 =?us-ascii?Q?ljulFLhPzG2hXZoRcH2ej01nq62/9mx+kYxLneBjMMth6W45apYdmTfoAKRZ?=
 =?us-ascii?Q?IHfwTkHVo282LzqmUGV2AI/QXeiysIkdlgQoj9yso+sqMlOHNI8cvLFGOFVH?=
 =?us-ascii?Q?nvJq/mmXCZA2VV9Bt3u9jrEIcUcqVvP3iLeA83TLg0uEHYzG3JySTAGzoHPG?=
 =?us-ascii?Q?07z9Kj3dqopALuASL1Q/Y9n3SOl8/ZLL8jjBW+YkJVZABR7cSjFi3AfMAy/X?=
 =?us-ascii?Q?u8sUvbEJa4pcW94gsEZj/j1OSpPjq/J/TUoKwepMo479mWGXPvgYezzYJrTN?=
 =?us-ascii?Q?bTY+6pmixsQfwvvqE5dKacswxDRRHNo0KkPcH9HDJ4Fh7mO9S4DkpzKbxwKr?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h6+xnRqHmfj9DkBaZ9IcbVOu75NbRNC3gc3HAs+v1BhS1bve9pRtI5R1QAG+BrMn6siSE4f0E0sXsbPozWDEOobD2/FdInjm7n8d+i7RLy97XUf0pG5F/yRytdOBoxay75unE3Dn9seSdv8UFIeFnVm/TV8xdVUSeyU4GD8YtX1ZcdRq8xozoMpT2lUiO0B4OLhQBKWNI10+Jy58k/PCMZUbmZHoo3+59dPkVwcOuZFREjheEcpyYZQ2K+ixLdur9rlWwuLDzPH7Z3IdbybEkrvhX01L8hY0KJajG2bMxe0D8iUaqlHMK3c+x3pJi3icoBL8AZoWmXXWiTRITshEVCiEr5mXJQk9Lq7WQm+fKZcje2KD2zARZbR8S78dzUGzIG4zy3pbBn14gBKSpZZkUjvwkqGuJIMrf7JBlt0PvNz4/vOXN/SPkxnoCdolY0EYpHO32m9cfbElbLr55QRcL20N0cfLAxEhWGIBdkM/lcsfsKHO5BrmtqCtHS55AkXDgfepGCDEb/GbVZiqictNXXQPWXgd7jmx/q6DF1o0zLclEkSLzeUpmaEkbA1wL6wts4J2x0sRxnFuiibPoHFnm6cbNU0Zt33IklXBf9Yx0ko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1c2554-3191-4d84-e923-08ddf557b21f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:31:55.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTjLEWCjfaaWZLiBukM/Qr7S01OVaaZrImiAaStAvsKdMxCs9iFIleEPxIVbIYKIjT8sPPQWuEhki0udqXiwtQokzn6j2dzje2cCHJMm2Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=886 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160181
X-Authority-Analysis: v=2.4 cv=S7vZwJsP c=1 sm=1 tr=0 ts=68c9bb34 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=KN18-bPwZsZEZmGrWHEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX/NSCRlVxDrkT
 LY1xK7WNeE+D46eCs9f4QXgOyIdJ/Olm9SHmQwkeTiGqL4EBwpnb9+uuJEEhRewqyFrP7Izdh66
 HGaieQdyY1pBZeU1u578adWiZ/5/ofvOhgArw9L94SGCjRQm4IcPENb93lB1cVdiyQ9lwUOxQe3
 2KZxn5c6by0aCIH3mHDwd1NNhDhW861S4I3u61Uuer/G+XxLmbq2hOGJrQD8+3VWRXt3xFuiAE5
 H4Cill4+296LmKHVkvQyWOAoQ7faDhbV4A9ZDgZIA9w9h9vSD9q5dqoER7dbfjGrUumJxBYGfBt
 iy6PcJG22Hgtug/x45NnoH8CE0YtntoaWi3xljw7xlkbh4Y0zh7uNK0IGcFUtDRuT/XBAptagEp
 h2dfrg+V
X-Proofpoint-ORIG-GUID: GuaEfXtXjDhLYWV1IReCdoaiZfV8RRjK
X-Proofpoint-GUID: GuaEfXtXjDhLYWV1IReCdoaiZfV8RRjK

On Tue, Sep 16, 2025 at 03:08:54PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 16, 2025 at 06:57:56PM +0100, Lorenzo Stoakes wrote:
> > > > +	/*
> > > > +	 * If an error occurs, unmap the VMA altogether and return an error. We
> > > > +	 * only clear the newly allocated VMA, since this function is only
> > > > +	 * invoked if we do NOT merge, so we only clean up the VMA we created.
> > > > +	 */
> > > > +	if (err) {
> > > > +		const size_t len = vma_pages(vma) << PAGE_SHIFT;
> > > > +
> > > > +		do_munmap(current->mm, vma->vm_start, len, NULL);
> > > > +
> > > > +		if (action->error_hook) {
> > > > +			/* We may want to filter the error. */
> > > > +			err = action->error_hook(err);
> > > > +
> > > > +			/* The caller should not clear the error. */
> > > > +			VM_WARN_ON_ONCE(!err);
> > > > +		}
> > > > +		return err;
> > > > +	}
> > > Also seems like this cleanup wants to be in a function that is not
> > > protected by #ifdef nommu since the code is identical on both branches.
> >
> > Not sure which cleanup you mean, this is new code :)
>
> I mean the code I quoted right abouve that cleans up the VMA on
> error.. It is always the same finishing sequence, there is no nommu
> dependency in it.

Ah right yeah.

I wonder if it's useful if err != 0 for nommu anyway.

>
> Just put it all in some "finish mmap complete" function and call it in
> both mmu and nommu versions.

Ack!

>
> Jason
>

Cheers, Lorenzo

