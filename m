Return-Path: <linux-fsdevel+bounces-60844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE1B5221A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D818B176A20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A06307AEA;
	Wed, 10 Sep 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fi10llUb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pjdmcktv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADDE2F1FFE;
	Wed, 10 Sep 2025 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535847; cv=fail; b=cvy2f00crt9vWTQR0rtsL82s69Ka9eLTn4z+pgRbZkBol/oYUNLd19C9Y/i5kNiRBtEC2zDq4RXbFF8Ufg/5nSeldvMkcj1FdE9JVsqSHpkJbrlkOzgnqt76WrKcW/IZiT1zQ0IiXo8p6PT1bz4Rgjh/YP6+S1589XqhW7MMyFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535847; c=relaxed/simple;
	bh=YZZl3g7etaAzi9WKn83ayfW12iAdDJa7mab67U7r6Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yk8+Lggjb/Gm5oCXdchqC40+d3m60W4I2Xpf753C6+o4T14u4VUlgGKdy3fIfNSZ5HXYMLzPgtRDsRa5aIdTqranpABli9rW+FOPIEe0NBgbZw0vQNSnHhy7wI0QDr6tDhmaSYjzqBbxQ0M/0jeLMg0d5w7borKT3ZaJ1oHj8u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fi10llUb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pjdmcktv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfiDk009732;
	Wed, 10 Sep 2025 20:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lZ5N+zGsZpeQkWttl0zoEAfMvGM/6/OQ/1j8dAT6dD0=; b=
	fi10llUbLH1lzL2+KEb/exhmtOBxox+CIHB8lctiF69sSoWYTofwluHkQxyRM2n6
	vCwn1PaxAsh+DG/AV1u5E42aA3bzJqi/3mBtF64Tx5xw9x9lbr1DJW6ErhcTZ0nB
	D1CmNaSPSKSsMckEVNLHkVtxX6WU5ZVphnFuuJkxQbWp7zecLQRufPNJ2O/Ootal
	NpOckpWqPl0IWqPhrV43UscyL0QFY1heYOIWT8pPJayuQyr867oQX1cQi8myLPI4
	aqdZ5mJsTKatDWdaJ9pe43G271gMz4cRMCHxkdtmn6sqxkmyiLgDqLPtAfcxQNr5
	/eJw7ptaW4DPVfFgDJhqHw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shvv34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:23:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AIW1Ji002913;
	Wed, 10 Sep 2025 20:23:25 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdj1ca0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:23:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/bz39UF+a6XtamgVw4oSlQ4o7oD9jKa1OAyo4EIPZCr1n99ukOdeASIZaoKFWfzqXTBzg8DeKjH4DhVMTRVLF0Q1pNmmFnyem1ZGdd5GhA2YaXxnDos1V6Te6dKIT+uW5nC4xHfOPsTI6gO3dFRgHV6G2xTcxWYxP3MC7L2u2vp4GXAihZAxFSu9+5fUQkFZ4PfrHQxw5D5tw+1Rv93E4JQlQ1V64Ab94SDhBITDPxy/IsyWj27lHxqQRw06an1ZX4LmFvGpQ2Nd48MsTxnuzhFu1iv/rHKjONT6wG+EKtmbCqbk1aVgfgW4p1dSzCQpxtB4jR/W0LXLELbpDoBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ5N+zGsZpeQkWttl0zoEAfMvGM/6/OQ/1j8dAT6dD0=;
 b=XUjDgISq/uSCoj+ZGAXSSRo/PQjo6RFkUwt/NhbL0hnrDXpQlV48QB2uz/bPajXQ3le982iHBDDqYlk/oYJ4PbMOsit573vLIAdAycOmEMkZAfN07WRFVzCAI2vJfGirZzX/S+LUeK/s+7hQYzSuj4ES/OjYTUbhfVD2GkFVAQBGcow2hUSKJJiS4M668KI3Aa1J/+OjvsFZQfWLqVy+Zs4bWkhSlA9bUfm9YZY6O6ujTsUEHxPOiJe//HYqISvzBg8WDLN6VplI0iQ2wQunlrbDpWvv/1XfqocezxoT/wkcz8No9NkeCFznR52RtsJbVsm+dxPQV+gPJr8Nq9jhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ5N+zGsZpeQkWttl0zoEAfMvGM/6/OQ/1j8dAT6dD0=;
 b=Pjdmcktvzo5x4dps/CjGn5lMAt8a08plA1i7AZCpm3S7Mt+/WyO/zbLp+Thqr3BzDu6E8U+zUsMFS+Gkm6iIF8Z81sKwneyCSe/lpItUrJO83EYuqZ5kZ0Hm5a991018s6zoQ3AgUPMAe6BJkPW91nOsyVcQnkrkjJYXvB3GkDY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6278.namprd10.prod.outlook.com (2603:10b6:8:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 20:22:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:22:50 +0000
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
Subject: [PATCH v2 08/16] mm: add ability to take further action in vm_area_desc
Date: Wed, 10 Sep 2025 21:22:03 +0100
Message-ID: <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0026.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::29) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 097ecb4f-9e64-4a22-b322-08ddf0a7d06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lgrqZrDmzt+3Zmt5Ab5gMXoGJM1fVp7uWqnSuL8wKMPQoAPgICzTKhKE9sJy?=
 =?us-ascii?Q?n1ciYoUJ/tIUOm5andFZc5xM15r87K8271QiaexCa8JDJp+4hGGd4ULsjpLf?=
 =?us-ascii?Q?cTn15uEc+4ZCOCLpOjmQTdWBTw1bsB5RQuWqbKmRE01UcEmFQ9Rgva95SYkN?=
 =?us-ascii?Q?HQU+BixzqtGFRvX/a3cj89iUM6XMxgg/vhSreevHDFcF+gGL5rYKYwnP3kG3?=
 =?us-ascii?Q?/+oXXrFvU49nP3S2QRuCZel1cj7ydOrfcx68+Mmvb2Fnwyqc68r/TvXsnNVF?=
 =?us-ascii?Q?EBMT2vbTMmrrAshimmt42JoxL4Jmf/7aXBsYfvEb4n56KoNV26gaP4JCNtD8?=
 =?us-ascii?Q?gYq4KeCmjQFbsd7O/XbEPIcbfIriV95M6T8Rn9k5QxsKk/409HQbRS0tkXB8?=
 =?us-ascii?Q?sSLbd8ApV/AvvwcsoEtftJBNcv+BqTVUuIPs8hXq/a73fSZyxg3Pnt9rrPnW?=
 =?us-ascii?Q?CcTNOy9AYulQ9tgi5ivHpw5tQvIC7dr+vXTjYhI1n9KgtCmelJ+eeYstoPec?=
 =?us-ascii?Q?IZNVhJVolewL5WjxOW8mRZ5lKfICy/HMJbtEKammeqcq8H1rH0bs99iw85RC?=
 =?us-ascii?Q?3RRUiwmqH7jNSjMoD8JKUar8koL8BtTyjg9S9toy5PEsXRoz5j8P7RIaWbPD?=
 =?us-ascii?Q?FeGo+gupI2J3Y4OXeJP3iSZbNo/eILmcyuwQ3c/2194oJr7zPOxJeHLaV+BE?=
 =?us-ascii?Q?mnnmSmiTCdzDXesGXPSQcQGlkBhOFMCQ4xkRow04W+KKwALbm5o2yFnUYTM4?=
 =?us-ascii?Q?ZHhYQHmWib6yUoHHNtVY6bU5/TAR8/4OoXaXR/Nbp1dNals+5PGEXxy62RK2?=
 =?us-ascii?Q?ox22vj2UzIWwJgNh/oLhU5xeg3RJ938yxTeSx8dUVIXR15REC6nTbPqq5SZN?=
 =?us-ascii?Q?dsm89yVH23Sf1hCOoMTasAoil3ZrnHwD432k5d17i4h6vqD/WF5Ct/+v0Q2m?=
 =?us-ascii?Q?FAWn1qkRT/7fO8O1jayOfdnKHFwC8iwATVvo3m+ABpAgO6IwWvA6h7u4U332?=
 =?us-ascii?Q?MGgqxk0rp16WrQYwaQFkEsqpOp5gvof0tw8rWjCzEkvewcUwqM4ae96IqaQQ?=
 =?us-ascii?Q?ydN6F05W+gLrJhUiIFXfKYUxRM8rew2zH9sE731PCdq33vhw4mJ+Bptia+KG?=
 =?us-ascii?Q?hCxGu0+qU5nPKxv0A7QfVQYqHfgqzXjVHP+qPeXB6eo0HqLeedbtS804bBAO?=
 =?us-ascii?Q?D2v8fruFVoXl+AD7Hl9Uxl+0qIKQGgOKfn3P4GOuOCBmu5U53jSNbVNLu4M8?=
 =?us-ascii?Q?nZKdFs0XA1W8P91c5v6l/6JaqfceR0re385Dg8CiJKWKEYdptQi7aVTuFV56?=
 =?us-ascii?Q?ZT28e71tD+YT/aSE6dQnrJi8idXGDNUMee8tnXsjS/2aUMU48jvVwcZ30dvA?=
 =?us-ascii?Q?prpJMpD3FGfQAdRnylASm7Jd5cUp5DGdPRAwoRXitJQBVqgJm1/xSAL8Oq61?=
 =?us-ascii?Q?yFh2MRohUog=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uEyqkqX66kZhgLUtauiCByDYnEEfzDRHG3xtkA388VOry6VhIkmHgkUGfep2?=
 =?us-ascii?Q?uFSgdyfYtfOqk2sgWdlPvIQrkzVHzhSsznkRjgmDg3+UuU4bDlAmsBgw+HrK?=
 =?us-ascii?Q?oSEyZDeIsZ+6H/bHRMdDfLfRJkQeVGwoorQQMCBg0lTgbspVzoWyqbHYlKCK?=
 =?us-ascii?Q?qBhnc+oMntFZxkUy+tzWit82ijOuCMMfewwEBveN4ur7f2JpAaj313jg8FA0?=
 =?us-ascii?Q?OMz4xelFti6/WrIIUGuz8uprOY8pi0cmu5MeULMFcyDViid9y9oy0MPAksIB?=
 =?us-ascii?Q?hmjm+Fqdeb8d2v8Nyx/36FFxM3NEUs7vnArEFE6TBt4KeTf/gYHiLpNkgu10?=
 =?us-ascii?Q?7QAJv5uh4an7vSdFypCUYqg7iHuClTW/xG7veSLxbzAQNE6AaY93CVo92S09?=
 =?us-ascii?Q?+iw5dpM5QfHBYJkr0NgF/X1Oj8ykQUpZp0xgaCTa2ozNIi/rOi2Vfluyvfrb?=
 =?us-ascii?Q?QYLlw7Nwjvf7ayAtpD3ieqJ73qSVNe6d4M5PbZfffZScG5fpWfQ+yBmE/AQ/?=
 =?us-ascii?Q?fGNA5LTmX02tp2E1EHGfDY8ZNxDKngLkq+GRtNb0dHwXwRmehisAw6XxuaFG?=
 =?us-ascii?Q?3MazxNyemTUNdfAbYe70Vs5OpDf+Ga/aPLvTM6v5jDzXDTLtlkvnwa944RG2?=
 =?us-ascii?Q?YFKXrPpk2Qp8XCVQJiW+YZd9+9vv+6/BZsRIptnoHmyUU1f2qsEC2FfvKoMa?=
 =?us-ascii?Q?BnySe6T1iTaqwnXJc9vZ98FbvBA59cDRYOSLoemFSeFIOvyhBuJmS64YByCx?=
 =?us-ascii?Q?vP3NeHppWXRt5U1We8yd8BhjWMOK+KaNuSRD9eRlWRJ0Nb5ML4Vov1vOmBk5?=
 =?us-ascii?Q?LvtAZmslBNAgZSTWKVsoZF7+OOoX32w2sD/a2fLtDw+OzyWwWbVpLg9IxS2a?=
 =?us-ascii?Q?iXGlmMWlnJcjI7qjgN6gNOIMBliZBrS74uzMn4OBwopXzDSUxU/LvkZV0dc2?=
 =?us-ascii?Q?gmNsZ0r7XkNaJWsJm3MSfM20LWcS1vA1F5i2vzjNGb7mpXsZIz2kai9Xnqcy?=
 =?us-ascii?Q?+YwkuPTsM4vnJAPPCP65VjoBwTLpGeEtYYFNiQsn4I8sgDpdOQR7MxxRPMFl?=
 =?us-ascii?Q?gxn0uITK9xQ2RZ7ngWijYAve//0WsmDv/c8mmf70RxiGhb9G4cyWs9xQwRcN?=
 =?us-ascii?Q?/EXG7LjsJ2DEXO4NDmbB7oSoaIzEjhzTD6e1G+7Tl2oeCEbTONOTZWvs5ZG4?=
 =?us-ascii?Q?8ohQpTdTJOnqn+sHjXsyMxkoQfmH4vZay8vBY4RS1U9QsfcfoxDMA5ORhrfj?=
 =?us-ascii?Q?s1eBl/jGzd4dPNtPAxoTTjHMVIL6uecvauP4NGHc9H0MvX1q0709bmuUT0kt?=
 =?us-ascii?Q?OeR7dzh15fZgto+XGPSDx2S3qsEIEE97mH8j+RxLIRKJU4PQP73osj/iwSf/?=
 =?us-ascii?Q?8125JX2dLjvHJ7YkdBFHPdWQQ6Ilua0i+FxrGjbNAzL1WV+Qhma+3ZI22bev?=
 =?us-ascii?Q?wRcLaVpWZPecD5R2S02pCJkclOklLo+Ib08R2bNkyOYe3Fi/kJKjmou1XGxb?=
 =?us-ascii?Q?DHxVkjJzp6StP3Z/KqpCAcpMNbg4SiH7TrkA7fkT8p354TRppgyqGnCsbljY?=
 =?us-ascii?Q?Bmz0cvbGDhHor0j8od9LpJ9OxMSwVxLKeMOS7Ppt1u6fY1B7ezztYgwSYuPr?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4PNKWHO/zi+Jz8E8uuS+VUbHw2a7brCl9NT/ZZP89v9ecV6VQoeZkEVvuZmNyre39GCOgYfoiJk46vMclstaVWtasYhD4F7bYuVdtwpD28FGi9IC3aiCadCDvSE4FqxyaOWsJhEKTMdzM0pPZLTl0JIlaKGj3MsIwiJkkiuisGciIw/ah4KBSC67K30vhoA3JCObbJcbsG3pdQmcDd5b90YRB7SHYRc+IwGpEutH+tu8HPsSuKqSJeZCB2xL4NreCnpU9SZKoGHpXh5b1E9N04NfSlV/6O9GGOj/RZ57/ywPxO9F6TcUA9k/Ry+LAJ7ipW/MQzzVGpw/zqzPU48i0wUhcCLD4OTp1lYxpW6gw4cxHpCtvoPQkNcuQ8triFa3l+Up/thFEdENvfh+oCO8CUEah22czPYjzZWMzr2kZID/nBuuWF6/iVs05z/xG9/lExPbECV9tczDVuIxQXjmg3a2WSmvXPwXdh1l4Sky+II6ch6SIVg+WtqmTjI/4AgdMUXEy1Jml5wTqVSpXvxev6/IRe96Lzug77SRF23/4OHRYfnf1Yq/4uJdP+8m3eM/CkUxweUuMWR4z0vyzof43NeZKmns92rsswTD5uiHBXM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097ecb4f-9e64-4a22-b322-08ddf0a7d06b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:22:50.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGabOcRwPcsLT90zdlRNyrTFwPXTeaMeDygZJxDBDaoSWUpajec0HF4yS0zVPYC1DaJD5UPce99LpoBBkvEzSmCqYEXvRyVvQQsS8L7nuV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100190
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c1de3e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=DGlkvfY0CEs1pWa0Jz0A:9 cc=ntf
 awl=host:12084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX6ir1Bv85KV7M
 qHHLT7O7bkElmdmtBl8NOWizhYOUoP4aopOglfE5V61PorgJ9HNeOu8HRwynmSNVQedOTfB0GCp
 iR+U4m/p8ynBw6eVFP9ydTAXxZVG55bRqubU8nR1TXEjNDsSQsCF/7epYm3IaaaS5T+Gs27AE8y
 z9kWKM89atU/lGZcm9rkJXTy8EQlrNKMuwEoMoJ35QtFEvv5A8VaIJOCXAys2LdmhXEnzyfdJNa
 Sc9wz2kDU/YOo/MF0tNI3F/HpsYjFc23fwy4Jhm7ClmKl2tWXVpRM+30rSsWBNAnUBvsRZp6Ajd
 rhtKRBK6OBfbQX5L0h/UtPy554aB+NtKWaphJTEzc+Dvnuqq8Y+Qqoug1VGm5lmst0xG/FXALrh
 BkwftwyhL3cqJTXLXLuecv9jPBidLA==
X-Proofpoint-GUID: lCT8vtzfaDVl9wcQfUgz1Th1ZnCKRJRQ
X-Proofpoint-ORIG-GUID: lCT8vtzfaDVl9wcQfUgz1Th1ZnCKRJRQ

Some drivers/filesystems need to perform additional tasks after the VMA is
set up. This is typically in the form of pre-population.

The forms of pre-population most likely to be performed are a PFN remap or
insertion of a mixed map, so we provide this functionality, ensuring that
we perform the appropriate actions at the appropriate time - that is
setting flags at the point of .mmap_prepare, and performing the actual
remap at the point at which the VMA is fully established.

This prevents the driver from doing anything too crazy with a VMA at any
stage, and we retain complete control over how the mm functionality is
applied.

Unfortunately callers still do often require some kind of custom action, so
we add an optional success/error _hook to allow the caller to do something
after the action has succeeded or failed.

This is done at the point when the VMA has already been established, so the
harm that can be done is limited.

The error hook can be used to filter errors if necessary.

We implement actions as abstracted from the vm_area_desc, so we provide the
ability for custom hooks to invoke actions distinct from the vma
descriptor.

If any error arises on these final actions, we simply unmap the VMA
altogether.

Also update the stacked filesystem compatibility layer to utilise the
action behaviour, and update the VMA tests accordingly.

For drivers which perform truly custom logic, we provide a custom action
hook which is invoked at the point of action execution.

This can then, in turn, update the desc object and perform other actions,
such as partially remapping ranges for instance. We export
vma_desc_action_prepare() and vma_desc_action_complete() for drivers to do
this.

This is performed at a stage where the VMA is already established,
immediately prior to mapping completion, so it is considerably less
problematic than a general mmap hook.

Note that at the point of the action being taken, the VMA is visible via
the rmap, only the VMA write lock is held, so if anything needs to access
the VMA, it is able to.

Essentially the action is taken as if it were performed after the mapping,
but is kept atomic with VMA state.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               |  30 ++++++
 include/linux/mm_types.h         |  61 ++++++++++++
 mm/util.c                        | 150 +++++++++++++++++++++++++++-
 mm/vma.c                         |  70 ++++++++-----
 tools/testing/vma/vma_internal.h | 164 ++++++++++++++++++++++++++++++-
 5 files changed, 447 insertions(+), 28 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cca149bb8ef1..2ceead3ffcf0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3597,6 +3597,36 @@ static inline unsigned long vma_desc_pages(struct vm_area_desc *desc)
 	return vma_desc_size(desc) >> PAGE_SHIFT;
 }
 
+static inline void mmap_action_remap(struct mmap_action *action,
+		unsigned long addr, unsigned long pfn, unsigned long size,
+		pgprot_t pgprot)
+{
+	action->type = MMAP_REMAP_PFN;
+
+	action->remap.addr = addr;
+	action->remap.pfn = pfn;
+	action->remap.size = size;
+	action->remap.pgprot = pgprot;
+}
+
+static inline void mmap_action_mixedmap(struct mmap_action *action,
+		unsigned long addr, unsigned long pfn, unsigned long num_pages)
+{
+	action->type = MMAP_INSERT_MIXED;
+
+	action->mixedmap.addr = addr;
+	action->mixedmap.pfn = pfn;
+	action->mixedmap.num_pages = num_pages;
+}
+
+struct page **mmap_action_mixedmap_pages(struct mmap_action *action,
+		unsigned long addr, unsigned long num_pages);
+
+void mmap_action_prepare(struct mmap_action *action,
+			     struct vm_area_desc *desc);
+int mmap_action_complete(struct mmap_action *action,
+			     struct vm_area_struct *vma);
+
 /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4a441f78340d..ae6c7a0a18a7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -770,6 +770,64 @@ struct pfnmap_track_ctx {
 };
 #endif
 
+/* What action should be taken after an .mmap_prepare call is complete? */
+enum mmap_action_type {
+	MMAP_NOTHING,		 /* Mapping is complete, no further action. */
+	MMAP_REMAP_PFN,		 /* Remap PFN range based on desc->remap. */
+	MMAP_INSERT_MIXED,	 /* Mixed map based on desc->mixedmap. */
+	MMAP_INSERT_MIXED_PAGES, /* Mixed map based on desc->mixedmap_pages. */
+	MMAP_CUSTOM_ACTION,	 /* User-provided hook. */
+};
+
+struct mmap_action {
+	union {
+		/* Remap range. */
+		struct {
+			unsigned long addr;
+			unsigned long pfn;
+			unsigned long size;
+			pgprot_t pgprot;
+		} remap;
+		/* Insert mixed map. */
+		struct {
+			unsigned long addr;
+			unsigned long pfn;
+			unsigned long num_pages;
+		} mixedmap;
+		/* Insert specific mixed map pages. */
+		struct {
+			unsigned long addr;
+			struct page **pages;
+			unsigned long num_pages;
+			/* kfree pages on completion? */
+			bool kfree_pages :1;
+		} mixedmap_pages;
+		struct {
+			int (*action_hook)(struct vm_area_struct *vma);
+		} custom;
+	};
+	enum mmap_action_type type;
+
+	/*
+	 * If specified, this hook is invoked after the selected action has been
+	 * successfully completed. Not that the VMA write lock still held.
+	 *
+	 * The absolute minimum ought to be done here.
+	 *
+	 * Returns 0 on success, or an error code.
+	 */
+	int (*success_hook)(struct vm_area_struct *vma);
+
+	/*
+	 * If specified, this hook is invoked when an error occurred when
+	 * attempting the selection action.
+	 *
+	 * The hook can return an error code in order to filter the error, but
+	 * it is not valid to clear the error here.
+	 */
+	int (*error_hook)(int err);
+};
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
@@ -793,6 +851,9 @@ struct vm_area_desc {
 	/* Write-only fields. */
 	const struct vm_operations_struct *vm_ops;
 	void *private_data;
+
+	/* Take further action? */
+	struct mmap_action action;
 };
 
 /*
diff --git a/mm/util.c b/mm/util.c
index 248f877f629b..11752d67b89c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1155,15 +1155,18 @@ int __compat_vma_mmap_prepare(const struct file_operations *f_op,
 		.vm_file = vma->vm_file,
 		.vm_flags = vma->vm_flags,
 		.page_prot = vma->vm_page_prot,
+
+		.action.type = MMAP_NOTHING, /* Default */
 	};
 	int err;
 
 	err = f_op->mmap_prepare(&desc);
 	if (err)
 		return err;
-	set_vma_from_desc(vma, &desc);
 
-	return 0;
+	mmap_action_prepare(&desc.action, &desc);
+	set_vma_from_desc(vma, &desc);
+	return mmap_action_complete(&desc.action, vma);
 }
 EXPORT_SYMBOL(__compat_vma_mmap_prepare);
 
@@ -1279,6 +1282,149 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
 	}
 }
 
+struct page **mmap_action_mixedmap_pages(struct mmap_action *action,
+		unsigned long addr, unsigned long num_pages)
+{
+	struct page **pages;
+
+	pages = kmalloc_array(num_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return NULL;
+
+	action->type = MMAP_INSERT_MIXED_PAGES;
+
+	action->mixedmap_pages.addr = addr;
+	action->mixedmap_pages.num_pages = num_pages;
+	action->mixedmap_pages.kfree_pages = true;
+	action->mixedmap_pages.pages = pages;
+
+	return pages;
+}
+EXPORT_SYMBOL(mmap_action_mixedmap_pages);
+
+/**
+ * mmap_action_prepare - Perform preparatory setup for an VMA descriptor
+ * action which need to be performed.
+ * @desc: The VMA descriptor to prepare for @action.
+ * @action: The action to perform.
+ *
+ * Other than internal mm use, this is intended to be used by mmap_prepare code
+ * which specifies a custom action hook and needs to prepare for another action
+ * it wishes to perform.
+ */
+void mmap_action_prepare(struct mmap_action *action,
+			     struct vm_area_desc *desc)
+{
+	switch (action->type) {
+	case MMAP_NOTHING:
+	case MMAP_CUSTOM_ACTION:
+		break;
+	case MMAP_REMAP_PFN:
+		remap_pfn_range_prepare(desc, action->remap.pfn);
+		break;
+	case MMAP_INSERT_MIXED:
+	case MMAP_INSERT_MIXED_PAGES:
+		desc->vm_flags |= VM_MIXEDMAP;
+		break;
+	}
+}
+EXPORT_SYMBOL(mmap_action_prepare);
+
+/**
+ * mmap_action_complete - Execute VMA descriptor action.
+ * @action: The action to perform.
+ * @vma: The VMA to perform the action upon.
+ *
+ * Similar to mmap_action_prepare(), other than internal mm usage this is
+ * intended for mmap_prepare users who implement a custom hook - with this
+ * function being called from the custom hook itself.
+ *
+ * Return: 0 on success, or error, at which point the VMA will be unmapped.
+ */
+int mmap_action_complete(struct mmap_action *action,
+			     struct vm_area_struct *vma)
+{
+	int err = 0;
+
+	switch (action->type) {
+	case MMAP_NOTHING:
+		break;
+	case MMAP_REMAP_PFN:
+		VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) !=
+				VM_REMAP_FLAGS);
+
+		err = remap_pfn_range_complete(vma, action->remap.addr,
+				action->remap.pfn, action->remap.size,
+				action->remap.pgprot);
+
+		break;
+	case MMAP_INSERT_MIXED:
+	{
+		unsigned long pgnum = 0;
+		unsigned long pfn = action->mixedmap.pfn;
+		unsigned long addr = action->mixedmap.addr;
+		unsigned long vaddr = vma->vm_start;
+
+		VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MIXEDMAP));
+
+		for (; pgnum < action->mixedmap.num_pages;
+		     pgnum++, pfn++, addr += PAGE_SIZE, vaddr += PAGE_SIZE) {
+			vm_fault_t vmf;
+
+			vmf = vmf_insert_mixed(vma, vaddr, addr);
+			if (vmf & VM_FAULT_ERROR) {
+				err = vm_fault_to_errno(vmf, 0);
+				break;
+			}
+		}
+
+		break;
+	}
+	case MMAP_INSERT_MIXED_PAGES:
+	{
+		struct page **pages = action->mixedmap_pages.pages;
+		unsigned long nr_pages = action->mixedmap_pages.num_pages;
+
+		VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MIXEDMAP));
+
+		err = vm_insert_pages(vma, action->mixedmap_pages.addr,
+				pages, &nr_pages);
+		if (action->mixedmap_pages.kfree_pages)
+			kfree(pages);
+		break;
+	}
+	case MMAP_CUSTOM_ACTION:
+		err = action->custom.action_hook(vma);
+		break;
+	}
+
+	/*
+	 * If an error occurs, unmap the VMA altogether and return an error. We
+	 * only clear the newly allocated VMA, since this function is only
+	 * invoked if we do NOT merge, so we only clean up the VMA we created.
+	 */
+	if (err) {
+		const size_t len = vma_pages(vma) << PAGE_SHIFT;
+
+		do_munmap(current->mm, vma->vm_start, len, NULL);
+
+		if (action->error_hook) {
+			/* We may want to filter the error. */
+			err = action->error_hook(err);
+
+			/* The caller should not clear the error. */
+			VM_WARN_ON_ONCE(!err);
+		}
+		return err;
+	}
+
+	if (action->success_hook)
+		err = action->success_hook(vma);
+
+	return 0;
+}
+EXPORT_SYMBOL(mmap_action_complete);
+
 #ifdef CONFIG_MMU
 /**
  * folio_pte_batch - detect a PTE batch for a large folio
diff --git a/mm/vma.c b/mm/vma.c
index 36a9f4d453be..a1ec405bda25 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2328,17 +2328,33 @@ static void update_ksm_flags(struct mmap_state *map)
 	map->vm_flags = ksm_vma_flags(map->mm, map->file, map->vm_flags);
 }
 
+static void set_desc_from_map(struct vm_area_desc *desc,
+		const struct mmap_state *map)
+{
+	desc->start = map->addr;
+	desc->end = map->end;
+
+	desc->pgoff = map->pgoff;
+	desc->vm_file = map->file;
+	desc->vm_flags = map->vm_flags;
+	desc->page_prot = map->page_prot;
+}
+
 /*
  * __mmap_setup() - Prepare to gather any overlapping VMAs that need to be
  * unmapped once the map operation is completed, check limits, account mapping
  * and clean up any pre-existing VMAs.
  *
+ * As a result it sets up the @map and @desc objects.
+ *
  * @map: Mapping state.
+ * @desc: VMA descriptor
  * @uf:  Userfaultfd context list.
  *
  * Returns: 0 on success, error code otherwise.
  */
-static int __mmap_setup(struct mmap_state *map, struct list_head *uf)
+static int __mmap_setup(struct mmap_state *map, struct vm_area_desc *desc,
+			struct list_head *uf)
 {
 	int error;
 	struct vma_iterator *vmi = map->vmi;
@@ -2395,6 +2411,7 @@ static int __mmap_setup(struct mmap_state *map, struct list_head *uf)
 	 */
 	vms_clean_up_area(vms, &map->mas_detach);
 
+	set_desc_from_map(desc, map);
 	return 0;
 }
 
@@ -2567,34 +2584,26 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
  *
  * Returns 0 on success, or an error code otherwise.
  */
-static int call_mmap_prepare(struct mmap_state *map)
+static int call_mmap_prepare(struct mmap_state *map,
+		struct vm_area_desc *desc)
 {
 	int err;
-	struct vm_area_desc desc = {
-		.mm = map->mm,
-		.file = map->file,
-		.start = map->addr,
-		.end = map->end,
-
-		.pgoff = map->pgoff,
-		.vm_file = map->file,
-		.vm_flags = map->vm_flags,
-		.page_prot = map->page_prot,
-	};
 
 	/* Invoke the hook. */
-	err = vfs_mmap_prepare(map->file, &desc);
+	err = vfs_mmap_prepare(map->file, desc);
 	if (err)
 		return err;
 
+	mmap_action_prepare(&desc->action, desc);
+
 	/* Update fields permitted to be changed. */
-	map->pgoff = desc.pgoff;
-	map->file = desc.vm_file;
-	map->vm_flags = desc.vm_flags;
-	map->page_prot = desc.page_prot;
+	map->pgoff = desc->pgoff;
+	map->file = desc->vm_file;
+	map->vm_flags = desc->vm_flags;
+	map->page_prot = desc->page_prot;
 	/* User-defined fields. */
-	map->vm_ops = desc.vm_ops;
-	map->vm_private_data = desc.private_data;
+	map->vm_ops = desc->vm_ops;
+	map->vm_private_data = desc->private_data;
 
 	return 0;
 }
@@ -2642,16 +2651,24 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	int error;
 	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
+	struct vm_area_desc desc = {
+		.mm = mm,
+		.file = file,
+		.action = {
+			.type = MMAP_NOTHING, /* Default to no further action. */
+		},
+	};
+	bool allocated_new = false;
+	int error;
 
 	map.check_ksm_early = can_set_ksm_flags_early(&map);
 
-	error = __mmap_setup(&map, uf);
+	error = __mmap_setup(&map, &desc, uf);
 	if (!error && have_mmap_prepare)
-		error = call_mmap_prepare(&map);
+		error = call_mmap_prepare(&map, &desc);
 	if (error)
 		goto abort_munmap;
 
@@ -2670,6 +2687,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		error = __mmap_new_vma(&map, &vma);
 		if (error)
 			goto unacct_error;
+		allocated_new = true;
 	}
 
 	if (have_mmap_prepare)
@@ -2677,6 +2695,12 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	__mmap_complete(&map, vma);
 
+	if (have_mmap_prepare && allocated_new) {
+		error = mmap_action_complete(&desc.action, vma);
+		if (error)
+			return error;
+	}
+
 	return addr;
 
 	/* Accounting was done by __mmap_setup(). */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 07167446dcf4..c21642974798 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -170,6 +170,28 @@ typedef __bitwise unsigned int vm_fault_t;
 #define swap(a, b) \
 	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
+enum vm_fault_reason {
+	VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
+	VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
+	VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
+	VM_FAULT_HWPOISON       = (__force vm_fault_t)0x000010,
+	VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x000020,
+	VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x000040,
+	VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
+	VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
+	VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
+	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
+	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
+	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
+	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
+	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
+};
+#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS |	\
+			VM_FAULT_SIGSEGV | VM_FAULT_HWPOISON |	\
+			VM_FAULT_HWPOISON_LARGE | VM_FAULT_FALLBACK)
+
+#define FOLL_HWPOISON  (1 << 6)
+
 struct kref {
 	refcount_t refcount;
 };
@@ -274,6 +296,92 @@ struct mm_struct {
 
 struct vm_area_struct;
 
+/* What action should be taken after an .mmap_prepare call is complete? */
+enum mmap_action_type {
+	MMAP_NOTHING,		 /* Mapping is complete, no further action. */
+	MMAP_REMAP_PFN,		 /* Remap PFN range based on desc->remap. */
+	MMAP_INSERT_MIXED,	 /* Mixed map based on desc->mixedmap. */
+	MMAP_INSERT_MIXED_PAGES, /* Mixed map based on desc->mixedmap_pages. */
+	MMAP_CUSTOM_ACTION,	 /* User-provided hook. */
+};
+
+struct mmap_action {
+	union {
+		/* Remap range. */
+		struct {
+			unsigned long addr;
+			unsigned long pfn;
+			unsigned long size;
+			pgprot_t pgprot;
+		} remap;
+		/* Insert mixed map. */
+		struct {
+			unsigned long addr;
+			unsigned long pfn;
+			unsigned long num_pages;
+		} mixedmap;
+		/* Insert specific mixed map pages. */
+		struct {
+			unsigned long addr;
+			struct page **pages;
+			unsigned long num_pages;
+			/* kfree pages on completion? */
+			bool kfree_pages :1;
+		} mixedmap_pages;
+		struct {
+			int (*action_hook)(struct vm_area_struct *vma);
+		} custom;
+	};
+	enum mmap_action_type type;
+
+	/*
+	 * If specified, this hook is invoked after the selected action has been
+	 * successfully completed. Not that the VMA write lock still held.
+	 *
+	 * The absolute minimum ought to be done here.
+	 *
+	 * Returns 0 on success, or an error code.
+	 */
+	int (*success_hook)(struct vm_area_struct *vma);
+
+	/*
+	 * If specified, this hook is invoked when an error occurred when
+	 * attempting the selection action.
+	 *
+	 * The hook can return an error code in order to filter the error, but
+	 * it is not valid to clear the error here.
+	 */
+	int (*error_hook)(int err);
+};
+
+/*
+ * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
+ * manipulate mutable fields which will cause those fields to be updated in the
+ * resultant VMA.
+ *
+ * Helper functions are not required for manipulating any field.
+ */
+struct vm_area_desc {
+	/* Immutable state. */
+	const struct mm_struct *const mm;
+	struct file *const file; /* May vary from vm_file in stacked callers. */
+	unsigned long start;
+	unsigned long end;
+
+	/* Mutable fields. Populated with initial state. */
+	pgoff_t pgoff;
+	struct file *vm_file;
+	vm_flags_t vm_flags;
+	pgprot_t page_prot;
+
+	/* Write-only fields. */
+	const struct vm_operations_struct *vm_ops;
+	void *private_data;
+
+	/* Take further action? */
+	struct mmap_action action;
+};
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
@@ -297,6 +405,9 @@ struct vm_area_desc {
 	/* Write-only fields. */
 	const struct vm_operations_struct *vm_ops;
 	void *private_data;
+
+	/* Take further action? */
+	struct mmap_action action;
 };
 
 struct file_operations {
@@ -1466,12 +1577,23 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 static inline void set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc);
 
+static inline void mmap_action_prepare(struct mmap_action *action,
+					   struct vm_area_desc *desc)
+{
+}
+
+static inline int mmap_action_complete(struct mmap_action *action,
+					   struct vm_area_struct *vma)
+{
+	return 0;
+}
+
 static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
 		struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc = {
 		.mm = vma->vm_mm,
-		.file = vma->vm_file,
+		.file = file,
 		.start = vma->vm_start,
 		.end = vma->vm_end,
 
@@ -1479,15 +1601,18 @@ static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
 		.vm_file = vma->vm_file,
 		.vm_flags = vma->vm_flags,
 		.page_prot = vma->vm_page_prot,
+
+		.action.type = MMAP_NOTHING, /* Default */
 	};
 	int err;
 
 	err = f_op->mmap_prepare(&desc);
 	if (err)
 		return err;
-	set_vma_from_desc(vma, &desc);
 
-	return 0;
+	mmap_action_prepare(&desc.action, &desc);
+	set_vma_from_desc(vma, &desc);
+	return mmap_action_complete(&desc.action, vma);
 }
 
 static inline int compat_vma_mmap_prepare(struct file *file,
@@ -1548,4 +1673,37 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
 	return vm_flags;
 }
 
+static inline void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
+{
+}
+
+static inline int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t pgprot)
+{
+	return 0;
+}
+
+static inline vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn)
+{
+	return 0;
+}
+
+static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
+{
+	if (vm_fault & VM_FAULT_OOM)
+		return -ENOMEM;
+	if (vm_fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE))
+		return (foll_flags & FOLL_HWPOISON) ? -EHWPOISON : -EFAULT;
+	if (vm_fault & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV))
+		return -EFAULT;
+	return 0;
+}
+
+static inline int do_munmap(struct mm_struct *, unsigned long, size_t,
+		struct list_head *uf)
+{
+	return 0;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.51.0


