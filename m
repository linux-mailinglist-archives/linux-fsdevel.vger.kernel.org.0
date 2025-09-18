Return-Path: <linux-fsdevel+bounces-62066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53279B83181
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 08:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29144A43F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 06:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE592D7390;
	Thu, 18 Sep 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fVFmYUwA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KcXlG98J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC342BE7A3;
	Thu, 18 Sep 2025 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175819; cv=fail; b=fjfgdhhaclZ81YxNbRTTU4iGW15RpFmCqcs9qjhmBD1JvqRCiCvAwX5SGf//Z8XVaFnkv/LwKRYYb/Bn1yBE8F6oJan6AMF8N0Ce7mVzpHnZq1n9obC/Pduer3Qt6B1INgI1ZJsr8G0ozsuOJCbsEFmOI9ze/l2gjGtWvk3Uzpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175819; c=relaxed/simple;
	bh=NDELBVZmVnwe0ZgiKldc0xo79SS6WlDYw0kIYeW9k9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q4PC9m+tAtFhoQNGF736kKpjtTMmgjGAPyqw1ewasjtiafpOq2xHiKSmofnCsAuz0rqV62vgiQQkFtO9ANkPmtcYOdWv1ouWlXd3lBh1cAKfqeBczC8YZyGekdlmHGavhozJGqKTBkaVH1WsqILp0tDPYX4ZZIYKYsHyPHX6HhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fVFmYUwA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KcXlG98J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HMgenX010081;
	Thu, 18 Sep 2025 06:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JlY3hMC8uaY9rYXjft
	IMZwXuDPh20OnTaynmLKmt4+g=; b=fVFmYUwAeVdBoEJ4S6f0Yu/T/1WqK6jRGv
	uxNBCA8PkkJGq7wSm8kO7jDBzExwl31gy/m0w/x8mQBsF4+5uLz9eqval/uyM2b7
	ay2dvvcQEq5iiBrjHTlQ5r5BFnaKVf6+59FMr8jDmy0KbDCs6nygfiuHp1vmq0ig
	YEE1ptKYlh8J/OoOsoWI3dQ6saorE6m/dDDmSBPad0uSWwgjQJO8dkbRB63cmaUy
	JvdpzWQf6orXMc++JYhWmwvs2mSlai2gqj9e+NsoWcYtmiUDUYdJ+zi3/4P2esk4
	Gv6OF8NG18iHYo/wxaEEHAMR/8gHW4xGASix7JNSBqCfCUj0ku3g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6jrbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 06:09:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58I5jCJD027359;
	Thu, 18 Sep 2025 06:09:34 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2my32t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 06:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCF6RnAOCEpgcqcZNCDRSNd8ok59DuRUDtnDY6NK4KAJO7FENVybK/JYYWvMceAHajGxK5TjApgGgy+6TCOWaRdk4CQzvN/+G6XrVUwiJpm24ucGM1kFoq3x2iCLpOkZzqrnfdpccrIuMW2co6Ph0Ve8pAsnwPkqdhfPI4/7GHfnRoodDqfs+ODxJbfD2O13yEAxTiHGbcazVkeFhnDetkgl6y192j/Hyu54q2QaYV2eVyqFd1FlHLy7qB5WtugR6qMP/l/r/j7mqRrO9ujf8IPvn+2vqdh6DkjwG0Y31zP1WCNxAiFEqwaP8u/XmJPehKBWUQoKB0kbDcSHjNojYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlY3hMC8uaY9rYXjftIMZwXuDPh20OnTaynmLKmt4+g=;
 b=hHaeCoc8JqYtgDlQDw5mTL59gGonELKBU5Vd2dOjj7F4Fb4UGWA8RL1AfhMzkjYvJmyHgGrST/Gp94MPXyHoiFi1mOhG+/rZ+pTbsJcS+10yHLQ+XWKA1bbTleMMyw0JAnmZ/8QeHM2EHWvkNC4eRV/9tWEczH0454pOj7tpTRfQJkrXZf74S50qTlMUAZhmj9EyVx8gqR1fvLOwiGaGuMbQm/M0eTlE+JlPAC6W44JomPpsXTu/WgIdJlqUlAvfFFAXdogcU8ZPI9kDI4530edfxFOY96FAkW18wtK1Zje8ecbFur3kojC8uegNz3gTVkGVR8HaE8bEODMr8hB/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlY3hMC8uaY9rYXjftIMZwXuDPh20OnTaynmLKmt4+g=;
 b=KcXlG98JN01YuXw8J19OEVDiNotKN3EHjHG3zfSRajU30eXZ6++RCewBq8ezhhhDHuMQmfHYpskgeYIKO/AlKOyAFJRWNT+gal0KyhA707j4OmJXI2scBlnl5ZettlVZME0ayXd6UQXDhCGBkoGPsfdA1sEh4GJnDO6Yq3Xv04A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5199.namprd10.prod.outlook.com (2603:10b6:5:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 06:09:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 06:09:31 +0000
Date: Thu, 18 Sep 2025 07:09:28 +0100
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
Subject: Re: [PATCH v4 09/14] mm: add ability to take further action in
 vm_area_desc
Message-ID: <df1c197d-ff38-40e9-8466-829bc5d4e642@lucifer.local>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
 <777c55010d2c94cc90913eb5aaeb703e912f99e0.1758135681.git.lorenzo.stoakes@oracle.com>
 <20250917213737.GH1391379@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917213737.GH1391379@nvidia.com>
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: f97899bd-138c-49d6-ab09-08ddf679eeaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2uqRmNQEVxWfMyMKwvDWgi4dIBYdR83TftUXQgJFzNZadgZZvJRCycax0LQv?=
 =?us-ascii?Q?VAPevuawusFYvfwQEQzzvOFPM0HI2U75y4PWjFMSAbctbrpzBq+Ud56rsJhM?=
 =?us-ascii?Q?4SU2DD7WgIgTOa9/1QYAvHFDym8yF8lLrx68xsOOLhsCktKzeqGcW4QvGBF4?=
 =?us-ascii?Q?Tb9869cUBpzslfIdu1c44rX3U2qs0ZIVxrJ1V0U9KvmrND1Xo8+bwcdQYS5y?=
 =?us-ascii?Q?9v/sjWkKs+vQ4rQ5U1ZjtTChLqJsyefcxLkJwC93e1bSnvKF8CyLPBQdf9Ii?=
 =?us-ascii?Q?ovKM0AU6fqcod6wfy4AjGKwvfGiEPNHrfilFNplMQkR7b83vX0V4qGAvc8+C?=
 =?us-ascii?Q?JkjkH0Uv+89ozgY3+pfGq86W3HjnQBxe9kXXLLQpKCo5c/MU4iqHoHy5df5X?=
 =?us-ascii?Q?PlJLWRtMSXLZewcE9GzamrBP1h2N4eQ0dNElBQtUkIkXvQ3k83hJMWb1KkdN?=
 =?us-ascii?Q?4it9HDn8kDIBMKEa9BXUy1gBL8f/LT1e68AwWcocMtkEFjqNh9p0a71ppX8c?=
 =?us-ascii?Q?SZAY1fXwqRZR1AlYWsgwBX2GcBSBIkg2t7Uga/Sl1SF6tGNVCqxXHmRDl8hb?=
 =?us-ascii?Q?Ptr13i6Gh9YhgupFUZ4wg2H+z5UemOAStY+F0xyOIDC1f2ss/ZJ3v5yeNcOj?=
 =?us-ascii?Q?KVgG3+0hh9ipT+sBLyOjsR7RhZqBCpyma07SVNTxcnmxln2YTYlQnXIWeY5H?=
 =?us-ascii?Q?LBXR0cmLlhnZrfgEekN+C5xwYXeVxdd5Nl4e71Kp6IGJ6ajw2VANcTeIaHYZ?=
 =?us-ascii?Q?40p+/Gr0AHcMpzOMBC6IlX87VhP6Iq+Guygbhs+6xbyh4p+DHe2K0R5uYJlv?=
 =?us-ascii?Q?f8ilM/Au2pJN6awgxnBqHKzOqTReLGITRlMyexYoaebBY9jCKvxVjZqVlJln?=
 =?us-ascii?Q?K11UccqxxlMuzSlfS1FqaT9RS1ZtZ800njwb9GfWFeybU23KjLpsGxQrqWL7?=
 =?us-ascii?Q?B99aH1pnd7YeaJWygo0eB+ESFpHeP/g3w6uDJkYeIEvyqWbX7FKQCnrepuwV?=
 =?us-ascii?Q?qD1WXJNcrUc6gEqw2wTGV12PRa3hwIN1kzcGZEnSSBJK3z571HRwiVUPqDCH?=
 =?us-ascii?Q?EeYwoEt7rrUdgWfSPAtcfdJPf8Hw8wUr1IB3xFdaC92s0h4Zp6vEWTt/KxSX?=
 =?us-ascii?Q?OUpETb64apjxvvq+2bKtt53g7Vdh38LEAXm3ivQcSUCrDhtQ/PR9b0EH+XcE?=
 =?us-ascii?Q?gQuSs6uTgq72s3Ap2Kq6ThiA9iRSvCQ99lyhMlUiWOmt9MsSBLmK6YgzcorK?=
 =?us-ascii?Q?qXVeXo1u6SSPYePmXcKtJB9f7UMex+3ZNOZKzwXuFj+BV8NGujMUVPV51uq8?=
 =?us-ascii?Q?rEwOEyKCyAvE77Ni/yTcn8kAnFPVZIAFx0PvhG2BtI5I8w4xSzqhjrjvwIhS?=
 =?us-ascii?Q?xuocqfPNBBS+mEOsoLn1kDZ+pryhgXxqf3wtX9eedtiG+vLDnABTOn6OohJQ?=
 =?us-ascii?Q?0b/49AlpkBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cJhQUVGzBdHb7XoaQVcFpKvjVu7ew4RYdJj/GekRnvuCKhyNW1n9wGOU3VV4?=
 =?us-ascii?Q?AMIJCeXyc3/09435c45g+AiSyt1lhVozE5ZjPWbANl3MJxQp4KJfOK740/Bs?=
 =?us-ascii?Q?oG3An5d4Y+GEI26J/XLmzzYJdTfEZabRiG0/iy7azg9u1N2/mAdYnNF9INaI?=
 =?us-ascii?Q?Yxg0hheOZiCQjeNcCtU7NAYfxiOTE3EZcQbqPlNxMfMzJ4AWE8hOCo/tZpFR?=
 =?us-ascii?Q?s8CUjvfZ4thYTLoMx0CGVLjz8fs9atLgJMPLa1VL/U4vJjSOhzhmuZnbmBjk?=
 =?us-ascii?Q?G2HAb9uEnPxRbtn60UbviHHPHcU3oQQbO34LYdiZbRCWerfJaNp2smrL3gBa?=
 =?us-ascii?Q?nd/vPL74Ef+GIYBt7pSdOBnE44HXmusiXFdYUQTXHkAjfeuWgC7Qmuw0H68S?=
 =?us-ascii?Q?6jp4zXyC4D3EWceRURO84SQRzomPoZCulRoRZhumImepFG8sLUfgRUtMBE+O?=
 =?us-ascii?Q?WyaldhCmbuHWOqfM1af3Z/7nzTogV4mCem7VxVC32TkVSjbUZsTHqAhXsGhy?=
 =?us-ascii?Q?Q4RVxuBB7YFp2a+oVrt53yzknE8E1ubUAiQWTQhZYvd50iqYsrAdA/UYnkaq?=
 =?us-ascii?Q?Ex2EvGTY3G1UcaQ0GXFSdGe6EmBxipPYyM9/HITOBqdZsq5dJED1wOpafiH6?=
 =?us-ascii?Q?YQavLn2uB4GYIAx2qS8nllC251gsc0TAykcn+Od31FpwBe55OZHnlX92uSE7?=
 =?us-ascii?Q?QNMTH7GBZOP30GfqxAr4uVlojce+6yZnVu2REY7LlZYreZaMXQAf2J3sSgO/?=
 =?us-ascii?Q?IzTR99MWo7LgCoTQYP0iVoadSQby/ggs0yc1bc4KOUFoBBFtg2iyNGRTzt5O?=
 =?us-ascii?Q?vxv5gDW9thpzxllc0tsm2M+tHrsSrHIv6Q5sBAxZdHbOe1cenDvmN2qS/1WU?=
 =?us-ascii?Q?wct6KasuICGJq31TZWAVM7FwgHpui4U2YMh0awLnmQ7D0BJ9XqP2Dwg1EzyA?=
 =?us-ascii?Q?Vuv8Foo+yIGd8m8CUoIfOmM776GBacnbBjuBCMggb+5sMQWu92RmP2Y4q+Fc?=
 =?us-ascii?Q?p3cTARIPr4D465+G/U68TlVnAASO2lBH0aBTCCop2gbqoV98ZRhOWA7sHwTu?=
 =?us-ascii?Q?sy2g5zDnjch/eNeBZNfHTYNwy4uJ8NJaVQdt3nJhINqYG8fFrajJBzPipiKI?=
 =?us-ascii?Q?Hl0jnRSWDx5hQO2E2f/4tiUIexn/UCoX5SMq/ceSbGiDLv37DzdXOCk8xUuz?=
 =?us-ascii?Q?VgIfrW6CJUgW0lqL/F1TCUVdHZPHeZH+Nf+x8EF9HRlYS35pNUU+X7v1MMIp?=
 =?us-ascii?Q?FJfy7U7vCewoBYMd+UAKCrvCL/FdCDvxJjo6/kz0M1zZwbem5Te8xGnovepQ?=
 =?us-ascii?Q?8hLaC0B+peTTNHk2+L1cYOJW4la/aQgbjV7Pp5lIm4TbipGO++pdZrmVNHPM?=
 =?us-ascii?Q?kvecN2zAX+/uuBjzyDONqUUvBjDspxHf8AvRP+J4grmCmEUGVqHS8nmF7kW9?=
 =?us-ascii?Q?xDqRwj23hA7pB2CYCfrXIQR/kLW2dhr7/NO4ETIQq6z0oMz7poIHsuemCvBf?=
 =?us-ascii?Q?9LfTitwoB2EgY47zER2+g9gEriUlac7PSaTEPLevyYjtshCtNrW3G+Jj/nKd?=
 =?us-ascii?Q?3KqtPQKe76FK4BUlL37RIfEaPl7OHl8uEtKi78zmS62+NOYGHH+BiZ+jY40y?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vqMwVYUYiOMEnQLXg+N6yiSJQNIhSOzmUicaG/NHZcm0Xkmis6SnFBURIPyMZDLNgmbRhWPXa86/1K0F4repbXlv//RKbJU13JFyXvI3UWbNiOnqU1Biw4/fq/FWEr6l48YtuA046sivTEYmVyfhPpQPSCtmEG7PMQEJAj/ehvBGfTGIrpnGT49B6J5yjAopvWXXVodN/zZiSWKVDNpp12xv0WIUAAqGZTnChcnk/+Utq5wbAcZqmYgU/YJaJe/CVhTPOGec0uyJNvCHLYbAonHAsdCKZVuJtu9SFMy2/nEE9o7SgjLWQUgncgZJt90619TZ7FdOpN2C7ldxlp+bsZQsOf3avKx6YEdERuPO0Puf0aAiS5ormxyaZdf+Z1rVaqWtudqSSYooONXyon1T86O4CRJSrYTkk0Lp/KN5IAZrNIJy+lrOaTNUMcRJpgj7IP9dag3YwEUecfr15g2hfa0gG64+zQnYuUlGZmg5hE2NO5TmMyaF+GELh0SXCZXz+L1kH9X3DPE6Iz2apl596a/f/C00i28KSbqOV32sVNw0/jxqAHGnvH0FcKYT/FX2ClnBgTr1+DqFscWvvoGrRw0Ex5gnotgxl3mSx7NU9c0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97899bd-138c-49d6-ab09-08ddf679eeaf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 06:09:31.4165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akpj89rkII4AtiRu6cO8U5TuCVYeoJoGA/O/0aiagBumemy+Ewp6Tx3dkpuSs9F+wkOJHK98wmRbIjdeN6zCtkD4c81z4qMXATybR8o0FuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180054
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cba21f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=vzm4EJpVXfjcab-RlD0A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: TzFxv-n83vuCHZwf24mSrGmfEvyrC2Qc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0l2cVho+lVPN
 Jh12MKuPP+Qe4Qd3kWfRhgJx3by7ghd2oIecTpt0R/kS+J/sfROCdD/zWgx7v4WewowvWSEEhiC
 a4BqIBeGfLr76Y/baTHUbm0X/i9IbV8NDih/kjIwXdodQZS2lrUgNO5S2DoCePmYPdN51YrqG0f
 xYw4RieJKhcED4ngdO0s/rqt430TeX7puoJ+NCVCzK3CVF0Q64mkFxWdeng2qGv5qSCN41Vz00F
 VmBfDjbbj3KgmESkPNxkokmYhhPX6yRa13sNfYnFLrWNrO+tVKVGCi8w/nQ5CNvMnz/Rft8Np/S
 kxCYXD82vtAKmSNr26VKGsGD0llJUqonmwzTRIudrkFa0MNKseC9Q83p/cyr+6URYOPeAHF4QlJ
 6xPdf6O4PGC7RlymkybAoKYg6VOpCg==
X-Proofpoint-ORIG-GUID: TzFxv-n83vuCHZwf24mSrGmfEvyrC2Qc

On Wed, Sep 17, 2025 at 06:37:37PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 08:11:11PM +0100, Lorenzo Stoakes wrote:
> > +static int mmap_action_finish(struct mmap_action *action,
> > +		const struct vm_area_struct *vma, int err)
> > +{
> > +	/*
> > +	 * If an error occurs, unmap the VMA altogether and return an error. We
> > +	 * only clear the newly allocated VMA, since this function is only
> > +	 * invoked if we do NOT merge, so we only clean up the VMA we created.
> > +	 */
> > +	if (err) {
> > +		const size_t len = vma_pages(vma) << PAGE_SHIFT;
> > +
> > +		do_munmap(current->mm, vma->vm_start, len, NULL);
> > +
> > +		if (action->error_hook) {
> > +			/* We may want to filter the error. */
> > +			err = action->error_hook(err);
> > +
> > +			/* The caller should not clear the error. */
> > +			VM_WARN_ON_ONCE(!err);
> > +		}
> > +		return err;
> > +	}
> > +
> > +	if (action->success_hook)
> > +		return action->success_hook(vma);
>
> I thought you were going to use a single hook function as was
> suggested?
>
> return action->finish_hook(vma, err);

Err, no? I said no to this suggestion from Pedro? I don't like it.

In practice I've found callers need to EITHER do something on success or
filter errors. I think it's more expressive this way.

I also think you make it more likely that a driver will get things wrong if
they intend only to do something on success and you have an 'err'
parameter.

>
> > +int mmap_action_complete(struct mmap_action *action,
> > +			struct vm_area_struct *vma)
> > +{
> > +	switch (action->type) {
> > +	case MMAP_NOTHING:
> > +		break;
> > +	case MMAP_REMAP_PFN:
> > +	case MMAP_IO_REMAP_PFN:
> > +		WARN_ON_ONCE(1); /* nommu cannot handle this. */
>
> This should be:
>
>      if (WARN_ON_ONCE(true))
>          err = -EINVAL
>
> To abort the thing and try to recover.

'Try to recover'... how exactly...

It'd be a serious programmatic kernel bug so I'm not sure going out of our way
to error out here is brilliantly valuable. You might even mask the bug this way,
because the mmap() will just fail instad of nuking the process on fault.

But fine, let me send a fix-patch...

>
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > index 07167446dcf4..22ed38e8714e 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -274,6 +274,49 @@ struct mm_struct {
> >
> >  struct vm_area_struct;
> >
> > +
> > +/* What action should be taken after an .mmap_prepare call is complete? */
> > +enum mmap_action_type {
> > +	MMAP_NOTHING,		/* Mapping is complete, no further action. */
> > +	MMAP_REMAP_PFN,		/* Remap PFN range. */
> > +};
> > +
> > +/*
> > + * Describes an action an mmap_prepare hook can instruct to be taken to complete
> > + * the mapping of a VMA. Specified in vm_area_desc.
> > + */
> > +struct mmap_action {
> > +	union {
> > +		/* Remap range. */
> > +		struct {
> > +			unsigned long start;
> > +			unsigned long start_pfn;
> > +			unsigned long size;
> > +			pgprot_t pgprot;
> > +		} remap;
> > +	};
> > +	enum mmap_action_type type;
> > +
> > +	/*
> > +	 * If specified, this hook is invoked after the selected action has been
> > +	 * successfully completed. Note that the VMA write lock still held.
> > +	 *
> > +	 * The absolute minimum ought to be done here.
> > +	 *
> > +	 * Returns 0 on success, or an error code.
> > +	 */
> > +	int (*success_hook)(const struct vm_area_struct *vma);
> > +
> > +	/*
> > +	 * If specified, this hook is invoked when an error occurred when
> > +	 * attempting the selection action.
> > +	 *
> > +	 * The hook can return an error code in order to filter the error, but
> > +	 * it is not valid to clear the error here.
> > +	 */
> > +	int (*error_hook)(int err);
> > +};
>
> I didn't try to understand what vma_internal.h is for, but should this
> block be an exact copy of the normal one? ie MMAP_IO_REMAP_PFN is missing?

Right. Of course. I'll include that in the fix-patch...

>
> Jason

