Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0612FB2D99
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2019 03:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfIOBmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Sep 2019 21:42:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39854 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfIOBmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Sep 2019 21:42:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id j16so30514638ljg.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2019 18:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGa+AWlAyDqoBCMbLegT75YFVGOcflpwqeENTJ+dosM=;
        b=TPhNmomCtklLH7dWD2YFBRhvpO07mGfy2r1h8kgNMMU7hbUy4GAQZkx28yzzlONVlG
         lQRXnoNgHKz24InPhF5OP9waeXo2aBWrwj7uUN3BrfkAvEJnAi7wSwTEqMtqRaPfvVsb
         vKg7Wf8VqO8sYVAsTq8VaZ09oB9b5tnC7c148=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGa+AWlAyDqoBCMbLegT75YFVGOcflpwqeENTJ+dosM=;
        b=hsRPDzGxdBc8XNgzXLF8VL8xBChNsyIznAZRZoC1r/Jsnp+Spb+XpurEzybon16piS
         A2RTt1gBR/EwZjzc4fdjfeEFWnlJX+O0rbS2i4G6syTJrAPVWLDpnHWadbczhjm8h/2z
         yG8XcMx33q8RBAAbbYxcF4zATs6ERlLdR2YswT+kwW+DRPk6EH3+7OwkeQJmKUBi82e5
         lYfEhHF8X8cRjlBerEpoWWBVQREGn7sgtYa1AAtZxosBD6ISIzcXjWHdOeheC7oByyUj
         Gg7n55yQPpVrZgcNVZqAcn4KGz07Xh/m7twU1lRQ0QaP9B+S5OiV+MwjR1ZbHdlsdDdd
         1G7g==
X-Gm-Message-State: APjAAAVgHna73MiG5pO5jsze4YzUhLR4ANEaBn7qYxqiW7W0vNjv491H
        YDCK2QO3iV5tQzf0Exdkw7siqQrvD5k=
X-Google-Smtp-Source: APXvYqxmCDyQCO7HjsCvWzDiW59oQ92hf0IASfOlc8D+t1mn/3TXvX1fPdtctAmZaLj6zrEyF1Hvog==
X-Received: by 2002:a2e:9c16:: with SMTP id s22mr25923145lji.70.1568511719127;
        Sat, 14 Sep 2019 18:41:59 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r16sm7892649lfi.77.2019.09.14.18.41.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 18:41:58 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id c22so2675211ljj.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2019 18:41:57 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr34688450ljg.72.1568511717567;
 Sat, 14 Sep 2019 18:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190909145910.GG1131@ZenIV.linux.org.uk> <14888449-3300-756c-2029-8e494b59348b@huawei.com>
 <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com> <20190910215357.GH1131@ZenIV.linux.org.uk>
 <20190914161622.GS1131@ZenIV.linux.org.uk> <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190914170146.GT1131@ZenIV.linux.org.uk> <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk> <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk>
In-Reply-To: <20190915005046.GV1131@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 18:41:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
Message-ID: <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and d_alloc_parallel
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 14, 2019 at 5:51 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> d_subdirs/d_child become an hlist_head/hlist_node list; no cursors
> in there at any time.

Hmm. I like this.

I wonder if we could do that change independently first, and actually
shrink the dentry (or, more likely, just make the inline name longer).

I don't think that dcache_readdir() is actually stopping us from doing
that right now. Yes, we do that

    list_add_tail(&cursor->d_child, &parent->d_subdirs);

for the end case, but as mentioned, we could replace that with an EOF
flag, couldn't we?

Btw, if you do this change, we should take the opportunity to rename
those confusingly named things. "d_subdirs" are our children - which
aren't necessarily directories, and "d_child" are the nodes in there.

Your change would make that clearer wrt typing (good), but we could
make the naming clearer too (better).

So maybe rename "d_subdirs -> d_children" and "d_child -> d_sibling"
or something at the same time?

Wouldn't that clarify usage, particularly together with the
hlist_head/hlist_node typing?

Most of the users would have to change due to the type change anyway,
so changing the names shouldn't make the diff any worse, and might
make the diff easier to generate (simply because you can *grep* for
the places that need changing).

I wonder why we have that naming to begin with, but it's so old that I
can't remember the reason for that confusing naming. If there ever was
any, outside of "bad thinking".

> d_cursors is a new hlist_head, anchoring the set of cursor that
> point to this sucker.  The list is protected by ->d_lock of
> that dentry.
>
> d_cursors being non-empty contributes 1 to d_count.

My first reaction is that this sound clever, but in a good way (ie not
"too subtle" clever, but simply a clever way to avoid bloating the
dentry).

But I'd like to see the patch (and hear that it works) before I'd say
that it's the right thing to do. Maybe there's some reason why the
above would be problematic.

            Linus
