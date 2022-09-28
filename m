Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF385ED16B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 02:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiI1ALO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 20:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiI1ALM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:11:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B6BE5F8E
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 17:11:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id l65so11071391pfl.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 17:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cmG65wzSzYi7hGoMEWIbS7DJOTmuAIyWOhAjc3YjV1E=;
        b=IR9nlCDixIsx2l9q0CgkOLRjWV1HKwfjx15bUruXKYDFUn8QfudJ/Iidf2j07AkFDu
         jNKEm3M2aoaCKMpoJl22A0snrasLDfPtrOOs4nq312N5vA38vulXNSLJfgk+S3bnhpjb
         h0mzdAeKiuEvWzOC5Q+3gXZekcnd17C9gonKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cmG65wzSzYi7hGoMEWIbS7DJOTmuAIyWOhAjc3YjV1E=;
        b=zJQHhiJWhLZGWpslKNROQr4w9hnOIOHBSrvs87pSziGd2Gm8NBDAFlcwZg2zMtGxdb
         /4PDnqRmNRzviYWsJeaFFZYMj1Tc1SshG01h1/P+I5WPudC1eILNHeX3K+PKNXZN+rcv
         SxU1G/5wx2gk/kmHGs48l31qcAz5PvyrbHhCM1uhNuzWFqNcrOMmDFWdaNeCTKcCbvGX
         4t7wrISM2vYe4gjZe/DRVnqI6EZbMX8k2f2ez9XEMhs1Lxx6gb5qy1A7DMZ6UiS747EF
         P/1bAhf+3DLH+QZqVv4rN7wPmZPDcg1fsQc/fh0gqxEUVtY6CVf7qdp8aQKH+2MVlW9R
         B+kQ==
X-Gm-Message-State: ACrzQf0MfIzQIM9XOmoLgDfOw4ywHiG+mGqdZ1Lyda1ruHqHHyYh1JM9
        csmRuVSxbOx/afEIDY055hnnsw==
X-Google-Smtp-Source: AMsMyM7f8AEq6UNNkcKk2D+H3d700LQtj7Mzllr5njmtRSRmF0oa+61OoP8amL7HP96XJoW4l8dLkA==
X-Received: by 2002:a05:6a00:b8d:b0:545:e7de:78e5 with SMTP id g13-20020a056a000b8d00b00545e7de78e5mr31769320pfj.72.1664323870374;
        Tue, 27 Sep 2022 17:11:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b12-20020a63d80c000000b00422c003cf78sm2097646pgh.82.2022.09.27.17.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:11:09 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:11:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Stappers <stappers@stappers.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Maciej Falkowski <maciej.falkowski9@gmail.com>
Subject: Re: [PATCH v10 27/27] MAINTAINERS: Rust
Message-ID: <202209271710.6DD4B44C@keescook>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-28-ojeda@kernel.org>
 <20220927141137.iovhhjufqdqcs6qn@gpm.stappers.nl>
 <202209270818.5BA5AA62@keescook>
 <YzMX91Kq6FzOL9g/@kroah.com>
 <CANiq72kyW-8Gzeex4UCMqQPCrYyPQni=8ZrRO1dQsUwDmAPedw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kyW-8Gzeex4UCMqQPCrYyPQni=8ZrRO1dQsUwDmAPedw@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 05:53:12PM +0200, Miguel Ojeda wrote:
> On Tue, Sep 27, 2022 at 5:34 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > How about just fixing up the emails in these patches, which will keep us
> > from having bouncing ones for those of us who do not use the .mailmap
> > file.
> 
> Sorry about that...
> 
> One question: if somebody wants to keep the Signed-off-bys and/or Git
> authorship information using the old email for the patches (except the
> `MAINTAINERS` entry), is that OK? (e.g. maybe because they did most of
> the work in their previous company).

IMO, the S-o-b's should stand since they're historical, but fixing
MAINTAINERS to be up-to-date makes sense.

-- 
Kees Cook
