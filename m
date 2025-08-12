Return-Path: <linux-fsdevel+bounces-57480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B5B22062
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C1B50269D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 08:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556C2E0B6D;
	Tue, 12 Aug 2025 08:07:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC12D323D;
	Tue, 12 Aug 2025 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986063; cv=none; b=upePujkZeIKhIth3T3xt/ZdFpFYha8G2/9bsdh3SJ43fOAvQ6KlCGCmLP/+Jcx9OkqlU0rP/lDnQBU4Ffku7g0eXAymEtCduzBGeVt/peN4V73wgDsFQlipVBfuvmdKxV+p/hFVURDlAZrAe9tnPxqnVMd6DgCwcS7gwedKW1mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986063; c=relaxed/simple;
	bh=ppHfjYLPLrvBKVXbor0vxJ7W7C3/XYdv6C+CE+7RQuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NINOPlAcBAEu7zGruZzw0aISEP1FyOR08y2EFJe7uh4Mr9CXCMP83tehG5t3OxKSX9cSPmlfv4g+7/QDMLXsIoAsISD+npLbL6jF2Xjizijai6nPOXesF6Z2bcfbkk/6e8mwBLJaNaDIfWHRHWJQeiBmCK284dYil8xMfP9XJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 64813e56775311f0b29709d653e92f7d-20250812
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:24076325-4bf9-4abf-b7fe-95fc83e76d02,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:4ac8a97a339f6c8d3cea5f3b62b86d7b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 64813e56775311f0b29709d653e92f7d-20250812
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1538524574; Tue, 12 Aug 2025 16:07:30 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E888CE008FA3;
	Tue, 12 Aug 2025 16:07:27 +0800 (CST)
X-ns-mid: postfix-689AF63F-547715471
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id D062EE008FA2;
	Tue, 12 Aug 2025 16:07:11 +0800 (CST)
Message-ID: <9dca7c98-84e5-4d16-af76-93f2b0470243@kylinos.cn>
Date: Tue, 12 Aug 2025 16:07:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 6/9] freezer: Set default freeze priority for
 zombie tasks
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
 <20250807121418.139765-7-zhangzihuan@kylinos.cn>
 <20250808142948.GA21685@redhat.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250808142948.GA21685@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/8 22:29, Oleg Nesterov =E5=86=99=E9=81=93:
> On 08/07, Zihuan Zhang wrote:
>> @@ -6980,6 +6981,7 @@ void __noreturn do_task_dead(void)
>>   	current->flags |=3D PF_NOFREEZE;
>>
>>   	__schedule(SM_NONE);
>> +	freeze_set_default_priority(current, FREEZE_PRIORITY_NEVER);
>>   	BUG();
> But this change has no effect?
>
> Firstly, this last __schedule() should not return, note the BUG() we ha=
ve.
>
> Secondly, this zombie is already PF_NOFREEZE, freeze_task() will return
> false anyway.

Thanks for pointing that out.
Indeed, I=E2=80=99ve noticed that in the current position the code has no=
 effect.
If we move this code to a more appropriate place, it should improve both=20
safety and usefulness compared to the previous implementation.

> Oleg.
>

