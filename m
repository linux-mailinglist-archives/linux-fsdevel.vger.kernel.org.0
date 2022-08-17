Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932005977AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbiHQUNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241793AbiHQUNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:13:48 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91862CDEC
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:13:46 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id c3so14243464vsc.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UdSoQI8thPMpoSW2DvIjRZp9bchOkPUbLe45PrZiNiQ=;
        b=LG7UuHjR0cHnBUDYoM045QkEl9s5qozrScU+aGLJgg84CTEQRG6r494VS3HlDxYyOt
         FvXmwMCzKtebJz7IIY0ABjMVhk0ye+/yRY1uWh8c0I2C1698ixcmjyShRzYK1M6NK83O
         QdptCFHqHdqw2zEqbNJXmbh4URzwz7/Eeg0ESlBk5pieczs35DFdKdYOSyKwKyyUSgK3
         3SE6kbxyt3TF1Cqd9zQ/Qb0pleP7LbBAuo5PfQ4CSJvDjk2/Wk2ay9a4VcdSignJNXDq
         309YlZo82Jgx6KvJUJhGvFW9NjywiFz6S7EJCuC9Y84atdQsY53pPaB/+by8Ai0/XXLq
         yD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UdSoQI8thPMpoSW2DvIjRZp9bchOkPUbLe45PrZiNiQ=;
        b=5EN9rBU8fiwmyXosgeUfborQFNFEWJXmZ+P3x+JnjprfK+LnjtPzhFPxJe7Ta3SDLD
         fGAu7DH4dVLrS9BvXrE4dLPMHkwULsCSHvYYAP69eHt+y3ICFEP6CEbUrj0VTr7L3K8L
         jg6cTOCGBEk8oSuf1mURphvL1/CUReF/PrPzpTNX0ioryh+iDMilMPDi3Rx0+m4+BJ67
         yBh5eFXIN5P4ItsDAZTDFCv9LKdXn9EhbnYoymmd7gfDKYVUbWJc5KMOUH1oYI9UrBaU
         oyZ5Kb1XvRxZ3bRnahpq4pqdlePyS24ugk6tHdmsxmGSpBWuGq5vdWGmdnwgSsi/1giQ
         ywBA==
X-Gm-Message-State: ACgBeo2vs0i1nALO0UZ7ea2gQKR3w2AtTXllfrnXNLjQfAi5BC7cmlNm
        rux7pndkBov8LFNin4Xya5nTgmBAwyCSoWXNoMk=
X-Google-Smtp-Source: AA6agR6zMQVBAYLnBd6JEjXhVRFOFHGvuv4wAHdZaC3Imh12FhfrFWK7rv77bo5tMcXcPlRO/xxwUrRMC8Tips8P58A=
X-Received: by 2002:a67:ec57:0:b0:388:d564:3ae9 with SMTP id
 z23-20020a67ec57000000b00388d5643ae9mr11096402vso.71.1660767225335; Wed, 17
 Aug 2022 13:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <YvvBs+7YUcrzwV1a@ZenIV> <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
 <Yvvr447B+mqbZAoe@casper.infradead.org> <20220816201438.66v4ilot5gvnhdwj@cs.cmu.edu>
 <CAHk-=wghBfgOkH2jjr4OrQ7d+CLdspq1xaQK3L8x6BuDPv0eiw@mail.gmail.com>
 <CAOQ4uxhoAAjKOe4w+z2_NCO9PF5KD=6oKuqQQ8xcMUe=buh89A@mail.gmail.com> <CAHk-=wiQ_VQDekBvtB0D0CzFAm4HSc3_J+euxdn5vKjuAoK9dQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiQ_VQDekBvtB0D0CzFAm4HSc3_J+euxdn5vKjuAoK9dQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Aug 2022 23:13:33 +0300
Message-ID: <CAOQ4uxgKDwRC5s6UF7E+s2d4jfHRdi+hG2ry3b8KNp_+Z5napA@mail.gmail.com>
Subject: Re: Switching to iterate_shared
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Normally readdir iteration is very similar to lookup().
>
> The *one* exception tends to be directory entry caches, although
> sometimes those too are shared with lookup.
>
[...]
>
> > Hmm, I wonder. Can gentents() proceed without f_pos_lock on
> > single f_count and then a cloned fd created and another gentents()
> > races with the first one?
>
> That would break much more important system calls than getdents (ie
> basic read/write).
>
> So if fdget_pos() were to be broken, we have much bigger issues.
>
> In case  you care, the thing that protects us against another thread
> using the same file descriptor is
>
>   fdget_pos ->
>     __fdget_pos ->
>       __fdget ->
>         __fdget_light ->
>           check current->files->count
>           do full __fdget() if it's > 1
>
> and then __fdget_pos() does that
>
>                 if (file_count(file) > 1) {
>                         v |= FDPUT_POS_UNLOCK;
>                         mutex_lock(&file->f_pos_lock);
>                 }
>
> check afterwards.
>
> IOW, this code is carefully written to avoid both the file pointer
> reference increment *and* the f_pos_lock in the common case of a
> single-threaded process that only has the file open once.
>
> But if 'current->files->count' is elevated - iow some other thread has
> access to the file array and might be open/close/dup'ing files, we
> take the file reference.
>
> And then if the file is open through multiple file descriptors (which
> might be in another file table entirely), _or_ if we just took the
> file refernce due to that threading issue - then in either of those
> cases we will also now take the file pos lock.
>
> End result: either this system call is the only one that can access
> that file, or we have taken the file pos lock.
>
> Either way, getdents() ends up being serialized wrt that particular open file.
>

Yes, I see it now.

> Now, you can actually screw this up if you really try: the file pos
> lock obviously also is conditional on FMODE_ATOMIC_POS.
>
> So if you have a filesystem that does "stream_open()" to clear
> FMODE_ATOMIC_POS, that can avoid the file pos lock entirely.
>
> So don't do that. I'm looking at fuse and FOPEN_STREAM, and that looks
> a bit iffy.
>
> (Of course, for a virtual filesystem, if you want to have a getdents()
> that doesn't allow lseek, and that doesn't use f_pos for getdents but
> just some internal other logic, clearing FMODE_ATOMIC_POS might
> actually be entirely intentional. It's not like the file pos lock is
> really _required_).
>
> > I tried to look at ovl_iterate(). The subtlety is regarding the internal
> > readdir cache.
>
> Ok, from a quick look, you do have
>
>         cache = ovl_dir_cache(d_inode(dentry));
>
> so yeah, the cache is per-inode and thus different 'struct file'
> entries for the same directory will need locking.
>

The cache in ovl_cache_get() is a refcounted object, so I think
we can fix grabbing the instance and initiating a new instance safely.
The cache in ovl_cache_get_impure() is more problematic.
I'll see what we can do about it.

> > Compared to fuse_readdir(), which is already "iterate_shared"
> > and also implements internal readdir cache, fuse adds an internal
> > mutex (quote) "against (crazy) parallel readdir on same open file".
>
> Maybe the FUSE lock is *because* fuse allows that FOPEN_STREAM?
>
> > Considering this protection is already provided by f_pos_lock
> > 99% of the time,
>
> It's not 99% of the time.
>
> f_pos_lock is reliable. You have to explicitly turn it off. FUSE is
> either confused and does pointless locking, or has done that
> stream_open() thing to explicitly turn off the vfs locking.
>
> Or, probably more realistically, the fuse code goes back to before we
> did f_pos_lock.

I'll leave that riddle for Miklos to solve.

Thanks,
Amir.
