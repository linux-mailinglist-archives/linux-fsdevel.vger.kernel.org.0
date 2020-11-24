Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55142C320E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 21:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgKXUkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 15:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgKXUkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:40:16 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD9FC0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 12:40:16 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gj5so30435248ejb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 12:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEOjqbrPL7ThHmqZn4HHPdQNZCU9KRjN0OANoYqF+LI=;
        b=YiUauuLl4oDGTRL45zuGDHR2J5VSlaFB7O6pBpiLin0jYi4oMDEyJ6WnB0ezsU1+lJ
         /Xr+VMmFy6Yl0v0tfocLf0a2OpJoR4jkrZf+QWqP87nKzXSlOFC8xx9JTBLeqme23GEA
         yBj2rHCTti3flo3PfXBjCwjdx6z70F417NynU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEOjqbrPL7ThHmqZn4HHPdQNZCU9KRjN0OANoYqF+LI=;
        b=uExFntIw8VmD7z1Kt0fGCRPaoXIo8jZlPkeiYurU85eSgsIIsPqYVpbe20hJvuaY4T
         3LBpfmp1mSrPvLcGaWkZ4YX5lR1kWZkI0YoLB6xlD1tjOUR65GcL6/iUUq42pFh4u4L+
         J4MjBLoSd3wSWplJWXVyXdVLvpDo0uJFAwGSDUUnE0amE7Bs4hmg4fAp7iOq3NxSipf8
         UHHMucttWR0gzghomc/Xib6hfQ5whvGd1PVo4fRKiGtHSxqVvZ/TiIqrCaE2DJtuYdLN
         azKU/qNv+an8VtMV5qqm8ZZX8Q9d3j2Qo9HoI+j1B6NTSId8voTCmorPh48I8ZpzMNfc
         18Ug==
X-Gm-Message-State: AOAM5301pLe9reYJZCPVqKTcZUeMtTLlY7WmWXdSGrGj7+2JkaRJPD4K
        gGWvx8nh8y9XFIe26Uj37C1ThAoRa0u9+g==
X-Google-Smtp-Source: ABdhPJyeaeX5ydoCQAgkGrFhISg5BGv+65TSnWJ+RI8IoC726lRZShnWI4FMGbMI6TXngJz+GybIdg==
X-Received: by 2002:a17:906:f84f:: with SMTP id ks15mr172221ejb.337.1606250414317;
        Tue, 24 Nov 2020 12:40:14 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id w2sm48452ejc.109.2020.11.24.12.40.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 12:40:14 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id k9so15615181ejc.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 12:40:13 -0800 (PST)
X-Received: by 2002:a2e:8701:: with SMTP id m1mr27321lji.314.1606250089295;
 Tue, 24 Nov 2020 12:34:49 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils> <20201124121912.GZ4327@casper.infradead.org>
 <alpine.LSU.2.11.2011240810470.1029@eggly.anvils> <20201124183351.GD4327@casper.infradead.org>
 <CAHk-=wjtGAUP5fydxR8iWbzB65p2XvM0BrHE=PkPLQcJ=kq_8A@mail.gmail.com> <20201124201552.GE4327@casper.infradead.org>
In-Reply-To: <20201124201552.GE4327@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Nov 2020 12:34:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9n5y7pu=SVVGwd5-FbjMGS6uoFU4RpzVLbuOfwBifUA@mail.gmail.com>
Message-ID: <CAHk-=wj9n5y7pu=SVVGwd5-FbjMGS6uoFU4RpzVLbuOfwBifUA@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:16 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> So my s/if/while/ suggestion is wrong and we need to do something to
> prevent spurious wakeups.  Unless we bury the spurious wakeup logic
> inside wait_on_page_writeback() ...

We can certainly make the "if()" in that loop be a "while()'.

That's basically what the old code did - simply by virtue of the
wakeup not happening if the writeback bit was set in
wake_page_function():

        if (test_bit(key->bit_nr, &key->page->flags))
                return -1;

of course, the race was still there - because the writeback bit might
be clear at that point, but another CPU would reallocate and dirty it,
and then autoremove_wake_function() would happen anyway.

But back in the bad old days, the wait_on_page_bit_common() code would
then double-check in a loop, so it would catch that case, re-insert
itself on the wait queue, and try again. Except for the DROP case,
which isn't used by writeback.

Anyway, making that "if()" be a "while()" in wait_on_page_writeback()
would basically re-introduce that old behavior. I don't really care,
because it was the lock bit that really mattered, the writeback bit is
not really all that interesting (except from a "let's fix this bug"
angle)

I'm not 100% sure I like the fragility of this writeback thing.

Anyway, I'm certainly happy with either model, whether it be an added
while() in wait_on_page_writeback(), or it be the page reference count
in end_page_writeback().

Strong opinions?

            Linus
