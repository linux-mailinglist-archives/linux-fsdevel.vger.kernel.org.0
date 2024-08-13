Return-Path: <linux-fsdevel+bounces-25796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E329950A47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10131F237C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0017D1A2C09;
	Tue, 13 Aug 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i3ahcxFJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dLqD2C2U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1F1A2558;
	Tue, 13 Aug 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567023; cv=fail; b=PoKkIeBKWAMsjKMwZe/f9nPqIUmZVu/0A0uHDtWqS3B25WpQr1NfVBwD/MfooJYURtwNmIZwfn44mxPLVPL5Y3WAyeZd6GELW5cqzJQ8GumjEtOzrWyH6WE39sAWe1RKinkNmBUWMCG74dwgcqVzbd/2v1u1x137/gSeWjU32Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567023; c=relaxed/simple;
	bh=SIeYeCN3naivfWQgEfPod6tH4say91ENejq+clpn/4M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=edOqW+24LU1jz0Q5Kib/tIOH2Xg1BV1C/x4cjqHQ8w8ErddYJ85z8TxqSgsHn/a5m+QPbMxwZg+hOAKtiOSIcR49S20Eo6a4lQv5qj7v9N7xR4EH06QiBjXsutY3ucz9/dICj1IEqYqrojm/LN0oNRyhV0Go/WHLdqbHWW/1Ej4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i3ahcxFJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dLqD2C2U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBVIg014878;
	Tue, 13 Aug 2024 16:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=SPKXZG0d8UdYrO
	QWjvKj3bxSUlAd2LhVY5lMe8Bn7Gc=; b=i3ahcxFJ5KLdvKJFmLmU5U1D6iAFqW
	NYaE7MJAtXFrY/zqL9LuGjG0nZb9k92MD90vLnau/DrHOGhxyV+w4qs1ctyTmR6n
	KtZMMFq5XYun5YSohyCTJA4gqGawAhSL6XhfkK9QjnxTroWteYHtdvGvIFs6N6Gc
	Vo9WdIDQeLirSWslit3g8wgPpPPO02aPnfy7nI610URPDdN4ZSB+SczT4YpXMisx
	aSQ+hqQp50Ah4uHpqhYSr89lJ5/rRblccd0yVoQiG3axtXCPkcD2+WxNbptHslDz
	k7+vwOPY3mUaHEe0pmlWdiI0zx0rpOW8dpWND1YlmR+XlWUQ8wAXq8ww==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy4beghh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:36:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DFeTNo017662;
	Tue, 13 Aug 2024 16:36:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn9pd6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:36:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTVYIV8KxycLqTxzv6ztzESyg+GY6gIjfp/JaiRnxJvqYOiZd6d+iqqqKBXt8jGaTO+SxS0q0l0jwJJAET2UYAkjUCwPFffxnx2WyzVJ78c1+QedVsjU+Fu+n56Je7PBaaKooSpNlfK+mAZGxkeGOvfq5QbTaNQ2dNFeTFECR2gTMR1b0njFWI3j/MpAXENN3nUJAladX+gdzqvTB66V/Y7OwnM6Ue/k8bZ7LP63ykzrasU2jJSDJf1ThLP69ZDJl8XyU+tuV0x29su5sebS55rn37c1FxQtQl0aIMdyDXq5pNx5Ea9MdZtX6xBr90Dpsw8ByQLDi5mGm26TmlS4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPKXZG0d8UdYrOQWjvKj3bxSUlAd2LhVY5lMe8Bn7Gc=;
 b=agQNdXtA5bXHVav4NZLBVxVJRCGS8XEXQ51PmOd/wzaCEpUbqnSiR4b9GqlPYYmOWmTE3SfK51KI2/a7KlD8f3OacVzm9XAdnvtHMQ/aVnKGTTLp9sBTB5XM84QGqEpN4nmkPGi2L1kqt0NzzF1H+yW9d3DrZk6O23Mey/UGBEwoHJOoXuZu3EAbUNXVHBkXczOe0TGo9fnvqn7z04S7zw/Erxq89uc5DLdZsnE1PPdech0o4+cTy4QsEjnu9AEjPMf7cZi2p8v8XQajsUNQslCpv5nHD+8qRs4/ObHntTVvAmlhsfySn/G4c78LnZemtsUz0leeWXjUhbDFhHP/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPKXZG0d8UdYrOQWjvKj3bxSUlAd2LhVY5lMe8Bn7Gc=;
 b=dLqD2C2U/JD9yM2TlUYXBjPKch2hujuggJYR1SnJznYVPsXSJSmFpQviJLdWTgmJV+qF6s82F/0UJ1vIYGg8WmALEw0bPxNTXjvkpWwTFIqkKP2yvcwoxBeyYdsVLIsvI8QxpFs9DRdew7iTHCgqcSgmFZ4uGDVLkqVjuj1Ul6M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6354.namprd10.prod.outlook.com (2603:10b6:510:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8; Tue, 13 Aug
 2024 16:36:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:36:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 00/14] forcealign for xfs
Date: Tue, 13 Aug 2024 16:36:24 +0000
Message-Id: <20240813163638.3751939-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0054.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 348dffee-7467-4584-e3ad-08dcbbb61f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F5a5Gmdu6992Ws3lP4guK6MB9Hq6AiRugVHYqsX0G3JKo/OHomBVqUVcWGpQ?=
 =?us-ascii?Q?EFiBzrElkngKrpk164aSX9gIuDwUEBDEmgo9IfxbUq2yCGmCck9M0XmeY+qz?=
 =?us-ascii?Q?GtZAnboYDC3HF1ByV0E51MmFz7jGxedcCA4o0E+z83wME/QUM/HqFqDZaTh7?=
 =?us-ascii?Q?pQTXIefc5NEoRiklmsDjaGEvJtanc5sH+hhVAcTJ80Mr1JG/ISMpTaGZoRTr?=
 =?us-ascii?Q?7GNr8DUuLjvJecB4OMScE4QyXjeH+gsHVBfTngcHiK43rbXR5ULNaDBiYW/Q?=
 =?us-ascii?Q?BGsI6PmT67dOtHHL9U/S5G5ufVSFMelP/KmskabchUVkKidJZaCJe08THlR5?=
 =?us-ascii?Q?bU+dw+UsgtASM3crs2TudxuWN71L9cWYK2npwI5xZxGbRxxPz66NDN8ZM7gl?=
 =?us-ascii?Q?f+ToBcPT3vXjjmsojMS+kPbNkQeUqtmJh226uqYm0W3YR1oEM9WEkv/Oj1+e?=
 =?us-ascii?Q?HJ+kWRI9GoXLjfo25ygWK5sZaPuJMnZ16csnfvQqMW63uI54Fh9os39vrOvE?=
 =?us-ascii?Q?TLqGusKpEfehauIDgDt24W474WUKL0fQhA3kta9dqfhiUog4K4s4YaV4VgSd?=
 =?us-ascii?Q?cIUdAjh2N6ucT3Vzo31VLA58oxrpvVBi3WHyVzNkchuYv0WCNvPTYkOIcmCm?=
 =?us-ascii?Q?LT1nY1RjUE3plKsqHmdx9/XCRNNkocoXcoy5+KmnWeA4w3bwvQBIzQy/iUEP?=
 =?us-ascii?Q?6OX5yFVQoFENYZlUJLUmG0BVdEqi6+iLlzjtztLl5o8w6/1ZogTLxbbxo2lN?=
 =?us-ascii?Q?Gaq4PCEFXOJiDabv94pNnCRdhGxdLMEV3JXfs0wDhkEx5HbRzGmZM4MHebRM?=
 =?us-ascii?Q?UiXnDxP1kuwi6nkkRTWzWiNPYFxGs0tWETZy5xiVTXkpnYiKO6gPdU/Su6Fc?=
 =?us-ascii?Q?ah75AaCkhAx9C5L2pwbtv+RPxqmSfyIk5LUWJ2rBTZju5skHlf9tQwBoDCKM?=
 =?us-ascii?Q?06cGl4ueQygKhiowr2V6NtuyQkxOr/l5nGx4UEzXwtRfSt+TilAzKTsKWKe4?=
 =?us-ascii?Q?ijlwZVudjqpMEjW6Qi4Rp+vC2faxnK7fJpXZAP7cWedK0FyUShVzGl1Ya8o9?=
 =?us-ascii?Q?SjwtKuUubb9w3BqERpCClcuJa1nkW1RYW2C53iZsW3Zg0VQYiN+RarbUtvye?=
 =?us-ascii?Q?vlp6O54I7lytLhC8b2QrF+xwagnyPezr6BD/mnof1vMpySUNZZCjBCYjgrzc?=
 =?us-ascii?Q?C4IuXYIfIHZPnlMfRa3Th5MU4weMiStOFXp4tNRGw6WO2eTaId2nXwG3vrBN?=
 =?us-ascii?Q?rO6EAI/EBHcHsAPCYlGijbzfkxMRpynqq89gXuQ6e9QMq33V8hUj0ar9HgP7?=
 =?us-ascii?Q?WEZYWdp+wrsu1fFN8eRkKbFK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sHBUZHII1MurpyDLtF9V0GA+rAMp/DduVUYmTxeMpgVg3dtxTXbMfc+ahK8K?=
 =?us-ascii?Q?GT91A+pGRE7AR2fpmNl7lPg1IRN3NWdeTBLI3Gc0wlv1+qa7aWDd3WfmqcNk?=
 =?us-ascii?Q?22clWghLfv1MYNmtOx6ccenh5svWaWnXDLqp+xFjDwGS2zdFYkH4RU7wGZnn?=
 =?us-ascii?Q?wwnO8lwOytdkTuUL0v3XIyyHj0XKsz2CzBMGfmQj/OWQdCET7OVZLD2pVyrH?=
 =?us-ascii?Q?zKeSadiKFTW8Qw4EKugNwee7Ad9q3pchvKda+nUzX++yAsVttIKGS3OQUsu0?=
 =?us-ascii?Q?K4DtqVdDUSnZpMqEY7HBaQcdWXElADQcfN1rH9Sdnr2lZh2ymdjLEUxQG63y?=
 =?us-ascii?Q?MAaKIx7rDI9nrX54dRS9VoyZ1wENSfzaprz9dra6PJXqKeMCDcwXTDMolm6p?=
 =?us-ascii?Q?qnfJSPb2fNv7EgFjI+0FXg10/CsKj9AV3yCjBmvlwejmnGGWNA0w3hd9G0u4?=
 =?us-ascii?Q?gxeKyOYYlUzyvhZxnpVu+ejn8+FJJdLt5Zbc/QCoVu/hx3iRGjg8MD2msMCV?=
 =?us-ascii?Q?5pEalDZ1mkAgIXG9QZuAH9U1qK5mEl8MrGNug4qtMlLZz6ry0L/5Gl2UCxoI?=
 =?us-ascii?Q?bp8kwrcXMhWJV8QQo3dM4rrrq+OlAzGlXxy+h8IhNXwA/lPhbWFsMmdKTG94?=
 =?us-ascii?Q?/01u7uTtwtGnUpIdlvZIfLbKw0zLcHx8CKIhzVh7HQ8pN0tGd1kNg9lmq0zO?=
 =?us-ascii?Q?Y+C6+El7WMeHLCi+T2F5x3oV5qi8+XSoMSPCh7M/17aNsqaUkyspUUJrLdFF?=
 =?us-ascii?Q?SKTMVHNUFtui9uiWzFd3JMk8NWI2h2PkifuXTd7oZilsyREiJ2qndfv4GQEd?=
 =?us-ascii?Q?eLtvwdkMTxw6KcJ+Q5NxZoI2I5KvxyO6g9AaeSikFXjblSMp0NrGDECdM7Mx?=
 =?us-ascii?Q?U22ifFnl3FxugQ8wd0jVlaZyg9moyQPmRFklbA2Y0qucErSwujgUP/MVTezA?=
 =?us-ascii?Q?OhzhWR1B9JYxSGuvc1EuO/XHOlxzbGsAXgLq6sjpFfA13YWoVulIW5O41xmD?=
 =?us-ascii?Q?nh4ToTzvdrKt/93UGjeFNPhNxs7g/Dj9PVCJE98k4CNymtFe3bsC7F1eUaXo?=
 =?us-ascii?Q?TPJgE7zWD5/RGQF1hXflQDSVxg0NTDIFJ9dpiTGUH9G2pKsLGLQWWdcnZWCc?=
 =?us-ascii?Q?VdRvclynV8PTR4QEv8gDy4+KpLfva32Not2jLAQnH3TIUfAQTLzJaFAL2Xr9?=
 =?us-ascii?Q?RAGMbSk1BCY3GEkXnclytzpzPFe5KQv6ZwSSeGzmoMKSlC5Tusd493znyGMb?=
 =?us-ascii?Q?mfoCYG50Ntk5H6CibDDZMO0VA5AHv55RqVpv4C4JAz2qk9inF1kuZ+yGkO+W?=
 =?us-ascii?Q?FU3MLsFc0610q0YwzsUO/+Albf3UBuo3rlFBtShxe+bd/e+G+MiczSETEbyZ?=
 =?us-ascii?Q?9PuvEGcto9Ll10ZrSOBujrC6wz+jR1ckImMSgOhairdGALHnN96kDRW7CxJO?=
 =?us-ascii?Q?EM4jPKnJOD2f4cqn2iAtsMk8IAYS0NDWZEi1C+GeUmbMPflE79Ok+3fZJ1G4?=
 =?us-ascii?Q?1Gh+++4zBEh9SJ8aoaTHJH6rZM70f5HqFHjG/jI0dMmgRepm4mKSZvSTkBLe?=
 =?us-ascii?Q?UMEl3NtSJ90soP27xxXyN6+cjtAUCYKycwDOCaEIo5AUslXo4Qh9l1Rp37E+?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	buRNnkWuvQnDRl3qOflZVVbsFZDWdmmDFhuTXImNIPYT6cO963d0sgM+NvVm5/OGyCJbDgRXT82HcRGDyRHXfYiiVgeYT3PtbIEdmFVqvC/3fDIBt2nCPBzQU+TmLlST0oR4aIZRarZwgQItB+ZV5aU3RXD/vCp9c/uCOAdCjpWQT3NtY9IalNHEp2LlMgN8V2rTgWCTGiLe9RsfAPcQ0/F72xRX4FUPnbKsMpXBUBBkuZ0900FGDBR6PeXRiD1ISgchQoCyG1Xo0SidxToaqezcs68v938ngCEVRS4hQ8LGhvR55Z2zemOFTFX5Lpv1mroXrDo0Ob9R49m3MiUvhWiKxAcQaFTyTf6Xf78DvBWoxwlzMJ8QxZ36Vl+3iD1KZfGUnhymolNTkWNGU1EHGwWCQGQd38fcdvULBn6TiAxoYPDnDEwe6h9X5GQ6seeNWuQMQS8Uz8qhpdTSYOM4eATjgsHHob3FYcSmIOB2zE1PpYwPC+UoPmJQcxXPH8bPauQxpR4esf1Zsd5U0t9jDZDlhrtfwCSGWT+8e7TZiKCpfx148mYA40+TJ/eoNGRt6c/B9Qb2VgCI7f8igkYoSICl6inVozXKB9lPqi1mNaE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348dffee-7467-4584-e3ad-08dcbbb61f5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:36:46.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kg39CmPa8vAk82bB67+3tWbFs9eaZoSnEjiLIutKMI9+vTKDAXI2n/lvt+y0SySnnPy1lEH7Cw5NtbcSRXMTuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130120
X-Proofpoint-GUID: Lt7X6impXTgZgJuIqsxDvw9QkYsYXP4N
X-Proofpoint-ORIG-GUID: Lt7X6impXTgZgJuIqsxDvw9QkYsYXP4N

This series is being spun off the block atomic writes for xfs series at
[0].

That series got too big.

The actual forcealign patches are roughly the same in this series.

Why forcealign?
In some scenarios to may be required to guarantee extent alignment and
granularity.

For example, for atomic writes, the maximum atomic write unit size would
be limited at the extent alignment and granularity, guaranteeing that an
atomic write would not span data present in multiple extents.

forcealign may be useful as a performance tuning optimization in other
scenarios.

I decided not to support forcealign for RT devices here. Initially I
thought that it would be quite simple of implement. However, I discovered
through much testing and subsequent debug that this was not true, so I
decided to defer support to later.

Early development xfsprogs support is at:
https://github.com/johnpgarry/xfsprogs-dev/commits/atomic-writes/

Differences to v3:
- Add more RB tags (thanks)
- Change round-in/out API to up/down
- Change unmap blocks patch to use alloc_fsb and rework helper
  (Darrick)

Differences to v2:
- Add rounding to alloc unit helpers
- Update xfs_setattr_size()
- Disallow mount for forcealign and reflink
- Remove forcealign and RT/reflink inode checks
- Relocate setting of XFS_ALLOC_FORCEALIGN

Differences to v1:
- Add Darricks RB tags (thanks)
- Disallow mount for forcealign and RT
- Disallow cp --reflink from forcealign inode
- Comments improvements (Darrick)
- Coding style improvements (Darrick)
- Fix xfs_inode_alloc_unitsize() (Darrick)

Baseline:
7bf888fa26e8 (tag: xfs-6.11-fixes-1, xfs/xfs-6.11-fixes, xfs/for-next)
xfs: convert comma to semicolon

[0] https://lore.kernel.org/linux-xfs/20240607143919.2622319-1-john.g.garry@oracle.com/
[1] https://lore.kernel.org/linux-block/20240620125359.2684798-1-john.g.garry@oracle.com/

Darrick J. Wong (2):
  xfs: Introduce FORCEALIGN inode flag
  xfs: Enable file data forcealign feature

Dave Chinner (6):
  xfs: only allow minlen allocations when near ENOSPC
  xfs: always tail align maxlen allocations
  xfs: simplify extent allocation alignment
  xfs: make EOF allocation simpler
  xfs: introduce forced allocation alignment
  xfs: align args->minlen for forced allocation alignment

John Garry (6):
  xfs: Update xfs_inode_alloc_unitsize() for forcealign
  xfs: Update xfs_setattr_size() for forcealign
  xfs: Do not free EOF blocks for forcealign
  xfs: Only free full extents for forcealign
  xfs: Unmap blocks according to forcealign
  xfs: Don't revert allocated offset for forcealign

 fs/xfs/libxfs/xfs_alloc.c      |  33 ++--
 fs/xfs/libxfs/xfs_alloc.h      |   3 +-
 fs/xfs/libxfs/xfs_bmap.c       | 320 ++++++++++++++++++---------------
 fs/xfs/libxfs/xfs_format.h     |   9 +-
 fs/xfs/libxfs/xfs_ialloc.c     |  12 +-
 fs/xfs/libxfs/xfs_inode_buf.c  |  46 +++++
 fs/xfs/libxfs/xfs_inode_buf.h  |   3 +
 fs/xfs/libxfs/xfs_inode_util.c |  14 ++
 fs/xfs/libxfs/xfs_sb.c         |   2 +
 fs/xfs/xfs_bmap_util.c         |  14 +-
 fs/xfs/xfs_inode.c             |  41 ++++-
 fs/xfs/xfs_inode.h             |  16 ++
 fs/xfs/xfs_ioctl.c             |  46 ++++-
 fs/xfs/xfs_iops.c              |   4 +-
 fs/xfs/xfs_mount.h             |   2 +
 fs/xfs/xfs_reflink.c           |   5 +-
 fs/xfs/xfs_super.c             |  18 ++
 fs/xfs/xfs_trace.h             |   8 +-
 include/uapi/linux/fs.h        |   2 +
 19 files changed, 405 insertions(+), 193 deletions(-)

-- 
2.31.1


