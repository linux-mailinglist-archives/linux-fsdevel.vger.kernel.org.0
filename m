Return-Path: <linux-fsdevel+bounces-76983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W20UDpcVjWkvywAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 00:49:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 706C11285D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 00:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79D7A309315E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 23:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE95A31354D;
	Wed, 11 Feb 2026 23:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iIcinHwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A2286A4;
	Wed, 11 Feb 2026 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853774; cv=fail; b=RCoPql9sUxLYn6ZgT7RD2Qrg/qHz9IRLKBgWxZHLfbJKHAjMmsA0xpEgpdHboAJsnDOk4t0/pQVNimQ5ZZ8zf7AZH9eISYDpkjtkQggxdXlLYDELANTSGow4ylXbS+i7TYZdL7dsKLfVl1d3FXSibxztIZFYIFq8jAH12rjGSc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853774; c=relaxed/simple;
	bh=vwEPQpLqTyNW6EsjX/C01G97v3pMSyjdeiEKYf0it8s=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=NSdaiM33H4bGnT/nyC125UfsE+149SBUDhCFZ5TQgpP4o5rSGCX3aAweTQOODwOqKcszEX3r4MB0ksktW3OKjaVP7I2wbkYNn4pdefLtagkhHTcgILaMP1vCWMzs+4ZZfA6TgS+XtQkFzVxBTqmlVzbaSnku37lJJK0r8dC5lCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iIcinHwU; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BApFEr3277755;
	Wed, 11 Feb 2026 23:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=vwEPQpLqTyNW6EsjX/C01G97v3pMSyjdeiEKYf0it8s=; b=iIcinHwU
	a6owqsc1QuQ8xct/sFsWcTataI8qAfND1eFEyJpUEai1LIAj2j9KA5aKo9NPBNyQ
	z7EQqbfFXBWkyNu+ZfcQk8GrtJZlt9dOrS+uCpS2FHTnW6NFKKRIlatDtRStedqj
	AuTN4CfGBFC3RazkgBnoDaWzAJKTFC6flqPQa8k8XxyTpY/mn7RdmBhZW0hPuSUF
	nLSw5fc1db4nic3zQGulXqAEsd40Gvm52rkW/mwgwe+Z5NfoqfmwCkT7Ov4W25P7
	uAJ6spNGbhXB2uZtbcRrfklvOkG8xu3p45JBwT/qWGCRDxg0CidygugQNUs6SCcY
	C09EiXy8JhdVKg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v13x1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 23:49:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkAkq6YVyfHnJl4TvQi91Tu6CyrfSjSPcgLpYRLn8ZKLaWNA08Ftw2cs4mZbAdVbP9jCTCZQbVRGkSsB6KoCgcgQaEJAH4K+QZFDZC3tDQW2O5gDKcg5pItCJApZKtbfACuEw4TYp8zEJRoGW7qY4jU5k2yKvP9Ypnlot+Va1WV63kD+MrXx88mKsqcDrTL4XCkJ4/stowTIYdE8gWemQQkUnAK9ccizK10YAZp58xnCwttBFPWX9i2mKvz162E/VFLyIPEXKD3oYMNlJCKacKBvYaRBWIN1msXer5jZzHjXP9KjZoHaVs6NdflzUA+4hiVCy5f4/mZq1cFIVngO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwEPQpLqTyNW6EsjX/C01G97v3pMSyjdeiEKYf0it8s=;
 b=rCdFAuv3646V6r/linK3RQKfMIC0ZzNxjBGgvRdyi8+OVEvpXnl0f3UZiy5SI2PWRV+pBacNHXcz/Xrh1tizLvd6FSQu90AWtWKua9X+sYG2Gy5l/Ci20NbyuwLnMsbNoojMDiRUdSmJQtRZr8zNwVfjtz4sQJLZG6ylXILxchR2/YQaHdTcuchOKgUosGMR7kZnSQbi/NmvzGeEMFZpfBBTDMCk0dJ+U64MTXarskJzfdDvNlmZRke6mjAiy7ke0w4Jj7zzQeOmScjWjnjXt15vsFrpDu78CEvVnvxiPQooT/+Sw92qMCTlsUHxymawcknVwuGfVynt2gARV96Xpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM4PR15MB5380.namprd15.prod.outlook.com (2603:10b6:8:63::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 23:49:13 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 23:49:13 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "jack@suse.cz" <jack@suse.cz>, "frank.li@vivo.com" <frank.li@vivo.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com"
	<syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] hfsplus: fix s_fs_info leak on mount
 setup failure
Thread-Index:
 AQHclMaiKtTJZ48RZUCMz1LaYapWfLVxofOAgAEsaYCAAALggIAAA2eAgAAJOICAA2a0gIAGhyGAgAFszQA=
Date: Wed, 11 Feb 2026 23:49:13 +0000
Message-ID: <6b378df8d9a6f7ecdb448ff3b3dd3c739c4334ab.camel@ibm.com>
References: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
	 <cace4df975e1ae6e31af0103efcbca9cdb8b8350.camel@ibm.com>
	 <20260203043806.GF3183987@ZenIV>
	 <b9374ab2503627e0dd6f62a29ab5dcde9fc0354f.camel@ibm.com>
	 <20260204173029.GL3183987@ZenIV> <20260204174047.GM3183987@ZenIV>
	 <20260204175257.GN3183987@ZenIV> <20260204182557.GO3183987@ZenIV>
	 <95e3ab710185fc18d820a64e6cb98e652de9694b.camel@ibm.com>
	 <20260211020331.GJ3183987@ZenIV>
In-Reply-To: <20260211020331.GJ3183987@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM4PR15MB5380:EE_
x-ms-office365-filtering-correlation-id: c91630e7-bf0b-4fe6-4e78-08de69c828c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVpGYjZFcDA3bUp2SEZQVmZhZDhodHJzU0RrTGtOT0cyeUR0Tm9KQ3Ezam8y?=
 =?utf-8?B?NEk5eTY2M3JHNktnR0psclVSRHhOUU5EdzQ4UWlvUWNqTDBvcFV1MkduYXBD?=
 =?utf-8?B?ZXovQkdTZGRGbGFTcjZ1SURuUkk2TFRFVjQwNm11b2lWTTlSSU10dGxDZlln?=
 =?utf-8?B?OWRsM1dsSWJ5dksxN08zY1Fzb2QwRXFuamJrM1VJOFB0MjFHT2hjakRxdFAr?=
 =?utf-8?B?OTQ3UVcvUFNDZzFBQktwSWx3NWZzMElGczlwWW5rZkxUV0EvVFQvZGpwdDk4?=
 =?utf-8?B?Zis4c1MwbmErdnUySGJWVkczTVF6ZWR2VnRoeUZ0SGJrdUVRd3BtK1BvRUtU?=
 =?utf-8?B?aDh5c3Z1Zkl1S0luaHFqQllhWENkVFRxT3BxQ0Q4REpjNVhhQkptSFh3TUZD?=
 =?utf-8?B?T0tXc1VIZjdoK0R4L096dFRQditNNmNMUTlMajVlU1BlcDVqb2pRR1JNZzV5?=
 =?utf-8?B?ektxSlFqRmJDOEMxdzlxL3p5TDZmM0loRkZjOUpUdzNQWXNhamJwRXp6akxC?=
 =?utf-8?B?SFVyRjVwbE1jOFU4OXl3SGFjYTU4MHBTUjdwaFNnWXpaZXVNdXJHbWN5NHVK?=
 =?utf-8?B?ZGFnb2pRV1c4RExzTWxIL3E4Q3NmazRZWTRDNzJxV0VRampCR0VuNkxQR3BT?=
 =?utf-8?B?RnNWU2dUVHJyUnMvSzdiUnFMeWNRb1RjcXN5SWx6NFdpbDFid0Z0ektYZUFG?=
 =?utf-8?B?Tllubk9CUFFyUmJMNkVSSG1SeWVDZTYxcXNwUGMrbTFESW5IeCtXKzJzZzJv?=
 =?utf-8?B?YVlCVFhBQWppVDhHaE13WmJCeWFWRHorTi8yR1h5dG0xQ1U1QnNMN1V3c2J6?=
 =?utf-8?B?Z1lDaFZrcEovVDZ5b2tyWDhOcVlReHhJRmUyeG5TQjduamE5Q09HbkZFSTlv?=
 =?utf-8?B?U1pHVXQ0QnRqMG50UmFSNHFOWWRHRDlrQ3dOU2JmY2JMT1lIWGQzQU1jbndT?=
 =?utf-8?B?Y2ovRGo3cXB1YVRWV1NsMXhSZFVZZ1VzbGVTUXRhS2dWM0dhbENDa2V2UE02?=
 =?utf-8?B?cG84cFh1MGRnMURIWDFSOXBTbW5hcmlhWHdsTFJRVUs1SmFKNzBrcDEwM29U?=
 =?utf-8?B?bXd4ZkZhbUdYUUFXMmpmWUhyZk9vMUJOMUlVVFBHRjFQQ0txbnNIeDdTVHN1?=
 =?utf-8?B?RXI2MVJsK2R4a2ovRzcyMm1mY0VHZnpMNlNQQ0pBVmZSNXRDMjF1Y2R2M0sy?=
 =?utf-8?B?QmR5Qk5NQkZCdEYxNWlRNDdiVXFYQlpXLzNxa3JCVThPWUtvcXRJb1pUU0Fp?=
 =?utf-8?B?UStoTDlVNC91b2Jvc0kveXVlSlhCWkVoS25sRDM3RXdTMmo1SW42VE1DNjVW?=
 =?utf-8?B?Z2JNcEpiZGk1T3ZMSlh6SEQranlvbGdaVVl6MjNHTDhmTi9sendONjN3ekVp?=
 =?utf-8?B?T2ZBK2E5aWQ5TVBMNFVkb1NKM0Ryc3ZMRTByaTlDd3poUHdIb2kzYlJFV2dm?=
 =?utf-8?B?UGJvY1F6UEk4bGJOdUE0MFRmNlBqVHY3andLS0tTNGlaWDZmSVI4WEhnVWhq?=
 =?utf-8?B?TGplL0pUbEhDWXptWndoaWNlaXRlVHRXdjkyNVlEY0FuZ01TUmpsZ2NPMmpz?=
 =?utf-8?B?a1JUbEhidGpRRWgrYXRObU1seWkvTHErVm1zalpjeFZqVmJmZXMvRjhXSXZP?=
 =?utf-8?B?QXdtUEVrdHN0YU8yZVFVZnJLeWFYdzcyQVE4Q3BDcDErSnlQNFlGSFgwZFhL?=
 =?utf-8?B?OHh4cW1CbTEyaFg4MEdyU05BWTdWYW5tY1NLNG1nVnd5c0NNdGo5U3ViOVln?=
 =?utf-8?B?eUtaRURYN0d5eDBBaWZ1aXhSckpsSVVFYUpRTmgxREhLVUIxUWZOLy9BYnJ2?=
 =?utf-8?B?Zm9yZXpJeUJYQ0lXL1prY0praHIxMktoSnBIb3MvZVFnY201N2lDY1FPU3dw?=
 =?utf-8?B?Mm9TRzRQeGNVdlZaVEVhbU41ZXFkOFBiRFRaaVYvWEltTHpaMXJ2UU1NRFJj?=
 =?utf-8?B?U25TTzlIVGxwV084dFJtUi83ciszMzJRbVNyVEhZWlhNbkFKMTF2dHJDQURH?=
 =?utf-8?B?Z2ozTldjT2F5ajhYRTRGTS9qbldDbXRNdW1ERHRRSGEwc0piSlNsdlRDK3Vn?=
 =?utf-8?B?S0M3ZnJjUGZIeHpJNnR5S1RyWitMSnpGbGEzQmJqb3lzT2JBN1cxSjlMSnpN?=
 =?utf-8?Q?BdmQpSCZVr5I1nu4WOGPZZHIX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzJSclRoQkIvdUN5ZWFGWmFmSnRhODI3bnpOVFRnTEdRR1RBay8rUjExc1Ry?=
 =?utf-8?B?VE1TQktjV0Jic0hrUmtOU3FJUXh6T0l5ek40by9KdjRhNXdtZzR1YVVrNEVi?=
 =?utf-8?B?TnFhYVdnYXJYaUFQeCtaNmJrVVUremw3Nk9mWXFYUk9YUWJIb0l6TmcvMUpa?=
 =?utf-8?B?bTY0aGJCVzZaNFp1OUhkeUJVcUhCRXpHUlMvMERuUzFWNU4yaUVlVmxIazMw?=
 =?utf-8?B?eFg4R014SU9aODkwb0I3RzRYbTlrQ1BRY1pKWjNMT1pjTVRqU21uNzArNmNk?=
 =?utf-8?B?dzdEait0TGhFNjk2SldFTDUrbkd5WHpnTjN2S2l4SzA3REM2cWlvVnNlOE1q?=
 =?utf-8?B?eDBaVHZhRFlNR1VnbnMvdDFwVHBVMWhyeGpHVmErK3BvQlJEVVp2d3lrYW1o?=
 =?utf-8?B?NzFoMDRnZVhYNXZZR0x6cVRiTVdMU3pCaDdTa1hSaFZSVE4rYjRwVjNQU1ph?=
 =?utf-8?B?c0ZkQVNIL25XLy9YUDc4enU2ZWNaNUJmMVVWZURMbmZBaktpbFpycnVyRHF0?=
 =?utf-8?B?QTZiSUw4UGRWOXJ6Y1lhZkdNUEx4TkI5ZDRFbGs4S3dKTlhDQStnYUJ4OS94?=
 =?utf-8?B?QkFZL040TFFLTkxjOEVZdWpqZERnMFp1Yy9xcmZHWFpNeE5rTnJLelVvLzZz?=
 =?utf-8?B?eEN6NTVqNnVEYVFsZHU5a041QlN4R1lJMWJ2S2lmdk4wbmpEVHQzRjFYRlEx?=
 =?utf-8?B?NzB1YVY0ZTZCQmtIYlVCWVJkVE5oeEpWd0lpSjFwMllJbDNvYlVXUVVLZ0ZI?=
 =?utf-8?B?SGxvUU5sblNycGVNdUFKdXNzeng5Nk02ODdId1pCMjRKOEo3ZEhtZzN4VVdi?=
 =?utf-8?B?WlNYdDViQU4yZVdzT0dybDIwZDNQaDU5dmlnZW1ySFZUSVdSOXJUYlI5dkFG?=
 =?utf-8?B?TmVTU1M1ajk4a1FJQnVSd2JtYytCZ3NTZ2c2VGwxMU81b244dlFZbzIwajJ2?=
 =?utf-8?B?YVovNjR1QnpmZEdCTXErSDlNc3VHYXc4S2RPdTM0SWRkYXVmZnhSbzl6czZT?=
 =?utf-8?B?OGRNT2VCcXJJRU95amc5VzRoMmdveWRYa3pxRU02WGNrSk91aW9GRUJaT1Zj?=
 =?utf-8?B?WExHM3kvdG8zenpQVTUvNmF3c1dEd1Zuc1UzajdCZW9maGRnYmN1VW9VMGx1?=
 =?utf-8?B?c0liY2ZKL0VzMW9WS0JLVCtsaE93YjZRQmprRVBhWDJld211R1RvTW9GMkpm?=
 =?utf-8?B?bGQ3MS95b2ZLZ1ZYSHVROFkyMGovZHdXcnYzSnVCTTI3WnZRTFJWSnVoaEk3?=
 =?utf-8?B?RWpjcndBRGx5R2s2WVpYMDQyTWdIVVhTUXdWWWF0WWpwV28zTUhTNGFIZXN5?=
 =?utf-8?B?c1FGTFlUcnUrVC9oU1ZQRk5tdWk1WGdoUlFoOE1sRk1uM3lzS2s1THVjdWhQ?=
 =?utf-8?B?S0JkLzVvQWNzUFJJWG1mRHVmYVZLOCtQMDQwTGRNTTlqWHlEVk5jay9STytL?=
 =?utf-8?B?M3Nncm4yUFpVRFZNWUMyQTVLck8vRysrdDR6aU1pem1DNHVtRGxWak5hTjBw?=
 =?utf-8?B?VFFJY1d0R1p1VVpjdytQeG1MVVZ6ZE80S0kyeFNzczExbFZoQ0QrekpNNmRh?=
 =?utf-8?B?eVg5ak9nY3hWRk9jdnFlV2FrK3hSNERIMk9wUkt3dnBtbXlWLytTZlVUZzB1?=
 =?utf-8?B?TlY4Uk4rUWlWbmdhdksxRStkck1mU0hZTnBFS0xuYzJTWTRxWmwxY1FacmEr?=
 =?utf-8?B?WkFvaGlIdDN2WUN1QWdQVkRjellFQjlJOGErcC9YQ2NnRmswR1FwYUlSQW1X?=
 =?utf-8?B?dEc2UGlialExc3pML25TOXVydTVBdWhtc21KM0ZGTWRiZ0JSL09FK0lOallI?=
 =?utf-8?B?N3lJRkVNaXV0bW5najU4NlB1bmplbFc1aGtEK1VEa2t4Q0k1Z3haOHRMS1Rt?=
 =?utf-8?B?TTJpdmtZbXgwbXRZZjNmVU5Wa0RoRVhXUjE3aUd6cm5LMFkzSXJyaWNFbVlu?=
 =?utf-8?B?OFJ6aThCd1RJRTVsdVRrWkVVVXBBUkxiSVBvTmxmWk9Pb25MdURlWFVaQjNM?=
 =?utf-8?B?LzV2NG9XQzB6OUUrb1laaFZ3VUNWTW5pWm5JUlN6bitNdDhGR0FZamQxRUJU?=
 =?utf-8?B?K0g5N01nZzZYdmxpMDduanVtWHFjVWpyOVRKWHhlRk83cVlhdWQ2UXkwK1Ew?=
 =?utf-8?B?VlFXNDZqbVNZNm9kL3NFZXVDZnNJV2R3dFlkVkpRT0VZTEhmKzF3K0ZXRWRN?=
 =?utf-8?B?cjk0R0ZlSUx2eDJUbVFxU2EwZ2g4NWVjM2VMMDFTRjN0dFlmanBuenZySmpr?=
 =?utf-8?B?ZHpGRUV3L1B3b1lpdk95cFpXY2ZlY3BTODd4UGxzOVJMZjcrZ0FvMDB3b0Fz?=
 =?utf-8?B?UUplWHFHTGR1S2llaUhjMSt2UjN4ZllpUVpVYi9oZUpSZVE4RFdpM21FY2hG?=
 =?utf-8?Q?pk8pwPJ64h/1cGIFuc31oz0JaIy2j4I0nKD2Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78589186B8D3994A84229BE36ECB931D@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c91630e7-bf0b-4fe6-4e78-08de69c828c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 23:49:13.1504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2GYNi17lNQ9hpxuLDIBSiFlxnItHMz46v1i+DQO9nIS5xjGo9Ghx0JmdtMOy4b/c6P+3uJD2nNgbj8pdLUFiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5380
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE4NCBTYWx0ZWRfXwp+UpNMnhNbV
 ef3liYeAKbViGzxOSYrFONTnZWTenGJ80BHfWPVlrxkofhfu9PUu1RPEtg3J5QWQv6w0XDdrCjT
 7wgcZ3VtMbGjeUGX+h6yV5a+NVIQEhgIciWK2o4veEy72vspiUaymb4qPkMDZEjmhNqNLMGJAxN
 SgIJASV8VX9lVUedeBPea6LIf7Y6WIS2HD/4LrPfwXUuY2zpol6LaIB6d4PDHgFw5YBf/6sQxdY
 BM0u7XIHSumsgEVv2MOpOW68PclAnOBA3BbbkVDFztA22U+Wy75G8ubGpIkKjx5Y8kGRdhk2UEy
 CnqPKwF0Edz0zghGcRuH9CC0UpOc0hFWEqnRH+ReJ4A77FhX2Jweb89JjxfOhjAjrF+O4pb4HPe
 LjW0Kv0s2elA1VEcZpEGuwdx9lyEHwJtMH5wwkkpMMkgb16v4q5NzBzM605T86Aqwl5AtafYKeo
 okxycarWAszL63BHtLQ==
X-Proofpoint-ORIG-GUID: IpWn0k14HDKpzraQ8IO0Awf00Br63xuT
X-Proofpoint-GUID: Zg2xL4-NQsqI1KVtsGdd5jGxa7OMLGiT
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698d157b cx=c_pps
 a=oAmyFwY4cP9Ja8EDt9RnJg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=P-IC7800AAAA:8
 a=eiN_ZEZwBDSeb-WjAH4A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
Subject: RE: [PATCH v2] hfsplus: fix s_fs_info leak on mount setup failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76983-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[suse.cz,vivo.com,kernel.org,vger.kernel.org,dubeyko.com,mpiricsoftware.com,gmail.com,physik.fu-berlin.de,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 706C11285D9
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTExIGF0IDAyOjAzICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBG
cmksIEZlYiAwNiwgMjAyNiBhdCAxMDoyMjoyMFBNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+IA0KPiA+IEkgZGlkIHJ1biB0aGUgeGZzdGVzdHMgZm9yIEhGUysgd2l0aCB2aXJv
L3Zmcy5naXQgI3VudGVzdGVkLmhmc3BsdXMuIEV2ZXJ5dGhpbmcNCj4gPiBsb29rcyBnb29kLCBJ
IGRvbid0IHNlZSBhbnkgbmV3IGlzc3Vlcy4gQ3VycmVudGx5LCBhcm91bmQgMjkgdGVzdC1jYXNl
cyBmYWlsIGZvcg0KPiA+IEhGUysuIEkgc2VlIHRoZSBzYW1lIG51bWJlciBvZiBmYWlsdXJlcyB3
aXRoIGFwcGxpZWQgcGF0Y2hzZXQuDQo+ID4gDQo+ID4gVGhlIGNvZGUgbG9va3MgZ29vZC4gQW5k
IEkgYW0gcmVhZHkgdG8gdGFrZSB0aGUgcGF0Y2hzZXQgaW50byBIRlMvSEZTKyB0cmVlLg0KPiA+
IFdvdWxkIHlvdSBsaWtlIHRvIHNlbmQgdGhlIHBhdGhzZXQgZm9yIG5scy5oIG1vZGlmaWNhdGlv
biBkaXNjdXNzaW9uPw0KPiANCj4gRldJVywgSSB3b25kZXIgd2hhdCB0aGUgaGVsbCBpcyB0aGF0
IGNvZGUgZG9pbmc6DQo+ICAgICAgICAgZXJyID0gLUVJTlZBTDsNCj4gICAgICAgICBpZiAoIXNi
aS0+bmxzKSB7DQo+ICAgICAgICAgICAgICAgICAvKiB0cnkgdXRmOCBmaXJzdCwgYXMgdGhpcyBp
cyB0aGUgb2xkIGRlZmF1bHQgYmVoYXZpb3VyICovDQo+ICAgICAgICAgICAgICAgICBzYmktPm5s
cyA9IGxvYWRfbmxzKCJ1dGY4Iik7DQo+ICAgICAgICAgICAgICAgICBpZiAoIXNiaS0+bmxzKQ0K
PiAgICAgICAgICAgICAgICAgICAgICAgICBzYmktPm5scyA9IGxvYWRfbmxzX2RlZmF1bHQoKTsN
Cj4gICAgICAgICB9DQoNCkFzIGZhciBhcyBJIGNhbiBzZWUsIHRoaXMgY29kZSBoYXMgYmVlbiBj
YXJlZnVsbHkgbW92ZWQgZnJvbQ0KaGZzcGx1c19wYXJzZV9vcHRpb25zKCkgYnkgdGhpcyBjb21t
aXQgWzFdLiBBbHNvLCB3ZSBoYXZlIGxvZ2ljIG9mIGxvYWRpbmcgbmxzDQppbiBoZnNwbHVzX3Bh
cnNlX3BhcmFtKCkgWzJdLg0KDQpJdCBsb29rcyBsaWtlIHJlZHVuZGFudCBjb2RlIHRvIG1lLiBU
aGUgd2hvbGUgbG9naWMgbG9va3MgbGlrZToNCigxKSB0cnkgdG8gbG9hZCBubHMgZHVyaW5nIHBh
cnNpbmcgbW91bnQgb3B0aW9uczsNCigyKSB0ZW1wb3JhcnkgbG9hZCBvZiAidXRmOCIgZm9yIGhp
ZGRlbiBkaXIgc2VhcmNoOw0KKDMpIHJldHVybiBwcmV2aW91c2x5IGxvYWRlZCAob3IgTlVMTCkg
bmxzIGJhY2suDQoNClRoYW5rcywNClNsYXZhLiANCg0KPiAgDQo+ICAgICAgICAgLyogdGVtcG9y
YXJpbHkgdXNlIHV0ZjggdG8gY29ycmVjdGx5IGZpbmQgdGhlIGhpZGRlbiBkaXIgYmVsb3cgKi8N
Cj4gICAgICAgICBubHMgPSBzYmktPm5sczsgICANCj4gICAgICAgICBzYmktPm5scyA9IGxvYWRf
bmxzKCJ1dGY4Iik7DQo+ICAgICAgICAgaWYgKCFzYmktPm5scykgew0KPiAgICAgICAgICAgICAg
ICAgcHJfZXJyKCJ1bmFibGUgdG8gbG9hZCBubHMgZm9yIHV0ZjhcbiIpOw0KPiAgICAgICAgICAg
ICAgICAgZ290byBvdXRfdW5sb2FkX25sczsNCj4gICAgICAgICB9DQo+IA0KPiBJZiBsb2FkX25s
cygidXRmOCIpIGZhaWxzIG9uIHRoZSBmaXJzdCBjYWxsLCBJIGRvbid0IHNlZSBob3cgdGhlIHNl
Y29uZCBvbmUNCj4gbWlnaHQgc3VjY2VlZC4gIFdoYXQncyB0aGUgaW50ZW5kZWQgYmVoYXZpb3Vy
IGhlcmU/DQo+IA0KPiBXaGF0IHRoYXQgY29kZSBhY3R1YWxseSBkb2VzIGlzDQo+IAkqIGlmIFVU
RjggaXNuJ3QgbG9hZGFibGUsIGZhaWwgaGFyZCwgbm8gbWF0dGVyIHdoYXQNCj4gCSogaWYgaXQg
aXMgbG9hZGFibGUsIHVzZSBpdCBmb3IgdGhlIGR1cmF0aW9uIG9mIGZpbGxfc3VwZXIsDQo+IHRo
ZW4gaWYgd2UgaGFkIHNvbWV0aGluZyBjb25maWd1cmVkLCBzd2l0Y2ggYmFjayB0byB0aGF0LCBv
dGhlcndpc2UNCj4gc3RheSB3aXRoIFVURjguDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyNDA5MTYxNzI3MzUuODY2OTE2LTYtc2FuZGVlbkByZWRoYXQuY29tLw0KWzJdIGh0
dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE5LXJjNS9zb3VyY2UvZnMvaGZzcGx1
cy9vcHRpb25zLmMjTDExOA0K

