Return-Path: <linux-fsdevel+bounces-47387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8EA9CEB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422641BC39DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F2A1F471D;
	Fri, 25 Apr 2025 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PKAZOvSf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P0VFYJsL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6C19F11F;
	Fri, 25 Apr 2025 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599606; cv=fail; b=OBkVLrT3omSxXHZhHgnxSi6CxOekzsGu+YtbU8bYxWBneUKdQjRVpG635OBZ/4dzyUgMMzUwWVwlejK9wFBCYhQ8TJ/a0rVBWZncZ7deqzmT3i/1B4BJQhaAsQRdzLV5HT8CTeVNBfsnv+5/+dfZ96pQLc3BzkvgJPLM9dEE3Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599606; c=relaxed/simple;
	bh=S+N+P9V+2hnC5ROOdlaOurGqopefgfDq+GmCTqjbDuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qY63nuJ4fzhM2zPdFjnFqcPuqW9zqjWlkaAOmCEd0T1f/Ljstxk1ngf6sX0YylBg6Tso3dZ2MznVE1jx6QcLJ1Bls2EHrf3GBmyoKjOIdcO9waFiNJlhLM+wF0TJ/8bILHrKGHLLEFdupKrqTLyMLjDuBkNnWiR5bf7YeWPP2C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PKAZOvSf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P0VFYJsL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGWJel005093;
	Fri, 25 Apr 2025 16:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vW6L9XPnw0AzlcQ0qOyE/PQry3DqvYFrUo4NzC+oiWs=; b=
	PKAZOvSfISAKsL4ZSdcR8bbP7tag79wOIYAmiAbsbXMhtKuFjAFXJnswxvyMctxD
	O3kF1LG5c8uNB3floR4XVN4UWog/2lwcKancYLgmEn7La+UH/Ut97pJcDkyFgjqB
	Y1Y7ri0jRXkeHqkKKdrCihm3YfuWu0brshk85C8Y4rwHIIrctRA1dfItOy6YGbS+
	qtuDhclsXai5zJ9Hzp2PMlSEbGDJlpqT9/ANwaGgjSEDX2F849csE3D0WmdcQv05
	JNWMwKPTi5+L075+pgZoeIkWhh5LT9pI/pw4y0odRs14usAKi6sF0R9VE9rJ4T9j
	rLBb5xSy809m1UPrIeryFQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468e0b01sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFmKBN025290;
	Fri, 25 Apr 2025 16:45:48 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbtnfxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8t+08FPtX88b/lVP8bxnvJK8mus8SZ3x1jlnKNgJTNzhYa2K9xrUpFuT+n2iknTM5tGVsWeNtBQQiJKkeE4yhhYDCzoe5JFyyulCOfdpJVqVYZCqvocaGirSBNhGXSAY9POcbMIUaUptl8/a0Xf9bKntpbqHdK8vSa2SfNOB1/BGxVBnwx5ea1Sm1KE7+15eGGCjRbt50H88WxudiNF+dE01p3LXoGeP75Lw12XoJTrutusNtgd5ilxrPB0/RrjBvNitQOEoIqdjsf3PaJ/67Rot6JBzTvwgKMxxZW19WsGnplgYfjX3+2wQMOIVnuj8APyzGrfNwlL8pEzQYlz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW6L9XPnw0AzlcQ0qOyE/PQry3DqvYFrUo4NzC+oiWs=;
 b=O1uuuOwLXVrNIYEG3XqtN6liJUJVgPvsElYSWAvOjC0QFVeQl1I00LEpHrdVqzz4YErxCE1qZ0Q35jEbECtDLk7QZK5gUCzkB9kahuXrjEx4rhBIQFB/FAFf8u1S4vxaKdXpj03DEoHWAjm1tUzK7uzUa2NPfuHrCwW4Ry68OUEXYjAafPKSSg8mSIxlJb0R/RfAWn/Np2lHpN1hF05pWL6ZfDblh2ojfh5xUwarwhJtN1MbYd84gUPMSHeiHpluM5CjedWOdYJEzW5uUvrHCKQtd7SRt50L1eOPQxm3EhH0I7SqAJcRdCAFXYnhZDzMF/cq0emJkzb/OIKkwzkSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW6L9XPnw0AzlcQ0qOyE/PQry3DqvYFrUo4NzC+oiWs=;
 b=P0VFYJsLyspWLLe1CPQCTvjUe8kAh912HxCF9b1qS2TNIN6oFPJmCFTfuRfJhZIcijVeVhXS3L0tkvFwEv3o5IAfyEzarJv2FgAcyQzLgVdfS0p06BPw28zO3tvLff6Oy3Xo1ozjQrxso/0K9v81MNblDsyR+NItTAga8LdGnu8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 16:45:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:45 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 08/15] xfs: refine atomic write size check in xfs_file_write_iter()
Date: Fri, 25 Apr 2025 16:44:57 +0000
Message-Id: <20250425164504.3263637-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c55aba8-60ca-4f2a-2c8a-08dd8418a027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ELTZ9iY/b0u/lsRwfoOxKLolnxNOmJfJmiwe211SMoDVC7sBGrzQD7enjURs?=
 =?us-ascii?Q?5ViDYxWTBR68nEG7vZQ8j2W56RFT7EaDcvXE4S7v9XGGTF6M+Q6T7wcNfxEi?=
 =?us-ascii?Q?jC81a8CZn8F8vhj4P73qOzYsXe3C/xufRNWoGKuWDyYatLGKd9g5Czr9Kx0u?=
 =?us-ascii?Q?Pwa2bhtgSSEpmG81x7NUPGmmX8TlNZtWmZ/UN0jx5cm0bZO572SLvatIuhAg?=
 =?us-ascii?Q?2PJLDOdpzSTPiBCR8JcYybrsnfMgb7yjymslSlZICE8sAA7+4/3GuA+YtBoP?=
 =?us-ascii?Q?GOfWGmjgxq/H4aKxTUHXEZqaa1fZAUn95Az/niukkaBj5v46ghw721ibYwwE?=
 =?us-ascii?Q?TjdHXuiR9geZKQqOZV4501UDMPGgpt0q9yQfVHcU5fn21EgN/rdMYApI9+AU?=
 =?us-ascii?Q?itoOpRMb3hO1OF1cHm+6agzKN1WsglZOt5pVLgzSn94LfFzyxWTA/1qXvY9+?=
 =?us-ascii?Q?8XvAkMiUJKGYY1fD406F97o1yP/u5codDpu/+ac1BbszW7jRARpEbSNp1RQ5?=
 =?us-ascii?Q?ljcC8MwdPjYyNWBJyQtt/R7mchTWJ8DiuWyPcirq6nTGEXDR+DC4uMUlgAqL?=
 =?us-ascii?Q?v0I7c2tt5vHGuXGZYuTbtefnMSNJ26ebu/ufL4YtRmU9NJ9dq+v1FNtRzZ84?=
 =?us-ascii?Q?N+uI4J047aaa8eGTCqezuP6VTZOzI8t++/e+Dl7HDMehWKeART6aUNCxC/sw?=
 =?us-ascii?Q?k61r85i4uB8fSSJ/nNOEUoVDJbZyH7J8pRBP4xd9hriLH4dseTD7rTtDB4EM?=
 =?us-ascii?Q?wJsdrS6eSXqe/+CWOSLlZgQYoeKevL8vP5/QwaEUvE2deiZ8uVSxNULz4XU1?=
 =?us-ascii?Q?8m1d5ckDocucvwVEpgdoHAAe5OhfTwoVXqi5uvEd0kuXWt9mJtNH1UV3EvMk?=
 =?us-ascii?Q?/wqhA9DJmqQV/JxlVzgrpImhO6rAkoN6V0IpfyWlvC0xnEZkMDIi+NW4Cm5M?=
 =?us-ascii?Q?ujLETARCmAJsWfFYPEfrWgmIa0cLGl2MpVedxsdJtwwbBzARQb2s+Z9uL7ZX?=
 =?us-ascii?Q?h9H/E2hzasp0WBSXTydN6RT/3riPdF7bSGfnO3FojBx4JnURhkZKGFbSJINU?=
 =?us-ascii?Q?2CfOW2WFUUXVvIiiOh+1rD14pU2g9mb+vPGonvzVUVzILO7sgtpGs0IoaxaD?=
 =?us-ascii?Q?vdww8mdT22Y1wHT0doZpoO2J1lRQj+pBXIKr8QFQMCXyitAWjxWdZE8iChBv?=
 =?us-ascii?Q?FX87d3WSPGrsFoS23pKrnecTySW9jzkiFOJNgZtFPtIY0hfeL31LaM2erRly?=
 =?us-ascii?Q?KCLSDMM9MmJTqzFOul08vRCsrnEOJ2xNdiQMl/Xn6jlYTJUxATM3iqluKaTe?=
 =?us-ascii?Q?H4vKa2lW5/RPUIk1clAgA4D5S8UXYklDrNVZ+Vgf3PngCYoaZ9/7YQ/lqtx/?=
 =?us-ascii?Q?Uf4ulxlMVdo0JTKRVX8nM8SQGGADrgRboGeQ23LoTC0NKKZ9zhHT8zxEjtIW?=
 =?us-ascii?Q?pt9svSbA43c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pSOpnXPIzyh/vIbXnBZqtVIfAQRPZZzMWr8i4kpnd/uQaX6P9AKnZmBISanA?=
 =?us-ascii?Q?E5lhotB2orWUSAVNQoLH5S//UF6lfpjm/5Ts2WzFdgxJUfPsPs0mZq/srTV0?=
 =?us-ascii?Q?NzNT0toAipQ3VfiyR3CqdjGrfofjgLcjFBzlmnrGQx08QxtTO/hA9nGCzcQl?=
 =?us-ascii?Q?DqZtbqdSsg6HQTtbW0IE3706V4tU3lcHC/H07Kauf403WfVa4a0hpV/4Olnu?=
 =?us-ascii?Q?C8HMZB0Bk1j5h6cA9zE7jhZiemyp1UisGusw8Qqn+oLhm5ZX6CyJAvtRGtdF?=
 =?us-ascii?Q?TDkX3Qbj10v5gENWTQKzfNWg5TwnTupCMLqQy/wunDhn2oJHDbUMxgsaCZhU?=
 =?us-ascii?Q?QqLooMS2vtp7wLVEw5SyVzAl3QuEMi8rFzGmZKd6m+LsYz2CWcdh13WaYR+t?=
 =?us-ascii?Q?56FgNA+btIbndenw1XMCPOPMPLMMpg1B4HFoBQISdLscCuCDt0JII+1KLeNA?=
 =?us-ascii?Q?YXxDFRppgEd/6QERIEUWqCCDGI5tdTRT+2FTFUDSvi/PAOAxYBqYYh9OJRT7?=
 =?us-ascii?Q?HFwm1qSOa80BAIClODX6sGTOe0po9FevFPy13+0LgAh2BCzxpfi3cXS3s8E5?=
 =?us-ascii?Q?MjBBVAVyaaEMFXIVJz4I0qMDkyWY61Z3WTNTIHJJzQcb7KjDh2Rb+6qS6RUL?=
 =?us-ascii?Q?8DszjJ30arWuR+BX73SLf7L4f8qdhxtDkUSFxXwDYiIEmkWzyAcAHiDBZj6J?=
 =?us-ascii?Q?nQl/zG8k9nvOLhFwQLUw/URua2VDS+wf92BaL1uE/XtwGB8r/CdWarON0L2G?=
 =?us-ascii?Q?WrFY1/NO8MthKgQhelLbyGy5hfb5KWFMELzmwMN5X4WpdDtg0xKyZ9Zg2ucz?=
 =?us-ascii?Q?hcqXGOz1fcaJ8vkquPT3omPSKr2GxLT+W/0MfLbsbB010GLiqfgL/lp48Mav?=
 =?us-ascii?Q?P6QJpyeZS1EPsou+5STpXxVfuRVGDU4Anc/7bcfk94Fuwg/4UctDHc2MivlR?=
 =?us-ascii?Q?+oRR71xIKDkB95+lcXXWt3jKm43eFtkR62rzCq5DLMouWbLlzwM4+c1GMKYF?=
 =?us-ascii?Q?PikQX4Ual++vqtjxXrodcY/DrrZLSyueROWZF7L/zmeve6aQgh1KJA3OXwbu?=
 =?us-ascii?Q?3vWpDTQgdeRMa7YB4BriY+yEysZxiCo0YloVYWclBYfd+ycjoU3fYy0LyEuD?=
 =?us-ascii?Q?OBbQ8LHh8yFjx7QItgRX9Z22OFTreeKHi7ytEbUJ7+QDxRiIQN7vrUexBPyO?=
 =?us-ascii?Q?ACDnXfBEPHhuKvnXCl9JALBAM5z7pMBBaeaNCi8V1NV8zvNmUphXU2l7pTWT?=
 =?us-ascii?Q?JWEvoNSaskG/dxOl2x6w4Nb13qnjAVdvlrVmV1D+Hj0O/KjFPmbN7j5tJKXF?=
 =?us-ascii?Q?0U3ruTZd9C2xV7h5CCj3ecDGJKR+/pkeZv/2jTPxJaEV2s+i5Od5JkJyT2jl?=
 =?us-ascii?Q?MV/rYcq/OLXb9bLOI4iHNReBw2+UhNNRPyaQQ7FBZsUXMEjO9pv8FCSGl/M2?=
 =?us-ascii?Q?p2HK+lq75fLKjW/ZlortRMlU59mwQYyCbGp1IVww36RnDDG/UQCiKgyrB6yx?=
 =?us-ascii?Q?sTedAlZFO75FqSynExQUzpYF1flL11sR5P0vxEeFCrM+nRFatdZB32uUnJ5D?=
 =?us-ascii?Q?Rjw/nCQEE6k+UeNiTfVeq4HSmeFpXOeuQgDP38RE0rCj+ShgS1+La6E2YcoN?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VFn8FmbryJRLhGexEi0y0B+s1vF9Mr7Tu3YdeItTk4ZwL5BkM+IoQ7NDbsN7ZnipFT0XPutVO47PHt9vTlFZeqgtJ/YXMQ0WdZ2R6cVdYPRZtUIIi8D3QUGfH/3uYpMDTBcs8iaVaqb7LCmjMDXlLtSpeE0TqBRWvtogKYAEChGvIJn6M/85GvhbvFw+Isyh/Inm1bU8TDpOCcOFiEnDev/OR89jJJAM8eawTTFdbRiLY7cCT5gJnRjH0WLw3384/Cx2d12EOvqOUpAN3rw04LvWeZTcbeo8dz9BONyprxXWxx2wq7umSB81w2kue4DND1os+RUMR66bebPKfLK/vgyXISFlNHwmKsQy7a5hucJcIof3C7dwC0a6q7rgZ/O6eOLGlh7h/OWg6ak9uIz0t76Yrg9iM9snBEGH3zsEYeAWusjYIMxoC1QN5iFTWcfUQZJkd3BntxF2h+miap0ROWS2V5tBdLEfEJG4t/h5QkbIbD/87lBI5Eb9eo/f/Df6H4Eemc6YnIwziP+7jddo4wcmcsPWb5LI7yQWQPGKW2x7HJiXUjSwSZgM2MKsXJ24aFDGFuS5Zw6oOkBMK4OmD/8P3QlLX8vASFUTIimGUg8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c55aba8-60ca-4f2a-2c8a-08dd8418a027
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:45.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHW+S6GCNBauSYCrPJIJHgTUhDKaQ4zUogDIWlVOZyWdNwsa1OcB/DGzTpLscRsnwwrmQWVffRjYGTer4z+9Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250118
X-Proofpoint-ORIG-GUID: GXpqxC4aNN6v71jiLg3NRFSf9ys0mZuH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfXyMmX9xO04vWE iG+L0x8kd4IiQ7bPa+p7Up34FJBKtZMNNNFBe8VP3pyfwb5dS5Cod8hyuXk332HNtrGhb5aPoRN UxID5rB1CfnhILRvJYqQdvRgxZvkT5SId91O3vLY4D8Hvqj4ywP31Q10Y3yb32zDCRbuvdXDPRT
 Uof04hYUptPQBAOQgb2G7pUmhDtf3e/DM7u4cstqIrhtpSgdW/m9UDAkxMsRkFrbCocJHdRZlnt i9vywZxWXg+zQQ9B/mgW/mFjcYfVChGX97aGvj7e4o19hS0L8Zii9XFIcbE4d1hY2DLWhMz+deC 3wAlblEz3RQRf5H/YzTKK3ZCd4ivDYwEv3ABvud1zcb5cNpttGAG2AsE26WjPcN82janGZ7N84i 2eV3VjI/
X-Proofpoint-GUID: GXpqxC4aNN6v71jiLg3NRFSf9ys0mZuH

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, partly refactor
xfs_report_atomic_write() to into helpers -
xfs_get_atomic_write_{min, max}() - and use those helpers to find the
per-inode atomic write limits and check according to that.

Also add xfs_get_atomic_write_max_opt() to return the optimal limit, and
just return 0 since large atomics aren't supported yet.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 36 +++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_iops.h |  3 +++
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 55bdae44e42a..e8acd6ca8f27 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1032,14 +1032,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		if (ocount < xfs_get_atomic_write_min(ip))
 			return -EINVAL;
+
+		if (ocount > xfs_get_atomic_write_max(ip))
+			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 22432c300fd7..77a0606e9dc9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -601,16 +601,42 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+unsigned int
+xfs_get_atomic_write_min(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomic_write(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomic_write(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max_opt(
+	struct xfs_inode	*ip)
+{
+	return 0;
+}
+
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
-
-	if (xfs_inode_can_hw_atomic_write(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
+	generic_fill_statx_atomic_writes(stat,
+			xfs_get_atomic_write_min(ip),
+			xfs_get_atomic_write_max(ip),
+			xfs_get_atomic_write_max_opt(ip));
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..0896f6b8b3b8 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,8 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+unsigned int xfs_get_atomic_write_min(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max_opt(struct xfs_inode *ip);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


