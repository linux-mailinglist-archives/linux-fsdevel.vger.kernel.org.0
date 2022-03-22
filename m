Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0AA4E4475
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 17:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbiCVQqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 12:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiCVQqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:46:21 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A87A197
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 09:44:53 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id e4so17016905oif.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tni6vUBFD1gSLbA6XGDRO2UtAeRxy38BPwWXOUKEs2o=;
        b=UeR/rzuty0Zx77quuu5eD+VAdXzA09XxH5mfXKj/SUJUGmCFIadbaJi8haSBnyUK1L
         gRrrz8Vj0e8I4TBloGs71nzVd8923qaUcTgr5f3ZyK+ojw8HvGKrFIEl3egWOVS31z0D
         vQDyuhciW8rJXHFRWYPEGYIm0/1CaW6sGMG6IBIJI5UXBrnlaIbXz+4O918t479pp5ep
         NGvoZuJ3P9jQyxiva4ze2AlW72/UcUEARavaipMMR6psjcn+rRU9jafwQ6ysOxhdH7K+
         IEeKuiEiWzFZsAIh11Ap2snd6zWRyp1B3C3e0yNj5LaGE00dtm25lQclFwSmsEGLkuLZ
         MznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tni6vUBFD1gSLbA6XGDRO2UtAeRxy38BPwWXOUKEs2o=;
        b=Ey6aJkrSVfUjNqEeGBnVJVsH7kWgHvrTjqKiXTgnBc1JL+Pct02dMEv80I1u37bqXP
         FS05Hkth/3Z3eQpL1QmkQvwecy7RhQO2v2nKRbhVt45RdQQGbHUYrPZj3XYOeGaOVIC2
         2+CIHfHgdFtFVe5eWag1/jaHCYKbbYl8Vhe/BubmzAloLaz2NLInsk74knPZhrVp15QN
         r0qk8vL/KnlzmjLgKgeL5zErOdA1C4tZKo6yeCNBlGjRqtUdFbBsJ7O77hqiVhiaMImW
         BIWQqAKvItxw224sGd5rGFv/PZfV5OKZOt1R710IfeovcWet/5UuXIdTtH8yTVr8MA3j
         Yryw==
X-Gm-Message-State: AOAM532CTGEQAz58cyM2dCJds1EddfFa41U2Us+XSXJo5j+HUWSM46wt
        BgFnh2W+6R/EiaMs2zAfH29Zb1XaBBpZJsLA2CU=
X-Google-Smtp-Source: ABdhPJzAvmK+RRkoxUNjirALLDA/15EkBUQzccqQFFKVkrhWdCrT+E2+AEVqHNd0uTXRamYvHDAMV2oA3z29sIJ0QZU=
X-Received: by 2002:aca:180d:0:b0:2ef:40d5:3b9c with SMTP id
 h13-20020aca180d000000b002ef40d53b9cmr2509163oih.18.1647967493085; Tue, 22
 Mar 2022 09:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220307155741.1352405-5-amir73il@gmail.com>
 <20220317153443.iy5rvns5nwxlxx43@quack3.lan> <20220317154550.y3rvxmmfcaf5n5st@quack3.lan>
 <CAOQ4uxi85LV7upQuBUjL==aaWoY8WGMG4DRQToj6Y-JCn-Ex=g@mail.gmail.com>
 <20220318103219.j744o5g5bmsneihz@quack3.lan> <CAOQ4uxj_-pYg4g6V8OrF8rD-8R+Mn1tMsPBq52WnfkvjZWYVrw@mail.gmail.com>
 <20220318140951.oly4ummcuu2snat5@quack3.lan> <CAOQ4uxisrc_u761uv9_EwgiENz4J6SNk=hPxpr7Nn=vC1S2gLg@mail.gmail.com>
 <CAOQ4uxgqZzsNhfpxDYomK19+ADqtfOgPNn4B1tG_4kupEhD05w@mail.gmail.com>
In-Reply-To: <CAOQ4uxgqZzsNhfpxDYomK19+ADqtfOgPNn4B1tG_4kupEhD05w@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 22 Mar 2022 18:44:41 +0200
Message-ID: <CAOQ4uxhnUo7C1Q9+MGkVn3ZggQv4=uxj1D=NpdqrfSU_ETM5ng@mail.gmail.com>
Subject: Re: direct reclaim of fanotify evictable marks
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> FYI, I've implemented the above and pushed to branch fan_evictable.
> Yes, I also changed the name of the flag to be more coherent with the
> documented behavior:
>
>     fanotify: add support for "evictable" inode marks
>
>     When an inode mark is created with flag FAN_MARK_EVICTABLE, it will not
>     pin the marked inode to inode cache, so when inode is evicted from cache
>     due to memory pressure, the mark will be lost.
>
>     When an inode mark with flag FAN_MARK_EVICATBLE is updated without using
>     this flag, the marked inode is pinned to inode cache.
>
>     When an inode mark is updated with flag FAN_MARK_EVICTABLE but an
>     existing mark already has the inode pinned, the mark update fails with
>     error EEXIST.
>
> I also took care of avoiding direct reclaim deadlocks from fanotify_add_mark().
> If you agree to the proposed UAPI I will post v2 patches.

Jan,

Before implementing your suggested solution, I wrote a test patch
that reproduces the deadlock.
It took me a while to get to a reproducible scenario and I ended up using
a debug feature called FAN_MARK_LARGE to get there.

You can see the test patches at the tip of these kernel and ltp branches:
https://github.com/amir73il/linux/commits/fan_evictable
https://github.com/amir73il/ltp/commits/fan_evictable

The question is how can we test this in release kernels?
Should we include FAN_MARK_LARGE as a hidden (admin only)
feature? Use sysctl knob to enable it? use an ioctl? something else?

Thanks,
Amir.
