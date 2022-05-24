Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470F65333A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 00:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbiEXWpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 18:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiEXWpD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 18:45:03 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EA0583A3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 15:45:02 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g72so5321223ybf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 15:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFJxesNeVZdJ8p6RzDYn9ZaWsWSp70bwESGebNW0UB8=;
        b=R22PT3Q4yed/Chk/ht3uDH8r7dQtQSX25txASrDdaRBtbAlSZH6brB3RT95PioC+0f
         l1jziEwIM+RtOrMf98Fk5GDzvxCxbrvIGwzU8ipc2J+TvIfKiTNoDcmemQP65Q9I50gj
         DNZUvcEG4b5XB1HAXmDku6hPDc4azFn4OG77s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFJxesNeVZdJ8p6RzDYn9ZaWsWSp70bwESGebNW0UB8=;
        b=2HguqUNReSbDFW4evorI/MWMV8BNFfkNMgSe7Zmz85j52J7WwEfl4Mhx+GOpVrhVT1
         pYh9uSWPN7eDdm6lUHMUHJOrvHmHToBRVw1TZdF8twIGusbIezo4izvgCewmPUJyRn6u
         MQaAQrG54pIs179cw3lwzHd9HUEsoLM59A4mXB67zoADFNB30clozwJLAlkULTv7Sy86
         3bovdGO1S73rYOssZwV6WsA7vcFffSTMkc+bHf184cwhWI/cU6ZVRUZpZAjOLaF90CLk
         jSdyFpLbTBchFhW8WuZmQDhr20b0c+WIuXk3SFsU8wGP/A5uF5fjZQXp9pp+g3H/3DGn
         CdIA==
X-Gm-Message-State: AOAM532elt+krFstzqyVYccp5KUWitebEV716ZyX/FLDh4Lo+6FVhGSZ
        2gUHzXy0sBs6zBN6Yk7CafE19tJdcY85rNkaYnCcsg==
X-Google-Smtp-Source: ABdhPJwLwW7l3Xl6KL/oB+o0l9D8Tigzh7l8sEdanX1Ifr7NYn/maLFXlCghZTjVIJtD8wW0Trs0nHYoW/AThH3hrqg=
X-Received: by 2002:a25:ace3:0:b0:64f:5f03:9f92 with SMTP id
 x35-20020a25ace3000000b0064f5f039f92mr22084309ybd.507.1653432301668; Tue, 24
 May 2022 15:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220511222910.635307-1-dlunev@chromium.org> <20220512082832.v2.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
 <YoQfls6hFcP3kCaH@zeniv-ca.linux.org.uk> <YoQihi4OMjJj2Mj0@zeniv-ca.linux.org.uk>
 <CAJfpegtQUP045X5N8ib1rUTKzSj-giih0eL=jC5-MP7aVgyN_g@mail.gmail.com>
 <CAONX=-do9yvxW2gTak0WGbFVPiLbkM2xH5LReMZkvC-upOUVxg@mail.gmail.com>
 <CAONX=-ehh=uGYAi++oV_uS23mp2yZcrUC+7U5H0rRz8q0h6OeQ@mail.gmail.com> <CAJfpegsPjFMCG-WHbvREZXzHPUd1R2Qa83maiTJbWSua9Kz=hg@mail.gmail.com>
In-Reply-To: <CAJfpegsPjFMCG-WHbvREZXzHPUd1R2Qa83maiTJbWSua9Kz=hg@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 25 May 2022 08:44:50 +1000
Message-ID: <CAONX=-d-6Bm9qGQyhmpkMQov+wjgH3+pAMHdSsifM6FpmHNPFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] FUSE: Retire superblock on force unmount
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Calling bdi_unregister() might be okay, and that should fix this.  I'm
> not familiar enough with that part to say for sure.
> But freeing sb->s_bdi while the superblock is active looks problematic.
Tracing the code, I see that, yes, in general that might not be safe to call
the "bdi_put" function for any FS - because it might have in-flight ops even
with force, where they will routinely access the members of the bdi struct
without locks. However, we do replace the struct with a no_op version,
and specifically for the FUSE case we sever the connection first, so no
in-flight ops can actually be there. And I am not sure if other FS may
need to do this retirement, given they don't have these
user-space/kernel split. It would make sense however to delay the actual
put till  the actual super block destruction, but that would require
introducing extra state tracking to see if the block is or is not registered
anymore. It can be piggybacked on the v1 patch where I have an explicit
state flag, but not on v2.
Miklos, Al, will the following work and be acceptable?
Get v1 patchset[1], in fuse_umount_begin do bdi_unregister and set
the flag, but do not do bdi_put or replacement with no_op. And then in
generic shutdown super if the bdi is not no_op and the 'defunct' flag is
set, skip unregister part.
Thanks,
Daniil

[1]
https://lore.kernel.org/linux-fsdevel/20220511013057.245827-1-dlunev@chromium.org/T/#u
