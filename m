Return-Path: <linux-fsdevel+bounces-57295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82894B20491
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5873418C12AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7864225A38;
	Mon, 11 Aug 2025 09:54:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64B21CFF6;
	Mon, 11 Aug 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906092; cv=none; b=WzAN4EBwX+CskKcNhlXccVQpNQzaFJsmMKv/ta41xiQSmFw5Frrl/311ZkQJAK2eifqY6SPkNfxIrU32CtYT75LdW/VBe6TGSUfoFVAkpn8+1rbMC9h9POgrUtbLC9NP7VV2AZSzppS2P4CBBb4jzE+vsVnfugZbhDOP1EGPBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906092; c=relaxed/simple;
	bh=JrNdyX6RHoEyF+dmtK86znKyiqTo8VUOFA2j6T73oQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lp5PClsgRhoL+q21LZyD4XXrVT3E9ypUfqTNo8Lqs574ih0sUSzdNCvZfQaSFoGBykx5rM44feSNpEIAplrSDAASWKBLudr9FbqtN0pyHPNrV47GHYS7Py/lmLhWnEb4hGYcwkyb4SBEdJRN1Ig8iKOxEfZDilA2SCHU/EIUzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2b9da468769911f0b29709d653e92f7d-20250811
X-CID-CACHE: Type:Local,Time:202508111725+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:acc68978-f090-491f-984d-775e43d21c34,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d6456464c6e6748e41fc8f4c855f847f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2b9da468769911f0b29709d653e92f7d-20250811
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1249145062; Mon, 11 Aug 2025 17:54:28 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 9F9D3E009021;
	Mon, 11 Aug 2025 17:54:27 +0800 (CST)
X-ns-mid: postfix-6899BDD3-5075201002
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 81F3EE008FED;
	Mon, 11 Aug 2025 17:54:24 +0800 (CST)
Message-ID: <4ceb0e8c-d164-4323-add0-a0770ec2afc6@kylinos.cn>
Date: Mon, 11 Aug 2025 17:54:23 +0800
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
 <0754e3e3-9c47-47d5-81d9-4574e5b413bc@kylinos.cn>
 <20250811093216.GB11928@redhat.com>
 <428beb0d-2484-4816-86c3-01e91bd7715a@kylinos.cn>
 <20250811094651.GD11928@redhat.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250811094651.GD11928@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/11 17:46, Oleg Nesterov =E5=86=99=E9=81=93:
> On 08/11, Zihuan Zhang wrote:
>> =E5=9C=A8 2025/8/11 17:32, Oleg Nesterov =E5=86=99=E9=81=93:
>>> On 08/11, Zihuan Zhang wrote:
>>>> =E5=9C=A8 2025/8/8 22:39, Oleg Nesterov =E5=86=99=E9=81=93:
>>>>> On 08/07, Zihuan Zhang wrote:
>>>>>> --- a/kernel/power/process.c
>>>>>> +++ b/kernel/power/process.c
>>>>>> @@ -147,6 +147,7 @@ int freeze_processes(void)
>>>>>>
>>>>>>   	pm_wakeup_clear(0);
>>>>>>   	pm_freezing =3D true;
>>>>>> +	freeze_set_default_priority(current, FREEZE_PRIORITY_NEVER);
>>>>> But why?
>>>>>
>>>>> Again, freeze_task() will return false anyway, this process is
>>>>> PF_SUSPEND_TASK.
>>>> I=C2=A0 think there is resaon put it here. For example, systemd-slee=
p is a
>>>> user-space process that executes the suspend flow.
>>>>
>>>>  =C2=A0If we don=E2=80=99t set its freeze priority explicitly, our c=
urrent code may end up
>>>> with this user process being the last one that cannot freeze.
>>> How so? sorry I don't follow.
>> The problem is in this part:
>>
>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_only && !(p->flags=
 & PF_KTHREAD) && round <
>> p->freeze_priority)
>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>>
>> PF_SUSPEND_TASK is a user process, so it meets the =E2=80=9Cneeds free=
zing=E2=80=9D
>> condition and todo gets incremented.
>              ^^^^^^^^^^^^^^^^^^^^^^^^^
>
> No.
> 	if (p =3D=3D current || !freeze_task(p))
> 		continue;
>
> 	todo++;
>
> Again, again, freeze_task(p) returns false.
>
>> But it actually doesn=E2=80=99t need to freeze,
>> so resulting in an infinite loop
> I don't think so.
>
> Oleg.
Sorry, you=E2=80=99re right =E2=80=94 it=E2=80=99s indeed unnecessary. In=
 an earlier version, I=20
incremented the counter before the continue, but I later removed that=20
and forgot about it.

