Return-Path: <linux-fsdevel+bounces-24820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E329450CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF5C1F28A7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305391BA878;
	Thu,  1 Aug 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DpGzJ+4C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZLkW838D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979AF1B9B4E;
	Thu,  1 Aug 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529988; cv=fail; b=d/xCaYOmsPSVkZsPth1Xt8IprqpQotqVlGwP8i7lJCsRjStGuLi0BtUUQxS0GXwvb+EPuApo3PTvB2otcE2/v/w/c+5FH37I4VeN2a0TzbW3DXk8kqEBoli5wM00Wba9NJFDWUdHocrfzR8vEuHgdnkjO97Y9cGhEX2R6UCdzHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529988; c=relaxed/simple;
	bh=a1jehRnMmuVsRrguzfau4mgpscPSWewfzNhtTSXK+y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XGmdy+z/dtLyTOWL13oholUBaKUEyW9+85eMGTFBwK+tvFZxbqOvDEtw9elxVGfOQmEhWadW23NE5Mc1GqQSnesCWo0SG/24uNVG3GG9vNPLnqtyKDnaAuAZryamnSRiGEGbcaloIT06Vif7+mzeXhzXCMVutYsmXhwrL7OiSZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DpGzJ+4C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZLkW838D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtY1W010833;
	Thu, 1 Aug 2024 16:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=8d0E1NCt/EKYL3wXt0IKGbAO3KgnRxvtKCwZkQZIxFY=; b=
	DpGzJ+4CshFse72ri4tZSVFumCbC42+4zboo8eXYUNiYbTDyLojxr+N4Ulur62pf
	e7sz0oKEre7kx1HY8LkCXujdk2bqVR+Z9usqHjRXwhWwdLG90MGOZk+nwZLnDsD9
	jpjPFjcfsmSbqnG1YHm1oMtk+76B2s8juU1lVqNnKxzGF76Ww3jHffDMT6oPMHxy
	K9hStQBbhPZuIipCLbMc95hApgdVU5RT+zrrp5Z3JqsqVCSkAvPtnNzRv5dbJL9Q
	vgpWN7qnG6DDdXDOB0/B++vezVMk9IbJqmbmIVID/Awmt+DftVgWLgQFL49BwhJN
	f6k6oTWLPVTm/bqzn/+1ZQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqtat9cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471FWhLM035584;
	Thu, 1 Aug 2024 16:31:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp0es85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ct/QIVTdElfFs1Xnm7a5KBlz4atd/ixjh6kNChFaXjg/QOY7XUM681Fe5RDoUM7cI3h715BETivrGcsJGivqTTFVHCmAGeqfXjSAs57OA6spxL0CNwh7WiufY/pVnvamd7wB/8WI1c9Q6xItTNKd1fnlj7DdNj+6D6CuDdiF0JzpKld4z87ToWBaL+NRfVELeyVSqRD5N7HlgF95VB4rZ6WMz0lN0MPAH2cYuAdYNQML92uY4N894/DwUQ55ptiG0y0dZpkHVqyjM+1bynvC6umPb/NRorZLdW8PqN8HZRFxip8j3wpW/4ZWS9ca0cg6CawmvvY2xqkcmhn36oM+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8d0E1NCt/EKYL3wXt0IKGbAO3KgnRxvtKCwZkQZIxFY=;
 b=Tae5Ekdu5+zRMsucftaVWKvb9Cbk8sFMdq8bjJzYa33cpm5GGcmbOJnPRv/GVwVt5ZWGK26pERVKbR4BFkIGHREgFYYRvOaAnuQJWTrU2nB2W5GSLQ2AScRJ/jD/u7V1ziQajthxTp4vgs3YE393Hh+cI1A1A2dXcWi3+iPy8XmwfwytwV3NiT42tf+UWmLYQ+81n0CfECKf9wGBGxL5hXordYols6NgaICw7vBB4111mDGGKVKA+lZug1ntTTv0FNSaFOiZnKNcytFGZgkTjx+HY4hCcuu4DCXp3g+Ws7P3MKh3kpxOUMc8KLvDo6l4/n0rOCGlYKfWMQG5NvprkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d0E1NCt/EKYL3wXt0IKGbAO3KgnRxvtKCwZkQZIxFY=;
 b=ZLkW838DWVlLw0/c8JWSQVjum4a/aJmJUxnwd4zBVABDQ9PeChECUFMOMpLylJo6jSfXGiaautqc7T6Wd0CZ4WpXK0XOT3pMDRsO/7y8LvrVIJNROH4AyGKhPd9iZGmh/wkD8fDsPM840gc75B2io7SeMWPKfBwxdHsJ6BfvsJU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:47 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 07/14] xfs: Introduce FORCEALIGN inode flag
Date: Thu,  1 Aug 2024 16:30:50 +0000
Message-Id: <20240801163057.3981192-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:2d::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: d47d9005-dd91-4354-c63e-08dcb2476fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJDTkozl4WcmA8g9WjNEYz/HRszQLb1ZsHT/n4YSUdRyKcFqUcp7sLV7b1+r?=
 =?us-ascii?Q?TxXL14Ke6PX+I+aY22gINC06VxSaFy83qvbrWfxUq26P3MnYhfAeNeOFC89W?=
 =?us-ascii?Q?iAjOt4jus0nrKjoVLvmrp5A6F+hlacnFZEd17oRiAUNQaa4YHW1DHOdXk6U9?=
 =?us-ascii?Q?etIVlOqoizPGKJG0tav3m5oUFzFtjBx3ASyNLXFKnupNfQj0SWOJoFeiSke+?=
 =?us-ascii?Q?zrHT5oo9vowphOSQ0GXk1EkmKwEZ6/e66nRSCv+Zj2smsFc9Pqs3KsC/pCYW?=
 =?us-ascii?Q?tbB9krQ+qfeiW37hnqXB7YJ8ySkfmsrEyB/zN8unsSpBuUFmZPZUqX8eWff9?=
 =?us-ascii?Q?0xORmeYMHN6YOQ5porZtW/VWTecQ60DgKx+s84WQ6K+RRAx+oi3Jk/eAq6NU?=
 =?us-ascii?Q?rK2sjNhxp7Hr6rJZRBVTfi6mGpZzO0SJVgOfDv1y5zy3kwZwKPpXVlHBqnzY?=
 =?us-ascii?Q?8mdXE6JEPLGZjA2esK1EJ4EhgxZAImKL+sYts75p8y3/bCpD5H+wf1NlUaLe?=
 =?us-ascii?Q?kaK0HG8OF30bU9pz050qlTNCqSGT9QaKs773F3aLNqNQRoYvC5C5Z9ZBG/yl?=
 =?us-ascii?Q?HZ1ZaNl97eGMDQfziJeEHmaQ8bOQMt4e05ceM8sP9kmB1uw+aV3yzYEakr+s?=
 =?us-ascii?Q?zMAIPd9worUCq1dABrJOsZigwdtYgISXBXOgAyZR3BcKhYBjyxoMAtFH1CtB?=
 =?us-ascii?Q?c5MSZMmiRI2zEg+qDoCQYkTtszYYTnInXk68FKVCOPkN2XDaIQgBiy3ejSB8?=
 =?us-ascii?Q?kqaN9/QHsKsUa9CLW8VwTeFBy2Ic/tJol3UPChCPilmAlOP/vmsk8dVjbP9H?=
 =?us-ascii?Q?f4BaWd2/FAFKtGrlj2Z8Crc5TosWxKoPGm0wIMfPiWa/sZSyytMO2GkGBAC7?=
 =?us-ascii?Q?DMVyMGJtKi80pccWkqEnpKUVQpgnr3l3SRFvR6qAzfMUK5JJhIJ9zjS4QX/x?=
 =?us-ascii?Q?YCBnFxp4G7VLaq3nsDtCNkmVrb7FNzgDo4/b9JLZOmF1XUUGrs+EHNhPVYt2?=
 =?us-ascii?Q?Wzj+ugV6vL+4D0I2+MoA8F/uyNOZFWUuUo3gSr9Gp6C2HvBnsiBqxdATm4it?=
 =?us-ascii?Q?TX5pLm9ML9UL3lVf1Ssq7BiAKD7KDAASh/tv7/qesWICcW3pSm89nkjTekkP?=
 =?us-ascii?Q?dnJEA4KdaOX+p4QAtMJnrxwkcXEwd6dg5yWYKNd2HdVMQVhlUjD+A6MYTEUP?=
 =?us-ascii?Q?aod7hW2Qe5lgaR/DynauVeayquGM+c+jXSAqHACJxp0a99/JqkKrRnQJsGcd?=
 =?us-ascii?Q?y260qKjf6j2ca4WGsdckWWIJRuE8ZzTawhnzkrJD2QB4V5XaIp+g9qo+39tt?=
 =?us-ascii?Q?SHP6OVWys1vEfMMN+V0SwJZxisoBNdnA+qC/Mifzh/JAkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QQEvUzAHTM0HV3sMrhvI4Jh7hultqSL9OehAvDZS8OytiJfN8nDh+tExll/1?=
 =?us-ascii?Q?0YtEy62sk/AqMrlBJ1lhpJbj578pltb0E3J8ED/Vt+rJUunSXn8GpCP/oPk9?=
 =?us-ascii?Q?mDgK1XQHAg7eTdSskoy1YzG3SX3Xxlgk4pnCWeYdhllQwvLZhGrrWd/2LWCr?=
 =?us-ascii?Q?zOHj6rxkrahSlazOA65C4odRQiOx6B3ApcGy6JPyeG7S8cYGsKyEXuGY5t8e?=
 =?us-ascii?Q?/TUSZCW1n7Cj6jHhhLwCmIVsmjRzPosE9gW6Q3dBFru95FJ7ivOaDq0NPBcC?=
 =?us-ascii?Q?raJUQ+6rqpIg6uJ5wtTVKtCM1sIY0Cr2KNBFinLkC3C2fil2oTM9M2ng0R5Z?=
 =?us-ascii?Q?7ScQ8LDsEUyUJc1gx3axuK0L+/FbyKTpaO6VbEU6p1aCHz4P+pNGI7qGYVBv?=
 =?us-ascii?Q?o/bO1fvNIf9DPkw4XaP3TKFJ1Vs4PamV+Ur+aw7ohIftYlavtOwopY/jyhA3?=
 =?us-ascii?Q?ISmNEGUMejnU1nG0j+pXPAO6k9P83qsBucmZIti2yiQ15rXQUoxivVlaiZB9?=
 =?us-ascii?Q?BARem4XRGIu2Lzi3h97AP9ejiviM9zA6csG5DweWYpIW5YgPbJjdbURrE9hN?=
 =?us-ascii?Q?RXcM3paN5KBz8xgo92+tf6zHH1WjWGOl/qizjaygLUEmWPtzePw2ftHGAG14?=
 =?us-ascii?Q?OtwDtVginNtavpOwPHsuo9qbsj5lNjt1SPY+u9w6T1T66KJwtmh4IBZphpPc?=
 =?us-ascii?Q?CupDXtdB8ajT6sYxN6dSGHcQE6sZ1G6KA9Erj+ZX+r4hsXRAmUgzYO+Zg6Ap?=
 =?us-ascii?Q?pjpvPnQKT0fNqXt9TS1OhZejd4Gkd+/T4sV1UAGoRDoThR0nNZyPs0xG+lTs?=
 =?us-ascii?Q?cxMNSewX3PzBwTPIX8FBYaCJh0d8JQ8d+lM9spSaGT6Y8u4sXRoMIdbeE0X+?=
 =?us-ascii?Q?6DLZL31Ae0514UmkwqRjR8iXKBGLYWptKLY9XEezPrRopPPm7Nnubi2xAc3J?=
 =?us-ascii?Q?9nWxHeKI7GcQfg54okxWNcza1tQjk5SpLSVE0WIrNCztF30xwjJzRtmqYWz4?=
 =?us-ascii?Q?A3CziLlJEna1UgHuCQz2RiZu4hToN2WDaT1B5VfniUDi+mYHYGsZbaXKbCG7?=
 =?us-ascii?Q?aXIECYabQDAj8sa6va2opeLf7IwpZQyBrVDoqFomeLaq+hpgzkThHbMxY0yl?=
 =?us-ascii?Q?Aba5TIfEPiEfU4uMfaYuQzVH/og+bXoCsfchjLRldr2oTDLTMipk8pJd2gyZ?=
 =?us-ascii?Q?n45DaShtRoo/Z9Ng84ZdZLD8u4tuxy7jyPjPjhDWmptLi+NVgp8+ma6cGNgm?=
 =?us-ascii?Q?vjIMSPDHF8IyedpcOoV/mIj/9r9Q/Fr5PCpYEimX+vUcj4UUNwau+unO1Jh0?=
 =?us-ascii?Q?tcFEpOGRSWZ13XvHnYIdhttG7Z3RoTqwAc0nbSm5vBQjXTLPAxVQrtaPsdei?=
 =?us-ascii?Q?S64W62PH3kp8znRaqduo+ENumUATID66Xt3IJKxM1hK8dmMao0FbJr3VkOZw?=
 =?us-ascii?Q?r6d/2Nam1+M9E2utwMydiG/bADNW6gxKX7wX9hmWjtlB2SnuetKnf4Pi5VPD?=
 =?us-ascii?Q?gWA0dqhftJdwsTMBYjsglKR0D7iSwBaYbHIAZBF6BGLDxuYlVYtw+ZdoyB47?=
 =?us-ascii?Q?8iIT8ddSso3et5o6wntpIin+/JP7ZlsKdVKHPrDt5s7BwGRaq8ljRp98m7DZ?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5JCJnL/m4qxBFljXPIF4X+WWfC/i5nVU8Sdz6GZ2bHzuZzgIjaOcZjzvcwzaTlwmtN2zQnWJCf/4ydsKSLaPwz0GioujwrtaP8YN1olQfwLjB7vOCjI2ZuabOIrXWqastPYqbj60ETLR5ac3vn7y+LR8zL00ea4dt6ZUPZzOXdpR463ZEDydxsUDxIXnRKDX1SDkX0ALZID3FbdiX7Tq8LQ3iWxQwpZuEbm8VjAmi/R1hLL6Hx3t+12nWoAGqNeSe8zsKH2R+GNdWuu2b8lebFDxUdvwQdZwpASXoA91SzbgSebFqYJl3XHtcEtM3oVWan+td7fLtT0QnmgptQBJoSiPS86aQPiZL7mb+MPk+49dhpEwBfCs9CepF8eYi74EkPOh5wDHP1X2+rZQvc6t3XED5pn4d/GRPOplPsSr1j9XmY6vNgVMDG+ChKKIEhxpEdSC2IxpQddhWQcEEqkPyivnJ8o+HtOMyRbmRVl6glbp5kJ4r3VqWIIaWoxUaj5IiZHFszs9hLoJ1At3pIYbRIlHxgz0/FODS9gQl3yn6i+OOyS4xVsFCyAgRbhxYDKikOHErbKcvkXGIxDpQaQqr0kWrm1yaOKP3zW+peujLHM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47d9005-dd91-4354-c63e-08dcb2476fcf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:46.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFR5C6MKsM5Wqe4uHwlc25DpVzabYQ7Cgw55pyT01EJedpcAMnvtXZ6aVjI9dxpN7asLee60QtGski7Iho2jpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408010108
X-Proofpoint-GUID: X1U9ClZb32VE4DpftoKkLxUYFVU5tm8u
X-Proofpoint-ORIG-GUID: X1U9ClZb32VE4DpftoKkLxUYFVU5tm8u

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

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Co-developed-by: John Garry <john.g.garry@oracle.com>
[jpg: many changes from orig, including forcealign inode verification
 rework, ioctl setattr rework disallow reflink a forcealign inode,
 disallow mount for forcealign + reflink or rt]
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


