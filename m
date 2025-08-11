Return-Path: <linux-fsdevel+bounces-57286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EF5B203FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 605427AD191
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9B52D9ECD;
	Mon, 11 Aug 2025 09:42:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7152253A9;
	Mon, 11 Aug 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905366; cv=none; b=kkQIIwj8+l+/qUbhd49bFo66SyVUcvW5Oa/kBozkMaVGNVQDvsMl4lLZ4x+iQKulXrci9s4Y9Xhir/k7fxRD0SLvsEmUCIqM+gdM0PIQQS8IdQyqq9mp/ZlBTJFNIXyF0YjaAu/FWh2ly0vOLQE/SxCBIXLgpUzVjQBGNyo6qS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905366; c=relaxed/simple;
	bh=R6t7OGJEj5xgNgF3fLtf4WQXap3UjRp4AgNhnXZUSVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0QdeG9X7teauIr4o3uCXP53rUPoHl06fTfUWOvBRWfDusvlnh4982od8A9U4PkGpixEYEmZLkZm7sLiQQ/ordH3FhkQxNyI9Xl1FS31ZiyY1L/TRIsfRQbwF9oelO+k0RZafhBvGVIerSm70lYPMNgD/LsEj6h0Ob2J3acYoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 853663c2769711f0b29709d653e92f7d-20250811
X-CID-CACHE: Type:Local,Time:202508111725+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:8f82698c-6304-4797-b77e-bd9eadd96666,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d6456464c6e6748e41fc8f4c855f847f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 853663c2769711f0b29709d653e92f7d-20250811
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 381576943; Mon, 11 Aug 2025 17:42:39 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 01051E009021;
	Mon, 11 Aug 2025 17:42:39 +0800 (CST)
X-ns-mid: postfix-6899BB0E-484419978
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id C8EA4E00901E;
	Mon, 11 Aug 2025 17:42:34 +0800 (CST)
Message-ID: <428beb0d-2484-4816-86c3-01e91bd7715a@kylinos.cn>
Date: Mon, 11 Aug 2025 17:42:34 +0800
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
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250811093216.GB11928@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/11 17:32, Oleg Nesterov =E5=86=99=E9=81=93:
> On 08/11, Zihuan Zhang wrote:
>> =E5=9C=A8 2025/8/8 22:39, Oleg Nesterov =E5=86=99=E9=81=93:
>>> On 08/07, Zihuan Zhang wrote:
>>>> --- a/kernel/power/process.c
>>>> +++ b/kernel/power/process.c
>>>> @@ -147,6 +147,7 @@ int freeze_processes(void)
>>>>
>>>>   	pm_wakeup_clear(0);
>>>>   	pm_freezing =3D true;
>>>> +	freeze_set_default_priority(current, FREEZE_PRIORITY_NEVER);
>>> But why?
>>>
>>> Again, freeze_task() will return false anyway, this process is
>>> PF_SUSPEND_TASK.
>> I=C2=A0 think there is resaon put it here. For example, systemd-sleep =
is a
>> user-space process that executes the suspend flow.
>>
>>  =C2=A0If we don=E2=80=99t set its freeze priority explicitly, our cur=
rent code may end up
>> with this user process being the last one that cannot freeze.
> How so? sorry I don't follow.

The problem is in this part:

+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_only && !(p->flags & =
PF_KTHREAD) && round <=20
p->freeze_priority)
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;

PF_SUSPEND_TASK is a user process, so it meets the =E2=80=9Cneeds freezin=
g=E2=80=9D=20
condition and todo gets incremented. But it actually doesn=E2=80=99t need=
 to=20
freeze, so resulting in an infinite loop

> Oleg.
>

