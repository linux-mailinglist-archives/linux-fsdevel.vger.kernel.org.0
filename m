Return-Path: <linux-fsdevel+bounces-57045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8858B1E48F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 10:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E422A580071
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF702652A2;
	Fri,  8 Aug 2025 08:40:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53061222565;
	Fri,  8 Aug 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642430; cv=none; b=FYuestNGyZLqTGKHXQym/72/M5JLjzjwJS/FHx+8oFccffELGroEd7jBlIoRXNPk6+/nvZTAUp/CGtaQoBi/y9cW0dcY7jvzfsXVO/Ly3aV6p4D84phHftmWUAWkDNgHQgdSb+aotARwty2ZNJTF/QlQOnfrfDMlFMsXzKo0cGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642430; c=relaxed/simple;
	bh=junXdwx0TkSI7LNOYjpb9IXp+ymJxIevkjGvsBY0XJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJMJjY60nh64Tq8BFfuztH4qfJbk1EqbcjhcDFqUE1YygZXIJBqAGQ7Dd0vQ6D6fYFrQtnxyyzscFbcqXcJHJxilVKFVtIaCUFHK8uFomKtxlFay6PbXUXRDP51mXdg2mDHl9kxGAZO+8y4kAMqbB3G4rpWdv8LzkvrIMvA50gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4f9d64ec743311f0b29709d653e92f7d-20250808
X-CID-CACHE: Type:Local,Time:202508081552+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e0211e39-915b-47f5-8269-b2a5fc39732d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:12be9df259196fe631b2eedfa1e50959,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4f9d64ec743311f0b29709d653e92f7d-20250808
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 516528990; Fri, 08 Aug 2025 16:40:17 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 29FF3E01A759;
	Fri,  8 Aug 2025 16:40:17 +0800 (CST)
X-ns-mid: postfix-6895B7F0-853165559
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3E5B8E0000B0;
	Fri,  8 Aug 2025 16:40:10 +0800 (CST)
Message-ID: <4644c5ec-b74b-4428-bd14-7b50dbd22397@kylinos.cn>
Date: Fri, 8 Aug 2025 16:40:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
To: Oleg Nesterov <oleg@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, David Hildenbrand <david@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
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
 <20250808075753.GB29612@redhat.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250808075753.GB29612@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2025/8/8 15:57, Oleg Nesterov =E5=86=99=E9=81=93:
> On 08/08, Zihuan Zhang wrote:
>> =E5=9C=A8 2025/8/7 21:25, Michal Hocko =E5=86=99=E9=81=93:
>>> If they are running in the userspace and e.g. sleeping while not
>>> TASK_FREEZABLE then priority simply makes no difference. And if they =
are
>>> TASK_FREEZABLE then the priority doens't matter either.
>>>
>>> What am I missing?
> I too do not understand how can this series improve the freezer.

Thanks for your question =E2=80=94 actually, I just replied to Michal wit=
h a=20
similar explanation, but I really appreciate you raising the same point,=20
so let me add a bit more context here.

Right now, we're trying to address the case where certain tasks fail to=20
freeze (often due to short-lived D-state issues). Our current workaround=20
is to increase the number of freeze iterations in the next suspend=20
attempt for those tasks.

While this isn't a perfect solution, the overhead of a few extra=20
iterations is minimal compared to the cost of retrying the whole suspend=20
cycle due to a stuck D-state task. So for now, we believe this is a=20
reasonable tradeoff until we find a more deterministic way to=20
preemptively detect and prioritize problematic tasks.

Happy to hear your thoughts or suggestions if you think there's a better=20
direction to explore.

>> under ideal conditions, if a userspace task is TASK_FREEZABLE, receive=
s the
>> freezing() signal, and enters the refrigerator in a timely manner,
> Note that __freeze_task() won't even send a signal to a sleeping
> TASK_FREEZABLE task, __freeze_task() will just change its state to
> TASK_FROZEN.
>
> Oleg.
>
You are right.

