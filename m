Return-Path: <linux-fsdevel+bounces-79660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qz6fIps1q2lPbAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:14:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D62276CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79B8D304BCEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 20:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902A8377543;
	Fri,  6 Mar 2026 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FFnZF/M9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F69285C91;
	Fri,  6 Mar 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828052; cv=fail; b=txXtjdk84bM1LPuhx8oAkFAYeK5rmicmIICB29NnJFfh1hreKvJPhb+/spSpKoY38Ll6Su1Uue1yu5XnfFepCKMvLND1Vnw6bHAsap3Dqes6/Oqf05boUqSdf3ugyX93zJbK6EKjZQ1N2PAdLk7m2X+KykyvMOuWUvUU+ESA+As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828052; c=relaxed/simple;
	bh=R8S41Q0djiE8lQrk5NH1BUjDH+LxukHGLSRfnEKsSNI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Vo2XdQCiC1ViLBL+epwvGkDiMUo1K6ICuhbnmjEMh7Zvsd4kQ5Xv1XeMqck6qaiKLpO30FioNmTJpVa82rKnH8ZmnNheVOgDJTPuLiaN/KnVGXdgYHrfBS7SmwWc8J6GW/Hhx2tGEs6v1Fr/EqXJIVDeXe+9LfcyyAgbCLPT5sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FFnZF/M9; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626AmQKl1631552;
	Fri, 6 Mar 2026 20:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=R8S41Q0djiE8lQrk5NH1BUjDH+LxukHGLSRfnEKsSNI=; b=FFnZF/M9
	/gxlmdjG2Vet1RcrxjUXbbEPs4nb1si8g/VVds+dh54fmxGI6UylZ+V8REw5A++S
	kN67wY3rynjgTtPNwAT917l+Yov1QtCzb6Q7OAVylTzT2jbE5JnoOATwBvjLMjsm
	7QXKxRvYNhhDoiDmiVLy8SvyNht1wRNrMQOSJb4HwJrpn1f+EQ5fvlZVQ1Z/JGx7
	gvVMFTIUMDuy1CBvTM41/AbLw1b1+mkYnnOI2+gNUzkocp7q4BlxvP2Qpl/cDXnr
	lbE9LFNhLd26VIxeeritn2cO2pivYDKJHhI9PQSIa3Xnd3//AGe3WuY8hOYirDQs
	+NwBTuS1Odxkyw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskda9bw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 20:08:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9Yfh4v5VN2MWmaaC5awzlvufptxUajACdG/vajgCzyoOTqULM+7puyc5kZ6OBARBV9hkoyWG4UdigfYyfBXYYOrLsOPnQzCxqEi0XNGMNSsyH9IXySXsEnpP4LddxR02ZCSvBl+pmQ/zARaVsyqTY5lY4xaI9NMUk5L3v22RYV2woVQW583qChAvT7NUsFMyMJCewJOaLwYkRC3PyzLgL93ZS5bXZeMIS27QSRbLdzGw1nQqxsmr+JWpa9mA+laZkFLKGSzTBWiN6RP/+hYTBQVZeajUYQHUCuWFVGzZhwFi8uy/3bZzFRZmKkn5w/rTngtpAXisL6U/B5S7S5Kmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8S41Q0djiE8lQrk5NH1BUjDH+LxukHGLSRfnEKsSNI=;
 b=hj2DHN0tHhDGesvf0B7aHyjhsulj4kURUhyvGnCcfREuMwCQjTKqtFLBQIztMToTSgpivNVerko4c1RWSCFYG4d8ZnRif1RrsRpQ8X9UPOv1cWcst1bX1dMU8XUmjTWu6PLn1Wcd5y+AXjbyAqM0ryJrA9RFvlNrj6ZgPGwgpz6P1vt1JFwwSicI95HCSbgskrjljDrBiVYZuWui9eOpDTPJndA1tquqPZ9KZcXsMmoOonT6uKA2N3JbcPHTvft2/4xS1/5e8G1LzTHqR6xOz36Rs9qa0qPitwlk1mZIJkDkKyRjCrnlcIn2AS23TU61ngE9eKoMARCxO8v6+xnxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB5248.namprd15.prod.outlook.com (2603:10b6:a03:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 20:08:40 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 20:08:40 +0000
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
Thread-Index:
 AQHcq9hDf3IahKMroEqX1R8/F3zmX7WezIeAgABKD4CAAATZAIAAEm4AgAFn/ACAABr6gIAABxiAgAALsYCAAS6+gA==
Date: Fri, 6 Mar 2026 20:08:40 +0000
Message-ID: <cecaebb4c333439ea6e10808908f69cd3f3dbf95.camel@ibm.com>
References: <20260303082807.750679-1-hyc.lee@gmail.com>
	 <aaguv09zaPCgdzWO@infradead.org>
	 <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
	 <aajObSSRGVXG3sI_@hyunchul-PC02>
	 <532c5cdf12ced8eee5e5a93efe592937b63b889d.camel@ibm.com>
	 <CANFS6bZm3G9HA3X5Bi2_KGZDNGuguQzG44-cMcQHto2+qe_05g@mail.gmail.com>
	 <e979abaf61fa6d7fab444eac293fcbc2993c78ee.camel@ibm.com>
	 <aaomj9LgbfSem-aF@hyunchul-PC02>
	 <f174f7f928c9ee29f1c138d9ca1b23abfbc77d0c.camel@ibm.com>
	 <aao2Ua94b16am-BE@hyunchul-PC02>
In-Reply-To: <aao2Ua94b16am-BE@hyunchul-PC02>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB5248:EE_
x-ms-office365-filtering-correlation-id: 6fcdaf88-b1a2-4ad6-7328-08de7bbc28f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 xl4QY+BzkA1w4bhQobFFx6x1U16Z4itDoIJ1kNOZiB0oEVuyUdrplEmWnLet3KXIkG2vz2cxMcW6vuVB+yFQq9DXRcsFjKeLXrgEezmPyGABPc7NcMlTHjlqC9fJcHMWne+/kkoXJ96pVdFY/dU2NV5gTMq9JmuHokIEfGh3lTg+PTcc00OJJQwVykOmQDyrUN87zAeJ8UW76wfIe8OG+aZa68zKf+LY5fa4EhV10fbkzxMpWaB5fFgYkL9PD5f21BgMYropvFHNAcq39xv8qqDXz6nnWxXWIl8DCQdvkrqSAb0Wi9NtKO4ALWi9WvKOnbeN5uiNiEe5gvFSfZJqQRZCzC26bPeZUJHZDcLBF1dK3IzP1XEWWPNh9X/H4oUt1VG9yM0gv37yskwXK3uMa7mVRkVVUKf1ujZQ5gjOXlMAx++h7Rk+/w8RV6lcCENvDjpIdawSf4KKrDkRKLD82EWXG0t088PuWEvke8bcdMTaAzvCcjl10g4O8NuzDFgsoJSvZnikW7ZxKV7pSKBbwPcXzeQc6vbuGLTUaaj/K2kBZlTLyoB1S62X9cfLxCf5gHb1t87IPjVQisjBKV/0J5voBUoPh/b1fbWEf0k6Bb6IXcWGt3wDsyileWqySQkpb1asHdbQT09YyUeD/Ff49VVOrUvL4t3l8VL2UlwUrJmNzo6SSv8e3ImxE2n2Apb/9VaPqL/Isvwas3aCm6ay38tCq5oddVM/8yBSwsX8yBF6wJ1ezqVrUgyKGyK6BCN8dqakY0yW1AqunxaYEzcML3O/zS5knuR4hmsV6pPZKXw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N29DSksyZWVjSFRSQnJmNXJZc0JJRTZ3b3YrM0dIb09lTHRxS3NOSEhXWm5G?=
 =?utf-8?B?bmFHUSttR3NMZFRSWkdYeVhtL0VkR2o3U3dSMHZaNnd1M2c0UmtJR0xxZ0RX?=
 =?utf-8?B?dXFoeHpNYlZNWFZkZFJGN3p6d2NoYThHb2FhK0VPcWI2ek9VRURtWmo2aDhh?=
 =?utf-8?B?TEtBcExreFJmQlNpWnVJSUhvbldPZmhsajVIMlhFVHptT1FOM2NkOWhOOGx0?=
 =?utf-8?B?ZXpudnduQU1mVzgrcUtEMkNNUU5IZVB0bHBrVVZLVlRhMzIwKzBleVFPVm41?=
 =?utf-8?B?R0VEZGNDZXZMeVNXTnJDemxJZWhZaHdMS0pYVFBleXhVcEJENUdKM0JDZ05o?=
 =?utf-8?B?SGtoTTZJNXZEenAwYWJUSGhKZ2o1d1d1YmgydXEzWGJBR0JIWHl1L1ltVDFL?=
 =?utf-8?B?NXlBQ1E3U0RsaGt1cEw4ajB6YTg4SkNtZDZBc2F0UVFTUjBEeW8ydE1GZjJS?=
 =?utf-8?B?SmRJRWl0dm5rQVlsRlBYdDVwVTJCc1BJNTRUcFlsSlZJWm5heVNtMFFuMFNZ?=
 =?utf-8?B?R3p0a1EvelA0ek03dDU0T2orV2ZMTHRmK3I0NEFOUjJ5TC9uQkhqOW5Kc2p3?=
 =?utf-8?B?d0REUHBoQ0MreVZQUHpneFJuMzFVRWtndjM3L0FXSm5pTkhhVFVVVGlBbUpm?=
 =?utf-8?B?YjZ0ZnZXZHIvUmR5bU5kRk5HNnNUQkwzeW9OOXJLWWN0cmZZY1czdm1MSGtr?=
 =?utf-8?B?VVFrdTYwTmZxK2RHczNTWXNzWDhSTVhsWHNYT24xSng0anNYQjIrYjhYSjk2?=
 =?utf-8?B?dVZQenRDWUwwWWE3b3BlQ0ZhMStDcldUcDl2ZWdYQXlrQTJLVkJQSFJKcGs0?=
 =?utf-8?B?OWhoaUlOWmZqaGc2WjBicWMrWVE0d1Z0YUpRUmdnRW10MGlzelllMVBIQVlv?=
 =?utf-8?B?cjlycWkzYTh5WFdwRlFTWjZ5K2dTNDM5VHAwMHBML1NJY3JSNE55UFlUSTlX?=
 =?utf-8?B?aExjajhTYkJLeXc2VS9QZ0dybHN6TXhwZmFQbGRSdVBXYmVRSnR2dzR1MkVN?=
 =?utf-8?B?N3NNVXJOTXBqVE9zalhHSVpGZWMxT2d1QmlwVm5BUkYxZXNCOXRqWStrdUEw?=
 =?utf-8?B?UXlEWUtkMnEvVm5wekVBTGRvTFhERnZOOFUzR3BkWlhncEpEN2lpbTJxUGRu?=
 =?utf-8?B?WlY4YmZ3RDFPYmYwOENvVCtnYnFRbFlEYnNmanoxUmNNblppdkN5eGx1LzUz?=
 =?utf-8?B?clV0SEpwZElLN2tpYXh1VE5yUWJyRHVBZUN2Q3JYSkVERlpZZlZQUzdpemxq?=
 =?utf-8?B?enhaUURYNGlqVW44ZEZsSkE5QVQ5VUowVjVlaHU5YUNqWGhYS0RPTUp0RXNX?=
 =?utf-8?B?Z2ppUjVnbWRjMlp2WnVoTjNCQWNmdTFpQ29aNzZoVG1veVRGeit1em9HRCt2?=
 =?utf-8?B?RXQyOWhCY1FWd2wrTDR5ZjhJVlZUQTROZVg4TmVPWllJMm9RQmJhdlpTOHJT?=
 =?utf-8?B?ak9tZnNUV0NSUWZQd0YxdEpIN29KdTRXUlVkMjRibTNOeE1QZjEzNXBrcmQz?=
 =?utf-8?B?eEpYZjNiYnR5WGZraXdlaVFaWnJsbVRFbE95aXVoV2RtZWg1QjNaRTNzSWov?=
 =?utf-8?B?VklNUXFSajFmVmtHb2lvendoTnJYa1Ywb0h5ZWNac3MxUis4V0JFUzJ0aW1Y?=
 =?utf-8?B?T1prd096eGhaUWtZdVZVRXFaRGxST0MvYUFGQTN6ZXVvZktXVzdnSnZkNnMw?=
 =?utf-8?B?OEVoYmJuS252WGNwWlB5SGN6cnZDSGtnTzFkNmd5Nm0ycEI0Q1VtSWVUbERK?=
 =?utf-8?B?YXRHQTdORjBLNEJEWmNGb0tVTFkvb1Rjb0FqbDM5WWFRRHVCeTFnMGlPU0gy?=
 =?utf-8?B?Qk9IeGphazYzeU5XYUxrRE1Jdy92NUZuNG40YWkzZ0RPUUlZeGZHOHdNQWxy?=
 =?utf-8?B?M2hWVUdvQm9DcHhvcGxKdFAyc0JtMUsrZVdURmlRdHErVFZnVFN4OTBpQWFa?=
 =?utf-8?B?N0F4VnpDSEJtanpXVUgxQjZ4bXFndC9xK1oxRkJia25udW9BcFZiRkhNblRE?=
 =?utf-8?B?cUxNZ05ZVWQwL0dHZklyejN0Nm9TVXRhcjZBTmdFQzZmMjBBTTFTYlVUQ0Ey?=
 =?utf-8?B?MGk3TW5WSlBES3VndnNJQkFLKzMrb0NxbGQ2WVJvWHU5b0xIUUFqNmt6ZVRa?=
 =?utf-8?B?UnZhYWRXWElhOXNpVUtGa1JmQmJuQmtlK2RXK2JvdU1kVW84RmFSSkJqRmpi?=
 =?utf-8?B?MExrZ3NzYXJDKzlRbElmSk5idHluM042bFU0a1RyT1dncm5RZWVCOGgvc3Z3?=
 =?utf-8?B?TkdDRCtvZ3g5dmgyc2tMa0pNNGVOVFFnNU5OcVg1WFV0ZDZpSmFxNkwvYUdR?=
 =?utf-8?B?SkFBS2tBMEI5NjZKSVBYYktKMXZ0bXVxeU56MmRFNVVnTVF4a3phakljK2RU?=
 =?utf-8?Q?6v9+ZugMKy216LH4R5MnAPOwsCDSyh4qvjy7L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB5FA1017421254A91EFA1F97AFA5301@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	e/MoRJTU6QFGlBekhNETFz9RzvkZZhZ1hsEeED2NM0b/N79qc7FFwlA4LIcgYaD/ni11rF50xxQTfgpYObvk+kgtEK5YOVlF/yNUKNuBu3eFXqm12LxiLg0qGhKWvPJnxl7q06MEFmdnlVmPi1BpFlCjNFWIrC9B3vc6RHyJx/D30r6qwrMU/7s+caf078FzOOpgk6Rw8Mp/teirggFH7jLvbVS0LzBNCvLaApU0sytdZG6uKYDot3r7J68cFK5I7oCgQ52qe7aaqN2aM5VJ67tw2VbMrqlMBeNyQLksxBQWRWXwEHr/FEJbrFHTWaEsLdwL0VuxQAxlqTkTy4w+Kg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcdaf88-b1a2-4ad6-7328-08de7bbc28f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 20:08:40.3694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8km/DdCabah+3K5NEGftVHD3Vi7kvTa30CyN5oaaWu6PWSDNyJkLc82FnqY+lYRZuIihRk7V7HiS4auGKaYSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5248
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 02GHkyhvjmFriwZf3xkrHYEmxEnqj5Cb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE5MCBTYWx0ZWRfXyDqSTnG8C1Hi
 dx+25oGqSXUHS83ZpjdLl1gXAoe45tWO0QiuSZzpuJ5BIWHm5hlOe3sasVT7ldItEJHY4+XFYCa
 4AZ5LfAQRZx/lpmRaTvKiqHZqBs1HhfrvI8APYcD0UnNThKGhV8vxd/pKzldHiBOKUThqXurmYf
 T1BezdCCYTQSdLTlOzpkGhxIywhIqxv/XaK5rKE+7B0951607r3JiMGVHO/VadRkw1kUk3KvDgF
 zzD2GELZqSfEFpFpik0EUvApLfxTVHoqWIfQkzTe9LwTX3nDGc5a48Fc8JyZMGCrwlsHL9qO8th
 gwiupXleGy0+c0jp/QEdnSh/2OaA/3/6mXaLY+1Yqc81rNTlIiBL6xiTMCWCu/g3K+kPgACXvva
 BPr/H5deeK1anV3+0lSZMkTHWGIzWH6O2yNQ9krIxTGZ77DR/u/PnDAWA86+7bsWx2ndGR8g/0g
 hzj1l77IJRujKOaI49Q==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69ab344d cx=c_pps
 a=fkezOHFRVmK1Ww34+/XMiQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=Odn45VFh_G48v7oVdbIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dPq5K1ZCgijwMfsMk75keX8Nd07tgry2
Subject: RE: [PATCH] hfsplus: limit sb_maxbytes to partition size
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060190
X-Rspamd-Queue-Id: D73D62276CC
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
	TAGGED_FROM(0.00)[bounces-79660-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAzLTA2IGF0IDExOjA1ICswOTAwLCBIeXVuY2h1bCBMZWUgd3JvdGU6DQo+
IE9uIEZyaSwgTWFyIDA2LCAyMDI2IGF0IDAxOjIzOjE2QU0gKzAwMDAsIFZpYWNoZXNsYXYgRHVi
ZXlrbyB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjYtMDMtMDYgYXQgMDk6NTcgKzA5MDAsIEh5dW5j
aHVsIExlZSB3cm90ZToNCj4gPiA+IE9uIFRodSwgTWFyIDA1LCAyMDI2IGF0IDExOjIxOjE5UE0g
KzAwMDAsIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToNCj4gPiA+ID4gT24gVGh1LCAyMDI2LTAz
LTA1IGF0IDEwOjUyICswOTAwLCBIeXVuY2h1bCBMZWUgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gPiBTb3JyeSBpdCdzIGdlbmVyaWMvMjg1LCBub3QgZ2VuZXJpYy8yNjguDQo+
ID4gPiA+ID4gPiA+IGluIGdlbmVyaWMvMjg1LCB0aGVyZSBpcyBhIHRlc3QgdGhhdCBjcmVhdGVz
IGEgaG9sZSBleGNlZWRpbmcgdGhlIGJsb2NrDQo+ID4gPiA+ID4gPiA+IHNpemUgYW5kIGFwcGVu
ZHMgc21hbGwgZGF0YSB0byB0aGUgZmlsZS4gaGZzcGx1cyBmYWlscyBiZWNhdXNlIGl0IGZpbGxz
DQo+ID4gPiA+ID4gPiA+IHRoZSBibG9jayBkZXZpY2UgYW5kIHJldHVybnMgRU5PU1BDLiBIb3dl
dmVyIGlmIGl0IHJldHVybnMgRUZCSUcNCj4gPiA+ID4gPiA+ID4gaW5zdGVhZCwgdGhlIHRlc3Qg
aXMgc2tpcHBlZC4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEZvciB3cml0ZXMgbGlr
ZSB4ZnNfaW8gLWMgInB3cml0ZSA4dCA1MTIiLCBzaG91bGQgZm9wcy0+d3JpdGVfaXRlcg0KPiA+
ID4gPiA+ID4gPiByZXR1cm5zIEVOT1NQQywgb3Igd291bGQgaXQgYmUgYmV0dGVyIHRvIHJldHVy
biBFRkJJRz8NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQ3Vy
cmVudCBoZnNwbHVzX2ZpbGVfZXh0ZW5kKCkgaW1wbGVtZW50YXRpb24gZG9lc24ndCBzdXBwb3J0
IGhvbGVzLiBJIGFzc3VtZSB5b3UNCj4gPiA+ID4gPiA+IG1lYW4gdGhpcyBjb2RlIFsxXToNCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gICAgICAgICBsZW4gPSBoaXAtPmNsdW1wX2Jsb2NrczsN
Cj4gPiA+ID4gPiA+ICAgICAgICAgc3RhcnQgPSBoZnNwbHVzX2Jsb2NrX2FsbG9jYXRlKHNiLCBz
YmktPnRvdGFsX2Jsb2NrcywgZ29hbCwgJmxlbik7DQo+ID4gPiA+ID4gPiAgICAgICAgIGlmIChz
dGFydCA+PSBzYmktPnRvdGFsX2Jsb2Nrcykgew0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAg
IHN0YXJ0ID0gaGZzcGx1c19ibG9ja19hbGxvY2F0ZShzYiwgZ29hbCwgMCwgJmxlbik7DQo+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgaWYgKHN0YXJ0ID49IGdvYWwpIHsNCj4gPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIHJlcyA9IC1FTk9TUEM7DQo+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICB9DQo+ID4gPiA+ID4gPiAgICAgICAgIH0NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQW0g
SSBjb3JyZWN0Pw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gWWVzLA0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IGhmc3BsdXNfd3JpdGVfYmVnaW4oKQ0KPiA+ID4gPiA+ICAgY29udF93cml0ZV9iZWdp
bigpDQo+ID4gPiA+ID4gICAgIGNvbnRfZXhwYW5kX3plcm8oKQ0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IDEpIHhmc19pbyAtYyAicHdyaXRlIDh0IDUxMiINCj4gPiA+ID4gPiAyKSBoZnNwbHVzX2Jl
Z2luX3dyaXRlKCkgaXMgY2FsbGVkIHdpdGggb2Zmc2V0IDJeNDMgYW5kIGxlbmd0aCA1MTINCj4g
PiA+ID4gPiAzKSBjb250X2V4cGFuZF96ZXJvKCkgYWxsb2NhdGVzIGFuZCB6ZXJvZXMgb3V0IG9u
ZSBibG9jayByZXBlYXRlZGx5DQo+ID4gPiA+ID4gZm9yIHRoZSByYW5nZQ0KPiA+ID4gPiA+IDAg
dG8gMl40MyAtIDEuIFRvIGFjaGlldmUgdGhpcywgaGZzcGx1c193cml0ZV9iZWdpbigpIGlzIGNh
bGxlZCByZXBlYXRlZGx5Lg0KPiA+ID4gPiA+IDQpIGhmc3BsdXNfd3JpdGVfYmVnaW4oKSBhbGxv
Y2F0ZXMgb25lIGJsb2NrIHRocm91Z2ggaGZzcGx1c19nZXRfYmxvY2soKSA9Pg0KPiA+ID4gPiA+
IGhmc3BsdXNfZmlsZV9leHRlbmQoKQ0KPiA+ID4gPiANCj4gPiA+ID4gSSB0aGluayB3ZSBjYW4g
Y29uc2lkZXIgdGhlc2UgZGlyZWN0aW9uczoNCj4gPiA+ID4gDQo+ID4gPiA+ICgxKSBDdXJyZW50
bHksIEhGUysgY29kZSBkb2Vzbid0IHN1cHBvcnQgaG9sZXMuIFNvLCBpdCBtZWFucyB0aGF0DQo+
ID4gPiA+IGhmc3BsdXNfd3JpdGVfYmVnaW4oKSBjYW4gY2hlY2sgcG9zIHZhcmlhYmxlIGFuZCBp
X3NpemVfcmVhZChpbm9kZSkuIElmIHBvcyBpcw0KPiA+ID4gPiBiaWdnZXIgdGhhbiBpX3NpemVf
cmVhZChpbm9kZSksIHRoZW4gaGZzcGx1c19maWxlX2V4dGVuZCgpIHdpbGwgcmVqZWN0IHN1Y2gN
Cj4gPiA+ID4gcmVxdWVzdC4gU28sIHdlIGNhbiByZXR1cm4gZXJyb3IgY29kZSAocHJvYmFibHks
IC1FRkJJRykgZm9yIHRoaXMgY2FzZSB3aXRob3V0DQo+ID4gPiA+IGNhbGxpbmcgaGZzcGx1c19m
aWxlX2V4dGVuZCgpLiBCdXQsIGZyb20gYW5vdGhlciBwb2ludCBvZiB2aWV3LCBtYXliZSwNCj4g
PiA+ID4gaGZzcGx1c19maWxlX2V4dGVuZCgpIGNvdWxkIGJlIG9uZSBwbGFjZSBmb3IgdGhpcyBj
aGVjay4gRG9lcyBpdCBtYWtlIHNlbnNlPw0KPiA+ID4gPiANCj4gPiA+ID4gKDIpIEkgdGhpbmsg
dGhhdCBoZnNwbHVzX2ZpbGVfZXh0ZW5kKCkgY291bGQgdHJlYXQgaG9sZSBvciBhYnNlbmNlIG9m
IGZyZWUNCj4gPiA+ID4gYmxvY2tzIGxpa2UgLUVOT1NQQy4gUHJvYmFibHksIHdlIGNhbiBjaGFu
Z2UgdGhlIGVycm9yIGNvZGUgZnJvbSAtRU5PU1BDIHRvIC0NCj4gPiA+ID4gRUZCSUcgaW4gaGZz
cGx1c193cml0ZV9iZWdpbigpLiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gPiA+ID4gDQo+ID4gPiBF
dmVuIGlmIGhvbGVzIGFyZSBub3Qgc3VwcG9ydGVkLCBzaG91bGRuJ3QgdGhlIGZvbGxvd2luZyB3
cml0ZXMgYmUNCj4gPiA+IHN1cHBvcnRlZD8NCj4gPiA+IA0KPiA+ID4geGZzX2lvIC1mIC1jICJw
d3JpdGUgNGsgNTEyIiA8ZmlsZS1wYXRoPg0KPiA+ID4gDQo+ID4gPiBJZiBzbywgc2luY2Ugd2Ug
bmVlZCB0byBzdXBwb3J0IGNhc2VzIHdoZXJlIHBvcyA+IGlfc2l6ZV9yZWFkKGlub2RlKSwNCj4g
PiANCj4gPiBUaGUgcG9zID4gaV9zaXplX3JlYWQoaW5vZGUpIG1lYW5zIHRoYXQgeW91IGNyZWF0
ZSB0aGUgaG9sZS4gQmVjYXVzZSwNCj4gDQo+IFRoYXQncyBjb3JyZWN0LiBIb3dldmVyIEkgYmVs
aWV2ZSB0aGF0IG5vdCBzdXBwb3J0aW5nIHdyaXRlcyBsaWtlIHRoZQ0KPiBvbmUgbWVudGlvbmVk
IGFib3ZlIGlzIGEgc2lnbmlmaWNhbnQgbGltaXRhdGlvbi4gRmlsZXN5c3RlbXMgdGhhdCBkb24n
dA0KPiBzdXBwb3J0IHNwYXJzZSBmaWxlcywgc3VjaCBhcyBleEZBVCwgYWxsb2NhdGUgYmxvY2tz
IGFuZCBmaWxsIHRoZW0gd2l0aA0KPiB6ZXJvcy4NCj4gDQoNCllvdSBhcmUgd2VsY29tZWQgdG8g
d3JpdGUgdGhlIGNvZGUgZm9yIEhGUy9IRlMrLiA6KSBJJ2xsIGJlIGhhcHB5IHRvIHNlZSBzdWNo
DQpzdXBwb3J0Lg0KDQo+ID4gb3Bwb3NpdGVseSwgd2hlbiBIRlMrIGxvZ2ljIHRyaWVzIHRvIGFs
bG9jYXRlIG5ldyBibG9jaywgdGhlbiBpdCBleHBlY3RzIHRvIGhhdmUNCj4gPiBwb3MgPT0gaV9z
aXplX3JlYWQoaW5vZGUpLiBBbmQgd2UgbmVlZCB0byB0YWtlIGludG8gYWNjb3VudCB0aGlzIGNv
ZGUgWzFdOg0KPiA+IA0KPiA+IAlpZiAoaWJsb2NrID49IGhpcC0+ZnNfYmxvY2tzKSB7DQo+ID4g
CQlpZiAoIWNyZWF0ZSkNCj4gPiAJCQlyZXR1cm4gMDsNCj4gPiAJCWlmIChpYmxvY2sgPiBoaXAt
PmZzX2Jsb2NrcykgPC0tIFRoaXMgaXMgdGhlIHJlamVjdGlvbiBvZiBob2xlDQo+ID4gCQkJcmV0
dXJuIC1FSU87DQo+ID4gCQlpZiAoYWJsb2NrID49IGhpcC0+YWxsb2NfYmxvY2tzKSB7DQo+ID4g
CQkJcmVzID0gaGZzcGx1c19maWxlX2V4dGVuZChpbm9kZSwgZmFsc2UpOw0KPiA+IAkJCWlmIChy
ZXMpDQo+ID4gCQkJCXJldHVybiByZXM7DQo+ID4gCQl9DQo+ID4gCX0NCj4gPiANCj4gPiBUaGUg
Z2VuZXJpY193cml0ZV9lbmQoKSBjaGFuZ2VzIHRoZSBpbm9kZSBzaXplOiBpX3NpemVfd3JpdGUo
aW5vZGUsIHBvcyArDQo+ID4gY29waWVkKS4NCj4gDQo+IEkgdGhpbmsgdGhhdCBpdCdzIG5vdCBw
cm9ibGVtLg0KPiANCj4gaGZzcGx1c193cml0ZV9iZWdpbigpDQo+ICAgY29udF93cml0ZV9iZWdp
bigpDQo+ICAgICBjb250X2V4cGFuZF96ZXJvKCkNCj4gDQo+IGNvbnRfZXhwYW5kX3plcm8oKSBj
YWxscyBoZnNwbHVzX2dldF9ibG9jaygpIHRvIGFsbG9jYXRlIGJsb2NrcyBiZXR3ZWVuDQo+IGlf
c2l6ZV9yZWFkKGlub2RlKSBhbmQgcG9zLCBpZiBwb3MgPiBpX3NpemVfcmVhZChpbm9kZSkuDQo+
IA0KDQpDdXJyZW50bHksIEhGUy9IRlMrIGV4cGVjdCB0aGF0IGZpbGUgc2hvdWxkIGJlIGV4dGVu
ZGVkIHdpdGhvdXQgaG9sZXMuIEl0IG1lYW5zDQp0aGF0IG5leHQgYWxsb2NhdGluZyBibG9jayBz
aG91bGQgYmUgZXF1YWwgdG8gbnVtYmVyIG9mIGFsbG9jYXRlZCBibG9ja3MgaW4NCmZpbGUuIElm
IHBvcyA+IGlfc2l6ZV9yZWFkKGlub2RlKSwgdGhlbiBpdCBtZWFucyB0aGF0IG5leHQgYWxsb2Nh
dGluZyBibG9jayBpcw0Kbm90IGVxdWFsIHRvIG51bWJlciBvZiBhbGxvY2F0ZWQgYmxvY2tzIGlu
IGZpbGUuDQoNCklmIHlvdSBpbXBseSB0aGF0IHJlcXVlc3RlZCBsZW5ndGggY291bGQgaW5jbHVk
ZSBtdWx0aXBsZSBibG9ja3MgZm9yIGFsbG9jYXRpb24sDQp0aGVuIG5leHQgYWxsb2NhdGluZyBi
bG9jayBzaG91bGQgYmUgZXF1YWwgdG8gbnVtYmVyIG9mIGFsbG9jYXRlZCBibG9ja3Mgb24NCmV2
ZXJ5IHN0ZXAuIEFuZCBpZiB0aGUgbmV4dCBhbGxvY2F0aW5nIGJsb2NrIGlzIGJpZ2dlciB0aGFu
IG51bWJlciBvZiBhbGxvY2F0ZWQNCmJsb2NrcyBpbiBmaWxlLCB0aGVuIGhvbGUgY3JlYXRpb24g
aXMgcmVxdWVzdGVkLg0KDQpTbywgd2hhdCBhcmUgd2UgZGlzY3Vzc2luZyBoZXJlPyA6KQ0KDQo+
ID4gDQo+ID4gPiB3b3VsZG4ndCB0aGUgY29uZGl0aW9uICJwb3MgLSBpX3NpemVfcmVhZChpbm9k
ZSkgPiBmcmVlIHNwYWNlIiBiZSBiZXR0ZXI/DQo+ID4gPiBBbHNvIGluc3RlYWQgb2YgY2hlY2tp
bmcgZXZlcnkgdGltZSBpbiBoZnNwbHVzX3dyaXRlX2JlZ2luKCkgb3INCj4gPiA+IGhmc3BsdXNf
ZmlsZV9leHRlbmQoKSwgaG93IGFib3V0IGltcGxlbWVudGluZyB0aGUgY2hlY2sgaW4gdGhlDQo+
ID4gPiBmaWxlX29wZXJhdGlvbnMtPndyaXRlX2l0ZXIgY2FsbGJhY2sgZnVuY3Rpb24sIGFuZCBy
ZXR1cmluZyBFRkJJRz8NCj4gPiANCj4gPiBXaGljaCBjYWxsYmFjayBkbyB5b3UgbWVhbiBoZXJl
PyBJIGFtIG5vdCBzdXJlIHRoYXQgaXQncyBnb29kIGlkZWEuDQo+ID4gDQo+IA0KPiBIZXJlIGlz
IGEgc2ltcGxlIGNvZGUgc25pcHBldC4NCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVf
b3BlcmF0aW9ucyBoZnNwbHVzX2ZpbGVfb3BlcmF0aW9ucyA9IHsNCj4gLi4uDQo+IC0gICAgICAg
LndyaXRlX2l0ZXIgICAgID0gZ2VuZXJpY19maWxlX3dyaXRlX2l0ZXIsDQo+ICsgICAgICAgLndy
aXRlX2l0ZXIgICAgID0gaGZzcGx1c19maWxlX3dyaXRlX2l0ZXIsDQo+IC4uLg0KPiANCj4gK3Nz
aXplX3QgaGZzcGx1c19maWxlX3dyaXRlX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3Qg
aW92X2l0ZXIgKml0ZXIpDQo+ICt7DQo+IC4uLg0KPiArICAgICAgIC8vIGNoZWNrIGlvY2ItPmtp
X3BvcyBpcyBiZXlvbmQgaV9zaXplDQo+ICsNCj4gKyAgICAgICByZXQgPSBnZW5lcmljX2ZpbGVf
d3JpdGVfaXRlcihpb2NiLCBpdGVyKTsNCj4gDQoNClRoZSBoZnNwbHVzX3dyaXRlX2JlZ2luKCkg
d2lsbCBiZSBjYWxsZWQgYmVmb3JlIGhmc3BsdXNfZmlsZV93cml0ZV9pdGVyKCkgaWYgd2UNCmFy
ZSB0cnlpbmcgdG8gZXh0ZW5kIHRoZSBmaWxlLiBBbmQgaGZzcGx1c19nZXRfYmxvY2soKSBjYWxs
cw0KaGZzcGx1c19maWxlX2V4dGVuZCgpIHRoYXQgd2lsbCBjYWxsIGhmc3BsdXNfYmxvY2tfYWxs
b2NhdGUoKS4gU28sIGV2ZXJ5dGhpbmcNCndpbGwgaGFwcGVuIGJlZm9yZSBoZnNwbHVzX2ZpbGVf
d3JpdGVfaXRlcigpIGNhbGwuIFdoYXQncyB0aGUgcG9pbnQgdG8gaGF2ZSB0aGUNCmNoZWNrIGhl
cmU/DQoNClRoYW5rcywNClNsYXZhLg0KDQo+IA0K

