Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCB6B711A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 03:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbfISBbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 21:31:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40054 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbfISBbv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:31:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id d17so1056417lfa.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 18:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJ4ydVPnUk1MpO9iHZC8eadZdfXIfU9vawn2F3Ib1fo=;
        b=A0YUpl9WGKzUNGpQlDZCnUNq6eUYinpLyOjjYEWw9qMpylivgUSR6LUyPDngKcRQfO
         CG9fCIJMna6iMWF1LQ7ztmKybh1kW4q5WyqsVkqC2UC0ZmH4W8gyqqZ+vDToxilfbXhs
         SCFR9Wb1ioaYc1GAqKixI4+MGwt/qdu3yOajg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJ4ydVPnUk1MpO9iHZC8eadZdfXIfU9vawn2F3Ib1fo=;
        b=NpywjWDGCFbAPmyGPUtMZC0yrC3FeCwDwJg2+saJMioFJyf58+Ay1wtdOJz4klc6ou
         CHYgXFSxETmwyastDpMB0VcUYzVYPm3yAaHBOS28aWSYLluGBTNzcPg8WcyGTEmgDNw2
         NmzRAXOReVHGQouS8svzLFle5u9fDlF2k60rAOJ9FRBa8LBbYCAJhXcG+dJ2BuUwZGM7
         kMN7K+JnbIsACQfbEKPyM3mEZvn3XCH8/ftAztds5/B5btBwViGijrN8pJIvDpLn/C4C
         8+vw0eHgNtZZlxxO6yH5xjdHi9nV3AkYW+mky0noX7YZGQrJ1fz1eMKbqadqav8qn+qv
         B5xg==
X-Gm-Message-State: APjAAAXQ2lcBtid+sKBrecKkAelBIpZ3W4Tjih8iLTwdzlgwTb6PBo9x
        aGs2ciIlT7Msh6XKfoQ6VW6yByC1WbU=
X-Google-Smtp-Source: APXvYqwcMbgrKvLuThZw332jLCaF5d7SFfU4mPnA/mlAl3D3serIwUW7+GdKjXBVParjSCFgJvuGRg==
X-Received: by 2002:ac2:558e:: with SMTP id v14mr3464097lfg.161.1568856707923;
        Wed, 18 Sep 2019 18:31:47 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m14sm1308135ljj.37.2019.09.18.18.31.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 18:31:46 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id w67so1071274lff.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 18:31:46 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr3489622lfh.29.1568856706072;
 Wed, 18 Sep 2019 18:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190917152140.GU2229799@magnolia>
In-Reply-To: <20190917152140.GU2229799@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 18:31:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
Message-ID: <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.4
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 8:21 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Please pull this series containing all the new iomap code for 5.4.

So looking at the non-iomap parts of it, I react to the new "list_pop() code.

In particular, this:

        struct list_head *pos = READ_ONCE(list->next);

is crazy to begin with..

It seems to have come from "list_empty()", but the difference is that
it actually makes sense to check for emptiness of a list outside
whatever lock that protects the list. It can be one of those very
useful optimizations where you don't even bother taking the lock if
you can optimistically check that the list is empty.

But the same is _not_ true of an operation like "list_pop()". By
definition, the list you pop something off has to be stable, so the
READ_ONCE() makes no sense here.

Anyway, if that was the only issue, I wouldn't care. But looking
closer, the whole thing is just completely wrong.

All the users seem to do some version of this:

        struct list_head tmp;

        list_replace_init(&ioend->io_list, &tmp);
        iomap_finish_ioend(ioend, error);
        while ((ioend = list_pop_entry(&tmp, struct iomap_ioend, io_list)))
                iomap_finish_ioend(ioend, error);

which is completely wrong and pointless.

Why would anybody use that odd "list_pop()" thing in a loop, when what
it really seems to just want is that bog-standard
"list_for_each_entry_safe()"

        struct list_head tmp;
        struct iomap_ioend *next;

        list_replace_init(&ioend->io_list, &tmp);
        iomap_finish_ioend(ioend, error);
        list_for_each_entry_safe(struct iomap_ioend, next, &tmp, io_list)
                iomap_finish_ioend(ioend, error);

which is not only the common pattern, it's more efficient and doesn't
pointlessly re-write the list for each entry, it just walks it (and
the "_safe()" part is because it looks up the next entry early, so
that the entry that it's walking can be deleted).

So I pulled it. But then after looking at it, I unpulled it again
because I don't want to see this kind of insanity in one of THE MOST
CORE header files we have in the whole kernel.

If xfs and iomap want to think they are "popping" a list, they can do
so. In the privacy of your own home, you can do stupid and pointless
things.

But no, we don't pollute core kernel code with those stupid and
pointless things.

              Linus
