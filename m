Return-Path: <linux-fsdevel+bounces-40087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AE4A1BDBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 22:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE943A6AA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 21:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3522F1DC9B2;
	Fri, 24 Jan 2025 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gEEQJimm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D91BFE10;
	Fri, 24 Jan 2025 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737752610; cv=fail; b=vFSDYBZKDG0//WCDRDkaBAZXIhyGlsth7nVHVmdOqd0EhryuCIV8xCBhtoWC0cSVwWOVlkqaQ76HCXcrP0xy8gYRl7YdbnwLp/hHYzT2PoTdAn94YDdrmIjwhbUaYhcqlRSQ+A6j0Hn2fmS0cQ3KdpzjjDyNnCcdUT5iv76mR7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737752610; c=relaxed/simple;
	bh=a8R7tU/1CY7pt89N/HSKTlFKXrExdn9bTFh3dF7is8Y=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=FqvAJVzn1KB/tCuuh7h1Qyjs0ibaiYDbRmSkfFO3z+BU2hb+fKPsnVtSXdY7rQJ3COx1N9fFp49JTwJEb/3LB9cTle4wDQSSb7fJe5/P8bMmQjNef/ksCpjjtbb5NhDImLwCaYHxBh2ftkulDhUiLPP8nUfdHxvVo3srZwhiGT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gEEQJimm; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OGGhJK021591;
	Fri, 24 Jan 2025 21:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=a8R7tU/1CY7pt89N/HSKTlFKXrExdn9bTFh3dF7is8Y=; b=gEEQJimm
	/sKJ0TU/Ou/MPUHEmlfDhQkh0U8EP6ZvuxQfMlwaeZ0IiJfFUmdZNx03OVBhfcWY
	vL4oNuQzXXgdlFzDXE31NdMV8XURzpQxAHqGWa34y/qYAHpGvttSqv6vVP97CPlk
	83CP5gADGw/79O8/l+bdjn+m+zcb8Dhv5DrRWYekGu3aPUQREVbkrT512bSDMGJq
	O7qpbmmhEOtBZeEpAi+EnTEx31gfRAeI3KDwPcHb535846eRSZPsABQ3+yg9oCTQ
	2e2TmQYliYZf3Et7/iBW8pGgh4gdcACVM6vY8fUokTw0SlVokMmjEQNPJNPIYMb6
	EhhfKCbxN9rzlw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c6jnkks8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 21:03:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gd3kAKT3L1jbVdfGqePPXaIIwkgwP3zeOQ8GKOPilOSV3LIlfFNGxWyNNZDlpXHZwZnTMAdiHGgx7xW774ZsLwSHAjTuTcjN3cElrklT/OW+x5UKAxU27z7vd9tEgUGnRVPz/X6WhEasy9hCfxbFBXFsZ+YA4NsaGX5Q192hyhK8rsMx8LcseJ50sCFTGiHZcczE91YwMa/k2aQ1Xl4ls/I7zcJXMWT3BWrsmlrXBmpwPJUCGFl3I5T9VbokzihVO8M0uq7/PTlySCHM0yanRO05i3IriM+FnR6UvWdOyUSZ8sNdq4TwV8QiQjJHYrQtsOn0VyKmV8dyy82+zBAtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8R7tU/1CY7pt89N/HSKTlFKXrExdn9bTFh3dF7is8Y=;
 b=sc8OY0ouUYKeK3afKlJyGVlU/8h1L7lhBzndjoHZPt7flu0VSHn82N5yUzkdolYrDd4vWBPLnlq5m2JucBD5cV3UQXYgdRhszSF2oNFSTyCMNqTXgN9XH9qQFO6EaAmR9cOAGmjUY9W3ImwexnIT/nkY3yDCiD8qUlCu2rOyMlH2KHt942lcbgab1gd3ZR4+lP21Chg1z6SgRS7/J9ncLPrN7JIOZ3NPkUPG8d47DEdArYo7M9t4r+AA7r4iD+XPkAAtwaOBlhQoHsNZYX4rKqtlaMvVEP34rBJ8NBBLrLDEGa7IkCbMdxunPji5n13cmfq085VxzmaViix5AZqlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB5056.namprd15.prod.outlook.com (2603:10b6:510:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 21:03:18 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 21:03:18 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "javier.gonz@samsung.com"
	<javier.gonz@samsung.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH] Introduce generalized data
 temperature estimation framework
Thread-Index: AQHbbjjHEmAPuPJvLUyENDU0Npkf+rMmalWA
Date: Fri, 24 Jan 2025 21:03:17 +0000
Message-ID: <f44878932fd26bb273c7948710b23b0e2768852a.camel@ibm.com>
References: <20250123202455.11338-1-slava@dubeyko.com>
	 <fd012640-5107-4d44-9572-4dffb2fd4665@wdc.com>
In-Reply-To: <fd012640-5107-4d44-9572-4dffb2fd4665@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB5056:EE_
x-ms-office365-filtering-correlation-id: 93c04030-00a7-4c58-aadc-08dd3cba86d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZnhqcGZwbndkNDVuaDZOdzdBQzlUanEyOTM1WUQ1T3czUHg1QmdLN2ZLZjFq?=
 =?utf-8?B?RU9qL1c0aUhOUFBNaGNDd3RpeVF5UlVQZVB6YWR3N1ZFSlNINTZDTEF6ZGhj?=
 =?utf-8?B?UlhNZ2hVYnowNjZ0Q24yVWZpUlRmZk9ZaEZ0a1hDcGxrOWJRWS9oSVJ3bzk3?=
 =?utf-8?B?ekxhMm1jS0ZyNEp1Rk5EREdDQWN6TTgwazhYTnJDVEY0R1g0WTFSNEdYRlRp?=
 =?utf-8?B?enl5QStlSlI2dFRDMDViak43NkUwdi9xYXNzL1NwaGVOVTljYUc3UXVXM2VF?=
 =?utf-8?B?OE1lK0RXMEdzQm0xTlhBMzNaTzdvR0l6WS82dzR3b3VNcGNXU01NQkEzb2Zt?=
 =?utf-8?B?QWVHaVZEZU1hUXdCbzlnc00xZG95bU0xakFHL0ZwbTNZakJ3ek1RV2ovQzI5?=
 =?utf-8?B?TzhjUlpXQXowODdOMDR3RDFjQ2xocmVuRUVaWFdrNTI0VjVLTWdYNSs1ODQy?=
 =?utf-8?B?M05jaUhhaFk5eVZzMkdyYThBYm9YaEpoUEJWSmhrMmV5V092dnp0TFJHYnVQ?=
 =?utf-8?B?b3VzakN5QnJZWkxLc0JUOFZGTkFMNFpOQ3dKRTZjeUdUc29QY1JSSlZIa0RU?=
 =?utf-8?B?TFBETG5XdEphMWhmOVIxNkJCcHkrQk5lNEE0NGhCOWY1RlNybWp1ZDdjVmM5?=
 =?utf-8?B?K0VZMzlEbVdLL05QMmM1WTFIeTZ4TStLQzBSRGIrM3NDRlpKUzZ1WmMwclIz?=
 =?utf-8?B?U2NPYlU2N04yZDhlQTVVMHA5QldzbUlnbXBLdTd6eDRTRWxNVVF4Z3VIMnRl?=
 =?utf-8?B?QkdYeEVBY29OUENHRDd3ajhkOWdXQ3d4WjB6c2xyNWczWmpjVnVucWRsUGJw?=
 =?utf-8?B?Ym5HR2hCWnZJRVRGM09BU3VpdU4vUGlFWnFFYk50anlBZk1zS3A1ZXA3S3By?=
 =?utf-8?B?MGF4M1lRbWJRaldBdEJXNWNmdE1vTnZlSUk4T0JmTHlpRnUxdzlkcU9BSjhR?=
 =?utf-8?B?WG1aN3BMYWNpMmx0bnNHUFRmTTZvZENtUEdnamVrU0J3YTlDRk01dytYMGFB?=
 =?utf-8?B?Qm1URTJyYlFUcEZuSms4K0pVK2t1N1R1YXl4UEVEcW9MOEJuU3BEK1l4ZEtR?=
 =?utf-8?B?U3JWdCtGNnNRZ3M2VXVFU2dmT2FBMVZKdnB4UG5QUnZyZWx4bmxPS29rYjY1?=
 =?utf-8?B?czFoOFRXZEZKN0JoQ0RDdlZRb0lBaldrZVR5SElFRElZTVRIQzdpbFZvK1VQ?=
 =?utf-8?B?dmpCTGxjWlBrdEZUV2lxL24walVXTXdUMEhpanhqcFBtdS9KcFNyU3QwSUcv?=
 =?utf-8?B?ZmhHdHVrcFNyTm9GOG9mdi9XUWZ6QlRSRmR6c0VxQTZjR3UyVFFwMWl2SS9q?=
 =?utf-8?B?ZmhFRTVjTC9mdFZCQkhoZ2pYVStpWUd0cGJod2U2OTBlU3NrcUFPLzRaNXhP?=
 =?utf-8?B?TWNzNDNKaW9zZmppcVVEUmxYQTVrdEtDMHR3R1RFdWROWlJTVzdvaTBwc08r?=
 =?utf-8?B?K2NuakNMOUd4emFreHFjWlB1UmRtQnFtVytFSUVWK3d5UVIwbFhlRkdGU1Qr?=
 =?utf-8?B?YmFkVThVS0VFRE1jekdUZTA0cnp6OHVWSTJ6MHNCU2loSzF1QmZmZ2ZNRElJ?=
 =?utf-8?B?dmVTZmVTTy9NdXlnNlFKMmYxSUNNNzBBTUQ5aUpLL0lrYjdwcENoKzY4K1lz?=
 =?utf-8?B?NHU2dTMzakR0MDJhSUs0dU1acGM0anc5bmMxSVpkSEtWZVRYTnV6RS95WWkw?=
 =?utf-8?B?cE1xZ29HNktWRlRFM1k3dFFiOTJjTFUwakgzRyt0czF0aVNId3gxWVhCbFZL?=
 =?utf-8?B?WGlFUFliZEZuZVE0QllNTVBqb2R5THRwd3NaejJCbGdtZi9Ub0JJYXZRVXJX?=
 =?utf-8?B?TlVEcmlxeGVIR3JIaTZOYzRvNU56dlg5QlJaRm5UaUlnTVN5Rm1VTUQ4VE5p?=
 =?utf-8?B?a1U1V1ZxWlZTQlNMSE9OcWZTQnErT3VZUWFqenlhOHBnc3orQkR3a2lvbzls?=
 =?utf-8?Q?AsplEvG65hPNmhew6PIf7dWaPwFK1pK5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFV0QWFEZVg4dUE4d0h2ZkN5VkowVnM2T3h3SlgrNFVzSW9wYUM0V0dHZkFu?=
 =?utf-8?B?ZVBKN095L3hHM2huMjY2MDB5eG0xRlFVaWRuL0JRVlozWElKdzMrTnV3Wjlt?=
 =?utf-8?B?ZUZzS05uM3A1czlOOWtXcVdwVW15Q0hrT3Z0aExReHZTVmpkeDRERTJxdldU?=
 =?utf-8?B?Z2UyVjAwM1NEQzNYNi83NlZnYjR1eVY4ZWNseU96cXllUGt4cVNBYy8wVEdJ?=
 =?utf-8?B?RlFNaVJJcFRSbnF4Q2dOV2Y5SFVGcmxZbGJsZmRyRnhsdXBidk5JVHF2RjlI?=
 =?utf-8?B?VFVWTi9qWW9uSm5BUFM5YU1jS1h1WWtqN1lrRHVwQVdPOGZOOGEwdzRQcXUw?=
 =?utf-8?B?UjVKWEJFQ3lOT01kMjBQSnB4N2V1cGJDWFVQZVNWRWhRV2d3YzhsYU5SRFVT?=
 =?utf-8?B?U2U5OWhTUVJTZ09CL25KSmVoOUhBT20rUlJMRFFoWGpYK3pPdjlkQjJqQXhX?=
 =?utf-8?B?Q1NCTm8wYWlBTkI1UHorUk9oaWVvQ2QrdFp1enhuUFZBL0tWYW1PM0JHMUpH?=
 =?utf-8?B?K2ZpNDNPVHA2WXhCTXlqbWNyZGNoUnAzazU5eHBNNDBDWERCdWdNUTZrNHlQ?=
 =?utf-8?B?dDQydTVRbkh5d3U2Y2FSaGNuY1NLRHpYa01qZ2FJRklicElVTXdOTXFKZDRD?=
 =?utf-8?B?NURaUDAxcGVoQ0RoSGNkWnRTUytjRkczUkdkZ3l2NnJqNDBUc2VCNnNjdnJU?=
 =?utf-8?B?NVJtSDM4YnN4bFFodkVQWW03VEFrenNjT014VXlJVTkyUUhWV2hEOC9xbkZX?=
 =?utf-8?B?RlovbnpvVzhEcmJuL1g0cEo0cnZKaHdCeEdKQ1hrYXZJSHA5YjJic2NCYTFZ?=
 =?utf-8?B?dStZU0pvTDNOYkQyMFhXY2FZMXNYYjVxbVhWTUJEd1dHVkZtMllHQmswTTFF?=
 =?utf-8?B?K2REc1JpK3p1U25WTFpNMFpVeG4wSDVSVTU1b0hudVMrT3FYenFNc1k0VDda?=
 =?utf-8?B?dGFVMFNsajd2Nnl2VDZ2R1NDN3FzTUovKzhSdUFEZHc3NTlWT2VoT21mUXcy?=
 =?utf-8?B?MDlPcVpJL0JGNVVKMmhSRU1yWWhXUWd1a05NVk5RODNCTmVFNEZKak96OEly?=
 =?utf-8?B?QzR5WGh6QjRlUXBZMmxQNEhxd015WGhmL1dORUxlbkNWeDJ4Z1BNWTFJc0Uy?=
 =?utf-8?B?VDRubStXOGRXN0w3UDFkWmtRcEhSV3JvUXpGOVV4MnZqWnZJSklLaWJ4L1k3?=
 =?utf-8?B?LzF2dE5hTU5sT210bzd3WWg3NUsrWWFnNm5PN1dhUUJPVlJDWWYzclQ3R0lC?=
 =?utf-8?B?R0VrVXNuSzVXTnJjZm5CaE1OU2dKaDQ5cTRYYW1oTm4yajFxYmw4blFLNWpW?=
 =?utf-8?B?N3NKckdhY2xIbU9OS0FRT3NqTUY2TWh0NEJEanQ3SzdXVERKcVRMRTJKMmNo?=
 =?utf-8?B?STJmaWhnWHcrdnhGTWU4YVpMcFBKNEpIcWhzTCswQnMxdW5PMjhpRlVjVFpT?=
 =?utf-8?B?TElKNjZkRWFPeEJmUkZvRTduT3dQbDJFNUJmd0JoOUh0cFhvRmU4dVFLRFox?=
 =?utf-8?B?alArUzJtdCthM2o1UEI0cGFEckl5RGlPN3lpcWk1dEFhOEJnaElRUzBSQWZ2?=
 =?utf-8?B?dnZEa3d3b20yTUprSkxzL3lJRVk4U3J5cmE3b3ppdlJvc2l6YWZwZGNLcWZO?=
 =?utf-8?B?bi82bGNpbHR5Umc5OHIvVGRRSmk2M2VoNVpjMjNST1IzSVlXSWtYSUFsaCta?=
 =?utf-8?B?cFdoNlZYKzdab2QvZlQ5anNhc1Zjb3JOUDF2dW8zbmtpNzdtREtNeTFkMGdZ?=
 =?utf-8?B?YWZBOU5Tb2kvYk8rSVJVcXc1TjBaRkZWZGhwcW95UHV1QWlYR1k4SHBEQnFo?=
 =?utf-8?B?QUZ5ZzllRlJDSVdFL3Z2Y05Zck9SWTBQUFFOYXFkZUFqS3RISjA5TytmdWZY?=
 =?utf-8?B?NXcwaGdPVC9rdEx1amdxbzlhMTVrY2ZOcFFFR0k5Y21FK1pDb3ZJRWVNV2k0?=
 =?utf-8?B?S0dTUzBjb2RobVdPcFpRUW1Nejk1SlNwSXZWMTNvbnRiM3dBMGtSV0psNVpP?=
 =?utf-8?B?Mm5EaE93bng2SVYwREJoQWxDRzJGcVd0QTVkQXRZWTdwQ2lacUpDQllSM1p0?=
 =?utf-8?B?aFZNOG80N3R0OHUzaTl5MHF0YldFYkF5c3V0bUM5UG9xUzhaL3g5cVBDd2d3?=
 =?utf-8?B?SEJuVjVLRGVNbUZuQkczRjVCRHdYZkN3VDYzVzg4RnRLL3UyWmpubU5VRmRs?=
 =?utf-8?Q?5bFy6W5SJ1soykRqP/WQ+l4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF0FF9705C924548A59B2ED8833D7FCE@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c04030-00a7-4c58-aadc-08dd3cba86d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 21:03:17.9875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFymVIiqME865ZofiZ/U2VN5syw9KF/OK92EdOLbvNZwjQ5xjV8SkAlPKFcXif0FPjb7JLG9zzgHkkiQlP84VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5056
X-Proofpoint-GUID: 45JBV37gN-2ubJ30zFdbBylt3wQIVPBv
X-Proofpoint-ORIG-GUID: 45JBV37gN-2ubJ30zFdbBylt3wQIVPBv
Subject: RE: [RFC PATCH] Introduce generalized data temperature estimation framework
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_09,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1011 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=799 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240141

T24gRnJpLCAyMDI1LTAxLTI0IGF0IDA4OjE5ICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIDIzLjAxLjI1IDIxOjMwLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6DQo+ID4g
W1BST0JMRU0gREVDTEFSQVRJT05dDQo+ID4gRWZmaWNpZW50IGRhdGEgcGxhY2VtZW50IHBvbGlj
eSBpcyBhIEhvbHkgR3JhaWwgZm9yIGRhdGENCj4gPiBzdG9yYWdlIGFuZCBmaWxlIHN5c3RlbSBl
bmdpbmVlcnMuIEFjaGlldmluZyB0aGlzIGdvYWwgaXMNCj4gPiBlcXVhbGx5IGltcG9ydGFudCBh
bmQgcmVhbGx5IGhhcmQuIE11bHRpcGxlIGRhdGEgc3RvcmFnZQ0KPiA+IGFuZCBmaWxlIHN5c3Rl
bSB0ZWNobm9sb2dpZXMgaGF2ZSBiZWVuIGludmVudGVkIHRvIG1hbmFnZQ0KPiA+IHRoZSBkYXRh
IHBsYWNlbWVudCBwb2xpY3kgKGZvciBleGFtcGxlLCBDT1csIFpOUywgRkRQLCBldGMpLg0KPiA+
IEJ1dCB0aGVzZSB0ZWNobm9sb2dpZXMgc3RpbGwgcmVxdWlyZSB0aGUgaGludHMgcmVsYXRlZCB0
bw0KPiA+IG5hdHVyZSBvZiBkYXRhIGZyb20gYXBwbGljYXRpb24gc2lkZS4NCj4gPiANCj4gPiBb
REFUQSAiVEVNUEVSQVRVUkUiIENPTkNFUFRdDQo+ID4gT25lIG9mIHRoZSB3aWRlbHkgdXNlZCBh
bmQgaW50dWl0aXZlbHkgY2xlYXIgaWRlYSBvZiBkYXRhDQo+ID4gbmF0dXJlIGRlZmluaXRpb24g
aXMgZGF0YSAidGVtcGVyYXR1cmUiIChjb2xkLCB3YXJtLA0KPiA+IGhvdCBkYXRhKS4gSG93ZXZl
ciwgZGF0YSAidGVtcGVyYXR1cmUiIGlzIGFzIGludHVpdGl2ZWx5DQo+ID4gc291bmQgYXMgaWxs
dXNpdmUgZGVmaW5pdGlvbiBvZiBkYXRhIG5hdHVyZS4gR2VuZXJhbGx5DQo+ID4gc3BlYWtpbmcs
IHRoZXJtb2R5bmFtaWNzIGRlZmluZXMgdGVtcGVyYXR1cmUgYXMgYSB3YXkNCj4gPiB0byBlc3Rp
bWF0ZSB0aGUgYXZlcmFnZSBraW5ldGljIGVuZXJneSBvZiB2aWJyYXRpbmcNCj4gPiBhdG9tcyBp
biBhIHN1YnN0YW5jZS4gQnV0IHdlIGNhbm5vdCBzZWUgYSBkaXJlY3QgYW5hbG9neQ0KPiA+IGJl
dHdlZW4gZGF0YSAidGVtcGVyYXR1cmUiIGFuZCB0ZW1wZXJhdHVyZSBpbiBwaHlzaWNzDQo+ID4g
YmVjYXVzZSBkYXRhIGlzIG5vdCBzb21ldGhpbmcgdGhhdCBoYXMga2luZXRpYyBlbmVyZ3kuDQo+
ID4gDQo+ID4gW1dIQVQgSVMgR0VORVJBTElaRUQgREFUQSAiVEVNUEVSQVRVUkUiIEVTVElNQVRJ
T05dDQo+ID4gV2UgdXN1YWxseSBpbXBseSB0aGF0IGlmIHNvbWUgZGF0YSBpcyB1cGRhdGVkIG1v
cmUNCj4gPiBmcmVxdWVudGx5LCB0aGVuIHN1Y2ggZGF0YSBpcyBtb3JlIGhvdCB0aGFuIG90aGVy
IG9uZS4NCj4gPiBCdXQsIGl0IGlzIHBvc3NpYmxlIHRvIHNlZSBzZXZlcmFsIHByb2JsZW1zIGhl
cmU6DQo+ID4gKDEpIEhvdyBjYW4gd2UgZXN0aW1hdGUgdGhlIGRhdGEgImhvdG5lc3MiIGluDQo+
ID4gcXVhbnRpdGF0aXZlIHdheT8gKDIpIFdlIGNhbiBzdGF0ZSB0aGF0IGRhdGEgaXMgImhvdCIN
Cj4gPiBhZnRlciBzb21lIG51bWJlciBvZiB1cGRhdGVzLiBJdCBtZWFucyB0aGF0IHRoaXMNCj4g
PiBkZWZpbml0aW9uIGltcGxpZXMgc3RhdGUgb2YgdGhlIGRhdGEgaW4gdGhlIHBhc3QuDQo+ID4g
V2lsbCB0aGlzIGRhdGEgY29udGludWUgdG8gYmUgImhvdCIgaW4gdGhlIGZ1dHVyZT8NCj4gPiBH
ZW5lcmFsbHkgc3BlYWtpbmcsIHRoZSBjcnVjaWFsIHByb2JsZW0gaXMgaG93IHRvIGRlZmluZQ0K
PiA+IHRoZSBkYXRhIG5hdHVyZSBvciBkYXRhICJ0ZW1wZXJhdHVyZSIgaW4gdGhlIGZ1dHVyZS4N
Cj4gPiBCZWNhdXNlLCB0aGlzIGtub3dsZWRnZSBpcyB0aGUgZnVuZGFtZW50YWwgYmFzaXMgZm9y
DQo+ID4gZWxhYm9yYXRpb24gYW4gZWZmaWNpZW50IGRhdGEgcGxhY2VtZW50IHBvbGljeS4NCj4g
PiBHZW5lcmFsaXplZCBkYXRhICJ0ZW1wZXJhdHVyZSIgZXN0aW1hdGlvbiBmcmFtZXdvcmsNCj4g
PiBzdWdnZXN0cyB0aGUgd2F5IHRvIGRlZmluZSBhIGZ1dHVyZSBzdGF0ZSBvZiB0aGUgZGF0YQ0K
PiA+IGFuZCB0aGUgYmFzaXMgZm9yIHF1YW50aXRhdGl2ZSBtZWFzdXJlbWVudCBvZiBkYXRhDQo+
ID4gInRlbXBlcmF0dXJlIi4NCj4gPiANCj4gPiBbQVJDSElURUNUVVJFIE9GIEZSQU1FV09SS10N
Cj4gPiBVc3VhbGx5LCBmaWxlIHN5c3RlbSBoYXMgYSBwYWdlIGNhY2hlIGZvciBldmVyeSBpbm9k
ZS4gQW5kDQo+ID4gaW5pdGlhbGx5IG1lbW9yeSBwYWdlcyBiZWNvbWUgZGlydHkgaW4gcGFnZSBj
YWNoZS4gRmluYWxseSwNCj4gPiBkaXJ0eSBwYWdlcyB3aWxsIGJlIHNlbnQgdG8gc3RvcmFnZSBk
ZXZpY2UuIFRlY2huaWNhbGx5DQo+ID4gc3BlYWtpbmcsIHRoZSBudW1iZXIgb2YgZGlydHkgcGFn
ZXMgaW4gYSBwYXJ0aWN1bGFyIHBhZ2UNCj4gPiBjYWNoZSBpcyB0aGUgcXVhbnRpdGF0aXZlIG1l
YXN1cmVtZW50IG9mIGN1cnJlbnQgImhvdG5lc3MiDQo+ID4gb2YgYSBmaWxlLiBCdXQgbnVtYmVy
IG9mIGRpcnR5IHBhZ2VzIGlzIHN0aWxsIG5vdCBzdGFibGUNCj4gPiBiYXNpcyBmb3IgcXVhbnRp
dGF0aXZlIG1lYXN1cmVtZW50IG9mIGRhdGEgInRlbXBlcmF0dXJlIi4NCj4gPiBJdCBpcyBwb3Nz
aWJsZSB0byBzdWdnZXN0IG9mIHVzaW5nIHRoZSB0b3RhbCBudW1iZXIgb2YNCj4gPiBsb2dpY2Fs
IGJsb2NrcyBpbiBhIGZpbGUgYXMgYSB1bml0IG9mIG9uZSBkZWdyZWUgb2YgZGF0YQ0KPiA+ICJ0
ZW1wZXJhdHVyZSIuIEFzIGEgcmVzdWx0LCBpZiB0aGUgd2hvbGUgZmlsZSB3YXMgdXBkYXRlZA0K
PiA+IHNldmVyYWwgdGltZXMsIHRoZW4gInRlbXBlcmF0dXJlIiBvZiB0aGUgZmlsZSBoYXMgYmVl
bg0KPiA+IGluY3JlYXNlZCBmb3Igc2V2ZXJhbCBkZWdyZWVzLiBBbmQgaWYgdGhlIGZpbGUgaXMg
dW5kZXINCj4gPiBjb250aW5vdXMgdXBkYXRlcywgdGhlbiB0aGUgZmlsZSAidGVtcGVyYXR1cmUi
IGlzIGdyb3dpbmcuDQo+ID4gDQo+ID4gV2UgbmVlZCB0byBrZWVwIG5vdCBvbmx5IGN1cnJlbnQg
bnVtYmVyIG9mIGRpcnR5IHBhZ2VzLA0KPiA+IGJ1dCBhbHNvIHRoZSBudW1iZXIgb2YgdXBkYXRl
ZCBwYWdlcyBpbiB0aGUgbmVhciBwYXN0DQo+ID4gZm9yIGFjY3VtdWxhdGluZyB0aGUgdG90YWwg
InRlbXBlcmF0dXJlIiBvZiBhIGZpbGUuDQo+ID4gR2VuZXJhbGx5IHNwZWFraW5nLCB0b3RhbCBu
dW1iZXIgb2YgdXBkYXRlZCBwYWdlcyBpbiB0aGUNCj4gPiBuZWFyZXN0IHBhc3QgZGVmaW5lcyB0
aGUgYWdncmVnYXRlZCAidGVtcGVyYXR1cmUiIG9mIGZpbGUuDQo+ID4gQW5kIG51bWJlciBvZiBk
aXJ0eSBwYWdlcyBkZWZpbmVzIHRoZSBkZWx0YSBvZg0KPiA+ICJ0ZW1wZXJhdHVyZSIgZ3Jvd3Ro
IGZvciBjdXJyZW50IHVwZGF0ZSBvcGVyYXRpb24uDQo+ID4gVGhpcyBhcHByb2FjaCBkZWZpbmVz
IHRoZSBtZWNoYW5pc20gb2YgInRlbXBlcmF0dXJlIiBncm93dGguDQo+ID4gDQo+ID4gQnV0IGlm
IHdlIGhhdmUgbm8gbW9yZSB1cGRhdGVzIGZvciB0aGUgZmlsZSwgdGhlbg0KPiA+ICJ0ZW1wZXJh
dHVyZSIgbmVlZHMgdG8gZGVjcmVhc2UuIFN0YXJ0aW5nIGFuZCBlbmRpbmcNCj4gPiB0aW1lc3Rh
bXBzIG9mIHVwZGF0ZSBvcGVyYXRpb24gY2FuIHdvcmsgYXMgYSBiYXNpcyBmb3INCj4gPiBkZWNy
ZWFzaW5nICJ0ZW1wZXJhdHVyZSIgb2YgYSBmaWxlLiBJZiB3ZSBrbm93IHRoZSBudW1iZXINCj4g
PiBvZiB1cGRhdGVkIGxvZ2ljYWwgYmxvY2tzIG9mIHRoZSBmaWxlLCB0aGVuIHdlIGNhbiBkaXZp
ZGUNCj4gPiB0aGUgZHVyYXRpb24gb2YgdXBkYXRlIG9wZXJhdGlvbiBvbiBudW1iZXIgb2YgdXBk
YXRlZA0KPiA+IGxvZ2ljYWwgYmxvY2tzLiBBcyBhIHJlc3VsdCwgdGhpcyBpcyB0aGUgd2F5IHRv
IGRlZmluZQ0KPiA+IGEgdGltZSBkdXJhdGlvbiBwZXIgb25lIGxvZ2ljYWwgYmxvY2suIEJ5IG1l
YW5zIG9mDQo+ID4gbXVsdGlwbHlpbmcgdGhpcyB2YWx1ZSAodGltZSBkdXJhdGlvbiBwZXIgb25l
IGxvZ2ljYWwNCj4gPiBibG9jaykgb24gdG90YWwgbnVtYmVyIG9mIGxvZ2ljYWwgYmxvY2tzIGlu
IGZpbGUsIHdlDQo+ID4gY2FuIGNhbGN1bGF0ZSB0aGUgdGltZSBkdXJhdGlvbiBvZiAidGVtcGVy
YXR1cmUiDQo+ID4gZGVjcmVhc2luZyBmb3Igb25lIGRlZ3JlZS4gRmluYWxseSwgdGhlIG9wZXJh
dGlvbiBvZg0KPiA+IGRpdmlzaW9uIHRoZSB0aW1lIHJhbmdlIChiZXR3ZWVuIGVuZCBvZiBsYXN0
IHVwZGF0ZQ0KPiA+IG9wZXJhdGlvbiBhbmQgYmVnaW4gb2YgbmV3IHVwZGF0ZSBvcGVyYXRpb24p
IG9uDQo+ID4gdGhlIHRpbWUgZHVyYXRpb24gb2YgInRlbXBlcmF0dXJlIiBkZWNyZWFzaW5nIGZv
cg0KPiA+IG9uZSBkZWdyZWUgcHJvdmlkZXMgdGhlIHdheSB0byBkZWZpbmUgaG93IG1hbnkNCj4g
PiBkZWdyZWVzIHNob3VsZCBiZSBzdWJ0cmFjdGVkIGZyb20gY3VycmVudCAidGVtcGVyYXR1cmUi
DQo+ID4gb2YgdGhlIGZpbGUuDQo+ID4gDQo+ID4gW0hPVyBUTyBVU0UgVEhFIEFQUFJPQUNIXQ0K
PiA+IFRoZSBsaWZldGltZSBvZiBkYXRhICJ0ZW1wZXJhdHVyZSIgdmFsdWUgZm9yIGEgZmlsZQ0K
PiA+IGNhbiBiZSBleHBsYWluZWQgYnkgc3RlcHM6ICgxKSBpZ2V0KCkgbWV0aG9kIHNldHMNCj4g
PiB0aGUgZGF0YSAidGVtcGVyYXR1cmUiIG9iamVjdDsgKDIpIGZvbGlvX2FjY291bnRfZGlydGll
ZCgpDQo+ID4gbWV0aG9kIGFjY291bnRzIHRoZSBudW1iZXIgb2YgZGlydHkgbWVtb3J5IHBhZ2Vz
IGFuZA0KPiA+IHRyaWVzIHRvIGVzdGltYXRlIHRoZSBjdXJyZW50IHRlbXBlcmF0dXJlIG9mIHRo
ZSBmaWxlOw0KPiA+ICgzKSBmb2xpb19jbGVhcl9kaXJ0eV9mb3JfaW8oKSBkZWNyZWFzZSBudW1i
ZXIgb2YgZGlydHkNCj4gPiBtZW1vcnkgcGFnZXMgYW5kIGluY3JlYXNlcyBudW1iZXIgb2YgdXBk
YXRlZCBwYWdlczsNCj4gPiAoNCkgZm9saW9fYWNjb3VudF9kaXJ0aWVkKCkgYWxzbyBkZWNyZWFz
ZXMgZmlsZSdzDQo+ID4gInRlbXBlcmF0dXJlIiBpZiB1cGRhdGVzIGhhc24ndCBoYXBwZW5lZCBz
b21lIHRpbWU7DQo+ID4gKDUpIGZpbGUgc3lzdGVtIGNhbiBnZXQgZmlsZSdzIHRlbXBlcmF0dXJl
IGFuZA0KPiA+IHRvIHNoYXJlIHRoZSBoaW50IHdpdGggYmxvY2sgbGF5ZXI7ICg2KSBpbm9kZQ0K
PiA+IGV2aWN0aW9uIG1ldGhvZCByZW1vdmVzIGFuZCBmcmVlIHRoZSBkYXRhICJ0ZW1wZXJhdHVy
ZSINCj4gPiBvYmplY3QuDQo+IA0KPiBJIGRvbid0IHdhbnQgdG8gcG91ciBnYXNvbGluZSBvbiBv
bGQgZmxhbWUgd2FycywgYnV0IHdoYXQgaXMgdGhlIA0KPiBhZHZhbnRhZ2Ugb2YgdGhpcyBhdXRv
LW1hZ2ljIGRhdGEgdGVtcGVyYXR1cmUgZnJhbWV3b3JrIHZzIHRoZSBleGlzdGluZyANCj4gZnJh
bWV3b3JrPw0KPiANCg0KVGhlcmUgaXMgbm8gbWFnaWMgaW4gdGhpcyBmcmFtZXdvcmsuIDopIEl0
J3Mgc2ltcGxlIGFuZCBjb21wYWN0IGZyYW1ld29yay4NCg0KPiAgJ2VudW0gcndfaGludCcgaGFz
IHRlbXBlcmF0dXJlIGluIHRoZSByYW5nZSBvZiBub25lLCBzaG9ydCwgDQo+IG1lZGl1bSwgbG9u
ZyBhbmQgZXh0cmVtZSAod2hhdCBldmVyIHRoYXQgbWVhbnMpLCBjYW4gYmUgc2V0IGJ5IGFuIA0K
PiBhcHBsaWNhdGlvbiB2aWEgYW4gZmNudGwoKSBhbmQgaXMgcGx1bWJlZCBkb3duIGFsbCB0aGUg
d2F5IHRvIHRoZSBiaW8gDQo+IGxldmVsIGJ5IG1vc3QgRlNlcyB0aGF0IGNhcmUuDQoNCkkgc2Vl
IHlvdXIgcG9pbnQuIEJ1dCB0aGUgJ2VudW0gcndfaGludCcgZGVmaW5lcyBxdWFsaXRhdGl2ZSBn
cmFkZXMgYWdhaW46DQoNCmVudW0gcndfaGludCB7DQoJV1JJVEVfTElGRV9OT1RfU0VUCT0gUldI
X1dSSVRFX0xJRkVfTk9UX1NFVCwNCglXUklURV9MSUZFX05PTkUJCT0gUldIX1dSSVRFX0xJRkVf
Tk9ORSwNCglXUklURV9MSUZFX1NIT1JUCT0gUldIX1dSSVRFX0xJRkVfU0hPUlQsICA8LS0gSE9U
IGRhdGENCglXUklURV9MSUZFX01FRElVTQk9IFJXSF9XUklURV9MSUZFX01FRElVTSwgPC0tIFdB
Uk0gZGF0YQ0KCVdSSVRFX0xJRkVfTE9ORwkJPSBSV0hfV1JJVEVfTElGRV9MT05HLCAgIDwtLSBD
T0xEIGRhdGENCglXUklURV9MSUZFX0VYVFJFTUUJPSBSV0hfV1JJVEVfTElGRV9FWFRSRU1FLA0K
fSBfX3BhY2tlZDsNCg0KRmlyc3Qgb2YgYWxsLCBhZ2FpbiwgaXQncyBoYXJkIHRvIGNvbXBhcmUg
dGhlIGhvdG5lc3Mgb2YgZGlmZmVyZW50IGZpbGVzDQpvbiBzdWNoIHF1YWxpdGF0aXZlIGJhc2lz
LiBTZWNvbmRseSwgd2hvIGRlY2lkZXMgd2hhdCBpcyBob3RuZXNzIG9mIGEgcGFydGljdWxhcg0K
ZGF0YT8gUGVvcGxlIGNhbiBvbmx5IGd1ZXNzIG9yIGFzc3VtZSB0aGUgbmF0dXJlIG9mIGRhdGEg
YmFzZWQgb24NCmV4cGVyaWVuY2UgaW4gdGhlIHBhc3QuIEJ1dCB3b3JrbG9hZHMgYXJlIGNoYW5n
aW5nIGFuZCBldm9sdmluZw0KY29udGludW91c2x5IGFuZCBpbiByZWFsLXRpbWUgbWFubmVyLiBU
ZWNobmljYWxseSBzcGVha2luZywgYXBwbGljYXRpb24gY2FuDQp0cnkgdG8gZXN0aW1hdGUgdGhl
IGhvdG5lc3Mgb2YgZGF0YSwgYnV0LCBhZ2FpbiwgZmlsZSBzeXN0ZW0gY2FuIHJlY2VpdmUNCnJl
cXVlc3RzIGZyb20gbXVsdGlwbGUgdGhyZWFkcyBhbmQgbXVsdGlwbGUgYXBwbGljYXRpb25zLiBT
bywgYXBwbGljYXRpb24NCmNhbiBndWVzcyBhYm91dCByZWFsIG5hdHVyZSBvZiBkYXRhIHRvby4g
RXNwZWNpYWxseSwgbm9ib2R5IHdvdWxkIGxpa2UNCnRvIGltcGxlbWVudCBkZWRpY2F0ZWQgbG9n
aWMgaW4gYXBwbGljYXRpb24gZm9yIGRhdGEgaG90bmVzcyBlc3RpbWF0aW9uLg0KDQpUaGlzIGZy
YW1ld29yayBpcyBpbm9kZSBiYXNlZCBhbmQgaXQgdHJpZXMgdG8gZXN0aW1hdGUgZmlsZSdzDQoi
dGVtcGVyYXR1cmUiIG9uIHF1YW50aXRhdGl2ZSBiYXNpcy4gQWR2YW50YWdlcyBvZiB0aGlzIGZy
YW1ld29yazoNCigxKSB3ZSBkb24ndCBuZWVkIHRvIGd1ZXNzIGFib3V0IGRhdGEgaG90bmVzcywg
dGVtcGVyYXR1cmUgd2lsbCBiZQ0KY2FsY3VsYXRlZCBxdWFudGl0YXRpdmVseTsgKDIpIHF1YW50
aXRhdGl2ZSBiYXNpcyBnaXZlcyBvcHBvcnR1bml0eQ0KZm9yIGZhaXIgY29tcGFyaXNvbiBvZiBk
aWZmZXJlbnQgZmlsZXMnIHRlbXBlcmF0dXJlOyAoMykgZmlsZSdzIHRlbXBlcmF0dXJlDQp3aWxs
IGNoYW5nZSB3aXRoIHdvcmtsb2FkKHMpIGNoYW5naW5nIGluIHJlYWwtdGltZTsgKDQpIGZpbGUn
cw0KdGVtcGVyYXR1cmUgd2lsbCBiZSBjb3JyZWN0bHkgYWNjb3VudGVkIHVuZGVyIHRoZSBsb2Fk
IGZyb20gbXVsdGlwbGUNCmFwcGxpY2F0aW9ucy4gSSBiZWxpZXZlIHRoZXNlIGFyZSBhZHZhbnRh
Z2VzIG9mIHRoZSBzdWdnZXN0ZWQgZnJhbWV3b3JrLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

