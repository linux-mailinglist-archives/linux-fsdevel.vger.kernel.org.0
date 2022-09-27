Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14775EC7D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiI0PeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 11:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiI0PeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:34:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7671C5C81;
        Tue, 27 Sep 2022 08:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D6AA61A32;
        Tue, 27 Sep 2022 15:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2968FC433D6;
        Tue, 27 Sep 2022 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664292858;
        bh=2+4zgQfkieFPcHub7KcQFOTs+GhxkxbMDSCzrasoAoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hS0hnWVNwbQH8CMggx/FnG3TE+EQG1YDcvQNPw2F2zf4K0nZFL1Hai/4ugvIm/7wt
         mLY/enrJatJcNvQxPtJw+SypA0krsBZo2N0AweMIml+l7HTnkgJF+39vnJcVnF/qvD
         Yf4/RC8YRSfBnqebIF6GvB/pdYzMOCdWoZZS/hNA=
Date:   Tue, 27 Sep 2022 17:34:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Stappers <stappers@stappers.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>
Subject: Re: [PATCH v10 27/27] MAINTAINERS: Rust
Message-ID: <YzMX91Kq6FzOL9g/@kroah.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-28-ojeda@kernel.org>
 <20220927141137.iovhhjufqdqcs6qn@gpm.stappers.nl>
 <202209270818.5BA5AA62@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202209270818.5BA5AA62@keescook>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:19:44AM -0700, Kees Cook wrote:
> On Tue, Sep 27, 2022 at 04:11:38PM +0200, Geert Stappers wrote:
> > On Tue, Sep 27, 2022 at 03:14:58PM +0200, Miguel Ojeda wrote:
> > > Miguel, Alex and Wedson will be maintaining the Rust support.
> > >
> > > Boqun, Gary and Björn will be reviewers.
> > >
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> > > Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> > > Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> > > Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > ---
> > >  MAINTAINERS | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index f5ca4aefd184..944dc265b64d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -17758,6 +17758,24 @@ F:	include/rv/
> > >  F:	kernel/trace/rv/
> > >  F:	tools/verification/
> > >
> > > +RUST
> > > +M:	Miguel Ojeda <ojeda@kernel.org>
> > > +M:	Alex Gaynor <alex.gaynor@gmail.com>
> > > +M:	Wedson Almeida Filho <wedsonaf@google.com>
> > <screenshot from="response of a reply-to-all that I just did">
> >   ** Address not found **
> > 
> >   Your message wasn't delivered to wedsonaf@google.com because the
> >   address couldn't be found, or is unable to receive mail.
> > 
> >   Learn more here: https://support.google.com/mail/answer/6596
> > 
> >   The response was:
> > 
> >     The email account that you tried to reach does not exist. Please try
> >     double-checking the recipient's email address for typos or unnecessary
> >     spaces. Learn more at https://support.google.com/mail/answer/6596
> > </screenshot>
> 
> Wedson, can you send (or Ack) the following patch? :)
> 
> diff --git a/.mailmap b/.mailmap
> index d175777af078..3a7fe4ee56fb 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -433,6 +433,7 @@ Vlad Dogaru <ddvlad@gmail.com> <vlad.dogaru@intel.com>
>  Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@parallels.com>
>  Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@virtuozzo.com>
>  WeiXiong Liao <gmpy.liaowx@gmail.com> <liaoweixiong@allwinnertech.com>
> +Wedson Almeida Filho <wedsonaf@gmail.com> <wedsonaf@google.com>

How about just fixing up the emails in these patches, which will keep us
from having bouncing ones for those of us who do not use the .mailmap
file.

thanks,

greg k-h
