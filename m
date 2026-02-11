Return-Path: <linux-fsdevel+bounces-76979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP5RAocEjWlVxAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 23:36:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A82128261
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 23:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EFDF301D307
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 22:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5C43563E5;
	Wed, 11 Feb 2026 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NjY7Xf4P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B410FD
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770849409; cv=fail; b=K3vBiRsZc9cJRSc4x8KzqTkq2kB+RFSvkQZQbq1XYMvn+9mwTozHqMmQrVveeu5QKBFus8qXTIEJe4IkwPiHH/3gBbLrsSj5dA2B27zM4edqg+A5stmr7JHNzqYEkLNl3RCW1quM2Hrh8th6BASDnq5cWOKbIWbKnQl3B+IaPBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770849409; c=relaxed/simple;
	bh=x9f7tp29FhLOqv9MsSLm1/dM31cqi96kVjQMQCALnuo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=KxgDyckaLoU5SRXiTZDkHYD1PkKmaF8pxiyoYdf9OblVzJkI17wpU0Z3Q4G4cSm5b6sZbCkFCN4FTFSfUBNjOfUKkP5MVQriQy7zEoQEea27tOWuRj7VEHtoUHq7sVnqJtpmFKHs4mKEPvvSuTnTj+OapcrK0+iEk/WYSkSUjcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NjY7Xf4P; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BGUP3B451836;
	Wed, 11 Feb 2026 22:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=x9f7tp29FhLOqv9MsSLm1/dM31cqi96kVjQMQCALnuo=; b=NjY7Xf4P
	RCDjyy9i8gLRG+B4It5d6RXWT1GPtaQRvd6+Rm2A3XzYi+akq6FtkwVyoH53ZBwg
	3nMaqplh2vazGCgPf1aonklkuiO6kvGIt0IVO9FazmfoQpkAhWkU96QFYdZtdiqv
	km+s67rlClTmlluAUm99RG5ysZbi85TjEF/1jQm49T2pBg8F3ais/ppcMT2Vvrak
	1QZJVby0SUvL1JYT2wKEBvmEx4tTw+ZmM3LZHajW82FNcg9T/HD5KMwRyaQbe51M
	c/pJ/W70zSoO/aNbpEUZelGyFOQt82ffwuHYEJFbhu41045OUdQGR5fh+nCh+igL
	5qwEDLs9J62pKw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ukgut-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 22:36:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXcpt+RktBcBFfxvO6eCJV928zsPvlr3LGxbJhwepWxPpUGUCjgVqD3ADpM1eXOzOZznSYP565HRHUiqKHGR9SQS3XmVW/nhHUAHVRN+MZOeyTYGIzvSr2PBkVq3RhTCVB4x3dDo1BZcAGtb4XjDBNuqIBpXBjLwXDNHF/9Zl/EkTLKovYgWp+YQ1uqi11xoA7OpkQhD7SA/d3qjxQ4D1nslAIkYc3HjE3mQDg9u+6eAqB66dM2gO+eFqiwgc8iXwYnN2i5VJ2QsJDwYZarVudil5xT+JSAZRYDLkQufPqIxHuMcqCPL7mmFNwa2qDKUJHLvFVlSKhjAJx6FKN4kQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9f7tp29FhLOqv9MsSLm1/dM31cqi96kVjQMQCALnuo=;
 b=wYJTMZeLutHqPtbfoVF9+eLbChllGZ35eXL/0I6r/wJ+UmIfg+XCwh9DTahr+60R5rXlbtwyWdugbAR2GSSEuwBzPoIkvRR7rx0z2I7j71wpSYeZN/nQlezmZdnMGbOwfeKEmClL1TF/GtCEvOySw1SejuLqzXIfLHBPMpcTYYpvzUL7D89MgPtGwcckth2vAnjXIM9KgQTEbKNtMgcOqgrYAt1Kimk7eI13H7eaEXIx00u/H69klRgk8q47mUZQWZ/kGtuabDQQ8rotwAjU0K0i2cNiNSJXN2yEE/8ZaCqZ7P7P8NDYmPJNqj+oQ7xPpqsdwkXcN/kFqvF0ouQGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM4PR15MB6201.namprd15.prod.outlook.com (2603:10b6:8:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:36:38 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 22:36:37 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] hfs: evaluate the upper 32bits for detecting
 overflow
Thread-Index: AQHcm0Hz5/ek17AYnEqBY5v2XikX8rV+Fz4A
Date: Wed, 11 Feb 2026 22:36:37 +0000
Message-ID: <68811931931db09c0ea84f1be8e1bdc0fd453776.camel@ibm.com>
References: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
In-Reply-To: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM4PR15MB6201:EE_
x-ms-office365-filtering-correlation-id: cdb8ba1e-44cf-423c-e9a4-08de69be0485
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmQ1eS95VEhGQjNIdmFtaEdxVXhFQTQyRjJ3NEluSTF0MFdkdUNIT1EzaFYx?=
 =?utf-8?B?clRCZ0t5M3V6M0pNbnl5bWpTcDFVQTMwY2h3a0pjcTJXN1VDZTNJeCtEVlJB?=
 =?utf-8?B?eWREVzNkUWxMWElzWUN1NGdRV2s5YU1naHJqRkJPcndJMmJucGFqS3FnYXIr?=
 =?utf-8?B?Y2Q3alpoT3hma3RWWXVWQ1duRWRyREl2K1B0VW5LblJjSnJmeHVSaC9iUG8z?=
 =?utf-8?B?SUdLRTFTWFZpUVFzVVNsV0xmd29TQWQ1aXhPL1drMEZkQjlmYnpoNlY3NzJV?=
 =?utf-8?B?MEIvWE1TcUphUmNYTDl1Q1FodXZRYmFHclFXVDR5WlJJZGNPeXZUSmFzbmp1?=
 =?utf-8?B?eVRpcGo5NkZ5Ym9ucVhUa0JDVWxJOWpxUXVBODhFbE1BelpYdlN4dzg5Vm4z?=
 =?utf-8?B?Nlp5TkJldlBFejMyRTE3QU0xTlNKZEFVVkVjS1lza1FaaTgvSDZSdzNiNDlp?=
 =?utf-8?B?eHlmRXBteGFLcm1wQ2tKbEV4bmh5TE5NS2JJS09OMVZpL1ZiT05GWm1kNCtp?=
 =?utf-8?B?bi85dnJYU2ZDTTd6S3luc2tEOTRwQWNuZUxRSnBOb0pNTTBKTWxQckxZdmZY?=
 =?utf-8?B?a2NFaWR4azJ2cUVWK1o1T1c1TGpTNDJDd2RFNGZlSUhNQjRaVEZENUpJY0VP?=
 =?utf-8?B?RTcvNDluQ1FQeGlmYzcrT2tDMDhGT0xjTnp4bER6NTNJRVoyeVJMZ1BhTWhp?=
 =?utf-8?B?UG1BQ0VDc05zWVpCV2RxZTQ3aG5paVEyUzhTbWM0bzQ3VFBQcFRkN2xCZ292?=
 =?utf-8?B?aFdUbWIrU3l1c1ZVNHY5Z1hhTGN1cHVrQXRRUStQWCtxbG1maGlDVmNza3Rl?=
 =?utf-8?B?VHJBMTRWeklZUlMweTI2emkvYjcrZzFyVXN6RXJlbzNUaWFFZjNCWG9EekUr?=
 =?utf-8?B?NkpVQlk0NFA1aVRUWWJVNE90SnRYbFlFYlNkM0kyeVRrZmhvS3h1MjZvKzlo?=
 =?utf-8?B?THRwNDRGd095YlU3WjEyay9vank4QWlmTjE5aHRZY0FnRFNHUTFOQzdwU1Q0?=
 =?utf-8?B?NWc3cGRzdmJVek51K1Fic2hBb3ljUFZzTERWOHEvSFVlYlZUZUlrRE1Sa1Uv?=
 =?utf-8?B?K3lCVDhQemlOS0VXOFQrUEJEcG1lUHVMdlBsQkovVU5nanRPNU8wVUQrNTM1?=
 =?utf-8?B?eHFiZmxlZCsrM3lpYUs3M044UHBMZll1dmZOUGsyWHhkWThTTEw1bm1zaDdP?=
 =?utf-8?B?UXJOcVZOM1Z2MUJjUGhpYmJwL2VjRmlmT2k1c0hTOWl2cTk2dmtPUjNkaG9E?=
 =?utf-8?B?TkgwSzl5aXZBcVBxbHhKWEgxWjVmcVRXMUZMbU1Sekd3dkhEYVZyMEdRNlN4?=
 =?utf-8?B?V29WbStKbTRqSTdTYVpNWlcrUk9DK0thWlZDL2lCVkR1SWRkM0tnN3lZMFRi?=
 =?utf-8?B?MXpOLytTNVRyMml1eDZzOGluOUUvWU9VZEw0UkRKMHVPQ3dCQ2oxQWJ6Q3Fl?=
 =?utf-8?B?TE5mYUR5RmFaQlhoTEJxamFZdnJiSFFpK2hLeWx4djJCZnNMMW5NYS9tZzFY?=
 =?utf-8?B?cVQxRSs3RHFGK0x0ZFQxa0pPem1uR2Z1SlUwMTU1ZU9pODYzd1lyRmJ1Rjh1?=
 =?utf-8?B?NFZzSGR3WGlZZFhieG5ZaFFwR2lheCt3QXVlaC93SFBCSlNNajZGbjB4dVdR?=
 =?utf-8?B?eFVCRVBpYkpJT0hBek5nbmt1RjcyQVBPS0tRQStMZUpKaFB0UCtzcTZ4a2E4?=
 =?utf-8?B?Q3pqUGhsRVloM1FsS3ZtdFY4c3MyT3dSNEw3VzJCMmNiM2dBeFI1cG9RUlgz?=
 =?utf-8?B?aTU3UHZTK3k3ZisrTHdyemZJOWNaeG1hSjJSaWhMYkhIUHhXdHcveDd1OVg5?=
 =?utf-8?B?N3Nab0t6aVI0TTJ4Rko5aWJEcGV2ZHJETjkxV0dRS0tvblg4UndUUEsrYWV0?=
 =?utf-8?B?RkxMbjFZOEpVVzJ6M1dFcWpodWFLb0s0cTVSQlhUTmZibG50SnRJbE9IclUw?=
 =?utf-8?B?amFGZ01tMm05WjZDbFhLYVJNMUIvNWtzT28vWGVOSVQ4R3dOOHU3eGM4d205?=
 =?utf-8?B?TjE3K3lORkRTVDRIN3NsOXFONWhscUJyVXBTZHl4Ukl4SWJsVUFJdDRtOCtq?=
 =?utf-8?B?ZTc5VFNNcEdSZVJLejdPUnE0Q2lhMUZlOUpUZytKMW8zSTh1em9wd1RJd3dn?=
 =?utf-8?B?bzJmOVVNT0E2TUp1dFdOQlF5dkNwUmFFdjk4bm1wNk1HblkwamkyOVN0ampG?=
 =?utf-8?Q?l6IcjnLsLBuG3NQkxciadcI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmtCdk5nbm11ZzQ1Z2h2S2U4T3hjaS9KS0JwRGZLSlN4dlphSC80dkZMZXNp?=
 =?utf-8?B?djNIQnBLRUREOFBxaFpycWNRWWlBQVRCblJLd3JXVVJ4bWNQWWVrcGlPbHdO?=
 =?utf-8?B?TjE5RTNHZmhlczJwSVpBNUVPMzl5UTk0dm5CUmk2U2x6ZXI4bTdLWUp1V3lH?=
 =?utf-8?B?U0srNlNIVnhpb21PajVQR1lkbHBuN2c2bFNTTzVTVTFISXQydmFYUUtpUHQw?=
 =?utf-8?B?WFp5S016cUlLMmJIZVdwcmc0aStUdkpsTDBoN3EvUmRtWllHTS9iVmgwZHYx?=
 =?utf-8?B?dHlvVmRQSGpSM2hEWnVRYmZlMEhpd1JTN0FiZVRYQzFMSjBHcTFlRzBmTXZT?=
 =?utf-8?B?ZDFoU2JBcGpxb2dTVncvU3M4MWxWK3RHTWwyejZEZ282NzdWc3NCdHB6ZjVa?=
 =?utf-8?B?a3NlYXd5WTZnL0lSTlJjLzN6a0FUbEFmbSsraEtMeGZOMmY5bnltamJGcmJM?=
 =?utf-8?B?U0xTUVFVUEY2aWNHWXBFK2tMU1RYWG9OdWU0Y1lwOGl5ZndIOXZuWXpVNHkr?=
 =?utf-8?B?WWNqbkFpSVhZUHVZZ2lxbU85bnBiV2d0MzRjbk5Xd2VBYm84a3FZRDlQQ3or?=
 =?utf-8?B?K1MxNHl3VjNna1FJQVh4TXMrQjlDNUxNdEZsWkR0Q1hJelcycTRrL2paYmIz?=
 =?utf-8?B?dGxGbTlINWRJMi9aOWFuQ3AyaXJwRExiMFRWSnExODFiRWJwbm04WGlxT3N3?=
 =?utf-8?B?aW9HYnBjaXM0aUw3S3pPRnBhbjJyMlQrd1krZ0pvdEtLYmRBeGFobFJITGFD?=
 =?utf-8?B?K1lERmU5MDF0RzI4eG5sQzZnQ2xkYnUrZjV3bG94UG5MSVZmcXhRbEprSWlU?=
 =?utf-8?B?bTVoMFZMZjZMcGNTRXNpcXZHMGhFenR4d0s2MG94N0pHL1hGMVVGcEQzdXd2?=
 =?utf-8?B?Z3lybHo3dGdpbWdLak1zcFJ5VUtiNDArcTE2NUtPaEdvaW5NUU1tZ0dTRXdR?=
 =?utf-8?B?bmJvc2c3Z2NPWkcwZysrcGlsZTNPd2xnT21pR3RheWVVT0I2K3FjcnRhM1Nt?=
 =?utf-8?B?TTVVcDJlQ0VmSTBnQVJsUW5tcTE5ekN0QVhHTFd1SC9RMEVIN2JST3lnQkZr?=
 =?utf-8?B?bkkwd0RSdXpxQytJZVRyK0x4RXgvTlZwYUJ3RjI4anc1OVI0VUFXRGVobG04?=
 =?utf-8?B?azdzZFczZlVobW01RGpXa0VMQkc0VWRZcnN2TTcvTS9ObUtoajF1Z3hFb3hO?=
 =?utf-8?B?WnBGSXRwbmRGZ29TdVJZbmpvSUFuRDdNQkZPWEc4Umk0NHVwQkZrR1lOMTh6?=
 =?utf-8?B?aHRGR01WTGxHRTgzTktsV3owSWo3d3JQcEl4KzVsMDFvc2xGQ1FNNHFXTUx6?=
 =?utf-8?B?cGJHaVFYa3hkWG1PNVNDOWphZ05TUGs0ZTh1VXYvMEZBMDhKTW8zVGxodnQ1?=
 =?utf-8?B?cEY1NkFuVTkrNE1zUXRpSUFrYXVheUtxQjNqQy9wR1NvU01BdjJQd0JxL1No?=
 =?utf-8?B?Uy9RbWlrRDU3aEJzeXdwSzZkQ0xrMHlPOTU4eGNZbHhDcWFCVzFzRTErUEJL?=
 =?utf-8?B?ZGtiYUdJUW9zaHBnOHJKNitLVjJRZGIxSjFCKzlHZVJneXBJRUVsdlpQWVQ3?=
 =?utf-8?B?SVZmRHlGbXZnQ0lEVkFtTG1VNGJJaHhwSnduZkd2UGJqRDNTSGpwVmlZb3Bu?=
 =?utf-8?B?MWNVSTA3eFd6K0VPTFdUZVBsZEtSUC83YkFMeWE2czdzYUdNVFJCVm1HbHNZ?=
 =?utf-8?B?dFBwVUEva2lsZjdwUk9XN0VHNEdBU3IvT25NQUxNd2NheThvd3dQeENhSm9w?=
 =?utf-8?B?dXl2TThEMnQvbzVrc2loMjB4Q1Nhb013RkdCSnkvV0ZqQ1JtR3NDSFA5eWFP?=
 =?utf-8?B?SWRRMnlHWXJSTHNwSlljbnBCOURFL1BvSXlKbDlXZU9FaGdYWm1HVld6TXVH?=
 =?utf-8?B?dC9pbXVUUkVqbWZKTjNuUnNUSnZlUC9WTVkxclRiZDJvano2NWRSQ011QXJ4?=
 =?utf-8?B?cUg1aWJJSDZObklaS2g1YVlzdFBUTFlYZkdIL3o3akRjQWhWYjhxa0UrdUpU?=
 =?utf-8?B?TXY0M09CMVBKNGZLaW9NY2lkRjBULy9vaHoxeDRyNlp1Y3JrTERMMTEycFBI?=
 =?utf-8?B?WHZGR1haaU10dlJKRXpRMjVvbkdoYkgvNjdjaG5CZERNMmU4b2loT3FGdUVt?=
 =?utf-8?B?bzJweGVmR2NyZnF5a2R1c1VsNTZXL1lMeEFmZVBZMmtJbUdxVXM1R2U5N3l5?=
 =?utf-8?B?blVHTDVGZ3hzUTkycXAwczd5SFd5MmVoNW84Zkp2UlkyaTNxWnZqbzVOYnZt?=
 =?utf-8?B?MEgvNkpkSURvYkRndW1sTlBjZitpT2FKaWtTVmlzZ1p1a21vVXZoL3pvd1ZX?=
 =?utf-8?B?Zy8xQ2NYQk8zN05QSWlhdEZLRGhsQ1RLQWJoSGVtMGt2YWo0bEpNc0Zmd3lN?=
 =?utf-8?Q?Zsp/iYqgFkC/nC5mdhuGkSS2g8M8JeDNLL4NE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B4A14B1ACCE6343B143FF5B56CC6172@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb8ba1e-44cf-423c-e9a4-08de69be0485
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 22:36:37.3405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Xp1dCDldv2ctf9/L+Oj3zBnxXiR1MoPynI9hA274yXFbIubnLWqLda1yjWg9Z2LvIPlxhh2y5MyoC4+WFk77Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6201
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698d0478 cx=c_pps
 a=f333RhXzhOQaWIE8hCCRDA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=Kk4oP9S42mGQ84ZI:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=hiResAf5AbySHtBVl-MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ny1_m_V5v22GZcWYBKh3laNf1Mzg7hHN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE3MiBTYWx0ZWRfXyeTk2Kx1gs3E
 vJplsj0n2MVpxUdMB18xjdApnMxIR/ckI85R06VjXb9JA430zkgtBPHTPTWxc6/xCgrvqD1s89G
 4KV91EHBQ8SvM1lmyztgjKakhC55o4Rtvmak5QGNfDp/ZcvYa6ljv+qVxS9Wv9M2mtVECpRcI8H
 M5ARzNnaUg3RpinxGnCPS3r0117dXoB2KG/9RZWRAN5RNbp7SJy/AOys2ZKWaekEMNsrNUOeCdP
 HD06menwCOUv0D+5pd9tv9BTcYCeW2+VGFh17JMqLEFIACeQMFKU612vzcW5Fx4PAmYxunyeAX6
 nO5vIYKWR14npsiz9qASfibaiGmgpfAWNCt9uzh3KTI0hq5D5ill6ytl4A6tS5oj2q/tf6PuOqD
 DTjQw47Pp+x0BUGYiWxoE2oAbJRtsX6ttAmPBuNrkgzz6ms9fqVOkUI4urYjYCwpcxtza8Usluh
 KUIF51Y5uo09E7kPb3g==
X-Proofpoint-GUID: Ny1_m_V5v22GZcWYBKh3laNf1Mzg7hHN
Subject: Re:  [PATCH] hfs: evaluate the upper 32bits for detecting overflow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110172
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76979-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,i-love.sakura.ne.jp:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,vivo.com,I-love.SAKURA.ne.jp,dubeyko.com,xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 71A82128261
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTExIGF0IDE5OjI5ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IENvbW1pdCBiMjI2ODA0NTMyYTggKCJoZnM6IFJlcGxhY2UgQlVHX09OIHdpdGggZXJyb3IgaGFu
ZGxpbmcgZm9yIENOSUQNCj4gY291bnQgY2hlY2tzIikgcmVwbGFjZWQgQlVHX09OKCkgd2l0aCAi
YXRvbWljNjRfaW5jX3JldHVybigpID0+IGNoZWNrIGZvcg0KPiBvdmVyZmxvdyA9PiBhdG9taWM2
NF9kZWMoKSBpZiBvdmVyZmxvd2VkIiBwYXR0ZXJuLiBUaGF0IGFwcHJvYWNoIHdvcmtzDQo+IGJl
Y2F1c2UgdGhlIDY0Yml0cyBzaWduZWQgdmFyaWFibGUgaXMgaW5pdGlhbGl6ZWQgdXNpbmcgYSAz
MmJpdHMgdW5zaWduZWQNCj4gdmFyaWFibGUsIG1ha2luZyBzdXJlIHRoYXQgdGhlIGluaXRpYWwg
dmFsdWUgaXMgaW4gWzAsIFUzMl9NQVhdIHJhbmdlLg0KPiANCj4gSG93ZXZlciwgaWYgSEZTX1NC
KHNiKS0+ZmlsZV9jb3VudCBpcyBzbWFsbGVyIHRoYW4gbnVtYmVyIG9mIGZpbGUgaW5vZGVzDQo+
IHRoYXQgYWN0dWFsbHkgZXhpc3RzIGR1ZSB0byBmaWxlc3lzdGVtIGNvcnJ1cHRpb24sIGNhbGxp
bmcNCj4gYXRvbWljNjRfZGVjKCZIRlNfU0Ioc2IpLT5maWxlX2NvdW50KSBmcm9tIGhmc19kZWxl
dGVfaW5vZGUoKSBjYW4gbWFrZQ0KPiBIRlNfU0Ioc2IpLT5maWxlX2NvdW50IDwgMC4NCj4gDQo+
IEFzIGEgcmVzdWx0LCAiYXRvbWljNjRfcmVhZCgmc2JpLT5maWxlX2NvdW50KSA+IFUzMl9NQVgi
IGNvbXBhcmlzb24gaW4NCj4gaXNfaGZzX2NuaWRfY291bnRzX3ZhbGlkKCkgZmFpbHMgdG8gZGV0
ZWN0IG92ZXJmbG93IHdoZW4NCj4gSEZTX1NCKHNiKS0+ZmlsZV9jb3VudCA8IDAsIGZvciB0aGlz
IGlzIGEgY29tcGFyaXNvbiBiZXR3ZWVuIHNpZ25lZA0KPiA2NGJpdHMgYW5kIHVuc2lnbmVkIDMy
Yml0cy4gRXZhbHVhdGUgdGhlIHVwcGVyIDMyYml0cyBvZiB0aGUgNjRiaXRzDQo+IHZhcmlhYmxl
IGZvciBkZXRlY3Rpbmcgb3ZlcmZsb3cuDQo+IA0KPiBGaXhlczogYjIyNjgwNDUzMmE4ICgiaGZz
OiBSZXBsYWNlIEJVR19PTiB3aXRoIGVycm9yIGhhbmRsaW5nIGZvciBDTklEIGNvdW50IGNoZWNr
cyIpDQo+IFNpZ25lZC1vZmYtYnk6IFRldHN1byBIYW5kYSA8cGVuZ3Vpbi1rZXJuZWxASS1sb3Zl
LlNBS1VSQS5uZS5qcD4NCj4gLS0tDQo+IE9ubHkgY29tcGlsZSB0ZXN0ZWQuDQoNCk1heWJlLCBp
dCBtYWtlcyBzZW5zZSB0byBydW4gc29tZSB0ZXN0cz8gOikNCg0KPiANCj4gIGZzL2hmcy9pbm9k
ZS5jIHwgNiArKystLS0NCj4gIGZzL2hmcy9tZGIuYyAgIHwgNiArKystLS0NCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2ZzL2hmcy9pbm9kZS5jIGIvZnMvaGZzL2lub2RlLmMNCj4gaW5kZXggODc4NTM1ZGI2NGQ2
Li43YjVhNDY4NmFhNzkgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmcy9pbm9kZS5jDQo+ICsrKyBiL2Zz
L2hmcy9pbm9kZS5jDQo+IEBAIC0xOTksNyArMTk5LDcgQEAgc3RydWN0IGlub2RlICpoZnNfbmV3
X2lub2RlKHN0cnVjdCBpbm9kZSAqZGlyLCBjb25zdCBzdHJ1Y3QgcXN0ciAqbmFtZSwgdW1vZGVf
dA0KPiAgCXNwaW5fbG9ja19pbml0KCZIRlNfSShpbm9kZSktPm9wZW5fZGlyX2xvY2spOw0KPiAg
CWhmc19jYXRfYnVpbGRfa2V5KHNiLCAoYnRyZWVfa2V5ICopJkhGU19JKGlub2RlKS0+Y2F0X2tl
eSwgZGlyLT5pX2lubywgbmFtZSk7DQo+ICAJbmV4dF9pZCA9IGF0b21pYzY0X2luY19yZXR1cm4o
JkhGU19TQihzYiktPm5leHRfaWQpOw0KPiAtCWlmIChuZXh0X2lkID4gVTMyX01BWCkgew0KPiAr
CWlmIChuZXh0X2lkID4+IDMyKSB7DQoNCldoYXQncyBhYm91dCB1cHBlcl8zMl9iaXRzKCk/DQoN
Cj4gIAkJYXRvbWljNjRfZGVjKCZIRlNfU0Ioc2IpLT5uZXh0X2lkKTsNCj4gIAkJcHJfZXJyKCJj
YW5ub3QgY3JlYXRlIG5ldyBpbm9kZTogbmV4dCBDTklEIGV4Y2VlZHMgbGltaXRcbiIpOw0KPiAg
CQlnb3RvIG91dF9kaXNjYXJkOw0KPiBAQCAtMjE3LDcgKzIxNyw3IEBAIHN0cnVjdCBpbm9kZSAq
aGZzX25ld19pbm9kZShzdHJ1Y3QgaW5vZGUgKmRpciwgY29uc3Qgc3RydWN0IHFzdHIgKm5hbWUs
IHVtb2RlX3QNCj4gIAlpZiAoU19JU0RJUihtb2RlKSkgew0KPiAgCQlpbm9kZS0+aV9zaXplID0g
MjsNCj4gIAkJZm9sZGVyX2NvdW50ID0gYXRvbWljNjRfaW5jX3JldHVybigmSEZTX1NCKHNiKS0+
Zm9sZGVyX2NvdW50KTsNCj4gLQkJaWYgKGZvbGRlcl9jb3VudD4gVTMyX01BWCkgew0KPiArCQlp
ZiAoZm9sZGVyX2NvdW50ID4+IDMyKSB7DQoNCkRpdHRvLg0KDQo+ICAJCQlhdG9taWM2NF9kZWMo
JkhGU19TQihzYiktPmZvbGRlcl9jb3VudCk7DQo+ICAJCQlwcl9lcnIoImNhbm5vdCBjcmVhdGUg
bmV3IGlub2RlOiBmb2xkZXIgY291bnQgZXhjZWVkcyBsaW1pdFxuIik7DQo+ICAJCQlnb3RvIG91
dF9kaXNjYXJkOw0KPiBAQCAtMjMxLDcgKzIzMSw3IEBAIHN0cnVjdCBpbm9kZSAqaGZzX25ld19p
bm9kZShzdHJ1Y3QgaW5vZGUgKmRpciwgY29uc3Qgc3RydWN0IHFzdHIgKm5hbWUsIHVtb2RlX3QN
Cj4gIAl9IGVsc2UgaWYgKFNfSVNSRUcobW9kZSkpIHsNCj4gIAkJSEZTX0koaW5vZGUpLT5jbHVt
cF9ibG9ja3MgPSBIRlNfU0Ioc2IpLT5jbHVtcGFibGtzOw0KPiAgCQlmaWxlX2NvdW50ID0gYXRv
bWljNjRfaW5jX3JldHVybigmSEZTX1NCKHNiKS0+ZmlsZV9jb3VudCk7DQo+IC0JCWlmIChmaWxl
X2NvdW50ID4gVTMyX01BWCkgew0KPiArCQlpZiAoZmlsZV9jb3VudCA+PiAzMikgew0KDQpEaXR0
by4NCg0KPiAgCQkJYXRvbWljNjRfZGVjKCZIRlNfU0Ioc2IpLT5maWxlX2NvdW50KTsNCj4gIAkJ
CXByX2VycigiY2Fubm90IGNyZWF0ZSBuZXcgaW5vZGU6IGZpbGUgY291bnQgZXhjZWVkcyBsaW1p
dFxuIik7DQo+ICAJCQlnb3RvIG91dF9kaXNjYXJkOw0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzL21k
Yi5jIGIvZnMvaGZzL21kYi5jDQo+IGluZGV4IGE5N2NlYTM1Y2EyZS4uNjhkM2MwNzE0MDU3IDEw
MDY0NA0KPiAtLS0gYS9mcy9oZnMvbWRiLmMNCj4gKysrIGIvZnMvaGZzL21kYi5jDQo+IEBAIC02
OSwxNSArNjksMTUgQEAgYm9vbCBpc19oZnNfY25pZF9jb3VudHNfdmFsaWQoc3RydWN0IHN1cGVy
X2Jsb2NrICpzYikNCj4gIAlzdHJ1Y3QgaGZzX3NiX2luZm8gKnNiaSA9IEhGU19TQihzYik7DQo+
ICAJYm9vbCBjb3JydXB0ZWQgPSBmYWxzZTsNCj4gIA0KPiAtCWlmICh1bmxpa2VseShhdG9taWM2
NF9yZWFkKCZzYmktPm5leHRfaWQpID4gVTMyX01BWCkpIHsNCj4gKwlpZiAodW5saWtlbHkoYXRv
bWljNjRfcmVhZCgmc2JpLT5uZXh0X2lkKSA+PiAzMikpIHsNCg0KRGl0dG8uDQoNCj4gIAkJcHJf
d2FybigibmV4dCBDTklEIGV4Y2VlZHMgbGltaXRcbiIpOw0KPiAgCQljb3JydXB0ZWQgPSB0cnVl
Ow0KPiAgCX0NCj4gLQlpZiAodW5saWtlbHkoYXRvbWljNjRfcmVhZCgmc2JpLT5maWxlX2NvdW50
KSA+IFUzMl9NQVgpKSB7DQo+ICsJaWYgKHVubGlrZWx5KGF0b21pYzY0X3JlYWQoJnNiaS0+Zmls
ZV9jb3VudCkgPj4gMzIpKSB7DQoNCkRpdHRvLg0KDQo+ICAJCXByX3dhcm4oImZpbGUgY291bnQg
ZXhjZWVkcyBsaW1pdFxuIik7DQo+ICAJCWNvcnJ1cHRlZCA9IHRydWU7DQo+ICAJfQ0KPiAtCWlm
ICh1bmxpa2VseShhdG9taWM2NF9yZWFkKCZzYmktPmZvbGRlcl9jb3VudCkgPiBVMzJfTUFYKSkg
ew0KPiArCWlmICh1bmxpa2VseShhdG9taWM2NF9yZWFkKCZzYmktPmZvbGRlcl9jb3VudCkgPj4g
MzIpKSB7DQoNCkRpdHRvLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiAgCQlwcl93YXJuKCJmb2xk
ZXIgY291bnQgZXhjZWVkcyBsaW1pdFxuIik7DQo+ICAJCWNvcnJ1cHRlZCA9IHRydWU7DQo+ICAJ
fQ0K

