Return-Path: <linux-fsdevel+bounces-2456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 815177E6151
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 01:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2268BB20E6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 00:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03836E;
	Thu,  9 Nov 2023 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F0360
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 00:18:26 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D851BFF;
	Wed,  8 Nov 2023 16:18:25 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:58140)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r0skU-000smb-Ih; Wed, 08 Nov 2023 17:18:21 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:56084 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r0skT-0037wH-FT; Wed, 08 Nov 2023 17:18:18 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Kees Cook <kees@kernel.org>,  Josh Triplett
 <josh@joshtriplett.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  linux-mm@kvack.org,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
	<202311071228.27D22C00@keescook> <20231107205151.qkwlw7aarjvkyrqs@f>
	<CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>
	<202311071445.53E5D72C@keescook>
	<CAGudoHF5mYFWtzrv539W8Uc1aO_u6+UJOoDqWY0pePc+cofziw@mail.gmail.com>
	<A7FFA44F-F7DD-477F-83A6-44AF71D6775E@kernel.org>
	<CAGudoHESNDTAAOGB3riYjU3tgHTXVLRdB7tknfVBem38yqkJEA@mail.gmail.com>
	<202311081129.9E1EC8D34@keescook>
	<CAGudoHEqv=JmMyV8vYSvhubxXaW-cK3n5WRR=nR7eDZjBOQTcw@mail.gmail.com>
Date: Wed, 08 Nov 2023 18:17:53 -0600
In-Reply-To: <CAGudoHEqv=JmMyV8vYSvhubxXaW-cK3n5WRR=nR7eDZjBOQTcw@mail.gmail.com>
	(Mateusz Guzik's message of "Wed, 8 Nov 2023 20:35:55 +0100")
Message-ID: <87msvnwzim.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1r0skT-0037wH-FT;;;mid=<87msvnwzim.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19FZAR+Ppw2c1+15ty8jD9sRIiAHEI+ZEI=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4965]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.0 XM_Body_Dirty_Words Contains a dirty word
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Mateusz Guzik <mjguzik@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 545 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (2.0%), b_tie_ro: 10 (1.8%), parse: 0.90
	(0.2%), extract_message_metadata: 17 (3.0%), get_uri_detail_list: 1.88
	(0.3%), tests_pri_-2000: 14 (2.6%), tests_pri_-1000: 2.5 (0.5%),
	tests_pri_-950: 1.20 (0.2%), tests_pri_-900: 0.99 (0.2%),
	tests_pri_-200: 0.92 (0.2%), tests_pri_-100: 4.4 (0.8%),
	tests_pri_-90: 66 (12.1%), check_bayes: 64 (11.8%), b_tokenize: 8
	(1.5%), b_tok_get_all: 11 (2.1%), b_comp_prob: 3.2 (0.6%),
	b_tok_touch_all: 37 (6.9%), b_finish: 0.99 (0.2%), tests_pri_0: 288
	(52.9%), check_dkim_signature: 0.53 (0.1%), check_dkim_adsp: 3.1
	(0.6%), poll_dns_idle: 121 (22.2%), tests_pri_10: 2.9 (0.5%),
	tests_pri_500: 132 (24.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Mateusz Guzik <mjguzik@gmail.com> writes:

> On 11/8/23, Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Nov 08, 2023 at 01:03:33AM +0100, Mateusz Guzik wrote:
>>> I'm getting around 3.4k execs/s. However, if I "taskset -c 3
>>> ./static-doexec 1" the number goes up to about 9.5k and lock
>>> contention disappears from the profile. So off hand looks like the
>>> task is walking around the box when it perhaps could be avoided -- it
>>> is idle apart from running the test. Again this is going to require a
>>> serious look instead of ad hoc pokes.
>>
>> Peter, is this something you can speak to? It seems like execve() forces
>> a change in running CPU. Is this really something we want to be doing?
>> Or is there some better way to keep it on the same CPU unless there is
>> contention?
>>
>
> sched_exec causes migration only for only few % of execs in the bench,
> but when it does happen there is tons of overhead elsewhere.
>
> I expect real programs which get past execve will be prone to
> migrating anyway, regardless of what sched_exec is doing.
>
> That is to say, while sched_exec buggering off here would be nice, I
> think for real-world wins the thing to investigate is the overhead
> which comes from migration to begin with.

I have a vague memory that the idea is that there is a point during exec
when it should be much less expensive than normal to allow migration
between cpus because all of the old state has gone away.

Assuming that is the rationale, if we are getting lock contention
then either there is a global lock in there, or there is the potential
to pick a less expensive location within exec.


Just to confirm my memory I dug a little deeper and I found the original
commit that added sched_exec (in tglx's git tree of the bit keeper
history).

commit f01419fd6d4e5b32fef19d206bc3550cc04567a9
Author: Martin J. Bligh <mbligh@aracnet.com>
Date:   Wed Jan 15 19:46:10 2003 -0800

    [PATCH] (2/3) Initial load balancing
    
    Patch from Michael Hohnbaum
    
    This adds a hook, sched_balance_exec(), to the exec code, to make it
    place the exec'ed task on the least loaded queue. We have less state
    to move at exec time than fork time, so this is the cheapest point
    to cross-node migrate. Experience in Dynix/PTX and testing on Linux
    has confirmed that this is the cheapest time to move tasks between nodes.
    
    It also macro-wraps changes to nr_running, to allow us to keep track of
    per-node nr_running as well. Again, no impact on non-NUMA machines.


Eric


