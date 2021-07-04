Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326FF3BAE70
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 20:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhGDS5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 14:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhGDS5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 14:57:13 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00679C061574;
        Sun,  4 Jul 2021 11:54:36 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b2so18290584oiy.6;
        Sun, 04 Jul 2021 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=03p+jZqu7HGiEAkxvDqYglOd0+4pOj2y7Dd/2+EDBgg=;
        b=cJduoUbD/v3r2k1W0RQa6a/09dprNG4T5vqhkENjUuq9x+67YZDh+TlBrvg1bKDXja
         MwEr38G562RfyzXJVMmOiwz0PNgaO2JZ0zb17Zf8JMba8iRyMFb0NeVw9FX6zcGqlW1I
         omk1bBGi20bucdZWsZjFZJ55lXGA+cFDpM87qsDPh718kpD8zj503+pFg9+mKyywJKt/
         XnYg+cyzv3A2EEzWuYSq+xTEGB+GqQa3Q6mWrZVCp8wBcTjCAM6YwhV3Lz9es9dKWIZ6
         yyWQtHWwHrSwBNsX/s8qtnOI7gNDBN5AOgpL2OBmF1ytwxVlqnrwbWNfenvuT7Myq80+
         CUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=03p+jZqu7HGiEAkxvDqYglOd0+4pOj2y7Dd/2+EDBgg=;
        b=CkGlj8OUzT37ywZqG2IfOdaO8RavbIrP4BB/FdH8iBQ1bh7fSxJMvdxdFmkCbfkIDV
         I930/Xe5EPjltqPhnzNKhzAMnk+/66eQSy5XU72dIuw1gdwIvD4/RhgUrxWe6KCHewq+
         hozv4GuaW2a4VjnNd7TlP1xQokIvClurXtz5kQ3wLX6WNBxmZhOIbb4k6CVNEZyRWULc
         /vZQ52lFoNjkSBFLGuiaHqtZkN6FRAxvQ3v2+t7YOge6HT8LADouU/m6nXgibCFqq3mP
         NkY3uMR3sTqDAanZNGdaLH5JL5lv0X+JAmtFZvM8oN1nkBqPduaZk1yG8UyUJdfTCY6d
         Ad4g==
X-Gm-Message-State: AOAM530mDhC3vQPZLV6bBMRNlKovMiZ9laXLeS5j6SNSkw5IFFBmrdQn
        eGzTPC6L9UbvdZpNJanAzbs=
X-Google-Smtp-Source: ABdhPJxsf1TKzTFZ0TORFt7AA1OqmalqGaMnx/k5gakaLPDn1cCcIvqPRlWhbPOJBx9MtjBBXiJfDQ==
X-Received: by 2002:aca:4c03:: with SMTP id z3mr7504835oia.105.1625424876328;
        Sun, 04 Jul 2021 11:54:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l8sm705157oie.0.2021.07.04.11.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 11:54:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20210704172948.GA1730187@roeck-us.net>
 <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
Message-ID: <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net>
Date:   Sun, 4 Jul 2021 11:54:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/4/21 11:31 AM, Linus Torvalds wrote:
> [ Added Christoph, since the issue technically goes further back than
> when the warning appeared - it just used to be silent ]
> 
> On Sun, Jul 4, 2021 at 10:29 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> This patch results in the following runtime warning on nommu systems.
> 
> Ok, good, it actually found something.
> 
>> [    8.574191] [<21059cab>] (vfs_read) from [<2105d92b>] (read_code+0x15/0x2e)
>> [    8.574329] [<2105d92b>] (read_code) from [<21085a8d>] (load_flat_file+0x341/0x4f0)
>> [    8.574481] [<21085a8d>] (load_flat_file) from [<21085e03>] (load_flat_binary+0x47/0x2dc)
>> [    8.574639] [<21085e03>] (load_flat_binary) from [<2105d581>] (bprm_execve+0x1fd/0x32c)
> 
> Hmm. That actually loads things into user space, so the problem isn't
> that it shouldn't use vfs_read() or that iov_iter_init() would be
> doing somethign wrong - the problem appears purely to be that we're in
> an "uaccess_kernel()" region.
> 
> And yes, we're still in the early init code:
> 
>> [    8.574797] [<2105d581>] (bprm_execve) from [<2105dbb3>] (kernel_execve+0xa3/0xac)
>> [    8.574947] [<2105dbb3>] (kernel_execve) from [<211e7095>] (kernel_init+0x31/0xb0)
>> [    8.575099] [<211e7095>] (kernel_init) from [<2100814d>] (ret_from_fork+0x11/0x24)
> 
> which presumably runs with KERNEL_DS.
> 
> Which is kind of bogus in the new world order.
> 
> None of this *matters* for a nommu system, of course, which is why
> that code used to work, and why it's now warning.
> 
> But for the same reason, it should still continue to work, despite the
> warning. Because iov_iter_init() will actually be doing the right
> thing and making it all about user pointers.
> 
> Can you verify that it otherwise looks ok apart from the new warning?
> 

Yes, it does, at least as far as I can see.

> I *think* we should move to initializing the kernel state to
> "set_fs(USER_DS)", and that would be the right model these days.
> 
> Of course, that could cause other things to pop up on architectures
> that haven't been converted away from CONFIG_SET_FS.
> 
> The safer thing might be to move it earlier in kernel_execve(): it
> does end up doing that "set_fs(USER_DS)" eventually, but it's done
> fairly late in "begin_new_exec()" (and it's done as a
> force_uaccess_begin(), not set_fs(), but in a CONFIG_SET_FS
> configuration that ends up being what it does.
> 
>> The same warning is also observed with m68k and mcf5208evb,
>> though the traceback isn't as nice.
> 
> Hmm. Either the m68k trace printing is just bad, or maybe it just
> doesn't have CONFIG_KALLSYMS (or KALLSYMS_ALL) enabled.
> 

You are correct. After enabling CONFIG_KALLSYMS:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at lib/iov_iter.c:468 iov_iter_init+0x82/0xe4
CPU: 0 PID: 1 Comm: init Not tainted 5.13.0-09608-g678b12cd4025 #1
Stack from 40835d8c:
         40835d8c 4030cee2 4030cee2 402b1a76 403122a4 00000000 000001d4 00000009
         40835e52 40835eb0 402b1b1e 403122a4 000001d4 401368e6 00000009 00000000
         00000000 00000000 00000000 00000001 00000000 00000000 00000007 40835e88
         401368e6 403122a4 000001d4 00000009 00000000 40835e52 408e2360 4009d050
         40835e52 00000000 40835e4a 00000001 000994b8 00000000 410994c0 0003d87c
         00005919 00027418 41000000 40c7ec00 400a4b18 000d6d34 000994b8 00004100
Call Trace: [<402b1a76>] __warn+0xac/0x112
  [<402b1b1e>] warn_slowpath_fmt+0x42/0x72
  [<401368e6>] iov_iter_init+0x82/0xe4
  [<401368e6>] iov_iter_init+0x82/0xe4
  [<4009d050>] vfs_read+0x1c8/0x31c
  [<400a4b18>] read_code+0x0/0x32
  [<4002dea4>] __flush_itimer_signals+0x0/0xcc
  [<40087082>] vm_mmap_pgoff+0x5c/0x84
  [<400a4b32>] read_code+0x1a/0x32
  [<400f513c>] load_flat_binary+0x596/0x92a
  [<4009cdf0>] kernel_read+0x0/0x98
  [<402b1060>] memset+0x0/0x70
  [<4009f64a>] fput+0x0/0x18
  [<400a4220>] bprm_execve+0x188/0x3be
  [<400a47da>] copy_strings_kernel+0x0/0x86
  [<400a4e4c>] kernel_execve+0xfc/0x18c
  [<40098278>] kfree+0x0/0x1dc
  [<402b6a34>] schedule+0x0/0xd0
  [<402b26b8>] printk+0x0/0x18
  [<402b11d8>] run_init_process+0x80/0x8c
  [<402b26b8>] printk+0x0/0x18
  [<402b5362>] kernel_init+0x0/0xe8
  [<402b53b2>] kernel_init+0x50/0xe8
  [<400208c4>] ret_from_kernel_thread+0xc/0x14

---[ end trace 4a67f75a6eb7dc98 ]---

> Anyway, does a hacky patch something like this
> 
>     diff --git a/fs/exec.c b/fs/exec.c
>     index 38f63451b928..26293bd7c502 100644
>     --- a/fs/exec.c
>     +++ b/fs/exec.c
>     @@ -1934,6 +1934,10 @@ int kernel_execve(const char *kernel_filename,
>          int fd = AT_FDCWD;
>          int retval;
> 
>     +    // Make sure CONFIG_SET_FS architectures actually
>     +    // do things into user space.
>     +    force_uaccess_begin();
>     +
>          filename = getname_kernel(kernel_filename);
>          if (IS_ERR(filename))
>                  return PTR_ERR(filename);
> 
> make the warning go away? I really would like to set USER_DS even
> earlier, but this might be the least disruptive place.
> 

No, I still see the same warning, with the same traceback. I did make sure
that the code is executed by adding a printk in front of it.

Guenter

> Anything that accesses kernel space should *not* depend on KERNEL_DS
> at this point, since that would make all the properly converted
> architectures already fail.
> 
> And any architectures that haven't been converted away from
> CONFIG_SET_FS would have been hitting that force_uaccess_begin() later
> in  begin_new_exec(), so they can't depend on any KERNEL_DS games
> after kernel_execve() either.
> 
> So that one-liner is hacky, but *feels* safe to me. Am I perhaps
> missing something?
> 
> It probably means we could remove the force_uaccess_begin() in
> begin_new_exec() entirely, but let's first see if the one-liner at
> least makes the warning go away.
> 
>             Linus
> 

