Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB522B4E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 19:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgGWRat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgGWRaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:30:46 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80024C0619E3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2020 10:30:46 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a12so7068253ion.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2020 10:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBT1YHYehsULa5041VfTOXF4E/wfuVFEWswNl4qqheM=;
        b=YjrAHQwakysKhK/uMN8tazLEkVJfnT8KlS75mhdIZTrHekThF6A1QoO8LeE4KRYv79
         9U1h+f8QxbfVSEa+wo1ooIRq90DsazR/yuqNMOI8KSbxYRocKc3EpZdFtK1mCmoj+SYX
         qMyenttxkX+IGflwu8drtiTgIVH8TdElCo2WxwbHaGnVHCN0Msrq0FVAYGe4mo0CelAr
         7vFgE/ydE9PaZ9Yxfax14ep0ZIwgmfJYwhrtN2+39UjoQ2ssbqrZurbbKm1Hmx0P3/o3
         wg7UQ6bicG8OaiG9dE0GW1aBhzJ7or5/NV9gOvfK2HquYLYsil1SutQ1nMBcqlTaNv1f
         +NpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBT1YHYehsULa5041VfTOXF4E/wfuVFEWswNl4qqheM=;
        b=ocCuCOHftvO7gnARjk3Oa9qtP/1YCWvL38OQfmtGzah7n/bPWPHs/jERVG5gb3PXRW
         D1fosJa7yhxUgEc1assLP5CsT31HuQD9qQnw1Na5YctXFEOOR06KAprbsarv+fBDPna0
         EtgN8wQ5VMDHzwhl91kZBD4WMn2lIWZvEaCmK94cXgizJx76QZ5xR49BIk53VKEX8Gcm
         OoYI/b3fmsnpy987FsxdRrHvgNMMndiwxNl0iY0uT0g52coT2MXigz/wKaFAoc4/tp6W
         8VuR97k4NF4H+0cbzGIxNPftgc3WZ9HO1K0ePOrhuvQZ2lF6ISkNroqRCC2/xnysGp7o
         RBcA==
X-Gm-Message-State: AOAM530iB3O81lMn2hHkPJOHChBqCWlkbE8YOMVqH0UoTweRdaCAHz/+
        Filfw7m0NAeQ0u6R1Hpe04Q67GiT4oALBkEG0FZQHQ==
X-Google-Smtp-Source: ABdhPJyIqBAKndpkDTRooZU00sQLj+EJ2gNlhOJAdMucoDkJLrVRnPm5q0vLnqiwg56deW/zDgZDAJR/qbOzd/o3brw=
X-Received: by 2002:a6b:bc41:: with SMTP id m62mr5742175iof.95.1595525445467;
 Thu, 23 Jul 2020 10:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200423002632.224776-1-dancol@google.com> <20200423002632.224776-3-dancol@google.com>
 <20200508125054-mutt-send-email-mst@kernel.org> <20200508125314-mutt-send-email-mst@kernel.org>
 <20200520045938.GC26186@redhat.com> <202005200921.2BD5A0ADD@keescook>
 <20200520194804.GJ26186@redhat.com> <20200520195134.GK26186@redhat.com>
 <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com>
 <20200520211634.GL26186@redhat.com> <CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com>
In-Reply-To: <CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu, 23 Jul 2020 10:30:34 -0700
Message-ID: <CA+EESO4kLaje0yTOyMSxHfSLC0n86zAF+M1DWB_XrwFDLOCawQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
To:     Jeffrey Vander Stoep <jeffv@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
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
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Sandeep Patil <sspatil@google.com>, kernel@android.com,
        Daniel Colascione <dancol@dancol.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daniel, the original contributor of this patchset, has moved to
another company. Adding his personal email, in case he still wants to
be involved.

From the discussion so far it seems that there is a consensus that
patch 1/2 in this series should be upstreamed in any case. Is there
anything that is pending on that patch?

On Fri, Jul 17, 2020 at 5:57 AM Jeffrey Vander Stoep <jeffv@google.com> wrote:
>
> On Wed, May 20, 2020 at 11:17 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
> >
> > On Wed, May 20, 2020 at 01:17:20PM -0700, Lokesh Gidra wrote:
> > > Adding the Android kernel team in the discussion.
> >
> > Unless I'm mistaken that you can already enforce bit 1 of the second
> > parameter of the userfaultfd syscall to be set with seccomp-bpf, this
> > would be more a question to the Android userland team.
> >
> > The question would be: does it ever happen that a seccomp filter isn't
> > already applied to unprivileged software running without
> > SYS_CAP_PTRACE capability?
>
> Yes.
>
> Android uses selinux as our primary sandboxing mechanism. We do use
> seccomp on a few processes, but we have found that it has a
> surprisingly high performance cost [1] on arm64 devices so turning it
> on system wide is not a good option.
>
> [1] https://lore.kernel.org/linux-security-module/202006011116.3F7109A@keescook/T/#m82ace19539ac595682affabdf652c0ffa5d27dad
> >
> >
> > If answer is "no" the behavior of the new sysctl in patch 2/2 (in
> > subject) should be enforceable with minor changes to the BPF
> > assembly. Otherwise it'd require more changes.
> >
Adding Nick (Jeff is already here) to respond to Andrea's concerns
about adding option '2' to sysctl knob.

> > Thanks!
> > Andrea
> >
