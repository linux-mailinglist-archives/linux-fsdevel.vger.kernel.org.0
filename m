Return-Path: <linux-fsdevel+bounces-57283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE46B203C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144D63BF41D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17C92DCF7E;
	Mon, 11 Aug 2025 09:32:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4423D297;
	Mon, 11 Aug 2025 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904730; cv=none; b=o9numsvMQVOzQLOPkjiAhG4cYXOnsI8SdOGTJgZ5SRRsEx5d5wU2uBhZ75x+xLRisMDXuPnjLjrOBQsHk6X7xDRT74T46e33jNB4Ev8J9lVYIRhzgm98ZykC7RghzIkjVSO7O68cD+SRmCDvekTgOYXfmBN11Hy7vIYJKfcuLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904730; c=relaxed/simple;
	bh=z+e4SktanIlv7wl3w34bGoc7lNCFYrrXJIFaG3Pie+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DELFo2Z/hAWuwdmqeKKg2Ie/dHCgX3Wv8Ji/VmZsyYa0CKOB75iTjjhg1DnJ3Mlezu453uAX5NGha8mnbCKnr9v9s7jJCaFLwlnEUaOjcSdRPqDSwNMqoXL25vdLM9w09DCwPCVqGRyvY5xcnh+37Nn5Uwjgqn6uL+LP82s9mRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 09119de4769611f0b29709d653e92f7d-20250811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:6894e59b-7da2-4bdd-9d45-8007d9a3ccca,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:116d6fe237f848fad94ae5ca94f49707,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 09119de4769611f0b29709d653e92f7d-20250811
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1613669997; Mon, 11 Aug 2025 17:32:01 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 2F02AE009021;
	Mon, 11 Aug 2025 17:32:01 +0800 (CST)
X-ns-mid: postfix-6899B890-891391949
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id CD093E00901E;
	Mon, 11 Aug 2025 17:31:57 +0800 (CST)
Message-ID: <ee4191ab-ecce-481f-999d-e65bfee799e7@kylinos.cn>
Date: Mon, 11 Aug 2025 17:31:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 7/9] freezer: raise freeze priority of tasks failed
 to freeze last time
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
 <20250807121418.139765-8-zhangzihuan@kylinos.cn>
 <20250808145349.GC21685@redhat.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250808145349.GC21685@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/8 22:53, Oleg Nesterov =E5=86=99=E9=81=93:
>> -				if (p !=3D current && freezing(p) && !frozen(p))
>> +				if (p !=3D current && freezing(p) && !frozen(p)) {
>> +					freeze_set_default_priority(p, FREEZE_PRIORITY_HIGH);
>>   					sched_show_task(p);
>> +				}
> IMO, this change should go into 3/9 to make the intent more clear.
Will do. Indeed, D-state tasks are not easy to solve, so our plan is to=20
provide a fallback-like mechanism.
> Other than that, I leave this series to maintainers and other reviewers=
.
> Personally, I am skeptical.

