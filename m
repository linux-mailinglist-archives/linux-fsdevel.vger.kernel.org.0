Return-Path: <linux-fsdevel+bounces-47385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070E1A9CE9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762E31BC3034
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978301E47AE;
	Fri, 25 Apr 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l+xq9XC/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HgJbXRlj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AD91C1AB4;
	Fri, 25 Apr 2025 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599579; cv=fail; b=C95F8NrYRVnN4X3rY0BqiAEkIMue/hG9808DBEGHmjKPWSsBE7paxq8Ur28gA/A3PUPQfajh1/T7OrUVlU0Mfk5dGqAG4KCXngMfaM2d+1v+8WpLzg2Wgp3vcB5YDSFdLuMyxl6lI1kv5ZFLMBiqz2+/lZXELh1LU2fYcnX3CIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599579; c=relaxed/simple;
	bh=TWl1Mml+H9E/Recm4STv3+32GH02Hlz0sgJWbcL3VVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U/XFtiItJ+2BJuks4US8Hf4BiFUs8euHl9NnlCdfhHakFx8qWdKeNb1v8fQ3gnPN+5/pDbek06GogaiNBKX836ogNUbJaHBREmgrATXQI1xH68dxTavFszOQsYNfv7JH68MrbP7dlfZg/cX1GZH1HA3Y54jemuFVenLCNMhLatY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l+xq9XC/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HgJbXRlj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGM35k001371;
	Fri, 25 Apr 2025 16:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SD9vDaEgdoaIUkTNyskI24Vwa1kn4qosOQlJU4vAMs0=; b=
	l+xq9XC/tslH33jcjY2A7fZeKew6mwx00japkeuBQoowB+l8K0oBE068i2O20ZoK
	EzkHc8zBmq4QRHkW18OAiX9Hpp5iVNZcH0AGdUAmS6RLrIrCkdJlbHsQWHDJ8IdE
	CqJ1wQk9x/DdCZ85/a1zk9fOosz0N/MuDYj5DIwfU96tS4f4ATepN3TFL7SSADsx
	AN/q4k0juP6ObjX14h4/ZJ5tsIiMuLc3GtC63pCaejIeJeTWwKusBoUmZF5awNmS
	zCiuWoTAqxxRQYL6BI6u+QddjDnGk8fu5yatowmmWxR4RLcSqx8UxelFVkNl8wsL
	H+HU8SRqzzNmbRFVIpl53w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468dupg33b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:46:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFabxE017293;
	Fri, 25 Apr 2025 16:46:02 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012036.outbound.protection.outlook.com [40.93.1.36])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jvj4eb3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:46:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWZ5m24IXwxo/EbsEllIeN/nyROR2pOPn6juCNvRU2dU4HdphjTeEOxPQ+4gxMlECMPfdPnTWF2uJKbFtM61HC3WmwzQe65zEpzhXYMP0qeShpmDq1oKqhpftE6dql5rej95OaSM0SXh33ya07t6/Sl0etI+omwzfeMloov9ScfJMo3STAMY9QnYm4Kqdb/JnmRz0exMxWA0+IDZdR2j0ChzfJqvEuI4Zx0NTlxT7f4WIUz2pZsFTxbtl3BzRjIjXJBch21MIORRnKtqEYCViIz11VUCsQH02l0erpl0VyCOMuplZ4cydcZqKNymoqgmlG7cozI2JF0o3jQcd+QwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SD9vDaEgdoaIUkTNyskI24Vwa1kn4qosOQlJU4vAMs0=;
 b=PaR9p4bDbKbH7uoRluDl3IA47UaDcqKbm7q8t3FG8/LkFken0fj6N24XtehCKpDFf0iOYnDFdGqculv6a2eJAGc7rhoL2QLbspRdEQ0W0KBGqte5EYaFk/iGAyiXaoQFjAszSDhgrUUffwy4SsJjJzLVN0Ixm1NyD1arMgTGrUx32jsTSK3RltP8ZlYEDfm4Z+FgG3KQG6oaz1F9yeORctxgyxAX40I1kA3OBUVLIW4oWG4iT/w9X5k/7F0nl1E9CjKV6lgn2SYLbGJSanGDCQFgAnk7L/Y7Lsw8i4oPiCT5H1yc4Ddqhm7NY+w7vgehLfJ2duW5Oo9U44T0OzVt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SD9vDaEgdoaIUkTNyskI24Vwa1kn4qosOQlJU4vAMs0=;
 b=HgJbXRljZRMPW9ZvNCVwLn2MvFhavfp7f8xqLaMdcxm5CCUfhS8XUBCnluz4IjJQQwO2PSM5FZ6LyYCqz99bdQmza5RhxigjDABmu7NkZ8g50kgIrbRDlQCdOug6Y4dN4cBRRba9muafJcU4iTK2ATmkMv0euLh8nAv3dWoTrj0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM3PPFA3FC49FBA.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Fri, 25 Apr
 2025 16:46:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:46:00 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 15/15] xfs: allow sysadmins to specify a maximum atomic write limit at mount time
Date: Fri, 25 Apr 2025 16:45:04 +0000
Message-Id: <20250425164504.3263637-16-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM3PPFA3FC49FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8b1e39-7f82-4e21-3a24-08dd8418a907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XoxYC4YQBn31eWDJDzQ/mYq9yfJnBldoYNo6mpgGlZYAeMPfXJ012X64uRYX?=
 =?us-ascii?Q?CM/ybhNuRZ8cNHoqlNPP3C3A+6UKi0xl7pV85qEl2KiwEJBmqtGz6p4THA0s?=
 =?us-ascii?Q?Fq1H9pOcy3LxQmMo5oi6WCUKZQWQ7L41bf5Qn4PGCPT3hRZG2bT8Eg16xHng?=
 =?us-ascii?Q?rGhuHBTbG5uwW2eBawDV2NidDy5/LLEcTuqM7h87pmy5lRRdu0ghys7TI4D7?=
 =?us-ascii?Q?6spmCgTrgiAky+CNerodt0e+iOQqqcRimuNm7hOYeQlfHcoy+Ut4uCZyZY9k?=
 =?us-ascii?Q?P0f6ktATqcnwinMlq4tpB72QLKe9m5Mxj2AS5EJKRMf/McB2ww69J60Pxpu1?=
 =?us-ascii?Q?bthY7kbG8UfzXXCSpATr+xxEiT+HyZhHnegAqmgW7Xyq4AvPYLbML8A8+wd4?=
 =?us-ascii?Q?l98VwQf3MGwBAoFiaUhEVkWStyHcPFCNM1TA+JiH6y1y7km2vpDA18FxdtF9?=
 =?us-ascii?Q?VnmaZFt80Ek73vitwv/Ym43cSLJPySfWsHv7mjvaxuj4QDRJeNeoViYpme2S?=
 =?us-ascii?Q?nKYzq4UOL9t62RD3YHwwfxM+tHDnSSkbHtTIl+FgXqXs6g81twdtbfFyeE/W?=
 =?us-ascii?Q?VQgJD4vuSECY1MXVWqi/Gqln+MmpdpzauUZa4v5C8+kQRZwE0JiJTyOdpwV3?=
 =?us-ascii?Q?61dgWTlFS1UJrZUeEPzIx1wLMj2/gmsYMRawGSqnKxpspswwYwctZOIBzeqw?=
 =?us-ascii?Q?COYMIZQz1dGEs+ErynMZ0ZXORgOTfaBiZaS17UnVDZGvNjYaDZgR+Cg62W5F?=
 =?us-ascii?Q?FpyUsc4MhdgZ+GT6VUKuCkC63DhZGoz9oWlQuRYJJEahgeKRXLPT1iUSO9Oc?=
 =?us-ascii?Q?/WViQvObgEasMh06MkEvYnR8NUIXqvxrxYfmvDG3VXZvKnhdU+JybGaON0en?=
 =?us-ascii?Q?Sw89Ugd2/PALY5BQQIZaKa6zzn2KbvsLqa+193CUUFXf+lOoW6mrui4ZSawz?=
 =?us-ascii?Q?kWGKg6ioJUPA2O471gCR3HX1h4wZPbPW7GLUYIYudqgNijRKrTdb/uh6Fmrl?=
 =?us-ascii?Q?bvYhLlTFfMSmIC0BlDCjVgassNbKGksMSC8nMZ7bL8uT7JvaDzK++yna+kx+?=
 =?us-ascii?Q?LS80b7I6u5iyBW2gM+1+PZ8vfmweJLoBXs3sA8O6eLVI+5S0DfPi+hwuErdm?=
 =?us-ascii?Q?5Dng0aA9U4jc0JG8G/VbWaC8Bj+3cdvjSFdv3DLsC0ZTbsfGzZxCU3o69lNN?=
 =?us-ascii?Q?NihkdOVacETBQycHGBaa6faQ932gtwdZu3U5ClrXakpUqQqsonBUqJSrvkbK?=
 =?us-ascii?Q?Fgytkctx06p2MtJwbWOqI6oy8jG69TZUpc/6eIE7pUtBrYruHdPbi449h6sk?=
 =?us-ascii?Q?hIMw0YQXG42kBSIgtiu8araMxDn+7m7ce+F6aYeUWTNL06MD/PhVtrlvjgLV?=
 =?us-ascii?Q?4UMlDMBmEij0gMl+kkA0+wMSPTm9j0FD2fX9bMBKkdaYdhNqZPKZdq+FV99E?=
 =?us-ascii?Q?8xtYs+5JocE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B3Fbg4a3MLC5E1CEZoVos9zesas3dN8ADKSUszGJMHWCFgDzwpibJ5TjFYIZ?=
 =?us-ascii?Q?OU11aAon8x8rS+KHSA2ZtSr7fTM2+6B5xc6SC0Nh64K3AWzPVgCOg0LeQLfr?=
 =?us-ascii?Q?OftxouMDi5IIEvOiEbSV9F5g5ejH6r1RHKgEMJlpxPUMqe6UX0wuuzWsAjUd?=
 =?us-ascii?Q?rMZxy0H8h69xe00Lbhxx1W0nJrstgR1RjVVogC7BagOHhZNxqKEeyDERutlU?=
 =?us-ascii?Q?VjyNfZbuRo5VNes5niSSj6F/C5MxZnOsyzCfXVEoFwLKnSg0KqioBRrb6gl9?=
 =?us-ascii?Q?+tVOtiKIjDLl9ALVtjvmUYcfwc1QEkhObTVv+IxP13k7lDQQfI1zJ1qdCdjE?=
 =?us-ascii?Q?SSJCuDluCvc8bt+2rNfjA5RisnkzCAk1h7X5mr/+kPy31JnEAohiePZc6Zpc?=
 =?us-ascii?Q?s+2hZr+PkOcRCJjPDQ94GjMrSd/ew9OVxkAPcDcTlo5D5TG81CtrOexOrrw5?=
 =?us-ascii?Q?GMeEttFM39jqdX8ZzY9NLHzgBd7hVCXXLbyjTdXkuxpQ/wgeVqLTeb9GdEPM?=
 =?us-ascii?Q?WTWBD83YkJND76FqhipzigF0ARKl1KTRH3x8/utxKWVKlS21i7IvJOa5j8R8?=
 =?us-ascii?Q?Vfzgu7YpXNlmSwv7FqR3rqsYHaQTlhy33D348nQ85yDIBf/sRJusLl4cZH2h?=
 =?us-ascii?Q?1dr4cAsTFJo5dlkk0pRhz+Ccp+R7OYS3254kqQzYMOKR97nk+iQCYjFv/ryB?=
 =?us-ascii?Q?6u+XnE73e1fPVf9tqDBtyKrBMMSgAdxNp11NjfY5t8gxl/DTBWzRZCxgBi6L?=
 =?us-ascii?Q?6fOMJW8kh11L6uDfss7xSGJFdhWRmrz8vMyr+wGIh51EJoXHyddRDEoeci6p?=
 =?us-ascii?Q?1AQKCDITYHb0AqbzOjdfzD6H5a2p9ci6J/h0KxjUi+4qzTq7/G3eJVk9F+Ft?=
 =?us-ascii?Q?hW+qo5F0F/y3WI0fGlX6EK3s/n7P1N5QfBia+fVCEDvauAHZH4j8Dh8+4LxT?=
 =?us-ascii?Q?xgRjktKkIpUrCa1OqpxeVln0hVrXNPk6vRT87M8X6o43xqDPtck3IlfVGMDL?=
 =?us-ascii?Q?PcammvR/E5y0Tv3dH2L2mZM+y6l65zsinsmWe099kMxq3tnJQu3pknLnaeuZ?=
 =?us-ascii?Q?iqLowmkA39RdeFb+fChTm4xPQz7FGIxVScm0BJ5vpoVpr+RNunwu0sZP53Hy?=
 =?us-ascii?Q?JJOtu4hILVKLWvWMU8lERh3n2iBVn3+J/m3gWLbO/QAVmJRLSY1xs89I/Uug?=
 =?us-ascii?Q?n+Gksv9QFsQAV27gN2IJf8tc/blXyfcSgLC2bmH0k+BPR51yfwY1b2RvD7+v?=
 =?us-ascii?Q?6wHlN50gVkh8ktuZbfoYmZqI3I3H5uI7N4vhrZlXn2cLPCGWPpCo1EX1DRmA?=
 =?us-ascii?Q?LpRZwm4RIGOVAs4GJgKscsW6oBGo3BrcJmgNa2YNXRbmm26pC3DzhY4UxzPo?=
 =?us-ascii?Q?YqO6LprI/kgAqueg4kpF3Vque4aBNfB01O08GOvlOfsm3I/+InAU4wjVqqV4?=
 =?us-ascii?Q?32QaiV/jqPuYjX/zIeYZMr8Ch03PrZEFm+Y689jZ14YLELcakfGv7NyJa+UQ?=
 =?us-ascii?Q?Q7L6h/zAdu76/0LA3h3CWEWGym8SzGW6wXSIWtyiHdZPTCL3UxXAs/HiFtZE?=
 =?us-ascii?Q?sYoDZZq/5AC8By1wv1AO25hAw4bAG/UpNd2tVTPJ96mGRrYxFgRJtauq2zoi?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3kMzXS8M60xrWg7IswmnQzsdEFw3FgY9fJLekF4Kmv+/axG9DpuOxksU5iuqeovnryJWCNj4/VTkGnX9JvzAiTamhxwC4kpC8S555gTlRpK82hMA99E7IAp9KBr5uvLTlA+0AtatqZ8JjhtXuGp4ikqZz4ZkSKDxYolmlWuK0fuNAJoI4xetxqv0iV4fARYc4X+vKoA+90sF9L5mcHSWtq3gMLwSibXiPUqvCFtcNZeLv24KjlDbB/Tr5oT2DgA3obJGPtTvtvi1h4mHFUIY7WYJVTE3IfD7RE4Qndi/TNUXek+4DMTKg6gkm2ui17akYVzjnx6gf0V3ngwRXUBuV+9YHqdoYPrAVZH1D8nQt7igV5U7Lcb/C+QDERK7pNGSnjpMwhGWTvg2qHnhOOzvr+lJGlT//BhYHhLEgnKNva5k98NqtpR4EhFewUnL3I65oVDl72x8vH6g1426avagOmyo4XwgkX4GKhrfxSoPBznIFDKfSfcSzgPcG5dZNtSFg33j7dy3pJVrA3O36fNEhd5pG8Wm4jXQI1I+j/P4nHYFcrzNwIPSg7PqpCwdbCrDqfLTlIJk1r3W0zdlC6HKAPchG3oqHfzzb6G6+kjQk5g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8b1e39-7f82-4e21-3a24-08dd8418a907
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:46:00.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdJG7bTWLmG39pHQjKM38iyr4Gg6T3NDMh/1f4He0NivITIDVcMNvXXH1/X1G0wrOsDWYrGqmcjZBs6czcKAAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA3FC49FBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250118
X-Proofpoint-ORIG-GUID: FoWefy15PKVJJrqAOQ7JSnyEOWROsHP1
X-Proofpoint-GUID: FoWefy15PKVJJrqAOQ7JSnyEOWROsHP1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfXw87tqUuZrFU+ QuBaYmtJEpmKzT19T8LUm3aR0wfPHA3a5OwVEt+mS3lBRofwvdgEQK8acd5FT1DDcY4oKwleDeZ WOWRIE3SwIAR8cBGTjc8xfl+Eg88jx2D4XZ32lTnoB6L4XagSKShyBGX2DyV0eOIsKy+K9hIp4Q
 CRNwu54cc+5zWe1uJPF3Ue12Gq+Woa00ORbdvI9Tko8Qv1s/rdn93sR14tNaN6EKQDeNr6wwkJI rKz/3pq73zSUh7qpcHhZMtnlwdupyOVPwgmLDUdQju5VPBGXMaM0i+n4KpO3AL0xRfCkKFA/cnE r+Dv/5cRjzZmU2OT+k1buvU+cm7h2P2ipINQ9CNh88aRRAnbchyc8Db9KIXJraNWzTXoY+zmEC1 HBXUaPJr

From: "Darrick J. Wong" <djwong@kernel.org>

Introduce a mount option to allow sysadmins to specify the maximum size
of an atomic write.  If the filesystem can work with the supplied value,
that becomes the new guaranteed maximum.

The value mustn't be too big for the existing filesystem geometry (max
write size, max AG/rtgroup size).  We dynamically recompute the
tr_atomic_write transaction reservation based on the given block size,
check that the current log size isn't less than the new minimum log size
constraints, and set a new maximum.

The actual software atomic write max is still computed based off of
tr_atomic_ioend the same way it has for the past few commits.  Note also
that xfs_calc_atomic_write_log_geometry is non-static because mkfs will
need that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/admin-guide/xfs.rst | 11 +++++
 fs/xfs/libxfs/xfs_trans_resv.c    | 69 ++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_trans_resv.h    |  4 ++
 fs/xfs/xfs_mount.c                | 80 ++++++++++++++++++++++++++++++-
 fs/xfs/xfs_mount.h                |  6 +++
 fs/xfs/xfs_super.c                | 58 +++++++++++++++++++++-
 fs/xfs/xfs_trace.h                | 33 +++++++++++++
 7 files changed, 259 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
index 5becb441c3cb..a18328a5fb93 100644
--- a/Documentation/admin-guide/xfs.rst
+++ b/Documentation/admin-guide/xfs.rst
@@ -151,6 +151,17 @@ When mounting an XFS filesystem, the following options are accepted.
 	optional, and the log section can be separate from the data
 	section or contained within it.
 
+  max_atomic_write=value
+	Set the maximum size of an atomic write.  The size may be
+	specified in bytes, in kilobytes with a "k" suffix, in megabytes
+	with a "m" suffix, or in gigabytes with a "g" suffix.  The size
+	cannot be larger than the maximum write size, larger than the
+	size of any allocation group, or larger than the size of a
+	remapping operation that the log can complete atomically.
+
+	The default value is to set the maximum I/O completion size
+	to allow each CPU to handle one at a time.
+
   max_open_zones=value
 	Specify the max number of zones to keep open for writing on a
 	zoned rt device. Many open zones aids file data separation
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index e73c09fbd24c..86a111d0f2fc 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1488,3 +1488,72 @@ xfs_calc_max_atomic_write_fsblocks(
 
 	return ret;
 }
+
+/*
+ * Compute the log blocks and transaction reservation needed to complete an
+ * atomic write of a given number of blocks.  Worst case, each block requires
+ * separate handling.  A return value of 0 means something went wrong.
+ */
+xfs_extlen_t
+xfs_calc_atomic_write_log_geometry(
+	struct xfs_mount	*mp,
+	xfs_extlen_t		blockcount,
+	unsigned int		*new_logres)
+{
+	struct xfs_trans_res	*curr_res = &M_RES(mp)->tr_atomic_ioend;
+	uint			old_logres = curr_res->tr_logres;
+	unsigned int		per_intent, step_size;
+	unsigned int		logres;
+	xfs_extlen_t		min_logblocks;
+
+	ASSERT(blockcount > 0);
+
+	xfs_calc_default_atomic_ioend_reservation(mp, M_RES(mp));
+
+	per_intent = xfs_calc_atomic_write_ioend_geometry(mp, &step_size);
+
+	/* Check for overflows */
+	if (check_mul_overflow(blockcount, per_intent, &logres) ||
+	    check_add_overflow(logres, step_size, &logres))
+		return 0;
+
+	curr_res->tr_logres = logres;
+	min_logblocks = xfs_log_calc_minimum_size(mp);
+	curr_res->tr_logres = old_logres;
+
+	trace_xfs_calc_max_atomic_write_log_geometry(mp, per_intent, step_size,
+			blockcount, min_logblocks, logres);
+
+	*new_logres = logres;
+	return min_logblocks;
+}
+
+/*
+ * Compute the transaction reservation needed to complete an out of place
+ * atomic write of a given number of blocks.
+ */
+int
+xfs_calc_atomic_write_reservation(
+	struct xfs_mount	*mp,
+	xfs_extlen_t		blockcount)
+{
+	unsigned int		new_logres;
+	xfs_extlen_t		min_logblocks;
+
+	/*
+	 * If the caller doesn't ask for a specific atomic write size, then
+	 * use the defaults.
+	 */
+	if (blockcount == 0) {
+		xfs_calc_default_atomic_ioend_reservation(mp, M_RES(mp));
+		return 0;
+	}
+
+	min_logblocks = xfs_calc_atomic_write_log_geometry(mp, blockcount,
+			&new_logres);
+	if (!min_logblocks || min_logblocks > mp->m_sb.sb_logblocks)
+		return -EINVAL;
+
+	M_RES(mp)->tr_atomic_ioend.tr_logres = new_logres;
+	return 0;
+}
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index a6d303b83688..336279e0fc61 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -122,5 +122,9 @@ unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
 
 xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
+xfs_extlen_t xfs_calc_atomic_write_log_geometry(struct xfs_mount *mp,
+		xfs_extlen_t blockcount, unsigned int *new_logres);
+int xfs_calc_atomic_write_reservation(struct xfs_mount *mp,
+		xfs_extlen_t blockcount);
 
 #endif	/* __XFS_TRANS_RESV_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index eebd5e7d1ab6..a6cea25b3a7f 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -740,6 +740,82 @@ xfs_calc_atomic_write_unit_max(
 			max_agsize, max_rgsize);
 }
 
+/*
+ * Try to set the atomic write maximum to a new value that we got from
+ * userspace via mount option.
+ */
+int
+xfs_set_max_atomic_write_opt(
+	struct xfs_mount	*mp,
+	unsigned long long	new_max_bytes)
+{
+	const xfs_filblks_t	new_max_fsbs = XFS_B_TO_FSBT(mp, new_max_bytes);
+	const xfs_extlen_t	max_write = xfs_calc_atomic_write_max(mp);
+	const xfs_extlen_t	max_group =
+		max(mp->m_groups[XG_TYPE_AG].blocks,
+		    mp->m_groups[XG_TYPE_RTG].blocks);
+	const xfs_extlen_t	max_group_write =
+		max(xfs_calc_perag_awu_max(mp), xfs_calc_rtgroup_awu_max(mp));
+	int			error;
+
+	if (new_max_bytes == 0)
+		goto set_limit;
+
+	ASSERT(max_write <= U32_MAX);
+
+	/* generic_atomic_write_valid enforces power of two length */
+	if (!is_power_of_2(new_max_bytes)) {
+		xfs_warn(mp,
+ "max atomic write size of %llu bytes is not a power of 2",
+				new_max_bytes);
+		return -EINVAL;
+	}
+
+	if (new_max_bytes & mp->m_blockmask) {
+		xfs_warn(mp,
+ "max atomic write size of %llu bytes not aligned with fsblock",
+				new_max_bytes);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_write) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than max write size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_write) >> 10);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_group) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than allocation group size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_group) >> 10);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_group_write) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than max allocation group write size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_group_write) >> 10);
+		return -EINVAL;
+	}
+
+set_limit:
+	error = xfs_calc_atomic_write_reservation(mp, new_max_fsbs);
+	if (error) {
+		xfs_warn(mp,
+ "cannot support completing atomic writes of %lluk",
+				new_max_bytes >> 10);
+		return error;
+	}
+
+	xfs_calc_atomic_write_unit_max(mp);
+	mp->m_awu_max_bytes = new_max_bytes;
+	return 0;
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -1168,7 +1244,9 @@ xfs_mountfs(
 	 * derived from transaction reservations, so we must do this after the
 	 * log is fully initialized.
 	 */
-	xfs_calc_atomic_write_unit_max(mp);
+	error = xfs_set_max_atomic_write_opt(mp, mp->m_awu_max_bytes);
+	if (error)
+		goto out_agresv;
 
 	return 0;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e2abf31438e0..5b5df70570c0 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -237,6 +237,9 @@ typedef struct xfs_mount {
 	unsigned int		m_max_open_zones;
 	unsigned int		m_zonegc_low_space;
 
+	/* max_atomic_write mount option value */
+	unsigned long long	m_awu_max_bytes;
+
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
 	 * Callers must hold m_sb_lock to access these two fields.
@@ -804,4 +807,7 @@ static inline void xfs_mod_sb_delalloc(struct xfs_mount *mp, int64_t delta)
 	percpu_counter_add(&mp->m_delalloc_blks, delta);
 }
 
+int xfs_set_max_atomic_write_opt(struct xfs_mount *mp,
+		unsigned long long new_max_bytes);
+
 #endif	/* __XFS_MOUNT_H__ */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf509..4cdb161a1bb8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -111,7 +111,7 @@ enum {
 	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
 	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
 	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum, Opt_max_open_zones,
-	Opt_lifetime, Opt_nolifetime,
+	Opt_lifetime, Opt_nolifetime, Opt_max_atomic_write,
 };
 
 static const struct fs_parameter_spec xfs_fs_parameters[] = {
@@ -159,6 +159,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
 	fsparam_u32("max_open_zones",	Opt_max_open_zones),
 	fsparam_flag("lifetime",	Opt_lifetime),
 	fsparam_flag("nolifetime",	Opt_nolifetime),
+	fsparam_string("max_atomic_write",	Opt_max_atomic_write),
 	{}
 };
 
@@ -241,6 +242,9 @@ xfs_fs_show_options(
 
 	if (mp->m_max_open_zones)
 		seq_printf(m, ",max_open_zones=%u", mp->m_max_open_zones);
+	if (mp->m_awu_max_bytes)
+		seq_printf(m, ",max_atomic_write=%lluk",
+				mp->m_awu_max_bytes >> 10);
 
 	return 0;
 }
@@ -1334,6 +1338,42 @@ suffix_kstrtoint(
 	return ret;
 }
 
+static int
+suffix_kstrtoull(
+	const char		*s,
+	unsigned int		base,
+	unsigned long long	*res)
+{
+	int			last, shift_left_factor = 0;
+	unsigned long long	_res;
+	char			*value;
+	int			ret = 0;
+
+	value = kstrdup(s, GFP_KERNEL);
+	if (!value)
+		return -ENOMEM;
+
+	last = strlen(value) - 1;
+	if (value[last] == 'K' || value[last] == 'k') {
+		shift_left_factor = 10;
+		value[last] = '\0';
+	}
+	if (value[last] == 'M' || value[last] == 'm') {
+		shift_left_factor = 20;
+		value[last] = '\0';
+	}
+	if (value[last] == 'G' || value[last] == 'g') {
+		shift_left_factor = 30;
+		value[last] = '\0';
+	}
+
+	if (kstrtoull(value, base, &_res))
+		ret = -EINVAL;
+	kfree(value);
+	*res = _res << shift_left_factor;
+	return ret;
+}
+
 static inline void
 xfs_fs_warn_deprecated(
 	struct fs_context	*fc,
@@ -1518,6 +1558,14 @@ xfs_fs_parse_param(
 	case Opt_nolifetime:
 		parsing_mp->m_features |= XFS_FEAT_NOLIFETIME;
 		return 0;
+	case Opt_max_atomic_write:
+		if (suffix_kstrtoull(param->string, 10,
+				     &parsing_mp->m_awu_max_bytes)) {
+			xfs_warn(parsing_mp,
+ "max atomic write size must be positive integer");
+			return -EINVAL;
+		}
+		return 0;
 	default:
 		xfs_warn(parsing_mp, "unknown mount option [%s].", param->key);
 		return -EINVAL;
@@ -2114,6 +2162,14 @@ xfs_fs_reconfigure(
 	if (error)
 		return error;
 
+	/* Validate new max_atomic_write option before making other changes */
+	if (mp->m_awu_max_bytes != new_mp->m_awu_max_bytes) {
+		error = xfs_set_max_atomic_write_opt(mp,
+				new_mp->m_awu_max_bytes);
+		if (error)
+			return error;
+	}
+
 	/* inode32 -> inode64 */
 	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
 		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index d5ae00f8e04c..01d284a1c759 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -230,6 +230,39 @@ TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
 		  __entry->blockcount)
 );
 
+TRACE_EVENT(xfs_calc_max_atomic_write_log_geometry,
+	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
+		 unsigned int step_size, unsigned int blockcount,
+		 unsigned int min_logblocks, unsigned int logres),
+	TP_ARGS(mp, per_intent, step_size, blockcount, min_logblocks, logres),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, per_intent)
+		__field(unsigned int, step_size)
+		__field(unsigned int, blockcount)
+		__field(unsigned int, min_logblocks)
+		__field(unsigned int, cur_logblocks)
+		__field(unsigned int, logres)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->per_intent = per_intent;
+		__entry->step_size = step_size;
+		__entry->blockcount = blockcount;
+		__entry->min_logblocks = min_logblocks;
+		__entry->cur_logblocks = mp->m_sb.sb_logblocks;
+		__entry->logres = logres;
+	),
+	TP_printk("dev %d:%d per_intent %u step_size %u blockcount %u min_logblocks %u logblocks %u logres %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->per_intent,
+		  __entry->step_size,
+		  __entry->blockcount,
+		  __entry->min_logblocks,
+		  __entry->cur_logblocks,
+		  __entry->logres)
+);
+
 TRACE_EVENT(xlog_intent_recovery_failed,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
 		 int error),
-- 
2.31.1


