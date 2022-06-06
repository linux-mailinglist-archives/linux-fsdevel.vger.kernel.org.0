Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD0553EE64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 21:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiFFTT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 15:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiFFTT6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:19:58 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45230115CAC;
        Mon,  6 Jun 2022 12:19:56 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 77C8F3FC00;
        Mon,  6 Jun 2022 19:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1654543190;
        bh=K+bCkP5CcB21zdaAQ4i4c8fx4eQGsa9syMHybRmRncw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=NO6lvjkHsJwW3anrcMCW4mNeNys3WtsBz7rlOVgsQA4ZFyKB+36rBaNTU7+HZc23y
         pLWcZmnnL6cNj8O+xLjSnuurEMMzW/OMm6Zgax/dNCWcGXZAswl6bWwrGEOLnFiJfI
         +owdVtUN/NuwE/hrfDg0tBiQ5OAWrcUZl8d2VUplNGGYEv2oNCLr2Ykma6MlFu1Daa
         V3mHTaoscVnfNPGLVdn0aGEasbrXu7YA/B36svTdTp8LJ2CXS6qmFaUsLofZCRp7Qf
         xpExGR/XSB/qYnpZac7sQ+Qzc36FSpI6l73uA3XuyOi8eLnflXzYqtRp3UkVxb4oIx
         5Haf8dQStSWIA==
Message-ID: <266e648a-c537-66bc-455b-37105567c942@canonical.com>
Date:   Mon, 6 Jun 2022 12:19:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Linux 5.18-rc4
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        gwml@vger.gnuweeb.org
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org>
 <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
 <87r1414y5v.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/22 11:28, Linus Torvalds wrote:
> On Mon, Jun 6, 2022 at 8:19 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Has anyone looked into this lock ordering issues?
> 
> The deadlock is
> 
>>>> [78140.503821]        CPU0                    CPU1
>>>> [78140.503823]        ----                    ----
>>>> [78140.503824]   lock(&newf->file_lock);
>>>> [78140.503826]                                lock(&p->alloc_lock);
>>>> [78140.503828]                                lock(&newf->file_lock);
>>>> [78140.503830]   lock(&ctx->lock);
> 
> and the alloc_lock -> file_lock on CPU1 is trivial - it's seq_show()
> in fs/proc/fd.c:
> 
>         task_lock(task);
>         files = task->files;
>         if (files) {
>                 unsigned int fd = proc_fd(m->private);
> 
>                 spin_lock(&files->file_lock);
> 
> and that looks all normal.
> 
> But the other chains look painful.
> 
> I do see the IPC code doing ugly things, in particular I detest this code:
> 
>         task_lock(current);
>         list_add(&shp->shm_clist, &current->sysvshm.shm_clist);
>         task_unlock(current);
> 
> where it is using the task lock to protect the shm_clist list. Nasty.
> 
> And it's doing that inside the shm_ids.rwsem lock _and_ inside the
> shp->shm_perm.lock.
> 
> So the IPC code has newseg() doing
> 
>    shmget ->
>     ipcget():
>      down_write(ids->rwsem) ->
>        newseg():
>          ipc_addid gets perm->lock
>          task_lock(current)
> 
> so you have
> 
>   ids->rwsem -> perm->lock -> alloc_lock
> 
> there.
> 
> So now we have that
> 
>    ids->rwsem -> ipcperm->lock -> alloc_lock -> file_lock
> 
> when you put those sequences together.
> 
> But I didn't figure out what the security subsystem angle is and how
> that then apparently mixes things up with execve.
> 
> Yes, newseg() is doing that
> 
>         error = security_shm_alloc(&shp->shm_perm);
> 
> while holding rwsem, but I can't see how that matters. From the
> lockdep output, rwsem doesn't actually seem to be part of the whole
> sequence.
> 
> It *looks* like we have
> 
>    apparmour ctx->lock -->
>       radix_tree_preloads.lock -->
>          ipcperm->lock
> 
> and apparently that's called under the file_lock somewhere, completing
> the circle.
> 
> I guess the execve component is that
> 
>   begin_new_exec ->
>     security_bprm_committing_creds ->
>       apparmor_bprm_committing_creds ->
>         aa_inherit_files ->
>           iterate_fd ->   *takes file_lock*
>             match_file ->
>               aa_file_perm ->
>                 update_file_ctx *takes ctx->lock*
> 
> so that's how you get file_lock -> ctx->lock.
> 
yes

> So you have:
> 
>  SHMGET:
>     ipcperm->lock -> alloc_lock
>  /proc:
>     alloc_lock -> file_lock
>  apparmor_bprm_committing_creds:
>     file_lock -> ctx->lock
> 
> and then all you need is ctx->lock -> ipcperm->lock but I didn't find that part.
> 
yeah that is the part I got stuck on, before being pulled away from this

> I suspect that part is that both Apparmor and IPC use the idr local lock.
> 
bingo,

apparmor moved its secids allocation from a custom radix tree to idr in

  99cc45e48678 apparmor: Use an IDR to allocate apparmor secids

and ipc is using the idr for its id allocation as well

I can easily lift the secid() allocation out of the ctx->lock but that
would still leave it happening under the file_lock and not fix the problem.
I think the quick solution would be for apparmor to stop using idr, reverting
back at least temporarily to the custom radix tree.


