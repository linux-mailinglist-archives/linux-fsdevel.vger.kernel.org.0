Return-Path: <linux-fsdevel+bounces-57025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41538B1E01B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 03:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0800418C6020
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 01:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5443335948;
	Fri,  8 Aug 2025 01:13:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903472E36E0;
	Fri,  8 Aug 2025 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754615632; cv=none; b=cOQTovKpxlyNx1vSH3NvqaPgK6MqMMVsM5548QkdjQgdNG2Fle92fsixPGl1ybYwQP6/qMlOEwSslr3i55cS4S8P25wwWYm/gvYLaNnuOQt4l0eMvdMkBaoXdN76cBsxRrddOGEYyCRp4bkCspdeWSAEENCAkagqVHbOq9+bYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754615632; c=relaxed/simple;
	bh=R1Jwc6a/WrKjV5zidgzTjP1eu9KZ8+1q30QH43FEGis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XifQ8vV20d/C5vzq/MpSrX8FHyVFkQHl/RugxBGWa6htE894znb1NbgPg00QK1iQW1oaeW4QFaSVDzUMdVnrEiWWoBTPA6/fg4fV0PT2Mrp+RKao8uxPi6RPhe6FGIZKjDja7g83oWiAPfpbH1rYcAx3WpRLQCs+WFgymK6JaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eb81b21273f411f0b29709d653e92f7d-20250808
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:776e54fd-e886-4705-8814-2912ed7b1ed4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b62a745bded9568a354f757b5e9c74bc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: eb81b21273f411f0b29709d653e92f7d-20250808
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1518627884; Fri, 08 Aug 2025 09:13:40 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7C2CBE0000B0;
	Fri,  8 Aug 2025 09:13:40 +0800 (CST)
X-ns-mid: postfix-68954F44-36935566
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id E603EE0000B0;
	Fri,  8 Aug 2025 09:13:30 +0800 (CST)
Message-ID: <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>
Date: Fri, 8 Aug 2025 09:13:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
To: Michal Hocko <mhocko@suse.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 David Hildenbrand <david@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
 Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Nico Pache <npache@redhat.com>,
 xu xin <xu.xin16@zte.com.cn>, wangfushuai <wangfushuai@baidu.com>,
 Andrii Nakryiko <andrii@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jeff Layton <jlayton@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Adrian Ratiu
 <adrian.ratiu@collabora.com>, linux-pm@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <aJSpTpB9_jijiO6m@tiehlicka>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <aJSpTpB9_jijiO6m@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2025/8/7 21:25, Michal Hocko =E5=86=99=E9=81=93:
> On Thu 07-08-25 20:14:09, Zihuan Zhang wrote:
>> The Linux task freezer was designed in a much earlier era, when usersp=
ace was relatively simple and flat.
>> Over the years, as modern desktop and mobile systems have become incre=
asingly complex=E2=80=94with intricate IPC,
>> asynchronous I/O, and deep event loops=E2=80=94the original freezer mo=
del has shown its age.
> A modern userspace might be more complex or convoluted but I do not
> think the above statement is accurate or even correct.
You=E2=80=99re right =E2=80=94 that statement may not be accurate. I=E2=80=
=99ll be more careful=20
with the wording.
>> ## Background
>>
>> Currently, the freezer traverses the task list linearly and attempts t=
o freeze all tasks equally.
>> It sends a signal and waits for `freezing()` to become true. While thi=
s model works well in many cases, it has several inherent limitations:
>>
>> - Signal-based logic cannot freeze uninterruptible (D-state) tasks
>> - Dependencies between processes can cause freeze retries
>> - Retry-based recovery introduces unpredictable suspend latency
>>
>> ## Real-world problem illustration
>>
>> Consider the following scenario during suspend:
>>
>> Freeze Window Begins
>>
>>      [process A] - epoll_wait()
>>          =E2=94=82
>>          =E2=96=BC
>>      [process B] - event source (already frozen)
>>
>> =E2=86=92 A enters D-state because of waiting for B
> I thought opoll_wait was waiting in interruptible sleep.

Apologies =E2=80=94 my description may not be entirely accurate.

But there are some dmesg logs:

[   62.880497] PM: suspend entry (deep)
[   63.130639] Filesystems sync: 0.249 seconds
[   63.130643] PM: Preparing system for sleep (deep)
[   63.226398] Freezing user space processes
[   63.227193] freeze round: 0, task to freeze: 681
[   63.228110] freeze round: 1, task to freeze: 1
[   63.230064] task:Xorg            state:D stack:0     pid:1404  tgid:14=
04  ppid:1348   task_flags:0x400100 flags:0x00004004
[   63.230068] Call Trace:
[   63.230069]  <TASK>
[   63.230071]  __schedule+0x52e/0xea0
[   63.230077]  schedule+0x27/0x80
[   63.230079]  schedule_timeout+0xf2/0x100
[   63.230082]  wait_for_completion+0x85/0x130
[   63.230085]  __flush_work+0x21f/0x310
[   63.230087]  ? __pfx_wq_barrier_func+0x10/0x10
[   63.230091]  drm_mode_rmfb+0x138/0x1b0
[   63.230093]  ? __pfx_drm_mode_rmfb_work_fn+0x10/0x10
[   63.230095]  ? __pfx_drm_mode_rmfb_ioctl+0x10/0x10
[   63.230097]  drm_ioctl_kernel+0xa5/0x100
[   63.230099]  drm_ioctl+0x270/0x4b0
[   63.230101]  ? __pfx_drm_mode_rmfb_ioctl+0x10/0x10
[   63.230104]  ? syscall_exit_work+0x108/0x140
[   63.230107]  radeon_drm_ioctl+0x4a/0x80 [radeon]
[   63.230141]  __x64_sys_ioctl+0x93/0xe0
[   63.230144]  ? syscall_trace_enter+0xfa/0x1c0
[   63.230146]  do_syscall_64+0x7d/0x2c0
[   63.230148]  ? do_syscall_64+0x1f3/0x2c0
[   63.230150]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   63.230153] RIP: 0033:0x7f1aa132550b
[   63.230154] RSP: 002b:00007ffebab69678 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
[   63.230156] RAX: ffffffffffffffda RBX: 00007ffebab696bc RCX: 00007f1aa=
132550b
[   63.230158] RDX: 00007ffebab696bc RSI: 00000000c00464af RDI: 000000000=
000000e
[   63.230159] RBP: 00000000c00464af R08: 00007f1aa0c41220 R09: 000055a71=
ce32310
[   63.230160] R10: 0000000000000087 R11: 0000000000000246 R12: 000055a71=
b813660
[   63.230161] R13: 000000000000000e R14: 0000000003a8f5cd R15: 000055a71=
b6bbfb0
[   63.230164]  </TASK>
[   63.230248] freeze round: 2, task to freeze: 1


You can find it in this patch

link:=20
https://lore.kernel.org/all/20250619035355.33402-1-zhangzihuan@kylinos.cn=
/

>> =E2=86=92 Cannot respond to freezing signal
>> =E2=86=92 Freezer retries in a loop
>> =E2=86=92 Suspend latency spikes
>>
>> In such cases, we observed that a normal 1=E2=80=932ms freezer cycle c=
ould balloon to **tens of milliseconds**.
>> Worse, the kernel has no insight into the root cause and simply retrie=
s blindly.
>>
>> ## Proposed solution: Freeze priority model
>>
>> To address this, we propose a **layered freeze model** based on per-ta=
sk freeze priorities.
>>
>> ### Design
>>
>> We introduce 4 levels of freeze priority:
>>
>>
>> | Priority | Level             | Description                       |
>> |----------|-------------------|-----------------------------------|
>> | 0        | HIGH              | D-state TASKs                     |
>> | 1        | NORMAL            | regular  use space TASKS          |
>> | 2        | LOW               | not yet used                      |
>> | 4        | NEVER_FREEZE      | zombie TASKs , PF_SUSPNED_TASK    |
>>
>>
>> The kernel will freeze processes **in priority order**, ensuring that =
higher-priority tasks are frozen first.
>> This avoids dependency inversion scenarios and provides a deterministi=
c path forward for tricky cases.
>> By freezing control or event-source threads first, we prevent dependen=
t tasks from entering D-state prematurely =E2=80=94 effectively avoiding =
dependency inversion.
> I really fail to see how that is supposed to work to be honest. If a
> process is running in the userspace then the priority shouldn't really
> matter much. Tasks will get a signal, freeze themselves and you are
> done. If they are running in the userspace and e.g. sleeping while not
> TASK_FREEZABLE then priority simply makes no difference. And if they ar=
e
> TASK_FREEZABLE then the priority doens't matter either.
>
> What am I missing?
under ideal conditions, if a userspace task is TASK_FREEZABLE, receives=20
the freezing() signal, and enters the refrigerator in a timely manner,=20
then freeze priority wouldn=E2=80=99t make a difference.

However, in practice, we=E2=80=99ve observed cases where tasks appear stu=
ck in=20
uninterruptible sleep (D state) during the freeze phase=C2=A0 =E2=80=94 a=
nd thus=20
cannot respond to signals or enter the refrigerator. These tasks are=20
technically TASK_FREEZABLE, but due to the nature of their sleep state,=20
they don=E2=80=99t freeze promptly, and may require multiple retry rounds=
, or=20
cause the entire suspend to fail.

