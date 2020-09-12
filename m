Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DDE267C49
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 22:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgILUtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 16:49:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52784 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725905AbgILUtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 16:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599943737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJuHYlMJJGIC0qBjlrqnGCpyE1IZMKKDiH+/8N+tl5c=;
        b=dr0Ce72Zjyh5SeDxwKvFw4/m19xObHSL43mDbzO+s7revoyWKKXwlq0IY0uNdFBtynqS7+
        +8klonsDyYpwtdJshU07+r1pbtmiutmK7sGN9COiJxZdxJ1wrsu8qZUgFCtDVTNVUNJSSX
        NWJmUnANjHfzUCxNxI/5uGqTukRwVWY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-wddxBGIfMdOjCsYpLafMBg-1; Sat, 12 Sep 2020 16:48:54 -0400
X-MC-Unique: wddxBGIfMdOjCsYpLafMBg-1
Received: by mail-lj1-f198.google.com with SMTP id d23so4087931ljg.21
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2020 13:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJuHYlMJJGIC0qBjlrqnGCpyE1IZMKKDiH+/8N+tl5c=;
        b=LTTD4LMfTjLf5oUFkUmGER319Ja/PamdA92NkAf0p29POas9JL+uhQxuXJePPZpNmR
         50aOErgSC9zo1gL0+KJlHdcit0+OKf8P3rlquyRRglX//WE89aG0W4Sa4TBdaGMpspxi
         hrSzQ7Rfq226myruy4dlD+lzT8VBr93ITy2OV5iFsCpFDCKkRfVwXUDBwZZ/OHJlH/5r
         vG92IgRQp+J/qqNKe0foSQNGEkD+FPyk86YduUvggHIX6fPr1g4M1v3WRmMrt31HZIvx
         i6lelGQThZ7jRL0drMAnx+KGVFKHbVqIuqxJuEuGdN6eC3snoBoe0Fhxa+wbPGWCXyeR
         ZJig==
X-Gm-Message-State: AOAM533t1iLIL4FjUJyl83KYJMKKJ1o97mrbp7sZgHa48FhJYT1Vc/mL
        +iPmsVW70rpG5UG6HefDzNVW5TtUiRcvxek3m86EVIhNbTRlMCRfRbu1E54reKDtEyX7oxy96na
        +1uKIfDHwv8vckplp1Eo4t1mFQr4z/mPM/4Kgy4hv1g==
X-Received: by 2002:a2e:8046:: with SMTP id p6mr2567814ljg.372.1599943732616;
        Sat, 12 Sep 2020 13:48:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDE6x8wpSTW0zchyo7JE5ZtuT3H92rSVgfacoMie83rLd05GidX9QR1xfHp5MvqzE7vmFLBF7QNJ6Y0VNPIQs=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr2567810ljg.372.1599943732385;
 Sat, 12 Sep 2020 13:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202107.3799376-1-keescook@chromium.org>
 <alpine.LRH.2.21.2009121002100.17638@namei.org> <202009120055.F6BF704620@keescook>
 <20200912093652.GA3041@ubuntu> <20200912144722.GE3117@suse.de>
In-Reply-To: <20200912144722.GE3117@suse.de>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 12 Sep 2020 22:48:39 +0200
Message-ID: <CAFqZXNtwDpX+O69Jj3AmxMoiW7o6SE07SqDDFnGMObu8hLDQDg@mail.gmail.com>
Subject: Re: [RESEND][RFC PATCH 0/6] Fork brute force attack mitigation (fbfam)
To:     Mel Gorman <mgorman@suse.de>
Cc:     John Wood <john.wood@gmx.com>, James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 4:51 PM Mel Gorman <mgorman@suse.de> wrote:
> On Sat, Sep 12, 2020 at 11:36:52AM +0200, John Wood wrote:
> > On Sat, Sep 12, 2020 at 12:56:18AM -0700, Kees Cook wrote:
> > > On Sat, Sep 12, 2020 at 10:03:23AM +1000, James Morris wrote:
> > > > On Thu, 10 Sep 2020, Kees Cook wrote:
> > > >
> > > > > [kees: re-sending this series on behalf of John Wood <john.wood@gmx.com>
> > > > >  also visible at https://github.com/johwood/linux fbfam]
> > > > >
> > > > > From: John Wood <john.wood@gmx.com>
> > > >
> > > > Why are you resending this? The author of the code needs to be able to
> > > > send and receive emails directly as part of development and maintenance.
> >
> > I tried to send the full patch serie by myself but my email got blocked. After
> > get support from my email provider it told to me that my account is young,
> > and due to its spam policie I am not allow, for now, to send a big amount
> > of mails in a short period. They also informed me that soon I will be able
> > to send more mails. The quantity increase with the age of the account.
> >
>
> If you're using "git send-email" then specify --confirm=always and
> either manually send a mail every few seconds or use an expect script
> like
>
> #!/bin/bash
> EXPECT_SCRIPT=
> function cleanup() {
>         if [ "$EXPECT_SCRIPT" != "" ]; then
>                 rm $EXPECT_SCRIPT
>         fi
> }
> trap cleanup EXIT
>
> EXPECT_SCRIPT=`mktemp`
> cat > $EXPECT_SCRIPT <<EOF
> spawn sh ./SEND
> expect {
>         "Send this email"   { sleep 10; exp_send y\\r; exp_continue }
> }
> EOF
>
> expect -f $EXPECT_SCRIPT
> exit $?
>
> This will work if your provider limits the rate mails are sent rather
> than the total amount.

...or you could keep it simple and just pass "--batch-size 1
--relogin-delay 10" to git send-email ;)

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

