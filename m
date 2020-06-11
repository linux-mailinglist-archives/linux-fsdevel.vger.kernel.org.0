Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03E61F6403
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFKIxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 04:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgFKIxT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:53:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BBCC03E96F
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2020 01:53:18 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so5657707ejb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2020 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6YzEOPqcAv0sbK26shJvGGJXzsZ+OpMKrc0abKSWR0=;
        b=TBzc150dfWKawe8BTuBkPPTozsKZsW13AxTAF8tPW9cXFUJqUFuEa5RF7HszIbf9rB
         fB9mPqlTI5c2XdUV/n/UXdmEOuUM5XoORlcgERNJxNoAusS+PCfEjCONkQwviyzAVs9C
         r/pvUSCef31tAuGU5DF813cdKuxqPyD2Xh4Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6YzEOPqcAv0sbK26shJvGGJXzsZ+OpMKrc0abKSWR0=;
        b=gAU2umVRMUyH3yVBbbF1o6tUGU7Aje/z0MZJGCWBvJ8MB0MmJ2KQwuywZhojSfVn6w
         exZmwnmfI9Qud/e52/D1gUSHhKTwWxTKU3CxLNv/UHRDGStotN/M29w+WYRQOp8JBr57
         Vsmj30ip3cigg4b57x+fhmQaccoHEK2JMGSbP3UWNIvTY7RHBoBVoZD6qSC5v+Dfedtk
         bzkUos3Icy9VzWpHk0MWiAGgb0F4XM3lk7lpZoN2mgJ4PtdAdpSB1OGG7Ec2XGF+9rBG
         Z1c/7a2XSXzp5N+C7bDphDMxMOs02SO5PUuoLclAvmv9rMNOFQu7XIftu64AUX1VVndS
         oL7A==
X-Gm-Message-State: AOAM532xDqFDPmwQi0MRfEO5xYm7ircLU6KXmkf5RR1fBMA29UlfvwSs
        +1m6qWEx7NsXb06mDcIKYVDYdEF+bTPkElMR6RNW40D3Eos=
X-Google-Smtp-Source: ABdhPJzbz0dgjrx3Ryf1GkzUPVMK1FxHJgHkQb20bmx7PiB3XXmFC/bXI1cG5MQ3FJbtLc5npnihAjSRsxh4ZPYqkZE=
X-Received: by 2002:a17:906:4310:: with SMTP id j16mr7158212ejm.511.1591865597455;
 Thu, 11 Jun 2020 01:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <b762fcc4-1ddf-70c2-3189-544779186d3d@virtuozzo.com>
In-Reply-To: <b762fcc4-1ddf-70c2-3189-544779186d3d@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 11 Jun 2020 10:53:06 +0200
Message-ID: <CAJfpegtzdjFVPWZsW5ASn40Qn7muVuWwmGAii7XVcqigLU7ysQ@mail.gmail.com>
Subject: Re: [PATCH RFC] fuse: optimize writepages search
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 4:11 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Dear Miklos,
>
> This patch was originally developed for RHEL7-based
> Virtuozzo kernels and widely used few years
> but seems it was not submitted upstream.
> I've rebased it to v5.3, compiled but was not tested,
> just to get feedback and then update it.

Applied and  pulled by Linus.

Thanks,
Miklos
