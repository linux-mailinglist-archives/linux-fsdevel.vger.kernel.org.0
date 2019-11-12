Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5B33F9708
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 18:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfKLRX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 12:23:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40505 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfKLRXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:23:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id j26so6419220lfh.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 09:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XShByMLu//cYaYZBKvqGtxFWH4UjDRbybOVR95jGz/I=;
        b=MNvkK6gaA2ornBJfgB8lmMgtKjS5hIKoXiHCGGLj7vU0zf0dCWiBna4ovnMMdHCGhH
         HsHFPAgdTnHSJhls7WKv0HtJ6tf4Mdstu5O/Ru9eMp90WQkrRwW9bX+/zXWgLjTgzkr9
         iQksID0zMw01OIpz2Z4X0yD1w6oNJb3f8ASss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XShByMLu//cYaYZBKvqGtxFWH4UjDRbybOVR95jGz/I=;
        b=Q8U0cHiqLxL8qvMfkjtFeEENBtnA2Irp0q5iNWIDYF/Y1fXsau7j/R80F4bUIEp+Ci
         M/bEV0R5GaeM27y3/7vsGblojAq/JofV1XNhPRgyneY/J4STCRk/TVDGOWT5o/wNY93b
         Usa18XMQ5QsVp0p5O4y3j6OeHfKDmoMaAnfgcVfToy6zEHaYgmCnJwAUNzL/a4EYY0Mz
         6RgNUkEk9HpiE+W/PX/7qJsBMvyDFajA46FKJFHPmqrsyflIWPgQzF5iYesDq61SElzd
         sjMidGjcZB235wWqaGHYwlV6gDBUeifX/VJhAZg58OXLaSMwq9bXJjx0w/2zORntFdJN
         Hsbw==
X-Gm-Message-State: APjAAAXWoyvNQq63xzZnILGTjJAGp43AQ55GdqXLY5eXrvyQ4Cm9b9rF
        4dsI8KoqLice7EE1AXeXEFvQSHPr03w=
X-Google-Smtp-Source: APXvYqyWOtUww9LFUycTmED8sTHAR/gtLVIChxqrRFMlq5mS5iAT3XPckYrhp3zwFCKAufT6cBfShA==
X-Received: by 2002:a19:81ca:: with SMTP id c193mr7004446lfd.43.1573579432671;
        Tue, 12 Nov 2019 09:23:52 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id w6sm5713142ljo.50.2019.11.12.09.23.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:23:51 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id b20so13508492lfp.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 09:23:51 -0800 (PST)
X-Received: by 2002:a19:4949:: with SMTP id l9mr6614232lfj.52.1573579430925;
 Tue, 12 Nov 2019 09:23:50 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
 <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
 <CAHk-=whFejio0dC3T3a-5wuy9aum45unqacxkFpt5yo+-J502w@mail.gmail.com> <20191112165033.GA7905@deco.navytux.spb.ru>
In-Reply-To: <20191112165033.GA7905@deco.navytux.spb.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 09:23:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=witx+fY-no_UTNhsxXvZnOaFLM80Q8so6Mvm6hUTjZdGg@mail.gmail.com>
Message-ID: <CAHk-=witx+fY-no_UTNhsxXvZnOaFLM80Q8so6Mvm6hUTjZdGg@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 8:50 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> The same logic applies if it is not 2 processes, but 2 threads:
> thread T2 adjusts file position racily to thread T1 while T1 is doing
> read syscall with the end result that T1 read could access file range
> that it should not be allowed to access.

Well, I think we actually always copy the file position before we pass
it down. So everybody always _uses_ their own private pointer, and the
race is only in the "read original value" vs "write new value back".

You had a patch that passed the address of file->f_pos down in your
original series iirc, but I NAK'ed that one. Exactly because it made
me nervous.

> By the way on "1" topic I suspect there is a race of how
> `N(file-users) > 1` check is done: file_count(file) is
> atomic_long_read(&file->f_count), but let's think on how that atomic
> read is positioned wrt another process creation: I did not studied in
> detail, so I might be wrong here, but offhand it looks like there is no
> synchronization.

Well, that's one reason to add the test for threads - it also gets rid
of that race. Because without threads, there's nothing else that could
access - or fork - a "N(file-users) == 1" file but us.

> So talking about the kernel I would also review the possibility of
> file_count wrt clone race once again.

See above. That goes away with the test for FDPUT_FPUT.

> About "2": I generally agree with the direction, but I think the kernel
> is not yet ready for this switch. Let me quote myself:

Hmm. I thought we already then applied all the patches that marked
things that didn't use f_pos as FMODE_STREAM. Including pipes and
sockets etc.

But if we didn't - and no, I didn't double-check now either - then
obviously that part of the patch can't be applied now.

             Linus
