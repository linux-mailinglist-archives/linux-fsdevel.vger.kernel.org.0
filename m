Return-Path: <linux-fsdevel+bounces-57039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39557B1E3E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA1D1898D8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 07:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D50256C9F;
	Fri,  8 Aug 2025 07:52:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420A245010;
	Fri,  8 Aug 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639573; cv=none; b=FXT6HZcvrBppvf4DUC5BhIxvO6aAqxXAH2plIZhAHMHyRoYA977r5K5nUlWnN9AbNlMcVZi/nV0wLgpjb40vSZ4hmR36lhx3uKqYIzbVPNC/CtG2NMlWCfUL0rkLIXr6svY0AEmEiWeSF6xGXR8DrXAYsdVz6NBLqeK/2JYzYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639573; c=relaxed/simple;
	bh=/2dZhq2Qy2sSATJbAU+7gVHKsPZccvnLlqFS5AqLg3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSeyeX4QHZRfJ7okabM4GtlcItGe0ufmTUe93MIkotUwK+jtnTnt8TF9Ds0D2Dj5xBC1tbGLksiHOdgOuuu0D247Q3ox3o2IRAKaV1AqYukgxzkSTxUgQG8XdyAZflOO4cqrvgum1SZRmog92KxhTx4CLbJoac160zhfb8SmGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a8e010ba742c11f0b29709d653e92f7d-20250808
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:906a0f65-2426-4900-802a-89dc3ba00924,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:12be9df259196fe631b2eedfa1e50959,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a8e010ba742c11f0b29709d653e92f7d-20250808
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 931304093; Fri, 08 Aug 2025 15:52:40 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A013BE0000B0;
	Fri,  8 Aug 2025 15:52:39 +0800 (CST)
X-ns-mid: postfix-6895ACC7-490838455
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 9AF52E01A759;
	Fri,  8 Aug 2025 15:52:31 +0800 (CST)
Message-ID: <ba9c23c4-cd95-4dba-9359-61565195d7be@kylinos.cn>
Date: Fri, 8 Aug 2025 15:52:31 +0800
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
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <aJWglTo1xpXXEqEM@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/8 15:00, Michal Hocko =E5=86=99=E9=81=93:
> On Fri 08-08-25 09:13:30, Zihuan Zhang wrote:
> [...]
>> However, in practice, we=E2=80=99ve observed cases where tasks appear =
stuck in
>> uninterruptible sleep (D state) during the freeze phase=C2=A0 =E2=80=94=
 and thus cannot
>> respond to signals or enter the refrigerator. These tasks are technica=
lly
>> TASK_FREEZABLE, but due to the nature of their sleep state, they don=E2=
=80=99t
>> freeze promptly, and may require multiple retry rounds, or cause the e=
ntire
>> suspend to fail.
> Right, but that is an inherent problem of the freezer implemenatation.
> It is not really clear to me how priorities or layers improve on that.
> Could you please elaborate on that?

Thanks for the follow-up.

 From our observations, we=E2=80=99ve seen processes like Xorg that are i=
n a=20
normal state before freezing begins, but enter D state during the freeze=20
window. Upon investigation,

we found that these processes often depend on other user processes=20
(e.g., I/O helpers or system services), and when those dependencies are=20
frozen first, the dependent process (like Xorg) gets stuck and can=E2=80=99=
t be=20
frozen itself.

This led us to treat such processes as =E2=80=9Chard to freeze=E2=80=9D t=
asks =E2=80=94 not=20
because they=E2=80=99re inherently unfreezable, but because they are more=
 likely=20
to become problematic if not frozen early enough.

So our model works as follows:
 =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 By default, freezer tries to freeze=
 all freezable tasks in=20
each round.
 =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 With our approach, we only attempt =
to freeze tasks whose=20
freeze_priority is less than or equal to the current round number.
 =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 This ensures that higher-priority (=
i.e., harder-to-freeze)=20
tasks are attempted earlier, increasing the chance that they freeze=20
before being blocked by others.

Since we cannot know in advance which tasks will be difficult to freeze,=20
we use heuristics:
 =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 Any task that causes freeze failure=
 or is found in D state=20
during the freeze window is treated as hard-to-freeze in the next=20
attempt and its priority is increased.
 =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 Additionally, users can manually ra=
ise/reduce the freeze=20
priority of known problematic tasks via an exposed sysfs interface,=20
giving them fine-grained control.

This doesn=E2=80=99t change the fundamental logic of the freezer =E2=80=94=
 it still=20
retries until all tasks are frozen =E2=80=94 but by adjusting the travers=
al order,

 =C2=A0we=E2=80=99ve observed significantly fewer retries and more reliab=
le success=20
in scenarios where these D state transitions occur.


