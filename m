Return-Path: <linux-fsdevel+bounces-79568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MivFpwsqmlaMgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 02:23:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA5221A37F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 02:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8965A3045A9B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 01:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1403009F2;
	Fri,  6 Mar 2026 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UH92vhyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC488336886;
	Fri,  6 Mar 2026 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760213; cv=fail; b=SDthqzdRKC6DrE8X0rzqkKAWij8rozmrMFJzzvq4EuaST1RQ8wVC+xPClG5zry6eBhO5fTGNa/kp4omIqm7QTTpvpuhgOynWPor+jjkUxdtuwNCtu6jadoxTEI7f7WjUJ1aMFdIoffwEbXEcIQ6RoJYvw8tRZ/BNsxpTKiftPdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760213; c=relaxed/simple;
	bh=RKk+5MIj06RJpitp1HWXnJLqwiRcRHXGCbefWTN2Zt0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=DSaDHb9XER6J2F0OeoUQxStqGLPynxtTUa6Oya6Ay4l8TOq2xYQgCfeEEmrT1/h4KurVBGnQ4VNE1sSKbLSj0gR90H+3vqbBApkOnq4XRnpYdhEURCWSyCqiRzoMD8H/r6HTaNBg+kLkJ+TPMLbuK10fEC61VqRpyMCzCLLiXY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UH92vhyH; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625GS7QL2195050;
	Fri, 6 Mar 2026 01:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=RKk+5MIj06RJpitp1HWXnJLqwiRcRHXGCbefWTN2Zt0=; b=UH92vhyH
	yPvBboB9RsVPUcngwsW1Lu0bXTvrtvGKME1orwDyMgs6X6bG4+shSHDIHiEr6082
	l0SywA/bxnHqys1AhjR5CeomCfsSv/EVn4pgTQucxfq/PMmKrWdNF26jS63iAuB4
	c2LeTIYZJPLUCK21Rwi7g3AOPmCW4qU9/RSsXRgCeAgKsbLxmy1CN5Ioku476a8p
	VZN17H3OcdyVXTK46ucSbw/jzgIv0YmnMlV7MV0i6zWsAFEaUp2TL5Mib4NWY8lz
	bFqnLvysfdoitkIf7eiCdhASeOln7YV7F/RISO/j/BNh0plYdHRSpHfBZCFfP9/r
	oKSz8EgTJBIc2g==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk45vnp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 01:23:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOe8p9vqiQyQhlKKGksXG1BHwDsYz2E3ogH3OZvqEUcsFmO9+rwTU5atCv746fDF3a3/IhEuv9G21rQAwJmcJukxC2d7xuryCt+USdc83ndvGg1LXskn6/wm+GnnAVNwl6JWtFE274CkoZp7xr0CTeu/XRCMVdXnwEALnO4unR3vEKHqXZRvXp+/bzVij04qvPnNGaRYXvvCf8kQ8rklROPdJuKsvdA0Ccofi840L8swSab5dnIwdZkj74ipNETpy8Pyem7i5fioyG9GNPbwp1XGKkJ8Iscd+EH9c+qkKKZ90+0DsJ3gWVK92eJbHloBBnBqP1FGJsV139b6OkbJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKk+5MIj06RJpitp1HWXnJLqwiRcRHXGCbefWTN2Zt0=;
 b=WwEKAur/MqpIKXNXGYZieWpw9DyR4J8ST6njVkwHo6/LPoeceYZppIJd2to5WlxPaQ4zbZr4kkw6GPbDtuA3zC0pBQ9vzGbzOpHySCixlWWvzS9JJU3XAN6pwiq9QUiLgMuCjFS4AZH1oMUyzMzkv9ZKeO1tq4jazy+sfhNY8m9fcCt87cibaVenUfvikrm4tpuEzUz78Yu+WIu4hwxWpVyN6g1ARtwFFib4XqJalJBksZ9t81eqYTxdjLAdi9KfFZn0aSF55CqB5QqBGAOe4wNDyttxn2XjYYmuDF4dkSH+Q/aqPCnA5HaEdAOoxRfWzxh8jlwLLMIaxmYPVY0sHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM3PPF9EEBA5A07.namprd15.prod.outlook.com (2603:10b6:f:fc00::435) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 01:23:16 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 01:23:16 +0000
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
 AQHcq9hDf3IahKMroEqX1R8/F3zmX7WezIeAgABKD4CAAATZAIAAEm4AgAFn/ACAABr6gIAABxiA
Date: Fri, 6 Mar 2026 01:23:16 +0000
Message-ID: <f174f7f928c9ee29f1c138d9ca1b23abfbc77d0c.camel@ibm.com>
References: <20260303082807.750679-1-hyc.lee@gmail.com>
	 <aaguv09zaPCgdzWO@infradead.org>
	 <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
	 <aajObSSRGVXG3sI_@hyunchul-PC02>
	 <532c5cdf12ced8eee5e5a93efe592937b63b889d.camel@ibm.com>
	 <CANFS6bZm3G9HA3X5Bi2_KGZDNGuguQzG44-cMcQHto2+qe_05g@mail.gmail.com>
	 <e979abaf61fa6d7fab444eac293fcbc2993c78ee.camel@ibm.com>
	 <aaomj9LgbfSem-aF@hyunchul-PC02>
In-Reply-To: <aaomj9LgbfSem-aF@hyunchul-PC02>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM3PPF9EEBA5A07:EE_
x-ms-office365-filtering-correlation-id: 41833962-9259-4ba7-c7ee-08de7b1ef15d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 CedFgvknO5z2pMWqNQLpedIoKHLpw+sgz7AZCH+GqlGKGNgby8PSFmylxrx+HfrQkWHg69vOSeLtvC8Kib81DAUl0WejlipDAnEMCGfXM0ocTXXbdHVYRIJcAvDZcMrk2QFKpVdBwRYpA0mf3loCwXjVwXppaaHiFX/FoqBvykG0/8knuvNzflUrs2A+v7vAocI3wQoOMZIZpXwgDAMU5ZO+ZhCW3l2SuwcyW5w7sEMWVmWElGR+rWgX19pGCdgYFUIP2Ps+WXHr24N2WgTKVde41aIiV73ZXFhrdnDxOHWMt4lXJ4G6rywKlnGOd7VpTNyswm6wkCh9gAzW+KZ1LsJxk0k3sH4TzhYvrNWZ+wSMeIvcHNv26mtId7lUisBC3R6JxDkr+QiSo9BqE9top2wMEYCREcsuvzFBSLezhtH4q31Wq77ZH2zeXZePDkMEkmFdzi5ZSmw/vMGXKRWouARL5FQKRG+VGy9E2rJS7eJFgs+JLU9f9uFUDGlDSrkPYjVUUtzQTVUOP3td7VP4f+q8h9KKzjCiWzCrYvfJXTomi3KoKTMf/OSXlj2z0GrWuMkMasYCz5eAW3zgWab+zffC2Atq+lrOsksCLJRnPXzKjvKxH6Ba7ze6X12wRDpt4CidNsgG6iCkRDCRd2/DY5cx1vbcFBy2FdLcX/ULer67LzSsXVSdi2Fw7tYKbBK+NxHGc8k9JvKFKBZcW3fPqT63a+jSdnxRG5qauMWRPhKt+8Rd4LyZ0epm7IzKKhoV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFFmVkFuZVVZWnJIeUYrWHVUd0UvOVpwV3o2Sm1TejVxVHNYdSt1dTQ3eWlj?=
 =?utf-8?B?eFlQV2JJaVlUQnpjT2tqeEpZMmdac0p2cEY1aDMvUzc1djdVb2EyRm5EQU1t?=
 =?utf-8?B?SFhkRjgzNnVsZjF4bmQwQXprZEVSS3lTazQ3RDhPMnFkcEY4dkRjcWVoUU5Y?=
 =?utf-8?B?dW55VTQrTnBNcndBdEVsTzJpSkFncjFGLzRUZGZ0T2EyT2Z0RTRNZlViRVZl?=
 =?utf-8?B?RCtiNG1pcGhkVk9HeGpZU0RRQWkvUmtoZ3g1SDRoclNOMitDcnlPdmgzQXF5?=
 =?utf-8?B?OW45V0lDOU5zenMrVkVxb3NmMTU4RU9ucTBtNlFlUzhUcjFCbVk3UjZtbXgw?=
 =?utf-8?B?blpHTThQR1dwbHIrcEl0THdzWUM3V3pyQmxySW9URGhPYm1leHZBNWY0ZCtR?=
 =?utf-8?B?eDU2SFRmaHhSQmJsVnYvMzNDcldhaDRrbGVuMjBLb1JGWmhucEhrOEpRcFR1?=
 =?utf-8?B?MHYxV3JDQ3pqYlhiUXByTkpJRkoraHJJUmdva3E3Y3hidnBwKzJuRkJlVWZN?=
 =?utf-8?B?ZFJnR09GaEc3RTRUK2o0ZXRpUVFML1ZRNmpEMXZZMTJQSTVJVU55eDJYOUpR?=
 =?utf-8?B?MERxZFNCeEdUemRNL2NETXZYTUwrUmN4WlcwQVJRLzREYVRrOTV2TFNnaVhn?=
 =?utf-8?B?alJsRVFxMnhwNzhoTCs0enFqOEY1RkJUeHNZMGZMQmN3R0kxb3ZVdW5Db0JG?=
 =?utf-8?B?UXQyb0huOWZneUEyVnJzTE1qUXB4NEt1cVBoUWxpanA0d2VpTUp3YUI5ZFAz?=
 =?utf-8?B?Y3Uva2ZQR2kvQUJYdnF6aUJJckNRMCtlYWk4Um8vdCt5U0xjUUZNTXlyL2Ri?=
 =?utf-8?B?czc2cUc5ZGdjQWlNR3FnMVdhTWN1cTA3by93MWUzMnliT0ZVK3c0Z0xibENG?=
 =?utf-8?B?UEc3ZWpWTGhiYVJWdmNOWDd3RnkzZmlGVkVveTREcDhvbENOSHFydTVreXBJ?=
 =?utf-8?B?TC9ETjhYZ2FXM3RiMWZoTDkwQnRFYTRsS1BEeXA2WWtickRkM2lZQWxnRS84?=
 =?utf-8?B?emlvWitDckk3L1hacVBaY0ptYzRnOWNoQlBaZzNWZVdRU25sbld5SVo1R1Qr?=
 =?utf-8?B?UGFFdG9uRG9oRCsrZ3Rsd0RweDQ3NkVpSWdkTjlZUWFPdXJ2OXdGMk5OVW9W?=
 =?utf-8?B?ZDVSQVJvSlZHOFpTZ1RPV00xNnpMaXpjRVYyQW1aSjREODhUWUZPdDJWYXpI?=
 =?utf-8?B?WnU2dDcrSWZpcWgzMzBWOWd2ZVJWdXo0bW9DTm4wMjdYVWl6WDZvOHFVU09S?=
 =?utf-8?B?MXNwdm96VTc0Sy81WUs2S0VvN1MyakRVOUZJT1FldUcrUnZ3U0tncDY0R3Jw?=
 =?utf-8?B?OGRubk9NL085U2ZjN1crUFdBTEtVSVpPMVI4TUl1QTRhT3BwYU05WU1ZTWJL?=
 =?utf-8?B?bnpEZ2c5b0ZXeWxDUTdoWFYxNzNXS09EM2ovbFBWQWNpS044TVpTdXlhdFVW?=
 =?utf-8?B?TUtmUHllVUZYbHNGVFUrSXFMTUdGNE5CN080blJLUDd5UU8rUThBWmdWeisw?=
 =?utf-8?B?UFQ1S29MbEk2ckVwTHVpSm5tYUpaSzl3eFpJODE3KzczSFRaTmVBNThzWkRS?=
 =?utf-8?B?SXh5djhUbHlWUUl5MjVXT3dQc21NQkQ5Z3hBTnRtVFRIMzJGV3puRmxhV3d2?=
 =?utf-8?B?MEVnTm9xaHBKYnRrbEFlN3Z4dmttN0w4dG9zaTFueXk1bzR2WjlvZ3lkZHpG?=
 =?utf-8?B?WVFUdmN4LzI1QTJxZkpVVUlHaGxaRDBydjcrWEdCMmlYMTR0ejZ0QVlpWlRF?=
 =?utf-8?B?WFA2TXZualdmYUM2c2ttY01wUklhRnBJOVdyQ2duWnhKQk5nV0FqMXo1NW9W?=
 =?utf-8?B?cGQ4UVZmS0hJNjVvaFRFTTZKMU54MEd1NkRWaDR4c1NraUg1OS9EWVRYbDh2?=
 =?utf-8?B?RWRFNkFydHQ0YVdFMTdZeElFSXVhT2xTeDc4VVNtdmxxMGdKV2JVeEpFYlJQ?=
 =?utf-8?B?VnU4dHRKUUJCOWFBSWRQSkRVZ3B4NjM4ejhTalZlV1FUWmwxMXdkOGdoV0tN?=
 =?utf-8?B?bTROdnp6d3VmdnVPQkRWMWhUbDhVOTU2ZWgxOFBiQ1NLZVphUjFjTGtnZ1N5?=
 =?utf-8?B?K01zQ3dzMzlsTWJNbVhYRGhGbU02Vmx1SWQzdUFaNjVHeDdqYXZFdWdQYkE4?=
 =?utf-8?B?OEFGeWVhM2RlVUhlVGdLaHBTZlhhSWJvMVl5bytHcTM5NncyNVpDNjlDdFZI?=
 =?utf-8?B?a09acFlBRjg1WjRrQit3alJRUE1uT1REME4rdXM3ZzZlRnFFeGFhcjhnOSs2?=
 =?utf-8?B?RStWcmZTaStOL0JBMTBEYWFBbWhSQkVlWTU5UmNHeExVWmhGbFlIMGt0YW1h?=
 =?utf-8?B?S1ZWeklucUNFOXFJYURPN2xYNTV3anNFL21QbGNyTjh0Wlk3UzdQZ1ZCNVg4?=
 =?utf-8?Q?+3ChCB2uOFpJ+wxLqMOv13ShUENY+JxCnj6Ag?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAA115B0190A61449D9E14EB48F8EB3D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Usrv1ErVrfwAIBKXueKlmVbqpSydNUg5IUzB0FnsKqHA0tAtiMXvuUhzHf5Lfd0h98tIcDkMblkMc6TZGKsONPKFBgyXR/sTnZvtkghcgSPoJIEcl6ahiCFtdvJ+Nz65zlq/TObqeI190tylNu1coeyuJTHYPrFs9r4Vis4u6eVlGegaDlYYLC7xoN0WXbkjqBhZ3QazeutaPrR6VyMgBa5IbDA89YDW0ukurLGdmgITAAcbh0LKZqxGLLmZLeZKCUpvfFXyL/Jf/PvCuixiM5QeArsEk3jWCjGER1KVZsnpgwNJK9nt4hyt7JpFLdRITzFqrru+imvqL6Haeoq+Qg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41833962-9259-4ba7-c7ee-08de7b1ef15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 01:23:16.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrP+SRXe55++jUTYdQdgsdf9kWk2xgDuS0U++hpZZlWJid34+rLuLPnEGv5fZA0H78sEfKxb8iI1vNDVkHsH8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9EEBA5A07
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Mm2DlWnxWB59Ttb2zWdRte6yrOTJtNfI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAwOCBTYWx0ZWRfX5IT+DBMK1Ef6
 znnsrd3SjNfEHF95oHLxrNHOaGLvAFWQSO0kTGoATrA/ah43d6ioDj5wCBqX+7GCnkNgfpt55pN
 zbkynahMO/Xu4T7MYw07+hgXvBziKk0em58LvAeKd47hS4eaZ2rqKu8uetgdN5/M6kt5FY0RqA2
 kGbfVliJmhPoZQeuXZ3tlBPADX0J8vXDZTTJpNho1t0aOCuMKWSGYWnXkZ1n07QBOZFKlJGNmnh
 g6Ozr0+6AdGy5zTjsXJGf5ikNlWEhnCqpiLxNnWNTrSNaKtA8K10ql2BtemADW1YB8dP3qZSVDb
 EmX9xxdTaRZdczlK5OkWcbAbbM+NWoQowkyoVp/tqu70WjIJIYxelDwvyLJI8EG57SK03MgnKpI
 5w5RrNgL2nURB9HZM5IZaByVmUzW6ZjmbCvo/eAIkn3nMk0fGrXE/yfxcv4NK6GxkjbDr1q1NBc
 wTdGR6B/wAqdxdTB87A==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69aa2c87 cx=c_pps
 a=H/ESeL7FTwDXaNlIHo07Cw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=P-IC7800AAAA:8 a=bFQc4QDILd1AectYSQgA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: PqTLvrj6sjwCTlaKhCZg31kufpk-Mu54
Subject: RE: [PATCH] hfsplus: limit sb_maxbytes to partition size
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060008
X-Rspamd-Queue-Id: AAA5221A37F
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
	TAGGED_FROM(0.00)[bounces-79568-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:url];
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

T24gRnJpLCAyMDI2LTAzLTA2IGF0IDA5OjU3ICswOTAwLCBIeXVuY2h1bCBMZWUgd3JvdGU6DQo+
IE9uIFRodSwgTWFyIDA1LCAyMDI2IGF0IDExOjIxOjE5UE0gKzAwMDAsIFZpYWNoZXNsYXYgRHVi
ZXlrbyB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjYtMDMtMDUgYXQgMTA6NTIgKzA5MDAsIEh5dW5j
aHVsIExlZSB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTb3JyeSBpdCdzIGdlbmVyaWMv
Mjg1LCBub3QgZ2VuZXJpYy8yNjguDQo+ID4gPiA+ID4gaW4gZ2VuZXJpYy8yODUsIHRoZXJlIGlz
IGEgdGVzdCB0aGF0IGNyZWF0ZXMgYSBob2xlIGV4Y2VlZGluZyB0aGUgYmxvY2sNCj4gPiA+ID4g
PiBzaXplIGFuZCBhcHBlbmRzIHNtYWxsIGRhdGEgdG8gdGhlIGZpbGUuIGhmc3BsdXMgZmFpbHMg
YmVjYXVzZSBpdCBmaWxscw0KPiA+ID4gPiA+IHRoZSBibG9jayBkZXZpY2UgYW5kIHJldHVybnMg
RU5PU1BDLiBIb3dldmVyIGlmIGl0IHJldHVybnMgRUZCSUcNCj4gPiA+ID4gPiBpbnN0ZWFkLCB0
aGUgdGVzdCBpcyBza2lwcGVkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEZvciB3cml0ZXMgbGlr
ZSB4ZnNfaW8gLWMgInB3cml0ZSA4dCA1MTIiLCBzaG91bGQgZm9wcy0+d3JpdGVfaXRlcg0KPiA+
ID4gPiA+IHJldHVybnMgRU5PU1BDLCBvciB3b3VsZCBpdCBiZSBiZXR0ZXIgdG8gcmV0dXJuIEVG
QklHPw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBDdXJyZW50IGhmc3BsdXNfZmls
ZV9leHRlbmQoKSBpbXBsZW1lbnRhdGlvbiBkb2Vzbid0IHN1cHBvcnQgaG9sZXMuIEkgYXNzdW1l
IHlvdQ0KPiA+ID4gPiBtZWFuIHRoaXMgY29kZSBbMV06DQo+ID4gPiA+IA0KPiA+ID4gPiAgICAg
ICAgIGxlbiA9IGhpcC0+Y2x1bXBfYmxvY2tzOw0KPiA+ID4gPiAgICAgICAgIHN0YXJ0ID0gaGZz
cGx1c19ibG9ja19hbGxvY2F0ZShzYiwgc2JpLT50b3RhbF9ibG9ja3MsIGdvYWwsICZsZW4pOw0K
PiA+ID4gPiAgICAgICAgIGlmIChzdGFydCA+PSBzYmktPnRvdGFsX2Jsb2Nrcykgew0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgc3RhcnQgPSBoZnNwbHVzX2Jsb2NrX2FsbG9jYXRlKHNiLCBnb2Fs
LCAwLCAmbGVuKTsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGlmIChzdGFydCA+PSBnb2FsKSB7
DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJlcyA9IC1FTk9TUEM7DQo+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ID4gPiAgICAgICAgICAgICAg
ICAgfQ0KPiA+ID4gPiAgICAgICAgIH0NCj4gPiA+ID4gDQo+ID4gPiA+IEFtIEkgY29ycmVjdD8N
Cj4gPiA+ID4gDQo+ID4gPiBZZXMsDQo+ID4gPiANCj4gPiA+IGhmc3BsdXNfd3JpdGVfYmVnaW4o
KQ0KPiA+ID4gICBjb250X3dyaXRlX2JlZ2luKCkNCj4gPiA+ICAgICBjb250X2V4cGFuZF96ZXJv
KCkNCj4gPiA+IA0KPiA+ID4gMSkgeGZzX2lvIC1jICJwd3JpdGUgOHQgNTEyIg0KPiA+ID4gMikg
aGZzcGx1c19iZWdpbl93cml0ZSgpIGlzIGNhbGxlZCB3aXRoIG9mZnNldCAyXjQzIGFuZCBsZW5n
dGggNTEyDQo+ID4gPiAzKSBjb250X2V4cGFuZF96ZXJvKCkgYWxsb2NhdGVzIGFuZCB6ZXJvZXMg
b3V0IG9uZSBibG9jayByZXBlYXRlZGx5DQo+ID4gPiBmb3IgdGhlIHJhbmdlDQo+ID4gPiAwIHRv
IDJeNDMgLSAxLiBUbyBhY2hpZXZlIHRoaXMsIGhmc3BsdXNfd3JpdGVfYmVnaW4oKSBpcyBjYWxs
ZWQgcmVwZWF0ZWRseS4NCj4gPiA+IDQpIGhmc3BsdXNfd3JpdGVfYmVnaW4oKSBhbGxvY2F0ZXMg
b25lIGJsb2NrIHRocm91Z2ggaGZzcGx1c19nZXRfYmxvY2soKSA9Pg0KPiA+ID4gaGZzcGx1c19m
aWxlX2V4dGVuZCgpDQo+ID4gDQo+ID4gSSB0aGluayB3ZSBjYW4gY29uc2lkZXIgdGhlc2UgZGly
ZWN0aW9uczoNCj4gPiANCj4gPiAoMSkgQ3VycmVudGx5LCBIRlMrIGNvZGUgZG9lc24ndCBzdXBw
b3J0IGhvbGVzLiBTbywgaXQgbWVhbnMgdGhhdA0KPiA+IGhmc3BsdXNfd3JpdGVfYmVnaW4oKSBj
YW4gY2hlY2sgcG9zIHZhcmlhYmxlIGFuZCBpX3NpemVfcmVhZChpbm9kZSkuIElmIHBvcyBpcw0K
PiA+IGJpZ2dlciB0aGFuIGlfc2l6ZV9yZWFkKGlub2RlKSwgdGhlbiBoZnNwbHVzX2ZpbGVfZXh0
ZW5kKCkgd2lsbCByZWplY3Qgc3VjaA0KPiA+IHJlcXVlc3QuIFNvLCB3ZSBjYW4gcmV0dXJuIGVy
cm9yIGNvZGUgKHByb2JhYmx5LCAtRUZCSUcpIGZvciB0aGlzIGNhc2Ugd2l0aG91dA0KPiA+IGNh
bGxpbmcgaGZzcGx1c19maWxlX2V4dGVuZCgpLiBCdXQsIGZyb20gYW5vdGhlciBwb2ludCBvZiB2
aWV3LCBtYXliZSwNCj4gPiBoZnNwbHVzX2ZpbGVfZXh0ZW5kKCkgY291bGQgYmUgb25lIHBsYWNl
IGZvciB0aGlzIGNoZWNrLiBEb2VzIGl0IG1ha2Ugc2Vuc2U/DQo+ID4gDQo+ID4gKDIpIEkgdGhp
bmsgdGhhdCBoZnNwbHVzX2ZpbGVfZXh0ZW5kKCkgY291bGQgdHJlYXQgaG9sZSBvciBhYnNlbmNl
IG9mIGZyZWUNCj4gPiBibG9ja3MgbGlrZSAtRU5PU1BDLiBQcm9iYWJseSwgd2UgY2FuIGNoYW5n
ZSB0aGUgZXJyb3IgY29kZSBmcm9tIC1FTk9TUEMgdG8gLQ0KPiA+IEVGQklHIGluIGhmc3BsdXNf
d3JpdGVfYmVnaW4oKS4gV2hhdCBkbyB5b3UgdGhpbms/DQo+ID4gDQo+IEV2ZW4gaWYgaG9sZXMg
YXJlIG5vdCBzdXBwb3J0ZWQsIHNob3VsZG4ndCB0aGUgZm9sbG93aW5nIHdyaXRlcyBiZQ0KPiBz
dXBwb3J0ZWQ/DQo+IA0KPiB4ZnNfaW8gLWYgLWMgInB3cml0ZSA0ayA1MTIiIDxmaWxlLXBhdGg+
DQo+IA0KPiBJZiBzbywgc2luY2Ugd2UgbmVlZCB0byBzdXBwb3J0IGNhc2VzIHdoZXJlIHBvcyA+
IGlfc2l6ZV9yZWFkKGlub2RlKSwNCg0KVGhlIHBvcyA+IGlfc2l6ZV9yZWFkKGlub2RlKSBtZWFu
cyB0aGF0IHlvdSBjcmVhdGUgdGhlIGhvbGUuIEJlY2F1c2UsDQpvcHBvc2l0ZWx5LCB3aGVuIEhG
UysgbG9naWMgdHJpZXMgdG8gYWxsb2NhdGUgbmV3IGJsb2NrLCB0aGVuIGl0IGV4cGVjdHMgdG8g
aGF2ZQ0KcG9zID09IGlfc2l6ZV9yZWFkKGlub2RlKS4gQW5kIHdlIG5lZWQgdG8gdGFrZSBpbnRv
IGFjY291bnQgdGhpcyBjb2RlIFsxXToNCg0KCWlmIChpYmxvY2sgPj0gaGlwLT5mc19ibG9ja3Mp
IHsNCgkJaWYgKCFjcmVhdGUpDQoJCQlyZXR1cm4gMDsNCgkJaWYgKGlibG9jayA+IGhpcC0+ZnNf
YmxvY2tzKSA8LS0gVGhpcyBpcyB0aGUgcmVqZWN0aW9uIG9mIGhvbGUNCgkJCXJldHVybiAtRUlP
Ow0KCQlpZiAoYWJsb2NrID49IGhpcC0+YWxsb2NfYmxvY2tzKSB7DQoJCQlyZXMgPSBoZnNwbHVz
X2ZpbGVfZXh0ZW5kKGlub2RlLCBmYWxzZSk7DQoJCQlpZiAocmVzKQ0KCQkJCXJldHVybiByZXM7
DQoJCX0NCgl9DQoNClRoZSBnZW5lcmljX3dyaXRlX2VuZCgpIGNoYW5nZXMgdGhlIGlub2RlIHNp
emU6IGlfc2l6ZV93cml0ZShpbm9kZSwgcG9zICsNCmNvcGllZCkuDQoNCj4gd291bGRuJ3QgdGhl
IGNvbmRpdGlvbiAicG9zIC0gaV9zaXplX3JlYWQoaW5vZGUpID4gZnJlZSBzcGFjZSIgYmUgYmV0
dGVyPw0KPiBBbHNvIGluc3RlYWQgb2YgY2hlY2tpbmcgZXZlcnkgdGltZSBpbiBoZnNwbHVzX3dy
aXRlX2JlZ2luKCkgb3INCj4gaGZzcGx1c19maWxlX2V4dGVuZCgpLCBob3cgYWJvdXQgaW1wbGVt
ZW50aW5nIHRoZSBjaGVjayBpbiB0aGUNCj4gZmlsZV9vcGVyYXRpb25zLT53cml0ZV9pdGVyIGNh
bGxiYWNrIGZ1bmN0aW9uLCBhbmQgcmV0dXJpbmcgRUZCSUc/DQoNCldoaWNoIGNhbGxiYWNrIGRv
IHlvdSBtZWFuIGhlcmU/IEkgYW0gbm90IHN1cmUgdGhhdCBpdCdzIGdvb2QgaWRlYS4NCg0KVGhh
bmtzLA0KU2xhdmEuDQoNCj4gDQo+ID4gPiANCj4gPiA+IA0KDQpbMV0gaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjYuMTkvc291cmNlL2ZzL2hmc3BsdXMvZXh0ZW50cy5jI0wyMzkN
Cg==

