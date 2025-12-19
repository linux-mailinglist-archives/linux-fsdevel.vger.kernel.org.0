Return-Path: <linux-fsdevel+bounces-71703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD08BCCE22B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 02:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2571E301ADE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 01:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E232122A7E6;
	Fri, 19 Dec 2025 01:25:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022076.outbound.protection.outlook.com [52.101.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5763BB44;
	Fri, 19 Dec 2025 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766107547; cv=fail; b=R3oCQ2C7+PsY5ctTkf/ZwOd0mvwQg/rhxddqVykNQqWpFc3BPzxEFsOaLTvv/sfplB0g2EjWGLESBdTzn2wdNpf7fL9fv6zmqZkCYBE/w2Yynt/bDxlYb4QcjQPrQXlT+pRMLdN1e7oRqbPAmPuUbPQpbfCPe5/f8TrGcYJMwIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766107547; c=relaxed/simple;
	bh=rlooRa/LlChHLu8cLOXkwNnQAvNavea9mIXL9rtxltk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c5dG+SUETdIxQ18cuV2DiX28YEkm8aVvYHxSLqKvHdNbte7zPt05rQVGDMhGwftsDVkdmwjPvv8229hTgI8PNNsXn5+Z2UPvqiExxNucPg17DF8GEODD7p7faexoBjkQ+N4AtRCxBlvTeXU/mzpKsfQouVuCo4zcUU4RkM8kq4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4wt5QWfKlnN4zoUSS4i4QVbV4yRXJoItRfxaVEPf6svrEFfapDEw/2YNiDASn4TnyxNu2oQ3Vf5b8iU7AlfIQG6uywdXYEQV95qxkBV9RlxLlGgxDNLQaOWGbIUGjYMb/Az2BFYxLLALDPmHh7pA2VJKQeahq2Vwsui5MmKpvBbjwHgNANBWBfYtJ64miRFiA3Qb+OXwfmjnsoeWkRi2GOgzGRhwIYVvtMNaks0r2j2ikqXgyhMdLeEzYmxCsOCaqXqBMIIS19Ov23Xp+X6gj866/uE7cq0XjhHzE1xfjSMtA6dccqvW7WXlfLdn3+VgRfDFWpkbZgDth4nzz/KeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CJEdM4Z1awwQWDTZUECtM0ep8f6YNhcxF20WOLhPbU=;
 b=Nx2JlJTyZ8cyRli0zkhesVlSjW9e2+BkMj4E3lUq1j3kgN/3vBCV/tqPlWWq7tRQZInViXQmoNoisUBEpU4dhq0qSwmJK6HCx9BJVXFE+NkyYtq5vqSBxEs/sd2ePMQsyb8CmGPEgix9FvL/gnfrjaPtVpriKXtsHIV981AeKRCcUaVvo47Owb8I9ARpROjGJcR4bnZ7Nxd0TrUSakZaeTgqR0+pz/sXlJXUAyzE5ntuk9pbmuCn+9lXFmasA8X1ukkINRo1QtzDieOq3ZAm/0tfqUchdPX01tzguKOXhbubTl7WD2McsIkVESHXkQP3dMTVX7LnBgjoMf+JlxXHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB5690.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:199::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 01:25:38 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 01:25:36 +0000
Date: Thu, 18 Dec 2025 20:25:33 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: akpm@linux-foundation.org, gregkh@linuxfoundation.org, 
	david@kernel.org, brauner@kernel.org, mingo@kernel.org, sean@ashe.io, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Message-ID: <osc3liyap3yp4zbnuxam7o53tcy47pinpl6pw6fmi5ch7cltp5@w32eddzvpjsk>
References: <20251217024603.1846651-1-atomlin@atomlin.com>
 <aULpZoSf2AATA_kT@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4qvqun6j65tse7vm"
Content-Disposition: inline
In-Reply-To: <aULpZoSf2AATA_kT@redhat.com>
X-ClientProxiedBy: BN9PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:408:112::33) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB5690:EE_
X-MS-Office365-Filtering-Correlation-Id: a906796c-71ff-4d42-ce11-08de3e9d8311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0NnUXg0WjNkc2l1dFJJcXFZcndrWEJlNzl2dkNhaHNZN2hXbDg0QXAzd09q?=
 =?utf-8?B?QWo4U2ZNMGd3T3JlZXlxbXpFTGQxMzBlRlVZU2RjdWprbUtuRUlpSk83OWJW?=
 =?utf-8?B?ME9uN04xSS9jY1JvUFNORW1Gb3BmWUFHemtOMXdacWRnR0lsd3FpdVNpUmhV?=
 =?utf-8?B?VFVSZlFIRFBRNGxEUUVNRkp2eHEvTm9DS05jYUxVZGFsVjd4M0hyMTZUajB2?=
 =?utf-8?B?MFEwajNvNVRnTUJ6MUNoOUlTYi9ldUU3azloODNnN1l1YXNndTdyZGlYNDJn?=
 =?utf-8?B?aHFnT2N3WXc4WStIS1cwZEE0ZDFDajEwWUpHT1RqVjVrVGt1V2h5eUhTS2Zs?=
 =?utf-8?B?d3lhb2NFc1hRNlB3QldNNGF0dzVmV0JTbTBDdHhINkwxb2tSUnpUQW9nWmxt?=
 =?utf-8?B?aks5ZW9INDF6eUUxOE0zRjRkQnRIVW01SFk3L3p3MFVXQnNYd0VuS0VUQU45?=
 =?utf-8?B?THN4MWFwbHQzTGE2S1JQRWxGZWFlN25vcDgwVnZzeU0zRG9vQTdYQkVtMFdH?=
 =?utf-8?B?VERQckZySjlGeFJaM2tJU2NBMXpITHBqWlVPS1Z5Y1NoMVlNdWlHcHhVUGND?=
 =?utf-8?B?YXI4dTFKbER2c0I0Zkh6a082UjdQTm5CQ3ZuTVNnTTZXMVdha3M0ZW1VbnRo?=
 =?utf-8?B?YWhsV3U5YWI3eFF3UDlNVEhFSEdOVHVEWHJ0RlNRRUZvOStaa0t0aGgyblZs?=
 =?utf-8?B?Z2craE40TlJ1NmkvQ2dPeXpkTjU3N0ZFbzJmMWE1ZXhEa1hJY205ZGNrNEtP?=
 =?utf-8?B?a3QrN0swbXpRL1R2bTNHU2Fnd1IvRUlxOFZ6dGZCUmRGSEN4L3NzUU1tRXFx?=
 =?utf-8?B?cXBwSk1nWURRQ2xYK2tNaVpDd3VwZWZQd3YvSlVTYzBCVTZGeDhFVHFVU0I3?=
 =?utf-8?B?Q0VMaWw0cytRTEdzanlUMXhXbExla3lQRGR4RVRsbWNveDlLK0JkZ0hxQnVl?=
 =?utf-8?B?VEJKRHpRSWVtd1ZacklnaEFHRXJvK0c0SERHMjJyTDdNNlQvRWtFb0lGeEVy?=
 =?utf-8?B?L1JXQ1FmcWhRUHAycllKZzhNY1lWZmVtSE9qNlduSmhZOG0vRGdScFAwcXhP?=
 =?utf-8?B?Vm1QSmlqSXRBNWh1WHRSbDhKUTIzc1dpcGdHSWkvVVY2cGtCS1VpemwwNUlz?=
 =?utf-8?B?aXVoT0R4Wnp5QmRzLzRMcktCdDhscmgrM3ZSazNvOUVuWjlST081YVllZVZl?=
 =?utf-8?B?TTFmaUVCK1A2K3BUMTRPU0Y2UGE0R3IyTzlCWU1RT2lwZmMzbmV2UW94Q0tD?=
 =?utf-8?B?d3MrdUFvWE5KN0RHVWozNFhhTGZjeDFRZkl3VXpYVGczS2crZGo2RWZHMCtt?=
 =?utf-8?B?NXBFQUNmd0g3U2p4TDNwZTNTVDFVdHBKdkVvN2ZlbWljTjBrb3VocDQyd2pY?=
 =?utf-8?B?c3Z1V3Z0SVFqUXFSTURteU5TUTFmTy9LYTQ3ekwzWTBzVWdGd1pFL0YxWVNH?=
 =?utf-8?B?bnZFbG1jTUhsOVFVL2pJbTJDcnhWNUFOcWxZVFhpbzdoMHdpdC8xTmxBREJj?=
 =?utf-8?B?ZHROa0U2SDB5MEdFSkg4ZnJSQ3VNOVdKNnBrOFNlQzhGQkNBZGRuQysrS3pz?=
 =?utf-8?B?QVRVUFBOQWtzN1VKMjBCdHpRYkRoQnFFUXR2ZlNNaEhhVS9LazZ6M1BQTnlV?=
 =?utf-8?B?MGNKNDgzdHFVK0tQb3hjNlZlYXkwQitMbi9WdjNPVXU2VmJjNFJCYU0rOWho?=
 =?utf-8?B?UDB1eHBFSnl2dVNnYVN0NmVyTDAxOURkdlhFY28xNUp1VkpKSkhGNXRLQUsv?=
 =?utf-8?B?cDg1aFhMNU1iNTlzWTNJb0M3UU56cXRxM2lzd05rTUV2WkZHaEpZUHluVW9M?=
 =?utf-8?B?Y1FVSjRZUTc5ZE9TMDR4ZGtoM3NDYS8xUnRieTQ2ZFEzbW1ZV2NLYWp2cmpv?=
 =?utf-8?B?YXhPUGZzN1d3NzhpZTBMZnk2d0x1dU9KZGVKTXhnT1U5VjFoY0pZQ20wYmpX?=
 =?utf-8?Q?NRa+tJuHHRNI76br5I5BmC11vR9Ouh0W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXJReEFjL3Uwd3BDaFdveklzbnkrS2hHM3FpeWEzM1ZHZTUzRzJ0YzdNNFBw?=
 =?utf-8?B?cnBwTGJxTEh5b3phZThjbDFqS1JQVGIwaVE2RVhWWEdMN2pjNTBOTTZnTVNM?=
 =?utf-8?B?bDV6c3ZxdEpBQlZwMVdGUll6NDhpTnYvME9VSnpoL1ZiTk9NeXIxRmJ3U1pa?=
 =?utf-8?B?cExqcUdia0V2SlVDdFpqd2RxRXdqekxMYlNrZ21mRnJiSW1SbUxoRWZMS1hH?=
 =?utf-8?B?S0FIWEVQcEVOK0hJajdXbXJDeTNYcHpQdUFIWGQ4THVSMlZrL0NJN1c2S1JT?=
 =?utf-8?B?RE1hcGlNM2ROdEZWbzRDelNWclpIRiswekI3SzZCdW9Ib0c3QVZtaThGeERw?=
 =?utf-8?B?SDdJNzc1SUVEV0NzUkUwUUEwUWF6T1JVV09Cb1VuVzEvSko4MXFkdFJnaTlF?=
 =?utf-8?B?R1FNT1BCOWVZa2MvSDRkTVgrbGpod1NXSWNreEhFb3FadDQ0QjVZc2tHaFpY?=
 =?utf-8?B?THFhcHJqRXA2NFZ4dDZONnhJNWNubmphejMvYXhJOGlKSjlNQXZ0SGJuUWxx?=
 =?utf-8?B?di9LdTRKMVlvbzFmdmRrdlE1WHRwMDNvbDdwVTVMZlhCQ2dBNVVFSmlpNTYx?=
 =?utf-8?B?TStEbjVDQWxmci9jUmtFTWFaVEtnZHZHMU9tWFROWFRuS1NwdU1IWUxCSzVx?=
 =?utf-8?B?NXQyVnlmcmR1RDV6cnFYcTRWcUlJSkdMSTNRendwQkVVSmpvdGpaU2ErZFM3?=
 =?utf-8?B?bFdGQU80bVRaZ1g0cjlqNFBXMkt6VDN1MERJaXhoSTZ6d0RaSDRlQkJuRm51?=
 =?utf-8?B?V2VTRTRmQ2d4OWY2Z08yenNvd1JVd01ydlo5eUZ3RDhjMnduU3U4bUE0aEl1?=
 =?utf-8?B?RUtOUCtyVnNmK3R3cTBhTG5CdnNQQjRRdHRvdUlYV0dNZGRRQXJiai9qOHJp?=
 =?utf-8?B?WndHcUN4cmljS3l3ejNCR29vK0lUSTZRNkhVTFlrLzRBNjAzYzdPVVpQNEYw?=
 =?utf-8?B?Z09xZHQrK2ZnNy9TV2JsVHZmeWpMOWxEdmRqak50SWM3dDRybFNFd1dwOSts?=
 =?utf-8?B?OEtvbGxocWZZNHp4eEtYUnBwOFM3UnhPYmgwWUZiN3dmS3RKWk1jV3JBM0wr?=
 =?utf-8?B?dXFMVlVNOXgxZ0Focm1UQUxWYTR1WjBna3JGb0s1N3NkWVlpMDZvWEJSOTg0?=
 =?utf-8?B?M2tNSXNHeUJXQzZqYXJpTkY2eFNRSENiUGhhbzNzL09UM1ZBbktWbDllUTR1?=
 =?utf-8?B?UFptZktlLzZZalpUZFFQTE1YUFpjdGFVY2tKUHl0WkZDL2liM1lUZlBWVjdF?=
 =?utf-8?B?aWFUVkJxeklSazZBK0E1eGtUdnVQSDZUeFd1ZTBRRXBKd2cwcEpZK0U3QzlT?=
 =?utf-8?B?Mjd0cHVjVU5vVTR5TkRvc2tOV3lhYzhsQ2xuS1NwRW9jYnBqWEQzK2VGdEV5?=
 =?utf-8?B?YjRnUUFuZUQvV2RXV3hZK01iWlFwN1BvcFAwOG9HcUFFL3hFU3d5WW40MUo3?=
 =?utf-8?B?UXFzejhqYk4xN0NNd1FrV0c3ZVNoZUxacWZYcncxVGttY3Z6QW1LdU5HOEF3?=
 =?utf-8?B?ZUVxS2p2ZDBKY29vSWtYbWE4RmhTWFNIaG1YUjlSOGxrRWE2QzdIdDRxNFZr?=
 =?utf-8?B?Vm45RXk1YXh5b0VzN1JVampwalJuRVhCUzFkVStoZWg5dG9ZbnJvSGgwM3BT?=
 =?utf-8?B?YjRmUDNHZHQrMXkwblV6MXZMYWNBbmpDY0o0RkQ3VkFzR1JtdzAwZUcwNGxz?=
 =?utf-8?B?ZXU5YWp5eWwvN3hqRSt0RlRYNnljODNlNjNhZS9mbExvSzBia01MRElDSldo?=
 =?utf-8?B?bFlGRGc4d0pRaENvSWZmcTgyd2ZGSVZ2WDlTZ2NMUDZUc2FwOUFLZUwxeWUx?=
 =?utf-8?B?NmdiTlgzRW9Ed2ZKYzlpODV0OUlQSStwNzZzMUJmYmlucmVuRnU2MEh2NkxG?=
 =?utf-8?B?UHZ0amxBUzZYcVJjNm55YVFmY1RTQ1gycmhDdFRJS1g0WXZHaUtUdFRNMUJj?=
 =?utf-8?B?WERDdmo4Q0gxNlp6SzBTdFdQcnVzMnlLQUZmekVqUkUyL3BNNzE3NEdHb3p1?=
 =?utf-8?B?UURUK0htb3lSc3NnTU95NmlPNzNOZzdKUHV2VGF5akVnYTduSjhvT0VXTjhR?=
 =?utf-8?B?RWtEaVloTHY0ckx4Um1mU1AxRklkY2J2WGRQVjhqRFRTZVdRcGRYUHMyNkxh?=
 =?utf-8?Q?rlf62/knjSFum+ELOnM5x7UoB?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a906796c-71ff-4d42-ce11-08de3e9d8311
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 01:25:36.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrsU+D92ClzgSZUoGFgUHYjpoTyq9bUkfP67581gt55Rf5AvR9Coagg/H+5PMK7dmpjexipZcvo4tVye9HEWZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5690

--4qvqun6j65tse7vm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fs/proc: Expose mm_cpumask in /proc/[pid]/status
MIME-Version: 1.0

On Wed, Dec 17, 2025 at 06:33:26PM +0100, Oleg Nesterov wrote:
> Can't really comment this patch... I mean the intent.
> Just a couple of nits:

Hi Oleg,

Long time no speak. Thank you for your response.

> 	- I think this patch should also update
> 	Documentation/filesystems/proc.rst

Acknowledged. I will do so in the follow-up patch.

> 	- I won't object, but do we really need/want another "if (mm)" block ?

I appreciate your observation; technically, the code could be more compact
by merging this into the earlier conditional block. However, my reasoning
here was primarily a personal preference regarding the resulting output of
/proc/[PID]/status. I felt it was beneficial to keep "Cpus_active_mm" and
"Cpus_active_mm_list" in close proximity to their counterparts,
"Cpus_allowed" and "Cpus_allowed_list", to provide a more intuitive and
logically grouped view for the user.

> 	- I guess this is just my poor English, but the usage of "affinity"
> 	  in the changelog/comment looks a bit confusing to me ;) As if this
> 	  refers to task_struct.cpus_mask.
>=20
> 	  Fortunately "Cpus_active_mm..." in task_cpus_active_mm() makes it
> 	  more clear, so feel free to ignore.

I appreciate your perspective on the use of the word "affinity."
My intention was to describe the relationship between CPUs where a memory
descriptor is "active" and the CPUs where the thread is allowed to execute.
In other words: the affinity set the boundary; the mm_cpumask recorded the
arrival. However, I see how this could be misconstrued. I will certainly
refine the language in the changelog and ensure there is no ambiguity
between the two.


Kind regards,
--=20
Aaron Tomlin

--4qvqun6j65tse7vm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlEqYgACgkQ4t6WWBnM
d9b6lQ/9HXk/ltDyPnZmFfvWS/8NRDEPhJqFCCdfUtxsIueAwE3LrZ9to0RYljHL
f4fXa0zRAje9aa+FIITenO4+A7IwAksGIaUndnmbbBVy9HoHa07GW2/e9VmHXE6L
4khFjbIYaSo7A3on78kDLHVBm4gINp+naRXRy7EyVLidBin3Cy8zd2k3DZUQJkp4
qgk4Yq1xg7sMKFXSYvRtPA9Cekc77luwaqCYdqobkQEEAx3gK9Yz/2ie4fLDU6Eh
Ah1xrRwAvJyuW3gDRfWp7axx8Wj7a51MtXNvSfrrR/2PIJXL/RNDXisF0BAgKQZy
mFGm0NOnnq/H6AtWQJaBuUs+tWWbECc3ql3jujhqptJ9mA5Uh68J5ClkWoxPqkuS
dtQFsD4t8A12aL2rlYvvif6fm1KICktZgr5RdyxYmVBjxwovJPjvS/4CHaZXfxwA
46n7lvC7LrkRJFbWNR+2WdQA7pumZpgS++d5Q0zat7x7DuyISRlMai9KuYtgr7wc
WubClvxS5eyLT0lvskgeD5iqTtRjjvU7Z60P/3c8uHVG1GGcufAEuSx1cS52kAq4
PeQP2Hg4hKKxg7Y5gKva2FoXZEuPddTDyTlNNLIVW1s8bpNzkBgMxiukKLWovDdJ
xveYajJdHlZRFbvJxzv7TTbTTDcl2W9sUav2ztAIHO32kO/uG0M=
=wvAa
-----END PGP SIGNATURE-----

--4qvqun6j65tse7vm--

