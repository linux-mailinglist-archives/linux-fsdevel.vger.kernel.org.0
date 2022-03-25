Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51EF4E6F07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 08:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354302AbiCYHkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 03:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354245AbiCYHkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:40:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC14C43C
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 00:38:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id p15so13648509ejc.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 00:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DiHXaOQKxgjJgR8FzYG0VW2c/gysd7B3sO8yEiSnp68=;
        b=j/OgKK9a/MpEwVPN4u69s2eJczNmOvkwscW8bzCVLv78HmxdsYX7X7jbHgtIgF97A9
         w57W9Nljd7jQu9hzHcGLDWE8og4lj+XVi0qHG/fp9jPhDz5mm207hoF8E8P3gn08pXhe
         4km1s2r9wfPR5Q7ppia5Ln5rCg8bE/uRCMwaIggJYROS5AQjHfiCYS5WGlCFdsxs4O1G
         4uCi/ExPkuaMETF3CBI1NkdFb2NSxifMqmcS3Y6FmReticDT6U5pacPflu0g49lHYcKG
         rnFFtWjBNl28t20j6DPoxATK1WMLb6Jxl2DJ2NwUMFGy++UW5p7MKPb4Ub8rtZBoqSBN
         jKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DiHXaOQKxgjJgR8FzYG0VW2c/gysd7B3sO8yEiSnp68=;
        b=QrNR43K6cbgp8J9OiI30SDQWHESv+GIjnSqOqPA5rBjZp+GJrLcfhZseZtpMu3s0E9
         w6Mhkd+apFT8mGYepzOC8/W+2nmcZwWASD7vnuHepWZ3QlPgjpaP2ks+lfwXTrNiz4fE
         /fn1XA7FU5EMulcv2SZEpgkZmOtqhMoZjAz1J5o9jksmiSHgLLEhwQK78B5euBZaYnPX
         biNLSr5dk6o8D43DCuxl7wWLZMUHet9Rd5m8qFzem6n7yKRWQOVjYmV16ghC2t/KrOsC
         H4cE3/CYeEh1dqgy+HQ5noqlKQXd4WfR0j+LmA3xoyx8irJPjdJ5J9/0vcR2R2nuzZvS
         6lUw==
X-Gm-Message-State: AOAM5312+DbmRztbbEzGNiEBOYjkm5KG8GbkAzHDNohgpKsnMA91rP8X
        4LflWfh2pSGEK9LD6cCyLtm4g3apSQB77UUTXz8=
X-Google-Smtp-Source: ABdhPJx/ZG6wSCbB1Yy/ImTT5JyWZnjoGJMZCccUQdUNol+H6ual7pZBJzX4EMORUrrfeWGs4ZsVKLmi04PGgCR40V4=
X-Received: by 2002:a17:907:7849:b0:6d5:87bd:5602 with SMTP id
 lb9-20020a170907784900b006d587bd5602mr9999030ejc.349.1648193920270; Fri, 25
 Mar 2022 00:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220321095814.175891-1-cccheng@synology.com> <20220321095814.175891-2-cccheng@synology.com>
 <87lex2e91h.fsf@mail.parknet.co.jp> <CAHuHWtkvt4wOdwaoyYv0B4862pSYttMBh6BUz3vHbERv+CEGaw@mail.gmail.com>
 <87sfr917hr.fsf@mail.parknet.co.jp> <CAHuHWtk1-AdKoa-SBOb=sJAM=32reVzcUQYjrrxvOPYwFZJqXQ@mail.gmail.com>
 <87o81x0wdv.fsf@mail.parknet.co.jp>
In-Reply-To: <87o81x0wdv.fsf@mail.parknet.co.jp>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Fri, 25 Mar 2022 15:38:29 +0800
Message-ID: <CAHuHWtm5qdJm0wmjMbauRERg4hJYv7EWTtA6-0n9Ss9p=OtOqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fat: introduce creation time
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, kernel@cccheng.net
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

On Wed, Mar 23, 2022 at 6:57 PM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> No, a user can change the ctime to arbitrary time, and after the your
> patch, the changed ctime only hold on a memory inode. So a user sees
> ctime jump backward and forward when a memory inode is expired. (Of
> course, this happens just by "cp -a" in real world use case.)
>
> I'm pointing about this introduced new behavior by your patch.
>

As you mentioned, there are still some cases to consider that ctime
isn't identical to mtime. If so, ctime won't be consistent after
inode is expired because it will be filled with the value of on-disk
mtime, which is weird and confusing.

To solve the issue, I propose to keep ctime and mtime always the same
in memory. If you agree with this approach, I'll send a v2 patch for
it.

Thanks.
