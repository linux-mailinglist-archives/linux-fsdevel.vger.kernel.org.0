Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E668724DCD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgHURIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 13:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgHUQRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:17:44 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090C0C061573;
        Fri, 21 Aug 2020 09:17:44 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i19so1183100lfj.8;
        Fri, 21 Aug 2020 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciQpCZNqlUAY76HFlpjGJHUNDAs9xwtRbJI1yNtcuhM=;
        b=V3/MFuyaaic5NHAkMdBvSSzRXUx1HZnX7/7tVB5SKdqFl4sCYkXTJLsJGDC8JzAEBz
         QQHAWx1G5tLg68B/f+jO/GTnmuGXHhqqsBY99hXSUagyg+/ese3ijTQFcPm59tc/Om0j
         93zEOpjIPKN+nJsVkX97YNxBsJZ8beku0FZSKz1vyd0ww1TeaPiS8O9rAmi4VkXJ0jVM
         YJVQVXWk6cpCcjykvdwRko4eFY+lYyAh9hfbpflaqRK7YwSgbZddXWy4G4blNIg5Dmc4
         RU7t62cdxvy05TJm67EQ7n0CS3ldhL2OQ1YZfsFLOzNquURORpOUln5VqamVCzY6TsIZ
         zDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciQpCZNqlUAY76HFlpjGJHUNDAs9xwtRbJI1yNtcuhM=;
        b=tTOBuY/c8XDoyb9OQOZjTkvb+LM+j2P3XHryuaV8pLuY8mwy3uf1dfWt7yL40xs/MY
         NOFVabsq4HRMUWHy+eFu/QYZnsHGbL3HNeBW00h4Lc2LARFk/E+6P0uvDwSUphPK9SKl
         ROJAYgGE+aq2H0MHB7rZE4ERfpftWbUm9zBRP5mayKqXvmUgth3AAJc4hOZF/37lauun
         /v9nH3KK9T+HcbMIjkLEoIa6ROJD4FIo4tNDSNsk9lEQDgBto/EVMqjZuWyGjiwI1Mwg
         EJnh0L9mdgU5XN5X9SHEZdRKMHk7gn1yP851v8h6iKYSTnKes8JlNu5cXEomw00S7HkW
         UrXg==
X-Gm-Message-State: AOAM5320FRkl99HPk8tjWY4w//0hstpZPuZJgW5dZYb8oJErJxwaDUi+
        zjiVAdBor+RY5ojxpJdP3r3vCfu/yDlUpg6jqL8=
X-Google-Smtp-Source: ABdhPJwm4JQ0bHBpLTQfTKEIlpZDWvTsAm23urM4zWdMRprV3Ar817MgJFfm1txpjI+CAqlIEnxa8dYFBlvOP4wMeaM=
X-Received: by 2002:ac2:59c5:: with SMTP id x5mr1766672lfn.174.1598026662334;
 Fri, 21 Aug 2020 09:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-9-ebiederm@xmission.com>
 <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com>
 <875z9g7oln.fsf@x220.int.ebiederm.org> <CAHk-=wjk_CnGHt4LBi2WsOeYOxE5j79R8xHzZytCy8t-_9orQw@mail.gmail.com>
 <20200818110556.q5i5quflrcljv4wa@wittgenstein> <87pn7m22kn.fsf@x220.int.ebiederm.org>
 <CAADnVQKpDaaogmbZPD0bv3SrTXo9i5eSBMz1dd=3wOn9pxDOWA@mail.gmail.com> <871rk0t45v.fsf@x220.int.ebiederm.org>
In-Reply-To: <871rk0t45v.fsf@x220.int.ebiederm.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Aug 2020 09:17:30 -0700
Message-ID: <CAADnVQL2ugp+t39kXnd_iQMM8RGM=O2nD7OBL7XvB1GBHcyoxA@mail.gmail.com>
Subject: Re: [PATCH 09/17] file: Implement fnext_task
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        criu@openvz.org, bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:26 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Wed, Aug 19, 2020 at 6:25 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> The bug in the existing code is that bpf_iter does get_file instead
> >> of get_file_rcu.  Does anyone have any sense of how to add debugging
> >> to get_file to notice when it is being called in the wrong context?
> >
> > That bug is already fixed in bpf tree.
> > See commit cf28f3bbfca0 ("bpf: Use get_file_rcu() instead of
> > get_file() for task_file iterator")
>
> I wished you had based that change on -rc1 instead of some random
> looking place in David's Millers net tree.

random?
It's a well documented process. Please see:
Documentation/bpf/bpf_devel_QA.rst

> I am glad to see that our existing debug checks can catch that
> kind of problem when the code is exercised enough.

They did not. Please see the commit log of the fix.
It was a NULL pointer dereference.

> I am going to pull this change into my tree on top of -rc1 so we won't
> have unnecessary conflicts.  Hopefully this will show up in -rc2 so the
> final version of this patchset can use an easily describable base.

Please do not cherry pick fixes from other trees. You need to wait
until the bpf tree gets merged into net tree and net into Linus's tree.
It's only a couple days away. Hopefully it's there by -rc2,
but I cannot speak for Dave's schedule.
We'll send bpf tree pull-req to Dave today.
