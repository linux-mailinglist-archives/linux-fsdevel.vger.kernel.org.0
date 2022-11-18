Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8170762FFF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 23:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiKRWV4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 17:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiKRWVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:21:38 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC02B404D
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 14:20:59 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s196so6168906pgs.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5GphRXPoQS/Vrh0W1iy/t4/ktGKCxOLwHIoEesDSbaM=;
        b=raRmAtMoxAHvm+cWt8uB1qY/uL8fDIEEQ845ErKjspwsQs3PPVdWYxO0L75hvUHtQf
         irIGDXPIQfiFZCUTJhRIhgfe39eZdzg1I+3UYhZDHvkfSJ1wvtHwpbqns84Jd0FZQ26h
         X5XxE+yI1d4KH/6esRkeJawzO/h6pGYUYDWabReCievZ31cA7txONg8IKDOGzQCqLEgi
         NpFuvwWrIZsXQd3hEuXSuX1qwNKErQdZHb8KOyrc3K2jS3RIawo6G6EdgzPJde6L7sL+
         63UY4yKzlNYnzB22y8Nhvh9wAoZ2Pppr196ZI3eqghJQbPnZuYU7iygvqYazZL/ZXOz3
         8lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GphRXPoQS/Vrh0W1iy/t4/ktGKCxOLwHIoEesDSbaM=;
        b=s0Ft+NkH7ddiHdqyvaiTMFlUd6U6uB8LgA0KGRqvMDxJQgMzI43w+vkAOdnyI4/7PJ
         Q2CfXFTyFaGyugqUgS47gnQ8py6rrGZc6aBSbBud1tueRS8GRsjG14cT9bvLs+mdFLBx
         qhaQqT4GhtF30/YbLyeYYplPMqvpphwZNedFKrcRcaKdsXctD+PUG+7YzNzBOcBfX9I0
         Ytg5eAo0PF0Xqe7FjVU/mg2iR5Gq0f5n5ZtrC/vWTj6wJdUJzWlLhts9PVmwM1jizCrF
         qiUEpeuut1CBQl+CwymtZ3XoWNsgYb+t6nrqSHAa6Mxpf/2C3xX9cJsCaJDwp5ENjcbH
         A98w==
X-Gm-Message-State: ANoB5pn/Uah9NoRoluyiFUjdI5/fB6Ih8T3sEy74+zimuQ0oDut38tfm
        45JQOCxMxFiSWF9L59DOke0RjuEeIRMxIgV5N0Y5
X-Google-Smtp-Source: AA0mqf5dYUJhLfi1dDKR+hOOUUP91cFW/0gakbsNFhwLrG03uEt2DOeFhA/+B/xFm4zqfF3zl8RZWLw9Ulw57+CuRFo=
X-Received: by 2002:a63:dc45:0:b0:44e:46f9:7eeb with SMTP id
 f5-20020a63dc45000000b0044e46f97eebmr8404580pgj.3.1668810058627; Fri, 18 Nov
 2022 14:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20221110043614.802364-1-paul@paul-moore.com> <20221118015414.GA19423@mail.hallyn.com>
 <CAHC9VhSNGSpdYWf_6if+Q+8BZvR-zYYxBMmoYhRNH9rWpn7=AA@mail.gmail.com>
 <9989ecccca46cbbecd12ae8ecdfc693ea115a09a.camel@linux.ibm.com>
 <CAHC9VhRUfJAYxZUDSkmoHdr5Z+TPCHSbv-nfvJ8t4_zg04NNXQ@mail.gmail.com> <89e8f4c2e1bc59c76715fc00a0578564ecf4077d.camel@linux.ibm.com>
In-Reply-To: <89e8f4c2e1bc59c76715fc00a0578564ecf4077d.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Nov 2022 17:20:47 -0500
Message-ID: <CAHC9VhQFg36rKjSsq0y4Uj4Rs5tR0DWxhvRefYuvT_vYk-5RxA@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,fs: fix vfs_getxattr_alloc() return type and
 caller error paths
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 18, 2022 at 2:09 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Fri, 2022-11-18 at 13:44 -0500, Paul Moore wrote:
> > On Fri, Nov 18, 2022 at 1:30 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > On Fri, 2022-11-18 at 08:44 -0500, Paul Moore wrote:
> > > > On Thu, Nov 17, 2022 at 8:54 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > > > > On Wed, Nov 09, 2022 at 11:36:14PM -0500, Paul Moore wrote:
> > > > > > The vfs_getxattr_alloc() function currently returns a ssize_t value
> > > > > > despite the fact that it only uses int values internally for return
> > > > > > values.  Fix this by converting vfs_getxattr_alloc() to return an
> > > > > > int type and adjust the callers as necessary.  As part of these
> > > > > > caller modifications, some of the callers are fixed to properly free
> > > > > > the xattr value buffer on both success and failure to ensure that
> > > > > > memory is not leaked in the failure case.
> > > >
> > > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > >
> > > > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > > >
> > > > > Do I understand right that the change to process_measurement()
> > > > > will avoid an unnecessary call to krealloc() if the xattr has
> > > > > not changed size between the two calls to ima_read_xattr()?
> > > > > If something more than that is going on there, it might be
> > > > > worth pointing out in the commit message.
> > > >
> > > > Yes, that was the intent, trying to avoid extra calls to krealloc().
> > > >
> > > > Mimi, have you had a chance to look at this patch yet?  In addition to
> > > > cleaning up the vfs_getxattr_alloc() function it resolves some issues
> > > > with IMA (memory leaks), but as you're the IMA expert I really need
> > > > your review on this ...b
> > >
> > > All the other vfs_{get/set/list}xattr functions return ssize_t.  Why
> > > should vfs_getxattr_alloc() be any different?
> >
> > The xattr_handler::get() function, the main engine behind
> > vfs_getxattr_alloc() and the source of the non-error return values,
> > returns an int.  The error return values returned by
> > vfs_getxattr_alloc() are the usual -E* integer values.
> >
> > > The only time there could be a memory leak is when the
> > > vfs_getxattr_alloc() caller provides a buffer which isn't large enough.
> > > The one example in IMA/EVM is the call to evm_calc_hmac_or_hash(),
> > > which is freeing the memory.
> > >
> > > Perhaps I'm missing something, but from an IMA/EVM perspective, I see a
> > > style change (common exit), but not any memory leak fixes.  I'm fine
> > > with the style change.
> >
> > Picking one at random, what about the change in
> > ima_eventevmsig_init()?  The current code does not free @xattr_data on
> > error which has the potential to leak memory if vfs_getxattr_alloc()'s
> > second call to the xattr get'er function fails.  Granted, the
> > likelihood of this, if it is even possible, is an open question, but I
> > don't think that is an excuse for the callers to not do The Right
> > Thing.
>
> Oh!  This is about the 2nd handler call failing.
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>b

Merged into lsm/next, thanks all.

-- 
paul-moore.com
