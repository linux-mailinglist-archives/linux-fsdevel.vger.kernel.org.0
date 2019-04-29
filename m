Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8BCCE2F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 14:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfD2Mng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 08:43:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36125 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbfD2Mng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:43:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id c35so11674690qtk.3;
        Mon, 29 Apr 2019 05:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqNvNUMJEdexVr3hF+SW8m4hwxFpjhomBgbdEJazb7w=;
        b=BvZGNr4O7y84o/2ymulQEFnat16DDwybdWGkXfSF1TQYh+AbVJpsl94S3WH3YmwIWt
         nZFtAXHZ1mCCYv2flh37L8WCW35RTcvCsBaljA/nl52Pc9qXPJjj1ovvLox/NmBcp8oX
         Klu3UxOpv4C4amRHRCHQKNVxNOUxq90XItKdAywso7rf829v5cIiI2/LMoDn6TpLK4ha
         CJpE6r9lRTQ6xFQL+sfreE/BmYM2j1GMzIAz+4XLdM0zH0mXDGONMTMT9UmdSZnhMU0m
         O4gA34ESDCBQa6HkD+piOQTjnWpm6gsE/MZ6yGb5OUlgOp1r5qIv/XF60NQQiisjdosp
         BMrw==
X-Gm-Message-State: APjAAAUsXfyYdyWwsy91jSUw5HdZtUkTc5VZAm8TyIe5Ih00Z5MhuQvD
        YbOTctobe8hZYCedRgXdoV5icK7qHfDPsI1o/Jc=
X-Google-Smtp-Source: APXvYqxN+jezyo2Yt09ge37OQJJuo/uOJcb8r6doEQ7wqS9DeRlWthXGnE4ncJ5t7cuNHdEH8H49xZyEeaQ6MnvohQM=
X-Received: by 2002:ac8:29cf:: with SMTP id 15mr8626476qtt.319.1556541815414;
 Mon, 29 Apr 2019 05:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190416202013.4034148-1-arnd@arndb.de> <20190416202839.248216-1-arnd@arndb.de>
 <s5hk1fthx9u.wl-tiwai@suse.de> <s5hv9yxjnp4.wl-tiwai@suse.de>
In-Reply-To: <s5hv9yxjnp4.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Apr 2019 14:43:18 +0200
Message-ID: <CAK8P3a1CbQsyTBykXkZv-35M_zQx97aOubtZD2YuzyPV94+4=w@mail.gmail.com>
Subject: Re: [PATCH v3 20/26] compat_ioctl: remove translation for sound ioctls
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Vinod Koul <vkoul@kernel.org>, linux-um@lists.infradead.org,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 9:05 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 17 Apr 2019 10:05:33 +0200, Takashi Iwai wrote:
> >
> > On Tue, 16 Apr 2019 22:28:05 +0200, Arnd Bergmann wrote:
> > > The compat_ioctl list contains one comment about SNDCTL_DSP_MAPINBUF and
> > > SNDCTL_DSP_MAPOUTBUF, which actually would need a translation handler
> > > if implemented. However, the native implementation just returns -EINVAL,
> > > so we don't care.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > This looks like a really nice cleanup.  Thanks!
> >
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
>
> Is this supposed to be taken via sound git tree, or would you apply
> over yours?  I'm fine in either way.

I was hoping that Al could pick up the entire series to avoid the merge
conflicts, but then we had some more discussion about the earlier
patches in the series and he did another version of those.

Al, what is your current plan for the compat-ioctl removal series?
Are you working on a combined series, or should I resend a
subset of my patches to you?

       Arnd
