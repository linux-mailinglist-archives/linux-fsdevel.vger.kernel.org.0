Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706BC571CD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiGLOfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 10:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiGLOfJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:35:09 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150F4B31F5;
        Tue, 12 Jul 2022 07:34:59 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:57756)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oBGyX-00B32U-U5; Tue, 12 Jul 2022 08:34:57 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:46192 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oBGyW-00Dghw-Qt; Tue, 12 Jul 2022 08:34:57 -0600
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
        <877d4jbabb.fsf@email.froward.int.ebiederm.org>
        <Ysyp8Kbl8FzhApUb@netflix>
        <87zghf6yhe.fsf@email.froward.int.ebiederm.org>
        <Ys16l6+iotX2JE33@netflix>
Date:   Tue, 12 Jul 2022 09:34:50 -0500
In-Reply-To: <Ys16l6+iotX2JE33@netflix> (Tycho Andersen's message of "Tue, 12
        Jul 2022 07:43:51 -0600")
Message-ID: <87sfn62yd1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oBGyW-00Dghw-Qt;;;mid=<87sfn62yd1.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19GFtaSVDwPoTYZnHwdRxtgbEun6enaSZ4=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 527 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (2.2%), b_tie_ro: 10 (1.8%), parse: 1.29
        (0.2%), extract_message_metadata: 14 (2.7%), get_uri_detail_list: 2.7
        (0.5%), tests_pri_-1000: 14 (2.7%), tests_pri_-950: 1.46 (0.3%),
        tests_pri_-900: 1.02 (0.2%), tests_pri_-90: 98 (18.5%), check_bayes:
        95 (18.0%), b_tokenize: 10 (1.9%), b_tok_get_all: 10 (1.9%),
        b_comp_prob: 3.4 (0.6%), b_tok_touch_all: 68 (12.8%), b_finish: 0.99
        (0.2%), tests_pri_0: 368 (69.8%), check_dkim_signature: 0.78 (0.1%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.56 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 12 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: strange interaction between fuse + pidns
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tycho Andersen <tycho@tycho.pizza> writes:

> On Mon, Jul 11, 2022 at 06:06:21PM -0500, Eric W. Biederman wrote:
>> Tycho Andersen <tycho@tycho.pizza> writes:
>> It is not different enough to change the semantics.  What I am aiming
>> for is having a dedicated flag indicating a task will exit, that
>> fatal_signal_pending can check.  And I intend to make that flag one way
>> so that once it is set it will never be cleared.
>
> Ok - how far out is that? I'd like to try to convince Miklos to land
> the fuse part of this fix now, but without the "look at shared signals
> too" patch, that fix is useless. I'm not married to my patch, but I
> would like to get this fixed somehow soon.

My point is that we need to figure out why you need the look at shared
signals.

If I can get everything reviewed my changes will be in the next merge
window (it unfortunately always takes longer to get the code reviewed
than I would like).

However when my changes land does not matter.  What you are trying to
solve is orthogonal of my on-going work.

The problem is that looking at shared signals is fundamentally broken.
A case in point is that kernel threads can have a pending SIGKILL that
is not a fatal signal.  As kernel threads are allowed to ignore or even
handle SIGKILL.

If you want to change fatal_signal_pending to include PF_EXITING I would
need to double check the implications but I think that would work, and
would not have the problems including the shared pending state of
SIGKILL.

>> The other thing I have played with that might be relevant was removing
>> the explicit wait in zap_pid_ns_processes and simply not allowing wait
>> to reap the pid namespace init until all it's children had been reaped.
>> Essentially how we deal with the thread group leader for ordinary
>> processes.  Does that sound like it might help in the fuse case?
>
> No, the problem is that the wait code doesn't know to look in the
> right place, so waiting later still won't help.

I was suggesting to modify the kernel so that zap_pid_ns_processes would
not wait for the zapped processes.  Instead I was proposing that
delay_group_leader called from wait_consider_task would simply refuse to
allow the init process of a pid namespace to be reaped until every other
process of that pid namespace had exited.

You can prototype how that would affect the deadlock by simply removing
the waiting from zap_pid_ns_processes.

I suggest that simply because that has the potential to remove some of
the strange pid namespace cases.

I don't understand the problematic interaction between pid namespace
shutdown and the fuse daemon, so I am merely suggesting a possibility
that I know can simplify pid namespace shutdown.

Something like:

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index f4f8cb0435b4..d22a30b0b0cf 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -207,47 +207,6 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	read_unlock(&tasklist_lock);
 	rcu_read_unlock();
 
-	/*
-	 * Reap the EXIT_ZOMBIE children we had before we ignored SIGCHLD.
-	 * kernel_wait4() will also block until our children traced from the
-	 * parent namespace are detached and become EXIT_DEAD.
-	 */
-	do {
-		clear_thread_flag(TIF_SIGPENDING);
-		rc = kernel_wait4(-1, NULL, __WALL, NULL);
-	} while (rc != -ECHILD);
-
-	/*
-	 * kernel_wait4() misses EXIT_DEAD children, and EXIT_ZOMBIE
-	 * process whose parents processes are outside of the pid
-	 * namespace.  Such processes are created with setns()+fork().
-	 *
-	 * If those EXIT_ZOMBIE processes are not reaped by their
-	 * parents before their parents exit, they will be reparented
-	 * to pid_ns->child_reaper.  Thus pidns->child_reaper needs to
-	 * stay valid until they all go away.
-	 *
-	 * The code relies on the pid_ns->child_reaper ignoring
-	 * SIGCHILD to cause those EXIT_ZOMBIE processes to be
-	 * autoreaped if reparented.
-	 *
-	 * Semantically it is also desirable to wait for EXIT_ZOMBIE
-	 * processes before allowing the child_reaper to be reaped, as
-	 * that gives the invariant that when the init process of a
-	 * pid namespace is reaped all of the processes in the pid
-	 * namespace are gone.
-	 *
-	 * Once all of the other tasks are gone from the pid_namespace
-	 * free_pid() will awaken this task.
-	 */
-	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (pid_ns->pid_allocated == init_pids)
-			break;
-		schedule();
-	}
-	__set_current_state(TASK_RUNNING);
-
 	if (pid_ns->reboot)
 		current->signal->group_exit_code = pid_ns->reboot;
 

Eric
