Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B48405FC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 00:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346669AbhIIW5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 18:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbhIIW5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:57:38 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD0BC061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 15:56:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h16so37624lfk.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 15:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ll2Nb/Rh/ET0+TwBLh//OAz8IKVSbYfnVralJR9y3lM=;
        b=MpZ1iF5kar3l4a5y2mq2lqPtsdQPViAY3yWrwP/QzgdtY6s/WnqVnIzYHuSwD66wNC
         kHs7IY4W9QQOe/FksrYH3pb4iovsSXAtL/+f/em1Cp4ckLWKJIePPXYTTlr0EXBht6j3
         YypuFDhDstbDWBUlmtVXCeyptUBLnP5YqTNAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ll2Nb/Rh/ET0+TwBLh//OAz8IKVSbYfnVralJR9y3lM=;
        b=n89FnfdU8eM5/8CCsWED7h1zG8IHoKAarzmVnp20BZTzsHx6sHWmyu0dZmkMhBBHT8
         Su0C+aPBKFNxRieXWQe/vvANkF3tOzKl2mNrl5151bGUymZVHjeidsEuQZy6BcomDAio
         zxDBenkCbDbB6Zj7T5rXf249iBvPQNXsrxv/wNzkPAXJpVthcrQtFbW1KD96RBeOIyhZ
         aF1W+xOpjDBEQtYC1LOjvX58Wfoz0W6S3woltnO9cv0wzi8eEF6bCfvjx/pEH9r0NefS
         c2T/vsprCrNrVCarFY4ACEas3Zmn3Np//InWuq8euBPjJ/AvNPIE1jRXynDpi63heVZg
         FJKA==
X-Gm-Message-State: AOAM533S1MPfq2V9N1qKQ70zR3NFiya+woatbsbl17VWSua8S09KJBL7
        XZufsbN/VmbCnEIcGhOy/z4O1tXW51nHAIa6p+o=
X-Google-Smtp-Source: ABdhPJwRIrpLCPRKPeLLjFQq+NPnkWuu28gtWdsaNAXu+UJYsvkIhRNxnkYU5btTxvxHXSoPzUydmQ==
X-Received: by 2002:a05:6512:3d94:: with SMTP id k20mr1662625lfv.260.1631228186198;
        Thu, 09 Sep 2021 15:56:26 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id d20sm336780lfv.117.2021.09.09.15.56.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 15:56:25 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id n2so155054lfk.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 15:56:25 -0700 (PDT)
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr1591482lfg.402.1631228185421;
 Thu, 09 Sep 2021 15:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk> <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk> <ebc6cc5e-dd43-6370-b462-228e142beacb@kernel.dk>
 <CAHk-=whoMLW-WP=8DikhfE4xAu_Tw9jDNkdab4RGEWWMagzW8Q@mail.gmail.com> <ebb7b323-2ae9-9981-cdfd-f0f460be43b3@kernel.dk>
In-Reply-To: <ebb7b323-2ae9-9981-cdfd-f0f460be43b3@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 15:56:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2fJ1XrgkfSYgn9atCzmJZ8J3HO5wnPO0Fvh5rQx9mmA@mail.gmail.com>
Message-ID: <CAHk-=wi2fJ1XrgkfSYgn9atCzmJZ8J3HO5wnPO0Fvh5rQx9mmA@mail.gmail.com>
Subject: Re: [git pull] iov_iter fixes
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 9, 2021 at 3:21 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/9/21 3:56 PM, Linus Torvalds wrote:
> >
> > IOW, can't we have  that
> >
> >         ret = io_iter_do_read(req, iter);
> >
> > return partial success - and if XFS does that "update iovec on
> > failure", I could easily see that same code - or something else -
> > having done the exact same thing.
> >
> > Put another way: if the iovec isn't guaranteed to be coherent when an
> > actual error occurs, then why would it be guaranteed to be coherent
> > with a partial success value?
> >
> > Because in most cases - I'd argue pretty much all - those "partial
> > success" cases are *exactly* the same as the error cases, it's just
> > that we had a loop and one or more iterations succeeded before it hit
> > the error case.
>
> Right, which is why the reset would be nice, but reexpand + revert at
> least works and accomplishes the same even if it doesn't look as pretty.

You miss my point.

The partial success case seems to do the wrong thing.

Or am I misreading things? Lookie here, in io_read():

        ret = io_iter_do_read(req, iter);

let's say that something succeeds partially, does X bytes, and returns
a positive X.

The if-statements following it then do not trigger:

        if (ret == -EAGAIN || (req->flags & REQ_F_REISSUE)) {
  .. not this case ..
        } else if (ret == -EIOCBQUEUED) {
  .. nor this ..
        } else if (ret <= 0 || ret == io_size || !force_nonblock ||
                   (req->flags & REQ_F_NOWAIT) || !(req->flags & REQ_F_ISREG)) {
  .. nor this ..
        }

so nothing has been done to the iovec at all.

Then it does

        ret2 = io_setup_async_rw(req, iovec, inline_vecs, iter, true);

using that iovec that has *not* been reset, even though it really
should have been reset to "X bytes read".

See what I'm trying to say?

                Linus
