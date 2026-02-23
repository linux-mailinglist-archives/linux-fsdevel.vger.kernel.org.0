Return-Path: <linux-fsdevel+bounces-77995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iACyEI+jnGnqJgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:59:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F2917BF1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 087BC302DF4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6BD36A009;
	Mon, 23 Feb 2026 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tMTUk7wy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675336A011;
	Mon, 23 Feb 2026 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873148; cv=fail; b=OebVkU8M0JzfwY2G8w4FXwlaI+xeTiEJ43+Hcdh3GnjK2fM59aS9tgLeUZv78464yJRBj1vsnscuxlClycNtRbBJ5EPyrOegKH2ATobxTy0J+LdOibnYmEvdNpjxwP0gTpvz9Oc+dAMX2Po8sQdPrwcYANnXVEOEuSCzJ/TsCfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873148; c=relaxed/simple;
	bh=gNaVvQofj+XmZ94SR4azvQyCcTEu9ikRUpLSqA8fVTU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=mk4h6UQ0ZiU3m4JPcOLxsRLTUcalUR8+kMypxx0D3IKS3TGbTJ5Mth3AJ878c/v5jWJyLaoVgK8AdKvj9KWBFHUGSIA1hmNkQ4GwgX7RmZRkiNFIju3JadxYjD74vR5O1p8QsM2rKUsFkgMMvSAlAsqm2Ugg1VriJ6jWxQ1T75g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tMTUk7wy; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NDLWjV2089891;
	Mon, 23 Feb 2026 18:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=gNaVvQofj+XmZ94SR4azvQyCcTEu9ikRUpLSqA8fVTU=; b=tMTUk7wy
	Sq3RkRvs20WY5THu9s6nmkOtVfM60ySka8bDQ+ezImPNOUCXKUKPtIXv50bIR1Hi
	lhJfMNXmmaICifpashC3Fl3KYKchup4TvDNGpCwUsSn8VV3/FTp+8BL2qF8ECBPZ
	PBMxmLozhyzoqRYQ9uIZNJb6rh2h7vcbJC7npO/X9an7kx94vXcYZ3bCPPqe/x9J
	WAtiPBMVTOK8aXd6Pe3Wc5mg5Tqo2RRqV9xoC3n/CXKDhN8Fc14eHrggXSrIP4f3
	IOxJzTNFS2Kp5qiQmrFNn4EFFZqCLhLBJwlAj0zD1IfPoDtAPO9YM56J/TYYhe7v
	3fLNnIkTu/371g==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cqre9n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 18:58:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFXllmPci7/+ul2kM4NidhmqBYH91Yu+AXx/qzteX+7Say73bZYXqFN0yVQP8A4rfpbtpjurPqNlHjI7zVxS0jMFqVpdB8DzM+vR97XrRtWF5Q1QYj925jRTZL7MHtC1DQ7MSXwx3LulW0yqNXgxTt1Ws7yI0zCPTIF5JxojuLcW8eqrl9nJ+V2Pb1vZtk1/hGKP79TUHAnvWRhw9FGOqcpu5+x8J2PBDncAYToQBmB1rl8wr2PhSNa0GQi/HcrqLzPgnF977mRcBIML4BPhe4uNHPoOMv0b7y2MnIa7Q+eHz/Iub1g2WA449cFtsqSQZrJqRherIO4Tg+zkJ03kFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNaVvQofj+XmZ94SR4azvQyCcTEu9ikRUpLSqA8fVTU=;
 b=n6mXi6joURehK2HtkTXaXLoxXxCRxvZWnMKEqoXLCNf49KH0TVe9J46olqQrqp7sTck2jbu7RQhsEpBIi28wsuchIgcIk0iDReBJm4fiiUAWeIHq3gXLob6tDv2a31rYhXHOS/FnWnDBnv0PTWwvnKY4zT7jEqnAAag0w6jbc9uAXkxbkautmXivwM15Q4ejN+ReCZU0dQq+s0T2LyFvZcuIzomhNvc6vf6tpGsgNQfJMTdpBzdivx4zpMlVIJetMOrTs7eKhy5bdlPTQK1zXpSM1wlO2ciwo+IeKRpv9NFxACTxjvpYjag9gl8bryiK/xHEAXqjMGuEj3A6SHSMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM4PR15MB6323.namprd15.prod.outlook.com (2603:10b6:8:185::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:58:47 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 18:58:46 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "kartikey406@gmail.com" <kartikey406@gmail.com>,
        "charmitro@posteo.net" <charmitro@posteo.net>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v5] hfsplus: fix uninit-value by validating
 catalog record size
Thread-Index: AQHcovm2BZRut4cpEEW0Yv2kmvqHlrWQpukA
Date: Mon, 23 Feb 2026 18:58:46 +0000
Message-ID: <9f5701d8b45cba21a01baf5d2ce758e3a5a4a8b9.camel@ibm.com>
References: <20260221061626.15853-1-kartikey406@gmail.com>
In-Reply-To: <20260221061626.15853-1-kartikey406@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM4PR15MB6323:EE_
x-ms-office365-filtering-correlation-id: 5e443c17-7d6b-4451-62de-08de730d929c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rk5aZnZPZWN6R2pIV2RsYmxXZkJiVkVBZTRYS2ltOFFKVm5HUmQzTmErekh1?=
 =?utf-8?B?NmdrZHFnYVV5UkRFY0dwTTVHWmphZEFONkpWc3ZxbW1pSFRuYmZwRWNvSGdu?=
 =?utf-8?B?QUVQQk45OGZ0dGhDV2tYNEhVUzJzV2hlQitPRkkzeXN1alZoSVU0RUZKbm4v?=
 =?utf-8?B?bDRKOFJheGI0MTJXVDBlY3BXYmFzbFZINDRpbnBySnVobE5rYkcyVmdMRDZm?=
 =?utf-8?B?S244c3R4Uk5OM0hRVkRFVm85VVRsbDhQT0J0YjIram5xbkRtNFd5MjJHZHRC?=
 =?utf-8?B?OG1kZmI2TFZvWXZGWUlXTnNaYXpuYjFxNGo0OENKOW1JdkZaaGVQOUd0TFMr?=
 =?utf-8?B?d01IWmpvazM3Wnc1dkYrUHVvWWdnV3NWZ3dpQWtzdlNzWE9hT20zQnlwYnlw?=
 =?utf-8?B?enpZQlVoQlRxUmI2VDZNMU9sYy9HMGwyRkVIS1FQRnR0TTJydThNSTZRYTZt?=
 =?utf-8?B?UlYvVWFKcHEzRXpWYlBGcy8rWWd5SXNqZDhxU0JwcEE3WkNmWExqQzdITzBy?=
 =?utf-8?B?bzd4bkdpZlJKSnR4cjdRUFBLNHJoczhQSUQ4Qm5LUHVXMFlNT3BORklIUUlH?=
 =?utf-8?B?MzRTb3JZVnJyd1F4cCs0UzQzMWt3UVgxcExRNGVmQmMreGRNZ2ZmZlFuRTBG?=
 =?utf-8?B?RkdjdXhFR25sQXVvN2pLdlppOFhLVGpoYjdvQ3Z1SWVobnVncXF3d3RTSE5R?=
 =?utf-8?B?a1J5b2x2dGxhdUwxZWVQVGhPRVZ1aXEyNlNpRml3eTJ4cmFRY2I4MkMwdklM?=
 =?utf-8?B?NFRwWU9oSHdpOUZidVJVSG1jbmhrQlRTVS9DNUlhMFhCQUZJL1ByTFdHK3Bn?=
 =?utf-8?B?VWpmQWdoNStSSGU1WGxtL0NXY3h4TlVXaUU0bTBGQWd5a0p5M1MyMU8yZW9W?=
 =?utf-8?B?NGgxRk1vUUNPemJLQ2VuTmJUS0JraGZMcHl1bDhDZnVpNC9RQ2xjelRMTmly?=
 =?utf-8?B?RDRvMXRKamVNODl5MGo4elNxZTd0anY2TWVxTjBwQ2REbnRWSHR3Z3hsOVBQ?=
 =?utf-8?B?OHVJTlptTzkxYnpKKzl5UXVMT3RJNTdIZHFBcEpLZlN2czAzeEMzZzg5S3Y4?=
 =?utf-8?B?bFVFeEJZVEErcUVYT2ZJUzRwUG1yNmtWRW03cko2S1JTOVVvVDFuRzh0YUR0?=
 =?utf-8?B?cWIxUmVSMUpqMmdJbEp0dVF1QVpWZDUyRmlJRjUzcXZ2SXZXUURTbDhCMWlv?=
 =?utf-8?B?eVMxWFFlM0dPcHFmQWwvOEt1dmdEbkZ0N0xNb2x6ckxmTTdZMGFYL3o3OUZG?=
 =?utf-8?B?UEtDQXRaRFdLK1p4R2xrdE92ZlNxb3lKaDd5c2hMR1hlN3daSXdPcEVYNXlq?=
 =?utf-8?B?Zk15ODZzM05sUGIzWGlGb3hQb1Zhc2Z5WlJQbFNnWmpqbzNJdEZ4ZTBwN1li?=
 =?utf-8?B?S0x5OStWVkh4dXRWKzZqVWtHMHluS0dkMXJXRDB2aE02UnNsWUFHc0JVZ1NE?=
 =?utf-8?B?VUl6WGtJc051bHBYMW41cGlXNUlQTFdoekFNbk5NRElaZGJNSS9hY3gvU0J6?=
 =?utf-8?B?bkUvZE9xNENOZFNPa2U5M211WTlLaWhHV3lyYmZxY2RxOEEra2wraFJhTWlG?=
 =?utf-8?B?cnhpYU10akhwV3Rmek9JdElZNXpyNVlEbDRMZHV5Z0tGdGVuUlFuN3hwZVBF?=
 =?utf-8?B?K01iL1FieDd6Uml2ZDhFZlp2Q0hyclQ5NmNVMHZpWE9XdnRwN1BvY2RlWXNq?=
 =?utf-8?B?WTVLUTg4WjE5L29aZTFTeEgvSHJCRWNQOWI2QjRIVXkwSElaQldkYXpTMnhi?=
 =?utf-8?B?d1JGV3J0dmJuUU9tQWpmcTg3ZStIOFNHaHZMMWRRVmdjUms0UFpnMzRScmY1?=
 =?utf-8?B?WllqZU5ZUmNONUVrMzZ4ZGYxS05US0cxeTFkZ1dJRGMvYzZGU2VLSGFEOFNR?=
 =?utf-8?B?VEU1NHM5Z0NJS0kzSG5UVUpZSVp5cmtZSkJZNzh5VlJNRDRObEVscHAvbnpS?=
 =?utf-8?B?elNoN2dFRE1RYjNHeHpRRFBoVjE0V0FUNHBqYUFXMGx0RXFmQnhySXRBQkEw?=
 =?utf-8?B?K21yQmRGSTZIbndwY2dXWDZkRTVIMXkxVEg2a3NJdnZoS2FrZStGWWk0cUpI?=
 =?utf-8?B?UDE3QlROeWFCbmdVd05xTHhtWjV5dTZXMklVTnhFT3M0Y2c2MmdVWTkxZFNm?=
 =?utf-8?Q?qmdvR+CXmk0/kdozxjoNwbIrc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2NyelNmU1J1bGxIQnJ1T3g4SnJJVjhZd0pQcGVWS2VQQUtjRjZWYkcyQUtJ?=
 =?utf-8?B?T0prcndPRG0vYTFHN1JUcVZ5enFPR2UvRXV2M2w4WUdTaC9ud0lqVTFnOHE3?=
 =?utf-8?B?eER6QW9xT0k0SDBBNXpPNDg5bHRHSjhYZ2YvY2dCVHpxTk1ISlMrbll5UXJB?=
 =?utf-8?B?cW1ORjl1amMrc2F3NVZMbmpKVXNNcmdpVWsyNHRIYU8rRGFvYmN4SVlMY2Fn?=
 =?utf-8?B?OEJxZlRoOS9HUWxZeXRJa2FvRW1lWE5TaUVsOERwa3NUV0J2S0FuWVdyQ0dV?=
 =?utf-8?B?MTREejhOZkJySGhleWFDQzNIWGNwT0RXVkh2cDVqUGNZcHovVDVWMCtvbFhm?=
 =?utf-8?B?cmdPNFBEdXRFTDU2d2h0RU04M2lzMXZZMDNnVTZUdDh4Z3RRYW4xR1k1VTI5?=
 =?utf-8?B?QzlTaUNONnZaSnJ4UnpaVGRwSlh3aGZOQ0NvcnVYQTFsQlJaZTl4RnlWRW9V?=
 =?utf-8?B?blJxSnY0dnhhVW9UeXE5VTljcWZnd3JUMVNXdXhFOHlvaXpKWGZCSUU2bWYz?=
 =?utf-8?B?K2ovNkxrVTJudkxEaEFjVXFrTjc2M2N0YzNDd0ZpUVVvQ1RaQW81TFVZT2Mv?=
 =?utf-8?B?RUw1TFpqM2xOUFJ0UTl5bUVEVlVRNHBLMmQ5dFhyNVVqVVB2Qzg0VVlKSUMz?=
 =?utf-8?B?Ny94QmswYUkzQmo1M3lVY3ZXM09uRVlIV2t5d2srekJvK0JibENTQTd6V3ly?=
 =?utf-8?B?ZlI0a05lZnEyOFk2Nzk5SWtkQ25rZGRwNW43UUJFUnVHcENPbE9mNGxsWGhl?=
 =?utf-8?B?Si9sWVBoOHFwSEpUNVQ4WklxUGM0NmozV2Y3Umh5SWtpN0FOWStCakMra0FG?=
 =?utf-8?B?cTVrZ0kwbS9aLzJIVU1WZjZMUTJ5L29Yb1Q4RFpvRjFoeW5JQUxmc2x6ME92?=
 =?utf-8?B?Vml6MHpWRzFUeEtMTWU0emVHWEZJbjRpa2M0OXFFeGZLdnpWTFVac2JvWi94?=
 =?utf-8?B?aks1TjBxM3VxM0VEOSsxb1V0UFoyQzA2V1VuWEVmSEwySXNrWDl2VzhlZklV?=
 =?utf-8?B?TXlVM0tVMWpRcHhIcnBqUHhYMWF5SDM2N3BLa2cxbUZKczJEMmt5Z0c5aElh?=
 =?utf-8?B?L1pSWGw2WTNDTTRjdlRDN3Z0VFlTZEJFblV1a3hvd2JYNlRnUlZacUpNU3Fp?=
 =?utf-8?B?YnNQK1lIazRmRUthU05qTTczUHI4NXVlNFYzUFpQVkV2YUxyVWNCd0c2bmtO?=
 =?utf-8?B?SUpqUVVOYm1mSEd2dHpkQnY3bU9wcEFHd3ZnQU9nTGtNa3NBUGZkRGwxNlRW?=
 =?utf-8?B?VmFkSnF2bmZKTzI5S2dsZzhGNG1GQXlmajFpZFRacm5OQ2Yra2k1ek02aEsy?=
 =?utf-8?B?T3RLaVVKRUlXT2lwM1JKT0pIL1lqdWVkczdsVFZqMWlKdTRzOSthblRqRUhL?=
 =?utf-8?B?aXZQMTBrQ2ZEMGNHcjZMUDkramtPdEtPUnRjTUJZdHkvTHV5S01XMmFhQmdn?=
 =?utf-8?B?K3NtR3BNMWFTMzEzQ1IxOCtoc0NnZ0wvcWZUbENhOFVaUjBneEVKUzBEUzIy?=
 =?utf-8?B?Zk05cVZpSVVxUnA1R3lCc3RlQ1pQbjJDLzRzZG9uTFlHMWZOSy9kNWIyMXdR?=
 =?utf-8?B?WG9jNDdheHJwWmZUWHRGRm5TcTAvL2cyOGhWWkVJRDEvaG83QVkrRG9nOC83?=
 =?utf-8?B?Wktla0JDazFiVk9oRW9NVXFNRGxMVEpHZC9RR3hBTG1QNWp0ZHVKUmVlVUxU?=
 =?utf-8?B?dUdOcFd4N0c3MVJhTC9DUC82Vmtwc1JEU0pNdzhMN21IWVBhMFMxVC9SWU1C?=
 =?utf-8?B?SVhxVW9yczRHbXNaL0xUUDcycWhXUEpnOUMxVzZyN1M5OTRFdm5wVG42R2Zl?=
 =?utf-8?B?bFluRlVOdUlCSUNLN1dzVE9mV1pXVEQ5QUZZeGs2K2RDckVCdmJWWXhxbWZP?=
 =?utf-8?B?VGlmTXFxSlppSFFEbUZyZkh0U056eitYRnVvRUpid3I3RE8zMmZJTSthb0Z1?=
 =?utf-8?B?M1Naelpab210VENGSVJ1R2RoaERsS25HWTFTMURlUDBzaDlLejlzaWUzVFY3?=
 =?utf-8?B?WHVGYThsUnQ5bTRNb3lPNWJuYVFEQkZUc1RudW40Q0R1U0MvaGIxODNXQ1BL?=
 =?utf-8?B?TmNCQmhHdkpEWlMzY2FDcUtUSnI5Q2YrWFlEV1hDQ2REVDBtZ2VSSTdoeVAx?=
 =?utf-8?B?ZE9yZ3JIZkhHdnZvKzZCMU9xK0t5R0RhZzIweEZJK0xxZTlNeTQ4Z1NjRXlo?=
 =?utf-8?B?Tkg1SHpOV3dOUzhHcHpEUDF3WUttbUxqaFZUc0VpSk5GQUVlRFpCa2wzdUlZ?=
 =?utf-8?B?aW5pT2RweUU1TVNac0RYRnlVQ3ppTUUzeE5peVBSdlVONmlYcFhNaWlWTW1X?=
 =?utf-8?B?R254ZGhNcHBzZ1Awc1RabDVMTjhlZnJxcnM0SnFWdlNKcFJiZGpJTTlMRWNN?=
 =?utf-8?Q?gvQrvgubYw75m+XcpEUYZcW3KJwSJCttUJ8r2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA2B0E19A041CB4DA42D8F52097B458C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e443c17-7d6b-4451-62de-08de730d929c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 18:58:46.4075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otV/YLjJMa0WDH1wjemdWX5XHNkYUOjyAAmk37QIKcCi8ssJQP2dPaRlcLeWTuxslSwPMSEmPqM3QaC6uhpQLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6323
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: XhuxlsQybhk9tGsbMRaQ6eORo50TnhuZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2MiBTYWx0ZWRfX2KkyHsnRcalK
 axFdSrX0Mc5UuH/4F2MuMZSiY9bukCbzOxrcrGzD+89O2bxTvgk8NZYSzjPXTuLhvWaQ6qRtIfB
 hlmpMhnWJx6a6wyNlF4mq4yhHJ/t4u2K5oawseKnQ9ZoJS87b1pAG3TP53k6i90xDZrmgZ+Pq3K
 C2Jfqn9TXU2a23hluiVxag5nK1LxBF5gsOMr/k0GBlnMDqS1C7r8aqLc7z0ygqfCyx42bfzjYmq
 Ev/Wwc3Q8bzQGDr8x6IM/0AhFhtwq9chZwV04Uc1SCnvVJg603otHEaDa7OdESTMxHrrdM5NAjx
 Uu/fdZYzuANxKl+DqGP0n9QUhx4xe/Opp3VqAk0Gl8gXevDFs6jyCqBwuDUgKslMqy2nPw4D13P
 vPt8FTS8AWgO9+mWXuR6HtuTdmCxq34CXKmjrR3wajOQg1mL6k381VmjUJi2IiYu2XHmPy/ioeZ
 ikyg0Ll5GBtbMQ3TMdQ==
X-Proofpoint-GUID: Qi667XIqfOzL5f3PWdglUeAzITxbumUI
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699ca36b cx=c_pps
 a=qx7sgmNqCaiUqJuMW1Xodg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=hSkVLCK3AAAA:8 a=wCmvBT1CAAAA:8 a=EBGCUklkLpfaal8VUhcA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=6z96SAwNL0f8klobD5od:22
Subject: Re:  [PATCH v5] hfsplus: fix uninit-value by validating catalog
 record size
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230162
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77995-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,vivo.com,dubeyko.com,gmail.com,posteo.net];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,proofpoint.com:url,dubeyko.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B3F2917BF1C
X-Rspamd-Action: no action

T24gU2F0LCAyMDI2LTAyLTIxIGF0IDExOjQ2ICswNTMwLCBEZWVwYW5zaHUgS2FydGlrZXkgd3Jv
dGU6DQo+IFN5emJvdCByZXBvcnRlZCBhIEtNU0FOIHVuaW5pdC12YWx1ZSBpc3N1ZSBpbiBoZnNw
bHVzX3N0cmNhc2VjbXAoKS4gVGhlDQo+IHJvb3QgY2F1c2UgaXMgdGhhdCBoZnNfYnJlY19yZWFk
KCkgZG9lc24ndCB2YWxpZGF0ZSB0aGF0IHRoZSBvbi1kaXNrDQo+IHJlY29yZCBzaXplIG1hdGNo
ZXMgdGhlIGV4cGVjdGVkIHNpemUgZm9yIHRoZSByZWNvcmQgdHlwZSBiZWluZyByZWFkLg0KPiAN
Cj4gV2hlbiBtb3VudGluZyBhIGNvcnJ1cHRlZCBmaWxlc3lzdGVtLCBoZnNfYnJlY19yZWFkKCkg
bWF5IHJlYWQgbGVzcyBkYXRhDQo+IHRoYW4gZXhwZWN0ZWQuIEZvciBleGFtcGxlLCB3aGVuIHJl
YWRpbmcgYSBjYXRhbG9nIHRocmVhZCByZWNvcmQsIHRoZQ0KPiBkZWJ1ZyBvdXRwdXQgc2hvd2Vk
Og0KPiANCj4gICBIRlNQTFVTX0JSRUNfUkVBRDogcmVjX2xlbj01MjAsIGZkLT5lbnRyeWxlbmd0
aD0yNg0KPiAgIEhGU1BMVVNfQlJFQ19SRUFEOiBXQVJOSU5HIC0gZW50cnlsZW5ndGggKDI2KSA8
IHJlY19sZW4gKDUyMCkgLSBQQVJUSUFMIFJFQUQhDQo+IA0KPiBoZnNfYnJlY19yZWFkKCkgb25s
eSB2YWxpZGF0ZXMgdGhhdCBlbnRyeWxlbmd0aCBpcyBub3QgZ3JlYXRlciB0aGFuIHRoZQ0KPiBi
dWZmZXIgc2l6ZSwgYnV0IGRvZXNuJ3QgY2hlY2sgaWYgaXQncyBsZXNzIHRoYW4gZXhwZWN0ZWQu
IEl0IHN1Y2Nlc3NmdWxseQ0KPiByZWFkcyAyNiBieXRlcyBpbnRvIGEgNTIwLWJ5dGUgc3RydWN0
dXJlIGFuZCByZXR1cm5zIHN1Y2Nlc3MsIGxlYXZpbmcgNDk0DQo+IGJ5dGVzIHVuaW5pdGlhbGl6
ZWQuDQo+IA0KPiBUaGlzIHVuaW5pdGlhbGl6ZWQgZGF0YSBpbiB0bXAudGhyZWFkLm5vZGVOYW1l
IHRoZW4gZ2V0cyBjb3BpZWQgYnkNCj4gaGZzcGx1c19jYXRfYnVpbGRfa2V5X3VuaSgpIGFuZCB1
c2VkIGJ5IGhmc3BsdXNfc3RyY2FzZWNtcCgpLCB0cmlnZ2VyaW5nDQo+IHRoZSBLTVNBTiB3YXJu
aW5nIHdoZW4gdGhlIHVuaW5pdGlhbGl6ZWQgYnl0ZXMgYXJlIHVzZWQgYXMgYXJyYXkgaW5kaWNl
cw0KPiBpbiBjYXNlX2ZvbGQoKS4NCj4gDQo+IEZpeCBieSBpbnRyb2R1Y2luZyBoZnNwbHVzX2Jy
ZWNfcmVhZF9jYXQoKSB3cmFwcGVyIHRoYXQ6DQo+IDEuIENhbGxzIGhmc19icmVjX3JlYWQoKSB0
byByZWFkIHRoZSBkYXRhDQo+IDIuIFZhbGlkYXRlcyB0aGUgcmVjb3JkIHNpemUgYmFzZWQgb24g
dGhlIHR5cGUgZmllbGQ6DQo+ICAgIC0gRml4ZWQgc2l6ZSBmb3IgZm9sZGVyIGFuZCBmaWxlIHJl
Y29yZHMNCj4gICAgLSBWYXJpYWJsZSBzaXplIGZvciB0aHJlYWQgcmVjb3JkcyAoZGVwZW5kcyBv
biBzdHJpbmcgbGVuZ3RoKQ0KPiAzLiBSZXR1cm5zIC1FSU8gaWYgc2l6ZSBkb2Vzbid0IG1hdGNo
IGV4cGVjdGVkDQo+IA0KPiBGb3IgdGhyZWFkIHJlY29yZHMsIGNoZWNrIG1pbmltdW0gc2l6ZSBi
ZWZvcmUgcmVhZGluZyBub2RlTmFtZS5sZW5ndGggdG8NCj4gYXZvaWQgcmVhZGluZyB1bmluaXRp
YWxpemVkIGRhdGEgYXQgY2FsbCBzaXRlcyB0aGF0IGRvbid0IHplcm8taW5pdGlhbGl6ZQ0KPiB0
aGUgZW50cnkgc3RydWN0dXJlLg0KPiANCj4gQWxzbyBpbml0aWFsaXplIHRoZSB0bXAgdmFyaWFi
bGUgaW4gaGZzcGx1c19maW5kX2NhdCgpIGFzIGRlZmVuc2l2ZQ0KPiBwcm9ncmFtbWluZyB0byBl
bnN1cmUgbm8gdW5pbml0aWFsaXplZCBkYXRhIGV2ZW4gaWYgdmFsaWRhdGlvbiBpcw0KPiBieXBh
c3NlZC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBzeXpib3QrZDgwYWJiNWI4OTBkMzkyNjFlNzJAc3l6
a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiBDbG9zZXM6IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9v
ZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fc3l6a2FsbGVyLmFwcHNwb3QuY29tX2J1Zy0z
RmV4dGlkLTNEZDgwYWJiNWI4OTBkMzkyNjFlNzImZD1Ed0lEQWcmYz1CU0RpY3FCUUJEakRJOVJr
VnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZtPUJY
ZG4zd0lwbU1sTU5tczVjZDNIV1Z3d3MwQVVxM1BSUjhIQVF2cURzbUdvUTNsX0tPRS1NRXZ3ZnVa
c3hVS2Emcz1BNFdfbmNzZTBVdU9vbU5LZ09Cc2tzVVMzVWpTeTl6b2NtY3ZXQ1NlR2NrJmU9IA0K
PiBGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGludXgtMi42LjEyLXJjMiIpDQo+IFRlc3RlZC1ieTog
c3l6Ym90K2Q4MGFiYjViODkwZDM5MjYxZTcyQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4g
UmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8c2xhdmFAZHViZXlrby5jb20+DQo+IFRl
c3RlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2YUBkdWJleWtvLmNvbT4NCj4gTGluazog
aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3Jl
Lmtlcm5lbC5vcmdfYWxsXzIwMjYwMTIwMDUxMTE0LjEyODEyODUtMkQxLTJEa2FydGlrZXk0MDYt
NDBnbWFpbC5jb21fJmQ9RHdJREFnJmM9QlNEaWNxQlFCRGpESTlSa1Z5VGNIUSZyPXE1YkltNEFY
TXpjOE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAmbT1CWGRuM3dJcG1NbE1ObXM1Y2Qz
SFdWd3dzMEFVcTNQUlI4SEFRdnFEc21Hb1EzbF9LT0UtTUV2d2Z1WnN4VUthJnM9RDNhTmh3NFVm
akxDZ0pmUlJHQk41Q3g1U2ZQdjJ6UW9hS3ZpQ0V0dXpQWSZlPSAgW3YxXQ0KPiBMaW5rOiBodHRw
czovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2xvcmUua2Vy
bmVsLm9yZ19hbGxfMjAyNjAxMjEwNjMxMDkuMTgzMDI2My0yRDEtMkRrYXJ0aWtleTQwNi00MGdt
YWlsLmNvbV8mZD1Ed0lEQWcmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4
Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZtPUJYZG4zd0lwbU1sTU5tczVjZDNIV1Z3
d3MwQVVxM1BSUjhIQVF2cURzbUdvUTNsX0tPRS1NRXZ3ZnVac3hVS2Emcz1nUXM3MWpFaGYySEdr
OUpZaWI5ay1wY2FYQWpzUHBxU0Fuc3FyM1dTTDBNJmU9ICBbdjJdDQo+IExpbms6IGh0dHBzOi8v
dXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwu
b3JnX2FsbF8yMDI2MDIxMjAxNDIzMy4yNDIyMDQ2LTJEMS0yRGthcnRpa2V5NDA2LTQwZ21haWwu
Y29tXyZkPUR3SURBZyZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhOSnUx
X1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09QlhkbjN3SXBtTWxNTm1zNWNkM0hXVnd3czBB
VXEzUFJSOEhBUXZxRHNtR29RM2xfS09FLU1FdndmdVpzeFVLYSZzPUFfUlNwN3gyOEZmQUl0b1Bs
Y1V3V2MwMmZDbmlxMFVMUjlHSGY1aFUteWsmZT0gIFt2M10NCj4gTGluazogaHR0cHM6Ly91cmxk
ZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3JlLmtlcm5lbC5vcmdf
YWxsXzIwMjYwMjE0MDAyMTAwLjQzNjEyNS0yRDEtMkRrYXJ0aWtleTQwNi00MGdtYWlsLmNvbV9U
XyZkPUR3SURBZyZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhOSnUxX1JH
bW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09QlhkbjN3SXBtTWxNTm1zNWNkM0hXVnd3czBBVXEz
UFJSOEhBUXZxRHNtR29RM2xfS09FLU1FdndmdVpzeFVLYSZzPUhUVG9MUFltVU1lNGdhUU0wTjQ3
QXhXOVdDTkI4RndlVklzV1F6dkE0LW8mZT0gIFt2NF0NCj4gU2lnbmVkLW9mZi1ieTogRGVlcGFu
c2h1IEthcnRpa2V5IDxrYXJ0aWtleTQwNkBnbWFpbC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGlu
IHY1Og0KPiAtIEFkZCBtaW5pbXVtIHNpemUgY2hlY2sgZm9yIHRocmVhZCByZWNvcmRzIGJlZm9y
ZSByZWFkaW5nIG5vZGVOYW1lLmxlbmd0aA0KPiAgIHRvIGF2b2lkIHJlYWRpbmcgdW5pbml0aWFs
aXplZCBkYXRhLCBhcyBzdWdnZXN0ZWQgYnkgQ2hhcmFsYW1wb3MgTWl0cm9kaW1hcw0KDQpNYXli
ZSBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLiBCdXQgd2hlcmUgaXMgc3VnZ2VzdGVkIGNoZWNrPyBJ
IGRvbid0IHNlZSB0aGlzDQpjaGVjayBhdCBhbGwuIDopDQoNClRoYW5rcywNClNsYXZhLg0KDQo+
IA0KPiBDaGFuZ2VzIGluIHY0Og0KPiAtIE1vdmUgaGZzcGx1c19jYXRfdGhyZWFkX3NpemUoKSBh
cyBzdGF0aWMgaW5saW5lIHRvIGhlYWRlciBmaWxlDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAt
IEludHJvZHVjZWQgaGZzcGx1c19icmVjX3JlYWRfY2F0KCkgd3JhcHBlciBmdW5jdGlvbiBmb3Ig
Y2F0YWxvZy1zcGVjaWZpYw0KPiAgIHZhbGlkYXRpb24gaW5zdGVhZCBvZiBtb2RpZnlpbmcgZ2Vu
ZXJpYyBoZnNfYnJlY19yZWFkKCkNCj4gLSBBZGRlZCBoZnNwbHVzX2NhdF90aHJlYWRfc2l6ZSgp
IGhlbHBlciB0byBjYWxjdWxhdGUgdmFyaWFibGUtc2l6ZSB0aHJlYWQNCj4gICByZWNvcmQgc2l6
ZXMNCj4gLSBVc2UgZXhhY3Qgc2l6ZSBtYXRjaCAoIT0pIGluc3RlYWQgb2YgbWluaW11bSBzaXpl
IGNoZWNrICg8KQ0KPiAtIFVzZSBzaXplb2YoaGZzcGx1c191bmljaHIpIGluc3RlYWQgb2YgaGFy
ZGNvZGVkIHZhbHVlIDINCj4gLSBVcGRhdGVkIGFsbCBjYXRhbG9nIHJlY29yZCByZWFkIHNpdGVz
IHRvIHVzZSBuZXcgd3JhcHBlciBmdW5jdGlvbg0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBV
c2Ugc3RydWN0dXJlIGluaXRpYWxpemF0aW9uICg9IHswfSkgaW5zdGVhZCBvZiBtZW1zZXQoKQ0K
PiAtIEltcHJvdmVkIGNvbW1pdCBtZXNzYWdlIHRvIGNsYXJpZnkgaG93IHVuaW5pdGlhbGl6ZWQg
ZGF0YSBpcyB1c2VkDQo+IC0tLQ0KPiAgZnMvaGZzcGx1cy9iZmluZC5jICAgICAgfCA1MiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgZnMvaGZzcGx1cy9jYXRh
bG9nLmMgICAgfCAgNCArKy0tDQo+ICBmcy9oZnNwbHVzL2Rpci5jICAgICAgICB8ICAyICstDQo+
ICBmcy9oZnNwbHVzL2hmc3BsdXNfZnMuaCB8ICA5ICsrKysrKysNCj4gIGZzL2hmc3BsdXMvc3Vw
ZXIuYyAgICAgIHwgIDIgKy0NCj4gIDUgZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL2JmaW5kLmMgYi9m
cy9oZnNwbHVzL2JmaW5kLmMNCj4gaW5kZXggMzM2ZDY1NDg2MWM1Li4yYjkxNTJjMzEwN2IgMTAw
NjQ0DQo+IC0tLSBhL2ZzL2hmc3BsdXMvYmZpbmQuYw0KPiArKysgYi9mcy9oZnNwbHVzL2JmaW5k
LmMNCj4gQEAgLTI4NywzICsyODcsNTUgQEAgaW50IGhmc19icmVjX2dvdG8oc3RydWN0IGhmc19m
aW5kX2RhdGEgKmZkLCBpbnQgY250KQ0KPiAgCWZkLT5ibm9kZSA9IGJub2RlOw0KPiAgCXJldHVy
biByZXM7DQo+ICB9DQo+ICsNCj4gKy8qKg0KPiArICogaGZzcGx1c19icmVjX3JlYWRfY2F0IC0g
cmVhZCBhbmQgdmFsaWRhdGUgYSBjYXRhbG9nIHJlY29yZA0KPiArICogQGZkOiBmaW5kIGRhdGEg
c3RydWN0dXJlDQo+ICsgKiBAZW50cnk6IHBvaW50ZXIgdG8gY2F0YWxvZyBlbnRyeSB0byByZWFk
IGludG8NCj4gKyAqDQo+ICsgKiBSZWFkcyBhIGNhdGFsb2cgcmVjb3JkIGFuZCB2YWxpZGF0ZXMg
aXRzIHNpemUgbWF0Y2hlcyB0aGUgZXhwZWN0ZWQNCj4gKyAqIHNpemUgYmFzZWQgb24gdGhlIHJl
Y29yZCB0eXBlLg0KPiArICoNCj4gKyAqIFJldHVybnMgMCBvbiBzdWNjZXNzLCBvciBuZWdhdGl2
ZSBlcnJvciBjb2RlIG9uIGZhaWx1cmUuDQo+ICsgKi8NCj4gK2ludCBoZnNwbHVzX2JyZWNfcmVh
ZF9jYXQoc3RydWN0IGhmc19maW5kX2RhdGEgKmZkLCBoZnNwbHVzX2NhdF9lbnRyeSAqZW50cnkp
DQo+ICt7DQo+ICsJaW50IHJlczsNCj4gKwl1MzIgZXhwZWN0ZWRfc2l6ZTsNCj4gKw0KPiArCXJl
cyA9IGhmc19icmVjX3JlYWQoZmQsIGVudHJ5LCBzaXplb2YoaGZzcGx1c19jYXRfZW50cnkpKTsN
Cj4gKwlpZiAocmVzKQ0KPiArCQlyZXR1cm4gcmVzOw0KPiArDQo+ICsJLyogVmFsaWRhdGUgY2F0
YWxvZyByZWNvcmQgc2l6ZSBiYXNlZCBvbiB0eXBlICovDQo+ICsJc3dpdGNoIChiZTE2X3RvX2Nw
dShlbnRyeS0+dHlwZSkpIHsNCj4gKwljYXNlIEhGU1BMVVNfRk9MREVSOg0KPiArCQlleHBlY3Rl
ZF9zaXplID0gc2l6ZW9mKHN0cnVjdCBoZnNwbHVzX2NhdF9mb2xkZXIpOw0KPiArCQlicmVhazsN
Cj4gKwljYXNlIEhGU1BMVVNfRklMRToNCj4gKwkJZXhwZWN0ZWRfc2l6ZSA9IHNpemVvZihzdHJ1
Y3QgaGZzcGx1c19jYXRfZmlsZSk7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgSEZTUExVU19GT0xE
RVJfVEhSRUFEOg0KPiArCWNhc2UgSEZTUExVU19GSUxFX1RIUkVBRDoNCj4gKwkJLyogRW5zdXJl
IHdlIGhhdmUgYXQgbGVhc3QgdGhlIGZpeGVkIGZpZWxkcyBiZWZvcmUgcmVhZGluZyBub2RlTmFt
ZS5sZW5ndGggKi8NCj4gKwkJaWYgKGZkLT5lbnRyeWxlbmd0aCA8IG9mZnNldG9mKHN0cnVjdCBo
ZnNwbHVzX2NhdF90aHJlYWQsIG5vZGVOYW1lKSArDQo+ICsJCSAgICBvZmZzZXRvZihzdHJ1Y3Qg
aGZzcGx1c191bmlzdHIsIHVuaWNvZGUpKSB7DQo+ICsJCQlwcl9lcnIoInRocmVhZCByZWNvcmQg
dG9vIHNob3J0IChnb3QgJXUpXG4iLCBmZC0+ZW50cnlsZW5ndGgpOw0KPiArCQkJcmV0dXJuIC1F
SU87DQo+ICsJCX0NCj4gKwkJZXhwZWN0ZWRfc2l6ZSA9IGhmc3BsdXNfY2F0X3RocmVhZF9zaXpl
KCZlbnRyeS0+dGhyZWFkKTsNCj4gKwkJYnJlYWs7DQo+ICsJZGVmYXVsdDoNCj4gKwkJcHJfZXJy
KCJ1bmtub3duIGNhdGFsb2cgcmVjb3JkIHR5cGUgJWRcbiIsDQo+ICsJCSAgICAgICBiZTE2X3Rv
X2NwdShlbnRyeS0+dHlwZSkpOw0KPiArCQlyZXR1cm4gLUVJTzsNCj4gKwl9DQo+ICsNCj4gKwlp
ZiAoZmQtPmVudHJ5bGVuZ3RoICE9IGV4cGVjdGVkX3NpemUpIHsNCj4gKwkJcHJfZXJyKCJjYXRh
bG9nIHJlY29yZCBzaXplIG1pc21hdGNoICh0eXBlICVkLCBnb3QgJXUsIGV4cGVjdGVkICV1KVxu
IiwNCj4gKwkJICAgICAgIGJlMTZfdG9fY3B1KGVudHJ5LT50eXBlKSwgZmQtPmVudHJ5bGVuZ3Ro
LCBleHBlY3RlZF9zaXplKTsNCj4gKwkJcmV0dXJuIC1FSU87DQo+ICsJfQ0KPiArDQo+ICsJcmV0
dXJuIDA7DQo+ICt9DQo+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL2NhdGFsb2cuYyBiL2ZzL2hm
c3BsdXMvY2F0YWxvZy5jDQo+IGluZGV4IDAyYzFlZWU0YTRiOC4uNmM4MzgwZjcyMDhkIDEwMDY0
NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2NhdGFsb2cuYw0KPiArKysgYi9mcy9oZnNwbHVzL2NhdGFs
b2cuYw0KPiBAQCAtMTk0LDEyICsxOTQsMTIgQEAgc3RhdGljIGludCBoZnNwbHVzX2ZpbGxfY2F0
X3RocmVhZChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KPiAgaW50IGhmc3BsdXNfZmluZF9jYXQo
c3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdTMyIGNuaWQsDQo+ICAJCSAgICAgc3RydWN0IGhmc19m
aW5kX2RhdGEgKmZkKQ0KPiAgew0KPiAtCWhmc3BsdXNfY2F0X2VudHJ5IHRtcDsNCj4gKwloZnNw
bHVzX2NhdF9lbnRyeSB0bXAgPSB7MH07DQo+ICAJaW50IGVycjsNCj4gIAl1MTYgdHlwZTsNCj4g
IA0KPiAgCWhmc3BsdXNfY2F0X2J1aWxkX2tleV93aXRoX2NuaWQoc2IsIGZkLT5zZWFyY2hfa2V5
LCBjbmlkKTsNCj4gLQllcnIgPSBoZnNfYnJlY19yZWFkKGZkLCAmdG1wLCBzaXplb2YoaGZzcGx1
c19jYXRfZW50cnkpKTsNCj4gKwllcnIgPSBoZnNwbHVzX2JyZWNfcmVhZF9jYXQoZmQsICZ0bXAp
Ow0KPiAgCWlmIChlcnIpDQo+ICAJCXJldHVybiBlcnI7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2Zz
L2hmc3BsdXMvZGlyLmMgYi9mcy9oZnNwbHVzL2Rpci5jDQo+IGluZGV4IGNhNWY3NGExNDBlYy4u
OGFlYjg2MTk2OWQzIDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2Rpci5jDQo+ICsrKyBiL2Zz
L2hmc3BsdXMvZGlyLmMNCj4gQEAgLTQ5LDcgKzQ5LDcgQEAgc3RhdGljIHN0cnVjdCBkZW50cnkg
Kmhmc3BsdXNfbG9va3VwKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnks
DQo+ICAJaWYgKHVubGlrZWx5KGVyciA8IDApKQ0KPiAgCQlnb3RvIGZhaWw7DQo+ICBhZ2FpbjoN
Cj4gLQllcnIgPSBoZnNfYnJlY19yZWFkKCZmZCwgJmVudHJ5LCBzaXplb2YoZW50cnkpKTsNCj4g
KwllcnIgPSBoZnNwbHVzX2JyZWNfcmVhZF9jYXQoJmZkLCAmZW50cnkpOw0KPiAgCWlmIChlcnIp
IHsNCj4gIAkJaWYgKGVyciA9PSAtRU5PRU5UKSB7DQo+ICAJCQloZnNfZmluZF9leGl0KCZmZCk7
DQo+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL2hmc3BsdXNfZnMuaCBiL2ZzL2hmc3BsdXMvaGZz
cGx1c19mcy5oDQo+IGluZGV4IDVmODkxYjczYTY0Ni4uNjFkNTIwOTFkZDI4IDEwMDY0NA0KPiAt
LS0gYS9mcy9oZnNwbHVzL2hmc3BsdXNfZnMuaA0KPiArKysgYi9mcy9oZnNwbHVzL2hmc3BsdXNf
ZnMuaA0KPiBAQCAtNTA5LDYgKzUwOSwxNSBAQCBpbnQgaGZzcGx1c19zdWJtaXRfYmlvKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IsIHNlY3Rvcl90IHNlY3Rvciwgdm9pZCAqYnVmLA0KPiAgCQkgICAg
ICAgdm9pZCAqKmRhdGEsIGJsa19vcGZfdCBvcGYpOw0KPiAgaW50IGhmc3BsdXNfcmVhZF93cmFw
cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpOw0KPiAgDQo+ICtzdGF0aWMgaW5saW5lIHUzMiBo
ZnNwbHVzX2NhdF90aHJlYWRfc2l6ZShjb25zdCBzdHJ1Y3QgaGZzcGx1c19jYXRfdGhyZWFkICp0
aHJlYWQpDQo+ICt7DQo+ICsJcmV0dXJuIG9mZnNldG9mKHN0cnVjdCBoZnNwbHVzX2NhdF90aHJl
YWQsIG5vZGVOYW1lKSArDQo+ICsJICAgICAgIG9mZnNldG9mKHN0cnVjdCBoZnNwbHVzX3VuaXN0
ciwgdW5pY29kZSkgKw0KPiArCSAgICAgICBiZTE2X3RvX2NwdSh0aHJlYWQtPm5vZGVOYW1lLmxl
bmd0aCkgKiBzaXplb2YoaGZzcGx1c191bmljaHIpOw0KPiArfQ0KPiArDQo+ICtpbnQgaGZzcGx1
c19icmVjX3JlYWRfY2F0KHN0cnVjdCBoZnNfZmluZF9kYXRhICpmZCwgaGZzcGx1c19jYXRfZW50
cnkgKmVudHJ5KTsNCj4gKw0KPiAgLyoNCj4gICAqIHRpbWUgaGVscGVyczogY29udmVydCBiZXR3
ZWVuIDE5MDQtYmFzZSBhbmQgMTk3MC1iYXNlIHRpbWVzdGFtcHMNCj4gICAqDQo+IGRpZmYgLS1n
aXQgYS9mcy9oZnNwbHVzL3N1cGVyLmMgYi9mcy9oZnNwbHVzL3N1cGVyLmMNCj4gaW5kZXggNTky
ZDhmYmI3NDhjLi5kY2I0MzU3YWFlM2UgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmc3BsdXMvc3VwZXIu
Yw0KPiArKysgYi9mcy9oZnNwbHVzL3N1cGVyLmMNCj4gQEAgLTU3MSw3ICs1NzEsNyBAQCBzdGF0
aWMgaW50IGhmc3BsdXNfZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3Qg
ZnNfY29udGV4dCAqZmMpDQo+ICAJZXJyID0gaGZzcGx1c19jYXRfYnVpbGRfa2V5KHNiLCBmZC5z
ZWFyY2hfa2V5LCBIRlNQTFVTX1JPT1RfQ05JRCwgJnN0cik7DQo+ICAJaWYgKHVubGlrZWx5KGVy
ciA8IDApKQ0KPiAgCQlnb3RvIG91dF9wdXRfcm9vdDsNCj4gLQlpZiAoIWhmc19icmVjX3JlYWQo
JmZkLCAmZW50cnksIHNpemVvZihlbnRyeSkpKSB7DQo+ICsJaWYgKCFoZnNwbHVzX2JyZWNfcmVh
ZF9jYXQoJmZkLCAmZW50cnkpKSB7DQo+ICAJCWhmc19maW5kX2V4aXQoJmZkKTsNCj4gIAkJaWYg
KGVudHJ5LnR5cGUgIT0gY3B1X3RvX2JlMTYoSEZTUExVU19GT0xERVIpKSB7DQo+ICAJCQllcnIg
PSAtRUlPOw0K

