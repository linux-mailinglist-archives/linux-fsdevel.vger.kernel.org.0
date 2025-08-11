Return-Path: <linux-fsdevel+bounces-57281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 022B7B20347
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CEB1656F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CF42DEA7A;
	Mon, 11 Aug 2025 09:25:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB42DD60E;
	Mon, 11 Aug 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904331; cv=none; b=gnfzFk870t3CRCBVnJ3ciS0JrH8MePSjL5pN2aAj8WStKAq/33fmnRSvaxbDBJpKzEFORd45OLaOg8rAQpxfExWr3NQ8f/Q2cqRAPcIA3nBDbg0w/7KqG6w1V25W2fdBcLpXj3K7W85qX1ZGpkle8atKxzbCgzKKxOndAU7zvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904331; c=relaxed/simple;
	bh=uqhTHipWjf1i3WdgVOlLns1pC87d6SJxKvkOFAAg9sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqUThVpDtWQY9l+AIPkLFQFzL4I8gRym1enpZFeVFyENU7XoPhu4qD7qT5PLWzJgZTH0U0uf/J4uJIKMvZFpiCSVX4pbcW2lThm1u6ioPv3plcqkm3HHXcm3tygkiON9KzY2pzuHFXn1bdGqrE7Zed0pu2Gd6pC2DEVMan+G0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1918392e769511f0b29709d653e92f7d-20250811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:482ea64d-9d7c-4d03-b134-789f2a05fb1b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d6456464c6e6748e41fc8f4c855f847f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1918392e769511f0b29709d653e92f7d-20250811
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2091135485; Mon, 11 Aug 2025 17:25:19 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id C5CB2E00901E;
	Mon, 11 Aug 2025 17:25:18 +0800 (CST)
X-ns-mid: postfix-6899B6FE-684577930
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id EE6C2E008FED;
	Mon, 11 Aug 2025 17:25:10 +0800 (CST)
Message-ID: <0754e3e3-9c47-47d5-81d9-4574e5b413bc@kylinos.cn>
Date: Mon, 11 Aug 2025 17:25:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 5/9] freezer: set default freeze priority for
 PF_SUSPEND_TASK processes
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, David Hildenbrand <david@redhat.com>,
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
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
 <20250807121418.139765-6-zhangzihuan@kylinos.cn>
 <20250808143943.GB21685@redhat.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250808143943.GB21685@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/8 22:39, Oleg Nesterov =E5=86=99=E9=81=93:
> On 08/07, Zihuan Zhang wrote:
>> --- a/kernel/power/process.c
>> +++ b/kernel/power/process.c
>> @@ -147,6 +147,7 @@ int freeze_processes(void)
>>
>>   	pm_wakeup_clear(0);
>>   	pm_freezing =3D true;
>> +	freeze_set_default_priority(current, FREEZE_PRIORITY_NEVER);
> But why?
>
> Again, freeze_task() will return false anyway, this process is
> PF_SUSPEND_TASK.

I=C2=A0 think there is resaon put it here. For example, systemd-sleep is =
a=20
user-space process that executes the suspend flow.

 =C2=A0If we don=E2=80=99t set its freeze priority explicitly, our curren=
t code may=20
end up with this user process being the last one that cannot freeze.

Of course, we could adjust the code logic to handle it differently, but=20
in our model its freeze priority is considered the lowest, so setting it=20
here ensures consistent behavior.


>> @@ -218,6 +219,7 @@ void thaw_processes(void)
>>   	WARN_ON(!(curr->flags & PF_SUSPEND_TASK));
>>   	curr->flags &=3D ~PF_SUSPEND_TASK;
>>
>> +	freeze_set_default_priority(current, FREEZE_PRIORITY_NORMAL);
>>   	usermodehelper_enable();
> What if current->freeze_priority was changed via
> /proc/pid/freeze_priority you add in 9/9 ?

Sorry, my oversight. You are right =E2=80=94 in this case we probably sho=
uld not=20
allow user space to change the freeze_priority of a PF_SUSPEND_TASK.=20
This would avoid unintended behavior during suspend.

>
> Oleg.
>

