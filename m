Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165B7C8F0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 18:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfJBQzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 12:55:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41461 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfJBQzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:55:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so15708872qkg.8;
        Wed, 02 Oct 2019 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwP070FtmeuK+3N75GeFgnRVrcbqBEsCTG6FQeHO1Dc=;
        b=sc5MKpK0FOi6wTaqxv0zmq/glDWjP01Ln7lGfhEjL/hAy0nOY7RJSJO9+Opy9fBM3V
         BsjFfT0FR1QRuq67piWtm/1Yq/6K5cVrkQZGE92EcBHsj/y53WMixNIMaE18jXEuhF3I
         aUTIzBsjBIiegFbGWfcuQJyJ9q4fjnnYJcuOcMzKv3pLpRIZyvTORxCSxO/GOQL2f02C
         2DaCbjFvNKWCj5on8F+jf+EJGQ/ql7vh3ewEXnQmVP4QBrdbNAnbknCUx7AdioHcGm+m
         5Y08bIb+XVtB6omolG5PRQqK6+5XA4ZnRG2/nOoSyKo4qGfRpIr5ZfQCjfMSZrN0n2h2
         k1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwP070FtmeuK+3N75GeFgnRVrcbqBEsCTG6FQeHO1Dc=;
        b=TqNTWnXnWgcEmx6Jlq+VCQTWuxmgbWis9+XSNgfMWz8vw8ykKJC58WScQ040Jo2M/d
         ghNb3KbX52n24QtYtPmZL/xSYwHPUsvfwkhunuf+VH+ksj2DNwtTy2/QRB+o2E9dazFs
         9uGRDqrJcmXWu44ydJ7hsw+hcZYWSzIQIDBnMIYVqmYw3L6aXGohIxtS+Mh8z8R8bZlw
         lJLsELoTB+gIA/rEJDDDTc7uQK9K7kE3AxH9Jw6RPcwCBhP66+9vi/UpQVZqzvD/XrmO
         RqORwhkRQSqIp6aSrwVPBrtnF/bCh84EC+fDt210Pix6nGI5C+b0Ods26GkaEj9ZCnc4
         GDMQ==
X-Gm-Message-State: APjAAAX8hkn/B2cRHKlD/a0ywR59Q3gE1RZB3apnRV0rlgKFeWOeTu73
        BrW0DeIQ1BbKcgvqiAaWqIDgo3bhGOvZqSRRgrQ=
X-Google-Smtp-Source: APXvYqznJfvsAqic7Yte0Cfh1sZVR0edCsCDW5/5o6K1NNRJiOV9X7R2gWkisKyDfH5T0CNTlj8XPfGp1ZnIWK0TLV4=
X-Received: by 2002:a05:620a:113a:: with SMTP id p26mr4871408qkk.353.1570035319775;
 Wed, 02 Oct 2019 09:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568994791.git.esyr@redhat.com> <CAPhsuW5CvJNRP5OO_M6XVd9q0x-CH9eADWR5oqdJP20eFScCFw@mail.gmail.com>
 <87d4b42f-7aa2-5372-27e4-a28e4c724f37@kernel.dk>
In-Reply-To: <87d4b42f-7aa2-5372-27e4-a28e4c724f37@kernel.dk>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 2 Oct 2019 09:55:08 -0700
Message-ID: <CAPhsuW68rK3zGF3A8HnwArh7bs+-AAvZBtVkt4gcxPnFCGxwAQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix typo in RWH_WRITE_LIFE_NOT_SET constant name
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 1, 2019 at 5:55 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/1/19 5:12 PM, Song Liu wrote:
> > On Fri, Sep 20, 2019 at 8:58 AM Eugene Syromiatnikov <esyr@redhat.com> wrote:
> >>
> >> Hello.
> >>
> >> This is a small fix of a typo (or, more specifically, some remnant of
> >> the old patch version spelling) in RWH_WRITE_LIFE_NOT_SET constant,
> >> which is named as RWF_WRITE_LIFE_NOT_SET currently.  Since the name
> >> with "H" is used in man page and everywhere else, it's probably worth
> >> to make the name used in the fcntl.h UAPI header in line with it.
> >> The two follow-up patches update usage sites of this constant in kernel
> >> to use the new spelling.
> >>
> >> The old name is retained as it is part of UAPI now.
> >>
> >> Changes since v2[1]:
> >>   * Updated RWF_WRITE_LIFE_NOT_SET constant usage
> >>     in drivers/md/raid5-ppl.c:ppl_init_log().
> >>
> >> Changes since v1[2]:
> >>   * Changed format of the commit ID in the commit message of the first patch.
> >>   * Removed bogus Signed-off-by that snuck into the resend of the series.
> >
> > Applied to md-next.
>
> I think the core fs change should core in through a core tree, then
> the md bits can go in at will after that.

Good point. I guess I will wait until it shows up in for-5.5/block?

Song
