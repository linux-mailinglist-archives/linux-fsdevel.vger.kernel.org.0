Return-Path: <linux-fsdevel+bounces-45953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4497A7FC88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F9D165058
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120B2268FE4;
	Tue,  8 Apr 2025 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T76L884V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DjSLnqZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710D0267AFC;
	Tue,  8 Apr 2025 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108976; cv=fail; b=hsNZA9GXRFjMQRBulkZeLkEFwOywpTUNf1GcTKfd8XNYzjoId50l0TgwjFcGOXj+ZfLZV26/3DeMPhnzp3jkR1vuDRHzBX4xy6I+hk/GEzFjPbZq1ebh9AgVCy7dqOkoNOHwkqURgZ15AVQkU0+edbfbjKmq/d8FHNPqYsgQBno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108976; c=relaxed/simple;
	bh=8qQKV1FtOcwnZ/845XnsWmXmISsJMyKouLAzMKMKnS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MATJFQ7tnsMHi/D7oEVzdQ3mY0XDEihRN2wdRK97hn6Y7qLMW63Tkor3fB85lEijK7KerWL2LgZ9afRm9pi5NPw2v/5VAZqo0DhtEe3wX3aIQ/mJcWAjLRZOYKqTPVWV2r93nQgZikDHmqrxijiHj2fzohfQiLT1Sm3CHKm+Mwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T76L884V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DjSLnqZY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381u7ks001181;
	Tue, 8 Apr 2025 10:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2Pc6qEAT2Y3hHxHFSlGChQjwkm9joyV+INFWibsIK3E=; b=
	T76L884V3GTQqJoNW5XnrpuQe4Hmb4b6aHP5vQ/+TdNVq/0zTvmNf42dROa5s5sg
	/IcVY4/YmWoGswAfQ0q7Ov0mF0IQdJEwL9yni90Da0PiP0UP8CgeLXXafcq0tuU4
	RH/QpYJX0UAYi6cKLueJQkgeqJmYYPbS+5LwMFLDp7dG4SrAgdupOJps/gD3DnD9
	4hHx0hrKicI2OK2JRC6nQYGW5zy09kaQ37o3/Sr+i6ohMOnNkytGRuW6ELO6WfLP
	jGCnL0BshhzKB/4ZG7ZRUSrQfrDDhzGCnJBPr19PV+IMPhZgGiadzFGD0BJeCy26
	Hs7wnUiHCuu5qIy33N6RnQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tuebmgf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5388gM2S023836;
	Tue, 8 Apr 2025 10:42:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyfc2pk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+vyVgZjTtiR4yp4pat2tfWd6E3PSIZdST0V0sTnLIa36XOZ0qVqBBpA0l9UJ3mILNkbnU8CNHuXtxbob5CPinF6TxKPfhI9gI9JnwP62jU96XvkzrU6VnJsQl6W9ZwBGgO/H1m+3pwgP1/47a1mmNh/ftSEbF6HMKXZ7C9eXd9a5e7xvszMk2KzHEQgQCGPKN2NWKAGmw8mdDhqk4uEMQW13PLgq4Tnr47hlfhxgTJrOXJet2Pnz5oTeHzn08QxYC0BZ9Z+kfu/5M/sDPImX0VQwHHOX9KPDDFJOAgfyUG3Ld20ixD8eECQ5weOfxawaP4ly1xS+Y4L1Xda0cdoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Pc6qEAT2Y3hHxHFSlGChQjwkm9joyV+INFWibsIK3E=;
 b=C5PPd3y+fnBzSjpB4JiD5F2c+hg6B91ZNCdjBewrbuJZe0uQT6i9s5VmvkDeBLqIBqpz5d4+4o/IW9QLTx57O7NiUnBam9hGiFJz4GvCqev9BvTUOM5TLpmvgAiMXEKKb+KoQeJB3o+5gTNhBTpyDjAKo2nCNkmNfGKkEpJzMg6HD/iklDw7bos3v7jpcbD4fIJ116orskb1Qe4pcm8I2iFlCaOPSiHf6Un4+i2k4HnVoCgp7odNcz5ocg/m4jW+uZIugnDBUE0cxD7jJ0zRZEnLiq4+Rap7v+tVZ+p4Hfe1jBP1RprEywnL7fweDK+KSaQ8gOwazFOOHdBOeUr1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Pc6qEAT2Y3hHxHFSlGChQjwkm9joyV+INFWibsIK3E=;
 b=DjSLnqZYnKwi/al8i8HoZIrTEUMH+C8EzCMzRpI9v5phE+3VcK9u4osb8LAAhd21UKz8hJrmIUVzIaKshY8XCdPZPOcFd9yLoCfogJYkh3gD5HavAvo+xyb3IESA0kU7KwM2hgTE/lWbBQDWxNLFJ1tnbgwOrUZhdmbbPltk7G4=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 10:42:36 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:36 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 02/12] xfs: add helpers to compute log item overhead
Date: Tue,  8 Apr 2025 10:41:59 +0000
Message-Id: <20250408104209.1852036-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250408104209.1852036-1-john.g.garry@oracle.com>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:208:23b::21) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|PH0PR10MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ad238a-7251-4c6f-306b-08dd768a13a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+3sVe/oJsDLDznB9hpCLtkppo0PAodhJRDklwf0RMqnpQ0hrp5c92hobdC0+?=
 =?us-ascii?Q?ZhXK+mn58tlEpkBWiI55BWogyft5sVda5BVFv+pv/+NAaSuPmgBb9jNDSDiL?=
 =?us-ascii?Q?1fTCV/NNWBaKgQR9r6hytC7658ON/pAprBH0CQzvQeHDlgnzE1s4JlmO12Zz?=
 =?us-ascii?Q?BfUqhDzxjQFdYNkPKW9O15Zi6cAWivdh/YEAdqoQfMRXvJ4RkQkxglINnBCu?=
 =?us-ascii?Q?YNFPj47RjITOB1lhQB8r1dxime2ddYWCf2lCBDjiGRZJ1xOjnMzE5kItOyr+?=
 =?us-ascii?Q?7FxYmNHeapa5jpEcmwJWgEgoHmZXsjZqQbPQ0SbsMFPa9+U/X5dD+HemtcT1?=
 =?us-ascii?Q?Bl34RsEmR55uo1/t//O5T6fDygPAeYcHJ9Pi0u7JNMJsbGsDnKxp0OutAVLI?=
 =?us-ascii?Q?cu43knLBLpwElq9o5XoLqmpqAf+24vehIbU5RWIFT2tWESdXI39HOkAHbfAh?=
 =?us-ascii?Q?i51rlQLe8jcfYf7WjXeW3yz4LV5dfIbmrWv046LsCBVubmY8eOA/JYn+ZdHq?=
 =?us-ascii?Q?iV4Sj8lD0cjyQroBOnP36kNZo7nIfwxWoCqy03kgaWNXXo4ieE686MfbnqxF?=
 =?us-ascii?Q?oNOyF9sO9rz3XGorsNgJB2tJwgyE51nntXWzx8zhYKsW5aaO58oE+KuTW1Go?=
 =?us-ascii?Q?hmlGytitTeu/tfBVMzkQc+dKY12k6vixKdLtuTgH3p/JDjfF2mTSw4oOZWFo?=
 =?us-ascii?Q?b01H8cD8RsyG+eB+jg/1eLwx4x6moVL7q+i+q8cnT05/fBdiKhCu9mlIvQUd?=
 =?us-ascii?Q?dm/zuvydF4YiOXP+cEVKPmGPSdEE57ERAzITtYEwenDGlvxejOU3M/2EszFs?=
 =?us-ascii?Q?49xLngc/PPLCZ46G8/ReOGOdBn2zlPGbTqe31bbZnFAVHD10P0Ij8BLP2rLI?=
 =?us-ascii?Q?2rgrFWvpYzoRGWZ+AsBcI6na4x5490TJH3zY0UfaeDYC05VSNVfYsrvUGKLH?=
 =?us-ascii?Q?6DL1s8LMfjHqfv7vOAj0nAwJWhafovmQ55KHc56aTWz1hDtHaEDKB30JHiCI?=
 =?us-ascii?Q?U+xvOg/3tJCvTR8EjnYRohmbPlgGyPZEEmYLfUFFA6E/d7nMwTlzNljbIXi/?=
 =?us-ascii?Q?IpljrfsbbiL5qrsVKYpj2BclWufoOTIYjk0r/BaiRC+9KxQLWY6dxWSpZ03z?=
 =?us-ascii?Q?atjUzy/FN+l3llvrurr6GVobxIbwOUMd3m9LMJnktrwmE9S1KAycztx9xzCS?=
 =?us-ascii?Q?+0kNBQ79IY35+cdbWg4II1vwyM6sfDOKDaXWbjSl1OCEpF7iH70mzYQ0SIL+?=
 =?us-ascii?Q?01VtInuSmCl60HJlqyztS+I1ZloZHLC9JQT9jAlbF5YD7asx3WcQjFHBk3hp?=
 =?us-ascii?Q?EiLnzHE+3ya+kWClb71D2buhCZ0xct7AzFSLMELVYwPQCR8i4ZxQd+f6C8an?=
 =?us-ascii?Q?Ljm7UCxC+IDLbSUufJtMe7p1rDTL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TCiCw8/dauQWvMJFww7J2lngKP6XrHPCkzbq0GucmGlE5p7a93bZZjZESW0s?=
 =?us-ascii?Q?SNsHn9BZySFGyLfW8s/Cm7FLM21mBcgwhrnDcNhcHG1cR6p55B/uLElQ1b0H?=
 =?us-ascii?Q?tN+ux9x5+mGOgW5ln/DtlPM4VO5MbEUKNVetNi2sjnGiVPCh794Bjxsfvc9K?=
 =?us-ascii?Q?S2ou6CGKj8adpYIOC9NWTh8H/PdSfJixpuoaS1wylOF+0jaoU6LVs+UDQeKM?=
 =?us-ascii?Q?/0Kh6mQ7Z+56UZi0eXgLlhWY83uwcH4H5Kmdfy9oD6dvMashHOcZkki7qDCE?=
 =?us-ascii?Q?LacgtYGhJI9ykOmH0d0WQrTXoE8guBrWtSHQnl2/YxMA3dn4/yFK4kJNtAuK?=
 =?us-ascii?Q?YuMMtcsBn6CK3SJp/pGhPSKHowXVZeQWJwk0KPoPnwVo+SBwiCiVF+hQPQHG?=
 =?us-ascii?Q?NtlENPhasDfsDh42QN+4ePrc59nacKvZEY4HX4T4riep8JtgMGTJAz41eYEm?=
 =?us-ascii?Q?wYaXMtbWLDvE6xlglO0ao6AIqFuoixGjEBeIjuqLZOvNkTOnbBlZ+0ECr8Xe?=
 =?us-ascii?Q?SkuM4bmxXQHEVKWJqYwu3qMlF5oxT/JWw5Hcduv/tkvh+CvDATWxofTJ8F5s?=
 =?us-ascii?Q?XzYPLfGxPRUmuu19d2GOcrUf1qgtWhm6GaKIkBczjVzpsPU/v3pG5H4AbJbl?=
 =?us-ascii?Q?5JxDMSP4LxB1R1iCrHkNn5dvrK4w7DXHMqg2X6MUs+to0uFuCzLNkEm4lidy?=
 =?us-ascii?Q?sx85xa61mrg0k9R0LSOEMnaq4QMdtqGBxTImbzKBe230oYFJE9K/JBfAZ9K9?=
 =?us-ascii?Q?elXNqnmMRY6RekCwjKHNgYoNqH2JMF1Td/aFy8d8WjBkd5Zt1VAxkoK7tavg?=
 =?us-ascii?Q?viHzYhX+D3u5XPyJ/DHhef0qLTRHWQ6VxZrDXLveRCuRQor/kM7XFJpIXBJ6?=
 =?us-ascii?Q?JNcKhPEDqCoH0DmvXhScnHraG3GYtFSIzUzY/budo20zjD7mdcEtIPXA+jQf?=
 =?us-ascii?Q?N0ee0H5bszGI0FeGSAafENklEqz2WysY0d8Tg4ToFGFFFr0p9ooHD7kS/gDS?=
 =?us-ascii?Q?3eVDKUzx60W4gkf9C6LepvCUX+/OwW9fpJuGSB5v3VkjzXlj3FFoB/kWu3zk?=
 =?us-ascii?Q?3bumUSnHKUf35oNcYjkW7uHEcoC1WDg4U4oPmQ0e+WnJoNyiRw9ryLkD75Ly?=
 =?us-ascii?Q?HUdXRlSHjQ/WTpfLUhiLapEXsi7ZHE+u6z4LHzIL1qW5NFgKY5QasUC76WFJ?=
 =?us-ascii?Q?j0jp7HtFZ84Bet1daFJi11T5wMmtHxWdzdgevenzZhDuyIip6uLnBaCkRC/A?=
 =?us-ascii?Q?mluw1CjNCYbTqxKqGoAybLZckMaFu66oGj3kl9iQ6mT7hHPFeaA7iOARp3pD?=
 =?us-ascii?Q?NMearV6kRUmzEgOMOacrFWk/MEOhiSWlsrFasFROxI0wspVPoTk0VbrgtBiJ?=
 =?us-ascii?Q?WaJ7P+ElylW+ukOPm2gYjqFCx42I48/z8wNA5D4duBzLBOOAxvYlLkMeOJgE?=
 =?us-ascii?Q?bmCPMuXex05HuMSNHfDUojAOFKxDZMQI8YfbY0h24Ttg6GKVmdcmEsv55miP?=
 =?us-ascii?Q?Ex4PKuHLsoU6VJGZC6IpITLQkv6KAV+87LBtFPaTpCWrNhS0QKZLx3kFTkd2?=
 =?us-ascii?Q?wEH/eu0hc27rHERPJQclfluV/nmxlVHaG7XLg3yQO/FCOw3dhQCDIJmYSWXc?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6ekOC4TKmyOdbJ+si0qm7xGPYwTB4FJbRMNbE0nEMGKmECAA66uAKnHduPRrApsPt34cFctDX/b4Nygq3+SZF6kE3YugPfhNwwM5x00uOiPxVAOyMFv01+MM+MGgkPYRJDLuNtDwWaouw37LySYAFqOVgSQDBo1pTX6UOTHCziZtMljgDdkqVkZ4I9H5EJWVam6dnfbbUDHAdLYDGZV+FSdFjqlc/2mN8UfCcMOlMi2YPBNA9gFsY86KTjveiPISQODt5EvuLGWKu0VroQX6pUl4bxl0m11EmLuekbl+Zi6zHrxrMCZ73o1v60AX+F3hASIxsLn/tgzYZh4r1ATljxVN1SNcBEeo8GiUIyiyD/Sniaz0AFQafNpOMpowc6+0WgUV22rx8Ht6inT3TdMewd2UlcTvfcpsoJnUn4bU6eBtsIVoxjL5iBSrrILfyZa31YXIzeaw1lmFNRioJolZ++kV80yLWSiQRBXogr5VpyOZQHKvC7dbTpBxhvGirKfAHAQsaN0WbH2SNLdLg9BMYur14pCIjXKrTOCcy/73r/y05fjWgOLSs828jzdZdx+e3vLzv9yC8qyYK9sHt34LtRgR9zCqJgFId+9AuvyNenM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ad238a-7251-4c6f-306b-08dd768a13a1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:36.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+Mad5bc5rlM+8mQhSPH8LRBIqcqt2KYpX+VCgZiXqRiaZ+zEGE7Tla/syTlbosKpVvNydr/wymzBt4sLrEiMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080076
X-Proofpoint-GUID: gzK36mZwETmPo_cwXct7LLKTjp6mqkIN
X-Proofpoint-ORIG-GUID: gzK36mZwETmPo_cwXct7LLKTjp6mqkIN

From: "Darrick J. Wong" <djwong@kernel.org>

Add selected helpers to estimate the transaction reservation required to
write various log intent and buffer items to the log.  These helpers
will be used by the online repair code for more precise estimations of
how much work can be done in a single transaction.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_trans_resv.c |  6 +++---
 fs/xfs/libxfs/xfs_trans_resv.h |  4 ++++
 fs/xfs/xfs_bmap_item.c         | 10 ++++++++++
 fs/xfs/xfs_bmap_item.h         |  3 +++
 fs/xfs/xfs_buf_item.c          | 19 +++++++++++++++++++
 fs/xfs/xfs_buf_item.h          |  3 +++
 fs/xfs/xfs_extfree_item.c      | 10 ++++++++++
 fs/xfs/xfs_extfree_item.h      |  3 +++
 fs/xfs/xfs_log_cil.c           |  4 +---
 fs/xfs/xfs_log_priv.h          | 13 +++++++++++++
 fs/xfs/xfs_refcount_item.c     | 10 ++++++++++
 fs/xfs/xfs_refcount_item.h     |  3 +++
 fs/xfs/xfs_rmap_item.c         | 10 ++++++++++
 fs/xfs/xfs_rmap_item.h         |  3 +++
 14 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 13d00c7166e1..ce1393bd3561 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -47,7 +47,7 @@ xfs_buf_log_overhead(void)
  * will be changed in a transaction.  size is used to tell how many
  * bytes should be reserved per item.
  */
-STATIC uint
+uint
 xfs_calc_buf_res(
 	uint		nbufs,
 	uint		size)
@@ -84,7 +84,7 @@ xfs_allocfree_block_count(
  * in the same transaction as an allocation or a free, so we compute them
  * separately.
  */
-static unsigned int
+unsigned int
 xfs_refcountbt_block_count(
 	struct xfs_mount	*mp,
 	unsigned int		num_ops)
@@ -129,7 +129,7 @@ xfs_rtrefcountbt_block_count(
  *	  additional to the records and pointers that fit inside the inode
  *	  forks.
  */
-STATIC uint
+uint
 xfs_calc_inode_res(
 	struct xfs_mount	*mp,
 	uint			ninodes)
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index 0554b9d775d2..e76052028cc9 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -97,6 +97,10 @@ struct xfs_trans_resv {
 
 void xfs_trans_resv_calc(struct xfs_mount *mp, struct xfs_trans_resv *resp);
 uint xfs_allocfree_block_count(struct xfs_mount *mp, uint num_ops);
+unsigned int xfs_refcountbt_block_count(struct xfs_mount *mp,
+		unsigned int num_ops);
+uint xfs_calc_buf_res(uint nbufs, uint size);
+uint xfs_calc_inode_res(struct xfs_mount *mp, uint ninodes);
 
 unsigned int xfs_calc_itruncate_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 3d52e9d7ad57..c62b9c1dd448 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -77,6 +77,11 @@ xfs_bui_item_size(
 	*nbytes += xfs_bui_log_format_sizeof(buip->bui_format.bui_nextents);
 }
 
+unsigned int xfs_bui_item_overhead(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_bui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bui log item. We use only 1 iovec, and we point that
@@ -168,6 +173,11 @@ xfs_bud_item_size(
 	*nbytes += sizeof(struct xfs_bud_log_format);
 }
 
+unsigned int xfs_bud_item_overhead(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_bud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_bmap_item.h b/fs/xfs/xfs_bmap_item.h
index 6fee6a508343..655b30bc1736 100644
--- a/fs/xfs/xfs_bmap_item.h
+++ b/fs/xfs/xfs_bmap_item.h
@@ -72,4 +72,7 @@ struct xfs_bmap_intent;
 
 void xfs_bmap_defer_add(struct xfs_trans *tp, struct xfs_bmap_intent *bi);
 
+unsigned int xfs_bui_item_overhead(unsigned int nr);
+unsigned int xfs_bud_item_overhead(void);
+
 #endif	/* __XFS_BMAP_ITEM_H__ */
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 19eb0b7a3e58..f89fb81517c9 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -103,6 +103,25 @@ xfs_buf_item_size_segment(
 	return;
 }
 
+/*
+ * Compute the worst case log item overhead for an invalidated buffer with the
+ * given map count and block size.
+ */
+unsigned int
+xfs_buf_inval_item_overhead(
+	unsigned int	map_count,
+	unsigned int	blocksize)
+{
+	unsigned int	chunks = DIV_ROUND_UP(blocksize, XFS_BLF_CHUNK);
+	unsigned int	bitmap_size = DIV_ROUND_UP(chunks, NBWORD);
+	unsigned int	ret =
+		offsetof(struct xfs_buf_log_format, blf_data_map) +
+			(bitmap_size * sizeof_field(struct xfs_buf_log_format,
+						    blf_data_map[0]));
+
+	return ret * map_count;
+}
+
 /*
  * Return the number of log iovecs and space needed to log the given buf log
  * item.
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 8cde85259a58..a273f45b558d 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -64,6 +64,9 @@ static inline void xfs_buf_dquot_iodone(struct xfs_buf *bp)
 void	xfs_buf_iodone(struct xfs_buf *);
 bool	xfs_buf_log_check_iovec(struct xfs_log_iovec *iovec);
 
+unsigned int xfs_buf_inval_item_overhead(unsigned int map_count,
+		unsigned int blocksize);
+
 extern struct kmem_cache	*xfs_buf_item_cache;
 
 #endif	/* __XFS_BUF_ITEM_H__ */
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 777438b853da..3454eb643627 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -83,6 +83,11 @@ xfs_efi_item_size(
 	*nbytes += xfs_efi_log_format_sizeof(efip->efi_format.efi_nextents);
 }
 
+unsigned int xfs_efi_item_overhead(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efi_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efi log item. We use only 1 iovec, and we point that
@@ -254,6 +259,11 @@ xfs_efd_item_size(
 	*nbytes += xfs_efd_log_format_sizeof(efdp->efd_format.efd_nextents);
 }
 
+unsigned int xfs_efd_item_overhead(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efd_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efd log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_extfree_item.h b/fs/xfs/xfs_extfree_item.h
index 41b7c4306079..ebb237a4ae87 100644
--- a/fs/xfs/xfs_extfree_item.h
+++ b/fs/xfs/xfs_extfree_item.h
@@ -94,4 +94,7 @@ void xfs_extent_free_defer_add(struct xfs_trans *tp,
 		struct xfs_extent_free_item *xefi,
 		struct xfs_defer_pending **dfpp);
 
+unsigned int xfs_efi_item_overhead(unsigned int nr);
+unsigned int xfs_efd_item_overhead(unsigned int nr);
+
 #endif	/* __XFS_EXTFREE_ITEM_H__ */
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 1ca406ec1b40..f66d2d430e4f 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -309,9 +309,7 @@ xlog_cil_alloc_shadow_bufs(
 		 * Then round nbytes up to 64-bit alignment so that the initial
 		 * buffer alignment is easy to calculate and verify.
 		 */
-		nbytes += niovecs *
-			(sizeof(uint64_t) + sizeof(struct xlog_op_header));
-		nbytes = round_up(nbytes, sizeof(uint64_t));
+		nbytes = xlog_item_space(niovecs, nbytes);
 
 		/*
 		 * The data buffer needs to start 64-bit aligned, so round up
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index f3d78869e5e5..39a102cc1b43 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -698,4 +698,17 @@ xlog_kvmalloc(
 	return p;
 }
 
+/*
+ * Given a count of iovecs and space for a log item, compute the space we need
+ * in the log to store that data plus the log headers.
+ */
+static inline unsigned int
+xlog_item_space(
+	unsigned int	niovecs,
+	unsigned int	nbytes)
+{
+	nbytes += niovecs * (sizeof(uint64_t) + sizeof(struct xlog_op_header));
+	return round_up(nbytes, sizeof(uint64_t));
+}
+
 #endif	/* __XFS_LOG_PRIV_H__ */
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index fe2d7aab8554..02defb711641 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -78,6 +78,11 @@ xfs_cui_item_size(
 	*nbytes += xfs_cui_log_format_sizeof(cuip->cui_format.cui_nextents);
 }
 
+unsigned int xfs_cui_item_overhead(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_cui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cui log item. We use only 1 iovec, and we point that
@@ -179,6 +184,11 @@ xfs_cud_item_size(
 	*nbytes += sizeof(struct xfs_cud_log_format);
 }
 
+unsigned int xfs_cud_item_overhead(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_cud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_refcount_item.h b/fs/xfs/xfs_refcount_item.h
index bfee8f30c63c..5976cf0a04a6 100644
--- a/fs/xfs/xfs_refcount_item.h
+++ b/fs/xfs/xfs_refcount_item.h
@@ -76,4 +76,7 @@ struct xfs_refcount_intent;
 void xfs_refcount_defer_add(struct xfs_trans *tp,
 		struct xfs_refcount_intent *ri);
 
+unsigned int xfs_cui_item_overhead(unsigned int nr);
+unsigned int xfs_cud_item_overhead(void);
+
 #endif	/* __XFS_REFCOUNT_ITEM_H__ */
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 89decffe76c8..452300725641 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -77,6 +77,11 @@ xfs_rui_item_size(
 	*nbytes += xfs_rui_log_format_sizeof(ruip->rui_format.rui_nextents);
 }
 
+unsigned int xfs_rui_item_overhead(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_rui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rui log item. We use only 1 iovec, and we point that
@@ -180,6 +185,11 @@ xfs_rud_item_size(
 	*nbytes += sizeof(struct xfs_rud_log_format);
 }
 
+unsigned int xfs_rud_item_overhead(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_rud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_rmap_item.h b/fs/xfs/xfs_rmap_item.h
index 40d331555675..0dac2cfe4567 100644
--- a/fs/xfs/xfs_rmap_item.h
+++ b/fs/xfs/xfs_rmap_item.h
@@ -75,4 +75,7 @@ struct xfs_rmap_intent;
 
 void xfs_rmap_defer_add(struct xfs_trans *tp, struct xfs_rmap_intent *ri);
 
+unsigned int xfs_rui_item_overhead(unsigned int nr);
+unsigned int xfs_rud_item_overhead(void);
+
 #endif	/* __XFS_RMAP_ITEM_H__ */
-- 
2.31.1


