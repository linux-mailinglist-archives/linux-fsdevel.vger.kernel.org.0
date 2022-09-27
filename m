Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AB55ECBF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 20:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiI0SPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 14:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiI0SO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:14:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA52F01E
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 11:14:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w20so9778754ply.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5CuhhpeecEhFdVDSwRfaaOshrTQhumle+WnVfsH8uAc=;
        b=D/tH1vduer9H5obsSHE4yCo6yQWyA5TAhekIWEghiTHEcuEU9ewwEUNQu2GsKZ1P5p
         oqXAVQDlkQsjEGzShYp3ADqa8qKhZnksOk7kjfN3W/NNnCDvOBLLmumlwASkvgn/tQfP
         pBqWt9bGicUOu1jiaI/FzYbQfqxgLVcpwj20s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5CuhhpeecEhFdVDSwRfaaOshrTQhumle+WnVfsH8uAc=;
        b=cOtk07lN2JfpbJZStnXDLtkJ9x5JSRHByCs5lU1pFEMM9dUoGIdDR7qXL/86LeNY/H
         DJMZ2qNypt54Uvg93QIiUQdPE/RFU5ISeokp1dYOaaue4Ofgw8B5l92R6O+HFlOCRWLy
         v62QLyGS3R/tqqK3E5UfVK4AnQBLY16xURNc2PhURNAc79Dt0a2CjIGSpZyHZ88pztSl
         lsDcT+0cXHeqoMxN3B4twIH8eORFamUdBnXgyPr+fxDkvsNKQjmjUc+zLGzkHelE1jC7
         MBdai4Zy9GSIFJhEF0SjN1HoO0xfamagPBotVnPQ083cDB3rxXztUnND0sDyF/tjel+G
         8I9Q==
X-Gm-Message-State: ACrzQf2G6I7jlLjcyHdXYWFVbu2DWP+5cCCx22aYhCQKJx15VqbNx011
        2V37iZO984h/fpQYH+ImP0X+KQ==
X-Google-Smtp-Source: AMsMyM5TmfTMGY9fR9CRAZVMmMunxbQdVXBknN1A9cjgrBKgnMu5b8X3YjRsJVIVx6XfA1AVPxyaIw==
X-Received: by 2002:a17:902:e2d3:b0:179:fe90:55bf with SMTP id l19-20020a170902e2d300b00179fe9055bfmr882904plc.161.1664302495744;
        Tue, 27 Sep 2022 11:14:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b001641b2d61d4sm1893164plg.30.2022.09.27.11.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 11:14:55 -0700 (PDT)
Date:   Tue, 27 Sep 2022 11:14:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Message-ID: <202209271111.689A2873@keescook>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-28-ojeda@kernel.org>
 <20220927141137.iovhhjufqdqcs6qn@gpm.stappers.nl>
 <202209270818.5BA5AA62@keescook>
 <YzMX91Kq6FzOL9g/@kroah.com>
 <CANiq72kyW-8Gzeex4UCMqQPCrYyPQni=8ZrRO1dQsUwDmAPedw@mail.gmail.com>
 <YzMnP73tv1PIGsu0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzMnP73tv1PIGsu0@kroah.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 06:39:27PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 27, 2022 at 05:53:12PM +0200, Miguel Ojeda wrote:
> > On Tue, Sep 27, 2022 at 5:34 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > How about just fixing up the emails in these patches, which will keep us
> > > from having bouncing ones for those of us who do not use the .mailmap
> > > file.
> > 
> > Sorry about that...
> > 
> > One question: if somebody wants to keep the Signed-off-bys and/or Git
> > authorship information using the old email for the patches (except the
> > `MAINTAINERS` entry), is that OK? (e.g. maybe because they did most of
> > the work in their previous company).
> 
> For known-broken emails, it's a pain as later on invocations of
> scripts/get_maintainer.pl will use those emails.

FWIW, get_maintainer.pl does use .mailmap by default already.

> So please just use known-good addresses to start with.

Sure, that makes sense here too. I just sent the .mailmap patch because
Wedson does have other patches in the kernel too, so it wasn't just for
this case.

-- 
Kees Cook
