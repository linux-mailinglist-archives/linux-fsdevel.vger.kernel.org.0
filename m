Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EF5636036
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 14:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbiKWNma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 08:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbiKWNmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:42:07 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA00C9A9B
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 05:30:25 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id q127so17430040vsa.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 05:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rnOSBrOnNqm4tJH25SDMPEcmSHajM5l6Da0ft21Y49w=;
        b=JHHL0O3sPko06ycWPZFP2b3wSuU2bSC1VH24WIyt1WwoO+i7arb1PlMMcv0tIr3VtS
         CuUZ9/hZGYQUuWQON+ig6B5zvbfVtAJAy2QVAUii5O4Lfpmfp3fi5n+qXMZxUash2omH
         2SE9Ceevdv+2C+SAYZP3gF+mMaN3a+KnkvQafAYgWmcUd/Tpf9Z0UIlEnxeMMzuRdpho
         1GppxXFjiJ9nbiO9A/FJ9CVNvSBaqxIBNZI3Pabmpx5k+tttEndY/NWnfqtEHt4S0GVa
         qMT2Evtj8XUxcgI101qPH6E4dOreYcswAP0K48YVFNp+nDAS9/ibrDbuMSOAQrkuiCzE
         Ou4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnOSBrOnNqm4tJH25SDMPEcmSHajM5l6Da0ft21Y49w=;
        b=4haqT1gaURobX1yhe+j8cQ/6TU6q3ksL0wpupCGBiule4OhXAqWL6gSi5vKjmr2Jz2
         R7ZIjTpmhx5qrpZBrLwj85E4srLQlimPxTFIB1AxzCQrs+9wXOMf5/2q0lI5qiCmguS6
         a7tAOFWsJ4VEmwT5U2D7GxTVGMRg3CKNvO8S4vQS3mE+4+iH66Qz1j4LBQJG/GtyHFiu
         CGYzjG5U5OphuM8R4+Uw9yO3Dj1NE7r4j4RhP6mzOQpbVIqMOILcA3Pvm4MeugehYz6/
         GTb7t/LEpNQtYn6QIog1ZaV/nUA7Z9AEWNtzGT1DjAkB9YffDGyQVfAZ2Sd0PsZ26ZZ3
         mkag==
X-Gm-Message-State: ANoB5pme4F/rkVgVZJ+fwdQg5sIiKUf6yDBGzzHNo43Hr+MCbs2Yaqcp
        ts2Km2JOv5+1IS6s1AnWeiaETXJPMNKrgV0yb38=
X-Google-Smtp-Source: AA0mqf7Fudd4X29D0dxKnBEM+ZphgpoysSfSE+OUSlzdipWZMME4YbMiKS+63rf1tdpYeLBwuwHwuuSWAxxfdb5xznY=
X-Received: by 2002:a05:6102:5710:b0:3b0:7462:a91 with SMTP id
 dg16-20020a056102571000b003b074620a91mr669783vsb.36.1669210224372; Wed, 23
 Nov 2022 05:30:24 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3> <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3> <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
 <20221115101614.wuk2f4dhnjycndt6@quack3> <CAOQ4uxhcXKmdq+=fexuyu-nUKc5XHG6crtcs-+tP6-M4z357pQ@mail.gmail.com>
 <20221116105609.ctgh7qcdgtgorlls@quack3> <CAOQ4uxhQ2s2SOkvjCAoZmqNRGx3gyiTb0vdq4mLJd77pm987=g@mail.gmail.com>
 <CAOQ4uxi-42EQrE55_km=NYiTiEaiheVZq7WN=6UQ9rrBqg7C+w@mail.gmail.com> <20221123121150.chowzv37syhr6dkt@quack3>
In-Reply-To: <20221123121150.chowzv37syhr6dkt@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Nov 2022 15:30:12 +0200
Message-ID: <CAOQ4uxixyBH_Mj4cPdP5fo4DZp+uz7XGU=cGJPkeW4s_pjdaNQ@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 23, 2022 at 2:11 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 21-11-22 18:40:06, Amir Goldstein wrote:
> > On Wed, Nov 16, 2022 at 6:24 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > > > > Can't we introduce some SRCU lock / unlock into
> > > > > > file_start_write() / file_end_write() and then invoke synchronize_srcu()
> > > > > > during checkpoint after removing ignore marks? It will be much cheaper as
> > > > > > we don't have to flush all dirty data to disk and also writes can keep
> > > > > > flowing while we wait for outstanding writes straddling checkpoint to
> > > > > > complete. What do you think?
> > > > >
> > > > > Maybe, but this is not enough.
> > > > > Note that my patches [1] are overlapping fsnotify_mark_srcu with
> > > > > file_start_write(), so we would need to overlay fsnotify_mark_srcu
> > > > > with this new "modify SRCU".
> > > > >
> > > > > [1] https://github.com/amir73il/linux/commits/fanotify_pre_content
> > > >
> > > > Yes, I know that and frankly, that is what I find somewhat ugly :) I'd rather
> > > > have the "modify SRCU" cover the whole region we need - which means
> > > > including the generation of PRE_MODIFY event.
> > > >
> > >
> > > Yeh, it would be great if we can pull this off.
> >
> > OK. I decided to give this a shot, see:
> >
> > https://github.com/amir73il/linux/commits/sb_write_barrier
> >
> > It is just a sketch to show the idea, very lightly tested.
> > What I did is, instead of converting all the sb_start,end_write()
> > call sites, which would be a huge change, only callers of
> > sb_start,end_write_srcu() participate in the "modify SRCU".
> >
> > I then converted all the dir modify call sites and some other
> > call sites to use helpers that take SRCU and call pre-modify hooks.
> >
> > [...]
>
> I've glanced over the changes and yes, that's what I was imagining :).

FYI, just pushed an update to that branch which includes *write_srcu
wrappers for all the call sites of security_file_permission(file, MAY_WRITE),
mostly file_start_write_area()/file_end_write_srcu().

For async write, write_srcu only covers the pre-modify event and the
io submittion.

>
> > > > > > The technical problem I see is how to deal with AIO / io_uring because
> > > > > > SRCU needs to be released in the same context as it is acquired - that
> > > > > > would need to be consulted with Paul McKenney if we can make it work. And
> > > > > > another problem I see is that it might not be great to have this
> > > > > > system-wide as e.g. on networking filesystems or pipes writes can block for
> > > > > > really long.
> > > > > >
> >
> > I averted this problem for now - file data writes are not covered by
> > s_write_srcu with my POC branch.
>
> Since you've made the SRCU per sb there is no problem with writes blocking
> too long on some filesystems. I've asked RCU guys about the problem with
> SRCU being acquired / released from different contexts. Logically, it seems
> it should be possible to make this work but maybe I miss some technical
> detail.
>
> > The rationale is that with file data write, HSM would anyway need to
> > use fsfreeze() to get any guarantee, so maybe s_write_srcu is not really
> > useful here??
> >

That was a wrong statement. For data writes HSM would need to do
syncfs() after sb_write_barrier(), not fsfreeze.
With the current POC branch, fsfreeze would only be needed to wait
for the async write completions.

> > It might be useful to use s_write_srcu to cover the pre-modify event
> > up to after sb_start_write() in file write/aio/io_uring, but not byond it,
> > so that sb_write_barrier()+fsfreeze() will provide full coverage for
> > in-progress writes.
> >
> > Please let me know if this plan sounds reasonable.
>
> Let's see what RCU guys reply. I'd prefer to cover the whole write for
> simplicity if it is reasonably possible.
>

OK.

Other backup plans:
- Set a flag in pre-modify events from async write so HSM
  knowns that event is not "atomic" with modification
- HSM may deny all events on this sort if it needs to record
  a change or it may mark the snapshot "requires freeze"
- Reliably deliver post-write events only for the async write
  completions (also on error), so HSM can track only those
  event pairs

Thanks,
Amir.
