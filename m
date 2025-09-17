Return-Path: <linux-fsdevel+bounces-61999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F84B8188C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88EA5162208
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AD1343442;
	Wed, 17 Sep 2025 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kCcYTHtz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JvHqzdL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D13408FD;
	Wed, 17 Sep 2025 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136357; cv=fail; b=ZdzfcxMQJWOGDWhptmMWV23+nBYdU0G3HOaqc3UOLMCGztw37/bJCyqUMyjKNZh+lwYEcupEIyvTQvjhHU4BU6tz/ibsGgdQtCzReV0anJq1Oinkk7pTSmkiqA22RpqgDAoh7KT1a9TMBPxaVGW9/l0VRL8WQaQbLFE2Krxm4lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136357; c=relaxed/simple;
	bh=RTVIDb12E3RTOAqXRHZq3nHnQnwjbAZl5pRrBSfBwno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iDHGRmatzU4Yvph0rgBIBJ9B5BBWKkI+cMj5qqcx9H3LZJjO5f17HggRgG68N57JG+OX4Da79jbzk1QK9df8fD5YXqlVMDlJhZyPA4a01/jIrnVoKXbb4F5kYqF8nZIplJss8DmB98prqgjPmBVorEKaP+2xiGkWXipeCclVaiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kCcYTHtz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JvHqzdL5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIVQG007508;
	Wed, 17 Sep 2025 19:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/35NbNXafzTqTCTdBBLOYGZizsI56qn6v89SyRTgQfA=; b=
	kCcYTHtzO4gwTRN0tFld28zEsE3ZWMxFMrtlcwMhczF2uyolyrK4GisfENQHG5Lb
	/G6v04t+yrAJ2+kPeXeqYqidv7jGF2MUKiY8SdgDLARHrj3vp9KIni7okMpQotcB
	+0zdQ8FGvaXyhYKfyBBV4RZYAnMRAqRVbh2P99EpoHCv4y6F5fOhlAIQWi6JZ0R/
	kUiRtL0Dd9vQci2RvgaYPXNYzdrSakk7b0zPWH+cKWJqOj3RtfHNXmKrCRESDvec
	L3Dy2h0wC4JZBdDYHufOeHQpmIFmYWdOurdRTEl7iL5lWjt/1smfqLMwoFkj0m40
	gVtWtlFlUHEqASqkIjrvAw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9200q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHEIej033687;
	Wed, 17 Sep 2025 19:11:50 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2e5fqw-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxtjVQBEkOg1dcgcstBTC5eOYS/wQ8xulH/VWu5CRujSOKaksKfnAxty2pOD76i82/DlrdcDn+kprpJBfiotIhhSZ+5R+9CiOuoYgDzGReEuhsWHWxIQSC173AgXhPKAodljtU7Z5YjcuOTB/UrTPmSLZ+m3H8ANHibdg2SekizvRbEptrZl9D3fAzuRyiWusEdM7+MqlP36zynV82ZPSWIjdZtPpSraH8nhduvtBs3p5Me5L81Hj2goCZA1pxFoPTUc5BrQInt3hnm09V7E0fyPokCOOB3KDPhsV3rXkmQvZlJPeQqfVAt8P+90mWWvtQbvKLwIWhnajfmkn8eUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/35NbNXafzTqTCTdBBLOYGZizsI56qn6v89SyRTgQfA=;
 b=HCp8+O3Q70Ej/15ZV88jEmzJiXEg82V8G8rXPLN6BH1lQMTTX+q1RZuGRnmrCFHKYoW/sBzWqT/dRIUceWxEoZIpJ9GOq/K7G6T8q06nfrvflqgAKSqjKAOiOKI8KTM4tf99OUe8wV+adv5fBzLB3SaejGxFR6SgTZ0YO8BNE+bXc29K5FeASHeDOX9LS5qWr1rR/gmBCK689WxHpi7LMvv1PUeJWnW3oKATf/sJ5y8dl0kuIMxG48iSC5IcrLwlgzwCT+sIIAO2QLFntGjsiSUXPGqyQMMSjndFyQC2echXFHjoRsI5c25Hc9mfzI5/hEawY8gX0/2wWuCY55EhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/35NbNXafzTqTCTdBBLOYGZizsI56qn6v89SyRTgQfA=;
 b=JvHqzdL5A3S7I1YBfYr1tfalrRom4QoS55b/IrsRKxpbN1NZbI0C/cn65OuREFbvlUxOtdU3p63Rz/G/i7nnVaEfXHrIkfoThnF77X9CPTxGJZh/oVOXxHQev7Cr5Pkqx7xPlezHhB3IwmgcFlq2MM7JAjcOKtgMt/XyGVfVSV4=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 19:11:45 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:11:45 +0000
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
Subject: [PATCH v4 13/14] mm: update mem char driver to use mmap_prepare
Date: Wed, 17 Sep 2025 20:11:15 +0100
Message-ID: <14cdf181c4145a298a2249946b753276bdc11167.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0223.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::12) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 898774d7-01ca-4c65-bdd2-08ddf61e0b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jiE/8mTFDw97FOeKykZHQkdxon4tiKGUJzgcCLYW1++Jeckuk/pwEZVf7Rst?=
 =?us-ascii?Q?pIZCQ/duRhAMRsDucDK/br1GQgAZeTB6wnYiggAhzf0bKsyqjjs3CyPg2SrC?=
 =?us-ascii?Q?jRFgHgy92oumkE5hCpSD+/hiGp4pVE+vluYLr4TXyi9rD78ZdR284XUy/CtJ?=
 =?us-ascii?Q?EhPp1cJwo+dFJMT/XqOkeK0YTfKSh6CZkTAHE2ngHcZnY8980YnJ51vEJSvW?=
 =?us-ascii?Q?uxoDO/LHFh8BPBJtUgZcBE6xm5+Vs4gOh03WX9iUs1KhXnbYmUtByhtlCyn5?=
 =?us-ascii?Q?vNu1EfXiI2LQv+COyRuLmSYPwQB1y+p6XXvAqaaNQ9E0NjXdq/Q1Dy1OBzvD?=
 =?us-ascii?Q?W22aWrQg8xjCrpcXE7TpNsRdUEXvdbWluXM989uJYjkeUHFuAQMEfBfdksoG?=
 =?us-ascii?Q?0kbIyVV7jQSbWCPpxbkg9t0LFponwlewBKHB7i7Fq1JJVugn5Gg5zO8PBXyO?=
 =?us-ascii?Q?6e6RVRQmkSeDQiUufQQ5D1FPrxPP3qIIFoXnmc/j7Uu4/A/wrlsDs8tgFR0J?=
 =?us-ascii?Q?QTktVZYWom+tQFJ6zpjevLm+SMAKWo/ftyAxC8guRvrnbQWLth7eX9v5BLjP?=
 =?us-ascii?Q?AbWmXUwDCheVFOvwmEd61V6Nz1LRk9ZxVnvZ4+EWuIUdH/A/5+10C/sFsvvn?=
 =?us-ascii?Q?LjP8nsYiMAxFF+OoHhP5nSvRNGymVVPW6qDNB3JIW/lNiTSG/2sQNK0VsJHQ?=
 =?us-ascii?Q?HEbb39V+hjzwvls7162Cw2PwGwAr6VUp8qKaMj5l7psqGNTtjAX3NfQbltF9?=
 =?us-ascii?Q?QAyHimilPCx4rArlMiOCrc6psH2Hg9q/jf9KpGMEXxZt3/gtE8WhjYXt0/cw?=
 =?us-ascii?Q?tnGHQ5pzsZ/M0lXQ/YpKUuoYGWIOVdNJZ06nFI2Pjvbn0MI0EN5QazF7VxhX?=
 =?us-ascii?Q?jtv+OaRGEfB0aVjYJqyV/7AXPmJbP2rDF2OphPoLyJcu3qKM80maM7ZKv2ik?=
 =?us-ascii?Q?6sprstF2yFiwG4APF6GXOxWCOfucuN2cweWPjuAVRG8GG9NKHfYH7CbREXWD?=
 =?us-ascii?Q?RPYFgeEde53cHD/yqJEwwDcjwF/8hXYVBBEzYspbQiRjXxFUczZUFkPY0cLI?=
 =?us-ascii?Q?BEUP9p/pj/XQ65nlOW4EVSZGk+Jzw9twsuezwsZ7coq8rEux2PVrEw6ytE4e?=
 =?us-ascii?Q?vNzibrBSyKWKcyA6Nm15gNsbLVB/ABn41tsQPPAG/e42Z037eTfqMVWd/FoO?=
 =?us-ascii?Q?sBv5CcBgmaFyI6K9bdcVYVWWevNUmDKLO5lYCpS+GeLCTLDCe6doI/Lw5Ut5?=
 =?us-ascii?Q?iTuM+xbfgkTpma/I2Reqmn1KMyGzP1jnqmU6MJXXr6tUramIgWvQnqhwzPyk?=
 =?us-ascii?Q?1sblfhDrfX/CK2NCBmum3fL8lRyb8+92FdzHaAj1YaXfOr65D/EZzyBC+Wg1?=
 =?us-ascii?Q?3BJuQanFTvh3+U27ZVDODJqk5ZUw7Y/GK7Qcx1n92HbcNBdyHRbr9gufcIUq?=
 =?us-ascii?Q?Bakdlbpnr1M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b9eE+ydtitg5DD87b06XfKgNhSuJq2qeUs6Yi2OiZTovGExFvdpJ53AqMPQv?=
 =?us-ascii?Q?KA2hJy8U8I29EN6jgsCrMLqHJ6yu5jQrXmD964chhBoIs55OY+THNC7R5boA?=
 =?us-ascii?Q?hoqI1AeR1kH0cF/EznimrWKB3bdmVb5YEVFbluzPVoPVY36N+TtQ2Tdd7FTx?=
 =?us-ascii?Q?NVs1A+ybhJtW2Ij5yX5+1EnupRiN49tB54p5A3jV2rFgidMqx8gEqKEfoKYx?=
 =?us-ascii?Q?CtbGOhlWC7f2f0qGMsdY+qkB1Gp1CY55By/i9wMiHQUdxraAXsmhbW+U501V?=
 =?us-ascii?Q?gBl68aMWgmLqVCuypn+tr8Wo3A2LD5SP1Y0T73k+JoiWXx8OKGBYHZSjeWw2?=
 =?us-ascii?Q?PUZ7HNnD01k9Fwa+dM/nm60fIcsTFzmRyFBaUpw6+Gf53/qeo0swo2fy+6Pi?=
 =?us-ascii?Q?MyNGsa4kJjibpodXp/ajAZGPWmroZ93YYyYdqoo9qUBSSWtyIgTxmuyy8AYi?=
 =?us-ascii?Q?DZSwwM0Y+2r3HN+02y3fYZ7rTnP3Nl71CeSivydewU+dSgZkq8fbMQR39E41?=
 =?us-ascii?Q?DfgongAK073C6YGJx3hCRAMPvKwI071NnPeVDqFZHH2xT0fguG1jXAJkR1Ay?=
 =?us-ascii?Q?C807iQGZVwcnOXn2ZPWqz36ckJbPUv4VyXetWa0fCsAL60HVQMl+NT30EH+O?=
 =?us-ascii?Q?hVoNPVoVwH3TOlHi2ol0R5FqdiYBZrFzbWK+F61mox31nAVBWH5hbxvj9Gro?=
 =?us-ascii?Q?z1cNdiOGsnjSvRGYdDjoER7zS5/vyzq4QhiFRCHTxuiG8z04A5vczijLhgML?=
 =?us-ascii?Q?7ifp61w5F1hEiQqPJ+EMOQ568tylxeJtoPwSrMAuHCHXi5CRgN3g014gPoXH?=
 =?us-ascii?Q?A6WlRUh+jPMKyNT3cKfLRCJXAUnbtTzpnVqNmA/nXKfzDfqFjo9eAF7+t7SU?=
 =?us-ascii?Q?lLlrqQaTD+8YbvWbbFECRHvzeBTHXBclG9j3Qd2n52DeR97UsNw2ni8SyH7f?=
 =?us-ascii?Q?UzQZyzaLoGsQD9BeGNp1jliLvFbiMfNfepsZxYq0Y2/KbQQ3fneJ8AbNS4aS?=
 =?us-ascii?Q?i5fH4qc2n8HqIKjsTi4oPUuHecENWdioGeBunZTsq7KmiDxTuyCv9Ab3GJgV?=
 =?us-ascii?Q?cOPYckhfIB5jDUjXMLCUimog1hNpOkVB+hCTj9pPDRt8+yXPlKIhJFm1Yen1?=
 =?us-ascii?Q?pWkkNVAglUVrYHkknwdWA6kI4LLBiCx1Fm63rPUX1bE1k3cjO8GoqV1XKHTZ?=
 =?us-ascii?Q?Is0OQO2MIeU24VhBmIoveiKXzn+qszduO/tPdiGoe5kpCdQDzbejevez0Kw8?=
 =?us-ascii?Q?8nvIMyr14vlQwyuIcRsFHHwSabgjbRzVqk3TsIvLb/YxN3lyPUCZ6lludTSz?=
 =?us-ascii?Q?+rYy/a789n9Gr0aJGVLmb72vdGuVgZNVoMVaW1/y4/Rc6bH3f4gngQyidAxf?=
 =?us-ascii?Q?EpLo3i2Dd4lfsPnJLzba8pDWRsdNAoClNLWWCr7LTvLyYVZafqV/UtkdhigQ?=
 =?us-ascii?Q?pPfTN68wWaw6ZydMeA8x+AoXWWuARXZSpPp/m6ZR7VDDKWz48UXMBwaT9R2l?=
 =?us-ascii?Q?09abQOgEZix8rQsGKfvz+WWAMLv62iSmsky+bCm3xBPmFjwqqmUz4DoDs+WU?=
 =?us-ascii?Q?pCAvvVHFtP8Mb72SPIKz2UhlFsvr5MKmz/DYXwoVpcrHN4mpFOtykk4oHvt8?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	13cp3WG1reE0QSHzg3kDDvdulAH3xaIR29ip9De/pwyOFcmohYgMuj0Q6FLufo/b4FJJNo1YrNRX+eMN1uduv16RPp2gEymDNBTlVtfaoiUXLF1QvGdZ5wbsAUjmdAUBeLmG4A0Mv5F5j0wM7PXQSWBdmFiufiu1sC95e6cepEqOftZYayIEKnzj3mPPw3M2WZ1bhZZe6nYSZg1clBuo+i4Idz3INh/OoVmhLC63c9brCQ5GvwALfFxDWyzl8bw7aBELKaoQE3p0qWS7NPT/0O8NlWZ/Il9Y708BGHPatzHoRZfS6dbLHhQHSdzI1ay78yw3RED6jVXRJWdRLeeXkRm8IoWurHsUpONDke91JhevRSjh0kJ8V+d3MQMGQE7MHAKXy0M6PXO+U8fU5V67gxUSIBnCqEZqWq4DD7jLKduYQY3Ta5UePl17Ex6/UNjkwF3DtvP0KrGN6EBzg7NRRr/owtPi0pC7QzOu72qtjxh9lcqw5nY+gS0ZiX1LD8KemVH1AHTgesl652XaBjPIKhzYl3djpeVR2qhqSEJ/EKajgGbNDRXGfCrwDhz4p6jTzwRFUs1lnP40K04BWjwt76BTbJem+YpWB6jnfpczqiM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898774d7-01ca-4c65-bdd2-08ddf61e0b0e
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:11:45.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JAtkvv7bKRfCr47OLX50OxEsWr1zakpwE1IY6ooiLlSohzhZkyNFFLLl6MPLCxoGz/ibW0IpaRMMMo1r7mOunlYD3zz6sCe74DVGz+Mjk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170187
X-Proofpoint-ORIG-GUID: ntpcZGVnzBXfK1yRjO3xkGmtgtEPMBTp
X-Proofpoint-GUID: ntpcZGVnzBXfK1yRjO3xkGmtgtEPMBTp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXz87W9LQidiD9
 BE8MB6srEEwBVtt5T5y3t1x6xRuhwHWznGweRBO0Dyj/IWqgJbj1glO7JWnPjzYyWChH57PK4jT
 658lcer3yhlc51STho3DyM7UwUKnFKLz3ZAUmXiyIis3K02jrsPauSqIJlgsNPkIOE1BnyWPSwr
 FmaZjW7rARuiCILUZQOrIz+9sq9CkfBsCNo0cel4QP7ZLmOpxSYAYXedgT5D5JO/LB3VtE8Ne90
 Btuf2L8En5uUXGPhntvx0vzFNXTwouuVM+xeylU6EAObm9S5UG133ghVtmHASEbbtg8vVs4t4x2
 1bM4xTc6IrzNO81WxnSXAfhvwFqmzzfePVB0PJGxwBHCDYIRVYqnZDP5DaO7+frplCBJ6iRqreu
 NDj6hrqv
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cb07f7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=x0R6ikhiTiIxgpotQrQA:9

Update the mem char driver (backing /dev/mem and /dev/zero) to use
f_op->mmap_prepare hook rather than the deprecated f_op->mmap.

The /dev/zero implementation has a very unique and rather concerning
characteristic in that it converts MAP_PRIVATE mmap() mappings anonymous
when they are, in fact, not.

The new f_op->mmap_prepare() can support this, but rather than introducing
a helper function to perform this hack (and risk introducing other users),
utilise the success hook to do so.

We utilise the newly introduced shmem_zero_setup_desc() to allow for the
shared mapping case via an f_op->mmap_prepare() hook.

We also use the desc->action_error_hook to filter the remap error to
-EAGAIN to keep behaviour consistent.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/char/mem.c | 84 +++++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 34b815901b20..b67feb74b5da 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -304,13 +304,13 @@ static unsigned zero_mmap_capabilities(struct file *file)
 }
 
 /* can't do an in-place private mapping if there's no MMU */
-static inline int private_mapping_ok(struct vm_area_struct *vma)
+static inline int private_mapping_ok(struct vm_area_desc *desc)
 {
-	return is_nommu_shared_mapping(vma->vm_flags);
+	return is_nommu_shared_mapping(desc->vm_flags);
 }
 #else
 
-static inline int private_mapping_ok(struct vm_area_struct *vma)
+static inline int private_mapping_ok(struct vm_area_desc *desc)
 {
 	return 1;
 }
@@ -322,46 +322,49 @@ static const struct vm_operations_struct mmap_mem_ops = {
 #endif
 };
 
-static int mmap_mem(struct file *file, struct vm_area_struct *vma)
+static int mmap_filter_error(int err)
 {
-	size_t size = vma->vm_end - vma->vm_start;
-	phys_addr_t offset = (phys_addr_t)vma->vm_pgoff << PAGE_SHIFT;
+	return -EAGAIN;
+}
+
+static int mmap_mem_prepare(struct vm_area_desc *desc)
+{
+	struct file *file = desc->file;
+	const size_t size = vma_desc_size(desc);
+	const phys_addr_t offset = (phys_addr_t)desc->pgoff << PAGE_SHIFT;
 
 	/* Does it even fit in phys_addr_t? */
-	if (offset >> PAGE_SHIFT != vma->vm_pgoff)
+	if (offset >> PAGE_SHIFT != desc->pgoff)
 		return -EINVAL;
 
 	/* It's illegal to wrap around the end of the physical address space. */
 	if (offset + (phys_addr_t)size - 1 < offset)
 		return -EINVAL;
 
-	if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size))
+	if (!valid_mmap_phys_addr_range(desc->pgoff, size))
 		return -EINVAL;
 
-	if (!private_mapping_ok(vma))
+	if (!private_mapping_ok(desc))
 		return -ENOSYS;
 
-	if (!range_is_allowed(vma->vm_pgoff, size))
+	if (!range_is_allowed(desc->pgoff, size))
 		return -EPERM;
 
-	if (!phys_mem_access_prot_allowed(file, vma->vm_pgoff, size,
-						&vma->vm_page_prot))
+	if (!phys_mem_access_prot_allowed(file, desc->pgoff, size,
+					  &desc->page_prot))
 		return -EINVAL;
 
-	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
-						 size,
-						 vma->vm_page_prot);
+	desc->page_prot = phys_mem_access_prot(file, desc->pgoff,
+					       size,
+					       desc->page_prot);
 
-	vma->vm_ops = &mmap_mem_ops;
+	desc->vm_ops = &mmap_mem_ops;
+
+	/* Remap-pfn-range will mark the range VM_IO. */
+	mmap_action_remap_full(desc, desc->pgoff);
+	/* We filter remap errors to -EAGAIN. */
+	desc->action.error_hook = mmap_filter_error;
 
-	/* Remap-pfn-range will mark the range VM_IO */
-	if (remap_pfn_range(vma,
-			    vma->vm_start,
-			    vma->vm_pgoff,
-			    size,
-			    vma->vm_page_prot)) {
-		return -EAGAIN;
-	}
 	return 0;
 }
 
@@ -501,14 +504,26 @@ static ssize_t read_zero(struct file *file, char __user *buf,
 	return cleared;
 }
 
-static int mmap_zero(struct file *file, struct vm_area_struct *vma)
+static int mmap_zero_private_success(const struct vm_area_struct *vma)
+{
+	/*
+	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
+	 * of /dev/zero anonymous, despite it not being.
+	 */
+	vma_set_anonymous((struct vm_area_struct *)vma);
+
+	return 0;
+}
+
+static int mmap_zero_prepare(struct vm_area_desc *desc)
 {
 #ifndef CONFIG_MMU
 	return -ENOSYS;
 #endif
-	if (vma->vm_flags & VM_SHARED)
-		return shmem_zero_setup(vma);
-	vma_set_anonymous(vma);
+	if (desc->vm_flags & VM_SHARED)
+		return shmem_zero_setup_desc(desc);
+
+	desc->action.success_hook = mmap_zero_private_success;
 	return 0;
 }
 
@@ -526,10 +541,11 @@ static unsigned long get_unmapped_area_zero(struct file *file,
 {
 	if (flags & MAP_SHARED) {
 		/*
-		 * mmap_zero() will call shmem_zero_setup() to create a file,
-		 * so use shmem's get_unmapped_area in case it can be huge;
-		 * and pass NULL for file as in mmap.c's get_unmapped_area(),
-		 * so as not to confuse shmem with our handle on "/dev/zero".
+		 * mmap_zero_prepare() will call shmem_zero_setup() to create a
+		 * file, so use shmem's get_unmapped_area in case it can be
+		 * huge; and pass NULL for file as in mmap.c's
+		 * get_unmapped_area(), so as not to confuse shmem with our
+		 * handle on "/dev/zero".
 		 */
 		return shmem_get_unmapped_area(NULL, addr, len, pgoff, flags);
 	}
@@ -632,7 +648,7 @@ static const struct file_operations __maybe_unused mem_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_mem,
 	.write		= write_mem,
-	.mmap		= mmap_mem,
+	.mmap_prepare	= mmap_mem_prepare,
 	.open		= open_mem,
 #ifndef CONFIG_MMU
 	.get_unmapped_area = get_unmapped_area_mem,
@@ -668,7 +684,7 @@ static const struct file_operations zero_fops = {
 	.write_iter	= write_iter_zero,
 	.splice_read	= copy_splice_read,
 	.splice_write	= splice_write_zero,
-	.mmap		= mmap_zero,
+	.mmap_prepare	= mmap_zero_prepare,
 	.get_unmapped_area = get_unmapped_area_zero,
 #ifndef CONFIG_MMU
 	.mmap_capabilities = zero_mmap_capabilities,
-- 
2.51.0


