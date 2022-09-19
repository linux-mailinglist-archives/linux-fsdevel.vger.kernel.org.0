Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80A35BD780
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 00:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiISWfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 18:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiISWfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:35:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB8C5005C;
        Mon, 19 Sep 2022 15:35:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n8so533534wmr.5;
        Mon, 19 Sep 2022 15:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jSHn4dypHtKElF3lnr9P4KEF/pRmmk/7yw3YSx+0bpY=;
        b=RFjSdbmy21QGzdrDMTqenolUsRAcAjRsw69oTj2bD1gedcPkRWyLcpZjw6CT6UvAWh
         WYIWrGjJrRaQ+c9RJka4vDgbp2eJ8PmMd/Md12OQPQ40iNcE+jHuW+yAyXSC4K+n+CaE
         AKGrtBme1gdLE5gghf5k9HEYefNfSv1S8va1mUcqLmbnZYdb/4MW9kUK3yXhNJvshPrv
         DeK+fraDMfAKDp60vo5y/XqiPnnGM/0jAl7lRleJ5EQof60FFbJMJy9qpTvr+ivLdrtl
         IiawHoxLaxhRyClRxhWOOovYb8LdOGG4dGGuS7nCMJriNnBorEFxs2un2R3gMZ7UBbBr
         38bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jSHn4dypHtKElF3lnr9P4KEF/pRmmk/7yw3YSx+0bpY=;
        b=QhWGTw4CtPlQJVJhddvaTJ6iplRurMMe0i+hmFDkb5YsIQRf4dM+rTSfhMNhWcrE01
         OgPCM8gFVJbZHNcr7CFc5zzFM/1Fkh2y+MsrJfCktPlplowQWBsOX8lLHtL8OvT6Dy3Y
         KjJOjirQx3Rd0qjPeLIvT7T1MzRR5QwPQax417mXZCci1Kx9BROb43pHjSnSjcl7iphU
         PltTIUIXRAz6CSQqQKcBIxDUIWK6hD79VKX64+KuV1MAIg2RU6GSKBIUWkn+ofra71Mw
         NOzaoaul7oSylh7QiBITto4ZoO6Zgeelxki/pjR6q54L6D96zLlmF3KB8OGbypfS7slS
         +x8w==
X-Gm-Message-State: ACrzQf1MJiF36HaS1y5wLlIylq3D01mTUWeZAdRmsp+QbHMPtZdsXGQ+
        BSPYoiCVrXI/7QnETsLF48Y=
X-Google-Smtp-Source: AMsMyM7l+zi50m08SqGU2M58bPPALO4MgAlrDU6dma3vPsHf3f827jKIxq+BFUzENICBjQVKWkm6JA==
X-Received: by 2002:a1c:38c1:0:b0:3b4:a8c8:2558 with SMTP id f184-20020a1c38c1000000b003b4a8c82558mr269059wma.82.1663626939515;
        Mon, 19 Sep 2022 15:35:39 -0700 (PDT)
Received: from wedsonaf-dev ([81.2.152.129])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b003b477532e66sm26150025wmg.2.2022.09.19.15.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 15:35:38 -0700 (PDT)
Date:   Mon, 19 Sep 2022 23:35:35 +0100
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>, ojeda@kernel.org,
        alex.gaynor@gmail.com, ark.email@gmail.com,
        bjorn3_gh@protonmail.com, bobo1239@web.de, bonifaido@gmail.com,
        boqun.feng@gmail.com, davidgow@google.com, dev@niklasmohrin.de,
        dsosnowski@dsosnowski.pl, foxhlchen@gmail.com, gary@garyguo.net,
        geofft@ldpreload.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, john.m.baublitz@gmail.com,
        leseulartichaut@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, m.falkowski@samsung.com,
        me@kloenk.de, milan@mdaverde.com, mjmouse9999@gmail.com,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        thesven73@gmail.com, viktor@v-gar.de,
        Andreas Hindborg <andreas.hindborg@wdc.com>
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
Message-ID: <Yyjut3MHooCwzHRc@wedsonaf-dev>
References: <20220805154231.31257-13-ojeda@kernel.org>
 <Yu5Bex9zU6KJpcEm@yadro.com>
 <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
 <Yu6BXwtPZwYPIDT6@casper.infradead.org>
 <Yyh3kFUvt2aMh4nq@wedsonaf-dev>
 <CAHk-=wgaBaVaK2K=N05fwWSSLM6YJx=yLmP4f7j6d6o=nCAtdw@mail.gmail.com>
 <CAHk-=whTDbFZKB4KJ6=74hoLcerTm3JuN3PV8G6ktcz+Xm1qew@mail.gmail.com>
 <YyivY6WIl/ahZQqy@wedsonaf-dev>
 <CAHk-=whm5Ujw-yroDPZWRsHK76XxZWF1E9806jNOicVTcQC6jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whm5Ujw-yroDPZWRsHK76XxZWF1E9806jNOicVTcQC6jw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 01:42:44PM -0700, Linus Torvalds wrote:
> On Mon, Sep 19, 2022 at 11:05 AM Wedson Almeida Filho
> <wedsonaf@gmail.com> wrote:
> >
> > As you know, we're trying to guarantee the absence of undefined
> > behaviour for code written in Rust. And the context is _really_
> > important, so important that leaving it up to comments isn't enough.
> 
> You need to realize that
> 
>  (a) reality trumps fantasy
> 
>  (b) kernel needs trump any Rust needs
> 
> And the *reality* is that there are no absolute guarantees.  Ever. The
> "Rust is safe" is not some kind of absolute guarantee of code safety.
> Never has been. Anybody who believes that should probably re-take
> their kindergarten year, and stop believing in the Easter bunny and
> Santa Claus.
> 
> Even "safe" rust code in user space will do things like panic when
> things go wrong (overflows, allocation failures, etc). If you don't
> realize that that is NOT some kind of true safely, I don't know what
> to say.

No one is talking about absolute safety guarantees. I am talking about
specific ones that Rust makes: these are well-documented and formally
defined.

> Not completing the operation at all, is *not* really any better than
> getting the wrong answer, it's only more debuggable.
>
> In the kernel, "panic and stop" is not an option (it's actively worse
> than even the wrong answer, since it's really not debugable), so the
> kernel version of "panic" is "WARN_ON_ONCE()" and continue with the
> wrong answer.
> 
> So this is something that I really *need* the Rust people to
> understand. That whole reality of "safe" not being some absolute
> thing, and the reality that the kernel side *requires* slightly
> different rules than user space traditionally does.
> 
> > I don't care as much about allocation flags as I do about sleeping in an
> > rcu read-side critical region. When CONFIG_PREEMPT=n, if some CPU makes
> > the mistake of sleeping between rcu_read_lock()/rcu_read_unlock(), RCU
> > will take that as a quiescent state, which may cause unsuspecting code
> > waiting for a grace period to wake up too early and potentially free
> > memory that is still in use, which is obviously undefined behaviour.
> 
> So?
> 
> You had a bug. Shit happens. We have a lot of debugging tools that
> will give you a *HUGE* warning when said shit happens, including
> sending automated reports to the distro maker. And then you fix the
> bug.
> 
> Think of that "debugging tools give a huge warning" as being the
> equivalent of std::panic in standard rust. Yes, the kernel will
> continue (unless you have panic-on-warn set), because the kernel
> *MUST* continue in order for that "report to upstream" to have a
> chance of happening.
> 
> So it's technically a veryu different implementation from std:panic,
> but you should basically see it as exactly that: a *technical*
> difference, not a conceptual one. The rules for how the kernel deals
> with bugs is just different, because we don't have core-files and
> debuggers in the general case.
> 
> (And yes, you can have a kernel debugger, and you can just have the
> WARN_ON_ONCE trigger the debugger, but think of all those billions of
> devices that are in normal users hands).
> 
> And yes, in certain configurations, even those warnings will be turned
> off because the state tracking isn't done. Again, that's just reality.
> You don't need to use those configurations yourself if you don't like
> them, but that does *NOT* mean that you get to say "nobody else gets
> to use those configurations either".
> 
> Deal with it.

While I disagree with some of what you write, the point is taken.

But I won't give up on Rust guarantees just yet, I'll try to find
ergonomic ways to enforce them at compile time.

Thanks,
-Wedson
