Return-Path: <linux-fsdevel+bounces-79452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIvpItfSqGmlxgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 01:48:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8BC20996C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 01:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECFD5300A24B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 00:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5571A9F85;
	Thu,  5 Mar 2026 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mhWECXux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD25288B8;
	Thu,  5 Mar 2026 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671634; cv=fail; b=rTaweJivu7YD1ogiE884ijlDkPGloXc0Qu4OuQjf31ZAfp3+dNCQUWb5vVDLi0ZDd1UN38iD4nUYUwUswC1DBAPpE8x+l7v/6pzz3CvyJs75+BaHSncbgObbSjzIUe0ZdShysOLL+Kf2xf6iSlOb5LKIX7BgUgXtq+ljMVxzqPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671634; c=relaxed/simple;
	bh=y909Z8+HXwlsAi+lFoaSnlt917W/osT2Fd21e5cFug0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=CgiyL7ju+YkTX2s/EZhtetwcQRO+0HQmBU5WlRRRk2IR0vuB65EhmpZTM1X7Hkcio+PLjDIG9wOXMQOhxpKCouV8yZp/OO2fVBjLYB3+1yuHXExWdK44XqncxVbSTurlxFTeD5gDPP9kngFQb1MbKn6RJODUn8gCiamJAcY50YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mhWECXux; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624F8nsh103426;
	Thu, 5 Mar 2026 00:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=y909Z8+HXwlsAi+lFoaSnlt917W/osT2Fd21e5cFug0=; b=mhWECXux
	imMKYgBdZsNLBK/lr6sC5e62+x03fwGeKHCAygtHulnKS21gxizi1A4NSyckKi6X
	jPYaoWgtDNv+NfRxZoc6/jdo6zB0shpxoI5IsKh+F1COTGPhOUMU0qyZiOz/ph4i
	RtZByiyAfXNhvQF57vxMpIy+rAtKU9zgucAHX7FHgZPTTWAR5BZ1tEIvQcBoXbvq
	0LBfozGNsvXtiGFQBsR3DBrD58wySVNljdC7t0WoyVy9xN/UrUA1qkDBl9xx7iY1
	af0D26KpWiBgLAvjwu8T1rvpPiJtMEzBb972ksgj77/yWNmAlvTpq98QCfEe+BAs
	2E6zKeV0uVJJRg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskd1q4s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 00:46:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVvoa3q9MQidnwx3sb5pq6vMx5sDI8mU1trHv3miJdczGq81WAnH6H33GQv60hrsUoi0mL4yYC4sPy8gAg+qe3lDHHZzYokwasTPSvh45x3B/3xb39GhIKD04+b3USyo5/ze2XBoO3yaeWU9Rg3ZapQkcWEFO6HHRloqtf7GBQQDdwdYtpfhlADajeO+AYIkF8zlMEohiuheK5HaNG5P1fh59MvkK4o0HM9oCvwEGxH6tGBUDGLxhZ9RoXx/id1BuJjEZB2SxQU4bAb5wp47B8KPbfQuH8iCvicTe75DRfVWuYDLpUiW0ffrU8XyJtEBIDh4spQ5bmFquBpjpXfjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y909Z8+HXwlsAi+lFoaSnlt917W/osT2Fd21e5cFug0=;
 b=lEqC5W+wI8YYYPbfUm4rAFGBeP0nCgRYlP8H0l6qPUB9NBuqQZmdkizVBuFGmMkQSSV2cNJs9ONE4VLSwDR57u/zGZ6SaSGOFF9VayvBGOHKRiHUkoe2+qP0fu3m44Fsm+UtSUXbpXjFnedK1cMrvB5aXij6s4fXyg/zwCN4ds2qX3e7MEscnMdqaZ6Ktl+wpti6cIpvKH+n1+uJ4CisPR+r7e0IUpReNMYLOgFsUKC4ZeFRm9wDbU+XKBApKXCxz4aJYBjoE7II+1TeCLTptw2ZHaGPdp+RQjz4XBC7J5d8MseZGAx0jPsf6M1DlUf2ubA8Sbt3S8nMo9g0iR1+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH3PPF02053E067.namprd15.prod.outlook.com (2603:10b6:518:1::484) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 00:46:55 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 5 Mar 2026
 00:46:55 +0000
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
Thread-Index: AQHcq9hDf3IahKMroEqX1R8/F3zmX7WezIeAgABKD4CAAATZAA==
Date: Thu, 5 Mar 2026 00:46:55 +0000
Message-ID: <532c5cdf12ced8eee5e5a93efe592937b63b889d.camel@ibm.com>
References: <20260303082807.750679-1-hyc.lee@gmail.com>
	 <aaguv09zaPCgdzWO@infradead.org>
	 <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
	 <aajObSSRGVXG3sI_@hyunchul-PC02>
In-Reply-To: <aajObSSRGVXG3sI_@hyunchul-PC02>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH3PPF02053E067:EE_
x-ms-office365-filtering-correlation-id: ed78220b-1be8-4833-2950-08de7a50b352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 RWeVdxKguW4Ri6PNfv9ABRC20TUqwdDnKgRgY9VI2x3aGWt6wgFz2Wg8E/i9Y6TE6W1XsFH6KuG5SCHvQg2S9I/Q2jYpEyDkzFx9/zQjqdGxOOY5r/HPtIVE1vXmq2YD1pOSaH67rpU1JXvXJ21mifjub9Ogg8hIqk1+NhiTihV07Pf7wZx1DYWBgDCZizL0WokROKMKyPLb69g8FL6UZhHgBUhDIyrUWwDijOhWuLVLSNxFb6uq7FqdzT1dEU9kbCK/LMre3Rk0LpYoc3CUw1ejOGQ+R9m3yc8kUfPO66oCh+pz4tK7mcKanFKnGU+FcJKSQmuJ5b7emf4IFuDwNrR48kuDPDmZXsev2YZvYtU2HlkMKb/oSyP0/oVgo88VvTB7ZGcy0fHmEFZW/PCuiPI84EI9BHkQwDZsl2TLkrFLRG7rKI+/mwulmAHxuea0n5E9sOSz5LwaWsyXYV1KzdAI3EKX+04h8Sd+QyW9cxERDr7A2jt6I0MP3k1+RfWxfXPrBWrKN16qIOw1dODrolsLFhgyqDv5ioMz1r6vFg+bpHDfpynzRp1UodcMMzeXIZh3Nuw7Z1BLU1IrVwS14a1gfjzXMKMDZtqUBWSutQSCj3R+mhA5WV/EVgVBIBt6TwOZG4QbWPWNn5DPwHErqRfyjyyJnvcU2Ty4MDskFQaEYODsezvZEzuHCFF74FA27OeN/viNSPDdRI8fRB/6ZyK4PseWWZ6rbjZev62JcH8LY7dPvyxgcpb2gvvkmqqY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmMybkhkNFFZTkZWZjM3T3NjcnI0enhxSlhYZU5iRDkyeFRDdEI1cVIxemJu?=
 =?utf-8?B?TkIyLzdaTElLd0dVRlJMSzdsZXoyZmhLdVI4ZVNoMitnK2RKSFY1Z0UwcjYx?=
 =?utf-8?B?OVJ1SnBkcTJGeDVUUGsyYk9ZUHVyNTNCM0Z0dFR2aUJ0NHpzbjMrTkhlMTZC?=
 =?utf-8?B?TTVwUFhmWUpMNDh6M2I2MUlPTWg2M0hsSTkvVjN3L29lQ3NJZkxBQmJDUzRs?=
 =?utf-8?B?aTlWUXR3M3RrRHhVbEx1U2ZVZTFLcjdWZjRPbkpGVU5xMEJNVmU4R29JbXVV?=
 =?utf-8?B?d2VpcXVoN3M1Z085YlBKdkcxTm9TVlJZSmdDaG1vRmpuNjlTbU9hRFF2bC9T?=
 =?utf-8?B?QTdHeStvR1pLTHk3ZnJtM29VREZDZWxYL0c5K0FodmdONldJc0xjYnJ3Uldi?=
 =?utf-8?B?QlpaNXAwTG5JN1ZFazljaE0zaVNlRUUxeUZHMnlZbVI2c3dUVXFCakVLTTZM?=
 =?utf-8?B?T2dLQ1JqclJkVDNxNmpwVEpTTWkyTU54a2RmQzBHMlVQaDV1bkJwVWpuVGIw?=
 =?utf-8?B?Vmc1bzZxazBBV29lTWtnREtvQ0Rtc3ptcGxURzdiSUZQOWs0Ujg1VWNVOUJa?=
 =?utf-8?B?b08rOWYxS1hHWDdEdko5T2hZL3o3L1VNVU02RTdUbE5DZkcvRWFjNUIvWnBT?=
 =?utf-8?B?NnFZRG5UckVIR1JGK2UvVVJtOVN3b25tNE9wYzF6Wm1OeXJLQmRrV202ZWpC?=
 =?utf-8?B?ZUFFVWlMcEhuYTFwUU9HcnFCQ0ljR1BJSjhxT0ZWMEJTVzBKaWpCTHpmdXEz?=
 =?utf-8?B?djJqMkdVRE1KNEVDNDl0R1Y0cnltdnNoK29kS0ZBeThJUThBWW9KbXVWVVIz?=
 =?utf-8?B?enc5emJoNXBkTkxjVGcwaFhQV1JPK3gwOGJlODRzMk5DS2hsVjFPajJiWGRt?=
 =?utf-8?B?TGpaZEhyY2R4d09JTDVyeDVWNXduR0dlalZPcUd0U2svRlgza080Tml0TDkw?=
 =?utf-8?B?elFqT0p0T0cxMVlvS2J5SFdZWGdQcVpaWEFsN1JFYllTVzlXeTI3OGd6T2NX?=
 =?utf-8?B?R2NKN1dmS3g1QUpHQ0VRRWtrL0xkUzZLME0zd1ZlRTl2ZThaMnZPekFzYmww?=
 =?utf-8?B?OVBGQUZyanhJMG9nZmpLcThsSlhvRStIeWw2NFl0MUZKVGNiSUM1Uld4dTlh?=
 =?utf-8?B?bWZWd0N3TUxPWVQ1NVZiWEFjYUl5aDdNTXRmOVhqT0Uwak5DNHA5amYvaTcr?=
 =?utf-8?B?RE5qS0p1S2owK0tSeHhpcG1UL0xZRnluNnFhOWF5RTIybUwvdjhYbURsOFBs?=
 =?utf-8?B?K3g4T1VRcGNOOVRyZmE0ZlZIK0h3bUMxbXEydDh0Y1NybE40LyszdE8yM2Ra?=
 =?utf-8?B?NDd0NytLVnlGUnh6Vlk4aFlMSS9OMHI2ak1USVNad2psSFlNRElYQURCUFF5?=
 =?utf-8?B?enZIMHhzVGM0Y0IzUjJkTkdYYVp4ZXBzbFhySTFtYkhCMzV2SVE4c3pYUmxX?=
 =?utf-8?B?VXY5anQ4Z2tkbVUzRXV0bHdXL0N2OWpZVlV1NVN4dWRkMW1kQXN1bytNZW1a?=
 =?utf-8?B?bEJlcjFJOC9wUUJuaFR1K24waHhET2orbUc3NS9UWDFyYXh5dzNWckR4YXpV?=
 =?utf-8?B?MGI0YTlRMEhNdkFuSWhLV1pxWENyUEp3Y2ROUFVDUjRmbFFhV21UcTdRWjdW?=
 =?utf-8?B?TzF3MW9HSzkwSHlNeUZXVzQ4eWhRNytnWDA3MWNnYWRod0Qwc1oxR045ZFBR?=
 =?utf-8?B?TEdMRnFPK0pqSXVyS05BWHR4UmswNzFvZmxqbWIwczI0WUEwdzZvUXVrbXl3?=
 =?utf-8?B?TTRneHdmSnVITXhEMlovamFFMys4ZFJHb2VjZWxqTzl2cCtuTVBaaVI3ekN0?=
 =?utf-8?B?amdNQ2plUzN3am03dlZvME9sdmI2cS9ldG0xY0FudFFHVkdya1lobUhQNGFh?=
 =?utf-8?B?MmtaV0hVNVVGOTM2bmhiTDFjNDlrWEwzU1FCTm9uSzQyNEN1cVZCRWh0Yjg3?=
 =?utf-8?B?d2U5dGVpRHBiZUVTRXdiZ281bWgxdGRqQURmWHM5bWNOTDdCZXJpcEpYSFpY?=
 =?utf-8?B?RFNldnRtK0x4YVJ3Y1h5cDBKTHdFWVVMY1RCRFpZYUhxejRKVlV3bGNKT3hC?=
 =?utf-8?B?V1ZaSk9ha2gwNEZ4MTZ5N0sxVFBQQk91RVk4MXdZMjJzTVkzWEFFb000UW5h?=
 =?utf-8?B?YjFIcUh6b29mWm5mQW1ZclFQTy9kTWRDNzZZbzF5VHk3akg3ak9kdnRVVE4r?=
 =?utf-8?B?MGlxS3Bqc056MW1XYVZ2MWtyRHlTTU9ocEhHcFZOUnpEOUtWU3lQOXJaZUN5?=
 =?utf-8?B?N0N0UHNwQU9XSzI3ZFBZYVNvRlovdmRXOVhmck5OVitFNkFaQkVxWUlmSW5B?=
 =?utf-8?B?NmxZRVRDQi9YL3lxbm5JYm04SmVRKzJRZFpkMGJGS1RxM25KL2kyRzVJZUNN?=
 =?utf-8?Q?LQYSHMy2k55p//qLVrCbAK8c/IMhRBe56l6V/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9527C4073A611D4A9431C121950FACCD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WsFuPCVthBbkv9722SsCGgvYY5krY5ubIT6RQfrWVjQeRQiRcJUTOOAN5ZwqSvfkAyaVtPcl4IeiUJus66eXLg9W6Sc3QduUJUrBmO52N/lDpn8kOdnBmvfa33W7DuofcOUUK745EZPIT/Ikk7DGNn+sb3nvPZaQH7dd5dUxYl6K52aIWDVMVy7vun4X5kXwvsu3GmVfMQevxHELrZ2DxbPydnJNoS+bzZorYRwCUdRnDnKulAWRBtcKNwLCKwDvsE/a0Ck5e9+3YjDpfwjUlnakU2sdjAmtqfQAYOhWl+wf4bEw2hsuFojgJoXE3jV5zJ2n0cNagjR/ENkWhXk4tg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed78220b-1be8-4833-2950-08de7a50b352
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 00:46:55.7589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +EUonFIr7DZL8O/ucDk2+2v0B6GPHNeQd9l4Reka46UfFtf+EfpSkhY7ntbjn2p2g50awm9UOkbsoX+azTxIpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF02053E067
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: hLn5nuApycckmpFwjpRDjwMlDP6nTDnR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDAwMyBTYWx0ZWRfX+TmrlfTghmqx
 3USb6i5dimurS84S0u+KDIY33VrvAqnuvcrXf5NdvAaRYACsaOOd5SbV1QRGDXOa/CixXTQlVro
 iVgF3Vrl/asjqHcFfgd7YrdsMx/aEKPFu5zIW1J3mRMZZNmivDk6zJHgoAOKj1P7FMOfZja8JI/
 /UeaI+mzeEsbC5/ZIT1P2K55RmX/q591H0u6NkPxhngPu22tr0cjaeTOD68E2SeHl2rpjeLxfzP
 9qzu77P1Oi39/vlRdRLxU/R/5hUydb37G6MMpW2WkAKwTlLGJTperCONOrtTao1K33hYvJI9xiE
 ADE9jxfmkHCIYuYtGq4hK+vouaOZ/+DifyHUKHEknftO10sr/9FhFhKtXdMu9FsvO+ZlwQ7d00H
 QTnoA3LD81I6fuMuLfukD0ZgQpTTHbGIaZLlBbZay2V/7aPActwxJCL4EaC+xaLpk3TO/sjhfah
 Y6CtxwHX7vAqpXz0p9w==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a8d283 cx=c_pps
 a=u8Zh/y5cvmLMdp3U04oolg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=P-IC7800AAAA:8 a=aAKcpuIfVOlGHAE3RekA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: UmRaqA7-znZJK9r_P1n59jGYb9hBzs6Y
Subject: RE: [PATCH] hfsplus: limit sb_maxbytes to partition size
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050003
X-Rspamd-Queue-Id: 8E8BC20996C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79452-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:url];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAzLTA1IGF0IDA5OjI5ICswOTAwLCBIeXVuY2h1bCBMZWUgd3JvdGU6DQo+
IE9uIFdlZCwgTWFyIDA0LCAyMDI2IGF0IDA4OjA0OjMwUE0gKzAwMDAsIFZpYWNoZXNsYXYgRHVi
ZXlrbyB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjYtMDMtMDQgYXQgMDU6MDggLTA4MDAsIENocmlz
dG9waCBIZWxsd2lnIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBNYXIgMDMsIDIwMjYgYXQgMDU6Mjg6
MDdQTSArMDkwMCwgSHl1bmNodWwgTGVlIHdyb3RlOg0KPiA+ID4gPiBzX21heGJ5dGVzIGN1cnJl
bnRseSBpcyBzZXQgdG8gTUFYX0xGU19GSUxFU0laRSwNCj4gPiA+ID4gd2hpY2ggYWxsb3dzIHdy
aXRlcyBiZXlvbmQgdGhlIHBhcnRpdGlvbiBzaXplLg0KPiA+ID4gDQo+ID4gPiBUaGUgInBhcnRp
dGlvbiBzaXplIiBkb2VzIG5vdCBtYXR0ZXIgaGVyZS4gIHNfbWF4Ynl0ZXMgaXMgdGhlIG1heGlt
dW0NCj4gPiA+IHNpemUgc3VwcG9ydGVkIGJ5IHRoZSBmb3JtYXQgYW5kIGhhcyBub3RoaW5nIHRv
IGRvIHdpdGggdGhlIGFjdHVhbCBzcGFjZQ0KPiA+ID4gYWxsb2NhdGVkIHRvIHRoZSBmaWxlIHN5
c3RlbSAod2hpY2ggaW4gTGludXggdGVybWlub2xvZ3kgd291bGQgYmUgdGhlDQo+ID4gPiBibG9j
ayBkZXZpY2UgYW5kIG5vdCB0aGUgcGFydGl0aW9uIGFueXdheSkuDQo+ID4gPiANCj4gPiA+ID4g
DQo+ID4gPiA+IEFzIGEgcmVzdWx0LA0KPiA+ID4gPiBsYXJnZS1vZmZzZXQgd3JpdGVzIG9uIHNt
YWxsIHBhcnRpdGlvbnMgY2FuIGZhaWwgbGF0ZQ0KPiA+ID4gPiB3aXRoIEVOT1NQQy4NCj4gPiA+
IA0KPiA+ID4gVGhhdCBzb3VuZHMgbGlrZSBzb21lIG90aGVyIGNoZWNrIGlzIG1pc3NpbmcgaW4g
aGZzcGx1cywgYnV0IGl0DQo+ID4gPiBzaG91bGQgYmUgYWJvdXQgdGhlIGF2YWlsYWJsZSBmcmVl
IHNwYWNlLCBub3QgdGhlIGRldmljZSBzaXplLg0KPiA+ID4gDQo+ID4gDQo+ID4gSSBhZ3JlZSB3
aXRoIENocmlzdG9waC4NCj4gPiANCj4gPiBCdXQsIGZyYW5rbHkgc3BlYWtpbmcsIEkgZG9uJ3Qg
cXVpdGUgZm9sbG93IHdoaWNoIHBhcnRpY3VsYXIgaXNzdWUgaXMgdW5kZXIgZml4DQo+ID4gaGVy
ZS4gSSBjYW4gc2VlIHRoYXQgZ2VuZXJpYy8yNjggZmFpbHVyZSBoYXMgYmVlbiBtZW50aW9uZWQu
IEhvd2V2ZXIsIEkgY2FuIHNlZQ0KPiA+IHRoaXM6DQo+ID4gDQo+ID4gc3VkbyAuL2NoZWNrIGdl
bmVyaWMvMjY4IA0KPiA+IEZTVFlQICAgICAgICAgLS0gaGZzcGx1cw0KPiA+IFBMQVRGT1JNICAg
ICAgLS0gTGludXgveDg2XzY0IGhmc3BsdXMtdGVzdGluZy0wMDAxIDYuMTkuMC1yYzErICM5NSBT
TVANCj4gPiBQUkVFTVBUX0RZTkFNSUMgVGh1IEZlYiAxOSAxNToyOTo1NSBQU1QgMjAyNg0KPiA+
IE1LRlNfT1BUSU9OUyAgLS0gL2Rldi9sb29wNTENCj4gPiBNT1VOVF9PUFRJT05TIC0tIC9kZXYv
bG9vcDUxIC9tbnQvc2NyYXRjaA0KPiA+IA0KPiA+IGdlbmVyaWMvMjY4ICAgICAgIFtub3QgcnVu
XSBSZWZsaW5rIG5vdCBzdXBwb3J0ZWQgYnkgc2NyYXRjaCBmaWxlc3lzdGVtIHR5cGU6DQo+ID4g
aGZzcGx1cw0KPiA+IFJhbjogZ2VuZXJpYy8yNjgNCj4gPiBOb3QgcnVuOiBnZW5lcmljLzI2OA0K
PiA+IFBhc3NlZCBhbGwgMSB0ZXN0cw0KPiA+IA0KPiA+IFdoaWNoIHBhcnRpY3VsYXIgaXNzdWUg
aXMgdW5kZXIgZml4Pw0KPiANCj4gU29ycnkgaXQncyBnZW5lcmljLzI4NSwgbm90IGdlbmVyaWMv
MjY4Lg0KPiBpbiBnZW5lcmljLzI4NSwgdGhlcmUgaXMgYSB0ZXN0IHRoYXQgY3JlYXRlcyBhIGhv
bGUgZXhjZWVkaW5nIHRoZSBibG9jaw0KPiBzaXplIGFuZCBhcHBlbmRzIHNtYWxsIGRhdGEgdG8g
dGhlIGZpbGUuIGhmc3BsdXMgZmFpbHMgYmVjYXVzZSBpdCBmaWxscw0KPiB0aGUgYmxvY2sgZGV2
aWNlIGFuZCByZXR1cm5zIEVOT1NQQy4gSG93ZXZlciBpZiBpdCByZXR1cm5zIEVGQklHDQo+IGlu
c3RlYWQsIHRoZSB0ZXN0IGlzIHNraXBwZWQuDQo+IA0KPiBGb3Igd3JpdGVzIGxpa2UgeGZzX2lv
IC1jICJwd3JpdGUgOHQgNTEyIiwgc2hvdWxkIGZvcHMtPndyaXRlX2l0ZXINCj4gcmV0dXJucyBF
Tk9TUEMsIG9yIHdvdWxkIGl0IGJlIGJldHRlciB0byByZXR1cm4gRUZCSUc/DQo+ID4gDQoNCkN1
cnJlbnQgaGZzcGx1c19maWxlX2V4dGVuZCgpIGltcGxlbWVudGF0aW9uIGRvZXNuJ3Qgc3VwcG9y
dCBob2xlcy4gSSBhc3N1bWUgeW91DQptZWFuIHRoaXMgY29kZSBbMV06DQoNCglsZW4gPSBoaXAt
PmNsdW1wX2Jsb2NrczsNCglzdGFydCA9IGhmc3BsdXNfYmxvY2tfYWxsb2NhdGUoc2IsIHNiaS0+
dG90YWxfYmxvY2tzLCBnb2FsLCAmbGVuKTsNCglpZiAoc3RhcnQgPj0gc2JpLT50b3RhbF9ibG9j
a3MpIHsNCgkJc3RhcnQgPSBoZnNwbHVzX2Jsb2NrX2FsbG9jYXRlKHNiLCBnb2FsLCAwLCAmbGVu
KTsNCgkJaWYgKHN0YXJ0ID49IGdvYWwpIHsNCgkJCXJlcyA9IC1FTk9TUEM7DQoJCQlnb3RvIG91
dDsNCgkJfQ0KCX0NCg0KQW0gSSBjb3JyZWN0Pw0KDQpEbyB5b3UgbWVhbiB0aGF0IGNhbGxpbmcg
bG9naWMgZXhwZWN0cyAtRUZCSUc/IFBvdGVudGlhbGx5LCBpZiB3ZSB0cmllcyB0bw0KZXh0ZW5k
IHRoZSBmaWxlLCB0aGVuIC1FRkJJRyBjb3VsZCBiZSBtb3JlIGFwcHJvcHJpYXRlLiBCdXQgaXQg
bmVlZHMgdG8gY2hlY2sNCnRoZSB3aG9sZSBjYWxsIHRyYWNlLg0KDQpUaGFua3MsDQpTbGF2YS4N
Cg0KWzFdIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE5L3NvdXJjZS9mcy9o
ZnNwbHVzL2V4dGVudHMuYyNMNDYzDQo=

