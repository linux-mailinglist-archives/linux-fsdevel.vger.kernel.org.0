Return-Path: <linux-fsdevel+bounces-47384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83734A9CE90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DB787B5A72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7621E0DD8;
	Fri, 25 Apr 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J1EEnycS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jGwfZm7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B361C3BE2;
	Fri, 25 Apr 2025 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599579; cv=fail; b=CTaoazEh+KQYCYw5cG5hj0bw4eUpjCh3IwFjKye3zr5oFVi4fFTFhxkH/hDBtJODD37Al1+h1o+ez3CTp/+EAVo+nv01ze7c7yyztRUNKfgnOy2eTMipAwMflna+UjtClJSMp1/8CjURjv4CxEm2W2x9UvgjYFMhL+opJAp+2+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599579; c=relaxed/simple;
	bh=u6666WSHmy0hY6dgLILWQlYgY56ohtnXREIIcF3ZX7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FTGSuTUnbCKxIWeucDOs8zGd0L64K9nYVTl1lzUVQI3zxCGaNxtvOabu19MZxUFn1SIfS/Cz+sld2soG6mJIJVGcdqlXp+2iJk2GtEzx+vbKKW/e9L2thKel15msQM/P9am8s2b0V83JKzo5s45pt0qidNhmo7P6IyNMp75dnqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J1EEnycS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jGwfZm7u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGWH2a005082;
	Fri, 25 Apr 2025 16:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+GjTaUXOsAEMkVLehJKaxirWFJMVdqNCf+CNJQT1L5E=; b=
	J1EEnycSDFq35+EJUmw/0z5gy1xbjJvhvnRSklNYzBheD9zFX1LW7B7udWtITOTa
	/6v0CFuklVbBJAPSvtubXyuka9udlwZCTZw7rUoChymQuwrwjJ8fBwqI0UeI93+R
	Z6pFkMQSUYUD+1WgQgtwLmQJJBCwhGQSh9EZPj3TNSOpc22mw9pPupJHJ1LnAArf
	X/Aw/9krPJMJakaLx6nhXUPGG+CYwTxkTb5yfmsC8KmF+ifzK+GwGGsXImWoRQoQ
	hOexsROXFyNTISt/hAbyGoEAsiV/sFJZZ6FhwJKkznhrAosBRPZuMCR6LEncY9Xt
	t1hI0rNQW+dj9vXjBCxh0w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468e0b01sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PG8eGM025089;
	Fri, 25 Apr 2025 16:45:57 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbtng3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqCgCslW6OUiCWm2yAV3kNJ9B1Vvp2dwRBb2qiGvCqv3XtdVa69+N4Inj8G7hpP5x12qpds+T0ZYURmzFJksMeySBY6a3zH0C8zRK1jHNtCw2kbQEEMDTKGMF35yoxr+BXsX01DQaRdWn9XdnTcC3Bh79GgeLE8PzPVE3KZnJrNm/YCE0FN1ZyC2tNgbnhkFLQafHzSTdSCyt3u1eJx0B8nE9rMWsU68X993KqemOGbZpfHPF/+T3oh9kswP9eaLVVaefmAyiaKeHMB1XdMZS6WbiH4LqGu7J14tD+sZAUVfjcfJCtCs1UchzBg55KK0ZKVX/6ivEPNo8Cg6kI25lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GjTaUXOsAEMkVLehJKaxirWFJMVdqNCf+CNJQT1L5E=;
 b=EVx+Nl0xhV+pMUCbXMuaxcfY3SuPs3k4fffpzlFrDUUHJuJ9xTPijNpEQ3HsFZR32aHNeIM+UTbrLDMc5wO2g2Z8XasjNLu+PPv+cGFRaFluE3NZiOdFtaoxanXpFE+JRbg0BFr/bU0GejMJZn8kca7klPb8lT+wA82FcL75BEOiTwtabdZIQWsUBfpXcrUMufGDgZyTqmR/Q4nGIFYHGPVPTuCnPZl6QfMWoHaA1LXACPEI977Vr1fiZmxFAfy1L0GZqps8VgUSwqWi6BKHGsIx9UqN94wiVnVOzTwv55WVh9rZ2wrmTljOVVLi8aMeEViRrl4Mb1LV9yHhZbU5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GjTaUXOsAEMkVLehJKaxirWFJMVdqNCf+CNJQT1L5E=;
 b=jGwfZm7uZ3qyjgsTP0iNyix+yGcX8l015wwfl+zMa2sVoj51kMBfJl3aMCw/lixVW4A5qGTEXXK4M0h850qv3U16s7ws7bVXYyrTFOXGVGotz8wpcwGzLwHxr/7WY0556pQ0lJctJg/isSvITF0GnL7v/O6cDqWTWv9zcIpM8Ss=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM3PPFA3FC49FBA.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Fri, 25 Apr
 2025 16:45:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 12/15] xfs: add xfs_file_dio_write_atomic()
Date: Fri, 25 Apr 2025 16:45:01 +0000
Message-Id: <20250425164504.3263637-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM3PPFA3FC49FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 42eb3e8b-b13a-42a6-bba4-08dd8418a53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vr28w+W8do7DZVJO8tLRaS2fNJXF31L2N09higQn1tEp22oCeTxtoSqhIdP/?=
 =?us-ascii?Q?NtGTAho/SVg/ZbtR6Oudhl5PUkxoVkKW0hX2ESHm3tw3Qaej9PR8f2qGPkBM?=
 =?us-ascii?Q?i7msUJ7uUTGra6k+lehnyhFNdQUZdnBpswHP9o/dFBAgIhG8KEAPIzW9JQlH?=
 =?us-ascii?Q?2Ucv58Oh5mbOAHfglinGCiaU22qk3hx+Xfm0nnZZAX24c5ffYXwhROYatk27?=
 =?us-ascii?Q?PJLkkw5GpyH9J8XSDiL8s5ckiaR9gf3fRUo5H0KDREoOviCNey++KbTPflns?=
 =?us-ascii?Q?iK2H/JDaTThm84iWeSl9nnoG2jXwHEU9iBXPfB+xUqLRDY+2+qrxczyfj9Tx?=
 =?us-ascii?Q?btnw4mJ16XZNAvOWIwLfRRsU2XS4VtT64B8Z/N52W9kTxgXxiNKjHoGdrrAj?=
 =?us-ascii?Q?falIJTxEFzomuzz9o3F+7aN+CC3U93iBq+2vP5SYyT7ibiOingKldD3f2vCm?=
 =?us-ascii?Q?TimvQ/HH16M5NNUtzMDEJS9MTRM1LRFlhx4Jjn+6nAPCotxgd9fkbI3sXM96?=
 =?us-ascii?Q?4wtjN/6nPA36a9kidI9m5ORz1UA1Tuq+KE7n/LTTrBtLF0WqQVWJirknVSy5?=
 =?us-ascii?Q?kxBzihqdd88uYTPXokuPlKBkG6MQRJK0jO+i6LLCqim1oV1vw37dI8oxuFwW?=
 =?us-ascii?Q?+0UFBVH0tga8wKH4+cu48pXWxjBTlcEPatInAK8De0FPsDew8Fwkk0bMWHIo?=
 =?us-ascii?Q?wP9AQk19DzDgLrBpfxeTVGZ2gpxg9/7o7zp7FkePctuSYfsKidUYaXDG/DIm?=
 =?us-ascii?Q?X9OwtN6oe3dzqFMJlE3D0lc7G2xFxI/D0kv5LXlSFO4dOB1lwBJKv3oJz6SS?=
 =?us-ascii?Q?DlFUM9wJZoXlZgoXWeUTdzj47D9oZdF+HyOOopa0DrlMZVJwVN7GrXPnG2He?=
 =?us-ascii?Q?NvHh00Ff3wFN1OYt7hMmt6aIzB4ycqW0mSba6mQNPqix0ys+A9qHsQ13DN0G?=
 =?us-ascii?Q?R/fkVgn840V0TpFJNgNU83GUIFwDmzU36nFarCHskeCee2I2GjtYcCWVmXTf?=
 =?us-ascii?Q?9xczjT8k1IGRZIhjPT58z7dS1OYsVL6ToDCFCpBLrJ+Qc/ZS9Z6aKmGOYAt1?=
 =?us-ascii?Q?/NmQcvcXfQuzXUSbPLCNmw7gKvqHlMRvDvupNC4Su9Wuw0YBuIjM3g4lz8Dg?=
 =?us-ascii?Q?XlIi+N69+fC1ZTw7UnhNz5upGauyCprGKSdyieqJcPBHXzvuFvNYuuZPuFBt?=
 =?us-ascii?Q?gBqF0q9ekWpS8jSJ3CJNSmauLNQUxAlLd1WmRdp/Z5yxuzIOBNmd3R38FtEM?=
 =?us-ascii?Q?JFa5dE8IblRJiuNtZLDZ78rdBsWAoHAC4nMO6DwoCaet8VQ8tOggklrKO6j9?=
 =?us-ascii?Q?3bMsqusTJH4gv8G3gnronN1Hq09QF/HLkd88rRmkBoxsNqp0JysXZtscp8cp?=
 =?us-ascii?Q?2ie0kPKqaDZ4p21o0Zm0NcEo/Rr0rFRxLLYWdESh4xtUUz0xAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pkt5c7ImAkvejTMwZCONlUySVQ4+JvxPxuTI6os1NFQ082ldjbkVvmsN+uM+?=
 =?us-ascii?Q?/KloJw1pfmPpfN71h4hvULQWO9FM9rMaCeXZZASI4h8uKFHcTWRIUFqaFg5J?=
 =?us-ascii?Q?XkN3ojcsrojpYWVUgCUepcR/4COncm1kvEH+3q9chKzmy+wQl5QkIDot4K3V?=
 =?us-ascii?Q?/S8s/QEYj0NrNRQIPxPnXDjME3SjV23w7Fsq/USQaUaScGo1kCzHMvCAllUz?=
 =?us-ascii?Q?uRlWOkEKLW7njZZoqkcY5zLe/rKS+YmYFNQ9yGX8Pub9IXGCCvlgz4lUw1DQ?=
 =?us-ascii?Q?dxv7bn9ieIwTtLm6ZV7ewibADR2CcW49qpUnTIkm8Kc1P+U+gPaxMPTuuHBA?=
 =?us-ascii?Q?CM/8DcxYb//W2FFkPlqAp8Akw42VcI8LIIkKDGOHOiHC+ubUQ0Jy3/O/eKE+?=
 =?us-ascii?Q?vHkEOyQjyvMlfcDZhVOiKmkbIUZ0pzKA5LfPD+VIpYQo3UX6es/XtWErmGlK?=
 =?us-ascii?Q?2/dqlzinS9cQM7i478rS6IXgLZn/R1RWm4wbV+KPbj8QpGDsvo0sH+Re0jeo?=
 =?us-ascii?Q?BFiVDdRH1tSnrA9G8b2KfIhUF0e5cED+oM3VFTcZHjOb7FFdGuRqkCnCpBIU?=
 =?us-ascii?Q?1+rBbcBROj7E6cU6qCO2aigEYUxar6xxf4EK3RjW0urnquLOD+5lThs/l9A8?=
 =?us-ascii?Q?PxafAXDgQjFY7wu991x0TMGq2KxFQbAVNMbCsFShq0Fl8O6I+u1YLPg1pFvK?=
 =?us-ascii?Q?vM1H6wyB8OZHWCqV8DVMs7Q8HvFXEVTCGCs8bNClEVAkXOrDhZtXiTgF8oZ1?=
 =?us-ascii?Q?LMXc5dC2XhaBbyG8crrW8XPJUT304YfoIMGNct427/5z9WIAAhRufiS1vk/5?=
 =?us-ascii?Q?1LnfUMZoPHIx/Z9Qv8hT+Nh+3XCL2mil2iTwPuJuYisP+4qHwkoWZxFcKjyr?=
 =?us-ascii?Q?70WRPYbDH5Na9WssiSuKtUvdbGlFmK+60AngGZnusGbzP9S+SulE/u8SaUkm?=
 =?us-ascii?Q?XnfsMldezPY0VOmWrgTJ5emcNpcqPnjVwRemXkhG96QM/DTD44BbIz/OZVG8?=
 =?us-ascii?Q?8S0Csp8jOVyr7n5x6G2N6jgIcMXs51ijHKfhRwUHdR4zaW/9WnV62EqpKVee?=
 =?us-ascii?Q?g2JeiFA+ED4PmH3njSprxXDwmJHkvajPLA/WNoToFjye7wIeH/9eK8Qe6aW+?=
 =?us-ascii?Q?r9+WpjrhhdmJ7S7N0X0VcbG1E9m+Jc5litTpVNMxrklXfWLZGw4gYAIFeptj?=
 =?us-ascii?Q?KCfmGI4zTvhl2WVVYtcRBuYmvUzzxHPncfANdrU8NBaRdxw7NyvZfuJLD8nr?=
 =?us-ascii?Q?+KbU3v+eJYxmDLjEovZ2e9tUBBKYcrOqixrS2zDTv4WddnUyxMV59v4TNO/6?=
 =?us-ascii?Q?KQXHB59Zh1TM7HqEpm1r1HPOpisxTfWVwEcWlHUEHxLZ9N2qLkv79CrmolTU?=
 =?us-ascii?Q?D5Z0v0fgEeIMMCv6bwmlahqnE6kssOqnsblCtOZVd4jLD4GWe/uzDew/8hbH?=
 =?us-ascii?Q?kn/jk7CVLmMPR0enG3Cfu9okD81MKF5WQ+RsM17awrrTq/QR/9z4ODVAkHel?=
 =?us-ascii?Q?Y9Uj7P4byMbW+uYYlifZtr/sNoAv8bAYSZ+/OY/DtrVRidJz+4mux+/+ikCU?=
 =?us-ascii?Q?IXh0oDL7oMy3KiyM40f7jfWwaf3tevpx9K9W+Rc1OYKvgpwhRjA9RR0Bs8up?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WHjofDJmztngdUtawgL0ieSw1pUWjo1giqh4Wtm4s1cfq/wgMHuIQ9CSZ+7aeYfd9w8vyPzMP6woakIWjyycARH5O+hJDMtNDBuRdOF29MpnBbLFZ80tdN52nK9NHOXcqdhAfWKsv7ln31Y917Vbsp/F1ImlfBg3eGo3lN98H30qxUe+2Kx0JEk8w609y/UElitAlQ9yPl8WXUlq9spBI3Lxdc6y3ZTvpD/RvvgRdmI0KUmWKvq9eNLD6/o/C+PaVR0OFAe2f56EnfETjHMirQcNMSicpOSbr1aUfG+znRnNT082pyha1PzLYiSVQ6aTgEm1b/s72pvhTbWQXdm6xmZkCzNhd1I6GqBsT4j0XVQ/Hbc118WfQHICnplri5Amw+F2Q1xtDaF3x+hCGF2Irbp8aE5BDhGLKTfgWwyi32LCB2oaRX+qN2ZB059kz99mb4wKTf/LsQqZ7hpQfc9ZnJqnSVWrRKZoVpz7/JoP8G3tBL0yBSMWPlp2CbDKtZVY0GqCUfz6RmQMFAaSkWsrxUaLBRkGOB6Q1YNqTU2DqAWMO10V95QJT37y6yjN18539kaP4Z/eMMSuzXWVXE7PD3cL11eBdi3ftVqZu08JZfw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eb3e8b-b13a-42a6-bba4-08dd8418a53a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:54.4595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elb4Rjwlw7smKGguKrsSHfxhIMDQysOon/205dzCTP3qSHJS+sDikqZqAK12LzrJFReX6YW9BMyk9iZ06Ol0+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA3FC49FBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250118
X-Proofpoint-ORIG-GUID: Q8v1diYooGiT58jkKUQ1hx6FFIkoUPdn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfX2PZPhHRYy+5F s+ZZeF3pWpnGKCduiMu66eObCvTY38ac+SrqaB8YEM36WQLLVXi3F3U0kQBx3Op9FMEuabW05UQ vQVp3SSzzPhnmuJn8iVzxtyWy8eGhtsaCeFXzVjSXePbCkH/9h8Uhh22Ggcv1Or/Qri71HGCtRm
 5aj3NXOJG13nTLAKBQqRc/TO2o4ARK8JtIbqXcGaG8L+EMlTPyZ/5x/6uIK0hJiunV6o0ilU4P6 kPzhei4+TyqxEhlDqgsxubXGoDYv/RRnlxWHqKiux2Ltw6mEPKN4R04ukC9w7i9buB4FTJwV7Dz iPqI5/gyWp4i30FqmvDWm5BTk6O8ziXcTgnOnVOnhJB/ERwIIKuIID/vuL35loqzI8CYMLFEe/o hX4nXDfl
X-Proofpoint-GUID: Q8v1diYooGiT58jkKUQ1hx6FFIkoUPdn

Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.

Now HW offload will not be required to support atomic writes and is
an optional feature.

CoW-based atomic writes will be supported with out-of-places write and
atomic extent remapping.

Either mode of operation may be used for an atomic write, depending on the
circumstances.

The preferred method is HW offload as it will be faster. If HW offload is
not available then we always use the CoW-based method.  If HW offload is
available but not possible to use, then again we use the CoW-based method.

If available, HW offload would not be possible for the write length
exceeding the HW offload limit, the write spanning multiple extents,
unaligned disk blocks, etc.

Apart from the write exceeding the HW offload limit, other conditions for
HW offload usage can only be detected in the iomap handling for the write.
As such, we use a fallback method to issue the write if we detect in the
->iomap_begin() handler that HW offload is not possible. Special code
-ENOPROTOOPT is returned from ->iomap_begin() to inform that HW offload is
not possible.

In other words, atomic writes are supported on any filesystem that can
perform out of place write remapping atomically (i.e. reflink) up to
some fairly large size.  If the conditions are right (a single correctly
aligned overwrite mapping) then the filesystem will use any available
hardware support to avoid the filesystem metadata updates.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 32883ec8ca2e..f4a66ff85748 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -728,6 +728,72 @@ xfs_file_dio_write_zoned(
 	return ret;
 }
 
+/*
+ * Handle block atomic writes
+ *
+ * Two methods of atomic writes are supported:
+ * - REQ_ATOMIC-based, which would typically use some form of HW offload in the
+ *   disk
+ * - COW-based, which uses a COW fork as a staging extent for data updates
+ *   before atomically updating extent mappings for the range being written
+ *
+ */
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	ssize_t			ret, ocount = iov_iter_count(from);
+	const struct iomap_ops	*dops;
+
+	/*
+	 * HW offload should be faster, so try that first if it is already
+	 * known that the write length is not too large.
+	 */
+	if (ocount > xfs_inode_buftarg(ip)->bt_bdev_awu_max)
+		dops = &xfs_atomic_write_cow_iomap_ops;
+	else
+		dops = &xfs_direct_write_iomap_ops;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock, NULL);
+	if (ret)
+		goto out_unlock;
+
+	/* Demote similar to xfs_file_dio_write_aligned() */
+	if (iolock == XFS_IOLOCK_EXCL) {
+		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
+		iolock = XFS_IOLOCK_SHARED;
+	}
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
+			0, NULL, 0);
+
+	/*
+	 * The retry mechanism is based on the ->iomap_begin method returning
+	 * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based write is not
+	 * possible. The REQ_ATOMIC-based method typically not be possible if
+	 * the write spans multiple extents or the disk blocks are misaligned.
+	 */
+	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
+		xfs_iunlock(ip, iolock);
+		dops = &xfs_atomic_write_cow_iomap_ops;
+		goto retry;
+	}
+
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
 /*
  * Handle block unaligned direct I/O writes
  *
@@ -843,6 +909,8 @@ xfs_file_dio_write(
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	if (xfs_is_zoned_inode(ip))
 		return xfs_file_dio_write_zoned(ip, iocb, from);
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from,
 			&xfs_direct_write_iomap_ops, &xfs_dio_write_ops, NULL);
 }
-- 
2.31.1


