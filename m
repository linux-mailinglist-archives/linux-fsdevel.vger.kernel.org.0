Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0121FF95ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 17:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfKLQpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 11:45:17 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39548 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLQpR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:45:17 -0500
Received: by mail-io1-f68.google.com with SMTP id k1so19456088ioj.6;
        Tue, 12 Nov 2019 08:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PobkGdQvYUHoqWoS3SPDAuh4l/MIV5b0WGjvMmrndiU=;
        b=iI/yGc/Tdnqjir5Ca3/F5FQb45PSQTVcgToixXaIkI3Uzh1+vXwgFXPHjnpeVtk4vN
         BWGRNT4b0kN6+d2DFLxL98kmhwcmh5M7V+TUdGLRow2XZOEAD9/VX6tqvoYhkBcUXKLg
         Op4DT6hjqb3bzsS9804lknY7nJ2O3GFuhMOz542Kk/gUuMnlnv5quu3qi41b20looD4X
         BlrWW9iV8TSsld2y8N5xOY9LodKiNKG0/8k4ps7D1+XuZ6r+YIT5568VwQZTL98W2Hjp
         0HpqeSENpG1GHMzgbK59qq6o33SJM6u+szS87OUTBAecu8IK43VJbbpuNNk6llzbb8r4
         uMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PobkGdQvYUHoqWoS3SPDAuh4l/MIV5b0WGjvMmrndiU=;
        b=MzUgYKhTNM+/ESinte6YHqb8CmLbGHU9/1a9q52zH1aosGSC0rnPUrDrfwFjSL7x9i
         ZXB6ruDQm7pfvvXo5ocTplJZtrbtqrsW6B+2Bh4KgZZhVHlw2QIItdsaLXvy8JdaqA7q
         kGL0w9DVFkvbpxS3p+tyhrMTH0kYLQuJ78zH2bUr2nqjdi28nhElWu3Bsx0O+K0uP0Gl
         AcU4/OyZD+IKToOyzvsCiSkND5j8Hlhoeq8JtlOf1E4LEDOiYCklYfUqKNX2Lzg+Qh7h
         h0pr/m6h3nbe2Ai6fTElHAkBL5U4VX/5HQLsJq4Qn6HohjYNi8lUOQ92Ow3ED3KYi4Yc
         PBNQ==
X-Gm-Message-State: APjAAAUree1TBLmhRTBTejE1l4fHG9GLgUvOoOG/4yUD5d8t9PlC5Ckw
        8mMYbht5tdplQOIBaP/crT351ATssFt/XcnojLuDyg==
X-Google-Smtp-Source: APXvYqxu+fKORcLQiO0ZD+mCPKm7rg5cIan4So75YiHJ5GgugQP7AbyPA9XtiXiL1L3LHIKCjaMACff5iBOsk1mKr74=
X-Received: by 2002:a6b:e403:: with SMTP id u3mr31742018iog.130.1573577116178;
 Tue, 12 Nov 2019 08:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20191111073000.2957-1-amir73il@gmail.com> <CAJfpegvASSszZoYOdX9dcffo0EUNGVe_b8RU3JTtn-tXr9O7eg@mail.gmail.com>
 <CAOQ4uxhMqYWYnXfXrzU7Qtv8xpR6k_tR9CFSo01NLZSvqBOxsw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhMqYWYnXfXrzU7Qtv8xpR6k_tR9CFSo01NLZSvqBOxsw@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 12 Nov 2019 08:45:04 -0800
Message-ID: <CABeXuvreoQkM1A3JBONtfD7uVLvC5MQ0hDRKX5rEQ_VUFGER8w@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix timestamp limits
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 8:06 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Nov 12, 2019 at 5:48 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Nov 11, 2019 at 8:30 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Overlayfs timestamp overflow limits should be inherrited from upper
> > > filesystem.
> > >
> > > The current behavior, when overlayfs is over an underlying filesystem
> > > that does not support post 2038 timestamps (e.g. xfs), is that overlayfs
> > > overflows post 2038 timestamps instead of clamping them.
> >
> > How?  Isn't the clamping supposed to happen in the underlying filesystem anyway?
> >
>
> Not sure if it is supposed to be it doesn't.
> It happens in do_utimes() -> utimes_common()

Clamping also happens as part of current_time(). If this is called on
an inode belonging to the upper fs, then the timestamps are clamped to
those limits.

-Deepa
