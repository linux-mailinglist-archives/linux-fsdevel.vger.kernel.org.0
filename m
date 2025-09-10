Return-Path: <linux-fsdevel+bounces-60852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F25B52244
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F791C8666F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA96932142F;
	Wed, 10 Sep 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ObIV4SC4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YK1wF6ke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7026C2F6196;
	Wed, 10 Sep 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535864; cv=fail; b=Dng1QKS3a+xbDMqb4cRB16dvb1mUB/KERTlwNPpXomT4XzQTpuMITCx9RIBqM5455yTLEXu3C4paGkpmkKvBgtHodNyoovYfRyDZ2b9fYiywoC89Nc2rvgZlyuopADwTSX9a2l49vtnyN/K8Rf6KZNba/Mykn+gi+/9WK5PSc0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535864; c=relaxed/simple;
	bh=9tnuSNbWqL4u3OhLXhyney3VthVRXizDzb9hdcWC+6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UT5kneiOjqGodUUjZNmHlxB5ntf/a2Z7e9WPKxGJyBsf0+XA0fMIb3RjsE4527cK5B+4f/yQLQ7/ef6oWw2owO66iwDdicSwnw47hn1RGjQTy3m01Gom21W2dXhz/jlCAf7R0mnxPCpkNiGZonyUzjOqoqepNJr1kCcrfm+Z4eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ObIV4SC4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YK1wF6ke; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfigc005172;
	Wed, 10 Sep 2025 20:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RSLOn2j28R9kM5FsmlPMWXz46guFdqwiFtj1MWQEEAI=; b=
	ObIV4SC4+g/ItWShZSjOq3YF9LPmlxugAbIzQNN+mmM/tY1coUristVRY5Ryv9YB
	MoKNpluYMCENTmbU0laVpcNhf22X5n8Vd8U8LqC0DiQUd++7Jep53leZ67sYrDvq
	rb8QHvfTqYg39h60qgr6tbVF6IzerNXifN1oqTlnaedpKyHAp8xZyvZBr4PZ3dS6
	WrT3HlW48E7SyVznc/Za60tOOvSxsd7VpJYQ0x+73jh20t3CpfWtECnnkcdEBFNl
	jFcQ6pBDQbgnRsT13ts61+P5J4fgbvOxVdD1Yq0d6WmIs0+y+HbSSp1B6nRQ758S
	WWkuaDkezsdgYLzg6Twjyw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226sw002-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:23:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AJfi4L002816;
	Wed, 10 Sep 2025 20:23:25 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdj1cg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:23:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKJ3wjJIVkFVp9hxj4ZimMp0eiXlM+KNAtb7xMQxOMV9uqWgQBWitXMGcEobcPM/x3GE1nyTI5rWHifFNrWrnotU24Zny6qr/x9x1M9WWkbcUUfLHD44uRQP2ptM/sDUu54pZDgVIBoe1rVJ9GAHyINWs5b15gRAsyOktw+E1qpdw5V1tUARDbfzm3mKNR/dUHXYgTXysQzGfj2k3NZNKXvngpvZKw4mpKnYxbdUEzx7pEVNJPomrQ6+BNb2ZUMaAqLlsAmcRyRRZpUUtHpyVFRfT0Wl1fEbKe5SzbRaztTzhEILYKW6odjuK9pn7NxXgQrYnzXcv4BJeyxNGYyP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSLOn2j28R9kM5FsmlPMWXz46guFdqwiFtj1MWQEEAI=;
 b=XWeQOGeIvq2KkZ6rbt7EiDtOamGXyo39ennV95ZS8p7roFByQDXEuW3kxm1l7i0p4sv9fTqEK7KJbJM7cXA97lCAdW5a2w+nPsqrLny7OxXX3nfSMlmbx05XkN3yr71ERjOlnlDaHw/L3IVJIitfZzpB+pH2e1S0DbVt4SRmNMgfN6sVWSjb0NZ6hs3vuS3biOuHcVZrlvPq5gGfXXOs//3jNUl/J+VXZixTyW3BFnXJmzdCbxpDdgfBGQjoluyoyRDgSs+KaWZFG/O26tjIzhsIWqeUZ1eCrHXpZDAqpT0rNf1rJEJBOlXTa+ip4vTyq2axsGr2ro9JdVdT7pcLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSLOn2j28R9kM5FsmlPMWXz46guFdqwiFtj1MWQEEAI=;
 b=YK1wF6kef5qDbXKClxlX1LtdMsoOfF2zfchMEZcf3Gx2YRsMC5R38WIhDZ8zoPWEwTOQeTg21o5vA8G9dn1CqcN+BYHqtAgNrhGi98kXasyWLN66m5uwzEDLvbj2lpyILXYjsDa7fr2phHL5L4Q4/eVV/K8lqeOBZlM01i+bGEQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6278.namprd10.prod.outlook.com (2603:10b6:8:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 20:22:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:22:53 +0000
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
Subject: [PATCH v2 09/16] doc: update porting, vfs documentation for mmap_prepare actions
Date: Wed, 10 Sep 2025 21:22:04 +0100
Message-ID: <e50e91a6f6173f81addb838c5049bed2833f7b0d.1757534913.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 729f4b94-2b2a-4878-72e0-08ddf0a7d24a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JUrPMECNB6p1lUEk12FxjwDWp/mdx1gtVjU1qKq2AgHKwge/6FkrGxi1ZWoH?=
 =?us-ascii?Q?5y8kzQFp+di3hO6t4hi+1TaD+pGg9T2sr+TEK8CtfE/tq/ipJQU/JkyVppdg?=
 =?us-ascii?Q?U2xnX5IlutTOkJvUoEhy2m1fCMfb36sUKmmgVCn/Mb2exNrV2yRgx1ZiLd4o?=
 =?us-ascii?Q?4kU4KrMPmLj93Xnw+BniHKK8vqAvvsvR1WtCOaq466HaX9/Bo2TtdHJb6IKq?=
 =?us-ascii?Q?WjdH+6fVX+zQTc8TULo2jELyjXPcRCND4RRr7XnAQAph2IRfZKD0Z6j7xsMp?=
 =?us-ascii?Q?b/Syd5i5Z/gXU59YVsI/mKE9Xxx/QKVsozYvYkiOdmOGkZD8icoJXrcDbeUo?=
 =?us-ascii?Q?ZN0uAHpmk4GTjB8vwNTyMZ9ekNtXHbVM55CD72NKZBboMn6Gqxe2PZqGkCtk?=
 =?us-ascii?Q?RTHp6tBGyDqK/RAGptwzm2TPpzoLAjrCht21mMlYjFe66GQ798V5meX5tcV7?=
 =?us-ascii?Q?Y2zWF9RFXnEei76HgGRrUkslnIhlBxzoJW9axCDWn2ufvmCRa0yGPLWbbeZl?=
 =?us-ascii?Q?Cg39CkljUPefb7bPPbkSjOJuAKqdZ94Mn9JSkJY52LkmE0C3z0A6Q2ZEoF0G?=
 =?us-ascii?Q?lV48PiKJO8WDM6UMJ7k7oahIlsKp7quI30oTxxoh4Ie1Qv6h9zyWDPkwvKz6?=
 =?us-ascii?Q?gspBhU4zhFM2OeM6aZN22PHbsTGcNupSyIhaxfNK/feAi3Zc/RCOW8cTontz?=
 =?us-ascii?Q?h3sV7P7UUpNPKVQ3CEPVCmOlj0opClHXQCDM2h0LdEZnL5GUlJgAZbfTB6kv?=
 =?us-ascii?Q?E2pyFO8TVO+DX0fPBhSIUgwnymvJ4bbhAmhUwzM81QL/R55CiMchoJRCnOM2?=
 =?us-ascii?Q?jKk4t2QCUj8YM6xNb4dCHqb9HKQFxskN4GQvZDEnEWBKxyC7A51cLoxVxKNo?=
 =?us-ascii?Q?DwhjZDUr0VvRMdQ1VBzwnesT1tKmd7ZjrGvLlQz2Cg3vvwDflgalnGCjIY7A?=
 =?us-ascii?Q?NGbO0Ex1vHaZ8EB+/NCQ7qGIESOwfdvBfctv4t1oWeNaHCbdO1X8W0GnhepY?=
 =?us-ascii?Q?meq0HxtY8QcgK+bN8CUDL7CDIvvfrQc7gVOZQoGMVtL+G6ReWe3cc7lpk/sT?=
 =?us-ascii?Q?tLmSU8TnKtA3B/2GDqZvK24/MVDKhlRKwgNIpSDv+QnDhms+rvDD0P5CC3SC?=
 =?us-ascii?Q?8LEJsaRnIWKrIz4CNHC29ePUJe4V9Jy9iJdHrrgMHR0f7OcCczm4F744E2yR?=
 =?us-ascii?Q?pitgBgGJl7P2D6fIBUgzkOJqHG8t2JXUcf0s42mi0o5cGHAWUx09rURmdOQ7?=
 =?us-ascii?Q?renEixs09LV4AaovY3Y0sJemQlc8Gw4pTf1dp7eSm2MxGxnV78lOkjuwfNn1?=
 =?us-ascii?Q?JKWLxWThDFMLbOoDdW3xD2N3Oq/V1vhhhWLM+UH1t/HmmMP23N6253Rd5Uj8?=
 =?us-ascii?Q?61IjEZbrHSn+k8mEIrMfcR+53e5X8Ht/4OkRGRK31DbcICTxO/GJM/RFzPqL?=
 =?us-ascii?Q?4BzH1i/sBds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?euU+P+auMFHXUlcOFmQiansK+q6gF6XpgEpxVlU+NScTJ4niF9ygK11oANTR?=
 =?us-ascii?Q?mAocld++W8Porc22OPvhl0mD8meU2y8QWiNYrTnn4eSx0DTHETDkf1uvMwy9?=
 =?us-ascii?Q?IjY6lnuEns14Oj1IsprEE1fYXTTDasxfWG8/M4mfP8UOSepI+9EkO6lY1j/P?=
 =?us-ascii?Q?goDnnQAcuf6ooAuXE9W1u8R0vbko1Vrugaw2gGZBYDOvHGhpJ5Wke2cGjQwX?=
 =?us-ascii?Q?K2guExt29XCZnJqEE/z5rzsJW0Ap3GISHTUSMA5yZlX3+A5UxZQ2B/pYtHE2?=
 =?us-ascii?Q?R/nOdcbp6C45sybCLGBeeQlx6iguVNvCUoOQOk/HtVu9i6IpE2B1PqeoZ8vA?=
 =?us-ascii?Q?u/Xqf2jffO2ece2dN4Q82IClQ5zSPSfh+LBSEljZarQXk+6buPgrd8DhIiWE?=
 =?us-ascii?Q?loHDA0wLEhaj3JEqZbBjIrprkmC0lwAW8/73S0PekPdVSH05m2BDKfKwefjw?=
 =?us-ascii?Q?P0Sc9gieZ75xr3G9PGsktfzEn6xvlyhuEFueb91RnlQfFhchbCtSS+RFInYY?=
 =?us-ascii?Q?Dt/1/RZQUWFt2/x2sHlxSKoLh6S0hSvLGT31S6B9e1I4dAzjPSEaT4MWmGex?=
 =?us-ascii?Q?MSudFlfHfmmxgZtZ85unhKxJ2L7zW8RYaXsZlAITIVBcd8RkS3rHLhM6usDV?=
 =?us-ascii?Q?kSQHUzNlFKJPjrZ6BTU0HOuMXrse1e95afuPqlFTm0Hhw74T1Xkhl/xhyL9h?=
 =?us-ascii?Q?mE/z+vcbAIJQxzmhKzmiYPg0Bp7pti7vA5VaRPQpB1Hdzt4jHh4vhLSiMeAL?=
 =?us-ascii?Q?ZaMlPj/F18DolaYhLdWOtzLZmVoO80uEXORXOvzzti+OE5UWHMn3U96PPax7?=
 =?us-ascii?Q?BKS9wNtAlDkGMZ8mee+mBqKIO8kM+oB96NchS2PT5iAwbUsK1Ztmhyo4KSs/?=
 =?us-ascii?Q?PFAyklBkcSL4s/Uo0PrdJSnBPrq8voP0MvXmvYwP4HfNY0YyDvZzLJdKuisd?=
 =?us-ascii?Q?RvKdTeSczSL1I4XfuQ0bnvNZLEBuCXXggrDoL6YlINEGoeQXVuBc2VzWMx7D?=
 =?us-ascii?Q?UPUT7dxh98j0+9t4vrYdwsFMwiIAgyhP2X298HGnqG7NqbA6pxeXzZpus7/9?=
 =?us-ascii?Q?U6WLAWMA1cRWUnhEfSrfWUBl17mTtGHjxYXn9dxaZ1OQJg0aH3m7QgECfpIS?=
 =?us-ascii?Q?jFQcOY18yxJRX+eKCZOLD2voaZg8YBZUo6UyyFvEZ3AE1eImNvHZoLOuUbXP?=
 =?us-ascii?Q?SmZ6UEJrhidS7k+V1pfENARDSSw+UVHlXPdst05OfKSk75F+B+Bj33A4IBER?=
 =?us-ascii?Q?7NHyMSiTfNzln4ZCZLAyPDhUbrpM9NzJctFcxNowU9ItaGirnqhNzZUSevm8?=
 =?us-ascii?Q?BaTG/X/85dQThcs5PnH/fBPMLcwlPiiOmzC/QS34WtSKtZY2YwVWVlpdBET1?=
 =?us-ascii?Q?BVfjDo4pE4CZBFo1Pq6olp7+h4eMcVMJ6GiBuNYqFPKjJ1CbpY1I0eKw/3Xl?=
 =?us-ascii?Q?h4pXmXwSPC5qmNhI052fDXlahB2ewMWDlsnl7xxChf3+vGOgYGDs40DxQF2t?=
 =?us-ascii?Q?vYxFsIi9HMiqPiEer8LRFBBjeXN7cmilLH6IvWJoHMR10gYrFX7hiO2okbzo?=
 =?us-ascii?Q?50OccLj6/cur0JYoBXDnixaS0PRey8w2UDx+BSAc/lAvAYymZnY6zo+LL9Ud?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2bE5kSjPaD/YhbmEeFdnk8oneH8cm+aOnFfY4BwTamL4PMw5ijVuNe3eMUBCS0UMG0aZvIFzxB7GmMKQP2Zbs9qi7h7QTMwoBNVDtaJcYPJBOEFXkeMdbFWDuWn2cXf13iW4BRk2GbIucwQ+D2HaewY0h6T7UUBKXS2pBVl1/mKhcm+ebuVEp7IuMdHC2InE3OKHYq9IqXeRb/fLeMSvI5cqcHLYqmuae92WzaFC8ucm0AgEFJ3NftJ+mqTCztQQdryuMbNU3x6Ru1cNC/11SxPRpt0IbR0K2y7Hv0lcTeL2q1wz9Jb8E41sM0kz7j6oWhkIo8SOFYAqSbbqmoubroFSI8Ejj2ojDwWTQD02uvFwr4i+q74Il/vBL5XG3A6CPcrgqMkKj05O4pmjjqEpUhoWWtbqyQTmIo86su/tmex+aTh41RKhucb3G+F9bY7LJlKE1npC1SdwRsCuEWiMFmYsZXD171+rkRHvhxahSbXiC8+dqu6lrtxUC8WbqptZloEZVQc91KwkasMaiebk9eEsrfo5xz5NHw3cCmWk8qcO1SfRuKr1hF4LQZ/esbYoL6RaCuh/WyZqpIo9emvINTaYv9YRGbwUWnsJb0KeD/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729f4b94-2b2a-4878-72e0-08ddf0a7d24a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:22:53.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/mOo0Z5HSPrGzRcleQn6gyJHCD6TjKL6YSXfDLwykoYSvdjXcIHZjYPeIVJM2BpQwYIjEZElGup4dZMDIkuZ0DlCqh+tKpnK6faAekCB8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100190
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c1de3e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CxsoVSIMbwK9moDqu60A:9 cc=ntf
 awl=host:12084
X-Proofpoint-ORIG-GUID: 2jZcJypCMw4ZaAzbXOlG6eVmfZv5itma
X-Proofpoint-GUID: 2jZcJypCMw4ZaAzbXOlG6eVmfZv5itma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX7fVhP82iXqPJ
 0IoctgL4CGLy7Izt/b1q925tORBuZe0G4m0JAamtpW8tfDr8vyGej7F/+VgIqZL5Xa1mR9U6mII
 GtTMV8fWmsDWXCBAdf5KKCnRWQcwSPWSALoAcy1w6CxtQczcb68bIzrP5mFOuOoJ6Mc8bzIfdWo
 Y0dQGezOyZ0Vc/82aB7pxaSlPp+wHS5ZQ0cYDxl+mJzYjG2grGhsK0V7IBD+iYt8M0Tk+iUIRtG
 XU+kxBodLWYLFEolplYjUs7DO3sUSAZBXh3Z4ht/KHiY1z0+DbqTV7RpjcfedPHoeFEeQmk09Em
 BlGq4tocJxoq/3Cb/43NyiWy1pdU+LhasC/m/J08Uxglajtd5cCH2/mv3Gz79yUxpHtRZvrD3tX
 RBAkjB2+NLV/0l3W3Pim/wzPDNn72Q==

Now we have introduced the ability to specify that actions should be taken
after a VMA is established via the vm_area_desc->action field as specified
in mmap_prepare, update both the VFS documentation and the porting guide to
describe this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 Documentation/filesystems/porting.rst | 5 +++++
 Documentation/filesystems/vfs.rst     | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 85f590254f07..6743ed0b9112 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1285,3 +1285,8 @@ rather than a VMA, as the VMA at this stage is not yet valid.
 The vm_area_desc provides the minimum required information for a filesystem
 to initialise state upon memory mapping of a file-backed region, and output
 parameters for the file system to set this state.
+
+In nearly all cases, this is all that is required for a filesystem. However, if
+a filesystem needs to perform an operation such a pre-population of page tables,
+then that action can be specified in the vm_area_desc->action field, which can
+be configured using the mmap_action_*() helpers.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 486a91633474..9e96c46ee10e 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1236,6 +1236,10 @@ otherwise noted.
 	file-backed memory mapping, most notably establishing relevant
 	private state and VMA callbacks.
 
+	If further action such as pre-population of page tables is required,
+	this can be specified by the vm_area_desc->action field and related
+	parameters.
+
 Note that the file operations are implemented by the specific
 filesystem in which the inode resides.  When opening a device node
 (character or block special) most filesystems will call special
-- 
2.51.0


