Return-Path: <linux-fsdevel+bounces-48004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9435AA8553
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8973BFB06
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2835C1E8847;
	Sun,  4 May 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="drgmKAbC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D5vz43sR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11671C863D;
	Sun,  4 May 2025 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349351; cv=fail; b=OPuI9/4r5g8Y/ncXWPUnuZ1DXfnR5p/PdDWnA4Hjwaq4728Wbu/UaoOPBLjCCF9FZOFIRgvBpumkU0WLM7CGgX059p6eKUiGZyGZBgA0Pj6Aca3OGP+H1JHHz9AoUa59DNB3YenYawLRQQohc7B4RXFAx7JaeNHvezLgRFkgc4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349351; c=relaxed/simple;
	bh=zin1cGnHDBDRrW3jNLQStqqddLgWyLLs2LbDahuY/MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1TQ9bmGM/jvPghxwUF7lT2N7LhhBzvVUAv7B9yuko216eTM8zTPCE/dTV1MOQnpqiy5GmwGrhNaeYhITLf67nFRF8+LSxstgXZFTwjdmFR82L+CWCgoRgjA54FIV+VXszpQKGFnzUzZl6jZZ+Z7BRLgbaVeebEMSOg50/35Qf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=drgmKAbC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D5vz43sR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5447anrf008269;
	Sun, 4 May 2025 09:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=srLclYblBb9JiBMt5Z335oUdMAMav4Fb0kt3AvrsdFQ=; b=
	drgmKAbCuicYkW5z2BGgarZBjcqSK7A/JqzINDvlihLXI+gbg5iwqjcOCaIg04Xp
	OHBRpyyDFqS6qumq33uSSZ9Sr1uz00D0ba7u2Xq3WasiSlBkUVohCFho71iOzR4P
	4tWsC2RE2sHFtidOFr0myNScc62I7TlqBPOW3dEWjITjqdlqKMSDsvFZbOuMUf3K
	hKC0l1eKGK/TR2KtYwT4iXKqZ84o13Kv1sZJlic9s/QHIJR0yQq5gEsK8JSu/jPu
	DiM54T2q/DNHFMaITVF7vlz3swGJwKk4p5f8r0Eq0YKaahkizCDqcN+4sSfIxMmr
	kLvoMkHQ2hpB/5g5P6pNFg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e40gr2x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5445o3rj037649;
	Sun, 4 May 2025 09:00:16 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012052.outbound.protection.outlook.com [40.93.20.52])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k6gfq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtCpNANmVu5Y+CbsbNM1l8XHTXoFESL7r4RI1oT/kTeU1TVXfYZH1XCU7N+/W1lES+ACFEUXoWChw2pUTKRYomuCQYT2ipe5hDmYNfr0FC+QX4LiO0dedZa4z/8yZlI3fFmoIQEP+dNIB4k9GCWjngjoAGfmosx71omEss6hYbvUzLyZyhBUEF6JpLs8GYCYA4VrczKlehOv9uz5lvdZ1g3at1gxTAPqPNBEpmdOXfk0HL18geazHWaDVACzENZmFxVn+GuNEXPYJD+S9oOuXf2LT50wjEbkMgE5w0la2r6vGsr5KQzPL8nsoIWhUnRHUDU57hVI/bHRpwLU+NgwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srLclYblBb9JiBMt5Z335oUdMAMav4Fb0kt3AvrsdFQ=;
 b=xIyQrmfYnKzGkO5RQtUvq5fpaPTVcYw+lZautt9iBpwWqCdzH9uwmgeyBIwXgEJYmkMG0weFqG8NAARSlTFbbO6ObUdpxeLw9NZvT5l5rSJCjEmfrvCIRnC0N7b6xzJ0eOIRaR7O7fDbk3A7W5j3njgsarlaio3uxW1aoVhNuZG2NoWGdxip0mC4vBuG028/GQ/mUwZfDmb9lSfS2x0BSgfzyPhksGp0fnd2emiwzmLvnhs1O6+R7EBKgk/ULE8ISAzMqHdOdJecrYRyJHGQmkr0DEHREjuqhLTRE44WvQXUpnbCovHUWBtYQWq/a+3DJ1c7RIaBx/y6zITY7vjgDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srLclYblBb9JiBMt5Z335oUdMAMav4Fb0kt3AvrsdFQ=;
 b=D5vz43sRwrgs6M7je406VE0a4Y/thUj9vqifcCpr49tTh0C87RrW6zK5nSA1ViAVTxVxFDeRGq2KAWyh2oPuoE4HkxkQOwfFfoJLZlHcn4D6pN7uiWy/oeFnHn5yV14S9f6ST3jdbshALq/OdxaYE6FHhwX+LCT9xW6CSJ+Fu24=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 09:00:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:12 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 13/16] xfs: add xfs_file_dio_write_atomic()
Date: Sun,  4 May 2025 08:59:20 +0000
Message-Id: <20250504085923.1895402-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:208:237::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: c41d20f6-0af3-4092-194a-08dd8aea144a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?grvkqlILi1/pLmLtfQFSBQqHMeF2h9TQNZn991/l8IK3POi9PqhUCQCUW9rb?=
 =?us-ascii?Q?g2bGzRGdpQ/bn+6lWrAXHMWYy3Z5VOLlfnYtMkWQLwsWZ0N7jdSimHkTMdM2?=
 =?us-ascii?Q?FsARV7HSZSO7khooT0eRYh0Neyr3BCS1KXrY1k+W7mmRuCCVEJ1VAkO8w2ch?=
 =?us-ascii?Q?Jz1v3jQLzQILz3NrQqRy/SR0HgH6lpVpa6G4Iii98N9AlfFsB/xUIy/D3nDZ?=
 =?us-ascii?Q?LzufE/l7HNLd2MyldhRRje5w5Vz3Ye9rp8wxduVTuraex2I065bNiEDZwWV1?=
 =?us-ascii?Q?Xt5nZez5D186fZ2hDOLCzZBMMwM3Qe5/Wq2bPN2MG0GtB3G89vAa2lT2fRoz?=
 =?us-ascii?Q?Mr2SaqDjxVkdwFP+Q5DfE1CpudLkuCjCkIzOvvg29t3E51O5SOADVJl6lKsl?=
 =?us-ascii?Q?NwWCiOO+6EC33/HqqXxNHmomy9q1po7js7cVRrIQvgEubsoMRwva5Mh5baow?=
 =?us-ascii?Q?EPOKuhix4VOqtMDvzhVN/S58SxDDzOSWr5Ewe0FrhVuWY/ap8atuW/EUYsHY?=
 =?us-ascii?Q?9hrn6RjovL1yn8KbLYifvMt+CsXkZVNwwhQh4QRrm325Plodtcjs3m8KtxZ/?=
 =?us-ascii?Q?xeNJmv7mbSixsSV/Ns0Jz99abpToYELPp/LZoODNzNSb70i2G43Pp9Kc2QG/?=
 =?us-ascii?Q?JFVr19Hggj38ymR1XnkzfQRsGqLHoqPlPpfP14eLRIQohcPHxLvig+BU6BRb?=
 =?us-ascii?Q?vg6mGD+Z19k5/oWFFBVGq7U3MRxN0s05ZOearcHxyP0lAN0ezpgbi0ATVT9z?=
 =?us-ascii?Q?mhedjm8iG8N4CTthVA/vhNMdwNAWKUJ3sTYtS+Ge3pLD+O9qkQqHQrCNcCrb?=
 =?us-ascii?Q?RnrfbHWb8QMuTgJJZtjUoUtOxh6OWn32d8qxfwLOIwJi9nHkg9jO1FKRRgZn?=
 =?us-ascii?Q?jgxd1bArp3YaOw4a0p537fFjwmwDoR1STU2i+B3WRyysGbFXm7WGpLTw3/+g?=
 =?us-ascii?Q?/cxtEXWSVrS7doIfE2hL3tA/MBA3MjrGYyh/r745KPzc3m56acvsKuouIjoT?=
 =?us-ascii?Q?zRqXUUG+pvZ687l2mmT45i5p+jcgdR5k/67/Kky4Gf1eOsuy7niwH78ZMs4J?=
 =?us-ascii?Q?/aCDdKd2jaFBDKzqoWjqTnMEwZIeqJ8ZegtBOECkkYRQZNMlBe+HaAsq1O6s?=
 =?us-ascii?Q?CvabbThd//Q1J/ebrEmoAYL4w9DNhXO7n4F+KRjE/ihdRvFfB/tauGLMlft9?=
 =?us-ascii?Q?lGlRZZNxCC+N9UYsN/tlZ4bMEgPbCNY0oaGNaO+3f2nNCK1gj3vaSuJFOkvX?=
 =?us-ascii?Q?UJ4UaN89yWdek1qo6O49sPB/j8AgaPTGI3bxKgbmxg0CWQOLVCRyNMNZxG76?=
 =?us-ascii?Q?Y6tG549NkunYT7THaG2fHOEYsfLsW3eQtmKxxTpMTyRYpRr8h/gkwvxDY/nt?=
 =?us-ascii?Q?jVEL6wIb5NpVaZJZf1NHzfwR3H5FnFrSnX9Po8J1LmeQrnIKNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s8KAPnXvOb/igOyuTjENCALGS18V04pgh/PMbbbA1OgsUsnokqg2KxLRFmjY?=
 =?us-ascii?Q?LGKPse5BO18cK6mdXgQn0Tl4c1dwfxQa87vw3rQ9WGINlTPOsN1QWSNqwYDZ?=
 =?us-ascii?Q?41J3lmVt7wap9hCCnkaFg6PJ2tWQc5tDHBrYdL3bDsPgDZW5kmbyGKoimcg1?=
 =?us-ascii?Q?xtyq+tuFnfJJtDgN+Die3VgXEEIc/NZKgXBXtKEgRbX68GLpGIEb4jufkCtd?=
 =?us-ascii?Q?3kbtzTijLIM/2g6WDwBeZIZkIihKdBxbWaJWnfta3SIZM/QjDJJeN3Mliyjo?=
 =?us-ascii?Q?Zwyz6KoESEQEBhhoQYzRpeZXKjtBFE4ejwDKwoZI4bM975WqTI58RcLPPgjT?=
 =?us-ascii?Q?6k82xl6ucGuZpm929MfSQWrHNB4372Y4qg0W5QDC5kpWgMM7L+OhncOaui8c?=
 =?us-ascii?Q?w4a82CiCcAihAlMvA9+JNIkND/44UxKXaf4gZMVhWRDIej4MYxJwCJl6yZcP?=
 =?us-ascii?Q?WVcjyA3JKnHCYfbZSdyMrxNz6JO8n5ynZktNYCFg+kW1Zi1imEBSz8knPvF2?=
 =?us-ascii?Q?ekjoreOa8jfZZ4KOTR9zVhD7RNugH5m9oagFV5n7AaQsHirtL0hOlRHFcqDq?=
 =?us-ascii?Q?bOzxuN6DLGeMND/q/MSY39CLsyrI0oVLRCyVDiujXtL05EMNaeDUGHbFv8oP?=
 =?us-ascii?Q?kRTY1zHczENaWZ7kc/HTT5CoZhHCN3yvH5Pgmevlzy/NQLzYGaTtCvsjwklT?=
 =?us-ascii?Q?XiylkRMVE5c3/u7ggRQ/0WAI/l2YNVOp1uIrohyA6Tn0/sDYswm/nvyQVKqX?=
 =?us-ascii?Q?r3evAIAzMmAZZivjD9FG0XbQAXolbBIodh6BvonyzmWgBOFQarwux3/jutDU?=
 =?us-ascii?Q?cWHWTNOpUhB9EtPjuTod2upC3S8SlWQnE6kvwWAR6EfOvGYyGxHbTelTvjkn?=
 =?us-ascii?Q?RiD0uD33hQxQAQ5RtdrmCLgoztyD0uA6wEFo4Aq069SuT02nzQcwQAsOuCrg?=
 =?us-ascii?Q?ns6xdovAmEtyMuJb6b6PobaW949YG9fQfKeDvhIIOebBlozZxyNCGkTuD1mF?=
 =?us-ascii?Q?FE8x0pwtwYVYyX2JEGYvVz2ZxV0L0MW9pWsG17ynSQbHBFvxvy5b2iSjxJ4r?=
 =?us-ascii?Q?Xmsq0dFovYIP4d3z8pRG+JyDd45dDtbh+Z5wvl9EXQuCpGuV3hdk1e7YzpPv?=
 =?us-ascii?Q?bWqEaJZ4gafFnw5uDLT91ePSIQl8wc85yHLIfUREeA6a8pJ3hg6fWVicZ6OG?=
 =?us-ascii?Q?F8sjr5Ho+KKB4S9kMp3DjqvbNBWplhoYna84eUtyE9sdC4nL+fgjydgwTbzG?=
 =?us-ascii?Q?lY0mQvV49+fMsqN4v5R/LLWnozv8w7DZo3t9Jq2kVO85mUbNHZffu4zxq/7P?=
 =?us-ascii?Q?p58LA+fqUS+FmSgwuZrQC8e/uMWXjAHQ5cmRt4u/czTUL3arC3rwbMe8kFF9?=
 =?us-ascii?Q?ZqWNH7oEuQmAX7ih3t628V7jl1jI1UrRjO1/dzuKVOY9A5UNOQiuUKW1anFP?=
 =?us-ascii?Q?wZbTEcf9iqmF93Naar6/mMcexCmWcnfhJjYQkUJaXp8IL6naZ4KWetpggQtz?=
 =?us-ascii?Q?c4zUQ+YorT4nLrKWGJHJ1miiMefDPwW7oNnPCtZ0GYaJ43NxnDihebJvKs3R?=
 =?us-ascii?Q?1anL9v8W5l/q7dVdW4nv4TZL0wQdtpsSTw6hK3q1KkdjgpzmwZtpECrhRtk6?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FSN1LdFrPwlgtRqRzOXcfTnflzNV2VmRpm1JZOTE/uk1gPjRx3IW5//IjjxsbmMCXUemdYY0gBl6bxWFYjyQ8iSi3lp62+2zEs4cvJmyiYO+5tG2Opn/mRldHKAOjfnzb+nw7imIYSBsDqzOirtQU/TU9eifSnc8kL+hnc2CRizyEca+pUT/1nznNxDzheVVd7+JTjRMdt4I+MB/k93/r2dmlc6EhJrm3DI914Iuia7SHAwK7FkPB2e7f/oDA8ZWqpaHeqzxEdB53iAYKfm7ZsRk7DDviRJjv0UTdlwtotQEeVaEBBALl5wRBkBvjMO/CK19eU2StEusa9Me1x9sntZ8jUgZMLxpI1xnstIjA4OH32BQq5Ka5TW34TsfA4veRonZ3OddMYlB5nK3sHAo/R4ARfhhLkmyjdc/SK8kBf1jDrhn8QAgYeXEWu8HeZKH041TaU4owtJXzbWFCD+88k7w5uX1WRsUOS6uXGaKmYUuoS6nNBuVv50JbJ8TL2pheuu+KvD0XXL7iKjnR3XBGxg4S4jfFghfrvIu9nSF2aYPBgeNi7flxA9BdEWdrujtyxC0xfarnNBxXS7sf9ecVgHq3Prb/GTzmMLQLn/02kQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41d20f6-0af3-4092-194a-08dd8aea144a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:12.5103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1NU6YOqzhWTQdNJnLf2cLyzXjhlGWm5aZheEbq5/LJLoXU5T2vG8Bvu2FZ4ep4Y2WRqxCLSZFgGcRH3E0VxSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Authority-Analysis: v=2.4 cv=Y4H4sgeN c=1 sm=1 tr=0 ts=68172ca1 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Y8Big0Z5EXcV7lnze7oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfX2mpPNhU4mh4x SRladcEDcjVz5ScLKXE71ZlphDlLhnCvtRXuWYR81tHh/Afev30P9SqEO+uhSvpIq4tzoOIu990 acxx0ZGg6dX6m+EeWo/LSdgsBxu6JmirjjPNiiqJUFUxN+1ALzzS4rz6Va2LAlnFczLxT5cIb4H
 LrCTuMhthwM0Y/6Z/ULGD8iPSbk7vlGxczMX0Gmkm8KeIG8pQ5jFw+125OGLuXOHm6UrQygjhZk Uu57+NfwjCzPHEU6p+P5EfZvgzuGKnyF5UHuZPy22IC6PLPy/dtp3qCl2V5CezCeYD5iZ/71bqX Z0yvNIWassxMVaBoG0nRUNvsVWn+BnaOCY62ZyyHjvBmFGvGmJvZGzj3CAKqPzrGky1JT+5yTkm
 jtQDCd/2BT18Iqkdrt6to6e9VAW3XqGe0nCSJnAHZmpi/zCvQEYu5qMNdKnBDdJgmVttXfs/
X-Proofpoint-ORIG-GUID: Q8HTXDtxTWsw2fmHsBEGfLmXHypRAzfC
X-Proofpoint-GUID: Q8HTXDtxTWsw2fmHsBEGfLmXHypRAzfC

Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.

Now HW offload will not be required to support atomic writes and is
an optional feature.

CoW-based atomic writes will be supported with out-of-places write and
atomic extent remapping.

Either mode of operation may be used for an atomic write, depending on the
circumstances.

The preferred method is HW offload as it will be faster. If HW offload is
not available then we always use the CoW-based method.  If HW offload is
available but not possible to use, then again we use the CoW-based method.

If available, HW offload would not be possible for the write length
exceeding the HW offload limit, the write spanning multiple extents,
unaligned disk blocks, etc.

Apart from the write exceeding the HW offload limit, other conditions for
HW offload usage can only be detected in the iomap handling for the write.
As such, we use a fallback method to issue the write if we detect in the
->iomap_begin() handler that HW offload is not possible. Special code
-ENOPROTOOPT is returned from ->iomap_begin() to inform that HW offload is
not possible.

In other words, atomic writes are supported on any filesystem that can
perform out of place write remapping atomically (i.e. reflink) up to
some fairly large size.  If the conditions are right (a single correctly
aligned overwrite mapping) then the filesystem will use any available
hardware support to avoid the filesystem metadata updates.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 32883ec8ca2e..f4a66ff85748 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -728,6 +728,72 @@ xfs_file_dio_write_zoned(
 	return ret;
 }
 
+/*
+ * Handle block atomic writes
+ *
+ * Two methods of atomic writes are supported:
+ * - REQ_ATOMIC-based, which would typically use some form of HW offload in the
+ *   disk
+ * - COW-based, which uses a COW fork as a staging extent for data updates
+ *   before atomically updating extent mappings for the range being written
+ *
+ */
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	ssize_t			ret, ocount = iov_iter_count(from);
+	const struct iomap_ops	*dops;
+
+	/*
+	 * HW offload should be faster, so try that first if it is already
+	 * known that the write length is not too large.
+	 */
+	if (ocount > xfs_inode_buftarg(ip)->bt_bdev_awu_max)
+		dops = &xfs_atomic_write_cow_iomap_ops;
+	else
+		dops = &xfs_direct_write_iomap_ops;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock, NULL);
+	if (ret)
+		goto out_unlock;
+
+	/* Demote similar to xfs_file_dio_write_aligned() */
+	if (iolock == XFS_IOLOCK_EXCL) {
+		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
+		iolock = XFS_IOLOCK_SHARED;
+	}
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
+			0, NULL, 0);
+
+	/*
+	 * The retry mechanism is based on the ->iomap_begin method returning
+	 * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based write is not
+	 * possible. The REQ_ATOMIC-based method typically not be possible if
+	 * the write spans multiple extents or the disk blocks are misaligned.
+	 */
+	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
+		xfs_iunlock(ip, iolock);
+		dops = &xfs_atomic_write_cow_iomap_ops;
+		goto retry;
+	}
+
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
 /*
  * Handle block unaligned direct I/O writes
  *
@@ -843,6 +909,8 @@ xfs_file_dio_write(
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	if (xfs_is_zoned_inode(ip))
 		return xfs_file_dio_write_zoned(ip, iocb, from);
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from,
 			&xfs_direct_write_iomap_ops, &xfs_dio_write_ops, NULL);
 }
-- 
2.31.1


