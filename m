Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC7466D6A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 08:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjAQHGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 02:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjAQHGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:06:09 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A05901A;
        Mon, 16 Jan 2023 23:06:06 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id b81so14355660vkf.1;
        Mon, 16 Jan 2023 23:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mWPhmCkqKFcIpCiTZaLR4Hhw47aqQrOmrHVQN5Cisu4=;
        b=kLjakUQ3HJ/QaIBy9T4YySwWu5x1pRkDr51em/m2P7CZlUw0a1Jt8HjrZkOYhX5m28
         0Y50dcK9vwQZeBjUVUONeExQBdr0dsniTaBUlGof2OqX5i1ticHVCkS9Jh4PQH026PwT
         fOJ7fdQRNlTK53OrEpadB8jj0DHJUJ6O9Ppyp8Szhfp//f5PLw38DjUNcX2BfDargfT9
         0KP3xuo5UtjUZk+gLnDKo2ifQlfJZSckX63ftBG9CFv+9C+or7aG3txAdLtI/AUsAbXm
         W5s+VyCbx20VAwt5Nccmb/XUkbgN/y/adLEbQK4MICkWSuAtEDo9bAY2/1KQto0zHLc0
         DRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWPhmCkqKFcIpCiTZaLR4Hhw47aqQrOmrHVQN5Cisu4=;
        b=T+fK1laN3ghxf1OQgHjtxSRbrfc87iKevHM/b+f36fTYekPFuzcM3Nvk/Mj9Ro7mg8
         0V8Uvi50KtmGO8zOUJBXdSkqNf8OBC9xpznlUtauI0RNz1YKWq+YUNaesrGI+ckYunq1
         Be/7EYQqpPUznOUqyUqKostBij5FAZ/LajB0WHz64G9dv4moq2G9bJQ+I4xWt9iA7vYh
         uohoQH2QlkAk31Zas8gOblvnNdlFGAMrUoeXcW0Mi7vsuax9DKk3BHAgPHUe8jTwZq7A
         lu5w7seS5n1kZtjmby2misDxEaE3I2u4v2C+721rfITYePmx06KxIDpfwLHhyUQTSLe3
         2QKQ==
X-Gm-Message-State: AFqh2kpl+oblYL82wvjvEZ45iIleMexR5d1IgqDEmcWJWbxl6chJaQ4V
        xVcArfAuKoUuqI8GKugbfD33CdxZoso5OHflBeo=
X-Google-Smtp-Source: AMrXdXv5hkZJP75uf7vHbHm2oi+TPuS4UOTAW7L+vOpzuqGYoF6128JJwSluXtMAWS4q7e5+vfUammxNthYnnPytZ4c=
X-Received: by 2002:a1f:ad56:0:b0:3bc:8497:27fd with SMTP id
 w83-20020a1fad56000000b003bc849727fdmr247206vke.15.1673939165880; Mon, 16 Jan
 2023 23:06:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673623253.git.alexl@redhat.com> <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
 <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
 <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com> <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
 <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com> <2856820a46a6e47206eb51a7f66ec51a7ef0bd06.camel@redhat.com>
 <8f854339-1cc0-e575-f320-50a6d9d5a775@linux.alibaba.com>
In-Reply-To: <8f854339-1cc0-e575-f320-50a6d9d5a775@linux.alibaba.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 17 Jan 2023 09:05:53 +0200
Message-ID: <CAOQ4uxh34udueT-+Toef6TmTtyLjFUnSJs=882DH=HxADX8pKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        Yurii Zubrytskyi <zyy@google.com>,
        Eugene Zemtsov <ezemtsov@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
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

> It seems rather another an incomplete EROFS from several points
> of view.  Also see:
> https://lore.kernel.org/all/1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com/T/#u
>

Ironically, ZUFS is one of two new filesystems that were discussed in LSFMM19,
where the community reactions rhyme with the reactions to composefs.
The discussion on Incremental FS resembles composefs case even more [1].
AFAIK, Android is still maintaining Incremental FS out-of-tree.

Alexander and Giuseppe,

I'd like to join Gao is saying that I think it is in the best interest
of everyone,
composefs developers and prospect users included,
if the composefs requirements would drive improvement to existing
kernel subsystems rather than adding a custom filesystem driver
that partly duplicates other subsystems.

Especially so, when the modifications to existing components
(erofs and overlayfs) appear to be relatively minor and the maintainer
of erofs is receptive to new features and happy to collaborate with you.

w.r.t overlayfs, I am not even sure that anything needs to be modified
in the driver.
overlayfs already supports "metacopy" feature which means that an upper layer
could be composed in a way that the file content would be read from an arbitrary
path in lower fs, e.g. objects/cc/XXX.

I gave a talk on LPC a few years back about overlayfs and container images [2].
The emphasis was that overlayfs driver supports many new features, but userland
tools for building advanced overlayfs images based on those new features are
nowhere to be found.

I may be wrong, but it looks to me like composefs could potentially
fill this void,
without having to modify the overlayfs driver at all, or maybe just a
little bit.
Please start a discussion with overlayfs developers about missing driver
features if you have any.

Overall, this sounds like a fun discussion to have at LSFMMBPF23 [3]
so you are most welcome to submit a topic proposal for
"opportunistically sharing verified image filesystem".

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com/
[2] https://lpc.events/event/7/contributions/639/attachments/501/969/Overlayfs-containers-lpc-2020.pdf
[3] https://lore.kernel.org/linux-fsdevel/Y7hDVliKq+PzY1yY@localhost.localdomain/
