Return-Path: <linux-fsdevel+bounces-30332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43A1989E05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 11:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9F41C2177A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 09:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DF118A6D2;
	Mon, 30 Sep 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y5EaH20o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mks+zvzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3756188007;
	Mon, 30 Sep 2024 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688187; cv=fail; b=n7gzsqbkA+rEVbEf4yZH5CXyRtd2ywUkS6bKd+dslNXpU0vYs2q1zM21KydkgPqVcilyWLduvKxxcPAJzRoR+tXOfkPlkem0BQDxm84L/cqpGmRPd4vfnHJ9oJMIUP4/wKt/7w6YzUYQ/tpGT1C97xeLrkkt/KAMuAA09a3TiZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688187; c=relaxed/simple;
	bh=MII/7zPyndC+HuFHW/rwxPxvph7oEY2jKp40Wls50f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BjjPX/K4f8/ciWnIPEYj14G88GZP6wHeWTHnu49H3q4+jpXJcqB3pP8K9NcczkFszHOKPGBYgC+jX9O0YZbKbWOLLfwT7j7Rrs93JzxXZ53eC2MMatSmEg/FdzRvwQ4e0bB+EWnwDKlgIcx/pijR01kiG0rtKBaDiB+u7gS38GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y5EaH20o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mks+zvzN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2tsUQ014360;
	Mon, 30 Sep 2024 09:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=uy94UiJFBw073KsMcbu3zT/X9YDvCxHNCZOFkRHDofQ=; b=
	Y5EaH20oOMJfnWFMv/azEi7SIku0JZT63iRt+3JFIb1M03tqzU/rx4RHJ8BIw5/v
	mHBN/6VY1zvX2fbVLHG+m4UMVdDs6LuQus7DmvuHde5kjgAkptQhclpJCZTWtUpB
	Hd1xxS9hyShSX8kp+pJiD46N4ZyvkSGknvHKwKRL/y4iYycQ90/s65W2ZCGVQ8wb
	IVAkB8OyMYnbVN4kaBVXSKctt6hh1jKH4EUwqgJJ/7P44WRcn4aM4ISFA3auDn+Z
	Vs1tettVPsGwcolXUqilJ0czpaG6RF9jg1m639dI3HhfnktaFXJVT08JmS0attDg
	M0ym2g1F0myrAPlXh8D3UQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qb2tu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 09:22:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48U7EUO6038677;
	Mon, 30 Sep 2024 09:22:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x885t06h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 09:22:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OC258i8IiXuaStkK19/nFGiloCv+S8r+9JrNJo6Ivi3YHIyEAs4c+e7GESJKvtEH7zuXPGg6l6anh5S6ui7n+hwTx/vZ/8LWRwBoEboT0DOvfsirJmbR9FExckcqntRPh74X7KAJa2AeLNEbxJCImqVE2myCx1W/DM2sRfxDHirJEX9N5vYCC2r+4vgj7jHR3CQjJJH8/91hS+BZcJNC/c4kXzHdHxcHdSbZ9Dj/kNtZi8CBjN+kI3msfdIHX2ww5iR1+cth/uYWGcpCH0vW3BJXsfdK80FEoJlV9rukv1WvWdkTvpXQgZp5L8YQFqaFFYXa4ZUcTqUQjJmQMWJ6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy94UiJFBw073KsMcbu3zT/X9YDvCxHNCZOFkRHDofQ=;
 b=eXQXhx4tLt0Ia/bVzfLS7AyiGOqw/pbaU9YCDCekL0rs4mwml0cIG7Wrwp+eICgc92P2lXL3OiGWMRzEvDhtle8d6YUxeItIhVJhwGN9+LpeJJ5yvBC2jGfNXnqTFROaiUGeKrnOvORJlYAr+rjbH5iH6BMGKESFKCKGP5JT5k88CTNy7nPSfEcuGSNeSSc5UntBpEQC+RPHTPrtGNtldY+F1OIDsShcLfQjpNmworobguGdR7jIuCpnMbvpF/SQNNko+liUt3B4PCkU2luq+/w1io6lDJeHOX8Q2OktLlYr5LW/OZs9HnP38rhosKWm4N7lrM3+B29hextOdiGrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy94UiJFBw073KsMcbu3zT/X9YDvCxHNCZOFkRHDofQ=;
 b=Mks+zvzNWE28uBxbK6rdaDk8SPtYlm1MtqQpTgVgY75LzsgzR36hY0vuuCY/bRUMnjVI4+tGHz6NqAKVahNN6HIxNlrj6uG1uBN9bI/I9uUxFnxCt3iUsc0fXf0mYsDDBIIjqDPxX+JnEjoBnKnfROutMRIvNG2mZ/roSjpr8Rc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA6PR10MB8134.namprd10.prod.outlook.com (2603:10b6:806:443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 09:22:50 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Mon, 30 Sep 2024
 09:22:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] selftests: pidfd: add tests for PIDFD_SELF
Date: Mon, 30 Sep 2024 10:22:30 +0100
Message-ID: <12dc5760f45f8c90f57be43e6f29f1ded473053a.1727644404.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
References: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::28) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA6PR10MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 77556be3-efde-4e9d-ab3c-08dce1317450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oi2ounY953a2r7Wnsy0h4tCssbH9vf7c0NKrrVunLtXv71mgXHrINa8r2LFq?=
 =?us-ascii?Q?VWCaSGjvfLoFFQ+4uda9OA8GP5HHvcu8jfAatsZvXMswTWPJ8EVe6qfcwypC?=
 =?us-ascii?Q?NSxhiGlOphRhbPFjdTY51oeP/PXdUWiRY99L/cDm7iRTKXugjPP+58sYXPfQ?=
 =?us-ascii?Q?3E6sKz42nvQDTR/Fhhxjvymy4iMkWxrf9kSikgpqHLuP62r+hSkp9/0lG8zR?=
 =?us-ascii?Q?qLmzSmDLl8bt/rm2O8Q1jpIyZmnrwx+hdxjJXlwoR1sNF8/wcFHWChC+Lcst?=
 =?us-ascii?Q?afeRwiqa3HlAb1fvBm4HY/j22VkMHGfLWWDJPVRwzZFo8x5Ky4+RKXPU3Acw?=
 =?us-ascii?Q?F8tn9GrNMbkqQUDuzfZ5tgK2ALMtW9igVFQZFIc4GM49GZ5SLSHtgxMMQMgs?=
 =?us-ascii?Q?765b7QINzY3ZgTHXK86MblXQhWVml+AZQQDNsRg4DBibdPopsO6MUrn2Oo3/?=
 =?us-ascii?Q?N8yuuVJrd2TUsZwzgUN8Oa8DsUkYCcGj4vGrxKF7s7U20obzrmYU4/MiTPui?=
 =?us-ascii?Q?r4wNckXtbdA7YdXeb59/bvyObqNrys5vhBOQKg7wX+ic6C3w4HGZL0hSl2Zj?=
 =?us-ascii?Q?EPDYZbev/5Cy4J2XJsvEsRk3JqqvNRN3msFV3Mf9zdKjAOrhhZ/An0Od6dxB?=
 =?us-ascii?Q?1lsjR1He+8K8NzZjXWsltvVbEyRjj8ObWkVZVwdLB6PJ4emLEh1px0YIQb9n?=
 =?us-ascii?Q?xWX+EglmZFgNEBzWwNGuDzZsl4d14HW/8WeoSXEbNm2VEDV/XbjDeTGcj3dL?=
 =?us-ascii?Q?5uGmVnYTBMoT+z0L0YC6fDmEwgeZK25cXt4W0+GWg2d4JosqdbRwmDHg+XHC?=
 =?us-ascii?Q?AQwrL380fFvkZJI02DOg+lXrVxglaC5wKm+jmX4OLi0U55yx3yv/norFq5rb?=
 =?us-ascii?Q?dxe/MKP1LMnZaoMP6q5qDTTRC1sFxnsZtdY6tYV2qqYzBGmkdj/u2SG+bu5A?=
 =?us-ascii?Q?dvNs/MMZdVrUR0Rd0FeqDKXddwPQgqDs8ab14sZ0taE1rKIfEWRLYmBaiXrT?=
 =?us-ascii?Q?46yexo5NR1PCH8Y2BNotjlz2/f7vBMUGUhkSARN8lO0GU2mztrbTFo04RM/p?=
 =?us-ascii?Q?uQrYSzfndlthLho+LHzmdhxdeEERZApkZf8zyPBpWhEpC1758eCCkjystm6h?=
 =?us-ascii?Q?bdCOnJobvH71ThZYbiEThpmhhehFNeXqhqQf+9zo07iH5l4yQG0QUgKK5vDk?=
 =?us-ascii?Q?oKeSFZl5GfwTljSX3aR9stMSmnr4nhmk5f8ogcjJm7aGwy2QWRS9HRTSQqp8?=
 =?us-ascii?Q?JhbU4ddzTf8E4sBJUIqYAy8JO7pxr2FSjy22RpnS7k6ceo+mJslgQBlj48ig?=
 =?us-ascii?Q?g39fNXfqGP2v/leRE2xXXi91/jLEPzQcVpvlMdwJG8DAOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cjJ7ffILrrNeOYTWs8JkEt0xurHrC5nSgFjLjPU+9nzThy8dgGc8Y8oQqCZm?=
 =?us-ascii?Q?h0kiTPm5I8UMFbwXrnsP4PNzDis9I4mcqlQhHhxudEAoj1HVF9N0b/fdKBJb?=
 =?us-ascii?Q?c2qhsPiyMNtCV7zmpWaqgKTalhaKqf4GGZTacdkMd4jvOp1zVw8VVoekvofp?=
 =?us-ascii?Q?YcKcHCPuNUdJ6BtK8YCTiumQI8TqdVqWcxfhNzfw3uW6Qc/1smtsdmpOqWPu?=
 =?us-ascii?Q?7qQ2yr1WZq5Jmcl6+wehphrGIhraBdlym+7zzIY0PNifKrXjqqzckLBng3Lf?=
 =?us-ascii?Q?ODo5ZtkoxMkhtsgN4Y4qUpw39G5v4tF5p8/oSWFTC6quISOz7icH/Iy5O/Xl?=
 =?us-ascii?Q?iCnmwP8qvu3KVOSL8X/9N0Rbnqoymi6mxM45nSeScUXe4SiMxAQQyGViNLIF?=
 =?us-ascii?Q?KbkcWHVMcOMh5yMl5dCJZCytliw9lWahcDH1IwgTfzBUbwjLQbJ5U6WGoezi?=
 =?us-ascii?Q?UhWAIRn0WswYsVDE2C8eNR/bBhZPoFHwwN2hNhkNfXdS+gunEWLfYUAmZtM9?=
 =?us-ascii?Q?9o87zdGjv+mik75LWRFkDwHI8VReqYWaNVcmKcjf7KChzzKPLY3cHaAGOoKm?=
 =?us-ascii?Q?Q3OW2qE4p2TeG0U40VQUNg40JDNG/NjF63/0OO1RrlrcP3Oj1Osj4ho1Vogb?=
 =?us-ascii?Q?TSERTJUsofX7R55rgdiXeMrZv0RvNgWlnTzD7KCgdmnt20Upttz0WxcgurKe?=
 =?us-ascii?Q?JXWaG7XJD7ld9EUtAgQX1rb8dh0T8Oy2izxOFu4M9NmQ09y4kGVWOn5OYPiO?=
 =?us-ascii?Q?Y6ob88WDsw55wPcZ7E37FoM476wCzW2HxBLpveIx/8JsoGdMlDZ9s/kq74aq?=
 =?us-ascii?Q?3vCWSh6OzzSBiLm/lDJemR91fZCZ3t0YdhjRcDnCqSoYF2HWjUtI6USWk1hz?=
 =?us-ascii?Q?h+lgVhNZlGjH9BW7wXU8p5yTBBQmQZwOjBGFAB1B1cssXejO/deJG/+2Ft43?=
 =?us-ascii?Q?f5POmiinZf0rAttCGGZOx44zw/ShJoUk5pyTEczgDG+awHlN0Kpg+5iKWEXG?=
 =?us-ascii?Q?X3j4LqZpmwfP2+VB/B/WW+UDvyBmG1yUE6JOG3IurfQeIxV7cZsH0vVgAhXD?=
 =?us-ascii?Q?B2MrAPU5nqHgcm0GGhvm8zGIP4C+V/hGGu0oasGM98demg1C9/TL/PWG9S9I?=
 =?us-ascii?Q?zNEWfRlcQa9Mt18hVOfkYaE8wU7J1AN0/SU9NBwcQqDDHwMVesVPgCU1UEnu?=
 =?us-ascii?Q?acnZbyvfAYLaUw//s1GhCW7iTYo/Wv6rVmFIzzKp2MwALK+U9YIT1oNbueCc?=
 =?us-ascii?Q?cRRGUBwC215EElWqeinbS5FzQSndWkYsNxQMTku6JnrLiz8k50XDluRQwssT?=
 =?us-ascii?Q?S6q6404brzaxtkwWa6OMKWDvRKBV58RpPmjA8wqVHRfTTCCcpYuTZIvQ4/nw?=
 =?us-ascii?Q?26XLnMax9oSVcC7hsPbawCiAyeIXZLP+lVRUzW61xlJsc32fGcXH3JXVOljZ?=
 =?us-ascii?Q?RAkY8PjcB0i41XECC32+YZA/UNNRp4MooQQn1vAf7K/q7R6ZSPch/3LbIwAC?=
 =?us-ascii?Q?LMDVk6Y4Pft54lFA9CAyVuVWi9/XsZQ5D7qDE6+3damJWNyTSv7b20YaNl/s?=
 =?us-ascii?Q?+hmUaGJTAKqvTLnrFhqw13ZjX3Dl5OaDXCzCz6SA30zd5tL7GTDWSfQcL16s?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wjpNs5TIqNz2P6WUxbatuauqFDb0PUnEDcTtVszCPg8e8rxXFhJzpSJEF1ije+Az8qhLVrJ7DXk8Pc6FmQJQ0pzH8xLvREcYWDqEU1qqIcSwlglEW1t1RncIVoLzxejwdimj70RM4n15Qjiqub4EDj27qTMSuv0e54Y6J++Cv/hdRSJatPyTiCkSQFXqDajMf2aXadO7Sm/6CFgSNs2jCclFknH58mLchIxF7WjED6JlLGKbDlu4gT35b96f8MOnxFjsA+RVX2NZILhn1Fyx6y3jGUyMIJmD76YG4dhGhmyOTLKjl4f8seP8gPD56q2QT9DN94pKfTa1TYNhsn90UfbiKYW+SBjDjf8k8UTc/A7S3lKNLfb9tXb/PSF9gSSwr6/n4lRNZmXf38jbw9bFvwV2x6G0Si+wdUAKjl74QrJq31O1PmN5uGDavi4+JHO684zJnu5h2H0ECcTX4bHcSD8o4608+PGypK7Cx9DkWZf/gRfffNZJ45jtWk9lAIA7pDHLec3Xa4t5fbWHHUPyUVEt8DSqm6qzARsD9vDk4fnF9tqyYHGYzK13eISjDuXKb6uWuzQsQ/qjZ3UMqlUZ6thABMFkmEpbel2NSZ/4fNk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77556be3-efde-4e9d-ab3c-08dce1317450
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 09:22:50.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPCVmmnEeo7v6/hkbY72dPTb2XbTnwRLeq32XWwOQzprMq9nfCBDgIXJeTlR+l3e8qU37Mcvg+rDmkcW5wQt0hgLpIDQq/zGHEP+RzGe974=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_08,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300067
X-Proofpoint-GUID: wD8FIO5tIN44wvCvXVbxiKRrjX7M3mvl
X-Proofpoint-ORIG-GUID: wD8FIO5tIN44wvCvXVbxiKRrjX7M3mvl

Add tests to assert that PIDFD_SELF correctly refers to the current
process.

This is only practically meaningful to pidfd_send_signal() and
pidfd_getfd(), but also explicitly test that we disallow this feature for
setns() where it would make no sense.

We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
theory PIDFD_SELF would work here, we'd be left blocked if we tried it.

We defer testing of mm-specific functionality which uses pidfd, namely
process_madvise() and process_mrelease() to mm testing (though note the
latter can not be sensibly tested as it would require the testing process
to be dying).

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/pidfd/pidfd.h         |  5 +++
 .../selftests/pidfd/pidfd_getfd_test.c        | 38 +++++++++++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  6 +++
 tools/testing/selftests/pidfd/pidfd_test.c    | 13 +++++++
 4 files changed, 62 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004..099ee7178193 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -50,6 +50,11 @@
 #define PIDFD_NONBLOCK O_NONBLOCK
 #endif
 
+/* System header file may not have this available. */
+#ifndef PIDFD_SELF
+#define PIDFD_SELF -200
+#endif
+
 /*
  * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
  * That means, when it wraps around any pid < 300 will be skipped.
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index cd51d547b751..cdf375fd61b2 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -15,6 +15,7 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 #include <linux/kcmp.h>
 
@@ -264,6 +265,43 @@ TEST_F(child, no_strange_EBADF)
 	EXPECT_EQ(errno, ESRCH);
 }
 
+TEST(pidfd_self)
+{
+	int memfd = sys_memfd_create("test_self", 0);
+	long page_size = sysconf(_SC_PAGESIZE);
+	int newfd;
+	char *ptr;
+
+	ASSERT_GE(memfd, 0);
+	ASSERT_EQ(ftruncate(memfd, page_size), 0);
+
+	/*
+	 * Map so we can assert that the duplicated fd references the same
+	 * memory.
+	 */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr[0] = 'x';
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Now get a duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF, memfd, 0);
+	ASSERT_GE(newfd, 0);
+	ASSERT_NE(memfd, newfd);
+
+	/* Now map duplicate fd and make sure it references the same memory. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ASSERT_EQ(ptr[0], 'x');
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Cleanup. */
+	close(memfd);
+	close(newfd);
+}
+
 #if __NR_pidfd_getfd == -1
 int main(void)
 {
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 7c2a4349170a..8e1510744aaa 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -752,4 +752,10 @@ TEST(setns_einval)
 	close(fd);
 }
 
+TEST(setns_pidfd_self_disallowed)
+{
+	ASSERT_EQ(setns(PIDFD_SELF, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9faa686f90e4..18802b657352 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -85,6 +85,19 @@ static int test_pidfd_send_signal_simple_success(void)
 				   test_name);
 
 	signal_received = 0;
+
+	/* Now try the same thing only using PIDFD_SELF. */
+	ret = sys_pidfd_send_signal(PIDFD_SELF, SIGUSR1, NULL, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s test: Failed to send PIDFD_SELF signal\n",
+				   test_name);
+
+	if (signal_received != 1)
+		ksft_exit_fail_msg("%s test: Failed to receive PIDFD_SELF signal\n",
+				   test_name);
+
+	signal_received = 0;
+
 	ksft_test_result_pass("%s test: Sent signal\n", test_name);
 	return 0;
 }
-- 
2.46.2


