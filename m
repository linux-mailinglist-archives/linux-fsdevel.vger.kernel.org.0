Return-Path: <linux-fsdevel+bounces-77328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id azUIBVO5k2nf7wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 01:41:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A8E14851F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 01:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC8C8301CCC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 00:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9382673B0;
	Tue, 17 Feb 2026 00:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gjB9Wu3H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAFE1A238C;
	Tue, 17 Feb 2026 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771288907; cv=fail; b=EUS/wP2A2Zaxcx1xzq2hrfhOboCE4SEF3NONQVzLPnJQAgpiuObeSt4Lhn0MtTQWWaahU/Drr4CKeE7u2qWK/vMIlT+UZfG8706P8MytAUcYBOg62Z0ufTCJJLeYa3k3ybt0+4QX5Y7WalfWIR1Pll8a6YmKxY2qInzfljc66Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771288907; c=relaxed/simple;
	bh=RYsDSfMdc0UzE5fyI8fGblnH9s4PuJ1c5v0/OHNN5b0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=GbLB7MorY/6GiA6ALSgVvKJqCg3zQQUW1l/1zKfdCtQqjH/oSy1lbCtoWVzk1s2Xa4pV/YRCiuMWjq016QjE/X4CAZ6PV3Hlha7smhPUkwX2q0ze8+6UasY9KPuPxOCJw4uJpC9MxyCR4pXA+l7CMtTUzg9hAREum8SrZ8R7iUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gjB9Wu3H; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GGoGPX122996;
	Tue, 17 Feb 2026 00:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=RYsDSfMdc0UzE5fyI8fGblnH9s4PuJ1c5v0/OHNN5b0=; b=gjB9Wu3H
	aA0YV4fxpvEy4UebFI4LwTTHf6SD8mGT/i5by4K1iEhwt/sn2AYM8aEc17WZk8jp
	agpc65EcoWQPyjlk5+tS3Z9BwThcA4pUgVjtippuBkfZ0j91HSJyr/TviFR42oDF
	Q3RDb+tNdTyN+91Suc+tcSljkaORvzXy0QMbG3HQMVmudUQabcJ6GowyaVUrwidx
	Ui2O0Lbvbk3h84vBYQFHkfK9BaEgetJHZR/QtRID8hVymsKwmK+dr7Wvq3C8Ffx3
	eKeCNEK60WFaepn3iyjW1JTagqAkI6Mq1ElnE9LbWbmBTlVSDDLNZ4zxNmnIEJr0
	rwZ0ufGao7xFrA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcqsv4u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 00:41:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/jO47HpQtLi0NpUpOhowF6FmDNrcxXEMGdsZW5PYZcFvSActA8EK/qaL6/2Xi1Eh0Zs7zvPqVFQWoMiXTxWIbxp3RxCcCsZpHmyuj3f6RnQpsdhqSskE/WK+RWivLfzL6FlmgshgE+vMYzTYsm5xI82xmhKR7SzR0FI3cnko2phMhCgoArdWtxYnflpwFCshodm5hMkvDuC89Dsafq3M5ZHUh7Ohj2T6RmuQZNrBcsSoCyfwuuWatkEJG9V1soNz+kSAeXafQ9m20P/V2gXt9r9i174hrboyhgFUutJ6U1XroA0Sn+Gr7fWUs5Gnpas0wnB1Pd5WlVt+baIKl4CtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYsDSfMdc0UzE5fyI8fGblnH9s4PuJ1c5v0/OHNN5b0=;
 b=Jdfjmpkne14akc8RpFxYvFzRZ4wSkqhjB64NiYSXvMgGAWLZiPwWGUXRKVWy1vkrq7o2Ipw3c/Q3jweGHf9IqylmQPsNfimH/sXQfBb1jIVAYIQ8ER+iRjVzs1Cr6FnMbM4Ig84KDSFoALwAeDOUQ6LAtNM6Ra9GYTElqzDNVGYTgOTQM3GeKspVfaxZaQ60RWbPGoEwQt78mDA0ucCgWmHUpXtX9SUHymYG/4CuIvM0lbuG1RieYYsM/6a+BqYmuFQWcOkFAAfjGhBB7UjARm4lunZdRAL9+HPxHKxdMbD2JN3JwQkDPbolPEuC2kFuX4Qq4M1s+U9RXBGQn7UnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5344.namprd15.prod.outlook.com (2603:10b6:510:1e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 00:41:33 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 00:41:33 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>,
        "janak@mpiricsoftware.com" <janak@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>
Thread-Topic: [EXTERNAL] Re:  [PATCH v3] hfsplus: validate btree bitmap during
 mount and handle corruption gracefully
Thread-Index: AQHclOtKLfhUmNqRn0mOeRrZ0UkGhLVxm1gAgBKD4gCAAgNBAA==
Date: Tue, 17 Feb 2026 00:41:33 +0000
Message-ID: <54dc9336b514fb10547e27c7d6e1b8b967ee2eda.camel@ibm.com>
References: <20260131140438.2296273-1-shardul.b@mpiricsoftware.com>
		 <85f6521bf179942b12363acbe641efa5c360865f.camel@ibm.com>
		 <ec19e0e22401f2e372dde0aa81061401ebb4bedc.camel@mpiricsoftware.com>
		 <c755dddccae01155eb2aa72d6935a4db939d2cd7.camel@ibm.com>
	 <de25fb7718e226a55dbc012374a22b7b474f0a0a.camel@mpiricsoftware.com>
In-Reply-To:
 <de25fb7718e226a55dbc012374a22b7b474f0a0a.camel@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5344:EE_
x-ms-office365-filtering-correlation-id: e71f1932-d8e5-4206-0ee1-08de6dbd4c90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWJjVkdZaFhDbW1WOTdzSnpYM29SUnozM3RhWWU3bUlRaERYVWZGZnMvQTlU?=
 =?utf-8?B?dWlGTjFFaGh2OUFtNC9HaDE1bElZTTNBU1VVN2FlS0VnRjNjaEJLUG1FWEFh?=
 =?utf-8?B?UDdHY0FCWnVYZnlRbjFPZHgvOEJ6ZlRDc2FuM0ZoN2RvaXp5dmE4cVMzeHhH?=
 =?utf-8?B?VVpEelg1QlFjQXFZZWhwc2JRc3AyVFk3SHZ6RU5UVmxYTE9FSWFwZDRZRHFy?=
 =?utf-8?B?U3NMcTJVNmJSY3RtTVZ6bUpFckgwaDVyNGs3WmRncWdDMVBoYjJLb3AxdGdN?=
 =?utf-8?B?YWtFYnpDNDE0V0t4aGNzZjhmbmNpakJiazRDMVJjdXdpbDlOZGtWM1FxUHM2?=
 =?utf-8?B?TXN2dzE5SXZ2eElYNXlwTUErNUtEZThlRWM3VXd0SGFuRXM5d2lad1hhbEs4?=
 =?utf-8?B?VEN1dGlJa05jdmRGRlNnN3hHNFY4RmJXbHJhd1VVcXNSdndVNHVIV2w1eXJz?=
 =?utf-8?B?SjE0T3RQc2l3L3hrbnZZZ3p5ZGk3V2ZlUDRqZnRoV2VUOWMvOEg1OU0rRUpD?=
 =?utf-8?B?allJcE85VERudDZ1QWNmU3pSZG1HUUJuR2hna1dqY2hXWWwvbkk2VWREZk9p?=
 =?utf-8?B?UXZTeUtTZVYxbDNhcUo4THFPdFVhdHdyYlYyc2FzNTRReVJVRWlIU2lDK3RI?=
 =?utf-8?B?QjNpcTNhbG0wU3Zkc05hRGdBZ214cDhMT2ZRaUI0ZG02MGV6VmxBLzRaZGJI?=
 =?utf-8?B?K09SL3U0eWlEM0lDWjBtVXhmRHRFd3hoalZkc2xnTHE5WC9jL0JOa09TSVor?=
 =?utf-8?B?QTJGK3RvcjE1OHVyMUIvOEdHMUVoVG4zcEw0VnpKRWNBOTZSOTRRTndEQmZm?=
 =?utf-8?B?bjNGMVYzWXJpWlk5SklYQklWMXNNRnVxQmsvVk5XMHBBR08wZlRVT0lXQk9F?=
 =?utf-8?B?bGd0YThOQW4xRFAxamN2ZXZ4bmpmT25UVWwwczFTK09OWlZHUUFNS1Uwb3Ni?=
 =?utf-8?B?YXdUMGxCbUxuMmR5ZHVHdDZLSFZzK2hjVW5hWnpRdVo4aWdGdkREY3ZXSVJW?=
 =?utf-8?B?VjFIc1lwcjJ0b09zamlnU3VnSXpnOVFxUFlWdnR2SU12Q0pEK3pEamMxT0RG?=
 =?utf-8?B?N0lKcy9KaWxPMjFxSHhpdXFSM09tV2FJVk1sN2Vub2xnbGhJS1RwZit5aVA4?=
 =?utf-8?B?QzdPeHJxNDR4THhFZXFUVXBrK3FKUTJoRGxqdjlZVlRrUEorWE1UVGhrSmcz?=
 =?utf-8?B?c2c5ajNvcXdMNGJLZ1Y1VC9ObkNQUHNsUFNob0IvQjNrSUphbnNhZ0g0Yys0?=
 =?utf-8?B?SHZrZjNkZS95ZktxRHJHdjNIZ0tmbG5QaXJQejEzeUo5WHdqM25FblQrcDhS?=
 =?utf-8?B?bGVTSVp2Q3lSVnk5SjREUG4yeWczbGhVaVdZNjN2angzODRMTHRrY2ViQVRz?=
 =?utf-8?B?VjZmMklCZmRxWk9MRU5JU04xWGgwNXRYNnNLYmpQTFRUMFU4ZStoZkVVSWhB?=
 =?utf-8?B?U1pvSzRMeENvSkZWSXVBUFZvd090MDNxdnpkK0RHa0RxSC8vN29YamJ0bGFV?=
 =?utf-8?B?WFJ3N2lPbVA1YzdsYjdXOUpNZzlZOEFWOUN4VU40UjF5MTlwamE5dWFNaXZV?=
 =?utf-8?B?Uk5lbDdSRnlCRVZsLzBucWxKM3JaMkNGd3Bta0twcnRNR2x5QnRTcS96dEhn?=
 =?utf-8?B?UzZoQjdYN0RjMU1PbXNRUkV6NWpvclF5M2Q4UStJS2psbThvK0k2aitMMzNX?=
 =?utf-8?B?Q1RDOTV5ZlpURm5WeU5XZzZPWWg4M3R6SnV2N3p4SUl1UFQzSU96ZVhjRkdw?=
 =?utf-8?B?OFcvS0FsSGh3ZTMrZ2dUc291ckhQb3VQT0JLaWxVRktneExFOGk0UmZFRzVC?=
 =?utf-8?B?QUlDVlVNK1ZTNVNOMEtuMUV4emN1V05sa1h2UElVNUJlTTQ0UStuKzdsT3lh?=
 =?utf-8?B?bVhEZFA0aTMxblkxVTBXZDRzVVlweG5xallGcUdWOTJKK0ptalF0L1orTHJ3?=
 =?utf-8?B?eDBpUVFVOThYRkRTQndYZStORVNjNksxRzJNRHVKQmRBS2gvdEtjdnZCeFI2?=
 =?utf-8?B?bjFVTmxoTEs1S3lqSUc2R3Njd1VmWmhxeEhjc1lLWHBadXBaOTBwVWhpblYr?=
 =?utf-8?B?aVRZNk9GWlFRQWZ3WlRoaE9uS0oxOVBzakpSVk9XQ3o5YTRuRHZ3YXJaWWNP?=
 =?utf-8?Q?4ThoxG0YAgsa3PexasudXmqcw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SU0zNFRPTDNMT2dKZUIzM2kzV0JFdGFTK1hpamt3ZGhLNmdaQ1NjLy9XMS84?=
 =?utf-8?B?alFOVFJwQm1QaHdlM0ZJSmRVS01IMENXN2VqVm9xcXpZajgzcEhrRGxMSGI1?=
 =?utf-8?B?bDRTcVVlVTBKYjVoTE9pRllyYjJiUEVFK0s2VEV1L0F6NHUzQmc2c25RUFU5?=
 =?utf-8?B?TzAwU0wwS0V4NnJYOWtqNklXWjR3NEVVenNGT3U4V09RL1NiOXp2Q2REeGFL?=
 =?utf-8?B?R0tRTnlUSm5VQW1YSGp0UncvYzcxKzQ0c0l2cmYyUi8vNmtmUVBzS2lZR2pJ?=
 =?utf-8?B?R0ZVN2YybE1QdzBvYWpZZnRrcmtNUDhRdFdwZ3NrdCtGNnFZWlk4TzBWUUN5?=
 =?utf-8?B?NEMvTEZJcDl1UUdjc3RYdEpHaTc2Q1lhRy9YZU50NU96L0RvalpiMG1JM244?=
 =?utf-8?B?bXYvd2M1Z1RESXVnOHJjSXdidXUwU2dVb3JIUitUNTFYVGlreERwVUplQUhi?=
 =?utf-8?B?SHNzcWdieVU4RVRyRC8rRUY2ZmpJRFk5WXA1ekZyQlA1RHVjTGFWOUJyOGl4?=
 =?utf-8?B?eGtXbUJmRjFJNys4Z1hXTEwyNGE0VXg4ZmJiM3FlcW1keTJicndxR2M3ZnJm?=
 =?utf-8?B?MkRwZlFQVzUrMWRRSTQ4TFJ4M1Z4RVZnNEF4azdvQnU4Qy9QUi9TYm9OQlB4?=
 =?utf-8?B?UWV1VHprbjkycUUvWjg4MzMvUVlrdGZMcGhvKytXNC94b1k1ckdUTlZRRTlN?=
 =?utf-8?B?Rjh0Y1JKd05CTW0xenNHekFhL3lpUEovYXZ6cXd4ZElrY0c2UzBqMmdrc2p3?=
 =?utf-8?B?dXhMQisvTkdwWllYeDdWWkJBTTgyTk92OUZIbjdERDdINjlwUW5ObFROdk83?=
 =?utf-8?B?UHg0dkRvQWF4VDFrN1E1QzJsK3A3L1FNeCthek05RzhvSVowd1lTY3Q0ZkU0?=
 =?utf-8?B?SFprejNMWC95V0MwekFVNlhkV0NWa0J1MnU2dG9SNENSY0xoendEczhHQjky?=
 =?utf-8?B?UDdKQXVQSndyam51cjNNbUplbDJnUkg3VTJhNmdpK2lqWGN4QU1KZUJtOVEv?=
 =?utf-8?B?cFFXTVVyNzN4Q2hYdE5CR1RDQ21aSnJxVCtGY3Z1MG0vM2IrSVJaMzI2NlBr?=
 =?utf-8?B?V1hwdVdXUmNtZGxobGMxWmFXQmdlMXhkL0lDNVBlcUhUUmJYTWRhTkw3RzMz?=
 =?utf-8?B?WXZFamREeWpTaG1BTThBS1VxTnRBdkRsZHVFZDZ3b3E0Q1ErU2RDN3FYemsw?=
 =?utf-8?B?cXBFVklSS1Qyb0pCNzQ1OEhPeWdnbGduLytJSDhnY3pqNVVKOXhISmx2bHE5?=
 =?utf-8?B?cm5ITjhib2lJTnZpVmNpZDZSdkpjbkVkWmJHaTNzOVV6bmorKzRuS3VRcEFz?=
 =?utf-8?B?M3B5WHU5dlVmdUkwR2cvaXp6a0V0akJJRXkwTVhVaENxbTlPZFNkeWZRdmhH?=
 =?utf-8?B?TWpaMkx5QWFwT1pveXBINUlQK084UXdZZ0pWWVBla0dJNkhIMXhyRlFDQVcy?=
 =?utf-8?B?ckkzTjBxREplVS9nRVJRaDlnWndXUmhtTThha3h4NGxmOEdCSkZKNWZmOU9l?=
 =?utf-8?B?L0RhS09TOVVRVE1kVTNWVldWcFA3VG5nYi95MlJvcmhldzRsN041bkM5OEQ2?=
 =?utf-8?B?enNvczVjeUNVTTNlZVVOYks4blFhcDV1ejhyK3pSSWxFdnhvRUY0UTVSMmcw?=
 =?utf-8?B?M0FVWFhEV0poMXdMQTFJUFZLSkxGVUNPUlhtVk9lb0hGTUxKY0FXUHo3VjFz?=
 =?utf-8?B?S2FNWVdxQzM0ME9FMWZqUk1iTmRIQ1NNUzJjNCtFdWt2L2crbFF2NEhoVDFP?=
 =?utf-8?B?dFZaUVVvV2FIN0FNV3BXV2cwYjl4bUpCdGhDMjVJMllTVHJyRUNjOEw0amY2?=
 =?utf-8?B?clpVT3d0UzVsbHBCZ2lSa1lXZGZJeUExekF6eXFISTZkTmV0U20zNDRXVytO?=
 =?utf-8?B?MzJNd2dZN0h4SXEwWHpjTDBXVVY3NTJZQnAyeFV1eDExdG5QdmJKNkJPRy9m?=
 =?utf-8?B?aVBoV2MxSWVtZzRKKzMyTWtOVWh4eVFOV0hjUFJrZytlbkREcXRySXBzUXpO?=
 =?utf-8?B?NzcyTURFTkwxd2ZjSVFnM1RTdTRQeWsvcEI1MHlCMi9heGZHRGg1ZjRtK2ZY?=
 =?utf-8?B?UGo2eTgrV25sZnpxcDN2akxvTG45UTJwaE81OEVpMGdoODZpdFN6UDJMV2lE?=
 =?utf-8?B?aUU1amw5NzYyOWI5bVRwTk9idzV0WUpleFN4SkZlMjFJeWRQUVFNRzJsVy9K?=
 =?utf-8?B?YXBjckNvVGpKcFVOejFQNUlqUWdYVjBJbTBLZmlDMTd5Y0Z5NUsyT1NGOFJE?=
 =?utf-8?B?amkyYWJUWFo0ZE8wbzVhMHFhVVNzcWllb05ibmxDRVZwSzgrQzlmNU5QbUJ6?=
 =?utf-8?B?bDB0dlJwdjBlZ3Q4L0VBYXJEZlV4RWxVRi9mbmRaR3BMaUZxSkVaTm1XVGJU?=
 =?utf-8?Q?glPEH0M3YUI+bx3EYUS8xcmkXqfsUzyY9zEhv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A4B8FCA5B505443BDBC3062EBE49CB4@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e71f1932-d8e5-4206-0ee1-08de6dbd4c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 00:41:33.3841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9qelnlZ1nvs0+uJr/z1v2oClxgBxJCcEBWc5JR+4m7ietCLqFKOWVv804WU+CZIjhH7bvehRtv3IVz+7KBEyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5344
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: I7fcid6HUCEhqrlfwgIQfXTACJiFNn0i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDAwMyBTYWx0ZWRfX2EEQlptA24g8
 3lHo8HwgRAxJCJYF5WhL6r71iBiuzZ9hYpN+ZXl6c3l3u3/+RnqXW19jEhiYDXKGJgdEwziI1fK
 t1cgH7AEkVKzk+xF1m1Mpqxg8hCErK92DMuJpOAkCOVyQRAvkh4i4wzAq/MAsqW30B2vkNLI0py
 BXSsRB/pWvCxFfIkQfsmmkyCLkq2znMEhHEjfCIxOCdf6JIaDVtKOZh+uT+YKFDex6TfEIdDwmy
 ehPvQ8/Vl7klMysmrc4wGDZjdHJA5B1toeJ7/4lpOBQeElhO9PXdKlVhSj7GqtRzGL+az53pIxv
 KuFTLqVhdA7/NMWNNXXSvfHp4LJ/E26hMd93qTBqOEAY+JyQqy/pN/iQr9bFu4WA8YSPDYWCjCz
 5yn5QBBc9Z/qYop0yRjmXRwXBNlswKZMu4rqTGL825bu5+JWD9R0K/FucPxhJy0/tw2h7avUYOF
 aQhnatmaXc6AMkYbQag==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=6993b941 cx=c_pps
 a=cLTib2BoJD1e+Gs0wkBYAA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=P-IC7800AAAA:8 a=E7Lgy1tWwXeeTmcNUdgA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: TcQqhB-uqpSSS5VChN1fwcTqIlxIqC6s
Subject: RE:  [PATCH v3] hfsplus: validate btree bitmap during mount and
 handle corruption gracefully
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,mpiricsoftware.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-77328-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 56A8E14851F
X-Rspamd-Action: no action

T24gU3VuLCAyMDI2LTAyLTE1IGF0IDIzOjI3ICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gT24gVHVlLCAyMDI2LTAyLTAzIGF0IDIzOjEyICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gT24gVHVlLCAyMDI2LTAyLTAzIGF0IDE0OjI4ICswNTMwLCBTaGFyZHVsIEJh
bmthciB3cm90ZToNCj4gPiA+IE9uIE1vbiwgMjAyNi0wMi0wMiBhdCAyMDo1MiArMDAwMCwgVmlh
Y2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gPiBPbiBTYXQsIDIwMjYtMDEtMzEgYXQgMTk6
MzQgKzA1MzAsIFNoYXJkdWwgQmFua2FyIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqBsZW4gPSBoZnNfYnJlY19sZW5vZmYobm9kZSwNCj4gPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEhGU1BM
VVNfQlRSRUVfSERSX01BUF9SRUMsDQo+ID4gPiA+ID4gJmJpdG1hcF9vZmYpOw0KPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAobGVuICE9IDAgJiYgYml0bWFwX29mZiA+
PSBzaXplb2Yoc3RydWN0DQo+ID4gPiA+ID4gaGZzX2Jub2RlX2Rlc2MpKSB7DQo+ID4gPiA+IA0K
PiA+ID4gPiBJZiB3ZSByZWFkIGluY29ycmVjdCBsZW4gYW5kL29yIGJpdG1hcF9vZmYsIHRoZW4g
aXQgc291bmRzIGxpa2UNCj4gPiA+ID4gY29ycnVwdGlvbiB0b28uDQo+ID4gPiA+IFdlIG5lZWQg
dG8gcHJvY2VzcyB0aGlzIGlzc3VlIHNvbWVob3cgYnV0IHlvdSBpZ25vcmUgdGhpcywNCj4gPiA+
ID4gY3VycmVudGx5Lg0KPiA+ID4gPiA7KQ0KPiA+IA0KPiA+IEkgYW0gbm90IHN1Z2dlc3Rpbmcg
dG8gY2hlY2sgZXZlcnl0aGluZy4gQnV0IGJlY2F1c2UgeW91IGFyZSB1c2luZw0KPiA+IHRoZXNl
IHZhbHVlcw0KPiA+IGFuZCB5b3UgY2FuIGRldGVjdCB0aGF0IHRoZXNlIHZhbHVlIGlzIGluY29y
cmVjdCwgdGhlbiBpdCBtYWtlcyBzZW5zZQ0KPiA+IHRvIHJlcG9ydA0KPiA+IHRoZSBlcnJvciBp
ZiBzb21ldGhpbmcgaXMgd3JvbmcuDQo+IA0KPiBIaSBTbGF2YSwNCj4gDQo+IEFoLCBJIG1pc3Vu
ZGVyc3Rvb2QgeW91IHByZXZpb3VzbHkhDQo+IA0KPiBZb3UgYXJlIHJpZ2h0LiBJIHdpbGwgYWRk
IGFuIGV4cGxpY2l0IGVycm9yIGxvZyBhbmQgZm9yY2UgU0JfUkRPTkxZIGZvcg0KPiB0aGlzIGlu
dmFsaWQgb2Zmc2V0L2xlbmd0aCBjYXNlIGluIHY0IGFzIHdlbGwuDQo+IA0KPiA+IA0KPiA+ID4g
DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGhmc19ibm9kZV9yZWFk
KG5vZGUsICZiaXRtYXBfYnl0ZSwgYml0bWFwX29mZiwNCj4gPiA+ID4gPiAxKTsNCj4gPiA+ID4g
DQo+ID4gPiA+IEkgYXNzdW1lIHRoYXQgMSBpcyB0aGUgc2l6ZSBvZiBieXRlLCB0aGVuIHNpemVv
Zih1OCkgb3INCj4gPiA+ID4gc2l6ZW9mKGJpdG1hcF9ieXRlKQ0KPiA+ID4gPiBjb3VsZCBsb29r
IG11Y2ggYmV0dGVyIHRoYW4gaGFyZGNvZGVkIHZhbHVlLg0KPiA+ID4gDQo+ID4gPiBBY2snZWQu
IENoYW5naW5nIHRvIHNpemVvZihiaXRtYXBfYnl0ZSkuDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghKGJpdG1hcF9ieXRlICYg
SEZTUExVU19CVFJFRV9OT0RFMF9CSVQpKSB7DQo+ID4gPiA+IA0KPiA+ID4gPiBXaHkgZG9uJ3Qg
dXNlIHRoZSB0ZXN0X2JpdCgpIFsxXSBoZXJlPyBJIGJlbGlldmUgdGhhdCBjb2RlIHdpbGwNCj4g
PiA+ID4gYmUNCj4gPiA+ID4gbW9yZSBzaW1wbGUNCj4gPiA+ID4gaW4gc3VjaCBjYXNlLg0KPiA+
ID4gDQo+ID4gPiANCj4gPiANCj4gPiBDb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcsIGJ1dCBJIHN1
c3BlY3QgdGhhdCBJIGFtIHJpZ2h0LiA6KSBUaGUNCj4gPiBlbmRpYW5uZXNzIGlzDQo+ID4gYWJv
dXQgYnl0ZXMgbm90IGJpdHMuIEkgYW0gZ29vZ2xlZCB0aGlzOiAiRW5kaWFubmVzcyBkZWZpbmVz
IHRoZQ0KPiA+IG9yZGVyIGluIHdoaWNoDQo+ID4gYnl0ZXMsIGNvbnN0aXR1dGluZyBtdWx0aWJ5
dGUgZGF0YSAobGlrZSAxNiwgMzIsIG9yIDY0LWJpdCBpbnRlZ2VycyksDQo+ID4gYXJlIHN0b3Jl
ZA0KPiA+IGluIG1lbW9yeSBvciB0cmFuc21pdHRlZCBvdmVyIGEgbmV0d29yay4iLiBTbywgaWYg
eW91IG5lZWQgbWFuYWdlDQo+ID4gZW5kaWFubmVzcyBvZg0KPiA+IG9mIHZhbHVlcywgdGhlbiB5
b3UgY2FuIHVzZSBjcHVfdG9fYmV4eCgpL2JleHhfdG9fY3B1KCkgZmFtaWx5IG9mDQo+ID4gbWV0
aG9kcy4gQnV0DQo+ID4gaXQncyBub3QgYWJvdXQgYml0cy4gSWYgeW91IHRha2UgYnl0ZSBvbmx5
LCB0aGVuIHRoZSByZXByZXNlbnRhdGlvbg0KPiA+IG9mIGJ5dGUgaXMNCj4gPiB0aGUgc2FtZSBp
biBCaWctRW5kaWFuIChCRSkgb3IgTGl0dGxlLUVuZGlhbiAoTEUpLiBBbSBJIHJpZ2h0IGhlcmU/
DQo+ID4gOikNCj4gDQo+IFlvdSBhcmUgcmlnaHQgdGhhdCBhIHNpbmdsZSBieXRlJ3MgcmVwcmVz
ZW50YXRpb24gaXMgdGhlIHNhbWUgaW4gbWVtb3J5DQo+IHJlZ2FyZGxlc3Mgb2YgQ1BVIGVuZGlh
bm5lc3MuIFRvIGJlIGNvbXBsZXRlbHkgdHJhbnNwYXJlbnQsIHRoZSBwcmVjaXNlDQo+IGludGVy
cGxheSBiZXR3ZWVuIGNyb3NzLWFyY2hpdGVjdHVyZSBrZXJuZWwgYml0b3BzLCBtZW1vcnkgYWxp
Z25tZW50LA0KPiBhbmQgb24tZGlzayBmb3JtYXQgZW5kaWFubmVzcyBoYXMgYWx3YXlzIGJlZW4g
YSBiaXQgb2YgYSBjb25jZXB0dWFsDQo+IGJsaW5kIHNwb3QgZm9yIG1lLg0KPiANCj4gTXkgaW5p
dGlhbCBoZXNpdGF0aW9uIHdpdGggYHRlc3RfYml0KClgIHdhcyBhbHNvIHRoYXQgaXQgc3RyaWN0
bHkNCj4gcmVxdWlyZXMgYW4gYHVuc2lnbmVkIGxvbmcgKmAuIFJlYWRpbmcgYSAxLWJ5dGUgb24t
ZGlzayByZXF1aXJlbWVudA0KPiBkaXJlY3RseSBpbnRvIGFuIGB1bnNpZ25lZCBsb25nYCBidWZm
ZXIgZmVsdCBzdWItb3B0aW1hbCBhbmQgY291bGQgcmlzaw0KPiBvdXQtb2YtYm91bmRzIHN0YWNr
IHJlYWRzIGlmIG5vdCBoYW5kbGVkIGNhcmVmdWxseS4NCj4gDQo+IEhvd2V2ZXIsIEkgd2FudCB0
byBmb2xsb3cgeW91ciByZWNvbW1lbmRhdGlvbiB0byBzdGFuZGFyZGl6ZSBvbiBrZXJuZWwNCj4g
Yml0b3BzLiBUbyBzYWZlbHkgdXNlIGB0ZXN0X2JpdCgpYCwgSSBwcm9wb3NlIHJlYWRpbmcgdGhl
IGJ5dGUgc2FmZWx5DQo+IGludG8gYSBgdThgLCBhbmQgdGhlbiBwcm9tb3RpbmcgaXQgdG8gYW4g
YHVuc2lnbmVkIGxvbmdgIGJlZm9yZQ0KPiB0ZXN0aW5nOyBzb21ldGhpbmcgbGlrZSB0aGlzIG9u
IHRvcCBvZiB0aGUgcGF0Y2g6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy9idHJlZS5j
IGIvZnMvaGZzcGx1cy9idHJlZS5jDQo+IGluZGV4IDRiZDBkMThhYzZjNi4uN2NlMTcwOGU0MjNj
IDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2J0cmVlLmMNCj4gKysrIGIvZnMvaGZzcGx1cy9i
dHJlZS5jDQo+IEBAIC0xMzUsNiArMTM1LDcgQEAgc3RydWN0IGhmc19idHJlZSAqaGZzX2J0cmVl
X29wZW4oc3RydWN0IHN1cGVyX2Jsb2NrDQo+ICpzYiwgdTMyIGlkKQ0KPiAgICAgICAgIHN0cnVj
dCBoZnNfYnRyZWUgKnRyZWU7DQo+ICAgICAgICAgc3RydWN0IGhmc19idHJlZV9oZWFkZXJfcmVj
ICpoZWFkOw0KPiAgICAgICAgIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nOw0KPiArICAg
ICAgIHVuc2lnbmVkIGxvbmcgYml0bWFwX3dvcmQ7DQo+ICAgICAgICAgc3RydWN0IGhmc19ibm9k
ZSAqbm9kZTsNCj4gICAgICAgICB1MTYgbGVuLCBiaXRtYXBfb2ZmOw0KPiAgICAgICAgIHN0cnVj
dCBpbm9kZSAqaW5vZGU7DQo+IEBAIC0yNTUsNyArMjU2LDggQEAgc3RydWN0IGhmc19idHJlZSAq
aGZzX2J0cmVlX29wZW4oc3RydWN0IHN1cGVyX2Jsb2NrDQo+ICpzYiwgdTMyIGlkKQ0KPiAgDQo+
ICAgICAgICAgaWYgKGxlbiAhPSAwICYmIGJpdG1hcF9vZmYgPj0gc2l6ZW9mKHN0cnVjdCBoZnNf
Ym5vZGVfZGVzYykpIHsNCj4gICAgICAgICAgICAgICAgIGhmc19ibm9kZV9yZWFkKG5vZGUsICZi
aXRtYXBfYnl0ZSwgYml0bWFwX29mZiwNCj4gc2l6ZW9mKGJpdG1hcF9ieXRlKSk7DQo+IC0gICAg
ICAgICAgICAgICBpZiAoIShiaXRtYXBfYnl0ZSAmIEhGU1BMVVNfQlRSRUVfTk9ERTBfQklUKSkg
ew0KPiArICAgICAgICAgICAgICAgYml0bWFwX3dvcmQgPSBiaXRtYXBfYnl0ZTsNCj4gKyAgICAg
ICAgICAgICAgIGlmICghdGVzdF9iaXQoSEZTUExVU19CVFJFRV9OT0RFMF9CSVQsICZiaXRtYXBf
d29yZCkpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqdHJlZV9uYW1l
Ow0KDQpPSy4gSSBzZWUuIEkgZG9uJ3QgdGhpbmsgdGhhdCB3ZSBuZWVkIHRvIG1ha2UgdGhlIGNv
ZGUgbW9yZSBjb21wbGljYXRlZC4gSWYgd2UNCmNhbiBzaW1wbHkgcmVhZCB0aGUgYml0bWFwX3dv
cmQgYW5kIHRoZW4gdG8gdXNlIGl0IGZvciB0ZXN0X2JpdCgpLCB0aGVuIGl0DQpzb3VuZHMgbGlr
ZSByZWFzb25hYmxlIG9uZS4gT3RoZXJ3aXNlLCBJIHRoaW5rIHdlIGRvbid0IG5lZWQgdG8gdXNl
IHNvbWUgdHJpY2tzDQp0byB1c2UgdGhlIHRlc3RfYml0KCkuIFlvdXIgcHJldmlvdXMgY29kZSBs
b29rcyBPSywgdGhlbi4NCg0KQnV0LCBJIHN0YXJ0ZWQgdG8gdGhpbmsgYWJvdXQgc29tZXRoaW5n
IGJpZ2dlci4gUGxlYXNlLCBzZWUgbXkgY29tbWVudHMgYmVsb3cuDQoNCj4gIA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBzd2l0Y2ggKGlkKSB7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L2hmc19jb21tb24uaCBiL2luY2x1ZGUvbGludXgvaGZzX2NvbW1vbi5oDQo+IGluZGV4IGYy
ZjcwOTc1NzI3Yy4uNTJlOWI4OTY5NDA2IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2hm
c19jb21tb24uaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2hmc19jb21tb24uaA0KPiBAQCAtNTEy
LDcgKzUxMiw3IEBAIHN0cnVjdCBoZnNfYnRyZWVfaGVhZGVyX3JlYyB7DQo+ICAjZGVmaW5lIEhG
U1BMVVNfQlRSRUVfSERSX05PREVfUkVDU19DT1VOVCAgICAgIDMNCj4gICNkZWZpbmUgSEZTUExV
U19CVFJFRV9IRFJfTUFQX1JFQ19JTkRFWCAgICAgICAgMiAgICAgICAvKiBNYXAgKGJpdG1hcCkN
Cj4gcmVjb3JkIGluIGhlYWRlciBub2RlICovDQo+ICAjZGVmaW5lIEhGU1BMVVNfQlRSRUVfSERS
X1VTRVJfQllURVMgICAgICAgICAgIDEyOA0KPiAtI2RlZmluZSBIRlNQTFVTX0JUUkVFX05PREUw
X0JJVCAgICAgICAgICAgICAgICAweDgwDQo+ICsjZGVmaW5lIEhGU1BMVVNfQlRSRUVfTk9ERTBf
QklUICAgICAgICAgICAgICAgIDcNCj4gIA0KPiAgLyogYnRyZWUga2V5IHR5cGUgKi8NCj4gICNk
ZWZpbmUgSEZTUExVU19LRVlfQ0FTRUZPTERJTkcgICAgICAgICAgICAgICAgMHhDRiAgICAvKiBj
YXNlLQ0KPiBpbnNlbnNpdGl2ZSAqLw0KPiANCj4gDQo+ID4gPiA+ID4gwqAjZGVmaW5lIEhGU1BM
VVNfQlRSRUVfSERSX1VTRVJfQllURVPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMTI4DQo+ID4gPiA+
ID4gKyNkZWZpbmUgSEZTUExVU19CVFJFRV9OT0RFMF9CSVTCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoDB4ODANCj4gPiA+ID4gDQo+ID4gPiA+IE1heWJlLCAoMSA8PCBzb21ldGhpbmcp
IGluc3RlYWQgb2YgMHg4MD8gSSBhbSBPSyB3aXRoIGNvbnN0YW50DQo+ID4gPiA+IHRvby4NCj4g
PiA+IA0KPiA+ID4gQWNrJ2VkLCB3aWxsIHVzZSAoMSA8PCA3KS4gQ2FuIGFsc28gdXNlIEJJVCg3
KSBpZiB5b3UgcHJlZmVyLg0KPiA+IA0KPiA+IE9LLiBTbywgYXJlIHlvdSBzdXJlIHRoYXQgbm9k
ZSAjMCBjb3JyZXNwb25kcyB0byBiaXQgIzcgYnV0IG5vdCBiaXQNCj4gPiAjMD8gOikgSSBhbQ0K
PiA+IHN0YXJ0ZWQgdG8gZG91YnQgdGhhdCB3ZSBhcmUgY29ycmVjdCBoZXJlLg0KPiANCj4gQWNj
b3JkaW5nIHRvIEFwcGxlJ3MgVGVjaCBOb3RlIFROMTE1MCBbMV0sIEhGUysgbWFwcyBOb2RlIDAg
dG8gdGhlIE1vc3QNCj4gU2lnbmlmaWNhbnQgQml0IChNU0IpLg0KPiANCj4gU3BlY2lmaWNhbGx5
LCBUTjExNTAgc3RhdGVzOg0KPiANCj4gMS4gVW5kZXIgIk1hcCBSZWNvcmQiOiAiVGhlIGJpdHMg
YXJlIGludGVycHJldGVkIGluIHRoZSBzYW1lIHdheSBhcyB0aGUNCj4gYml0cyBpbiB0aGUgYWxs
b2NhdGlvbiBmaWxlLiINCj4gMi4gVW5kZXIgIkFsbG9jYXRpb24gRmlsZSI6ICJXaXRoaW4gZWFj
aCBieXRlLCB0aGUgbW9zdCBzaWduaWZpY2FudCBiaXQNCj4gaG9sZHMgaW5mb3JtYXRpb24gYWJv
dXQgdGhlIGFsbG9jYXRpb24gYmxvY2sgd2l0aCB0aGUgbG93ZXN0IG51bWJlci4uLiINCj4gDQo+
IEFwcGxlIGFsc28gcHJvdmlkZXMgYSBDIGNvZGUgc25pcHBldCBpbiB0aGUgZG9jdW1lbnQgKExp
c3RpbmcgMSkNCj4gZGVtb25zdHJhdGluZyB0aGlzOg0KPiBgcmV0dXJuICh0aGlzQnl0ZSAmICgx
IDw8ICg3IC0gKHRoaXNBbGxvY2F0aW9uQmxvY2sgJSA4KSkpKSAhPSAwO2ANCj4gDQo+IElmIHdl
IGV2YWx1YXRlIHRoaXMgZm9yIE5vZGUgMCAoYHRoaXNBbGxvY2F0aW9uQmxvY2sgPSAwYCksIGl0
IHJlc29sdmVzDQo+IHRvIGAxIDw8IDdgIChvciBiaXQgNykuIFRoZXJlZm9yZSwgY2hlY2tpbmcg
Yml0IDcgaXMgbWF0aGVtYXRpY2FsbHkNCj4gcmVxdWlyZWQgdG8gdGFyZ2V0IE5vZGUgMC4NCj4g
DQo+IElmIHRoZXNlIGNoYW5nZXMgbG9vayBwcm9wZXIgdG8geW91LCBJIHdpbGwgYWRkIHRoZW0g
dG8gbXkgY29kZSBhbG9uZw0KPiB3aXRoIHRoZSByZXN0IG9mIHlvdXIgZmVlZGJhY2sgYW5kIHNl
bmQgb3V0IHY0IHNob3J0bHkuDQo+IA0KPiBUaGFua3MgYWdhaW4gZm9yIHRoZSBndWlkYW5jZSwg
Y29udGludWVkIHJldmlldyBhbmQgZm9yIGJlYXJpbmcgd2l0aCBtZQ0KPiBvbiB0aGlzIQ0KPiAN
Cg0KQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhlIG1haW4gbG9naWMgb2Ygd29ya2luZyB3aXRoIGIt
dHJlZSBtYXAgaXMgaGVyZSBbMV0uDQpJZGVhbGx5LCB3ZSBzaG91bGQgaGF2ZSBhIGdlbmVyaWMg
bWV0aG9kIHRoYXQgY2FuIGJlIHVzZWQgYXMgaGVyZSBbMV0gYXMgaW4geW91cg0KcGF0Y2guIENv
dWxkIHlvdSB0cnkgdG8gbWFrZSB0aGUgc2VhcmNoIGluIGItdHJlZSBtYXAgYnkgZ2VuZXJpYyBt
ZXRob2Q/DQoNClRoYW5rcywNClNsYXZhLg0KDQpbMV0gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjYuMTktcmM1L3NvdXJjZS9mcy9oZnNwbHVzL2J0cmVlLmMjTDQxMg0K

