Return-Path: <linux-fsdevel+bounces-20062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DA38CD672
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 17:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D4B1F22C47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F8FB653;
	Thu, 23 May 2024 15:00:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2130.outbound.protection.outlook.com [40.107.92.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E19B645;
	Thu, 23 May 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476450; cv=fail; b=AFmgp9ZaOxtxZI4GD9gbQ5x9CCEGCgVbOBH8/kpaThsa/gHQptjowLPs590/p5R7xbh19KYmCC4AU5Wxuk/x1pWKZpYFszayjmzZdzOnTkI6ZfZ3jeq2lEGCGcP+dyibcIgkAS7bow28HHlbq8v+oVfuzhj5rszXzruf4KbdiJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476450; c=relaxed/simple;
	bh=scs7kERhFIvKyKTZj/mmkY4UBNau8RrNbyOCZDQkeWU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GfaY2E33WtLyZGkv1A5e8En661Mvx00CQ4HxGcfSLINb0prXRRZ9AWjC/TUnBxaPjgT/jyOtVQkT0xpd+5l/HpAVVCntIqMoH5Buzq8JXRq96NIHnaPJEkprJKteSwnBMEBgeVQpwL1sLSAbBGJa0vyhjoHcmZr5/014iCrVwCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.92.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKIgPMo8fY4rBziWKmAsxbwAb/adU4KXD9U9HbcLJxBKfcpnGq52csvq4X/wlkPHvuTWvMBwrm1DbGqVCVUlqeLgg1uDa3ceLbfhTqL9sX1DqOdIgB8cM4ocxohl8yfHYfVUMjQ71lohi0/3/7uIuLbDEqUOQ8vQcoSjqhbwaJxiE8g9gFrBWWztUj0Bc90B0w15jz8UDVjaEdWWUEDawru/D2FztQxEJF3RoA83woCwYeE/Z/PGOD9N4G9vtsFqItmoIcSxokPOdh+FUHe/35/aPanxsJkHjEBw+EsQIn5KiUoxKo6pEN/qNkjxzBLP8IdvKUp8FWChBfa3Siis0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTxQSjTX2oirq1SG4X9otd894ft78cRklL/6OlMCAUQ=;
 b=Xcfqr9LkcG56DVRHsLBjuvGrc2WEJO+coyJEbQaa8UK6l+yeR1cgHX1SrZjHOZMAyRhLBJrFqWfaw1F94OZ+0Z3/LvWu/auQYp+8g4sa10ZTZlSoYiY5ytzddZcmYpWF/n3NYOzmxg5oGrs8UoJ8TG206/ybSa74av6HdWtKLGI7cuNi4+uU8zfVcdXG3ZJU3x/QUU0ZB+dsYdWTJfr3csTvbfuhEsXi1HEsrlpveP09iZigt3kx1Xu44MeB/IUtk59ELHJSILzZ2X/VeO8mo4Ad6wVBegvQ6e3vg24DOEYVvMlMiuxTbB3ibBgbSieOp/2e8BhikM/ODqUw7qnlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from CH0PR01MB7170.prod.exchangelabs.com (2603:10b6:610:f8::12) by
 DM4PR01MB7548.prod.exchangelabs.com (2603:10b6:8:5f::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Thu, 23 May 2024 15:00:43 +0000
Received: from CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::97c:561d:465f:8511]) by CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::97c:561d:465f:8511%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 15:00:43 +0000
Message-ID: <28473e0b-bc3e-410a-a502-184595ae6f6c@talpey.com>
Date: Thu, 23 May 2024 11:00:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cifs: Fix credit handling in cifs_io_subrequest
 cleanup
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
 Shyam Prasad N <nspmangalore@gmail.com>,
 Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton
 <jlayton@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <536b0f03-db96-49a3-93de-d9ea835e8785@talpey.com>
 <469451.1716418742@warthog.procyon.org.uk>
 <581217.1716475935@warthog.procyon.org.uk>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <581217.1716475935@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:208:32f::22) To CH0PR01MB7170.prod.exchangelabs.com
 (2603:10b6:610:f8::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB7170:EE_|DM4PR01MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2a413b-dd0c-4422-9ff3-08dc7b391e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFFEbVlvckl4SGhhZGx2QWJYdVFKVFA2TU54eGVpajRORzEreVVVUGREd2tm?=
 =?utf-8?B?M1hhQzVyYTZJMk1FOHpJNXdjUkNYZVJjNEJPZndhQ0RieVBjaExwdG1OWlVD?=
 =?utf-8?B?Q0x6ZXRQMjNUSmhDZWFDbjY4MGVXVTNmYjlDdUJZYTYwMlBWNHFnOXhvTEM2?=
 =?utf-8?B?NFMxMW5uUVM3aCtScWVvdkpjUnFLT2JNdjJFazFwdFFkNDVBa1ZRYXJYd2lY?=
 =?utf-8?B?K0YxUTF4bnIycCt1Uy9wL0VHL1M0T3NjMVJIcWN5RFBZOEhTb1RWUWwydEhQ?=
 =?utf-8?B?WkhTRzBaVDR3cXBjUkl1S05QVG95K0VhaXR2Ri9YOFU2d2h2WU12WUtKdjZ6?=
 =?utf-8?B?WXNxZ3FoVWg2bENTMFhGZmRwbVEyVzhRVWphNmVQeG1pYXdDbHZaSm8yd255?=
 =?utf-8?B?b24xY0ZHYWVVcEhFTGNZNmNabjcwRkVhZGNEWEl3emMyb00xZlI4WGxjK240?=
 =?utf-8?B?NW42c2FFblQ0Vk5wamRiQUduSmRlZk1JOCtFdkQ3RWRiNHkxc1VJc1NJTzhN?=
 =?utf-8?B?VTBBOFo0Y2tCTGZWUzRoM1k0NEJIWHF5dHV5KzMxcDlKY3p2QTIybXFaNEMy?=
 =?utf-8?B?dEdVR0gyYitjaXRIR2FSOWlLbGUrQThSSDFXbG11amNBVzBUcHJoNGhiQ29W?=
 =?utf-8?B?Tzk5b1ZwWFkxeTVLZFhwdFk4Y2NNR0kweXZ1L2RPRTcvYithQVI1TFYwcVh6?=
 =?utf-8?B?bG9HNlA1Y0xZWm9Bd0JkL1pjYnpoWm5CRGFFQXZ3QnFFM3drbTJvWDQrS1NQ?=
 =?utf-8?B?Wkl3ckxoc0pBUVJDai8xRWl6WnFBODVueHRLamJGc0FXOFoxLzljUkxvR1hG?=
 =?utf-8?B?aDJZQ0VjaGh3WEtzWUU0OE4yQXpVdnZFV2p6bXlDMGlJNnFyRFZaMnFXVGFp?=
 =?utf-8?B?aWlmSjRCUEhzT1c4eEtQMjVXQ3ZDdU1UY1hVMzNoZ1E5b2VGVW91cEZaYU9q?=
 =?utf-8?B?R25nTm5NYjhuVk16VzBhS0l1VXpLUWQwYlhJdEt4ZmNYcnFIeUFmOGFVbkxn?=
 =?utf-8?B?VVZLUjlBYjk4VVdSazQ2ejREU3A4UTh3dnBWOVV5b1BXMVYyRG1QZVU5RUpa?=
 =?utf-8?B?cXFtb1hZL01PRysrOU5vakpzQlZ0ekY4OFRjQy9RdmJ1M3p0NkdMVUVOTmgy?=
 =?utf-8?B?L1lmMlZwS1BTWjk3dHVBYlBmclk4d3VBRVhzQXRkeGxpWlN5VG1jbm1URm5i?=
 =?utf-8?B?bGdsbzNrOUhyNmpwZmFlU2dlS2dPcEV5ZmFZZ3FrNllNTlIza3g4VWRremoy?=
 =?utf-8?B?QWZOVFB2TXBNNVZZWjFoamJvZTJwUjY4WFJvZnFRQVZ4c2x2TmRxa0k4VTdq?=
 =?utf-8?B?SWYzczBhTFVNbGxhSi80RVVVeHdHa20wdm9mV0QyUS8xdUNCc3Y3MzBpb05u?=
 =?utf-8?B?a2Z3RWc0aGZISjVnZEVWeXptWmdtbGtDSXhodC9ZbFFVNm11VFY3c0hiclFz?=
 =?utf-8?B?TGo3UTZlODYrKytlbTQ5MHZ2M1Q3Zm5RYVJ6RXNjd1FzNEZRVU0zckZxMzA0?=
 =?utf-8?B?Yk5EblpvTzJiOEM4NXNWM0RoKzE3WVExb3JPekRmR2FXK0xVTXAyc0J6ekZi?=
 =?utf-8?B?NTJ4bkhkbTNqQVFaREZ6QllZWFVQRWp0Y1pCSXRKc3l6MUIzaXA0ZE5ReWRD?=
 =?utf-8?B?WnJwRTcwdFF0VVkweTRpU1dqVmlUWlExNk5uL2UyeUNveUFyM1cyUWZOc3Nz?=
 =?utf-8?B?cVIwQ1c1QkxPTnUyZmRiSzBVR0xWNmxHSTUvLzVwR0dnUzhjTUNEUDlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7170.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGZrc1RHcHpPWmh3VlpsaDFxYWVYaEVtZ2VrNEF1ZWFDbUxnc1ZuTmhLN1px?=
 =?utf-8?B?VnhRZXNJYWttNWdiTmNSNlQ0TCt3UnEybVJwMWJFcDZ2TG5BTm5UaDBDQklz?=
 =?utf-8?B?VGhVMzhTZGppam40c0N0UGcwaHpSSlkvekJ5eGNhWFJETnZVd01PVGlWdm1y?=
 =?utf-8?B?NktyRzZNVUpwZHE3dHhDbDN0N1hkVnlvZW8zbVZnVjkvb0NJYVR4UXVxR3lC?=
 =?utf-8?B?SmRicW1GVmU5bVpTc0NGbDZFWVZoK1MxVmd1cXMweDcvNlh2SU51eXlKZC8z?=
 =?utf-8?B?WnZsK3JjYU1UeDdReUVmYVl2L09jaUVzTmVmN29MM00yUXM1dWZMeXd2bG05?=
 =?utf-8?B?WDRhYmNNWkQ4OGhFU2F6T2h5bDU2UUplY1FieDVQUTA0Ymx4UVlPcExyMjVl?=
 =?utf-8?B?VDJSeThKa0luR0I0MzVsM2JOeHlzNjdSNjdVN1RtUHpWbk5wRDNnRTNvbXBE?=
 =?utf-8?B?MnNhNXRBOUVvZ1BUQnhHT1hiblIyQkpRV3QxdVA3Ym1hY0ZGdUJxdEtHazB0?=
 =?utf-8?B?Q3NOaHlndENveHpKMjFaa2x2NkhmMTdHd3hab3U4STlnd0piQVBGaTNZM2Mw?=
 =?utf-8?B?S0FtTXFiSDZFK3lhUFBRRlMxUGRYM3EydVhoaWtCYjZ0c3ZJbFd2M01Scy9S?=
 =?utf-8?B?cE9rSFRJQklnRWNhVFU2ZUxuaDN3QjdneS9QQVJZenZYcWFLU1l5Yy96L0VM?=
 =?utf-8?B?SnJJS2ZzWk83UXBvZFBKNjc2WVlUWDhnMks3cldBQURacmVodzJUdm5wbTVw?=
 =?utf-8?B?cTlQcVR0SGkxRmowdlFmbDBQZjUvSXdKT1lNdWxxSHpDZGtLUnI1cUJKakdU?=
 =?utf-8?B?QXhsL0c1VGJlY29jM0tGalpVK1FEVWVSL2dGZ2ozRWdMU3lFUVZFMmIwcXlL?=
 =?utf-8?B?dVVnZTd4QlZmOVRGcmxDdnlFSEdaYXllUVZwR3ZGdk1ZTDk1MVYrQ21IVERV?=
 =?utf-8?B?cjdnbVBhTUVpNEVIRlRsUUhSUmp4bGwrN3pUUDhBR3NONDd1MTIveUdkY29a?=
 =?utf-8?B?NlVQOUNsSUdlVG84RzdzUXVxMTdKNTJaK0dieXZDdDhqNmgzcGFCY01GQlpp?=
 =?utf-8?B?bklVTktpcFpuK3paL3FvZGduMWdNdlNLR3pPWHhlNTBNeElrd1M2QjFRTklt?=
 =?utf-8?B?L1R6Tm0wU05OOHo1SDgxdndpa2I5KzF6TU9DYUNjc0dDcUg3QklZaUpNMXhT?=
 =?utf-8?B?dzc1UWxmVThxTFBaeFdWZWNpQzR5ZEhsazJheUdwUVltSkI4UEkwRU0xOGFB?=
 =?utf-8?B?bFJWcDZvZExkYUI5S3ptTmRNaEFmQitsYjdPNWpveVNKUVBwZVFsUHZmNVVu?=
 =?utf-8?B?aVBDQms5bmJyVGdBYlVEdXNCVTNhdW8xK3pmbUpNUWVkWGt2UENBVkxJN25P?=
 =?utf-8?B?ZHpqckZCRjd6ck5xYXR2QlJ5Z2N4eVA1d2FvNGg4SGJvT3JLZWtGeG1OTWdU?=
 =?utf-8?B?QkYyYVU1Y0N2TTlzM3B1b3FaNkZ1Q0U2UVplUzJwcjlhak1hWDFsQkxhU3B6?=
 =?utf-8?B?d0dpMS8wekFVUXhqUlhrMWgxNWZlNzhOK1NxRHNSU09Fd2NvU1BQNXNBYlVF?=
 =?utf-8?B?czBhN1BCRUN0ZmZpN0tBVmF4SjdIc0JPL2RSMEtQdmlVUG53dGxuS0JTaWVo?=
 =?utf-8?B?V2luY05DVVJoZDFrNHBMWHlJZnhmYXo1Y045Z0tYVGU5Qk1hT2NZS3F1ZG5J?=
 =?utf-8?B?QWhKMjdiK1krMU5qL3daNlN2VFgyTi9lcFprbVBvaWJmQ3YwUUR3ckNMTGR5?=
 =?utf-8?B?Y2tSRW1oTXE3R2R5eFdLSTlwcCtKaDRRYXJGc2U4RDlqRWFLcWhxTmFBZDUv?=
 =?utf-8?B?bVFHbm8xcW5zR3RtQ1BzL0l4MTRuZTRZRmlSNkV5dkg4aHpRL2tpalV1NnNE?=
 =?utf-8?B?b0FvV0hhQ3R4Zm5jMEpJM0toeTNzOVdpN001N0crMy9ySjkveVZQR1dBV09Z?=
 =?utf-8?B?WFNPYnZXV0ptb1NSUlp2U2NoQndTTEpUR1VVMFNBUVZLcVRBV3pTRUVndGhU?=
 =?utf-8?B?d3pxZ204OWJ2WEdmdzFpOG1pZ2xzekE5Y3JZbWp0UFNNZnZKSm5xZUhqcnJh?=
 =?utf-8?B?ZzZsUm9wWGkyWDY4MUhaMVZvYk9zWHJTTjJTY3V0cVdJVitSZ2FkR3phQXBH?=
 =?utf-8?Q?MeQDBQYte9ZPzVWElQQ4PmaHG?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2a413b-dd0c-4422-9ff3-08dc7b391e32
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7170.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:00:43.2584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0XQ4XQz2CzLP779s2Cg2L/cd5G4zDLNlyuWxj8nY8iDdvpTYDjW0ksinOD9MYmz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7548

On 5/23/2024 10:52 AM, David Howells wrote:
> Tom Talpey <tom@talpey.com> wrote:
> 
>>  From a protocol standpoint it's correct to reserve the credits while the
>> operation is in flight. But from a code standpoint it seems risky to
>> stop accounting for them. What if the operation is canceled, or times
>> out?
> 
> No idea, TBH - SMB credits wrangling isn't my area of expertise.  Note the
> patch is superfluous as smb2_readv/writev_callback() clear the credits at the
> end; worse, it's actually wrong as we're not allowed to touch [rw]data after
> calling ->async_readv()/->async_writev().
> 
>> I'd quibble with the assertion that the server will "give us new credits
>> in the response". The number of granted credits is always the server's
>> decision, not guaranteed by the protocol (except for certain edge
>> conditions).
> 
> It does give us new credits in the response, doesn't it?  In
> hdr.CreditRequest - though I suppose this could be zero.

Yes, credits are consumed by requests and replenished in responses. One
credit is needed for any request or response, plus one credit per 64KB
chunk of payload (read, write, etc).

The value in hdr.CreditRequest is a hint when sent in a request, and
a small-ish integer, very possibly zero, in a response. Often, it
replenishes the credits consumed by the request it matches, but it can
be higher or lower at the server's choice. And it can be sent in any
response, before or after the one you might expect.

Tom.

>> I guess I'd suggest a deeper review by someone familiar with the
>> mechanics of fs/smb/client credit accounting. It might be ok!
> 
> I've given Steve a patch to try and find where the double add occurs.
> 
> David
> 
> 

