Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDCE5F6ABC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 17:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiJFPgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJFPgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:36:15 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286FA9A9C3
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 08:36:14 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h18so1186277ilh.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kBsN+WV474YxARCF7+nqmiK1jJMhN3dpQirfp2PoxlI=;
        b=JjMbJ/6iXZaadLFSJQk/HRtX7HrZ/RZDwb2mntZuqfcRGukztaLnaRtozSNqvZ38A4
         YIoQ/S3pghhDMLpw8KTrVksZJi+qZfmtmFFtL6r+hlek1RDiFjHhO28+25YkHLvlCc/G
         2ton1aYig3VnJwiK390amDUqhjkwHT2v8cCIJriuz9pU8Vq1hyKD89eS6KbebFUKLB7f
         StxxrRJteAZtp0mitV1ByWgBDUKx7ejR8uKWfR+ZopLjyxWlWBgzgq30TO7uWMlo0TOX
         Ot9J/qTOjnGajAnOuylFkpSg9k4OtDzH80hAqWJVInjfgYhV53xWDOLUG2oWhzMmJmJ7
         oo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBsN+WV474YxARCF7+nqmiK1jJMhN3dpQirfp2PoxlI=;
        b=Sc4mJps3a+VSORjPBRmfMaS/7Sj/PnM6/NKmgkQA4TRCZmPlZBiQW3u8o6IObreuU7
         i70IklZL7nkEXfXz7qBzxq0gsBjYI6cPQpM6lPBv+KULj8HuyE6y94HnFrTwsnIItCQd
         ejT/cEmmr9jUCboK2gg3jn0U6vLuBKufMJ2Q7n2ZfIXcD8F4+VOxMj8Zafyc+QsjRUru
         LAlaP7O6EzV3dpasAcU1xUY4TxjKQUluxuCn/C4CeWUcrWvCabWsp2i3fUrX14qBw60H
         +jl1uEdwuaVlNCKTAwE8UBsmdYqwMo8dUOT3kN13Be24yoHm2STfTaz9s4Lq3ptCsviG
         tXdA==
X-Gm-Message-State: ACrzQf0p5CBAG6gXiw7T17INg+0RkkfFXzE5Kxl5+gmBxR6UUvCRlOvg
        dbiwFhCt8y3rEZXA+zAP8LLLTFGIg/xe7uIhul/laBpzNHM=
X-Google-Smtp-Source: AMsMyM4b3/P730KDfkxwcyTWlRlnjgpSRQAwOlc/NfsO6cxtR79rz7+RL4b861zTtxfuwZkTO8fgQgVJ7C0o9SGCGVA=
X-Received: by 2002:a05:6e02:1989:b0:2f6:45ca:410d with SMTP id
 g9-20020a056e02198900b002f645ca410dmr99039ilf.187.1665070573386; Thu, 06 Oct
 2022 08:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein>
 <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com> <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org>
In-Reply-To: <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Oct 2022 17:35:37 +0200
Message-ID: <CAG48ez2h29CschY7GPiyg7eZT9B4UnBeKtS6AksyD8iDqs25Bg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jorge Merlino <jorge.merlino@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 6, 2022 at 5:25 PM Kees Cook <keescook@chromium.org> wrote:
> On October 6, 2022 7:13:37 AM PDT, Jann Horn <jannh@google.com> wrote:
> >On Thu, Oct 6, 2022 at 11:05 AM Christian Brauner <brauner@kernel.org> wrote:
> >> On Thu, Oct 06, 2022 at 01:27:34AM -0700, Kees Cook wrote:
> >> > The check_unsafe_exec() counting of n_fs would not add up under a heavily
> >> > threaded process trying to perform a suid exec, causing the suid portion
> >> > to fail. This counting error appears to be unneeded, but to catch any
> >> > possible conditions, explicitly unshare fs_struct on exec, if it ends up
> >>
> >> Isn't this a potential uapi break? Afaict, before this change a call to
> >> clone{3}(CLONE_FS) followed by an exec in the child would have the
> >> parent and child share fs information. So if the child e.g., changes the
> >> working directory post exec it would also affect the parent. But after
> >> this change here this would no longer be true. So a child changing a
> >> workding directoro would not affect the parent anymore. IOW, an exec is
> >> accompanied by an unshare(CLONE_FS). Might still be worth trying ofc but
> >> it seems like a non-trivial uapi change but there might be few users
> >> that do clone{3}(CLONE_FS) followed by an exec.
> >
> >I believe the following code in Chromium explicitly relies on this
> >behavior, but I'm not sure whether this code is in active use anymore:
> >
> >https://source.chromium.org/chromium/chromium/src/+/main:sandbox/linux/suid/sandbox.c;l=101?q=CLONE_FS&sq=&ss=chromium
>
> Oh yes. I think I had tried to forget this existed. Ugh. Okay, so back to the drawing board, I guess. The counting will need to be fixed...
>
> It's possible we can move the counting after dethread -- it seems the early count was just to avoid setting flags after the point of no return, but it's not an error condition...

Random idea that I haven't thought about a lot:

One approach might be to not do it by counting, but instead have a
flag on the fs_struct that we set when someone does a clone() with
CLONE_FS but without CLONE_THREAD? Then we'd end up with the following
possible states for fs_struct:

 - single-process, normal
 - single-process, pending execve past check_unsafe_exec() (prevent
concurrent CLONE_FS)
 - shared between processes

The slight difference from the old semantics would be that once you've
used CLONE_FS without CLONE_THREAD, you can never do setuid execve()
from your current process again (without calling unshare()), even if
the child disappears in the meantime. I think that might be an
acceptably small UAPI break.
