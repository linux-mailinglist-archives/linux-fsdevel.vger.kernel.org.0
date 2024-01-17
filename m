Return-Path: <linux-fsdevel+bounces-8168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127A3830927
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C6D1C2117F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 15:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F9221347;
	Wed, 17 Jan 2024 15:06:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2109.outbound.protection.outlook.com [40.92.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640AA219E2;
	Wed, 17 Jan 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504006; cv=fail; b=T0WFj87lNirKSYDchkP5ITeJgcccYqK2G2AK/8v6eTa6BwHHJcw3oCTekJLii9eCz9jFV1P+ZirmQ3HlMzpGJAPNm2NqnHnZiS1tblXGyJZfKpcod8Wvdgs9tQpRtLm+wkljg3leoGN25CCN2eDjJjfsZPCPo0bwiVs0fJkRcvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504006; c=relaxed/simple;
	bh=HTgVbkU8aBK1AEuTb7WrMcBbwr1clgxj4mLBCA3isc0=;
	h=ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Message-ID:Date:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-TMN:X-ClientProxiedBy:X-Microsoft-Original-Message-ID:
	 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-Microsoft-Antispam:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=JPSWi5/Qm/Je5xOTyj1JD89oVMmWqcNF42yuU2m6GnOM+vNoEELs1FKwu6iIKcFVilhQychGe2eYJPTeuK6EUvpRLisPZ+EZPOeXlmvMV8A3tUyAABPM5OaBV1SJqV+d0xZxOM97EgvCFMeDuozrtZ6qbRA4KzZ0Zk0LS5MNnck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; arc=fail smtp.client-ip=40.92.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REFPQqIcuQ1rraNAoGtkkZ9D0FIddCwrj5isYDPQrVBVfXHUq6TfGBcjzRK5ahmRVSiM6jdJXHjcgsT9d293JR3TFSyQMWZsKvN1e5d6BeY3LexSD5pi5de0k3azSNnqWeSsN8IcRKw6Nr7r2T1NSfq8wx75WjsoKjEdv0fspKP28EXn9dArSJy9JTuhEpkzAAqtv8d/1dCR2SCziJnbUQN7bGfFv/NKz4THQ+kzIxZyxL9lVRR6weu1Kx1SfFNwFbA5X/uLzu798YIp9dGDbNX1/Ac+RsH+EkU/iMQDDvCZpNPZu4EvWFP2ubG0N7R25ba68RLnTQkPgl9kRIAEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQuXagApWt4Daj83j5mM39b/7odNWEvLZirA0PEXUXI=;
 b=OEWFF4tZN3cl2dnlANzABGaK2lloIrMent/5bUdZFHTXsN9cj3EDd7iCBInnLnIEMJYbNGOfwLecHmWGfxWOJbK6qnAq+vqowbZamoBXKdQj3Ny6X7Re7/Rum/hjpGPV20aMMlUvvMas5/+lNnUOTdHmNb0pT/lP18isxCPsC8Htl//zVbjzSza88NmdX81tE6EuS0q1+Dd6viynIGnvxBIdgpY0mLtigBbOn1tbpWLy5CzM3Yiy3+RurBtdpH7OBepUs+qGU7pcscqVVcEAx7zMYi0xJJ5Z9xlrl2K2Jdg4xESar3cQ1CoZw4cMFd4jgdQuwHz3hfjQPgcxCt3UVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by AM9P193MB1015.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 15:06:41 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 15:06:41 +0000
Message-ID:
 <AS8P193MB128538BC3833E654F56DA801E4722@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Wed, 17 Jan 2024 16:07:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14] exec: Fix dead-lock in de_thread with ptrace_attach
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Christian Brauner <brauner@kernel.org>,
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
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hans Liljestrand <ishkamiel@gmail.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <20240116152210.GA12342@redhat.com>
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <20240116152210.GA12342@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [cKsup7P2HGb1RulCUzR0VWX2C3ZaJIr9lnrNEqibD2u+IizNXCtk7qzawAgnaGkt]
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <d1ee3d3d-312e-4300-a1af-b05173b9e38b@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|AM9P193MB1015:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f24e6f-a067-47eb-d010-08dc176de90b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yQPNeq9zuCjUwEYTZZH3YqiH3S6ZHuTam5ASCxj+jOBpzZYkioawQeu5MuntYq/5HxeCvWP4y2VIgdsIK2pCigJTZUGKOtlVnZLTCMFYWvCQXSsdyuOMhgtP7+decVNrTOsliTNvH8mrsBYLkhJbWo4dTmf5A0ONmdhbKy96p53vuuplfiie1mLMGREpWnoRkwmlgUtKbE7kGSFoWKfzIgOHQRSPsYAWMG1IsJHnwA8t1rkEPE/vLScUqh8DkqbL0JbRZzy1Xvrm5LzyZpYOYUf3hQo0rmPhmvg4QKRjLr+bFEZA3VgNq6R1RI4M9aZ7ILC4IXena0npQDcfKDR2HkeE2bPOYyXdKtCtIZVxhSfbX1uWg1en204B3qpuqmfKqTXavWYNk22i1Wm5vIiFEWkLU70qIw3o2O9YNcuwlcapiYiMbdMR3sGCV2zvqWoQpojxWoxXX2f3AZV0RqQsRTfl8IATmEiMLnS62zWnHQDPqsjUFwTPjfgHTlUw4V561nneBak0wguxaPugWuibXouKVQlPvoNL1Uj0BEcJWBkoyyVJu9QJZgmVtgBKM5ht
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHlVamdRbkdsanVRZnpiWWM5aDNZWFJmOEZkZTdHVDN1TlJWQklkekRNTUhT?=
 =?utf-8?B?WGZJdDhOeDV1ZHNtUVZVMFFRdHRMbndMbEJjRlpRemlrUlVFM2FNcCsxR3Nk?=
 =?utf-8?B?TzZrcVpTVk5UVEwxWXZGMTZmYSs3UU5mY0l0SmphMkl2Zmp4aXlVaWQxcFlH?=
 =?utf-8?B?aHQ5QTlWSkQ0T0dyUDFNMVJqc2JWU0VYcHZrd0w3WkxFMVUwVlJJTEQ3WlBS?=
 =?utf-8?B?NmJ3SktBNEkvUUo0Qk1IZXo2amltVkVRVWhZdGdzL0R1TmRieHJvMmV0Vzdr?=
 =?utf-8?B?RjlUNFFwWHhVR1ZESXV3NGhmY00vM2hzVTJyUTAwR1diRGRVOG9sNkd4NDhR?=
 =?utf-8?B?cTMrVUV2ek0zM2UzMmM2L0d4MnJVeUlWNWFJU0huaUxmWCsrb2JsNXZGelk4?=
 =?utf-8?B?T25meXBHcEtjdUJwbitsdEprUm1EVGEwWHZDY1drbENGVjJGekJiRlQxRWg1?=
 =?utf-8?B?S3hyOU5wdHB0UVBVV29uRUxFNGhoWTBJdEVtYXFSYSt3TnFMZHZRbXRGNjZl?=
 =?utf-8?B?K05PYTBCbGlyVXNOWml1a0NmM1VkSlFnc1hHK0RtNWFibzdKK0h5Y2djR1ow?=
 =?utf-8?B?TEpYUE9WZHRQajlUZzRnb2tEVy82TC9wTzhBTWpqMENBQU5ua0pRd3JxVDl1?=
 =?utf-8?B?TVRWaHhvZnRIdjdwZ2h1STZEMEc2UVh3Z0c4ZGk4YUhuNUVaeTN3cDRPSTJs?=
 =?utf-8?B?dkUvbTd0R3V6cTJkSnZtcmllK0xMTG1PeURMVnpjSzR4Wk9Yc1ZXR0UraThy?=
 =?utf-8?B?cjZMMEo3UFBTNCtIN3l0L05vLzRNeHI4ZWFKUXFKY25NVHpnVm1neHJ2Tkpt?=
 =?utf-8?B?UVZjNUtJNHYwUGhsRldPYnc5c2lNc1JqUUQvWEhiSlJtK01QMkZhWC9PNXFV?=
 =?utf-8?B?YW9SdG8wclc3NjFrVERKeGV0NHFiL1lIWXdBcnE2YzBIY2QwKzZTYzd4bDds?=
 =?utf-8?B?QzdpbGo0V2U5L1M4QnZhYXJCVkdjUHp1ZnpYOEhDRktBMnFsZ0psSEd5UXBW?=
 =?utf-8?B?OU93NEhBc1c1ejkwRktkOHBDalpULzZ6REF6VDVmNm5MQ3VpQzFHWVBnRXc1?=
 =?utf-8?B?VmpJNW1YcGZETzZlUzRxZmZ6VW1vMTF2WTNoMHZVSWQwa0tMZDlVNG81YW5Q?=
 =?utf-8?B?aC80WmJVcTlhYnJxSmRYVDhveUpobStNR2pDNUZvZElycm14WWlvanpSOU91?=
 =?utf-8?B?OFY2a0Qxdk5TS215bTdGakE2dXJFWG5ub3lxb09EMVorN2dnVEtsdjhlcGNK?=
 =?utf-8?B?N3cxL3kxMDFiemNzRzZYVWx1M2lUSkQxRExidldSaVVXc1gzWGt0UHF0dFpM?=
 =?utf-8?B?MDc4a3NJOGp0RE11b00yMy9OanRRbVlTTkJidUZhR1VVdFJKMmxPam1haS9B?=
 =?utf-8?B?Wlh3Rk9aWmpJR0pvbzk4MllibXYwRzlDa3ZTYTlJczFFL04yYUhvWG5yTG1Q?=
 =?utf-8?B?WWNnQVpCeXBySWQxODErd241VGRqZXlTSHF2TFVIQVozRGxLZXdJdmFBU2J6?=
 =?utf-8?B?Z2UwT0xqZWVaMWJhRFNvOXR4RzhTV0RMTWJMZStXNUNLRjh5MWJLZnl0eS9W?=
 =?utf-8?B?bVo5c0tOSU91RnNRTFVTMUd6SlkvN0pJa0VMM3d1Z0ZweGp3TUo3ZTAzb3g4?=
 =?utf-8?B?OVdOc2JpbFhkTUIxb1Vid1BEOU9uMHBkWlFWL0drTVdyT3M0TEREZXhMKzQw?=
 =?utf-8?B?azlOZTBCc0ZPbWJXdk1JUWh1UzE2SkFKalRqUC9PY2p5dlZWVjBqMURvemdu?=
 =?utf-8?Q?h1eKFB9sL2aPrbHHR0=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f24e6f-a067-47eb-d010-08dc176de90b
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:06:41.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1015

On 1/16/24 16:22, Oleg Nesterov wrote:
> I'll try to recall this problem and actually read the patch tommorrow...
> 
> Hmm. but it doesn't apply to Linus's tree, you need to rebase it.
> In particular, please note the recent commit 5431fdd2c181dd2eac2
> ("ptrace: Convert ptrace_attach() to use lock guards")
> 

Oh, how ugly...
Will this new C++-like "feature" ever make it into a stable branch?

> On 01/15, Bernd Edlinger wrote:
>>
>> The problem happens when a tracer tries to ptrace_attach
>> to a multi-threaded process, that does an execve in one of
>> the threads at the same time, without doing that in a forked
>> sub-process.  That means: There is a race condition, when one
>> or more of the threads are already ptraced, but the thread
>> that invoked the execve is not yet traced.  Now in this
>> case the execve locks the cred_guard_mutex and waits for
>> de_thread to complete.  But that waits for the traced
>> sibling threads to exit, and those have to wait for the
>> tracer to receive the exit signal, but the tracer cannot
>> call wait right now, because it is waiting for the ptrace
>> call to complete, and this never does not happen.
>> The traced process and the tracer are now in a deadlock
>> situation, and can only be killed by a fatal signal.
> 
> This looks very confusing to me. And even misleading.
> 
> So IIRC the problem is "simple".
> 
> de_thread() sleeps with cred_guard_mutex waiting for other threads to
> exit and pass release_task/__exit_signal.
> 
> If one of the sub-threads is traced, debugger should do ptrace_detach()
> or wait() to release this tracee, the killed tracee won't autoreap.
> 

Yes. but the tracer has to do its job, and that is ptrace_attach the
remaining treads, it does not know that it would avoid a dead-lock
when it calls wait(), instead of ptrace_attach.  It does not know
that the tracee has just called execve in one of the not yet traced
threads.

> Now. If debugger tries to take the same cred_guard_mutex before
> detach/wait we have a deadlock. This is not specific to ptrace_attach(),
> proc_pid_attr_write() takes this lock too.
> 
> Right? Or are there other issues?
> 

No, proc_pid_attr_write has no problem if it waits for cred_guard_mutex,
because it is only called from one of the sibling threads, and
zap_other_threads sends a SIGKILL to each of them, thus the
mutex_lock_interruptible will stop waiting, and the thread will 
exit normally.
It is only problematic when another process wants to lock the cred_guard_mutex,
because it is not receiving a signal, when de_thread is waiting.
The only other place where I am aware of this happening is ptrace_attach.

>> -static int de_thread(struct task_struct *tsk)
>> +static int de_thread(struct task_struct *tsk, struct linux_binprm *bprm)
>>  {
>>  	struct signal_struct *sig = tsk->signal;
>>  	struct sighand_struct *oldsighand = tsk->sighand;
>>  	spinlock_t *lock = &oldsighand->siglock;
>> +	struct task_struct *t = tsk;
>> +	bool unsafe_execve_in_progress = false;
>>
>>  	if (thread_group_empty(tsk))
>>  		goto no_thread_group;
>> @@ -1066,6 +1068,19 @@ static int de_thread(struct task_struct *tsk)
>>  	if (!thread_group_leader(tsk))
>>  		sig->notify_count--;
>>
>> +	while_each_thread(tsk, t) {
> 
> for_other_threads()
> 

Ah, okay.

>> +		if (unlikely(t->ptrace)
>> +		    && (t != tsk->group_leader || !t->exit_state))
>> +			unsafe_execve_in_progress = true;
> 
> The !t->exit_state is not right... This sub-thread can already be a zombie
> with ->exit_state != 0 but see above, it won't be reaped until the debugger
> does wait().
> 

I dont think so.
de_thread() handles the group_leader different than normal threads.
That means normal threads have to wait for being released from the zombie
state by the tracer:
sig->notify_count > 0, and de_thread is woken up by __exit_signal
Once those are gone, de_thread waits for the group leader to reach
exit_state = ZOMBIE, but again only if the group_leader is not the
current thread:
signal->notify_count < 0, and de_thread is woken up by exit_notify.
So his reflects exactly what condition has to be met, see:

                        sig->notify_count = -1;
                        if (likely(leader->exit_state))
                                break;
                        __set_current_state(TASK_KILLABLE);
                        write_unlock_irq(&tasklist_lock);
                        cgroup_threadgroup_change_end(tsk);
                        schedule();
                        if (__fatal_signal_pending(tsk))
                                goto killed;

so when the group_leader's exit_state is already != 0 then the
second wait state will not be entered.
  
>> +	if (unlikely(unsafe_execve_in_progress)) {
>> +		spin_unlock_irq(lock);
>> +		sig->exec_bprm = bprm;
>> +		mutex_unlock(&sig->cred_guard_mutex);
>> +		spin_lock_irq(lock);
> 
> I don't understand why do we need to unlock and lock siglock here...
> 

That is just a precaution because I did want to release the
mutexes exactly in the reverse order as they were acquired.

> But my main question is why do we need the unsafe_execve_in_progress boolean.
> If this patch is correct and de_thread() can drop and re-acquire cread_guard_mutex
> when one of the threads is traced, then why can't we do this unconditionally ?
> 

I just wanted to keep the impact of the change as small as possible, including
possible performance degradation due to double checking of credentials.
Worst thing that could happen with this approach, is that a situation where today
a dead-lock is imminentm does still not work correctly, but when no tracer is attached,
nothing will change or be less performant than before.


Bernd.

