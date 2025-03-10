Return-Path: <linux-fsdevel+bounces-43664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4ACA5A346
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824AC3ACDA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970CA23A9BF;
	Mon, 10 Mar 2025 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cSX+WYde";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PCa8Ipi+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B1523817B;
	Mon, 10 Mar 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632024; cv=fail; b=DEzwt74KM4lvcYhwmiH6NI48Q2+8d7VVwTqoYx6YCSSvwhJ/hlZUYpl7dahpExXAEkkkh7F33P96y5F7IgDULbhE4IcC4OF8bKE5irHEHKAWvD7RJYwQxoBuKW76TwQhZUYT5YFdxZY8MCyuYxZEXMFTcEaegR5uMKQpX7Vb+1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632024; c=relaxed/simple;
	bh=dPXiC5XNfLOWLeshpyB/kVTjzt8wgtd4zF4vLU1ToZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kg+/q3NvlicbpfXC9vUys0d2riFO5IrvB36r96+KBpyH3t5gb09yE8kdSyGEoJVD3zRWKyyLw53ugDiJu5e4yuZewZGVBgccUnrswm05FQ6Nm+6t5MZLltv5nnB+KoRrCGb9Bh3+U0h7yhwYselUccO64oTZlQTGo7o4zon6yEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cSX+WYde; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PCa8Ipi+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfmlP015827;
	Mon, 10 Mar 2025 18:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2ZIaAeuMRNr8q+4QyUCgflEIANoKRryUdfAghQssgN8=; b=
	cSX+WYded3dygJFQmB/Zs5trf/mPqSl8HfiGf6yupSCprffQzA8nMdofQsk7wbIe
	x1IPTCn90Ei3UDi4xdjtvbOQsQXH+Jp4Q+AH0yJs8u8DdlJIG0/qCWjUr/7SZN6X
	C2FCyBHrq1IffMA1WlaRXDHim3CSz/5feS7HUyahgEusLpeuMgqXq5nhvhXrRBMT
	ICsRJP9I+4g53e8ip6KNqGK6288QCm5tzpVxmtyas4+m2AngFdfIs8ZSoiuBwuPv
	GV/43B5nekpjycLrhJX/DtfdsYqgwbVIFd2uUQz+5X27tcex+E16vafg48kczYGv
	kjWwX+0g/ZDLz1imVORUiA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cacb9hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AIFBjf026926;
	Mon, 10 Mar 2025 18:40:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb805p7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fD7zhW+SfihEzcFXTJPovTwV2YKZEv5YeG0EnS3+fx64xz7pmu+uGeWd+r+YYwdmcXwGiKJ0u+LlmSo07hfGac5yLZebGjxrIT9IQc3+hcE3YZGBNNSDDdyEiiJzdXO0dGpVDcqNb5QB293AJw7SwUY8mXgXToBmhM6CscxmonoUVEE1l5Ny6PB+ezZ830yXgTelfDlHDpXYNZxUbrcg/dbqbd0ksu7p0TtWo7B0Ow9Soi2JUuzbvK8W6dULwlDtLB9J/e6kPr62GFyIBDpeKjVrawhePN2EdO8ciZZhIMjosQYhpswdMQDaMkmji/kMQoodYHtqFqezpEgcDc/LUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZIaAeuMRNr8q+4QyUCgflEIANoKRryUdfAghQssgN8=;
 b=QKiaq30wMoxHiH6yxbfQ6myKD9bTjeAGiKdIxLqyGwjo2MXF2p20MEFS+fZHppSxLulef4KUmCtp0fj3rdWzjqrFa7WA/WnhYDj5vXtDuuh1wNiWrYK/Qeqlc81mBo+zTbQ6PPZiJ/YlMni2F/Rl37P1tQLoDY1PwqoSuxQbgE1M/ADwMkVu0Zd96v8pWmlyZtImh7bWWH06KSKpPIdCnYaygORP5qakHhdODcLrwh1XJRbYVJ3LLUVH2vUpZUFqXZhcWEmo6T32IAppOlzLUp90KpQcQU3LARPFDZctAYkwiVMg8eBTKocnOhhRzZrRKg35qHrP/J5EdNqZFCBxRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZIaAeuMRNr8q+4QyUCgflEIANoKRryUdfAghQssgN8=;
 b=PCa8Ipi+e8Y1wyABAb5SOEBhq7+TX5BJaeH6o1XL4qUJBZrltTA503NEZRv1lJwXRNCDMuTzC/0GQBthejBWYAKqjpoP3wVhOnux5e/6cOOD7aEuX4/xM6BWFKuaRAxg33IiZShcNpVqssrvPl6cDTIdZG1CAw7nZxHqmdCVDOk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4502.namprd10.prod.outlook.com (2603:10b6:510:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:40:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:40:15 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 07/10] xfs: Commit CoW-based atomic writes atomically
Date: Mon, 10 Mar 2025 18:39:43 +0000
Message-Id: <20250310183946.932054-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250310183946.932054-1-john.g.garry@oracle.com>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: 134bf365-ed8c-4108-0041-08dd6002ff6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6SV89MeYkvlM03yCV/q9+au00v7RC9hzIGV9dyLzgogpGY8rpywcbk9KJLa0?=
 =?us-ascii?Q?vBU15S4WfUxc9+B61mOAdHDZ0s5lSihppOeAz6j+bBr86+GycA3ch3TRORJ4?=
 =?us-ascii?Q?rnHDoSCyvz/A1FQjm6uiPr6qBooVxgd2BtuGczWzX6lEqsMvuygvJpi4m6Cu?=
 =?us-ascii?Q?yUIqie0bqS6sMpqKJRw1Gti1/bgl7vbSif+63gkAe8hMvRfpq77XUGVg6DZ0?=
 =?us-ascii?Q?JOEHdTAG+NbtN9YpQAeztq63YUMH5MU6ABdH2aUaRIK1Z97N3FkRzGiqtMGg?=
 =?us-ascii?Q?p8gcFIC4pCqRxj1GclpXRIG352u00OXKTd2SZoJkD2lHHJeLnfHVBXpNCDbd?=
 =?us-ascii?Q?27OMkUIH920/Wa0VrzJLcU608xAK6QWzZ0dTkVSxR57KvUZPSqkHNdrpujlp?=
 =?us-ascii?Q?VvWEvzsyWtyxRMymf8fZlTojnV1b3VjwKD5op/t2cKp3UAildNj4lRFMUDwN?=
 =?us-ascii?Q?JbMEIR/b5/DR1uM1jkirrpK8OyERc0wvMsH7+ubzbqMA58KJK82/meRy1Q3Q?=
 =?us-ascii?Q?ZmSvRberY5ZOi43S3vMw6MObSFukGI0KbWodq7ErOqKhWk1YUuEKhTtxPtgY?=
 =?us-ascii?Q?IWp08oMzgi8hX9aiVEG5wxBWjcUzGQILR/E4LE/C2n1juNYqrtyc/FSmz/ET?=
 =?us-ascii?Q?WnqJbzal7e9dk+VKyvC1JFI5XkCK6lxVbp7u4IkCbmI2+rdeuT/hX727gydf?=
 =?us-ascii?Q?h0LnwA1bVMxZw2viLBnpGQzkxNRQbRE4UfNVO4bor4lIPelIaPgaFwuwEwPl?=
 =?us-ascii?Q?OgDhymIeJrWM6joqAdLc+OuFjNGEODpQI1fTaEDj/INAXyiwzSpNqCXoMMNH?=
 =?us-ascii?Q?KDiWHm/thQtRUhYi8PzvsLssbVwtLz4hR1PAg3Su9tN+7fS4HuDHgPvfbWl6?=
 =?us-ascii?Q?QGiu/IMDeVjgROn/T6qmh0yhxiUvxuggvyth2a7HCAURvr8uzplWdseX/w8E?=
 =?us-ascii?Q?CSQvDwVDYOLpTNhXEu0O0evE8uXc4DF4pGKGVV5klb2lBWu74u0KJRMHs2+D?=
 =?us-ascii?Q?raTgtieieJeSicqF9CtcsrlP4PkJMho8wWlStIHtntLIeK7pOx0jE9XATDIj?=
 =?us-ascii?Q?ByNMc0K4+F8pLhVP2AGr1lNsMSMjTdPSRbVdSewiE6Enda+qGhhv5JTqpd2N?=
 =?us-ascii?Q?nS96MPwVIkuxaW/5xma0tfVHJRtPq7X5niveSO8t1trpydz2yt2zKkLLFe+1?=
 =?us-ascii?Q?lHce3No8R4yDIgUJ4fGI+0zIeKG2ttHGgl4vjnuHPCndo9MIoY+jyvMsYYeK?=
 =?us-ascii?Q?FaiCaj7idLYlNh5ahuVsOaJHCuhu7/zCyeL/6qZ3mY9tj6LS7ZBlqDNFQv16?=
 =?us-ascii?Q?cFP9rkKhuD15zcIjJRHfWE911AaSerb2Be6XCP6uucHg9fdUFvNj8O77D7Ng?=
 =?us-ascii?Q?ylMjEshtrZ9jSNbyrshTedUIPzmM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CgGOP1s8G+KzB0uMS7ITllqV+X2zAO+eadOwGSwltzEUl6xjnVTatjBP9YM3?=
 =?us-ascii?Q?3+Oolhs/nuuG4K1Qas6Lyet+lK7l74YQv7jtSmH9VhLHBk/ZmWzUG9tjJat5?=
 =?us-ascii?Q?Z7+Yq6XdgQI9FejM+UkAUPDhPnQuo3+ept3SHs2uwI9WhdsqfrplWODpq5/R?=
 =?us-ascii?Q?rdhoCKA+StdIbo8KMw8oypDM9/dAG5bYLLykdY3lsY2nrYhG+BbA7NXuqy6P?=
 =?us-ascii?Q?3lgCC8OQfiY5rTcKuqtbPLNDuFM2AzNH+8eZTO/Yy4UvbEijQN239ch44nqP?=
 =?us-ascii?Q?3iAnIM1HQeUBFlYSXP/uAhA+eAOcSaTfGa4KtZPqC+80A/OeB/8VH0SGg5K3?=
 =?us-ascii?Q?p7kpVqyOSBjzfNPGmZVM+U6S22+N7EJMFEtmSut4g49AV2Yk9WYDy/VsqZD+?=
 =?us-ascii?Q?myvM361j1lz5/Pp09jC+2PYxhUi88B7YjvF6xJ/2qqgvb/qqAxDDgU1MInQC?=
 =?us-ascii?Q?nrPEpOoATJ6G03g4nUgCiLPUo6HemnCWhpvNoAItcLRTNcd5jBa8rLOUs4s9?=
 =?us-ascii?Q?+iSASUPDBMDdneHZ6/ihCSMj/Zs8l92gKNIVDYKm8UkFVDdeTpvktuDHkduT?=
 =?us-ascii?Q?muNzpiAqyVrTT+LryWXjRIYCeD701/wD6XVE0ZJcaa450j8bzkGUleQgkoKg?=
 =?us-ascii?Q?poss+k84sCA6LL7Pn1bZ4U59VUMMDn7ovcatQlMexq0HN8RhXPEmpo9pBij6?=
 =?us-ascii?Q?Fc/3o+D/M7gZOaOU+iZxqZ5hxy+qmpkUS28WzRN8gIcNxlQD36hBaDQ5OuOq?=
 =?us-ascii?Q?P0uz4LqqlYYukhXimA+8Ea445YX9zwup73Pb3xX1fyUOKu/3yx151PT7/7DR?=
 =?us-ascii?Q?RFxAetfZ9Zb2Ty5Rw772iTMkUvlMDU6/JfdI4oMuRasl1xTn7J8lpzMedFQV?=
 =?us-ascii?Q?+DhSOAnyIHWXF3nsgByWPzl7TyVus8g+4nf2/3Xn1V+a6JqpyeCWGIXM3pCF?=
 =?us-ascii?Q?Nf77lHF900lsIYh2EyxwJ42B/ZV7B8/C1aqKMnMkqOiiqhYuoSDnayD/9HLl?=
 =?us-ascii?Q?SrxQ2sDdbCLk2KkVpV2EDvCHBnTTjRh0Uaf9gyb49G6OxHnLsM3pLk1cuQHO?=
 =?us-ascii?Q?8wdQindnDaBBdPPt/zEB28eCaCpsLN1kiPC/ep/RagxboTQ9agORATCqCRwx?=
 =?us-ascii?Q?bWEMuLnLwjRDC2qEMyTtUqmt3aemWDWgfWCmIh17/3/AnbxnHs5EntG+H8z8?=
 =?us-ascii?Q?c6529c889ANfhKkpcN4O2FIXedBo4if6rsntQ69awaezNJATnEtnKCBmgHMD?=
 =?us-ascii?Q?SmRpSbc/vy7CVCyUxZwyxMdJ5Ncx9didpkXOOn18pWAfNiJD52jhD0M3mTbr?=
 =?us-ascii?Q?77NQP6VGrhXdZFH/M3GkvVKD8jy5uw0hdOQVuETefJhvNpbmbqqESnwnLIK2?=
 =?us-ascii?Q?YaTRDPGaBKdnepEOw6k2nxz9urcjiA/7ZL2mXWakoO65BImPl1/Xt93U0VEe?=
 =?us-ascii?Q?zfu7QBXIazbkw6izkGp8TWIn4IywEbb/v0paPmvlDMqKrb5NYihBp2k3Q9x8?=
 =?us-ascii?Q?BqaQgMJs7om6qXclGlkvvm7Ml25Ht7FRKOm23U3UnJ9h1sZVjOIbyK5w3tmM?=
 =?us-ascii?Q?1/2vc1/6WgO8uMyc5rRgBwgT+h9yjZf5r1su7yi3PXBsqdaGg1xJqt0divm3?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9v4Cz/0Box+ku075ZXDTnTN+gxnY1PHE1RpsfRBHBBmN7ptmBBAXEb/y80o3tGlXp4bHh/6OBrZAZB8niMxrAlpMlc6ZG3KzM3EddSyqMrsPfozouD6fuH73ZF8fmYZVcTPnUQjMkCUcXTocRdmIPnYXW+yLbnSK5dYBTJ5dE9aRxNI7zkZG4Qs8WpnsLlKLQaoZcWTAELVuUkLs2XwnsG18zQJ62iC6R35AEbVkF6ljM8spaMlouiocaTaoNROLbaBzACpuFFZGnTBpxVDuqiL3ztlkpPrMkIY1cT11fGAaNp6CrfpcCWPjrzIL6lQ3l5QrqsxZ4SqucgIj76t0GHIn3+49dZiEz0PvGz7G7/A/cGGYDEQIOltRl2jbMso0vra9CTWETuIn6qguw8nbeT0bPlvB3l5pPgeYZLEtOkGfpJWRIhNBLwtDzlf7EE6ABvpYs7wovfoJfEk4eVrdXQYdKynrxHb8a2VbDVovymBkvsjQlIcaPaD1Qioa5FZmpwXRUh6nrlkVX2heWZtelJ+ulrTnIGM9Q9WQV+BiMNkleg/IVrTZx5F1NKpt3iKj+Z7F4N2af57fid8avj9HuwMnnWTMXmKsSe7BFWNPmI4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134bf365-ed8c-4108-0041-08dd6002ff6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:40:14.9876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ryf6jaDXgFkjUjBgC+Oh8Ffsv+Y6gucp54lGIsTplRCG9Ne4GLVFpXQkCbdHxwyL3rL/XvxrFodXogLhn+fJ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100145
X-Proofpoint-ORIG-GUID: HV6myyPqmgMdFeMU1yeB0iRci05TQWOO
X-Proofpoint-GUID: HV6myyPqmgMdFeMU1yeB0iRci05TQWOO

When completing a CoW-based write, each extent range mapping update is
covered by a separate transaction.

For a CoW-based atomic write, all mappings must be changed at once, so
change to use a single transaction.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c    |  5 ++++-
 fs/xfs/xfs_reflink.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h |  3 +++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ddcf95ce741e..16739c408af3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -576,7 +576,10 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			error = xfs_reflink_end_atomic_cow(ip, offset, size);
+		else
+			error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 0949d6ba2b3b..ce1fd58dff35 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -987,6 +987,55 @@ xfs_reflink_end_cow(
 		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
 	return error;
 }
+int
+xfs_reflink_end_atomic_cow(
+	struct xfs_inode		*ip,
+	xfs_off_t			offset,
+	xfs_off_t			count)
+{
+	xfs_fileoff_t			offset_fsb;
+	xfs_fileoff_t			end_fsb;
+	int				error = 0;
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_trans		*tp;
+	unsigned int			resblks;
+
+	trace_xfs_reflink_end_cow(ip, offset, count);
+
+	offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	end_fsb = XFS_B_TO_FSB(mp, offset + count);
+
+	/*
+	 * Each remapping operation could cause a btree split, so in the worst
+	 * case that's one for each block.
+	 */
+	resblks = (end_fsb - offset_fsb) *
+			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	while (end_fsb > offset_fsb && !error) {
+		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
+				end_fsb);
+	}
+	if (error) {
+		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
+		goto out_cancel;
+	}
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
 
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index dfd94e51e2b4..4cb2ee53cd8d 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -49,6 +49,9 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count, bool cancel_real);
 extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+		int
+xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count);
 extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
 extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
 		struct file *file_out, loff_t pos_out, loff_t len,
-- 
2.31.1


