Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2901D89D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 23:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgERVOP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 17:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgERVOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 17:14:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3858EC05BD09
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 14:14:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nu7so412803pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iOTqBFjbUc15JVKUZQ3fGM2L6h0BsYo4USOrm5zOjvU=;
        b=QyJ2yabWgeLSe3uhlxGEGCdqXI7GGUQMHdHhZaMMgw/WkN7Ij2ODRj0KXr2ScfSqjB
         jy/FL1DUlvhZhUope/ZuuMXh4KneVfXf2MmI3mlhTREqRQ+7xz8aAy4xZmKt0svsG2Sa
         +2I9yrT7Ek3YJ30F1VDFRrtaLFmPpqUusgWm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iOTqBFjbUc15JVKUZQ3fGM2L6h0BsYo4USOrm5zOjvU=;
        b=OfckGDN7DrZbhl+/BefTc7rVHGvJR4VsMJtpcmOQVH8qVR3R6z+5C0AkWU6z+v1XJq
         5MndaNy4Rc2v2WXu2N/T+KpNClI844VMUHyhC6jqWOZgXiNvp/d+3JKr4T1cHhUv7Cjh
         /cqEh/fFPSfPhjE3sHSQ/yB9eZ0fhUsaHy9Rkq5y1HjIBWdeLgLxP4AqNZqirotFrnqP
         g9NN/8NwLNDahSAH8zIf2a61hk5KrXzqUOGO1E+G0LmeHgUmPuXCAsER4/mJ+InUoPj9
         tsZrKsvsWBaTvMcT/ZvioJiMnfbVm/10+DJgpE//Zztmk6tG0czAoK5ObGctq4aiqOD8
         RNig==
X-Gm-Message-State: AOAM533DY0GHiwNsS/YEPdLwyW/RtkgcYAPbPUqHfUYk2pyXTr7AVxvx
        VFeegV7EN5RLiE0zC7sQ7GbFLA==
X-Google-Smtp-Source: ABdhPJyhODLbzmuFhF6JGyvviQduFf54TxfdMAQHhQKoZO4RfjPkqc/t/GeGJicV4WkxDddupDqT0w==
X-Received: by 2002:a17:90a:8c83:: with SMTP id b3mr1395133pjo.141.1589836453742;
        Mon, 18 May 2020 14:14:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k4sm8280834pgg.88.2020.05.18.14.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 14:14:12 -0700 (PDT)
Date:   Mon, 18 May 2020 14:14:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Kitt <steve@sk2.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: const-ify ngroups_max
Message-ID: <202005181413.A9A985574@keescook>
References: <20200518155727.10514-1-steve@sk2.org>
 <202005180908.C016C44D2@keescook>
 <20200518172509.GM11244@42.do-not-panic.com>
 <202005181117.BB74974@keescook>
 <20200518183055.GN11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518183055.GN11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 06:30:55PM +0000, Luis Chamberlain wrote:
> On Mon, May 18, 2020 at 11:17:47AM -0700, Kees Cook wrote:
> > On Mon, May 18, 2020 at 05:25:09PM +0000, Luis Chamberlain wrote:
> > > On Mon, May 18, 2020 at 09:08:22AM -0700, Kees Cook wrote:
> > > > On Mon, May 18, 2020 at 05:57:27PM +0200, Stephen Kitt wrote:
> > > > > ngroups_max is a read-only sysctl entry, reflecting NGROUPS_MAX. Make
> > > > > it const, in the same way as cap_last_cap.
> > > > > 
> > > > > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > > > 
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > 
> > > Kees, since there is quite a bit of sysctl cleanup stuff going on and I
> > > have a fs sysctl kitchen cleanup, are you alright if I carry this in a
> > > tree and send this to Andrew once done? This would hopefully avoid
> > > merge conflicts between these patches.
> > > 
> > > I have to still re-spin my fs sysctl stuff, but will wait to do that
> > > once Xiaoming bases his series on linux-next.
> > 
> > Yeah, totally. I don't technically have a sysctl tree (I've always just
> > had akpm take stuff), so go for it. I'm just doing reviews. :)
> 
> Oh, I don't want a tree either, it was just that I can imagine these
> series can easily create conflcits, so I wanted to avoid that before
> passing them on to Andrew.

Yup, that's cool. I happily defer to you on these cleanups! :)

-- 
Kees Cook
