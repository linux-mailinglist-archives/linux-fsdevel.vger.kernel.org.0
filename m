Return-Path: <linux-fsdevel+bounces-57280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F03EB202FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D964227F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DDD2DCF6E;
	Mon, 11 Aug 2025 09:14:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3EB23B613;
	Mon, 11 Aug 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903644; cv=none; b=X+p76muX0J4D2H2cZiych0jlVQT4od0MoI/Bs0pRc+aGpZsTWXhB3hxvQiOSWAaBAdfXwS2QkRPw+l84vpcDdYpWUFD/IQvqumajxpS8oQiAHCtOwK0417l1bi8evJZiA4laDm+lWHGZU5x/es1D51nRVNYMLxcshuaDyHXV6Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903644; c=relaxed/simple;
	bh=NXv5SMn7xjwbfnsKK35GuN+UD0kh/Ux7ELzbxv6osL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQu20tDaMNkio3flFOjmUpXXUpO4A4oHEdumcvGTC/30GqBlCiRsHJagDmGaVOJiPdVQLuJbaFQ54ZVwYeMYe2UhupjBLsBkttdOdkY3qR7m256mBwZQ628QYRAlg501Jeh3t7gCwlB7vyjuPjbIV4byl70LLuUf4JTF/6PB9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7f6c73fe769311f0b29709d653e92f7d-20250811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3ba7c0db-18e1-43fc-a896-13f729196999,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:dbc7cdf834544e741f770fa4c9a5deb7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7f6c73fe769311f0b29709d653e92f7d-20250811
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1790700532; Mon, 11 Aug 2025 17:13:51 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 76C64E00901E;
	Mon, 11 Aug 2025 17:13:51 +0800 (CST)
X-ns-mid: postfix-6899B44F-304809903
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 4529AE008FED;
	Mon, 11 Aug 2025 17:13:44 +0800 (CST)
Message-ID: <09df0911-9421-40af-8296-de1383be1c58@kylinos.cn>
Date: Mon, 11 Aug 2025 17:13:43 +0800
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
 <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>
 <aJWglTo1xpXXEqEM@tiehlicka>
 <ba9c23c4-cd95-4dba-9359-61565195d7be@kylinos.cn>
 <aJW8NLPxGOOkyCfB@tiehlicka>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <aJW8NLPxGOOkyCfB@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/8 16:58, Michal Hocko =E5=86=99=E9=81=93:
> On Fri 08-08-25 15:52:31, Zihuan Zhang wrote:
>> =E5=9C=A8 2025/8/8 15:00, Michal Hocko =E5=86=99=E9=81=93:
>>> On Fri 08-08-25 09:13:30, Zihuan Zhang wrote:
>>> [...]
>>>> However, in practice, we=E2=80=99ve observed cases where tasks appea=
r stuck in
>>>> uninterruptible sleep (D state) during the freeze phase=C2=A0 =E2=80=
=94 and thus cannot
>>>> respond to signals or enter the refrigerator. These tasks are techni=
cally
>>>> TASK_FREEZABLE, but due to the nature of their sleep state, they don=
=E2=80=99t
>>>> freeze promptly, and may require multiple retry rounds, or cause the=
 entire
>>>> suspend to fail.
>>> Right, but that is an inherent problem of the freezer implemenatation=
.
>>> It is not really clear to me how priorities or layers improve on that=
.
>>> Could you please elaborate on that?
>> Thanks for the follow-up.
>>
>>  From our observations, we=E2=80=99ve seen processes like Xorg that ar=
e in a normal
>> state before freezing begins, but enter D state during the freeze wind=
ow.
>> Upon investigation,
>>
>> we found that these processes often depend on other user processes (e.=
g.,
>> I/O helpers or system services), and when those dependencies are froze=
n
>> first, the dependent process (like Xorg) gets stuck and can=E2=80=99t =
be frozen
>> itself.
> OK, I see.
>
>> This led us to treat such processes as =E2=80=9Chard to freeze=E2=80=9D=
 tasks =E2=80=94 not because
>> they=E2=80=99re inherently unfreezable, but because they are more like=
ly to become
>> problematic if not frozen early enough.
>>
>> So our model works as follows:
>>  =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 By default, freezer tries to fre=
eze all freezable tasks in each
>> round.
>>  =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 With our approach, we only attem=
pt to freeze tasks whose
>> freeze_priority is less than or equal to the current round number.
>>  =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 This ensures that higher-priorit=
y (i.e., harder-to-freeze) tasks
>> are attempted earlier, increasing the chance that they freeze before b=
eing
>> blocked by others.
>>
>> Since we cannot know in advance which tasks will be difficult to freez=
e, we
>> use heuristics:
>>  =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 Any task that causes freeze fail=
ure or is found in D state during
>> the freeze window is treated as hard-to-freeze in the next attempt and=
 its
>> priority is increased.
>>  =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 Additionally, users can manually=
 raise/reduce the freeze priority
>> of known problematic tasks via an exposed sysfs interface, giving them
>> fine-grained control.
> This would have been a very useful information for the changelog so tha=
t
> we can understand what you are trying to achieve.
>
Got it, I=E2=80=99ll add that info to the changelog. Thanks!
>> This doesn=E2=80=99t change the fundamental logic of the freezer =E2=80=
=94 it still retries
>> until all tasks are frozen =E2=80=94 but by adjusting the traversal or=
der,
>>
>>  =C2=A0we=E2=80=99ve observed significantly fewer retries and more rel=
iable success in
>> scenarios where these D state transitions occur.
>  =20
> OK, I believe I do understand what you are trying to achieve but I am
> not conviced this is a robust way to deal with the problem. This all
> seems highly timing specific that might work in very specific usecase
> but you are essentially trying to fight tiny race windows with a very
> probabilitistic interface.

Actually, our approach does not conflict with solving the problem. We=20
plan to keep the freeze priority mechanism disabled by default and only=20
enable it when issues arise, so as to maintain the consistency of the=20
existing code flow as much as possible. It acts like a fallback mechanism=
.

We acknowledge that the causes of D-state tasks are complex and require=20
high effort to fully resolve, which the current freezer mechanism cannot=20
achieve. Our solution is low-cost and able to capture some problematic=20
tasks effectively.

> Also the interface seems to be really coarse grained and it can easily
> turn out insufficient for other usecases while it is not entirely clear
> to me how this could be extended for those.
 =C2=A0We recognize that the current interface is relatively coarse-grain=
ed=20
and may not be sufficient for all scenarios. The present implementation=20
is a basic version.

Our plan is to introduce a classification-based mechanism that assigns=20
different freeze priorities according to process categories. For=20
example, filesystem and graphics-related processes will be given higher=20
default freeze priority, as they are critical in the freezing workflow.=20
This classification approach helps target important processes more=20
precisely.

However, this requires further testing and refinement before full=20
deployment. We believe this incremental, category-based design will make=20
the mechanism more effective and adaptable over time while keeping it=20
manageable.
> I believe it would be more useful to find sources of those freezer
> blockers and try to address those. Making more blocked tasks
> __set_task_frozen compatible sounds like a general improvement in
> itself.

we have already identified some causes of D-state tasks, many of which=20
are related to the filesystem. On some systems, certain processes=20
frequently execute ext4_sync_file, and under contention this can lead to=20
D-state tasks.

 =C2=A06616.650482] task:ThreadPoolForeg state:D stack:0=C2=A0 =C2=A0 =C2=
=A0pid:262026=20
tgid:4065=C2=A0 ppid:2490=C2=A0 =C2=A0task_flags:0x400040 flags:0x0000400=
4
[ 6616.650485] Call Trace:
[ 6616.650486]=C2=A0 <TASK>
[ 6616.650489]=C2=A0 __schedule+0x532/0xea0
[ 6616.650494]=C2=A0 schedule+0x27/0x80
[ 6616.650496]=C2=A0 jbd2_log_wait_commit+0xa6/0x120
[ 6616.650499]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
[ 6616.650502]=C2=A0 ext4_sync_file+0x1ba/0x380
[ 6616.650505]=C2=A0 do_fsync+0x3b/0x80
[ 6616.650507]=C2=A0 __x64_sys_fdatasync+0x17/0x20
[ 6616.650509]=C2=A0 do_syscall_64+0x7d/0x2c0
[ 6616.650512]=C2=A0 ? syscall_exit_work+0x108/0x140
[ 6616.650515]=C2=A0 ? do_syscall_64+0x1f3/0x2c0
[ 6616.650517]=C2=A0 ? syscall_exit_work+0x108/0x140
[ 6616.650519]=C2=A0 ? do_syscall_64+0x1d5/0x2c0
[ 6616.650522]=C2=A0 ? audit_reset_context.part.0+0x284/0x2f0
[ 6616.650524]=C2=A0 ? syscall_exit_work+0x108/0x140
[ 6616.650527]=C2=A0 ? do_syscall_64+0x1f3/0x2c0
[ 6616.650529]=C2=A0 ? futex_unqueue+0x4e/0x80
[ 6616.650531]=C2=A0 ? __futex_wait+0x9b/0x100
[ 6616.650534]=C2=A0 ? __pfx_futex_wake_mark+0x10/0x10
[ 6616.650536]=C2=A0 ? timerqueue_del+0x2e/0x50
[ 6616.650539]=C2=A0 ? __remove_hrtimer+0x39/0x70
[ 6616.650542]=C2=A0 ? hrtimer_try_to_cancel+0x85/0x100
[ 6616.650544]=C2=A0 ? hrtimer_cancel+0x15/0x30
[ 6616.650546]=C2=A0 ? futex_wait+0x7d/0x110
[ 6616.650549]=C2=A0 ? __pfx_hrtimer_wakeup+0x10/0x10
[ 6616.650552]=C2=A0 ? audit_reset_context.part.0+0x284/0x2f0
[ 6616.650554]=C2=A0 ? syscall_exit_work+0x108/0x140
[ 6616.650556]=C2=A0 ? do_syscall_64+0x1d5/0x2c0
[ 6616.650558]=C2=A0 ? switch_fpu_return+0x4f/0xd0
[ 6616.650560]=C2=A0 ? do_syscall_64+0x1d5/0x2c0
[ 6616.650563]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 6616.650565] RIP: 0033:0x7f095ef8f3eb
[ 6616.650567] RSP: 002b:00007f07409fa360 EFLAGS: 00000293 ORIG_RAX:=20
000000000000004b
[ 6616.650569] RAX: ffffffffffffffda RBX: 00000d38021f03a0 RCX:=20
00007f095ef8f3eb
[ 6616.650570] RDX: 0000000000000000 RSI: 0000000000000000 RDI:=20
000000000000009a
[ 6616.650571] RBP: 00007f07409fa410 R08: 0000000000000000 R09:=20
00007f07409fa570
[ 6616.650572] R10: 00007f0960a60000 R11: 0000000000000293 R12:=20
00000d38021f0380
[ 6616.650573] R13: 000055c28c70b400 R14: 00007f07409fa3a0 R15:=20
00007f07409fa380


While the kernel already supports freezing the filesystem, which can=20
address this problem, it is quite expensive =E2=80=94 enabling this featu=
re=20
increases the suspend time by about=C2=A0 3~4 seconds in our tests. We ar=
e=20
therefore exploring lower-cost approaches to mitigate the issue without=20
such a heavy performance impact.

root@zzhwaxy-pc:/sys/power# echo 1 > freeze_filesystems
root@zzhwaxy-pc:/sys/power# sudo dmesg | grep -E 'suspend'
[ 9844.984658] PM: suspend entry (deep)
[ 9850.998197] PM: suspend exit

root@zzhwaxy-pc:/sys/power# echo 0 > freeze_filesystems
root@zzhwaxy-pc:/sys/power# sudo dmesg | grep -E 'suspend'
[ 9893.928486] PM: suspend entry (deep)
[ 9896.239425] PM: suspend exit

> Thanks

