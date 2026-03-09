Return-Path: <linux-fsdevel+bounces-79869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EzbCWwir2n6OQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:41:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B09512403E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9AB33037900
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 19:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326C83ED12C;
	Mon,  9 Mar 2026 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dAn9N0c/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D62FFDF7;
	Mon,  9 Mar 2026 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085176; cv=fail; b=nefDZ5eoHQIinaKWKAlKqy3qsnkJ1akenFNzS9cTN7cnudxPB6KV99hnpxA0+EudjA87MdMM/Nr/ZE0mqg373YH0YrhTNX3M6da/nA/0ABqfy9ay824hy7xHyYxlRRFNwQzJkZX1wvkTTua5Dgv4r5UVhNMlNNuHE25Q03zFXN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085176; c=relaxed/simple;
	bh=bEf/DQAqBgTNdYirxqE9pwH76rEHOw3fj1gnofv24HI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=i08W9f8bL0ZUpd+1QIs4K+6YVlQtUZhHFWs9VQQXNDX971jpehlrUeuS+7jKMbFqHmuUaoy2NbWfkgR+LHLRX5rtGh9auW9CvhKnU1YhEHL0wVbdWg2pIcmTumNkt7loo8aM6kbB6D4dOvjete0gJJgJ1pHP45NS9PaTgdRxm8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dAn9N0c/; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629F8mbg1268713;
	Mon, 9 Mar 2026 19:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=bEf/DQAqBgTNdYirxqE9pwH76rEHOw3fj1gnofv24HI=; b=dAn9N0c/
	pYL5Re8Sqeiz68HoDh2JMwZ4dQkj6A1DmnIRPPQjd0xfs0ozSciulRAhYVACass0
	KpOEIe/MnBF9pjFcrNnwC9WYxuNi3NQJQvApiQ5cWDmi+8kr8BQsHpKYMwnC+IEj
	rtBXhqeyCCRJwg/f0/q0ZwzE+RJFBZm4h57r6FUmpeFerMIUhFSJ5E8QvBbyjZdw
	dm/IYp2SMXam+AGs0UC8r1kOUU71aMYKVs3MxSeHM91ntlKq1REZuK9mXz5gYcTE
	sUdwtjHRlXIG8Hq1cPT84S4tGr7QEF6M9CQ6lqOBI3Fcf/35o8g6n9J8HzsyH6xe
	vVJL5wGIkC0PMw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mfu26-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 19:39:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OANQsIboG/SbLqWgbY5hSiCZEp1er4VPV7bQun1wQAisW7ABN/QwXuTLflbIEcfL2X/8SzGhx9CkyKMBZPWGrNFZ3P837P50d2fq9g+gTPw2pYsmG3yXoYyuoAWK8V7nCTZWl8VM0N7ZUEYHBpL+QsjgkqVHVFv297xaoJsA6BfjjQHIp/fYjVoreC8AqE5cpZMIB8xEmgKafZpHeu6y2S+CsZVsueSnzG5OHkpyblg60/cIwSLfXKn8F74He4xlCew4oVhUZEVuYV/nwE6Bx0bWZbhF8M+MQXsWOfgUHV/ZUB9Gl61ggLQlklf2fcSsXrP/0LtbEoLj/lBIDVG6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEf/DQAqBgTNdYirxqE9pwH76rEHOw3fj1gnofv24HI=;
 b=E0sU1DB9gThuQO6zVsOojinSCflKhNVxYuQCBekv05ws6ZnLj1cFpc7n7s+QBhQitttiKpyJf+fsQyleWZ7DsXMb4LEHonmYyGvBnrPxBlJb5ckh2X4qzvcs9WZFAB49+tX8o9THMmjimWTv4muTwrE1NtLaumUZ4vJ3+TN6VM/RmJDHueJXdIfc7PzF8lNELhFAOryw+HN1azyBU/74zJXBiPKbDj+f4LlmHThe9+7sXqP0HLle36cczsYqf7xFbPqV5AfyG0Z3Eya8cz2jOFwkjCz9v5L3gog4IX7PR024CdQTOdTZEzw6LkpAf402IGqvJqgE8G3YGKwLoggdVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LVXPR15MB7177.namprd15.prod.outlook.com (2603:10b6:408:37e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 19:39:22 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 19:39:22 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "janak@mpiric.us" <janak@mpiric.us>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re:  [PATCH v5 2/2] hfsplus: validate b-tree node 0
 bitmap at mount time
Thread-Index: AQHcr7p8A2rquoUAr0+folCk7KnMQLWmmWMA
Date: Mon, 9 Mar 2026 19:39:22 +0000
Message-ID: <777135e49c8f44f1f9a023d88be9a55b7acf2426.camel@ibm.com>
References: <20260228122305.1406308-1-shardul.b@mpiricsoftware.com>
		 <20260228122305.1406308-3-shardul.b@mpiricsoftware.com>
		 <4442aca3ca4745748a7f181189bd16b2b345428e.camel@ibm.com>
	 <66104cc5521c69a4745b894be307eec25333eb09.camel@mpiricsoftware.com>
In-Reply-To:
 <66104cc5521c69a4745b894be307eec25333eb09.camel@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LVXPR15MB7177:EE_
x-ms-office365-filtering-correlation-id: 42a2fd6d-4e9a-44b0-58d1-08de7e139047
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 XlOZfJRYq1+ceF8XHqzSK5hNQqL4mi2rKYy32UdGiCS+AObp7zHC7B60t4Uk4144Kzfor7OT6/lD9hXlsxQLQSL1/kwSR/NjkLhrjIbecXHapKmg1pLQqA4yzmvA16biEsmkq7V+5oZrC7qFy6ngQQWy2wdomreDF3CYLBpx6KFIEBu6Og2fFQmiuWVvCwqSrg4C4JyzTXr8+AdxrttfV0detG1qVbqGg4IZA8WblWz9SzyIvGETppVFaBb8VUTPmPczEChywfvS8yrtbEdeTr3GWQnIg7kvq8ThMxSpQpStPTELwjRdfSx7QNxVYb3D6/+ffZkwCH9HcYWt7b3MAxvq9xdsNWYER1hy41kHrRajh9TYOBfvVkgkfgSbkuoOigGDpbN9PYIo/Gt6+C+uTOHR7jjfTbl5537qObzJbLUdXan3gzYCVmaz3n5iGNm7U2ug/e5z1rAGNtpAmN9q+BRNXBKRZc74NpKlF+mN+cJFqRBjA18S6hShJtM3CmuAR0pSRL5h2BN7/8XA4XPSzKn/ftITD3Em7c0fWW33A7RcZIySkEDAcC2GUzTZWEb7U0Uc0GoYmKxiMEWXlaVFcI6CA2puW32s9Z58pGVOt/O7OapsypjchGmyNNnRJ+ZY/afx+RDJkh869rj/czmVFBiwMq3U2ueL7logb3oAkjdNCECk5Sno1y7rYamsH1DwlhUMtD80f/3ywfKtbE9ZK8XGb74lwccIb0m9ZYG+XhqaTpvZKIGBJdn6VrACc3FZAb1qsSg4DJ2TwfLg48MfmTBWbTtwiS2p1fTwml6tluI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWU0a1FwMHVRWEd1WlpZSlF6dHQvVWJyQlNpY3RIL1hYMXNGQ1BwNll5ZWNa?=
 =?utf-8?B?WjdiYlZTUXh6WGtZVDRnWmNOY2VxUjZHd2pjTzYvSHVvWEFyYldicFViRzJP?=
 =?utf-8?B?R2tFUk95dndsaDYzT3VIUVlxemg3NGxjcjFvY0lSZCtkWXBlU083aEovaHcx?=
 =?utf-8?B?U1k1bWtTK2d1OEVVTlBMQzJYekRBQ0RydDdsdm9KbzdpcmNYaGtGYjRvaVEr?=
 =?utf-8?B?NXorb0JOaWpQbUFMLzljZGdhMVFCY2VXaTlWRVhnQ2tmZDhlR2V4c3FxMmIr?=
 =?utf-8?B?d0xRQndWWUtsaC9BN25vR3RreXF5RDVKWjZnallUbC9RYWN0QXZZZTFHMCtR?=
 =?utf-8?B?RlpmbjB3aERSbXhaTm5EU2tCTVZVL3VSR0ZWVG1wNkdROW5MREJ2cEVGWk8r?=
 =?utf-8?B?VHYxYUhpclF4Y0VGUDc0dmQ5S0IwSlkzejhBSWlCZ3pRNEszS0cvbDRkWDBH?=
 =?utf-8?B?dkg0a2xvNmpMb1MzV2hEMFpLK3dTZmNyeDV5ZlBRSTVkRzFDNlA1emVyc0lH?=
 =?utf-8?B?QlE5cUlFdDBnaVFqbVMySWRxUFBxMkQ1cVdROW9tckl6UE5uSG5yT1A4bHBa?=
 =?utf-8?B?elZTL3NFUDN0QXUvWFlDakVrbEZkTmdQL1pkK0p5L2lUMDNGbXp5aGhFSzVq?=
 =?utf-8?B?bmhNU08xd2V0VXg4cWYzMHF1SStyUTdYSTFiSUkrYVpnZnZvL2FYMS9nSDZV?=
 =?utf-8?B?U25mRWJCYmlUZUdMa1hjZmNrWHU2TFBQd2h3NXFrK3M1OTRmUWVmM2xzKzB4?=
 =?utf-8?B?a3JEK05LNXdkRFlkdUltRkYyVGNOVnRWVkY2SWkxVkJFZERya0FhNVUrS1pm?=
 =?utf-8?B?QU8xYzVnUm11UjNwRS84WmtBMVJnYjZiVWtGL3cvc0c1YUlZTms2eTMxWGlv?=
 =?utf-8?B?dUpueVZqc1NMdUhmVDZsQzNGK0VVRVdlMFBOanBWNS95Z0J5ZGlHeWRjbWtN?=
 =?utf-8?B?ektEZklBZnpFdzJ1TWRjYXlobG84TWZGTFQya09ZZUNLcnFtRzBVd3BUWVBW?=
 =?utf-8?B?M05GbWY4QXA0bS9GNnRMYlVEb1Z5a05JME8wSUZNU3ZlWjZhMlp3aFNCaG1a?=
 =?utf-8?B?V0dKM09XY1dFdlJEV0QzdGsyRmZkc3BIeWNlVlUxdDh0RTh3NnlhbGNPSUk5?=
 =?utf-8?B?R2lOOVRMUWJkWXo5LzZjdHFjOGZtbVVaQmxldXU3YjJIMUtoSmNJMllSaHlQ?=
 =?utf-8?B?Q0hOcTdkN0VRREdKL3RjQjNaTWNDRUlrQnZodm40Skk4Wm1ySVRCTFNPcUJU?=
 =?utf-8?B?a3JRZ2kxWXlNcUVRTTM2Y1JkV1VFOWwxNGdyVTBWUGVxdVpBZjQxeUNxNnlL?=
 =?utf-8?B?R3RGbDRpTXI5aWFwVUxyTE83OC9jYWNuTEdVNEZzWjVNNngxMyt2c3J3Q3Bm?=
 =?utf-8?B?UXdNd1IvY2NkbnNOYzdPL2ZMbnplZ084ZTJrcFNyTnlIWU9kcjBCcUdudTFL?=
 =?utf-8?B?eU5XWm9tSk1FcnljZWQzd3VsUHVXUDdHd3RXMnRnMGN4K2d0VnBCcHd2MGs4?=
 =?utf-8?B?NnB0VTRMaVBxTHkrQ05IUG5pVjJzdW1rOXA3aXJhN3MxOW12MWZ3OVVuMERP?=
 =?utf-8?B?RjF1VnE2RmlHMitKdWpJd3YzZEw1V2lrVnhtcXVDWnNydjFZYzlnN253bDBF?=
 =?utf-8?B?bm83MUk0UW0yTXM0QiswZ0xVeU4rV211d3ZpOUVxZE54VkM5cEFDTC9zemRW?=
 =?utf-8?B?MDU0eFQ4bXpoZUhIWkpZeVBZTVZucnJSOHh3Mk9uWkRnMTNxb2UvY0VxMFBp?=
 =?utf-8?B?bFQxNzVlVmFBeW82VytRcHdteW9IQW1vbTVkRENIQndCZFY5VURhUnpNN05B?=
 =?utf-8?B?OXhPdmVKVStvSzVnSEpXNkxDcHdOVm1Rd2ZDeHZRdlBmQWhkZGIxZm5TTEdQ?=
 =?utf-8?B?QWNPdVpqVHcxMlFPVVZNWWdJWktTSmtUV2VZejNXRnQ5WElMeXFmZXErSTBj?=
 =?utf-8?B?QVRocGdrUFI0SVhleEQ1OTlSS0NRa2JobHNuUGhpa2ZxaFJlLzVjT1BLVThG?=
 =?utf-8?B?bm1NUlBTMjF3dnlqNHRsRi80eFQvS3hVaWVYVkoreHJWaUJWaGtmV1JFR3hR?=
 =?utf-8?B?NlVpdUo2S3Rrc1lra0hvMm9Mb2I3TGZVMTFKWE5KckltMUcvZWVtaTFaZVMy?=
 =?utf-8?B?dDRkb3c5UE9iTEUvbytLeE90ZWllQ0JWUE1JQnNCZnZzNHhzcmhUczZkMUhn?=
 =?utf-8?B?UFFrM1FEQUxrd0JzVEdrSmFOTHJXcGpKU1Y1VUYwSnBDSkFpd0RtR2UwZ0xM?=
 =?utf-8?B?REFCUXhBaW1TV1Y3bFFWeVJrUG9ZTmR0bjJBU0JDSFU3dmt3WjJHcEltZGZa?=
 =?utf-8?B?eHg0eXZmTDBRNWpreGJCb2VXUTZBd2JHT3I0MFJ2SUJLNzBBR0FiRjM4VkFi?=
 =?utf-8?Q?MBCkdyOwTWxZHBSW4gLBFaYwHQ7xLj/8c/axY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA219843C392734B9D2A5C52AF77AA94@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	cfsApZDtOjNFWEcw95s6Iqixr96DRt2C9c5951PvMqaVY26PAOmLRzfTfyE9DdDEHSgka3Pic+LiONM1gnkeG8OqtpAWqG2qQi3KOJyK5ty7dLBzpz75ol4tt2jCHzrmxtFhl5JszG7ZC2WM4u+8AmjXPDDPUE3G+ylF/XXWV0LdUVkymwr5Fl8/7ke7mUQGH2bzZb4bRlL7sJp5Z61eFNOhv++M2FBRI4tknrczkRaycpmvYvrYM7+GTjXYL3waKiazXAIQeQwmsszTAzhmkcyz5bfJXAdF2ZEvtvend5YYDLVil2rRVOkI1qxL8DQI4YBfkKeEM0/1+PmuclybrQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a2fd6d-4e9a-44b0-58d1-08de7e139047
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 19:39:22.2625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2nky/wlN9GFUQzrYe6QN5E1YfwLQMKBFskUtSftRzKtGcxO/Uq0p9/DVtDXD+BjjoRcNUyPylbjE2tXuUsCDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR15MB7177
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69af21ed cx=c_pps
 a=8TTB3MyXo5LrYHl2kKBanA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=zidGryzhAeLWLxBYUvkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE3NCBTYWx0ZWRfX59rWdm3AKrEC
 NTn1qNnSoIgEso9kU/MGhY+tklb66LFIbAF8OkWDY4cD3XgDh1Y4pQW0VGVYw3tF4wlWI+vU1DY
 XcxAReFEBYv+Upe48VHHOMFRs4KCtm1aecsvQKosfd5nXLLGxnn215dg7TQcTQ8ZgyFFw1F3T7E
 /ODdPMNwbXkEzDJKBglAuPzL9V1TFIn1Bn08C4Y7NHS7TwWbKaDSiVbLYQI7RoMgLPF3nGhWy2J
 uSrWJBxhB0h2aY6qo5rtW+YNlGV3OBBNxrpN2iNpMRwmEP7dtw1eRd4C1I6a/hwP+E/vYKz0QPf
 KDq3e/U4z2+TLTIo35LNFNcz2kRf1ETexttZgRKyQaEWh/SEqSV7CXQg8y/XtGAXdvd+iBCZhVN
 S1lt9SpH8/0rhwVcYmR/WpnC3pg8IOs1sRZe/jjsmmwhSgwgIu1PLgNbAhei2RBIm6JrO9mbvxE
 Brt87dFbCAf5u5Su1xA==
X-Proofpoint-GUID: cZCPu3UdWE0zagOFUvDS0fY0Z5RnpIZn
X-Proofpoint-ORIG-GUID: mFkIqxaCr4gpAwvtIOtLbFRu-K7nCCNF
Subject: RE:  [PATCH v5 2/2] hfsplus: validate b-tree node 0 bitmap at mount
 time
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090174
X-Rspamd-Queue-Id: B09512403E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mpiric.us,mpiricsoftware.com,gmail.com,syzkaller.appspotmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79869-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAzLTA5IGF0IDE3OjE2ICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gT24gTW9uLCAyMDI2LTAzLTAyIGF0IDIzOjQ1ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gT24gU2F0LCAyMDI2LTAyLTI4IGF0IDE3OjUzICswNTMwLCBTaGFyZHVsIEJh
bmthciB3cm90ZToNCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL2J0cmVlLmMgYi9mcy9o
ZnNwbHVzL2J0cmVlLmMNCj4gPiA+IGluZGV4IDg3NjUwZTIzY2Q2NS4uZWUxZWRiMDNhMzhlIDEw
MDY0NA0KPiA+ID4gLS0tIGEvZnMvaGZzcGx1cy9idHJlZS5jDQo+ID4gPiArKysgYi9mcy9oZnNw
bHVzL2J0cmVlLmMNCj4gPiA+IEBAIC0yMzksMTUgKzIzOSwzMSBAQCBzdGF0aWMgaW50IGhmc19i
bWFwX2NsZWFyX2JpdChzdHJ1Y3QNCj4gPiA+IGhmc19ibm9kZSAqbm9kZSwgdTMyIGJpdF9pZHgp
DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+ID4gPiDCoH0NCj4gPiA+IMKgDQo+
ID4gPiArc3RhdGljIGNvbnN0IGNoYXIgKmhmc19idHJlZV9uYW1lKHUzMiBjbmlkKQ0KPiA+ID4g
K3sNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgdHJlZV9u
YW1lc1tdID0gew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFtIRlNQTFVT
X0VYVF9DTklEXSA9ICJFeHRlbnRzIiwNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBbSEZTUExVU19DQVRfQ05JRF0gPSAiQ2F0YWxvZyIsDQo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgW0hGU1BMVVNfQVRUUl9DTklEXSA9ICJBdHRyaWJ1dGVzIiwNCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoH07DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAo
Y25pZCA8IEFSUkFZX1NJWkUodHJlZV9uYW1lcykgJiYgdHJlZV9uYW1lc1tjbmlkXSkNCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gdHJlZV9uYW1lc1tjbmlkXTsN
Cj4gPiA+ICsNCj4gPiANCj4gPiAjZGVmaW5lIEhGU19QT1JfQ05JRMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoDHCoMKgwqDCoMKgwqDCoC8qIFBhcmVudCBPZiB0aGUgUm9vdCAqLw0KPiA+ICNkZWZp
bmUgSEZTUExVU19QT1JfQ05JRMKgwqDCoMKgwqDCoMKgwqBIRlNfUE9SX0NOSUQNCj4gPiAjZGVm
aW5lIEhGU19ST09UX0NOSUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMsKgwqDCoMKgwqDCoMKgLyog
Uk9PVCBkaXJlY3RvcnkgKi8NCj4gPiAjZGVmaW5lIEhGU1BMVVNfUk9PVF9DTklEwqDCoMKgwqDC
oMKgwqBIRlNfUk9PVF9DTklEDQo+ID4gI2RlZmluZSBIRlNfRVhUX0NOSUTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAzwqDCoMKgwqDCoMKgwqAvKiBFWFRlbnRzIEItdHJlZSAqLw0KPiA+ICNkZWZp
bmUgSEZTUExVU19FWFRfQ05JRMKgwqDCoMKgwqDCoMKgwqBIRlNfRVhUX0NOSUQNCj4gPiAjZGVm
aW5lIEhGU19DQVRfQ05JRMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDTCoMKgwqDCoMKgwqDCoC8q
IENBVGFsb2cgQi10cmVlICovDQo+ID4gI2RlZmluZSBIRlNQTFVTX0NBVF9DTklEwqDCoMKgwqDC
oMKgwqDCoEhGU19DQVRfQ05JRA0KPiA+ICNkZWZpbmUgSEZTX0JBRF9DTklEwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgNcKgwqDCoMKgwqDCoMKgLyogQkFEIGJsb2NrcyBmaWxlICovDQo+ID4gI2Rl
ZmluZSBIRlNQTFVTX0JBRF9DTklEwqDCoMKgwqDCoMKgwqDCoEhGU19CQURfQ05JRA0KPiA+ICNk
ZWZpbmUgSEZTX0FMTE9DX0NOSUTCoMKgwqDCoMKgwqDCoMKgwqDCoDbCoMKgwqDCoMKgwqDCoC8q
IEFMTE9DYXRpb24gZmlsZSAoSEZTKykgKi8NCj4gPiAjZGVmaW5lIEhGU1BMVVNfQUxMT0NfQ05J
RMKgwqDCoMKgwqDCoEhGU19BTExPQ19DTklEDQo+ID4gI2RlZmluZSBIRlNfU1RBUlRfQ05JRMKg
wqDCoMKgwqDCoMKgwqDCoMKgN8KgwqDCoMKgwqDCoMKgLyogU1RBUlR1cCBmaWxlIChIRlMrKSAq
Lw0KPiA+ICNkZWZpbmUgSEZTUExVU19TVEFSVF9DTklEwqDCoMKgwqDCoMKgSEZTX1NUQVJUX0NO
SUQNCj4gPiAjZGVmaW5lIEhGU19BVFRSX0NOSUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgOMKgwqDC
oMKgwqDCoMKgLyogQVRUUmlidXRlcyBmaWxlIChIRlMrKSAqLw0KPiA+ICNkZWZpbmUgSEZTUExV
U19BVFRSX0NOSUTCoMKgwqDCoMKgwqDCoEhGU19BVFRSX0NOSUQNCj4gPiAjZGVmaW5lIEhGU19F
WENIX0NOSUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMTXCoMKgwqDCoMKgwqAvKiBFeGNoYW5nZUZp
bGVzIHRlbXAgaWQgKi8NCj4gPiAjZGVmaW5lIEhGU1BMVVNfRVhDSF9DTklEwqDCoMKgwqDCoMKg
wqBIRlNfRVhDSF9DTklEDQo+ID4gI2RlZmluZSBIRlNfRklSU1RVU0VSX0NOSUTCoMKgwqDCoMKg
wqAxNsKgwqDCoMKgwqDCoC8qIGZpcnN0IGF2YWlsYWJsZSB1c2VyIGlkICovDQo+ID4gI2RlZmlu
ZSBIRlNQTFVTX0ZJUlNUVVNFUl9DTklEwqDCoEhGU19GSVJTVFVTRVJfQ05JRA0KPiA+IA0KPiA+
IFdoYXQgaWYgY25pZCB3aWxsIGJlIDEsIDIsIDU/IEhvdyBjb3JyZWN0bHkgd2lsbCBsb2dpYyB3
b3Jrcz8gRm9yIG1heQ0KPiA+IHRhc3RlLCB0aGUNCj4gPiBkZWNsYXJhdGlvbiBsb29rcyBzbGln
aHRseSBkYW5nZXJvdXMuDQo+ID4gDQo+ID4gSXQgd2lsbCBtdWNoIGVhc2llciBzaW1wbHkgaW50
cm9kdWNlIHRoZSBzdHJpbmcgY29uc3RhbnRzOg0KPiA+IA0KPiA+ICNkZWZpbmUgSEZTX0VYVEVO
VF9UUkVFX05BTUXCoCAiRXh0ZW50cyINCj4gPiAuLi4NCj4gPiAjZGVmaW5lIEhGU19VTktOT1dO
X0JUUkVFX05BTUXCoCAiVW5rbm93biINCj4gPiANCj4gPiBQcm9iYWJseSwgc2ltcGxlIHN3aXRj
aCB3aWxsIGJlIHNpbXBsZXIgaW1wbGVtZW50YXRpb24gaGVyZToNCj4gPiANCj4gPiBzd2l0Y2gg
KGNuaWQpIHsNCj4gPiBjYXNlIEhGU1BMVVNfRVhUX0NOSUQ6DQo+ID4gwqDCoMKgIHJldHVybiBI
RlNfRVhURU5UX1RSRUVfTkFNRTsNCj4gPiAuLi4NCj4gPiBkZWZhdWx0Og0KPiA+IMKgwqDCoCBy
ZXR1cm4gSEZTX1VOS05PV05fQlRSRUVfTkFNRTsNCj4gPiB9DQo+ID4gDQo+ID4gT3IgaXQgbmVl
ZHMgdG8gaW50cm9kdWNlIGFycmF5IHRoYXQgd2lsbCBpbml0aWFsaXplIGFsbCBpdGVtcyBmcm9t
IDANCj4gPiAtIDE1Lg0KPiA+IA0KPiA+IE1heWJlLCBJIGFtIHRvbyBwaWNreSBoZXJlLiBUaGlz
IGxvZ2ljIHNob3VsZCB3b3JrLiBCdXQgSSBwcmVmZXIgdG8NCj4gPiBoYXZlIHN0cmluZw0KPiA+
IGRlY2xhcmF0aW9ucyBvdXRzaWRlIG9mIGZ1bmN0aW9uLg0KPiA+IA0KPiANCj4gSSBvcmlnaW5h
bGx5IHVzZWQgdGhlIGFycmF5IGJhc2VkIG9uIHlvdXIgZmVlZGJhY2sgZnJvbSB0aGUgdjQgcmV2
aWV3LA0KPiB3aGVyZSB5b3UgbWVudGlvbmVkIHByZWZlcnJpbmcgYW4gYXJyYXkgb2YgY29uc3Rh
bnQgc3RyaW5ncyBvdmVyIGENCj4gc3dpdGNoIHN0YXRlbWVudC4NCj4gDQo+IFRvIGFkZHJlc3Mg
eW91ciBjb25jZXJuIGFib3V0IHVubGlzdGVkIGluZGljZXMgbGlrZSAxLCAyLCBhbmQgNTogSQ0K
PiB0ZXN0ZWQgdGhpcyBjYXNlIGxvY2FsbHkgdG8gYmUgYWJzb2x1dGVseSBzdXJlLiBCZWNhdXNl
IG9mIGhvdyB0aGUNCj4gY29tcGlsZXIgaW5pdGlhbGl6ZXMgYXJyYXlzLCBhbnkgaW5kZXggbm90
IGV4cGxpY2l0bHkgZGVmaW5lZCBpcyBzZXQgdG8NCj4gTlVMTCAoMCkuIEZvciBleGFtcGxlLCBJ
IHRlbXBvcmFyaWx5IHJlbW92ZWQgSEZTUExVU19DQVRfQ05JRCBmcm9tIHRoZQ0KPiBhcnJheSBh
bmQgdHJpZ2dlcmVkIHRoZSBidWcuIFRoZSBpZiAodHJlZV9uYW1lc1tjbmlkXSkgY29uZGl0aW9u
DQo+IHN1Y2Nlc3NmdWxseSBjYXVnaHQgdGhlIE5VTEwgYW5kIHRoZSBrZXJuZWwgc2FmZWx5IGxv
Z2dlZDoNCj4gaGZzcGx1czogKGxvb3AwKTogVW5rbm93biBCdHJlZSAoY25pZCAweDQpIGJpdG1h
cCBjb3JydXB0aW9uDQo+IGRldGVjdGVkLi4uDQo+IA0KPiBUaGF0IGJlaW5nIHNhaWQsIEkgYWdy
ZWUgdGhhdCBkZWZpbmluZyB0aGUgc3RyaW5ncyBhcyBtYWNyb3Mgb3V0c2lkZQ0KPiB0aGUgZnVu
Y3Rpb24gY29tYmluZWQgd2l0aCBhIHN0YW5kYXJkIHN3aXRjaCBzdGF0ZW1lbnQgbWFrZXMgdGhl
DQo+IGRlZmluaXRpb25zIG11Y2ggbW9yZSB2aXNpYmxlIHRvIHRoZSByZXN0IG9mIHRoZSBzdWJz
eXN0ZW0uIEkgYW0gbW9yZQ0KPiB0aGFuIGhhcHB5IHRvIHJld3JpdGUgaXQgdXNpbmcgdGhlICNk
ZWZpbmUgYW5kIHN3aXRjaCBhcHByb2FjaCBleGFjdGx5DQo+IGFzIHlvdSBzdWdnZXN0ZWQgZm9y
IHY2LiBMZXQgbWUga25vdyB3aGljaCBhcHByb2FjaCB5b3UgcHJlZmVyLg0KPiANCj4gDQoNCkkg
dGhpbmsgd2UgbmVlZCB0byBkZWNsYXJlIHRoZSBzdHJpbmdzIG91dHNpZGUgb2YgdGhlIG1ldGhv
ZC4gSSByZWNvbW1lbmRlZCB0aGUNCnN0cmluZ3MgYXJyYXkgYmVjYXVzZSBpdCdzIG5pY2UgdG8g
aGF2ZS4gQnV0IEkgbWlzc2VkIHRoZSBwb2ludCB0aGF0IHdlIGRvbid0DQpoYXZlIHRoZSBjb250
aWd1b3VzIHNlcXVlbmNlIG9mIGluZGV4ZXMuIEJlY2F1c2UsIHdlIGhhdmUgb25seSB0aHJlZSBz
dHJpbmdzIHRvDQpkaXN0aW5ndWlzaCwgdGhlbiBzb2x1dGlvbiBiYXNlZCBvbiBzd2l0Y2ggbG9v
a3MgbGlrZSBtb3JlIGNsZWFuIGFuZCBzaW1wbGUgb25lLg0KRG8geW91IGFncmVlPyA6KQ0KDQpU
aGFua3MsDQpTbGF2YS4NCg==

