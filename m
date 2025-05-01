Return-Path: <linux-fsdevel+bounces-47840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017E1AA61C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD60C98179C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22A82248AE;
	Thu,  1 May 2025 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BCd8RlRG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NPEojaDG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300862147E6;
	Thu,  1 May 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118726; cv=fail; b=tzx54kZCklIS5KCp19dPn4bhfnaF8FRE6q3TStfEERofblQyLAg/hiCMERta3ET6cOX4pb1xLMhw46dwzcNPasBW7ogcxVxgjCMAbzo/T3oQfbNtR3sLFEUnK3FAk4v9nNXroHy5t3m9oR9ODosfbWIwWg07uYy4gCFQbLDT184=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118726; c=relaxed/simple;
	bh=9VFmvw8VF1chdP8OjAH5HxqGEv1269P9oeW+EWcQoRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHiHybuE/jkhT7BWRUGtrRBbtoh/UkLIkBTpWWX9Lwj6AOEHMgPuvDuJrP035zAjfj80MLX/h5wOaZZ2MF3Q3G871uq9yToxL+akGHRq6h5j7F3L2D7VgAf78ruEBH4eC4DOrwXf3yS5Rxi8J9xPn/hV8D99R8kw4PTxQ+L2eDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BCd8RlRG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NPEojaDG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541GjwGr026256;
	Thu, 1 May 2025 16:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j9xxB5gxSLG2TwhErVZly1cUqbdL0R17BVPJ3uUQ5Ys=; b=
	BCd8RlRGz+/eL84PfHwMj2uvmCT/JgGAA6pj7yMzoRNRyJ2JZsvZCFGzU5pdM7yf
	chPhysD6B3UDM2BW8ufmo7NzorJJdPsRaCP0LKTev3pPcfRjtqsUnSIPk0obErzO
	XAKfFOLyzNQhzCxrQvPB9RLduKyQQpiSIKd97GlUq2r2qB5Np23ac0yHWxmklhST
	In3PmidklXUKxJ6Xs8ZRdxZx1abfsvC79RnmBdgnuBtZUtPtSXvuZnc2SU8ZjAfK
	wnRAeUAMqlwzLUIXCmirNVNIyEAHFiL/FrEAz93FYB8xsXlTkJT+sdmYdv6Rt7+d
	yR8Z3WIaUleQfBBnvn/C/A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukuj7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541FbSq4035440;
	Thu, 1 May 2025 16:58:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxchjk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnvg8FhsVPNP67s2ZeqC099z1xFsQ9ihM3z/R6LnoRgw69Icuuqq5hoK7+gYmwW0qvW3EBJD7a3KwntHw14RD7InrejuiVbUbVDl6JUQMD9KMNigFBw2nSlGeHkYXwTYwN7dzGNDTAlG+APr1ppDEjzcm9zW6HMSZ65D3sj9F3kEB6ZCfmrpsk7WIUEBcMNgpKe9I7xn+J2kBMcin0i5KAD/zvs2diKPrW5b/ipp0K4yTwVJZUqzt/eQaZ9w4evs1IvqI+2h5EEpS/yR7zReknFJLQwvyNt0jbrWxCU6NGCBpaQJagSAhGmLc1QlW4ZihX8Td/Wn+17DOGp3Gi3I8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9xxB5gxSLG2TwhErVZly1cUqbdL0R17BVPJ3uUQ5Ys=;
 b=XGTFn0P0p/q7bJYLTB0UYvlhDJ1USHa6f0GbD/DlzeYkjAu7pyPQpSH6hcPrTUYh3gnFGtk0uXHsaeTV13OBAOLjwFpgWE7+B5BG2kZP8sDhcIGlFhHSzjjLxF7R1yKrUgch/lISF1SyDD2l4r20N8RDDXIYjqd5UAgzK6V9+iCeFX77w8sNMHo+wZyeTJR6PgaqyeRSBrtvn/6bujGIrBWWsrP0NM4jKYowvcrWXIA8gE9n25R+ZsBerdvPWHyBwmjGgJzIGm1Bqu/5+kkNLbL9NgKFSFAbZAJm1qOEclRjupFTqBfCLbtR/z++mO90rmCtG0TyKcEa7sIGTbjm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9xxB5gxSLG2TwhErVZly1cUqbdL0R17BVPJ3uUQ5Ys=;
 b=NPEojaDGr7IAev04W8m2BjrKO4svTFgASG7a2aiXlCqdjidDut8uOtvshPmq2eYz7OS42bSUAccuvLLW6H5xwL+Twf0VCeKYeo/AkHQgl0Sd905zuntpmuaaZl8Z0YLnczb8OggMZdr3+6aA89YibAvUO8vzxk722PXmKVIIngo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 16:58:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:58:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 10/15] xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
Date: Thu,  1 May 2025 16:57:28 +0000
Message-Id: <20250501165733.1025207-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0306.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9bef03-956d-4ebe-58db-08dd88d1559b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?07G5a7CCj+q61DI+EnYWSilrEH9KcMULVusVZaNiCKo1l10slB0Bg+5ByEav?=
 =?us-ascii?Q?MAmXZA7dfD2F5JEjUgiT9aMlJxfMAHnBESKE2OZR/B5ZKDR8KXZibeIdshGK?=
 =?us-ascii?Q?Zhwk2lWIjb32aG5oeCUwUKyH6uE71sjaf5+D085bZVx3xUK69Sgzx4zM3LAc?=
 =?us-ascii?Q?zw12fN64esbWqPwGbz8ItS4CroNol/R5GXdA1bmePZ1jpz+CQnIdVzB/YJ7w?=
 =?us-ascii?Q?vVhDUar+7oXCT/f+b+WKB64nv9Kg7/xWvihahocv20VEvz4w+74HNlOEP7nP?=
 =?us-ascii?Q?phUMaTOjh7J3SUsHJAh51akoiHHSNHi96YcXQyH1lyp7GnSszjJ3O39CKkAi?=
 =?us-ascii?Q?c0o3JWZlwz4IeQWFjLu7j46K0oKqpTvK0H8H4jjHZ9BbIySqDlHQJhg9D6mK?=
 =?us-ascii?Q?6UFcsakGKkNI+dFFlzJIuDoRcAhQdVXfOOAuKJr/+zTgKQJ21uR9qaNMf1BI?=
 =?us-ascii?Q?PaJQmxu4pqK4DiVL+310iJ/7QjedONF4x93M5ofDUni+tpICy2xSJWE4KBKG?=
 =?us-ascii?Q?NQNGukJqLOP4mjHf+lMDvrNaKS8aZaDgFYqEs9OgL2wSrCDUwRGurGnaS8vU?=
 =?us-ascii?Q?JrEUBZX8srsMpp79748uaY5h+k4fPdQ67Muy68+4ji5KX4P7STsG57sVp3uu?=
 =?us-ascii?Q?RDdMKo36VyVbiNaHIwKdRr9VGuJSaa/pDZB7/xmC5C8dCkP+l98Ik7VT+70V?=
 =?us-ascii?Q?xqkPZMffU/YovhSMYdF3oBWGTud6pcNa3ZO5WKXb9AF+UA9FpdLMWjluPCLL?=
 =?us-ascii?Q?U9S19665l0vcm15MYBG2vc99xqts8H9ZB98Kt9UbGZOO4lKU9+QrxpnG3oDw?=
 =?us-ascii?Q?4lOB9IAwwl0ARihKsMM037kzyCzaDuG8g5FzV0rXxeScFlg5nS9LaDTzg7RM?=
 =?us-ascii?Q?Gm0M09YubDbGQKBV3Cf9nSl5kPQV5v+DgPL05OF0qC+Bt6X1OETjmv6DBhpi?=
 =?us-ascii?Q?53dVw+GqTUHcj3SXcobXt0egxjfTTXksrtjeUYwK3OWPm87xeyR0GzDSTgH7?=
 =?us-ascii?Q?lQa8QMGtEb78DPrwKrmVXyKK0EhDnyBX6iEhgtdIQbNxQwZv3ydBZhKOgBgE?=
 =?us-ascii?Q?d3xHCZnPSVxohAD8WE137n2K/gU4fm5wiSrAz+m0Zif0ANa6ToHVM10e5fuS?=
 =?us-ascii?Q?SlQzBV/deFKWgjFuyxWZapKWqa1+2IORTvzIP5NYL9LAt8bpk/YR764pER2i?=
 =?us-ascii?Q?+EULvzLFndWxZisj+B29yY4Ch0dZZqht5u1a+gcbk6p11417U2siNgbup7ik?=
 =?us-ascii?Q?OYQnPBQeLZeFi0KgvtJ1CIzvf8TIlt/DFFqTagrpvGk6caAvoVrTDG6tptiL?=
 =?us-ascii?Q?tzRXQs4gcEvzS708gg5hy/5D6itnl2ELim7x/wJ1sDYTxSzEj8xUS6kGVKhE?=
 =?us-ascii?Q?Hb0Xydadw1zbfoskjSyAR1nz7n8y7QDwWUwrrf09PekNo20s2gYhSzfE/qp/?=
 =?us-ascii?Q?TsjjR7qHuLI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?szCjbhb/DNd1jvCK1sfiEREMzj66xaHuPQGcH84cZYjXJ7SQl2bWScnudHXH?=
 =?us-ascii?Q?mfB+z907fKpTKOqUzA3nQMxZI/yC3H/o53Ok/K+HdP/vKIIewFof5+s3z5Sl?=
 =?us-ascii?Q?K5ej7CO8+VZdJUzZUjIFnIoG4tI/7kPpUTajXJurr1UNk2EMaStgItvsokjf?=
 =?us-ascii?Q?ZQlLb1cU8ipMKLa9tGS/nq84k4W7VqFtlgH/RFw8a1Enr62TwU6c5GIcZW6r?=
 =?us-ascii?Q?7J3li5Zje7SflGlS3LJ9GEJ4YEeP+cJBgIEnBng60bSaEQW6HS76yripd/Ko?=
 =?us-ascii?Q?WAZ6ELx3dOuwcT1g2u3/wrhJoaxzNf3ZZdc/0xEfKLqiT7zKZrqPO7Rks4kx?=
 =?us-ascii?Q?6c5L2d0ckbmeEmYVQUUECN8GMSgCG9tk7BJoSzYrhRQsr94L3QxdXwtLELOE?=
 =?us-ascii?Q?yR9g/CtLcDE1vS+WQjpuhZzHad918pXxwqCFp4g5sjMJtHnA6zo7mD61fXL2?=
 =?us-ascii?Q?mFSwyvIRDYM+HpGLmM74V/dF7U5UMcLYdAFWzHpOlIT7ktDCS6XMkCG23D5X?=
 =?us-ascii?Q?1xCY4HzxUax/cR/T5bo86qBJauVCMM1A9EE7S+MtEDiB3U/yp+nLIm6AVrTs?=
 =?us-ascii?Q?6rfGMeOqtDHsI70QW6pZPPFsNGXAFbXgrb6k40uR1W6kJX45/0dwBtONm8qM?=
 =?us-ascii?Q?bK3cNwmKZx9YKZ3+FkOa1rasApSIKKKPYR1Q0obZWFmvf3kXGtAHykBewu1S?=
 =?us-ascii?Q?rwf+Ids7HzGWJXiAjctThXF1TLcyQXh4OlBwJTeqhvUxrOuTbsKgr0FFSRn8?=
 =?us-ascii?Q?77wyPMPMEwt0cQMjqdWaaijo8KrIA17Os239wjcxtuoVGlbBodH1ng6hUfdI?=
 =?us-ascii?Q?HK/4LFrsScW6c7/QlbsBG4HAoYD3PvvAaJS0x8D8pK7WcPNFFvW5I9noEfMI?=
 =?us-ascii?Q?VZ9ic6SXxgAd3jA3FQAPFIU1EKiY+R3FJ/eToVvQ8hiYV1h/8+LHj6I4Z8SE?=
 =?us-ascii?Q?OXtkf6x/70Latpb+QZwRqNf08yD8y/U1qT/a28XTIr1OW34ldHv5AzUeLCnv?=
 =?us-ascii?Q?I11MtBJMn7DrfzKc97HyAbA8t5i79ZR0Mm0RreO2mZEJULD+Z8Uec6AjcQmL?=
 =?us-ascii?Q?edmlfult144KaSiBJyoxmFOQwqx3/5G63S0SHF6ev7QTY0lPu8D2DPUjE+5g?=
 =?us-ascii?Q?sLv2JT3h0PnYQ45LFkNRc73ZAiviCHzJNg4Bw/RIVVJAvjkoZhhiUWVZnKgs?=
 =?us-ascii?Q?wIuoyVik/LdukcGabzkOcG4Xkjdc6CcIWLSRrNjhVVdJa9LbQ60cvSDG3S+D?=
 =?us-ascii?Q?NDCUiZt1+R2d6DO+wUmM0siaPRMzNGMeaxUnCMZymNIfEKCzPtpcrK14sN4C?=
 =?us-ascii?Q?/fZeVcLnbRnoW7mYQssVsBvIefbgdMJeXDa88bOfejRenbar1E6ov8twKeoW?=
 =?us-ascii?Q?Z93RlWfBqNJcOKklnGKMZe2oytwI37uWGZWhjGMHDNJK7wRw+Y7JB7B4RQTn?=
 =?us-ascii?Q?7nrlqy1K86Ao3dQBVBRavFX1otljZbz2PZSrGOFeOZuGZHKQpjb940ill4dl?=
 =?us-ascii?Q?5JIAzeQxcuPciAvU/mBAVc2nW6RnqBdyus2fhhKFqAfGMBNUmmawcq81SSvX?=
 =?us-ascii?Q?kTWyxMY8VqwOAW92Ausx+6TNQOwloAjYcG9XX2DqEMVRjkShbBXsBWkI1lT+?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kDNq5Rnd0XGbJHzi9bASxb5PNTWA9jK/MzRW17edlxVF6ltJEyTU4k4YuFzRjQ1XuEfH0hggbQ7fCet/PvuXk2gQYolDpEvMSDoo5ejUz+gXIw3NJDdVahjPOPmH0uQjYvgL56yMNRUHDj7oOwsRKnKJiwVfnV+LY2c6Q8OqlpNmtXHKSAMi29kGW7qckuc9lOQqYhXPYhCsCPgpRi8+T7NCIytz44w9B2rmlQSSP399yIIPRCgRTyA+Vj7hyPQutchzLDQp8HTnFwim8lSTL9PwFkAcGz/g/7NQJK6qtnJwuxNnKXnJ1vlZN4r2lDRqvVDk+L77toM6AZiSuvDIBro3UlieFS/0joNplAuXnLsTVZkLYi060RELx/NUsJHW5w8reXD0VkCcHixPpiBRzYcT9Qy2+pOULK9MAE3fxIxouppyOaBkkE1KIpKFqNco3a4i0Ts878T8V5QbrueAC8X4yBCYsvTXGKzBLIfm3HeFnCz5tBHnkG+36fRaGRKWiEteGait3v3nPWJnnA4pNjQ9uv5DSnUB7v8Kxbwu7XvdoHs3eZknr4c8FDS10305+hPlCuD0gWqz0fdI4kpaIg21QxN0Jvv9q+PJpjlKFOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9bef03-956d-4ebe-58db-08dd88d1559b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:58:02.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUce9wKF0TYirodbJ8TU+tf4LVAK+ItTgiHf9N3pAkRpR1fif+hW8kMH53fkfZepV+ojdJ1KUyB0RLZwU60NSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOCBTYWx0ZWRfX/IQ1shIBa0Ls U4KcPrMwDFBl48eu01R7wop3NNVPLXR1BDhVoZ3wOt/saou6WeMK54BH7Oux/7OBGFbn1lDeZb2 eWK4YkELAw3lV2+jcwuEjIkFN9gfVpJm6iQhCY0Dywt/aQwioBHXOY8bUWXeQ0jAXXXvzwsDvPg
 TuesGymwYVVLyYDVjFJfwRFwKniTIiSsyDyx0xnUe4QXZNK/SOOwfwUzcJ2CFLxr0fXj7VKNyqc 4Bwk7kd1XJbIzXW1550S3w4FQii/OH/L5SFVNY2m2BkFd2uBfa19PRjsVm04MDFTCXMvqo1jt6P 0qTBEgfxLMgNnVoFFMG56rKFY5owceNFnogxIOy974/RCWDBmfYTqwfeR0MRltF99TOYgBXpOBK
 2zLotGQI8F9tAx0kMGDNG1DrG9iToXbvU9gj8CZhw3e/+B0ZNiCvulxq17xYf7wZrVUapiDX
X-Proofpoint-GUID: AKvzL4be-enWmOZXHZh_w2GG_RmNIgKn
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=6813a837 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=7Xr6i1Xs6TsDAXCDpIQA:9 cc=ntf awl=host:14638
X-Proofpoint-ORIG-GUID: AKvzL4be-enWmOZXHZh_w2GG_RmNIgKn

For when large atomic writes (> 1x FS block) are supported, there will be
various occasions when HW offload may not be possible.

Such instances include:
- unaligned extent mapping wrt write length
- extent mappings which do not cover the full write, e.g. the write spans
  sparse or mixed-mapping extents
- the write length is greater than HW offload can support
- no hardware support at all

In those cases, we need to fallback to the CoW-based atomic write mode. For
this, report special code -ENOPROTOOPT to inform the caller that HW
offload-based method is not possible.

In addition to the occasions mentioned, if the write covers an unallocated
range, we again judge that we need to rely on the CoW-based method when we
would need to allocate anything more than 1x block. This is because if we
allocate less blocks that is required for the write, then again HW
offload-based method would not be possible. So we are taking a pessimistic
approach to writes covering unallocated space.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: various cleanups]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c | 62 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 166fba2ff1ef..ff05e6b1b0bb 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -798,6 +798,38 @@ imap_spans_range(
 	return true;
 }
 
+static bool
+xfs_bmap_hw_atomic_write_possible(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_fsize_t		len = XFS_FSB_TO_B(mp, end_fsb - offset_fsb);
+
+	/*
+	 * atomic writes are required to be naturally aligned for disk blocks,
+	 * which ensures that we adhere to block layer rules that we won't
+	 * straddle any boundary or violate write alignment requirement.
+	 */
+	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
+		return false;
+
+	/*
+	 * Spanning multiple extents would mean that multiple BIOs would be
+	 * issued, and so would lose atomicity required for REQ_ATOMIC-based
+	 * atomics.
+	 */
+	if (!imap_spans_range(imap, offset_fsb, end_fsb))
+		return false;
+
+	/*
+	 * The ->iomap_begin caller should ensure this, but check anyway.
+	 */
+	return len <= xfs_inode_buftarg(ip)->bt_bdev_awu_max;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -812,9 +844,11 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_fileoff_t		orig_end_fsb = end_fsb;
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
+	bool			needs_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
@@ -875,13 +909,37 @@ xfs_direct_write_iomap_begin(
 				(flags & IOMAP_DIRECT) || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
-		if (shared)
+		if (shared) {
+			if ((flags & IOMAP_ATOMIC) &&
+			    !xfs_bmap_hw_atomic_write_possible(ip, &cmap,
+					offset_fsb, end_fsb)) {
+				error = -ENOPROTOOPT;
+				goto out_unlock;
+			}
 			goto out_found_cow;
+		}
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
+
+	if (flags & IOMAP_ATOMIC) {
+		error = -ENOPROTOOPT;
+		/*
+		 * If we allocate less than what is required for the write
+		 * then we may end up with multiple extents, which means that
+		 * REQ_ATOMIC-based cannot be used, so avoid this possibility.
+		 */
+		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
+			goto out_unlock;
+
+		if (!xfs_bmap_hw_atomic_write_possible(ip, &imap, offset_fsb,
+				orig_end_fsb))
+			goto out_unlock;
+	}
+
+	if (needs_alloc)
 		goto allocate_blocks;
 
 	/*
-- 
2.31.1


