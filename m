Return-Path: <linux-fsdevel+bounces-25801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F14F950A5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8116CB223F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5915E1A4F34;
	Tue, 13 Aug 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V9WXSXNE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qOBHWcjv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84BF1A2575;
	Tue, 13 Aug 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567038; cv=fail; b=GKLLtaVm1RwoTVKQ97hRD+fehoKI9dROAj9al36Yvab0Pilx4ptxnMqY84+bghnNKTBBcHfs4t32rI+0hLc1GzIshS1noXAZrIutwZPvEtjaqMt8uEZgAesJ5C2w2bYGRRFK1eHfdW7IU2nvGUCTmliBudL/W8UpDArVy6iEYAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567038; c=relaxed/simple;
	bh=Z7LLq+zV9tmtxtH7CKsr9XEVpUgX/3s9P1O+oRwkdvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qIYREQzjDyfsI8LtdOT8ASFETua/J39p9KqOluqQKmFvcBxVTffgpyqpmbPr6bno1K4d3VgieL1zIITWQS1Iae9+e88MleZx4iIEDoptXgLG/TUEdQz2i5rUlEXi6XIUEB/ZRSmFdbSPpW2F+ALWcxbjZUNrDIaRxw9m0DwZU3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V9WXSXNE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qOBHWcjv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBV5S022283;
	Tue, 13 Aug 2024 16:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=JKxlh27GsuWWUAHXyP7CKwSvfJ1z6wrm1JzCJZJ03YY=; b=
	V9WXSXNERlrZ7XrmTJ6/ah1APf1sbMoyoAJTbaMqlZqpvVrL93XzDLvi2jV9QCS/
	dQr8lNpdYqGC49z3fQbfu775AMOs6ZxBuXcoqqscya3qCwlaywCuMU7azZUrX8bC
	LMz5sr+M6EPJixE5ZvYvRjsidXmpQr+eda9XRen46B8im6Fk0xzsvt/w2V57nhQV
	ClEzLft9cSIY7DMujJZnHnDMJz+QEbLo04+2eN3V7ynT4Wgc2fw3tRL/54Vao6cU
	Zktb5qBLRufNzTlo7wTwa7b8lPFLUxEkWDw6JJ0uikcYWFk0f48MVrCFvi90uKu9
	rKS3TEWJckPBduSFN8Y71A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0396a9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DGBTrd010640;
	Tue, 13 Aug 2024 16:37:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8s053-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsjP1qZnVs6ZzEgRT+IlI0SrTR2NMG9VL5D6IYFUiRw0A1F/sg4vlijECrDPmgChOwjJ8fKDz6syqSvlxADjBZskN4D6vkRvIMpav3bnVw4Ci5IgF3+ZEGJBM8gfUVS0sszC3os1NBLH1HzbpPJ3apB7vj7EZ/Drplpr8zUwW2peX5RlulAiJRyd5+iT+v8MRtJfjoieD/Fp0H8/MnvQCrKjMf0rwJfOXSTgtM4l6wVerri5bp6IbQSSdjGnlX1dfGDKAxUfiqWA5iyqO3nplIJunj+0g+lC5ZoGRy8NPNkCAKok69wQztF0RGY4OPcCWk5u8ExOfp/VNSro1PQt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKxlh27GsuWWUAHXyP7CKwSvfJ1z6wrm1JzCJZJ03YY=;
 b=I5a/VZDstNNzDR8EUZpVh+6txd/4qyVbzsGM+Ub29b22ufhEeIKXG5K8YPA8LPCyQ1dqbjjgEhmmn4lIoWe3E/Ex5J9TZxiDLVZVBF1qsjVTQEi8FSwuveiHyGzOurBgDKPHGcwHkbpDTjZ96AaG7A/ZdjGXGJ4s85YcmBYoH7rQv3xdBoPMWLDCKnfTPh+/aJ0NhBDUiH//4Dgx1Ap+t49LJaWHnbvb8iy671sS4PlFTN0LjMHhagmX2ewuQlbrmZ+XGqjlm7c63nAQ4y1dprzkilUdFTf/GUAr9W0ujvwip2D/qO5m8zeMEiMwf0AeIqAXDee2sPk5QHN7WEeEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKxlh27GsuWWUAHXyP7CKwSvfJ1z6wrm1JzCJZJ03YY=;
 b=qOBHWcjvmT4J55ZUtSmD+Ib/y2ws+zk9zcniIMDSk2ehdIBL4aXrVz5/cBow4QlYBncORGE/kMPUzu9CYGq1YjhModvtFxdbCrAEsedI/CY5BCfjZJOSG5Mq26S7W0MRtrNZH47IXJW3taOblOjdLYQzrJ8DXhpmuqFNK81u/PY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 16:37:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:37:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 07/14] xfs: Introduce FORCEALIGN inode flag
Date: Tue, 13 Aug 2024 16:36:31 +0000
Message-Id: <20240813163638.3751939-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::46) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fa0bb9-0a65-4062-0c14-08dcbbb62897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hh1JU1w5IqLRoC9e/JuVBdUmPbu7I+wFepvDAWQuLwAD9WUV9vXGLCCO6ERW?=
 =?us-ascii?Q?4lmgiGNzRODAJUwhL79TwbjSLIcNarUxoLNZmkLWW00uH+zHh+9vY04kUf3R?=
 =?us-ascii?Q?TXh1aWrtqmEWR7NuYBYCTrcnG03wjUpCWR8oEJGvTkYcxoyqwQyqrj6J8mVc?=
 =?us-ascii?Q?EQKmeiBxWnVbWa1GcT9RnZJwqA7SeoLv3nlTMnt6GEbkQqnBP93opMR6bFQo?=
 =?us-ascii?Q?zahtvN906hP0Q3KJhnMyPg8rOg6OgM3ND7LRVtrbwyaNPROtmIAawtH/TAbV?=
 =?us-ascii?Q?0mudwnhSf4Z+Jb7AC2KN3QJe9OAawVeJ6c8jgu2zmvOhxSunJQT/xTuW6H8D?=
 =?us-ascii?Q?lkI/REOMhsRcW5cUYBPW8upWcLWJ+8UiMJT+2Vs0YEAjzCgxZ9T2xpMRK9DQ?=
 =?us-ascii?Q?HWbS+n7cwKvp7X8FFPuJdeKyRg+9d1JLpeFzdXF5tufVxzXQdXlB5tt6IxMj?=
 =?us-ascii?Q?greW7fEzRsWxoAJzmhHNL15NRHqt91GJVrRT32NeWSnDOMl3z3daJEQUpEyX?=
 =?us-ascii?Q?BXg5xXre76XPKT9yRy5h3AQBIKjIm7jQetlo7N05ZDqO3fzUdHIlaQX6peNZ?=
 =?us-ascii?Q?68QVELGRti6fFzkcp4cuC7a4buWyzNwB1jWQ29T8C/M3esJTzegWkOE9EZKy?=
 =?us-ascii?Q?hlw/bBWhx3yIgFJDQJZc3leAeCRuwEvaV8ZG3lXgYU5pXMRY+bn93ZaR7Kuz?=
 =?us-ascii?Q?0oDgjlqFyZS/hfFR6Z5cZrGY9ubExGkl1UsqT2GXql7AEdKHr5oxl3Q+xtIP?=
 =?us-ascii?Q?fWoc7xfqRbFoswZTTvQVF2hSsq3ib9o//+priSaioyD3tWUIw7dSAtRqb0LK?=
 =?us-ascii?Q?LSTc04QNpcmXl49+jNVVWUA85aw1kzS8kUoXj5Cedxsespw95sydsdZ0bQu6?=
 =?us-ascii?Q?pGZvouIl9eAl2+VdnPfd2A79emBAe+4ac/mY/fxurXm1eb8kBQk80klerA5V?=
 =?us-ascii?Q?i0YF+IYFrncEQXuaa6Z8DoWemkOX195S09phQ6eCEy+D5SEH5xXqqS2oI6te?=
 =?us-ascii?Q?RvYa/dQwqr11ACo8QH6fNzkHz+6q2tR+eg9pisiY8Cwu/b6XqBXODVCg6gGt?=
 =?us-ascii?Q?anpFphtfEIl+gkiz86XtIkkKcW3AADPgpO/jts89aZb3QKYWlHVOT2UPyTtr?=
 =?us-ascii?Q?514yKPlBQpEr190TNXt3Mnw2JBCL2rXcwIGjJse0JdmaCGXWLd0CgtY6oPgS?=
 =?us-ascii?Q?kytTDEhB2C+CZhqf/J7AGqBVffYyJdFpUy3sa7Dp6txA3xbUpXtfaVL9LR4I?=
 =?us-ascii?Q?YSgUCa+ubBEdm8Hz103ulIEdlXybHybamMpU91mTFPtGvUSLwrruzReY8QMb?=
 =?us-ascii?Q?mepSAtZMH7yoKrEJ6IwJ4MGtJyO3t/0q2sjrY4Tkd+976w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?awoeJVhcBRScUUPecfWYF9EhTwTDvUSLXiwLJmFYYg9gdIeJk3IhwP48oYfP?=
 =?us-ascii?Q?rBmLiTZc3mCGFbBlllt9A+xEeMwcqjUMfbw+t6gVyAeARpTxMnXYZZh9wxZm?=
 =?us-ascii?Q?7CrSP7ju054Z9sWtsRGHCRD/lCaZI42LJMEgbhRaNMLRrFZxwWvmKtpWseXt?=
 =?us-ascii?Q?2dy0i+v1fMSpROXQc46M+OO8ROxZQpCEmjrDOBBlhGedmqM0jdk/9IHzu3FP?=
 =?us-ascii?Q?M7S5WW1tAY/fMhEVXxzXw9SE/BDdVGScFWNECt8IaiWMMtjvQplhcri+dfan?=
 =?us-ascii?Q?aZ3GAf1tTcFtBZLZY6/+jnSD5luTMti78Ihked3JibCv5kQXZ2UFznx1335u?=
 =?us-ascii?Q?lTTnWknnLWDl04Dgc/yR+C+Br7IUpwxa2YuOFzCZ1tU8V3G5c8wceUsHLoxr?=
 =?us-ascii?Q?WzcKynfVjaxwlMRV0Q6TLhqxuPlXM4yR3y7dNqX327Jr1YYLvCRCgCpldtZw?=
 =?us-ascii?Q?QvtfBH3f0nxN5HBWZIlVapjKwJFBCeu/uCjLL9p7ynaJevKrAU+xPfs76Wl6?=
 =?us-ascii?Q?5btvpdPzGEyQ0PyOVM94huj6nfWUoViEi70TOr/e8hQDJVK7k6ArUxeSIhLh?=
 =?us-ascii?Q?i49MM5Qg8j1CW4feMyZ2MUeZ+qu0iBXRbfSu4a/xMYK+pfJrJg7UT1jZef17?=
 =?us-ascii?Q?W0SfYEv3CAl+KdU3VNx65eVXxqIsOp+ni2PNElh7/jN0IcFytmmPPHki7x9Q?=
 =?us-ascii?Q?lqury/ACYhPhyxMcBBaacQkuEmgiMgR9XPFPRbZCjAPkn64vAdEI3l+7Z13b?=
 =?us-ascii?Q?OTVxFyW9YjNpeub08bxn9VnsmMnKxs09CrMCwGbbSGQxJ2p13PRCEdUGCVdz?=
 =?us-ascii?Q?IQ0x8msjrF4J9e/k1RCtBl8B8fpsXcP40cW6dLttDvqiTum854BvldqgXxCi?=
 =?us-ascii?Q?cXjS7iUbpwXzT3KkG4ynV/NyX8xpUfmKB5oHvYJWs1KvrcZlv1edU45dnKCl?=
 =?us-ascii?Q?WhyfFcHU+Nqv7Mw/CcEdlLJeOMR0FPz4RMwwhy2T8mhhUMzaWgoyAqaFd/Hq?=
 =?us-ascii?Q?7H8bAvCUS9TZ4ITRJzd6BfTdaeL2d7OaJPZZMqxjMs3qy9emF50t5zX361TG?=
 =?us-ascii?Q?qpoTtpR3zlvyA+dsxbJjybsSWIMP+ZR0ilRz8EWaW7PdrL5/7xP/+9CWvu7j?=
 =?us-ascii?Q?u6qP/Hg9WV23AHMESlJQvmkVEYgUf8XgH2/RE++jTv7Ed1M7wkBq0nK9hbhY?=
 =?us-ascii?Q?fIjfzhsieY00hJCCaZnvdpr5lipVZKskx41SB+mWYWZeNnLxpXZnFwHMhe0h?=
 =?us-ascii?Q?4gdsPP8qSv4AN3FbRHe/IddRUZDiu9eyAw8NiXFQvqWJXwVPkZc0v/dPK+57?=
 =?us-ascii?Q?JQzi5mNg3Zg5LRbxed8S4Dg9xcaImHLeGFlVZ00Vsp4PQrVpL4ytBwJ/e2Kg?=
 =?us-ascii?Q?zVQAT87wT7ikpxCcpxx1wEuTSV3krSrZL8PvEq+d+ubfsth7DLPELpMuoEoi?=
 =?us-ascii?Q?5pXUQ83de+hHPzo3U+JgJvVad67R/bvLlUCgUKDfQTIZu4vf76ZKZS6a9ziV?=
 =?us-ascii?Q?ZCUj08tLFZTLBLkscEM9lRO7JLgIEhTQWhXg/aQQKLZzsguYAN8dOWgOV/6I?=
 =?us-ascii?Q?vjs6PAfs5qDMjdacPIoplKZDu1pDNe0re6PXwED8/90r1Zyo4E5a2h6JCn1J?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vktwin+TwXnDZDNh2GHE3HctgPK71b3JHITTyUhXtgmAm5TlxPFYlUOd9wA0UpR8bfXGlpzV+ss7mmIVZL4qfw5x/paNFn3Jlx2YmD278E6TILb7EgDw8NXR5Os4KtBFxYjRK2aZyiM3pEKz1MohFCvTIcI193B1HWR8E0Vzo9TGOV97str7nGoNq+LEnphGcXR2bxiWCRJ+UXnCAGu4JfbOHVgJ6bNZJTLHYXg+QuI2nmbalT2l6j7OmBGXEOwwooJmf91r9FCoqZHIRHw3UJVrLnbfDvDN5iIdSjwau6kXAF++tIimhDnJ3XlOFvzK0PB2DEuOTixh4Gh/8q72WGbmW7186gRA1SFpzQyV9+nNJ2v04SPHIWQQq1xG0GoCjsxBnrj6UtV9TRcSwtvENiYh0Lf4F9Q3H2tVO6uzJvWJorX3gf0wazM8mSqTyC1iNqH98+9NI1lKcThQ1Wf/or6U7SP6qRbGNakhjDXk+216+zHt+HO1NXXUGEcEYsfY4Lrr7m5UMhKRzhZn/1wXyhEP5qu+GM4/HQ794At0UjFOzIB12M/VVf+5DgUdZ7aZportj1/jLzKcf1ORA+i53CEYpZYj2cGLIpCjc4v8Byo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fa0bb9-0a65-4062-0c14-08dcbbb62897
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:37:02.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOnw9zCh+Jfm8R6byl9XrbdLZe0r4CCr1QjoD1RyjsJb7EEWXEiUrSwQQ+Ju+chXxVGEuCFpvihrF4jCFt0H0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130120
X-Proofpoint-ORIG-GUID: Qr5L0ATrAra1jzd7mfy2V8zWS2AAvbOk
X-Proofpoint-GUID: Qr5L0ATrAra1jzd7mfy2V8zWS2AAvbOk

From: "Darrick J. Wong" <djwong@kernel.org>

Add a new inode flag to require that all file data extent mappings must
be aligned (both the file offset range and the allocated space itself)
to the extent size hint.  Having a separate COW extent size hint is no
longer allowed.

The goal here is to enable sysadmins and users to mandate that all space
mappings in a file must have a startoff/blockcount that are aligned to
(say) a 2MB alignment and that the startblock/blockcount will follow the
same alignment.

Allocated space will be aligned to start of the AG, and not necessarily
aligned with disk blocks. The upcoming atomic writes feature will rely and
forcealign and will also require allocated space will also be aligned to
disk blocks.

reflink will not be supported for forcealign yet, so disallow a mount under
this condition. This is because we have the limitation of pageache
writeback not knowing how to writeback an entire allocation unut, so
reject a mount with relink.

RT vol will not be supported for forcealign yet, so disallow a mount under
this condition. It will be possible to support RT vol and forcealign in
future. For this, the inode extsize must be a multiple of rtextsize - this
is enforced already in xfs_ioctl_setattr_check_extsize() and
xfs_inode_validate_extsize().

[jpg: many changes from orig, including forcealign inode verification
 rework, ioctl setattr rework disallow reflink a forcealign inode,
 disallow mount for forcealign + reflink or rt]

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Co-developed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h     |  6 ++++-
 fs/xfs/libxfs/xfs_inode_buf.c  | 46 ++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_buf.h  |  3 +++
 fs/xfs/libxfs/xfs_inode_util.c | 14 +++++++++++
 fs/xfs/libxfs/xfs_sb.c         |  2 ++
 fs/xfs/xfs_inode.h             |  8 +++++-
 fs/xfs/xfs_ioctl.c             | 46 ++++++++++++++++++++++++++++++++--
 fs/xfs/xfs_mount.h             |  2 ++
 fs/xfs/xfs_reflink.c           |  5 ++--
 fs/xfs/xfs_super.c             | 18 +++++++++++++
 include/uapi/linux/fs.h        |  2 ++
 11 files changed, 146 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index e1bfee0c3b1a..95f5259c4255 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -352,6 +352,7 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
@@ -1093,16 +1094,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
+/* data extent mappings for regular files must be aligned to extent size hint */
+#define XFS_DIFLAG2_FORCEALIGN_BIT 5
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
 #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 513b50da6215..1c59891fa9e2 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -657,6 +657,15 @@ xfs_dinode_verify(
 	    !xfs_has_bigtime(mp))
 		return __this_address;
 
+	if (flags2 & XFS_DIFLAG2_FORCEALIGN) {
+		fa = xfs_inode_validate_forcealign(mp,
+				be32_to_cpu(dip->di_extsize),
+				be32_to_cpu(dip->di_cowextsize),
+				mode, flags, flags2);
+		if (fa)
+			return fa;
+	}
+
 	return NULL;
 }
 
@@ -824,3 +833,40 @@ xfs_inode_validate_cowextsize(
 
 	return NULL;
 }
+
+/* Validate the forcealign inode flag */
+xfs_failaddr_t
+xfs_inode_validate_forcealign(
+	struct xfs_mount	*mp,
+	uint32_t		extsize,
+	uint32_t		cowextsize,
+	uint16_t		mode,
+	uint16_t		flags,
+	uint64_t		flags2)
+{
+	/* superblock rocompat feature flag */
+	if (!xfs_has_forcealign(mp))
+		return __this_address;
+
+	/* Only regular files and directories */
+	if (!S_ISDIR(mode) && !S_ISREG(mode))
+		return __this_address;
+
+	/* We require EXTSIZE or EXTSZINHERIT */
+	if (!(flags & (XFS_DIFLAG_EXTSIZE | XFS_DIFLAG_EXTSZINHERIT)))
+		return __this_address;
+
+	/* We require a non-zero extsize */
+	if (!extsize)
+		return __this_address;
+
+	/* COW extsize disallowed */
+	if (flags2 & XFS_DIFLAG2_COWEXTSIZE)
+		return __this_address;
+
+	/* cowextsize must be zero */
+	if (cowextsize)
+		return __this_address;
+
+	return NULL;
+}
diff --git a/fs/xfs/libxfs/xfs_inode_buf.h b/fs/xfs/libxfs/xfs_inode_buf.h
index 585ed5a110af..b8b65287b037 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.h
+++ b/fs/xfs/libxfs/xfs_inode_buf.h
@@ -33,6 +33,9 @@ xfs_failaddr_t xfs_inode_validate_extsize(struct xfs_mount *mp,
 xfs_failaddr_t xfs_inode_validate_cowextsize(struct xfs_mount *mp,
 		uint32_t cowextsize, uint16_t mode, uint16_t flags,
 		uint64_t flags2);
+xfs_failaddr_t xfs_inode_validate_forcealign(struct xfs_mount *mp,
+		uint32_t extsize, uint32_t cowextsize, uint16_t mode,
+		uint16_t flags, uint64_t flags2);
 
 static inline uint64_t xfs_inode_encode_bigtime(struct timespec64 tv)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index 032333289113..b264939d8855 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -80,6 +80,8 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_DAX;
 	if (xflags & FS_XFLAG_COWEXTSIZE)
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
+	if (xflags & FS_XFLAG_FORCEALIGN)
+		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	return di_flags2;
 }
@@ -126,6 +128,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+			flags |= FS_XFLAG_FORCEALIGN;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
@@ -224,6 +228,8 @@ xfs_inode_inherit_flags2(
 	}
 	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
 		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
+	if (pip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+		ip->i_diflags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	/* Don't let invalid cowextsize hints propagate. */
 	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
@@ -232,6 +238,14 @@ xfs_inode_inherit_flags2(
 		ip->i_diflags2 &= ~XFS_DIFLAG2_COWEXTSIZE;
 		ip->i_cowextsize = 0;
 	}
+	if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN) {
+		failaddr = xfs_inode_validate_forcealign(ip->i_mount,
+				ip->i_extsize, ip->i_cowextsize,
+				VFS_I(ip)->i_mode, ip->i_diflags,
+				ip->i_diflags2);
+		if (failaddr)
+			ip->i_diflags2 &= ~XFS_DIFLAG2_FORCEALIGN;
+	}
 }
 
 /*
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 6b56f0f6d4c1..e56911553edd 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -164,6 +164,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
+		features |= XFS_FEAT_FORCEALIGN;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index bf0f4f8b9e64..3e7664ec4d6c 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -312,7 +312,13 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 
 static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
 {
-	return false;
+	if (!(ip->i_diflags & XFS_DIFLAG_EXTSIZE))
+		return false;
+	if (ip->i_extsize <= 1)
+		return false;
+	if (xfs_is_cow_inode(ip))
+		return false;
+	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
 }
 
 /*
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 4e933db75b12..7a6757a4d2bd 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -469,6 +469,39 @@ xfs_fileattr_get(
 	return 0;
 }
 
+/*
+ * Forcealign requires a non-zero extent size hint and a zero cow
+ * extent size hint.
+ */
+static int
+xfs_ioctl_setattr_forcealign(
+	struct xfs_inode	*ip,
+	struct fileattr		*fa)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (!xfs_has_forcealign(mp))
+		return -EINVAL;
+
+	if (xfs_is_reflink_inode(ip))
+		return -EINVAL;
+
+	if (!(fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
+				FS_XFLAG_EXTSZINHERIT)))
+		return -EINVAL;
+
+	if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
+		return -EINVAL;
+
+	if (!fa->fsx_extsize)
+		return -EINVAL;
+
+	if (fa->fsx_cowextsize)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
@@ -477,10 +510,13 @@ xfs_ioctl_setattr_xflags(
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
+	bool			forcealign = fa->fsx_xflags & FS_XFLAG_FORCEALIGN;
 	uint64_t		i_flags2;
+	int			error;
 
-	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
-		/* Can't change realtime flag if any extents are allocated. */
+	/* Can't change RT or forcealign flags if any extents are allocated. */
+	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
+	    forcealign != xfs_inode_has_forcealign(ip)) {
 		if (ip->i_df.if_nextents || ip->i_delayed_blks)
 			return -EINVAL;
 	}
@@ -501,6 +537,12 @@ xfs_ioctl_setattr_xflags(
 	if (i_flags2 && !xfs_has_v3inodes(mp))
 		return -EINVAL;
 
+	if (forcealign) {
+		error = xfs_ioctl_setattr_forcealign(ip, fa);
+		if (error)
+			return error;
+	}
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index d0567dfbc036..30228fea908d 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -299,6 +299,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
 #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
+#define XFS_FEAT_FORCEALIGN	(1ULL << 28)	/* aligned file data extents */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -385,6 +386,7 @@ __XFS_ADD_V4_FEAT(projid32, PROJID32)
 __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
 __XFS_HAS_V4_FEAT(crc, CRC)
 __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
+__XFS_HAS_FEAT(forcealign, FORCEALIGN)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 6fde6ec8092f..a836bfec7878 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1467,8 +1467,9 @@ xfs_reflink_remap_prep(
 
 	/* Check file eligibility and prepare for block sharing. */
 	ret = -EINVAL;
-	/* Don't reflink realtime inodes */
-	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
+	/* Don't reflink realtime or forcealign inodes */
+	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest) ||
+	    xfs_inode_has_forcealign(src) || xfs_inode_has_forcealign(dest))
 		goto out_unlock;
 
 	/* Don't share DAX file data with non-DAX file. */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 27e9f749c4c7..b52a01b50387 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1729,12 +1729,30 @@ xfs_fs_fill_super(
 			goto out_filestream_unmount;
 		}
 
+		if (xfs_has_forcealign(mp)) {
+			xfs_alert(mp,
+	"reflink not compatible with forcealign!");
+			error = -EINVAL;
+			goto out_filestream_unmount;
+		}
+
 		if (xfs_globals.always_cow) {
 			xfs_info(mp, "using DEBUG-only always_cow mode.");
 			mp->m_always_cow = true;
 		}
 	}
 
+	if (xfs_has_forcealign(mp)) {
+		if (xfs_has_realtime(mp)) {
+			xfs_alert(mp,
+		"forcealign not supported for realtime device!");
+			error = -EINVAL;
+			goto out_filestream_unmount;
+		}
+		xfs_warn(mp,
+"EXPERIMENTAL forced data extent alignment feature in use. Use at your own risk!");
+	}
+
 	if (xfs_has_rmapbt(mp) && mp->m_sb.sb_rblocks) {
 		xfs_alert(mp,
 	"reverse mapping btree not compatible with realtime device!");
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..f55d650f904a 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -158,6 +158,8 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+/* data extent mappings for regular files must be aligned to extent size hint */
+#define FS_XFLAG_FORCEALIGN	0x00020000
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.31.1


