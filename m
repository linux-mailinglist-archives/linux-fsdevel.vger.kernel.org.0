Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A9F33469D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 19:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhCJSWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 13:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhCJSWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:22:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4344BC061763;
        Wed, 10 Mar 2021 10:22:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id f12so24418111wrx.8;
        Wed, 10 Mar 2021 10:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0tu0NOYXG5WtYq99GHSm2YwfcjxiU16vCremGU2p31M=;
        b=msrZbGOkD2Isy+rMP3gosek7d/5Ozb7lUf27/4sF5bbF9OwqLjnXD0NvLnjwMd/ghv
         9HVXvBjT45hF7YiYoasLftHXnZPmv0SV+EvbivID+JhdhpkS2DufWMq4q6qqhpQ0ihIT
         RGCCX0kPp22eCEK1WFaDQmMfxHPy2qILrEfeUT0T5dITOC//FpPbZyNVvogUxBeAB6xF
         if1AtuLYu4dCU8yH8jS170JhOqCD2GdswACelTdmvMEMQeHJRRo5sKPLfsRRAOBMdYMq
         SYTy4vtq25z2Pa1womKzSP6m/2dPpnO7B/i1iAjg00oe6mKjCSJ8BcjDe8Cz1TrphyDi
         BIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0tu0NOYXG5WtYq99GHSm2YwfcjxiU16vCremGU2p31M=;
        b=Q/m9ihpNBO2LZFpK7LyRQQ7ORvG/MoRECBrq2CiTLG07ov/hr6yXsWTmetFwebGHpi
         lZTOAGUFhtec9YDUhBe+JX+Y9tq/KCF0qSgcS6Y+JlM3Fnw/jJEPgzzqdPKAcEzS94XC
         OPQpEXGHwSuOg3F+RDj3db+xPyKxvntM04k02tUjb82kovcUrhm/EFNIVDNBHb84tJrW
         zl1UaJcMdbC98x3eGwjllyIwfJdqU5zuWfKbIziC9vx72EHBn0iV6gWrZ75q0EKAdafb
         0hZ2fBoHzhqMZf6SImvFVbaDRvYVSdFFIdpe24/3uOaNdgdQlUXtpyyhRW6ubZvom20/
         lMlw==
X-Gm-Message-State: AOAM531sXT5Ky3ooHxXzw3MhgyaILsgTbkl/8T9MqnbKe0O0a/8yI+mq
        uJpiVUfm5so4v4RLoGvgmuOOfowHkED0+w==
X-Google-Smtp-Source: ABdhPJxG/1k3ueSD/MuHuHMA0j8g6uldaZDdS3GEXdoHvNRqrkyPTnGtbP855tMpG7EUzMg6EsCcMw==
X-Received: by 2002:a05:6000:1546:: with SMTP id 6mr4810464wry.398.1615400554048;
        Wed, 10 Mar 2021 10:22:34 -0800 (PST)
Received: from example.org (ip-94-113-225-162.net.upcbroadband.cz. [94.113.225.162])
        by smtp.gmail.com with ESMTPSA id m132sm223239wmf.45.2021.03.10.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 10:22:33 -0800 (PST)
Date:   Wed, 10 Mar 2021 19:22:29 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RESEND PATCH v4 0/3] proc: Relax check of mount visibility
Message-ID: <20210310182229.dynrgsxejnfkp3f2@example.org>
References: <cover.1613550081.git.gladkov.alexey@gmail.com>
 <m1zgzwm7iv.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1zgzwm7iv.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 22, 2021 at 09:44:40AM -0600, Eric W. Biederman wrote:
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> 
> > If only the dynamic part of procfs is mounted (subset=pid), then there is no
> > need to check if procfs is fully visible to the user in the new user
> > namespace.
> 
> 
> A couple of things.
> 
> 1) Allowing the mount should come in the last patch.  So we don't have a
> bisect hazard.
> 
> 2) We should document that we still require a mount of proc to match on
> atime and readonly mount attributes.

Ok. I will try to do it in v5.

> 3) If we can find a way to safely not require a previous mount of proc
> this will be much more valuable.

True, but for now I have no idea how to do it. I would prefer to move in
small steps.

-- 
Rgrds, legion

