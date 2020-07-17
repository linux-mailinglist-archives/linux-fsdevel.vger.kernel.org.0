Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56D0223BC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 14:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGQM52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 08:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgGQM50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:57:26 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB9FC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 05:57:26 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u25so5976278lfm.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zpg6cGdyGhLyboymADE90r/zduQzSIQvj+TJ2GrDePc=;
        b=tb/YF1ZlEjAMFGBS+M3Q8QrLKLQPtI4K0mzIZY//Ug05fMoXdF4fFtUN75hVdeLDA9
         Owe7VSA6bu351EIy9eMpiuO3y3ZPFBlGOwHPzEnCJb4RSL2t1W5bIo1ucKqTCB+BiS7v
         qj5iOCn8lVhUWsc5iC0DxwItWcvvxUjrIFx+Xu+ijXW1qv/q0F6mu6I8xfYCi16ToI7w
         L87qH4lUxWCckscbxDHgI7xkgBNKn/l4LX36MBZX6jg2mL0yOvYlegHDvXadRSiab1MH
         LbkRyi7DRxjoc3s3jdkKfJmHDl+costlxdq+pirP4UWSpVug3Z+WRDbH3q1sH4JMksRt
         g+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zpg6cGdyGhLyboymADE90r/zduQzSIQvj+TJ2GrDePc=;
        b=G3hC+LmuGYES9EvhQUH9XjIK8jDoru+YAaY4TMUjO99f0v7mD8imSBjXtrT1Yct3tr
         Fk2YDuUZSE3rrYIYwSyLlr6rN74CayJk7nMPZVfdYu0Vqb/dwGTa2u3aO4ucK9c43zDo
         UNi9lezRTH6CIYMfcUHjQkxoYhhQE2IibqfVo64P+XuqDMFO8XIfZq3OpdAHilI27KMb
         QqxJ83sb5RTn0GePR+kfoqgwXSYfV2AGWrCiXJQKQ28geCOGE8WawG3wBIjkEA+/dwnB
         XzQ1IFr7aNwpkefDc7VnWpQB0uYMY6B7ONMmNgKxE4FnTKBkh7muWlj5/ott+bqOF6K1
         gPkw==
X-Gm-Message-State: AOAM532lIP/BtyQ1Q9E88Kw3fIP3xmGDCCGhXWutgZ5WNC6ZEoTO3FzW
        ox+aeqF5e9vkDwHWqs7dJ6UutBJvRAbZLWAHu/0ZAA==
X-Google-Smtp-Source: ABdhPJzTtzajD/MUy4V7w8QAlgm1I7cn0fGggWZmfAJFhv6Zou0dOku0U3HmmGEmYmxQbW0fDM+gjWabABVqWtBK7pk=
X-Received: by 2002:ac2:5619:: with SMTP id v25mr4665990lfd.117.1594990644627;
 Fri, 17 Jul 2020 05:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200423002632.224776-1-dancol@google.com> <20200423002632.224776-3-dancol@google.com>
 <20200508125054-mutt-send-email-mst@kernel.org> <20200508125314-mutt-send-email-mst@kernel.org>
 <20200520045938.GC26186@redhat.com> <202005200921.2BD5A0ADD@keescook>
 <20200520194804.GJ26186@redhat.com> <20200520195134.GK26186@redhat.com>
 <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com> <20200520211634.GL26186@redhat.com>
In-Reply-To: <20200520211634.GL26186@redhat.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Fri, 17 Jul 2020 14:57:13 +0200
Message-ID: <CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Sandeep Patil <sspatil@google.com>, kernel@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 20, 2020 at 11:17 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> On Wed, May 20, 2020 at 01:17:20PM -0700, Lokesh Gidra wrote:
> > Adding the Android kernel team in the discussion.
>
> Unless I'm mistaken that you can already enforce bit 1 of the second
> parameter of the userfaultfd syscall to be set with seccomp-bpf, this
> would be more a question to the Android userland team.
>
> The question would be: does it ever happen that a seccomp filter isn't
> already applied to unprivileged software running without
> SYS_CAP_PTRACE capability?

Yes.

Android uses selinux as our primary sandboxing mechanism. We do use
seccomp on a few processes, but we have found that it has a
surprisingly high performance cost [1] on arm64 devices so turning it
on system wide is not a good option.

[1] https://lore.kernel.org/linux-security-module/202006011116.3F7109A@keescook/T/#m82ace19539ac595682affabdf652c0ffa5d27dad
>
>
> If answer is "no" the behavior of the new sysctl in patch 2/2 (in
> subject) should be enforceable with minor changes to the BPF
> assembly. Otherwise it'd require more changes.
>
> Thanks!
> Andrea
>
