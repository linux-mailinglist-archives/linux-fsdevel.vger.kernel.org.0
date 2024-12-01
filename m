Return-Path: <linux-fsdevel+bounces-36209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4079DF67E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 17:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CA6B215C2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E06C1D6DA5;
	Sun,  1 Dec 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NF89ZB3P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xjgxi3ry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F308DAD23;
	Sun,  1 Dec 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733070149; cv=fail; b=moyD6LRJk0VRPvpsVdM4neSyV6hnohLBUL3tGOvhim6Mf8unkOEoaZW/Bdyc9lbqbKYxAFYd+jhyWIxKK7Sb/fFvIkeKgqqtYLu98HKGkbc6VzxOu4xfIgj81wVH6lg7BD47vjTQtp99YcynvScg04W89J76voQ1aWuVVf0UHZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733070149; c=relaxed/simple;
	bh=KBMWaCPee7D4SYDtuEqTfiK3LlUwHuq+KpOTMrZEmU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NHF8CtQc1oPmMisuV6zKgmeUvwCNGQ+yY7zccOMYM2SO1Xa0JeKVmFjzIjpPj8odPNgmGDvUwlRuvcXvfv5OfNHaapwZsQMLj7d9FnzL1iZh9S55KwwnCk4199eHB/odN9kerbV9DUQjG8ORmWz2t5GKnn5NOmNwycw0pkvmOYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NF89ZB3P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xjgxi3ry; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1CwQrQ029894;
	Sun, 1 Dec 2024 16:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KBMWaCPee7D4SYDtuEqTfiK3LlUwHuq+KpOTMrZEmU4=; b=
	NF89ZB3PuezjL6O29AyQr2dOOMk9J2cA8KCjNDTaZEjRgjNFWTZYbbakaj2WYWV1
	GrvtdSoNoRdYPOBf3AVrYzIrkf+g2DWLWN3a+/H95DcFmryBrTm+JWl14jYlqwoR
	4AuWVCSYPoChvzj5vGN5ddMfA88KjbLQfQ95qSJHUJ0p6wEuzPWIft2QdNbt8Kl2
	C1Hk2s4lIhXfylK+T0biScRGzU8XegNsot6kjafguAGo7OgeoiVq0jjXQ6Rn0ycy
	2LdS1EhufIpCbk+2w46D3PaM2QU6RZyCp5cHrmnTcm3M6IFAEkJp5exi/zn+Fgpk
	E3Agsk/OzVW2OIYVKbSBEQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas1n4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 01 Dec 2024 16:22:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1DPBs2037152;
	Sun, 1 Dec 2024 16:22:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s562213-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 01 Dec 2024 16:22:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0KztIRmt7wkauIM5sRc2/hvboSt3KwdYodB8KsKPuEAJhDk39e9wK+zhqGa13wAL/RzO5HFMfqoaOj4ovLn1ANReaMiwfORB7ye/UgxoamzETgau7bu0nJWsqUCeWqIIiam73qT+Dk58KdLmT1ZNbcOe8KuR0JnrazhMUOIItwRf2t8LuQjGfGTjqtSCuPrHDA2aIDMxSRA8qe++562oMvPsv76BFTWv1SyvaD1/BQn3ZIaa3wGs7lSqH6MfNyl6Tdk+CI2b5uJ6+XHqCx7uaPRK3Cs6mWCojwhKQ8FB9s6aL1+K7GZSccBsTBM3ZGEUBFcMPH+j5dmIDwjLYjVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBMWaCPee7D4SYDtuEqTfiK3LlUwHuq+KpOTMrZEmU4=;
 b=Lilz1FeXQZkNzNEDhWqiPWKAVD4H0Z7nhCsOcKYumA6vq718osL/vg5MpzjzV7uxGNYz1QwIZA4h7/gymjo6o6bqJQIOqgFJtliryG8SUEPQ8GxdFKAy91o1s5Z1rcUznGwnprvZg7bWi0/QXYmXV6UnYrXvnLhqNctQsdhKa/Q2dlyz2iJwIZh5Xw9buwxrkfZHUYNsO2cwRvaEFjb49BfaImFLHalOFK5lN3dsrxCE/G+Z4Kd47jXA90nTmmfE75u2gJjIrsXGUXuY3JD0edGEJHPmSv2VC0FwKC39yZFKUcPz+ompf9/L11M5Q6DnoJr9sPrDRplCvaEx9U+w6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBMWaCPee7D4SYDtuEqTfiK3LlUwHuq+KpOTMrZEmU4=;
 b=Xjgxi3ry5NnokC7Z7SD+8Cpjk1K8FHIrppbJifLfqJY1LhTmVVb8FPiLWQUNnAyNj2f8/LZJeAxGNu9y2eHuMOs9NP84QeVtQDhRVKWTpQI62I7XsdavksTYwQR3L6hv+YeANNLYEtE/zlxEfe5tPKrvkFTtjtFe3T/ibg//1wg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6128.namprd10.prod.outlook.com (2603:10b6:8:c4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.16; Sun, 1 Dec 2024 16:22:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8207.017; Sun, 1 Dec 2024
 16:22:03 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>
CC: Amir Goldstein <amir73il@gmail.com>, Erin Shepherd <erin.shepherd@e43.eu>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        stable <stable@kernel.org>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export operations
 as only supporting file handles
Thread-Topic: [PATCH 0/4] exportfs: add flag to allow marking export
 operations as only supporting file handles
Thread-Index: AQHbQ/K6WHLxloboXkSYiRVdFU2Yf7LRYc+AgAAwjQA=
Date: Sun, 1 Dec 2024 16:22:03 +0000
Message-ID: <2F18FF7D-5AC9-4EE4-A19A-F016CF5B1971@oracle.com>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <0974893ac7d97cc709ffa7df52fb5e0b7f502a4c.camel@kernel.org>
In-Reply-To: <0974893ac7d97cc709ffa7df52fb5e0b7f502a4c.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6128:EE_
x-ms-office365-filtering-correlation-id: f0ae8664-1be1-452f-745b-08dd12244ac0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDJZcGVyZ1Q2QnVGc053UGFaTytsRjF4dUxqYUR3ajlGS2kvZTRZbmdSTW9v?=
 =?utf-8?B?bDNzb3YrR2JJQk1mejVSMnM4NDFXRDNnMWJaRjFCYzM4RFQ5cDFZejVtTFI5?=
 =?utf-8?B?dEJGS1Y1MmVML3l2bngrQ0RZT2R5YkdCYlc1YlhlOVBmV2FHTFdTVDlncEo5?=
 =?utf-8?B?Qi9ZZ2tqUVVBV0ZZWm1IT2tuVXZHdEo2bTlsN0lxOHliN1JPeDVMSDQ1VmFP?=
 =?utf-8?B?R1QyVkEyNzVJcUxYYnQ4VWpOaVRNVzVpL3N6RThWR2c1U2tuUEhESWhRZEV5?=
 =?utf-8?B?MkZHRm5pb2QvYUFPN21kNC80a0IwZnRUYmd6R2pQUGRWWGN0Y3pSdW0wSTcv?=
 =?utf-8?B?UHRwOE9jb1YwY29BTVJhTXNrbU15T3U3OVlBUFU4Y284QzFOeDJrb2RqTlJQ?=
 =?utf-8?B?VzA1blNLNmdhMTd2ZzNrQ09MR0dIN3NLRTdobldIWFVjS2xIbXdTQjAxTzRH?=
 =?utf-8?B?dlp5TjZRblRZVHJUa3E4OGdJV3p6YVd1akxjNU9QSmlKc3FaT2JYbFBLeTJx?=
 =?utf-8?B?S0ZSMVhxWCtEeWQzNXliRVVNcVlPWlR1Y0UyWjdXQ0k4aDlqbW01LzlDVGI2?=
 =?utf-8?B?TnBiT0JYYVlRVGxvbG1LZXcxcGttV0k5MUNjN0lKdUdNdWd4ampONnlYWE4r?=
 =?utf-8?B?cFVDaVdxdGFQWGExUG8rTVh6VERVcFdNeXQ2U0g0aXJFT0FhMGFwV09WNHBr?=
 =?utf-8?B?TTVVYkFqSjBhQVZRQ0t3WVFVbi9TYWVVVXF4TDlQSG5QN3drRC9VaUpxVGMv?=
 =?utf-8?B?ckZudDJEd3hJVEpPa3R2MTdtSjRwTld5YlljREVFaDE0aHJXYVJnbG9DK1dx?=
 =?utf-8?B?MWVUdHNYNC9tbFFOSUFGVGUyNlNHdUFjaW9pMkRSTi82ZTBkenNCR1RjeUFF?=
 =?utf-8?B?MzFJa1pjTjFNRFQ1bldJRGUvZ1ptL0ZxaGV2Y1dSejllaFdTYVNVaCt3QXc3?=
 =?utf-8?B?b3pLczlpTm1rdnArbEJnMERmcHAwdzc2Q1RaL21uU0hKZDhpSmxydkJQaHJN?=
 =?utf-8?B?Wjc0ZC9BOEt5Q3Avc3pwcHpCVGV1WTQ4OGFndk5GNkxDVEJ2UjgyVmg5SXlo?=
 =?utf-8?B?V0xyZFZpMXRiV2hqekRJaWpsakpsc241MEFSR3pHSUgvSE9jVndVRzBLcWwr?=
 =?utf-8?B?YzZLZFNJbFMxaDVDeHMvcEJ4M0YzekUybC9WK2tSVGt0b1dmMytPN2ZRalRG?=
 =?utf-8?B?b0tPY3JkUVl0a0QyZWhVWXJ1VnYxYVc5K05vNDBNLzFvTDR5NGs0TnBMRXBD?=
 =?utf-8?B?WUxLTDFBaGcwNWR4RTRhMWIzNWl4ZXhQYldlZUFRaS9DVW5HaEdmdGFQdzVV?=
 =?utf-8?B?US9LVStXVUFrdllERGF5dnFhYUwxUE1OODF2T09lc2k0ZEVwZzJsQ3NnKzNN?=
 =?utf-8?B?eDUzYUtxQWVpazFiSzVNUi9kLytZVUIvYUNmQzNWS1FQMEw5UFpROU9tZlVG?=
 =?utf-8?B?NjdrYWhHeEJodGRkM3dWdXFDUTBnczJya0w4M3NyQklreVp4YnRSREJ6djNZ?=
 =?utf-8?B?Wm83Sm02Q210WnBVVEt3VFpLQ1BveUljSUIyYTk5dGdLQ2dPcEZLeVBlUW9H?=
 =?utf-8?B?ZDVDL0ZWVUhVN0tYUk5pc250NUZudHlpWVBpbXJCUVZCZjJ3RXFtVjk4ME5Z?=
 =?utf-8?B?MGQraWRpZ0dYcUc4Y0JUUDB1dDcxOTlYQVNyU2ZDRU9oc0xua0R1ZVNCdXRV?=
 =?utf-8?B?MzVMczBTRzNZakNNNS84bWpvMGpTeFVVWmM0RldKRXI5WEFlSkFTWHQyUjMy?=
 =?utf-8?B?YWd2aTZ4TGFMSkcxTkVPRjFMNHlqWlpwN280MUpHVnMvVi9ReFVNVldPL0po?=
 =?utf-8?B?UWt3ZmE1c2tYeWxVU3NMckhLTWhqOU1RYlRCaC81T1JWNEVLN2UvRXFLaldK?=
 =?utf-8?B?aVN1b3IxZEZLQVJtYWZKclVCWHBkallsRytjQzU3UmZjS1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXk2dzlCbmFLUS9WL0d6NWs5SjZNN1JyQTNtdjhiU1kwdnVuOU1LaTFKZ0Mv?=
 =?utf-8?B?eVpvamVzdWpwTGJOV0pucDcrUUQwTEh0YjE0ZExOSWcrTmxLQjZTTDFyK3hm?=
 =?utf-8?B?SGFJa05oNThRTnpPT2Zad3N5VWNkRTVYeXhvSTZyQUMvaEtpV1NoZ3dxNC9E?=
 =?utf-8?B?OTgzU0RKYzB1QXVuUTZLQzUrU1pkU0JoaCtHaEZaYzQ1bkxmQUdKeHVRcGx1?=
 =?utf-8?B?Z3VRQTVYZzU0WXZseHdCZlhWV1B2emthSjc0aVoxYUwvcW8rejQzTmJ5SC80?=
 =?utf-8?B?MGZyNFhvTWJrMWxKMFNhbmpna2M4emwvWWtUenFCRHA1cUhnNTJGZmp2dC93?=
 =?utf-8?B?dmtHV0VsVzNyRUxBZkdnejdpYWEzSjJPU2UrM09pcms3S3Y1NWtXSkdqS0tX?=
 =?utf-8?B?cU1WYndnTDNmU1NKa1Q1eFB3bDRQNXBDTC9NTkxmcEt1dzBBbTdhZFhvd3dw?=
 =?utf-8?B?QlVTQXBQTWkzTEN1cHZ6cGdCSnBhbEQ0QlE5bG9DdWNwRm0zU0o3VmRkOTlk?=
 =?utf-8?B?dE41YUpMSFVkVmVtdkY4VmdUaEhTRytjV255cDdURkRGcVpiZ0NnMnZKV1dF?=
 =?utf-8?B?K3VyVlVOUWRQajhGdDk1ZUVyVXJUR0gyRWlZbzBoMUxUYTU5TzFkNjZ1TmRp?=
 =?utf-8?B?MWJCMmxBU3NqL1doUGNSa2pZOFp4blBmRUFaY3lRYjh0RkpnWTF4VEJaSEtr?=
 =?utf-8?B?WFQ1MGdmb2dqaWJqdEtaMVhVaE9iWWFISkl6aXYzaDI2WVU5UnozNGtsY1lG?=
 =?utf-8?B?YTI2MzhoVXRHdEpIUHhyZ1JXVjE3R0JrOEVwQm1UaVUxRlA3TEk5RS8zS3Bq?=
 =?utf-8?B?TDdHTm84Sk1jU1hjYTY0aDdyajBVMnRwQUNiYk1pYjd5akFXMm5vdVowQ1ZF?=
 =?utf-8?B?QlVVUEsxQzVDcktZZjhXcUd1cnJobzFRWmFaY2R4ODFkREh0ZXFnbDJZYnJ1?=
 =?utf-8?B?ZkcwUjV2bW5zNlVhSzhhRWh0Qncxa2hKK1U3TWlremRqQ3Z4QUo3bkxIRDVl?=
 =?utf-8?B?ZFdCc2ZFdkNLYXZTNlo3bnhRUUZoT2RpOTNtSWxEeUJXU1VmZFB4ajRTc3VC?=
 =?utf-8?B?R1dMWnlCKzZCWmZoTVJtbWhSeU1ETmN0QnUvaVA4Z2NrTGpRdTJVdDdQWko5?=
 =?utf-8?B?Zm9YSE83cE5EcitQbWE0YmpnUkJ2MTZqdExKMDg4b3ZFVDgrVEVrK3diVllv?=
 =?utf-8?B?UzBETzUwUE1USGhnRUVIWmwxa2ZJV2d0YW5JWG0xRzVNcm13V1llYXlzYmtX?=
 =?utf-8?B?NlFKUVJTbmhZOEYrbFNWZEs5YTg3RjB3OVFSOVJwTUdqc0lPZzlIN24xcjIr?=
 =?utf-8?B?Qnp3T0hJbmV0dlptQUxRcDNweFgxb3kzVERxTjFHZSs4WEI1UWRrM2wwbzFn?=
 =?utf-8?B?YTdpR0ZzN2hzeGFuU1hORGY5VVZCTUhObW5SMEtDSEVreUtyemdPL2FQYzFB?=
 =?utf-8?B?Z3pFWnhJbUM4dVR0VFpEbkFFVTZyM2JjM1NOajhiNjNWeHAxT0sxcnZQYXpZ?=
 =?utf-8?B?c2pqYkhxQUM5MVJpQy9XM29aaWdtcnJaUDJuQnd0cXFTTytuYzRQblZUc0JC?=
 =?utf-8?B?SzdUVmFVMnpSYy9YemNJRHhTdXo5bDJmOHpST0RtbzBSR1ozYngrYVp5SjV1?=
 =?utf-8?B?dzdraXU3bVkxS0xxNXUvWkVmaDh4NGVFbTJ4U1Nta2RwNlVIOGJQZGF2ZnZ5?=
 =?utf-8?B?QUlWaGc4LzVwSG82MmkyYW5teVdocHBjN3h6R0dGdlJrQUFXRi96NkxzMUNy?=
 =?utf-8?B?WFRpMFI0S1hnOHFuajRMMlBpQ1JtTUl1dDVINDBXeC9EUFRHM1dKQVJhS1Ru?=
 =?utf-8?B?N2R3VktjcG1EWGhEckJ0cTkyek1EOEcva2ppQzRHVmJVSnRncFU1N0NlYldV?=
 =?utf-8?B?K1ZvWDY2QUNpNVhhSjZvZjVMY2xORmR0b1lRM3MzZWY1UjdiaXNlTUxhUnZx?=
 =?utf-8?B?ZjlCejhHdHdQZDVNNWpNNXAveHVGL0FJTk5DTXFaVnJqSk9udVRiSTIwU0t5?=
 =?utf-8?B?UVpxQVFQZXdLN3FoK0hkZE54cmRUZnpyWm9OWVVHbm5tV2ZtS3ZEQUhwR1JK?=
 =?utf-8?B?YlpmbElVelBWZlNyODRGTXFXbllZRVc1UG9Fc0tzRTZkYk4zRjljci9ZWlJQ?=
 =?utf-8?B?TkZ3MjNlWko0WjJjYlpYcnpnWVZrZmkzeW9GMGpjZmJ2VEwweW9sMW02S3J6?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9889C753FB83EE468740B84DA2C1DEA3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3S3G2ohyqE6BDWeJqVBVIJoszXvx5GNxlCrErqRBouW4WsiI+g2AzCGKZyb3HXi6BI9kkuFJpHKc0spZ9lzUcNxMQViQFbl+zpe2mUgpxQyrDeOE3hsSObL61uom7LHi5AQ4PHvnzlpFqkkjJHNevkouvbm3Ca3rDAUUpR1XN5NIAd/1DKE+c+9awd1eORO+38Xr6S+trV/XYVI+baLXmSjPTQ1RH67CIEvlMf6SIaqiBJSuWjBGf3y5EfKXaS4lCXsDnzSutUJM1e/Y6xrKSBXOrYdiA9UKkKSPYjd+gHzviPhIsg2Wz2fUO0h3PC5uAYl/Z8aWBpX7KGebSQ6FPPgS1ulooUziQky8O+lWntBizHLpKgq+YGDF+7PPFRaUTgrZ1u7Xn00/iO1Nkc0YDDYTqUirG8KW4m3HXyxiW/QjoLLPtCu7dU2Zuj6H/8fIUyjDxLGTWHixFuKppiIyKWo4KKJVQL7VDkZXC9NyOQyObSa66dvgp8rMayDqdxYKmwo0yi6xuWno99WBmXsvwkj/RiqyuMGGMR9Ym0KHpsXlrZh6m/RKWvk33DH8hLeqi+6pjJHUoYuHUQ9rcnu8fcl717s6PuJM/9p1dYdNHdA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ae8664-1be1-452f-745b-08dd12244ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2024 16:22:03.8178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9Y99gywpiLUVU4A8LBg5byfIypQ1GQb5gYhi1lttyt3S11UGZLlfIhcXrL/msKowui3/C/HhdoOqghwIkGQ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-01_14,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412010139
X-Proofpoint-GUID: O6p75xa7QVY5xyKih0--fMGsMsYlcDYt
X-Proofpoint-ORIG-GUID: O6p75xa7QVY5xyKih0--fMGsMsYlcDYt

DQoNCj4gT24gRGVjIDEsIDIwMjQsIGF0IDg6MjjigK9BTSwgSmVmZiBMYXl0b24gPGpsYXl0b25A
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBTdW4sIDIwMjQtMTItMDEgYXQgMTQ6MTIgKzAx
MDAsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPj4gSGV5LA0KPj4gDQo+PiBTb21lIGZpbGVz
eXN0ZW1zIGxpa2Uga2VybmZzIGFuZCBwaWRmcyBzdXBwb3J0IGZpbGUgaGFuZGxlcyBhcyBhDQo+
PiBjb252ZW5pZW5jZSB0byBlbmFibGUgdGhlIHVzZSBvZiBuYW1lX3RvX2hhbmRsZV9hdCgyKSBh
bmQNCj4+IG9wZW5fYnlfaGFuZGxlX2F0KDIpIGJ1dCBkb24ndCB3YW50IHRvIGFuZCBjYW5ub3Qg
YmUgcmVsaWFibHkgZXhwb3J0ZWQuDQo+PiBBZGQgYSBmbGFnIHRoYXQgYWxsb3dzIHRoZW0gdG8g
bWFyayB0aGVpciBleHBvcnQgb3BlcmF0aW9ucyBhY2NvcmRpbmdseQ0KPj4gYW5kIG1ha2UgTkZT
IGNoZWNrIGZvciBpdHMgcHJlc2VuY2UuDQo+PiANCj4+IEBBbWlyLCBJJ2xsIHJlb3JkZXIgdGhl
IHBhdGNoZXMgc3VjaCB0aGF0IHRoaXMgc2VyaWVzIGNvbWVzIHByaW9yIHRvIHRoZQ0KPj4gcGlk
ZnMgZmlsZSBoYW5kbGUgc2VyaWVzLiBEb2luZyBpdCB0aGF0IHdheSB3aWxsIG1lYW4gdGhhdCB0
aGVyZSdzIG5ldmVyDQo+PiBhIHN0YXRlIHdoZXJlIHBpZGZzIHN1cHBvcnRzIGZpbGUgaGFuZGxl
cyB3aGlsZSBhbHNvIGJlaW5nIGV4cG9ydGFibGUuDQo+PiBJdCdzIHByb2JhYmx5IG5vdCBhIGJp
ZyBkZWFsIGJ1dCBpdCdzIGRlZmluaXRlbHkgY2xlYW5lci4gSXQgYWxzbyBtZWFucw0KPj4gdGhl
IGxhc3QgcGF0Y2ggaW4gdGhpcyBzZXJpZXMgdG8gbWFyayBwaWRmcyBhcyBub24tZXhwb3J0YWJs
ZSBjYW4gYmUNCj4+IGRyb3BwZWQuIEluc3RlYWQgcGlkZnMgZXhwb3J0IG9wZXJhdGlvbnMgd2ls
bCBiZSBtYXJrZWQgYXMNCj4+IG5vbi1leHBvcnRhYmxlIGluIHRoZSBwYXRjaCB0aGF0IHRoZXkg
YXJlIGFkZGVkIGluLg0KPj4gDQo+PiBUaGFua3MhDQo+PiBDaHJpc3RpYW4NCj4+IA0KPj4gLS0t
DQo+PiBDaHJpc3RpYW4gQnJhdW5lciAoNCk6DQo+PiAgICAgIGV4cG9ydGZzOiBhZGQgZmxhZyB0
byBpbmRpY2F0ZSBsb2NhbCBmaWxlIGhhbmRsZXMNCj4+ICAgICAga2VybmZzOiByZXN0cmljdCB0
byBsb2NhbCBmaWxlIGhhbmRsZXMNCj4+ICAgICAgb3ZsOiByZXN0cmljdCB0byBleHBvcnRhYmxl
IGZpbGUgaGFuZGxlcw0KPj4gICAgICBwaWRmczogcmVzdHJpY3QgdG8gbG9jYWwgZmlsZSBoYW5k
bGVzDQo+PiANCj4+IGZzL2tlcm5mcy9tb3VudC5jICAgICAgICB8IDEgKw0KPj4gZnMvbmZzZC9l
eHBvcnQuYyAgICAgICAgIHwgOCArKysrKysrLQ0KPj4gZnMvb3ZlcmxheWZzL3V0aWwuYyAgICAg
IHwgNyArKysrKystDQo+PiBmcy9waWRmcy5jICAgICAgICAgICAgICAgfCAxICsNCj4+IGluY2x1
ZGUvbGludXgvZXhwb3J0ZnMuaCB8IDEgKw0KPj4gNSBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4gLS0tDQo+PiBiYXNlLWNvbW1pdDogNzRlMjBjNTk0
NmFiM2Y4YWQ5NTllYTM0ZjYzZjIxZTE1N2QzZWJhZQ0KPj4gY2hhbmdlLWlkOiAyMDI0MTIwMS13
b3JrLWV4cG9ydGZzLWNkNDliZWU3NzNjNQ0KPj4gDQo+IA0KPiBJJ3ZlIGJlZW4gZm9sbG93aW5n
IHRoZSBwaWRmcyBmaWxlaGFuZGxlIGRpc2N1c3Npb24gYW5kIHRoaXMgaXMgZXhhY3RseQ0KPiB3
aGF0IEkgd2FzIHRoaW5raW5nIHdlIG5lZWRlZDogYSB3YXkgdG8gZXhwbGljaXRseSBsYWJlbCBj
ZXJ0YWluDQo+IGZzdHlwZXMgYXMgdW5leHBvcnRhYmxlIHZpYSBuZnNkLg0KPiANCj4gUmV2aWV3
ZWQtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+IA0KDQpBY2tlZC1ieTog
Q2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20gPG1haWx0bzpjaHVjay5sZXZlckBv
cmFjbGUuY29tPj4NCg0KVGhvdWdoLCBJIHdvbmRlciBpZiBhIHNpbWlsYXIgYnV0IHNlcGFyYXRl
IHByb2hpYml0aW9uDQptZWNoYW5pc20gbWlnaHQgYmUgbmVjZXNzYXJ5IGZvciBvdGhlciBpbi1r
ZXJuZWwgbmV0d29yaw0KZmlsZSBzeXN0ZW0gc2VydmVyIGltcGxlbWVudGF0aW9ucyAoZWcsIGtz
bWJkKS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

