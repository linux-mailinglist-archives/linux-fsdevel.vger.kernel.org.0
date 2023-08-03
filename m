Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCFC76EDD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 17:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbjHCPRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 11:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbjHCPRd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:17:33 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7504530EF;
        Thu,  3 Aug 2023 08:17:31 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-79ad4ffc6e6so379715241.3;
        Thu, 03 Aug 2023 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691075850; x=1691680650;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K4yxIW5Zr5zWYdk0K2WRHu8yBYrAXK88es3xebcNiAY=;
        b=Ia+rBYqego+DbKDo49qkMnP7r5ecxm3/JhB5UhBPdbL/rZwzfb3a8o98RgodCjG00u
         17e0t1uSMj+OlQq3RWpuDrms5QA8arwgwGCznnGxWZwPCxU63Wxq3I3S6wKWvvB2xwEt
         1+jZNlAapqifL/k3rWXP7H5qahFM1mu0kepUZls/7duDlXwVHG3jdY3aml9eiO5jxp1p
         8REnABLUbeGVBSea37vzaMF4SuPWzr6YdKO8RG1rSvvlhmty3HKbQOUNvyH8ZAACcuYU
         Q+Z9LCfm5yrlaEhX4Y4FakREje6jWhEici+FjmP86eL5SN2XY870i2XuOkU21SRBljvJ
         NZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691075850; x=1691680650;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4yxIW5Zr5zWYdk0K2WRHu8yBYrAXK88es3xebcNiAY=;
        b=N+8WjpxIv7TIkS9OUgRKmnvGta2HgFsiL7OuOnHPUUbxRkRxlkhP6Yy01efAhK48GX
         Wnqoo9iMVnFUjqMYB9eYwao3N/CpzOHBfWYl0C4PXUhDxIyw5M393oWiD97NwSbS8OaF
         1DoQE+NISNU7iKY7k98wC9oaOkCeTNQNdDZFpSOCKuh34JRcgLLCbWpzIsU96pdM+cBD
         OdfruVQCzyzGn1bzwRugp/CDR+XxUz9JzaQJ799uDT+JTCd1nvAbJsOZH8PwLx4DnWmK
         sKIfFLPK8fh13TaRFxC8e0bzSt/iaF+SGV2eX7j3LOmUHfGY8i9dS6y35EnSIfqzr3iU
         AUQA==
X-Gm-Message-State: ABy/qLa1KWtCIzbbGjtLAmGjGAThISL5Okkrj305F4DzyoBnQBFcYB91
        OuPvRFWT5683quogqwk0fKuYIDCETEc/Ogpj0/Y=
X-Google-Smtp-Source: APBJJlH6fK+IbnvRm0yWBu8hKE304zKKdbbG4oC3Kcor5TsiQw0V+kE04oLSEODgyK1HZk31yrfYw/q1e7DZRJ1sGgY=
X-Received: by 2002:a67:ead3:0:b0:444:c720:6181 with SMTP id
 s19-20020a67ead3000000b00444c7206181mr6641862vso.3.1691075850282; Thu, 03 Aug
 2023 08:17:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2342:0:b0:783:def9:1a3a with HTTP; Thu, 3 Aug 2023
 08:17:29 -0700 (PDT)
In-Reply-To: <20230803-segeln-hemmen-34df115b4914@brauner>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-pyjama-papier-9e4cdf5359cb@brauner> <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
 <20230803095311.ijpvhx3fyrbkasul@f> <20230803-segeln-hemmen-34df115b4914@brauner>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 3 Aug 2023 17:17:29 +0200
Message-ID: <CAGudoHEG7vtCRWjn0yR5LMUsaw3KJANfa+Hkke9gy0imXQz6tg@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/3/23, Christian Brauner <brauner@kernel.org> wrote:
> On Thu, Aug 03, 2023 at 11:53:11AM +0200, Mateusz Guzik wrote:
>> On Mon, Jul 24, 2023 at 09:59:15AM -0700, Linus Torvalds wrote:
>> > I really hate making the traditional unix single-threaded file
>> > descriptor case take that lock.
>> >
>> > Maybe it doesn't matter. Obviously it can't have contention, and your
>> > patch in that sense is pretty benign.
>> >
>> > But locking is just fundamentally expensive in the first place, and it
>> > annoys me that I never realized that pidfd_getfd() did that thing that
>> > I knew was broken for /proc.
>> >
>>
>> So I got curious what the impact is and checked on quite a modern CPU
>> (Sapphire Rapid), so nobody can claim it's some old yeller and atomics
>> are nowhere near as expensive on modern uarchs.
>>
>> I used read1_processes from will-it-scale -- it is doing 4KB reads at a
>> time over a 1MB file and dodges refing the file, but it does not dodge
>> the lock with the patch at hand.
>>
>> In short, I got a drop of about 5% (~5778843 -> ~5500871 ops/s).
>>
>> The kernel was patched with a toggle to force or elide the proposed
>> mandatory locking, like so:
>> @@ -1042,8 +1044,10 @@ unsigned long __fdget_pos(unsigned int fd)
>>         struct file *file = (struct file *)(v & ~3);
>>
>>         if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
>> -               v |= FDPUT_POS_UNLOCK;
>> -               mutex_lock(&file->f_pos_lock);
>> +               if (file_count(file) > 1 || fdget_pos_mutex) {
>> +                       v |= FDPUT_POS_UNLOCK;
>> +                       mutex_lock(&file->f_pos_lock);
>> +               }
>>         }
>>         return v;
>>  }
>>
>> I got rather unstable single-threaded perf, going up and down several %
>> between runs, I don't know yet what's that about. But toggling back and
>
> We've had the whole lkp intel performance testsuite run on this for a
> long time to see whether there any performance regressions that aren't
> in the noise. This includes all of will-it-scale. Also with a focus on
> single-thread performance. So I'm a little skeptical about the
> reliability of manual performance runs in comparison.
>

I did not merely post numbers claiming a difference, I justified it
with profile output, prominently showing the mutex lock/unlock pair. I
genuinely think this puts the ball in your court.

One potential factor is mere CPU(s) -- maybe whatever was used in your
bench is older than the CPU I used and for example is more negatively
affected by mitigations like retpoline et al. I intentionally used
something very high end, specifically: Intel(R) Xeon(R) Platinum 8470N

Another potential factor is discrepancies in kernel config.

I found one here:
https://lore.kernel.org/oe-lkp/20230802103152.ae3s43z6yjkhnkee@quack3/T/#t
, I'm guessing it is the same as the one used in Intel tests. In there
I see:
CONFIG_RANDOMIZE_KSTACK_OFFSET=y

This is implemented with rdstsc, which comes with a massive premium to
syscall cost. Also note it does not *fix* CPU bugs or whatever, it
merely is a hardening measure to shuffle the stack pointer (way
overpriced btw). Which is a long way of saying I sanity-checked
syscall perf on my box with getppid and had to disable this opt (afair
it bumped the rate from about 11 mln to 15 mln ops/s) and that it is
fine to do so.

I could easily see how more things like this combined with older CPUs
would make the mutex trip small enough to not worry about, in that
setting. I don't think this is the same as the cost of the change
being negligible in general. I can't stress enough my config retains
retpoline and other mitigations for actual bugs, so it's not like I
cheated the system.

I'm attaching my config for reference. It is what's present in Debian
+ a bunch of stuff disabled.

> If Linus thinks it matters then I think we should only take the
> f_pos_lock unconditionally on directory fds as this is where it really
> matters. For read/write we're only doing it because of posix anyway and
> using pidfd_getfd() is squarely out of posix anyway. So we can document
> that using pidfd_getfd() on a regular file descriptor outside of a
> seccomp stopped task is not recommended.
>

In stock kernel the code is:
        if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
                if (file_count(file) > 1) {
                        v |= FDPUT_POS_UNLOCK;
                        mutex_lock(&file->f_pos_lock);
                }
        }

after pidfd_getfd succeeds the count is > 1, so the thing to worry
about is racing with the thread calling fdget_pos or making sure it
stopped using the fd, but only the first time around. Perhaps there is
a way to wait it out (as in guarantee it is not using the fd *or*
already had seen the bumped refcount) which would be perfectly
acceptable for pidfd consumers? Note the thread may be stuck in an
uninterruptible, indefinite sleep somewhere while using it without the
lock. On the other hand if such a thing can happen with f_pos_lock
mutex held, the pidfd consumer running into the same codepath with the
lock would be in the same spot, so perhaps this is not so bad?

Note this is definitely hackable just for fun without pessimizing
fdget_pos much, but off hand I don't have anything reasonable for
real-world use. I'm going to sleep on it.

-- 
Mateusz Guzik <mjguzik gmail.com>
