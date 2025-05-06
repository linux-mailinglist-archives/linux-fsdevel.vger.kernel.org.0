Return-Path: <linux-fsdevel+bounces-48189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AE5AABE5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DB83B1F20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144826F440;
	Tue,  6 May 2025 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XzSxW65F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p3+FU/Uo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3026771B;
	Tue,  6 May 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522332; cv=fail; b=RrLt9x/5blNZMoertGrDjcgOtJ+LKDYTwqDIn0EUZyE11U6UwwF/M1ZaCLNLnL499Ve8H/7RIY7+6MqjEtejkdpsZhp1wielA58YpnV4Y6OJF904jmnrZWZ7ez/V0LOIYOp974dqws79Maurk6kEq0bdbkCLOHmsOkVti+7pVd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522332; c=relaxed/simple;
	bh=Gt86B67ma/3VOL5nB2EHvDqAICS+2kUXqIoSWorB2nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYK5LMnZ7Cv6+i2MvnaNYLFZbmks0Byozk0rcGgSRu1OBu4hxF3E1bSbmdPlQnRJ7vlF29SBv492Ma3zF2T3bDA9gJ6UBfSKv4kcd487xrybqGOc5Wj+uy2Qple9cRgmcWO3Eo/eA8exhgbjhrq2HDoE/Eeeegb4HOExVcmKC7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XzSxW65F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p3+FU/Uo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54682DVZ003145;
	Tue, 6 May 2025 09:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Dv0t/22YJP2ALF5ZPQOIRvcKH44Dz9YaJS5xdbj5Big=; b=
	XzSxW65F17ZG11KboiULMi3MibbsG5v40XFxdQuFullR+LHCIo+abv3Ci47m1rlF
	4YyW1EbahupgQ0jYCV3u0ym3gNBsfhwH3bzyiomCQ37v76MlhPwcURF+BQ3XJbG2
	h+0pMgmKv8hxHhahWh/RlrxVFU3UbxXgLndIGXlo38Cd4g1gKoDb5NLXXWtoFDTG
	oYuLsx0ReplguUBIun43MJUN3//kjeN0cQEc+Xv8hf/f05raHhUgjXqu47a8ef1i
	jcarw8pXunALhyLVpw82DWIxyhPKrGqm/7R5/TNZE9WD48xtRudYGKwDuw7aL/V0
	fAUOxyfZpEXjuLDyNbBTpw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fejbr4w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5468CAR5035353;
	Tue, 6 May 2025 09:05:18 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k8rmqc-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsByen7KTaBODhjVfxqIFsHtWuv7ikq75t6Ia0vriAGCd9WfhyUI3m+TWq2HE1qg2fFy6ONY+4NqQz0horf8fYosKug83nV/TkC1AzqjJKIW34nRZ8TnG7VjQknClojaD38OuWEgVJr3cTpLLyGEUEgoxIcuvuoItEIc9izvkBOYI+asa3EekcrVxHOMHZO/xmjuhxbYWzkJJiHdogJywpJ/RFSle9jX8I0q+RLWUMMiW3MITuIn2/o6OKDqkUkeCdmPrd54aZ6HVHtzy0q2vwmZP2ktoHUPdxshw6sjhaJxgFzLpbtBTQBU85Cf88mNHU4k9aQpi6EYByZCsaZ3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv0t/22YJP2ALF5ZPQOIRvcKH44Dz9YaJS5xdbj5Big=;
 b=uu1J3hkDdV3TqziuTWaIGWGeADs48XyNfY7r5wXq4YH0Mm1leQj2owStyCzPCaAy9j0PDxG0blnbOY5LFRKDkDx8fmENl/bbus+BiKthb9FETQGKnD+cizEZcYDbsTb9f6DDvL9VvdFxKTygsOS00y+zbUxU7DtL78AhPrFk8nJU0WxFuGB471SqWwOPlK1p1eeelr+0wkE3Gxa0IUXOPalh786uzS72ll6dj1JdFmw48aINQl6lvTEUFKS8pbBRHuf98fMJCr82Somcmq2lWJLaTzV3gDVB4XaGM/DPXW6ylrmmoLqbKnedmuTBuVsm5tuaHWS+3VOXrUHcYXN7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv0t/22YJP2ALF5ZPQOIRvcKH44Dz9YaJS5xdbj5Big=;
 b=p3+FU/UoHViM2WopObbX29WqRKcjvrIFBk1t/Rdsh7QGO1gsjaKTa6f2MJtxfLv30fzRafxjMR+AEAz7jn3rN60S5kMFHEkTLS2dh4IrjnCSPaDjS5SS2tOmWI3GfAPSTXIOM+q2dClBi+NI8w1Qaq+b+fHN3wWhXFHYOhFoUcU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 09:05:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:08 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 03/17] xfs: rename xfs_inode_can_atomicwrite() -> xfs_inode_can_hw_atomic_write()
Date: Tue,  6 May 2025 09:04:13 +0000
Message-Id: <20250506090427.2549456-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0078.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8a545c-1666-4c40-ce13-08dd8c7d1982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yUHw0VqY83VtqjAAtqaNge84Ylz0C939vh4y29Emoev9j16Vk/5YMMvcmeaJ?=
 =?us-ascii?Q?Cz6i/zVi1ftTjA0U98ExDEOulCZveoYH9lTcnF7nIC9R/UJXDt5SKRBD1bvO?=
 =?us-ascii?Q?Y61fFYIKUy1zJLTgmck0FllZV9JVx72D1hn7XwN8KB/EnG4QGxnee6YOEFTY?=
 =?us-ascii?Q?5N8PqyHejzcUdMfo7j2Oh2uV82gT8zXZY6qoInuApuS1k6YoYiKjI53cZibu?=
 =?us-ascii?Q?p/TrV9EFBcatUCItrD0oVawyJ9cLv6RW+oJ59wJiyU1AGuMyOUb4jnhDtqGQ?=
 =?us-ascii?Q?lYJuZRvn45S1A6cHDnyYmEla8UmVL/rssckGy03AdNAMGuyGqvge+Gd4zEDk?=
 =?us-ascii?Q?516WSyowEnTpIxHNUL0auiPBdG+FJy5vQrtdW5BwchJjWHxKtiC+f9NrQ0iU?=
 =?us-ascii?Q?Na7/xcw871APkmgW+8oP3wOV2pOOl66WS5AVCf5y/eVtuoR2o5ShtjeqtE3D?=
 =?us-ascii?Q?ac1k0kNqfEGbXimb/D+/XPdh4MkS4Tbv7AIPUJ1LTgn//Og1gKJH14IL2bo0?=
 =?us-ascii?Q?7U2Z51JwyW1aClJXnuHnDEOL9Rka5/FYR8BS+UAXDjwYVPi2Hu6BT5SkofRf?=
 =?us-ascii?Q?Qg1+gFsGljI0t86OEDUQWo1obNGCllIsAQEmAj4/Fh5YADms5JD9W3bb/uqk?=
 =?us-ascii?Q?ontCjCohBQwV5VdtUa/Qq/a0s+2X2szkLfSPYwyQOx3tAh2Ot1PN2I9RjvZC?=
 =?us-ascii?Q?KUBB0MrjvWDaq7jW4bqMWGAeNzW+et8ZuKLrLUxvRaPPYKgdZ6V01x3xB6mK?=
 =?us-ascii?Q?R8Q0m9G8xHiMoDWN1IzmNZBaoGxrRkCJKT1Fdk2f4PeAo1xaDMOTYVzrrC+8?=
 =?us-ascii?Q?1xlK5IgHd4S3J+AliUCOEx4cZezMO3MYhT5NRUYBlSeyF8ss3PrS2F+uyf1S?=
 =?us-ascii?Q?y6DqUt2VthOL+pH3NglpOG/KqcgxDH4jli7JXZ4MpTvfUPprLRd2vLD0z0X0?=
 =?us-ascii?Q?mSHW4rwTOcELUsdGeF3UlgkD/TSGM7AvXau1L7atFES00OAoz/vqZLsaxXL2?=
 =?us-ascii?Q?l5gCczW3XuSg5ZohfTg8WI2cUWx4UHIkkd5IAMvvCa/DL+Fgafl4+1X03unx?=
 =?us-ascii?Q?bnE6ZaE7E3YzBAZIjOoP0RvO3niD2kjqzrLdWU1/+YOdFzp78YiCgSvH7xxl?=
 =?us-ascii?Q?9t5+qJmsOi53HMl2WIqBY4KwTCR+2/RjFMk9vWeh8Tdp/qziNed5WEI3I/ZR?=
 =?us-ascii?Q?7narpfDiQlZ2EL1kxyehvHFyGbOx8HHYCTe3II2UxmaNlT4CU1t6D6ZxcaRj?=
 =?us-ascii?Q?1anNiaNFat0nhLWK1tnCpGeErPZdOFH1E6WyUBSYA+jB4vzvLD6OWimu9ay7?=
 =?us-ascii?Q?cWIdigWLb/PSNH37U+ZvyNugRRAHhqR94wx+kk917pcDt8HA8vKgE2ewnIn/?=
 =?us-ascii?Q?6ZURStfhy9izpERYoDdjgdj6h5omm7D9QV5Z7em23erfvyiWWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xgvzRlxiC0vLhVDJAFCTjmzSrMXzE79peClDOk+CorlpzckAmWpo8jdCNeGV?=
 =?us-ascii?Q?h4eaNGYG/MZV23oLziRWVBcH8nh4tZhzYYV6Da7QdWWU4l3OZfTU6mwYGaVQ?=
 =?us-ascii?Q?Pda/49fKxxtm380RtutSzAvZmEjYZc1fGFiSkUC5e9x9xCrNxjCpTNshlcpj?=
 =?us-ascii?Q?J0KWCbb2FpieV4eFYyIqQIf0/6VwSLNRZ4JGvr2oI9aC6JMOlB8H5yzYwHpv?=
 =?us-ascii?Q?E5hDfLCPpELUQyjbECY+PDyK3nsbXAwNzK8RJln7qMeLFyqA+BXQf/VIo7Ag?=
 =?us-ascii?Q?U/oJOVgrKRhI3bheBIg4I+jOOcjc39smfU/7V2zzHBwZEinaFPTYZcxwIMl8?=
 =?us-ascii?Q?IWzfyAoT0x93FPlGU7eYWnEy2O++QU+WJGT5omkkC7Eq7J5pvKS+hWa5ygqX?=
 =?us-ascii?Q?XoKaRlpbjQWlzGJ4nYAAhaHTiWkeujGme+ig2Vn5lq4qCtKKm5DyjiSQ8lLs?=
 =?us-ascii?Q?PLF9gRBESAb+uIhrUJPM/2JX66Hms+oxohbJ3YkzxAQa3UQe62E/CwQab7B4?=
 =?us-ascii?Q?4q4ZLS/KZIVwBD204u7ryLCKxKMOmC5ycOB9J8f1Ftp6XE7GqvFGcN72F4+c?=
 =?us-ascii?Q?N2T8+vTu6LPam3HmtnwekZ1A1s0uMUVU8KcDme4/VNWRJoncFcYKH84qZRJL?=
 =?us-ascii?Q?jtlBwbAyEccOb6hJJhVkdRY/Pdotvp7jOqlKPAeIIIW4bp1hRf7ENKzQmaHU?=
 =?us-ascii?Q?pJae+hNnXiK78U383Q5Akx0xRNRlVDgfT1dQ/+ZTUDfZg6QGOcChpH1G4k/x?=
 =?us-ascii?Q?X4thZqcvWgS457JsaMmV15ljqVOieFUkMp+GW5sjTeJcO44ncQvJwR5xVSSW?=
 =?us-ascii?Q?tS5PhkCQbUk4mvnb+gSNm2TDYEXwQBgiKP3eW12hgI5r5amUwAJPI9B3Qw0s?=
 =?us-ascii?Q?xmSFn9AU+8x1cz6VD4dmCVtN8Fh0DnucD8fYWpImBZ9J/gM3I5E60uA9zsTB?=
 =?us-ascii?Q?GgOZNtrHg2guocxl38kvy3KZ/ABy3Z1XZabSRtaVasFvGXM0a06dVWevohMP?=
 =?us-ascii?Q?LQZXcLYMhQ63Jvlasc1jvQU1yIYED1OhIOaRQMa6SFsePHMPMJdSzOfXFHMt?=
 =?us-ascii?Q?zFA4SkcBTNOj4aeT04OduOQDAgMrpRZsf7iwBjd/4KwEj5Ly11eQHNVsDODQ?=
 =?us-ascii?Q?hcdBpafW6aNchfqcY1uB5cMn0Y+hA0u0QOOMg7yL2hIl43vWiHTys9juFMjb?=
 =?us-ascii?Q?5nTniSW4Tw/qY18FLXOsM14IpgLTPQ6oPM90X1ITf4i+2sfUwFa7GUI+Sri+?=
 =?us-ascii?Q?cep7FQCfKn9peXY9jkWvGkh7fuuCRlHX4uxAUbtHqvYyxsOcfcRfiiPrWfvZ?=
 =?us-ascii?Q?oKyJ5sQ4T6BjmcE3nyH2GO4fMDW9nT86AvMsNtA9RLPVuzChdXAZt+7wpL3Y?=
 =?us-ascii?Q?vdhDK5Lhp/Xl0L3jdTcvM2MGgJ+F1BYz3djEdTwdpmvEDBsmKR2CTVCYsTpV?=
 =?us-ascii?Q?xNH1/qoR6fX17+27db63gSytbRiSXVo88Ki3uhj+6hE+NQ0e6bOYlR8sFeHq?=
 =?us-ascii?Q?7ojTTDHcS+mFytmjpdrlPWxpHykhWlPc1yTFVmWp4VOq443kP8zC8t5SK8R4?=
 =?us-ascii?Q?V9jX55PZlxXBNhGcb5m6iaJPnplXNLYI+VK/+7bx2Opjik/0diF1qI49+4gP?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f6G48mr/drZQV1/FdJjCajRPSpNLeAiq2o9R+moextflQeB4Dv/1LKNQomuVffbOBIjh8g4Iajl8UeSrun2m8o3gVH3tYeBjYs1TbWotTRSF0FUws3J5Du4ccsCF7OTDJ48FJvnnz7TK/YK/JHm/gjXzqu68V8ulxhiWGV2KEy0rIi01mZPrTr9JkAVH9tkzeCuh7luR6wZ9GwMg6nEjlRDaha9yQjH9cPBCZDsjgo6Jh6OpIDbD+jH62/NMCqJtpB15GXXviMB2d6s/umTzd/1jbQoE4EWa8VFpgIJL5Z5XPEhEfjhoMbPnyrbk52kkXVGFGvpdKQwqgYAPDb0AI6kzTsWqvCZdBnIGie/wsXw/eOvceclxvmBpbVkZE5PENLIfgPwOybXw5Qfnloo8UVqx4xaFNFmbvjr0dZcZnIpmTiKlF30bIA74FQYvfu6JIF0QL+FSRO+q1ClJ6qlJnIhaYuYQmBZ13D4sVOsFC07HDXKHC/bXY9Yci7l7+dNIwe7Dxqq7A/2dwtT2MLpDHtGC9KDVfFfg19LJGj/4t4p3HBtmGST5Ei+/z4Q6flY7rFyUZt3sDWDFSJAT+Z26AeKK8QZssYy/GRvaMQTvJDk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8a545c-1666-4c40-ce13-08dd8c7d1982
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:08.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0EwLTq+sR5pwG5xL6DJ+7SxjJdORehyp17WZGf3iAGC8nATlElv7Ouqk6JK1l4pMU89ByWYMyJf9l3Kj8J4Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505060086
X-Proofpoint-GUID: pAVkZF77J2faTkF0CVOeF_MkisCfQNrZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfX4l8BmBfAPij7 NeGbFR6Vu01JD8a1290HkNtLQDm9UHx1b+r5M8O+SZFUhgtjcPdiqTbfRBD6zyyH/kS9VI85HHf ai72S1S8SbRUOzrbH8LkPlTJLEDntOA8SGi9BlfMgSWuT9cMaCyawUFnGqGhIUOVa6nF5RdZWNy
 X196pwe7NVNaqKrCx2f6aWfrBGcRc0JM5bqSGBNpnd1YG3AnQEJICvLdFcsz4TCrVBuh9zi0d5e nevhfl8PU15OYiFXNJh4rXP8mbjXY6dz2UHI3VCBYxoHcYp6ma9PWZP9Cjc5LHBNZNnu1535hXM CTHn6QWmSGiydcGlUetbjcxLnE/Frw2OTj+G5b3QxSyC55OlCkAl2NtSitFD8gqcRQKglZVJzMk
 mM6lIEdr0c28U5OmoONir+DWC5rHadx/Pr9nEN2h+wsOT5EOQ1tDJ+wqNzIxQpdHPCfH0ztI
X-Proofpoint-ORIG-GUID: pAVkZF77J2faTkF0CVOeF_MkisCfQNrZ
X-Authority-Analysis: v=2.4 cv=PoOTbxM3 c=1 sm=1 tr=0 ts=6819d0ce b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=dsZ8xDv__DIBmhsdlCwA:9

In future we will want to be able to check if specifically HW offload-based
atomic writes are possible, so rename xfs_inode_can_atomicwrite() ->
xfs_inode_can_hw_atomicwrite().

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
[djwong: add an underscore to be consistent with everything else]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c  | 2 +-
 fs/xfs/xfs_inode.h | 4 +---
 fs/xfs/xfs_iops.c  | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 84f08c976ac4..55bdae44e42a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1488,7 +1488,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
+	if (xfs_inode_can_hw_atomic_write(XFS_I(inode)))
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index eae0159983ca..d3471a7418b9 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -356,9 +356,7 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 	(XFS_IS_REALTIME_INODE(ip) ? \
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
-static inline bool
-xfs_inode_can_atomicwrite(
-	struct xfs_inode	*ip)
+static inline bool xfs_inode_can_hw_atomic_write(const struct xfs_inode *ip)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f0e5d83195df..22432c300fd7 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -608,7 +608,7 @@ xfs_report_atomic_write(
 {
 	unsigned int		unit_min = 0, unit_max = 0;
 
-	if (xfs_inode_can_atomicwrite(ip))
+	if (xfs_inode_can_hw_atomic_write(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
 	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
-- 
2.31.1


