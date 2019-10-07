Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2CECEB8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 20:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfJGSNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 14:13:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42265 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfJGSNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:13:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so14700694lje.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMlh6GXN6QbpwC889qdv/mL2tKRwyhPfZJiqASBvKqo=;
        b=h8vVKPc80ltfyFjjkk1eX3SsLDZsWpHSGP70shQML8lM+pQi5PD43ZLbNhTvHnnieH
         3Pdsvi7u5yvEvu0mkBG36/MC6h2vZ5j/Ramv3pLra1nTcYqBd177SsSNYgfSw50OivjV
         toQ4l5QhAqNdBrZzz/KNR6RQik0WFppq5OXBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMlh6GXN6QbpwC889qdv/mL2tKRwyhPfZJiqASBvKqo=;
        b=uP9nETuZLYKoD4/K8XPbV7FRvY4XIWyASTla7mrZMU8yZxQXSAZCgzBLLQg3xKvTzn
         qfcK271sT5T1v3peO4p4/CJ4mJZgCzREd7P7Xxeailkb4br+qnE9q/6MAu7Moc+IzdXZ
         tzPVMdL6ZbZxLTorZUb4a+L4+lQn5QeiXQaY4rbOua+G84tX4m5/4pXr0wHjp8FtOvte
         nledLeqcaiVUU3U05DZnNJAh728tN22D9OxUxSHS3MkrFfpxsRWQZJLxu0sVgC0WuQd2
         u1Pz/F8vpwHUEVeEoWwySD8J9qeIb+MHpCINMfH6s+ZiDErZFUkZZhiAGxcC7EDxzkG8
         ZP4g==
X-Gm-Message-State: APjAAAUXwhgBG1dIFaQR62OkEJdmz9Ypn8FgcmmkTWyknytxPsoOz/4P
        lCxzJz9OESCnoc2Ri6y06TYsLGWeoW0=
X-Google-Smtp-Source: APXvYqx4fQ5r9MtyjwY2bgOP0j34BAUImDzuqkZRoIs/WFutEXzI5rYtGup7b+w6Pr6SNgTubnCZew==
X-Received: by 2002:a2e:9d44:: with SMTP id y4mr19788209ljj.115.1570472024381;
        Mon, 07 Oct 2019 11:13:44 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id n17sm3241811ljc.44.2019.10.07.11.13.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:13:43 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id w67so9971525lff.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 11:13:43 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr17404487lfh.29.1570472023078;
 Mon, 07 Oct 2019 11:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <20191007173432.GM26530@ZenIV.linux.org.uk>
In-Reply-To: <20191007173432.GM26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 11:13:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSzPwzX0cHgTZ9SQrd8XWQcMnLkBCo_-710pLTEBFGYQ@mail.gmail.com>
Message-ID: <CAHk-=wgSzPwzX0cHgTZ9SQrd8XWQcMnLkBCo_-710pLTEBFGYQ@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 7, 2019 at 10:34 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Tangentially related: copy_regster_to_user() and copy_regset_from_user().

Not a worry. It's not performance-critical code, and if it ever is, it
needs to be rewritten anyway.


> The former variant tends to lead to few calls
> of __copy_{to,from}_user(); the latter...  On x86 it ends up doing
> this:

Just replace the __put_user() with a put_user() and be done with it.
That code isn't acceptable, and if somebody ever complains about
performance it's not the lack of __put_user that is the problem.

           Linus
