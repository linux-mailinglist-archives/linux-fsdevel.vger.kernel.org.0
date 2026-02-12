Return-Path: <linux-fsdevel+bounces-77058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDsYEmdLjmkBBgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 22:51:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A292B13161D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 22:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8566F3062F9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 21:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDA934AAF9;
	Thu, 12 Feb 2026 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="smGszIkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A32E8B82
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770933084; cv=fail; b=ttC7frKkL+8EkdNbsMZiVzNkv/Ivr4zv/qKWPFr2NPY3nCgj+dDNqnRU8W1hSD+dJRV+9ztsfBMV6CSD7n7G5uNoPn0eg/zHQSAU5lPOkogIgT1wR9ro1Wr/GY2V3PF/xmWa55m8bvE76zXMH8YMJ4LbSNitbYlLurzM0XqDAGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770933084; c=relaxed/simple;
	bh=lfJY/hGxFJ+R7oUwZy64Ui5cXSJdw9MwBrOz1U6C/Sw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=X0IebeypenPMAZNE3uPHtTdPchjF9KRRCnk1xIRQgeWn3DplL1bEnT7okm4vRbHUCX0L73V/PhwpRPzRwWVBgR2v+7hfbN+mS9W31cfy/oy8aqy/wNO3UvGE1YqDkABSninEfLH+4NG6F9QP/q00ODhG7f/XMoxFiXI2DI/tprQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=smGszIkQ; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CIae7t4037824;
	Thu, 12 Feb 2026 21:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=lfJY/hGxFJ+R7oUwZy64Ui5cXSJdw9MwBrOz1U6C/Sw=; b=smGszIkQ
	9zX2lYrTfYYUla/VUJrUy1tW48d9Sue1iHHiT/gMyo61alysOmZcj+RBWWLqLKvw
	Rvb6TpAUuCX8hhOIVKUwNLqBQ2Wu1fsZyEne1B0rC20mjvRaExBuW/reWYP6TIM7
	2H3PImh/55oUwFCQ3n5f1sgIaOjecCFyMJuvDT5QYS21NTFcRA8S/L0ACN4rXUTU
	gTtcCh1SklfWe9EutaVCntbKmf71HXNocVHx7BwTg4A+YsJxjolSS+ZYmaAmFEa1
	SFs4s8FPjU6lqtKb9Rz7++16nJUulXfve0YIcZe7Wcu7rhgxhWX22M26Hrbswkur
	UEwyCgRf59jWmA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696urbcc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 21:51:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyGWOOjQg42ZxgVJ9XUnD9AIQg968Uih6xO0OlCvRzSWQlT7DMCI/MQp7K4L/czSNAn/2itquxCKweTyVRkcj+auicPebZjeeFwt16y1hYoUmlNasxSqv0VurzbcYEAcZyiuhSruSATIU5P+LDd7QVCPE7pROwcljVUb5UcmFNErkIASssDKaH0LhKeS9RnwPc1DWt2ZncdSoRWt3YGgl7mENnzHRnwHJtneFIKjxRladJ9BdhkkfjoSkX3qwR3Sh2DE2q1Y9mRxJEFco+aB2zpmZ2itJtalUZgzn3hKw7s7qs3vxrUcAPeYWcgj7vuA74CaO3xnXWe7cHA6DqpWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfJY/hGxFJ+R7oUwZy64Ui5cXSJdw9MwBrOz1U6C/Sw=;
 b=lsp8Gr8JVYko/SnNWoL5prt0qavO9t6xaupAjPKhyViaQ5nfNh0f5apvSLV4/KVC2GFFElzreXBdXEdiwq/Z/vgXlODEYEDVul+jWJes11kEpYXD1KhGOWW9LWsZRpP7Y7JW46KeS0rCgHMV9uF4Vv9ysNKLHmMP3CEK2ab2Itq4g5+HrnYJG+s8CURvpymt4qSNUYq7VlgWpJ9DziB2+RbBHglQ3PAxPtjKvWbLwfonuEHLTIJoz9iG+gM/jbia2BaYkl4Mwl3swi0BzrftjhH1OsD2OItwsmz1oAeXo+ku8lrHgnG3PT4+uigEmjK6o98tK2w0l4QM4YKelnnaqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4577.namprd15.prod.outlook.com (2603:10b6:806:199::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 21:51:14 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9587.017; Thu, 12 Feb 2026
 21:51:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs: evaluate the upper 32bits for
 detecting overflow
Thread-Index: AQHcnCNRSqmOvktJcEm/ltcoFQArFLV/mx8A
Date: Thu, 12 Feb 2026 21:51:13 +0000
Message-ID: <62e01a3505bca9d1e8779f85e0223ec02c24a6de.camel@ibm.com>
References: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
	 <68811931931db09c0ea84f1be8e1bdc0fd453776.camel@ibm.com>
	 <4a026754-1c58-40a6-96f9-ecaafa67a2ae@I-love.SAKURA.ne.jp>
In-Reply-To: <4a026754-1c58-40a6-96f9-ecaafa67a2ae@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4577:EE_
x-ms-office365-filtering-correlation-id: cda10c40-e9a0-4a99-76a2-08de6a80d7a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWhiMmJvNmlKZTJSWFg1a0dWMDZ1aXFqWGFiV1lvbnlySnVtWklQUWM4NTQ5?=
 =?utf-8?B?SHlBSE94SU5Ed0hubkxScENZb0tER3VtMi90Q1k1YWp4VVhrcVR4ZTlQRy96?=
 =?utf-8?B?dm9UNEpBNDVTK0xxZ2traGxzcWtBOTlzZWM0NFVmSnlWZEx1WERZUEVJRzY0?=
 =?utf-8?B?RXBSNDVyUWx2dy83Q05zNTBCVUFhRVhraXRBZ05vNjdBdUQ5UlFJb1kxN0JS?=
 =?utf-8?B?bDB0WWxOM2JabkN6OFkydlFOWVJ4THp1aFNtZ3VZUk5saGFuYkY3OTRKMFR1?=
 =?utf-8?B?YTdzdkh1RDg0dE5ucUJVWnNINXFiQ0JWU00xV29aTUFnd2k5eTY5Umhudm9J?=
 =?utf-8?B?SW1vckI3UDdLTE5LbC9YSUw5SnkzSmNYTEl3MkkyQWVrdnV6dHdRRm5CL2hQ?=
 =?utf-8?B?TWdsNWgvb2xzTlI1d08vZlgrejEvMGp6K2h6UEROcSt1bTRuSVRsS1ZndjJ2?=
 =?utf-8?B?bDkyUVpnT2w1VStnK0JFeXRsWmtCZW81WkdlMGN0eEFLdTVBWGZOU2xmQUxY?=
 =?utf-8?B?REp4ZXB5TmNBeUJkNUpUQ2V4Q0hWL1l3ZTJQWVdmVWJ2SWlZV1loa2lOSDdG?=
 =?utf-8?B?ME9OV216UTBPZTlMTENKZzF3Q0ZUSmFuWWZrRm1kK2t6Q0ExZ3o0ZFVDL1lC?=
 =?utf-8?B?WGlJVjMvbTJTZm9ud0FXZ2EzYzdjQzBXZ3kwTGVXYjBGY3VrSnVOcmh5Ri93?=
 =?utf-8?B?WXJVZ2FpMHV3THJUcjV3OHRXVjRzSjFKdkdIRUhTeGo0QmlXdWNUcVRwV1lr?=
 =?utf-8?B?NHZqRDBRd0VPaXlVNmxkSUZLaW5GaXRzN2xrUEQ1YjF2RzF1enlQQlRnWjZm?=
 =?utf-8?B?TXI0bGpjN3Nsd21Lc3lXQmN0WGQ4RjVTRFdLdzMvMDBPKy96cXdEb21LTUx6?=
 =?utf-8?B?Mnl5bVB0RDZhN1NwNFd5cmNheS9ZSmZKcHZXK0VINStyT2JsWWdvRnl5Z0NB?=
 =?utf-8?B?aVJhWERBMHg4Y0JjeXc2Sk5TaXlBaFFwaXAxd2M0eGFXRTB2MnpqQkE5cldT?=
 =?utf-8?B?UXdValUwdmovb1BOQ25odXYxNGpqL0c2dVNIU1FvSkpJdzdQZFdOeFRNMHZM?=
 =?utf-8?B?NWR0S2xsLzZUbHlhejZnZWVRLzRCUXA1ODcxbytLR2phSDc5eDRGN1lzRStV?=
 =?utf-8?B?MHBET0dVTVZ1bjV3ZjRuY3IrNmNDcHMyRlQxY29lVVdDL0wvV0hEek1KOE1z?=
 =?utf-8?B?cW1lS3RTTzNGV09lTnd0TC9JMVl3TnpBTlE1c3JjVURhTmo3WkdacVNUQU1w?=
 =?utf-8?B?ME9ZVkh6Wm42ZWRycUwzYlR2Y0hUU0dFcmIzZ0F4bFJlVXBQNWJucGtqOG53?=
 =?utf-8?B?WlA1T2tmeFlibEtlTTVKSEZOVXhSWEZsQzFDVUxsc2JrZXVpTnBUWWp2R3JU?=
 =?utf-8?B?UzJXYUtueEtBVXlEVWRkNk4vckFya1liOGpyMHdQcThxV0RkbTVsSE9FRHIv?=
 =?utf-8?B?eWUxMVIxYytteFBWNUpNK1FHN3FhOGs2cUdqdmdqMEtPc3BpOGhhZTlzbmZ6?=
 =?utf-8?B?cXdCSDZLTFNySXB5UENGT2NxRW0vNWdBc3d4K0lKcVlTQmtqd0RDOHZONzVT?=
 =?utf-8?B?YWIwNjEybEJwVmwyT293dUxTcEI4RUplTWdBb2M2akE1VlNPaEhPcFZKSmNJ?=
 =?utf-8?B?di9nb25VY2ppZzlqRWF0Mmg0UmNNK2JzZ2NJV0sxZVJhL1ZFT1UyZEl6Vk1Q?=
 =?utf-8?B?bU5SVDNpZ0dzV0xaYWRpQ2hyeUlBN091Y0x1MmFRalNGTE94dlZRVVpTMmcz?=
 =?utf-8?B?MVZtNHM2aHMyUXlmV016VGM5ZzNkNHNRanlzbVFnNTQrQ1k4NHR5VzgvbkdT?=
 =?utf-8?B?aCsrQ0ttZU9KM2RzVzAyNFlkblNialBhbWVnU2JsVUlyc2t1dmFmMTJNYTJv?=
 =?utf-8?B?TjB3aVZ2dzI2WHl4RllOa3ZQR2ZtemtKVlhzMW9xaHBYZk9LenFpUFhzS0Jn?=
 =?utf-8?B?Y1V0SkN2QVRxbG90UjQ3VXdpa29sUDllUTI2bmc2VVhSUTNNc3p2YWlkbXR5?=
 =?utf-8?B?UjVGWXk0ZUJzY0VUUjg5WU9JdnN4QmJoUWZ0UC9Ka3dmRkdzaTNTYWpHRWFy?=
 =?utf-8?B?K3ZDbWZiMU5IVWUrZUIzaUhnbzJEei9MUVhxcEZtbTdtK2xDNjh4akdvU2hi?=
 =?utf-8?Q?4acXAQMEWE5GnAxwy9dAY0DIt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlVsT3FoV3EvSFF6SFNhVGJxSFlMckJkYlRJOW0rK1NxWG5pWDNYelo1VXdX?=
 =?utf-8?B?T1JxQTFuWGxWbkpDOXZ5a0sxUmFKT3pORG9jMDNJd05rZ25qRmtsVHlPZkhK?=
 =?utf-8?B?djZUdWVjV2cxSXNWamlSS2YrZjZTL3REbjRRdXMrK29DMTRQRkpLaVg1OEoz?=
 =?utf-8?B?ZTVxbFNVaFBwYXdZaUE3cllWZUxHVFdrYnBmMEU1ZUdxSEY2emxId0I0eVNo?=
 =?utf-8?B?cVpoTlVOYi9IMTVqWExIR252d2I0NmIwN05TRy9mSjJKaEpQOHcyekN2eEts?=
 =?utf-8?B?akZmR2phKzBoOUNrNEdZYUpUczByVVVhd1NJUXhTUnNzNEd2ejZsZjBRV1Ay?=
 =?utf-8?B?K0pKdklTamFpMEpWd24xdVJRa2pzL3VwdFpUaHkzMVZab2VUcUUyVHkvbDU2?=
 =?utf-8?B?ckgzSit0S0ZBUGQ0cWsxd3hYZC85SkdvaXdYL2NxWFFMeFVVMzJZeUVBZXRs?=
 =?utf-8?B?dEp2RjJrOHJ0VVRXcGZZSkorYk1iT3JpUU0xMWZ6bFNCeWNCOWpXeGIzVUVz?=
 =?utf-8?B?UWEzV04xMnhKRGdDR0IzS2pVNGY1U0NNcUVJeitkQVNndjJHTWxiVXlpVVBh?=
 =?utf-8?B?eXd0VnFMRzVjNUdOdUlyYmMvT0tFd3lVYThzZmRiTDZQOG5aZENoK2xBODNq?=
 =?utf-8?B?RGloZGNJVkd1UlAzaTJ4eTlXZTFYZ1lSTjNQNms3WHQ1dWd2YXg4RjlQS0hE?=
 =?utf-8?B?QTBpT0NBUHBDQVJkS3lxNVBFL1BKRDRnNkJ4aDlVZjRvV1ZpRTlabWZVdjRO?=
 =?utf-8?B?bU0yMWwwZTJBS0ZKTDlQNTMweHZ3b0x5WDFianZvMG9KT24wYW4wVE1vbVMr?=
 =?utf-8?B?K2xxT1ltakZLMTZXdTV4eUloREN0MzU1MnFBSXBCN1F3RWx6SW80QlVTU0ZU?=
 =?utf-8?B?b1JtYkh5OFJPSGJXcm5sM014enM0T3Z0U1ZVNVRHdGdhS0NSZnNOb0xRQWFC?=
 =?utf-8?B?VGpaZGtPWGhJdmRzemZFaHRPM3huSUdlNVRWZmkvME8wQ0pnT1hESU1WTkFF?=
 =?utf-8?B?MEFkN0MwcGlBV205L0dSYmI2RndvNXBQdnBPcG14Z0hML3V2SVFBQWdGODNV?=
 =?utf-8?B?ckNGUC92bGhvY3J5THNYd3Qxcm1GcDFuYnM3a1RpaXN0dEllRjVOalMyaDN6?=
 =?utf-8?B?ZWFNTGRJZFdqVEtNTm9RVXNPSU1GV2VOaDJ3a1pDUWN5T09ubTlKb0Y2Z1ZL?=
 =?utf-8?B?T05wMk16RXlpNXl2ZGJCZVFkSEJFazhPalhScXZlOXpqQWFWd0tmam42NzYz?=
 =?utf-8?B?S2xTNk5zSkFpUURiYVplbytha2FQcWhjamxBR2hmbWpFQ21EYVFxcmx2QVdr?=
 =?utf-8?B?TFdVUHoycnQyK2xpdHhkUVYvdzdlMnczY3hVTFIyNDVjTmcvSUdYOTUrUG0x?=
 =?utf-8?B?Wk5wUHZuc2Y1aGQ5ZEhOZC9Qbk9ZblRmWXVPYzFVZ1dyYUErdmxDSzRMZkM4?=
 =?utf-8?B?QnhhbXJQemZyUXcvcnk3RzBlVVpnZHRIbmdkVVBTWlJTeGNGbE44VU5KamZj?=
 =?utf-8?B?M29UZ2ZZUlA2ZDAwU202MHhEbGRNRzJwMERFSDJGZlI0YjNKRjJ4U29VbjdP?=
 =?utf-8?B?QnlHOCtxd2JWcDd5MUJCRW8wRGZnc0phcW1ZMlV2UEJXZy8vNUxjb0QzUWcv?=
 =?utf-8?B?Z20wOWtoTVg1R2hTRHZOVEMxb1AyaEVyTkRqYkVxVFovOCs2RHFvelhGQjlV?=
 =?utf-8?B?ZWc5N1lPc0VvODRjcUhRMnIrdWNUWnhyM3UxSVI3TkVBSEpLZ3lDRjRwNjFR?=
 =?utf-8?B?RUFRbjA1N3RXU2tycHlmb0pmNHROS2kxUlJLc20rVEFVSHBMQmlHVVdzakNX?=
 =?utf-8?B?OVBaejY3VnpRYWJWUkJ5YmxuaTU0WXJ3WHVHaEVGTGRaVVZ0NU1MUkxGWmph?=
 =?utf-8?B?K3V0U3IwY3Y5bzFyd2w3U3ROTjJpTGRNbmdqbnQ5bUtGZUd4RW1iNFE4SEdm?=
 =?utf-8?B?bmJ0cWE3cVQ0Tkw3bE1vZ2REZ1FjcW9nVXZXRXVsRUY4QnZUeEdCYWtpVVVX?=
 =?utf-8?B?azhEY001ME53NzYzT09ibVNXQ211V2RHQlpVWFhmS2tmQitqaUFyTnp1R21p?=
 =?utf-8?B?dU9kQlVLKyt2cmFwelRPYWNXNFJqVCtZZ0lLUHdSTWFFcDRlMGQyKzZVRUli?=
 =?utf-8?B?a3VVZzBaWXgreGR5OE54SnRpdmcwbHA3ekI3TmxoM2VJckdnOUN1NS9weGtH?=
 =?utf-8?B?TjBqck9TUXZBRlF6L0VjeUl1UjN1VTEzNVJJaUREM0YzZTlPeHZLTENWYWMv?=
 =?utf-8?B?Y0lJTGplSE4rdVMyc2E4aENKNWYyWGZOZSt6MXJkaDdOUjd1bHdRYXUrWHVs?=
 =?utf-8?B?Z1d3K1dPeUJQQWZoWDJ0WTZTcW1YaXE0R0tVSlM5NlFhQkg3dTdYdXJzMllX?=
 =?utf-8?Q?7eJ9DnXooarj8JOphUbJWU6nVS9WG9qJyxkX4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDE2279FA424024E9EABFD168095BB09@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cda10c40-e9a0-4a99-76a2-08de6a80d7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 21:51:13.9121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wV2kjBPs97P/PGcKWDq6DHG/fbsWOrZPrrqkFxkjeTjine3szcM+q+nz7HgixwtT4vaffB+U7SvuqU0k9BhePg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4577
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698e4b54 cx=c_pps
 a=+9lCAQqCkh6G/pz+5LnHJg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=Kk4oP9S42mGQ84ZI:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=P-IC7800AAAA:8
 a=l5MG69z2Oz79vq9UucsA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: KRVv8lrRqkuhWuUs11yViX7JugZHf7lA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE2OSBTYWx0ZWRfX4HVFfo70HDqR
 KuhjcXNxyOIx3TtOiJm7KjG5iGoWxp5C/OYA50+7d4Ckl+TGfFmnIBQzq5PwOk2k4NFjIHguoIK
 jb7AdECANcU0a6NW8dgXH1M7JMkpFLX4s8E0RgYbdmEVBA+C7PCLnyKwrB20razAFINovfuSWQU
 Hw2qflS8MhpI8KOb9ulSXdTpR8DqT/71tfrYUYEQr9vFNFKSNrzqMuGQDo4T2WiZtC5udBiHGGK
 /RuwyD/07o9ijMWKsilO++1xUuVpAsVTlk2X/i7jISXkwJZ9bwxNM3DwpzwsaV4z/ippTcOjwUt
 DGlx60qdoApAJ4Vv/oIxMIs2qPiBaTfDH47N/nWLbAM3UjWdfgclrQILGGiI2VJtgYXS10mxxE0
 fMgASKBXmcxlpNsoQJOJq+afS6KCNf4RoD7H7ll/cQyMopZoYFt683TepjRwoX/tphISJMo+PUm
 Nzhm0LDcjcPGmdZYPPg==
X-Proofpoint-GUID: KRVv8lrRqkuhWuUs11yViX7JugZHf7lA
Subject: RE: [PATCH] hfs: evaluate the upper 32bits for detecting overflow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120169
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77058-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A292B13161D
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTEyIGF0IDIyOjI3ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjYvMDIvMTIgNzozNiwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gT25s
eSBjb21waWxlIHRlc3RlZC4NCj4gPiANCj4gPiBNYXliZSwgaXQgbWFrZXMgc2Vuc2UgdG8gcnVu
IHNvbWUgdGVzdHM/IDopDQo+ID4gDQo+IA0KPiBJIHRyaWVkIGJlbG93IGRpZmYuIFdoaWxlIHRo
aXMgZGlmZiB3b3JrZWQsIEkgY2FtZSB0byBmZWVsIHRoYXQgd2UgZG9uJ3QgbmVlZCB0bw0KPiBm
YWlsIG9wZXJhdGlvbnMgdXBvbiBvdmVyZmxvdyBvZiAtPmZpbGVfY291bnQgb3IgLT5mb2xkZXJf
Y291bnQuDQo+IA0KPiBTaW5jZSAtPm5leHRfaWQgaXMgdXNlZCBmb3IgaW5vZGUgbnVtYmVyLCB3
ZSBzaG91bGQgY2hlY2sgZm9yIG5leHRfaWQgPj0gMTYuDQo+IA0KPiBCdXQgLT5maWxlX2NvdW50
IGFuZCAtPmZvbGRlcl9jb3VudCBhcmUgKGlmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkpIG9ubHkg
Zm9yDQo+IHN0YXRpc3RpY2FsIHB1cnBvc2UgYW5kICpjdXJyZW50bHkgY2hlY2tpbmcgZm9yIG92
ZXJmbG93IG9uIGNyZWF0aW9uIGFuZCBub3QNCj4gY2hlY2tpbmcgZm9yIG92ZXJmbG93IG9uIGRl
bGV0aW9uKi4NCj4gDQoNClRoZXNlIGZpZWxkcyBleGlzdCBub3QgZm9yIHN0YXRpc3RpY2FsIHB1
cnBvc2UuIFdlIHN0b3JlIHRoZXNlIHZhbHVlcyBpbiBzdHJ1Y3QNCmhmc19tZGIgWzEsIDJdIGFu
ZCwgZmluYWxseSwgb24gdGhlIHZvbHVtZS4gQXMgZmlsZSBzeXN0ZW0gZHJpdmVyIGFzIEZTQ0sg
dG9vbA0KY2FuIHVzZSB0aGVzZSB2YWx1ZXMgZm9yIGNvbXBhcmluZyB3aXRoIGItdHJlZXMnIGNv
bnRlbnQuDQoNCkFzIEkgcmVtZW1iZXIsIHdlIGFyZSBjaGVja2luZyB0aGUgZGVsZXRpb24gY2Fz
ZSB0b28gWzNdLg0KDQo+IFRoZXJlIGFyZSAtPnJvb3RfZmlsZXMgYW5kIC0+cm9vdF9kaXJzDQo+
IHdoaWNoIGFyZSBhbHNvIGZvciBzdGF0aXN0aWNhbCBwdXJwb3NlIGFuZCAqY3VycmVudGx5IG5v
dCBjaGVja2luZyBmb3Igb3ZlcmZsb3cqLg0KDQpJdCdzIGFsc28gbm90IGZvciBzdGF0aXN0aWNh
bCBwdXJwb3NlLiA6KSAgSSB0aGluayB0byBoYXZlIHRoZSBjaGVja2luZyBsb2dpYw0KZm9yIHJv
b3RfZmlsZXMgYW5kIHJvb3RfZGlycyB3aWxsIGJlIGdvb2QgdG9vLg0KDQo+IE92ZXJmbG93aW5n
IG9uIHRoZXNlIGNvdW50ZXJzIGFyZSBub3QgZmF0YWwgZW5vdWdoIHRvIG1ha2Ugb3BlcmF0aW9u
cyBmYWlsLg0KPiANCj4gSSB0aGluayB0aGF0IHdlIGNhbiB1c2UgMzJiaXRzIGF0b21pY190IGZv
ciAtPmZpbGVfY291bnQgLyAtPmZvbGRlcl9jb3VudCwgYW5kIGNhcA0KPiBtYXgvbWluIHJhbmdl
IHVzaW5nIGF0b21pY19hZGRfdW5sZXNzKHYsIDEsIC0xKS9hdG9taWNfYWRkX3VubGVzcyh2LCAt
MSwgMCkuDQoNClRoZXNlIHZhbHVlcyBhcmUgX19iZTMyIGFuZCBpdCBtZWFucyB0aGF0IFUzMl9N
QVggaXMgY29tcGxldGVseSBub3JtYWwgdmFsdWUuDQpUaGlzIGlzIHdoeSBhdG9taWM2NF90IHdh
cyBzZWxlY3RlZC4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9o
ZnMvaW5vZGUuYyBiL2ZzL2hmcy9pbm9kZS5jDQo+IGluZGV4IDg3ODUzNWRiNjRkNi4uYjJjMDk1
NTU1Nzk3IDEwMDY0NA0KPiAtLS0gYS9mcy9oZnMvaW5vZGUuYw0KPiArKysgYi9mcy9oZnMvaW5v
ZGUuYw0KPiBAQCAtMTk5LDcgKzE5OSw3IEBAIHN0cnVjdCBpbm9kZSAqaGZzX25ld19pbm9kZShz
dHJ1Y3QgaW5vZGUgKmRpciwgY29uc3Qgc3RydWN0IHFzdHIgKm5hbWUsIHVtb2RlX3QNCj4gIAlz
cGluX2xvY2tfaW5pdCgmSEZTX0koaW5vZGUpLT5vcGVuX2Rpcl9sb2NrKTsNCj4gIAloZnNfY2F0
X2J1aWxkX2tleShzYiwgKGJ0cmVlX2tleSAqKSZIRlNfSShpbm9kZSktPmNhdF9rZXksIGRpci0+
aV9pbm8sIG5hbWUpOw0KPiAgCW5leHRfaWQgPSBhdG9taWM2NF9pbmNfcmV0dXJuKCZIRlNfU0Io
c2IpLT5uZXh0X2lkKTsNCj4gLQlpZiAobmV4dF9pZCA+IFUzMl9NQVgpIHsNCj4gKwlpZiAodXBw
ZXJfMzJfYml0cyhuZXh0X2lkKSkgew0KPiAgCQlhdG9taWM2NF9kZWMoJkhGU19TQihzYiktPm5l
eHRfaWQpOw0KPiAgCQlwcl9lcnIoImNhbm5vdCBjcmVhdGUgbmV3IGlub2RlOiBuZXh0IENOSUQg
ZXhjZWVkcyBsaW1pdFxuIik7DQo+ICAJCWdvdG8gb3V0X2Rpc2NhcmQ7DQo+IEBAIC0yMTcsNyAr
MjE3LDcgQEAgc3RydWN0IGlub2RlICpoZnNfbmV3X2lub2RlKHN0cnVjdCBpbm9kZSAqZGlyLCBj
b25zdCBzdHJ1Y3QgcXN0ciAqbmFtZSwgdW1vZGVfdA0KPiAgCWlmIChTX0lTRElSKG1vZGUpKSB7
DQo+ICAJCWlub2RlLT5pX3NpemUgPSAyOw0KPiAgCQlmb2xkZXJfY291bnQgPSBhdG9taWM2NF9p
bmNfcmV0dXJuKCZIRlNfU0Ioc2IpLT5mb2xkZXJfY291bnQpOw0KPiAtCQlpZiAoZm9sZGVyX2Nv
dW50PiBVMzJfTUFYKSB7DQo+ICsJCWlmICh1cHBlcl8zMl9iaXRzKGZvbGRlcl9jb3VudCkpIHsN
Cj4gIAkJCWF0b21pYzY0X2RlYygmSEZTX1NCKHNiKS0+Zm9sZGVyX2NvdW50KTsNCj4gIAkJCXBy
X2VycigiY2Fubm90IGNyZWF0ZSBuZXcgaW5vZGU6IGZvbGRlciBjb3VudCBleGNlZWRzIGxpbWl0
XG4iKTsNCj4gIAkJCWdvdG8gb3V0X2Rpc2NhcmQ7DQo+IEBAIC0yMzEsNyArMjMxLDcgQEAgc3Ry
dWN0IGlub2RlICpoZnNfbmV3X2lub2RlKHN0cnVjdCBpbm9kZSAqZGlyLCBjb25zdCBzdHJ1Y3Qg
cXN0ciAqbmFtZSwgdW1vZGVfdA0KPiAgCX0gZWxzZSBpZiAoU19JU1JFRyhtb2RlKSkgew0KPiAg
CQlIRlNfSShpbm9kZSktPmNsdW1wX2Jsb2NrcyA9IEhGU19TQihzYiktPmNsdW1wYWJsa3M7DQo+
ICAJCWZpbGVfY291bnQgPSBhdG9taWM2NF9pbmNfcmV0dXJuKCZIRlNfU0Ioc2IpLT5maWxlX2Nv
dW50KTsNCj4gLQkJaWYgKGZpbGVfY291bnQgPiBVMzJfTUFYKSB7DQo+ICsJCWlmICh1cHBlcl8z
Ml9iaXRzKGZpbGVfY291bnQpKSB7DQo+ICAJCQlhdG9taWM2NF9kZWMoJkhGU19TQihzYiktPmZp
bGVfY291bnQpOw0KPiAgCQkJcHJfZXJyKCJjYW5ub3QgY3JlYXRlIG5ldyBpbm9kZTogZmlsZSBj
b3VudCBleGNlZWRzIGxpbWl0XG4iKTsNCj4gIAkJCWdvdG8gb3V0X2Rpc2NhcmQ7DQo+IGRpZmYg
LS1naXQgYS9mcy9oZnMvbWRiLmMgYi9mcy9oZnMvbWRiLmMNCj4gaW5kZXggYTk3Y2VhMzVjYTJl
Li5iZGZhNTQ4MzNhNGYgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmcy9tZGIuYw0KPiArKysgYi9mcy9o
ZnMvbWRiLmMNCj4gQEAgLTY4LDE2ICs2OCwxNyBAQCBib29sIGlzX2hmc19jbmlkX2NvdW50c192
YWxpZChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQ0KPiAgew0KPiAgCXN0cnVjdCBoZnNfc2JfaW5m
byAqc2JpID0gSEZTX1NCKHNiKTsNCj4gIAlib29sIGNvcnJ1cHRlZCA9IGZhbHNlOw0KPiArCXM2
NCBuZXh0X2lkID0gYXRvbWljNjRfcmVhZCgmc2JpLT5uZXh0X2lkKTsNCj4gIA0KPiAtCWlmICh1
bmxpa2VseShhdG9taWM2NF9yZWFkKCZzYmktPm5leHRfaWQpID4gVTMyX01BWCkpIHsNCj4gKwlp
ZiAodW5saWtlbHkodXBwZXJfMzJfYml0cyhuZXh0X2lkKSB8fCBuZXh0X2lkIDwgSEZTX0ZJUlNU
VVNFUl9DTklEKSkgew0KPiAgCQlwcl93YXJuKCJuZXh0IENOSUQgZXhjZWVkcyBsaW1pdFxuIik7
DQo+ICAJCWNvcnJ1cHRlZCA9IHRydWU7DQo+ICAJfQ0KPiAtCWlmICh1bmxpa2VseShhdG9taWM2
NF9yZWFkKCZzYmktPmZpbGVfY291bnQpID4gVTMyX01BWCkpIHsNCj4gKwlpZiAodW5saWtlbHko
dXBwZXJfMzJfYml0cyhhdG9taWM2NF9yZWFkKCZzYmktPmZpbGVfY291bnQpKSkpIHsNCj4gIAkJ
cHJfd2FybigiZmlsZSBjb3VudCBleGNlZWRzIGxpbWl0XG4iKTsNCj4gIAkJY29ycnVwdGVkID0g
dHJ1ZTsNCj4gIAl9DQo+IC0JaWYgKHVubGlrZWx5KGF0b21pYzY0X3JlYWQoJnNiaS0+Zm9sZGVy
X2NvdW50KSA+IFUzMl9NQVgpKSB7DQo+ICsJaWYgKHVubGlrZWx5KHVwcGVyXzMyX2JpdHMoYXRv
bWljNjRfcmVhZCgmc2JpLT5mb2xkZXJfY291bnQpKSkpIHsNCj4gIAkJcHJfd2FybigiZm9sZGVy
IGNvdW50IGV4Y2VlZHMgbGltaXRcbiIpOw0KPiAgCQljb3JydXB0ZWQgPSB0cnVlOw0KPiAgCX0N
Cg0KWzFdDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xOS1yYzUvc291cmNl
L2luY2x1ZGUvbGludXgvaGZzX2NvbW1vbi5oI0wyMTcNClsyXSBodHRwczovL2VsaXhpci5ib290
bGluLmNvbS9saW51eC92Ni4xOS1yYzUvc291cmNlL2ZzL2hmcy9tZGIuYyNMMjgyDQpbM10gaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTktcmM1L3NvdXJjZS9mcy9oZnMvaW5v
ZGUuYyNMMjY0DQo=

