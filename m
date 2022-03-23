Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A24E4F06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 10:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiCWJS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 05:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiCWJSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:18:25 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3284975C27
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 02:16:56 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id r8so1030617oib.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsJyQ5y/d6VhBbryl6EWYGx+hkcP9hYmUTXG8qCvFfw=;
        b=WsXje9w8j4RZn2Lt+i6K1w9RUQE0YtoNDvsNfZGcnXPe73qzKxIMe8/arCkOdUZ+xb
         MekLkcgpGOxTTRROXOX9XSj5uatGpntwWRu4XSt5g74sy6GfW6KSpJLh9ZBKrAeO1WLW
         CDGwkJEi5IJQ9FC8hg4m8+JVC1BCLE1VflnHJ73XKXX5H01HZRVTn2UutUiz9wgwx/zh
         EZXs4TgaEPq4Tjlj4ugCszSIHzVRLolxDebMvAgTsVC7aDuBEZRqJZv96OrJKYlwiocy
         dehcDDt4nqPMQr7F2PNQMTwoPr7K+QnTR1lfnW6E6wxFsdLwYjgOAUIfFHH60q6BH5JK
         kDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsJyQ5y/d6VhBbryl6EWYGx+hkcP9hYmUTXG8qCvFfw=;
        b=wtULhsZKQQLtGOBQEjRZHvo6o8BRG+4bO6H9lyN9H5zjr869KX/GthDVZL0ePYZmLs
         Zhp8acK2BPWW5dbt+SudaRACjBwVp1cqZcABcY+bjB/apQAaVBjn6j/uhRV3mzPhCGc5
         HfC41onpH2tMiGsCNRTdouJAauYMl2W3tSXuZzZdJbhrx5kG3MSYZdg3s1wl/XCudixM
         Gz+CqH96d1/Zkh4V38dtI/58E/S3w7Geo2GfRbUy6vb54PsmFk210UqmWYfE+3qNeE+l
         zi9BCCGZiGGgYEoJeeHeTmMTAZB0WYTBJ7hUnLQ+gZXznZCko/+8ljRW7vaDPw3+53Hx
         YhxA==
X-Gm-Message-State: AOAM533DZQ8es5EoEncMnWL3PqUHFd7izZVZtaG9rjipq8ro/hyIN9CY
        9BD6P2yNuq0zdzFbY5g8906vJac8gMOd5vsOxvbV8Ba6
X-Google-Smtp-Source: ABdhPJw/+BBPBxVoGz4mWIIFhKEnCsR7L+433tECV6Or6w5tLmSGj4tHki0GUHMmuOSr7no/BNvH8S1eNRH2mTK1HHI=
X-Received: by 2002:aca:4005:0:b0:2ef:84d3:f282 with SMTP id
 n5-20020aca4005000000b002ef84d3f282mr2964142oia.98.1648027015563; Wed, 23 Mar
 2022 02:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220307155741.1352405-5-amir73il@gmail.com>
 <20220317153443.iy5rvns5nwxlxx43@quack3.lan> <20220317154550.y3rvxmmfcaf5n5st@quack3.lan>
 <CAOQ4uxi85LV7upQuBUjL==aaWoY8WGMG4DRQToj6Y-JCn-Ex=g@mail.gmail.com>
 <20220318103219.j744o5g5bmsneihz@quack3.lan> <CAOQ4uxj_-pYg4g6V8OrF8rD-8R+Mn1tMsPBq52WnfkvjZWYVrw@mail.gmail.com>
 <20220318140951.oly4ummcuu2snat5@quack3.lan> <CAOQ4uxisrc_u761uv9_EwgiENz4J6SNk=hPxpr7Nn=vC1S2gLg@mail.gmail.com>
 <CAOQ4uxgqZzsNhfpxDYomK19+ADqtfOgPNn4B1tG_4kupEhD05w@mail.gmail.com> <CAOQ4uxhnUo7C1Q9+MGkVn3ZggQv4=uxj1D=NpdqrfSU_ETM5ng@mail.gmail.com>
In-Reply-To: <CAOQ4uxhnUo7C1Q9+MGkVn3ZggQv4=uxj1D=NpdqrfSU_ETM5ng@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Mar 2022 11:16:44 +0200
Message-ID: <CAOQ4uxgi+cfv_wnMuwiLCXvzMNBt1Pv1mP3u9t7GBj9mK0pmSQ@mail.gmail.com>
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

On Tue, Mar 22, 2022 at 6:44 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > FYI, I've implemented the above and pushed to branch fan_evictable.
> > Yes, I also changed the name of the flag to be more coherent with the
> > documented behavior:
> >
> >     fanotify: add support for "evictable" inode marks
> >
> >     When an inode mark is created with flag FAN_MARK_EVICTABLE, it will not
> >     pin the marked inode to inode cache, so when inode is evicted from cache
> >     due to memory pressure, the mark will be lost.
> >
> >     When an inode mark with flag FAN_MARK_EVICATBLE is updated without using
> >     this flag, the marked inode is pinned to inode cache.
> >
> >     When an inode mark is updated with flag FAN_MARK_EVICTABLE but an
> >     existing mark already has the inode pinned, the mark update fails with
> >     error EEXIST.
> >
> > I also took care of avoiding direct reclaim deadlocks from fanotify_add_mark().
> > If you agree to the proposed UAPI I will post v2 patches.
>
> Jan,
>
> Before implementing your suggested solution, I wrote a test patch
> that reproduces the deadlock.
> It took me a while to get to a reproducible scenario and I ended up using
> a debug feature called FAN_MARK_LARGE to get there.
>
> You can see the test patches at the tip of these kernel and ltp branches:
> https://github.com/amir73il/linux/commits/fan_evictable
> https://github.com/amir73il/ltp/commits/fan_evictable
>
> The question is how can we test this in release kernels?
> Should we include FAN_MARK_LARGE as a hidden (admin only)
> feature? Use sysctl knob to enable it? use an ioctl? something else?
>

I went for ioctl and I kind of like it like.
Pushed.

Thanks,
Amir.
