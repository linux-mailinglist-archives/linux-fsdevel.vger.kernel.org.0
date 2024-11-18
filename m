Return-Path: <linux-fsdevel+bounces-35051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1439D07B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 03:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0141F21A1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 02:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF91803A;
	Mon, 18 Nov 2024 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="DXueErnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9D33E7
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731895336; cv=fail; b=u53j2Vdve9hqagiPEXZPlFE2c7+gzXJ/syE20/gEBduerspM5Mq9TFOMQESV+6LfgUpds5SWntqnvhu+kMcuuiG7q3ig5EsU2zBY4RaMyAOAWJxuKQ3h5in83lmeObglsQ59zMT5ccrtvgLQCBhbtF0ePPGKvZEhzIZgeJly3M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731895336; c=relaxed/simple;
	bh=Vcda1x1I6Ld/dIrWnPI8SRG3HDFKEQ3PfkHcSfc5KpU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VnSGvnJp1pH2FHpX8CTO2ow7nPhUixdMyXiCDWOUhso34ZM9r9UFfNBjmWJaS6iAmNw2H+cMRfdz8uOK+0q4oaKg9HV964cNM2o68Givjd/i4tysfsG0I/kEQ6uZPkdrpzaQKwMbz5kyEkxodA7rhom/EqGUsNBo4nxCWC/KgKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=DXueErnV; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI01e38009889;
	Mon, 18 Nov 2024 02:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=Vcda1x1I6Ld/dIrWnPI8SRG3HDFKE
	Q3PfkHcSfc5KpU=; b=DXueErnV3iLuCNMCzGgpiZH2LYjwPRAz37USajNW0WN9e
	1tPMrbRcmB3obO5bcZPLirHAzxKhzJLfH+U2lcXaWs5oAnn61P4GbHpi7Qma7ASa
	bFiesVqB+OCLAPy94qY5LHMxO6Klx9qcNNdNVRoU7WkkUDvr0IOTOSgg00EpQOlB
	bWhoY45YXHCCWl4m8p/1Xc/12R1fFFGPEPRi6cl/a5JKGV3/Ho9nuV57OHuGiX1n
	aS7PW3WHIolyQ+CKQjc/lQ97/re9ks9uYIthTICN4FEIYncOg28HtkZWCbIF6E+L
	tKmBVjmJ0l6nHIxIHtdwNwrB0Optyw6uCkkIIF6ew==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2048.outbound.protection.outlook.com [104.47.110.48])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42xm9p8xen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 02:02:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKPFnxADQGlOuOlqOgm5DgQqekt/BhtfBEMPXbqbU9qknU0cOXNVhX1MkFVItGSch8Xnmd/mo2ygg5Q2PH9SNJ4UDtm71sHk6TC6g0DW3GREE77ojyF7wXl32XaZ0emMf+Ijit/hn3dg0GJnoHk6vB1zfW0CXBioarpkwzGs2zbOQ5vkLTn2aWh0oMy/JJwLLcz8rQicIOrwNjMKv7rKwW9jL2Rf/h1iAIZEmtWVV8a1mL2yYzIfBED28s1OgoJjQ4UfP+nvf048bcsECyCqaqsNoHdMSUaqxOxROR96MVF58fZDS6U0i6bWJvV2bvs06aaG6nWAR0T/ORY1ln3B1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vcda1x1I6Ld/dIrWnPI8SRG3HDFKEQ3PfkHcSfc5KpU=;
 b=g7LYwz6/uNbzGJEXWzgFddDsT3m4PMOicXoeiPIj7byY/Nmi0q00MSLwgoXGLBi/Jc50BMMcgef45fAhnlkzCKRAheDssxI2rphvk2OE9b4UwP90OalsXaq2IR2Po9q78euRIRYVrwhyCRTV6axadLTMH36JlzHRmcdXy+lrK2vjetZxWyS2CKCCQgAG3nWWlmWcyNT1HJmVS/GfDSfE/9xLzRn/PO/ycCWfAmrfpEb05SiQruJJ49trAZ6Ae+xEM5sGlO+ZQcYfKy4v+7mv/QCrdJLDbCqEya/metl8pf1Z6OPhtL49XsewC22y/xeu2fIhujR82XV1hbMHTxOifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB6119.apcprd04.prod.outlook.com (2603:1096:400:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 02:01:58 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8158.013; Mon, 18 Nov 2024
 02:01:58 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v3 3/7] exfat: add exfat_get_dentry_set_by_ei() helper
Thread-Topic: [PATCH v3 3/7] exfat: add exfat_get_dentry_set_by_ei() helper
Thread-Index: AdsFm7o69pSeu2bAR9KHr0tMBqa1WgzwPUxw
Date: Mon, 18 Nov 2024 02:01:58 +0000
Message-ID:
 <PUZPR04MB6316168F7AA02F4194AC108D81272@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB6119:EE_
x-ms-office365-filtering-correlation-id: 9a1f4db4-1d77-45e3-8e1e-08dd0774fc19
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWxrald1NTU5a3RIbXVHWDZzQWRuSmlIQnI3cERtYk5yTEFJWWsrV1ZQMXM5?=
 =?utf-8?B?MVUySHNJTWpiZFdOOFdMeGNUd2ZITnZHeWNqMG5PclpmY0NVRzJjc1JyWlYy?=
 =?utf-8?B?MmlZc1RpcTY4VkY5NU4yVnRaaGdRZk8rZmlkYjNzL1R5U0I5VldURG5LblRM?=
 =?utf-8?B?NGRDYjFBbEgwL2RHZ0kvUDFXZU8vMmwybVU4NFlKeklObVJhcDhFbEd3eDhC?=
 =?utf-8?B?OUJLUlYvQzE1OHBoTzl1TFhYODhZU2NqMmt5NnlGR0JHTk12WGJPZzdmbHhU?=
 =?utf-8?B?ZlUwTjdnSjBrTlpTWktXejNiUlBVY3lQTkVHKzJoMTVVanRDWGx3TWFlSmMy?=
 =?utf-8?B?Q2RwSTJoRi9KenA1bTZqQlQ5N0xQVFJXRnhTelkwSTBvMVJaMDVQUCt6UFdt?=
 =?utf-8?B?VXA4bGh2RkUySG9xSjFjMzdSMFA3WEdXa0VJMjlYZE9CcTYzL2RHNTRlTmFH?=
 =?utf-8?B?ckVvdmFLNUdBaDdUalpUZG5ZN1ZPRHhZYVhodHRCNTlVMk9WQ1J5V241RDNr?=
 =?utf-8?B?d0tSOWtpRXN2QXVSYXZYSzVFL2UyWmlTSUg2aXQ1V2p5WTNqRU9pYjVhN3lD?=
 =?utf-8?B?ZE5KdUloWXpwOHR5NEg0OWZubTNtYm9uQXlQcGc1bGdUUWV3MEg2MDNNUnNy?=
 =?utf-8?B?QTlJdlAzUUF2Um0rZ1paa2ZhZzFwckpEajJzWjJHOW96Rk5IaHhrRkNMRlg1?=
 =?utf-8?B?UVljWDV5dER0WFFIeVBtRFAzQ2FNa2llWFoyWUp1aXFsK1BrRHJqR1ZDM1I5?=
 =?utf-8?B?Z2JDbjh4SlVQYyttMG1WMzFIVVhaMElFVTRPVWdiTExVM0YrZ3RBY1pNeXJw?=
 =?utf-8?B?Uy9JR05tMG5JN3k4ODFHQ3pFcG54VUVHaXZQRTM3eVRURFhjSjg4TFdiaEJT?=
 =?utf-8?B?LzlCeVlTamRUQnB0NnY5ak9TVFFLOUlpUFJWZ21IYVkyOE9RRkllcnYvK0Z2?=
 =?utf-8?B?UjZrMElhanJuUldlQ0ZqTGRtVFVoeWFXRi9uSUVmeWlrK1dOUlRkSlU4Q0Z1?=
 =?utf-8?B?dCtJYURNWW9ML0NCa0FER20ycHUzZ2VKd3h3MTdxU2NTQlBERFpiOEVvYytl?=
 =?utf-8?B?ZkJpQytrQU9PZjAzQ09sN04rcFdrR0pab3hVd3ppWWd3VmJweTFDZjZNNm5D?=
 =?utf-8?B?ZkpNbG5kL2FJdzdKViszaTRuRW5MLzdVeDdQN0ZGOERWTEYwRnNYUVpDV1R6?=
 =?utf-8?B?cGlzQ2lpNFBveFdrQVQ5RlozdWlYTk9xWnh6N1FFN1JWbjdxUzd2YkcyZkFv?=
 =?utf-8?B?QlcvUVU1TzZRRXZ6TVNGVmdsdzdHM0s4SDg1K3cxQlFrM1B2Qm1DQ1JKRWlJ?=
 =?utf-8?B?bU1YdC9JK0dtRjU5d2VHQWpsaUVUWHc5K01nQXlwUkNMa1BoK3NtNVNVdEMz?=
 =?utf-8?B?dFVGOEJuUVMxcjc0YmlsWTY4eXk1bDZlRFlUTE9LclJKc2ViYXVHWVA3QlVY?=
 =?utf-8?B?RFdDMFdlc1Z3T3hkdW1pOW1JdklVT0ErSGtTZ0lhbTZnZlUydWlOcHVIM1hN?=
 =?utf-8?B?Z01BTzA5QXk5SHEvb3Z2MXZpN2NLYzdhbkU3VGxCbnB0dXlWSnloYXE2WHR1?=
 =?utf-8?B?WFl2bmFGbFMzeW1YcUdrU2NFb2d5QTVSS0YyNE1JdGhiSGRJZ2NCdmxTeGw5?=
 =?utf-8?B?RGtTakg1NXdEYnh2dmxnb3VCV0oxazhPYmhQcmtHWnB3aEU0NHNaRWkvd25S?=
 =?utf-8?B?aHpKaHVEamIvdUplN2VVL2xpa25UcHAvQU1zdzhucVBZZ3ZNbzc0Qk1hRXV1?=
 =?utf-8?B?OG9ldDhDQTZ6VlB6L2ladG5hcjNkMVNTdldrUWlLQ2doa25NYkRUYnFRQ2F4?=
 =?utf-8?Q?YCUQkfjcpKkmOoZmXz186Md9SWGSjbgzd8Qrw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V29FTTk3TU4rczVCZ1F6aFhSNUVKVVNoTXE5Tm5wZjhaNGdTUERUaHZMQkYw?=
 =?utf-8?B?c1dONXFwS09nWHVDNFBFVzQ0RWtGSnN2ZHVwcjRvOW1jaS9mUkg5TDBtS1BM?=
 =?utf-8?B?VEFJMGUrRGliNEpmOExDMEhIY0lMcVFUTTgxQUkvMXU1MkcyM25ub2tPdHVP?=
 =?utf-8?B?UUlUREhsdFRKRFUvUEE3RDgvRkZzOXFDcmdyZU9OdCs4OXl5SVNoSjl0SkN3?=
 =?utf-8?B?bW02MFkwODk5RkVOZmZ3TjJiQTBhWFNYUkdWT3k5WlhzV3htUEUrU2NiWDR1?=
 =?utf-8?B?WUJGeU55TnlQM2x2R1VFMjlDc3lKZUhKTzdpdzNYMlp0dEdBQkNHS0NINGtI?=
 =?utf-8?B?SWIxaUFEeitHRDRKOHF1YU16NUVIcXhKeWJOOHAxZ3JvQzg3eno4ZlpaOHBa?=
 =?utf-8?B?NXBscm9idFR0b3lrV1pJSzVFb2dlamc3RUFXaThSbXBnMG00ckwwa3JLOUFK?=
 =?utf-8?B?ZXljb3NOcDRramJxOXZ1Z3oycGZwOWNmVU1oclBoYjVSWGg4a3Q2Nk5hUUFN?=
 =?utf-8?B?aGlSR2hGaEE2M2FHN2JYcHZBUUpTY1g4VVlVdktwYmZuRCtaeDdCVUxkNEVW?=
 =?utf-8?B?VVZNR3ZBaTNkRXhVT2ZvbUVUS1FFTHJrZ0R5Rkdud2hZOWZUSDd6bTlCNWZV?=
 =?utf-8?B?dTl6TmttWFg1QnZYa1crdVhsd3FjY1lwTTlwQ3g4bmQybWhMSHBId0cyS1dh?=
 =?utf-8?B?NmNZcmxHaHJ1UW5kTnBwWCt2bVlpdTk3YThiYkVqYXoyZHVteGx0a0I0S0tF?=
 =?utf-8?B?VmV0U0hVVXlNV2xFV1lNblIvSEdiTTVwVnRsd1BueE1KMVEvYzlQbWFrRTFT?=
 =?utf-8?B?czU0NG5mSUczL01HTnBvWDB3eCtpYm0yWTFzQWo0azd2eFl0UjBqcmN6ck9D?=
 =?utf-8?B?bUlRcERQZ2NCYXdOTHQvMVZUN0dVVE8vRFlWdXB1S0dIR0JmWVo5MkQwSTVw?=
 =?utf-8?B?NGwxUmlKUEZ1OUxOa1ZUUmFGZEluZ0EzT2pNQ3NTbVJ4cXZ5SzlSYUErNjU5?=
 =?utf-8?B?WTY3UWJrSmRLa0ZZU1Q3YUZOYStFUElZWWxxMEZGOEpEZm02WlE2enBqWTRr?=
 =?utf-8?B?ZUJuZWVuemd3emc1R1NCZXl4S09DOU9GdUgrZjNpM1BNM1l5b0RlMmVPc1hs?=
 =?utf-8?B?b1FWU2dCazZUMEQxcmhmRVpacWZ1VDhyTTVHQ1BzSkZuYXNVekpXZnFpSEJj?=
 =?utf-8?B?RDdoS2hUNHJmT1Q4RmNVSGVyazZvYXlac2k3NnIyQ2tzbkZKWSsvZWxsb2tk?=
 =?utf-8?B?bFI4U1NJdWlXbHE3Z1ZEVkFPdFlDQ3pWSk13cUljN3RkbmhKTkhjaUgvSjZm?=
 =?utf-8?B?bkNZYVQyWFppN1ZXbnEyeFlzU1hJR3JodnM4cFBZSEtjUHhiNkRiSlFnZzl1?=
 =?utf-8?B?VXpkZjJZUjlUZksram5oREhldUFScFVMaTQraFFONjBMaEhHc05mMTh5UTNG?=
 =?utf-8?B?VFlYbFl4TUdGNnlUTUl2SllsOVRmcW5EYlR5c1ZnTDhxR2c5RlVlVWUyWU5I?=
 =?utf-8?B?T01HTW9EN0J6RU41R1RpVGpsV3NEbmdKd2NmdVkySW5YQlgxcENMbmtZNlRM?=
 =?utf-8?B?Y2g3SzlPUk9RRzlWaVQ3RFhZOFBOOHBCTldGSXkzSkZxYlFkOWVJZkthV3NT?=
 =?utf-8?B?U3RZYWd2WUI1a2M1eG1qcXBSKzBWVDY5Tjlnems1azk3V1dRd280OU1lbkhm?=
 =?utf-8?B?UWY2dFZKczROM0M3RjZGdTRhQ0ZtK1FmV0dpUWk0ZjI0cFp4Z0F1bmFtSlhG?=
 =?utf-8?B?YWtvNUM5c2VzSmhtQkRJZWwrS0ZvSWZnaE1POFdNZUpXZVk5ZCtScnRQOHhQ?=
 =?utf-8?B?UDlPeU9kL0dtRGhZbkRXWWdWRnE2YzA4YmxSeEtoZCt5K0J1Y2ZFenI4Z3NE?=
 =?utf-8?B?Vi9vNFE5eEQvN1dSY2FUeFhLOGkxWEVKdUZ6b012OUdnTWh6Mm5OdkFOc2Nx?=
 =?utf-8?B?VHR5ZTk4MHBEMWNtQlhCaDIwNDV2d3c2MlZjV2JLVUtIZDcvc1N5M28xWE5t?=
 =?utf-8?B?MFdjOHRtNW82MTNGdmR1bGNRaTI5MWZxZHZWSjZDSmRWYmgzcWlVK1I0NlRC?=
 =?utf-8?B?OHRlRCtDcmE1RTN2YUFNSUQzYTRvWTQ5TDIvV0QvYmNxU2d1YlRpdk5Ockx4?=
 =?utf-8?Q?tJ/Z9O7biik/D9i09qlidvnKe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9j1ZWytZgnmMbl1SEIAcwgD9jTS0rh3bRkE9ymFDfRKRgZApc1Hv+ynIE62pmdIqBqmNSGekHPImxpYQd7CtmsuBR5qhIbGGJ29kLTiDlX4ZC9hm3s5jnz9CcYMLOjZNShIf4n+uSoKZoiEHfSsiGRurJELN0R2c40QG3J8BpJREIUDonh4LruXshHsWfA5dL+Znw4mA7Gj3gjZQp/2xLZWoJE+HukiCFZSqp16UQe+cWomdKhp6QmaCoczYOY4QtoJ98TfxdCG2IOa+6WrJnaTmA/O4xM6mLrhsm8HguYnIYhadcH65FWoAzxk+EmdN+2pzT7478MfDffrRSOZN4U5ogshIuM8mf56z9WlHL7J+1HkeaPYeUiT7zFeVgu4K2Wvx+NCp4c4kQ+jHEEhMOggziW2lHj96btuVq+Ri4Xm7c/xUZH87BWpqrbdAfgeiLmf4Dyir5uxDzE7TwnfEmve1sYdNz8E5cMMn3d8xwrStCDDfjoxREbEJgXQptWh/YsziaWonA6bkJzfctpSkaqGJBA9XxyOUMsOUo41Jzd0zKxz/f+A9aQSyE6R4n3YR2S9tKqXY0MmUf40HXguT4gCJkXFzkaYhwkcV1sMIXVrmhNiztugfQZ4MIM7mKTad
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1f4db4-1d77-45e3-8e1e-08dd0774fc19
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 02:01:58.3256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/PqV6jxFIuqMOhvSY7nlc/nfRUGE3e6heFmqiXGp3e5LmzP2rUhYwAC1bZsnGXAXDAxq/oo1yciLUXJVbv5Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6119
X-Proofpoint-GUID: cwl9lXU8ys0ukQX4ZA6aZIdgpDiY2fWb
X-Proofpoint-ORIG-GUID: cwl9lXU8ys0ukQX4ZA6aZIdgpDiY2fWb
X-Sony-Outbound-GUID: cwl9lXU8ys0ukQX4ZA6aZIdgpDiY2fWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_24,2024-11-14_01,2024-09-30_01

VGhpcyBoZWxwZXIgZ2V0cyB0aGUgZGlyZWN0b3J5IGVudHJ5IHNldCBvZiB0aGUgZmlsZSBmb3Ig
dGhlIGV4ZmF0DQppbm9kZSB3aGljaCBoYXMgYmVlbiBjcmVhdGVkLg0KDQpJdCdzIHVzZWQgdG8g
cmVtb3ZlIGFsbCB0aGUgaW5zdGFuY2VzIG9mIHRoZSBwYXR0ZXJuIGl0IHJlcGxhY2VzDQptYWtp
bmcgdGhlIGNvZGUgY2xlYW5lciwgaXQncyBhbHNvIGEgcHJlcGFyYXRpb24gZm9yIGNoYW5naW5n
IC0+ZGlyDQp0byByZWNvcmQgdGhlIGNsdXN0ZXIgd2hlcmUgdGhlIGRpcmVjdG9yeSBlbnRyeSBz
ZXQgaXMgbG9jYXRlZCBhbmQNCmNoYW5naW5nIC0+ZW50cnkgdG8gcmVjb3JkIHRoZSBpbmRleCBv
ZiB0aGUgZGlyZWN0b3J5IGVudHJ5IHdpdGhpbg0KdGhlIGNsdXN0ZXIuDQoNClNpZ25lZC1vZmYt
Ynk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBb3lh
bWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IERhbmllbCBQ
YWxtZXIgPGRhbmllbC5wYWxtZXJAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9leGZhdF9mcy5o
IHwgIDIgKysNCiBmcy9leGZhdC9pbm9kZS5jICAgIHwgIDIgKy0NCiBmcy9leGZhdC9uYW1laS5j
ICAgIHwgNTMgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQog
MyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAzNiBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9leGZhdC9leGZhdF9mcy5oDQppbmRl
eCAzY2RjMWRlMzYyYTkuLjI4Y2MxOGQyOTIzNiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2V4ZmF0
X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCkBAIC01MDgsNiArNTA4LDggQEAgc3Ry
dWN0IGV4ZmF0X2RlbnRyeSAqZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoc3RydWN0IGV4ZmF0X2Vu
dHJ5X3NldF9jYWNoZSAqZXMsDQogaW50IGV4ZmF0X2dldF9kZW50cnlfc2V0KHN0cnVjdCBleGZh
dF9lbnRyeV9zZXRfY2FjaGUgKmVzLA0KIAkJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0
IGV4ZmF0X2NoYWluICpwX2RpciwgaW50IGVudHJ5LA0KIAkJdW5zaWduZWQgaW50IG51bV9lbnRy
aWVzKTsNCisjZGVmaW5lIGV4ZmF0X2dldF9kZW50cnlfc2V0X2J5X2VpKGVzLCBzYiwgZWkpCQlc
DQorCWV4ZmF0X2dldF9kZW50cnlfc2V0KGVzLCBzYiwgJihlaSktPmRpciwgKGVpKS0+ZW50cnks
IEVTX0FMTF9FTlRSSUVTKQ0KIGludCBleGZhdF9nZXRfZW1wdHlfZGVudHJ5X3NldChzdHJ1Y3Qg
ZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywNCiAJCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0
cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsIGludCBlbnRyeSwNCiAJCXVuc2lnbmVkIGludCBudW1f
ZW50cmllcyk7DQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvaW5vZGUuYyBiL2ZzL2V4ZmF0L2lub2Rl
LmMNCmluZGV4IGQ3MjRkZThmNTdiZi4uOTY5NTJkNGFjYjUwIDEwMDY0NA0KLS0tIGEvZnMvZXhm
YXQvaW5vZGUuYw0KKysrIGIvZnMvZXhmYXQvaW5vZGUuYw0KQEAgLTQzLDcgKzQzLDcgQEAgaW50
IF9fZXhmYXRfd3JpdGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwgaW50IHN5bmMpDQogCWV4
ZmF0X3NldF92b2x1bWVfZGlydHkoc2IpOw0KIA0KIAkvKiBnZXQgdGhlIGRpcmVjdG9yeSBlbnRy
eSBvZiBnaXZlbiBmaWxlIG9yIGRpcmVjdG9yeSAqLw0KLQlpZiAoZXhmYXRfZ2V0X2RlbnRyeV9z
ZXQoJmVzLCBzYiwgJihlaS0+ZGlyKSwgZWktPmVudHJ5LCBFU19BTExfRU5UUklFUykpDQorCWlm
IChleGZhdF9nZXRfZGVudHJ5X3NldF9ieV9laSgmZXMsIHNiLCBlaSkpDQogCQlyZXR1cm4gLUVJ
TzsNCiAJZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZCgmZXMsIEVTX0lEWF9GSUxFKTsNCiAJ
ZXAyID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoJmVzLCBFU19JRFhfU1RSRUFNKTsNCmRpZmYg
LS1naXQgYS9mcy9leGZhdC9uYW1laS5jIGIvZnMvZXhmYXQvbmFtZWkuYw0KaW5kZXggYzYxZmRk
YjliMjNjLi5mOTM4Mjk5ZTc0OWIgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9uYW1laS5jDQorKysg
Yi9mcy9leGZhdC9uYW1laS5jDQpAQCAtNzY2LDI2ICs3NjYsMjMgQEAgc3RhdGljIHN0cnVjdCBk
ZW50cnkgKmV4ZmF0X2xvb2t1cChzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVu
dHJ5LA0KIC8qIHJlbW92ZSBhbiBlbnRyeSwgQlVUIGRvbid0IHRydW5jYXRlICovDQogc3RhdGlj
IGludCBleGZhdF91bmxpbmsoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRy
eSkNCiB7DQotCXN0cnVjdCBleGZhdF9jaGFpbiBjZGlyOw0KIAlzdHJ1Y3Qgc3VwZXJfYmxvY2sg
KnNiID0gZGlyLT5pX3NiOw0KIAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZGVudHJ5LT5kX2lub2Rl
Ow0KIAlzdHJ1Y3QgZXhmYXRfaW5vZGVfaW5mbyAqZWkgPSBFWEZBVF9JKGlub2RlKTsNCiAJc3Ry
dWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSBlczsNCi0JaW50IGVudHJ5LCBlcnIgPSAwOw0KKwlp
bnQgZXJyID0gMDsNCiANCiAJaWYgKHVubGlrZWx5KGV4ZmF0X2ZvcmNlZF9zaHV0ZG93bihzYikp
KQ0KIAkJcmV0dXJuIC1FSU87DQogDQogCW11dGV4X2xvY2soJkVYRkFUX1NCKHNiKS0+c19sb2Nr
KTsNCi0JZXhmYXRfY2hhaW5fZHVwKCZjZGlyLCAmZWktPmRpcik7DQotCWVudHJ5ID0gZWktPmVu
dHJ5Ow0KIAlpZiAoZWktPmRpci5kaXIgPT0gRElSX0RFTEVURUQpIHsNCiAJCWV4ZmF0X2Vycihz
YiwgImFibm9ybWFsIGFjY2VzcyB0byBkZWxldGVkIGRlbnRyeSIpOw0KIAkJZXJyID0gLUVOT0VO
VDsNCiAJCWdvdG8gdW5sb2NrOw0KIAl9DQogDQotCWVyciA9IGV4ZmF0X2dldF9kZW50cnlfc2V0
KCZlcywgc2IsICZjZGlyLCBlbnRyeSwgRVNfQUxMX0VOVFJJRVMpOw0KKwllcnIgPSBleGZhdF9n
ZXRfZGVudHJ5X3NldF9ieV9laSgmZXMsIHNiLCBlaSk7DQogCWlmIChlcnIpIHsNCiAJCWVyciA9
IC1FSU87DQogCQlnb3RvIHVubG9jazsNCkBAIC05MTUsMjEgKzkxMiwxOCBAQCBzdGF0aWMgaW50
IGV4ZmF0X2NoZWNrX2Rpcl9lbXB0eShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KIHN0YXRpYyBp
bnQgZXhmYXRfcm1kaXIoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkN
CiB7DQogCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBkZW50cnktPmRfaW5vZGU7DQotCXN0cnVjdCBl
eGZhdF9jaGFpbiBjZGlyLCBjbHVfdG9fZnJlZTsNCisJc3RydWN0IGV4ZmF0X2NoYWluIGNsdV90
b19mcmVlOw0KIAlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0gaW5vZGUtPmlfc2I7DQogCXN0cnVj
dCBleGZhdF9zYl9pbmZvICpzYmkgPSBFWEZBVF9TQihzYik7DQogCXN0cnVjdCBleGZhdF9pbm9k
ZV9pbmZvICplaSA9IEVYRkFUX0koaW5vZGUpOw0KIAlzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2Nh
Y2hlIGVzOw0KLQlpbnQgZW50cnksIGVycjsNCisJaW50IGVycjsNCiANCiAJaWYgKHVubGlrZWx5
KGV4ZmF0X2ZvcmNlZF9zaHV0ZG93bihzYikpKQ0KIAkJcmV0dXJuIC1FSU87DQogDQogCW11dGV4
X2xvY2soJkVYRkFUX1NCKGlub2RlLT5pX3NiKS0+c19sb2NrKTsNCiANCi0JZXhmYXRfY2hhaW5f
ZHVwKCZjZGlyLCAmZWktPmRpcik7DQotCWVudHJ5ID0gZWktPmVudHJ5Ow0KLQ0KIAlpZiAoZWkt
PmRpci5kaXIgPT0gRElSX0RFTEVURUQpIHsNCiAJCWV4ZmF0X2VycihzYiwgImFibm9ybWFsIGFj
Y2VzcyB0byBkZWxldGVkIGRlbnRyeSIpOw0KIAkJZXJyID0gLUVOT0VOVDsNCkBAIC05NDcsNyAr
OTQxLDcgQEAgc3RhdGljIGludCBleGZhdF9ybWRpcihzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0
IGRlbnRyeSAqZGVudHJ5KQ0KIAkJZ290byB1bmxvY2s7DQogCX0NCiANCi0JZXJyID0gZXhmYXRf
Z2V0X2RlbnRyeV9zZXQoJmVzLCBzYiwgJmNkaXIsIGVudHJ5LCBFU19BTExfRU5UUklFUyk7DQor
CWVyciA9IGV4ZmF0X2dldF9kZW50cnlfc2V0X2J5X2VpKCZlcywgc2IsIGVpKTsNCiAJaWYgKGVy
cikgew0KIAkJZXJyID0gLUVJTzsNCiAJCWdvdG8gdW5sb2NrOw0KQEAgLTk4Miw4ICs5NzYsOCBA
QCBzdGF0aWMgaW50IGV4ZmF0X3JtZGlyKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5
ICpkZW50cnkpDQogCXJldHVybiBlcnI7DQogfQ0KIA0KLXN0YXRpYyBpbnQgZXhmYXRfcmVuYW1l
X2ZpbGUoc3RydWN0IGlub2RlICpwYXJlbnRfaW5vZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9k
aXIsDQotCQlpbnQgb2xkZW50cnksIHN0cnVjdCBleGZhdF91bmlfbmFtZSAqcF91bmluYW1lLA0K
K3N0YXRpYyBpbnQgZXhmYXRfcmVuYW1lX2ZpbGUoc3RydWN0IGlub2RlICpwYXJlbnRfaW5vZGUs
DQorCQlzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLCBzdHJ1Y3QgZXhmYXRfdW5pX25hbWUgKnBf
dW5pbmFtZSwNCiAJCXN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSkNCiB7DQogCWludCByZXQs
IG51bV9uZXdfZW50cmllczsNCkBAIC05OTksNyArOTkzLDcgQEAgc3RhdGljIGludCBleGZhdF9y
ZW5hbWVfZmlsZShzdHJ1Y3QgaW5vZGUgKnBhcmVudF9pbm9kZSwgc3RydWN0IGV4ZmF0X2NoYWlu
ICpwX2QNCiAJaWYgKG51bV9uZXdfZW50cmllcyA8IDApDQogCQlyZXR1cm4gbnVtX25ld19lbnRy
aWVzOw0KIA0KLQlyZXQgPSBleGZhdF9nZXRfZGVudHJ5X3NldCgmb2xkX2VzLCBzYiwgcF9kaXIs
IG9sZGVudHJ5LCBFU19BTExfRU5UUklFUyk7DQorCXJldCA9IGV4ZmF0X2dldF9kZW50cnlfc2V0
X2J5X2VpKCZvbGRfZXMsIHNiLCBlaSk7DQogCWlmIChyZXQpIHsNCiAJCXJldCA9IC1FSU87DQog
CQlyZXR1cm4gcmV0Ow0KQEAgLTEwNTMsMjEgKzEwNDcsMTkgQEAgc3RhdGljIGludCBleGZhdF9y
ZW5hbWVfZmlsZShzdHJ1Y3QgaW5vZGUgKnBhcmVudF9pbm9kZSwgc3RydWN0IGV4ZmF0X2NoYWlu
ICpwX2QNCiAJcmV0dXJuIHJldDsNCiB9DQogDQotc3RhdGljIGludCBleGZhdF9tb3ZlX2ZpbGUo
c3RydWN0IGlub2RlICpwYXJlbnRfaW5vZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9vbGRkaXIs
DQotCQlpbnQgb2xkZW50cnksIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9uZXdkaXIsDQotCQlzdHJ1
Y3QgZXhmYXRfdW5pX25hbWUgKnBfdW5pbmFtZSwgc3RydWN0IGV4ZmF0X2lub2RlX2luZm8gKmVp
KQ0KK3N0YXRpYyBpbnQgZXhmYXRfbW92ZV9maWxlKHN0cnVjdCBpbm9kZSAqcGFyZW50X2lub2Rl
LA0KKwkJc3RydWN0IGV4ZmF0X2NoYWluICpwX25ld2Rpciwgc3RydWN0IGV4ZmF0X3VuaV9uYW1l
ICpwX3VuaW5hbWUsDQorCQlzdHJ1Y3QgZXhmYXRfaW5vZGVfaW5mbyAqZWkpDQogew0KIAlpbnQg
cmV0LCBuZXdlbnRyeSwgbnVtX25ld19lbnRyaWVzOw0KIAlzdHJ1Y3QgZXhmYXRfZGVudHJ5ICpl
cG1vdiwgKmVwbmV3Ow0KLQlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0gcGFyZW50X2lub2RlLT5p
X3NiOw0KIAlzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlIG1vdl9lcywgbmV3X2VzOw0KIA0K
IAludW1fbmV3X2VudHJpZXMgPSBleGZhdF9jYWxjX251bV9lbnRyaWVzKHBfdW5pbmFtZSk7DQog
CWlmIChudW1fbmV3X2VudHJpZXMgPCAwKQ0KIAkJcmV0dXJuIG51bV9uZXdfZW50cmllczsNCiAN
Ci0JcmV0ID0gZXhmYXRfZ2V0X2RlbnRyeV9zZXQoJm1vdl9lcywgc2IsIHBfb2xkZGlyLCBvbGRl
bnRyeSwNCi0JCQlFU19BTExfRU5UUklFUyk7DQorCXJldCA9IGV4ZmF0X2dldF9kZW50cnlfc2V0
X2J5X2VpKCZtb3ZfZXMsIHBhcmVudF9pbm9kZS0+aV9zYiwgZWkpOw0KIAlpZiAocmV0KQ0KIAkJ
cmV0dXJuIC1FSU87DQogDQpAQCAtMTExNiw4ICsxMTA4LDcgQEAgc3RhdGljIGludCBfX2V4ZmF0
X3JlbmFtZShzdHJ1Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUsDQogCQlzdHJ1Y3QgZGVudHJ5
ICpuZXdfZGVudHJ5KQ0KIHsNCiAJaW50IHJldDsNCi0JaW50IGRlbnRyeTsNCi0Jc3RydWN0IGV4
ZmF0X2NoYWluIG9sZGRpciwgbmV3ZGlyOw0KKwlzdHJ1Y3QgZXhmYXRfY2hhaW4gbmV3ZGlyOw0K
IAlzdHJ1Y3QgZXhmYXRfdW5pX25hbWUgdW5pX25hbWU7DQogCXN0cnVjdCBzdXBlcl9ibG9jayAq
c2IgPSBvbGRfcGFyZW50X2lub2RlLT5pX3NiOw0KIAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2Jp
ID0gRVhGQVRfU0Ioc2IpOw0KQEAgLTExMzQsMTEgKzExMjUsNiBAQCBzdGF0aWMgaW50IF9fZXhm
YXRfcmVuYW1lKHN0cnVjdCBpbm9kZSAqb2xkX3BhcmVudF9pbm9kZSwNCiAJCXJldHVybiAtRU5P
RU5UOw0KIAl9DQogDQotCWV4ZmF0X2NoYWluX3NldCgmb2xkZGlyLCBFWEZBVF9JKG9sZF9wYXJl
bnRfaW5vZGUpLT5zdGFydF9jbHUsDQotCQlFWEZBVF9CX1RPX0NMVV9ST1VORF9VUChpX3NpemVf
cmVhZChvbGRfcGFyZW50X2lub2RlKSwgc2JpKSwNCi0JCUVYRkFUX0kob2xkX3BhcmVudF9pbm9k
ZSktPmZsYWdzKTsNCi0JZGVudHJ5ID0gZWktPmVudHJ5Ow0KLQ0KIAkvKiBjaGVjayB3aGV0aGVy
IG5ldyBkaXIgaXMgZXhpc3RpbmcgZGlyZWN0b3J5IGFuZCBlbXB0eSAqLw0KIAlpZiAobmV3X2lu
b2RlKSB7DQogCQlyZXQgPSAtRUlPOw0KQEAgLTExNzMsMjEgKzExNTksMTggQEAgc3RhdGljIGlu
dCBfX2V4ZmF0X3JlbmFtZShzdHJ1Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUsDQogDQogCWV4
ZmF0X3NldF92b2x1bWVfZGlydHkoc2IpOw0KIA0KLQlpZiAob2xkZGlyLmRpciA9PSBuZXdkaXIu
ZGlyKQ0KLQkJcmV0ID0gZXhmYXRfcmVuYW1lX2ZpbGUobmV3X3BhcmVudF9pbm9kZSwgJm9sZGRp
ciwgZGVudHJ5LA0KKwlpZiAobmV3X3BhcmVudF9pbm9kZSA9PSBvbGRfcGFyZW50X2lub2RlKQ0K
KwkJcmV0ID0gZXhmYXRfcmVuYW1lX2ZpbGUobmV3X3BhcmVudF9pbm9kZSwgJm5ld2RpciwNCiAJ
CQkJJnVuaV9uYW1lLCBlaSk7DQogCWVsc2UNCi0JCXJldCA9IGV4ZmF0X21vdmVfZmlsZShuZXdf
cGFyZW50X2lub2RlLCAmb2xkZGlyLCBkZW50cnksDQotCQkJCSZuZXdkaXIsICZ1bmlfbmFtZSwg
ZWkpOw0KKwkJcmV0ID0gZXhmYXRfbW92ZV9maWxlKG5ld19wYXJlbnRfaW5vZGUsICZuZXdkaXIs
DQorCQkJCSZ1bmlfbmFtZSwgZWkpOw0KIA0KIAlpZiAoIXJldCAmJiBuZXdfaW5vZGUpIHsNCiAJ
CXN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgZXM7DQotCQlzdHJ1Y3QgZXhmYXRfY2hhaW4g
KnBfZGlyID0gJihuZXdfZWktPmRpcik7DQotCQlpbnQgbmV3X2VudHJ5ID0gbmV3X2VpLT5lbnRy
eTsNCiANCiAJCS8qIGRlbGV0ZSBlbnRyaWVzIG9mIG5ld19kaXIgKi8NCi0JCXJldCA9IGV4ZmF0
X2dldF9kZW50cnlfc2V0KCZlcywgc2IsIHBfZGlyLCBuZXdfZW50cnksDQotCQkJCUVTX0FMTF9F
TlRSSUVTKTsNCisJCXJldCA9IGV4ZmF0X2dldF9kZW50cnlfc2V0X2J5X2VpKCZlcywgc2IsIG5l
d19laSk7DQogCQlpZiAocmV0KSB7DQogCQkJcmV0ID0gLUVJTzsNCiAJCQlnb3RvIGRlbF9vdXQ7
DQotLSANCjIuNDMuMA0KDQo=

