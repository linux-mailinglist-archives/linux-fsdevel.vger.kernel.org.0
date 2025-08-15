Return-Path: <linux-fsdevel+bounces-57986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A31E1B27AF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 10:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97AA54E401F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9B4248863;
	Fri, 15 Aug 2025 08:27:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341A710E0;
	Fri, 15 Aug 2025 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246455; cv=none; b=U7I3UwP4C0jiroLSAz8gGh4K+RYYnIGETJMIbVpY9UlHHkgliNsUK/xFI0O+gsXZabe62xNhLjGb0SrQrBoU3qUt06cjiAPRBK0NK6lITeNIixEs3iK+lbWlLk3uJtY1P3UpddJuaMzwY9A1noc8GWgMIpSJwLIQix3txN75OBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246455; c=relaxed/simple;
	bh=RcZMl5K/x5WJWGxz7wXDHxJSURQrTCmZO/JmwgRl6B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlcrAzbmh81A+K8U5Fep+KPWBrcj3prYcbaL86xlstg83M5JywQ9C4Pti3CErLT4aR3Y6IHQ2mKu3/tfoSTABMENd7eQ0msBoWgjLx1MaoKeIfyGy+44jujAjdg8ayIp6/v6A0Yd53uRx3tACvd8IFsBQUkdnre2ReuF676H3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: abff620279b111f0b29709d653e92f7d-20250815
X-CID-CACHE: Type:Local,Time:202508151617+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:339357e6-611c-4c45-9af4-4b0f9ad93f29,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:bc8e9e1cfca9223f5b74cc50e33c6883,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: abff620279b111f0b29709d653e92f7d-20250815
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1281589497; Fri, 15 Aug 2025 16:27:25 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A5724E008FA4;
	Fri, 15 Aug 2025 16:27:24 +0800 (CST)
X-ns-mid: postfix-689EEF6C-527582324
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id B8201E008FA3;
	Fri, 15 Aug 2025 16:27:18 +0800 (CST)
Message-ID: <bef49dcb-8619-4448-b8d7-6dca3a6cb456@kylinos.cn>
Date: Fri, 15 Aug 2025 16:27:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Oleg Nesterov
 <oleg@redhat.com>, David Hildenbrand <david@redhat.com>,
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
 <20250814143717.GY4067720@noisy.programming.kicks-ass.net>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250814143717.GY4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/14 22:37, Peter Zijlstra =E5=86=99=E9=81=93:
> On Thu, Aug 07, 2025 at 08:14:09PM +0800, Zihuan Zhang wrote:
>
>> Freeze Window Begins
>>
>>      [process A] - epoll_wait()
>>          =E2=94=82
>>          =E2=96=BC
>>      [process B] - event source (already frozen)
>>
> Can we make epoll_wait() TASK_FREEZABLE? AFAICT it doesn't hold any
> resources, it just sits there waiting for stuff.

Based on the code, it=E2=80=99s ep_poll() that puts the task into the D s=
tate,=20
most likely due to I/O or lower-level driver behavior. In fs/eventpoll.c:

Line:2097 __set_current_state=20
<https://elixir.bootlin.com/linux/v6.16/C/ident/__set_current_state>(TASK=
_INTERRUPTIBLE=20
<https://elixir.bootlin.com/linux/v6.16/C/ident/TASK_INTERRUPTIBLE>);

Simply changing the task state may not actually address the root cause.=20
Currently, our approach is to identify tasks that are more likely to=20
cause such issues and freeze them earlier or later in the process to=20
avoid conflicts.


