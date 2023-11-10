Return-Path: <linux-fsdevel+bounces-2697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124E47E793A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 07:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE861C20CED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 06:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922F563C0;
	Fri, 10 Nov 2023 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380F6121
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 06:23:49 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC856F83;
	Thu,  9 Nov 2023 22:23:47 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:52218)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r1K32-00Au9P-8z; Thu, 09 Nov 2023 22:27:16 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:57024 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r1K31-002Sgf-8u; Thu, 09 Nov 2023 22:27:15 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Kees Cook <kees@kernel.org>,
  Josh Triplett <josh@joshtriplett.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  linux-mm@kvack.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
	<202311071228.27D22C00@keescook> <20231107205151.qkwlw7aarjvkyrqs@f>
	<CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>
	<202311071445.53E5D72C@keescook>
	<CAGudoHF5mYFWtzrv539W8Uc1aO_u6+UJOoDqWY0pePc+cofziw@mail.gmail.com>
	<A7FFA44F-F7DD-477F-83A6-44AF71D6775E@kernel.org>
	<CAGudoHESNDTAAOGB3riYjU3tgHTXVLRdB7tknfVBem38yqkJEA@mail.gmail.com>
	<202311081129.9E1EC8D34@keescook>
	<CAGudoHEqv=JmMyV8vYSvhubxXaW-cK3n5WRR=nR7eDZjBOQTcw@mail.gmail.com>
	<87msvnwzim.fsf@email.froward.int.ebiederm.org>
	<CAGudoHHb8Fh5UxgMa-hw3Kj=wjMqpdZq2J6869fBgsKXcZOeHA@mail.gmail.com>
Date: Thu, 09 Nov 2023 23:26:23 -0600
In-Reply-To: <CAGudoHHb8Fh5UxgMa-hw3Kj=wjMqpdZq2J6869fBgsKXcZOeHA@mail.gmail.com>
	(Mateusz Guzik's message of "Thu, 9 Nov 2023 13:21:04 +0100")
Message-ID: <87a5rmw54w.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1r1K31-002Sgf-8u;;;mid=<87a5rmw54w.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+cPIx/y1pkh9ZJrAXmYoQCg+zoL4NEB9Y=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Mateusz Guzik <mjguzik@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 403 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 15 (3.7%), b_tie_ro: 13 (3.2%), parse: 1.25
	(0.3%), extract_message_metadata: 14 (3.6%), get_uri_detail_list: 1.99
	(0.5%), tests_pri_-2000: 12 (3.0%), tests_pri_-1000: 2.3 (0.6%),
	tests_pri_-950: 1.33 (0.3%), tests_pri_-900: 1.17 (0.3%),
	tests_pri_-90: 99 (24.6%), check_bayes: 97 (24.0%), b_tokenize: 7
	(1.8%), b_tok_get_all: 10 (2.5%), b_comp_prob: 3.4 (0.8%),
	b_tok_touch_all: 71 (17.5%), b_finish: 1.36 (0.3%), tests_pri_0: 240
	(59.6%), check_dkim_signature: 0.55 (0.1%), check_dkim_adsp: 3.0
	(0.8%), poll_dns_idle: 1.28 (0.3%), tests_pri_10: 3.4 (0.8%),
	tests_pri_500: 9 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Mateusz Guzik <mjguzik@gmail.com> writes:

> On 11/9/23, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Mateusz Guzik <mjguzik@gmail.com> writes:
>>> sched_exec causes migration only for only few % of execs in the bench,
>>> but when it does happen there is tons of overhead elsewhere.
>>>
>>> I expect real programs which get past execve will be prone to
>>> migrating anyway, regardless of what sched_exec is doing.
>>>
>>> That is to say, while sched_exec buggering off here would be nice, I
>>> think for real-world wins the thing to investigate is the overhead
>>> which comes from migration to begin with.
>>
>> I have a vague memory that the idea is that there is a point during exec
>> when it should be much less expensive than normal to allow migration
>> between cpus because all of the old state has gone away.
>>
>> Assuming that is the rationale, if we are getting lock contention
>> then either there is a global lock in there, or there is the potential
>> to pick a less expensive location within exec.
>>
>
> Given the commit below I think the term "migration cost" is overloaded here.
>
> By migration cost in my previous mail I meant the immediate cost
> (stop_one_cpu and so on), but also the aftermath -- for example tlb
> flushes on another CPU when tearing down your now-defunct mm after you
> switched.
>
> For testing purposes I verified commenting out sched_exec and not
> using taskset still gives me about 9.5k ops/s.
>
> I 100% agree should the task be moved between NUMA domains, it makes
> sense to do it when it has the smallest footprint. I don't know what
> the original patch did, the current code just picks a CPU and migrates
> to it, regardless of NUMA considerations. I will note that the goal
> would still be achieved by comparing domains and doing nothing if they
> match.
>
> I think this would be nice to fix, but it is definitely not a big
> deal. I guess the question is to Peter Zijlstra if this sounds
> reasonable.

Perhaps I misread the trace. My point was simply that the sched_exec
seemed to be causing lock contention because what was on one cpu is
now on another cpu, and we are now getting cross cpu lock ping-pongs.

If the sched_exec is causing exec to cause cross cpu lock ping-pongs,
then we can move sched_exec to a better place within exec.  It has
already happened once, shortly after it was introduced.

Ultimately we want the sched_exec to be in the cheapest place within
exec that we can find.

Eric

