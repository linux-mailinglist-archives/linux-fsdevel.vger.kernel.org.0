Return-Path: <linux-fsdevel+bounces-23164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95767927DD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE5E28290E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4593B143725;
	Thu,  4 Jul 2024 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V+eSJ9fr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WIm0hi3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED29142E86;
	Thu,  4 Jul 2024 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121342; cv=fail; b=H8YogsgXJiZXWN+E0yPWR0yBlpwyZu0J6vPv+JrEI59z4AON8JhKzcC79SSiL8ED7KMEbYVUTCrpvUpKnKVlTw3Xb7Dns4E1LtYBnGlRBeCDZX2x/3H80P2wVVitEfSUBS4AffqVYU9PhBuEi//2DO7VFupopD+MBMnEMg0LkQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121342; c=relaxed/simple;
	bh=bpP6Lac+emi0BbGIYENj3M9MyZUFmn/H+vx64rtgUiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJAT4qJrtdS23pBOzd8U/NvetGcViXSlH1/ND4hUDdAb5s/VuBk+F57FAKm10vHcuN/EHKTL2BJOj3JpDryVgD2+KLT0+ymxyMHV+5VJ1Zj2IruZVO45ujSFrWsLqYYKQ58oCW9ynBsaY72qwgY6JdUpHddBBWnp57UwIB5rboM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V+eSJ9fr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WIm0hi3z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Dn5b7016715;
	Thu, 4 Jul 2024 19:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=ZNOuVBPyXShnbnx3cIgX7ipwTQ+o5n5XVXt2hJi/FzM=; b=
	V+eSJ9frwhtlNm5MTS+15sRb2XaUVsGs0Cr9aGJVcprb3dnFkXsgcDs0w7OS87r0
	ddfhJSB/69QWeLy9K0uTmX8aU6Mp5YR59tGANVIHBOPKp4ei46jpDMDe2TYU4TFq
	v3zVB5u4H/MZzONyLP/KW5GWGZm56Cd7+c8YL26cWt25chQemRdhC8XNpd1WzxzI
	ylGuvNijpRcaqeWYoX926XUPtZjAQvAnj7KfaKx6VBIifqloewFH/SrDaEBYcqRn
	WvXJRW9i37dtMBMhetfbtYiyRfR2y+Edjzy4gzhgDtX71R7AwwiDPpvbFzq770Qn
	0q4I3ULdvZIcJutHbs25RA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attjr2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464G0qU4021840;
	Thu, 4 Jul 2024 19:28:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qgrd9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyjqeI3PNSKlJzsUPyhIL17VN5ng08TdeGA+GrTjPsZmoWjuD8bOyJOt5Qk0zt53oYbDBvhCvEeIc9bAHxT4TXjydzKuxQkokAqGykctxoG0CTA7EvoYnGpcxAH3ZctG7Do7splCrEus7awDR7i4xsXO8Hqd5R/LcnKZPzzDyzB8u85Y3ozo16FRdwDjuQKDW1yLthsXnWPQ2ip7LPH06rTkXt1W+pqK4CUQVmz0hpujehTQGncv0svdaTZdcGSlDR7Znwh0o2bSw/5ZhXeE1qDiWb9bAyLAVgsAAIjnhsc3sFO9lOkDmWY22EqVc6yjMVy+p9JrNvwewBOKM8gBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNOuVBPyXShnbnx3cIgX7ipwTQ+o5n5XVXt2hJi/FzM=;
 b=DDOdBdyIe7i2r+2XyL8Y5EzTeS90p+F3f7CfER2xAX63CBsSi9/Dqtb3OJZLGoIENVNneW1DGlj4Hc3/HDjRgcdsd3g+87pS3+v6mV4XdGkimnaiS6YiZQ/oEAOzX8IvBMz5KwuffsutQ6QmPtY8hjP2lilOlEikR25ejTwveXH2AVi+GWHirCp0UDCnIxYVSapXbT5Hpvw4OivUJhBHdLbr1zRe4iR8KJ7yTD2cAdrrT0d3/y3roEk8z9F35D0UefIegYRpupEE1HECz5nd1OlBjXjmpzvrWIxhAYspvvOQd/7wtTTXl17pLu+f8ePEY58sJQF+GR5p42PKXNu6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNOuVBPyXShnbnx3cIgX7ipwTQ+o5n5XVXt2hJi/FzM=;
 b=WIm0hi3zcmRmSHByTSwzXfUO6XEFmn8yRtYfNCB+iBhM2RDJeUpN49l4RYJLe6j2WH2E65mQ/tffnG+P7OO1KXYxiAONeQXN1tXYvWHqc10m+YHnQAJIqcDJMi9vxgpI8PtS6LGB3hRVepq3a48oaNT8ys74vSviGLLfwAgt6eU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB7228.namprd10.prod.outlook.com (2603:10b6:8:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 19:28:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 19:28:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v2 7/7] tools: add skeleton code for userland testing of VMA logic
Date: Thu,  4 Jul 2024 20:28:02 +0100
Message-ID: <7989012e4f17074d3b94803dcebb8c3d1365ca1d.1720121068.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0147.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 807b1166-7abd-44f0-3d4e-08dc9c5f80f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?K7BHA2kSxxANYbXyw2Kb85vRU15yB+WTQOsyG7mVyuMKVR23euSdO16v2v2A?=
 =?us-ascii?Q?Ktr8yAVwOJNQQ4h3OxazeIo7+KLHovAhYae7GIZzpUFK5ccj4ZVJ4GcYCNrU?=
 =?us-ascii?Q?JRZmWQO/h1oVxacWVALhJ4g4I6q1UIbpEFceAK4DjG3J/qN2+2VgX/XrhH9V?=
 =?us-ascii?Q?SM02gZ9viLU070zzk1ZgcAb22L+3HidA2pQuY+LyEX/96nJ2osb1iEG+OQ4p?=
 =?us-ascii?Q?yX1/S7XB+noWVKydi2t1ViJHeQaKzaDLFXAGoU07uC0aX9BCdUUm91zx9u8O?=
 =?us-ascii?Q?A76Elppp7CoeZW5UO9TmJHTGOI0Lg8gZQz0MrOZ5NpW+pjgoigfc/uzlOgXE?=
 =?us-ascii?Q?PyAxJHwPHXtWtXT5Q1HjuVoz9jHEkmRPheRS6QwC9WdpGhrw9aUYBviyNsIy?=
 =?us-ascii?Q?mb2PLS5yGhqAinKr0AVrU1sydVnK7EgqTDzKnClX82O44kX6db1ugqniikY3?=
 =?us-ascii?Q?Z42u6MZN4FjPYrexw53LeUAFYLUNJ0ra95GS2iubobrOE4+t9JvHuF94LUoh?=
 =?us-ascii?Q?lrR+8cbFCa9bKN0kB86jwurx0lTK54GEKOiD416g+0wRPrJuQEqQsUmZyKUb?=
 =?us-ascii?Q?e0ooGyiduz1VpWTQa1uaSj1LXv49jogOHMHYoPC+yDCmKa6gncQ6ytVcqyeG?=
 =?us-ascii?Q?enOyAftb9cdGevNoClGotkrBcNMI6bZhqFFxg57vxa2ffxTPuW5bCvVp85wJ?=
 =?us-ascii?Q?uTdeUIf4UsxQVZVZydsKnAS7ZvGJf/xXC/zOfjzz4L2wjJy40xjiFZi1/Yt1?=
 =?us-ascii?Q?nLq+R8GkurUpI5pB0iMmCQ5tFzmk6Qykpi8Co7xEvlGB7KDZtuH9DQEdIBE0?=
 =?us-ascii?Q?2m3XlKtdO2v6qs9X4Mv5EJgWfL/rvtzWfSMazPmE116S/mHoUQ0j3GYcXVW2?=
 =?us-ascii?Q?sKWdV0mR4I1Qr4TzGKGJ1w6k24H750gfF0rJ2X2Z40KFFNgAG+O8AxzeUxNK?=
 =?us-ascii?Q?vH/9gqFN/jovTJ4IIjAZdxSXFMBWZoQgwPOA0OsiAnaij+QcPz/+NUXvAgG3?=
 =?us-ascii?Q?+gk8HHqpiFa3Su0iNgBL2EeE/BUU9VyObIjK9b8OFQ9L//S4OFjk+zLdRS+N?=
 =?us-ascii?Q?5cMGosbwK6jK8c4/x6JqHXmCDe6Zms4Q8inOd6rTsGgVA3MT/TBaehkJxjw+?=
 =?us-ascii?Q?wMiv5BUvPG2b6+ncv+byuO5SerA7MBWsSReIwbyc6l1c3qbe4wgg3/Yh/ZP2?=
 =?us-ascii?Q?ok3aTrR/5dqwqcI2dsqcmOpkYiC8MPW8AwmPhvbB4LDlJC68KCjeUsGIAYlJ?=
 =?us-ascii?Q?cixtXmOE9bX1GdQRF6XkF2YiuDVtGEhc6E+EWRBDRs8aHBZR8KKXuNUjgfpx?=
 =?us-ascii?Q?gkz+Tb08y8iSVYQmRx3Z42HKgn2Oq4dXOZBWmPK0+0ZWaw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7RZLLSelNrEM1KFB2z6X8Q1CZXpukSSfrM5Fd0g+pmAkPpZs0lYYrK/hOtF5?=
 =?us-ascii?Q?T6zQTTrJjpI4nIU+5YB8UxQvMmjw32JXx0p0kBLfvZAmfCn4MxyDNK6lZwwh?=
 =?us-ascii?Q?UVQX60ZjchXsvNh0o4C56gACJv6eS5crd5MqThVJpEPYAhcBMCFdozXhYGy3?=
 =?us-ascii?Q?uJKbkDq7GIDFJiITR/r76CwDD/ykDPzaoOZVtuld8UbCtswIBer2Iwu2E7FS?=
 =?us-ascii?Q?dAfDhZdLRh19CoATWYYbnIOnUAcynuawQzE0Zz/cPqeYESdsxvE8VlRmKoFK?=
 =?us-ascii?Q?E5rCotBVRzR2ipUaFmt8e+4A6YvdFQNZBxZZGGK0CBrDQl0O6xevhZtMDpwt?=
 =?us-ascii?Q?7LGAHDAPckHR+oAOKOnjy5qPqyjWHVZlgH99Jnn7Y9YG4CdgeSej14YcFjuI?=
 =?us-ascii?Q?8MyGg1N9PDo6277TynkNNz230e56wYQBq1LukAXYM88uexVUB6X3QsifKSDZ?=
 =?us-ascii?Q?uK7UiLFaJDL0pwjBA/czL2xyLRfte8tnmNxS5jHJsOgK1lcpNv+VSKMEo7rH?=
 =?us-ascii?Q?GV+d7zF2AcGupXqv485anb5KIdCzCCwRCD0puv36VmwvWP7Ts3bLfGRVh38h?=
 =?us-ascii?Q?4qaFLUVtsxxZe3rlegKDbLE3weG5khd7OZoq1yrtyUHZxSJB59CWaFjUNXnA?=
 =?us-ascii?Q?aCUTteJHrbSLvCEgLP6qjr+GD3goFyNc4xAGqMwG+NIAkOEVqhwphnWKjzsg?=
 =?us-ascii?Q?omYDZOtQ1OoSmZTgB8oHh3RCNK6WPIL9PCtkFBiwte0xSoVetP/XKv8t3sHf?=
 =?us-ascii?Q?PVuV10Iek9nWqL59t8jTU6srmDvpzo/gHQeR5/8au+IVk6vZVKcM8vWC2e3i?=
 =?us-ascii?Q?RqwFuZ4XJ38L1yuG3kldGaxMsU79s3R3bvqkVMF28IBnAOqyMOmUK74wpXUd?=
 =?us-ascii?Q?kMY3IfoGpSScQnWmJaRroeo0bCqbEczGOdZMkrG7ULezPPgS/MEFcb0mI9fT?=
 =?us-ascii?Q?EKbCta2xfF0Eq0t5qjqCxzlvX/fJx6eDex0bwpyHDfXqeWylQuQcr8i1c2fA?=
 =?us-ascii?Q?4beDJEmOH5/O80BdWjv2hG8gL2JCYCNxR7521ZpxKdwtclBOLgePRuEgVbMQ?=
 =?us-ascii?Q?d5N4K2rHU2+B+pcEs+D1tOUXuJuqQNaDD3zhrXOdcmmEMKvz1zgryVqacwcT?=
 =?us-ascii?Q?QQaznZh5oSMfHI1LfCt0IgkzlWCxqWKFQwSlXIE5k4Ft4I3nWZidwc0AhzwR?=
 =?us-ascii?Q?btTp4zMBcOYzEinLiahusJTYFxIA6HVfdDsQ3UY0EFOmvx5A7dDOZ4HdtvCY?=
 =?us-ascii?Q?pQ4Akp0Aj2RTnWaRVXnFSlR5ZV6hsgUP4PYUye+DcJaC1oLft5hbIqz5iYzw?=
 =?us-ascii?Q?bGpuch7xoSukxsFCayZJgMVUJplzWI5RKJiYsCsxpvtXbF94nb9c3Hvdf5fo?=
 =?us-ascii?Q?jwo/qIlExPnEyXFUBXJL3BoYLDPd4tT9CwBk1AiV4kLia2vieIBl1pojwe0f?=
 =?us-ascii?Q?Il1rej+69ZlAaLAinpAC/fgRZLLLBJoOICug4QNFUxNWc9jkOV8GygQ1B9gx?=
 =?us-ascii?Q?OwYV21c0IcOdknhVpHItX94XgKWAlnCmqT22Bm+TroE54lPoxdL66YbACk1I?=
 =?us-ascii?Q?qLAf4gYiBCpwOhuXGUECupUs+T5ZJUrlMkPSHaSeOBVFsKHf3cz3UidLwpuq?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ipzN7PS4Sn1y4THNv0r7c4hFb+WZHfuLTy8DqETP9+srGUSNqFWmqud3lVMieesICrrgkSB1xzAH2q0BPIYM9Z2NCoIwmpfc01zGREYGj1AAZ/1aWNdNYh9PYEEEfb3W8QR4sy0+e38Ji9P/hL3T6TmhGokmP6DHAdvibf096B5f9jgkyL3XDNGSecoCr7Btx897XJY5ylflzkDg5nZuXmykbce+TIe297PBCySCArZRelHlAqqASHH1wHeyGHCbtuXU4PcWW+REdDr36UgjCqUUWbHT5+Uy+PGImbagFdUc4yyL4djf0cC3vlAUJKzhFWUxMopZcuLfrDti400cWug0SaPXzSgTQMeKBd4nVfDYaaKGnbqR0dhWIcsbo3BUeLH6FPxo8WWs6my6yFwWdI6fiuLZ8wzprp7XfteQPP7+aMyrmpUJahO8RHF4aJikPTAD0EvOqfiSn6UXH7ssmNzD5ugMuqrrcGLRgLNQc8lYtOha8SUweFtBoitxZfjTNj+aLpLGW4kFa+pPi17iUG5mk4A6ajPGcsekmgPzmSa20qmCrrh8WeVmQ8WaCX5OrCng5rvQCTVi/IML+0uVp5PogdBzCe8TUXO6HvEfwbM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807b1166-7abd-44f0-3d4e-08dc9c5f80f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 19:28:38.1451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owjm+19CciYvkFxiYbZMTGb5BjkZK+gxI3rQF3ampRKYwCMFa1l9QnvTpLnCylHaT/8b56Id8iIiWS9KHstcqgTl8hqwRcOFxa+xiiI/3WA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_15,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040140
X-Proofpoint-GUID: 7vc-cCYi1JbuJ71M1ppbXyGsNuU-ZwM0
X-Proofpoint-ORIG-GUID: 7vc-cCYi1JbuJ71M1ppbXyGsNuU-ZwM0

Establish a new userland VMA unit testing implementation under
tools/testing which utilises existing logic providing maple tree support in
userland utilising the now-shared code previously exclusive to radix tree
testing.

This provides fundamental VMA operations whose API is defined in mm/vma.h,
while stubbing out superfluous functionality.

This exists as a proof-of-concept, with the test implementation functional
and sufficient to allow userland compilation of vma.c, but containing only
cursory tests to demonstrate basic functionality.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS                      |   1 +
 tools/testing/shared/shared.mk   |   3 +
 tools/testing/vma/.gitignore     |   7 +
 tools/testing/vma/Makefile       |  16 +
 tools/testing/vma/linux/atomic.h |  12 +
 tools/testing/vma/linux/mmzone.h |  38 ++
 tools/testing/vma/vma.c          | 207 ++++++++
 tools/testing/vma/vma_internal.h | 882 +++++++++++++++++++++++++++++++
 8 files changed, 1166 insertions(+)
 create mode 100644 tools/testing/vma/.gitignore
 create mode 100644 tools/testing/vma/Makefile
 create mode 100644 tools/testing/vma/linux/atomic.h
 create mode 100644 tools/testing/vma/linux/mmzone.h
 create mode 100644 tools/testing/vma/vma.c
 create mode 100644 tools/testing/vma/vma_internal.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e5ece55b3cfc..16673f2d0b14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23984,6 +23984,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	mm/vma.c
 F:	mm/vma.h
 F:	mm/vma_internal.h
+F:	tools/testing/vma/
 
 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
index 6b0226400ed0..f5d68a9a36df 100644
--- a/tools/testing/shared/shared.mk
+++ b/tools/testing/shared/shared.mk
@@ -50,9 +50,11 @@ maple-shared.o: ../shared/maple-shared.c ../../../lib/maple_tree.c \
 	../../../lib/test_maple_tree.c
 
 generated/autoconf.h:
+	@mkdir -p generated
 	cp ../shared/autoconf.h generated/autoconf.h
 
 generated/map-shift.h:
+	@mkdir -p generated
 	@if ! grep -qws $(SHIFT) generated/map-shift.h; then            \
 		echo "Generating $@";                                   \
 		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >                \
@@ -60,6 +62,7 @@ generated/map-shift.h:
 	fi
 
 generated/bit-length.h: FORCE
+	@mkdir -p generated
 	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
 		echo "Generating $@";                                        \
 		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
diff --git a/tools/testing/vma/.gitignore b/tools/testing/vma/.gitignore
new file mode 100644
index 000000000000..b003258eba79
--- /dev/null
+++ b/tools/testing/vma/.gitignore
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+generated/bit-length.h
+generated/map-shift.h
+generated/autoconf.h
+idr.c
+radix-tree.c
+vma
diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
new file mode 100644
index 000000000000..bfc905d222cf
--- /dev/null
+++ b/tools/testing/vma/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+.PHONY: default
+
+default: vma
+
+include ../shared/shared.mk
+
+OFILES = $(SHARED_OFILES) vma.o maple-shim.o
+TARGETS = vma
+
+vma:	$(OFILES) vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
+	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
+
+clean:
+	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h generated/autoconf.h
diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
new file mode 100644
index 000000000000..e01f66f98982
--- /dev/null
+++ b/tools/testing/vma/linux/atomic.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_ATOMIC_H
+#define _LINUX_ATOMIC_H
+
+#define atomic_t int32_t
+#define atomic_inc(x) uatomic_inc(x)
+#define atomic_read(x) uatomic_read(x)
+#define atomic_set(x, y) do {} while (0)
+#define U8_MAX UCHAR_MAX
+
+#endif	/* _LINUX_ATOMIC_H */
diff --git a/tools/testing/vma/linux/mmzone.h b/tools/testing/vma/linux/mmzone.h
new file mode 100644
index 000000000000..33cd1517f7a3
--- /dev/null
+++ b/tools/testing/vma/linux/mmzone.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_MMZONE_H
+#define _LINUX_MMZONE_H
+
+#include <linux/atomic.h>
+
+struct pglist_data *first_online_pgdat(void);
+struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
+
+#define for_each_online_pgdat(pgdat)			\
+	for (pgdat = first_online_pgdat();		\
+	     pgdat;					\
+	     pgdat = next_online_pgdat(pgdat))
+
+enum zone_type {
+	__MAX_NR_ZONES
+};
+
+#define MAX_NR_ZONES __MAX_NR_ZONES
+#define MAX_PAGE_ORDER 10
+#define MAX_ORDER_NR_PAGES (1 << MAX_PAGE_ORDER)
+
+#define pageblock_order		MAX_PAGE_ORDER
+#define pageblock_nr_pages	BIT(pageblock_order)
+#define pageblock_align(pfn)	ALIGN((pfn), pageblock_nr_pages)
+#define pageblock_start_pfn(pfn)	ALIGN_DOWN((pfn), pageblock_nr_pages)
+
+struct zone {
+	atomic_long_t		managed_pages;
+};
+
+typedef struct pglist_data {
+	struct zone node_zones[MAX_NR_ZONES];
+
+} pg_data_t;
+
+#endif /* _LINUX_MMZONE_H */
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
new file mode 100644
index 000000000000..48e033c60d87
--- /dev/null
+++ b/tools/testing/vma/vma.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "maple-shared.h"
+#include "vma_internal.h"
+
+/*
+ * Directly import the VMA implementation here. Our vma_internal.h wrapper
+ * provides userland-equivalent functionality for everything vma.c uses.
+ */
+#include "../../../mm/vma.c"
+
+const struct vm_operations_struct vma_dummy_vm_ops;
+
+#define ASSERT_TRUE(_expr)						\
+	do {								\
+		if (!(_expr)) {						\
+			fprintf(stderr,					\
+				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
+				__FILE__, __LINE__, __FUNCTION__, #_expr); \
+			return false;					\
+		}							\
+	} while (0)
+#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
+#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
+#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
+
+static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
+					unsigned long start,
+					unsigned long end,
+					pgoff_t pgoff,
+					vm_flags_t flags)
+{
+	struct vm_area_struct *ret = vm_area_alloc(mm);
+
+	if (ret == NULL)
+		return NULL;
+
+	ret->vm_start = start;
+	ret->vm_end = end;
+	ret->vm_pgoff = pgoff;
+	ret->__vm_flags = flags;
+
+	return ret;
+}
+
+static bool test_simple_merge(void)
+{
+	struct vm_area_struct *vma;
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	struct vm_area_struct *vma_left = alloc_vma(&mm, 0, 0x1000, 0, flags);
+	struct vm_area_struct *vma_middle = alloc_vma(&mm, 0x1000, 0x2000, 1, flags);
+	struct vm_area_struct *vma_right = alloc_vma(&mm, 0x2000, 0x3000, 2, flags);
+	VMA_ITERATOR(vmi, &mm, 0x1000);
+
+	ASSERT_FALSE(vma_link(&mm, vma_left));
+	ASSERT_FALSE(vma_link(&mm, vma_middle));
+	ASSERT_FALSE(vma_link(&mm, vma_right));
+
+	vma = vma_merge_new_vma(&vmi, vma_left, vma_middle, 0x1000,
+				0x2000, 1);
+	ASSERT_NE(vma, NULL);
+
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x3000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->vm_flags, flags);
+
+	vm_area_free(vma);
+	mtree_destroy(&mm.mm_mt);
+
+	return true;
+}
+
+static bool test_simple_modify(void)
+{
+	struct vm_area_struct *vma;
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	struct vm_area_struct *init_vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
+	VMA_ITERATOR(vmi, &mm, 0x1000);
+
+	ASSERT_FALSE(vma_link(&mm, init_vma));
+
+	/*
+	 * The flags will not be changed, the vma_modify_flags() function
+	 * performs the merge/split only.
+	 */
+	vma = vma_modify_flags(&vmi, init_vma, init_vma,
+			       0x1000, 0x2000, VM_READ | VM_MAYREAD);
+	ASSERT_NE(vma, NULL);
+	/* We modify the provided VMA, and on split allocate new VMAs. */
+	ASSERT_EQ(vma, init_vma);
+
+	ASSERT_EQ(vma->vm_start, 0x1000);
+	ASSERT_EQ(vma->vm_end, 0x2000);
+	ASSERT_EQ(vma->vm_pgoff, 1);
+
+	/*
+	 * Now walk through the three split VMAs and make sure they are as
+	 * expected.
+	 */
+
+	vma_iter_set(&vmi, 0);
+	vma = vma_iter_load(&vmi);
+
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x1000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+
+	vm_area_free(vma);
+	vma_iter_clear(&vmi);
+
+	vma = vma_next(&vmi);
+
+	ASSERT_EQ(vma->vm_start, 0x1000);
+	ASSERT_EQ(vma->vm_end, 0x2000);
+	ASSERT_EQ(vma->vm_pgoff, 1);
+
+	vm_area_free(vma);
+	vma_iter_clear(&vmi);
+
+	vma = vma_next(&vmi);
+
+	ASSERT_EQ(vma->vm_start, 0x2000);
+	ASSERT_EQ(vma->vm_end, 0x3000);
+	ASSERT_EQ(vma->vm_pgoff, 2);
+
+	vm_area_free(vma);
+	mtree_destroy(&mm.mm_mt);
+
+	return true;
+}
+
+static bool test_simple_expand(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x1000, 0, flags);
+	VMA_ITERATOR(vmi, &mm, 0);
+
+	ASSERT_FALSE(vma_link(&mm, vma));
+
+	ASSERT_FALSE(vma_expand(&vmi, vma, 0, 0x3000, 0, NULL));
+
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x3000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+
+	vm_area_free(vma);
+	mtree_destroy(&mm.mm_mt);
+
+	return true;
+}
+
+static bool test_simple_shrink(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
+	VMA_ITERATOR(vmi, &mm, 0);
+
+	ASSERT_FALSE(vma_link(&mm, vma));
+
+	ASSERT_FALSE(vma_shrink(&vmi, vma, 0, 0x1000, 0));
+
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x1000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+
+	vm_area_free(vma);
+	mtree_destroy(&mm.mm_mt);
+
+	return true;
+}
+
+int main(void)
+{
+	int num_tests = 0, num_fail = 0;
+
+	maple_tree_init();
+
+#define TEST(name)							\
+	do {								\
+		num_tests++;						\
+		if (!test_##name()) {					\
+			num_fail++;					\
+			fprintf(stderr, "Test " #name " FAILED\n");	\
+		}							\
+	} while (0)
+
+	TEST(simple_merge);
+	TEST(simple_modify);
+	TEST(simple_expand);
+	TEST(simple_shrink);
+
+#undef TEST
+
+	printf("%d tests run, %d passed, %d failed.\n",
+	       num_tests, num_tests - num_fail, num_fail);
+
+	return num_fail == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
+}
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
new file mode 100644
index 000000000000..093560e5b2ac
--- /dev/null
+++ b/tools/testing/vma/vma_internal.h
@@ -0,0 +1,882 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * vma_internal.h
+ *
+ * Header providing userland wrappers and shims for the functionality provided
+ * by mm/vma_internal.h.
+ *
+ * We make the header guard the same as mm/vma_internal.h, so if this shim
+ * header is included, it precludes the inclusion of the kernel one.
+ */
+
+#ifndef __MM_VMA_INTERNAL_H
+#define __MM_VMA_INTERNAL_H
+
+#define __private
+#define __bitwise
+#define __randomize_layout
+
+#define CONFIG_MMU
+#define CONFIG_PER_VMA_LOCK
+
+#include <stdlib.h>
+
+#include <linux/list.h>
+#include <linux/maple_tree.h>
+#include <linux/mm.h>
+#include <linux/rbtree.h>
+#include <linux/rwsem.h>
+
+#define VM_WARN_ON(_expr) (WARN_ON(_expr))
+#define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
+#define VM_BUG_ON(_expr) (BUG_ON(_expr))
+#define VM_BUG_ON_VMA(_expr, _vma) (BUG_ON(_expr))
+
+#define VM_NONE		0x00000000
+#define VM_READ		0x00000001
+#define VM_WRITE	0x00000002
+#define VM_EXEC		0x00000004
+#define VM_SHARED	0x00000008
+#define VM_MAYREAD	0x00000010
+#define VM_MAYWRITE	0x00000020
+#define VM_GROWSDOWN	0x00000100
+#define VM_PFNMAP	0x00000400
+#define VM_LOCKED	0x00002000
+#define VM_IO           0x00004000
+#define VM_DONTEXPAND	0x00040000
+#define VM_ACCOUNT	0x00100000
+#define VM_MIXEDMAP	0x10000000
+#define VM_STACK	VM_GROWSDOWN
+#define VM_SHADOW_STACK	VM_NONE
+#define VM_SOFTDIRTY	0
+
+#define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
+#define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
+
+#define FIRST_USER_ADDRESS	0UL
+#define USER_PGTABLES_CEILING	0UL
+
+#define vma_policy(vma) NULL
+
+#define down_write_nest_lock(sem, nest_lock)
+
+#define pgprot_val(x)		((x).pgprot)
+#define __pgprot(x)		((pgprot_t) { (x) } )
+
+#define for_each_vma(__vmi, __vma)					\
+	while (((__vma) = vma_next(&(__vmi))) != NULL)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(__vmi, __vma, __end)				\
+	while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)
+
+#define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
+
+#define PHYS_PFN(x)	((unsigned long)((x) >> PAGE_SHIFT))
+
+#define test_and_set_bit(nr, addr) __test_and_set_bit(nr, addr)
+#define test_and_clear_bit(nr, addr) __test_and_clear_bit(nr, addr)
+
+#define TASK_SIZE ((1ul << 47)-PAGE_SIZE)
+
+#define AS_MM_ALL_LOCKS 2
+
+#define current NULL
+
+/* We hardcode this for now. */
+#define sysctl_max_map_count 0x1000000UL
+
+#define pgoff_t unsigned long
+typedef unsigned long	pgprotval_t;
+typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
+typedef unsigned long vm_flags_t;
+typedef __bitwise unsigned int vm_fault_t;
+
+typedef struct refcount_struct {
+	atomic_t refs;
+} refcount_t;
+
+struct kref {
+	refcount_t refcount;
+};
+
+struct anon_vma {
+	struct anon_vma *root;
+	struct rb_root_cached rb_root;
+};
+
+struct anon_vma_chain {
+	struct anon_vma *anon_vma;
+	struct list_head same_vma;
+};
+
+struct anon_vma_name {
+	struct kref kref;
+	/* The name needs to be at the end because it is dynamically sized. */
+	char name[];
+};
+
+struct vma_iterator {
+	struct ma_state mas;
+};
+
+#define VMA_ITERATOR(name, __mm, __addr)				\
+	struct vma_iterator name = {					\
+		.mas = {						\
+			.tree = &(__mm)->mm_mt,				\
+			.index = __addr,				\
+			.node = NULL,					\
+			.status = ma_start,				\
+		},							\
+	}
+
+struct address_space {
+	struct rb_root_cached	i_mmap;
+	unsigned long		flags;
+	atomic_t		i_mmap_writable;
+};
+
+struct vm_userfaultfd_ctx {};
+struct mempolicy {};
+struct mmu_gather {};
+struct mutex {};
+#define DEFINE_MUTEX(mutexname) \
+	struct mutex mutexname = {}
+
+struct mm_struct {
+	struct maple_tree mm_mt;
+	int map_count;			/* number of VMAs */
+	unsigned long total_vm;	   /* Total pages mapped */
+	unsigned long locked_vm;   /* Pages that have PG_mlocked set */
+	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
+	unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
+	unsigned long stack_vm;	   /* VM_STACK */
+};
+
+struct vma_lock {
+	struct rw_semaphore lock;
+};
+
+
+struct file {
+	struct address_space	*f_mapping;
+};
+
+struct vm_area_struct {
+	/* The first cache line has the info for VMA tree walking. */
+
+	union {
+		struct {
+			/* VMA covers [vm_start; vm_end) addresses within mm */
+			unsigned long vm_start;
+			unsigned long vm_end;
+		};
+#ifdef CONFIG_PER_VMA_LOCK
+		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
+#endif
+	};
+
+	struct mm_struct *vm_mm;	/* The address space we belong to. */
+	pgprot_t vm_page_prot;          /* Access permissions of this VMA. */
+
+	/*
+	 * Flags, see mm.h.
+	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
+	 */
+	union {
+		const vm_flags_t vm_flags;
+		vm_flags_t __private __vm_flags;
+	};
+
+#ifdef CONFIG_PER_VMA_LOCK
+	/* Flag to indicate areas detached from the mm->mm_mt tree */
+	bool detached;
+
+	/*
+	 * Can only be written (using WRITE_ONCE()) while holding both:
+	 *  - mmap_lock (in write mode)
+	 *  - vm_lock->lock (in write mode)
+	 * Can be read reliably while holding one of:
+	 *  - mmap_lock (in read or write mode)
+	 *  - vm_lock->lock (in read or write mode)
+	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
+	 * while holding nothing (except RCU to keep the VMA struct allocated).
+	 *
+	 * This sequence counter is explicitly allowed to overflow; sequence
+	 * counter reuse can only lead to occasional unnecessary use of the
+	 * slowpath.
+	 */
+	int vm_lock_seq;
+	struct vma_lock *vm_lock;
+#endif
+
+	/*
+	 * For areas with an address space and backing store,
+	 * linkage into the address_space->i_mmap interval tree.
+	 *
+	 */
+	struct {
+		struct rb_node rb;
+		unsigned long rb_subtree_last;
+	} shared;
+
+	/*
+	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
+	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
+	 * can only be in the i_mmap tree.  An anonymous MAP_PRIVATE, stack
+	 * or brk vma (with NULL file) can only be in an anon_vma list.
+	 */
+	struct list_head anon_vma_chain; /* Serialized by mmap_lock &
+					  * page_table_lock */
+	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
+
+	/* Function pointers to deal with this struct. */
+	const struct vm_operations_struct *vm_ops;
+
+	/* Information about our backing store: */
+	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
+					   units */
+	struct file * vm_file;		/* File we map to (can be NULL). */
+	void * vm_private_data;		/* was vm_pte (shared mem) */
+
+#ifdef CONFIG_ANON_VMA_NAME
+	/*
+	 * For private and shared anonymous mappings, a pointer to a null
+	 * terminated string containing the name given to the vma, or NULL if
+	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
+	 */
+	struct anon_vma_name *anon_name;
+#endif
+#ifdef CONFIG_SWAP
+	atomic_long_t swap_readahead_info;
+#endif
+#ifndef CONFIG_MMU
+	struct vm_region *vm_region;	/* NOMMU mapping region */
+#endif
+#ifdef CONFIG_NUMA
+	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
+#endif
+	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+} __randomize_layout;
+
+struct vm_fault {};
+
+struct vm_operations_struct {
+	void (*open)(struct vm_area_struct * area);
+	/**
+	 * @close: Called when the VMA is being removed from the MM.
+	 * Context: User context.  May sleep.  Caller holds mmap_lock.
+	 */
+	void (*close)(struct vm_area_struct * area);
+	/* Called any time before splitting to check if it's allowed */
+	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
+	int (*mremap)(struct vm_area_struct *area);
+	/*
+	 * Called by mprotect() to make driver-specific permission
+	 * checks before mprotect() is finalised.   The VMA must not
+	 * be modified.  Returns 0 if mprotect() can proceed.
+	 */
+	int (*mprotect)(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, unsigned long newflags);
+	vm_fault_t (*fault)(struct vm_fault *vmf);
+	vm_fault_t (*huge_fault)(struct vm_fault *vmf, unsigned int order);
+	vm_fault_t (*map_pages)(struct vm_fault *vmf,
+			pgoff_t start_pgoff, pgoff_t end_pgoff);
+	unsigned long (*pagesize)(struct vm_area_struct * area);
+
+	/* notification that a previously read-only page is about to become
+	 * writable, if an error is returned it will cause a SIGBUS */
+	vm_fault_t (*page_mkwrite)(struct vm_fault *vmf);
+
+	/* same as page_mkwrite when using VM_PFNMAP|VM_MIXEDMAP */
+	vm_fault_t (*pfn_mkwrite)(struct vm_fault *vmf);
+
+	/* called by access_process_vm when get_user_pages() fails, typically
+	 * for use by special VMAs. See also generic_access_phys() for a generic
+	 * implementation useful for any iomem mapping.
+	 */
+	int (*access)(struct vm_area_struct *vma, unsigned long addr,
+		      void *buf, int len, int write);
+
+	/* Called by the /proc/PID/maps code to ask the vma whether it
+	 * has a special name.  Returning non-NULL will also cause this
+	 * vma to be dumped unconditionally. */
+	const char *(*name)(struct vm_area_struct *vma);
+
+#ifdef CONFIG_NUMA
+	/*
+	 * set_policy() op must add a reference to any non-NULL @new mempolicy
+	 * to hold the policy upon return.  Caller should pass NULL @new to
+	 * remove a policy and fall back to surrounding context--i.e. do not
+	 * install a MPOL_DEFAULT policy, nor the task or system default
+	 * mempolicy.
+	 */
+	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
+
+	/*
+	 * get_policy() op must add reference [mpol_get()] to any policy at
+	 * (vma,addr) marked as MPOL_SHARED.  The shared policy infrastructure
+	 * in mm/mempolicy.c will do this automatically.
+	 * get_policy() must NOT add a ref if the policy at (vma,addr) is not
+	 * marked as MPOL_SHARED. vma policies are protected by the mmap_lock.
+	 * If no [shared/vma] mempolicy exists at the addr, get_policy() op
+	 * must return NULL--i.e., do not "fallback" to task or system default
+	 * policy.
+	 */
+	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
+					unsigned long addr, pgoff_t *ilx);
+#endif
+	/*
+	 * Called by vm_normal_page() for special PTEs to find the
+	 * page for @addr.  This is useful if the default behavior
+	 * (using pte_page()) would not find the correct page.
+	 */
+	struct page *(*find_special_page)(struct vm_area_struct *vma,
+					  unsigned long addr);
+};
+
+static inline void vma_iter_invalidate(struct vma_iterator *vmi)
+{
+	mas_pause(&vmi->mas);
+}
+
+static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
+{
+	return __pgprot(pgprot_val(oldprot) | pgprot_val(newprot));
+}
+
+static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	return __pgprot(vm_flags);
+}
+
+static inline bool is_shared_maywrite(vm_flags_t vm_flags)
+{
+	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
+		(VM_SHARED | VM_MAYWRITE);
+}
+
+static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+{
+	return is_shared_maywrite(vma->vm_flags);
+}
+
+static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
+{
+	/*
+	 * Uses mas_find() to get the first VMA when the iterator starts.
+	 * Calling mas_next() could skip the first entry.
+	 */
+	return mas_find(&vmi->mas, ULONG_MAX);
+}
+
+static inline bool vma_lock_alloc(struct vm_area_struct *vma)
+{
+	vma->vm_lock = calloc(1, sizeof(struct vma_lock));
+
+	if (!vma->vm_lock)
+		return false;
+
+	init_rwsem(&vma->vm_lock->lock);
+	vma->vm_lock_seq = -1;
+
+	return true;
+}
+
+static inline void vma_assert_write_locked(struct vm_area_struct *);
+static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
+{
+	/* When detaching vma should be write-locked */
+	if (detached)
+		vma_assert_write_locked(vma);
+	vma->detached = detached;
+}
+
+extern const struct vm_operations_struct vma_dummy_vm_ops;
+
+static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
+{
+	memset(vma, 0, sizeof(*vma));
+	vma->vm_mm = mm;
+	vma->vm_ops = &vma_dummy_vm_ops;
+	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma_mark_detached(vma, false);
+}
+
+static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma = calloc(1, sizeof(struct vm_area_struct));
+
+	if (!vma)
+		return NULL;
+
+	vma_init(vma, mm);
+	if (!vma_lock_alloc(vma)) {
+		free(vma);
+		return NULL;
+	}
+
+	return vma;
+}
+
+static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
+{
+	struct vm_area_struct *new = calloc(1, sizeof(struct vm_area_struct));
+
+	if (!new)
+		return NULL;
+
+	memcpy(new, orig, sizeof(*new));
+	if (!vma_lock_alloc(new)) {
+		free(new);
+		return NULL;
+	}
+	INIT_LIST_HEAD(&new->anon_vma_chain);
+
+	return new;
+}
+
+/*
+ * These are defined in vma.h, but sadly vm_stat_account() is referenced by
+ * kernel/fork.c, so we have to these broadly available there, and temporarily
+ * define them here to resolve the dependency cycle.
+ */
+
+#define is_exec_mapping(flags) \
+	((flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC)
+
+#define is_stack_mapping(flags) \
+	(((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK))
+
+#define is_data_mapping(flags) \
+	((flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE)
+
+static inline void vm_stat_account(struct mm_struct *mm, vm_flags_t flags,
+				   long npages)
+{
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm)+npages);
+
+	if (is_exec_mapping(flags))
+		mm->exec_vm += npages;
+	else if (is_stack_mapping(flags))
+		mm->stack_vm += npages;
+	else if (is_data_mapping(flags))
+		mm->data_vm += npages;
+}
+
+#undef is_exec_mapping
+#undef is_stack_mapping
+#undef is_data_mapping
+
+/* Currently stubbed but we may later wish to un-stub. */
+static inline void vm_acct_memory(long pages);
+static inline void vm_unacct_memory(long pages)
+{
+	vm_acct_memory(-pages);
+}
+
+static inline void mapping_allow_writable(struct address_space *mapping)
+{
+	atomic_inc(&mapping->i_mmap_writable);
+}
+
+static inline void vma_set_range(struct vm_area_struct *vma,
+				 unsigned long start, unsigned long end,
+				 pgoff_t pgoff)
+{
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+}
+
+static inline
+struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
+{
+	return mas_find(&vmi->mas, max - 1);
+}
+
+static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
+			unsigned long start, unsigned long end, gfp_t gfp)
+{
+	__mas_set_range(&vmi->mas, start, end - 1);
+	mas_store_gfp(&vmi->mas, NULL, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void mmap_assert_locked(struct mm_struct *);
+static inline struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+						unsigned long start_addr,
+						unsigned long end_addr)
+{
+	unsigned long index = start_addr;
+
+	mmap_assert_locked(mm);
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
+}
+
+static inline
+struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
+{
+	return mtree_load(&mm->mm_mt, addr);
+}
+
+static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
+{
+	return mas_prev(&vmi->mas, 0);
+}
+
+static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
+{
+	mas_set(&vmi->mas, addr);
+}
+
+static inline bool vma_is_anonymous(struct vm_area_struct *vma)
+{
+	return !vma->vm_ops;
+}
+
+/* Defined in vma.h, so temporarily define here to avoid circular dependency. */
+#define vma_iter_load(vmi) \
+	mas_walk(&(vmi)->mas)
+
+static inline struct vm_area_struct *
+find_vma_prev(struct mm_struct *mm, unsigned long addr,
+			struct vm_area_struct **pprev)
+{
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
+
+	vma = vma_iter_load(&vmi);
+	*pprev = vma_prev(&vmi);
+	if (!vma)
+		vma = vma_next(&vmi);
+	return vma;
+}
+
+#undef vma_iter_load
+
+static inline void vma_iter_init(struct vma_iterator *vmi,
+		struct mm_struct *mm, unsigned long addr)
+{
+	mas_init(&vmi->mas, &mm->mm_mt, addr);
+}
+
+/* Stubbed functions. */
+
+static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
+static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
+					struct vm_userfaultfd_ctx vm_ctx)
+{
+	return true;
+}
+
+static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
+				    struct anon_vma_name *anon_name2)
+{
+	return true;
+}
+
+static inline void might_sleep(void)
+{
+}
+
+static inline unsigned long vma_pages(struct vm_area_struct *vma)
+{
+	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+}
+
+static inline void fput(struct file *)
+{
+}
+
+static inline void mpol_put(struct mempolicy *)
+{
+}
+
+static inline void vma_lock_free(struct vm_area_struct *vma)
+{
+	free(vma->vm_lock);
+}
+
+static inline void __vm_area_free(struct vm_area_struct *vma)
+{
+	vma_lock_free(vma);
+	free(vma);
+}
+
+static inline void vm_area_free(struct vm_area_struct *vma)
+{
+	__vm_area_free(vma);
+}
+
+static inline void lru_add_drain(void)
+{
+}
+
+static inline void tlb_gather_mmu(struct mmu_gather *, struct mm_struct *)
+{
+}
+
+static inline void update_hiwater_rss(struct mm_struct *)
+{
+}
+
+static inline void update_hiwater_vm(struct mm_struct *)
+{
+}
+
+static inline void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
+		      struct vm_area_struct *vma, unsigned long start_addr,
+		      unsigned long end_addr, unsigned long tree_end,
+		      bool mm_wr_locked)
+{
+	(void)tlb;
+	(void)mas;
+	(void)vma;
+	(void)start_addr;
+	(void)end_addr;
+	(void)tree_end;
+	(void)mm_wr_locked;
+}
+
+static inline void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
+		   struct vm_area_struct *vma, unsigned long floor,
+		   unsigned long ceiling, bool mm_wr_locked)
+{
+	(void)tlb;
+	(void)mas;
+	(void)vma;
+	(void)floor;
+	(void)ceiling;
+	(void)mm_wr_locked;
+}
+
+static inline void mapping_unmap_writable(struct address_space *)
+{
+}
+
+static inline void flush_dcache_mmap_lock(struct address_space *)
+{
+}
+
+static inline void tlb_finish_mmu(struct mmu_gather *)
+{
+}
+
+static inline void get_file(struct file *)
+{
+}
+
+static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct *)
+{
+	return 0;
+}
+
+static inline int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *)
+{
+	return 0;
+}
+
+static inline void vma_start_write(struct vm_area_struct *)
+{
+}
+
+static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
+					 unsigned long start,
+					 unsigned long end,
+					 long adjust_next)
+{
+	(void)vma;
+	(void)start;
+	(void)end;
+	(void)adjust_next;
+}
+
+static inline void vma_iter_free(struct vma_iterator *vmi)
+{
+	mas_destroy(&vmi->mas);
+}
+
+static inline void vm_acct_memory(long pages)
+{
+}
+
+static inline void vma_interval_tree_insert(struct vm_area_struct *,
+					    struct rb_root_cached *)
+{
+}
+
+static inline void vma_interval_tree_remove(struct vm_area_struct *,
+					    struct rb_root_cached *)
+{
+}
+
+static inline void flush_dcache_mmap_unlock(struct address_space *)
+{
+}
+
+static inline void anon_vma_interval_tree_insert(struct anon_vma_chain*,
+						 struct rb_root_cached *)
+{
+}
+
+static inline void anon_vma_interval_tree_remove(struct anon_vma_chain*,
+						 struct rb_root_cached *)
+{
+}
+
+static inline void uprobe_mmap(struct vm_area_struct *)
+{
+}
+
+static inline void uprobe_munmap(struct vm_area_struct *vma,
+				 unsigned long start, unsigned long end)
+{
+	(void)vma;
+	(void)start;
+	(void)end;
+}
+
+static inline void i_mmap_lock_write(struct address_space *)
+{
+}
+
+static inline void anon_vma_lock_write(struct anon_vma *)
+{
+}
+
+static inline void vma_assert_write_locked(struct vm_area_struct *)
+{
+}
+
+static inline void unlink_anon_vmas(struct vm_area_struct *)
+{
+}
+
+static inline void anon_vma_unlock_write(struct anon_vma *)
+{
+}
+
+static inline void i_mmap_unlock_write(struct address_space *)
+{
+}
+
+static inline void anon_vma_merge(struct vm_area_struct *,
+				  struct vm_area_struct *)
+{
+}
+
+static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
+					 unsigned long start,
+					 unsigned long end,
+					 struct list_head *unmaps)
+{
+	(void)vma;
+	(void)start;
+	(void)end;
+	(void)unmaps;
+
+	return 0;
+}
+
+static inline void mmap_write_downgrade(struct mm_struct *)
+{
+}
+
+static inline void mmap_read_unlock(struct mm_struct *)
+{
+}
+
+static inline void mmap_write_unlock(struct mm_struct *)
+{
+}
+
+static inline bool can_modify_mm(struct mm_struct *mm,
+				 unsigned long start,
+				 unsigned long end)
+{
+	(void)mm;
+	(void)start;
+	(void)end;
+
+	return true;
+}
+
+static inline void arch_unmap(struct mm_struct *mm,
+				 unsigned long start,
+				 unsigned long end)
+{
+	(void)mm;
+	(void)start;
+	(void)end;
+}
+
+static inline void mmap_assert_locked(struct mm_struct *)
+{
+}
+
+static inline bool mpol_equal(struct mempolicy *, struct mempolicy *)
+{
+	return true;
+}
+
+static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
+			  unsigned long vm_flags)
+{
+	(void)vma;
+	(void)vm_flags;
+}
+
+static inline bool mapping_can_writeback(struct address_space *)
+{
+	return true;
+}
+
+static inline bool is_vm_hugetlb_page(struct vm_area_struct *)
+{
+	return false;
+}
+
+static inline bool vma_soft_dirty_enabled(struct vm_area_struct *)
+{
+	return false;
+}
+
+static inline bool userfaultfd_wp(struct vm_area_struct *)
+{
+	return false;
+}
+
+static inline void mmap_assert_write_locked(struct mm_struct *)
+{
+}
+
+static inline void mutex_lock(struct mutex *)
+{
+}
+
+static inline void mutex_unlock(struct mutex *)
+{
+}
+
+static inline bool mutex_is_locked(struct mutex *)
+{
+	return true;
+}
+
+static inline bool signal_pending(void *)
+{
+	return false;
+}
+
+#endif	/* __MM_VMA_INTERNAL_H */
-- 
2.45.2


