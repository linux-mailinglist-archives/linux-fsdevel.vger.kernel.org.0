Return-Path: <linux-fsdevel+bounces-42541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5BFA43009
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 23:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D4617ADA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7052063EB;
	Mon, 24 Feb 2025 22:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h2e9kvbE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E11FFC7F;
	Mon, 24 Feb 2025 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435906; cv=fail; b=DqpCL3n+bUX9azTlBoseUHEpPHRDI4ZicBcEkRtnHFL6K4Cmi7bzEv1YK7RpnyM+WdB/JgvK30UbnXyMZI5WFj2ODcJwr1wxlYcKpF3Q37uQKgdRTicjakyCjxASf6/JFToptfETwdh63KBKF0XXrW/xYq/BlBhHrlSKOf/4df8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435906; c=relaxed/simple;
	bh=aLXLwaoZPC/67j6tgaN/7GeL8PiOkRPIQ6/kPsIIQA8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=rhT3rBzWxjjk1puPJo439nWu1vg5Qm8PW6KRLJBkYhnQMsO7v+DwMjsaoMnTqETKN/qD2qMUNhlC94dCYXDV0Fns4NhmycwLg0QdJB3ePCbLEy663fG24uUcySunXo8oPVq6WdpWIkbVvDQHWKs6coYhXg1dHPiYF7d/HVX6mU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h2e9kvbE; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OENg0A025061;
	Mon, 24 Feb 2025 22:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=aLXLwaoZPC/67j6tgaN/7GeL8PiOkRPIQ6/kPsIIQA8=; b=h2e9kvbE
	RVt3C8v5VEEAbcC33sJ77C1phdfb0icrEc0KBDZqSDU0ouRmEDty7SsAmuTfKQVC
	Bwey0Q6fxG7bLqhV+yKvFUmvKMAxBLltc1h5bvmXnEUXlbMV5htmvFy1ZerKZaxL
	QdZMFSQGJP3nAs71emXuCYtlIp2M5clVrnjuvStHgLHZEOhmS62LLZ7nzd0Hs97g
	GNL/gbf3FikjVHAPZy4H9LSxLbRyQ2mLDtpTKPc2VBPTsbvLmo53bbGtltX1BH1r
	b6FTjwva1lDP4hsadjh/GyUYAsEGfDFkxavd/vhI6iw4NoWvIosFf6c/mMQB9q8b
	TH7jYnRtXVKPNg==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450eu9w8te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 22:24:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDAQcXzSCVz/+ssaH3D/EL5JLCioO/Z/oUn8ez7dcWG14GNPDZd4KjlHRiDMLmO6AmTIQn1Ek0RHLt4CQpGAvqyk6sppPB7q0L9MrRdD4yd03oeltYDSfirAZH7fc2hOvT4SoTKmaW2ThsODeOIedqpl0Vnce8qUn6tpHLZwD42PqzUjtQSa9dEgm6JitlVaBlKmlLDeNJL5DjbwTdMkTmLP63dy6RX0JltPrh5RtOsZVchsRww+2xkLKE6jPx/irXYxnkp13xW9l/IA+xaDYLcjrr2Axe12v9BD8GtDj5zsVDepyiNUSIu8wDK1HZKXTuzB1eb5RXg3FpShf8pzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLXLwaoZPC/67j6tgaN/7GeL8PiOkRPIQ6/kPsIIQA8=;
 b=rlDRd0iy25siFKs/jhbv1vI/NyB8uh2kJfqPQ5dWSiGbCHpyNWhjjdLT2zcT4GQrHEuAa9sCb0HOjO76kMnI4c2DMRR2+paFWML8e4XFRKZTsmtbdk49FbidMGHi8CErsNSE3QFln3v13kpqXkV16G5WcgvMmVchuwj8iRpsZPyQuC8nNlrEoRlVkjzHlWH342djJDjnCtF0tM2n1CB4k4NwmTBV7dstYGdXtCyy2e8JlARIKXnGjkPAPdCXWqMYgxbYnQp+crntYVakL6FbjXrevonLxuPu+22lNANtuLVd6hoornrxHxtR0AtEzdqOu/UdYO49QYof+5foQV284g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB6237.namprd15.prod.outlook.com (2603:10b6:610:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 22:24:51 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 22:24:51 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        David
 Howells <dhowells@redhat.com>
Thread-Topic: [EXTERNAL] [PATCH v3 10/9] fs: Remove
 page_mkwrite_check_truncate()
Thread-Index: AQHbhKFqlSEJYs6P1UqV2Sco7GBc9rNXDJMA
Date: Mon, 24 Feb 2025 22:24:51 +0000
Message-ID: <37368dc6d9e561ff610f307b0abce583dae73150.camel@ibm.com>
References: <20250221204421.3590340-1-willy@infradead.org>
In-Reply-To: <20250221204421.3590340-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB6237:EE_
x-ms-office365-filtering-correlation-id: c0a10aea-5600-44bd-c0e9-08dd55220e35
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZkxrRGE3VWhoVlByVnQxYjk3aERnVGpFMlNFcHJLanBsTERxNk9adi9zOGpC?=
 =?utf-8?B?ajJlanRHc2YyYUlWSHhiQ1lTanY2aW9IK1RvRkE5bnRsR2ZvMWh2Wi9LdlMw?=
 =?utf-8?B?QzBsS3hpdGtZUUFOaXUwbXllaERZRlFiZHJLV3hPQXRPbERFNGEzakZMd1NG?=
 =?utf-8?B?OXR0YmNiQUxnRHZQUnU0ZHI4NXRaTU45VFlTWnNIVVRZWDZNSCtYUm9tSlFt?=
 =?utf-8?B?cjZGb3NvVGVZeU9kdTEvNW5uaGRpQjBtWURDdUNWcnU1UHVSQ0hVMDJvWDcv?=
 =?utf-8?B?SWo3dXJFaGhrWC9aN09LZ2VGaWdUY3JpczFYaW4waE9JUXg4VkFQdVpLNURv?=
 =?utf-8?B?bU5EaU5EQnZUdllsN296VXIyWWVRZWtDakFUNjZWRTV6Z1hISkh0V0JTVG1J?=
 =?utf-8?B?VmxZbDBTYU80c3dwSlFoVXZLZnVTWjRIR2FOY2k3QlZGUGRQY3VyUDd0Y3dq?=
 =?utf-8?B?S3ZHc2pvUks3YlpDeXFyUnQ3ckJMM0JZc2dWWTdacit6ZndvNHRxa205K1ls?=
 =?utf-8?B?WEFVem9pK2JZZVp2M096bzNLWHJQd2JOemI4eGsyU3NHaXpUb3B6OVdQMmhs?=
 =?utf-8?B?ay9lelgzYVV2cGFqdng4UGxTVUlBWG52cDlha1pnZXZmc1BlL0VJNG5XYnB4?=
 =?utf-8?B?Z1lQZzJoTXVtd3l0aXEyQ3czK0tLVUdnbjg1Z2kzVmtDZThtUmRGM3NKZDlJ?=
 =?utf-8?B?SXpBU05tZDdQWWQ0MlhyaGVCVzlSd2kyN2R6VDZHaTlUOWtQMldtSHFSaTZa?=
 =?utf-8?B?RmJaR1NJenFidFQ0eVl1WllVSno4TGtQb1MwaktJRFZBb0w1YnpSR0VuUzdz?=
 =?utf-8?B?eTlKM04zcldPMnc1K1pqb2FyNFllM2ZRdjNva2JqVjg4SWlnS1dtc3pJV3NF?=
 =?utf-8?B?ZklSeXBpT20wWWFDeFZzbmpVTmZ4eDExUVVsU095aStjVTNyOG1rWWUrNER6?=
 =?utf-8?B?VTBJYSswR09QaEVQdm1tNnQzMEZSWE1GbS80UXpNb2Noc2xMeVJ0QlBHc2tJ?=
 =?utf-8?B?Z2VHQUlZZFVpYndKcVJROGd1TVFCamtKSEJIVis2YWlSMUJyMFZxYzRFWUor?=
 =?utf-8?B?QjFvWWdjU04xcXdqeE8zMGkrUC8vdTU2cjZpd1BXdGRaVGc1Q1BsMmpTMW02?=
 =?utf-8?B?TXhZcHo1b2JYRDViV2c0NnMzVUJxVlhGMjZXNWs2QUdJRUpucHhZcThRbjNR?=
 =?utf-8?B?Vlc1RFNXc09ZWDlLZHMwNjVXRDBuNFdXVXA3bkdDT0VrNHAzYnpqdFpuTUZJ?=
 =?utf-8?B?VSttaHA3RDR1K3UxNE90VFRHa01jK0tLMFFzQnlYSkU2U1pQWXhOL1VadUFY?=
 =?utf-8?B?UWdkOUdXR3FGN2hBcGloV29SVUlENXhQTUlRVDM1ZGR2SWdncnBhS1RvR3B2?=
 =?utf-8?B?b1V6OWJDQjg1RUxsWlJWZVJMZTJkZnRobWFVMXZOZlVOS2llc2RPWGlPTTdP?=
 =?utf-8?B?ZW9JKzB2b1o3Q1F4YmpKeG9ULzcrazJLbHpEOE1CeHNDRG9EMGJjbUsxbHNq?=
 =?utf-8?B?U0VKS2ZsWlhhVU9weU1JYW1qcS9Db2VNMFprRFd0cGYxYTFsNWE1Rzh1N3BR?=
 =?utf-8?B?S2dHc3ZqZUhsQzlXN3FtMW96dldUckVGcjVUb0Jpd3NoOTBvM3RFeHU1NS91?=
 =?utf-8?B?SXJFeThYVnpOTXcrZjF4RWRSamtVeWk1SEpEZHA4dDR6cTRQUmcyQWRxUk05?=
 =?utf-8?B?ZFFsdVJWNEQ3aXlsaDVrYUxDckdESGE4QVFCZlA4NXhxSTY2YUh3MDZYMGly?=
 =?utf-8?B?VFJaM2FZWDlLem5oaXhzbitES1BmQW5KTVh0VW93cW5HL21tVStVUXRWNHNM?=
 =?utf-8?B?QW05anQ4SlZQUHBDNncvanJKSVcyUkJXcjRwRTJiL3g3dm9sMmFiNlNQWHdU?=
 =?utf-8?B?TVhEVjdVOGJCVlFSWlJTT004WVcxN01JbDNKcEVzT2YxaTVvQ2xuZWNXbFNB?=
 =?utf-8?Q?MdhYC+G2qQ7YXl/8L9UF/VavvwtO7/pb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTl6dGNmcm81WnllSHpwTW56U3pjZGZMbzhPcm9uNXVubU9kOTB6ZkJsQ1hy?=
 =?utf-8?B?SVp4MjUvOUhqaHdER3JzclMyQnJSUzUraVdKcGYvU3pab2orN3NKbEhKeUdz?=
 =?utf-8?B?R3Z6YzludFduZlQ5eXlwMkZ2WlpKS1ZTT2ZYcDZ3OUk3L0hyZUVsT25NZk1N?=
 =?utf-8?B?dU1ad2tyNC9kSE9wNGxJcGdtTVBFV0V4bXVoSkRaNldtVERQeDR4cGhpVmJu?=
 =?utf-8?B?N3JReTFjUENETmRwZWxORUdQNXZGeTJucUxjTGNRb05GTFhKM3o0R1pFYXdO?=
 =?utf-8?B?TEl1TkxUd0xhM1VtMkgyTXl5S3BSUWFQeDJEbXR5OExQMWg5UkJNTC85Q0xN?=
 =?utf-8?B?dkNuMXhuZ29WZzRzc1c1VG1lVXQ5Q3VsZXhXRUo0NmZBZzd1dVRUSEZOL3Mx?=
 =?utf-8?B?M21TdkpLRkExeWhiTXhVSlZhUzluakt6bVFoMFZNSlNYTDBOVnN6SVVsSXFR?=
 =?utf-8?B?TzF6N3QrL09XQ1AzWTk1bi85ZnRhUWZjTW55b1ZUVk9ybC85dTFaZllYWEw4?=
 =?utf-8?B?RDR0OFNWakFCYXcrVENFY2RDdVJIZUZpNTV3RE5nQTZYUms5ZjFLNCt6YXB2?=
 =?utf-8?B?TWFsM0lLSnM1am5YZlIxOHc4TmdTaEhsZ29PbEZ0aG51MUxtRStKdGxDT0kv?=
 =?utf-8?B?STNZWUxRYTVMOVdsdHEvb2pBUGNQdEpQR1BSZEExMFlKODJRL295UTBCWklI?=
 =?utf-8?B?b2tWTDhOZDV0T1BSejZmb2RrK3Bia29TbVBsVU82ZmlYdWhFWHdjai8zb1RX?=
 =?utf-8?B?NFgydmhhVWtPY2dYeDhOdkRmY2YvcmNFSnQyNkZiZ0QwWGY5UnVqN0wvV0RF?=
 =?utf-8?B?bWFTZjlsbmpvbE1lcERDYzV4QkFidXp4Q3drS0o0azJoMzBab1dTanRZZmgx?=
 =?utf-8?B?aHg3YTMrcTJYZXVCRzZ5NWl4aXluOG4zR1oybWgvc2cyb21QbnVlOStJY1d0?=
 =?utf-8?B?RU9IL28yd2E1NmovYW8vUkxWU0V5N3h1VTZxcXhOUG5kU2xxeTF4cGdsT0c0?=
 =?utf-8?B?NHpYMkxPT1F6djNJR2FmODNOZGthb2JVTzJaWmpVcVlHYkJPaXloQWs1MUlv?=
 =?utf-8?B?WjR4MTJoL21scHV4VEN6eDBqU2JodTZwd0R0RnhFc0hhNlNRZ0ZValNRdENq?=
 =?utf-8?B?RDIzQ2d0ZWN3cndHUXNzVG1lSjltMlUxVFZYeUxLdS90bjV2WVRRTy9WK1Ex?=
 =?utf-8?B?SnBZVHQzZU1WVk5VZmM2TFNpRlBXdTdCYmhneUFBVmg0UnZwcW9LdmUwV0xF?=
 =?utf-8?B?MzlDYWJMQU41Um5XQjdhdGNNd3BYUmdOOWhqRi9RMVRUUmxnV2h1L1dXdXc3?=
 =?utf-8?B?QS9KUUVLTnI3ZW9yZytNWlBNQ2g2eHV1cUgxU1NkaDBpa2hDS1dRYXhTUktr?=
 =?utf-8?B?OE9neEhrQ0NMMkRQMUhjbkkyTDZkME1EN0l3WDZwUGtXSWtBOEdTbmhnRTNn?=
 =?utf-8?B?ek1Xcmk0RndJYm5xME9VZ3hLVklodU9wd3VPZjRvb0hQZHVUbWhHaDgvcmFL?=
 =?utf-8?B?Q3BNeDVkNlV4MnpndFQvZEs2ekVGZURHeDE0RWs4aFBUSDFjaE9xRmt6T1Fp?=
 =?utf-8?B?VnpHYWFzdVA3MmlxdHBackg4OWdRVXJKUFJaOWdTNHk2eTg5Z05JelFiMXh6?=
 =?utf-8?B?aC9Ra1JwNUJwUTFDUWRKS3U3OVNEajNFeithVVRKTEc3VC9lcXFiS2ZKZFZl?=
 =?utf-8?B?ejczUXFQZ0dlUURrcmFIaTlpYmRqbmJGcU5obHBoQWhnaWticzhNR2xIUTlJ?=
 =?utf-8?B?blAwWnMyV0hNMDdOUHJvMTg3QXFrOUc4Y2l3cU9wamtKMlNXRXI5OUp1KzhI?=
 =?utf-8?B?ZDhxRlFnejJzMmlwTnV0Y2E1NXdrVWdtZnJiajdhb3BYem5ucGk3VHhabElE?=
 =?utf-8?B?enRLenFzM1VqVDl5MlZPenFTVkVDOHNKcVZrSk9DYUp3Zy9TVTQvN0xpaFlG?=
 =?utf-8?B?WHZVM1dtbGFxSmlrdytPYnNUZHprcHlONm9GeU8vUFhJQ2JyTWVWVlY1cFda?=
 =?utf-8?B?R0tvVTBWTERVaTlNQnF6ei9MSDBlNWVrSlNZZ0lGUmhDSldacnVFakFtcEo2?=
 =?utf-8?B?Qi9Nc3gyS1lJYStZMER0cDBMQ1dlTDUwc2FBdngwQ2NPNTcrSk9OT3Z6dFRm?=
 =?utf-8?B?bVlCM2VsU2w1SEVOUnUwQzR5dVgrNHVoa1dOZnc1djFoOVgwUWx6b0xHV2ZP?=
 =?utf-8?Q?KqAc+/gydhY1pqoDhBehyIA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48B4BCE6E456C44EAD17CBA4D4C24B74@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a10aea-5600-44bd-c0e9-08dd55220e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 22:24:51.1698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QiGwnnJvtqDvRSLp+07mnwUx6RJhqZnqF3ALeaBIyws+g5sUcM7rqBuaFjq5TpSHKq5YFCPmz0vo07AHM08kkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6237
X-Proofpoint-GUID: NXhHrqKcQ3lEgkLLpLeoOgs6Hr2AZQZF
X-Proofpoint-ORIG-GUID: NXhHrqKcQ3lEgkLLpLeoOgs6Hr2AZQZF
Subject: Re:  [PATCH v3 10/9] fs: Remove page_mkwrite_check_truncate()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240140

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDIwOjQ0ICswMDAwLCBNYXR0aGV3IFdpbGNveCAoT3JhY2xl
KSB3cm90ZToNCj4gQWxsIGNhbGxlcnMgb2YgdGhpcyBmdW5jdGlvbiBoYXZlIG5vdyBiZWVuIGNv
bnZlcnRlZCB0byB1c2UNCj4gZm9saW9fbWt3cml0ZV9jaGVja190cnVuY2F0ZSgpLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTWF0dGhldyBXaWxjb3ggKE9yYWNsZSkgPHdpbGx5QGluZnJhZGVhZC5v
cmc+DQo+IC0tLQ0KPiAgaW5jbHVkZS9saW51eC9wYWdlbWFwLmggfCAyOCAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjggZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wYWdlbWFwLmggYi9pbmNsdWRlL2xpbnV4L3Bh
Z2VtYXAuaA0KPiBpbmRleCA4YzUyYTYzN2Q0MmIuLjc5OGUyZTM5YzZlMiAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC9wYWdlbWFwLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9wYWdlbWFw
LmgNCj4gQEAgLTE1NzksMzQgKzE1NzksNiBAQCBzdGF0aWMgaW5saW5lIHNzaXplX3QgZm9saW9f
bWt3cml0ZV9jaGVja190cnVuY2F0ZShzdHJ1Y3QgZm9saW8gKmZvbGlvLA0KPiAgCXJldHVybiBv
ZmZzZXQ7DQo+ICB9DQo+ICANCj4gLS8qKg0KPiAtICogcGFnZV9ta3dyaXRlX2NoZWNrX3RydW5j
YXRlIC0gY2hlY2sgaWYgcGFnZSB3YXMgdHJ1bmNhdGVkDQo+IC0gKiBAcGFnZTogdGhlIHBhZ2Ug
dG8gY2hlY2sNCj4gLSAqIEBpbm9kZTogdGhlIGlub2RlIHRvIGNoZWNrIHRoZSBwYWdlIGFnYWlu
c3QNCj4gLSAqDQo+IC0gKiBSZXR1cm5zIHRoZSBudW1iZXIgb2YgYnl0ZXMgaW4gdGhlIHBhZ2Ug
dXAgdG8gRU9GLA0KPiAtICogb3IgLUVGQVVMVCBpZiB0aGUgcGFnZSB3YXMgdHJ1bmNhdGVkLg0K
PiAtICovDQo+IC1zdGF0aWMgaW5saW5lIGludCBwYWdlX21rd3JpdGVfY2hlY2tfdHJ1bmNhdGUo
c3RydWN0IHBhZ2UgKnBhZ2UsDQo+IC0JCQkJCSAgICAgIHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+
IC17DQo+IC0JbG9mZl90IHNpemUgPSBpX3NpemVfcmVhZChpbm9kZSk7DQo+IC0JcGdvZmZfdCBp
bmRleCA9IHNpemUgPj4gUEFHRV9TSElGVDsNCj4gLQlpbnQgb2Zmc2V0ID0gb2Zmc2V0X2luX3Bh
Z2Uoc2l6ZSk7DQo+IC0NCj4gLQlpZiAocGFnZS0+bWFwcGluZyAhPSBpbm9kZS0+aV9tYXBwaW5n
KQ0KPiAtCQlyZXR1cm4gLUVGQVVMVDsNCj4gLQ0KPiAtCS8qIHBhZ2UgaXMgd2hvbGx5IGluc2lk
ZSBFT0YgKi8NCj4gLQlpZiAocGFnZS0+aW5kZXggPCBpbmRleCkNCj4gLQkJcmV0dXJuIFBBR0Vf
U0laRTsNCj4gLQkvKiBwYWdlIGlzIHdob2xseSBwYXN0IEVPRiAqLw0KPiAtCWlmIChwYWdlLT5p
bmRleCA+IGluZGV4IHx8ICFvZmZzZXQpDQo+IC0JCXJldHVybiAtRUZBVUxUOw0KPiAtCS8qIHBh
Z2UgaXMgcGFydGlhbGx5IGluc2lkZSBFT0YgKi8NCj4gLQlyZXR1cm4gb2Zmc2V0Ow0KPiAtfQ0K
PiAtDQo+ICAvKioNCj4gICAqIGlfYmxvY2tzX3Blcl9mb2xpbyAtIEhvdyBtYW55IGJsb2NrcyBm
aXQgaW4gdGhpcyBmb2xpby4NCj4gICAqIEBpbm9kZTogVGhlIGlub2RlIHdoaWNoIGNvbnRhaW5z
IHRoZSBibG9ja3MuDQoNCkFzIGZhciBhcyBJIGNhbiBzZWUsIHdlIGV4Y2hhbmdlZCB0aGUgY2Vw
aF9wYWdlX21rd3JpdGUoKSBpbiBbUEFUQ0ggdjMgMi85XToNCg0KLQkJaWYgKHBhZ2VfbWt3cml0
ZV9jaGVja190cnVuY2F0ZShwYWdlLCBpbm9kZSkgPCAwKSB7DQotCQkJdW5sb2NrX3BhZ2UocGFn
ZSk7DQorCQlpZiAoZm9saW9fbWt3cml0ZV9jaGVja190cnVuY2F0ZShmb2xpbywgaW5vZGUpIDwg
MCkgew0KKwkJCWZvbGlvX3VubG9jayhmb2xpbyk7DQoNCkFuZCBpdCB3YXMgb25seSB1c2VyIG9m
IHBhZ2VfbWt3cml0ZV9jaGVja190cnVuY2F0ZSgpLiBTbywgd2UgY2FuIHJlbW92ZSB0aGUNCnBh
Z2VfbWt3cml0ZV9jaGVja190cnVuY2F0ZSgpIGZ1bmN0aW9uYWxpdHkuDQoNClJldmlld2VkLWJ5
OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCg0KVGhhbmtzLA0K
U2xhdmEuDQoNCg==

