Return-Path: <linux-fsdevel+bounces-31946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAC199E208
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4107EB236CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36841E32AB;
	Tue, 15 Oct 2024 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fgsvtswo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DIiJQdmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE91DD557;
	Tue, 15 Oct 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982940; cv=fail; b=B5tVJIS0KsEZwYtwjmtgwBZDaXe/L9VAW90NtlcYyT4HFHtRclcyage1BCqhQelrGOZwEz2sVEYqPF8oyXOf2M3ZCUHIvaXuHflXVTpmXpay5FRWEbj2w5O3ub/42rTcSHBbp3eAfZwdLuJspTKdDzI46GhLmZ7uckSjNxjCcxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982940; c=relaxed/simple;
	bh=PRrDkoSeESCFQmalYb0tyyf6s2YdIZ8qgL2KjK4WWoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YK4F1x+Gs+EBJ9ttkvk8Udk4PZC+SwM3WmIs42DhXWys2i2rRdxeH63jE7d9KpzAL/O//LV20NsV1Hv/Lj1VlJ883iAvOcrOrdVnZK0ZfYU9rWwl1/qvA08kAbvotpTMo+AbBAO4dZU/j6EoJqOYT8hZWuer4+gvTIegNdiZ9vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fgsvtswo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DIiJQdmZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F6F3rv012550;
	Tue, 15 Oct 2024 09:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8MqU1/P/auBsdf7FWpVOBsuUx8R1RFiawgabOzGdm10=; b=
	Fgsvtswo4uHYQAU8Z0jr8qmX3ijZZsyQkykFDTtBiWD5AJLtTvd1a4hm/xVqS7Wi
	w9NhrVOVkDECTaRNXIiaKcFFlwHbIMszBAyiRavkGUyhpKadcUJ6GWyR5UnkSSjn
	HpOgQO3v6K4tjhN1ggWsEfbqrZaJqn51o0xmEgKOShDjPpIkWKgLlHoakR8GL859
	inuZDrhkgoHH92+DN2jKvkX/j1DoRMB1s0PspyNpcfkapUBK+N8e+pRzx/zgnk1p
	+DGH5v1vLbB5Uvtb+hNueBEBI0uyVoegoVkeoRc8TV2WSmePoRjZnM6o9sD6F8rt
	N0OnmUKfL/5E45rQxR0Y0g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cgfcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:02:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7XxXx026388;
	Tue, 15 Oct 2024 09:02:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj754ms-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:02:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oA562IMzbBrTm2nmuOgbKbaTdGy0DebLXRGc+Q4oN/zP8A131FU2Qyjb42SQl70E90djM8EfzFs3xEFSVKUNuPwrhUvhL9Rpe3ieUDPF40sqvKuBnlD8+jl/PlBApB4J+dREkrhpucSKnswGdITLZEUBwsWWHgsHQYeZndrdSpI4RX898iSirvJS5tp/OrNoymY7Sfpxnm9AgqJ8vjPBqkpJM3P5sJFltSKYDQNMbuFHmhD6uR8hkz6fLlRlRieqB6KflFzMVPjq3SZTXVATWRAXv084hMEET2aoFJmLpFv7AKCdQAHBxMIQAbdqShuHXJ2ax1135g8O+I53c8PBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MqU1/P/auBsdf7FWpVOBsuUx8R1RFiawgabOzGdm10=;
 b=xEEuG35k1AFrslkO+WEIS/5Retnn5ovJ5cJmdfva0+9UfvRJ5ouSxc887M0bsUwic9tbTXSaOm1psPt6VF78alASJVbVreOA4AY7orMDx8I/r6OpbjmzWk+Wm3C7e2EVb9D3bO4Jd6M1FtiIxIcRTFl5hb4Ui5kBagCm7YCscxGVSzjAuTXZNwhtFmJE6+BtinaxTaC4MTs+TMBCunMNDW6cJXgYNM5479NkCLzEbpFWaLm4A3H6IiLXIsjRYy6Aa5LehMKVtm4cBujFZLgyOKlh5eIWp+tpaQAbKy8XBJMLFW1V6my0cRsDgBqnIgDJCG6x6iUxoQafI2NZP3a4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MqU1/P/auBsdf7FWpVOBsuUx8R1RFiawgabOzGdm10=;
 b=DIiJQdmZAwZUHzQq6+Ns7bhjKGBNllAgqZhnROoQPji/cFIME2Yj7Xqq3YNyf2YptUWHgmj4y7fcvR/cKqNUHkdqe3C/4qs0HOMZ2O2gB7SdMvsnnzlP3l/vRplbVoWFBXHuq2HJZiSGOc585zD/2nhEDfAZ3Xi31KwHNWmALcA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 09:02:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:02:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 6/7] xfs: Validate atomic writes
Date: Tue, 15 Oct 2024 09:01:41 +0000
Message-Id: <20241015090142.3189518-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241015090142.3189518-1-john.g.garry@oracle.com>
References: <20241015090142.3189518-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0f1342-09bf-4d5a-8fbf-08dcecf807dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZCUSLs9BuiKCGam6NiOSdm11hCR4lS43uqlEJcRDfpdMrOoALZydnFXlWdMq?=
 =?us-ascii?Q?GRo8KOHb6mIpYwwyZXiOxJ9iyCuMpF5qVsHu8l2BX7fHa+AL4UVSPe4yBQfH?=
 =?us-ascii?Q?KEmhpFexoAEa5Nun6DuioUrGnJsmjU16LXY35MD3Q4buBOisQm1O4mDJQZ9I?=
 =?us-ascii?Q?YmjEFyjJzoHQXzyVKkf2GqhW7u9FEO7mNjY2weEirNdXQGgmKgraSzGuN93d?=
 =?us-ascii?Q?lzq72vgOtKS8KsJ+AmbLQfRziS81mT2Sqxko2YDXJzvJl8suq4XFWAtiZa2A?=
 =?us-ascii?Q?UHZSld22tFqAmdPFq3OUwost25+Whm8iB1hsSgi3ADQmQJzjx7i6plu/hnVU?=
 =?us-ascii?Q?bKglV4OvJ2zaqI6xojChVhJXGIWhBXZj6AOHGGSWvznq74ipSEOe4ok5tpy/?=
 =?us-ascii?Q?8DEwNSFJ52ZdAQywvEGUdJbyRixu3Zlz9x4CV0P/2y8VQInRC1eA8preScIf?=
 =?us-ascii?Q?7RyyKgv28i5Teiugd4KQYIVVRNOgT5kLGBvCW7XxYNJaElLSIMy0tqtuhcKK?=
 =?us-ascii?Q?EhTDiCUceatYKA05JEHu64lWWJqWuPQ2n441a3M/NkUVCHT3GcJyMURG1hm9?=
 =?us-ascii?Q?iNImfixX25mZeCNwG5oenuvYopfCW0v3QOUTXNbqGq8sk9MXuuSblcW0VKe1?=
 =?us-ascii?Q?FHBe+yr044A1Ds4blh8MJBaWaIW26VgB4Ey7B2+tP6q8KDoe8c16//Nubnqo?=
 =?us-ascii?Q?iWeGlhQ4p4R/aBwlHkG47LbDrAeI0LYUYw+FcLvMqdoFqX2a9gdsnIDCQax1?=
 =?us-ascii?Q?ELczvfVKUHxZLNyXgBDvJR25cwl6tqDDREyqxmJsflCUfg60Hj1T+leARfBo?=
 =?us-ascii?Q?4wxLaoOeo7jGJIQxlMIN6Mc1/vs8pDlr+QJroaPNWxTXMgJ3LIXD+aX8jriE?=
 =?us-ascii?Q?GoMCCGNqvzDmKXVrtL6XTJd/o7JojtvzjAe87bmCeUqm+VFszYQsyhhDxsbO?=
 =?us-ascii?Q?QNxhWoOhAG39XIUKFYgKx15OI9Sx04hm4A/KLhH66u8p/MoknwQ5ITsAn2Qu?=
 =?us-ascii?Q?Ve+nnf65IE7jvoQVbgaQ8xuIpLEYncuOB6ZbAz1rtTjD6JHBWgwg1C4zprB4?=
 =?us-ascii?Q?y/mIMJFNZtUEwf/DViKRtc50528/9S1cPrpxYSFNAKmNK6uY7H27ImrckNDB?=
 =?us-ascii?Q?piTcgKmi4yDCUjhlXcvWXKF11gtERFTdnAojpnqrFY05d6hJ6QyM+mvobpWw?=
 =?us-ascii?Q?1kX+d8ljD9/IE4RuOv+Szr/h09lzcDLqy3zowa+u5V8ya/qqSj111YvwgO7b?=
 =?us-ascii?Q?4Dt2FCpBoK23QAtLs7kh37J8+fH9fcxGjrX1PtbGLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TNwITTpJsdVRhCkZmSliMxxSe58wW+0BOvkdeMDAONcqRHLvoo/qVvplI8Kr?=
 =?us-ascii?Q?faAVLSNAqQ3MTmLCmpvtFSMSOmhr3UpxHt7/W9xjw7CuFrHvyO4SQHjq4s8+?=
 =?us-ascii?Q?+g0CljzhPXyeNmIA6PWQ4AQulYBH9hqTNnM8Yg/LIYD967WEDnhQZRAQ6l/k?=
 =?us-ascii?Q?XywKNhkN3va6WWoxuMs71SNbLrbuFB7Vwq6tH4sKq5MtEOV9H7P26MMnrNaK?=
 =?us-ascii?Q?MbWEcPxkRPFRxfkjVmeJYVmJ2oTyLD6Z9lwn9b0lALdfWQ9Vrq+lt9VyxZX3?=
 =?us-ascii?Q?l5xSiZC1xwPpGj3CzFUjLK5UNtnG1705RyrSewv/U1b6hTL2X3sDcnbEFFWA?=
 =?us-ascii?Q?9OSjPJbcICR8EGKF5KZ/vii/LdFOon69SQTL+1/Tp9rBcSc1sLVPhszbLWQk?=
 =?us-ascii?Q?GfL7lUF2D/6JCYtuCNb6H7pUErcI4dMUbAvjBlDJEVKJtvTUYfsQ3t8Rlnhf?=
 =?us-ascii?Q?1EpaGaVcgApFHWz7yVOiRspuxiv1y2qa5Dmdvk9s51p6p8zC9/4q/GuLF88L?=
 =?us-ascii?Q?wulr+486iKZfFM5P2TKJYeEqM2VsNHU57d6MOvUGHGoKpU24e3YCQuwFO7Fu?=
 =?us-ascii?Q?Q9u0dYIYzxK4j5uVkUcovszroDsOq5RfYPNirxw84LsqO4VjpOX5sjhgbBVG?=
 =?us-ascii?Q?5FEoDp2s4izk8GiBQBVy+w4LRNo54CtZLYdyWFyBriKW8rJ/VFoGjb5OfrPr?=
 =?us-ascii?Q?RnEsA6z1+6uO21OQWcl+RB6o9j19YzcdPyFiQPuuTZrS82InXQ+h9Wn1U+ky?=
 =?us-ascii?Q?AMgKau2fM8cNNaGovTdL2sb61BCnzciVXvDWjjNANAJvQYR8eNqUH+0JILyS?=
 =?us-ascii?Q?2wxJLjOYtttwAtTOlhul17bzRIouDiYrbNL06Y9q+oNy7m7B8olOSIDcR4ki?=
 =?us-ascii?Q?D5yVqgoSBiUKzgdvLVeieUcJ5EzyIE+ilUl52wQiJiIALIU5KKhKclxSYN7Y?=
 =?us-ascii?Q?y1vh0VAvH+8tgzcQ2PwLdNkQ6QkEhZBe+T1Y85H5x1x8ykahKehfNM8HLpg/?=
 =?us-ascii?Q?ab63oEsCsPzkUQavkN6Shj75llack5SEN7YEtbG5GgojOz86oqm/Xdh8R1Ny?=
 =?us-ascii?Q?+rdKPaUYh/+mLMpwvP3CnKVo55QyABTMsH5V3lBAPrgffQsr1uGhJVd8fHKf?=
 =?us-ascii?Q?Bxz5a3yGtZmhYGgKSp6hDc6K+pD9d1FDFpus7e1nSXiTixign2H6SOXPBpWB?=
 =?us-ascii?Q?vlySomrSgKNT5s5qtxCcEmaqMR30xE0gWFRaScBQWunyMlf9u2KLlWQ34lnU?=
 =?us-ascii?Q?FM1QvBXyS2y0Xw4bgaGyRGetC+Bvnyj+c8RGlpW64WdDMo/uO0PMIDXELRtC?=
 =?us-ascii?Q?CTqEF5zmSJARxXNTgcntHQR1OFPf3OgsHWGB4/mM1geJtM3C3bITosrmN0Qc?=
 =?us-ascii?Q?NuVrRaERAf7Al2RXK3cIo/1CHhnwhwgq8bACFnVEFNLOD00HoNXs3XJ+Vmow?=
 =?us-ascii?Q?J4abyRJZ8Vh/pWdmrjkQQTp7zGVX0PTVH5+gauPCnTL+X+Na0p5RULmPPlsR?=
 =?us-ascii?Q?I3uVTKoVO35OgHLrQ8nWekMZZUGfSboPOzek72x+WeG1zAaZnnSIUTn2bFdw?=
 =?us-ascii?Q?slVrP96Oo8nKHh695RZwqpAMBgoFDKCIXCZP2i1rk3kzEExIkvuRxsvUfzW7?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dzuRvvY3zjkwB7+PVpl8dbPBACVOcH+s4EFqLKkFIV6ZhNQDJ4uhWCvkP+zBXOGb6W0Y7wPngbi+THc+CFi0H/OrlZe9QBz5CD3BmdMhJj3KOsF/mIiO1ShWHe72V+GZJdFakCHR91K+T4Eg8QvgNRet15hkFoPW3pmkFq7lzql7ZpztnOvMgCGMyzHQDidkOJChGtEjdbq14a6bj6xZjYlC7IgFIHUeVvd9KOhDwP3NQfqIhGe5WdB+RX6evPTZ3AurIC5V8ZhTa/0StT/hFNHUpDo74Kd66w3Whx8BI2Liq2jlmX9fE188/dG00GPgS/KUM/Ij6H7jJMkUiSFlRsLJcCKfKYxGj8oTejRHYhVvvzt0+Dq+tILYsv01yV8ZFRuMLKV4QK+nWehP9tGMqjTuNhb4ddgeVZIJX2LSnO+Lu4B4qzYELfCfrC+SCOvE7Vao3/kkLZc/L2+nQxMcWc0OCc1rJ0F+SoYajoBgPq8HpoByekYkLt3Hafb2fWwzTRl4Nfq1E4x1L4bdmuNipNf5OhffyF2+7PQdIR33rcYODzOuqxPLOxamGc9MT8ZPYyEdBupYxXUXeJieXQ+AgHecrjk5IvJhLdk+Yk6S4tk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0f1342-09bf-4d5a-8fbf-08dcecf807dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:02:01.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6e2/Y/0jcALrP9ttEDLTITaDsG7iRZe1QO+GIbICPhCvrf9Wouw6pfllSu0LNPPKLUzTh95SCCtAVEfWHA+pLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150060
X-Proofpoint-ORIG-GUID: vll1tEY-Vsw4O88w42UkSMA46KTKWPJS
X-Proofpoint-GUID: vll1tEY-Vsw4O88w42UkSMA46KTKWPJS

Validate that an atomic write adheres to length/offset rules. Currently
we can only write a single FS block.

For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_write_iter(),
FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
ATOMICWRITES flags would also need to be set for the inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 412b1d71b52b..3a0a35e7826a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -822,6 +822,14 @@ xfs_file_write_iter(
 	if (IS_DAX(inode))
 		return xfs_file_dax_write(iocb, from);
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+			return -EINVAL;
+		ret = generic_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		/*
 		 * Allow a directio write to fall back to a buffered
-- 
2.31.1


