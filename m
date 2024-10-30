Return-Path: <linux-fsdevel+bounces-33232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5379B5B98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 07:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D41B22A28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 06:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9BC1D0F76;
	Wed, 30 Oct 2024 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="n2JH26qo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459FE3398E
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268750; cv=fail; b=rJqcgABpoxlhJLApTkz/INXjRC9fspqz1ovX96b5cQHaS+QidrKAsGshs/xNMtuKC1RsuAPatyLUov7eo++csGRCqF0/Ovno9mMbnLIDHddZU8W34v8owxTes2FvM4+E7sq5rn4XWQFYtGNyRaCW3vpRm3v+BQtSq39IMdc+/UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268750; c=relaxed/simple;
	bh=NivdX8AtRVA6JNFvv/TVGM9USOTDI0TcVF/YlAo3/Gs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=foDsSNf5fA/IopofiV+LY/sm5mPCuS2waANgPKhGwMx/WhAdxASsz9Q4YmxItjx+p5W/NcWDT/8NhN42pKTBzNM3GjxNtTBewFlL0eie+Q/wk4JO6G0EvjlSnsF2fgX29GDXpeR9wn2nDs/8VHTrPKIGdzsKEuRSDf6nbF59v9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=n2JH26qo; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U5wJjM018773;
	Wed, 30 Oct 2024 06:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=NivdX8AtRVA6JNFvv/TVGM9USOTDI
	0TcVF/YlAo3/Gs=; b=n2JH26qoYR+XRA5U/iMHnGoNCJ6L3pkT1bigE7ZXyDdoW
	r+OFDZLg8GXh2O4rXxyZpEPE32hR9o+SDZrN5fpAJ13Xxj7HrzyaBDwaGC80CmN9
	32Qlfr3po7/yeVt7kM/Ji4n9hHnG875kD+URJZcaROrm5DZg/foWLht1Zl5kYDiR
	3ov+TTXRSVT+1DNrDpAbacz017l3HJZkqEWuiOGpmOALnZgf40ZEEpmJuAkAigsV
	zlFLbmUdoubqMVoo13S7JmiPIubmWgMwuT8ai9wTV5nIbs1XsK8BxILUwu7yaBD+
	gwYn0SyKWE+DlZJJp5584ypUerDMRcMW9qIqGkJxw==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42k2ypgkdm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 06:12:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x75iFzze4m3g9tXrVj0ukOTi4K5m0iTTOCXMnoRDIBpjsp8fF34+pBtmovMbsh3Mst+pwhGF3fCCir/w0aevi6BKsYS/gM7d0G7rGuT7FQKVjU5B6H20lrDh5sNJgPiX1uRLr0rpEOsAB06iWb87Da4IoKrM92PiZ6DyL+tYNHGJW+rChxxBmmPOXCf7yeqWLS9WbJNxJa+KelhauXVk6q7Cg8pF8s0V2OfTfWX3ig98EKlQ4jWWD4WSC+wkgovluN/QEccX7AuK9QWBN6CxKuAkKSY2eYKCsvlQN0MM53eQIKIRIjZjlJ5HrQzyhXbRwcVg91Z10ih1omWEQC988g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NivdX8AtRVA6JNFvv/TVGM9USOTDI0TcVF/YlAo3/Gs=;
 b=q4d8L/Oy+YIg9GHby2Gj07bBbcWorD9ZdWIniVJRY7GYorCIR2+U09wD9BCONVSew8ydCls2Qc1ddhti7rxAP9b1ebTlipTfk4xc65YIYSCADQyeafNgcupCaqxDh+QvbPlP1H7ZmtDVntQ7/a+/dMLinKvnum2KbHScp3xG10If4BpzuBpszfo5CTTfGgjaJi2ihatT9R4zFMgijv8ygkxn/mkFTZojRHE7b3FUl0E7/Bmu5lT3UCos901to3HuasvVw4ONcC7QnUCkd8Ho9WaLqDjmXztkPt1La68q/NX24gRjyPT7kYmTabzSNk6CDlCsbL7NilfCqBh6KMOYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY0PR04MB6268.apcprd04.prod.outlook.com (2603:1096:400:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 06:12:01 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 06:12:01 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 1/6] exfat: remove unnecessary read entry in
 __exfat_rename()
Thread-Topic: [PATCH v1 1/6] exfat: remove unnecessary read entry in
 __exfat_rename()
Thread-Index: AdrpZcjC8JDh6QmXSF2Xe94pYPCVBxBK3sag
Date: Wed, 30 Oct 2024 06:12:01 +0000
Message-ID:
 <PUZPR04MB6316CEF70D6AB2386AEDAEC281542@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY0PR04MB6268:EE_
x-ms-office365-filtering-correlation-id: f32bef25-8e53-4043-37f7-08dcf8a9c4f4
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVp0N0ZDeWl6cG9pbEpNK1pxaEFPc1Qza1dKRDg1MndSaFViM3NkdTJ3Q0U5?=
 =?utf-8?B?dWF3Mko0YWNmWjAzMWNOb2k4V2dCN0JBRU1zajh3NnJHUUJCV2dDTytwU0FH?=
 =?utf-8?B?UnYrRnRGSUx4L3hpcWdKZjZmbXlkd0VLZk1qaStva0kxbXZ5Rm9XalB5QzBG?=
 =?utf-8?B?Vm0yWi9BdHdMd1YxZ0l5QytBa1dpdHd0NldYM1dscG5jT1gvR29mTDV0MUhv?=
 =?utf-8?B?alZTbThtU3BlZGpYcWxXRWtXcnFMQ0RBcjYvYzRrL3pjWkMvelhtMUxKMDla?=
 =?utf-8?B?MlE4L3pGWk5namJWbDduSFlNTXNhRjd4SjhKa1Z4Q09KSWd6enpxeXBPS2Ri?=
 =?utf-8?B?c0FubUluT1JESWcrZzlaTnFqamxkZnp2RlMzWXpvWktOeDZEUHJrVGdNc2dT?=
 =?utf-8?B?WTZEM1d2eVlWUFpaQ2ZXc1FpTENDV1Z3RHNIUi93akdlRm1BSXFST0xjMDBE?=
 =?utf-8?B?VHZRMURKUGJRLzEzL3h4WmxtbERWdVA2bVVVcTU5Z2g1KzZKNVo1VERoQ0Zr?=
 =?utf-8?B?eSttMTNieWh4VnRXRzIxTDdMaU9LSE9vd0JvYUh0OURDZWkwRzR0SGR4eWxr?=
 =?utf-8?B?dVFpZnRwRDJMY3o2VkxSMEkxdG15ck9jNUxsVXJ0STVtaDJLeVJVeC9qVjRX?=
 =?utf-8?B?ZkRVeHkrVnRydHRySUxqaWlIRTdzVFl2dHY4anpBOG40bTltenpRMFVTbUZK?=
 =?utf-8?B?ZzVJSXpuY3YwZENQUkpJQXBTL1pvN1V2dE1JbU5USHd0STZJNWw2OXpQTEVW?=
 =?utf-8?B?UFlhN1drVXhWaVQ1MzZOb0JJZmxPS3ZnaEdWbUVvdzQvbnlobTFjK3V4Tlpz?=
 =?utf-8?B?bmNGc3YzMlF3STlzYkFZK1c5K3FvTFdMaFM1VGJqelVTMkZ0UnRWa3VmTmJx?=
 =?utf-8?B?VFlCY3I2TXRwZTdUdlMwcS95dHBtRHhtZm9ZL3ArTGorU0cwcmMyYmtlOE9K?=
 =?utf-8?B?Z2tVOCtLNFY2bG56TkF5d3JQTGNITmhtL0V3WjNUM09PM0pLODlvZmlaT05n?=
 =?utf-8?B?aVZoYmFyWDd5WXF3ejQrQ09GbUt2bGR6YTUvN0tvd3BnZDJkOGlzU2pPazlj?=
 =?utf-8?B?QTZ1ZUExVWtrVUp3TmtuOHZ6Q2k0TFVIN3dxckRZVkFKYUdqY2c3aHRRQUFl?=
 =?utf-8?B?VjRESkFkdDh2UnNKbVRQdWdMRFc2cWh2ZGl4N2s3VzR6aTgrRU0wWmRBc0Ru?=
 =?utf-8?B?WFVRWW9VM0tVbXdvd3JYUjVBZ3R5RnhMVnJlY2FBMU0wc1ZocExseEhQMEdu?=
 =?utf-8?B?SVRLRDdrSE5MTkdRMUJLdkFORW1uMzBnNjVuYlZBNlF3NHk3bmxnZmU4Q0RG?=
 =?utf-8?B?SWFnWlZRa0lYbnFrVDRFczV1MnBTR21BMFVJR1ZaSVlZa1gxSFl6blRValZL?=
 =?utf-8?B?OHk0YzJLNFFKaE53cUFrVXd6S1hkWWVEdWtiZGFYNVZySC9yUTNzNUxlcDl3?=
 =?utf-8?B?V2JPcnVXRXRCSUtDLzJYR1lxRE1GRkRKeU9kZWdzL25yN0lqRndxSVVBa3JZ?=
 =?utf-8?B?cmlickoybk1VYXQ0S0RyQ05mQ1pjaEphOEx6eGlpdHc3N2RYU1dlUUxmRmpL?=
 =?utf-8?B?S0tNQ0xjeHF3SE8yRVhqTUFqdUJyMlBxRzk4MHJEMzNON1Zmc0VSV2dMZjlI?=
 =?utf-8?B?cUJRNVNTcERlcW1tY3hBeFJSeVkxQzdSZUZzUUJ6bk4vSTAxL0lZTUVHMTB2?=
 =?utf-8?B?UWo4YXV1R0luREVqQVU4WFVmdHZ0cjc4MkdqaldZNE0rQmZac3gxQVVGTjVJ?=
 =?utf-8?B?R1ppNGl5dUh2OEhPUTdONWZzRUFMQ1o2VkVIUk9RNU4rQ2NJV3hSb1JKckdq?=
 =?utf-8?Q?NJYIm89HbOWJQcd0t0y4wC7WoywsYGDXB5iIw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDZ4R1JzMGlZUHpoWXRQcURDVHNaWjJVTHFHUkdRL3NKK0dPR1I3eENUNHVK?=
 =?utf-8?B?NCs5S05WQ0M1eHJ6K1RHVU9YL2cvWlltUTFJdkYwMHRMa2dKS2Y1Z2x1TnBQ?=
 =?utf-8?B?d1YzY2ZFTjZrSGNQeXc0NjlyNUxzOThlRlMwdDQ0dWhMenVpWWhkOXN3UWd2?=
 =?utf-8?B?LzByUDlKL1RWM0dQRHFPYzZmVmVyYTBIOVZWVWxscG1wUnhRNHBJVVAvNlgz?=
 =?utf-8?B?Q1BiUEZEbkVkbm9kUXRxVVg4ZWYvSVF5U2RVM2xNK2QrNjRkNW1MWjhHWVk1?=
 =?utf-8?B?WlNsZXNzeklQOXdmOHlma3I3MGttd1ZFbzQ0RzB0anZjVmY3aHlOcFZaWEV4?=
 =?utf-8?B?QzBUaVczeGllRXBwcUJwWjlZRDZjYTI3dGpCQnJrdTh3Y2tXUFRuZUg5c1l2?=
 =?utf-8?B?QUhlTW5KUTFGd216QWtxdFAxTURGcTZxWDEyQVgyVmlxV1ZpZTc1TDg3dTJv?=
 =?utf-8?B?aVZQQ1crUWxvTG9TbS9SS0pKYVFXalZGbFpkakowcE81OTFsWG13VmNwTlBt?=
 =?utf-8?B?MVFkVGdHVVkxU0ZhTjJncDhhTDVaODEvZ1pKNlR1ZVZhNnY0U1VuYmlLNWdZ?=
 =?utf-8?B?emZzZHkyR2VQT3llWVBVZGhCaE9aTlJyQ3NTZGlSbFJlaUoxQ3hWSms4RHV4?=
 =?utf-8?B?R3cweUNiZG5wRkhXSHA1QzMvOWF0Q1d1TWZZcVpvZWY0b1BHMWM5YmNVUzJE?=
 =?utf-8?B?bE1rb1k1STRYRVpmVUVyN0ZNcDlueW5IMHhpbUtPaEhNbEpqQkh5VFRPbzM2?=
 =?utf-8?B?aFAwSkNHSHJ6dXFtc0l4ZEFvMXFvemRqTHhpRGJ4eUFlcjJzaWpDdktrT3Y3?=
 =?utf-8?B?V2twb21xMURESXZYU1NEZHdYM1dETVBaY0Z2cjZ2UEJGOVBqSHRRVHpNWTYx?=
 =?utf-8?B?Rlk0WHZCR0RqNmczMFFYUmZQa3gyS1N1VTcyVmRqb2EzS1NZQWVyM2xkdFRX?=
 =?utf-8?B?bDgyc1g0WFQ2Z2FicFdMa3BRdXNnUlhIYWJDdCtsaG1aUHpyM2dBbFM4MW8v?=
 =?utf-8?B?U0lPSnZQN1JuL1d6NmM3WXZYeVByVitsajd3bXgrdmNKMG5sTXo3c01hRTd5?=
 =?utf-8?B?K3JPY3owWmNmRWpCT1VxUkJhSm4rUVJSNEliRFlZMHJqeVhqM0RFVHF5L2xD?=
 =?utf-8?B?aStyN3dScjYva2RyS3pJajNJNlhqSlk2M1hrYWtKOEZYSWthMWJPN1RMSE1k?=
 =?utf-8?B?QWJ1b2VRdDl1UjJIb01NcTV1amdObTFNN0NDVERJbSsxM0RtZHlGUUdZNCt1?=
 =?utf-8?B?aTB4NThkNytzaGhkbGZTdHFEYmZ6VUdkZDJMOXVzWnJJY1NPQlhVS3FtYzFY?=
 =?utf-8?B?YUlVTWpDV0ZaUnZsWUEyZ05LTVZaaUVHOU1ZSHQ0Y3h1NE9FTitNa2kvTUhD?=
 =?utf-8?B?R3pQM2tveHJZY24ranFhN3duWURrTU85M2JmYzZFWlZuYm9IUE1uM2hMNWNC?=
 =?utf-8?B?QWgxMzROSjlTNDNxTWZtNGs3a3NzOTdvR3Y1enAzM1Z4UnNpanFsRFkzZnpE?=
 =?utf-8?B?YkV5VVJoSWdqSUsram1ZMFE0QVgwaHV6MFhRTGNrQXF2S2srbWRhOEM5ci9W?=
 =?utf-8?B?a3BVVTV0WUhyVmVzLzhpUjFTYTlmanZNSzBXZ0NQM0dINm5mc0tIdkJWVmlL?=
 =?utf-8?B?eC9GaWZzWDB5TmR1K1FIM3FDbUdHM2xXVHlrMnFralhtb3BVbzNEZmFqVHpo?=
 =?utf-8?B?dmIxNE1sMXRVc0w0U2dTY01lVHFDR21YYWpFRG5TTmhQTi9jTHU4T01Oeldv?=
 =?utf-8?B?RkpiQXNId2xoNHg5SlQ2blZoRWlkUG1hUkhZRGlrWkk3NkkxMUJXemE0TjJV?=
 =?utf-8?B?OElNdk8yQk90N3RoRFlmc3VpRzE4N3Z3bThNK090d1pyWVR0UFJvTisrSlhh?=
 =?utf-8?B?SmwwV2NZRmdkdXNTa3ZjTFgwd2Z5RU16OGp3MFVjVUNlWlZPWCtPZFpMSVpN?=
 =?utf-8?B?WkUzbVFZYXoyNjExa2Nodnk0b3cwY1FvMHYya3hFMDVtajNLZnRBUWV2cE9a?=
 =?utf-8?B?ZEtIUUpZYldqd3g3VFRRZVR0bVV0YmVkNzI0b0pvYm5oWFg5REtFNDFwR2ov?=
 =?utf-8?B?UUd2eFU5eGNsZ09jRnFsaHBDVS85YUJWVnA4SUU4MnJ6VGhKeUN0cGlLS095?=
 =?utf-8?Q?SiMqV1O26AfFJtI8zoEfBlTSH?=
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
	aICL6Kxvlp91uvq1vwAX31tt8l06o1HXx4FgKFnixEIBJLOnmpJ3TJQWcdizXIL6G+G8S/zf2dkvhShxqDTPZH1n3z1uW5lxpV3/Wo6Z0hbmdeJD25cfc4rTCTKtmhFZvw2y5n/Pa+i7OWpe+t5P4jARLEnlkeNaoS0eZVdFM73HyrQW+QqMQRV8JBVjAUNIiUyLnInOnqs7SHg/YCkG6UuomReQhVGThwpPAa4IBV7ABNn6CAlGPHhstwW3lvnWTAOg0mZC+pKY1lX2ZGi+JxIQliqWCnvzT0dsFPIN/5klhaF7YGCOH1PFfxYcnJkjH+UjiTtnMPftYmlzGseMIYc2tlyebbn61OXg6YmZWj9wAU8LeRQiIE79Go9JXEAZc/RS2FiV1UQ309yEIorHTKWnxa2diVGTv9isw5UiRI8wH4jMfYpOVFHMACkXNk83JVx1MdELWT9lB3peitVuECl0PqJe2MJWaB4zQwVMOAwi6USn6cHqEGihYENujx4hgu7RCnb/Kd29vst3P0lhxKouTwj2PNv+/+UbJ2Hryn5V1ASfxyKljjou2ojgNZnZy7zyMCx/BWWFFp1D9CmtUPOIAzFyg2ILNNlIBs41ZhkZvHPksSrQt2m85eHJY4CR
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32bef25-8e53-4043-37f7-08dcf8a9c4f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 06:12:01.6750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkFFY0E97x8EmzM2LxWCwErrAIHVHjyFNgiMa81R+MLR+q7HHD6V1IBnxSozvL57WtGz1Xv5d0Kqfqd9LUrRwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6268
X-Proofpoint-GUID: EUZWk9COespQCFExs9wN_X0PSP38me3a
X-Proofpoint-ORIG-GUID: EUZWk9COespQCFExs9wN_X0PSP38me3a
X-Sony-Outbound-GUID: EUZWk9COespQCFExs9wN_X0PSP38me3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_03,2024-10-29_01,2024-09-30_01

VG8gZGV0ZXJtaW5lIHdoZXRoZXIgaXQgaXMgYSBkaXJlY3RvcnksIHRoZXJlIGlzIG5vIG5lZWQg
dG8gcmVhZCBpdHMNCmRpcmVjdG9yeSBlbnRyeSwganVzdCB1c2UgU19JU0RJUihpbm9kZS0+aV9t
b2RlKS4NCg0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29t
Pg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQpS
ZXZpZXdlZC1ieTogRGFuaWVsIFBhbG1lciA8ZGFuaWVsLnBhbG1lckBzb255LmNvbT4NCi0tLQ0K
IGZzL2V4ZmF0L25hbWVpLmMgfCAyMCArKysrLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMv
ZXhmYXQvbmFtZWkuYyBiL2ZzL2V4ZmF0L25hbWVpLmMNCmluZGV4IDJjNGM0NDIyOTM1Mi4uNjcy
MzM5NmRlYWU4IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvbmFtZWkuYw0KKysrIGIvZnMvZXhmYXQv
bmFtZWkuYw0KQEAgLTExMTgsMTcgKzExMTgsMTIgQEAgc3RhdGljIGludCBfX2V4ZmF0X3JlbmFt
ZShzdHJ1Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUsDQogCWludCByZXQ7DQogCWludCBkZW50
cnk7DQogCXN0cnVjdCBleGZhdF9jaGFpbiBvbGRkaXIsIG5ld2RpcjsNCi0Jc3RydWN0IGV4ZmF0
X2NoYWluICpwX2RpciA9IE5VTEw7DQogCXN0cnVjdCBleGZhdF91bmlfbmFtZSB1bmlfbmFtZTsN
Ci0Jc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXA7DQogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBv
bGRfcGFyZW50X2lub2RlLT5pX3NiOw0KIAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhG
QVRfU0Ioc2IpOw0KIAljb25zdCB1bnNpZ25lZCBjaGFyICpuZXdfcGF0aCA9IG5ld19kZW50cnkt
PmRfbmFtZS5uYW1lOw0KIAlzdHJ1Y3QgaW5vZGUgKm5ld19pbm9kZSA9IG5ld19kZW50cnktPmRf
aW5vZGU7DQogCXN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICpuZXdfZWkgPSBOVUxMOw0KLQl1bnNp
Z25lZCBpbnQgbmV3X2VudHJ5X3R5cGUgPSBUWVBFX1VOVVNFRDsNCi0JaW50IG5ld19lbnRyeSA9
IDA7DQotCXN0cnVjdCBidWZmZXJfaGVhZCAqbmV3X2JoID0gTlVMTDsNCiANCiAJLyogY2hlY2sg
dGhlIHZhbGlkaXR5IG9mIHBvaW50ZXIgcGFyYW1ldGVycyAqLw0KIAlpZiAobmV3X3BhdGggPT0g
TlVMTCB8fCBzdHJsZW4obmV3X3BhdGgpID09IDApDQpAQCAtMTE1NCwxNyArMTE0OSw4IEBAIHN0
YXRpYyBpbnQgX19leGZhdF9yZW5hbWUoc3RydWN0IGlub2RlICpvbGRfcGFyZW50X2lub2RlLA0K
IAkJCWdvdG8gb3V0Ow0KIAkJfQ0KIA0KLQkJcF9kaXIgPSAmKG5ld19laS0+ZGlyKTsNCi0JCW5l
d19lbnRyeSA9IG5ld19laS0+ZW50cnk7DQotCQllcCA9IGV4ZmF0X2dldF9kZW50cnkoc2IsIHBf
ZGlyLCBuZXdfZW50cnksICZuZXdfYmgpOw0KLQkJaWYgKCFlcCkNCi0JCQlnb3RvIG91dDsNCi0N
Ci0JCW5ld19lbnRyeV90eXBlID0gZXhmYXRfZ2V0X2VudHJ5X3R5cGUoZXApOw0KLQkJYnJlbHNl
KG5ld19iaCk7DQotDQogCQkvKiBpZiBuZXdfaW5vZGUgZXhpc3RzLCB1cGRhdGUgZWkgKi8NCi0J
CWlmIChuZXdfZW50cnlfdHlwZSA9PSBUWVBFX0RJUikgew0KKwkJaWYgKFNfSVNESVIobmV3X2lu
b2RlLT5pX21vZGUpKSB7DQogCQkJc3RydWN0IGV4ZmF0X2NoYWluIG5ld19jbHU7DQogDQogCQkJ
bmV3X2NsdS5kaXIgPSBuZXdfZWktPnN0YXJ0X2NsdTsNCkBAIC0xMTk2LDYgKzExODIsOCBAQCBz
dGF0aWMgaW50IF9fZXhmYXRfcmVuYW1lKHN0cnVjdCBpbm9kZSAqb2xkX3BhcmVudF9pbm9kZSwN
CiANCiAJaWYgKCFyZXQgJiYgbmV3X2lub2RlKSB7DQogCQlzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0
X2NhY2hlIGVzOw0KKwkJc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciA9ICYobmV3X2VpLT5kaXIp
Ow0KKwkJaW50IG5ld19lbnRyeSA9IG5ld19laS0+ZW50cnk7DQogDQogCQkvKiBkZWxldGUgZW50
cmllcyBvZiBuZXdfZGlyICovDQogCQlyZXQgPSBleGZhdF9nZXRfZGVudHJ5X3NldCgmZXMsIHNi
LCBwX2RpciwgbmV3X2VudHJ5LA0KQEAgLTEyMTIsNyArMTIwMCw3IEBAIHN0YXRpYyBpbnQgX19l
eGZhdF9yZW5hbWUoc3RydWN0IGlub2RlICpvbGRfcGFyZW50X2lub2RlLA0KIAkJCWdvdG8gZGVs
X291dDsNCiANCiAJCS8qIEZyZWUgdGhlIGNsdXN0ZXJzIGlmIG5ld19pbm9kZSBpcyBhIGRpcihh
cyBpZiBleGZhdF9ybWRpcikgKi8NCi0JCWlmIChuZXdfZW50cnlfdHlwZSA9PSBUWVBFX0RJUiAm
Jg0KKwkJaWYgKFNfSVNESVIobmV3X2lub2RlLT5pX21vZGUpICYmDQogCQkgICAgbmV3X2VpLT5z
dGFydF9jbHUgIT0gRVhGQVRfRU9GX0NMVVNURVIpIHsNCiAJCQkvKiBuZXdfZWksIG5ld19jbHVf
dG9fZnJlZSAqLw0KIAkJCXN0cnVjdCBleGZhdF9jaGFpbiBuZXdfY2x1X3RvX2ZyZWU7DQotLSAN
CjIuNDMuMA0KDQo=

