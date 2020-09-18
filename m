Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A1626EA05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 02:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIRAlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 20:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRAlJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:41:09 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23437C06174A;
        Thu, 17 Sep 2020 17:41:09 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id m7so4876042oie.0;
        Thu, 17 Sep 2020 17:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=TEJL8Xzj/fzq/oU2gOYJsVJrSY0GKEjb4w5Sx8Dz19o=;
        b=D38ZLFY1dA7rEozu9BqbWKiU5DGEq4OQl+80AF+XTTOMlepr8joeMreMDUwOJnBh1N
         H7d5eYsZ4aUxeES7Ym6ADlEKOxtGvncqdj5Fb5n5yZJfcG1Ve5vAIgAInXNy+Ayoxezk
         ixj73tv/hnIIfdRqdEYDJnlN1nSBD/8hJ49MMRPSATAipu5hUgQ+JYLTYLNB+9nYEnmU
         sKuFy7ZO7g+nAQ9f9vKkp/Eg4zbvkf8o+X999xCpP8l3E/6YUJTKeH2H4DBeismsXks6
         ++bSEL3DVt/AR9hYoeOfbbnJ4J3A05jyJDZC70rd2Vj0yeRpL6woV+4tSKZgfHB5WsnZ
         AptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=TEJL8Xzj/fzq/oU2gOYJsVJrSY0GKEjb4w5Sx8Dz19o=;
        b=EVlNJ55+MR629AsTVdZWz/T9ZqqoB87/4VBdIl6iw7tP9DPzGYuECuh/r2U7zRVi80
         6nLWb6xrAUBgBVQvDwXXeCVN/WgV4P/2kZKea+9bcAlcVP5q1W0rF5nMNrH6Ydpre/zF
         3fag7qyxxc4VE2/66MTBCY71w52NA0pMNlCS7UxVQqNJh61/sQHRbW8Q9sWcrtoyfkH6
         1PE6jE2hJcWsD6Fn86uXjbjttcPUgcAZxeEtVIVlswV0csEX+VUOrAXvGQJWITtxkbW+
         EyE+9QiZliGWEmozJ/BKZohEiblojNzZUhEF4qDfpiivFPhtdoT8glpU8TbKgIzBUO2v
         2w9w==
X-Gm-Message-State: AOAM5318lp0FXoQtZPXitIh17u8QJRAQV590zAtXU/f8fetT5IpcWKT3
        omampZaC90OyDELLLO3uL5DVsbIx2UWpXREFInI=
X-Google-Smtp-Source: ABdhPJx3WAshJZWth566SLCnsvt2ZL4eYw0+z6Wac1D1N00uKponkj4RtbcM+HQ5aNYgH1yyeI1dBxPGODMv7ZLb28k=
X-Received: by 2002:aca:d409:: with SMTP id l9mr7391783oig.70.1600389668564;
 Thu, 17 Sep 2020 17:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org> <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org> <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
 <20200917192707.GW5449@casper.infradead.org> <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
 <CA+icZUWVRordvPzJ=pYnQb1HiPFGxL6Acunkjfwx5YtgUw+wuA@mail.gmail.com>
In-Reply-To: <CA+icZUWVRordvPzJ=pYnQb1HiPFGxL6Acunkjfwx5YtgUw+wuA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 18 Sep 2020 02:40:57 +0200
Message-ID: <CA+icZUUUkuV-sSEtb6F5Gk=yJ0efKUzEfE-_ko_b8BE3C7PTvQ@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 2:39 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Sep 17, 2020 at 10:00 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Sep 17, 2020 at 12:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > Ah, I see what you mean.  Hold the i_mmap_rwsem for write across,
> > > basically, the entirety of truncate_inode_pages_range().
> >
> > I really suspect that will be entirely unacceptable for latency
> > reasons, but who knows. In practice, nobody actually truncates a file
> > _while_ it's mapped, that's just crazy talk.
> >
> > But almost every time I go "nobody actually does this", I tend to be
> > surprised by just how crazy some loads are, and it turns out that
> > _somebody_ does it, and has a really good reason for doing odd things,
> > and has been doing it for years because it worked really well and
> > solved some odd problem.
> >
> > So the "hold it for the entirety of truncate_inode_pages_range()"
> > thing seems to be a really simple approach, and nice and clean, but it
> > makes me go "*somebody* is going to do bad things and complain about
> > page fault latencies".
> >
>
> Hi,
>
> I followed this thread a bit and see there is now a...
>
> commit 5ef64cc8987a9211d3f3667331ba3411a94ddc79
> "mm: allow a controlled amount of unfairness in the page lock"
>
> By first reading I saw...
>
> + *  (a) no special bits set:
> ...
> + *  (b) WQ_FLAG_EXCLUSIVE:
> ...
> + *  (b) WQ_FLAG_EXCLUSIVE | WQ_FLAG_CUSTOM:
>
> The last one should be (c).
>
> There was a second typo I cannot remember when you sent your patch
> without a commit message.
>
> Will look again.
>
> Thanks and Greetings,
> - Sedat -

Ah I see...

+ * we have multiple different kinds of waits, not just he usual "exclusive"

... *t*he usual ...

- Sedat -
