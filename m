Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53B62A4F8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 20:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgKCTBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 14:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgKCTB2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:01:28 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40D2C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 11:01:28 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id b2so16964924ots.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7Le6+jXIquweVZrF16b1g0MpbTKlNPrAdUJtxzuros=;
        b=HR/fXnM0ViFZdMfgIg8m/Y2AaVUbBqgR3Nanp7YgrJppVNG6a1UsV3YZEIbmf5k3oO
         qP/RYmOdCyoOgqytqJ0g7f8RzXKjvVC1K+aFeCG7sdupPgv9SEpi9Wm34zmV9yA1cNti
         fJaInuGc+2fTEs0IqJ1ce88EIHiWYgXEQXxyUS1AunBEyETv8sO4GEzUZwujz8BokLo/
         kpKR4Cd4B3TSiGGkd8RZSXAn+3Xv7/gXFZYaMO0H/FPbVDFZpbh12IVowKFzTL8cf0Op
         I+zyEZRfqLbvGBIZvB6O5CtRWkYsiTF3yPNkc7fF7SapfWJ3/XvmTCFISrLTVhIhZOiY
         sJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7Le6+jXIquweVZrF16b1g0MpbTKlNPrAdUJtxzuros=;
        b=NWA9HwTvmdTot0yhR4tS6sDHaaIDvOsC0h72juTmMhZQAl8IiTqtksO9OkZA+EpfnW
         sNCxYV5BFCmd5fqmKiwiktCGUpIspEWhTls7cBcXTwK1PcUw7xkfU2YUnk+4Aua6SnlL
         zcAfYxdSvmULqXsTXjbkAWEJcEUsHuVGEFCcl0wts6WuNyTrCvHIsqufei+L+t3K1fQd
         mzj/Rj+3Svgdw1PrbfMnOLU0MRs1bpQSZjljbfeU8GhJ0KbBv5dMcvicChNGFHzXQLGH
         s1484IRS9FjsXClcsle15KjugiyrSuGzg3xllabj2I4rYu3vogVlyj9HCRAEj+SFtUf8
         CCyA==
X-Gm-Message-State: AOAM532WXinKWkKV/KLOu+hv2Yi7PUwNksHtXY8WCdMZsvGyD2eCq9nO
        i/hZibnUactkYdccvMyuHMYV3tuCjAilNjrYJhE=
X-Google-Smtp-Source: ABdhPJyy0qkOhwMT3rvzU9a9BcOpMvo92Z4xcLXlzO6EWBl1WoeB+1fzsnL+kMTppcVzQq8ubzgPfsqjsZjTlVgYaOo=
X-Received: by 2002:a9d:1b2:: with SMTP id e47mr11065615ote.45.1604430088117;
 Tue, 03 Nov 2020 11:01:28 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT6Q2-fC5Zo-dmjt9FJEt6ADmy1rijYX41aBmWwtO6Dp6Q@mail.gmail.com>
 <20201103153005.GB27442@casper.infradead.org> <CAE1WUT43_MT3p0B5S6sE9hcXQENGidDvQiWk31OKZH39jE8U7g@mail.gmail.com>
 <CAE1WUT7OChDF8iGnZ5kdXPeBbesFmHpu8Cqw3h3EeNY1otWT0Q@mail.gmail.com> <20201103185717.GE27442@casper.infradead.org>
In-Reply-To: <20201103185717.GE27442@casper.infradead.org>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 11:01:16 -0800
Message-ID: <CAE1WUT45SLDA_G8WcHC7R1udHDLL9G2bjP9tcZT7otQmAz=W+g@mail.gmail.com>
Subject: Re: befs: TODO needs updating
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 3, 2020 at 10:57 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 03, 2020 at 08:20:33AM -0800, Amy Parker wrote:
> > Luis's email appears to be broken right now. The mailer daemon
> > indicated an error on its end:
> >
> > > <luis@other.computer> (expanded from <luisbg@kernel.org>): unable to look up
> > >     host other.computer: Name or service not known
> >
> > Is this occurring for you as well?
>
> Yes; I've found someone who has a current address for Luis and suggested
> that they update their address on kernel.org.

Alright, great! Let's hope this gets resolved soon. Do you have this
address to CC him
on in the meantime?
