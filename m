Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857A75EC774
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 17:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiI0PTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 11:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiI0PTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:19:50 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EB23D5B7
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 08:19:46 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c7so9673469pgt.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=ozwz/kr75NpC96tOUqziv2FbYDcS1Xg/Xc9JrcnYDIw=;
        b=aD4rrECu2ausOVlLE4gUsa1xeFXbzCDqhUSEM6rCLHK5rgBwyb5IlVpaAwSzAj9rFc
         8ss/JFQrnzUDOWJOgToiGQz3DbeSTLrRlmlivZobo7sNCVAPyZFjQXP4xDr73rtevCI5
         12CxpLpirpMPby3pdyIUMhC7x3a/7EJIzGNLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ozwz/kr75NpC96tOUqziv2FbYDcS1Xg/Xc9JrcnYDIw=;
        b=3J50+EQ4vvqcV9R3EsIkWfT7Tgc5Fn9oSW1mSpAe7k/dndf6KUuAGbEuMSgeDKeho9
         ofvwDJUteW9R1IQFHhOT4L4GWnNdHmo9M+LmnV6bbEwqPzZMavy+DlhMrDSUyHucGIXH
         +IzzyR8WvdKmZEQGpBzitpFD9xHNmD3QI4JY3HZ6QDxEx9nJ1mejhqc5llTzdUe0tauJ
         C5pordRFpiMPBmoZn+4M18XdXn8Vgw4oPrfipAm6FXyrlhxof8fNT2ZvuqKDjnsQ4FEq
         6/8cVRPimiAjWt+VDht/s5jgYY1rvnMV3kZX6wfFTmjhUN/bGHwdfSNa5tY0Z3tjpDXY
         O8Qg==
X-Gm-Message-State: ACrzQf3cXDo+EQ/AKOWZZVmJTs7Gkn1aDY1BYzUiFacsIatPDLEFRmaD
        Qqw0b+t+qG16R88RdTzgzMalQA==
X-Google-Smtp-Source: AMsMyM6u3m9PcqcUS16zstLBXfgnAsEawKfJRgbn2Z1VogzvRHBpOu67PA1zUb8r5rtEtpXZP+Nddw==
X-Received: by 2002:a63:8942:0:b0:43b:e87e:3fc0 with SMTP id v63-20020a638942000000b0043be87e3fc0mr25309584pgd.531.1664291986021;
        Tue, 27 Sep 2022 08:19:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i14-20020a636d0e000000b0043954df3162sm1653393pgc.10.2022.09.27.08.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:19:45 -0700 (PDT)
Date:   Tue, 27 Sep 2022 08:19:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Geert Stappers <stappers@stappers.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>
Subject: Re: [PATCH v10 27/27] MAINTAINERS: Rust
Message-ID: <202209270818.5BA5AA62@keescook>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-28-ojeda@kernel.org>
 <20220927141137.iovhhjufqdqcs6qn@gpm.stappers.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927141137.iovhhjufqdqcs6qn@gpm.stappers.nl>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 04:11:38PM +0200, Geert Stappers wrote:
> On Tue, Sep 27, 2022 at 03:14:58PM +0200, Miguel Ojeda wrote:
> > Miguel, Alex and Wedson will be maintaining the Rust support.
> >
> > Boqun, Gary and Björn will be reviewers.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> > Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > ---
> >  MAINTAINERS | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f5ca4aefd184..944dc265b64d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17758,6 +17758,24 @@ F:	include/rv/
> >  F:	kernel/trace/rv/
> >  F:	tools/verification/
> >
> > +RUST
> > +M:	Miguel Ojeda <ojeda@kernel.org>
> > +M:	Alex Gaynor <alex.gaynor@gmail.com>
> > +M:	Wedson Almeida Filho <wedsonaf@google.com>
> <screenshot from="response of a reply-to-all that I just did">
>   ** Address not found **
> 
>   Your message wasn't delivered to wedsonaf@google.com because the
>   address couldn't be found, or is unable to receive mail.
> 
>   Learn more here: https://support.google.com/mail/answer/6596
> 
>   The response was:
> 
>     The email account that you tried to reach does not exist. Please try
>     double-checking the recipient's email address for typos or unnecessary
>     spaces. Learn more at https://support.google.com/mail/answer/6596
> </screenshot>

Wedson, can you send (or Ack) the following patch? :)

diff --git a/.mailmap b/.mailmap
index d175777af078..3a7fe4ee56fb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -433,6 +433,7 @@ Vlad Dogaru <ddvlad@gmail.com> <vlad.dogaru@intel.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@parallels.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@virtuozzo.com>
 WeiXiong Liao <gmpy.liaowx@gmail.com> <liaoweixiong@allwinnertech.com>
+Wedson Almeida Filho <wedsonaf@gmail.com> <wedsonaf@google.com>
 Will Deacon <will@kernel.org> <will.deacon@arm.com>
 Wolfram Sang <wsa@kernel.org> <w.sang@pengutronix.de>
 Wolfram Sang <wsa@kernel.org> <wsa@the-dreams.de>

-- 
Kees Cook
