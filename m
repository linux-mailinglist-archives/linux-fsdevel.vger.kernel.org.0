Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3712D5EC9B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 18:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiI0Qjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 12:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiI0Qjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:39:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475787666;
        Tue, 27 Sep 2022 09:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F0FCB81C67;
        Tue, 27 Sep 2022 16:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C81C433C1;
        Tue, 27 Sep 2022 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664296770;
        bh=wz23PfcTdTIdqAQl5thzO7BMBPxbOwN3lceMYMw1jGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bc/NPChR9D3eBwwGJpE3ZRtNdGteeMsXkL64KjWJZosFQ5qn4i65kQoXNKI8hlrIL
         VN1bGzhMK9Cj/4x9FO8IqKrBsp8TkF1mlg5NbHInmb0sU6bm+W7MsaJ4wZNyDuH/Cv
         gR/VSO9yFRYuvkig2uGk+mNj9D3nbm8092BNJ4y4=
Date:   Tue, 27 Sep 2022 18:39:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
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
Message-ID: <YzMnP73tv1PIGsu0@kroah.com>
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
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

For known-broken emails, it's a pain as later on invocations of
scripts/get_maintainer.pl will use those emails.

So please just use known-good addresses to start with.

thanks,

greg k-h
