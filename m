Return-Path: <linux-fsdevel+bounces-43933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ED7A5FD7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7391517E9F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F7C26E977;
	Thu, 13 Mar 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XrySqdTR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CBbac9uS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483EA26E947;
	Thu, 13 Mar 2025 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886100; cv=fail; b=X00wIMSv2zRUlgUKrkS2QsoKg6L/3SvcvOmoDAr3pxTmq1V5cs9fbfPxyeosHmOaVfIBVZW13X3Adey4JU2CFTeNCNsxLsLLsKIc9JmhypUS4JalBb4MqE1yYqosTYAL17mQgXfOPj64QQBCCjp3K3doqhKKISViONYCI8d/aTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886100; c=relaxed/simple;
	bh=uSdZDsz7wUXFvzJBPtk3oLIdsy62Qj8JN5Io+Mv29J4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gTdywFmzFOJlhiQqsecthTMCCB9Fgxk4PCmGxGFPjFxg9NYGVOK49a0UDdIF2BhRQR+9wEPLOpbkMXLDBgNt+swMnxxUe/slReuIhQJksjM6X95zbPb6ZI+W0gCVYmt3EYE7jC1/MX2W9lU9BvkgLspxiFpAn/L3z0o9aoI76KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XrySqdTR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CBbac9uS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtmiK031863;
	Thu, 13 Mar 2025 17:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8i695V85z50Gd4b4Eoc7L+HS8qVP4JENNmz+bKCP6jQ=; b=
	XrySqdTRSgBQytMmNs40jUlcS9QRugsMJLiqAPIviYSS79K9lwSQTnCz5gLqmkB5
	IzKtGhGui3XGGToUSDLqYLUU996cOJVJji+8htr5hwNDI4sYHMmG7ZpF+4b0DqQv
	Gw+PZmHiaQJ+oYYj9hXIjM8ivGCzn8hLAQX3OyjgWSWORnaMzuMdmUwnJe+QwChx
	VR7i0y50B7VrGDVrsZYXcjDAM4X3hTMnhuwJgNwcgxN4jTYauk+nnGrDANGghAZQ
	ITXpiTR3sAEc/fG/7DRFBndZN5tjEyIPxdi1hT1UbXeR7tHCyCkUnxIte9s5oiMj
	F2WTDa30b5YvyvbvMr38RQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4hcsep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGQFn1003795;
	Thu, 13 Mar 2025 17:13:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn2e3tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY7kZRQZ+4oaOXsigLQNVJvlIa6o0RsxbyrB7XY4/XV4vp6Lg1NZJrYjqHkWiNW1/JIBTSYsCLA6foSM823Cx3R/eX7sZxeYc/ElPVfsWymsKs41TXbwpf46NYWt8xpiPkblgBCmad29Y1gKl1sCeTS2TPhqTRUuknsL1xelZ+HaCvmNFRM0CIdCqoUfSFpxbXWvZGVzcdrZmLWB9hfvyYZvk+VYW5FkJAS8q0tTp9vLchuVQKR0KDVEEyzTxZv7Nmd62gg8ju7K8MrSSQG0iiAvnp6Q7INTaacXL9vzZhQpa+QHwPJ5N61WjwEigWp9H03RoNVeFiNfLzuKUPI2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i695V85z50Gd4b4Eoc7L+HS8qVP4JENNmz+bKCP6jQ=;
 b=BJ6/r5g9bTGZ1+OQgK4m5Z45qvxBSC4y/QJ3UKMuqXLwYykurUh/mglDVf5iZ6+3FfuUEJuUvsL6Vr+0BHYsL9L8jf1FblnzT5zbY3QKE4Xc/hBWonUhZ3F2YRSfIl6rzc8ZRjhzDgw22sZvPWyajHo3NHuhite6cQHTgglgEal7GsUhMsMJQJcNy2wYo/s0+hq7YdbTRn90wkAiSqxbbn1AqiQeqP2ooxEdLn1VTK0s0a2awEiTP5WK4AhrR4roU8j78kWfQ8Zy45I0Iuz2gibyHKslHprcvp8tjD0o2RMSucvoKtWwTJJclgz5GTDla6yMjSA75ZRJq/LEdf/p8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i695V85z50Gd4b4Eoc7L+HS8qVP4JENNmz+bKCP6jQ=;
 b=CBbac9uS7Pw2j6kaPAFbVojedl3MleitNLz+8HMCZDv7AVkuCVYoAsO/QblzZ927KV/XNk86XPz+P0coMq8LFciadxnMCacikQ7fj0LdgZDYXD4QG58COYQyp7urRG+5loqOJO4I7f6cKpZLNRl0hBJpoGdhz8pQJ1X6IwPKaRM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 17:13:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:43 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v6 13/13] xfs: update atomic write max size
Date: Thu, 13 Mar 2025 17:13:10 +0000
Message-Id: <20250313171310.1886394-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0648.namprd03.prod.outlook.com
 (2603:10b6:408:13b::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN0PR10MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 64db504e-994b-4c0a-14b6-08dd62526885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TA4mqskEFr3EhOgUGjGUNCg72S83kkbxNNAepML70KrNXKkQFdiHhjlZfXvb?=
 =?us-ascii?Q?m1sVUcFkd1V7AQ9jv59NoeP6LkQlpRPHLSx7kVwYqwj1tXh3MkJHxvZPz/B/?=
 =?us-ascii?Q?EJ6bX8/a1HYsU3nOz+xramawk92+4XaRJVs8m3+8eoewpfREp4VS5qT9OPLh?=
 =?us-ascii?Q?5B7RUlZcv2G76WPIHbBg8+6aHD/34eb4mnII5dj1tjxTrq7sT9Ht3IE8X5mD?=
 =?us-ascii?Q?M20bQZApms/WsizgCqW9FXuheGrG5YcVPuC3VEet3VhGn+ekRAQUIJ85Xjfz?=
 =?us-ascii?Q?8PVlyS6V2VjScP/P46uv6Fa4NyM85+vBCTkN7COkedUnNU0AYKSVNAESWI02?=
 =?us-ascii?Q?Q19jkc3Qek241rh2tzvONeXetQ+XVyIpsJct0+u6J7gB2Q0b2HAKYIydT0sU?=
 =?us-ascii?Q?VNa3TZhZ4/Zq2OB+OZRZb3ob7hEdJr6O9+IAqs0f6Qkbkf5d3fUBV48l85xq?=
 =?us-ascii?Q?v6thH6SqlqqS3v2BqtHtO7/47MgTG7uQ4R3+S0QDsNpFxzymXap66g/lqmAu?=
 =?us-ascii?Q?ElyZmkexXgWR5iCrs0dBK9XNjWQaotX5ASkIHYYKsI6fpIjBRyCCLyRCl0FZ?=
 =?us-ascii?Q?bu4O9BqZCpNgYmC+iOifsL7teSLqmeeqRWmdz74buWGxNGVoxATx/706p1Co?=
 =?us-ascii?Q?2fBbH879dei1+IZTY4NakaDo6+n1RQamLiSxsSOVTXWmAPMYFwPERRlzwZo7?=
 =?us-ascii?Q?kwehjkumwlbYE5gt0Hyq0EuxxBx3EPhVqUPXc9+Oc/YilceTjD/kI2u+zme3?=
 =?us-ascii?Q?ZOQgThLRL/w7zTcwVRDfl9g3wGxUgllxvS346QL+3jR4OQZHF3EKOaT0sVUo?=
 =?us-ascii?Q?3l6T1341dbkBO9+zf5+9ovdXlX1v6fABFSUibwKaWtJO1pptsYcPEEE1UKFc?=
 =?us-ascii?Q?AX/we6+JGMMAt3s0WoZiZOVQZTvwjFlFPjHoCdQHT1s+Z5G/W+07lc5ZuEG5?=
 =?us-ascii?Q?cV0cbFSFZ66urEyDcT6wBjLo/bpYGb4zlwfXTf1q5/jnyFy3D1mJv2UHMJab?=
 =?us-ascii?Q?ir9HcS5VDNdnMV/bD9rKOvKAZx/i+SZhz6s6oCYWutj8fCFdCRFH+cp/weGl?=
 =?us-ascii?Q?gBlvT4NM11lbWgzmyFsXnj1pk7GUtwvCQy2Sr0MVkvT+NiyF20CR4sk8zUel?=
 =?us-ascii?Q?AWG08IsYESYlCsvGgNVX38yQGD7Jg80zIBNBFGOS/EtLoDYt70ujM9/L0MYn?=
 =?us-ascii?Q?Wq7nFno/aedTIPIjs7dSJdKzNPAVaX28/9Wr1aCKaFg874NR3cvowxiw0Jr2?=
 =?us-ascii?Q?4kIXrf2skhztQF+oNj2fLGLHPlSnOZT/humfmR7Wgqnd+x16rzoPlQrQ70oO?=
 =?us-ascii?Q?/cHEkFXCCskAdaMCfgt+T1dQThDnXiBCacC2Kt2CydoT2KI94tBW1kkm1nxv?=
 =?us-ascii?Q?URm+lhLA0kuSms4191WxhJriEe1O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uz3wcbgvo4c+kW+5ypkA8/4bUyYfh/0csWenpCV3aXscn6WYQhfSll38nbJf?=
 =?us-ascii?Q?q41VIDIGSH8P8TCU2SIM9JOIXPp75CBGygMw7IBLwxPO5zoe6OCHEC4qAHZP?=
 =?us-ascii?Q?lxg5SBj8Pi2oNSghj+rEo3Th9AMxbLEavq0pZp6spy9Pp92uEqP7bqIARZP5?=
 =?us-ascii?Q?+qrbrklk3hvaGzGwSgdGNXZCFqMd6MVfk2ND7bmdJaah2B2lFChYvaIqIkcR?=
 =?us-ascii?Q?18G//iFc8tooOic7QSM2+734a/cOFVnPjQbfniRa3X4yDm9d3k2h8LlGtX4k?=
 =?us-ascii?Q?JoAY+QOrRAeME5TzSC8yskTY/A7noB5zLJD1myhoQ1NjfIKhZX2+SwuqoKpU?=
 =?us-ascii?Q?v1+MjG9L2BvzOtXAITDf9/4iIBC8yUl87HlFzFz4Z5nIgwoxHi/cC3fJuWZ7?=
 =?us-ascii?Q?dKrC0zBEyASPzp0/WywLUHnR/wTSZn35/Ow5TQXJARaV6cMKpfHRDF8eWHL6?=
 =?us-ascii?Q?wLVOiZ2IFnWPvBWfG0xoP+jQ66Q8/6O3/LxOH52qfWRd9UMm2fxy5DyDTild?=
 =?us-ascii?Q?BxNXFRB8TxGhgGZ0pEcCmDN98YGzk2wca1y7tJaX1LUFNF+en5ohnv9+zVGP?=
 =?us-ascii?Q?4uT/gBeynrQIJdMuLwAAvdBDqMuTI3/lh160JCJciWjxbTHU0dBupH5tNO4z?=
 =?us-ascii?Q?hayWS5mtF9d5Auskz5/Yptn9hAJde8J3/5T5EiYzqB9LwlnngVB9M3BHOF0O?=
 =?us-ascii?Q?9L791mMSO4Oox7hQNPdYar9X+ybdFflJ3EeIrYljHedpWbhXRdhtNQ4wZnTf?=
 =?us-ascii?Q?z+H9h7Ty5dHiKGPVGwpntIWobPAF/tijmea0FBfzKWqisfdtIjNzKkDLE4hf?=
 =?us-ascii?Q?sCitMG0JFkwhTJpfvYIbn8D3SqWTb2Naxp9i2UMvtzIcBVyH9y2NPk6YOl2t?=
 =?us-ascii?Q?xE7klR1O+V/xbyG0TKGIeEhkM87PHjbTo69hC7b8+iHvzycXjOvzLI9U5ql1?=
 =?us-ascii?Q?srYcH7b+s+ilbLxSwolaAUWZN2M+Yjdx9Q0b8qGixwJBbrCgLGI0fsx87lGo?=
 =?us-ascii?Q?6mcIA8o8exkoeEgIHjoLgJHLeRxLYBrw7TKyzYBlqdxm7SE/nbvtytOjiuof?=
 =?us-ascii?Q?tKl7smtWeBnL/sBKvZr6zXWo7VASCEExstd3Lec7fQSrbHbbyjui9TK2RzeM?=
 =?us-ascii?Q?Y5AHDKx67Ajd78ImzVyXCxHnLWGDTJVNwWsn0JPzDQHgZTUH018ali9GfK5t?=
 =?us-ascii?Q?PIZZAjrHTOpPDGv/gkUW5BuDhkIUjfw5GjsT82z4G2fmuRD6GJ/LaS/Ondmb?=
 =?us-ascii?Q?2d/t6f4EX22NNdAQmgBVMH7RExsP0Dh47x8HmXTRT8OIJkJxmI4lMPUbaF56?=
 =?us-ascii?Q?RANn1WAu7tnu34QZ049Lsfd6oTBzc/fdCA/dGXq+WPk3vF4dbBotizIjDpMw?=
 =?us-ascii?Q?68HxS9vfhDvs7Jws+zDuRneKW9D/9i32rr24HU2IEBXRgoD5BscIMndBT83K?=
 =?us-ascii?Q?e9BBS30mStnMCJUDbq6nMv5cA2eAyr3WHx7hwhiACnXh8awbRQPn3TsWBz0K?=
 =?us-ascii?Q?/WsSNX40WldYR4gmLqKrK1z16solBy8cGRTfGVWZZBOaycagjEfIZsf16YAf?=
 =?us-ascii?Q?sKKukSj8JZrE5TKzXwI3mRTJCGmaAG6Sc28GP0vfzdol31JfmAr8rimOGIE7?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OOkTld4advz2AXmu/qqu+tcjHTFIaMB2cT11qMmtHIlfoFzFExQjHBdG4oCJ7zyNnImB2/ZOkhUN6lfA+viENeaVjY/DX0KahCbzBCAI2tvK8M0dtG8Y4CsyI7OwxqcemxEWR239OSxDPbE0GocrTUMpzJ/lpkiBwJloGTiNcm1pgUVNCJ2SQnvrpGlTO5R15eP4ug/HBOjsQKQxewL7J9LCj0WirAQTmroUAJjJJr3llGCeTSp3kqr7m0g/V0OPHV6/U46IaaZwrE5J2LAKRiKz4f1xPGGfnh7ilNFxQARvwl9FXC8X15WVBZ8hgvgNssk6qAvTBXLSu5WtWB9JCUH3KNwfSSe7CgoMZ05/spruxQh17iDEq+j8aQir39zKpON53Ei2GFiTASDn9rxyl7BbMCQUjfiww9oSElhHwPheUFiFRnwSWHNsDSo2cAq4O915O9u9MHEhTIefB7UC33BXYImmuoZPZWltGW54Q5lNzHgm7fAabH61zP08Pvvq1zsuy+IBhQl+5bGB52wFbx8JaEWoAFOPdG2VzatInF3dKBcYd6s2NzjtvU69vo3Muvao9ggk0UBH0qWe+1exIlrBJXeQeny2epQxHMDnzr8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64db504e-994b-4c0a-14b6-08dd62526885
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:43.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LO3ChwujIHXgAwx0FQD6ipLLr3x6DdFdhe9nTSlwuyVpqE3rLZDfRpH4RfC2j7yoM2KzBXkFOD07Ml2+XfuWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130131
X-Proofpoint-GUID: rZ35P1BLJX9pNfk-LBcFeXGgZZ_3es3f
X-Proofpoint-ORIG-GUID: rZ35P1BLJX9pNfk-LBcFeXGgZZ_3es3f

Now that CoW-based atomic writes are supported, update the max size of an
atomic write.

For simplicity, limit at the max of what the mounted bdev can support in
terms of atomic write limits. Maybe in future we will have a better way
to advertise this optimised limit.

In addition, the max atomic write size needs to be aligned to the agsize.
Limit the size of atomic writes to the greatest power-of-two factor of the
agsize so that allocations for an atomic write will always be aligned
compatibly with the alignment requirements of the storage.

rtvol is not commonly used, so it is not very important to support large
atomic writes there initially.

Furthermore, adding large atomic writes for rtvol would be complicated due
to alignment already offered by rtextsize and also the limitation of
reflink support only be possible for rtextsize is a power-of-2.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c  | 14 +++++++++++++-
 fs/xfs/xfs_mount.c | 29 +++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h |  1 +
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 64b1f8c73824..7c22eefd6b89 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -615,10 +615,22 @@ unsigned int
 xfs_get_atomic_write_max_attr(
 	struct xfs_inode	*ip)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+
 	if (!xfs_inode_can_atomicwrite(ip))
 		return 0;
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	/*
+	 * rtvol is not commonly used and supporting large atomic writes
+	 * would also be complicated to support there, so limit to a single
+	 * block for now.
+	 */
+	if (XFS_IS_REALTIME_INODE(ip))
+		return mp->m_sb.sb_blocksize;
+
+	return min_t(unsigned int, XFS_FSB_TO_B(mp, mp->m_awu_max),
+				target->bt_bdev_awu_max);
 }
 
 static void
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index e65a659901d5..fd89cb7a83fd 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -666,6 +666,33 @@ xfs_agbtree_compute_maxlevels(
 	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
 }
 
+static inline void
+xfs_compute_awu_max(
+	struct xfs_mount	*mp)
+{
+	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
+	xfs_agblock_t		awu_max;
+
+	if (!xfs_has_reflink(mp)) {
+		mp->m_awu_max = 1;
+		return;
+	}
+
+	/*
+	 * Find highest power-of-2 evenly divisible into agsize and which
+	 * also fits into an unsigned int field.
+	 */
+	awu_max = 1;
+	while (1) {
+		if (agsize % (awu_max * 2))
+			break;
+		if (XFS_FSB_TO_B(mp, awu_max * 2) > UINT_MAX)
+			break;
+		awu_max *= 2;
+	}
+	mp->m_awu_max = awu_max;
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -751,6 +778,8 @@ xfs_mountfs(
 	xfs_agbtree_compute_maxlevels(mp);
 	xfs_rtbtree_compute_maxlevels(mp);
 
+	xfs_compute_awu_max(mp);
+
 	/*
 	 * Check if sb_agblocks is aligned at stripe boundary.  If sb_agblocks
 	 * is NOT aligned turn off m_dalign since allocator alignment is within
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 799b84220ebb..1b0136da2aec 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -229,6 +229,7 @@ typedef struct xfs_mount {
 	bool			m_finobt_nores; /* no per-AG finobt resv. */
 	bool			m_update_sb;	/* sb needs update in mount */
 	unsigned int		m_max_open_zones;
+	xfs_extlen_t		m_awu_max;	/* data device max atomic write */
 
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
-- 
2.31.1


