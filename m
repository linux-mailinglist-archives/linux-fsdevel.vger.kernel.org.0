Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0644570B81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 22:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiGKU0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 16:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiGKUZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:40 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A974D812;
        Mon, 11 Jul 2022 13:25:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0771B5C0130;
        Mon, 11 Jul 2022 16:25:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Jul 2022 16:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1657571125; x=1657657525; bh=kNzIp30Qm/
        z7d269z2/7uprxKlfk1b3Xh9kIgnDKL3w=; b=jdSmgR3nMHSEZedXM5Yb9S/a66
        VWyn4EdjuZc6tTPaLqq1KzPMJQt9mT7jXaIPKzyuDBHBY6lHP3385uKfUG3eRZsA
        7qIELLk4Y5sJE87O8iuD9v1dTyPAuUSHkBvorFw63UzEYHCv7HAkvciUKq4c6tKa
        6SfOVYVEHu9uCOAMmxkqjJcDMkSQqmnZ7qLMsH2Flrw1ssXzzjjG6tzm4wrBc4p8
        PzlFxlxCztZjot7Qnv3Fpxyc6IizHrp7RX6GuBEl/nMvp63pJaby8lN6JAKITDYY
        kPt7nhnjsOvdL9COeX9wqq08xW+JB1f9J3qfQxfj7EtsRMLJoblB8gCJ2e2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657571125; x=1657657525; bh=kNzIp30Qm/z7d269z2/7uprxKlfk
        1b3Xh9kIgnDKL3w=; b=k5rCBC2IsD779cvf/It1Nxc+98YUYsRPuKokoHQXcS+h
        119XRyia2VNbLP+m6impbKEn7Y20/n52qOwE3vYr3ZEoA3kGJRH24QDNbV6Miylt
        QTDKd9meOrUNyGchCPM4pZEBlJ6L7hS88+ou5zO0bH1AQEsbsQ9BpXE97WCddBpF
        qu5tCMZWuyvQQxqrnUY/k8urkbZxdv/295w61YNmUTlA1n13JqIdxMUIlIrpVNHd
        rnWYqBzWT9ZoJOSGaqnKCrn6OQuTlcbgskf9G0MXoumnpgIpwMozDdC3IoX+CWBN
        dZXJ/o1Evg65WevBCatMrVtpgIMDfWCM415S+Lf3fw==
X-ME-Sender: <xms:NIfMYsr3CJXdzuXI0q7WglfUM3zszE9cKM5ehjBkHNQ5xrGtoqSvkw>
    <xme:NIfMYioZn2W1EMkm0PDjOPFb_SoFp1CSC4rzSfSn1Ptxj5YxI_Yxiivnf29tWaiEw
    Y1au1oj16yyecHiGKU>
X-ME-Received: <xmr:NIfMYhPLccsl49jduEzW5uowsbGtEU2rOQg5KC_KvIMH2lMLWjeBWPTW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejfedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:NIfMYj71TdBzJ5iwFd9PaWaNtD3KVzbpVZUwnoPKHEmcY4EeDdCA7g>
    <xmx:NIfMYr7j8tC0EctlhFIX00r8-x3VqnbqPt1d8UEGIZopCvnGILkG9A>
    <xmx:NIfMYjhIFmj4HoQr7wWuP9-xQebg0SQQNekhGMvmuUmRXtxN4hgL0A>
    <xmx:NYfMYu298dFgWEiyHHgz4RnXZlQqtVPNXhXdaY1Azc4fq4xTPvpdrg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Jul 2022 16:25:23 -0400 (EDT)
Date:   Mon, 11 Jul 2022 14:25:21 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: strange interaction between fuse + pidns
Message-ID: <YsyHMVLuT5U6mm+I@netflix>
References: <YrShFXRLtRt6T/j+@risky>
 <CAJfpegvH1EMS_469yOyUP9f=eCAEqzhyngm7h=YLRExeRdPEaw@mail.gmail.com>
 <CAJfpegurW7==LEp2yXWMYdBYXTZN4HCMMVJPu-f8yvHVbu79xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegurW7==LEp2yXWMYdBYXTZN4HCMMVJPu-f8yvHVbu79xQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

On Mon, Jul 11, 2022 at 03:59:15PM +0200, Miklos Szeredi wrote:
> On Mon, 11 Jul 2022 at 12:35, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > Can you try the attached untested patch?
> 
> Updated patch to avoid use after free on req->args.
> 
> Still mostly untested.

Thanks, when I applied your patch, I still ended up with tasks stuck
waiting with a SIGKILL pending. So I looked into that and came up with
the patch below. With both your patch and mine, my testcase exits
cleanly.

Eric (or Christian, or anyone), can you comment on the patch below? I
have no idea what this will break. Maybe instead a better approach is
some additional special case in __send_signal_locked()?

Tycho

From b7ea26adcf3546be5745063cc86658acb5ed37e9 Mon Sep 17 00:00:00 2001
From: Tycho Andersen <tycho@tycho.pizza>
Date: Mon, 11 Jul 2022 11:26:58 -0600
Subject: [PATCH] sched: __fatal_signal_pending() should also check shared
 signals

The wait_* code uses signal_pending_state() to test whether a thread has
been interrupted, which ultimately uses __fatal_signal_pending() to detect
if there is a fatal signal.

When a pid ns dies, in zap_pid_ns_processes() it does:

    group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);

for all the tasks in the pid ns. That calls through:

    group_send_sig_info() ->
      do_send_sig_info() ->
        send_signal_locked() ->
          __send_signal_locked()

which does:

    pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;

which puts sigkill in the set of shared signals, but not the individual
pending ones. If tasks are stuck in a killable wait (e.g. a fuse flush
operation), they won't see this shared signal, and will hang forever, since
TIF_SIGPENDING is set, but the fatal signal can't be detected.

Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
---
 include/linux/sched/signal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index cafbe03eed01..a033ccb0a729 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -402,7 +402,8 @@ static inline int signal_pending(struct task_struct *p)
 
 static inline int __fatal_signal_pending(struct task_struct *p)
 {
-	return unlikely(sigismember(&p->pending.signal, SIGKILL));
+	return unlikely(sigismember(&p->pending.signal, SIGKILL) ||
+			sigismember(&p->signal->shared_pending.signal, SIGKILL));
 }
 
 static inline int fatal_signal_pending(struct task_struct *p)

base-commit: 32346491ddf24599decca06190ebca03ff9de7f8
-- 
2.34.1

