Return-Path: <linux-fsdevel+bounces-8143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9434D8302C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 10:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0991C2131A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF96914275;
	Wed, 17 Jan 2024 09:50:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2109.outbound.protection.outlook.com [40.92.73.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8314614264;
	Wed, 17 Jan 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.73.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485026; cv=fail; b=T92lGWoGT6qqrUX8cu7eqiw7/4jDY6O7M76aZvZ02FUiI2Yz8G+WxAXFlk9OPqJCuPimp2CoHJ/fym/EmqdfzrshrPvmJXOsW3DDDFfEtP2y2SU91QJ8j/K7oPjUBM5ctgjnL7C/zIsPHKL4fbK9pIBwt46oRGinogFg3bD5iVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485026; c=relaxed/simple;
	bh=YAQ6usm7i1mtCit1YL3uGbXnVgbGeSbX+ATC1/rZa0w=;
	h=ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-TMN:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=nIcFXdm3bMzY7/8steIyyEnILxsqLPXk0qXZzrRx1jkOOE3oAO2jZ+ImudYpawDYqZLmuAhYUL6A63Ll6LCsJZkKyIUmNiS3GdZcWB0z5vyW2zZ3WLfdfkmAZRywNW57w2YQNB+BV9Ylido0cTOBhyREBWnjs92R1a2jb6c9JbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; arc=fail smtp.client-ip=40.92.73.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuRchGId7vudaB70dHqTEMPAG1xAdVyV4Yo9jp4lOticKUuIYGidosfyMArDOGY6do9xlCKb0ujkqz0KNSQsqU7iPVVXl0N1V3R7xhXByXLt6zQK2SPuLwj45jHvtqC+KfQsOSeh2VLJbzjybua9/cRUJeNNi8u0NAbjQCF0T9dHrzJPMBWC7IdObnCdb4SLeYmQTsVvuDePnnTrfn6PRsHOvjPmQC5t3/08Xc98oKLCyCAaEVUEh1S1clFi51hqqgOtrEt8fUmQnAVoKlPNDCmMmujvBuFO29Q1j7k83p03PlCCx/kYwoReWwLDFas1huZnWn89/svefOj5rI4/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngBKJQzTnGcPenI0VR4L67Dis8vzs27DKdd4wRD6qKA=;
 b=fXtZvi+SB+RWf5DFsEjAXyyAS2PsV9paSXPrLfDf45APC9eKOv3xHp0ZyC+dNG2MUjJTTLPsxjCVjnaNeP2w6gNS7Z7tukY0At+u715lZlv7T9dygc/5bb87JzXQvAUS8K+lJ2xWX6KEaga/U51G8BH1EV9lGTF6fGVpQY27HFvs1TyZA+6Npl9faw5rnSEA7eXcDosp17J05TMb/v2HGQAnZbIKz7B9HI01jiDk6m0put+ehp9+Jvw4AQsUsmydZhzXgJZXqobvyXKSKlYLH6deUOW64v/pdmUHroyrirHFnSLpW14auD2PNkokiwkzzT64A4nyRtlg/Uq+A+8MSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by PAXP193MB1582.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Wed, 17 Jan
 2024 09:50:19 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 09:50:19 +0000
Message-ID:
 <AS8P193MB12857F0E26BD5C8D1BC632F6E4722@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Wed, 17 Jan 2024 10:51:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14] exec: Fix dead-lock in de_thread with ptrace_attach
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Serge Hallyn <serge@hallyn.com>, James Morris
 <jamorris@linux.microsoft.com>, Randy Dunlap <rdunlap@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Helge Deller <deller@gmx.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
 Adrian Reber <areber@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 tiozhang <tiozhang@didiglobal.com>, Luis Chamberlain <mcgrof@kernel.org>,
 "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Frederic Weisbecker <frederic@kernel.org>, YueHaibing
 <yuehaibing@huawei.com>, Paul Moore <paul@paul-moore.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Stefan Roesch <shr@devkernel.io>,
 Chao Yu <chao@kernel.org>, xu xin <xu.xin16@zte.com.cn>,
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <dchinner@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Zheng Yejian <zhengyejian1@huawei.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 David Windsor <dwindsor@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Hans Liljestrand <ishkamiel@gmail.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <ZaWJi/N2Dtye3aVs@casper.infradead.org>
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <ZaWJi/N2Dtye3aVs@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [a1slPzDbHiej5yQ5B6H71L47/jDSwUtTwd4wZciRfoD6o7RsHe2CyRGURISCVsMZ]
X-ClientProxiedBy: FR0P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::13) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <1c6bc4f2-4e75-43e3-a77a-a08f15467cad@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|PAXP193MB1582:EE_
X-MS-Office365-Filtering-Correlation-Id: 88918171-dadd-4f09-1ae7-08dc1741b6c0
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmqqMbmmUl3hmy+2IMtEJKZcwk92VJ/r+pDByb+73YMPZVlRtVvNLFeTdAw/oHz0yQoai782yWJyyyJkqbEN0QOaf4RiWYe0LH5Ib1JZtDWthECpdE50pBCEIoJTNmH584porW09MRopAb8DPbYIzExfX3SgQY3hBCilpZqiU88jy8d77Xa4LDX4P5VkHHGGSyihOYXCaA7hUItCH/101GG9oWg1YR8N66uKuOP6+do2KVnrgNSTqYd0cTUppvj1OH9IvmgMBYUuk5xIkd8xxHeiyl4qS5PzqUTXBCJkG9E4/8MJDAeVXHt0gaaKz0x2zXUt0OcK9BQrSRuTGuupl++nrKBYaeUZSME1zAKNOhwcJ+K/fP/anFnv8cvPfIdqh9x5/yAkZqCwyuk1mWIRWULbW4yZCEeAsxnHjntiCCpvvRo6O8vSZcW+U9z1/16Os2GAk48til74U2XA2N4nbOoq5z/0bMjo4+t8xnQwgCUNLxgyP9p6M1Nb9NPz1ZsYfKYpRgg8X0Vy2uLImFAd8TD8OrZ0cGEDSiZKkECZ/ehu4tiQPpB6CXHGATWAxDUP7tHtG7c7P+FuXZHEW+KoIAajKNSqpGtdkc8v7Pls6YPsaLEJbbS7ulcWDs5a3SsIunsbifDEVkkyo16ox8u29IxfOI6Cqu9QnK4wPxeNBnfZDjmZZzrF5z8dCdp0n+akQiK6zZDipXpM9i0A3lHt1WIUda0NZetPb29T7SMiHpphgQjcYXYmHn0Nfauv1dFIjuI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NQ8ErT2tMKKFlHA36UP2ewGm+R9EA3dq4NC67GDar6b818qWVkkwggJ2mycWanIGH46X936jDjDn+RosKGnhm8sy/Cx8U61Y3MrhimYgHqn0ztOf6Te2GZTztwLScqY0ySqnos5xvwM+5w4P90r02/fRNjlJayEU6jVds8GIcJGJEqNjRwsNkCQF+uyQE8pTxRKnLL/FA8Cv4CeT4VYpfAu4vS7Zr1/XHxcu25pUX9nQh9V8rsHIR0jsQU47KlCtIPYct3bpfDUbiKqzwIThYSfDHXHv1miL2RjtIfkD3zWm6wwFK8l4YVTVLSZ4kyo/JN4gZfm93bzHTlHNbBvLDovYeyjn8x36S78vOoojGF1kMSjEzceJ+zxhzU1wF/OQrN2vlbjUvbKhUllQkmdyEmAPcNUobOYnpJNFYMvaZlg/NgZnSNthK9y/j0tKcY2YG9n6FoY49utkEj/NHPvHNNkMryaI7hP4olXjEXvPbWTEliMSyKiCMfqfoFaB2turL6c02Kc694+bfmxv24RNZnHCkSpcpQvdOoS9mKlXLwl/btUNW5xpYnd9lLT4lNbC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXE1UEVzeEZ1eDdEVk9obld3Uk5GUTNCVk5TaTN3NHdkMzZKMjNMVENZNllC?=
 =?utf-8?B?NVZtbTRTdE4zbUdScDYyZkJPelNEYjYxK1B6SS9kSlk3WWpWRWxiSjFBdE16?=
 =?utf-8?B?dmVmZWc3WWsyQmZDbjA5bjRQVWdtTy9mNEUzUnFZTDZzM0dJbHVreHE3ZlVa?=
 =?utf-8?B?T3FYTGRPaGxXdkhpQzlzWnBmNDE0VWFaRGNiWEN6WEtrSWdORGNFQUE1eUF1?=
 =?utf-8?B?ZlhuNVNGM05tOTdpSE9leWxPVm5aT1hFNHhzZ1d2V3dhbDJsU25TRzBab1JS?=
 =?utf-8?B?SEZReTBZNUIyaTRuM0hVUGFLSXFETEpWODZuMk9FY2dFVEVrQkdqTVdhUFpG?=
 =?utf-8?B?aVRxYUpDTGFsdzkwZlpxb3Q3R3BBVzVwWW9JNzhxQnAvZHRqcmFOelJFaUZC?=
 =?utf-8?B?YWp6MHAvc1VYRm9EZmx4UWQwUEg1eEp2WDN2N0dZWWRmRE5KbVhPaStxZldh?=
 =?utf-8?B?aTQzT2luTTlEY3hmSnF4aTdCUHpFeVUwbFJldC9GelhHd0EveWtSVHI2eWhX?=
 =?utf-8?B?NlozeFFYOXdSMHdtbC9kbll0c3RmeHp4ZCszT3RHdzRCMkRQVjNFbFdUTWk2?=
 =?utf-8?B?T3Fmc3VEb2tCZm80UjBDYVNRU1J5cUJkNjJSTlB5SnBGbTlXQ0RmaFV2Skt1?=
 =?utf-8?B?aDNSTzFFRHpQQmJkNlVaN0V3UEN0bjhyUmVvWFgvVzlwQ29paWhvWUZyRldv?=
 =?utf-8?B?cDNVaWQzOW92c1c3ZXV4VnhJdGR5YlliWHk3enlQSjlERVFIcnRCVWVtM3hF?=
 =?utf-8?B?Rk9rbWkwd1k4c3krclJUUHM3SE1XNFdLdjh6d3R5RFk5YSt5V01qUGNKZzI1?=
 =?utf-8?B?ZTdRMWZsbjBHcFJtUjhtcXd3ZGRaS2dYMVpEOHZyK0VWTk45L1BHTlFHMlVp?=
 =?utf-8?B?NHdpRXhPelN3VWFWYmprU0V6K3VsNENSWklhR0lmZ3p0SFE5MUdPRyt2cEs4?=
 =?utf-8?B?c1ZRRGpTSVRZWk1GdzVyT0NibEorNnNqR3NqN2tGRjNCOHpxWU5sRE54akIr?=
 =?utf-8?B?SUo5cjJaQXl6R3V2YjVLbmhCTnAwSC91Y2FnM0cwZ2prTGFNS2RtWVE3NFdK?=
 =?utf-8?B?S1dsRTFWeU81bHZ3WUYzWk0xNUhNZUFUWjhTS1QvT09mNFJIb2RQTk92TEp2?=
 =?utf-8?B?MlJhUnhMQjRidk1iOUF2Q3FVdnU2UFpob01CSURPNEJUcXBZSUhoRTZ5U2NJ?=
 =?utf-8?B?Z0RxOEJmMnhhZmtEQ3EybzRwUFBTYnN5NVJQQ1djL0VGbnk1c2h5aSszMWho?=
 =?utf-8?B?Y1hZT1MwNHNIR1N1MVpZaG5FdTlIby9MYkpkV3JXNElRSU9RMWlld1kxd0pO?=
 =?utf-8?B?WmxhNkM3cURyQWRNb25MaHFQS2F2TS9KNTI5c1N0bnNkZ2dQYVByUXluUElr?=
 =?utf-8?B?RXRhYldialpUYTgyZGlmQ0M3WWg2b2h0VjZ5ZllxVnp5b285ZXVzampWYUsw?=
 =?utf-8?B?emZEUHljYjloRGtBS1NtbnZUdEsrNitTL1R3MXovdEZPdkRhOTVvN2YxNWVT?=
 =?utf-8?B?cmRQRXBhRlhkcnMyL0trbEpkdzJSbGJPOUJORFAwTjRYTURjR3ZJVnpZN1ZP?=
 =?utf-8?B?c1k1ZzRXSzJNUE0zaTQ4NFJ4NjRhS2pVUmJkL3BZcW5kUEhYWkFLZUhNb0ho?=
 =?utf-8?B?V215cStmeVhHZUxDRWQ5Z0V1amV0NVdLTHlaenladmNrOFJYRlU5S3RXQk1P?=
 =?utf-8?B?WHcybjlzRWhRd1k3VURKT0xRM3JVM0NJRWd4VFZFd3pkYzkwenVWbVZJMjFr?=
 =?utf-8?Q?LBquwdGaRfJoIGjXAo=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 88918171-dadd-4f09-1ae7-08dc1741b6c0
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 09:50:19.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1582

On 1/15/24 20:37, Matthew Wilcox wrote:
> On Mon, Jan 15, 2024 at 08:22:19PM +0100, Bernd Edlinger wrote:
>> This introduces signal->exec_bprm, which is used to
>> fix the case when at least one of the sibling threads
>> is traced, and therefore the trace process may dead-lock
>> in ptrace_attach, but de_thread will need to wait for the
>> tracer to continue execution.
> 
> Not entirely sure why I've been added to the cc; this doesn't seem
> like it's even remotely within my realm of expertise.
> 

Ah, okay, never mind.
A couple new email addresses were found this time when I used
./scripts/get_maintainer.pl

>> +++ b/include/linux/cred.h
>> @@ -153,6 +153,7 @@ extern const struct cred *get_task_cred(struct task_struct *);
>>  extern struct cred *cred_alloc_blank(void);
>>  extern struct cred *prepare_creds(void);
>>  extern struct cred *prepare_exec_creds(void);
>> +extern bool is_dumpability_changed(const struct cred *, const struct cred *);
> 
> Using 'extern' for function declarations is deprecated.  More
> importantly, you have two arguments of the same type, and how do I know
> which one is which if you don't name them?
> 
>> +++ b/kernel/cred.c
>> @@ -375,6 +375,28 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
>>  	return false;
>>  }
>>  
>> +/**
>> + * is_dumpability_changed - Will changing creds from old to new
>> + * affect the dumpability in commit_creds?
>> + *
>> + * Return: false - dumpability will not be changed in commit_creds.
>> + *         true  - dumpability will be changed to non-dumpable.
>> + *
>> + * @old: The old credentials
>> + * @new: The new credentials
>> + */
> 
> Does kernel-doc really parse this correctly?  Normal style would be:

Apparently yes, but I think I only added those lines to silence
some automatic checking bots.

> 
> /**
>  * is_dumpability_changed - Will changing creds affect dumpability?
>  * @old: The old credentials.
>  * @new: The new credentials.
>  *
>  * If the @new credentials have no elevated privileges compared to the
>  * @old credentials, the task may remain dumpable.  Otherwise we have
>  * to mark the task as undumpable to avoid information leaks from higher
>  * to lower privilege domains.
>  *
>  * Return: True if the task will become undumpable.
>  */
> 

Thanks a lot, that looks much better. I will use your suggestion as is,
when I re-send the patch next time.

>> @@ -508,6 +531,14 @@ static int ptrace_traceme(void)
>>  {
>>  	int ret = -EPERM;
>>  
>> +	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
>> +		return -ERESTARTNOINTR;
> 
> Do you really want this to be interruptible by a timer signal or a
> window resize event?
> 

I think that is kind of okay, as most of the existing users lock the mutex
also interruptible, so I just wanted to follow those examples.


Thanks
Bernd.

