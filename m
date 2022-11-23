Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6A9635F89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 14:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbiKWN2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 08:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiKWN2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:28:13 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BCC77200
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 05:07:19 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id a19so3792511uan.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 05:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7zC6oSnSf6BcBX4kmnnFrHBlh7HIdEFiSeFjDUxu6/4=;
        b=kD681cvi9urN32FUKzLTzUYNEMoQUdJfQzmO33VKpkAnW6TTbGdXxKUwBNQVuCnmEB
         WIqjAn3XPYHqCLtmXNUImWplD0/HHQNfpsw90jLppXeqlLm8TkMoo9q8MTWWFeOUswRR
         YsYtegX4B+caQUwj52Z6Ueut/1wDhoGYMuplWqWqr59zr/FIUMMKhPRQg9kghoqB1VOs
         sDiVIwVg1408eGIrXusZAx8bX9wC7gT9D5dUdI3N9iyepP7kx60EQRFkZmv/IqscZ5Vg
         9vFqu0I3mdBfnr+7K5w6YfESyQeW5sV2d/3RTeON+xIgFnwhJg0PCUFny60wmdP0C+2M
         Yfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zC6oSnSf6BcBX4kmnnFrHBlh7HIdEFiSeFjDUxu6/4=;
        b=2f1PX2FXznuHyRFx2Lbrg52NG21eYS7USx6FqKStzDssxEjDW4UMm3xZBruFPUm+2A
         LhEuzduxtLQS5J+zzypq+RGVthPriTZKy4Pa8VUBzNvb927GIAJMe0f3VOkyHaVlOJXP
         ef4mk98U4SpA4PhGmRHV7zZjqoUQRTFQJpAEG0vEhdbGMb7dYI5EHmt4yz3sL5SEBKaL
         j7LXE4tnIzqoB2ZZidr1Bz9S9HNkU5drvQ3ucgWR96VrsTbgQdylM0i0CacfKpmPSTP2
         dEqs0CK+l8KCvnNTnuJ0/E0NESkSvpEqTbO2qpdfv4EwwiHOEn9mzTWb0kdxFTvg/8Bm
         43mQ==
X-Gm-Message-State: ANoB5pkL6ZsA33AKTzg07QRECsLNH5susFvuk0HW0GWWDXMiqJHwBwuQ
        kIkaHPnfF0thDt435ViX2DMDziVMf2/1I5aemQsoFlGj
X-Google-Smtp-Source: AA0mqf50ZR9NFeUmoS7wDQ2PYO40b2r0bZLfpICZR10Jz4HyHpMtKjarvNnnEG9BxxOOdETHnBA/ieHNy1vXbFmZpVM=
X-Received: by 2002:ab0:14e8:0:b0:418:b9ed:8d94 with SMTP id
 f37-20020ab014e8000000b00418b9ed8d94mr5384716uae.60.1669208838220; Wed, 23
 Nov 2022 05:07:18 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3> <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3> <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
 <20221115101614.wuk2f4dhnjycndt6@quack3> <CAOQ4uxhcXKmdq+=fexuyu-nUKc5XHG6crtcs-+tP6-M4z357pQ@mail.gmail.com>
 <20221116105609.ctgh7qcdgtgorlls@quack3> <CAOQ4uxhQ2s2SOkvjCAoZmqNRGx3gyiTb0vdq4mLJd77pm987=g@mail.gmail.com>
 <CAOQ4uxiuyYdN9PK4XN+Vd7+XO56OcW_GrSU-U62srxLGQbx3JQ@mail.gmail.com> <20221123104920.g72y2ny533p2eo7w@quack3>
In-Reply-To: <20221123104920.g72y2ny533p2eo7w@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Nov 2022 15:07:06 +0200
Message-ID: <CAOQ4uxh8sLO9GH_JjyfywvCbXwoc_DiUvfaO8Fn=BK7WyMVdnQ@mail.gmail.com>
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

> > Hmm I guess "crash safety" is not well defined.
> > You and I were talking about "system crash" and indeed, this was
> > my only concern with kernel implementation of overlayfs watch.
> >
> > But with userspace HSM service, how can we guarantee that
> > modifications did not happen while the service is down?
> >
> > I don't really have a good answer for this.
>
> Very good point!
>
> > Thinking out loud, we would somehow need to make the default
> > permission deny for all modifications, maybe through some mount
> > property (e.g. MOUNT_ATTR_PROT_READ), causing the pre-write
> > hooks to default to EROFS if there is no "vfs filter" mount mark.
> >
> > Then it will be possible to expose a "safe" mount to users, where
> > modifications can never go unnoticed even when HSM service
> > crashes.
>
> Yeah, something like this. Although the bootstrap of this during mount may
> be a bit challenging. But maybe not.
>

I don't think so.
As I wrote on several occasions, some of the current HSMs are implemented
as FUSE filesystems and require mount.

As I imagine an HSM system (and as our in-house system works)
there is a filesystem containing populated and unpopulated files that admin
can access without any filters and there is a mount that is exposed to users
where the filtering and on-demand populate happens.

I am less worried about bringup.
My HttpDirFS POC already does mount move of a marked mount on startup.
My concern was how to handle dying fanotify group safely.

> Also I'm thinking about other usecases - for HSM I agree we essentially
> need to take the FS down if the userspace counterpart is not working. What
> about other persistent change log usecases? Do we mandate that there is
> only one "persistent change log" daemon in the system (or per filesystem?)
> and that must be running or we take the filesystem down? And anybody who
> wants reliable notifications needs to consume service of this daemon?

Yes, I envision a single systemd-fsmonitor daemon (or instance per sb) that
can handle subscribing to changes on subtree and can deal with the permission
of dispatching events on subtrees.

To answer your question, I think the bare minimum that we need to provide
is a property of the mount (probably an event mask) that requires at least one
active fanotify vfs filter to allow certain permission events to go through.

I think it would make sense to allow a single FAN_CLASS_VFS_FILTER
group mark per sb and one per mount.

If use cases that require more vfs filters per sb/mount arise, we can
revisit that restriction later.

Thanks,
Amir.
