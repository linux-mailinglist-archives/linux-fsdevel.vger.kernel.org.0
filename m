Return-Path: <linux-fsdevel+bounces-57637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0EFB240A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1CA1AA5033
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 05:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0BA2C3257;
	Wed, 13 Aug 2025 05:49:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9EC2C1598;
	Wed, 13 Aug 2025 05:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064142; cv=none; b=bFONUAexirVhlxa6Qm2PU+pfQDrClzVrfzuHZiYr3g92Z0cODaaFuo2zv6psLuAxHl8DFvJFVI0xV8mEtXQr98GjjDS3Spnu4RpYq9vT/0B4AdrZ94HDM3Jj62K/5IuNQ7zHQYK01BZuRaQ0MILAZnsKaE9RApEPb9Tq0cUxFHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064142; c=relaxed/simple;
	bh=XhlugzNdH+d95jCW0kj5l9IYJ//kXJPzqTGjstCtpEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+Abkn9yHqLukqE+wRasMICohEjnYLhhX9EFFKIJRarKnDgInq+O6KeL8vpGKTfNm3L61ckAHPCqrL6TaGDuSKjM9tds390d+S60mPvpmtb7sipwPhAeAq9LvFvt5pfVhAHhWWgT424fUxsXI84mtYOQOp7wx56GYI+RI2K7+as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 30a643cc780911f0b29709d653e92f7d-20250813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3daa047f-cd79-47a5-8fd7-224c239c4ce8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:994f152d6c1a295ca93fe5963adb0ebd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 30a643cc780911f0b29709d653e92f7d-20250813
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 54274607; Wed, 13 Aug 2025 13:48:51 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 0897CE008FA5;
	Wed, 13 Aug 2025 13:48:51 +0800 (CST)
X-ns-mid: postfix-689C2742-86747173
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 4E0DFE008FA3;
	Wed, 13 Aug 2025 13:48:38 +0800 (CST)
Message-ID: <8c61ab95-9caa-4b57-adfd-31f941f0264d@kylinos.cn>
Date: Wed, 13 Aug 2025 13:48:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 Jan Kara <jack@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
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
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <aJSpTpB9_jijiO6m@tiehlicka>
 <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>
 <aJWglTo1xpXXEqEM@tiehlicka>
 <ba9c23c4-cd95-4dba-9359-61565195d7be@kylinos.cn>
 <aJW8NLPxGOOkyCfB@tiehlicka>
 <09df0911-9421-40af-8296-de1383be1c58@kylinos.cn>
 <aJnM32xKq0FOWBzw@tiehlicka>
 <d86a9883-9d2e-4bb2-a93d-0d95b4a60e5f@kylinos.cn>
 <20250812172655.GF7938@frogsfrogsfrogs>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250812172655.GF7938@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2025/8/13 01:26, Darrick J. Wong =E5=86=99=E9=81=93:
> On Tue, Aug 12, 2025 at 01:57:49PM +0800, Zihuan Zhang wrote:
>> Hi all,
>>
>> We encountered an issue where the number of freeze retries increased d=
ue to
>> processes stuck in D state. The logs point to jbd2-related activity.
>>
>> log1:
>>
>> 6616.650482] task:ThreadPoolForeg state:D stack:0=C2=A0 =C2=A0 =C2=A0p=
id:262026
>> tgid:4065=C2=A0 ppid:2490=C2=A0 =C2=A0task_flags:0x400040 flags:0x0000=
4004
>> [ 6616.650485] Call Trace:
>> [ 6616.650486]=C2=A0 <TASK>
>> [ 6616.650489]=C2=A0 __schedule+0x532/0xea0
>> [ 6616.650494]=C2=A0 schedule+0x27/0x80
>> [ 6616.650496]=C2=A0 jbd2_log_wait_commit+0xa6/0x120
>> [ 6616.650499]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
>> [ 6616.650502]=C2=A0 ext4_sync_file+0x1ba/0x380
>> [ 6616.650505]=C2=A0 do_fsync+0x3b/0x80
>>
>> log2:
>>
>> [=C2=A0 631.206315] jdb2_log_wait_log_commit=C2=A0 completed (elapsed =
0.002 seconds)
>> [=C2=A0 631.215325] jdb2_log_wait_log_commit=C2=A0 completed (elapsed =
0.001 seconds)
>> [=C2=A0 631.240704] jdb2_log_wait_log_commit=C2=A0 completed (elapsed =
0.386 seconds)
>> [=C2=A0 631.262167] Filesystems sync: 0.424 seconds
>> [=C2=A0 631.262821] Freezing user space processes
>> [=C2=A0 631.263839] freeze round: 1, task to freeze: 852
>> [=C2=A0 631.265128] freeze round: 2, task to freeze: 2
>> [=C2=A0 631.267039] freeze round: 3, task to freeze: 2
>> [=C2=A0 631.271176] freeze round: 4, task to freeze: 2
>> [=C2=A0 631.279160] freeze round: 5, task to freeze: 2
>> [=C2=A0 631.287152] freeze round: 6, task to freeze: 2
>> [=C2=A0 631.295346] freeze round: 7, task to freeze: 2
>> [=C2=A0 631.301747] freeze round: 8, task to freeze: 2
>> [=C2=A0 631.309346] freeze round: 9, task to freeze: 2
>> [=C2=A0 631.317353] freeze round: 10, task to freeze: 2
>> [=C2=A0 631.325348] freeze round: 11, task to freeze: 2
>> [=C2=A0 631.333353] freeze round: 12, task to freeze: 2
>> [=C2=A0 631.341358] freeze round: 13, task to freeze: 2
>> [=C2=A0 631.349357] freeze round: 14, task to freeze: 2
>> [=C2=A0 631.357363] freeze round: 15, task to freeze: 2
>> [=C2=A0 631.365361] freeze round: 16, task to freeze: 2
>> [=C2=A0 631.373379] freeze round: 17, task to freeze: 2
>> [=C2=A0 631.381366] freeze round: 18, task to freeze: 2
>> [=C2=A0 631.389365] freeze round: 19, task to freeze: 2
>> [=C2=A0 631.397371] freeze round: 20, task to freeze: 2
>> [=C2=A0 631.405373] freeze round: 21, task to freeze: 2
>> [=C2=A0 631.413373] freeze round: 22, task to freeze: 2
>> [=C2=A0 631.421392] freeze round: 23, task to freeze: 1
>> [=C2=A0 631.429948] freeze round: 24, task to freeze: 1
>> [=C2=A0 631.438295] freeze round: 25, task to freeze: 1
>> [=C2=A0 631.444546] jdb2_log_wait_log_commit=C2=A0 completed (elapsed =
0.249 seconds)
>> [=C2=A0 631.446387] freeze round: 26, task to freeze: 0
>> [=C2=A0 631.446390] Freezing user space processes completed (elapsed 0=
.183
>> seconds)
>> [=C2=A0 631.446392] OOM killer disabled.
>> [=C2=A0 631.446393] Freezing remaining freezable tasks
>> [=C2=A0 631.446656] freeze round: 1, task to freeze: 4
>> [=C2=A0 631.447976] freeze round: 2, task to freeze: 0
>> [=C2=A0 631.447978] Freezing remaining freezable tasks completed (elap=
sed 0.001
>> seconds)
>> [=C2=A0 631.447980] PM: suspend debug: Waiting for 1 second(s).
>> [=C2=A0 632.450858] OOM killer enabled.
>> [=C2=A0 632.450859] Restarting tasks: Starting
>> [=C2=A0 632.453140] Restarting tasks: Done
>> [=C2=A0 632.453173] random: crng reseeded on system resumption
>> [=C2=A0 632.453370] PM: suspend exit
>> [=C2=A0 632.462799] jdb2_log_wait_log_commit=C2=A0 completed (elapsed =
0.000 seconds)
>> [=C2=A0 632.466114] jdb2_log_wait_log_commit=C2=A0 completed (elapsed =
0.001 seconds)
>>
>> This is the reason:
>>
>> [=C2=A0 631.444546] jdb2_log_wait_log_commit=C2=A0 completed (elapsed =
0.249 seconds)
>>
>>
>> During freezing, user processes executing jbd2_log_wait_commit enter D=
 state
>> because this function calls wait_event and can take tens of millisecon=
ds to
>> complete. This long execution time, coupled with possible competition =
with
>> the freezer, causes repeated freeze retries.
>>
>> While we understand that jbd2 is a freezable kernel thread, we would l=
ike to
>> know if there is a way to freeze it earlier or freeze some critical
>> processes proactively to reduce this contention.
> Freeze the filesystem before you start freezing kthreads?  That should
> quiesce the jbd2 workers and pause anyone trying to write to the fs.
Indeed, freezing the filesystem can work.

However, this approach is quite expensive: it increases the total=20
suspend time by about 3 to 4 seconds. Because of this overhead, we are=20
exploring alternative solutions with lower cost.

We have tested it:

https://lore.kernel.org/all/09df0911-9421-40af-8296-de1383be1c58@kylinos.=
cn/=20

> Maybe the missing piece here is the device model not knowing how to cal=
l
> bdev_freeze prior to a suspend?
Currently, suspend flow seem to does not invoke bdev_freeze(). Do you=20
have any plans or insights on improving or integrating this=20
functionality more smoothly into the device model and suspend sequence?
> That said, I think that doesn't 100% work for XFS because it has
> kworkers for metadata buffer read completions, and freezes don't affect
> read operations...

Does read activity also cause processes to enter D (uninterruptible=20
sleep) state?

 From what I understand, it=E2=80=99s usually writes or synchronous opera=
tions=20
that do, but I=E2=80=99m curious if reads can also lead to D state under =
certain=20
conditions.

> (just my clueless 2c)
>
> --D
>
>> Thanks for your input and suggestions.
>>
>> =E5=9C=A8 2025/8/11 18:58, Michal Hocko =E5=86=99=E9=81=93:
>>> On Mon 11-08-25 17:13:43, Zihuan Zhang wrote:
>>>> =E5=9C=A8 2025/8/8 16:58, Michal Hocko =E5=86=99=E9=81=93:
>>> [...]
>>>>> Also the interface seems to be really coarse grained and it can eas=
ily
>>>>> turn out insufficient for other usecases while it is not entirely c=
lear
>>>>> to me how this could be extended for those.
>>>>   =C2=A0We recognize that the current interface is relatively coarse=
-grained and
>>>> may not be sufficient for all scenarios. The present implementation =
is a
>>>> basic version.
>>>>
>>>> Our plan is to introduce a classification-based mechanism that assig=
ns
>>>> different freeze priorities according to process categories. For exa=
mple,
>>>> filesystem and graphics-related processes will be given higher defau=
lt
>>>> freeze priority, as they are critical in the freezing workflow. This
>>>> classification approach helps target important processes more precis=
ely.
>>>>
>>>> However, this requires further testing and refinement before full
>>>> deployment. We believe this incremental, category-based design will =
make the
>>>> mechanism more effective and adaptable over time while keeping it
>>>> manageable.
>>> Unless there is a clear path for a more extendable interface then
>>> introducing this one is a no-go. We do not want to grow different way=
s
>>> to establish freezing policies.
>>>
>>> But much more fundamentally. So far I haven't really seen any argumen=
t
>>> why different priorities help with the underlying problem other than =
the
>>> timing might be slightly different if you change the order of freezin=
g.
>>> This to me sounds like the proposed scheme mostly works around the
>>> problem you are seeing and as such is not a really good candidate to =
be
>>> merged as a long term solution. Not to mention with a user API that
>>> needs to be maintained for ever.
>>>
>>> So NAK from me on the interface.
>>>
>> Thanks for the feedback. I understand your concern that changing the f=
reezer
>> priority order looks like working around the symptom rather than solvi=
ng the
>> root cause.
>>
>> Since the last discussion, we have analyzed the D-state processes furt=
her
>> and identified that the long wait time is caused by jbd2_log_wait_comm=
it.
>> This wait happens because user tasks call into this function during
>> fsync/fdatasync and it can take tens of milliseconds to complete. When=
 this
>> coincides with the freezer operation, the tasks are stuck in D state a=
nd
>> retried multiple times, increasing the total freeze time.
>>
>> Although we know that jbd2 is a freezable kernel thread, we are explor=
ing
>> whether freezing it earlier =E2=80=94 or freezing certain key processe=
s first =E2=80=94
>> could reduce this contention and improve freeze completion time.
>>
>>
>>>>> I believe it would be more useful to find sources of those freezer
>>>>> blockers and try to address those. Making more blocked tasks
>>>>> __set_task_frozen compatible sounds like a general improvement in
>>>>> itself.
>>>> we have already identified some causes of D-state tasks, many of whi=
ch are
>>>> related to the filesystem. On some systems, certain processes freque=
ntly
>>>> execute ext4_sync_file, and under contention this can lead to D-stat=
e tasks.
>>> Please work with maintainers of those subsystems to find proper
>>> solutions.
>> We=E2=80=99ve pulled in the jbd2 maintainer to get feedback on whether=
 changing the
>> freeze ordering for jbd2 is safe or if there=E2=80=99s a better approa=
ch to avoid
>> the repeated retries caused by this wait.
>>

