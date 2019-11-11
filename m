Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30098F817A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKKUoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:44:07 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:35462 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfKKUoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:44:06 -0500
Received: by mail-lf1-f48.google.com with SMTP id y6so10943252lfj.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 12:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRpKFfWznVhj0rOmApAqWtyU5VUj2Sa8IVNQNnpT9os=;
        b=HWedAvPLYel4dWRGlAl6RaJ3Yu3or3ICRF5dcXJUzKCmWReTCRRVOKzRS6Z3LxfDIr
         l0e8MYVVHvCHAhgsOsOTZcnm+wKkf9HPI9/P3cBWrjFgw3bENmYWUazQx+bSFZG4Gm6Z
         d/PZrJ7ylSByQPRbgQv5LTVX8eUcGbMpV4Ke4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRpKFfWznVhj0rOmApAqWtyU5VUj2Sa8IVNQNnpT9os=;
        b=n/FLTVomUtsd6HWf+/CtFZyAPQfu6+2D8ef70n/y9HfSUxkCqknL4xxf+QHu7RgLR9
         PXvNSkjSe7eeafk3jtYGwm7N8Fn8nGvsUh3PDG8yLZrEyQnJ3BLLKMNvmNufaXeM/7ae
         2KKIWxpOFRNNwM0zuxaa2TKPf6wgauG/aNnSPQjroFanbsCLI3fpyQ5mv1RjNBJHnled
         l358e9CXLgrFgQR8HDonU2ANs1rOH2Ehtd8d2TEwwN39ES1LfOJxjBDQRY5JRVt5IqC6
         8zZJi7TSDYPbOmotlg6kYqoDi5EsLOF2OBUw2x0M/d01j0lCTipBjGNlu2ecAAG3Joet
         QluQ==
X-Gm-Message-State: APjAAAWX10QuVYV2nahX1NaKRbHENQLJiozghfcw+YnHC07LTFrNxYsG
        wVGz/EqXaLbn7PDsox8prrEVxBlPpy4=
X-Google-Smtp-Source: APXvYqwHVe8eVLoOtZCFwWR6tnFrsPlloOnBcXvFMXY+tmYu/l9stmN5PQ+7nW+Hgh45db/yJ/hyKQ==
X-Received: by 2002:a19:8a42:: with SMTP id m63mr3005319lfd.168.1573505043789;
        Mon, 11 Nov 2019 12:44:03 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 77sm6486595lfj.67.2019.11.11.12.44.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 12:44:02 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id k15so15293677lja.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 12:44:02 -0800 (PST)
X-Received: by 2002:a2e:8919:: with SMTP id d25mr17557153lji.97.1573505041971;
 Mon, 11 Nov 2019 12:44:01 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
 <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com> <CANn89i+x7Yxjxr4Fdaow-51-A-oBK3MqTscbQ4VXQuk4pX9aCg@mail.gmail.com>
In-Reply-To: <CANn89i+x7Yxjxr4Fdaow-51-A-oBK3MqTscbQ4VXQuk4pX9aCg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 12:43:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRQuSrstW+cwNmUdLNwkZsKsXuie_1uTqJeKjMBWmr6Q@mail.gmail.com>
Message-ID: <CAHk-=whRQuSrstW+cwNmUdLNwkZsKsXuie_1uTqJeKjMBWmr6Q@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:13 AM Eric Dumazet <edumazet@google.com> wrote:
>
> What about this other one, it looks like multiple threads can
> manipulate tsk->min_flt++; at the same time  in faultin_page()

Yeah, maybe we could have some model for marking "this is statistics,
doesn't need to be exact".

> Should we not care, or should we mirror min_flt with a second
> atomic_long_t, or simply convert min_flt to atomic_long_t ?

Definitely not make it atomic. Those are expensive, and there's no point.

                    Linus
