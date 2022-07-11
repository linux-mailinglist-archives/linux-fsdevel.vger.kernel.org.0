Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90130570CCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 23:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiGKVhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 17:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiGKVhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:37:48 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E810032BB2;
        Mon, 11 Jul 2022 14:37:46 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56004)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB169-00Fyyi-KE; Mon, 11 Jul 2022 15:37:45 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:45020 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB168-00GwFM-AH; Mon, 11 Jul 2022 15:37:45 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YrShFXRLtRt6T/j+@risky>
        <CAJfpegvH1EMS_469yOyUP9f=eCAEqzhyngm7h=YLRExeRdPEaw@mail.gmail.com>
        <CAJfpegurW7==LEp2yXWMYdBYXTZN4HCMMVJPu-f8yvHVbu79xQ@mail.gmail.com>
        <YsyHMVLuT5U6mm+I@netflix>
Date:   Mon, 11 Jul 2022 16:37:12 -0500
In-Reply-To: <YsyHMVLuT5U6mm+I@netflix> (Tycho Andersen's message of "Mon, 11
        Jul 2022 14:25:21 -0600")
Message-ID: <877d4jbabb.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oB168-00GwFM-AH;;;mid=<877d4jbabb.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+BNhhz/q5rz9OSWYm2QD2VMDoDaU2rMNc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 745 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 14 (1.8%), b_tie_ro: 12 (1.6%), parse: 1.03
        (0.1%), extract_message_metadata: 16 (2.2%), get_uri_detail_list: 2.3
        (0.3%), tests_pri_-1000: 14 (1.9%), tests_pri_-950: 1.32 (0.2%),
        tests_pri_-900: 1.17 (0.2%), tests_pri_-90: 335 (44.9%), check_bayes:
        326 (43.8%), b_tokenize: 9 (1.2%), b_tok_get_all: 184 (24.7%),
        b_comp_prob: 2.9 (0.4%), b_tok_touch_all: 126 (17.0%), b_finish: 0.85
        (0.1%), tests_pri_0: 343 (46.1%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 3.0 (0.4%), poll_dns_idle: 1.10 (0.1%), tests_pri_10:
        2.7 (0.4%), tests_pri_500: 13 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: strange interaction between fuse + pidns
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tycho Andersen <tycho@tycho.pizza> writes:

> Hi all,
>
> On Mon, Jul 11, 2022 at 03:59:15PM +0200, Miklos Szeredi wrote:
>> On Mon, 11 Jul 2022 at 12:35, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> >
>> > Can you try the attached untested patch?
>> 
>> Updated patch to avoid use after free on req->args.
>> 
>> Still mostly untested.
>
> Thanks, when I applied your patch, I still ended up with tasks stuck
> waiting with a SIGKILL pending. So I looked into that and came up with
> the patch below. With both your patch and mine, my testcase exits
> cleanly.
>
> Eric (or Christian, or anyone), can you comment on the patch below? I
> have no idea what this will break. Maybe instead a better approach is
> some additional special case in __send_signal_locked()?
>
> Tycho
>
> From b7ea26adcf3546be5745063cc86658acb5ed37e9 Mon Sep 17 00:00:00 2001
> From: Tycho Andersen <tycho@tycho.pizza>
> Date: Mon, 11 Jul 2022 11:26:58 -0600
> Subject: [PATCH] sched: __fatal_signal_pending() should also check shared
>  signals
>
> The wait_* code uses signal_pending_state() to test whether a thread has
> been interrupted, which ultimately uses __fatal_signal_pending() to detect
> if there is a fatal signal.
>
> When a pid ns dies, in zap_pid_ns_processes() it does:
>
>     group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);
>
> for all the tasks in the pid ns. That calls through:
>
>     group_send_sig_info() ->
>       do_send_sig_info() ->
>         send_signal_locked() ->
>           __send_signal_locked()
>
> which does:
>
>     pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
>
> which puts sigkill in the set of shared signals, but not the individual
> pending ones. If tasks are stuck in a killable wait (e.g. a fuse flush
> operation), they won't see this shared signal, and will hang forever, since
> TIF_SIGPENDING is set, but the fatal signal can't be detected.

Hmm.

That is perplexing.

__send_signal_locked calls complete_signal.  Then if any of the tasks of
the process can receive the signal, complete_signal will loop through
all of the tasks of the process and set the per thread SIGKILL.  Pretty
much by definition tasks can always receive SIGKILL.

Is complete_signal not being able to do that?

The patch below really should not be necessary, and I have pending work
that if I can push over the finish line won't even make sense.

As it is currently an abuse to use the per thread SIGKILL to indicate
that a fatal signal has been short circuit delivered.  That abuse as
well as being unclean tends to confuse people reading the code.

Eric

> Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> ---
>  include/linux/sched/signal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index cafbe03eed01..a033ccb0a729 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -402,7 +402,8 @@ static inline int signal_pending(struct task_struct *p)
>  
>  static inline int __fatal_signal_pending(struct task_struct *p)
>  {
> -	return unlikely(sigismember(&p->pending.signal, SIGKILL));
> +	return unlikely(sigismember(&p->pending.signal, SIGKILL) ||
> +			sigismember(&p->signal->shared_pending.signal, SIGKILL));
>  }
>  
>  static inline int fatal_signal_pending(struct task_struct *p)
>
> base-commit: 32346491ddf24599decca06190ebca03ff9de7f8
