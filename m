Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315AD571ED1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 17:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiGLPUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 11:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiGLPTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:19:03 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79777C4441;
        Tue, 12 Jul 2022 08:14:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E5D45C00C5;
        Tue, 12 Jul 2022 11:14:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Jul 2022 11:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1657638853; x=1657725253; bh=K0oMR9Ywpn
        pKggCpxNkdlZh5kdkAJqeLH7UnRFMxakI=; b=C9jqbtzu0ua6Xvp3yUcf1xf+Lm
        VPJH2O9Sp4oY3pywlygS/B03nZPxTRBwIQwhYpsvQOggXQrIPS1gbHdO+UeQRpxU
        gsdjoN2YtmfSjtxFVGk9jByVmpWs2fas4X6Xwr2lYHeWWS+Rto9gXAp5QoDMgHnG
        rG1sr1ycMnP5gu+Pl4idKf2SqgHWxRsP88Zsv6+eeBl+6N+uL1qwrE9IJVlGOgjy
        ogSqbDRbW40WfhlkuZbMxT1zHUqG0cXRlk8fpfHNdbTZc3JVgX7VNJyAiIsHtrSW
        9fplwBUE1Cs1hYgTh/9Ruln84neAU+L9STM8RRmX1Px3Go2Ich0qGfLm5/wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657638853; x=1657725253; bh=K0oMR9YwpnpKggCpxNkdlZh5kdkA
        JqeLH7UnRFMxakI=; b=MLyWGRCS1eNuiNFYsB+Qvr3q3mk6v7JBLrsEv1096i1l
        EdyfWzcbYZxXSdLVLIq+M8LgrOtJtjGk9EV6hJ8bC5sco2qcauVQYbrWjH191nWB
        fscU3Oyd/or/GLlAn3aYOl6YtbP4SsnE1/5f4W3xeIKFZPqfi5lP6Jzc0F5nDH7j
        TE2FsE29qKH603ed1+7z8AcV3mMTqOAvK51sQMSwgYZhrArWCsee7vYKB/GwrFsQ
        RvT2gSiaFUigKU9hempeaBkjsTkxQ76imOlCzj3JIj4pyEL876o1FMYOKr6ORH3u
        eKQmxkiPrqROzsMq0SZV/bcfojILAtVdXf4VEky3wg==
X-ME-Sender: <xms:xI_NYux5d-8Iev1TLqAiy9kLYYN5IrHzsqQehAXxzqSZkQomJbpeVA>
    <xme:xI_NYqQN76Lt0BJ8LS_eIUYRRHwc1mug93J9ybYl01UzJi6ilC3VECkxtfSfdgnyT
    xvJzYIdqPCboOPVX8w>
X-ME-Received: <xmr:xI_NYgV_muiSLBJ16BAyTAQ2fNtMoMHg6pzdoTXeU6ccl9MQwQS2v8OW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejhedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:xI_NYkj_ZYvQglH4Sqp7xt1zNZJOYLDWh7AaA_2WaEYdX6LQ4iEJtQ>
    <xmx:xI_NYgAmbADCYfkWcFbWrW2DiXsTpu9zAqbLhcCpsU4Nw1UcRbe4rw>
    <xmx:xI_NYlLKFuH_pEiUhM0OZM_pQ3sXrgYmuCocbrpcPcEQmzHeSIJlAQ>
    <xmx:xY_NYj_P4MUdWdoUFGdHSP_FHN7-LtyWzH68FAQePCFy00SSy3AVfw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Jul 2022 11:14:11 -0400 (EDT)
Date:   Tue, 12 Jul 2022 09:14:09 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: strange interaction between fuse + pidns
Message-ID: <Ys2PwTS0qFmGNFqy@netflix>
References: <YrShFXRLtRt6T/j+@risky>
 <CAJfpegvH1EMS_469yOyUP9f=eCAEqzhyngm7h=YLRExeRdPEaw@mail.gmail.com>
 <CAJfpegurW7==LEp2yXWMYdBYXTZN4HCMMVJPu-f8yvHVbu79xQ@mail.gmail.com>
 <YsyHMVLuT5U6mm+I@netflix>
 <877d4jbabb.fsf@email.froward.int.ebiederm.org>
 <Ysyp8Kbl8FzhApUb@netflix>
 <87zghf6yhe.fsf@email.froward.int.ebiederm.org>
 <Ys16l6+iotX2JE33@netflix>
 <87sfn62yd1.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfn62yd1.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 09:34:50AM -0500, Eric W. Biederman wrote:
> Tycho Andersen <tycho@tycho.pizza> writes:
> 
> > On Mon, Jul 11, 2022 at 06:06:21PM -0500, Eric W. Biederman wrote:
> >> Tycho Andersen <tycho@tycho.pizza> writes:
> >> It is not different enough to change the semantics.  What I am aiming
> >> for is having a dedicated flag indicating a task will exit, that
> >> fatal_signal_pending can check.  And I intend to make that flag one way
> >> so that once it is set it will never be cleared.
> >
> > Ok - how far out is that? I'd like to try to convince Miklos to land
> > the fuse part of this fix now, but without the "look at shared signals
> > too" patch, that fix is useless. I'm not married to my patch, but I
> > would like to get this fixed somehow soon.
> 
> My point is that we need to figure out why you need the look at shared
> signals.

At least in the case where the task was already exiting, it's because
complete_signal() never wakes them up.

> If I can get everything reviewed my changes will be in the next merge
> window (it unfortunately always takes longer to get the code reviewed
> than I would like).
> 
> However when my changes land does not matter.  What you are trying to
> solve is orthogonal of my on-going work.
> 
> The problem is that looking at shared signals is fundamentally broken.
> A case in point is that kernel threads can have a pending SIGKILL that
> is not a fatal signal.  As kernel threads are allowed to ignore or even
> handle SIGKILL.
> 
> If you want to change fatal_signal_pending to include PF_EXITING I would
> need to double check the implications but I think that would work, and
> would not have the problems including the shared pending state of
> SIGKILL.

I think that would work. I'll test it out, thanks.

> >> The other thing I have played with that might be relevant was removing
> >> the explicit wait in zap_pid_ns_processes and simply not allowing wait
> >> to reap the pid namespace init until all it's children had been reaped.
> >> Essentially how we deal with the thread group leader for ordinary
> >> processes.  Does that sound like it might help in the fuse case?
> >
> > No, the problem is that the wait code doesn't know to look in the
> > right place, so waiting later still won't help.
> 
> I was suggesting to modify the kernel so that zap_pid_ns_processes would
> not wait for the zapped processes.  Instead I was proposing that
> delay_group_leader called from wait_consider_task would simply refuse to
> allow the init process of a pid namespace to be reaped until every other
> process of that pid namespace had exited.
> 
> You can prototype how that would affect the deadlock by simply removing
> the waiting from zap_pid_ns_processes.
> 
> I suggest that simply because that has the potential to remove some of
> the strange pid namespace cases.
> 
> I don't understand the problematic interaction between pid namespace
> shutdown and the fuse daemon, so I am merely suggesting a possibility
> that I know can simplify pid namespace shutdown.
> 
> Something like:
> 
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index f4f8cb0435b4..d22a30b0b0cf 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -207,47 +207,6 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  	read_unlock(&tasklist_lock);
>  	rcu_read_unlock();
>  
> -	/*
> -	 * Reap the EXIT_ZOMBIE children we had before we ignored SIGCHLD.
> -	 * kernel_wait4() will also block until our children traced from the
> -	 * parent namespace are detached and become EXIT_DEAD.
> -	 */
> -	do {
> -		clear_thread_flag(TIF_SIGPENDING);
> -		rc = kernel_wait4(-1, NULL, __WALL, NULL);
> -	} while (rc != -ECHILD);
> -
> -	/*
> -	 * kernel_wait4() misses EXIT_DEAD children, and EXIT_ZOMBIE
> -	 * process whose parents processes are outside of the pid
> -	 * namespace.  Such processes are created with setns()+fork().
> -	 *
> -	 * If those EXIT_ZOMBIE processes are not reaped by their
> -	 * parents before their parents exit, they will be reparented
> -	 * to pid_ns->child_reaper.  Thus pidns->child_reaper needs to
> -	 * stay valid until they all go away.
> -	 *
> -	 * The code relies on the pid_ns->child_reaper ignoring
> -	 * SIGCHILD to cause those EXIT_ZOMBIE processes to be
> -	 * autoreaped if reparented.
> -	 *
> -	 * Semantically it is also desirable to wait for EXIT_ZOMBIE
> -	 * processes before allowing the child_reaper to be reaped, as
> -	 * that gives the invariant that when the init process of a
> -	 * pid namespace is reaped all of the processes in the pid
> -	 * namespace are gone.
> -	 *
> -	 * Once all of the other tasks are gone from the pid_namespace
> -	 * free_pid() will awaken this task.
> -	 */
> -	for (;;) {
> -		set_current_state(TASK_INTERRUPTIBLE);
> -		if (pid_ns->pid_allocated == init_pids)
> -			break;
> -		schedule();
> -	}
> -	__set_current_state(TASK_RUNNING);
> -
>  	if (pid_ns->reboot)
>  		current->signal->group_exit_code = pid_ns->reboot;

Yes, but we need to add the wait to delay_group_leader(), and if the
tasks are stuck indefinitely looking at the wrong condition, I don't
see how moving it will help resolve things.

Thanks,

Tycho
