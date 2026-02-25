Return-Path: <linux-fsdevel+bounces-78395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJTCBV9Dn2laZgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 19:45:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD3519C683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 19:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7775303013B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 18:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6373A344040;
	Wed, 25 Feb 2026 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BWNTLsc1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922C6212542;
	Wed, 25 Feb 2026 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045084; cv=fail; b=EEOrTOtOZO5CA+PfOCcL6+FJedbDNrPT6usacUzcqiG7/jyUzJk/jABxgd6KECHGswg6/VFuKi/dOdP7Et0RUG+LD6iHHRsIENQPbKkvX35n2Agu+YR0n9LJB2c8ZhpwX4uE/XhHwhdrQDuJj4gjHDztvhtvS7wGgQPUgX3PFtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045084; c=relaxed/simple;
	bh=jiitNOYxXkwwMxC0uAb8R//i7diTvBOKjica1sDL5cg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ufFlfHkdxwuEPdtG174fzMrMZjyMKDzHFJkBpbSmKHYM52/cgljHePlLqgG7ZMGgG7kaJVAGtpY9fhWKi99qS/kDx+rGFiqdZi4Ja4cHXuB1o5TOkiwl/EwiCc2XkajzIbF6A6urxcJ3Ee3mL+7fu+KcwdQoAEFX/JpNke4o9RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BWNTLsc1; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PCIxHU2713427;
	Wed, 25 Feb 2026 18:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=jiitNOYxXkwwMxC0uAb8R//i7diTvBOKjica1sDL5cg=; b=BWNTLsc1
	fXP1wxadSaHMeQ1AZ0NoJ/jBBub7TodJexOfG3nWZvn+Xsl6kUOegdZWgdWl0j+M
	u4LmYrQFZBsrurkfh9v3AKhlObkUMxnnIPhnWB1ne6VPYZ5NEVavQRzIy6hTY6GR
	lCc9cHIcxfvjF+eFBh/TtUL01bxlXVUmmTBieBZSXgev2uNUajkO81iUZU1WmcTe
	IJJVNfZ9Vfi2g5riTx855j9V3obURp3D1sFTdCUk8RvPgElTm31UU6E7OLGHVtZk
	Ef9PDVr018bAtqouVZP7TOAOQlt3gqvpzZ7VpzTlAG8LopjKIfJkaaeyvhd62y5G
	leAMJ+t82eulkg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c95cd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 18:44:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDk+glMRnKpsMrv0OAFCGEdHkRkEFLaGBYJ8Q8nqQr3G3jXnUGYlwnjR+EXHfH9b42dCRqU1FgJHcN4uXLjY7wWnLir+EoDNPjhuNMn3r2H6fFtwmqvyRLdYnd8ItOkaCji/6IHA7oZBVx/pnwJqygb81uwzqtGeRt+0VcWsWOla06/V23B3H/D+anfKnOCN0j40OhTKlVA0Y4e+gMx/ePkVp58Y38f9y3Mi9FO0+wyvKQSg0HRDaPphJu4XCJEkO4NSMp5WlX0XvbeAA2zCBr0nuwMLzEBznHMngxJpRy6e9hMF/yow4jJyAFQqhrLqrKBBM2Nx3U9R8Qi8wiSbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiitNOYxXkwwMxC0uAb8R//i7diTvBOKjica1sDL5cg=;
 b=UcR6REpEyh/U48punGFGWERTePJ3LoqPJ2YrA6JnvjWpXNXQSzOjp+kPa29FJcE7T6M3uRu1UUSmm9/DeH8TlL1IGpIh1wKId0+o/4kjcFfACfr+EzR6Q4NcwA3AcGIYByDnoay3L3IIheDmK7SsmVdz9J0dbbiXsEW9lrH3Pgvob2e4/Th0RMXpgKWXxt2v3pvf0bV7QQ/v/jYfWTkwVom4w1+VItIlPiLyO2oz7DxqY5NUaKv4PYxvUxvtunoXVpD/alo9X4Ot1tscAv5yerXys1h1CMO0Ge3SVYfLteSoqTq1DEhhbUbiF2OakCJruB3n2241L782wqy59HZ1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB6068.namprd15.prod.outlook.com (2603:10b6:8:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 18:44:28 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 18:44:28 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "anishm7030@gmail.com" <anishm7030@gmail.com>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "brauner@kernel.org" <brauner@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] ramfs: convert alloc_pages() to folio_alloc()
 in ramfs_nommu_expand_for_mapping()
Thread-Index: AQHcpcyWZTY1BwQHSUOoPHTK6W+1TbWTwfCA
Date: Wed, 25 Feb 2026 18:44:28 +0000
Message-ID: <9a40c9e323e30b61527f96796e10daffef5d06e7.camel@ibm.com>
References: <20260224203134.101436-1-anishm7030@gmail.com>
In-Reply-To: <20260224203134.101436-1-anishm7030@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB6068:EE_
x-ms-office365-filtering-correlation-id: 2b62bce5-6843-43c9-8fdf-08de749de81c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 scO+viJTOTUNYLXKJQkqJc/Q15e3cNzhwggJ0HuVva2AmtjtUMmN/ckjTKTvbmJSCevzkaW21/s356fA/43iwEB/KhHnzdkTQBuAcBpeRC+hUbtsY59jUFhMzBYioGE5kjplSj0dDEhXEsq4rEj+s71QWhUtbP+eFM/ALFTTCSFn1dN88tG610Gg5x99TG9eEKd4EV6aKPH7zHdP3hd07u0ccCMS5IanWRcbyhwa0UWLe407eeFB04g0PH6oKo3pECJ6rNYj9f6qVYimzCA/BsUw2tWBRuznQO3w8z/gY2A0+6aY/V2OyOE0VoqiJ8g9q4gyNKzKC+n7svmdv8l7oC/DIv/7e3MJK8lfmfatjedvkfyc8ySRHkstqPgBURaXg9WL1YABXMaFOYn1txBs4hHakem6CoRCaA9nIiamcVDjEwNg7QZTsSp7zUT66LfpZkOlRzQYD201/RTIgKo/4zJDy1KXPRY7w+oJHXeLnE/HKY7pf9Zn6wMr/bFt4pwg1Ur8UOGEtEXxScWsbG8pP+ixVQ4HDYL9zN0hkLsUm78hj3ONEBupTE4NPh/UYtPof/k9hU9hJR1vsaGr8J5P9gKZkBlsn2PYDAqINLhvbSm/PPd+ceSAjbC2FHc4FQehVUVRT5VO+PTcYcP/fH8Z1v/V3FKFtr0GpU5bzFCE94pFT/OqE8CTb5NacEuxnV8CXPuX4IYSHxRhwuA4leDD5cn7n30cUVjl5JzXeeHSwYPbmPG5Wix7gfypwjb6v5wFWO5EecYvzz7ynLl0c4E3zad3A5Fk3OhE8PaT90tpcnU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sy8ra0hjU1ZSWGU1eldSTGIwS0FPblVpU1lscElkV2xiNDBlem0xQzh4d2ZT?=
 =?utf-8?B?a0pyWXNienlFaVp5S3plN3JLTitZMjRzUjRZalgza3d2bGZZM2s4NzJjL0s2?=
 =?utf-8?B?QUtmeGNOdXFxTlpTQmkzWEo1b3N4engrN2Y2V2pzYU1BL3JkV0owNTdxRUN5?=
 =?utf-8?B?Y0pFVEtzNzZndm02Qlp3WVQzdjVqSHhhS1VqK25JVmVhTGVxMWFhamVvUTFB?=
 =?utf-8?B?QWRPVXU5WkcxczR6UmJMV1NiU1dJRndMS2xUQ3p2S2hRQ1EzN2RFNUE5U1Ux?=
 =?utf-8?B?SUY0UDltK2l1R1pWK3BlZXRXdkNodURZbjlqbjFWeEpWSUNnSW81TEhqNGZO?=
 =?utf-8?B?VkJOWW54LzFkdytxODB6aUJQOXczUnlTZUZva1dYRy90MDF4WmRRR0dOUUpl?=
 =?utf-8?B?WkRoOFZISVhWUkhFMnpvSjhmSlVIb3gwVjkva21vUHo3RHMzbVNMMHMrYjd5?=
 =?utf-8?B?ZURBZnY1NGZVVS8yWDhJQkhlSDhxcGhTdFhzaTdIVmNRN2E0OUEwbUF2VDRW?=
 =?utf-8?B?NUtnejFUZGs2TjZCbG8xMC8ycGozYWhmdFpIVnNGQkZaWmN4RnZ0WW9lQ0Qv?=
 =?utf-8?B?bXJUOHVIcWt2UXNBbENFbEtveU44VFlrVERDY1pDVXB0ZEQwb0ZHSXA3VXg4?=
 =?utf-8?B?YXQwVlJtYVRsNXVMU3FlQjN2VFhtRDltbFpoUnlsY0pINmswOGZKMkt0K1Bw?=
 =?utf-8?B?Sjh2R1BuRk5UajBxZE1JWnphVDdmdmJCaTZLQWdaVnJGa3hFSUhhOVlDTURp?=
 =?utf-8?B?cEJXVk5pUy84WVhwWU5tN01NaGxxK1A2RE9QY09JTzBPWUk3dHVoVGhac2l0?=
 =?utf-8?B?VnNaa1NJam9ScktmV0huSmM5ZW14OThFYW1ubGYzSXN0bGttZW5GdjlRejlG?=
 =?utf-8?B?MkNMZ0hJYVJyVjdrV1Bma1pVVyt0SGNkTVVURzJJVXFSalE2Mk9kT2NuRHIv?=
 =?utf-8?B?RTRCUVVHb0JyT09ac29ra2tDUHl1MU9wdWMzdmlBV1Y3bTFFWHpIOEticzJ2?=
 =?utf-8?B?ZGJqZG4xc0QrV1U4ZUZhTjN4WXBMRUFsK243MFJQeTIwQ0w2ZWczNHpRTVh0?=
 =?utf-8?B?WFpPMnNoQWQyby9qem96bytKTHltQSt2TlMvc2cySUJPY0lYZnJZdXZoYlhI?=
 =?utf-8?B?OUlld2F1aGt5Si8rM3M1M2Uyd1hLVUk4andPaHIwRXByMnl0aGd1NnRSdjdE?=
 =?utf-8?B?SDNZTHFud1I5NEFYR2Z4Y3pPSFZZc08rd3cwNzF4dFVsVEtrZEZjdGlNdDV5?=
 =?utf-8?B?QVF2bzE0cXhrRDdhRHdTRTA2bGk4T0dVOUM3YUx1emd1alVuaVgyOEtkRzN1?=
 =?utf-8?B?VDV2bGJrMzE0aU1BSWt5bC9KbDA5N2VjdnkyZnlOeXV6OGQvY0ZWU2p1UFVt?=
 =?utf-8?B?R1kwRG5MY0dMS2pOUTc3NFV4T2l1Y3R6eFRuN2pSNElYLzhOUjFJMlFsa3o2?=
 =?utf-8?B?THlDL3daaENJYk9sVTV2TTFUUEs4THVBRGJOR1AxTVJvZWlIMU9zSVFTL3M3?=
 =?utf-8?B?SDUyZG9yNkppYnBGdVB5ZXpwdVc1aEg5cXBTd0JwODg3cXpoSzhVRXhqcWxr?=
 =?utf-8?B?MjJHYWVKejVNNy85djA0OExhWWVvMGppdC96Zi9mRE5URm9tbllVdlozWldp?=
 =?utf-8?B?dlZZZmVrd3lRR3lvaUlkWmNBRGVoL2kxRDAyYS9pNlhmQkZrd3hjek5JRHc4?=
 =?utf-8?B?am9pWkF1YmFXUmU4akY2V2N0dnJlTmN5dUdmVDNndEZiOTJnOXhOSEYwcURB?=
 =?utf-8?B?MThxZmRUanovZElXanJYdnBIZWI4d1lvcHdLcHhBdTBkU0UxQ1VkYjVENTFi?=
 =?utf-8?B?ZUxLVGpsRkxyeTAvT2I5YTJiT2dnZjZlQWpvaXhTUXcwTngxOWJSaFN4VTYw?=
 =?utf-8?B?Qk5vYysxSVBNYkczdGNhdFFaaUQ3ekxHTnJIVURHMUloa091U216Z0VHKzQ2?=
 =?utf-8?B?b1RtMG1mSndDTzc1MjBHQ1FGU0IybSt4Ui91OGlrR0dJVHgwdzBCSGRaZWd1?=
 =?utf-8?B?N1JaMXN5dnJQUTI3Z05RRDdieEFHazBzaThiUlZIdEVqZjlONFBRNGx1d0k2?=
 =?utf-8?B?YjBIOEhoOHZ1dEtjNjlnMzlLMitXcHZOZHE3UU5Yd3ZZY0ZmbGlFVkJTenhu?=
 =?utf-8?B?aDYrZ2tZZEJyTFZuU0w2Qk41cEN3QTc5UlNab3AzaVlUandhVW02Y0lPbDNE?=
 =?utf-8?B?Tk5wb0VlalFtbW9kbVA1dlAvelR5K1h2TldIQU9lSjNrcUdmZzJGRXAyRGd5?=
 =?utf-8?B?MTAza01UdHVWN1d6Y2ZPeHVONm10NEVTa2gvUW9KMkFNQUkxK2lWaTI5dHJZ?=
 =?utf-8?B?TVdQN1hRcmlSSVg4cUU1dkQ1c2JnRVBwek1RcTNSMkpSWmEwK2pIYllNZGdp?=
 =?utf-8?Q?u9cDdCpRmZlrl5KE3zESYGD53bQJ/uc35pRkU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A02193D041A67409157E72820EC6B61@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b62bce5-6843-43c9-8fdf-08de749de81c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 18:44:28.5859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNiWibaRZ8EK+y0XdKUeoen4VFIUlT53klDXyxFn3dpe3lg8mGDYr4T5bJLW53pdMVCn99VWfSV0pdDvQbXFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6068
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE3OSBTYWx0ZWRfX2yARgP9NK8V2
 5w2l7HozUz/l2Y+1D94iZVolqIGNvlf6XDn7cfav2VnZLO+LF3upFoT21WuT7L1hSgPgPXPgyki
 rO3SBFgmClDPJOhbHqY4BDAwGHY7Zdp/dnmxukwSUOecHnwyfEjkeqNlJA1+fv6xBLlekH8n7KY
 E5pNhyddTD7z1l9JjOPm9637NXVoiT/ufUYvN6NkBrmiIn9eGECv/8bag5uRAFKQCCCwBt76MDM
 YExLY0uinDt4BD7E+U9+vVRhmMQdKAqpaji7KYnhNztdNn9cQYdK1GA1qD8VtEKD0+PV2tLe7XS
 twvleTh0KGShSj+oIAM3fcey5xsLTTjkHTsqzUBas94wv33w+5TcWllEdNcykitd+Nt1amFZmbP
 VZv4hqmGyBK0L7whvuT/Gcla05mwz+Ax6w4NSGGB+WeFz+TtI/I1RTIDa0rq9Nbnxjla4G0jWRh
 PBbXcgDNG1QK5n88r2Q==
X-Proofpoint-ORIG-GUID: R5iP7Xfgv3oWVMVOvhNnJVvtnpuRTk1M
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699f430f cx=c_pps
 a=AqWYtYKdvuqIQX7AE/aD9Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=OE2p78BuclK1AqHl0rYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: f7yKkPf4XIWi38TItIEtjMIm5MbI9jaY
Subject: Re:  [PATCH] ramfs: convert alloc_pages() to folio_alloc() in
 ramfs_nommu_expand_for_mapping()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250179
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-78395-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,suse.cz,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7CD3519C683
X-Rspamd-Action: no action

Q0M6IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnDQoNCg0KT24gVHVlLCAyMDI2LTAyLTI0
IGF0IDE1OjMxIC0wNTAwLCBBbmlzaE11bGF5IHdyb3RlOg0KPiBDdXJyZW50bHksIHJhbWZzX25v
bW11X2V4cGFuZF9mb3JfbWFwcGluZygpIHV0aWxpemVzIHRoZSBkZXByZWNhdGVkDQo+IGFsbG9j
X3BhZ2VzKCkgQVBJLiBUaGlzIHBhdGNoIGNvbnZlcnRzIHRoZSBhbGxvY2F0aW9uIHN0ZXAgdG8g
dXNlDQo+IHRoZSBtb2Rlcm4gZm9saW9fYWxsb2MoKSBBUEksIHJlbW92aW5nIGEgbGVnYWN5IGNh
bGxlciBhbmQgaGVscGluZw0KPiBwYXZlIHRoZSB3YXkgZm9yIHRoZSBldmVudHVhbCByZW1vdmFs
IG9mIGFsbG9jX3BhZ2VzKCkuDQo+IA0KPiBCZWNhdXNlIG5vbW11IGFyY2hpdGVjdHVyZXMgcmVx
dWlyZSBwaHlzaWNhbGx5IGNvbnRpZ3VvdXMgbWVtb3J5IHRoYXQNCj4gb2Z0ZW4gbmVlZHMgdG8g
YmUgdHJpbW1lZCB0byB0aGUgZXhhY3QgcmVxdWVzdGVkIHNpemUsIHRoZSBhbGxvY2F0ZWQNCj4g
Zm9saW8gaXMgaW1tZWRpYXRlbHkgc2hhdHRlcmVkIHVzaW5nIHNwbGl0X3BhZ2UoKS4NCj4gDQo+
IFNpbmNlIHNwbGl0X3BhZ2UoKSBkZXN0cm95cyB0aGUgY29tcG91bmQgZm9saW8gbWV0YWRhdGEs
IHVzaW5nIGZvbGlvDQo+IGl0ZXJhdGlvbiBoZWxwZXJzIChsaWtlIGZvbGlvX3BhZ2UpIGJlY29t
ZXMgdW5zYWZlLiBUaGVyZWZvcmUsIHRoaXMNCj4gcGF0Y2ggZGVsaWJlcmF0ZWx5IGRyb3BzIGJh
Y2sgdG8gYSBzdGFuZGFyZCBzdHJ1Y3QgcGFnZSBhcnJheSBhZnRlcg0KPiB0aGUgc3BsaXQuIFRo
aXMgc2FmZWx5IGlzb2xhdGVzIHRoZSBmb2xpbyBjb252ZXJzaW9uIHRvIHRoZSBhbGxvY2F0aW9u
DQo+IHBoYXNlIHdoaWxlIHN0cmljdGx5IHByZXNlcnZpbmcgdGhlIGV4aXN0aW5nIHRyaW1taW5n
IGFuZCBwYWdlIGNhY2hlDQo+IGluc2VydGlvbiBiZWhhdmlvci4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEFuaXNoTXVsYXkgPGFuaXNobTcwMzBAZ21haWwuY29tPg0KPiAtLS0NCj4gIGZzL3JhbWZz
L2ZpbGUtbm9tbXUuYyB8IDcgKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9yYW1mcy9maWxlLW5v
bW11LmMgYi9mcy9yYW1mcy9maWxlLW5vbW11LmMNCj4gaW5kZXggNzdiOGNhMjc1N2UwZC4uNzY3
ZGU4ZmM1NmYwZiAxMDA2NDQNCj4gLS0tIGEvZnMvcmFtZnMvZmlsZS1ub21tdS5jDQo+ICsrKyBi
L2ZzL3JhbWZzL2ZpbGUtbm9tbXUuYw0KPiBAQCAtNjIsNiArNjIsNyBAQCBjb25zdCBzdHJ1Y3Qg
aW5vZGVfb3BlcmF0aW9ucyByYW1mc19maWxlX2lub2RlX29wZXJhdGlvbnMgPSB7DQo+ICBpbnQg
cmFtZnNfbm9tbXVfZXhwYW5kX2Zvcl9tYXBwaW5nKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHNpemVf
dCBuZXdzaXplKQ0KDQpUaGlzIG1ldGhvZCB1c2VzIG9sZCBwYWdlIGNvbmNlcHQgZXZlcnl3aGVy
ZS4gSWYgeW91IHdvdWxkIGxpa2UgdG8gc3dpdGNoIHRoaXMNCm1ldGhvZCBmb3IgdXNpbmcgdGhl
IGZvbGlvIGNvbmNlcHQsIHRoZW4gSSBhc3N1bWUgdGhpcyBtZXRob2QgcmVxdWlyZXMgbW9yZQ0K
cmV3b3JrLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiAgew0KPiAgCXVuc2lnbmVkIGxvbmcgbnBh
Z2VzLCB4cGFnZXMsIGxvb3A7DQo+ICsJc3RydWN0IGZvbGlvICpmb2xpbzsNCj4gIAlzdHJ1Y3Qg
cGFnZSAqcGFnZXM7DQo+ICAJdW5zaWduZWQgb3JkZXI7DQo+ICAJdm9pZCAqZGF0YTsNCj4gQEAg
LTgxLDEwICs4MiwxMiBAQCBpbnQgcmFtZnNfbm9tbXVfZXhwYW5kX2Zvcl9tYXBwaW5nKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHNpemVfdCBuZXdzaXplKQ0KPiAgDQo+ICAJLyogYWxsb2NhdGUgZW5v
dWdoIGNvbnRpZ3VvdXMgcGFnZXMgdG8gYmUgYWJsZSB0byBzYXRpc2Z5IHRoZQ0KPiAgCSAqIHJl
cXVlc3QgKi8NCj4gLQlwYWdlcyA9IGFsbG9jX3BhZ2VzKGdmcCwgb3JkZXIpOw0KPiAtCWlmICgh
cGFnZXMpDQo+ICsJZm9saW8gPSBmb2xpb19hbGxvYyhnZnAsIG9yZGVyKTsNCj4gKwlpZiAoIWZv
bGlvKQ0KPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gIA0KPiArCXBhZ2VzID0gJmZvbGlvLT5wYWdl
Ow0KPiArDQo+ICAJLyogc3BsaXQgdGhlIGhpZ2gtb3JkZXIgcGFnZSBpbnRvIGFuIGFycmF5IG9m
IHNpbmdsZSBwYWdlcyAqLw0KPiAgCXhwYWdlcyA9IDFVTCA8PCBvcmRlcjsNCj4gIAlucGFnZXMg
PSAobmV3c2l6ZSArIFBBR0VfU0laRSAtIDEpID4+IFBBR0VfU0hJRlQ7DQo=

