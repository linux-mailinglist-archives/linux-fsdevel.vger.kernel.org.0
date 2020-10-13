Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1628D33F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 19:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgJMRnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJMRnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:43:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DC0C0613D0;
        Tue, 13 Oct 2020 10:43:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ce10so988401ejc.5;
        Tue, 13 Oct 2020 10:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=riyjHiSVJ5SsRLINQZKfDFHKzd3ulLsf2FB6PKmdJEE=;
        b=cgi6feJEh2fLmCFE1xGTPmL/jy7F7eSPJDcSk0SnoTj1njReE2kjErOLbO5XjBFRB5
         IcU2j00xoEiAim5aw75yyfPrmoA+k3t74ZWlE+rTz8pWmlsVTP5ZyN8fhyAefTqH4rdA
         ErXbre0KgubkZZj7kwTDUl3hVqlVn9YspxdTjqfrRxc/X0+u1uqMx7n//TV4DcwsfRBe
         NgpewxPhmXZOBvgZX1AXdHCIQB8A/EanTtjTii3bYqt759goRCXV2eBdpFmVYqW/mudF
         Mx3Ve3FyZFJWYGMgtpE3XZu1rywu/qtZ3ETwG7BqwnnyA8Jj+Snmv1nzihftcWzn3Y+P
         Q3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=riyjHiSVJ5SsRLINQZKfDFHKzd3ulLsf2FB6PKmdJEE=;
        b=gNBs9DlKh0pFDjzUz25tF3VzJTxhX/90f8P1/pQ5U08+53EM8Bt0PpwkwziG0yKHhh
         u5Wda9wG1Bpj+P+HD3qvPgRF7ZAdm97W9xUo7f8ep6P7gdq04YnslAVyYmqjsXGgQt8W
         pM5VPEZUtn6RA+lXHSlwZaxH5Vzm/tRqb9hywK6hWRKrWl9cjzIs9GvHCapZ5VO6xAA9
         Vj0WFWuZOr4PjhBknuxdJJG+v8vMZMv7D6H+WBMNpE31RvyMSI4W2ZGheUIYk3+DqjD1
         kX3WK/xa/96T/e1e/bt1L1WmSvXf76RLJuQYxqVRcZzXakq3Dy+JEMp5fv+R9sjybSEL
         TraQ==
X-Gm-Message-State: AOAM530MkE+HrKU+VscYlwTwXV2fie5NhGFyWzsc1Roh7lW+EP8yKea/
        nx29aWpmJDWANt8vPghg82l9E25+lvZxGU8o8Dbq2+RhREw=
X-Google-Smtp-Source: ABdhPJxTKlNpPOHx+6AEVrAQauN/4vqgvk1XNCJ6wQ0aZIXLvOcrvzzzC94ENcljKFTJV38SSWEUqAy37gg0Rs9kVWQ=
X-Received: by 2002:a17:906:2e0e:: with SMTP id n14mr909012eji.120.1602611015789;
 Tue, 13 Oct 2020 10:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWkE5CVtGGo88zo9b28JB1rN7=Gpc4hXywUaqjdCcSyOw@mail.gmail.com>
 <CA+icZUVd6nf-LmoHB18vsZZjprDGW6nVFNKW3b9_cwxWvbTejw@mail.gmail.com>
 <CA+icZUU+UwKY8jQg9MfbojimepWahFSRU6DUt=468AfAf7uCSA@mail.gmail.com>
 <20201009154509.GK235506@mit.edu> <CAD+ocbxpop9fFdgqzyObuT5oA=2OpmPj7SeS+ioH6QBvN_Ao6g@mail.gmail.com>
 <CA+icZUUp9gXGcDrX1rD2PNJfTTOe6JjfMTYiunjT9WTqCRVKRg@mail.gmail.com>
In-Reply-To: <CA+icZUUp9gXGcDrX1rD2PNJfTTOe6JjfMTYiunjT9WTqCRVKRg@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 13 Oct 2020 10:43:24 -0700
Message-ID: <CAD+ocbzz_7KwzMo6UpSLef6i7aFWg9O+25DqtOGj=nvRNqbcsQ@mail.gmail.com>
Subject: Re: ext4: dev: Broken with CONFIG_JBD2=and CONFIG_EXT4_FS=m
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Sedat, I'll take care of this in V10.

On Fri, Oct 9, 2020 at 8:14 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Oct 9, 2020 at 6:04 PM harshad shirwadkar
> <harshadshirwadkar@gmail.com> wrote:
> >
> > Thanks Sedat for pointing that out and also sending out the fixes.
> > Ted, should I send out another version of fast commits out with
> > Sedat's fixes?
> >
>
> Hi Harshad,
>
> when you work on v10, can you look at these warnings, please?
>
> fs/jbd2/recovery.c:241:15: warning: unused variable 'seq' [-Wunused-variable]
> fs/ext4/fast_commit.c:1091:6: warning: variable 'start_time' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
> fs/ext4/fast_commit.c:1091:6: warning: variable 'start_time' is used
> uninitialized whenever '||' condition is true
> [-Wsometimes-uninitialized]
>
> Thanks,
> - Sedat -
>
> P.S.: Now, I see that ext4.git#dev has dropped the hs/fast-commit v9 merge.
>
> >
> >
> > On Fri, Oct 9, 2020 at 8:45 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > >
> > > On Fri, Oct 09, 2020 at 04:31:51PM +0200, Sedat Dilek wrote:
> > > > > This fixes it...
> > >
> > > Sedat,
> > >
> > > Thanks for the report and the proposed fixes!
> > >
> > >                                         - Ted
