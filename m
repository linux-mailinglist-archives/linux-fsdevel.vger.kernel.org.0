Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805954DE7EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 13:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242924AbiCSMrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 08:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiCSMrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 08:47:15 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF8B43AC0;
        Sat, 19 Mar 2022 05:45:54 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id h205so4052651vke.4;
        Sat, 19 Mar 2022 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOMGYmaATQC2z13UyvSGmscWZ1Ke2cRO2FHb2Uve4+c=;
        b=H2shOi2EAOzGFJtpVsRsTpiG5Kz4xpnCa3MGNiZBROxxo3CUttZA+GU/rsDYwAnB8z
         dytXpQzdTt3qZlJJCf6+4+e/zIg4HUNUo5eEVZFdVdSHPyAkEnmAhgi5IGeQREuJ4NdB
         GN0OMABVxth+oNA2qGjhdsSQ3LkZ8/exdo3KKeH27krMSI8x60bBzqa9jyapIAJ/ylwR
         0+oLyV42aPGla/O4dXdBp3OIpJus/ouddIfD0m1sXnee8w6NoaZj4CjeFMgQWbeeyYK2
         P8odlP1/iGxLJJZut0uI/haoY9GlsG+XSrRj2Y4oxOueyu8z+0BbHVA4s1qFF+AoxZUJ
         D8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOMGYmaATQC2z13UyvSGmscWZ1Ke2cRO2FHb2Uve4+c=;
        b=lhp0UdiDqRwNWtf/2M06J+n1ygnURos6jWzo7sc5N0pUzhhvRPgXVvT4zrRLi5c3jp
         QSRumj1rej5seP35GfG3tne677z62aR8tRFKL8VvIbFeJj9Nbprk+00dmiZTx1oo/lc6
         59UWn6ZmAGKraluyCN3Z/muZFOD+z53/gli63AQ8P9R4xdG3emeUbmqAV6ZKVsBdCqye
         Vp25yFuUnmC7YXBqX5/bsCfcjKyw7DEpQ+osEOEd9eCppQ1BC36044ZLalgUUCKqwldw
         FMUpFaS+LX81uRGKk2UneHVZFASUhja1hmJPqZx4e1U8KbSHoomaEIyH7ZvdhCmBXp3r
         A0QQ==
X-Gm-Message-State: AOAM530NZf1N2VqrRcj25332kH7yGd/OQGCrmDRKtM+lLDeanwcjNd2l
        oGRlMGCZymXEm2FJiPzrp4hhvcMkAMAgSgLxNvkaztVJwGw=
X-Google-Smtp-Source: ABdhPJxjG9+XKDL2nuKi2W+QM9BrUWAJzSd68nq9Al1JVaNMnKFacS0NNJmC0amrXWYex35MjoU0mITjbMjNi5r5L3E=
X-Received: by 2002:a05:6122:8c8:b0:32a:7010:c581 with SMTP id
 8-20020a05612208c800b0032a7010c581mr5241750vkg.32.1647693953310; Sat, 19 Mar
 2022 05:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <751829.1647648125@warthog.procyon.org.uk>
In-Reply-To: <751829.1647648125@warthog.procyon.org.uk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Sat, 19 Mar 2022 13:46:25 +0100
Message-ID: <CAOi1vP_sEj7i8YbbwJibbSG=BCVp4E9BAo=JF0aC79xBNC8wcA@mail.gmail.com>
Subject: Re: Coordinating netfslib pull request with the ceph pull request
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Sat, Mar 19, 2022 at 1:02 AM David Howells <dhowells@redhat.com> wrote:
>
> Hi Ilya,
>
> Since my fscache-next branch[1] is dependent on patches in the ceph/master
> branch, I think I need to coordinate my netfslib pull request with your ceph
> pull request for the upcoming merge window.
>
> David
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-next
>

Hi David,

Given how your branch is structured, it sounds like the easiest would
be for you to send the netfslib pull request after I send the ceph pull
request.  Or do you have some tighter coordination in mind?

Thanks,

                Ilya
