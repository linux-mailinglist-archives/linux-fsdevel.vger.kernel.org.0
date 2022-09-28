Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1805EDC75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 14:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiI1MWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 08:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1MWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:22:48 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E485A83;
        Wed, 28 Sep 2022 05:22:48 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e205so10005275iof.1;
        Wed, 28 Sep 2022 05:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+CftlzZKPWUN2sMz/9pukEyU4VBPKHGAq6MB8SWaK/0=;
        b=Ma+mmZRWMI3cY+2rtc2vD7UvUtG6FzcPx201Z6UpGUCyLi+RkY0iYsvORv0o8yfEeD
         2DAgSicf1WQChtVtofrVir/bg6zGOmpx3ezwoq+B3XuWzrLF26gmFuZ3vmiT2jBu2L2w
         wIEQdLkPCdJc+8xUGG+ITU4/dDC1Bpkkk6xIBpeMTmlPKu2+642XorDYvMn41eO68f/t
         YdfaJ/L1XjIc7jtCj6QMKYRPoYcuNRZ3wTYr6cHSekAMBvuxLidvMnbDynYJJRgayd14
         cVNHwVFYwQR5lgSJ3yog5eIjsMJ9wAl+YAH4Hr8tyDqovlr9Fxi5yKq5mF3Ln5KeWBJV
         n32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+CftlzZKPWUN2sMz/9pukEyU4VBPKHGAq6MB8SWaK/0=;
        b=yV6j05nqjmmuBnu7uCusGWuB7oKxw899wEi3z970xorREZ+b7WiavFOwc+JjMIpWBQ
         IcV8HB+yK78LeKnx8ggNtpYPjXuhwN7ha++LjPVT4Q+Smy7MdhH3e42lRd8dJgoYJKc3
         fdCi4vqS6Ci1YY1stU75WmV9n+uDQIVkFDhfDjQcR64GKT/ly4BrDKw7oxp+ljV+sah/
         YkpnuUYvtaY+w16UW7f01mhBzRtKtnO6J5PTbEcEu5oqWcl4K3g+UnQhcwHAGK8JwSNn
         8Qm5PHLKyrQT2jryxlP2EyvJRkTheCjaLYlCww3y09U96a1OTtgJ2xgT+bPLBpxvbw6S
         O+lQ==
X-Gm-Message-State: ACrzQf0NYhiNtlGFLPA6oaU00FsSVcsA+uAMBvuQrXo483kxrr67a7bA
        bmbP5t2+MZj13mO73nQHfuaR8CvSrOhUPoal3d4=
X-Google-Smtp-Source: AMsMyM53QVkbDVC1kqX3LZXbJyrpKPjUY231Eosv6bsOxvN6nIiJ9eZkEjhcIK3hKUatI4G6U3r0as4TEUXZrNcQSlw=
X-Received: by 2002:a05:6602:1509:b0:69b:35ba:4720 with SMTP id
 g9-20020a056602150900b0069b35ba4720mr14240802iow.155.1664367767433; Wed, 28
 Sep 2022 05:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-28-ojeda@kernel.org>
 <20220927141137.iovhhjufqdqcs6qn@gpm.stappers.nl> <202209270818.5BA5AA62@keescook>
 <YzMX91Kq6FzOL9g/@kroah.com> <CANiq72kyW-8Gzeex4UCMqQPCrYyPQni=8ZrRO1dQsUwDmAPedw@mail.gmail.com>
 <202209271710.6DD4B44C@keescook> <CANeycqo3O3yh2ms6vpHkzBLtT7QuCYWeweLq_z9SVygsot43YA@mail.gmail.com>
In-Reply-To: <CANeycqo3O3yh2ms6vpHkzBLtT7QuCYWeweLq_z9SVygsot43YA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 28 Sep 2022 14:22:36 +0200
Message-ID: <CANiq72nHZSsZD4_gxOJRio-i=WCoaLm5rGnQcdi36MLjxU7+WA@mail.gmail.com>
Subject: Re: [PATCH v10 27/27] MAINTAINERS: Rust
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Stappers <stappers@stappers.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Maciej Falkowski <maciej.falkowski9@gmail.com>
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

On Wed, Sep 28, 2022 at 1:57 PM Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> Our intent wasn't to have a known-invalid email in MAINTAINERS, it was
> just my mistake: after leaving Google I updated my email in a lot of
> places but missed this one. Apologies for that.

It was also mine for not realizing it! :)

> The patch below fixes this:

Thanks Wedson!

Kees and I discussed how to proceed earlier and so I updated a few
hours ago the branch collecting the tags we got so far and fixing your
email address in `MAINTAINERS`, so it is there in `rust-next` now:

    https://github.com/Rust-for-Linux/linux/blob/fd9517a1603f083dfa88f3cf9dc67d26f6ba0ec0/MAINTAINERS#L17764

Cheers,
Miguel
