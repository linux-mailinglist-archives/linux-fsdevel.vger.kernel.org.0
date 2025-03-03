Return-Path: <linux-fsdevel+bounces-42975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93829A4C98A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8905716948B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413A32517B4;
	Mon,  3 Mar 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iyycfIjs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xUU87H9D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4A251796;
	Mon,  3 Mar 2025 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021904; cv=fail; b=evZ9PyH3jKCsML3qZf+ciMq/+37nP1bjD1asJN3z5CHm+zFB1aAyvXfiGcKYFdmj/8qHn/2wA8GbxD6aykpPEJK/HaiIr3ISUCTURcxT5emJVhzQYxMv2nxqYEiXIxNGCKRm2x+g5heAxMFBcPSmrndc0u4pn1EaR2dUyfio/cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021904; c=relaxed/simple;
	bh=5rc7y+9Q4Uv0CzoCMnMFpX9taqnBGuFdf4ccQMqZsD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YofmynxZkzOWk02dP14dO1c/GoJwmcUsKyXkXR1POFE5Fp3ICD+M8YAkNgzgjHv1aYugaAjHi51AlzlA7dWTHxxOmt11eSiONCii7G5EV8AiIgDATyNlnyV5C5iow2ZEKhTldQNxpEopvyUVDP0pkgCwcRfi9TURs3IFbRxIydQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iyycfIjs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xUU87H9D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GP9ON006971;
	Mon, 3 Mar 2025 17:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wW+iH6Y6zcSlX+jygh8CPOrH3MA3jK2pXCc0UAtbv7w=; b=
	iyycfIjsSsNYQp/YFtuc53tkx8TYN2rr8iTAM96FjLfJoKuREmcS4Sd4Rx5/F2Zw
	WANMc0+Uw+gEY4zTHV3/W8qgNx9yD5f5FUVaAmcK/k9G6d90lreWi6yWorqvnNr4
	nzqtH7/0ihykYg83147wqPW10Ulyk+4dhpTQnjocr0F55lgwG3Y64xbt0gZpIXSi
	xQmOad1Winy87wVBUiXDf2sqFKB1MvkCn7iD9bCpFHnC7hAgPlaLI7/RNMWKPcyo
	k1d+wEkwS0YeTXW/RFp0tHbLlg4z/U4FsoGCO1NrrAyPxKtPtJC5pQUt3JHceBF0
	MsIkU/22MTSuQoHOTPOG3A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub735w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523GgURq003162;
	Mon, 3 Mar 2025 17:11:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7shjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEQS47NzVJY95iuPVn2199wolKWuGFgSj87Yp2qsixdJXPC6zPEo0cKaIReKTZzCJM2XmP7tdUTLT66HczF/5poZxtMyiMSNypcv4HgG+ocOwtum768Xs8SAl+/KNEVqCOrtGiQJzUWpT5gD6Rxhslk9er0FKcXxZjvHcAMOVcHr3y1eXaXnBBp/dCfvyEnNx9fpKtUPGh9NP//ay8A4EnccVNlBzT14ozo5fXhpzHEKOGAkMrNZjdX8PnvCsWfLc5bHKuZofnaN2z9/3BmaJVAC6yWi2n7PPlbG8dKEU+xX/5ljcHYSKqusVqaONWNDlhyzcbGH+qD9CONjzVuusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW+iH6Y6zcSlX+jygh8CPOrH3MA3jK2pXCc0UAtbv7w=;
 b=cB9Epalu0v1ClkrMYeRmyfKaFa0dho1QJaqBgA7KR3+xqfjbbRr4uQ9h2nfxA6CD6CnJBZu8AUhSTMlph6yigUCHc86b3CIyrZ87/6wg8ZyAvJAav2zG9tVh885ZMfXAD4TwzR2hHCocdV05zaJ9h/XtJjZ/dAQjmAAQmsQKHw52J/qvfMtJ0z017xSAYRSvZkWOuYG4Bfjva2IBSAUK+ulGjMZA2Y/63ymJVEEwQRg0TQoIWY0nIMgFD4k2OUM1tKGi2APvXxvVa0iQ4rE4rk45tmo10NQj0T2u2zvsgS2ODMmxxkIae9qHkYXLlh1y/0HBb43UMDjOvICp7zxjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW+iH6Y6zcSlX+jygh8CPOrH3MA3jK2pXCc0UAtbv7w=;
 b=xUU87H9DVy1J6+YqcnwY+X6aMFBHU2jLzvSzLCl0e42GkBEnXYigWbQ9rhPjBqhIu6sGvpIPNNrnbeQUOb3M0F9PiskX4qjCdSofH22AmhK6aHWRVwqUN9a0SwG5reBbUVyROOAroPz0XhCV43S3UCjPDUYbkyJh1PzWKQmHCNM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6251.namprd10.prod.outlook.com (2603:10b6:510:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 17:11:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:11:30 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 01/12] xfs: Pass flags to xfs_reflink_allocate_cow()
Date: Mon,  3 Mar 2025 17:11:09 +0000
Message-Id: <20250303171120.2837067-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:408:e0::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc68af7-9286-4e98-35f1-08dd5a76711a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ln3NMJ0Z4Sm4OCQn1vRQK+wvNx3vjdU8WUguFckChb+StLecagFMBj3X0b+q?=
 =?us-ascii?Q?brg3YTQa1P+Bad5ccnLGXzq0PWcusFlEcxAm8RMbwRkDDCDYRAQJLLrKimBC?=
 =?us-ascii?Q?82/6OLGQgB341liEdWGqTOoIWHijqIKKqfj6sml0CG3Y+WX2y0uHMtFU/6x7?=
 =?us-ascii?Q?sqPXscCaA8JZzePwf0vC2+Exz+m1OicpTzD2iWkNtSLKMOgiXWfI3D73hbVC?=
 =?us-ascii?Q?dz1hUF9JBrEPO9Q4y76LyqnJx0jwCHXMNaZmO0i6oSk3Bmkr+6ymd8otY2O3?=
 =?us-ascii?Q?3NffyYy8BIT1XoorxzpAnw7YNk2sGuPjPIHrnqaubbUiRsIWSvGw8LrfQVQA?=
 =?us-ascii?Q?ea1SepjVqPpCA9FKGoGrW/Z5qycrxVfT3+Gpw2bPjOzw0yy02IRJuTPt/Dvc?=
 =?us-ascii?Q?nNNGQPJIykKDzThpzaVnVIGXPTOrCmhtVo/ERmYQGsSeozH72LAn8sT70Li7?=
 =?us-ascii?Q?c8Yj6WoCND1ZQY/E+j88fSX92LkrXc0RZ0xBP8lTtdX1BYgk9f6lB1+tzqBI?=
 =?us-ascii?Q?evupDa4miqAWoRryhWO2rxtzD3Eere1KZ/RRI+Vr9fUYZXZLTXMFx8Se8OZy?=
 =?us-ascii?Q?u1fm7Uvxw7K8cbYAj9EnVVy6cV2woYZxef8VYysG9vHWI0BpHtrvStphN+Vm?=
 =?us-ascii?Q?WhEJVr3D802YoB84lOy/U+b86tX7xsRnUGhi0oz8yaSNLF0GkYlfrE0MKSd5?=
 =?us-ascii?Q?deavGYjdXH/XEmJq6UHyQ+6ircWyhU4cjtrDhXqaIi7VVAqKM/TphkU2rAIk?=
 =?us-ascii?Q?Co6owICpmXQ5jWxqyU8FOq5vtb2Dr/p3rHX5RPyBoNSp7vZV5Gz+ZDr/DpmI?=
 =?us-ascii?Q?DEgXEHVmaObBfog9/eRP66+xL2qKDs3UezSJkOnfFmNQ3osn4Dhx0cQa5Op5?=
 =?us-ascii?Q?00223N7ESrfTu4uz6P/Mra1EOsQopLtZqThcPVkeGMhZhMOPK+EnJk67fnPx?=
 =?us-ascii?Q?p0T/zNjfrYWzy7s/bgd2IukryZ77X56RRzeF2Tjw1YmaGsax6dXa8OkiwuQp?=
 =?us-ascii?Q?MpSMnF0KWvV1ucwmrWBc3G6yb62hYwEe3yb7/ZswFqdwmUPbUCiGWFYVJPsb?=
 =?us-ascii?Q?zDbPFl09A+mErM2aERMuLp5S99MfrChwyH6PcyyBnBCxyMhYWfsPPqmIWKmg?=
 =?us-ascii?Q?1RSAa3ml3qMk6Ra+AGRxGHyy89V5BQBKArPSd55DhV22uoWh9UYPwrlqxcm0?=
 =?us-ascii?Q?MpEjDM/KAgERwkKtoDWoqI6MYKtf8KIhSUymdpQraUmugFmJuN0k8cZWciFl?=
 =?us-ascii?Q?lkvvSkBMGboTYpdECaIeUEi3vxu5/FvgTemxJzelXB09NNEMNFaYoT7YytG+?=
 =?us-ascii?Q?XUWFED0K6AlsYXkkzLExPpIegNatm4SbsWsR+owhCkxx1N96SPrTh4rBtZhY?=
 =?us-ascii?Q?dieg6nyGEDX3LdNedzjGlYrnKo13?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IlpHIdk+dNdxZILk3EGFcd42C8MnWY0Ng+FJxSE9ok0R7svpb0i7d+odA+lv?=
 =?us-ascii?Q?Gk4VkWdcdLXNQNo6yBzc1wleoAL9EwZxzB7Dd1eR/ScWXtcWEIXuD3x7R5v+?=
 =?us-ascii?Q?vtpaumrcJIqKzYnGJ1NKUtEQoLbUpjGgI2K2Eod69+7DprU25o+WqVH8/xFp?=
 =?us-ascii?Q?L+OEAb0J/UZ5ac6/F8CZ0V+NGHfDLLQvLcltleTIaG03OSaUehTTyWSpueta?=
 =?us-ascii?Q?M25wgpvGrSXAUyLR8HdAn21X1ekjpwmfo+SpvnQz0L1TpqyjI+6pj+GHRXMv?=
 =?us-ascii?Q?nB/HV/JBgyeCZLu0W/7GqqASIFIgS+sV46uvfFBT98Ss8Q7M392kMWFBGe0Y?=
 =?us-ascii?Q?NnVHa7QztBVTdbjqPGDWQuSSIyGL1qP91shro2NdFw90Q7eYkXjdTrgWMNrm?=
 =?us-ascii?Q?gMLFGO288S9LWKl2DMdVHinAdkthNgzHEuxEGV74Ox9cDME5LFfeujY1pwpE?=
 =?us-ascii?Q?/DvvaKF+Yp3HIypxp2us1OIYT82KFOaYMwaHEvHFZyMrSLvPwitsnaDcW405?=
 =?us-ascii?Q?tMh/BahQoG5tNfke2wl7rbFCKQQ7CitFJrZUvx4AiKY/uWqQRJ5lsZnx3NJM?=
 =?us-ascii?Q?ZybajpLNL3GTu5mot5/P8M7pBaMxkbmFmvH38QeavNKdWx0yVbe1VFGevzJ+?=
 =?us-ascii?Q?rdY3jIyT53ncyV7V/IlzfcMenFLXlDnmG3uVDZwSUZJY/E9RZrEj0yu9D+Yr?=
 =?us-ascii?Q?ZrfaZUSUi3+ZzfqxLEfZ+s7zmnr/hhd+14dd4PMN0OgOCOgwoYErc0gOHrxt?=
 =?us-ascii?Q?FWWoaz+Bu+COJdW98tpJOyB5w9NaerZi5BP0uVSxrLdmlTxAZcJcFVS9FZrg?=
 =?us-ascii?Q?UV4yeQuitCSECg24ACGXqAuAf5ehugqYVAFL/oa7gdpWYAXwV0f9popIjZVp?=
 =?us-ascii?Q?DF3h4WwqNlkTItxrEJp2uV03M24vnM0EiFCRNUnyMftwDjEJa+heIjbzAQMB?=
 =?us-ascii?Q?4DP0TXvb5Tn3lyTQhm3V9oJcJfnp3cfQHTVZtzBudqABbQC/O8i2ktonIU9W?=
 =?us-ascii?Q?tx6kM9BiPpaLTMSayOVCGETuHZk/Xeigl20ac2vS5X28Wra7rfJTAQCcjVoV?=
 =?us-ascii?Q?4J811/Xv0a0uP7wtwnzxArLp93wDsv42etbOy1vYQq71nwxQ4Atxdx04Ht67?=
 =?us-ascii?Q?clU1qvOPMd+Q5Qr2mKx2xR3jEcXezWfV16SkWL1Ep4GamWyx21z+qdUDjTIn?=
 =?us-ascii?Q?YBX3ENDsM0x2RU4yT87kxpNsrE+/xp+5XWyQi9Rz8yTlKZZqat1NqMGwyBxT?=
 =?us-ascii?Q?G1uscID0928tjSvcRq8ztV+p6wu/rg7tgryufEL5ZzC/GLmPAB90MkROUGAZ?=
 =?us-ascii?Q?MWnXEjTUvxp6cuLut2XJvdoSK/CONQ+pho6J3YfSmg5OcH1zmBiDclOcDOGI?=
 =?us-ascii?Q?Y5k3NXBRAgUX+VhXTLSgkQKlbpCzI0gLksHJKozLa4qLTnLXVrXow42p+r96?=
 =?us-ascii?Q?QTZkz85f6vUduiY8WKGb1TdwIOq9jo9uIpB4bQpG8cxc3W5w5ZNEX6etxfNC?=
 =?us-ascii?Q?84hwOe9dcXDdT+/BJHcurpjCBIVbclSixxFkt5tVcFezVLYEX62sAKd70h4A?=
 =?us-ascii?Q?H2RKXfSqeD5BsyJTan7kmjeSzEcx6yUhjs/kOotgvr2UnRyKPCEHNSLg+iWQ?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5ZJDpTTjnBHuHJyAtNceJZyXhfkLGNN01hk4+xRKPSJgg61H1NZek0vWWGA42DKPCidRzfEkKMbrjE+ejXDWOxGFERzihxXOu6FWIUMzy9SYLY61+FcTVyBvGCFC0L/OxjvnihLUpqBb7oLWAAk+iVRV8ZhTH+UXGo0LNYMnKpXAPvaNeBnh7WtSaQl3mEsvBXDDR1H1mffjDy6dER0r9gOWNeQF6oMNWWdyC81c+S9It15RV1lxjZB7SBrsHU+CjiumVa5Do6C8ZPsLNqbm+ALlalLfwW4ZeDA9WHaL5dOrQz9rVCjL3UmzcJZcWNkkn2zi/yUM0jz3q5ggEb1CYfvoRKcnnF8KTdNa9p0IB5qyxHtuLBfK98bYlBA2viRTVcyN4Y1KMqP+BH9TCIygsg5s6iysxUcGgniYoSYi83mIq31KeaqnYSbeD1qVwh7pvQU+XoteFF97YBKPSq+VerKXhxaqV3Og+Ema8tWKrCfI9LBelIELlLK2CMwbo5eyqGEIQP9dIYjKhJlgxOpGdZ40JkhpiAqecueaFNjrkCT0W9YJQO/gHODpspqDFFgIZI0+eubq7VFhVQ6ZbGJWIXGGGOUnQOFzpfsGNkmjg9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc68af7-9286-4e98-35f1-08dd5a76711a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:11:30.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKdeCG3uM2tj2FIxVvQDl/G4/6OJ6pTNUN0qLthlQ5DnsIiddC4j5uPFk6ThureSXWo1IlhTZqAYO7reGEbiww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030131
X-Proofpoint-GUID: bpxet-R7jSf0XUyqh_kdBZbm2FKwHNbi
X-Proofpoint-ORIG-GUID: bpxet-R7jSf0XUyqh_kdBZbm2FKwHNbi

In future we will want more boolean options for xfs_reflink_allocate_cow(),
so just prepare for this by passing a flags arg for @convert_now.

Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c   |  7 +++++--
 fs/xfs/xfs_reflink.c | 10 ++++++----
 fs/xfs/xfs_reflink.h |  7 ++++++-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 46acf727cbe7..2e9230fa1140 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -810,6 +810,7 @@ xfs_direct_write_iomap_begin(
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
 	int			nimaps = 1, error = 0;
+	unsigned int		reflink_flags = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
 	unsigned int		lockmode;
@@ -820,6 +821,9 @@ xfs_direct_write_iomap_begin(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
+	if (flags & IOMAP_DIRECT || IS_DAX(inode))
+		reflink_flags |= XFS_REFLINK_CONVERT;
+
 	/*
 	 * Writes that span EOF might trigger an IO size update on completion,
 	 * so consider them to be dirty for the purposes of O_DSYNC even if
@@ -864,8 +868,7 @@ xfs_direct_write_iomap_begin(
 
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-				&lockmode,
-				(flags & IOMAP_DIRECT) || IS_DAX(inode));
+				&lockmode, reflink_flags);
 		if (error)
 			goto out_unlock;
 		if (shared)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 59f7fc16eb80..0eb2670fc6fb 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -435,7 +435,7 @@ xfs_reflink_fill_cow_hole(
 	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
-	bool			convert_now)
+	unsigned int		flags)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -488,7 +488,8 @@ xfs_reflink_fill_cow_hole(
 		return error;
 
 convert:
-	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
+	return xfs_reflink_convert_unwritten(ip, imap, cmap,
+			flags & XFS_REFLINK_CONVERT);
 
 out_trans_cancel:
 	xfs_trans_cancel(tp);
@@ -566,10 +567,11 @@ xfs_reflink_allocate_cow(
 	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
-	bool			convert_now)
+	unsigned int		flags)
 {
 	int			error;
 	bool			found;
+	bool			convert_now = flags & XFS_REFLINK_CONVERT;
 
 	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	if (!ip->i_cowfp) {
@@ -592,7 +594,7 @@ xfs_reflink_allocate_cow(
 	 */
 	if (cmap->br_startoff > imap->br_startoff)
 		return xfs_reflink_fill_cow_hole(ip, imap, cmap, shared,
-				lockmode, convert_now);
+				lockmode, flags);
 
 	/*
 	 * CoW fork has a delalloc reservation. Replace it with a real extent.
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..cdbd73d58822 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -6,6 +6,11 @@
 #ifndef __XFS_REFLINK_H
 #define __XFS_REFLINK_H 1
 
+/*
+ * Flags for xfs_reflink_allocate_cow()
+ */
+#define XFS_REFLINK_CONVERT	(1u << 0) /* convert unwritten extents now */
+
 /*
  * Check whether it is safe to free COW fork blocks from an inode. It is unsafe
  * to do so when an inode has dirty cache or I/O in-flight, even if no shared
@@ -32,7 +37,7 @@ int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 
 int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		struct xfs_bmbt_irec *cmap, bool *shared, uint *lockmode,
-		bool convert_now);
+		unsigned int flags);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
 
-- 
2.31.1


