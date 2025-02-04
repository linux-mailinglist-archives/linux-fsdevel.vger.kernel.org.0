Return-Path: <linux-fsdevel+bounces-40733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADB1A270C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6362F3A549E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30120D4FB;
	Tue,  4 Feb 2025 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8R16MeW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vsBi3+MY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1994E200BA8;
	Tue,  4 Feb 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670531; cv=fail; b=I9M5eRg4Z1sTmIX7REgyILYG+WEaOYLNuC8aezeO6JIoW8/YnLBfabEVlJu3BuDXTR1EkbRNA5ye5afyilEWrLdH/5RXPIENQ/HvvEZULLmO7nE0xAVvyV691/ZJP/jeleKTilLvNwYa5a15XePh2YJMA/EpDuiJy/qh0lJhSHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670531; c=relaxed/simple;
	bh=HHjpF8rSeI+thvRgMXwNdhTquxmYHAX5FNY87CKjviQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZ8OxbmIQqWBrALgCoJzQEBSPS8pxnzum3Zle/m9Wl49yC8t7knP9GwVrF+DfsZiS1c4wzRkqlB8NHz5voPqMbkAhcMlZhuHWEexMJK9M5VHlcmXZjQCKBBKDwdoD2vOBVFGUWRmuxYrl9lIvuucbwieqsta5KZ4DAXh/wXxiUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m8R16MeW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vsBi3+MY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BfYnM000869;
	Tue, 4 Feb 2025 12:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AL1psR4ZpHXLz8epBAZ1gHlsPaWCSjpUJf7YQlT4/FQ=; b=
	m8R16MeWtHIvjW5CLh5YDm44YoQo60OAsRSN9Lip1V/UVHb+Wtmhmsrg7X4YKuJA
	AnL5KVWE0knmlNO2yp8a/jEmuhQb6dDeFo4oRQrzp7IG6IdNtPvbw1Ecs0T8F8hM
	qLVyVo5fcxgnpwidfvuip4IRZ4Czt1bjAlJWEYqSZ9wLY0Dom02lfXL+IF4wZy6d
	ZOMrcFYqmiMQfRZ78HEQJbEB2ESBKbXG/3RpdwRwYF1hajxWUN3w+2pTACyelUHT
	RFrQxPMhYrbYIj0lFMxvuXTi6odn69rwyabWVcUwKUBz+GjhJMnEkLgtNyKB2DzC
	Vy9w/fYFqeJQpgHIjNkfGg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbtcp1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514Bl2DY036260;
	Tue, 4 Feb 2025 12:01:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fm3ykg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWiA7gb4kP0dL+QccSE9J6enLYHjtWXtLTvd1zQn8H+A0PxyZiYdRSljCDAvHSEBJfk49TdHLqWdH/cH7XBVn/I3G7rVyMNceiOmknrUYndDdEhuro86iAUvqMls7vWDiRUTCzN0m1RYzDsqVz4gmnkyMIAz4xaWJO+23cTtziZxX3y4rwQo+4Ahr1IzM+PqcKSBorIMKaPJTwOrl6c4kBUoXa+hLPNVvxE7TbWRrZs/sQLNFUT0ZCRDStDcm3Cm82JHFo8AuQ4DXdRdFhVolY5I5wuco2Tt7KxeIw/yqlNJGK8gxPtU38Zn5Uzs5E315kC9md61X8lQCio+qF+Img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL1psR4ZpHXLz8epBAZ1gHlsPaWCSjpUJf7YQlT4/FQ=;
 b=CzGjf6LBakorpeX0FmZdWn6zidiUXHg6XT1pjcKcjUwqJADeDd4IsDp37Z8cwpt9/CFbK+cdvyQV/hoTE2qJCXPFicJYdMfG7vIFgb9J3uRa79txwxgRPDgs6LuvNetk32j9/HWEa06Z3yhzvDYI+gbGx7JifjJGrqmIK1Pr2SslEvEg+y5ywn/0XiX2LfZ1q3uYCOP1egWCcBEIgffRJZcMBomxZMTB6D7gW8joUBhpxdKdWMHck6l9FurkUgp3G5+bwDKJ7klyKJL9ciSIpEOfZz+CIseWVC2chUwrZ7lNEgZhAa3Snv33TFg/Jg8LBc48vfs2F72QiXLORs9xfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL1psR4ZpHXLz8epBAZ1gHlsPaWCSjpUJf7YQlT4/FQ=;
 b=vsBi3+MYLf8DIkhrWQ3O7bE8debaK7v5UV4rLjz7q0jIaULkcvAo55w6/xCYhhx7/BC9Xk7ZqNKYtBhmEoReVqAmPDRHcEM3X1YZh5d9viWqgVoOcolXLUjI4ErWh1EY4E0yP9V4cWtDtzi3yqyEphZ2+FgOmCLxVekhqDTuzjw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:01:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:01:50 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 06/10] xfs: iomap CoW-based atomic write support
Date: Tue,  4 Feb 2025 12:01:23 +0000
Message-Id: <20250204120127.2396727-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250204120127.2396727-1-john.g.garry@oracle.com>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a44969-495f-4479-cc3a-08dd4513b52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+idamzjEOjOmeqDPo0ZOR0I3spVVO+VUhG/1wGdM4VnCw99dmDTaoLSr8uYY?=
 =?us-ascii?Q?2ZodRo3mVFK+NNfO1jWyCZe5mR3sC3pJHJ0aqWoOt2SdNSN1kZhtRH+QNUJ8?=
 =?us-ascii?Q?1COprsUKtWkIT6pFCYCHjDCWe6D3mP+XhciGWXQnPywme+ig0BlbuY4k44K1?=
 =?us-ascii?Q?YN8BRtkc6LtXVL5i2qJK54/69FhN8oFlQnyrJoxfZSMuRHBQWVwmwyS1Qyk2?=
 =?us-ascii?Q?yj0+SwEvppKviRTa4dk6iV2GiHChY2f8RvlrN3/M5eazTF3Jau8tc39NP+eK?=
 =?us-ascii?Q?W1E9mr6SklD4GdKicty2Pky3mEpPROGVyWjhNlfbeofoh1+CNwfaIc5/jxzE?=
 =?us-ascii?Q?xwUFut70FjszEHPaeBNBph8UQqfKvbWdH1ynPQD+2X1kRHAFy2mwrwCfIyqi?=
 =?us-ascii?Q?VBZNUBAZkCCvJlLjNjyIYd2o0k0YjJ0bovfFRZiYmaAJRhr0BwEH6td7CgD2?=
 =?us-ascii?Q?4WYWSJiS/tfBO4jUCT+huO26JzlKIU5ThxwC4tNikrp5gOZRHrLzXsccNY3C?=
 =?us-ascii?Q?9RwabScspapjTxqgXsE6i2hUH9gzOqPZ/vGBTW1c3USKe4d222YC21mw5L1l?=
 =?us-ascii?Q?yI95OGtsfCPfc9A4j2RJypZeT2HDhPwoBbGoyDtg3VIaUfKTslKaCNDpvV1v?=
 =?us-ascii?Q?1WDN9C1jWVEgI8atwYkJRXuskhJNrEJGBQ55bKNYuM3HHjL0DGsLP+qDwluy?=
 =?us-ascii?Q?nVKkYnrumRnuHvPvTj1ZgCSnmU/OQGifA+n9fMGblOsmaUCo0APBwO96S/2C?=
 =?us-ascii?Q?IGHgPpdkirFIYw2sJ4v0g2DXYAW/SbTfLSE/G5SqOQ2W2ZZS/HqHZ3nsysn1?=
 =?us-ascii?Q?LQECmCwTen7r9emjZwjg7kPXQnSp8CmJZLjlG6+F2K5nLMqi83SVmiOdd0fo?=
 =?us-ascii?Q?ujZ8KiX3BPYoxV71LQb6U0f3DsXXBTG3NIC0rFu4t7HK/EjkqcS9jc5B5dIo?=
 =?us-ascii?Q?9QzMhitclrXQY0G9egNH8hxlUotRvsTlbBQWDhU2x4niSfcK67zmjuRDne4y?=
 =?us-ascii?Q?bykz7KgpKsrzYBJmhWoK03OiiKNBnUddmagZM9NmtXXsJzfqg6ZSPcSwn/KL?=
 =?us-ascii?Q?c5LhZJcfZ4E7SO3DuEIAd4lZDnSogJZr5fuF73U/gCI9BBztUtkg/4/9W+i2?=
 =?us-ascii?Q?oy2K/SbvduMQzxEi8z/ZQi6DKC6pAO1r9Fj/EDkHrwT3BGFvgBKZTKmfl0Kt?=
 =?us-ascii?Q?T1r8PiXi46hRpfbxJWVEUzucc3ZXBhnShz4XYbSOXfhL6fFE4KvYX8D+DaMq?=
 =?us-ascii?Q?gEUbLNoEZ60UPDQ0E3aXxSVvCHTRe9hpY6PU37ZklhjnQCn3kgchInDvSfqb?=
 =?us-ascii?Q?ZkCrbYcXHRrvCfhQ5TBTUzR6ynDd4knxQDHzM8QZHjL473niCUR1QdeKFPPL?=
 =?us-ascii?Q?Nl0qz/O0IvHPA26dQHhHpzh6civW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pU1z9pCD1LOS/c19UnexnXIxNX0RdlS7Q/DEBR0NXW4T7bt8JByADADjqkxq?=
 =?us-ascii?Q?o1G2psg8GI8dmvufcZsDZqJcyeImO26Jnsk4AoZWimkXFtCfiEpr6BGHXbWk?=
 =?us-ascii?Q?dXgr3e4eYfDTyx1LICbzRJEuCPFHTf3NcqprxHz2CP4A3avBagT3UY6YifJF?=
 =?us-ascii?Q?VkNuHaFvU1ZGEP2Wk1DSH8LMETvwQUBv287FFnENV5mAHMJNwE28NKAbRtY7?=
 =?us-ascii?Q?3iA6bADUck00NiwT0RKaivRlGAoDAH1V78F7NL0D7+4ty6xXEOc5dgMrb9lo?=
 =?us-ascii?Q?sgZ1MbyaKDc3EHZElt0lE4H6K15p+zkKtI5NACAduX0foXn5LdFOkzCERX3j?=
 =?us-ascii?Q?1sA7eqtJs7XefebBSMzKCTZhB2W23as+M5AwSl0wAOT8WaRtBUJXFIiYwUy+?=
 =?us-ascii?Q?VcZUO3LARmPlExjhJcYgOpNo1Lkg0gMJPu1WkwrU5Lk5jUkPnQdU7CncJhc7?=
 =?us-ascii?Q?gT2z9e6+x1ILdbpQKIvnmm/vN192xIDdILGdPe9x6sFM3NcnWO+f0D19yUKk?=
 =?us-ascii?Q?BHddPMBKx18sH/6JYjU8KYvC2bq39yA1Tt73lLZ4j+Awczyc4zcrKHjgZZzh?=
 =?us-ascii?Q?vMoLtnyb2rxYksOkPGWayuKOih05/CgZXB0YKelxyD7AVUFAGn4Och6z7qg1?=
 =?us-ascii?Q?SH8Eor1muKjTKsoIpxHuYsfe3Ti/nzqyPohLoNX2e54vpvfdMsBWHequLxoN?=
 =?us-ascii?Q?2rpP+bphE2Dk/B2vZ6eNngIVIu15Wynl82rxsrmQchD16voLHNLDIaBmOXca?=
 =?us-ascii?Q?Bxb8Q6n9Fu6ZSfW1d9FFs3U4SVJYfTawZKQ9Pmr16oBPV4bTF9U2cY+4SUbQ?=
 =?us-ascii?Q?/anLQx69hGQmoacUJ8Mlg6o8tws3SWRn28Qzg4VGg9Nq/S8a3qwY+6g9TkEg?=
 =?us-ascii?Q?OchViFbgbK7LgCCTYPFbm9Lf0o4sELwq/bwjG2028moVPDN2e0scrvX9+4wS?=
 =?us-ascii?Q?V54NPT52zAgHv1IgyeurnF8kmzWP5IDFGFSh4m4malLGTqN1n9EUpsl2Iel0?=
 =?us-ascii?Q?oLWzrSyFtbs/lsbJhCd2rhcjoQUjpzJ5nCwMxddZ3RBLNJcyhiEjC4RKyZh3?=
 =?us-ascii?Q?kNKkXrFsZ8iSuoJnfuPbLPAQ5U57wHJyJQ6bJi7NSH5RUYDzuCBI/FwrLnXx?=
 =?us-ascii?Q?Niq8MkNEiSeU9Luk1fs95n6QEeqfMjBOHNB8SsMnf1AsY95mDN93thUeF3+9?=
 =?us-ascii?Q?JUmH0mmscdbDA6O+42W9Y42xmis/V0CctIQVO2SKjcC/2IX7+esu7ZPYK56K?=
 =?us-ascii?Q?6DpjCSh413vtQSBt8zCunJpYjfGYk59YWFyjYGHkXrvMJY4j/LZHlJG/7SuV?=
 =?us-ascii?Q?/Z2Hk9AeB35pxPGRw+yKrMJlXEGzKoepCW988aFyQntqmBfZyq1lNKxoHmCk?=
 =?us-ascii?Q?DdjL+kmxC12OZtWgnGmlMi7TvKKsGlzUPTKnfYgq/R/Udn0rGdfq+bo8L9cU?=
 =?us-ascii?Q?ejeox6fmmVoMSGGokkkE4Xb8Uwse9Bjz2aRscRO4elktxDSpMOA9mBGjzkrW?=
 =?us-ascii?Q?J3oqOKlDq8SqV07seCHspERxmmf0meF8Zzi+ukx8GME/7tz9wTZfzfptnUg4?=
 =?us-ascii?Q?OUrJ1GlG7EobhSBhgrmZlLAT7SGBa4kl0YM33H4+d0AlItMgOXI+uxoOXzFx?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hxwBPujNgD+t89f7cZZxTNvH8pT5S/trJ9kmEhlixaNBBJs84exB7b1VMvKAjfGrq+b0ozH2t4otAkBPe04CGrflnOnDSwBGDRwMcWntg51rsSnPNutm/Np51VCFBlwwcPR/c4J/FkQygob8Hvi9ifjGfdlDU2Zq3MRQ0MrTG5k9t8mSHwmPhqDEKdy4Zkbuz9nPFrcdtPDmqViVV4F+LFjemoPP/3XFna9YN8TSI+ZbE0bqo6dB4DMnv7VZm7ntkTCOUovo3PfGJvteT5vVNEJ8+6hQNLnSXyYt5szBowZjfq5UTSpdD0GwvsqVE5itEKBeS6UuutWZoR1bRTrN8Jdw05/uE6vGm9M8iBrbyuoXZ8aN6gxEq6PiOUzkpe93p6uHSqfMehI9N0ddEPktQaExoQEFQgf6A4273hpTHU++C1BK677d+pTwCllorxXkx6mVahOfI8snSO3kVUDTK2HOkl2seslPKwYDKfgKvJ4j3oKsk3a+Gr0EPhVuOvk7jps+hAnLXb6uO0jc1OelXP2I5lVb+6f5HV5eSCFUU1/eUBC5rEBwVkUpmAC7O3Pan4UAlgS6OASSq1TfWf7XbdzZtmW03uPx61fgmni4hS8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a44969-495f-4479-cc3a-08dd4513b52c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:01:50.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dfsahq/tVxfnjDHGEumqkqpLcs09a42k8Jk9A0dM7Rysp4dZVu0GScUSfmPnceRQvxfvl0QxV2K+c4xIW2wPfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040096
X-Proofpoint-GUID: Ck1d4m83J04V72BekJ2aIbqrKbPjOqDc
X-Proofpoint-ORIG-GUID: Ck1d4m83J04V72BekJ2aIbqrKbPjOqDc

In cases of an atomic write occurs for misaligned or discontiguous disk
blocks, we will use a CoW-based method to issue the atomic write.

So, for that case, return -EAGAIN to request that the write be issued in
CoW atomic write mode. The dio write path should detect this, similar to
how misaligned regalar DIO writes are handled.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c | 68 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ae3755ed00e6..2c2867d728e4 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -809,9 +809,12 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	bool			atomic = flags & IOMAP_ATOMIC;
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
+	bool			found = false;
 	u16			iomap_flags = 0;
+	bool			need_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
@@ -832,7 +835,7 @@ xfs_direct_write_iomap_begin(
 	 * COW writes may allocate delalloc space or convert unwritten COW
 	 * extents, so we need to make sure to take the lock exclusively here.
 	 */
-	if (xfs_is_cow_inode(ip))
+	if (xfs_is_cow_inode(ip) || atomic)
 		lockmode = XFS_ILOCK_EXCL;
 	else
 		lockmode = XFS_ILOCK_SHARED;
@@ -857,12 +860,73 @@ xfs_direct_write_iomap_begin(
 	if (error)
 		goto out_unlock;
 
+
+	if (flags & IOMAP_ATOMIC_COW) {
+		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
+				&lockmode,
+				(flags & IOMAP_DIRECT) || IS_DAX(inode), true);
+		if (error)
+			goto out_unlock;
+
+		end_fsb = imap.br_startoff + imap.br_blockcount;
+		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
+
+		if (imap.br_startblock != HOLESTARTBLOCK) {
+			seq = xfs_iomap_inode_sequence(ip, 0);
+
+			error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags,
+				iomap_flags | IOMAP_F_ATOMIC_COW, seq);
+			if (error)
+				goto out_unlock;
+		}
+		seq = xfs_iomap_inode_sequence(ip, 0);
+		xfs_iunlock(ip, lockmode);
+		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
+					iomap_flags | IOMAP_F_ATOMIC_COW, seq);
+	}
+
+	need_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
+
+	if (atomic) {
+		/* Use CoW-based method if any of the following fail */
+		error = -EAGAIN;
+
+		/*
+		 * Lazily use CoW-based method for initial alloc of data.
+		 * Check br_blockcount for FSes which do not support atomic
+		 * writes > 1x block.
+		 */
+		if (need_alloc && imap.br_blockcount > 1)
+			goto out_unlock;
+
+		/* Misaligned start block wrt size */
+		if (!IS_ALIGNED(imap.br_startblock, imap.br_blockcount))
+			goto out_unlock;
+
+		/* Discontiguous or mixed extents */
+		if (!imap_spans_range(&imap, offset_fsb, end_fsb))
+			goto out_unlock;
+	}
+
 	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
 		error = -EAGAIN;
 		if (flags & IOMAP_NOWAIT)
 			goto out_unlock;
 
+		if (atomic) {
+			/* Detect whether we're already covered in a cow fork */
+			error  = xfs_find_trim_cow_extent(ip, &imap, &cmap, &shared, &found);
+			if (error)
+				goto out_unlock;
+
+			if (shared) {
+				error = -EAGAIN;
+				goto out_unlock;
+			}
+		}
+
 		/* may drop and re-acquire the ilock */
+		shared = false;
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
 				&lockmode,
 				(flags & IOMAP_DIRECT) || IS_DAX(inode), false);
@@ -874,7 +938,7 @@ xfs_direct_write_iomap_begin(
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+	if (need_alloc)
 		goto allocate_blocks;
 
 	/*
-- 
2.31.1


