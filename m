Return-Path: <linux-fsdevel+bounces-60531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DC1B48FE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F41716B4E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD5C30C605;
	Mon,  8 Sep 2025 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IRaKDESF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tiagTWsu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB030BB84;
	Mon,  8 Sep 2025 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338713; cv=fail; b=J6g0slxgIglP458YhtTkphyMlrjuZc3bDil0XUBgCLBjYI6wS1WKswEvhVx8kJtdIFbCa1+LzT58im9OOrjX168LmIaEC4ka9QFrq1//cts0k86If1wC/q8yruVo3v8ktZjaqThtqmN4a5WAacAC5x4TM5r6Ftl+SlHXDwytWe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338713; c=relaxed/simple;
	bh=b89e/9nQu0AHfaOMVCoE+IE4iPTTDLr45vU4CzvG+vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tkM6YnJJmpy+ZnZQRmJQuHFHwi1Wt9pUEYg8UHckKTK69ILn39y5FtGrK64cT7SscjNckBgqnZOMYzMnPj0CQwB8AUO6Z7H/6tIhJCdhe7522G/uANgqMLNtaMOe++DeN+cPVua8gtK5mSch1s9YPaJyvsc6Eq5YFhLnlgE0knk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IRaKDESF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tiagTWsu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588DTsj4022207;
	Mon, 8 Sep 2025 13:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QKDQQeIgJvrBmA1J1O
	vo4nTrwIFDKNW21ZOYIK1ive8=; b=IRaKDESFj/koqTvYzVqSsPgsLzbKZvhiNf
	woC3uR70o0DHpaKVup6l0OrbImECbuDJqMCnI8DvVNhRsaTLZdtL1ncs3jaK6iQi
	5wZ2gL2G71Nd6tE4LLZvyiCqpPCodM72glp+mbrMqZ7FvgQw45sxdj7qmcpYwf1W
	8GqJrjZtfj6X2uAeCYHpJw2ywVcot0Pjos4EJr29W3f/8u3Xcn52O14ppCFex6S2
	QIzLAJ9BTWrN+K9UuQn4RtzDHg++SpyU+PxP1Fm12+ooXt7a6Eq3ahOsa1ZkJ7y0
	vA5D+dz61I/fePpqCnAmHlMv7+gs9gl3nGVno6zu4jJVRN/V+7Kw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49202ur0tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 13:37:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588D31CW002971;
	Mon, 8 Sep 2025 13:37:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdeqaj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 13:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS4QM7AGMADr3KsC2OyORgamfJjUWoGH6rDC5Dg6MtHblJrJ+uQHw+BeciMQZYGKzbcxoSeGhepuVoLHLyVlf3TCizRlW7vYA+YQY9yTeh5IvQBMYaik8GBlPrN8XPz0ydld077RyqKBGwW3uCJsrfD6e96+rEKO+/3/s0/g78MDJYLmYOhVvWW7ojiZn2iIn3cRca1n2cBt15WrSk51ppegbQL4PwJFSybTkTEUucYlpqTEIOMWwjGpEsw0Qov6viuGF0BN9uVYXvcTWow6Zn9QN2FZ16fl3OnmmGN+5BHBm/jh3KI+DJmPSAkQ7RA5XNXYr3gp/6VtPyBrc8CX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKDQQeIgJvrBmA1J1Ovo4nTrwIFDKNW21ZOYIK1ive8=;
 b=scAkj8+a717c0eeBvT/96SYEJzoN/isbQW07eHDbaPgR3sPrKV1xyDA72BfIYE0ICsYnTgtCt7yU1oL9WSlmRrrUl7BZrQySZcsnpbHqA83WeugUzVAIypmN8/ns/eNeFiSDmAHm3Nu+s6a7EzrAKOZx61UIQDunKcYNqlxhDbkrPHpHh08ZlAQgYHRnaqU80mkbKi3Ly0NIwMDVhP8c6PgJa7ixwGmOOn7qwEjbFc2J9S0teIYghHCy6zhhUfS5RO/MkBg6lFloGsuNTYcfck0OG8TxeWwW8EwhMBqfe/b5ZTlCd5QA985V4HkyP28J/NsbQ5lM/rw405EyeUQjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKDQQeIgJvrBmA1J1Ovo4nTrwIFDKNW21ZOYIK1ive8=;
 b=tiagTWsuTHVLZTI5kq8IvPe3tZaXj+LhrkknEK8nTW3e3HJ/TIW1QsG5Kr9PyIF36+Rtukiu7pkwIcplh9xdxzG66LaDN29XRh3ZQ60E3VCXKGvBGRz2gaj+i6z4S4L9n5LJsK1QYmgoL/D+AUHY7/JOTapFu1fd+Ftd2o0dnJY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6864.namprd10.prod.outlook.com (2603:10b6:8:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 13:37:46 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 13:37:46 +0000
Date: Mon, 8 Sep 2025 14:37:44 +0100
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
Message-ID: <f81fe6d4-43d2-461d-81b9-032a590f5b22@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <346e2d1e768a2e5bf344c772cfbb0cd1d6f2fd15.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908131121.GA616306@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908131121.GA616306@nvidia.com>
X-ClientProxiedBy: LO4P123CA0377.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::22) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cef9cd8-e496-49e9-88cc-08ddeedce573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?flIDQQemqMMmbsM+NoeGLiDNZ0azH523/6jda4Jdq10FNY7OCxRJW3ClUeXX?=
 =?us-ascii?Q?AWcVdVyo/smo+C7e4SZNLuDm3uRf/rSF3JlETIwZxQcqW0b7JLHx8DS32pet?=
 =?us-ascii?Q?/CgLZW99NCNacZd23zK1Wl8gzZ7h9qNAw4n1i3u76pyD0uvFf63x5Qdtlpo/?=
 =?us-ascii?Q?Q/CsIv1phf9ugnHaj9Ij1pIhy0XkO828PqNUhSFwuuLFNm3SoM7edeqALytW?=
 =?us-ascii?Q?4piGj9p84oMB7VBkWEz46FUSt2EP0JwS13tVQ7mtvBiLfpcrH6GBP4SLrMuV?=
 =?us-ascii?Q?Id1duZ5bWZa2M0I0auH9XcvRygBFwHlEJBRQRs1w/8eijw/xyen/kF6DHL5B?=
 =?us-ascii?Q?KB1jcbnRpuv+f6auq3bd5nt2nfXcUHjSNPIGRtVOMu4MqXeekeS6EixDLlea?=
 =?us-ascii?Q?R7yXLsftv10aY+5p03wLUqUxQkqvAVgkTF+PphLDkd1mTDuTuZj3E9pymzn0?=
 =?us-ascii?Q?F0nCPSo3AmhdvjBujdprnppxPjikiDj823wWUfRg9dtYF23N1c4h02KzbhYI?=
 =?us-ascii?Q?zn3ZJ1wkX3iQ8os6GE47L43NuqMTvN1hP9tKiNhf/fsrUq0fP7YAF/hCXt7T?=
 =?us-ascii?Q?rPBD9s8MVOfSpb3AgvRmwynA1N8mYwIcEmr8QAecboYqRFyCEKkrLupRlduR?=
 =?us-ascii?Q?R5rWwIIZNq4x9bCu0uSxVXmETDi+TjtMELvtjVjd0jD90YD72adUAWVCVMrw?=
 =?us-ascii?Q?zXxK76Q3jPu0wMk70T18TWOsBoM+fhKy+qzIQYSKO4yGEn5VKqFZ/4NZrSwq?=
 =?us-ascii?Q?IQQuLzJLLiXk7mpUE9EgRAgM0tvJIzAJBqAIqU8+yeEczRv7UxlQeFSt13PN?=
 =?us-ascii?Q?+BCtK7LSfrKRbn1mBuTUEwlVSbBMsSLvbcQbhZlhf1eQkS6yi76CZV2MrmeG?=
 =?us-ascii?Q?QBbLAeABUcS1Bdtv3nGxV0g+3hICNF5GmdsWIEoQ16Ck0fO13VmDuXnVbUk/?=
 =?us-ascii?Q?DqJcmQhaJQ73DCVw53whSBiAhALhU/ePmIw9edJH2TjAWaiGvcvMPZuvQY44?=
 =?us-ascii?Q?TScIvnAppQG4jCQsQmbtEzQANkKxc0RCTsoOrsiBIoj5M3ZsD3Z6Uw+gulhB?=
 =?us-ascii?Q?a91g5UH2dSc8ROJoG3EAypKwIIjNJZEU+6aVXtecKD71zaPKQyaYyArny3aO?=
 =?us-ascii?Q?7MoSTh6xnX9AUT2Iw+s+OnQ695yLd6wVMzSLmjTt3R7BIN0hGfRsooOQ8bvj?=
 =?us-ascii?Q?K41AjW5ioeNyu/GOHE7cxulKYo9lj9TbdGb798e93MyDNfNRddqaiRr4tq72?=
 =?us-ascii?Q?L8xaY1BosjRfUq6DAvYUv7p1MtY1owZvlBF2M5mNxuN3fBVQG6k7tOlFlO57?=
 =?us-ascii?Q?CLglKLZgTt6wgtd6YTz/66ehETHZsLf+Ib5gZ8iKclE/LzA5vi5WLA+GqOVC?=
 =?us-ascii?Q?8fF1XkWi1rVcb7CCfA58YMEqaXMFlAF+XVcEA+AGnrrm5nOT8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZO3KFM9CtZUtT+mkMMrLumiMaHvhOPZfgkO63YfdJ0ldFEcr2Sanoa+aUqCH?=
 =?us-ascii?Q?ZMNpsqFV9E0CB65lBhGwHI65RCuCFK6k46dXqs5FMQGNbLVPJIKfDgTZ/niA?=
 =?us-ascii?Q?ZqE5bGbk+8SETfYSfX4TOcSDzBGKe1VfSDkqhl8bEQTpkDBMtQGddmP4uWj0?=
 =?us-ascii?Q?LFAdFSWgFnzFDyNRsIHramVwVcEy7R0YWP/BsclChpKgJ6tEovx29cwr7HYD?=
 =?us-ascii?Q?+yhoMDXXITFB9GJmZK8JUDC9K9wT8BX1M3ArKlEI2GxyIL2Jk7KdkC7NDHDw?=
 =?us-ascii?Q?91ARDFk8bgmR24O3xrL1ppJ+1bIB91NjmSPkDzX50YH1x7gkQ9K+vGBbSq3u?=
 =?us-ascii?Q?3kzC/cIZO1ARnyqdRR8gvPRpZCJ8P05pDEW6GhdbxgyRA58TmTnqLkdXAbst?=
 =?us-ascii?Q?VbovrRe7Vg0NLg8ZsDjtSbH+V0j5Iy1R9WXHadT9NMF30zs1Q3+SYB4TFnXS?=
 =?us-ascii?Q?bRitJkZyHuEnXRoHzY5ur8IjyacdIuHByxui46NxaeQoYnAwugcWg99tF//o?=
 =?us-ascii?Q?IFAKjpTNscJSUu58d3GyAx8A9uNrHXxPjIUkwHfs5aXMISu9RDn/Ekb7EPkc?=
 =?us-ascii?Q?aJJGEfNaLvHGqBoRMFunPrrfT2Ttz2815tcONKL+/RiPKuds/KTXPrLl/TsQ?=
 =?us-ascii?Q?W1DHmNBSZBGfLpbo5KlZhEY0YC6Ku3Kz3h+dVVg/JJ9LU/DdZff6GJvndQpV?=
 =?us-ascii?Q?tzfhGAK5xwU1nayTwiuclEqOv1g71cTJVIScStQBcovpnd5ifr3Fhcso57av?=
 =?us-ascii?Q?8p9laj9Q9+qlNm+dybLAUuUXVr4iiM9nr9LF1+LzQohRS5SZShOhgvhOVaMz?=
 =?us-ascii?Q?fg3lYZNoY+F8DGJ2kBCosvtYwoQfyIkuF5dDhH8g7WQkseFXjP1K0Ol2ex0j?=
 =?us-ascii?Q?C8UtN+0WZBwUuzQVz5pIq2egBkq5XKbTRqPw4qVOT6NPxbeehRfjQB3hJNK6?=
 =?us-ascii?Q?PpH2Nkd0T6inOp1SGPNJRZBotqS3Fk7YQOz/2Dd52gui3ueWrsAqNb18Cl/8?=
 =?us-ascii?Q?Iy4a3tOpQK9iTgqNTd/qaEx3lOt6kXhH4ys26jBHx+GinNT56SWezI0RpOx6?=
 =?us-ascii?Q?LcIKxjNaFwRLfDNuEqQgtPl+0F6oT+gX7nEInq0zg40VMx49Hw8HHVF+1Vgu?=
 =?us-ascii?Q?j25kJe0Gre0TdYBGwMoVNZ8odY6/XEsCFEChr4oDvQfMQ9FPOlquWXANttKZ?=
 =?us-ascii?Q?R+QvNWumgPNUHCe32eebs5VQO+C/22BkYrSlD2tSc3YpeUl88f9MybBa6nGl?=
 =?us-ascii?Q?nL6pyD8KlnIZERezfL6ATGHoOzdanMvpPDXRh1+y1l0tckOtY26Gyg4kvnSg?=
 =?us-ascii?Q?doCUDylRGQ01vFBnyQiNAYfcba3CtTQeMvhUrgGMkn+GWBdKlnOqWMZuQ6lZ?=
 =?us-ascii?Q?+XQNNPTiKsyysTYqqFN6ir+xUA7CrHL93qt7nREdgqau6JaBo4YcRKiNLVqX?=
 =?us-ascii?Q?HO0vaMin7GSbDN0FHUnTb6vPWpGbukC2IXxd5SUuvCsnjm/iE4TnZ11VrKkG?=
 =?us-ascii?Q?6IndFm4fJtdbaPYqcmFP/NWBB1KaGHYMS4YP/1+p1kpmmnCcZLLGc0ehisQf?=
 =?us-ascii?Q?7umLkVt5pTBwaPrelL+jzKJQARHise+HoV8fDo81MHT8or58cCiDKtAOU9MG?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xBpO7J7igySuPaekXR9dzMzDE1w7HP1fDgYNHwAd3l7cnxQBNiW9ncW/5QBTswU+nfvWG6FLdrk19buGjShrXxRujlmShHVKE/JSo8TAZLjDMI5MgWUd7B2VCNoDOrKgBqZRBpjsmyo65ZG08AIhUesx19TAzRAdynBNuNbL5uVlrb79SFcPuEibYMOqjyhZwco7lccyxacZzzlf8xGcciENttpzLOM6ZP/d6qra4h42IKhV+3mtLN3+EYHtCzA5vHPf/mYXhyYhT5UZNN9I7EBqRaJOarueh3CeeJjMBOafJIhjOkPNuIDATuTa9U09LW+ftuTXkQvZQheDmlscZSahfITSUpk3+j85IGD0IELrdZ3mckDagihALTtPFzH03Le5OxNryBl24oaQxca6bWqeqEVGbxFJmz76BUBBZ8WK7HKetgteEVrif44RlFO7rdOx2pb1nTj13MprE92k+7uGVrfmbd3fDFgOPkvTdJINxLWzjpVT6RvifUW16GRauWvZsldUTVgmYMknGV3Q6uff5iic5v/zQ9PGx/AwpNlmFa5OZka39qRDzDmRrqPAB58PVE1EM1trf1/7MpwDyBgVKOcipFqZ3cXYJHuL62Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cef9cd8-e496-49e9-88cc-08ddeedce573
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:37:46.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+YF7jNwe47kmwt5uQBQyBb7EGsVqa3Hqe9F95zfc6naC6BHES1UQ0ZpAgqurINxq0iv526P/HyBpycYdEu4oeSf8fWYLThxS38VOw3hPeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=830 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEzNSBTYWx0ZWRfXxgdYLuWQ9/vg
 z8xNoNRhSECjLlC3mF6ItZdkKKGoAMU/i7beQz/XukGrYsBImAo+5untvHG76TTYAgX5CkYSAZx
 5g1sBDwtHWNH0rSp4EInxoIZPzcCX6gT75Ya0NZRL/GVVjF2e4Ta22eQ52YNTziD6OKRqqBnUEb
 tYQ3mUJmUpWlhRbORLBVYfnAmEFOrfxRKPE7Ly5ioX9t0k8EBMA+RCoZ05hGsLJ3iPAh4Dp/5Nn
 iPAiCEb+rjovmbZ4+1NbBsEJUFTqHb+vwqFneTs3tKTvcqBpAv/eSZQaN3ibUMDfxQ8eTaSE2po
 /1bBCStLgZzZBzFOidhL9lhmWeJupFWznTYKgxs7sAyGyFa05SZ6Kz1wvCZSGJLbRtcuFvEZS1v
 Y3R+C98sKSh7NGGCTS1KR+NwA4VkCQ==
X-Proofpoint-GUID: q70cHU5ELKcMLGjGb--ig5pvOGonFV-7
X-Proofpoint-ORIG-GUID: q70cHU5ELKcMLGjGb--ig5pvOGonFV-7
X-Authority-Analysis: v=2.4 cv=HN3DFptv c=1 sm=1 tr=0 ts=68bedc30 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=5G2UyHYFvs9mNkJOU74A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069

On Mon, Sep 08, 2025 at 10:11:21AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 12:10:41PM +0100, Lorenzo Stoakes wrote:
> > @@ -151,20 +123,55 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
> >  		vm_flags |= VM_NORESERVE;
> >
> >  	if (hugetlb_reserve_pages(inode,
> > -				vma->vm_pgoff >> huge_page_order(h),
> > -				len >> huge_page_shift(h), vma,
> > -				vm_flags) < 0)
> > +			vma->vm_pgoff >> huge_page_order(h),
> > +			len >> huge_page_shift(h), vma,
> > +			vm_flags) < 0) {
>
> It was split like this because vma is passed here right?
>
> But hugetlb_reserve_pages() doesn't do much with the vma:
>
> 	hugetlb_vma_lock_alloc(vma);
> [..]
> 	vma->vm_private_data = vma_lock;
>
> Manipulates the private which should already exist in prepare:
>
> Check non-share a few times:
>
> 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
> 	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
> 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
>
> And does this resv_map stuff:
>
> 		set_vma_resv_map(vma, resv_map);
> 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
> [..]
> 	set_vma_private_data(vma, (unsigned long)map);
>
> Which is also just manipulating the private data.
>
> So it looks to me like it should be refactored so that
> hugetlb_reserve_pages() returns the priv pointer to set in the VMA
> instead of accepting vma as an argument. Maybe just pass in the desc
> instead?

Well hugetlb_vma_lock_alloc() does:

	vma_lock->vma = vma;

Which we cannot do in prepare.

This is checked in hugetlb_dup_vma_private(), and obviously desc is not a stable
pointer to be used for comparing anything.

I'm also trying to do the minimal changes I can here, I'd rather not majorly
refactor things to suit this change if possible.

>
> Then no need to introduce complete. I think it is probably better to
> try to avoid using complete except for filling PTEs..

I'd rather do that yes. hugetlbfs is the exception to many rules, unfortunately.

>
> Jason

Cheers, Lorenzo

