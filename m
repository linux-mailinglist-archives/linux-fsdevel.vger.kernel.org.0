Return-Path: <linux-fsdevel+bounces-79524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TBn5OikQqmlLKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:22:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 467152193C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B414302F3B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EC2366837;
	Thu,  5 Mar 2026 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BzfpqCDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B606366557;
	Thu,  5 Mar 2026 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752901; cv=fail; b=bg+Z82AsmBBbtPDHeAatapBf4oSn6R7nfXweVzat444QpFo9ChAzVVt/AWEhcsk0glbDWBahBuyZJTvsXGI0TCG3CS6V8Bbm3NeWFxryADEKGVfxOGCvfXHlVfKZujQ68AyoVxKyH1o8YoH50cz2lnVZoyI99sKyq6Y/1GwddII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752901; c=relaxed/simple;
	bh=N8sdmY52yv+CNmTCZc3Gp18RDoWg+Po8Xy6uhnvobYw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HMjZyf6V+XXsxP8jNfRpG1imwx1OSE6iFkhYEtiaXxl7d3X0dDi+PKcZUkhUuKx+xus3LLhW6fSzJqWkUYSG/uXfLuHCI8wPksQsIZ0dzd+VCHRYUnh1C0GcAmplUoDr7hNx+esdGKG1WAM4GXE7ZVteqzkw+p1oXIkgBK+9dFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BzfpqCDg; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625DTfQ41195516;
	Thu, 5 Mar 2026 23:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=N8sdmY52yv+CNmTCZc3Gp18RDoWg+Po8Xy6uhnvobYw=; b=BzfpqCDg
	4RYg+OUZZuIFhYFE2E0PjIRE+E6shS4DDoXGDgIExT/ZaVxQQN2eGJpZFfZ2phS4
	51RaEMSMTD3bFxa/CNZCflzAkEemZBhMlh6gXUvXmrJojtTB3k83VnQvVxOUslOV
	eQOnw1yuV1TzwbMgfVFV3mcpYOUaurZh1UMQ+Mw0fzC01iAqYECXcMwT+nfE1C6M
	PeQ3FzReivjBWVOaMejVwlqNw3fgUeID6AxpW3M+2tNYpD+EhVxXRjBybcFUR7Gt
	xg82IDMTlY50lhcdSJyD+Sfnq32wXeReJDdIGZW4ElTv7i+k2vKZCjxwUfsHIVf0
	FrL3lwKPgYQaow==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskc5hhr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 23:21:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAonyyeg8IOYoR7PARnMDsB+YqESsgrGuvyd68QZwzfLXouajQfrIEraXCsfDaf64PycmdAxpxFBH+GsM/C6HztqnJthKt1RyOTSt+nXaORkYTkNfu4JHxclFnG770ixUSJjGi6K4XhsALuwQ0FMcr0YFtR93/typGbYzLwAHIOVrNRwKtzlA+gpYgHELp2yiTXaPbfoBLmM9pyXwc0m+D3hAWrEaHD/sv+0Sx/g7FMez7UEEQrmmA+iuaiepUOKwD8Q17844Zq0gX1u3KiJM3kfMX6shIigQQqnlnpNTjQb0rthid+jEVKRXAh5r6p9JoSEUn9Iq6ytGPYWxKLNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8sdmY52yv+CNmTCZc3Gp18RDoWg+Po8Xy6uhnvobYw=;
 b=rYLbTy2FrSZBkM/SyRKMk2iJx//YN06xsXl6DiobU0GGEZPZN+DQ8uTPyXeTfvDA7ONioF6U7b52Bewe+ExPPLgIgqBjfXGajo2tjC1SqtGt4IGtqB5GGcwgAPBu7xLYk7TclgQyn9dn9b4wXJFr7BWmJrR5r0jWYMGIOAe4q/Oa6UVE6n72NXfiz/UJbbLsp05HfDRjqq0z64V//YVhnGWA2k1G3GD1T0os0ZrIUs1SefTcslCRfRwDOW+yzt763GdxUMuo3NsqZImLRPAzJR8ymme7XY6lYBx0FzdYZ7gCx89UOs7JRiA5xSKLUQ+JLneM3gK3gmp47Q7ZjI3GSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SN7PR15MB4237.namprd15.prod.outlook.com (2603:10b6:806:103::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 23:21:19 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 23:21:19 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hyc.lee@gmail.com" <hyc.lee@gmail.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "cheol.lee@lge.com" <cheol.lee@lge.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfsplus: limit sb_maxbytes to partition
 size
Thread-Index: AQHcq9hDf3IahKMroEqX1R8/F3zmX7WezIeAgABKD4CAAATZAIAAEm4AgAFn/AA=
Date: Thu, 5 Mar 2026 23:21:19 +0000
Message-ID: <e979abaf61fa6d7fab444eac293fcbc2993c78ee.camel@ibm.com>
References: <20260303082807.750679-1-hyc.lee@gmail.com>
	 <aaguv09zaPCgdzWO@infradead.org>
	 <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
	 <aajObSSRGVXG3sI_@hyunchul-PC02>
	 <532c5cdf12ced8eee5e5a93efe592937b63b889d.camel@ibm.com>
	 <CANFS6bZm3G9HA3X5Bi2_KGZDNGuguQzG44-cMcQHto2+qe_05g@mail.gmail.com>
In-Reply-To:
 <CANFS6bZm3G9HA3X5Bi2_KGZDNGuguQzG44-cMcQHto2+qe_05g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SN7PR15MB4237:EE_
x-ms-office365-filtering-correlation-id: 656c1103-43c9-4dd3-7f71-08de7b0de834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 zlL4MzqQsD3JY20LwXSc+FDoUVOzUREDUjiMtzwoHUJcn+fX8xefnE3bel060rt0OatOjQ13h23Bw6qQKzG3Ru/lKZxNb/dMt63zOxZ451mCog/ccTtiGvoC4x74htRDYZBtEEvYDi5gTrlxJyNbzj6uFgCVznMufFucPYnY2PVVmGfXYDtnHYx36CPasO4YCyiul6j9d6rT5GUvIOf5xRd3KYQHOKg11l+NKo5rmzQiPoHMztZ6iEwDC5gLNidZboKr5wqdtXTASOQGIceXXpvn8g02/FhT8lG5PrPPrz1LQPwuztnEesVSMP1GUyL0letdaKgphbP2/q48R44Ked3zEycuKmQxtcqKldCIyyyPzYyObYkille13+U64zlbzYlip3lakhQ8/yQ060nzePmjQEm7w2nnz0kSeVZ29Esd3EOSrQWQIdM+g/EcVAK1BdNJZTnA5e87/3A7S7UykXeBA+s34gBJMBZXtEs3gE8GG5xZhpkAmr60mJDZPtmMd3nQ1bD1InPCwICE3qaQIDYLpsFQ9YWuokQt6yeOxuV5FFIjUJH+qIQnj+bCWqZ16pVj5UdD9p5xCFyCoFo75kD7T6+ZN1tUJhOasgVHDm9AAxVP/x13zuXKtQko7+TbapL91NVoZSGpOh3UO+aMQhbHus24U+5PPGVsF9Zpzr8dnvaFTcN0LxcpdYMWtH9WHwpdCwvxxMBG9QrDhGe3GtTF1ObVCRlP09jjvVwhiLLyqQsSETEP6aqj43jhA/WM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RERiZDFvMGRMbmdQeThHRUNwVWhrVFhETU9ackJSUCtuSnRxaHpNbEVnak83?=
 =?utf-8?B?dE5QL1NYSGh2SGlZUGwvOExZcFZFMXhUM0NzcVhKbVQvL1FEYnNIR3k5Yi84?=
 =?utf-8?B?MmsyTXBjT1NBd0EyWnc1b09Yb0FaRGJQc1Z0MGZzUWVNZUJVcDc5RFpBbmp6?=
 =?utf-8?B?YVliS2tiTUE1M0ZMSlVzbEJHWjVhbzlmWEc5V3FGaXJ4bDFSdHovUExGM0VJ?=
 =?utf-8?B?TmpZRFNSd2hmYWx3Kzh6ejhkTFBJQmxpVUthamFmdkRTNWIwblB2c3UwNThB?=
 =?utf-8?B?NitTR2xFS3RMRXVBZGNyOERuU3R6OFQ4TW1JOTdhWWw4emYyZFRTalliYVVF?=
 =?utf-8?B?TWhlNkJKZFZCOTkxN2l2NXM4cy95TnU0U0ZFZDFxMmV1bVI3alZTWGZLdFNX?=
 =?utf-8?B?UzhBb1lSMi9RYmlCUmJaMkhOeWFhRUZjSTU1MFJvdzRBc09LOVpBNHlvaFgx?=
 =?utf-8?B?T2hmaEtUTjNJV0V6dHV4a3pqZ2JGY0N3NVR4cXQ5ZVJCc2xzcHBac2tSUGV4?=
 =?utf-8?B?ZEZpQks3SXVnK1ZVVzErdXZBb2JSMzVSdjRSdnh6QlNlWjN0VlVIU3NrU3gr?=
 =?utf-8?B?WVRDdHR0UUU1eUs4eUxvM0FqQUZrZ3c5eVIrNXdSWXFxd0JXc1IvQXNydHVG?=
 =?utf-8?B?eXpyNkk5VGZpenRmRERQZnNuOVE3V2RuNlppYi9iU0p1QUc2WUpybTBOalp4?=
 =?utf-8?B?L0FsakRYQ3N2SU1DbFBZTzIwcjJBbm40akJhSHZRbzNTdjQreXdCQTd5c2FJ?=
 =?utf-8?B?b25CSGpoRnhld1FIa3FoUjVZc1g5QWxjNUJMWk96Q0VmV2hveTR5K2pvT2x6?=
 =?utf-8?B?VFdwbFBROWkrS3JQbExkWDlib2kwUXdBTEZMdVVCcWt0Y2N1OTZTYnpOV2Zq?=
 =?utf-8?B?R2p2bnZFZmpBSXdFOWh6c0luT1JhbUp5R3FCWHZXVUVSczNNZFYvRFhnS0Ry?=
 =?utf-8?B?WE1IZWtjS1M5Tyt5K3FGMjhkbkUySDlHR2MzNzlWT3dMeFlFdkVXSUdtOGNN?=
 =?utf-8?B?MVZScGtHUU5GWlljRFNKUk1ZOFZURDZzQm1uOEFQdFJMWW80aVhQK0lQaFhv?=
 =?utf-8?B?MEhkWUxwb1RYa3I5ZW9nY3E2ekViK0lUbHhWcjFqTmhHV2plYVBONmtPc3Fz?=
 =?utf-8?B?azQvdGZtbnZUSzJzV3lDSFNiMkdVOHp4TjVrWE1vM0xYNGlpTUlvL3VNK0xW?=
 =?utf-8?B?RExyT080eW53eTMzeWYxQ3FKZUI4THhFRU1jYXgzaFJMT2oxVTVRUEFxL3Vj?=
 =?utf-8?B?ZFFlYXpyYnNPYkwvc0w1MG1sS0FXTC9QQmZ4aDZVR2gvYnJtUlk3TUF5WnFs?=
 =?utf-8?B?ZmlWQmZ4aWJNVDQ0dzhQMDREcTBXZXhDYkc4R2VwTXh1TThrNjQyRDRra01D?=
 =?utf-8?B?emZBZ0lhK0o0SU5KWDF1YnhhakpTZUtYOVMrYTR5VGRVV1NTNWdBQmFlNlVR?=
 =?utf-8?B?enZodXJmdHRaWTFPYzRDUmNSNnF6a29iakZKaU9HclQ2RDVoYmFaSmJCblBH?=
 =?utf-8?B?MUUwT3NuR0prZE95QWFzTVo5QSsxblhyY3ZzazFqWVZ0VEtBcEpKcklCbCt4?=
 =?utf-8?B?N3duWmk0b2dFZVRnaGtGbkJqeXYzRHVEVWc1TW1Ua1M1UzJDU3htTzFtdkZ0?=
 =?utf-8?B?eDhCSWVwclBudlhNTC84bThuc0kxWjBSMlRpK1hXVFdWRTEwREdzbjVtOTdT?=
 =?utf-8?B?ck5hNzBUVHpKaDNHZmhjSnB5NWNMM2xCUUpBSVJtK3NoWjg1REc3UGdzUlYw?=
 =?utf-8?B?VzZOMHA2dkZtKy9hTkZMRjl0SStYUktPemxBUWxjdE93bzZsd0g4U1pBWWw3?=
 =?utf-8?B?OGlMdFUrU0FuZE5qRGUzQ1RPMnJrczlHUFVvVHNWYkNEaHJ0TlhVKzM5RExo?=
 =?utf-8?B?bGs4SUVQem1CR083QnM1UW0rSm15UXBoT0tpeXBLZUV4Mk1DQWdTZ3JLMmxt?=
 =?utf-8?B?TFRuSjZ3dTRoK0Q0WUJDeUd2ZThSV2pPYXNLMHBjREpFSzJVak1yQkQxTTU1?=
 =?utf-8?B?bitkUXQ5OWgvWjY2bnhESW1rR3dmNERBWFNwZXNqOVkxbHlmNHdVK0hCa05D?=
 =?utf-8?B?ZmtGYkJHYUpZcnkxNU52cDFMREovek4wZTVnK3NmelV0Z0hxNURzVkI0eldJ?=
 =?utf-8?B?dklqMnAyMXI3Q29KeGREL1p1VTMrWGJPN2x3bDhvWEVQdzJtWXR6aFRzL1Iz?=
 =?utf-8?B?VW0vRnJaTGNVcGdPSjhqSURVMjZHZTVhYkliSDRLSWVUS3NzL1drMytZbnFU?=
 =?utf-8?B?VE9TL3QzMnRnSWU4dFVVSWhrKzczeE5jVmVSMld4S1pkOUxlM011Ti9IdFhv?=
 =?utf-8?B?a2xtS2gyMzdHb2p3OFBXYm9ZUlRhSFRNMzZuZDZGd0tPR0xlc0huZ2x0UFpU?=
 =?utf-8?Q?rc9JGg4YRGE8YEK+f0j/+UsPvh+rdoW/NYeew?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A5E8862CA2C7E4F8F298165BADFAA78@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656c1103-43c9-4dd3-7f71-08de7b0de834
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 23:21:19.3421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGrWVWgaFmxZAkOiO+rIgSdPx+kY96r0JxnO75k3ZwAfmwYXS6IwN9BL6pQx3sWihYXtejgQrjQtD+opg1bVvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4237
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 28fSf1pqvTAv9fRnBJk_gUzlH_cJdfie
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69aa0ff1 cx=c_pps
 a=rV7DuXtNeKhYS0+Ag8nf3Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=aFIx6uq9AAAA:20 a=mhbryFDTQEXlzcs6hC8A:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE5OSBTYWx0ZWRfXxQf9Hg+mjDTe
 Y02sfCzK4vyNRdD1A8Dggaa26A3TFhJBkZzjWxcXI/U0UNDAWIpYlVXgXfawU9Y155vzyHE9udi
 siwpC5Yc187xTpKBW2OnLrsl1RjG7JoAgjjrfqjyoPzX/teVD5KYHWlKtw+8isjEATTw8Qgy8xH
 goFnJJC8fSAqq5Rw+EpGx85Nd90XhIS1jT7hXzgjMXAxRxE2TSavCiFew3oJorknvkYt8AODh+M
 D+UJI7WvDveK/YFo0ztGIz9dZr3zVI1K29+JRb1wBtNhLIMVj5cDFbe+VJuaZL0g9LUG+T0KhLz
 2EigS4ZcJ+dkJKp6Si/toBYF+Ud7seE6SUnrq6LYd5oxzn3mNC1LYbE/pUxN+69xl1PMKyGp2fU
 DXZMYawbd32ACuh6fnrrhBBEtZyGqZuRC0AqK2q3uHhMsm9OeK4jKhmH5u2/ofvHUVa8/4YCUc9
 q6jMr0RlazUEYRxQWlg==
X-Proofpoint-GUID: FW8J8eUM1RKnZniQl5JM5TqhwtzWiIre
Subject: RE: [PATCH] hfsplus: limit sb_maxbytes to partition size
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050199
X-Rspamd-Queue-Id: 467152193C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-79524-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proofpoint.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAzLTA1IGF0IDEwOjUyICswOTAwLCBIeXVuY2h1bCBMZWUgd3JvdGU6DQo+
ID4gPiANCj4gPiA+IFNvcnJ5IGl0J3MgZ2VuZXJpYy8yODUsIG5vdCBnZW5lcmljLzI2OC4NCj4g
PiA+IGluIGdlbmVyaWMvMjg1LCB0aGVyZSBpcyBhIHRlc3QgdGhhdCBjcmVhdGVzIGEgaG9sZSBl
eGNlZWRpbmcgdGhlIGJsb2NrDQo+ID4gPiBzaXplIGFuZCBhcHBlbmRzIHNtYWxsIGRhdGEgdG8g
dGhlIGZpbGUuIGhmc3BsdXMgZmFpbHMgYmVjYXVzZSBpdCBmaWxscw0KPiA+ID4gdGhlIGJsb2Nr
IGRldmljZSBhbmQgcmV0dXJucyBFTk9TUEMuIEhvd2V2ZXIgaWYgaXQgcmV0dXJucyBFRkJJRw0K
PiA+ID4gaW5zdGVhZCwgdGhlIHRlc3QgaXMgc2tpcHBlZC4NCj4gPiA+IA0KPiA+ID4gRm9yIHdy
aXRlcyBsaWtlIHhmc19pbyAtYyAicHdyaXRlIDh0IDUxMiIsIHNob3VsZCBmb3BzLT53cml0ZV9p
dGVyDQo+ID4gPiByZXR1cm5zIEVOT1NQQywgb3Igd291bGQgaXQgYmUgYmV0dGVyIHRvIHJldHVy
biBFRkJJRz8NCj4gPiA+ID4gDQo+ID4gDQo+ID4gQ3VycmVudCBoZnNwbHVzX2ZpbGVfZXh0ZW5k
KCkgaW1wbGVtZW50YXRpb24gZG9lc24ndCBzdXBwb3J0IGhvbGVzLiBJIGFzc3VtZSB5b3UNCj4g
PiBtZWFuIHRoaXMgY29kZSBbMV06DQo+ID4gDQo+ID4gICAgICAgICBsZW4gPSBoaXAtPmNsdW1w
X2Jsb2NrczsNCj4gPiAgICAgICAgIHN0YXJ0ID0gaGZzcGx1c19ibG9ja19hbGxvY2F0ZShzYiwg
c2JpLT50b3RhbF9ibG9ja3MsIGdvYWwsICZsZW4pOw0KPiA+ICAgICAgICAgaWYgKHN0YXJ0ID49
IHNiaS0+dG90YWxfYmxvY2tzKSB7DQo+ID4gICAgICAgICAgICAgICAgIHN0YXJ0ID0gaGZzcGx1
c19ibG9ja19hbGxvY2F0ZShzYiwgZ29hbCwgMCwgJmxlbik7DQo+ID4gICAgICAgICAgICAgICAg
IGlmIChzdGFydCA+PSBnb2FsKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmVzID0g
LUVOT1NQQzsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiAgICAg
ICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgfQ0KPiA+IA0KPiA+IEFtIEkgY29ycmVjdD8NCj4g
PiANCj4gWWVzLA0KPiANCj4gaGZzcGx1c193cml0ZV9iZWdpbigpDQo+ICAgY29udF93cml0ZV9i
ZWdpbigpDQo+ICAgICBjb250X2V4cGFuZF96ZXJvKCkNCj4gDQo+IDEpIHhmc19pbyAtYyAicHdy
aXRlIDh0IDUxMiINCj4gMikgaGZzcGx1c19iZWdpbl93cml0ZSgpIGlzIGNhbGxlZCB3aXRoIG9m
ZnNldCAyXjQzIGFuZCBsZW5ndGggNTEyDQo+IDMpIGNvbnRfZXhwYW5kX3plcm8oKSBhbGxvY2F0
ZXMgYW5kIHplcm9lcyBvdXQgb25lIGJsb2NrIHJlcGVhdGVkbHkNCj4gZm9yIHRoZSByYW5nZQ0K
PiAwIHRvIDJeNDMgLSAxLiBUbyBhY2hpZXZlIHRoaXMsIGhmc3BsdXNfd3JpdGVfYmVnaW4oKSBp
cyBjYWxsZWQgcmVwZWF0ZWRseS4NCj4gNCkgaGZzcGx1c193cml0ZV9iZWdpbigpIGFsbG9jYXRl
cyBvbmUgYmxvY2sgdGhyb3VnaCBoZnNwbHVzX2dldF9ibG9jaygpID0+DQo+IGhmc3BsdXNfZmls
ZV9leHRlbmQoKQ0KDQpJIHRoaW5rIHdlIGNhbiBjb25zaWRlciB0aGVzZSBkaXJlY3Rpb25zOg0K
DQooMSkgQ3VycmVudGx5LCBIRlMrIGNvZGUgZG9lc24ndCBzdXBwb3J0IGhvbGVzLiBTbywgaXQg
bWVhbnMgdGhhdA0KaGZzcGx1c193cml0ZV9iZWdpbigpIGNhbiBjaGVjayBwb3MgdmFyaWFibGUg
YW5kIGlfc2l6ZV9yZWFkKGlub2RlKS4gSWYgcG9zIGlzDQpiaWdnZXIgdGhhbiBpX3NpemVfcmVh
ZChpbm9kZSksIHRoZW4gaGZzcGx1c19maWxlX2V4dGVuZCgpIHdpbGwgcmVqZWN0IHN1Y2gNCnJl
cXVlc3QuIFNvLCB3ZSBjYW4gcmV0dXJuIGVycm9yIGNvZGUgKHByb2JhYmx5LCAtRUZCSUcpIGZv
ciB0aGlzIGNhc2Ugd2l0aG91dA0KY2FsbGluZyBoZnNwbHVzX2ZpbGVfZXh0ZW5kKCkuIEJ1dCwg
ZnJvbSBhbm90aGVyIHBvaW50IG9mIHZpZXcsIG1heWJlLA0KaGZzcGx1c19maWxlX2V4dGVuZCgp
IGNvdWxkIGJlIG9uZSBwbGFjZSBmb3IgdGhpcyBjaGVjay4gRG9lcyBpdCBtYWtlIHNlbnNlPw0K
DQooMikgSSB0aGluayB0aGF0IGhmc3BsdXNfZmlsZV9leHRlbmQoKSBjb3VsZCB0cmVhdCBob2xl
IG9yIGFic2VuY2Ugb2YgZnJlZQ0KYmxvY2tzIGxpa2UgLUVOT1NQQy4gUHJvYmFibHksIHdlIGNh
biBjaGFuZ2UgdGhlIGVycm9yIGNvZGUgZnJvbSAtRU5PU1BDIHRvIC0NCkVGQklHIGluIGhmc3Bs
dXNfd3JpdGVfYmVnaW4oKS4gV2hhdCBkbyB5b3UgdGhpbms/DQoNCj4gDQo+ID4gRG8geW91IG1l
YW4gdGhhdCBjYWxsaW5nIGxvZ2ljIGV4cGVjdHMgLUVGQklHPyBQb3RlbnRpYWxseSwgaWYgd2Ug
dHJpZXMgdG8NCj4gPiBleHRlbmQgdGhlIGZpbGUsIHRoZW4gLUVGQklHIGNvdWxkIGJlIG1vcmUg
YXBwcm9wcmlhdGUuIEJ1dCBpdCBuZWVkcyB0byBjaGVjaw0KPiA+IHRoZSB3aG9sZSBjYWxsIHRy
YWNlLg0KPiANCj4gZ2VuZXJpYy8yODUgY3JlYXRlcyBhIGhvbGUgYnkgcHdyaXRlIGF0IG9mZnNl
dCAyXjQzICsgQCBhbmQgaGFuZGxlIHRoZQ0KPiBlcnJvciBhcyBmb2xsb3c6DQo+IGh0dHBzOi8v
dXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0aHViLmNvbV9r
ZGF2ZV94ZnN0ZXN0c19ibG9iX21hc3Rlcl9zcmNfc2Vlay01RnNhbml0eS01RnRlc3QuYy0yM0wy
NzEmZD1Ed0lGYVEmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9S
R21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZtPTg0UzhEWnlxbGdjSkEwdXpYVlBZRC1jdmRvbmh2
eWk1a01XYWtsS2ROakQ4b3RwLWR2dEhYdUwyTzJDcmlkRlYmcz02aklfQVFDZHVvNVRpbThpb0k1
VjhYeTUwamd1Q0xVVHgxQ1NGRUZfX0QwJmU9IA0KPiANCj4gaWYgKGVycm5vID09IEVGQklHKSB7
DQo+ICAgZnByaW50ZihzdGRvdXQsICJUZXN0IHNraXBwZWQgYXMgZnMgZG9lc24ndCBzdXBwb3J0
IHNvIGxhcmdlIGZpbGVzLlxuIik7DQo+ICAgcmV0ID0gMA0KPiANCg0KSSBiZWxpZXZlIHdlIG5l
ZWQgZm9sbG93IHRvIHN5c3RlbSBjYWxsIGRvY3VtZW50YXRpb24gYnV0IG5vdCB3aGF0IHNvbWUN
CnBhcnRpY3VsYXIgc2NyaXB0IGV4cGVjdHMgdG8gc2VlLiA6KSBCdXQgLUVGQklHIHNvdW5kcyBs
aWtlIHJlYXNvbmFibGUgZXJyb3INCmNvZGUuDQoNClRoYW5rcywNClNsYXZhLg0KDQo+IA0K

