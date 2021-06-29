Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B543B72F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhF2NJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 09:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233862AbhF2NJF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:09:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DF7861DC0;
        Tue, 29 Jun 2021 13:06:36 +0000 (UTC)
Date:   Tue, 29 Jun 2021 15:06:33 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel@vger.kernel.org, io-uring <io-uring@vger.kernel.org>
Subject: Re: [PATCH v5 00/10] io_uring: add mkdir, [sym]linkat and mknodat
 support
Message-ID: <20210629130633.pqxg7otr542wrj2g@wittgenstein>
References: <20210603051836.2614535-1-dkadashev@gmail.com>
 <CAOKbgA69B=nnNOaHH239vegj5_dRd=9Y-AcQBCD3viLxcH=LiQ@mail.gmail.com>
 <2c4d5933-965e-29b5-0c76-3f2e5f518fe8@kernel.dk>
 <a459abe3-b051-ea60-d8d9-412562a255d5@kernel.dk>
 <20210622081240.c7tzq7e7gt3y3u7j@wittgenstein>
 <CAOKbgA5ak=yVo1Pw+8xzSH4vWVJSPG_rmwRCCOiUUGPp2tq+vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOKbgA5ak=yVo1Pw+8xzSH4vWVJSPG_rmwRCCOiUUGPp2tq+vQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 03:34:37PM +0700, Dmitry Kadashev wrote:
> On Tue, Jun 22, 2021 at 3:12 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Mon, Jun 21, 2021 at 09:21:23AM -0600, Jens Axboe wrote:
> > > On 6/18/21 10:10 AM, Jens Axboe wrote:
> > > > On 6/18/21 12:24 AM, Dmitry Kadashev wrote:
> > > >> On Thu, Jun 3, 2021 at 12:18 PM Dmitry Kadashev <dkadashev@gmail.com> wrote:
> > > >>>
> > > >>> This started out as an attempt to add mkdirat support to io_uring which
> > > >>> is heavily based on renameat() / unlinkat() support.
> > > >>>
> > > >>> During the review process more operations were added (linkat, symlinkat,
> > > >>> mknodat) mainly to keep things uniform internally (in namei.c), and
> > > >>> with things changed in namei.c adding support for these operations to
> > > >>> io_uring is trivial, so that was done too. See
> > > >>> https://lore.kernel.org/io-uring/20210514145259.wtl4xcsp52woi6ab@wittgenstein/
> > > >>
> > > >> Ping. Jens, are we waiting for the audit change to be merged before this
> > > >> can go in?
> > > >
> > > > Not necessarily, as that should go in for 5.14 anyway.
> > > >
> > > > Al, are you OK with the generic changes?
> > >
> > > I have tentatively queued this up.
> >
> > Hey Dmitry,
> > hey Jens,
> >
> > The additional op codes and suggested rework is partially on me. So I
> > should share the blame in case this gets a NAK:
> >
> > Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Hi Christian,
> 
> Thank you very much for your help with this! Just wanted to say that you
> were quite supportive and really helped me a lot.

Hey Dmitry,

Thank you for saying that! Much appreciated.
Thanks for working on this!

Christian
