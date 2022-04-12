Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B54FD222
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 09:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351293AbiDLHKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 03:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245289AbiDLHJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:09:08 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C98949F08
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 23:49:33 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h14so25397012lfl.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 23:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAV9zD/9i3JbiiASrVcLIQyrbdWy7ico6dvybKeWvXs=;
        b=M/AHANmKGN/x+pUfTld06wGLxBZO8idhvqokFKh3BT7GGmJsUzvYs7TnI5abkdSjIW
         PMSxmtD12lJgdcdZ2OqdkCSLdMxu98RMRLkVkArQbM54XQ1sY2yeEjL+w00BVnLPR1SX
         sv1fHZETALyHeOuUK7+l+iTeLbFoU0iMZrz7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAV9zD/9i3JbiiASrVcLIQyrbdWy7ico6dvybKeWvXs=;
        b=kTw6NS9cV9a79lIdNNUs3IhjcCLLTi7SEoD5RYWEVY5EEp5XNVPNDXSja/wx/HzFhg
         pK/k7+n5HzN7I82fbXjx8Goyy0rP71ybussZJMMRVHbX4GGEdDxvOsAU6FMRSpQn0Vqx
         cdIi0cSbEapSz1g4E5PzRFbM6SrvO8mtkJWmSFgF/LYa+7DoFkhThzvVM5m/z4LiPxoE
         5ZKaqAyjx3RZXOEYuv+TWxUd/qPBRrWv8CXRUAFiwmxQIrvGA1UjwEMFXOx+Y4R8Meko
         L/R5vNxLFoOK0BWluQFyVZHUBB7D/lUwY25yRD/NZiw0NouSMD2Vv5OBbOxOqB6rwrNL
         er1Q==
X-Gm-Message-State: AOAM532quWeqWRJnZkwLth3MYMd4s7cNwxQv8Tclc2SKOvc9DCP82D7P
        yxBry5l2WO1g/41tAl43IwMbEcLnunAX5Rgb
X-Google-Smtp-Source: ABdhPJzRU7hf1DBzcDkI4NGbIpB2zj/C1m70gKkwHZVGL+xqyjpu54xFmTJvfPnpfiPiYN8ykHgdBg==
X-Received: by 2002:a05:6512:3193:b0:44a:b555:b724 with SMTP id i19-20020a056512319300b0044ab555b724mr24103614lfe.459.1649746171534;
        Mon, 11 Apr 2022 23:49:31 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id e29-20020a19691d000000b0045d5fdab903sm2407040lfc.126.2022.04.11.23.49.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 23:49:30 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id c15so22840836ljr.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 23:49:29 -0700 (PDT)
X-Received: by 2002:a2e:a549:0:b0:249:9ec3:f2b with SMTP id
 e9-20020a2ea549000000b002499ec30f2bmr22850127ljn.358.1649746169549; Mon, 11
 Apr 2022 23:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
 <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
In-Reply-To: <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Apr 2022 20:49:13 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjfLQdsjMBRQm=UB+RB08Cs6G41+kk2ybe7JHuu4ydhRQ@mail.gmail.com>
Message-ID: <CAHk-=wjfLQdsjMBRQm=UB+RB08Cs6G41+kk2ybe7JHuu4ydhRQ@mail.gmail.com>
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 7:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Correct. It's literally the compat structure that has no basis in reality.
>
> Or it might be some truly ancient thing, but I really don't think so.

I was intrigued, so I went back and checked.

        unsigned short st_dev;
        unsigned short __pad1;

is in fact historical. But it was changed to

        unsigned long  st_dev;

(for i386, so this is a 32-bit 'unsigned long') on April 2, 2003.

From the BK tree conversion:

    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=e95b2065677fe32512a597a79db94b77b90c968d

so I think we should just make sure that the 64-bit compat system call
is compatible with that 2003+ state, not with some truly ancient
state.

                      Linus
