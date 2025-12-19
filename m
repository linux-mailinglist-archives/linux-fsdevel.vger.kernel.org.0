Return-Path: <linux-fsdevel+bounces-71704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3889ECCE3D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 03:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14FF7307C1A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 02:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7873B284B2E;
	Fri, 19 Dec 2025 02:06:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020114.outbound.protection.outlook.com [52.101.196.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432123EA82;
	Fri, 19 Dec 2025 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766110006; cv=fail; b=aS1BzeGm6mxQ8VHev6VWwkofiWqGsj48+xX+dUTnBdpU/TWaPVy9Kb5cFH1ySCW+IZKyDpi82ZlBkZkRwn62ng6VuPAefyqSnvuDjbZytXf1/PfPUEgkrubMTs7diGiRf5TNZLmRUrX7asfu7nB9CNzcPy2veJpsKyFZahCwu8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766110006; c=relaxed/simple;
	bh=s8H81k+75t9ww7QCod6I6idoOJ3mWYOUrUGiztjVYdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g4cfcU63+eeEkAemMGGdXul3BiWL8dvdtxeAgMhVn6lJeSFc90+fZZYLPOmckqd6xiS3Zu42EpocbpRpwFVCyZzknFDvvHinrfySxmgAtjoXcI1WC6URnc+3aUkB3ct+CN4KgdO/k2RdukBl4U/h8P5gUFs+a3027wnKelGcaNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzteKjqwADHKp8VfkVbENqvFCDeW8rAUjmVz4w8Xz8mpy2IaRB3ViIEENksIMaRzMWIYkYJSJRj1IUNGVyhftMfckCKWFnuB9XU2+roGHSS0ExZgdJVOFlnn3dG4/sEHOfuAf1wYTVPglRvLcZD1C0Pt3/aw1DmXry4JK+KBHhorGDY4mIyTJOZ1MmA2RQbKiDmdNRc/TrpMflOl1Do3AhcM8afvPxstl7VB7l3qzjSa2/49gcMdb8uBPKu1H7HIu1y3KPfj73+f5eVFAVS8QLy4V7DwiAVKNi6oeS0XPM+CZR51/NQunMBbOW34+ILNqu/4ZdsSpFci5HcwvVtqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LWkx7elk6fX2WThSmELpwebc4nKEr3b2Mgv+uGHnpI=;
 b=URMg1Gx+t5YZqhYpPw2pUAGQQCyQuOKuCjuzegOgJ34U23GpOu5zoz6pBTS6ISy0M29mfBpXepliMzRWzto5l3ljlG5ZeZf/UxvmmmVJiADtrCNQLQ2OjjLT3GssHeYDrL6GJj6b1YmxJMlmMT587eQQxJgO3Mw8xLT35UHlqFpZpWluGMkJNepZh7meey+INUQvTQvzfcJX7iTZyKojSOR0siWH/iHXF8Ejub+mFz6HK1ucsF04PLpYDZhvuTQ/4RKH1k0+lPzITqa7b2IYZPu5z4neLmua/awcESNx+6h1dkd6S4zQDHKDd3nS+FEXQ5q29qvtkB7jvKT3IZwCsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3863.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:8b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 02:06:40 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 02:06:39 +0000
Date: Thu, 18 Dec 2025 21:06:34 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: oleg@redhat.com, akpm@linux-foundation.org, gregkh@linuxfoundation.org, 
	brauner@kernel.org, mingo@kernel.org, sean@ashe.io, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Message-ID: <fzu354ripzrd4ygxtftbx6mhymb4rzhbkbyogezlmb6pezclwu@tmnelgqjoupy>
References: <20251217024603.1846651-1-atomlin@atomlin.com>
 <060edde3-7cc4-4a36-b9aa-824e607d954c@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5hz6jrvqcljydhmu"
Content-Disposition: inline
In-Reply-To: <060edde3-7cc4-4a36-b9aa-824e607d954c@kernel.org>
X-ClientProxiedBy: BN9PR03CA0951.namprd03.prod.outlook.com
 (2603:10b6:408:108::26) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3863:EE_
X-MS-Office365-Filtering-Correlation-Id: b2fa4450-08d9-43d8-47e2-08de3ea33ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUNhSUxGZ1JHWkJiT251SVNjdVF5Z21udFBmQkd6S1BNb2V6S2J6MVI2UlZt?=
 =?utf-8?B?VDhHV3RuTEcrNFM5ZytBOXdqQWdiR3lBblRyOTIrZytsNmlzck9kaU5Cd0F1?=
 =?utf-8?B?Ri93NGVVYkh3NlVjcGdNTGlMajV0U2hDSW41SWhGOWRBVVJ5cmp4MmcranRv?=
 =?utf-8?B?TGFEUnZBRElKeFJjMHZzTVcrQVBUc3pzOUE3RWRlSzZFTkRLTk5JSVU1SmlR?=
 =?utf-8?B?VXF5akJjMWZ2YjUvYlVEWDNYQUczYyt5MlRubG4yd3V1Tkh4clB4SFFXSjc1?=
 =?utf-8?B?WEYrUmZzZXNtblQrVHY4YTBrTExUSUdsL1NZRmlKMlMzc0tPQlZQUUdWZVQv?=
 =?utf-8?B?dXFCekRJVHRFZjhWOTU4ODRWVkwvMVpMR1RXdW9OTE5YZjhPc0cxWWpLemxh?=
 =?utf-8?B?UnBPWE9rMHVlbmQxRTRHa2xWZHg4Qzg3UEpBVkxaSVZnOWVNaDdmK1RXekE0?=
 =?utf-8?B?ZDhjSnlHbVcrZm8vVzNGQWkzcmZad1BscDRwVW5jRXliL3puTjZSTnRVc1ps?=
 =?utf-8?B?dU5MRjNQcFpTY0dmWms0enRyTGV3cXBRcHREMnR5SWlEWnFvejdFV08yUk1U?=
 =?utf-8?B?S1Q4eFVRTzA2ekdCWkNjMVdYN3NJSDlrRU9IYWhuNzFGd0p2cEV1WTUzYUdl?=
 =?utf-8?B?aDNTTThZMmJBQUt2SHlPVnVKdkhDVkpDaFdHNEd6VWtoR2I3U00rRG5sckJF?=
 =?utf-8?B?ZXY5eitSY0ZSS2hEQWI4Zjh2cWdDb0FqTnhOQ1hOWFBscVdXbThwZnZONXlN?=
 =?utf-8?B?ek40ZUVzOUMrMG92MUdEMEQvVDlmbGpmNjhaUFI1TlZZK3d5N2RiT3o3Ylhj?=
 =?utf-8?B?Zll6dXNOdjhvdnl4eFZ1OGVLZ3MxdnFrVVRyRHV1Nm5TOEpTVnlBNjVFRmhx?=
 =?utf-8?B?dXhhWmJtTzdQVUhNeU8wVzg2dGo3dXZKclY2VGdCRTVrWEYvSVVWUWlxTWQr?=
 =?utf-8?B?TEpveHZCUVhTeGF5clhjamg5RFRwYUZ0ejV6MVQ2TnhNdGJBUFBQSThxaS9q?=
 =?utf-8?B?QjRSeWM3YUU1TjU0RkFHR2RmZ2dsRDdDaURlN3VFY2xCZ3lVdXJvaW10Umph?=
 =?utf-8?B?N2x3c2ZTSVR1U1d5UmY3TDhyLzVHUVVwN3MwYjRhRHJDTXlwbHlZUFh4SEVo?=
 =?utf-8?B?bGwvSTZ5UkJFc3NyOXhMa0s5RndxWFNhdWJsQUJ0Z0NPYmFjT2l4SDJNRVVQ?=
 =?utf-8?B?Tk1FZ3JGTTM2SlgzUVBBN0FQZ2Q2NHltMncrSmxxbHdtdXAxR1FVMFU3Q3k0?=
 =?utf-8?B?ZTJGTjhEMDh3NDNTWFZvRXV6bC9HbHpCM0daaXFiZDhoa1FCZUlQWVg0KzhG?=
 =?utf-8?B?d0pMdjNrdEtUMGRRaUw4VndFUFFvSEFXcFJjVW9XWktNTnZXclYrdUNWY1Z5?=
 =?utf-8?B?cjZlWG14QW5WUk9iS1BMWG5tck4xSjFWcUZqY2N2ZVlvWmk1OWpCRmFONVNm?=
 =?utf-8?B?VHJXaEMrUGJucjkvS3ovR2o3VkFDT3Mxc0lYbCtTem1CMWlhdjhiUDgvNWZh?=
 =?utf-8?B?OHMyUWZDb1hlcGo4NzlRTHltS2hVdkNiRlJ2RnRGOHhqajlxejA1cTJZbmZ3?=
 =?utf-8?B?S2Z1SnBnbmNnaXRnWXlZWkRtQWIzMnFqU29IWFZjOW5GSGNzZXJYUFB5b3FF?=
 =?utf-8?B?VGtrcVFCL2VIYzZYdXc2dDh5d0xSQ3gzQ01oTmJWTDhqdXJjUUFxc0N5c0NY?=
 =?utf-8?B?Y3haS2p1aEV0WEVDcEg3Qk1wcnlIL0FtZVhQbGp0MzZrVHhNV21lTDFLZHFH?=
 =?utf-8?B?MDNBYjlFQVVQcUxoM2g0QjhRdjZPSlBCVDNkOHI0V2ZCTHdUbmszYTgvUFVn?=
 =?utf-8?B?R2FnR0xCQ1owRWhIY1FDTHFJeUpQVXRDZi9ZcS9BTUxLV2NTS3loUmxkN3dE?=
 =?utf-8?B?dzZCcFRZL01ud0lKN0Zpc0dFZG4wWmVNaEJzTllZcmIxTEhzNlN6MVBCdXF3?=
 =?utf-8?B?Y01mNnlxMDhnVWNETTdHbVBxRCs1Q01LK1E0VEFwbm8zQ2ZsMCt4b3gzTnc5?=
 =?utf-8?B?VXR1aHBOWkZRMS9pcnZYSFVqUXdCZ1hUT1pWbmFRWk5nU05ZZ0NhTVhYVkVS?=
 =?utf-8?Q?W7Yo4/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjBoKzlDdXk5dUtmemVHb0lFZFZUMlNJNU8xZkZaV2lKRGFIMURobm5KQi9l?=
 =?utf-8?B?Ymd2YlVkMTVSNGVQNzNUTXZUczY3TWZnOUNDU05nb3k5ODhVQU5xWEsraXFH?=
 =?utf-8?B?enVrVy9aZkh0bVZpaWZLeFY4RWR0MG9kVjlJemFYUUNWNitpWER6Nlp6SEhp?=
 =?utf-8?B?UXVCZEkvaE1XUTRUTmtPM3cyRCswV05vYUg4bWI1b2g1QkJYT25VVnZjRDgy?=
 =?utf-8?B?Zkhsek11djdUYUo5dnFEckpnSXFIeUlhUS9raU5waVFkbGZ4dWZNRm9WN0Er?=
 =?utf-8?B?QldtcE56cElhcWk0dzE3a3hsZ2hUREZNOVlpS2tqelZUYkR0Mys2UHB2b2Rh?=
 =?utf-8?B?VCtNV1BNL0Rac3d6RERGUnkxVUZrUmlFRU1VYVF2Y2ZUQStCZ2xoTlcyUFRV?=
 =?utf-8?B?eWtES3BQWkJlRFJoNFFsazZJUTFJQTRRVHYxRkpXS3FHM04zcWpiVE12c1B5?=
 =?utf-8?B?VnVEY0JHcHJ3TnNyUC9vWWpKQXpPSmZvbWQ1UWlydWs2eXRMcy91R1ZDYUE0?=
 =?utf-8?B?TEVaVWlWSHNpcjRmeXBjQWhlVGw0QnZOVHJYSk9lcTZEL3pIY0lBNWlYaEZM?=
 =?utf-8?B?Rkd4UXNpQzhOZVVFT0MrQ2poSlJNaVd2Y2w1am5ERHRCcWZqUUFKdzdNV1g3?=
 =?utf-8?B?YjQ4MkcydCthSFZOUUt1emlxVUpzc2RqU0J4elFSZlFmMWZ6Yms2ZmZxMk4w?=
 =?utf-8?B?a0N5NWZEWVE0SGU1cEVZNHorSFF4ZWJPYkloNkhqVVNGOHpwU2tSWGtoQ2c0?=
 =?utf-8?B?bm80TkdmZlFJak5oUlFpRjlwZkN1M1F6azVWTjVvdFVGQzNRcVpFWDkwcGg1?=
 =?utf-8?B?eG8wWVdSSWR1RWxMWnN1a1FXaytQTE5ObWZQV2RvODMwS0d2MERlOC9BNEcy?=
 =?utf-8?B?cENGTDJrdWVhWHJOMDF3dTR6VzdrbjZHKzlUYjlQWG5YZFYxczRmWFh1YmNW?=
 =?utf-8?B?dVNLUGE0UVREOWszN1NCeUlzbm54ZWF2U1RnUXVwOUpIUFNyL2dnTTI1VDhv?=
 =?utf-8?B?b25QM1ZLZlhRMmV3amxhT2RCTEpuK0NnZjV1MFNuaDFhZy83NTF1WTlDSWpr?=
 =?utf-8?B?TG1pd0wzZ3dYUXFRT0VJbGxvbkhGQWptYWZXSmFIS0E4NmtuVWlVVVRSc2dI?=
 =?utf-8?B?WUZLWEtLZzlvOWlEeVJ1SVJ6ZklYeDNsT2Jad2dHaWUxWG1Ua2pIVGtNRHhk?=
 =?utf-8?B?ZTlLeWEwWG5uZjJ2bVdkTlFSV21JaVRGcC9yYlRydXRFcjgweFlSak05Mk83?=
 =?utf-8?B?Si9lcDc1YXZKSUhlbnBrZTR5TkFlYmdwTnk4WFZOTVNtUy9WUjhGNnp5cFlv?=
 =?utf-8?B?cFBYQTNyMmQ5MUtTY0REZTdWL1hMWEJ0VEU2UkF0cUl6dFVtTVhESVhXS3BT?=
 =?utf-8?B?WXJkUmFWMUcxaFhud2IrT1NBZERGckh6VUh4VmZoL0F6ZUtQOGZEdUgvT0Zz?=
 =?utf-8?B?UXFDdVQzTWJKeHlRZEYxcWdGdHVqUDNCRWFvekFvbGlsaVhZU0JMSVBMYjJQ?=
 =?utf-8?B?aDZCemEvQnczZ3o4VHlsQVlITkl4VUd0OUx1aDJEM1pMQWpJVzB1MGtlQTAv?=
 =?utf-8?B?RnRUcjhVbE1vMjVjUnEyajUwb291RUlQV1drMzZkd1hxaU5uM0dHdVFybk9x?=
 =?utf-8?B?Q1hEdklsbE1NMVRNMjg4SUVxYk9HQ2pNckpjYTh6MTNKam11TmtrRSttd20v?=
 =?utf-8?B?S3FqOFlXZDVNSlRXb1J4dyt0bmhMeElya1oyTW5iS1FTc25VQXl1MEMwWVlU?=
 =?utf-8?B?RElQMEpNeGY0dGl6QXo4UHBESWFoYUlacWx1WkxLOUZtRUFJZWY0U0cxOHBU?=
 =?utf-8?B?VmVzcS9sMWowMEIxb3JGeGZ2K0JJU2xXdzZHaGhqMk1BMWRFTWJsOW9VejNp?=
 =?utf-8?B?UFZhWmlNWXU0elovVjgrZStmUVNnd0Vuak91NFo1VXRPUW5oZTJjMjhNWHJl?=
 =?utf-8?B?THhjTXhnSU1EUkdZckVhckZjeWxGZHRFRTc5ZWNXbUpWbThpZHFGaXE1S2po?=
 =?utf-8?B?ZDNmeGI5ZnU4blRXbS9KMW43QzM3M05Mc0JqQ1ZLZHB5NmtIQjhNU2lWeFBG?=
 =?utf-8?B?L1FwWkxueDNGUnRQdXBPODAvU1ZPWFo4ajlrN2NTT1Q4dUlmZEVScVlmaGcx?=
 =?utf-8?Q?+nGJAsVna6ksiYouNX68t4Is/?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fa4450-08d9-43d8-47e2-08de3ea33ec0
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 02:06:38.9627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9zG3OaV8Uc2q/qkt/tA7m+Tkiw40vaWouU0NVeyH0ShfsEu6uIiWX0g7kMbnPsPJvyE5BBxIvq7fOAwCStzgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3863

--5hz6jrvqcljydhmu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fs/proc: Expose mm_cpumask in /proc/[pid]/status
MIME-Version: 1.0

On Thu, Dec 18, 2025 at 09:30:53AM +0100, David Hildenbrand (Red Hat) wrote:
> I agree with Oleg's comments.
>=20
> Given that everybody has read access to /proc/$PID/status IIUC, I wonder =
if
> that information could somehow help an attacker to better attack a target
> program (knowing which CPUs have dirty TLB etc). As you saise, it's
> primarily for TLB and cache sync ...
>=20
> Just a thought, have nothing concrete in mind.

Hi David,

Thank you for raising this point; security and information leakage are,
quite rightly, paramount considerations when adding new entries to
world-readable interfaces like /proc/[pid]/status. Upon reflection, I
submit that the risk here is minimal for a few reasons:

    1. Existing Visibility: The kernel already exposes a significant amount
    of CPU residency information. For instance, /proc/[pid]/stat explicitly
    shows the CPU a task is currently running on (field 39)
    i.e., task_cpu(task), and "Cpus_allowed" already defines the bounds of
    where a task can be. See do_task_stat().

    2. Resolution of Data: The mm_cpumask is a relatively coarse-grained
    diagnostic. While it indicates where TLB entries might be valid, it
    does not provide the fine-grained timing or cache-line information
    typically required for sophisticated side-channel attacks.

    3. Diagnostic Value: The primary intent is to provide visibility into
    the "memory footprint" across CPUs, which is invaluable for debugging
    performance issues related to IPI storms and TLB shootdowns in
    large-scale NUMA systems. The CPU-affinity sets the boundary; the
    mm_cpumask records the arrival; they complement each other.

I trust that the diagnostic utility is seen to outweigh the theoretical
risk in this instance.


Kind regards,
--=20
Aaron Tomlin

--5hz6jrvqcljydhmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlEsyYACgkQ4t6WWBnM
d9aNPg//VZLnk+Yq/jWGSNVXoleb5u9XtEiJ0LMcGwvAwbh4dXVcuw+2PVVN7UNO
qTTT3dndnbarHp5kWRPx7HORzm/hfScA496r5iRylG8lNo5VJg56bMzd8xck+441
L7cCq23a3E7Qwz1syvtG1dd3rGimb9v1g/7U9Fg/03v+pPEJz+XjxVGuducH9gic
8q46ZTE06XTAT26mXfwJwpR+Z/F+yks7bpYjkILrKkka7XATw5M3A7W5GLF3E0rX
1n+8Whm2cneL/jVjlnFfQD+LFu/oOj0UVKL05KsvIvUyuSJ8wH0wwfoVhbLN4GLx
NuldJTiHZ82kG93trJBhI4a+rlAtFmeXYTlNx7vVQlVYfo73TB+zk37E+q/GPr85
siEwWxwG8azIuwkTknQ61VSFQgZofxryi8q3dkB1+5SkB7GwWXtlxd4h5fX2yjkO
u7bXIyQ2w/rud25Uj6EhAqjsntQ4Pw6cJdNe9pD6+cZQRwyEzQBrQaTRGRTuNTSf
OjdSQgpDLAR74T/MMZfNb/Ilu8K+rp4k8jmxGgcnKsOTqVI0mrbXzkwhD4eIG6hM
lek4jTJOYYs0gx2fEX6oE8pviN+qbcmgOb86TvU5F1EN7/yu+PaCD2Yl+lVU0fn5
Qy0Nw0ayimfxqVOvwHm/sip3dVzWSgLO4YvvkNTQaFBwzNVeRaA=
=RQhg
-----END PGP SIGNATURE-----

--5hz6jrvqcljydhmu--

