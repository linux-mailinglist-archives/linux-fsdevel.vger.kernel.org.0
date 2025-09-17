Return-Path: <linux-fsdevel+bounces-61992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486ADB817D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEA2626577
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6B233629D;
	Wed, 17 Sep 2025 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V/cUKDou";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m6QVp05f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678032BC1F;
	Wed, 17 Sep 2025 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136344; cv=fail; b=IrJ+ThIjPB2aevgK5I1MijVW0TfrhF6g1wRJ1nLR+Xl1cSxgVuKlFBBW7Q6BT6MWXLR7eg60ypEG5mOmkio8rL7Cd7xX5YNjhVzWSSOy4d7o2EwTS8s2TmZj2CzgGPRGzvM+NrivjhqV3Mjxj08lLQNAeFh+NxghDRU0TgdyDZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136344; c=relaxed/simple;
	bh=mAl3nNAOybZalcyIaMD0cvINITxcPr9TcYow+IPVbXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pAJsotMnWGaeVtA0Vwm7pzFdQ1IALiE8+kaDXyt4RnyPt7gv1iMMo9CK1E56kUGsBENJEHH1Se+I7wWKgyVpBCLAK7SksPM2KRn1ke+atzL2z1DffuUTGtH4501lxJ4HhtqbUoddqY5pUVDB3FQTVyQps6JeTwghaKFMphtPPy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V/cUKDou; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m6QVp05f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIRaB001799;
	Wed, 17 Sep 2025 19:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FuJChwG1MhLRYQ6IH2bwrJ1lCowbo9ircLVlBP437qg=; b=
	V/cUKDoudjxC8E/9DJRzKE7yWsDk+xjImfjNmFRCdQu69/gFTDh1DLsqOqRa5phi
	zv08lVXF/VcqjQa8JsfADgYZKf+0dj8elRpCdofJ9rPny5CP0piRRBwPBUJrPsvm
	p41SQdH+BixHfv5xFa+v8JV9s5w9FsN9c10qbUMIhmQFGSwL2Nh0v6zqXkt4gM7y
	OgIUcdkeqt61ALU114exJDmLG8J8rVTCFIdhVNdK8fr0JmESe8smWXytpjQoMLi5
	M398A8X8+eM51ocKq+qgEfq9gPSNqvnzrjnd1cpdgGj4aBDlBDoyblXjRKPpSp7O
	K/xMqVZH/UHo5tTL5EmfUg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd207g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHmk6f001628;
	Wed, 17 Sep 2025 19:11:42 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2edr7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciXVOqOT8pyWVLrGKXnVlDlQtKE6P1VJAXcg7IQjmHqINFgDvE25wqDIjJLtjPgT3AQX8JHA5bEsKMz4hOCCXPcaasmmOkG8yhMkmCSnoJk/JmNVJZVUzZCQZIH/8LJ8EO4TvSqnqnuet37fzAfXmXnxPM92XvQNMMRhSdijzLlbw5oz/cs0ONoOwz6ChVCrx+eWGjut0pwrLFFHMl9e51fIEhkJlOVzItqKfmhD/pIZ7mZ1XxpC3syg7oQ3V63gXUwTqoc0NP+ueAjebrwVH7IcYssAmVLoVr7FnYkPV9MNcYm1hQPrtmMdBU982S7r2WJtqW/xmlBUllIFYo9hWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuJChwG1MhLRYQ6IH2bwrJ1lCowbo9ircLVlBP437qg=;
 b=xMvrsjHyM/nYX5u/DQ3ami3oQbw08FLJVvQ2zu2oQuju6LT8Zwpz1SgrKQt7/iBgeWW+pV4HWZBRUkZQEI/mYiBeX9nLcmMimkdw/m9VKfU5ywkDxHNLmV803U81BoUeorP1mrxYJV/0rA+DEktPqREHDxKBYEV2IY5azyR5QzJK+kNZyRZMC6OXbyA/madBFWb/fNtOChQdSXxEpyWrLK7kWoLhdVaQ0pVsXfZxT/LNmCnCDb2Rl2MhNkSaHrlkNYk+k6cpaOpKJEOpTA/UQkJ2HEpGeUyizYcKwdP+YuEtnHDtrf3brESDwileTJZcQIED0ttJ65phI734QxHWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuJChwG1MhLRYQ6IH2bwrJ1lCowbo9ircLVlBP437qg=;
 b=m6QVp05fapMRexPGhRTVc7WBMcrFWLG4NMYKk19u8q3/8A8cWQtEnBPiqjF1OZSSSvpaHZV0XXZOqO6DqqNnwNDwIp5TEqcH/1MHVCE2ZuPh84SC8xrxLo3eX0sxxD6orpYl+gEvK20zvequeynjC7r3EviYSKWydtMH6UdURFQ=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CY5PR10MB6189.namprd10.prod.outlook.com (2603:10b6:930:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 19:11:36 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:11:36 +0000
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
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 08/14] mm: introduce io_remap_pfn_range_[prepare, complete]()
Date: Wed, 17 Sep 2025 20:11:10 +0100
Message-ID: <cb6c0222fefba19d4dddd2c9a35aa0b6d7ab3a6e.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0451.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::31) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CY5PR10MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: ce92cf06-d2fb-4c08-45ec-08ddf61e05dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PjokzuATfC2inAuHM9pViYgsiPhUFiMQGuNzZahWr/K2pMW1f/0le63nneGI?=
 =?us-ascii?Q?8ghNB0L7NAq8y6cKGOV3lLnya42ZQBtAnNQ0xpRc2Q8YkL0goKBBnr5cD5CT?=
 =?us-ascii?Q?zHMlUdlMJeKhTaQr4RlYPHst7vL5kKLV8Y3nf2+pbxqLss4skfsHxukszIsm?=
 =?us-ascii?Q?NMOoHasTjN3pnvSz78VSONA2aX91CcXsoxLwQojhcB6SV43hfZBkxzXzHZV5?=
 =?us-ascii?Q?3R2BJpv+w0Lg22b+lv0j3vNgxC0XvC0m8kTJBsRBujtl4NI7azHoAblg/Geb?=
 =?us-ascii?Q?eAGuzoL2NNJfbapycCCz97bfyfJI0/ZQDQhE47PMg33ZLxq4e+a5U2xnNTgU?=
 =?us-ascii?Q?GetmhoKOeukbEMHToLYBfPNTGH3hGtR4GmrxpiFYPx2zScP0wq22XgTSq6s9?=
 =?us-ascii?Q?5hPaqGJpJGutCgDddR7gGw9iBjGHXnDcUDu2dmIs9dD4c53f+DQUtPbm7hej?=
 =?us-ascii?Q?Z1GyHw8tIP4WIH+Ifa8DWo0a+kzlz6ac/KyUq+Baniz4S/MGg2GJfCggLYyp?=
 =?us-ascii?Q?3XtqPK98O+k8A5XvGMGIPZI88Vq5wXCM+kfN2c3mYLNfRp60uCQiTgIpYUX6?=
 =?us-ascii?Q?hrVVDzvxVwobb+9eiMOpgu0+xzhG6u70ZeQaciTVDoCTQ4b+wnNMVIXdg5le?=
 =?us-ascii?Q?iD9IMrdqr+PV5VgPsI2HTQLPIPrQvy2upON8tRip3ZT4o2Ej8nkCvwepwFI3?=
 =?us-ascii?Q?x3lJSXjm8wNID2WX/rggejtUm98tEkpMEARtjJadY8uEWErHuWTCTY/AaPR6?=
 =?us-ascii?Q?b4n+TjR8hsdELBSV1AO3j4xQpT05T0oMTSVpggr8VZFeweTPfAZPAVuY7IGi?=
 =?us-ascii?Q?xeIAGQZVCYhkPNZFgAhdfIVQRgV+AoWkDy3UBs8RiWqvFmwFx32bzET2jwEj?=
 =?us-ascii?Q?iAJsiR/LSgSERpk6nkm6wfjkWFa5uLNxHJtTMifde0CX7RP6DCOIkdyNJcw/?=
 =?us-ascii?Q?hlwP5fvuZODkYCLAFcyKsarq1wyhXkQHk/cXT2rWEq6fLzfmkk3EFcKMjK+Q?=
 =?us-ascii?Q?mnC8AJnBarLyEkOfS9j2TZIV1b1A5dYXnDL2FjNLv/RW6LWxhUxXYcUj4qwW?=
 =?us-ascii?Q?ZBedTBkH0eEdFj5Mzorwy9kwDWTEZDaCQOF/obQ+dOzguhnkUkwpTOs2eLk9?=
 =?us-ascii?Q?KUuoSwWx9u8X8VNgqN5sdH5rfQLHLVaTJPnXcjfUsSMF+oxJI2orRj9HkYtq?=
 =?us-ascii?Q?icCQhaqFNQMU8HarjZyfmLRmMsPDR9CdpjHY1yTsWJfsuu3l/QIX/lP4ASQX?=
 =?us-ascii?Q?wOh9S1NnW0z6X/37EEznWloHlnvKjoIbFTkq15QNwFiyTD6mpfC/LBGx68g1?=
 =?us-ascii?Q?AJrn9HS/FATQ5+MLyFEQNQUAdE2pyuJHCwk835JLXQtlhvTuZP6EEhlMI41f?=
 =?us-ascii?Q?1TSvux9k4/K2rmm2J6F6YPhhBUcmwRLiqUnWD7C1co8OMFQdZss0jbuVdtMC?=
 =?us-ascii?Q?xLTzf1Mn3Pk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GqTmY/SL55kJKSqzPXoQxXEo0tT2NI8EAHCk2aUhHcmUEjPtyC6dSSXFUG3N?=
 =?us-ascii?Q?ZhrgWNsiH3M+CDMwumyaiGroCFgymoHarhDnvJUpGjt/46rmgtmvZUCoWJGO?=
 =?us-ascii?Q?xlcecM+H3S2Shaxt+DIFHXLT8/l5y+jeLAYxRmiVMHoS1otxrJdX1a2ZZVR/?=
 =?us-ascii?Q?BCgGscb+sENdAZwv5NTYR3sMw60YO5UJ1Na8frcnkNF9vR8Fofl3HHu728CI?=
 =?us-ascii?Q?IjwQQj9UH4+RfdhtJNUvEU5bPJaqlE+dPVnajvYVfjyDjlIFjYMbm162p3uT?=
 =?us-ascii?Q?al/AIisS8kxRPMKOuvwerfS2B4vtVhNEiXmGRbPZQ3PUjvRr547Gl0KnJIVT?=
 =?us-ascii?Q?2l46n9zIe3Pkyx/zJULgc6uD2TkqX2Xt0kuDjQA0cidFcOyjwgpe6yUF/cUS?=
 =?us-ascii?Q?WdxPS5V7EAJQmDDmGjnQj3SUdRZbeJgbknfJON4DBqr08evYp+Q0DwREtfRU?=
 =?us-ascii?Q?4ihu4tHPlfATmhMVGj0cYtiKb+pF9eIfunR6v6iAbpHwdaffOERRUvs8H1AH?=
 =?us-ascii?Q?oNBdg3xDudmrFIpiSd1xoUVJa5H4cXYWqilfM5TMI7IYff8wdLSaYUoKXK9b?=
 =?us-ascii?Q?BbX94iNNz+MiwCzcd93ksdKJmy33zyEG1vad4VucUCWA1bk1CDUIJe187KrZ?=
 =?us-ascii?Q?Is43bIz9TV9IUNbcb/OjZK3AHR1WSr57J+fA0pl3s94MA4owCk467WMI1KLz?=
 =?us-ascii?Q?I292WEFcCOH1cfyEqdc7OeDNPlD9002wLzwvAvNoepS8ZKcjZNYDdPTT3q2U?=
 =?us-ascii?Q?99ipyzg2AQApnuMxuX2UAZQERG2Sab4CISNXKqdPQCJUP4GJmGdl45GpFsC+?=
 =?us-ascii?Q?/3CVYedWhQmI9xq02W03Rn12YtcV0hVM/s6s/lD89tT5RR6tBpFVYsVlmmdd?=
 =?us-ascii?Q?6k25pwRysdPruKiMoD49cG9MuXdIUDR6YcBxce1OyNeYii79Nd7ymBJBpAPG?=
 =?us-ascii?Q?XVm3yotxJUcvwIw2eaPtlCh6ZAVLwrz63W0L8XlUu8Yd+sPApyZEA0HTsZSS?=
 =?us-ascii?Q?+VdOB+yR8bpFJI4UQuPduQ/jOnwD8El5jsr3crJ3DvMhqTJKewf1K1oMG257?=
 =?us-ascii?Q?Ju3OfLPFeESwrPSCAeUUmG5UHyKbl6JjKkugcRdPs9yU9/e3MLnK7DvhVwWZ?=
 =?us-ascii?Q?aHJ/qopNZwkL26pM9e1De5qjLlt5axEj/3s4Gqx4Une6LSqgiYM9lg3pVsp0?=
 =?us-ascii?Q?s+5JndafqyHQpGp694ZLnWuED2yOty4bATE8RDOXvV9qfkxUFbHMWI/RRUMr?=
 =?us-ascii?Q?sgCUQVkjw6g6znLB2tNSAzVq5uOKk7Ys94APWR2eoyZYmj9nK1B8z6aznKah?=
 =?us-ascii?Q?8wqIJt85R8VawFnaySAwwiszOerthqDnm+dFjvR50lNR0XVZHtniYyj4DxAt?=
 =?us-ascii?Q?b8qt0ge/bRQciTOXf0lIj7LDKS2gQvKmmdO/oykAM/2qLWngxx1Iux/pjVHG?=
 =?us-ascii?Q?S+gD06uJz6f0YNWFbtRqapOfa8xa/56UDu7TNnhFDOZnqNZfzUUqXifSFyEE?=
 =?us-ascii?Q?iWHtGm9PVu8mbp5YngmhApYc6ERztApOrumivD0L6DRQiQ/EQV6ttEJ/WZOx?=
 =?us-ascii?Q?kfM6WjTuyE3CVvZYgMJBK0ig0yjXbtDSsA19nWx9puuVBFvv5ihKed0dzd7w?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Px+TxJ5VtCpppFfgRm1NRhf7KeIhowKnszIyQUHaqGH5eWMVOWFpLKgde16NFl9TgEfmrNIdTzpWzyXzemNi2ZMMq2h37kpTuiBpCSEY/+IEjkmMZMsmGlfOdpcVOO2SU1Mceaz1Fw/JAVpSXPvAlh7aYr4zYlmsNa3YRloIVNv6TtGv6+U49AC+UVJexrJpD1XcFCXVrS6K6ZQ+rF1Ng/Ht0VjPHpy0dJ2LtW468y1c6wrxrWq75WaAue/EN0wJZiijD+f3Wy2zS2qWWyRN6D/0BH9SRcqyk2S3SPIu1htU0vR+L4NEMjaPNBTiql5h3w3SJWE01lBi5gEBjUwGgOLJzjjeK6qWcvajAUMbZdPTUMFJ9G7ftg05mHbopnEiGf5U0w8rscXozqsV6xkZSyNoQpHlSBTDr4+FU1Z6Sx8odDBvcnbN/QOT1d4cBgldr7qQXooPmOrnLGg8Wpzdb2J16+wlm8HEqd9BMK+BxDes8oYo8mqQ6rbX4R9pXXMJ+FvQlG5MyvtfgQTyiTSNmZeGQvTzUiiCsIIp7Px5jGYfpKbXVuptDEff7sTqcDqnk2geq3ZumJk7od4pGfIrDfIoWgd5W0en7HR2hkHxnnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce92cf06-d2fb-4c08-45ec-08ddf61e05dc
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:11:36.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ru3oeXWdf3V/2+6rJXIjlWB4KtdqukeWL5AIQ48AmgYJYcYOSQYTl4J6G4r4tKLEYsvOA37R+ePFBZlzC5JZqMP0OCMjaz5bUyr5v/a+hDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170187
X-Proofpoint-GUID: lzsFeGxGclgUp2xNz4ABxSrxNaXJncy0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8btFyoBMBpbU
 2/7vhS+OcDco3sTDxReVVhoCGzm8u+7DCqIikPkpgew4psF8Y1u/33Nn4MkCUbinwhnUnvAacGT
 1KbZM80ss9I2SMoe1jm94RPAr+KmttrSjaFo2JpEPJ5WAw6dJXdW7VV34tPoOxdYMq2OFPUX+yd
 G8Kp8xT98o+8c0+QYUph83Pgi1V5kVv7vOGjhukO1kSToFegnYtfOm8ZCkPz3wssAmXL83fLiLu
 uNnD9SATRTQi3aZBMxsxIq/5KmLnh6ltgpTRS/zh03lB/qxruxkT+VknQKc8c2qQIeClmNX1eM5
 rpGptfkWu2Dj05RrMAZup5BsVK/vQUuaRJkXRpWIL2oTPaXD2OtO636un/qqiuN9fvwOqFATTzh
 Y0rv2os5
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cb07ef cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=ANQtcE5oiNAsODQ0kQwA:9
X-Proofpoint-ORIG-GUID: lzsFeGxGclgUp2xNz4ABxSrxNaXJncy0

We introduce the io_remap*() equivalents of remap_pfn_range_prepare() and
remap_pfn_range_complete() to allow for I/O remapping via mmap_prepare.

Make these internal to mm, as they should only be used by internal helpers.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/internal.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index c6655f76cf69..085e34f84bae 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1657,4 +1657,22 @@ void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
 int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
 		unsigned long pfn, unsigned long size, pgprot_t pgprot);
 
+static inline void io_remap_pfn_range_prepare(struct vm_area_desc *desc,
+		unsigned long orig_pfn, unsigned long size)
+{
+	const unsigned long pfn = io_remap_pfn_range_pfn(orig_pfn, size);
+
+	return remap_pfn_range_prepare(desc, pfn);
+}
+
+static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long orig_pfn, unsigned long size,
+		pgprot_t orig_prot)
+{
+	const unsigned long pfn = io_remap_pfn_range_pfn(orig_pfn, size);
+	const pgprot_t prot = io_remap_pfn_range_prot(orig_prot);
+
+	return remap_pfn_range_complete(vma, addr, pfn, size, prot);
+}
+
 #endif	/* __MM_INTERNAL_H */
-- 
2.51.0


