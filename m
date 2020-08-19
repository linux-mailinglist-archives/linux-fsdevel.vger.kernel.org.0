Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C110124A398
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 17:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgHSPzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 11:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgHSPzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:55:03 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF042C061757;
        Wed, 19 Aug 2020 08:55:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i19so12317603lfj.8;
        Wed, 19 Aug 2020 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=31Qym4k8331f6H4k76WgLs9RnH9R3abh8NK+iPJ0pQ8=;
        b=ParQHmrOzrGsP3e8fhsiAiGjWynHT+odEmSfEkdgFcYE/+EQafA+ybVP3YAc1Dxz9E
         27+5cq+fFaPMGVyaOMMxJpwnxvv8nYc2vRQFpcgSgK6p62joE/f6qdx7KldywxEogdY7
         CFVBvmCIGQrkg97ni13iqPUqTQeG7RoUkfk+CPPqVTDCbGxcJAoWBxduM4pDSErKNneb
         VjhShTP2TTUj1v5u5GrI4yTEn9l3iPL53IdQG9oRB+Fzz3RY27xmJfJVU6A5ljf+dS+Y
         d0z0JbhPisKdgb7xtwyN5o7BmFZhKWWQpsdGP3UFkxzTngWz0SN9SvIZlh8iKXuBi6pP
         9JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31Qym4k8331f6H4k76WgLs9RnH9R3abh8NK+iPJ0pQ8=;
        b=UhEoy9DFXxWff05nIWEanrzEoNt6J3RzsjxJiFraScrKocl9QKEwQbQ2j3diGLsT3p
         scIQw6xd8RfUmUJWrcKnkFQqitRRREVWo0FXyZb7oS+gVhE5Ma6RFg3D9JclwVhAGEQz
         zurMdTrKfUbFVh4RAxFgNbxDNc0nYk3YxI4THu3KX7IVMYq+6blWOo7wS6s78TR7SV6m
         hmfbMTip3CeSgp3Ft1yI5Us74zuo9WpEW85zvFaVnHw1OtRhSYD+YfM176HWSQIA/AiX
         A3mKotdyCoEXrxFDFrD0B7MHw17VzOC/TRAeEY5mPGf81nWl3wXfAd9yNl1xTO6nld0+
         QS7A==
X-Gm-Message-State: AOAM5304vc+2h6hejd/FewrP0mbsRxpBp2fIdy5UJRwQ+Po/PefdPFOI
        yTBfR60/Pq64jfVCMu/GcaAeeu8xPxQdGjsmTTk=
X-Google-Smtp-Source: ABdhPJzo8ojYd7PedEirG4KP1WXU+RDi395iO/dPgxj2okrypI9Ncnu33CdFRKWevZJNZ0mb8YOPvY5MOjj7/ncEWrM=
X-Received: by 2002:a05:6512:2010:: with SMTP id a16mr12109645lfb.196.1597852502174;
 Wed, 19 Aug 2020 08:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-9-ebiederm@xmission.com>
 <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com>
 <875z9g7oln.fsf@x220.int.ebiederm.org> <CAHk-=wjk_CnGHt4LBi2WsOeYOxE5j79R8xHzZytCy8t-_9orQw@mail.gmail.com>
 <20200818110556.q5i5quflrcljv4wa@wittgenstein> <87pn7m22kn.fsf@x220.int.ebiederm.org>
In-Reply-To: <87pn7m22kn.fsf@x220.int.ebiederm.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Aug 2020 08:54:50 -0700
Message-ID: <CAADnVQKpDaaogmbZPD0bv3SrTXo9i5eSBMz1dd=3wOn9pxDOWA@mail.gmail.com>
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
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 6:25 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The bug in the existing code is that bpf_iter does get_file instead
> of get_file_rcu.  Does anyone have any sense of how to add debugging
> to get_file to notice when it is being called in the wrong context?

That bug is already fixed in bpf tree.
See commit cf28f3bbfca0 ("bpf: Use get_file_rcu() instead of
get_file() for task_file iterator")
