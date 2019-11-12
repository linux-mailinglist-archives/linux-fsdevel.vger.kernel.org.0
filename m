Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8258BF9749
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 18:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLRhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 12:37:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41361 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLRhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:37:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id d22so7236471lji.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 09:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IBqefimeVs+AYlMba+nG3Ifymts3na+gdpNY2rCXiUk=;
        b=diHQe+yBS1ptQml1pfafp+kWY2eFlTIw5aehrJHkBhZ8198TLnziuPuv+aWPbMESa4
         ZLgW0hXjhFPDrgdFG9RXdXxqYD1Ejn46fc1vZ1auR9hlb58u47fldPax7D6iEk6grtjo
         EpEWHP7zBGk+CKduo6ZBne9+0TPwuTpetW/Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBqefimeVs+AYlMba+nG3Ifymts3na+gdpNY2rCXiUk=;
        b=tCYBCj7moi1n9Ge4ZHN0obe2TwDj4SGDBJpLtAt6APRUFWOhUn2QwWkV6SxiZ0b0Fk
         5dDu1VdWRDyTAXe6in8nGVpzl/rffp2ALpaECIUbn/J/rOMekvjUmEpgBwl5OXHJyx/z
         b7g2qy1cCnk+a2mNzcaIihJcWj1ki2ZPHjEQlKbJoeYMga0s4BvAqnKnn6OyW6fiRGtd
         jhOY3lSJ0wDix+Zkvz+3RaqsZvxYA4o62gPljBVVkKC2kJoEeA2v2xfarK7U6k6/q+sz
         mMnqdIVomcKvm7DU3c4/pMi00wSml/+NxLgEzLGYGgp0mxcxSUFVTlGBDfRcRNRNaEX4
         jLmg==
X-Gm-Message-State: APjAAAW6ZOR87R9Svd7EqyByfGuIZGvgdSNZswDVVMDUKaBnerA5jWUf
        mgdWnGeo7veoAUI8xyzeIsLk9m5jdMY=
X-Google-Smtp-Source: APXvYqwn85KBG6AK5mOvAl8R7KBlfznTqvR6V9kism2avQXy92rsX/SdySpppXfSwpkDLnChoQ6IDg==
X-Received: by 2002:a2e:88c9:: with SMTP id a9mr19008054ljk.30.1573580219063;
        Tue, 12 Nov 2019 09:36:59 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id v6sm10294529ljd.15.2019.11.12.09.36.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:36:57 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id q5so7520092lfo.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 09:36:57 -0800 (PST)
X-Received: by 2002:ac2:4c86:: with SMTP id d6mr20463115lfl.106.1573580217235;
 Tue, 12 Nov 2019 09:36:57 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
 <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
 <CAHk-=whFejio0dC3T3a-5wuy9aum45unqacxkFpt5yo+-J502w@mail.gmail.com>
 <20191112165033.GA7905@deco.navytux.spb.ru> <CAHk-=witx+fY-no_UTNhsxXvZnOaFLM80Q8so6Mvm6hUTjZdGg@mail.gmail.com>
In-Reply-To: <CAHk-=witx+fY-no_UTNhsxXvZnOaFLM80Q8so6Mvm6hUTjZdGg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 09:36:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPFjpOEfU5N4qz_gGC8_=NLh1VkBLm09K1S1Gcma5pzA@mail.gmail.com>
Message-ID: <CAHk-=whPFjpOEfU5N4qz_gGC8_=NLh1VkBLm09K1S1Gcma5pzA@mail.gmail.com>
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

On Tue, Nov 12, 2019 at 9:23 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. I thought we already then applied all the patches that marked
> things that didn't use f_pos as FMODE_STREAM. Including pipes and
> sockets etc.
>
> But if we didn't - and no, I didn't double-check now either - then
> obviously that part of the patch can't be applied now.

Ok, looking at it now.

Yeah, commit c5bf68fe0c86 ("*: convert stream-like files from
nonseekable_open -> stream_open") did the scripted thing, but it only
did it for nonseekable_open, not for the more complicated cases.

So yup, you're right - we'd need to at least do the pipe/socket case too.

What happens if the actual conversion part (nonseekable_open ->
stream_open) is removed from the cocci script, and it's used to only
find "read/write doesn't use f_pos" cases?

Or maybe trigger on '.llseek = no_llseek'?

                 Linus
