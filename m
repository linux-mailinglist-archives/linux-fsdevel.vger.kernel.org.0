Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF62773D1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjHHQNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjHHQMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:12:51 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3331B7A91;
        Tue,  8 Aug 2023 08:47:03 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7658752ce2fso367474285a.1;
        Tue, 08 Aug 2023 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509621; x=1692114421;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xz/zhFKbMIJR+KKgZSw7P32rjOpIQihabZraRVRGK0=;
        b=gmdO3Cj4fkyniRVQa3BwSCJQrjTDaAdtuRHCdamQd7oE9DKI9tmIArNHrs15jtgZ16
         eRwxmVAp6CsvrfZS93LnZua1a8Co4VzfmIxEgSPJRUzy9km03LaCzBk1jRDbsH1q/vrd
         0jEG9/eHZKJdh+IRhOCWPpQ6DJR86CBwISaPUJ2skEiGa+VA283eszdmeh5XuEbYeIUq
         5OICAjUM8nnWhmpruyy96+7ulKr7cfYYdtNIozVjz4fO3dLMAnLNRsyBvho4EKtKB9p9
         bMBNz6/7EvUQWpXSeORWxsz1zlZqWtivsc6zLsy49gPaDf3BtAxVFhAJAZ+/APS3mYN4
         /mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509621; x=1692114421;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Xz/zhFKbMIJR+KKgZSw7P32rjOpIQihabZraRVRGK0=;
        b=eHLVpPWH0AMVfTpZDDVlmhKcWl/L/kFDePHfHEfJXYDNLP0BhusbKQCL04uVcpIKLW
         nOKM/3K1IHtNRLbwniuXi2TnlZWIGiGQcDjZGcnp/zvBW5QYIdsW4dLD8Bdaw2seN3aq
         8SmL6Q3O8RmL1o7723N2cSFwFOmFXdpsABHmCRquMa9F/owrA7dnGciQTg5VKJsQ8KPx
         U84nKIeLrEK1D1DP42wwc/WtSrsPTR9S8JCp3D9MR3qT5HVcVQAwv4pEYxJlauReicvR
         kxju+DXHCKo1I6Q/0Z+EoLG5ydjbInsnLdr2WmBC4CANP2DpCjXKUinP19NRTuka8m8i
         y1mA==
X-Gm-Message-State: AOJu0YyZhCsgytT+/it831PxmCJTEL7BQdNkji9Et//urFofWQeULPhm
        mKiC54MRaYGuJw91FcnIQzPK9Hle+kY2/jHKCH8sQVU2
X-Google-Smtp-Source: AGHT+IF1Xxk73VEWS4jxoUC9ZSSjSHdUi0h1IMt3oZJ23RnlCV/2A0GcySDKw7cZcRysgjBABCDDdC2hCFoernZsw60=
X-Received: by 2002:a05:6870:d10b:b0:1ba:629a:e34a with SMTP id
 e11-20020a056870d10b00b001ba629ae34amr14595706oac.12.1691479929454; Tue, 08
 Aug 2023 00:32:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:696:0:b0:4f0:1250:dd51 with HTTP; Tue, 8 Aug 2023
 00:32:08 -0700 (PDT)
In-Reply-To: <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 8 Aug 2023 09:32:08 +0200
Message-ID: <CAGudoHGKU-22o9AFWHk2c25dk_ugXJR3e3DHCZq_ku5BuJKwxQ@mail.gmail.com>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/23, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Adding a couple more people.
>
> Mateusz Guzik <mjguzik@gmail.com> writes:
>
>> Making close(2) delegate fput finalization with task_work_add() runs
>> into a slowdown (atomics needed to do it) which is artificially worsened
>> in presence of rseq, which glibc blindly uses if present (and it is
>> normally present) -- they added a user memory-touching handler into
>> resume_user_mode_work(), where the thread leaving the kernel lands after
>> issuing task_work_add() from fput(). Said touching requires a SMAP
>> round-trip which is quite expensive and it always executes when landing
>> in the resume routine.
>>
>> I'm going to write a separate e-mail about the rseq problem later, but
>> even if it gets sorted out there is still perf to gain (or rather,
>> overhead to avoid).
>>
>> Numbers are below in the proposed patch, but tl;dr without CONFIG_RSEQ
>> making things worse for the stock kernel I see about 7% increase in
>> ops/s with open+close.
>>
>> Searching mailing lists for discussions explaining why close(2) was not
>> already doing this I found a patch with the easiest way out (call
>> __fput_sync() in filp_close()):
>> https://lore.kernel.org/all/20150831120525.GA31015@redhat.com/
>
> What you need to search for is probably the opposite why is
> task_work_add used in close.
>

You are splitting hairs here.

> Taking a quick look at the history it appears that fput was always
> synchronous until a decade ago when commit 4a9d4b024a31 ("switch fput to
> task_work_add") was merged.
>
> The next two commits 3ffa3c0e3f6e ("aio: now fput() is OK from interrupt
> context; get rid of manual delayed __fput()") and commit 6120d3dbb122
> ("get rid of ->scm_work_list") seem to demonstrate why fput was made
> asynchronous.  They rely on the new fput behavior to break recursive
> calls and to allow fput from any context.  That plus as Al talks about
> having any lock held over fput can potentially cause a deadlock.
>
> All 3 issues taken together says that a synchronous fput is a
> loaded foot gun that must be used very carefully.   That said
> close(2) does seem to be a reliably safe place to be synchronous.
>

Benefits of fput not taking surprise sleepable locks (and only
sometimes) and whatnot were pretty obvious and I'm not proposing
changing random consumers back to __fput_sync equivalent.

What is not obvious is if filp_close consumers, which already suffer a
lot of work, forces them to be in a spot where __fput_sync is safe to
do. The question was de facto brought up by Oleg's patch and did not
get a response, I don't see any explanations in other places either.
Cursory reading by me suggested it is indeed dodgy thus the proposal
which does not alter filp_close semantics.

As you stated yourself, the close syscall itself should be the safe
spot here and I was surprised to find this was not sorted out already
-- it genuinely looks like an oversight.

> The big question is can your loop calling open then close going 7%
> faster into any real world improvements?  How much can it generalize?
>

In this context you mean how many other spots can use it? I expect
none (apart from maybe close_range). But as I mention later, close is
not an obscure syscall, it is used all the time.

As for real world, I don't think anyone will get a marked win as is.

So happens there is perf loss all over the kernel, here is perf top
from the bench with task_work out of the way:
   7.07%  [kernel]           [k] entry_SYSCALL_64
   3.59%  [kernel]           [k] do_dentry_open
   2.95%  [kernel]           [k] strncpy_from_user
   2.93%  [kernel]           [k] kmem_cache_free
   2.88%  [kernel]           [k] init_file
   2.86%  [kernel]           [k] __call_rcu_common.constprop.0
   2.72%  [kernel]           [k] kmem_cache_alloc
   2.70%  [kernel]           [k] memcg_slab_post_alloc_hook
   2.46%  libc.so.6          [.] __GI___libc_open
   2.37%  [kernel]           [k] mod_objcg_state
   2.28%  [kernel]           [k] link_path_walk.part.0.constprop.0
   2.20%  [kernel]           [k] apparmor_current_getsecid_subj
   2.19%  [kernel]           [k] apparmor_file_open
[snip]

For example memory allocation/free is taking quite a bit of CPU time
and I strongly suspect with enough hackery it can be significantly
less expensive (it mostly bottlenecks on cmpxchg16b).

That is to say, if one was to sort all other things out, there is
several more percent to recover.

I would agree with the concern if the patch was complex, but it is not.

> Taking a look at close_fd, it is used in autofs, cachefiles, bpf, amoung
> others.  I think there is a very good argument that we can not say that
> filep_close is always a safe place to call __fput_close.  There is just
> too much going on in some of those place.  A particular possibly
> dangerous example is cachefiles_ondemand_daemon_read which calls
> complete after close_fd.  If as Oleg suggested filp_close started always
> calling __fput_sync that call to complete looks like a deadlock waiting
> to happen.
>

I did not look at cachefiles specifically, brief look at others was
indeed worrisome.
But then again, they are not a factor with the proposed patch.

> [snip]
> Which is a long way of saying that this only looks safe for close(2).
>

Yep. Except is a highly popular syscall, so it's not like I'm
proposing a change to facilitate something which happens once a year.

>
> Are there any real world gains if close(2) is the only place this
> optimization can be applied?  Is the added maintenance burden worth the
> speed up?
>

I don't think the patch at hand adds any particular burden and can be
easily modified to appease most concerns.

> I would not export any of your new _sync variants to modules.  They are
> all loaded foot-guns.
>

Specifics, including glaring warning signs and some commentary to the
extent "don't use it" can be trivially added if dodging task_work by
close is considered fine by people maintaining the code.

Ultimately the real question I asked in my e-mail was if close(2) not
being exempt from task_work was *intentional* (it does not look as
such). Writing a patch which only changes semantics for this syscall
(and not for anyone else) is trivial and there are numerous ways to do
it, I only shipped one I almost had to write for benchmarking anyway.

Frankly I expected changing the behavior for close(2) to be a
no-brainer, I did expect pushback on the way the patch is implemented.

That is to say, my willingness to argue about this is not particularly
high, so if people insist on not patching close I'm going to drop this
thread sooner than later.

-- 
Mateusz Guzik <mjguzik gmail.com>
