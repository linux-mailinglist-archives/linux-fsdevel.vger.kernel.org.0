Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0411CDA95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 05:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfJGDMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 23:12:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41986 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfJGDMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 23:12:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so11942767lje.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2019 20:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYWjgTw5GkrwHymLyJCkMr92dUNrlshJ2F++JeqwTfM=;
        b=PlOETn+6XP6GogbseS1eada7ZC/+jLxJP+MQfcH+4KhnaLD+6vgIQ/uMIIW2W9xdBJ
         y/41fuZuX5dRGnHr9WX5qOggV8VhkLc+0+KHywTkQJ7HT2a/n9EX7ua4fqHF1WX/ykdb
         6sMZfuQaEiLs56OZZqdLOBJrlXUr42OLbFr5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYWjgTw5GkrwHymLyJCkMr92dUNrlshJ2F++JeqwTfM=;
        b=OI6l/YgVy5gYLyMS+wFE8SHaGOvm6N5UM3oa9UTqRC9IbRlE6F9+lErVHsshCJEXlN
         rguOWcaHk/ZJvMgD/Z0CN+fXCJTqtGYKPoaBe1xyi4OPDZOSkQ8dfZUwAobmFpvDemTu
         wqpDlxmRIfm5x+/NRnYcTd04M2bEZK4FZDTabTP/5jKT+RwQaQKCYvlQ/ZIW77hYYjMg
         8tgBln35ML8bIl8L6uam3yRSCqQcmYI5Aine8Fv6NLfZtQfBVRJUxnZ2DLvzj8rsN9ja
         hWcarg2xKsDVZIj5njJpF2t+emILWGcqLzhse5Ombc1vB0BPItrbsVf859jOd4ce1/8V
         CHyQ==
X-Gm-Message-State: APjAAAXtxWSnwXGhM+hwHnlXKxqTkCaPRg3Tyb9YNo2BP0Bav/MxMy7N
        uq+rkIV1dVLtcPf0YNMKWVrUZep2qOs=
X-Google-Smtp-Source: APXvYqxrRMrCh/hgW27e1W13JJC/7iKGHMA1UaRb3RjfsFshsBWrlcS1gJeg0ojt6HT0TFO6upYtHA==
X-Received: by 2002:a2e:7502:: with SMTP id q2mr16934313ljc.202.1570417970403;
        Sun, 06 Oct 2019 20:12:50 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id p3sm2891346ljn.78.2019.10.06.20.12.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 20:12:49 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id n14so11930035ljj.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2019 20:12:49 -0700 (PDT)
X-Received: by 2002:a2e:2e17:: with SMTP id u23mr17071874lju.26.1570417969062;
 Sun, 06 Oct 2019 20:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <c3e9ec03-5eb5-75bb-98da-63eaa9246cff@roeck-us.net>
In-Reply-To: <c3e9ec03-5eb5-75bb-98da-63eaa9246cff@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 20:12:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKUHYSj2iZTaVKHuRve-=V6GJem78Uh6FkGb4pwYZd3Q@mail.gmail.com>
Message-ID: <CAHk-=whKUHYSj2iZTaVKHuRve-=V6GJem78Uh6FkGb4pwYZd3Q@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 6, 2019 at 7:30 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> > Mind humoring me and trying that on your alpha machine (or emulator,
> > or whatever)?
>
> Here you are. This is with v5.4-rc2 and your previous patch applied
> on top.
>
> / # ./mmtest
> Unable to handle kernel paging request at virtual address 0000000000000004

Oookay.

Well, that's what I expected, but it's good to just have it confirmed.

Well, not "good" in this case. Bad bad bad.

The fs/readdir.c changes clearly exposed a pre-existing bug on alpha.
Not making excuses for it, but at least it explains why code that
_looks_ correct ends up causing that kind of issue.

I guess the other 'strict alignment' architectures should be checking
that test program too. I'll post my test program to the arch
maintainers list.

             Linus
