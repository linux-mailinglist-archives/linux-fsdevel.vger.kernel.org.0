Return-Path: <linux-fsdevel+bounces-60540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8974B4913A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B603BCAE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2E430B52F;
	Mon,  8 Sep 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qcOrMTHT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GuchOSAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDAC1D63E4;
	Mon,  8 Sep 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341282; cv=fail; b=sNiFWzsS+tNj8cPI8YF5BYhcfAx5+rjMOvXmlCgqhcRpr+zszwVBNJp157yNpND4Pu6D/mSh1BXbsRfT+FUpu46rAEsUfrdE/804FTs+SYe+QC20EZYBm8Egc+Y0fgfMc377IHQ5rv6FfMJHnXi981hAAo7aAWFbUFB4gKDTIw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341282; c=relaxed/simple;
	bh=tmtYjePhUiaiJuRW3twaYfJbTVriS7lYLcVjH0zKSkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vzh+ggIzVk5SAsxiAvM/b2TqhZZvRvJIqpouMsmNPuMjNMAQr4Ccc+A5kANC/Q8RrTfVpCjmT0HlEG/adnJdLs9I5GfXysc/AliBfNWd9bH3cUrvllXeeUy04jngUPpm7SasUKw6BeW31EVHTEnCQHwofO/bdy5JnPNoJkxIgVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qcOrMTHT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GuchOSAA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588E28Mb006494;
	Mon, 8 Sep 2025 14:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wfEmfOliu6v9Q2jCKy
	8mwJIIEZAM5ZL2Lu/9af69v38=; b=qcOrMTHTWALScsR3WjrIhw/tCZu6tF4+yt
	F415dMFHdb6GUdG3RpVs6wvqKNzTTGNEYDg3+Xh6qRqkqC0oiqMZAoiLSAVlvIeb
	kRENTzWcSxi16zKoJOr3I+kMrWhh9j5KVDNNHWBwcC8K2BiUUIRglJ0PJyEKhF0+
	Aq26Cf9zNqKFFSMnX4ii1/ax53djyp1Qc56DraDff9gYj33FMd/89eOSKO3cSWN6
	Vb7L9xe0+ZCcNSWee2RjFU6pM4hI6tQwEfcsFXAozYZXCnhohACj0BEzJ6TXBjy6
	BmJvxsuOoisb0iC2U39DxX7mm2HVgjROrHszhGz3cDnhaRMERQug==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491y4br834-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:20:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588Dx2Ch012871;
	Mon, 8 Sep 2025 14:20:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8g3cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:20:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzWobYM3uVK6zcqe+sNRs8VG4wSdYfnZdt2nKwhavSk1XSBaDQZJ5uok/j3ROGzCtZtYWgk6FRz/lCKeMk0xVNn6el8+LZM9zBrjQ4pf/g+sTeSXZDNYaEK+bi3Dr9KshehW8GPdaDSUwxhS3H7xdX1ykPUTkw0CJwJRPwsQUGvBUw1B3F8wLG9zu5Xt25duDZUA6tJ1kctV6CZ6Il0b3QWQYeY5iYaNSHJ7o5CB6AN/n0D+MrOQrEsc1KHldDE+jYiXVGn38RZpTAgHFgUYP8zn/VGnigAU9MVlz9HNhLijDE6RJDWNxQGbx3flioC4rbZ1Sq2UY8Lg71fiaP5x3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfEmfOliu6v9Q2jCKy8mwJIIEZAM5ZL2Lu/9af69v38=;
 b=wFM/y+iKTB56W/6Bcn8GmfPoYEoPxKyzqiL2PHoeg8iciRUO7e8u8KnlTSFk8bk8q8wckZ85R3w2is+NGMcaANyNw3giZw/itS2XyNMFLv6GOmgFut5JHVjS+30cZp3KD2YCCt6WVSUVNE+AMi7cxomnqif+Xc1kaF4Rzo9tnbWRSirrGEetgP1/pYjX5Mwofkw0ScOhQPrnrWCiU+WW7ymJXyAg16YQkZ7w77TgEov9IXxgBkl81NTn04yUqTn2hGQDzTt5eFhzl2hJ9Q1zIswrm+nzRveHPW7VqrFzMDOORk7AFkebqMqQ5olyqy3u+ajLAEpDNuzkvme+VuNo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfEmfOliu6v9Q2jCKy8mwJIIEZAM5ZL2Lu/9af69v38=;
 b=GuchOSAAFmDk7DMdCHfZoMcU3fGcSXVHoaBdpcWNTOlNYORPCsjCy0K4dl0rszWVPzzKdWE4KiykaV5obG3Bt7+yuSjagzSS8/NXQBt0EVVTN68XFfm+lz4rla6WMzF0VvR91RR+AtdaVUwFct0Zl0JvFusMVKg1JyhrPIpQRNg=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by MW5PR10MB5808.namprd10.prod.outlook.com (2603:10b6:303:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 14:19:54 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 14:19:54 +0000
Date: Mon, 8 Sep 2025 15:19:53 +0100
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
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 10/16] mm/hugetlb: update hugetlbfs to use mmap_prepare,
 mmap_complete
Message-ID: <d9121de1-e929-4450-8e19-f1df8b617978@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <346e2d1e768a2e5bf344c772cfbb0cd1d6f2fd15.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908131121.GA616306@nvidia.com>
 <f81fe6d4-43d2-461d-81b9-032a590f5b22@lucifer.local>
 <20250908135240.GI616306@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908135240.GI616306@nvidia.com>
X-ClientProxiedBy: LO4P123CA0228.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::17) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|MW5PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 948f7875-5236-4ad9-227a-08ddeee2c83a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mS/QWDkmXtclGx5wjq/tq6BJOVrEZG65ceMC11Zto7Z6XvSxNkMgngGUaoer?=
 =?us-ascii?Q?sG/btw8oJLnm9Fuq0dsWJU52whaGbMoZ4C3y2/Dhs0cujAZnxsKiaSNgSEWG?=
 =?us-ascii?Q?7JcbhSCR86BymiUJBx8UYYPTG4rvJk0RXjKLgW/wtAXW8C06HfTJtT0/l+7W?=
 =?us-ascii?Q?TTIMMYedK73vNKsN9k5lOWbM39jDZlpsZ7erbGP6ZYdC+cAVjxk7MdF2KCfg?=
 =?us-ascii?Q?ISWePq48M4MPoZ9vrCOfyO5JeFqoBjAx5/fZukSDB/eKFgO4IdYNjrNVv92y?=
 =?us-ascii?Q?kCK5nllnbi6ZfxLtK0FwkfuIeCJ+NKiJ0+doc6R1h0pdfR/8+isL/2XDufuA?=
 =?us-ascii?Q?CuDk/0e+3gWStBEfMveNQY4I9BmRiq/Dbr1elUrGgHzyqID+94fonZKBz0L2?=
 =?us-ascii?Q?33X/+sWSZH0Do9tCN4JPB+2/4C60hySdA1rf648y5OazCDhf+FLNfzpZJt5C?=
 =?us-ascii?Q?ptSrYDFAzqxQvlWJRTX3XYLcLdF+j+aE94623exaXZDinIwLzt6afh/Q+WAc?=
 =?us-ascii?Q?LN35JfzhsSSoPiXLoQryXITOVVQUEUkLu2FjoYnXgSuLzdLNAKBcsPoNUyYO?=
 =?us-ascii?Q?zqgG+JrosDwOzxQlnzieM+Ji6brJ5ReN6cDf6Kpnmu9B6CfxoGCM8ymD1AT3?=
 =?us-ascii?Q?PDU6sYpwXizZ9Ng5nP3Fj8B6wocaQX3okMpFMY+42vgiiAnoCEuA1UBq85Rm?=
 =?us-ascii?Q?2Y3KbdtK+EKMdEdHJ0Hv5eHQl8BdUDDfeEaxTds5jn+wdjJjis7WARDRZ2C0?=
 =?us-ascii?Q?89kt6T8cJEyaFFWE9gAKjsq1cJQBtU+6GxDsgcCEiER5NnjoF27zlLKLGKnt?=
 =?us-ascii?Q?O4h2g0Vi98fjfAG4f1vST3n9kZYWmvL5MmR5xxTh/jVgP1aXO065MA+VLdzG?=
 =?us-ascii?Q?XwqLH9nS/k3HL1JlPgFlMARaPjwhLvIjOnxUsF10tPDzdZU/sgNzolgo2DC8?=
 =?us-ascii?Q?l3eSbajcM+EViX/HtYIOYMuOn0XOAM6qjR+1EiFAaFOFM88r8deplc5es+hp?=
 =?us-ascii?Q?Izm5EilK1ssch4wxzw1K0J1ZSPPMIAhPKyRbwfEprDpNSIFISNqMEd1c1mr/?=
 =?us-ascii?Q?n+A+isiD9dOiPZW+zrWfbbaSyyKCJXLg6Hgp/qD3aJzO6rZE8ThS+HojjN1m?=
 =?us-ascii?Q?Cj2lSAKf9UCcMaSzz8AMv3p4h70749KSxCV3SFDiMvhKKQZV6lLiGNi9CBkv?=
 =?us-ascii?Q?k86qgVLBxKhAT9s2Lxm5oPHfR1aWLj9aSDhG5HQgXEh9AI+3jptDhf13Fn35?=
 =?us-ascii?Q?nW6gzYhM5HsmPiyv96pJhjZOL8MDavf1DH+jNKxDIQwlXPNo/dWpKEWUkGRl?=
 =?us-ascii?Q?UhVu89IBGYpYpbiRW9MR8LaH+JqkxHlfTr4aq+EWICWWL3DRS8h4B07h0Klz?=
 =?us-ascii?Q?5u9FhZeGmQpnBzdLjh40pz/IL9Fj15wSd8JKUmKUKqjD69raAinS9kz8h083?=
 =?us-ascii?Q?BqNeqVPRhUM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XQ4LfOpHjLLDdprZ58WwCNfwq69GahNDuS/To72XXqIK2IIq68oNCO3dzINV?=
 =?us-ascii?Q?Tfdbf4hr+8JjJoMzEGgN5sjXfxqSE7UTlbGKAcaoxZxVmi7n3LMvOC5eiR/h?=
 =?us-ascii?Q?2jhoueZ81+wKBFqXSxYfapvDLtrleB0YLpVviQqJQFEQDiirp1+c1JtmQLvJ?=
 =?us-ascii?Q?Kznns+7zEqJxSqJPW6AZAuu4vZfAYcxA+eEnDz5ssEwCQFQB1FLqxysTwiAw?=
 =?us-ascii?Q?QH2XOG9eOqZisru8C1ZCos22UGkKYq7W1hxaXUmvKobJ+EM1y3kVJf2SfmqF?=
 =?us-ascii?Q?Etf1iPWpRG5a8eNvq03dFeBF/LrNk2srNKkla543r7V+2tQkACQZxZ/3CRvN?=
 =?us-ascii?Q?yNy1WoxhMLN88fTxVp5lUB5Ztfs7tkoe3HSDIE0zTEfUgOYGyqww2/qvPkp5?=
 =?us-ascii?Q?o520fckvz7mMMdDWisQGXZe3YXeJCkewckk+lrmxAQEShclDa30obL3BgVTh?=
 =?us-ascii?Q?HW3mBX5uT4pjyoa5cC2z/ytvuwhUkSsa1nSSOXloRAMvu3I6hl5V0mMqAb8I?=
 =?us-ascii?Q?oycmNF7JK6nfCTYoVsEtxOwxqQzfzGF91OOP6bKFsr7Gg2I+rwOxuJAJuHzS?=
 =?us-ascii?Q?aRyHejgTTJXgIZFeDF6uW6JNvnZvN0k37Cf0htAZBGhve0STt+Z/phN0652D?=
 =?us-ascii?Q?b53gjtZZBcWSriJddryKV4L72MYKH5z1GOiV8vmplRO/NSJlBFPCQ4G7Iinu?=
 =?us-ascii?Q?xeeUGN020bG4CzsqKgX1eISlcwfDoeWP24hPMegwwnqELDJhji3rfcZxsl26?=
 =?us-ascii?Q?AlHZWzgcWXvehWFhS0QckgmfVa72GnJmhLt1BbkbIFgCyBVJESEVBtfisF/q?=
 =?us-ascii?Q?RYHP1tEj2ZwCCR1gWVahZodkqA6mMxFLoFB4wfBTZS8giKiU2wPBmULmU5lI?=
 =?us-ascii?Q?YxFcohoVLGS8KjWJyk25UaxNHBeTX5ylEwgP+jWTawBOKtFgZ0yv5SocBShC?=
 =?us-ascii?Q?bXzDcjQ3yUem9BwiiubWQVG0sLpkNIxlsh4ByJfeSXE2XWzIYL8Ywfdggxd4?=
 =?us-ascii?Q?Z7Mz40Aad2aPwO1sSfsehRxzYV8qRI0F7/0cpKQDwAx1+gcz/KQBJOc9s5m9?=
 =?us-ascii?Q?0P73OuhsXXHJHfUJXV+R+9zjxP6fc9vsEvBdlbodZS1auI8SR+udF+qjzsDE?=
 =?us-ascii?Q?1Pb98aUZ4hQb/YkLkesyyLsy/FPzcs3tj9IBaks7EFWgSr5GCLtxkCjGcG7N?=
 =?us-ascii?Q?dnpJus+3PptWLr6T5Vf0YwQ4K2nVltXAADBooFT8sR3Me4/s9vgo1PBQeIhV?=
 =?us-ascii?Q?cdJi119qJxEgd8rLiF+DkA41OJkapFlsbyVBn9XRt24nOlu2voSOY2dr5g2E?=
 =?us-ascii?Q?BwdE2W1qLiX69UoAatplxkYHYCMDOB9CGAarxHkc4pC3uZEiOrCucuqWxI2a?=
 =?us-ascii?Q?20KBCrk6Jw5hzu/2jg1NfsQXEpK6cHxd/tS8f4gc7M8D+zg6CP6ix+Gh0yQY?=
 =?us-ascii?Q?Y1MNjEb+kTmzTfcmDbFIUJzFZ5gw7RunPSs6I3RmEljqjO65+xATrMPGD+mI?=
 =?us-ascii?Q?r2cPLOkcUP0EKsbCwIOqmitRffnPghtMFoSOQHQk1dUYZvHl8ugMkLWyJfpR?=
 =?us-ascii?Q?w/42Xk07oOboJ94nSyiFVGQgLoBARL7jEQtq/XHZxotdxp+Q8TTPqXNdHPUV?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eMLTe/51kh5Yfjnh9AMCF1fBA23noy0TJ/j8tP+VxyeZzzafuO085XyNgzgtsGhu4kE7F3ZBsPzWXCLCoOzgqy0HlW+y6IjKFcCI89z3m8gAHOVXYsMpO4kD6pK9hx5itC5Bbcuhozvtey6cTg4soANaYXNCGsEUqlSL/2Qb5h9zxNKbhKEFPR/Nu3UhW98VTJdpjKjQ9Fql4tQUQkWRSpKOPIil4YNMVx9EcQl2JstZKXopf9XVvhGt3aKMtn7jb0GZw3tGlWYBljRHvnz/YjbUOUxt5Ty0/r85cAooLvbsZFYBZoVbZq08VlrZbadWBL73gdKTsh0KI7Xj2G64QiKlo/OkPiIrCGUk9hPWuncHXvOjd5esn0FhWND23GX4tFDolcF9Glpd786UKw43gqiUZEOhzDzumXd2xcotDUDS3JrEmDQf1GDPTZif6I/qmyK/sfHy+jhyX0OXFPS5qEPs6piQgLoNbcGcC3lou/hIX6xD6+ILyWniOT4ZB1orx24IvdXJJPN8yoQ2AzXvlNXqJlnYBUzhkoVE+TDcUOipSxq5ceaBOc5AyKEY3YoNDxL3+j+0XQcouxgh7MzmzG5/uEx5o9k+gxu+q60FwSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948f7875-5236-4ad9-227a-08ddeee2c83a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:19:54.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58j4osLP29vjJcFP9hBUAoW7YnlY3OtJRHAXxQXNK6+pGKCG9ch548cYbjkqetYu+K3smnCXdBqHQC8iIWCvRP/g+FH7FhRaP+3bZTJ9TW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080143
X-Proofpoint-ORIG-GUID: RAiXpBTU8WAK94ib7g07JQR43MB07PII
X-Authority-Analysis: v=2.4 cv=ILACChvG c=1 sm=1 tr=0 ts=68bee615 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=ROdJHagua6v1V9-Z0y0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEyNCBTYWx0ZWRfX9EMrtN3fdlTj
 Oak5nNXGh2HvuhP8DQ13BDTAQwI8yiMPW0/3gyFUDO5KJxwPm5xRHsg7gyDJhDVCHTY7OTDKFEy
 2orJ8WClmf0oMalhgRPXFSXDwbbVACmvSgHgQPEGLLaUU6nEfcYxBrlSq4TFiGsl5znWLCBsqdI
 GokvLYI1vRUdJXP8ipVOTfAGjVoyUTWvzY0lSc9flIJmTYo06RLPq5wvxPZfDD8xCuaa/O0nP1W
 zz6Tcb2F1HO7gkpoBj/JljfXSLLcP53CNd5S1UwdOnTIBUmAK8DQKOYEshdRhXBSgzDhCLKkBrZ
 xp1e3yQOhjJ/9bb0KgUAg6MSbKIgt4NmWVEO6gu2cV5gRqEs8h8qijEeSkaXuXT8Xot2GCgVs7X
 QqUnIn0r
X-Proofpoint-GUID: RAiXpBTU8WAK94ib7g07JQR43MB07PII

On Mon, Sep 08, 2025 at 10:52:40AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 02:37:44PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Sep 08, 2025 at 10:11:21AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Sep 08, 2025 at 12:10:41PM +0100, Lorenzo Stoakes wrote:
> > > > @@ -151,20 +123,55 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
> > > >  		vm_flags |= VM_NORESERVE;
> > > >
> > > >  	if (hugetlb_reserve_pages(inode,
> > > > -				vma->vm_pgoff >> huge_page_order(h),
> > > > -				len >> huge_page_shift(h), vma,
> > > > -				vm_flags) < 0)
> > > > +			vma->vm_pgoff >> huge_page_order(h),
> > > > +			len >> huge_page_shift(h), vma,
> > > > +			vm_flags) < 0) {
> > >
> > > It was split like this because vma is passed here right?
> > >
> > > But hugetlb_reserve_pages() doesn't do much with the vma:
> > >
> > > 	hugetlb_vma_lock_alloc(vma);
> > > [..]
> > > 	vma->vm_private_data = vma_lock;
> > >
> > > Manipulates the private which should already exist in prepare:
> > >
> > > Check non-share a few times:
> > >
> > > 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
> > > 	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
> > > 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
> > >
> > > And does this resv_map stuff:
> > >
> > > 		set_vma_resv_map(vma, resv_map);
> > > 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
> > > [..]
> > > 	set_vma_private_data(vma, (unsigned long)map);
> > >
> > > Which is also just manipulating the private data.
> > >
> > > So it looks to me like it should be refactored so that
> > > hugetlb_reserve_pages() returns the priv pointer to set in the VMA
> > > instead of accepting vma as an argument. Maybe just pass in the desc
> > > instead?
> >
> > Well hugetlb_vma_lock_alloc() does:
> >
> > 	vma_lock->vma = vma;
> >
> > Which we cannot do in prepare.
>
> Okay, just doing that in commit would be appropriate then
>
> > This is checked in hugetlb_dup_vma_private(), and obviously desc is not a stable
> > pointer to be used for comparing anything.
> >
> > I'm also trying to do the minimal changes I can here, I'd rather not majorly
> > refactor things to suit this change if possible.
>
> It doesn't look like a bit refactor, pass vma desc into
> hugetlb_reserve_pages(), lift the vma_lock set out

OK, I'll take a look at refactoring this.

>
> Jason

Cheers, Lorenzo

