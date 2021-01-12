Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A6C2F272B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 05:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbhALEiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 23:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbhALEiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 23:38:08 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5A4C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 20:37:28 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i5so631217pgo.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 20:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rbilBSVbbXRhMniJ880rYaxIbYDyKirjuZYOZwkmcWA=;
        b=zvT18tdFpQ/pRdt6LlFHrPSrnVnGmGNGvUTAJ+9ubbkUbPvfMD+LxfzwLfjyDcoAyg
         FCKI/OAA08wU0Tw/qngcGX7S+6ehUOuZ5JnfNqEWveHjonwBxKP9i8Suwlx6tO2MvHV6
         /j1JVJyeLgmpF6uKgg+ElGJZtkAZ5km/x3sPtQvVP7C795boOKyeX459Xn7NDljjXXRK
         zAurjT5Z65+GM9HFJDBGYD0wM+IU/m++9SeqUVdkOtLeejFzbc6EjeCfjXY5d0mxrc55
         6j8DQpzzPp0ehMZ5c6zijGW4hAWxJbVv2hjf/l3bFLeXCtiJn74pwSAvm6ax0Wo60zl/
         1lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rbilBSVbbXRhMniJ880rYaxIbYDyKirjuZYOZwkmcWA=;
        b=YKQhocQoC18s9Ceej0FFhS0sx6z9lxoddeavnokqDb+d+WOBy6YLQVn4AqVdxcnXTT
         GNqkKixKJkyZ1/UKTsBuH81xe+VNqqSliUKk82gsb6AmqBrdC+B4HnDp+LTy9cOIUP0J
         87SisGC3wVnkygjeEzSZHkvA8Wayw/oyJgmTvu6iePsim7KEe5XzXpag5unNFRsH/h9P
         ssrONJeaZ1MdUxm4ECLhgoye7aeG95xsEG9pSq+Op/mKl/NCThMrnPjieQlqZG/bBz8D
         QTjGeOfde1RUOKt/XlCwymuWqP7tu/Ayby0y373ADA3E9OXsNyzdwbM2QOPUEsLccYN/
         acpA==
X-Gm-Message-State: AOAM531Lc0EO4z6gH9XGB60fW/JBHUFYOI86uQO3bJKHYCipLT0gQfnc
        uyVpmbxq0piesg+PfG/M3iFyKw==
X-Google-Smtp-Source: ABdhPJzqT038Q1NS6gUqh3U5M0rY1V8A6yUPOxIXzvLah9euNeTgLW5cROBqwrBWy95Ytl8MKEUOzw==
X-Received: by 2002:a05:6a00:10:b029:18b:2cde:d747 with SMTP id h16-20020a056a000010b029018b2cded747mr2812217pfk.60.1610426247395;
        Mon, 11 Jan 2021 20:37:27 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id j12sm1161108pjd.8.2021.01.11.20.37.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 20:37:26 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:07:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V1 resend] dcookies: Make dcookies depend on
 CONFIG_OPROFILE
Message-ID: <20210112043724.3pbpsmxn7yl65psk@vireshk-i7>
References: <fd68dae71cbc1df1bd4f8705732f53e292be8859.1610343153.git.viresh.kumar@linaro.org>
 <CAHk-=wi6ri9S7Nj1VZuA_pKOV3mEfH=-magLf_J_F=qhiFcKdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi6ri9S7Nj1VZuA_pKOV3mEfH=-magLf_J_F=qhiFcKdw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11-01-21, 11:28, Linus Torvalds wrote:
> On Sun, Jan 10, 2021 at 10:02 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The dcookies stuff is used only with OPROFILE and there is no need to
> > build it if CONFIG_OPROFILE isn't enabled. Build it depending on
> > CONFIG_OPROFILE instead of CONFIG_PROFILING.
> 
> Umm. I think we should remove CONFIG_OPROFILE entirely, and then
> dcookies as part of it.
> 
> We discussed removing CONFIG_OPROFILE for 5.9 (I htink) already - the
> oprofile user land tools don't use the kernel OPROFILE support any
> more, and haven't in a long time. User land has been converted to the
> perf interfaces.

Right, I followed that discussion but I wasn't sure if this patch will
go in first and then the later ones will follow. And since I couldn't
see a reply from Alexander for it, I thought it is best to resend it
to get merged first.

Okay, I will try to send some patches to get rid of OPROFILE and
dcookies now.

Thanks.

-- 
viresh
