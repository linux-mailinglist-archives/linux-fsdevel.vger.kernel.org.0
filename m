Return-Path: <linux-fsdevel+bounces-61994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB481B81805
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910C6626A74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B4033AE92;
	Wed, 17 Sep 2025 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H7wKR6ev";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bY/R6Q/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7541333A82;
	Wed, 17 Sep 2025 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136346; cv=fail; b=kex9zPsQxkU9NiFfZlhSQ61ilFltrMkMkF3vkVilX0PP2LV2XiCNYbg2XjBEBP6W7iEoyO+hOPlzl3d00K+pjeZh2GSkA8jljU4G3MGebpUa0KxVfLGlvoVWhc7I0ewXBV8LcswcLvxd9nxkrG16rg4ETVyJxtqBjLvyije5lkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136346; c=relaxed/simple;
	bh=zRGrsCI3pwn/4pOj4IjwGsYxQnDJMnjxJgo2aSf04fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MkEhAmsuG0uJzBGni9VZDOBhfcj+4paCgqesMiOCl4K/+eOD9sCH9grOfLEaCTFBjaebPTiSFDBZx2aAr0iyi/zeS0OvPyvsYf9Df1it9WLiNgplIUjmoarWKVpzh8iF/QDMU6M1Q+h3J3+NH9pueNE7GtfDA0EUzZUBl5p8RoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H7wKR6ev; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bY/R6Q/s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEISvD007336;
	Wed, 17 Sep 2025 19:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hb/gfX0JwVYnbXTvQa1ZmKzCKlseHRvNPsGowFPJR8g=; b=
	H7wKR6ev5PKilgvDbtIcV2DYtHHY+2Oo/VZ7B5alnT6wjSX8cszzX1uQEF0ZswYs
	hQ9vQ8pnJ2UYunQBygKn+tRkRBrbkFYVFWUwgpUR50HY96Ee+79i1HYJ12iQGmsb
	K1kaZNWsma/9NQ19UNf9tgE0y/NRdAdkqXIwjfwmeKjMhfpgu6HaGVpBy1bGrted
	96DX2UsRUH5fuO34B821ggQSVlYlaeGfS24LhDEbPYOZYDIHcVRK2It7dN7n+Ssi
	pJx9SzEMRzpTodStVky/BmPQGkWFlY4RTPeNcJ31wSuI9ip03hw+pL7+0iO/eDuI
	EWabnE6Dv9KkAQwjfqp7Qg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx92001-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHmk6Y001628;
	Wed, 17 Sep 2025 19:11:36 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2edr1x-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzPP4Sp8ZqF7MMgoDaS9EmGF9YpCQCjwf8Zbe5K4IaCq7oO7FxBCKngDGH1X2sI564C9mTxkvgEef8CxrH4o4r10zkCHhe6gw5BK2tMnw9JPNHTbUMQrHlWHR01VVQ2OuobqNq0vaNSJPIImnW3Ah+P30xNqWiMOm2eXVRVfNpY79RwWK2P1Yq64lOfPmteEXRSaVicsDj9J/BAdhGuSr64gyLguEfjLw4KBs1AyvA98yeUu2ATP2nlO1sCpQT9E6W7ukqJHpf76EGKHc5XWyv8FPegffEXP1tI6kfM9V3q0sZW+CkYnJ1LAAqbNCbNLKuaNVCE2gWdkZMswmDU0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hb/gfX0JwVYnbXTvQa1ZmKzCKlseHRvNPsGowFPJR8g=;
 b=j7Ud7xijXyBw7iejsaL4pCTkkflLOdneF2p4yft/46A0WGVwnY+CeWoeEiU7c8x1rr8zR8VsQHwjXHth4o9j0Put+DHPC3OTrTf/eg6sUCUygtDLHEUG+MHy3fP0dD4Xa2qgVLYUGKlXEsjyHjHqvBjnH0pfFtmOSKrmgZGaPxfnCBuIH1be+zXpLGge7jP+V9v9RAXGMddpNU1by7lvrYruIpan562mbwXfrz5DC9u3NOMKm8Ari7ufwF/Coi0qo0SINvL7P0st5Mb333C3gcqTxVzBrLQhGzFEe2HEKG4U2eCXoYj4Q8AElwN1WmfjDzEM5w7Jmmtmhz6kVmTI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hb/gfX0JwVYnbXTvQa1ZmKzCKlseHRvNPsGowFPJR8g=;
 b=bY/R6Q/sESVnqZeR8HyyEwjxP+LGdTCkIoihEgHkh8RfebFx6NB8WtW05mu2wdDgREAg02S30wD5QD2aMAh6Bneu/K1Q+N+cPjRhm1G3zAz35b7rYD7MSq6WJ8i1mBloDR7Aj0CDT8uMgoZyfa7ZJdXSW7seL9/KRB0AShFdWvQ=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CY5PR10MB6189.namprd10.prod.outlook.com (2603:10b6:930:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 19:11:31 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:11:31 +0000
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
Subject: [PATCH v4 05/14] mm/vma: rename __mmap_prepare() function to avoid confusion
Date: Wed, 17 Sep 2025 20:11:07 +0100
Message-ID: <24cdbee385fd734d9b1c5aa547d5bbf7a573f292.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0398.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::7) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CY5PR10MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da66b6a-a778-4712-5d9f-08ddf61e02af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DuZyueFJy7XVQDSwgaUob0+sInJwJ5nG2r8sulQnr1VFx0/qKaQDQIabbyxh?=
 =?us-ascii?Q?3vK1p+WIctZeWU5Y/294cH7NcHZLBrXGHIcavNpMxQtv81eIDqduGO8+39Lb?=
 =?us-ascii?Q?JYP5ya8oP/dQOOggbTLc/kJNinuA3Usb7uYMmRbbwQnS/H1dw6BX4eAHftlR?=
 =?us-ascii?Q?Ug9d/YacixkPtXFcr8L8BZ3vjiUBbWVUVH6+pr06u53Z/0EweJDL22NiYmy6?=
 =?us-ascii?Q?x3+5gqr41P2QZLjRyAVArBsP3rG5re72vUS5H+KH9DopJQPlqJqDcKri2VJv?=
 =?us-ascii?Q?i1aZLSXexNrE27YnE6cMXKhLpAkWfFejZq4Qt07lBPlZm3oR3SzDG4gMBsNe?=
 =?us-ascii?Q?Y9kNDIVMyq0y9FHgtyn9FXXTmuUJZ1rkxH3tuOnONgDWbyP6E1PybmPTCJsE?=
 =?us-ascii?Q?uDoMvNPw/W/TiBd0v70CqJQIqCfSLrs8M99JCLlT7Ope1/nH4qHjzQiaPwMS?=
 =?us-ascii?Q?zf5LMW48E7JPzNm4DGk13OVCH75uknHSTFtbqVPmRQ7pbnBk9FmV/UoW+ufB?=
 =?us-ascii?Q?xR+OnupeaY8z6xidOUFdbPNkyVtBRerSqUWetcqK5Ci8ZW/VcV/QBERwAKtN?=
 =?us-ascii?Q?Y53WA/ehp1KPHB0GWq6pPPfZ71hFn7qhO1hyWi4O8S9w6iRwgrjWfnMF6ZMp?=
 =?us-ascii?Q?HypOKf07hN3B8C1JrbTcnBLyxMarEcCMlAwVFF+DQzfcBcDGgP65TwAOJ+QW?=
 =?us-ascii?Q?OrSeNMX27V7tCjqmEDoji93877EqgIMMKpUa05C+ku4kJ+eF5KNPQLeUZgpu?=
 =?us-ascii?Q?BXhD+13N3P+K6kbSADaVeSLmCYDBTqgdqI50IKrLfIXghJ2HaB2hndAMc5aL?=
 =?us-ascii?Q?FJ1Od2wsVSOgJAEWhDZnINdRh1VihRi45LQespn0F1SXnZ38AMpSxtWhrorZ?=
 =?us-ascii?Q?QoHqR0Bemi49s44/mV1cLiRoLD1TVtYNwWP2osIVkzxl5uITONJDm+cyjuFo?=
 =?us-ascii?Q?gYwTkXMz1Ps2zG8gQRf+INqNpUWISvDCL5cbk9ilBlt1cjG6fvAt8GlrGNhE?=
 =?us-ascii?Q?xbCRv+/DMS3Q7gOmmhLL95K4VNApGG8etFLV3h2B12vJQo0apgW4zTvohGdV?=
 =?us-ascii?Q?uOBN7fd5c+Gvi/4q+mo9fQyekYmd46FxNGpiJUuYpkB9HJYR9CAix03/PS4N?=
 =?us-ascii?Q?7GI9jz85N4pCUXl6DM7BFde4yPhjzZvsl3w/X1xC6qfrJeLhST63qoRr9oks?=
 =?us-ascii?Q?ORhWdiRbuVOoEbRHvIGiae1WJm3S1KekrefIBmcAsrruq3sTcXPE/FfOM6MG?=
 =?us-ascii?Q?I6/tXxj7MG3kRh7VGMZ7VoPf6x+Z4ifkfxUljFpm99FOfyJ4xp+DyYV+/kwM?=
 =?us-ascii?Q?bBguJ+D4DLE+rzuNpICmh8bY8MELxsKPuvG+RpSiPftyuwFrq1dA/PvBvtOj?=
 =?us-ascii?Q?P+ybIGT6gIyjfpWMewm8iFMVo+C3Hp7biceQQm3Xl162gIErr1Ag1Xi14k8Z?=
 =?us-ascii?Q?LagVQq0BCnE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qXAeT40Eq+2p1mkkTFXMAs7P5ie+aYylfmBjQJ+hvkrZzJSe6Lb8cFvKyPEM?=
 =?us-ascii?Q?69kL8+6pdtsBB/Es0MpknUD74YKDbbal6QDevsBJSAGYWWZYKuwtPi1iS9br?=
 =?us-ascii?Q?tV2P8ylX47wTYekX4zyjCBBHBdvIm1tus0A5HRXa7Fp6t6yDthr3GJPkW5qY?=
 =?us-ascii?Q?tk+iiIeVAXuUUJQobse9KmLHpvDGj9chqBRexyqZFJTXS5zx7w48nWE/K6h+?=
 =?us-ascii?Q?s09UQp9l+1PwJiWG2hCUVNbm20SY+rIcEEij8imuz0bfbEnF+n3IlubQKtVp?=
 =?us-ascii?Q?fivypTmhnHj7z1Cv/WdvPXT6dMoezEzRCaxXdNyh0/BaxdPnxplsrvuAP/td?=
 =?us-ascii?Q?cbJxLFWrCDrDkeEeGWIA6uw5KjPfylCjN+8kiojaY3tNbnZjdKpei3x9GSTh?=
 =?us-ascii?Q?RHT5xsk+FehzSWUXllZGYIUYSOO21kNSvEXihnBUegfWrT0NJvtScgt+zS3i?=
 =?us-ascii?Q?2n2LtDydbUXLFS3PXlwcC+SreE0gdF1cCaadFZ4eXCq5TwtSzT4iWxcPxxi3?=
 =?us-ascii?Q?QUAa8hFwTNmVzQwEsW9BjaZyd1xwZ+ocuuOUwh5gbePLvJjW/4XncsJYabrI?=
 =?us-ascii?Q?dtF2OEHqrrYoxBpqa/nvM3di3u2BDy2qmbwYv1Py29tZZxDQAr4WTvKHEo0H?=
 =?us-ascii?Q?kBym32ABLPRBaM8oAk3og6dYHSBZ7yj/5yKYg05VdTiOj9usMfZCy8Z1qHwt?=
 =?us-ascii?Q?Mrf+F5mh4kJQ3IDRez/2VaDU9KFuyi9NIxfUlFlhhFkvYJQrfzVcFDnMN8dZ?=
 =?us-ascii?Q?gNNASSZWLTe6d6PCJ3GIfYGpwP1Qwz+hM4AZzbYYrjnphm1tqyDs9htm8EVb?=
 =?us-ascii?Q?a3VybpC2ZmMdaEp3xKf2LDGpwr5qZQBl+dFLfT8VDzCdxrL+aQ56eyzPLy0l?=
 =?us-ascii?Q?Rwnr1MTWMKXkgnk7783tfwEcLD/ZQekmI7PIKvGVilVHFm6uUJekWqnIxYEJ?=
 =?us-ascii?Q?LzJjA3Dvt7JXTPIjkSzgyO/SGeu+DlII8AEY9n6rst1pq5xH6inNxRcXCk/p?=
 =?us-ascii?Q?zuyYEtcIl07hLV6TOK2P9EN09a+NeiHJgjLgjK0Jg/DN/SA5oeG0/PGpGAAK?=
 =?us-ascii?Q?jr/ayx/q8Mc69fIEKS3wuMLY6ARg4Ux0ghplGaq56TE99Dv7sMI2TiC/2mLX?=
 =?us-ascii?Q?Gi+h/hQWvIVH1Z5zK14diU/JZiWTOX8aMZnxhOe7fdACz6wzS2DSukUnTEDb?=
 =?us-ascii?Q?Gd2k2x/Pey/CswvtPz9Pi4sFhVVC7z2oINCoVwzYUYTU+qQ/PRYzDPvcn7eZ?=
 =?us-ascii?Q?CyKiE8OmF92iq3G49WNSAza8KMwDxFuFOPf1GkiImxEiq55aU6n8UpXOiQcb?=
 =?us-ascii?Q?wrX+aXVcOfzmkUCbtaykDYXPfc6Zrl3GoItWGLAO5S2Iver4ZccGxWZB2L6m?=
 =?us-ascii?Q?p0qdtlqXhR6vjXuiVzLAmO6e/Ian/zUDOmBZ1202Ki5fi4/fSSSjqk5E4a2H?=
 =?us-ascii?Q?wu4eY3FNm0Apdjt1/FulcnHPE0ZGorc+EnyaE0RI5ylYsmmncYCK/wOSii2z?=
 =?us-ascii?Q?hrERp2lM3dvLyZ3hu62dZ54O99UJcV6J+khAaHaA97ldSW6e1lfCVo8hQvP3?=
 =?us-ascii?Q?nI7p+nHYj5hkSSn4HAZ3S/Hxb+cu+U3EtKxJNmmZh/9YEBEcfAq5MQvVXOud?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LJ6Q/ogLgc8daSnjDlloXHI/pPCrywg28J6lZ22ipSlcIS3NlsUxcaYZgHbO1nsjRoOk9qWHMkWq6/+XdAXAMFNjsaeTkqdV7CUSzLltQGGfjGhwnvl7DhPAOYDZqEJt33XqWPGuLBfHuqgzAxjYaEjuA5iOrqs2K6Nx72bABibVL2N/HQUa9P3zlruPkcPzRqPPu5NbV9e3kAfU4OkfrB2/AeyfRqfOgS3CaB1xQqEUwlC7p3xu5spoD3/c5pfyJMfxvEfE5WyWkXkwRlGHl4SOvEu4TzFF+lPf0i7RxGdYL8m3Rd6hBfwwbQimOmm0vRbpfurHJbbYiWDGrnT33afQEVj/+vPrGXPVpPiUP52+YM5VOn4Clxvp2ipfSPITEtoqi+Pqt8D8C/gRbleGN0TTOUfur0iDzp/f8i7UwCEnPY9k0BRJLvSwK8DCIqojNo2yrgqXdDF6Cp7/NPDjsPCqL1nKC3WEJ1dcn/GfyDU+rp+XvT8/CxC+f65aIc2Gha+AVXp2BkMmLILMW8TWYQ5T3J5TbidZvN6WeAlGbjx2MMZ2eMuYHoRtsuERWm8Tw66KirNQ/nT6cqDWzeHD/ZRmHdTRXRdPp4/p3kw3dgE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da66b6a-a778-4712-5d9f-08ddf61e02af
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:11:31.1518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvOQadZ/0nls7jLTVdGloupOtuWOBWvAhBo4ZGG0FnMV5KrsqFWk/9rMOO2d2DovnobjCywPQ0NQHceBqP7oM3NUNsNeQlVJUqyoaeqtkQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170187
X-Proofpoint-ORIG-GUID: JGRnfS3eZXM2RRlIlhDXyX2fRx_MmBcL
X-Proofpoint-GUID: JGRnfS3eZXM2RRlIlhDXyX2fRx_MmBcL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0VbOwMXznAyw
 UvG6FCJB4d2OvOm9QQFFur/fvr3sSbvRp9XGcEekolyIOpxEMApbFncQ4GixpqoSdHqXoUiwW4Q
 wDX28Tcob0714n7vCtNJ1fi9B+rhgtdvNPilaFu7qj+wcY8FV69xGR8lu9DeyztuTtbrWwXhONs
 7eMlfRBSdd5Uv2JB4LPjfetr8OgUHmcVI/l1BoYCHB1WtQQpLPekXcovGEdAzG9IK/NdILfkvwi
 PnQsNK4IXbDVlbYMbNtW69G1IrtK/N9KjU+0ALG0w8RD2i4aKDCOZ94U410wvzoWnYx5ggqqMs0
 Hjn/wzwyMMRBeKguhj6kX8go9DPXxqAzhx3Ybcn+lIZvf6zq84GsLmwU6x70zGzCHlavOXULwMS
 qJ1+zRcV
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cb07e9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8
 a=69g8Iwx80a-1R0TaFSkA:9

Now we have the f_op->mmap_prepare() hook, having a static function called
__mmap_prepare() that has nothing to do with it is confusing, so rename
the function to __mmap_setup().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
---
 mm/vma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index ac791ed8c92f..bdb070a62a2e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2329,7 +2329,7 @@ static void update_ksm_flags(struct mmap_state *map)
 }
 
 /*
- * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
+ * __mmap_setup() - Prepare to gather any overlapping VMAs that need to be
  * unmapped once the map operation is completed, check limits, account mapping
  * and clean up any pre-existing VMAs.
  *
@@ -2338,7 +2338,7 @@ static void update_ksm_flags(struct mmap_state *map)
  *
  * Returns: 0 on success, error code otherwise.
  */
-static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
+static int __mmap_setup(struct mmap_state *map, struct list_head *uf)
 {
 	int error;
 	struct vma_iterator *vmi = map->vmi;
@@ -2649,7 +2649,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	map.check_ksm_early = can_set_ksm_flags_early(&map);
 
-	error = __mmap_prepare(&map, uf);
+	error = __mmap_setup(&map, uf);
 	if (!error && have_mmap_prepare)
 		error = call_mmap_prepare(&map);
 	if (error)
@@ -2679,7 +2679,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	return addr;
 
-	/* Accounting was done by __mmap_prepare(). */
+	/* Accounting was done by __mmap_setup(). */
 unacct_error:
 	if (map.charged)
 		vm_unacct_memory(map.charged);
-- 
2.51.0


