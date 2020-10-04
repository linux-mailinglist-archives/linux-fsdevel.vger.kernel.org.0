Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF03282A38
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 12:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgJDKf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Oct 2020 06:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDKf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Oct 2020 06:35:28 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB24BC0613CE;
        Sun,  4 Oct 2020 03:35:28 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id c5so5271707ilk.11;
        Sun, 04 Oct 2020 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ADJmPtVWd8BfEUsxAtlbgqXLpgZYE8DCMvkZfCLzDuc=;
        b=bI5ma4rK71E99v+8kDSDQcLMn6IS/nlcfS3h4fRNa2H2yRscwzLPY8I6KP4HNzqbcC
         0MeSG9PBF38vYrShvu+ghex5cYD6sIBlJGvDhLYw7cjlrM7EPLLootvczRKRkP7z063W
         fDG47QYHYg7VJ+4Qb1XNr5b6nRNv1cmAZETwXY6d+3Gx5hBInjOHP3Q9H32mxGlfKzw+
         ztgBc1CA19HmHylyPgBM66UNug/pICr2esYm4m6eHM6xhS1Ao+nwlOHV4vi8ZuO2nDEN
         lhfDX92UR1BbeshGQNGoPDGwsvhBY0PZWw2t8iEAzqFXgjAX9sBZdIyWCkgB8Zvysb/Y
         Fk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ADJmPtVWd8BfEUsxAtlbgqXLpgZYE8DCMvkZfCLzDuc=;
        b=gG2ISq8Zgn0ZR6z5sMuZjq8xlxbtSbYU/JpG/2dIsf+ZvgvG8GOPspt+ulLlyQnWWf
         PhSTApTPCJtasVPi/tyUPQ0MmMz+51egATc+aEGmYu+QpSe4mMEoM9Soyp2rmyZ80RvU
         F6kh1fEfGyxHl6J81mvGU+iwxIckMlTTrUH71/SykjnB+6jfllT0Tb1oZ9zN+qd3cBIp
         YZim/QA6J5glr41O/0M5918b23lN4BLn6kzeZR78IIytXGEy4xVwpGycSnVR3rpO7Omc
         mhHrVEoCnrfNNxsrLGJ0pbg+lGEEeX1AU7r6MWz9EHKF+tu+hN51HOW1ShApPMgSXNiT
         gWcQ==
X-Gm-Message-State: AOAM5304Zylu2BGf7/vB6O0lsRDdWilULG8K+AhYNHnsfFNc4EM78o8k
        CBuAF5X67azY/RM9olvUcyJ9b00RNkn4SWmzSqWl4KGyw1eTbw==
X-Google-Smtp-Source: ABdhPJxfc6cpyhvWtXPEoELVpwimPdr7Z8cHq5bhJgxEwUAV9XQ8Co6SX6rWm7iresgjwWCFViddDJRju76drMtcqbA=
X-Received: by 2002:a92:6a0a:: with SMTP id f10mr7756966ilc.186.1601807727950;
 Sun, 04 Oct 2020 03:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200924152755.GY32101@casper.infradead.org> <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
 <20200924163635.GZ32101@casper.infradead.org> <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
 <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
 <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org> <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org> <CA+icZUULTKouG4L-dFYbGUi=aLXTZ083tZ=kzw6P+pKcSj-6hQ@mail.gmail.com>
 <20201004041330.GF20115@casper.infradead.org>
In-Reply-To: <20201004041330.GF20115@casper.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 4 Oct 2020 12:35:16 +0200
Message-ID: <CA+icZUXVkH9fmo2asm12Baxd9oTJGew9Yi=9L4AmvQK5s_pFfA@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 4, 2020 at 6:13 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Oct 03, 2020 at 08:52:55PM +0200, Sedat Dilek wrote:
> > Will you send this as a separate patch or fold into the original?
> >
> > I have tested the original patch plus this (debug) assertion diff on
> > top of Linux v5.9-rc7.
>
> I'm going to wait for the merge window to open, Darrick's tree to be
> merged, then send a backport of all the accumulated fixes to Greg for
> the 5.9-stable tree.  I'm also going to do a 5.4 backport.

OK.

In "iomap: Support arbitrarily many blocks per page" [1] the debugging
assertions are folded in, so I hope you will do this in the "backport
of all the accumulated fixes".

- Sedat -

[1] https://git.infradead.org/users/willy/pagecache.git/commitdiff/e799a897db4b1913a2f5279a9ee1b342bda05a98
