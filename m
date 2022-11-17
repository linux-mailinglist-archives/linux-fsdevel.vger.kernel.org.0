Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A891B62DB0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 13:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiKQMjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 07:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbiKQMjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:39:05 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0793F71F32
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Nov 2022 04:39:04 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id g26so737549vkm.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Nov 2022 04:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7xXiwmOu7cJokvvJFpjWYo3K4u6JR8GsKdA/5vFthns=;
        b=ZMEkYGRZ/8+wda2jzAiYOapHdayFomXXjJik9E7Dh70FyaMZ6M/9B+yKUlXlwyjCfn
         2MIVXsVnh7z5DTrn74IUDmti2B//AGsLnf4jRq3PyY6gENuAtDq5L+MhR0XKaS1Ejo0G
         wrRq6nJD8F/liYeLIusfxeWnnU5Ngz50qAEmjFEbGyUQCYKrZP8uR25bvLgBMdNrzig2
         22NKVYDBv1KJl3gKXYesvXejw3YkH+jBRefi5Ona7ngqj7QBZMlAG81odLnOSiROwK4S
         +uH1BMmhh3A+9ARbpdTsVydpRR2kM62hJGxOwxYUlAMchD7ek2hj1t/B+lxphWq2Xtaf
         M/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xXiwmOu7cJokvvJFpjWYo3K4u6JR8GsKdA/5vFthns=;
        b=wwXoU1aN/xx0At1chOVYlh3gVraZTYqwWSz41bp4Heal0+x7HSW7hzT/SR6ihC9uM7
         GXjzNQtMtyBgGhC0zZ9djEymAGZrzkSglgB1fleogbDGL/Mv8dIoq57I1NXitJFYtRyD
         FzIstGb2k2/H1rvwhCwqzpiwBadKj2Z+ZUMN+g3wK4ntIPrKLNZDnFsCFoGFjyRbLAvS
         TXEi3bbkM73Yn38qif2eGdVEqvPIKHnRaAFI1JxLr1sgs+WnL00eTQ3wsLXcOnkgme9u
         WKwzhgH0xQPc1GhT62YSLjI7JrQDw1sfCcBfdCvnVVa7b6vQdk72H70Q6Sdat+99zfg6
         XteQ==
X-Gm-Message-State: ANoB5pnnfswpQLP7ERTd7p3aIL+VQdeERyLFXtUOQsvwAEgEgCJL+mHe
        yLhkeOvT7oUbly+XdG61Fx/7wf0aglbF/5MVoyS6WSed
X-Google-Smtp-Source: AA0mqf5zKvqKnFQQ3EmBZp2etK07rFgu8uCO7NCGW7A6AtJjvXSvpv5SKpTSteKb4OnW0UhvWD8Nnrmh8I4L21kjxYE=
X-Received: by 2002:a1f:9e92:0:b0:3ab:a69f:3b7c with SMTP id
 h140-20020a1f9e92000000b003aba69f3b7cmr993319vke.36.1668688743057; Thu, 17
 Nov 2022 04:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20220922104823.z6465rfro7ataw2i@quack3> <CAOQ4uxiNhnV0OWU-2SY_N0aY19UdMboR3Uivcr7EvS7zdd9jxw@mail.gmail.com>
 <20221103163045.fzl6netcffk23sxw@quack3> <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3> <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3> <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
 <20221115101614.wuk2f4dhnjycndt6@quack3> <CAOQ4uxhcXKmdq+=fexuyu-nUKc5XHG6crtcs-+tP6-M4z357pQ@mail.gmail.com>
 <20221116105609.ctgh7qcdgtgorlls@quack3> <CAOQ4uxhQ2s2SOkvjCAoZmqNRGx3gyiTb0vdq4mLJd77pm987=g@mail.gmail.com>
In-Reply-To: <CAOQ4uxhQ2s2SOkvjCAoZmqNRGx3gyiTb0vdq4mLJd77pm987=g@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 17 Nov 2022 14:38:51 +0200
Message-ID: <CAOQ4uxiuyYdN9PK4XN+Vd7+XO56OcW_GrSU-U62srxLGQbx3JQ@mail.gmail.com>
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

> > > > The checkpoint would then do:
> > > > start gathering changes for both T and T+1
> > > > clear ignore marks
> > > > synchronize_srcu()
> > > > stop gathering changes for T and report them
> > > >
> > > > And in this case we would not need POST_WRITE as an event.
> > > >
> > >
> > > Why then give up on the POST_WRITE events idea?
> > > Don't you think it could work?
> >
> > So as we are discussing, the POST_WRITE event is not useful when we want to
> > handle crash safety. And if we have some other mechanism (like SRCU) which
> > is able to guarantee crash safety, then what is the benefit of POST_WRITE?
> > I'm not against POST_WRITE, I just don't see much value in it if we have
> > another mechanism to deal with events straddling checkpoint.
> >
>
> Not sure I follow.
>
> I think that crash safety can be achieved also with PRE/POST_WRITE:
> - PRE_WRITE records an intent to write in persistent snapshot T
>   and add to in-memory map of in-progress writes of period T
> - When "checkpoint T" starts, new PRE_WRITES are recorded in both
>   T and T+1 persistent snapshots, but event is added only to
>   in-memory map of in-progress writes of period T+1
> - "checkpoint T" ends when all in-progress writes of T are completed
>
> The trick with alternating snapshots "handover" is this
> (perhaps I never explained it and I need to elaborate on the wiki [1]):
>
> [1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#Modified_files_query
>
> The changed files query results need to include recorded changes in both
> "finalizing" snapshot T and the new snapshot T+1 that was started in
> the beginning of the query.
>
> Snapshot T MUST NOT be discarded until checkpoint/handover
> is complete AND the query results that contain changes recorded
> in T and T+1 snapshots have been consumed.
>
> When the consumer ACKs that the query results have been safely stored
> or acted upon (I called this operation "bless" snapshot T+1) then and
> only then can snapshot T be discarded.
>
> After snapshot T is discarded a new query will start snapshot T+2.
> A changed files query result includes the id of the last blessed snapshot.
>
> I think this is more or less equivalent to the SRCU that you suggested,
> but all the work is done in userspace at application level.
>
> If you see any problem with this scheme or don't understand it
> please let me know and I will try to explain better.
>

Hmm I guess "crash safety" is not well defined.
You and I were talking about "system crash" and indeed, this was
my only concern with kernel implementation of overlayfs watch.

But with userspace HSM service, how can we guarantee that
modifications did not happen while the service is down?

I don't really have a good answer for this.

Thinking out loud, we would somehow need to make the default
permission deny for all modifications, maybe through some mount
property (e.g. MOUNT_ATTR_PROT_READ), causing the pre-write
hooks to default to EROFS if there is no "vfs filter" mount mark.

Then it will be possible to expose a "safe" mount to users, where
modifications can never go unnoticed even when HSM service
crashes.

Thanks,
Amir.
