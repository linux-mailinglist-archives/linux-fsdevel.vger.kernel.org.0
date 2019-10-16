Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18748D980E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404756AbfJPRA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 13:00:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35185 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfJPRA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:00:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id m15so37201632qtq.2;
        Wed, 16 Oct 2019 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ITMSYb2mpF3RaZgz9ExWMw4f2fxz+CBvsGA+3mZlnY=;
        b=ijjVZXxvfuZw0TNdMfAxpyi2d8BL7/Z8qq/jxibkITdBmlt8llqyRR+Yf1H0Sua2oz
         nxNsLpDDlKv59Ueffc82qHmOGkGfp6D2WKzqWu9lwt5Ata/yAcht7OfcU5iF6GIn2dKf
         Z1xEWN4cSpvTDfpv6+WjtF7t3nU0yxRlI/CqXNDwUC7O+9/gRWkOfLwlNq7H1LbbF8sZ
         XZeuAsQ/vVWJ62X28Vjk/96f+sGyNTGltBgxwjCEKaUeeIVdUeQb+DA70wdfRokLaVJq
         4lFv+KWiy0I/nrW52cNOjNWNBM2D6UHoVuyH0ypctDTWrNbrU5efkRg/Rk9CuwtAP8qj
         sAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ITMSYb2mpF3RaZgz9ExWMw4f2fxz+CBvsGA+3mZlnY=;
        b=GR4Ys9fnkCh94U4Q7hfFRMgihO8SJ/55AEdndzZLOKaKGKdRTAt2ZpQOiXSL2wYzPp
         ClqxbMHOoIkSY5j6BRnQ9qHCoc0PvVoeddCpo2HSc6V2oCIqyjIGFIMND4OV4Ud5Im56
         dNwzenrvaMP4Efl1+Lpl4QP8QxzSNL8qqlx9Q1wzG6V+wAhuVKqca5t3fWTeWAJQgDbS
         ifaVEeY6dymkGIvXfszraIzHVcNde0j2OuQYt7JrOnxUEhXAGakHAm41KVA4rOtU1Ft5
         1N0cdffEQNUz5QdgT8P22/ojGX/+4YUwEe8TVL0vgNC5UGjay/q/v9ZWvpOsISWkjezS
         1s+w==
X-Gm-Message-State: APjAAAW8xIR9jFZQ2sS4qTOjBGGmmpRTrTtFBOQdopeyLjiLq/xBnkED
        uS/8/eTnWaRUjCSiPQ0/fD5yi+QntDofy+B3mgs=
X-Google-Smtp-Source: APXvYqyuL/2JXnrA0RyJL6yz67FJ8Lms7lPxW5N5SBM54W/lLa5IDZGtH0jjpkiAz30csKSYqVRDxFzRXZXUzmgAJNc=
X-Received: by 2002:ac8:1a78:: with SMTP id q53mr45222642qtk.379.1571245225491;
 Wed, 16 Oct 2019 10:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568994791.git.esyr@redhat.com> <CAPhsuW5CvJNRP5OO_M6XVd9q0x-CH9eADWR5oqdJP20eFScCFw@mail.gmail.com>
 <87d4b42f-7aa2-5372-27e4-a28e4c724f37@kernel.dk> <CAPhsuW68rK3zGF3A8HnwArh7bs+-AAvZBtVkt4gcxPnFCGxwAQ@mail.gmail.com>
In-Reply-To: <CAPhsuW68rK3zGF3A8HnwArh7bs+-AAvZBtVkt4gcxPnFCGxwAQ@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 16 Oct 2019 10:00:13 -0700
Message-ID: <CAPhsuW6ZSbKLYPpUk3DT+HxTfcuOVPG64rQ057aoLGgrGSeGHA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix typo in RWH_WRITE_LIFE_NOT_SET constant name
To:     Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff and J. Bruce,

On Wed, Oct 2, 2019 at 9:55 AM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Tue, Oct 1, 2019 at 5:55 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 10/1/19 5:12 PM, Song Liu wrote:
> > > On Fri, Sep 20, 2019 at 8:58 AM Eugene Syromiatnikov <esyr@redhat.com> wrote:
> > >>
> > >> Hello.
> > >>
> > >> This is a small fix of a typo (or, more specifically, some remnant of
> > >> the old patch version spelling) in RWH_WRITE_LIFE_NOT_SET constant,
> > >> which is named as RWF_WRITE_LIFE_NOT_SET currently.  Since the name
> > >> with "H" is used in man page and everywhere else, it's probably worth
> > >> to make the name used in the fcntl.h UAPI header in line with it.
> > >> The two follow-up patches update usage sites of this constant in kernel
> > >> to use the new spelling.
> > >>
> > >> The old name is retained as it is part of UAPI now.
> > >>
> > >> Changes since v2[1]:
> > >>   * Updated RWF_WRITE_LIFE_NOT_SET constant usage
> > >>     in drivers/md/raid5-ppl.c:ppl_init_log().
> > >>
> > >> Changes since v1[2]:
> > >>   * Changed format of the commit ID in the commit message of the first patch.
> > >>   * Removed bogus Signed-off-by that snuck into the resend of the series.
> > >
> > > Applied to md-next.
> >
> > I think the core fs change should core in through a core tree, then
> > the md bits can go in at will after that.

As Jens suggested, we should route core fs patches through core tree. Could
you please apply these patches? Since the change is small, probably you can
also apply md patches?

Thanks,
Song

PS: for the series:

Acked-by: Song Liu <songliubraving@fb.com>
