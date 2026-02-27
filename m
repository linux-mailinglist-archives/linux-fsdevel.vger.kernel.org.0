Return-Path: <linux-fsdevel+bounces-78799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHNsB6kXomnFzAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:16:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E781BE996
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8771331A6F36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230AB3815F3;
	Fri, 27 Feb 2026 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kcl5aGP6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3700478878;
	Fri, 27 Feb 2026 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230253; cv=fail; b=aMy40DM8QRLlsbuOAXLHtcBnMUSGBdGcRqb8aLQziTytyWSdklwMhzVLEaGBYovP+rFyJEGicjh/MoKQCLDmWQpkIzAi6OfMUHDs42OYHEnni2fZ9KQJV3tolRcyWZMnWLea8cUcH+Hd2D9hpNLl2QsHiu27SANljpOg8l6eVxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230253; c=relaxed/simple;
	bh=91AZMrQYNMaS5+rjuRg+N5Ab67R2ou8hEf2hBrTe7g8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=iNQrQ82T3TwAkQzfUYEiwNmlXPE7YrMYx4KVI2sAOp/EIKGy1jkTmS1+hOOmVaX4CIXqY5iKYtgHrdL6n/Lv9B2tRqLs4vSp7FSQNGBPECps5BfD0y1WPnOY8+hpyJ2GG4jH10yQQdmUuTE1uoSeZTyWqI7DAYBer8HKl3VixG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kcl5aGP6; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RC8sGG1020989;
	Fri, 27 Feb 2026 22:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=91AZMrQYNMaS5+rjuRg+N5Ab67R2ou8hEf2hBrTe7g8=; b=Kcl5aGP6
	M21NPhUC+yVUaKKm7wpF1Wx9HJQyDmL1V2PxR7XkgcDBYPeST5nAoYBFX8mVIco3
	UwlJFMyP1KBFp0DdS0JBqjspkPgb645gFTXaL8IMWKwZhzGWdYC8u1TRcqzxFGEC
	XAkpgoBCIi3h3i3ZtM7YvrgVECOSFmoelP7Hr7OHiaFuaH1fbs35xR0oVe+3vbCJ
	/wXjFQkV13+jAyBBJ4+6t05iLXGVokb/VIX8KVDfxtmvB9y4HLz65U9LLtP8PMZM
	93p4y3mpah9kJ39WKDsklyYGVA7/MohG7hFCSuoZ4TXPbE8KGy2GcPdXJ2a7VqEa
	eOda0qHir4gAYA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf472euxf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 22:10:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDXV9UqBKhlmZujjlnzhhF/nz/pzF1ci1GQ6U/667IH432VsGj8biubAXFKwooat6RZbn8hK2eU00R+xg7egBz+82VAKXk30pVjkPgP5x69IoSBvBuubu0syVFBPyoHY5yqANMq0+BBn+sSHQD7fzbUtyXgO9Z80q+bUTL4DEo2WjifsFHAfMQSubnPp4A1TztxW6peci+0yytB4qeFZb0pVTWFO89uZV3yXxHbI5Efuo3Mn4/EtI2cpolv8CXWTU19H+CR1p5/rLmQh1+U8eyM0DzVsyJMfg1zxfuDIZCuE4j3Yq4Bfi+PV33odQVQIwLecQedR1UZ3GyW3tDifCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91AZMrQYNMaS5+rjuRg+N5Ab67R2ou8hEf2hBrTe7g8=;
 b=QOf9nkFPBAPzHCb4jhHvc8557DVjgtvQ67Vsru3da7wKfEHe0Fd0Kdn0FMuWLmo5w9sBcqsSJFRyqu/UwZP9Wfm5uf0Lt5keS0QAFnNwjJ1I4rj/w+MIU4KB/Rn6aisXvFl47GkpJDj+wLNt+ajsnmZKgsTIEQxkBf/uSXLciQWp+uI0mtjEyWHMJfl9jtzuZp4rrw7aSLclUnI3b+8d7IV0CeFuShQu1h8hJ2FAxqTsiDVpMWEN6aDk01vTORn3FbmOjCQSkKTtCCEHh75y2AwnRY+HCF4jMW530OpoxkkJHDdWM0ORNxoYp1KNO0TZBqEWLi2ugUBGJ9W5zQ66gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB6186.namprd15.prod.outlook.com (2603:10b6:8:115::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 22:10:32 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 22:10:32 +0000
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
CC: "janak@mpiric.us" <janak@mpiric.us>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re:  [PATCH v4 2/2] hfsplus: validate b-tree node 0
 bitmap at mount time
Thread-Index: AQHcqAtELWTmExdlbUe6qP6CB129A7WW+mIAgAAfMQCAAAIcgA==
Date: Fri, 27 Feb 2026 22:10:32 +0000
Message-ID: <6d17f7581696c43119d87b9a2dcea4fe09bcc865.camel@ibm.com>
References: <20260226091235.927749-1-shardul.b@mpiricsoftware.com>
		 <20260226091235.927749-3-shardul.b@mpiricsoftware.com>
		 <5deb0aa2971a6385091c121e65f0798de357befd.camel@ibm.com>
		 <7d3c9221cc49a47779606d8c67667544f27de2df.camel@mpiricsoftware.com>
		 <9f6e83c657586caa86483db77df401a67f903361.camel@ibm.com>
	 <7194aa49efdb85c7cfc9578f1460aaa9a1c67095.camel@mpiricsoftware.com>
In-Reply-To:
 <7194aa49efdb85c7cfc9578f1460aaa9a1c67095.camel@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB6186:EE_
x-ms-office365-filtering-correlation-id: 921a0d40-492e-4ebc-2820-08de764d063d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 QIHPCaWKMJhdJc26NYgqu0R5yX38caafL5wwIOebwsxMUQdsrX7g1ffYQgWtFayjN8IlMsg1nVaMPXEf8PiYHL+eQABCcTbt4dOfOB3XfRAlS3h/nMQPx36mWwb5I3LM3zn83ciENz1Z8VQicJR6hqefIZXOE6sK3KCdWMzbZoJY02/k38qUB16Lk4cPFjTp2DeocXT8N7jm3+VtYqXSCew4Lyl26Zb5Hlat8VbKOPcrwSGHxy4y6YQkKHdAgawgJGCd6KaAGY29vU4utKPqrclSd4nKoXIrpZi+OWFkmQRXm3yzBfcFIFxypbfpnJ93MagvoErVPnGJShuY2JgQyJYu23XoknhfcmwtHP3R1JI2/H6uQCq3XZYW8emXwxo6BsRDUExV7Bg740AnE0Yr2I9buNeW8OgVNA0IVRVDi9pDu7usKu7OXaNh75Y6w/MqJhlS1ztfYIa120U0t4vCnMKMBB/lzYj7erUdTe9Bt4YaU6G1ZuTT9ogHUvDcY4NaJxXZgFgH4B8+1prTcG19cidxZknLjsUgXFaASGL5c6qq/kHIYSRpZ+K2CqYL47jhv+Npxx71ws6HsSSDWG9V9cE4FpAs1eOWoyM/4UsClHobYeoqIVMtw60BfOl8UdCLSsGV51EHtkAC0Cv6MM5akSCos1ICjSNVr2ve23J32WWGSnvbdXeA0yX4ButCH8TjbDrKyKV6WT67ZiZ0/sRz7hSp8hkgr5TjHjqMlufsb+4K1GoOaYtN4Zpp+QXklLPX+jr3SDh8OSQD2Ie670EZjA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXJUb3lGdXVsMVlPQ1lUVWlGWWpDaTZVL0xtYXU1RXgzUDgySlpZeGtuS1Fo?=
 =?utf-8?B?V2w0T2xyR3lRKzcyN011b056c0Q2MEJwRnh6S0luczR0T0dkWHRwQm9MaXNo?=
 =?utf-8?B?alBsdG84cTB4bkxpazBBR3lURmpUaU1jZmR0dlJYMUpiMkVpbFJUVHBaK1I2?=
 =?utf-8?B?Rk8zOWIxSzVadGRDQUFiNmE2a3lsNTJkYjdmQ2FSbzdtTnc3UDAzbkRWQmFD?=
 =?utf-8?B?dDhhY2FyVnljdnV1WmppZzNBaExMWEZIeWJ2TzNOZWNQUnl5d3dSS2c1dlpi?=
 =?utf-8?B?dGx1aDhOK09DSVN6WGN2QnY2M0Jka2YxTkhoK3JVTkhwZERJU29QWHB4QjI0?=
 =?utf-8?B?allhek9QeS9tcFZMMjNpbWZ2ZzA3MmpiRFl0UzZ2QjV6WU9lNkJlVC94L1Rk?=
 =?utf-8?B?Z0RnSGdEUUxBZFlGdUxZUzZsellmT2NYbnhPdFA3c0U3S2pPNVZlT29MMWJ1?=
 =?utf-8?B?RUVQVmhRdW5wOElER0pNbk02VmRlTlhHZk1iOENKc09pTjFIZ2FYbTJJeFdN?=
 =?utf-8?B?Z1VxRUwrTkRsbHduMVpSZ1dCVlRabFJyNW9tVERIQjZyRWZKaGFhVzZndkY4?=
 =?utf-8?B?eDhlc0sycWZEQmVERE1Ldm5UbGFsQU0wRDNjS0oydjNGQnB4OXloUkFaSVA5?=
 =?utf-8?B?RDlPREdMYkpFRklrcWd0VU1mazl4RERQVm1NaFNBQStWangyNW5QUFRsdnNS?=
 =?utf-8?B?dXJxWFh5LzdMUWs0emttb1ExZzRyb1F5dFp1NVJTYXg2OHNpWTQ4aFZkV3dN?=
 =?utf-8?B?V2dNTXJ4Z1JTc2NvbVA3S0h0MERjQ09iRG9rQlpVSCtOV1VSOTR5VE5hdzdX?=
 =?utf-8?B?WTRGU3RQMkg3R3pieDlWVzZBWENUWUlBSE96MkhwVHhINnNKcGE4ZVR1TGFE?=
 =?utf-8?B?Si9lM1ZFdkNHRmVYbExzYkIrVVBvZ0lwQVlaYnFzMWJwcC93ZkIzM0FFYkp0?=
 =?utf-8?B?aEZrMVFLZG1VYkZKMEphM3NBZCtHeXdpLzVrN3prSXVTSWU4YmwyVlNaS2FO?=
 =?utf-8?B?ZmNCZUt5R3I4cEV4UlJUYVVvajliQ2sxa1ZkZXBXWHU0eFZCYkozVHJNZ2k5?=
 =?utf-8?B?WWVjMXBDTC9SRnBRbm45RWF6ZFlLbHhmK1JBdHp2YWtkd0x3ZEpTV0lqbkZ2?=
 =?utf-8?B?M0F5SzdBLzhGWDdKREtLQ1Z4aU1IczhDQ1A0MnBNM2ZUeERiczVxN1dhb0ZD?=
 =?utf-8?B?eXVQajBXTElSTUt0ZjFhMzNuWnRlS1o5R2JZSnhlTlgvcDdTU29ka2VMcXNx?=
 =?utf-8?B?RmVxMWpkOUpvMnphWG94ZjhMWFRucUt6K0VLb3JFV1lhZHRSRzRhWVhGbS9p?=
 =?utf-8?B?N0RqcmJ1MS9zWnZwYkZlNU5CcnRhMytBbzRLZGlCcWpEWEswbmN3U203dlUy?=
 =?utf-8?B?Y1VVcmpkckpROGJLZXExVHJtWjhyeVIrZFluRytCeDhwKzRsQnBJbzZsZStN?=
 =?utf-8?B?UXdWa0hvYjlWQlJLNHJVcFBqdjRQZUIyaTVya1BtQlgyRFIrdkhEbzdKdm5U?=
 =?utf-8?B?bDF5NWRhU3JCQzZnQjRpOU1WcjZoMUNPcVMxY1dEb1FHanZvYVhsbnpBZmJq?=
 =?utf-8?B?bXhTZmo4cXpHMWZnMjgxeXltOG9UcFg1Z0VPcHVnN1JVdlcrVVRLZ3d6VkNX?=
 =?utf-8?B?bEFVbzBKeDl6cEFscDdOTDBtVk1ucU9HTTdzR2NBZXcwUnJWSllGQ281ME5E?=
 =?utf-8?B?RmJXRWlDL05hVlRmK21hSFIvL2Q3OWRRN0JTcGpDc2dSbDJTOW1aOS93MmVK?=
 =?utf-8?B?VUc3aXhGL0RpM0JlRmdqNE5vTEVlRUYyMjNPWDZmRVFmS2JOc0Z0d2xaRWVW?=
 =?utf-8?B?NFozRG5naWdXdVUzRyt6RkNNZUErQVlpaUVWWk85TmgwNXM5eTZzZG50bEwv?=
 =?utf-8?B?d2RrUlZvaUtaZkh3T3FaVnpWbjQ1eU5IRFNJRnJQLzhuTVpwTDFYZEQ1R0p6?=
 =?utf-8?B?bnBTRU5YU2J2WmFacVpRKzNPSkw2dGlWZ0ZOL21nVXB6eFBIZ0cxU2VHTmF2?=
 =?utf-8?B?eFBKWTl2MGdmdHQ0QW04RnliU2dycEZlSXFQSW9BZVdGYkZwcDFrb2FHeFU1?=
 =?utf-8?B?R2xqR3pZTVNPSFdsVEFITU5CU2lMdUZpQ0RpUjdHNWx3eGFRQ2drdEZBRWFa?=
 =?utf-8?B?a2UzYWw3WkxSY2g5WHBLWE4rQjVxR29vM2dtUURSV216emM3aTVSSXZmMnVO?=
 =?utf-8?B?L0x1S1BYVnVXMEtjTlNBWmZRalhRaUNwS1lsWUQwM2lsemlMUFgybmdrNjAr?=
 =?utf-8?B?S05WSitDWHQvRU0vbnJaZ0ZtMUZvWnVQNEVqS0VQZ21XVDFyd3NVN2VUWmNa?=
 =?utf-8?B?M3lkUWM1WmdiQlFtVGpoUGdoU1B3Vk9xNW45dVJyOEpUZVp6RzhqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F333356FDDC61A4B9E3B6872DAA104A0@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 921a0d40-492e-4ebc-2820-08de764d063d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 22:10:32.1164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHjerD60gsz0eWQZ2v52icabxc0Y8BDLXZ+R6o5QbUiu0ykthtStq1wL9CtNJIgOJng9OEOgSwdARFCrIELzxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6186
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Ooym0yQzZPnnPqXtxU6MwasxlprEELCU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE5NyBTYWx0ZWRfXxjokj0+suJO6
 uaitovxfwdtEauBggSe8BlZaeqoENwT/9MHhPVncSiv7cfn05JN1UdxC1O7ZlJlmJXJbrft5f3d
 gNWvAxxSjsxqpLQgv9u/Gu1C71zI4Mkn6LFQkgEflGutFrerOKc+BPhtOUUoYsxFP58EVtgctuO
 C8nl2CuGA1WrLLCyNoTz9PDYlVH0SR5XAc9CmWyE0SbiBibcYneMLVm6KMie3ZBVmi2BCu9BuS6
 0p1onnJkUSTJ9Ts//w8tobsIx5O/exfDYA8S8jHsqiZpysmR5GKjctzUmrNqw9vIq95avvuUVgn
 UHddspUq80E6uuknvDTYKQUqL58JfrJv0+2pshAUEXQ3QVKK3Fq+7cW/DP6LtKLU/9+D7jj6fHx
 mR4TW/fakOnes8PcI+vbN9xO3macrd36B6B6M4RRnJlW2VmIo4qcu5N9Z8zwP4olpc6kefOczwQ
 0fAtGeP66dyN5ezgOdQ==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=69a2165d cx=c_pps
 a=AqWYtYKdvuqIQX7AE/aD9Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=m7wWXtlxBDzQB3skZ6IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GXQueDgnD8dN0Kz-SfNVbapvV8aDShNb
Subject: RE:  [PATCH v4 2/2] hfsplus: validate b-tree node 0 bitmap at mount
 time
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270197
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-78799-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 96E781BE996
X-Rspamd-Action: no action

T24gU2F0LCAyMDI2LTAyLTI4IGF0IDAzOjMyICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gT24gRnJpLCAyMDI2LTAyLTI3IGF0IDIwOjExICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gT24gRnJpLCAyMDI2LTAyLTI3IGF0IDIyOjM0ICswNTMwLCBTaGFyZHVsIEJh
bmthciB3cm90ZToNCj4gPiA+IE9uIFRodSwgMjAyNi0wMi0yNiBhdCAyMzoyOSArMDAwMCwgVmlh
Y2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIDIwMjYtMDItMjYgYXQgMTQ6
NDIgKzA1MzAsIFNoYXJkdWwgQmFua2FyIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4g
PiANCj4gPiA+IFdoaWxlIHRoaXMgYnl0ZS1sZXZlbCBpbnRlcmZhY2UgaXMgcGVyZmVjdCBmb3Ig
dGhlIG1vdW50LXRpbWUNCj4gPiA+IHZhbGlkYXRpb24gaW4gaGZzX2J0cmVlX29wZW4oKSB3aGVy
ZSB3ZSBvbmx5IG5lZWQgdG8gY2hlY2sgYSBzaW5nbGUNCj4gPiA+IGJpdCwgdXNpbmcgaXQgaW5z
aWRlIGhmc19ibWFwX2FsbG9jKCkgaW50cm9kdWNlcyBhIHNpZ25pZmljYW50DQo+ID4gPiBwZXJm
b3JtYW5jZSByZWdyZXNzaW9uLg0KPiA+ID4gDQo+ID4gPiBCZWNhdXNlIGhmc19ibWFwX2FsbG9j
KCkgcGVyZm9ybXMgYSBsaW5lYXIgc2NhbiB0byBmaW5kIGEgZnJlZQ0KPiA+ID4gbm9kZSwNCj4g
PiA+IHVzaW5nIGhmc19ibWFwX2dldF9tYXBfYnl0ZSgpIGluc2lkZSB0aGUgd2hpbGUgKGxlbikg
bG9vcCB3b3VsZA0KPiA+ID4gZm9yY2UNCj4gPiA+IHRoZSBrZXJuZWwgdG8gZXhlY3V0ZSBrbWFw
X2xvY2FsX3BhZ2UoKSBhbmQga3VubWFwX2xvY2FsKCkgZm9yDQo+ID4gPiBldmVyeQ0KPiA+ID4g
c2luZ2xlIGJ5dGUgZXZhbHVhdGVkIChwb3RlbnRpYWxseSB0aG91c2FuZHMgb2YgdGltZXMgcGVy
IHBhZ2UpLg0KPiA+ID4gVGhlDQo+ID4gPiBjdXJyZW50IGxvZ2ljIG1hcHMgdGhlIHBhZ2Ugb25j
ZSwgc2NhbnMgbWVtb3J5IGxpbmVhcmx5LCBhbmQgb25seQ0KPiA+ID4gdW5tYXBzIHdoZW4gY3Jv
c3NpbmcgYSBQQUdFX1NJWkUgYm91bmRhcnkuDQo+ID4gPiANCj4gPiA+IFRvIGFkZHJlc3MgeW91
ciByZXF1ZXN0IGZvciBhIGdlbmVyYWxpemVkIG1hcCBhY2Nlc3MgbWV0aG9kIHdpdGhvdXQNCj4g
PiA+IHNhY3JpZmljaW5nIHRoZSBhbGxvY2F0b3IncyBPKE4pIHNjYW5uaW5nIHBlcmZvcm1hbmNl
LCBob3cgYWJvdXQNCj4gPiA+IHRoaXMNCj4gPiA+IGZvciB2NT8NCj4gPiA+IA0KPiA+ID4gwqDC
oMKgIC1XZSBpbnRyb2R1Y2UgdGhlIGhmc19ibWFwX2dldF9tYXBfYnl0ZSgpIHNwZWNpZmljYWxs
eSBmb3INCj4gPiA+IHNpbmdsZS0NCj4gPiA+IGJpdCByZWFkcyAobGlrZSB0aGUgbW91bnQtdGlt
ZSBjaGVjaykuIFRoaXMgY2FuIGludGVybmFsbHkgY2FsbA0KPiA+ID4gaGZzX2JtYXBfZ2V0X21h
cF9wYWdlKCkgZnJvbSBQYXRjaCAxLzIgdG8gYXZvaWQgZHVwbGljYXRpbmcgdGhlDQo+ID4gPiBv
ZmZzZXQNCj4gPiA+IG1hdGguDQo+ID4gPiANCj4gPiA+IMKgwqDCoCAtV2UgcmV0YWluIHRoZSBw
YWdlLWxldmVsIGhlbHBlciAoaGZzX2JtYXBfZ2V0X21hcF9wYWdlKSBmb3INCj4gPiA+IGhmc19i
bWFwX2FsbG9jKCkgdG8gcHJlc2VydmUgaXRzIGZhc3QgbGluZWFyIHNjYW5uaW5nLg0KPiA+ID4g
DQo+ID4gPiBMZXQgbWUga25vdyBpZiB0aGlzIGR1YWwtaGVscGVyIGFwcHJvYWNoIHNvdW5kcyBh
Y2NlcHRhYmxlLCBhbmQgSQ0KPiA+ID4gd2lsbA0KPiA+ID4gcHJlcGFyZSB2NS4NCj4gPiA+IA0K
PiA+ID4gDQo+ID4gDQo+ID4gSSB0aGluayB5b3VyIHBvaW50IG1ha2VzIHNlbnNlLiBJIG1pc3Nl
ZCB0aGlzLiBIb3dldmVyLCB3ZSBuZWVkIHRvDQo+ID4ga2VlcCB0aGUNCj4gPiBtZXRob2RzIHNp
bXBsZSBhbmQgdW5kZXJzdGFuZGFibGUuIEZpcnN0IG9mIGFsbCwgaWYgd2UgbmVlZCB0byByZXR1
cm4NCj4gPiBtdWx0aXBsZQ0KPiA+IGl0ZW1zIGZyb20gdGhlIG1ldGhvZCwgdGhlbiB3ZSBkZWZp
bml0ZWx5IG5lZWQgc29tZSBzdHJ1Y3R1cmUNCj4gPiBkZWNsYXJhdGlvbnMgdGhhdA0KPiA+IGNh
biBiZSB1c2VkLg0KPiA+IA0KPiANCj4gQWdyZWVkLiBUbyBjbGVhbiB1cCB0aGUgbWV0aG9kIHNp
Z25hdHVyZSBmb3IgaGZzX2JtYXBfZ2V0X21hcF9wYWdlKCksIEkNCj4gd2lsbCBpbnRyb2R1Y2Ug
YSBzbWFsbCBzdHJ1Y3R1cmUgKGUuZy4sIHN0cnVjdCBoZnNfYm1hcF9sb2MpIHRvIGhvbGQNCj4g
dGhlIG9mZiwgbGVuLCBhbmQgcGFnZV9pZHggdmFyaWFibGVzIGluc3RlYWQgb2YgcGFzc2luZyBt
dWx0aXBsZQ0KPiBwb2ludGVycy4NCj4gDQo+ID4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgd2UgbmV2
ZXIgaGFkIG1ldGhvZCBmb3IgYml0IHN0YXRlIGNoZWNrIGluIHRoZQ0KPiA+IGItdHJlZSBtYXAN
Cj4gPiBiZWZvcmUuIEhvd2V2ZXIsIHdlIGhhdmUgaGZzX2JtYXBfZnJlZSgpIG1ldGhvZCB0aGF0
IGlzIG9uZSBiaXQNCj4gPiBjaGFuZ2UNCj4gPiBvcGVyYXRpb24uIFNvLCB3ZSBjb3VsZCBoYXZl
IG9uZSBiaXQgY2hlY2sgKGhmc19ibWFwX3Rlc3RfYml0KCkpIGFuZA0KPiA+IG9uZSBiaXQNCj4g
PiBjaGFuZ2UgKGhmc19ibWFwX3NldF9iaXQoKSkgcGFpciBvZiBtZXRob2RzIHRoYXQgY291bGQg
aGlkZSBhbGwgb2YNCj4gPiB0aGVzZSBtZW1vcnkNCj4gPiBwYWdlcyBvcGVyYXRpb25zLg0KPiAN
Cj4gVGhpcyBzb3VuZHMgbGlrZSBhIGdvb2QgQVBJIGltcHJvdmVtZW50LiBJIHdpbGwgaW50cm9k
dWNlDQo+IGhmc19ibWFwX3Rlc3RfYml0KCkgZm9yIHRoZSBtb3VudC10aW1lIE5vZGUgMCBjaGVj
ayBpbiB2NS4gSXQgY2FuDQo+IGludGVybmFsbHkgY2FsbCBoZnNfYm1hcF9nZXRfbWFwX3BhZ2Uo
KSB0byBhdm9pZCBkdXBsaWNhdGluZyB0aGUgb2Zmc2V0DQo+IG1hdGgsIHdoaWxlIHNhZmVseSBl
bmNhcHN1bGF0aW5nIHRoZSBrbWFwX2xvY2FsL2t1bm1hcF9sb2NhbCBmb3INCj4gc2luZ2xlLWJp
dCByZWFkcy4NCj4gDQo+ID4gDQo+ID4gSG93ZXZlciwgaGZzX2JtYXBfYWxsb2MoKSBpcyBzbGln
aHRseSBzcGVjaWFsIG9uZS4gUHJvYmFibHksIHdlIGNvdWxkDQo+ID4gbm90IG1ha2UNCj4gPiBz
aWduaWZpY2FudCBjaGFuZ2VzIGluIGNvcmUgbG9naWMgb2YgdGhpcyBtZXRob2QuIEhvd2V2ZXIs
IHlvdXINCj4gPiB2aXNpb24gb2YNCj4gPiBhdXhpbGlhcnkgbWV0aG9kIGNhbiBiZSB1c2VmdWwg
aGVyZS4gWWVzLCB3ZSBuZWVkIHRvIGV4ZWN1dGUNCj4gPiBrbWFwX2xvY2FsX3BhZ2UoKQ0KPiA+
IGZvciB0aGUgcGFnZSwgdGhlbiBkbyB0aGUgc2VhcmNoL2FsbG9jYXRpb24sIGFuZCBleGVjdXRl
DQo+ID4ga3VubWFwX2xvY2FsKCkuIFlvdSBhcmUNCj4gPiByaWdodCBoZXJlLiBCdXQsIGZvciBt
eSB0YXN0ZSwgdGhlIHdob2xlIGxvZ2ljIG9mIGxpbmVhciBzZWFyY2ggbG9va3MNCj4gPiBsaWtl
IG5vdA0KPiA+IHZlcnkgZWZmaWNpZW50LiBEbyB5b3Ugc2VlIGFueSB3YXlzIG9mIG9wdGltaXph
dGlvbnMgaGVyZT8gQ291bGQgd2UNCj4gPiBlbXBsb3kgdHJlZS0NCj4gPiA+IG5vZGVfY291bnQ/
IE9yLCBtYXliZSwgaW50cm9kdWNlIHNvbWUgaW4tY29yZSB2YXJpYWJsZShzKSB0aGF0IHdpbGwN
Cj4gPiA+IGtlZXANCj4gPiBrbm93bGVkZ2UgYWJvdXQgbGFzdCBhbGxvY2F0aW9uL2ZyZWU/IEFu
ZCB3ZSBjYW4gdXNlIHRoaXMga25vd2xlZGdlDQo+ID4gdG8gc3RhcnQNCj4gPiBmcm9tIHRoZSBt
b3N0IGJlbmVmaWNpYWwgcmVnaW9uIG9mIHNlYXJjaD8NCj4gPiANCj4gDQo+IEkgbGlrZSB0aGUg
aWRlYSBvZiBpbnRyb2R1Y2luZyBhbiBpbi1jb3JlIGFsbG9jYXRpb24gaGludCAoYSByb3ZpbmcN
Cj4gcG9pbnRlcikgdG8gc3RydWN0IGhmc19idHJlZSB0byBjb252ZXJ0IHRoaXMgaW50byBhIG5l
eHQtZml0IGFsbG9jYXRvciwNCj4gYW5kIHJldXNpbmcgdGhlIG1hcC1jaGFpbiBzZWVrIGxvZ2lj
IGN1cnJlbnRseSBpbiBoZnNfYm1hcF9mcmVlKCkgdG8NCj4ganVtcCBkaXJlY3RseSB0byB0aGUg
YmVuZWZpY2lhbCByZWdpb24uIEJvdW5kaW5nIHRoZSBpbm5lciBzY2FuIGxvb3ANCj4gd2l0aCB0
cmVlLT5ub2RlX2NvdW50IGFsc28gc2VlbXMgbGlrZSBhIGdvb2QgY29ycmVjdG5lc3Mgb3B0aW1p
emF0aW9uDQo+IHRvIGF2b2lkIHNjYW5uaW5nIHBhZGRpbmcgYnl0ZXMuDQo+IA0KPiBIb3dldmVy
LCB0aGUgY3VycmVudCBwYXRjaCBzZXJpZXMgaXMgdGFyZ2V0ZWQgYXQgdGhlIG1vdW50LXRpbWUg
Yml0bWFwDQo+IGNvcnJ1cHRpb24gdnVsbmVyYWJpbGl0eS4gVG8ga2VlcCB0aGUgc2NvcGUgYWxp
Z25lZCwgd291bGQgaXQgYmUNCj4gYWNjZXB0YWJsZSB0byBmaW5hbGl6ZSB0aGlzIGN1cnJlbnQg
Mi1wYXRjaCBzZXJpZXMgKHRoZSBtYXAgYWNjZXNzDQo+IHJlZmFjdG9yaW5nICsgdGhlIE5vZGUg
MCBtb3VudC10aW1lIHZhbGlkYXRpb24pIGluIHY1LCBhbmQgSSB3aWxsIG9wZW4NCj4gYSBzZXBh
cmF0ZSB0aHJlYWQvcGF0Y2hzZXQgYWZ0ZXJ3YXJkIHRvIHB1cnN1ZSB0aGlzIGFsbG9jX2hpbnQg
YW5kDQo+IG5vZGVfY291bnQgb3B0aW1pemF0aW9uPw0KPiANCg0KVGhpcyBpcyBteSBwb2ludCB0
b28uIExldCdzIGZpbmlzaCB0aGlzIHBhdGNoIGF0IGZpcnN0LiBUaGVuLCB3ZSBjYW4gb3B0aW1p
emUNCmhmc19ibWFwX2FsbG9jKCkuIFBvdGVudGlhbGx5LCB3ZSBjYW4gZXZlbiBjb25zaWRlciBv
ZiBjYWNoaW5nIHNvbWUgcG9ydGlvbiBvZg0KYi10cmVlJ3MgbWFwIGZvciBzZWFyY2ggYW5kIHN5
bmNocm9uaXphdGlvbiB3aXRoIG1hcCBpbiBtZW1vcnkgcGFnZXMuDQoNClRoYW5rcywNClNsYXZh
Lg0KDQo=

