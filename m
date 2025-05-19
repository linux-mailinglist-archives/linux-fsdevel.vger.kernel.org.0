Return-Path: <linux-fsdevel+bounces-49335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77006ABB7ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7609A1888900
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 08:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E6E26B0AE;
	Mon, 19 May 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fuUqK646";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yPBSpsEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3547826AAA5;
	Mon, 19 May 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644747; cv=fail; b=R+6RtSV9buPjB+uxT0LVnB5wVGB3jVrs6QwFRuaog5TXH+tA1BdDLRlkxCPntUkjB389hWE/N+9hhil6sUS4MlaryqKBmdyUeTLt7jEJpHJvkjb2xnU5tXPs5COGrDmSxDPqR+0gzFqDGS7386feLgFk/vOTy4f+V5ibD7jLErM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644747; c=relaxed/simple;
	bh=kRN98GNItL+O6Vc25bt4ZCyGrx+jD0iVVDXevj9+PAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D4y41egfWRn73HhDVDYXvSL6gDBPglY+GDBhYLCNVmgDa2jf6ObTHnPIZ/CSQVanNF42KSlWXsD3vblJE40npTMPzxaf0L5bnoRuEIhd9RrqVd3V7DsdGimSpGfHusfkLDTSoAx1wVWVJ1bKBTQCUcBKkdQdPgdKZW+ufjJri2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fuUqK646; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yPBSpsEC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6imkM024963;
	Mon, 19 May 2025 08:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8TuWYa+9z0ohzDM9mYzEITFvvLHSnXGgRsnjyKLoJJQ=; b=
	fuUqK646r1K9A0Sxesh819GGEzg3K3wqUvvkOj/mPLHa7wGK6UtbN4BbWxoxIzOr
	4pcQ/0chwadGgAsdB5u4HU6E6q19mMkmCXbdEwOwP1zB7/qZE6OuTKNKPFK6bhOx
	DbHvsUGAOXiCSct+vjPJ8/X/f7iXKJ1rCh4yJ1nYIhCHDZGIuJ8MkySgMRN+ZxEK
	1EUqosqQ93VAJYx1mSarcApxdlORQoaPEHB3FxoS+2kuJ5SNhqDuDGrtcB917XuF
	NH5WG7Q+wf0KKbam4yM8OOupleTHd0f/Ix/0CXliZxYGwVKYgmUo0K2sK9JSkUgu
	7IR8Z/RsVDBqPDFSzgt8Yg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pgvejfq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 08:52:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54J7Y6QQ035236;
	Mon, 19 May 2025 08:52:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw6drk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 08:52:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuB5uwh/Ym49YHhHvh8f3dKftCBhOAEOKSU0ia3Xr4y9exJ5ILI3S11Fbn5DnomONyRBFnNunAp4is6xGNOkFVBDFhc3TRoyU5V45nIn6Dkxk2is0xj9m1b+5aiWjE92qe0OZ/JspNfJ6RVBKK+tQbQTzJ2mfimNBaEply51oKM2MjQAgoNJHxxO4fA5xt64ZxjOqzlaB5tm6yY8ihrBpZHMb6BdjH+A2iw7iYm1cT/Mnlk4ssVoMl1hOhXZ5LToKD3gACVDWOk/0jXA+zaEe5B6ufhQJy/MSKGwIzliDj6u7VB2s6GlPrBVc3IYydUwy1fWsqbuU8VbpYcMyqxUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TuWYa+9z0ohzDM9mYzEITFvvLHSnXGgRsnjyKLoJJQ=;
 b=d2JAbPt6gUVPTVZL177HPj513J2r5C45/i3hj09TxwzAcM191u/J5ByQciQl2Sih+G6dlzVlILRU1Op89mS5ILgl37dwkKG9+D7afvKqEkLegWzYeBDs2NeWW+vYTJpf9RWvg2OeBFkUcLBCfsTQE+o8Mht0xOUmTl8B0iaOwlcAROvLfSu0N9/4aHJ5QWPuZee5XSJDQULZ7Ddhc+ZGZ+bDY3KOHng29Vn4k17q6IIslLoZ61ljCFZP6/ErLeOryQUZ0RFiuTS3g8rAxgFk+Dzsi0DQen6mF1VumdIQzNbnOeCL3L5UoLIAgi085f6cEWl+9lqagx3w6z74T4E6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TuWYa+9z0ohzDM9mYzEITFvvLHSnXGgRsnjyKLoJJQ=;
 b=yPBSpsECljtdUJkcDMK3d4/UxTQDdOMVyjjQYRCiGza8h5WcFkun0xrLjpcpjdtZLZKWbok3iWOS9WQ96nRiuH/ATGh18XOkc0WBnK7YQ7zZvjcvGJEy/BGqGgCNPBTVgQpb+wPfwgyNVz4b8P1k7to5LQwgY8G3w84P6nfr/cU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7767.namprd10.prod.outlook.com (2603:10b6:510:2fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 08:51:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:51:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
Date: Mon, 19 May 2025 09:51:41 +0100
Message-ID: <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: a74b4248-e01a-4873-e1fa-08dd96b26ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P5RrJqK8/98UAwCe/k/tvf/s3GjGAkmdIbSPuRCJSfA+zgZPrDPSMyP9C3FJ?=
 =?us-ascii?Q?GYYHR1qX5sDrJNeq6x+i5KIImO4pAs/V8LxL1mAjHWUK9saWVf2Wjuu+O24J?=
 =?us-ascii?Q?cuiwYfWtd1ou3flisT/DSmuMQu0gPMhmrQXKxojzOUeUC3ArhdvQCI9YHugN?=
 =?us-ascii?Q?ghQEDAf71qMNHJybqYaR8Q6a+qRPEFKPSFm5LCjjUfm59hMKGsbiLpBwpmaH?=
 =?us-ascii?Q?tYdxk8ZFnGBucQQCGvUZ2QAYZxdeWEksX7ySGVE+egKGImFg+/mjOZ1heJ91?=
 =?us-ascii?Q?t1otQkliHJEByiqsyFok01jScKaJFFslAFYREVIR2/bQuAn5NTHppeuJrzos?=
 =?us-ascii?Q?I+FiML1fSnX3EEMwpU6a3fGFSTWL3WJ5utuHv3PlJAfnoOhdhI+da4BV/fG6?=
 =?us-ascii?Q?CgFr9+SA0SFA3IPOrx7VC83v0PDFyNdk980PWm+p1gcETviRH9gYjsLeh/qQ?=
 =?us-ascii?Q?On5R6cmelCwGvUGXhOouKNrlZLY7GItRlhtkv+kr5kuB5Ts6xSjojLrezO4C?=
 =?us-ascii?Q?XrGwKy/d2B8kI295fcsbdl76Bsxsyn6OFpvki3phBgc1qOWV9/8c3AC0bqjL?=
 =?us-ascii?Q?hHQdDb9RkIh3pN1c1fEkqpzXUoS0NfEDdhJ9Haw7W2v6DPsAPGF1qHwcuhJO?=
 =?us-ascii?Q?w8y7QNoQM7hLt958U+qQBDbdyzd9s3qPLrXMRKTjhyZvFtgDqIlUOYmM2zxN?=
 =?us-ascii?Q?R2ZCUNqz14vYJc7NKDUIWOWxwS+fBmrm6dBoTmLtunEm1Rfhmb7WMHM5MM8K?=
 =?us-ascii?Q?/QTek7O1431y2w6h2uX3eR5SpCT72FfYjjdNrmaWlhpS0F8CJ7rIo140yBVS?=
 =?us-ascii?Q?gYCDRYBPkE2CXcK+MLhpKwJsmHUlMXt8gq9pgeAjc7q3aNiBVKB04I/GAG+G?=
 =?us-ascii?Q?oKnnb6/vqesM8FDChjAEbEQkvoSdzZEbZ9ab8v34T4WTWxX8FQMZXk87zzLc?=
 =?us-ascii?Q?cMUrlYBjqKm2MjiC8FhCYwbnCztSU/TKoxU0c2cdwluMGc3I92NzhAoAsS3X?=
 =?us-ascii?Q?1pgN/9tPRa3WM5mli3mSPLxOUmmVbBiO9HeCJov4dcMlF+Ze9PWGGRoiT6z5?=
 =?us-ascii?Q?vzg/k+YL4mHNIfq3uhTaGUgaOw5l6iADEQf8u40mUMMLSEZHcyMMuhSGndW9?=
 =?us-ascii?Q?ykCk0dTaub/g0trm0rq9M9iL8mvE7fLWhM7K4MFGelfba6Dk9YbQoyag5X+X?=
 =?us-ascii?Q?taXTq/Ylhl+3UQOTUxytIdfv4EObJ7ncWrMwVKKYBbZHdJfoYRjXxWPlTqGs?=
 =?us-ascii?Q?ZqiFzezWtFH/j3uV+qb4r6FCAHjxuOKQB+VXLnycughoGClgAikdZiJmFfls?=
 =?us-ascii?Q?1nnXxjyXbXtKXtyBr98/grO0dUO0SuKc/nr8Ck99Y0araOvp8HGjhg9el3Ei?=
 =?us-ascii?Q?27gb5XcSFq18iTnU90i8IpYVxkkf1Ao0mg5KjLbhNzvPhZhtexTGViUpSc03?=
 =?us-ascii?Q?lLKs+rFWXso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fntyi69b8jDFd2gTwOsCdY1wI87Vl2KLaP9tkzz9Huz7LflsL+7Ya+Mx0Z6g?=
 =?us-ascii?Q?5TiVPPwlwbep1rm97M3wqn8L9PzX3ib6uVIeBw82lc0igtcux1v4RTy6beos?=
 =?us-ascii?Q?BK8FaatYZDMNcyvPvWv6T1a2wcGba1Qf8Qi/ounmtFmMpcoGFqgeEUt+h/8V?=
 =?us-ascii?Q?eYkVEBbHZyQUrHJ2AwlKZbCuPeEBW8CLBUw1sPIitTXlcGEXbqojtmnWLLvv?=
 =?us-ascii?Q?D72Yax7LekUygeWix7LsKzLLjv8A5obRiYbo4pfSXMphT0IkLGs/mqF/bU1c?=
 =?us-ascii?Q?GxECFaf88gAokFRSMU4QuCWEJa4OAbC6+QNCUsAWS2bfBxYBW4/kjtttZLE6?=
 =?us-ascii?Q?N2GySShO0RBhY23fu6d59VDLY3PyztdRP3QKwFiYf/8n++VQPCsaj7Ey0Csl?=
 =?us-ascii?Q?pHlCkIEsnldFA5gTkjIkmFl0ToT4Pq7xlQ+9MgHW0QKFHWK9nHUgXMWm6nmB?=
 =?us-ascii?Q?O6r5e6S7URsVw7Y2zaG/ZU63+ExGkAwP837W0gZRCEf7WBBkaANuI840eAov?=
 =?us-ascii?Q?OgTttS4Hz9BQfHbDZ4b1IkrhBOtcln3G7K6bykSQ2BhIoWxBa8cXfQ6ARnxE?=
 =?us-ascii?Q?LU+4+TkcVtC/sV7673tk7o9fiz3TDDxf7VkumoF2+oYf/xryRS+pQvTuwQu1?=
 =?us-ascii?Q?bMsnJ49an76ld/8dn+Lffi42u5RA60tjJHFkTKE4ay1dIuGgG+CZZ35pLgyp?=
 =?us-ascii?Q?UWAjdS/Lj/+yKNqzeEgSM7k25PqWFA2LbQp3Sovap2VxXn+GNhPySMbCeS9b?=
 =?us-ascii?Q?GGbbeMTLhrs2yaawCzqGbsEWcKhCxchL7YI03XAZEajOOnEnadOpTnhVmSVr?=
 =?us-ascii?Q?yonasLDFF0AlF9lQEguWnVKrjsxns4jb6LwCYulRXnJZ0Gj8scvtYMklU5Uf?=
 =?us-ascii?Q?+BuIXvTzWHBSpn+3zn/yamAufeUjervkMZNMeFm2nafAiTYpSJITC7OEeupK?=
 =?us-ascii?Q?JTNFZkUV6qfDYgTLxfS/CtN6rPr2nY4AQS9rgdycUsuHnooUJZ9OfFURJIzA?=
 =?us-ascii?Q?sC+t15OJGAYByRsCKMMY7fA7EPkq2ky+1pSzUw2xjj4pqtR+22du2XW/1R/s?=
 =?us-ascii?Q?TxhJn2aCGPvg6wkzpU82ZeeGdbPNgcmKem1F7v/yJaSBOtdZiQ72cMt/v1lT?=
 =?us-ascii?Q?XYdk4EFL4djz94vCcn1z479dva0df6BsaeE7TNqX8gUqmsHo6DFgy8ojsu4G?=
 =?us-ascii?Q?rxtnRAveY/5g3lgE5/lBC4AJRo1uMWq9Udj10XUbgzY6JPv/E6z/ghHjbjpn?=
 =?us-ascii?Q?F4AysnY9bCcMWLkc+tqr4PhZzmzWmS7jJyEwSIhdHwoUQavioIiUi/Pkkqnh?=
 =?us-ascii?Q?4GwsVQprKE+k5W+zF0+EzqTICg5r1+TbnuM2y0aM2vgTF/vahJGPb9FLpT1k?=
 =?us-ascii?Q?duUpUOu2O0lAJxLoCnCybfd0VBCExcI+1/L2EFOBbvxrAqjP8gN7WNh7cAKM?=
 =?us-ascii?Q?L9FomdDljYmb5RGMS6k3fRaI3MuZGUreDRFlaJDAXcI6CEiHbX3Y5X0N1BGI?=
 =?us-ascii?Q?Fq+dHpURWaLzjH7Sug6j9EqfVYRomsrVkwqJeHHkVzTy2GBrLTU7k8GzDCNQ?=
 =?us-ascii?Q?k86yrg4dqhOgfDCGJ0CKhqDOp3U7y5aYGfLbi1IOFUUeUfLSPb+8h8mW5mr+?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cgVEmhc2a/BhexrzI7D7dXPqMhMv3fXA4iJ8BsdB6lmii4pI3kPd1e6AVvRB3EKNtYCFtHwUJpcuQ7GVkXTO/F2RFI1GUsgvFaCUlFHsy8lgF9SRB/9jWOespT7izI+nCn91RdkKMAOL7dfXDsC5aPVh+ZhZeT8VAGbgkZeX8Ey1sVjTP/jroo1UUcgIiOf5SxJAvCPphX4mY7D9E+X67Fdzbxj50OyZZtlJB9scbGyxE3GfgJJZy7l4q8EwP13iVqrM/vn4fyfOnrD9A8SihaWxvVEe23CevcYWpW98RF1THhP9iIOCr2D2QRmBKrrBvHHQAwORbPaizmRQnouIo3xE9Nad7yHpght0lxOgJQ+kxAg4su04rAki4XnOixESNPYH+gWLQ7SH4OxvbLIHhMVzccP/2ek1L7sB7SJyvGouLrOb6xmR6uvqlvj/SP7QnMhH4pHRPnhFOdEuZ7dZR79mW17eBWA00Op0tlWxekVzUPPXtxoODPcA3P2Uc44GhCSVLVqNy58AHtvVd4+82OGXQ6BSCJ/hlrV8fLjCusrgGD1UNmUVwEKJlMBV/jboTpuMOIG0oYPepqN4mPY+TJoiBWFKmTA/eZHuwJyioY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74b4248-e01a-4873-e1fa-08dd96b26ad1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:51:59.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJ33J8qBFzyjfIXUS6wut3Z7YdvcI7goZaPVQcCl2w049zn3HOh8RtsjJ6XfAbt9cz9jkglCXCvGoLyxVPGwRDcv3EJejCYditFMGvyBevo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190083
X-Proofpoint-GUID: ZpUlUYvYXKrjW0uEUffdCOsfLRjpqQeK
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=682af133 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=UG4qeyOn-HlvHNRBQ68A:9
X-Proofpoint-ORIG-GUID: ZpUlUYvYXKrjW0uEUffdCOsfLRjpqQeK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA4NCBTYWx0ZWRfXx0dCYcT4/xa5 c5HU8NaRHaBAOFi+7uSOIZy171+dc0j5CEkv5VCvOjy9Ryn6mXOYb1wdrXeeeXh9/DYLv9rYb2o EChiKeK/9MDOfzsCDmVZQerEV6+7dHE2anSZ4qnY0j7PxmdvkRpGC2WopkSOsR+mNARm9xLJtO0
 5MY4hRy5vCdM6hRZkzq8+P/y77DkPlGzKnN3R0ERJu5fKPp4ddFAbi3moqCSAdrKLMhuSK+F/ob omRX2KOgqsNZcBDx3S1kQneETxMBjuvkkfC+a7qU9Kh3m2HyNQh7JJkpuCdLs2vlFCq5EhGTxi9 OtfGhcAIYzbwTGTPcosseTye7P3OzkUa/ElhzxKxxKscsf4hNDAHYasJkRi3Rnsheuin9d15Xpl
 uoqJgy04NwGtVLZ7oM6h1ZhiN7DAHWmwG+Mw0SO3CISAFg4RNp4jMfwMRMITf3XZ6az44RfR

If a user wishes to enable KSM mergeability for an entire process and all
fork/exec'd processes that come after it, they use the prctl()
PR_SET_MEMORY_MERGE operation.

This defaults all newly mapped VMAs to have the VM_MERGEABLE VMA flag set
(in order to indicate they are KSM mergeable), as well as setting this flag
for all existing VMAs.

However it also entirely and completely breaks VMA merging for the process
and all forked (and fork/exec'd) processes.

This is because when a new mapping is proposed, the flags specified will
never have VM_MERGEABLE set. However all adjacent VMAs will already have
VM_MERGEABLE set, rendering VMAs unmergeable by default.

To work around this, we try to set the VM_MERGEABLE flag prior to
attempting a merge. In the case of brk() this can always be done.

However on mmap() things are more complicated - while KSM is not supported
for file-backed mappings, it is supported for MAP_PRIVATE file-backed
mappings.

And these mappings may have deprecated .mmap() callbacks specified which
could, in theory, adjust flags and thus KSM merge eligiblity.

So we check to determine whether this at all possible. If not, we set
VM_MERGEABLE prior to the merge attempt on mmap(), otherwise we retain the
previous behaviour.

When .mmap_prepare() is more widely used, we can remove this precaution.

While this doesn't quite cover all cases, it covers a great many (all
anonymous memory, for instance), meaning we should already see a
significant improvement in VMA mergeability.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/ksm.h |  4 ++--
 mm/ksm.c            | 20 ++++++++++++------
 mm/vma.c            | 49 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index d73095b5cd96..ba5664daca6e 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -17,8 +17,8 @@
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
-
-void ksm_add_vma(struct vm_area_struct *vma);
+vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
+			 vm_flags_t vm_flags);
 int ksm_enable_merge_any(struct mm_struct *mm);
 int ksm_disable_merge_any(struct mm_struct *mm);
 int ksm_disable(struct mm_struct *mm);
diff --git a/mm/ksm.c b/mm/ksm.c
index d0c763abd499..022af14a95ea 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2731,16 +2731,24 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 	return 0;
 }
 /**
- * ksm_add_vma - Mark vma as mergeable if compatible
+ * ksm_vma_flags - Update VMA flags to mark as mergeable if compatible
  *
- * @vma:  Pointer to vma
+ * @mm:       Proposed VMA's mm_struct
+ * @file:     Proposed VMA's file-backed mapping, if any.
+ * @vm_flags: Proposed VMA"s flags.
+ *
+ * Returns: @vm_flags possibly updated to mark mergeable.
  */
-void ksm_add_vma(struct vm_area_struct *vma)
+vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
+			 vm_flags_t vm_flags)
 {
-	struct mm_struct *mm = vma->vm_mm;
+	vm_flags_t ret = vm_flags;
 
-	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
-		__ksm_add_vma(vma);
+	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags) &&
+	    __ksm_should_add_vma(file, vm_flags))
+		ret |= VM_MERGEABLE;
+
+	return ret;
 }
 
 static void ksm_add_vmas(struct mm_struct *mm)
diff --git a/mm/vma.c b/mm/vma.c
index 3ff6cfbe3338..5bebe55ea737 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2482,7 +2482,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	 */
 	if (!vma_is_anonymous(vma))
 		khugepaged_enter_vma(vma, map->flags);
-	ksm_add_vma(vma);
 	*vmap = vma;
 	return 0;
 
@@ -2585,6 +2584,45 @@ static void set_vma_user_defined_fields(struct vm_area_struct *vma,
 	vma->vm_private_data = map->vm_private_data;
 }
 
+static void update_ksm_flags(struct mmap_state *map)
+{
+	map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
+}
+
+/*
+ * Are we guaranteed no driver can change state such as to preclude KSM merging?
+ * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
+ *
+ * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
+ * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
+ *
+ * If this is not the case, then we set the flag after considering mergeability,
+ * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
+ * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
+ * preventing any merge.
+ */
+static bool can_set_ksm_flags_early(struct mmap_state *map)
+{
+	struct file *file = map->file;
+
+	/* Anonymous mappings have no driver which can change them. */
+	if (!file)
+		return true;
+
+	/* shmem is safe. */
+	if (shmem_file(file))
+		return true;
+
+	/*
+	 * If .mmap_prepare() is specified, then the driver will have already
+	 * manipulated state prior to updating KSM flags.
+	 */
+	if (file->f_op->mmap_prepare)
+		return true;
+
+	return false;
+}
+
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
@@ -2595,6 +2633,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
+	bool check_ksm_early = can_set_ksm_flags_early(&map);
 
 	error = __mmap_prepare(&map, uf);
 	if (!error && have_mmap_prepare)
@@ -2602,6 +2641,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	if (error)
 		goto abort_munmap;
 
+	if (check_ksm_early)
+		update_ksm_flags(&map);
+
 	/* Attempt to merge with adjacent VMAs... */
 	if (map.prev || map.next) {
 		VMG_MMAP_STATE(vmg, &map, /* vma = */ NULL);
@@ -2611,6 +2653,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	/* ...but if we can't, allocate a new VMA. */
 	if (!vma) {
+		if (!check_ksm_early)
+			update_ksm_flags(&map);
+
 		error = __mmap_new_vma(&map, &vma);
 		if (error)
 			goto unacct_error;
@@ -2713,6 +2758,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Note: This happens *after* clearing old mappings in some code paths.
 	 */
 	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	flags = ksm_vma_flags(mm, NULL, flags);
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
@@ -2756,7 +2802,6 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	mm->map_count++;
 	validate_mm(mm);
-	ksm_add_vma(vma);
 out:
 	perf_event_mmap(vma);
 	mm->total_vm += len >> PAGE_SHIFT;
-- 
2.49.0


