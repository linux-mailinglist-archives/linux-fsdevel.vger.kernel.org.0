Return-Path: <linux-fsdevel+bounces-47759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39558AA5530
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 22:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0887BBE07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970EE28469B;
	Wed, 30 Apr 2025 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YgUY4MU+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AN5q0jEZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B427A46F;
	Wed, 30 Apr 2025 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043223; cv=fail; b=njtI+7I1r1mNb7K05o+JHLrSCXo/SIk/Px8uBSBWr1lmIwWmTMhC4GNYlBpkaN1E2WBkSCkFDdf9UZxnvA4dBaJ7SF8iAnPsbSILHe2bGFNJhHoFh3tg7/VRyyY6NDBn6sOSP7aNbkCBMaCicy3darpueh77gFkQKd37+CkXMrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043223; c=relaxed/simple;
	bh=jo0/0aIT/XugcDN6/phBLgpySvGT+UWgLpe2A/UQmDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugPQMDlPZ7QxIoi/UDMDOYmQHJG7lNGvcUFg0c/UBcopxjVUe2lgdB3+aOmMSmW1DuzpkgJw4pmxYrXYKcnZmctciKe8EXoM3Vv1niYBIBOmGgZWL0fSL6jj0BTunY/LDj1WG9MExF8aK3o/zy8ToPVQwwOpoN9ElwBNOeXApVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YgUY4MU+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AN5q0jEZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHttEM008802;
	Wed, 30 Apr 2025 20:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/I/HV1cnAxwHYKohd0J7clXbAg05cRUgE8nyzc4Lvms=; b=
	YgUY4MU+93qTGggnC1xgWXZLFRtwgTGJhSjNicO3nxBHKeGgNOGxm2EwBc0EttTz
	tFF53uwaV/olpqouwPrHaV1CRy1d+fwjN3YViN9uSVS8/kAhayN4fwX58U9j4YcQ
	eNF5DvVQ1sFw6ZA+zabb/y5n4ODbAeN7TzQXEH8oLkTZEqdIl5JLHtWobZyinycc
	teaOwyC8i+3FzeKFttzOpuNJTLQ5Tqribo0MJ66reGOxO8XlXgm3CPg+OylRKIdH
	HKDBXmqAmPxrLNN+MJ9nNozOmdbjO9lAFAKv10Rk62lhck4C935T6z5w3e2kKOdw
	+HRJqJMr4V16HG84spMK6Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uta19f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 20:00:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJtLZn033518;
	Wed, 30 Apr 2025 20:00:03 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbsguy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 20:00:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsdCKb/ZAjXb2s3cU+pZGHjIMHA3uJvAmbmR3+fEQPZx/vu1HEh6kIN8NrOd//OwMwBDTqIGfnSPzy9kMjl24Pd4rP55fTtFfGcJ9CuEX32gUUruXkAw1NyMhX7E/GjYETfJg1XceZHBrbeabviqVInm2PocKIm8vfE/PLo98ld7znG/Z9Tj8vNhEysMze8fQOXgelDfY7qII2TBwNOny6AHBhReZxGPBWDLy44InvgvKJ1xSEuLQroT7Ewy+AyzO1531ejALnwZWrjJo6/uT8nZKfylOgI1SasuAklGLW8Cg41JNxMHgsv2Y+L6sw0C5XBh+r1Be/DlsLuxqFo+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/I/HV1cnAxwHYKohd0J7clXbAg05cRUgE8nyzc4Lvms=;
 b=Ma4qIdd8zDQWypWgcLTCv5s27HDRzEdDDE/GxFRC3rlHfx+guQATZA2ooc8jybYmmauHwe62FOwi/sG5QJ2z4jwls5iYG96zZ1bUTjrDtrQEd5CV2pJGCN2JvK6iiw5/39oS6pNhSduaUtYs0VB+0BB1A95oRCyLdWWlQc1B+3x0QuMQ+LFMH0cidXDB4J31npnkSsJJ25t8AE1C2PPGGh7plaVdwDXm0HqadV/Gx9jh37K17qiFPjAf6/M9nuHVxLZ3U8pQD94r0mKoJQOM+IelC2hB25FwaY9ga7jdqSirltO6ntrh2gGl5gMgM5GBgm0fqcN1ewifxvkFvCYPkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I/HV1cnAxwHYKohd0J7clXbAg05cRUgE8nyzc4Lvms=;
 b=AN5q0jEZIrgHpGbP72c7yNlaXKfy/za0GwngimfB82QPpMchOaqXt623CXrbGqNp4LTRZ7SDS5GoMhQnF4sp7DYM6/9362NIds9Y/41lHnyghWMWLUmLvqwiWDwQ/8cERer9AbjwjHev1/bz7pHTr4zEeH5n4ADMrYJwd7w3L3E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 19:59:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 19:59:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH 3/3] mm/vma: remove mmap() retry merge
Date: Wed, 30 Apr 2025 20:59:37 +0100
Message-ID: <da9305fddaf807eeb7bc6688f0c6cdf14c148c27.1746040540.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 041c0e10-212d-44c5-be31-08dd8821962c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q6T58HZVQbE2Egh57CIGZrCwW2zMl/cINwdAJs0peOs1oozaYvWoJXwbnaGd?=
 =?us-ascii?Q?RG9gZxDeLD5ea8CpNQUCS/jRg3vJheL6Jgwj8kvpqN38fW0YgHb4KPkGSHXi?=
 =?us-ascii?Q?toOqBbQnJVbvLtEgRLth1q63qq/HyLNdlJZVPbm3GlENgHtLw0G9AuNsF83D?=
 =?us-ascii?Q?HaYbban6tb03aC5GHt1UlrcfiAHmtBXDZIr99lDXEGPMibbLhqWhx6eixLSU?=
 =?us-ascii?Q?/onqTLVEB597AmTJThmDqv+FFxr/B5AP9a/8/QpR2QNBFiN7M/So7rPXmnPL?=
 =?us-ascii?Q?05b01RiunNJD/DEydj6BeNrEZGa/+6q/U38g6wIDmwu0b/oWRq1/aWrSzMzm?=
 =?us-ascii?Q?Ql0n2K0HIIzUN0shQ9mmSuvaI55tGnoQdLIL63igTLX4xXOZxdnxvChIvmUA?=
 =?us-ascii?Q?vrK+N6UBuB0MiabvogYmsA/VCl9iJfDr9xaLe2wcfSWuw8I8nTUOIHaSPT4f?=
 =?us-ascii?Q?jtgtwBZAO7cqwaO8trMsebCCSOxSLhSzG9NkYgC3yktSXKTv3+4wjMiEnvPz?=
 =?us-ascii?Q?m/MgS69te1jvC/2ZulTMV8on8xJCYQtltOX5X7snMHDfEPMCR5gUmeof1ouI?=
 =?us-ascii?Q?IeyJKfpW0XCHipKqQ4TI09HCtYXhUY9pI/uk5d9uBancpv1fCYP3+QYLnOvX?=
 =?us-ascii?Q?0VmVk1BJhZqnySR4rgDQUDHoGmvaMTmCy+FRCrIhmtfwq0RiV8GXI+xbGB8u?=
 =?us-ascii?Q?4Jv0DPsLGScIMMKCQ/XskcPWyHPEKftZX36a8AC57XRkIcgQFhbnNovFLtAs?=
 =?us-ascii?Q?BVm9aLraFeJMMxjaB1912YUyHK4M3smYo7Rv2AtE9JEQyUiDdlsB+gOYEaqQ?=
 =?us-ascii?Q?ZzAM9a9+woEotQ8K/ZcT5ufvWta9Go+vLhR3BwqrSUjIdCw3FMJjQhJrIxKh?=
 =?us-ascii?Q?6wLjxiqi6+Rd1PZrVVHnrfMWXmOrX/b0HYPBMo1pjXRzE/Uavqju33ukeKyy?=
 =?us-ascii?Q?pVEHSvmHzcKnW6F5hhtJNaL+H/lj23m1EYVZxNOZD+rX2IsKJQLf7p5Bsc5G?=
 =?us-ascii?Q?k+WI2PnXj8q5RV9LKVGhrkCq+Q/rZKziiJflczpnOSG2wgjXoEjIhbhSwvTf?=
 =?us-ascii?Q?Z6Oj6STKBPaWg2AJInnLLX1XnrEqkzGF7AXfxTA89PKqwqRBU6dd88KkvBV8?=
 =?us-ascii?Q?Ni8DSluITF/2YtK//uwa5hcDGA7zcW63j/LOBDFk+MhKTxDnZxUglOe0cZ7V?=
 =?us-ascii?Q?4f9XuUL4nmnwdKhq1Z1+sqPH6RBujgFgH2HJtoMrwDDPGQcDh6FiYq/yTB4C?=
 =?us-ascii?Q?VqHBc3cZFoCOBqiG+q5Kma9htVRwDWJzKBB9bM3XTl+OJm+KFBLr8VsdG5DX?=
 =?us-ascii?Q?zSPlhxDSaqU91wOakcK4AeVy7g+tcI0rLAmF8LdDc7GW6EJcZKDlx6eakM8R?=
 =?us-ascii?Q?tCTWitkpcZKoUR+yWtntXT8+wX3cFxA7NslqxARBmG2L8c0WtA5BEF3G6LvQ?=
 =?us-ascii?Q?owpqtsnzCx8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?chjx1wACKY3gw+Y+0NXb/xqO2IQeQ2WJh/oBgJsarGvU5yEBv5neGyl5qD/P?=
 =?us-ascii?Q?p4VZBysLBGAq8zv+JhsbpKJycjZAmxKjXodJwbswRdFxJfqx6AgNR4/PmcqJ?=
 =?us-ascii?Q?m/r0IkLIXj3u9m0OIZRLjY62bogmBvF4OXVgpF69dblbQCzTIJTpLJ/P3F8L?=
 =?us-ascii?Q?P+ygkPXO/tQLSSeP1K+NJUh/YzEu0Bvlf7C+FjiL/iFBn19ArxYsEGNPYDfJ?=
 =?us-ascii?Q?+i0H0h94vZDjpsuXjtBueuVC08WjJXOINoXOZCh66XxGADYjnj304EHucE0V?=
 =?us-ascii?Q?473HhWtmqUubWzVu/l92JYADX43OIspn5E+3CILooWn/SG2zRWsmXJj+id8O?=
 =?us-ascii?Q?JHPT0NHwo9h0h4quATdpqpguJj/r/gReyszb3Gj/lC3mhipDEyegAULEwz2q?=
 =?us-ascii?Q?GTR6ikmPwnC4in2lcGdt6Csl73g8OMCSYItsWJQhVSkBw8OUR5Ogufeul7BU?=
 =?us-ascii?Q?DVeMhE6kfpL968/PLT4zki6CspnbvKF3GxS6xp6OuphlKdQjC62x3JTAHIXJ?=
 =?us-ascii?Q?PplgyPPtW3+qSLXQeScqSZyI0GnZPLmW1WbOhOwpcOk7/tJ0jLfbs5AkY0hT?=
 =?us-ascii?Q?Frd805JloEG7l314eQpLXoJD5xRQcdzA3bLuErg1TZ1uJW4ljPepcJevb7FP?=
 =?us-ascii?Q?fdlgDeIRfODc3JX9wEN/hXZEoCuxKnz76FiGU09ofbzjtfSSiB62EgYJduwL?=
 =?us-ascii?Q?QIk+2zuqoc8vJgfQMWjjfkysRGdr7p98LkoOgKqgSclk641vySpcog1n/8jV?=
 =?us-ascii?Q?12zqVsbUCqcmyPimMRDJRVsH0urdJfSJVUfWx7sl/u+lH88uXeow0vf+j2ml?=
 =?us-ascii?Q?EJWGQOSC/L/V2Lizpsr6OkgVgFBu6pD165QjOGeFa67VwglkaNZc3uI47tSY?=
 =?us-ascii?Q?sbck2aaKxXlALAc8Ia9RpR7kso8/z3Ag2ktBnH3ThDAYVAURru+NBeu0hH+U?=
 =?us-ascii?Q?4wmMpVqHOxBGLMdAz5HFncEEZbkMhkEL9O8TB5fkN2vZnLuZwHJdTBbQ5ZlX?=
 =?us-ascii?Q?4XqiXzzYcb5Lobd1DjED0d7T48VNDhiGk46vUOX/BhYX8V1W5Vgcpzw416Od?=
 =?us-ascii?Q?Th6oTgjMSKhIENxjHAmaXv9v46AWhUm/O1GYFQsddXDao7jV4XLrJQRTtqpu?=
 =?us-ascii?Q?H26G4w5jJLers9zXxlGzsVtQmG5UbXBxbXVjnK0FKMyRTkMbd/739/0URg6L?=
 =?us-ascii?Q?6HXpMJ5zdGXZ9f+T4NYXre4FL5lgxSB5vuRyacXKF6OaLx563JGojidSF0a1?=
 =?us-ascii?Q?lK1V490zTOx2olkAmaFYH7OL8DranUJPGRhNCqXlkwi09bkxuaGVSWX/DtTZ?=
 =?us-ascii?Q?1UagsYZ/FIB+1mqAICnO1bc71FITe/tiIGG+hqHIpKkmOLoDV7siYslHLt7X?=
 =?us-ascii?Q?jXZc6Atz4PK2+uQ3CB5cPhygOy5+WGpKlCpUs5Ljq6DXnAPrZuDOhLmO7xfY?=
 =?us-ascii?Q?ecUI7krbS8+FQfJ4DOgWBqAkHsFZd+pPtoK6RBaqJVkvN7eQgKPmzXPyDVsc?=
 =?us-ascii?Q?vOrNHJIBSzqcC1f7jlDYeDYw4Wl0VYNydg5wqxiCILriYSNNZpUXG1YvB+ax?=
 =?us-ascii?Q?3EAQ7upCn6BvKrWGwPmQXPDtbHTOC0+jEmnlH+RCmYlpg2ORZMpx1J448gbO?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DZXLI5mlDoOi0f8lbCBTLY1XfbtqdjhxIGIDK6Y6imlJxWaqeof5pL7cDwcYdQTY0YX7azRfubA8VI8je2EfjFW+wVWg1snFk7ibB4DZ9+z363TtxJK3Lg0RFoC/3fldnpymAQp4iJVEfcwU7r7G9IhO5oCgoQWHQyMIlpKFX6RU+MJVENbrezSPt9j1lCs+qp8e3g+1lG3HdO0BfKk4bV7pB49zDHizhxQuyXcrwdjyv9q6jWQ8yOr7UUC/PQPq32zKlD8NjJOLWa93YqMK7PafIkw12duMa/af1nDBicGVER8BE40j6mLGgZ/Au0UyLZtibMHB1uHBjW7hHNTlzUxcmaLGQu8Y9KgJ/s+0Y1Vj6PI9u1wS/J514xalsxs5zM8bbymIHtao+Jy0x9/GEDEjz2nZFMPfWvQlHMMtJOiSWr79U4x9MqGYBlFqB0L8znCNTHjNNxpdclLqcl20u27l/CyqoxGWDKG03SdHKc4IuwBCyQCCNW/GkAorDNf1RT8X3G1DParCfo+W9pMLmRVBzJdbq5DI3LSwkFj0WdBHNOZehwRJU2GmYSV99YoBTac7Hu07pTkAQIMnmW87zESTpdKiR2c/1nnGPYEPsKo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041c0e10-212d-44c5-be31-08dd8821962c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:59:59.2195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USSwzum8QxSmDIdQuxbsbQnqHmcwUesziNiAAq/oOu9kk0zOCGnX0RliGAZ7DeIrLgo3zdrOuggKg/TtsmpsOz6Glv6Svxk6WIrbOJHcJ48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300146
X-Proofpoint-GUID: DCyUSUOCadg4aovaEH7MvkbqKGpP6Dry
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NiBTYWx0ZWRfXxfFzXd9/96k/ rDXqknLnqBJo6Kj9B5R88uzOKsvbmtFi391OsW53Ndi39EoWoEMOnmxWtZDUIVM5jlXEMCk5zJ0 LhcwdDUW1QLtpR3exW5aJ1eBNE24CgxnWBvJzFY5Uu2gWMZf7oG9t8dnSWnGukRetqJgRAAs5tT
 ke58wlmCRhFw8OTU/f/h+QgLng8XGXAY6q5Cf2pgEaoiGoOJMG1qeN8zBRo2b2UPTPKas7BYhgX kFVfPsQ6HIbNP338r6OCS+cCIezQzcNX0bWi96IWoSDz/jLcyyPCDU6t9FsZF3r2sq+X9vhDHob fTiwv/lpy8Bwqb/Li3RCQTfpLOahD+Ao2CEySKThLxwD5mgxBpdQNw0Y0ru5X/9Wt9DrqMcchGy
 n7UfgTRTheIB9eQuz1lqZI1oVTQlwwatqwoDY0DOf5nom8ZRtbyNvL2eZPhgtDyVCWmAcC/A
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=68128144 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KWrF3PiNL9PbMbJVJAMA:9
X-Proofpoint-ORIG-GUID: DCyUSUOCadg4aovaEH7MvkbqKGpP6Dry

We have now introduced a mechanism that obviates the need for a reattempted
merge via the f_op->mmap_proto() hook, so eliminate this functionality
altogether.

The retry merge logic has been the cause of a great deal of complexity in
the past and required a great deal of careful manoeuvring of code to ensure
its continued and correct functionality.

It has also recently been involved in an issue surrounding maple tree
state, which again points to its problematic nature.

We make it much easier to reason about mmap() logic by eliminating this and
simply writing a VMA once. This also opens the doors to future
optimisation and improvement in the mmap() logic.

For any device or file system which encounters unwanted VMA fragmentation
as a result of this change (that is, having not implemented .mmap_proto
hooks), the issue is easily resolvable by doing so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 76bd3a67ce0f..40c98f88472e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -24,7 +24,6 @@ struct mmap_state {
 	void *vm_private_data;
 
 	unsigned long charged;
-	bool retry_merge;
 
 	struct vm_area_struct *prev;
 	struct vm_area_struct *next;
@@ -2423,8 +2422,6 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 			!(map->flags & VM_MAYWRITE) &&
 			(vma->vm_flags & VM_MAYWRITE));
 
-	/* If the flags change (and are mergeable), let's retry later. */
-	map->retry_merge = vma->vm_flags != map->flags && !(vma->vm_flags & VM_SPECIAL);
 	map->flags = vma->vm_flags;
 
 	return 0;
@@ -2641,17 +2638,6 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	if (have_proto)
 		set_vma_user_defined_fields(vma, &map);
 
-	/* If flags changed, we might be able to merge, so try again. */
-	if (map.retry_merge) {
-		struct vm_area_struct *merged;
-		VMG_MMAP_STATE(vmg, &map, vma);
-
-		vma_iter_config(map.vmi, map.addr, map.end);
-		merged = vma_merge_existing_range(&vmg);
-		if (merged)
-			vma = merged;
-	}
-
 	__mmap_complete(&map, vma);
 
 	return addr;
-- 
2.49.0


