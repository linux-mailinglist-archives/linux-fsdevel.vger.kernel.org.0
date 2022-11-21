Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1717F6329C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 17:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKUQkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 11:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKUQkU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:40:20 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999D7DFC6
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 08:40:19 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id m18so5914804vka.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dQz34xVruW6ETY0iOoEoJ7A2xp77Y8pOKPC2eueNzwg=;
        b=UZIfs+ZDBy9AZO42hkBVFh7fn92Y8sDX9uy+NRRGeUsnzSCTe6GQmoEvY6U4i+9Wme
         UGuc3pOf4kls5DQjLx4SnMQGIyazR+Ymeldmw8idYxOIWJobwFeuDKgj/+mBtPwHleW8
         kMtSqNGTLMpuYIJPBt2BrwoAUmyAppHnCpN5sNVGzcFFgpziAcKK/jv/huBKeEYfjry4
         6Ma0ghRcMSMYpnNjOTOGt2ozoEMvXqTI7X4JWhFAZELzD7C6NxEfKCK49b53ykfJEpDa
         J6+uDiR/UcnoN8ThS8e6o25sJZCnEOR89+w2lmKqJB4U+SIXiliCU04Gs/9h+hxljdom
         Uydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQz34xVruW6ETY0iOoEoJ7A2xp77Y8pOKPC2eueNzwg=;
        b=l+7JbBp4+iR4fKnJ1rqegJtPeNscH1rd/+Rlx8l4mGnVE1SyC60ytgVtKlydJ6Ct3O
         X4JN/nTA0H24YG0nR+gFicreozJWhPpyvX2M1Nl9ICB2vq7DfUHtzVg5UiEKBC/2kcLq
         WzGU39Dm2rricVEEgrpS9KlyXtCWNrQIU3v6nn5qb92ioF4Lz2IA8VK7fHruVHxDrIZh
         /8MOvEL2Jnz/KqmMvtUHmW/buFCVQZlazlOQEh9+G/fhBDMNJYpNpC5PqUgJJizXzDiL
         8E9b9c4b7L1OmUaz29qWtdZqzYcy5/9FGmOr89NUaZnC/tieL5hEfGWiybgkoP9oPsPo
         NTdA==
X-Gm-Message-State: ANoB5pm7MPZOBHbObS6DN+rwfvaY3RiHgzeJkAjpanqR6ZraATNoW+tY
        5TpwB8FZhfafBvTBLVNBSDE3puxx+CKXZDULymEBzf4/E3c=
X-Google-Smtp-Source: AA0mqf779ieLwctcAJsHY+VL4m7uvwNYqhS9BimfufqEbB1VqVX6Khpf1Dif1a9I+bCSQ+4/ct+09+jCXq03Rs+pkkc=
X-Received: by 2002:a1f:5086:0:b0:3b7:5ff7:cfb8 with SMTP id
 e128-20020a1f5086000000b003b75ff7cfb8mr734446vkb.11.1669048818630; Mon, 21
 Nov 2022 08:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20220922104823.z6465rfro7ataw2i@quack3> <CAOQ4uxiNhnV0OWU-2SY_N0aY19UdMboR3Uivcr7EvS7zdd9jxw@mail.gmail.com>
 <20221103163045.fzl6netcffk23sxw@quack3> <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3> <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3> <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
 <20221115101614.wuk2f4dhnjycndt6@quack3> <CAOQ4uxhcXKmdq+=fexuyu-nUKc5XHG6crtcs-+tP6-M4z357pQ@mail.gmail.com>
 <20221116105609.ctgh7qcdgtgorlls@quack3> <CAOQ4uxhQ2s2SOkvjCAoZmqNRGx3gyiTb0vdq4mLJd77pm987=g@mail.gmail.com>
In-Reply-To: <CAOQ4uxhQ2s2SOkvjCAoZmqNRGx3gyiTb0vdq4mLJd77pm987=g@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 21 Nov 2022 18:40:06 +0200
Message-ID: <CAOQ4uxi-42EQrE55_km=NYiTiEaiheVZq7WN=6UQ9rrBqg7C+w@mail.gmail.com>
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

On Wed, Nov 16, 2022 at 6:24 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > Can't we introduce some SRCU lock / unlock into
> > > > file_start_write() / file_end_write() and then invoke synchronize_srcu()
> > > > during checkpoint after removing ignore marks? It will be much cheaper as
> > > > we don't have to flush all dirty data to disk and also writes can keep
> > > > flowing while we wait for outstanding writes straddling checkpoint to
> > > > complete. What do you think?
> > >
> > > Maybe, but this is not enough.
> > > Note that my patches [1] are overlapping fsnotify_mark_srcu with
> > > file_start_write(), so we would need to overlay fsnotify_mark_srcu
> > > with this new "modify SRCU".
> > >
> > > [1] https://github.com/amir73il/linux/commits/fanotify_pre_content
> >
> > Yes, I know that and frankly, that is what I find somewhat ugly :) I'd rather
> > have the "modify SRCU" cover the whole region we need - which means
> > including the generation of PRE_MODIFY event.
> >
>
> Yeh, it would be great if we can pull this off.

OK. I decided to give this a shot, see:

https://github.com/amir73il/linux/commits/sb_write_barrier

It is just a sketch to show the idea, very lightly tested.
What I did is, instead of converting all the sb_start,end_write()
call sites, which would be a huge change, only callers of
sb_start,end_write_srcu() participate in the "modify SRCU".

I then converted all the dir modify call sites and some other
call sites to use helpers that take SRCU and call pre-modify hooks.

[...]

> > > > The technical problem I see is how to deal with AIO / io_uring because
> > > > SRCU needs to be released in the same context as it is acquired - that
> > > > would need to be consulted with Paul McKenney if we can make it work. And
> > > > another problem I see is that it might not be great to have this
> > > > system-wide as e.g. on networking filesystems or pipes writes can block for
> > > > really long.
> > > >

I averted this problem for now - file data writes are not covered by
s_write_srcu with my POC branch.

The rationale is that with file data write, HSM would anyway need to
use fsfreeze() to get any guarantee, so maybe s_write_srcu is not really
useful here??

It might be useful to use s_write_srcu to cover the pre-modify event
up to after sb_start_write() in file write/aio/io_uring, but not byond it,
so that sb_write_barrier()+fsfreeze() will provide full coverage for
in-progress writes.

Please let me know if this plan sounds reasonable.

> > > > Final question is how to expose this to userspace because this
> > > > functionality would seem useful outside of filesystem notification space so
> > > > probably do not need to tie it to that.

In the current POC branch, nothing calls sb_write_barrier() yet.
I was thinking of using it when flushing marks, maybe with the
FAN_MARK_SYNC flag that I proposed.

For general purpose API, the semantics would need to be better
defined, as with this "opt-in" implementation, only some of the
modification operations are covered by the 'sb write barrier'.

Thanks,
Amir.
