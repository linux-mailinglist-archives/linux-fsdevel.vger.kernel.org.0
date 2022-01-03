Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142D048373D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 19:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiACSzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 13:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiACSzv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:55:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A25AC061761
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jan 2022 10:55:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u25so18004237edf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jan 2022 10:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/tl740B5dKu3LcT9k/DwsMLta3onSSEJxNz0w7L77Q=;
        b=Kswum6/H/CUH2m0aHNjA1M5P7b2h+4XmNGY0uwlFwhgK88+sTraM9oPHfrCUvC7BBC
         z9HqFO/bsZzRqNxojrBth5Oqqu5mYpoIPKcy4zoL5GBEtm0KpwU4q8c0MbhbFUQPm6Z1
         +tMVNRgmFAbuDQCKKiMS5Qsyxrr9JVh2pPJKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/tl740B5dKu3LcT9k/DwsMLta3onSSEJxNz0w7L77Q=;
        b=IhpJc4KsjW2/0URwcppiB4REPT5x//RXI0cqCzLCKbnzS+PmhqxLzK1eJYDvTm1m7S
         KQj+3G2OboFD5mYwTxguEPP+dJY0VcHP1pXo1fkzvE9womqSyR30kxnUUlUmI3LvLAtL
         5ffU2FwQVibEcFKUjLQlLuHlFj7zERyygZtnwRe1ynuVsyY5sK4RK5nRwT64wUZxFr4u
         62mnY9MpAOv/BmWw8TiQHlM2mftAsV4xIX/XL4r3PS8CVgEE5n6qqBrYfugI9KjM8ddV
         sSxWT2Cll3rTzsIyNFLrpgunsQCi0xDJj9Kq/D9ckA/ydYHNFw2rYWm8QVQJzx3iKdjd
         vpbg==
X-Gm-Message-State: AOAM530t95fObc3iNf0vzMPGkD8WtwuupVMloq3h9tki8tzt+519THrS
        O1K/yJaIfZQyQJSVn2fzCVMefQjr1+U7lzpJ
X-Google-Smtp-Source: ABdhPJxvpbu4licyKCb8SceqrDL8/Yr6l2QlF8IzL/jy/DEx9zfmmyS6jCekDyYwOva4v+TFfKhnrg==
X-Received: by 2002:a05:6402:38d:: with SMTP id o13mr45530816edv.129.1641236148538;
        Mon, 03 Jan 2022 10:55:48 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id lv23sm10775078ejb.125.2022.01.03.10.55.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 10:55:47 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id s1so71580101wra.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jan 2022 10:55:47 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr39310306wrx.193.1641236147522;
 Mon, 03 Jan 2022 10:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20211221164004.119663-1-shr@fb.com> <CAHk-=wgHC_niLQqhmJRPTDULF7K9n8XRDfHV=SCOWvCPugUv5Q@mail.gmail.com>
 <Yc+PK4kRo5ViXu0O@zeniv-ca.linux.org.uk> <YdCyoQNPNcaM9rqD@zeniv-ca.linux.org.uk>
 <CAG48ez1O9VxSuWuLXBjke23YxUA8EhMP+6RCHo5PNQBf3B0pDQ@mail.gmail.com>
In-Reply-To: <CAG48ez1O9VxSuWuLXBjke23YxUA8EhMP+6RCHo5PNQBf3B0pDQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jan 2022 10:55:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjPEDXkiyTtLijupF80JdNbKG9Rr8QA448u1siuZLCfkw@mail.gmail.com>
Message-ID: <CAHk-=wjPEDXkiyTtLijupF80JdNbKG9Rr8QA448u1siuZLCfkw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] io_uring: add getdents64 support
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Stefan Roesch <shr@fb.com>,
        io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 2, 2022 at 11:04 PM Jann Horn <jannh@google.com> wrote:
>
> And for this validation caching to work properly, AFAIU you need to
> hold the file->f_pos_lock (or have exclusive access to the "struct
> file"), which happens in the normal getdents() path via fdget_pos().
> This guarantees that the readdir handler has exclusive access to the
> file's ->f_version, which has to stay in sync with the position.

Yes.

So the whole 'preaddir()' model was wrong, and thanks to Al for noticing.

It turns out that you cannot pass in a different 'pos' than f_pos,
because we have that very tight coupling between the 'struct file' and
readdir().

It's not just about f_pos and f_version, either - Al pointed out the
virtual filesystems, which use a special dentry cursor to traverse the
child dentries for readdir, and that one uses 'file->private_data'.

So the directory position isn't really about some simple passed-in
pos, it has locking rules, it has validation, and it has actual
secondary data in the file pointer.

                  Linus
