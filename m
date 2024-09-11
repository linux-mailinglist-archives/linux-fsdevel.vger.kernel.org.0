Return-Path: <linux-fsdevel+bounces-29114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2799757E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 18:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1863828AE18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0491AD9C2;
	Wed, 11 Sep 2024 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ohzssZsG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YeW63pHi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F781AAE0C;
	Wed, 11 Sep 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070619; cv=fail; b=Pep9itmSy6lAkxIBdXWMwXO1lYZYSpuCrE0q8H2viyaoQpz8vNsbycIiwW6jP6w+1Cy16soXojSm20G6/YTB6cJylUcldlS5yBRyFcOiCnEFhQGhEwklreZFZMU79qJtmUS0Zv0lKcEMyX3k/TTw97sQkE2jGQ111DWfr1QDXUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070619; c=relaxed/simple;
	bh=AKsfAkSiN9HPYbArCG2U1Ae43hUABdGxf9OEnTJV38w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aLTXqYUUE8DT2UO06kR2pkdkdoiy5cpwOpiNN/CiKCq8ut+zJ1h5YS37Y/PhZnXfs6F1HHYcEk0tTsmqLYVHeZjTzoJcE3WNKc7XuU+5KgYzT7/QRAe0A0sMQeeVCeISh04y9/lmxdnuNsLovJMlBPOyvJJ7pDPhRP+EOGo7ebQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ohzssZsG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YeW63pHi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BCgNjH032296;
	Wed, 11 Sep 2024 16:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=AKsfAkSiN9HPYbArCG2U1Ae43hUABdGxf9OEnTJV3
	8w=; b=ohzssZsGnPP5HCcTHxOvaSCvKn17C4AoeQoEqTDxDt7291G0CWPHcVC1w
	w+XD5q5rH9+ZuZZAnl+Quvtm7PaufaS2FU4L12Tled4ds5aZHxS3R8YMSnnrJ8KI
	qnCleRHHJRHoplIpIwuMSQTcF5HAuafFm73j4tAsv5pXBrMGoH3Ols2Rpy93qXID
	0Cm6SVCG+mt9ZM3r3GSXeHO8EQan56nwdGOROn6ORkepxuo//E5EcdMVff3drhRj
	JmWKJ5l704eyP9Pq+hWoRMc/5CcUk7xCojEyArZLepKeulQFSSqROt+h8Uuh7aaW
	OmxDnr6epjgXF6SZW3TQzsaaFa22w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9rjk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 16:03:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48BFfG01040820;
	Wed, 11 Sep 2024 16:03:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9bpfyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 16:03:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3NlpaD/8/crTpUPVPlkLTtC4rtTJE5Ypnwg2eF9+8W64PqhUm+T39aMhylQ3T7xHrv4qO+CBXr+xOHVxRYVaqNrWq4cXFc7RRgeBLBsMk/qMu0uQb5qSZscOL2JWCWWJvrZ2sPjzRcyxnHmNjpUPf/m/O5u3TkeyL8p9uYCmNy2jwfI1J4hAY9SIiEDXfD4pofvt0gQ8OmwirILNYlW5+O5Kqh32Hc4H+tSWx0pJm3akiJIGLww7tIbfsxb8HLEXETg0Aa9EKRbvs1tF+s+RrKdJGAqoZAQ0fSkJ30RIqFl0QjEZ/0Lhrwr1a/mSV6b1/2UEYO0yImIJsQNmdgznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKsfAkSiN9HPYbArCG2U1Ae43hUABdGxf9OEnTJV38w=;
 b=Bc7CnLl3bQyHfKnVBjviVUorBrJc8pVueUeBJ3txSQ+vAv1muvDRQJUvBQK1Xe3PgTwkTMqvSkSMXZVhcqJnlsCe9oqGEC4lairhXu9oZNHq0QGMh3Imb3c33ccQdYL3ZAnpIM0IQLGld/b54wcfvlZOUFyi+Ad/BOomW0AvfIPnpt+HJzLwZrrRlGo7SHUGiqWvclOF3Sx7QWDQo7ImAe4U2A7EvUxCrvEUHhIRE7vjjHuremCbUHxuAmT13tbSb5VNHOUctG/2Q0pcCsptUho0K2sez8/9E+VoTHcoSZW9CR26CubYPWOxRSb6EDg5umFesGDJZHjSkpYvsllq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKsfAkSiN9HPYbArCG2U1Ae43hUABdGxf9OEnTJV38w=;
 b=YeW63pHilfNKxF6MxoMZ0fvm4TUwslbUVDs6RtMNqbbjDA3yyVQjn103kpSnxtSoxUfi+uguEiRmFmHWSSpRJwybFj+iZdWf9Kw2tRcvlzpacad7odAM81fBjhQ9eGh8bhnczLOYGRqkMK3UZoA4R3L0aN+amBEjWqgJchmE9L0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4526.namprd10.prod.outlook.com (2603:10b6:a03:2d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Wed, 11 Sep
 2024 16:03:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.003; Wed, 11 Sep 2024
 16:03:03 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Anna Schumaker <anna.schumaker@oracle.com>,
        Mike Snitzer
	<snitzer@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond
 Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Thread-Topic: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Thread-Index: AQHa+/Z3Mom0zo7SI0muKVdY2xT3QLJLLt+AgAaglICAAQC8AA==
Date: Wed, 11 Sep 2024 16:03:02 +0000
Message-ID: <A8A5876A-4C8A-4630-AED3-7AED4FF121AB@oracle.com>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <66ab4e72-2d6e-4b78-a0ea-168e1617c049@oracle.com>
 <172601543903.4433.11916744141322776500@noble.neil.brown.name>
In-Reply-To: <172601543903.4433.11916744141322776500@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4526:EE_
x-ms-office365-filtering-correlation-id: d12e29dd-56ce-4167-e215-08dcd27b3749
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGF0TVVwbkhxWFVhdzhJZy9aRVhRRVdqRWhNZURQNzdWWWFmeDRFaWw4NkRt?=
 =?utf-8?B?S3k1cEh2WmlocG5PSUJQWFVWYU9vZE1zV0xad0dyK1Y4RVZ1QWNqb05jWlIr?=
 =?utf-8?B?T0tBaDVKWU5OSWxPdktGL24reDEzM1MyZjZDYk9FRmpUUHRZMXBuYnA0ZW4y?=
 =?utf-8?B?TGwrVUFVRXVSVk1aWGpUSC9HQkhUZDJxZXdZc2lNNUwycFhOcDVuUG1HeW9F?=
 =?utf-8?B?OHRqZ2V6akVud0t2UlA3a1BGd21uRER2RDFreGUvbnk3cEZxQ0FaSFZwSnVX?=
 =?utf-8?B?ODE3Q0J5Qk5Qc0U4THh4ajZkbkhOYStYMTdaQ0xBNTBZMWFlRTNRWWhKOEti?=
 =?utf-8?B?S21sQThXbmJFT2hnMWVSRnpEQmU1Z2VzNkJPRVRjZk9NZi9ydmxYNXQ4TXpy?=
 =?utf-8?B?eTN1NVUwRXhGMmZKTVB6dEhYZ2JRd0J5aXdXUkg4RU1YQy9Jd1RuendxVWdR?=
 =?utf-8?B?ZzFnME9vUGZsYTlML09ZclFlTUpEQnZ2aC9hbUljSkRObzdPanNNMnhxcTN6?=
 =?utf-8?B?SVlkWWwyalFaU2pKd1BibEoxeGRFMFl5dmNEb2FFeDRFVnZPYkY3M1RoR2cr?=
 =?utf-8?B?dFdHaDNPMUg4NU84OEVST2VySXQvM3RDQjB1UnFkZXJvZklWNzdBZGpmejhl?=
 =?utf-8?B?RjBwUTJESHN2L0wxV3BTNzN2bzl5TFl2eW5VQUI4d2M5ODR3K3hud1o2N2lu?=
 =?utf-8?B?UmVCVTlwcHJJZTc1YWR0bS82NERYVnpPZ2NKZ0ZhOUZOTnhBVWxmTmZPamlE?=
 =?utf-8?B?dmhob3lkU3pNSWViczg3K1llNjdvOUE3SWkraDBMbUtRUndrVXZ3RXZDNUh1?=
 =?utf-8?B?cTYrZ2FPRTVLd1ZxTkMwQ1NFT2QzeWFDbVNYeEpES3NES0ZmRm11OGh5YjZH?=
 =?utf-8?B?cnZPVnFDYlBtUnR3N1R6Rk95azFSaU5rVlNVd2Vybm5EZi9aS0EwZTE0ZFFZ?=
 =?utf-8?B?OXJDNkVXVG92VUdmT2daWmtqL2pkbDBkZ3dFUEFnSklOU3ZEUmxhR0pSLzVa?=
 =?utf-8?B?M2wxWjErWTZZTlVkb2RzTXg1aXZQTTB2Znd0YUgvVWpTRHlZN2NFaklvblBT?=
 =?utf-8?B?MWRkTWxaeHMzdzYyVThHak5Xa1hTUE1BdkRkc2x4OVAxeTgydjlPaWQ0a0Zt?=
 =?utf-8?B?RmNneXdJbE5XU2hFakhMV2JQdU03V29pNDZLNDhCN21ZeDNDSDJSTDhCSHBG?=
 =?utf-8?B?dXVLQVEwaHF1TXg0d09ITEo5c2JoMktyektqQW51S0w1a2lKbmtTQldLSFVk?=
 =?utf-8?B?SUc1UDQ1ZjdSbW00MGorVlR6NmJGYkRIRGpqWHQ4dE45K3lhT01LRTAydmd4?=
 =?utf-8?B?cEExUGUvU1lVT1dwSTE4bFVLcmdXVm4xeE5odFZJWklFdUJ4L3RCOVA1K2x5?=
 =?utf-8?B?UFhtY0crNFNJbmxuNkRqZHR2MHRuNmRTZFhacFNkZUhROSt2WUljUlFyQjNB?=
 =?utf-8?B?eE1Zcld0bDVZYmdqK3NsY0xhRExPblB6N2FBWGdtVFBFdlBlQzJ0WENRQzg0?=
 =?utf-8?B?VUtGNlV3dURtOHJVT0lRY0lKcWtrT3FDTEJpelhsanpKYUdzeVVVbnZYc0My?=
 =?utf-8?B?SWZON2hXeVljeWdKSzBFUUVNR3ZRdVdDVzBHdWFHNWxxbFVCdGNvcC9DQ2Vs?=
 =?utf-8?B?UUgveEpFeGx3cnNkS2JqT01oRlg3aGRCbHJQS0ZGZTlEMThKdjBGYjQ2OXhK?=
 =?utf-8?B?NDc4dmhEV2dGc28vSC82a3cwZkthRSs0aTRNd0hIZzBsdkxnbkR6a3hYVzNX?=
 =?utf-8?B?eVNqYWNzUXpCWGExdC9Wdk9xKzdSM0NsYUV3UG1jdk02VS94Y1NmOHFObW05?=
 =?utf-8?B?RWk0ZjVaSGVZSU9JNlVSR3l4TTl2VVJCQlN3Z3NvU1pDNDVLYmZRZ0dmMmY2?=
 =?utf-8?B?UFFyZjk3bmMwbGZ0OThWOWNld1BBMENQaThmVERMTmRrZ0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWc1dUdZdjJVSVVPdEJwT1lFeVhEeHdwMCsrQjgzSm5vbUkwZlhqSWRLMFdP?=
 =?utf-8?B?V29Pbk83bXZPODBZazBFWXdFQnFUSTNOUVRCVDdUZ3lQQ2FhYXkxUUIyK3N1?=
 =?utf-8?B?V1hTbk5sdHRaS2xOTlgxTTlpaDlzdDBvMWRVRGlmYVFrOE5GM3pLNEVvUUhv?=
 =?utf-8?B?Vi92SVRVVU14N2VQSXQ3YndJSEJpYklJU3h2bU1yQWdUVHdhNE4xVlJZaTF3?=
 =?utf-8?B?ZGJZWXQwbkZCL1ZwZlFjQVU4azQ1a1Y5aGp1QXlPOG9IdjJRZmxua0hLeWhQ?=
 =?utf-8?B?UW01NjhzRE1DbC9NcEMyWmJCdkJJUDd2UEZ3d1U2Vko2L2s5TmgyWDVsZ1Ja?=
 =?utf-8?B?U2tVSzl0bGVmT1BsRkFYN1pGcmZqV3ZQSTR3dDE0MkJOeVBqOEgycTlUR0Vx?=
 =?utf-8?B?aVhsVUE4cUFocklKTlo4QmNwcTB0Skt1NkpxNHcxZy95cnBxczF2dEsxNzhs?=
 =?utf-8?B?TXBVRklvaXNRS3dMK05VTWJOVjhWYXRLRUhTQWFmUTBrQ1dFNEsweE16U2tP?=
 =?utf-8?B?NGIzcFdUazF2cWhYR25sQU9TKy9DSzdMTmxWY2tUQVVpY1Q1Vk44RkRiVnk0?=
 =?utf-8?B?d3F1dVlnQ051aE5WS29MVXhUd1NmeHdqd3hiWUFkbkR5b0FDd1F6cHN6Kzkw?=
 =?utf-8?B?SFI1TnN2V3A1M3kyZWU4REIxMTZ0SWhFYU1JM0ZyOFpuMHdGdUxacXFkMzZm?=
 =?utf-8?B?d3lpS1Ywd3VEOU1BdVcxU1cwMzE2Sm5qQ24wcTdyei9NWnVMVzNEbVpxZ1pI?=
 =?utf-8?B?Nk1sWmNleXhWbmlMTTVHMStzR2cxcXpwM09sRThueXB4YyswOSt4ZldoZS9I?=
 =?utf-8?B?Q05SUmphTUZyY0tIemNReUo0YTRHVUYyS09VOVdOOGpkRzNhR3JFbUJqaGdG?=
 =?utf-8?B?YVNsWUlibit3bDl1QkMvQTl6N2tPMUpES25ST3BpN3lWZ1pKLzl6MnhodHlM?=
 =?utf-8?B?SHZ2QnBVeDU4Q2FBRVBxMFNvNHE5dW5kVDZleGtaRW5tNUUwQzRMMGlwNzlv?=
 =?utf-8?B?ZFhqT3YxWDdlSzkraVhIZEZVNTU5TGk1VjJtUVZ6WTY4YnpQMnpRWTJJQkdF?=
 =?utf-8?B?aFptNFZXdFJaYWNnaGZWeFJXYnJsZEgxdFJCTFJ2WTlhMG8ycnovb2FYaDlX?=
 =?utf-8?B?ZUlER1NFQU00Q2lBUTh5eHo2NEtCZGJhN3YrZ1d0ak1iTis2bUdFcEZqK3Q0?=
 =?utf-8?B?Skc3MjR5UG9wWGMwOHFpeWlwZ2tLZnE4a0JkaGF4UHVRTktOMWFITFVZY2U2?=
 =?utf-8?B?UEIxcjdiSUFHVGNndVZ1bW9MNzMwRjRhdElteHd1YVVSQW1JQVordzdoN2o5?=
 =?utf-8?B?dEJlWlFHQVNvREloTVFmUU1XOFRRRi8ySFJIU0FHb0pnV1dNR2MzSWZQbjQ5?=
 =?utf-8?B?ZG1DK3dJbUllRjdiWDNmN2xKdjdINHdLRkRxT2YrOHZCYThBYVRsMjVibWVa?=
 =?utf-8?B?SjA1S1lEa1FmSHRvNEZTYU1QakVONXY3cHgzcUZCaTAzUnlBOFdQMG1RaEp2?=
 =?utf-8?B?cExKaUlSTHorUGE0UE9NajFtdkUzOFlmWTA5N2g4OGF0MVlwSzA0UllobXo5?=
 =?utf-8?B?Z0hQSTV6cmJrd3NuREhiTmNjTm1sc2prY0lYdnVyMmZzUlhUamk5R1g4YjQx?=
 =?utf-8?B?UEVVcUYyK2trUWtkWi9uanJ2dFdYdW1qVGtNelhKM0dhL25PMHF1WER6eUtV?=
 =?utf-8?B?TUJLSUEwL0llWERkeDRUY1E2NnQxOGJGRHQ0Wk9ZS0h6TmVvS1k1ZGhPcFcw?=
 =?utf-8?B?ZzJyVExwdnpFSFhYVHdFWGk1U0JNNzFSQldGcGYrcXNWdHIxRkRTeHRaeDZv?=
 =?utf-8?B?RmZsOU4zazVvcmhZdEtRRlpwTDhzSGdNWWh3U3I0YkU5bUNKbnZUbndEM1Zn?=
 =?utf-8?B?WjBXQ3lraTY2amxIWnl1WVFsUjl4ZGJlRUVXUjNQc0hUL24zQU96UHI0OE1l?=
 =?utf-8?B?dWhRWnRiY0dmL2tDL3ZmcG9HT2VMVGxEM0RKNHRmd1ppd0x0THFBTXh5L3lK?=
 =?utf-8?B?VFgxajZKT0Y4WHJJVUJWaGhPMTJWNldoM1VSVFd4a0EyOTkwZm96NHA2clJ3?=
 =?utf-8?B?L2NkSGRTVU1keTBsZGx4QUFpY1U1VXdodlpiV1hVQldWenFQZDZ4aktXVmE3?=
 =?utf-8?B?UTdJMGFmWGhweVczL0FJVkt4Tjl5OEphVjJ5M2p6RnlzaWF6VGRldjlKTFI4?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AB9CA55A5D73F4BB7837DBAFEFC92E3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D3gXdMAJu7vRwBN0HLGc1KjI8gCkb6Zi+PAzRiG0lgZrDqJToY1Kl73HvD45per6vB0NS5+jEpuLQ2LaqDzX27DOdvWAsj/AsoCdz2RINvETShpd1SGA3TbkYTX3xGlppHgoyr8ndFrvfEJCRxiBKv+a3L1UZmVLvKfLogLVtg8H13d3rPwZ/+8OfgfkN6uP8j6YVHnHp+WVAOOiO3+6WD/hwc/7qmjtwJpO5GBATF/t8FVqL+8zlO99E11X9xCMGIDN4BMMdFnjW0Dl+D32MchyPyUvmc3CrgIPLTasSFPPpRRPLmxvHrnfADrO4EELeXIa9Ldn/L7eNRm7q9uSBBk2zgkzYCHYHPOkzDWJwubQVat//+J3L/+IyCFQ1f3rtNoeaDe3KAL8w9U2iPVIaj2IGvf+HwawJV7D76wvxcBL1KZVDRgGRSdfMjTF+vuYlf51vxaMwi8e9jLvd6tnFx7AT9FYws30SY+ER4JUagfLI8kyQGvnyaKa9dZEnpZeJlz6fB+rm3QH7eYzr5PJVL6loNSB/NvnKOwNJZYh67x5cICQxYKBU+CxvES3y9Dx7LXj7oO+IEfDWm+YKdMMS3N9qWKZOEGCcjIT/UF+mQ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12e29dd-56ce-4167-e215-08dcd27b3749
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 16:03:02.9803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDNMV5FegsdyrD50POGnGEFnzCXQT8g1zsjGh4hyODJnGbuuIi6g7OG2eW5GZB/WDS2uDvPpBFvKvfm4IEenbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=984 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409110122
X-Proofpoint-ORIG-GUID: S_DiSVSFRg5piZRblfjn3GDxM23Jok5p
X-Proofpoint-GUID: S_DiSVSFRg5piZRblfjn3GDxM23Jok5p

DQoNCj4gT24gU2VwIDEwLCAyMDI0LCBhdCA4OjQz4oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIDA3IFNlcCAyMDI0LCBBbm5hIFNjaHVtYWtlciB3
cm90ZToNCj4+IEhpIE1pa2UsDQo+PiANCj4+IE9uIDgvMzEvMjQgNjozNyBQTSwgTWlrZSBTbml0
emVyIHdyb3RlOg0KPj4+IEhpLA0KPj4+IA0KPj4+IEhhcHB5IExhYm9yIERheSB3ZWVrZW5kIChV
UyBob2xpZGF5IG9uIE1vbmRheSkhICBTZWVtcyBhcHJvcG9zIHRvIHNlbmQNCj4+PiB3aGF0IEkg
aG9wZSB0aGUgZmluYWwgTE9DQUxJTyBwYXRjaHNldCB0aGlzIHdlZWtlbmQ6IGl0cyBteSBiaXJ0
aGRheQ0KPj4+IHRoaXMgY29taW5nIFR1ZXNkYXksIHNvIF9pZl8gTE9DQUxJTyB3ZXJlIHRvIGdl
dCBtZXJnZWQgZm9yIDYuMTINCj4+PiBpbmNsdXNpb24gc29tZXRpbWUgbmV4dCB3ZWVrOiBiZXN0
IGItZGF5IGdpZnQgaW4gYSB3aGlsZSEgOykNCj4+PiANCj4+PiBBbnl3YXksIEkndmUgYmVlbiBi
dXN5IGluY29ycG9yYXRpbmcgYWxsIHRoZSByZXZpZXcgZmVlZGJhY2sgZnJvbSB2MTQNCj4+PiBf
YW5kXyB3b3JraW5nIGNsb3NlbHkgd2l0aCBOZWlsQnJvd24gdG8gYWRkcmVzcyBzb21lIGxpbmdl
cmluZyBuZXQtbnMNCj4+PiByZWZjb3VudGluZyBhbmQgbmZzZCBtb2R1bGVzIHJlZmNvdW50aW5n
IGlzc3VlcywgYW5kIG1vcmUgKENobmFnZWxvZw0KPj4+IGJlbG93KToNCj4+PiANCj4+IA0KPj4g
SSd2ZSBiZWVuIHJ1bm5pbmcgdGVzdHMgb24gbG9jYWxpbyB0aGlzIGFmdGVybm9vbiBhZnRlciBm
aW5pc2hpbmcgdXAgZ29pbmcgdGhyb3VnaCB2MTUgb2YgdGhlIHBhdGNoZXMgKEkgd2FzIG1vc3Qg
b2YgdGhlIHdheSB0aHJvdWdoIHdoZW4geW91IHBvc3RlZCB2MTYsIHNvIEkgaGF2ZW4ndCB1cGRh
dGVkIHlldCEpLiBDdGhvbiB0ZXN0cyBwYXNzZWQgb24gYWxsIE5GUyB2ZXJzaW9ucywgYW5kIHhm
c3Rlc3RzIHBhc3NlZCBvbiBORlMgdjQueC4gSG93ZXZlciwgSSBzYXcgdGhpcyBjcmFzaCBmcm9t
IHhmc3Rlc3RzIHdpdGggTkZTIHYzOg0KPj4gDQo+PiBbIDE1MDIuNDQwODk2XSBydW4gZnN0ZXN0
cyBnZW5lcmljLzYzMyBhdCAyMDI0LTA5LTA2IDE0OjA0OjE3DQo+PiBbIDE1MDIuNjk0MzU2XSBw
cm9jZXNzICd2ZnN0ZXN0JyBsYXVuY2hlZCAnL2Rldi9mZC80L2ZpbGUxJyB3aXRoIE5VTEwgYXJn
djogZW1wdHkgc3RyaW5nIGFkZGVkDQo+PiBbIDE1MDIuNjk5NTE0XSBPb3BzOiBnZW5lcmFsIHBy
b3RlY3Rpb24gZmF1bHQsIHByb2JhYmx5IGZvciBub24tY2Fub25pY2FsIGFkZHJlc3MgMHg2YzYx
NmU2OTY2NWY2MTQwOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkNCj4+IFsgMTUwMi43MDA5
NzBdIENQVTogMyBVSUQ6IDAgUElEOiA1MTMgQ29tbTogbmZzZCBOb3QgdGFpbnRlZCA2LjExLjAt
cmM2LWcwYzc5YTQ4Y2Q2NGQtZGlydHkrICM0MjMyMyA3MGQ0MTY3M2U2Y2JmOGUzNDM3ZWIyMjdl
MGE5YzNjNDZlZDNiMjg5DQo+PiBbIDE1MDIuNzAyNTA2XSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0
YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwgQklPUyB1bmtub3duIDIvMi8yMDIyDQo+PiBb
IDE1MDIuNzAzNTkzXSBSSVA6IDAwMTA6bmZzZF9jYWNoZV9sb29rdXArMHgyYjMvMHg4NDAgW25m
c2RdDQo+PiBbIDE1MDIuNzA0NDc0XSBDb2RlOiA4ZCBiYiAzMCAwMiAwMCAwMCBiYiAwMSAwMCAw
MCAwMCBlYiAxMiA0OSA4ZCA0NiAxMCA0OCA4YiAwOCBmZiBjMyA0OCA4NSBjOSAwZiA4NCA5YyAw
MCAwMCAwMCA0OSA4OSBjZSA0YyA4ZCA2MSBjOCA0MSA4YiA0NSAwMCA8M2I+IDQxIGM4IDc1IDFm
IDQxIDhiIDQ1IDA0IDQxIDNiIDQ2IGNjIDc0IDE1IDhiIDE1IDJjIGM2IGI4IGYyIGJlDQo+PiBb
IDE1MDIuNzA2OTMxXSBSU1A6IDAwMTg6ZmZmZmMyN2FjMGEyZmQxOCBFRkxBR1M6IDAwMDEwMjA2
DQo+PiBbIDE1MDIuNzA3NTQ3XSBSQVg6IDAwMDAwMDAwYjk1NjkxZjcgUkJYOiAwMDAwMDAwMDAw
MDAwMDAyIFJDWDogNmM2MTZlNjk2NjVmNjE3OA0KPiANCj4gVGhpcyBkb2Vzbid0IGxvb2sgbGlr
ZSBjb2RlIGFueXdoZXJlIG5lYXIgdGhlIGNoYW5nZXMgdGhhdCBMT0NBTElPDQo+IG1ha2VzLg0K
PiANCj4gSSBkdWcgYXJvdW5kIGFuZCB0aGUgZmF1bHRpbmcgaW5zdHJ1Y3Rpb24gaXMgDQo+ICAg
Y21wICAgIC0weDM4KCVyY3gpLCVlYXggDQo+IA0KPiBUaGUgLTB4MzggcG9pbnRzIHRvIG5mc2Rf
Y2FjaGVfaW5zZXJ0KCkuICAtMHgzOCBpcyB0aGUgaW5kZXggYmFjaw0KPiBmcm9tIHRoZSByYm5v
ZGUgcG9pbnRlciB0byBjX2tleS5rX3hpZC4gIFNvIHRoZSByYnRyZWUgaXMgY29ycnVwdC4NCj4g
JXJjeCBpcyA2YzYxNmU2OTY2NWY2MTc4IHdoaWNoIGlzICJ4YV9maW5hbCIuICBTbyB0aGF0IHJi
dHJlZSBub2RlIGhhcw0KPiBiZWVuIG92ZXItd3JpdHRlbiBvciBmcmVlZCBhbmQgcmUtdXNlZC4N
Cj4gDQo+IEl0IGxvb2tzIGxpa2UNCj4gDQo+IENvbW1pdCBhZGQxNTExYzM4MTYgKCJORlNEOiBT
dHJlYW1saW5lIHRoZSByYXJlICJmb3VuZCIgY2FzZSIpDQo+IA0KPiBtb3ZlZCBhIGNhbGwgdG8g
bmZzZF9yZXBseV9jYWNoZV9mcmVlX2xvY2tlZCgpIHRoYXQgd2FzIGluc2lkZSBhIHJlZ2lvbg0K
PiBsb2NrZWQgd2l0aCAtPmNhY2hlX2xvY2sgb3V0IG9mIHRoYXQgcmVnaW9uLg0KDQpNeSByZWFk
aW5nIG9mIHRoZSBjdXJyZW50IGNvZGUgaXMgdGhhdCBjYWNoZV9sb2NrIGlzIGhlbGQNCmR1cmlu
ZyB0aGUgbmZzZF9yZXBseV9jYWNoZV9mcmVlX2xvY2tlZCgpIGNhbGwuDQoNCmFkZDE1MTFjMzgx
NiBzaW1wbHkgbW92ZWQgdGhlIGNhbGwgc2l0ZSBmcm9tIGJlZm9yZSBhICJnb3RvIg0KdG8gYWZ0
ZXIgdGhlIGxhYmVsIGl0IGJyYW5jaGVzIHRvLiBXaGF0IGFtIEkgbWlzc2luZz8NCg0KDQotLQ0K
Q2h1Y2sgTGV2ZXINCg0KDQo=

