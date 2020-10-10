Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD652289E16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Oct 2020 05:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgJJDyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 23:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730920AbgJJDkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 23:40:07 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2755C0613D5;
        Fri,  9 Oct 2020 20:14:46 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b2so11096470ilr.1;
        Fri, 09 Oct 2020 20:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=T7Myh5hgefype84ZyMTWFL+NtDFSpEcH4wo+XsH3jtQ=;
        b=MNCmMBh0nWrAYMKKoAx4eS7NfaPNChxqxhLdAm9sulOeMpf6bkovUeJr0FxJS17RIn
         4ooyRIZKarHD2Kix/3dyzHO20bgrVpCGjCu9Bmpc2E+sPg1BEv4NeepJACatvCDk3Lhu
         2vCy5puDd518jf/Crd0i/fFayus4L7Eq1CeUfnv8BNuue2d/ClQyXGJ0LDUSqS+dInBy
         LLnGyDr8WMjj9mSyrg5Qm7SeB8tEXTv/d+J48g70pHWCaEdvJ363LWCg4UVXUoWpLAoX
         dmM8MU+4kQlzTtMKdQzhFIIPo04LqkTQHevzTAqCW7os/c+JWJTeVBWNSJrdCLWaNuYa
         MUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=T7Myh5hgefype84ZyMTWFL+NtDFSpEcH4wo+XsH3jtQ=;
        b=J7jZcGKEd9QfiDDST4ZO4qNm4QyG5bJ8+AeIwndKHlHGEWi5nzNflEfsjhz2iLw25S
         00uHEiW+ZiORPepFALJd22+Vb6PzDzNPggcBLZAiJp4FBKgQI81zruajfPWp/lCBK2xI
         cVZMyjQDyRvcm5c4HmETvfeC2gstWvJIY6JCYqNgfTlnQt0zgJRbGK0L/mDpJdJ9LBYP
         oagtubVxKrGP9DEZbiSBbtfU8aNOE7Tk4tf7oHVydsjReH0ck4a73B8Hd0NNX8b62MCB
         6uu04iAvUrZXAOH+Uo71urI1ABZysH9v1y4SiignbAYMKFSJ+5gWzIBVJLmdLK+VM+Zs
         s28g==
X-Gm-Message-State: AOAM531xPtLT86xBI4XNGr4pNM3M0vMLinxj4NF+egUpCLURMa/Z5tHB
        EIC37Q2b+i8VeYFCubbccf4IXJ+lXxWJUvFz/8A=
X-Google-Smtp-Source: ABdhPJyxyYLeir1BqAKEnwMZxKnbPy7MAILD6FH40v7zuua0vIS2AnLIq1apl8bx+B/BezlNy0Mq3YMJeaRWYyUMesA=
X-Received: by 2002:a92:c986:: with SMTP id y6mr12182206iln.10.1602299686242;
 Fri, 09 Oct 2020 20:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWkE5CVtGGo88zo9b28JB1rN7=Gpc4hXywUaqjdCcSyOw@mail.gmail.com>
 <CA+icZUVd6nf-LmoHB18vsZZjprDGW6nVFNKW3b9_cwxWvbTejw@mail.gmail.com>
 <CA+icZUU+UwKY8jQg9MfbojimepWahFSRU6DUt=468AfAf7uCSA@mail.gmail.com>
 <20201009154509.GK235506@mit.edu> <CAD+ocbxpop9fFdgqzyObuT5oA=2OpmPj7SeS+ioH6QBvN_Ao6g@mail.gmail.com>
In-Reply-To: <CAD+ocbxpop9fFdgqzyObuT5oA=2OpmPj7SeS+ioH6QBvN_Ao6g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 10 Oct 2020 05:14:31 +0200
Message-ID: <CA+icZUUp9gXGcDrX1rD2PNJfTTOe6JjfMTYiunjT9WTqCRVKRg@mail.gmail.com>
Subject: Re: ext4: dev: Broken with CONFIG_JBD2=and CONFIG_EXT4_FS=m
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 9, 2020 at 6:04 PM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Thanks Sedat for pointing that out and also sending out the fixes.
> Ted, should I send out another version of fast commits out with
> Sedat's fixes?
>

Hi Harshad,

when you work on v10, can you look at these warnings, please?

fs/jbd2/recovery.c:241:15: warning: unused variable 'seq' [-Wunused-variable]
fs/ext4/fast_commit.c:1091:6: warning: variable 'start_time' is used
uninitialized whenever 'if' condition is true
[-Wsometimes-uninitialized]
fs/ext4/fast_commit.c:1091:6: warning: variable 'start_time' is used
uninitialized whenever '||' condition is true
[-Wsometimes-uninitialized]

Thanks,
- Sedat -

P.S.: Now, I see that ext4.git#dev has dropped the hs/fast-commit v9 merge.

>
>
> On Fri, Oct 9, 2020 at 8:45 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Fri, Oct 09, 2020 at 04:31:51PM +0200, Sedat Dilek wrote:
> > > > This fixes it...
> >
> > Sedat,
> >
> > Thanks for the report and the proposed fixes!
> >
> >                                         - Ted
