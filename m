Return-Path: <linux-fsdevel+bounces-77750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KYVM4Gfl2nc3AIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 00:40:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E013163915
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 00:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B786303788C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAD130F819;
	Thu, 19 Feb 2026 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jaKXXmrw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F92FA0C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544408; cv=fail; b=cSKUeOpLGiSWc+IWXkl0DH/4CtUEHfGHFMEeIEZj7FVL3zh3OpIX+MdbvzgVvli6guCSbQyfJ5hqntVlmLNw0U+P2cs8GHJluhtin9zWDSMQKaCfe2KqP9uR1qL24GxDthfGSfzy3+kZpSHid5CGpsoXDuyS4GnSLYW1i6kX4e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544408; c=relaxed/simple;
	bh=9kP8zEOU/FlbgzAbLrPlDzS6LXwWnTgM58doBCIRDI0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=RVVMDkgpZnqX9B+b7BDeBBDczMa2NlFpoC7RARFvGMLBjfB+q3fbqqsXtafL4he7XI6h5iV9rWtzwBnZx0zilTTGKjnODnL99Nsy5f6cLuXMzxPQSFPsfrB8LSkoP2FG0yQeitF6fn14F6dy7yey3jHCjeh/4Lmkh9jlsTHZMPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jaKXXmrw; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JKTWj41271212;
	Thu, 19 Feb 2026 23:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=9kP8zEOU/FlbgzAbLrPlDzS6LXwWnTgM58doBCIRDI0=; b=jaKXXmrw
	Cq2JFLW+4qPliTK0p9M0e0jTVBTL2MGJFAQWcmcuAoZ8X1wfz5mFnJ6vZQaUD4Xe
	Dtw/EB6eddRNVvMt1KQDjLmed2J0noH4ARSNeJbHWChAQNXOuVUmlcbz+nCS4bxK
	GOp7eh7InXHyjsLnPP+Z42CWcMkT7Zsi0kctnQYF3y7HIjmSfm24SOWCTOpQYD8P
	sdOXIdu5+OzJXBSruHWL0qPRJKFH2Jey4XfxalMkxuPyv52V1T3YYqBo7W5twX+U
	rp9D0FpkGLSdLTdk4DjXj2qEB8IP99ZxrRLInjtMyxBWLSiW8NCISWgJyHXRsONN
	qR13it9/Q6J4wQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4kq6qu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 23:39:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wC/VZx8KaB+DPc6u4r3KEx57NxmfyG3teyb5pvlAJ2ha0jywEuSGCbEwu32+PcFhzH8CZvArGfRzR9MSXadcfG0KmRfS/UtoJJ5miLlLlA19ilfyfz186Cfofy5xjtqANiqiXVt2J4BJxHRm5Rxv/w6DY/MQtGwB7ZQmx/8Va8bGLWSuWWio+83wE4P+HvdRoGPTNoiKUUO+dmXDF2cveRBcP3Xyf8blsu4qrVbHMx6wzgyOKzsGtNKNy92CVrzURaRmrshn7phy0dxAvBPGORjLdItxKL/IX8gRzzewhYrirV8daweNZhHqTKNCfsRl0x0cc8X1v4EvOgTp9vMM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kP8zEOU/FlbgzAbLrPlDzS6LXwWnTgM58doBCIRDI0=;
 b=XCtAxbIPg9wh9Jy4tvqsGLQEE6AzukYMYQy3fBDHcRR1rT49C0O3qwERZbUqqgQLklGY3+reOvyw8DtEAe8r28Iq14h0tyKCVEZxiXFL+eQk31WNQJ+lkVI8gICB+IeNXSSagSxnP3vhHCe5t3IyGjsD0ZZpNoUAhD+OvBFrqJOsnv31eIq88wS65LJJ5NWKfpJ6Uwd65F6umu/1ksjvJquq52x7ob7XqLhu1nbgJkHVJvDlIdTzRyEuxVmgQ4Lz8Uy2bBTRSmlSxao+Youo5zkMqlGh7p7YH9b8AuOmOPjllskjb8xFyat1K6HxnIkKd+kSnIukPuVUPoCrdkF7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CY8PR15MB5580.namprd15.prod.outlook.com (2603:10b6:930:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 23:39:56 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 23:39:56 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "charmitro@posteo.net" <charmitro@posteo.net>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs/hfsplus: fix timestamp wrapped issue
Thread-Index: AQHcn7avK7OIubRA4kGw9zI5SLiJRLWHMl0AgACC1oCAAT14gIAAP7SAgAGATYA=
Date: Thu, 19 Feb 2026 23:39:55 +0000
Message-ID: <37099689c4b0a39fd98af812c31c07ab2f833d51.camel@ibm.com>
References: <20260216233556.4005400-1-slava@dubeyko.com>
		<87a4x8f5zq.fsf@posteo.net>
		<2b7b7a970926f56a3742cb76e394e9fb3d79b0eb.camel@ibm.com>
		<m2bjhn81n2.fsf@posteo.net>
		<15b8136f279abd8320e2d4745a4f1e76c9f9aa83.camel@ibm.com>
	 <87jyw9blzq.fsf@posteo.net>
In-Reply-To: <87jyw9blzq.fsf@posteo.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CY8PR15MB5580:EE_
x-ms-office365-filtering-correlation-id: 971f5c1d-cd94-4066-d5ce-08de70103013
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3JLRml4MjM5SXpmWEpMa0hVSG1QY2c3VWkwTWUwMVRuUzkzL0ljR1FmZGQ3?=
 =?utf-8?B?c1A1cTZodFdEc0o3YUYrRDBoUStiRE01eWJjQ1B4TmNrS2ZmS3cxQnZodkkx?=
 =?utf-8?B?NlV4OXhZZEIrN1Y0ZXpUUjNNTUh4NTN3bzRFOUhmVUM2ckxvTHJLQ3FNYjUy?=
 =?utf-8?B?TzN5KzBReU9JL1YyZkN6NTM5bnhBamJjQnhlR05jRWxlcjdmZm9mSnAvQTg1?=
 =?utf-8?B?SFkxYThIbkVnZU5KYjJadFhLTG1hbjdtMmx0QktuS1JuQUgxYnovcmN3aHFw?=
 =?utf-8?B?TEVwWkdzb3BIbTlVdG1iNi9iMjJLekd2eGR6ejY5VjhzUWRhUmUwMHVGTzJQ?=
 =?utf-8?B?dHRZOXRQcmhaSUk0cEZ2aGFhUmRGajU0blFkNmxTZ1dKWm9pbXRsLzg0am5T?=
 =?utf-8?B?dXpPTUpxQXIxOWYvTFhJT3l4ZWY4ZE5LdkxLWUhnTjRZWWs4bjgxSXNER0tr?=
 =?utf-8?B?ZEVyVVFSakdHM0Fxak4xcHMwRFZ3ZGZ4K2hzWnEwRVlVdHdETGNCT3BMeVZY?=
 =?utf-8?B?UEJTeVlMenpZNVYzTnAxaHE2eGVSa1kwd1BDdHFRVUFoZ1pKenIwOU9sanln?=
 =?utf-8?B?ZkhXTmdrUUd5SkY0Sk1wU2syUUVUd2szSHVOajF6Z3Roclp2SWFrL1laUjRX?=
 =?utf-8?B?eitJUGxsbWE1cXhSRFVmMHhHZVBFVWpVeCtpcWNqYi9UT3JuRlZuM2Y2Slo2?=
 =?utf-8?B?Zk9tYVcyWU1QbW1PcjAyaEp2NDZSTC9PaEFvcU1BcUo2R2FYbEsxNjdvZHhQ?=
 =?utf-8?B?eW1rRjVINFZNdnNwaTI5VDRkZEUxd1NLQk4wZlZxL3RpcktUdjEyQk03WUxN?=
 =?utf-8?B?YzV2aWw3SisvSVhqNDIzaU14ZU05aTczOVF4WklEbENPZ3ZkZ0VCTVhnVEZ3?=
 =?utf-8?B?TXdUZTcrRndpSWVSRERXQUtHVXpXR0FFOXNGVjZYb2ZZOE9hTnRMdHFOUVpz?=
 =?utf-8?B?S2pYSzlKNGp5SkU1TFVad1hTRXB2UFlDb1dNQ3Y1WE45VkJnOHNrVUpadzlN?=
 =?utf-8?B?eklSckQ2SldOQ2xxeXdNaE0ySFZoaSt0RnpJVVB5UDZ2eWhFdFFPNVVabkxC?=
 =?utf-8?B?b2pjdnlhbDhTVmFXOVFpNFZLaTJBTWFMYWk5Yko2SGZnUUt0NTdSZlFKa3JE?=
 =?utf-8?B?dkpySjhGSk5vODJlUU43bFFhRFJ5clU2d00wbXZKTXlmdjFFZjFkbkkwVTEy?=
 =?utf-8?B?NjhPdXZWdHUzWjhSV3B5YXhqVHJCN3VScWsyeVF4NXRGeEtwelFZQUJCWmIy?=
 =?utf-8?B?c3BiOS9BWS9wN3F5Kzd6ZGV4Tjd4OXNMRURhNG9LK0hIWC9JMm1lWVFMcWhT?=
 =?utf-8?B?Sk85eW1TRG1YM3JkallLemhkSVh0OTRndWNmaUR5dFNvYWYwMmxlU0wzZXlU?=
 =?utf-8?B?NWJVelBRZVViYUNZSmhtU0liOGxvWEQwNHdQYWx0TjNqOXJBSWdJZXhLajNa?=
 =?utf-8?B?TktMVWhVMVhNZXBleVpEVlFFdm9FY2w0ZWF3Sm5UZzdWMkhUY3JRV056NmhF?=
 =?utf-8?B?eXJDSER4ZzZWVjZTYWpQVEtFSnZic3BHbHRmLzhtNTRHeEk3OThldGhxaHho?=
 =?utf-8?B?MlF6dTIrM1pDNnNvWDZpYzFOUklqMFpMaWZPZUNSelVhbmF4UFZLeW5DQVF3?=
 =?utf-8?B?dC95eWJxS2RGRERkVGRYUURFMHFUbFA4WWZiaURPTkJnL000b1FKc2FRZWE3?=
 =?utf-8?B?bVdrVkI5TWJOaERZbTZuK0lTbGxrMEthWDRvcktjTjgzcDhobHhlbW9rcDhS?=
 =?utf-8?B?QnJGTTdQd3llWnZGeXEzNG5xVktvcTFlNVB4RlArWDNRWVd3d0M0Q2pBdFZv?=
 =?utf-8?B?SVBiSTUwUHFLcCtEeng2em5SQmt6bHoxbWh2dnVGQzJ3dHZEOHdhNUNLWGNl?=
 =?utf-8?B?TXhveVE4eFR6MXY3RWNTWmNXMVhkQzJtbjZKdU1xLzBPVmYvTWw2YysxcDZl?=
 =?utf-8?B?WTdFYlpXVCsvZ2RhemxIZ2liVkNDYTlXaHhRbHY4RGsyeVRoZWhwem5VVTk5?=
 =?utf-8?B?NVVXNmFjbmNuUUl5RDdsQ1JxZlVNV1pYaWx6VWlmQmxUWlVsWGtNb2NoSlM5?=
 =?utf-8?B?eHBNa1Q1c3R1TnNLMkJFQkN2OWJhRkJUSUVORXJwUnJ0Vm5lcEMwdkJJYlZ6?=
 =?utf-8?B?ZnpiZm9ZL1E2a3kzb2hsbGRyd2lmTEZXQ3JjSFJLajV4UjQwZW10VEhEWUtK?=
 =?utf-8?Q?FmyjTGRQKGXnNhEhTH3tmKY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0RqY0tLZXB1aWpyMUZhc1hhV1Ftd2MxUWpaTHBzdXp1bng0OGw3L01yV29U?=
 =?utf-8?B?cnhDM1VNVm5IS3A1V1lGRVJTOHJDR1kxckc1UENvRy9XcmVCeW1pRm1XU1cv?=
 =?utf-8?B?U3dCZC9YNVNSUWMrT1BNSXV2S2lBQlhyQUo0TzY1THQxalpHZ3lWME5UWldk?=
 =?utf-8?B?RXNFQ1diNmw1Q3JyYlJjVjVmNlJzU24rNG1DUEVqQTB2UjR2bkplbTRjMHZn?=
 =?utf-8?B?Skx6aHBOZVY5WS9pckRDdW1wNkR4dmNsMjJDSDFMdG9RUkpmOUdqbnN3d3Ey?=
 =?utf-8?B?Z25wL2M1REsxQUhOQXJNN2YzNk9rWGRCZSt5U1BrWWdBSU9Vejlwdm5nVDg1?=
 =?utf-8?B?LzV3dXE0NGdQV05ubTJqZytIQ2Vxczh2dkJqS2tEaExnTXAxOHFtSkpsSEQ4?=
 =?utf-8?B?RjJnd3NiYXEzUG5DSk8zT3N4YzhrdXFqNGFtVUlpOVBOcjNsbVBneWRZWFBR?=
 =?utf-8?B?M0p5V0x4RVppRE01VkRHM0g2VndYUlNWZDQ1bUhwdzltUWVDUnJRWDArQ0hx?=
 =?utf-8?B?VEpZSURhSkl4MVhEZ2ZOTkV4RHhrMENwR2FPZ0ZiVUlIV2ZwbnVGa1dWVGtC?=
 =?utf-8?B?TWp4L2pCNW1FS2xDUVZxZnhCbkg0azNuSnI1azVxMytXMFl5eUl3WkhYd3Jl?=
 =?utf-8?B?SGJTNG9KTmFwWkNMbjZRM3YrY0dHTmZnMEF0bjBwTzVxWkljMGVGT0FLZTFi?=
 =?utf-8?B?VDEreDJvMzlYNTBhai83YUNicE5YYWdRQ2ovb1ZtNVZmNWlwOUt3eG5XaVNm?=
 =?utf-8?B?RXYwUTNVUEIzamhiRkxmblU5QkRwYm9vUm1sY3ZqUDVzUUJoTUhzSFRmMDg1?=
 =?utf-8?B?UmZpdkk0ei81RTBZd24xd0VYKytoT08vbW0zRStvTktoN1h6U1kvUVFFOFND?=
 =?utf-8?B?MWU5b0FtY2tuWWxZN2VCODFPeVJLbkZmR2hoYUtCRU1XNnptTFNGanU5Q2V6?=
 =?utf-8?B?OVoxQTM1Q2JkbGZqRjNjcEtQVjh2TXpQdFY0VFFZMzljenZmQzBsUW5PRHFr?=
 =?utf-8?B?K1FCeHJ1MVBGQ3dFdUs4MER2YThkcEhQbzl5T2lQYjVvV0swQ0pOZFUzT0ps?=
 =?utf-8?B?QjFubjZPV2FVZExKb3VKVVA3a0ZpWmZvOTVvYWViTXhQVDEvdm1nK25WNEpD?=
 =?utf-8?B?Ly9VT3NMZG5jUzlrS1hTWmZJWWplUzZsYzg5bkNkbzZOeFhkMExqYzVZd1RJ?=
 =?utf-8?B?b2NSMG1mNXFmQXZneXJaSmR5eWdvZGN1MENRK3gwYStFMkx5cEpjcHpCWExo?=
 =?utf-8?B?YjNsbjNEYnJQZ2lQc0R1NXNmakN2U2xXZWhCWDFoZmZVRnBBTHREZkxQdUFw?=
 =?utf-8?B?MytYeUtpTDE4ZWM2WXV4U3g4ZC80Y3VjeTZ4RkFGKzdSMDU2emJCYVkrU3Nn?=
 =?utf-8?B?OTJaTEx0YnZoenVLVDl2bUZrRmg4dWNHZEhrUUplTlVidzdkRlJsVWJhOWND?=
 =?utf-8?B?YmNJL0NHa21ndUg1dGdHcEJ5dFlRcDBVNEREd1ZXNC8wbXBpZVAweEp2bnI5?=
 =?utf-8?B?TEN3cE5pRTNwNTBPQ2ZrbkVCK1c4UGw1OTh6OW1JWk9ScWMxb3dsckk1M1BW?=
 =?utf-8?B?aDVXbFRwa09QZmNYZnZjM2pJQUNWelIrWHh1aFB3NHhQdjR1WlA3UjF3eG5B?=
 =?utf-8?B?VExjMUlmTVFNeHpXcFlpeTJYeDVsWnNIa0Z2Uk5UTXUyMG1yVTJrQXlPb3VY?=
 =?utf-8?B?a2pJNFJnMHBaY0xyYVpWV0FOQjlHRE1hVms1OWJCQkFrWEQ3RGFOczU0TzFa?=
 =?utf-8?B?TVZad2hmNEQ2SjI1QmIvOU5Hbk5sdDFPRlRIOTRoVy92UFdrMkIyMFNMbzd2?=
 =?utf-8?B?L2ZDdGJVRUphc2VpNEM2bi9HNEpSYUZzellYK3F1VVpEcjV2RTdvVTZjMDBD?=
 =?utf-8?B?YjF1ODQ2M0pzL0NjV09xYm4zc29tbnRSck1Fb1VleUwyUXI3cnNQdlAvNU5m?=
 =?utf-8?B?MldIaHNuZW12Yk9qSTI4bVY1amtlUzlzNUZRZkRmRXA0UG5tUlZZbUh6aUl2?=
 =?utf-8?B?SmdUSEdZVE1GTzhqSDd3eXhNeTdoYTlJcWljWHl6Rk9zc1REWkpTYU1wRW1y?=
 =?utf-8?B?Q0dOMnJsalFnR2hnMXRyU2hHdmUyckRFeHlIL1YyS1E0bk5CTzZaMUpiYTc2?=
 =?utf-8?B?N3ZJcHRzcW1aYkpjazc5d3gvcDQ2azJ4aGxFU08xc2RtcVpYeVcvejlGcUEr?=
 =?utf-8?B?WXpmMEloZVRoVDEzYUVRUDZiVC9QaWFTOVBkRWhobVJramxVejcrRzkvWEpL?=
 =?utf-8?B?VVVHdktkWE5IV1ZjUEdQaVRXOUtPeGl6WmdmNVZrbnZtclpFTmxIZmlPYmpt?=
 =?utf-8?B?emNpaTBiZHNpNyswbGtSYU1TZjBaMWM0M2JRK1pFQzcyaDEyYUovbkpnY1k2?=
 =?utf-8?Q?Feg1lN+EXlBovENlyQTlwGFtjQgAA9836HycG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C7C2C938EB26A4D9418F2239DEBE4F2@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 971f5c1d-cd94-4066-d5ce-08de70103013
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2026 23:39:56.1006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8ctRZ2qhfBOaqa8CThfyeWfgPNy+wI7FfX/RbimSCxQc5iru0EBY67I8jSfLnqnehBiGFGiMjSkeJCjE7Zdtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5580
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDIxMCBTYWx0ZWRfX9iDFsiQR2jXS
 DExwsCGGBybeqyCgsRYrZ9sg1tCECPP3e65TFIpWsSSVa4ZQ0EWlnaXOubjzMg8sNbCirRzm1oA
 PNiKcs+hjn3ADaxDJRKPC9Cdvp45GQpc0+/Z+3020Lj3xQBOHTk5MIAK+rt7pxGpOnV3fgdvte3
 zNHfCfZ0gVnkF0a6gAgt2BiXFm0a6P9VJBruHGWs+/FhEZrO7byMQkLb0pmRVB+8duoodeA0BLx
 XnpomY3vkDk0sZF8u+xC2WPwYbnf+8nMaUFoNup/U60rXx83g0WIieLchwLeUHH59zXZlORAeKR
 bof6mf5leN9/jWKHTO9zz2nuRkWr0W61ThIWT/yQFMSmECfQ5Czmwlsm5LbJ9Q6qPAiTXiR6jg8
 OpewZMiTZSMO75BCsNRze0f2v1bvuCOR38AIEg8Tx0CoOTpfx0wqpNBwL4FvfvuJnpyTtU1qKuB
 eBmLf5UPxGc6k+949UA==
X-Proofpoint-ORIG-GUID: AqK4JG8RTIRBd0xklTAbDZW5hcDBrIWp
X-Proofpoint-GUID: AqK4JG8RTIRBd0xklTAbDZW5hcDBrIWp
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69979f4e cx=c_pps
 a=5tz+rB/kfTqQMEo17N6B4w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=9tbf9WehI1aumuMr2fUA:9
 a=QEXdDO2ut3YA:10
Subject: RE: [PATCH] hfs/hfsplus: fix timestamp wrapped issue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_05,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190210
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77750-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2E013163915
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTE5IGF0IDAwOjQ0ICswMDAwLCBDaGFyYWxhbXBvcyBNaXRyb2RpbWFz
IHdyb3RlOg0KPiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3Jp
dGVzOg0KPiA+IA0KDQo8c2tpcHBlZD4NCg0KPiA+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ID4gKy8q
DQo+ID4gPiA+ID4gPiArICogVGhlcmUgYXJlIHR3byB0aW1lIHN5c3RlbXMuICBCb3RoIGFyZSBi
YXNlZCBvbiBzZWNvbmRzIHNpbmNlDQo+ID4gPiA+ID4gPiArICogYSBwYXJ0aWN1bGFyIHRpbWUv
ZGF0ZS4NCj4gPiA+ID4gPiA+ICsgKglVbml4OglzaWduZWQgbGl0dGxlLWVuZGlhbiBzaW5jZSAw
MDowMCBHTVQsIEphbi4gMSwgMTk3MA0KPiA+ID4gPiA+ID4gKyAqCW1hYzoJdW5zaWduZWQgYmln
LWVuZGlhbiBzaW5jZSAwMDowMCBHTVQsIEphbi4gMSwgMTkwNA0KPiA+ID4gPiA+ID4gKyAqDQo+
ID4gPiA+ID4gPiArICogSEZTL0hGUysgaW1wbGVtZW50YXRpb25zIGFyZSBoaWdobHkgaW5jb25z
aXN0ZW50LCB0aGlzIG9uZSBtYXRjaGVzIHRoZQ0KPiA+ID4gPiA+ID4gKyAqIHRyYWRpdGlvbmFs
IGJlaGF2aW9yIG9mIDY0LWJpdCBMaW51eCwgZ2l2aW5nIHRoZSBtb3N0IHVzZWZ1bA0KPiA+ID4g
PiA+ID4gKyAqIHRpbWUgcmFuZ2UgYmV0d2VlbiAxOTcwIGFuZCAyMTA2LCBieSB0cmVhdGluZyBh
bnkgb24tZGlzayB0aW1lc3RhbXANCj4gPiA+ID4gPiA+ICsgKiB1bmRlciBIRlNfVVRDX09GRlNF
VCAoSmFuIDEgMTk3MCkgYXMgYSB0aW1lIGJldHdlZW4gMjA0MCBhbmQgMjEwNi4NCj4gPiA+ID4g
PiA+ICsgKi8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaW5jZSB0aGlzIGlzIHJlcGxhY2luZyB0
aGUgd3JhcHBpbmcgYmVoYXZpb3Igd2l0aCBhIGxpbmVhciAxOTA0LTIwNDANCj4gPiA+ID4gPiBt
YXBwaW5nLCBzaG91bGQgd2UgdXBkYXRlIHRoaXMgY29tbWVudCB0byBtYXRjaD8gSXQgc3RpbGwg
ZGVzY3JpYmVzIHRoZQ0KPiA+ID4gPiA+IG9sZCAiMjA0MCB0byAyMTA2IiB3cmFwcGluZyBzZW1h
bnRpY3MuDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBGcmFua2x5IHNwZWFraW5nLCBJ
IGRvbid0IHF1aXRlIGZvbGxvdyB3aGF0IGRvIHlvdSBtZWFuIGhlcmUuIFRoaXMgcGF0Y2ggZG9l
c24ndA0KPiA+ID4gPiBjaGFuZ2UgdGhlIGFwcHJvYWNoLiBJdCBzaW1wbHkgZml4ZXMgdGhlIGlu
Y29ycmVjdCBjYWxjdWxhdGlvbiBsb2dpYy4gRG8geW91DQo+ID4gPiA+IG1lYW4gdGhhdCB0aGlz
IHdyYXBwaW5nIGlzc3VlIHdhcyB0aGUgbWFpbiBhcHByb2FjaD8gQ3VycmVudGx5LCBJIGRvbid0
IHNlZSB3aGF0DQo+ID4gPiA+IG5lZWRzIHRvIGJlIHVwZGF0ZWQgaW4gdGhlIGNvbW1lbnQuDQo+
ID4gPiANCj4gPiA+IEhpLA0KPiA+ID4gDQo+ID4gPiBUaGUgY29tbWVudCBzYXlzICJ0aW1lIHJh
bmdlIGJldHdlZW4gMTk3MCBhbmQgMjEwNiwgYnkgdHJlYXRpbmcgYW55DQo+ID4gPiBvbi1kaXNr
IHRpbWVzdGFtcCB1bmRlciBIRlNfVVRDX09GRlNFVCAoSmFuIDEgMTk3MCkgYXMgYSB0aW1lIGJl
dHdlZW4NCj4gPiA+IDIwNDAgYW5kIDIxMDYiLiBUaGF0IHdhcyB0aGUgb2xkIGJlaGF2aW9yIHZp
YSB0aGUgKHUzMikgY2FzdC4NCj4gPiA+IA0KPiA+ID4gWW91ciBwYXRjaCBjaGFuZ2VzICh1MzIp
IHRvICh0aW1lNjRfdCkgaW4gX19oZnNwX210MnV0L19faGZzX21fdG9fdXRpbWUsDQo+ID4gPiB3
aGljaCByZW1vdmVzIHRoYXQgd3JhcHBpbmcuIEZvciBNYWMgdGltZSAwIChKYW4gMSwgMTkwNCk6
DQo+ID4gPiANCj4gPiA+ICAgT2xkOiAodTMyKSAgICAgKDAgLSAyMDgyODQ0ODAwKSA9ICAyMjEy
MTIyNDk2IC0+IDIwNDANCj4gPiA+ICAgTmV3OiAodGltZTY0X3QpIDAgLSAyMDgyODQ0ODAwICA9
IC0yMDgyODQ0ODAwIC0+IDE5MDQNCj4gPiA+IA0KPiA+ID4gVGhlIG5ldyBzX3RpbWVfbWluL3Nf
dGltZV9tYXggYWxzbyBjb25maXJtIHRoZSByYW5nZSBpcyBub3cgMTkwNC0yMDQwLA0KPiA+ID4g
bm90IDE5NzAtMjEwNi4gU28gdGhlIGNvbW1lbnQgbm8gbG9uZ2VyIG1hdGNoZXMgdGhlIGNvZGUu
DQo+ID4gPiANCj4gPiANCj4gPiBPSy4gSSBzZWUgeW91ciBwb2ludC4gU28sIHdlIGNhbm5vdCBl
eGVjdXRlIHRoZSB3cm9uZyBjYWxjdWxhdGlvbiBmb3IgdGltZXN0YW1wcw0KPiA+IHRoYXQgYXJl
IGxlc3MgdGhhbiAxOTcwLiBCdXQgaXQgd2lsbCBiZSBnb29kIHRvIHN1cHBvcnQgdGhlIHRyaWNr
IHJlbGF0ZWQgdG8NCj4gPiAxOTcwLTIxMDYuIEhvdyBjYW4gd2UgaW1wcm92ZSB0aGUgcGF0Y2g/
IFdoYXQncyB5b3VyIHN1Z2dlc3Rpb24/DQo+IA0KPiBXZWxsLi4uIHRoZSB3cmFwcGluZyB3YXMg
dGhlIGJ1ZyB0aGF0IGJyb2tlIGdlbmVyaWMvMjU4IHJpZ2h0PyBTbyB0cnlpbmcNCj4gdG8ga2Vl
cCBpdCB3b3VsZCBqdXN0IHJlaW50cm9kdWNlIHRoZSBwcm9ibGVtLiBBRkFJSyBzaW5jZSB0aGUg
b24tZGlzaw0KPiB0aW1lc3RhbXAgaXMgYSAzMmJpdCB1bnNpZ25lZCBjb3VudGVyIGZyb20gMTkw
NCBpdCB0b3BzIG91dCBhdA0KPiAyMDQwLiBUaGVyZSBhcmUgbm8gc3BhcmUgYml0cyB0byBleHRl
bmQgdGhlIHJhbmdlLg0KPiANCj4gVGhlIG9ubHkgd2F5IEkgY2FuIHRoaW5rIG9mIHRvIHN1cHBv
cnQgYm90aCB3b3VsZCBiZSBhIG1vdW50IG9wdGlvbiB0aGF0DQo+IGxldHMgdGhlIHVzZXIgcGlj
ayB0aGUgbWFwcGluZywgc29tZXRoaW5nIGxpa2UgInRpbWVyYW5nZT0xOTA0IiBhbmQNCj4gInRp
bWVyYW5nZT0xOTcwIi4gQnV0IHRoYXQgd2lsbCBpbnRyb2R1Y2UgYSBsb3Qgb2YgY29tcGxleGl0
aWVzLg0KPiANCj4gSU1PIHBhdGNoIGlzIGNvcnJlY3QsIGp1c3QgdGhlIGNvbW1lbnQgbmVlZHMg
dXBkYXRpbmcgdG8gc2F5IDE5MDQtMjA0MA0KPiBpbnN0ZWFkIG9mIDE5NzAtMjEwNi4NCj4gDQoN
ClBvdGVudGlhbGx5LCBpdCBpcyBwb3NzaWJsZSB0byBjaGVjayB0aGUgdGltZXN0YW1wLiBJZiBp
dCBpcyB5b3VuZ2VyIHRoYW4gMTk3MCwNCnRoZW4gd2UgY2FuIHVzZSBzdWdnZXN0ZWQgbG9naWMu
IE90aGVyd2lzZSwgd2UgY2FuIHVzZSB0aGlzIG9sZCB0cmljay4gSG93ZXZlciwNCml0IGlzIG5v
dCBjb21wYXRpYmxlIHdpdGggTWFjIE9TIFggZGF0ZSByZXByZXNlbnRhdGlvbi4gSWYgd2UgY2Fu
IHNlZSB0aGUNCmNvcnJlY3QgZGF0ZSBvbGRlciB0aGFuIDIwNDAgdW5kZXIgTGludXgsIHRoZW4g
aXQgd2lsbCBiZSBub3QgY29ycmVjdCBkYXRlIHVuZGVyDQpNYWMgT1MgWC4gSG93IHJlYXNvbmFi
bGUgY291bGQgYmUgc3VjaCBhcHByb2FjaD8NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

