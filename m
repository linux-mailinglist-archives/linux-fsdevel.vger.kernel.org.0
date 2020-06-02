Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC821EBB67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 14:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFBMQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgFBMQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:16:17 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A93C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2020 05:16:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s1so12309426ljo.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2020 05:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4Qy4wUhDH5Xhze+eb6ArM9+MXeHPXd6rx4E89Zh3o0=;
        b=Mf9BRQkSo6RI1cW7TTfXRtxfIGGr+OWwuRTQSEFJkxZdq4Vi6AF1nkBBgQ8oP/YhrF
         H0/nXoSFjW4KPwsL1kA2fb2AgZ89LpPodg7HdbKKDWIIsD3IvuEr+a0mtdy7kHzHROb0
         zm8QfBjLJ0rXB+3IaCAfH0tBnl4EatcsS1dapBK9iHchRPo70+L8M/VYAxHtQ1T6C/QR
         o0eOhLwXjLjdvhO0/2UDM1ZyLP59t9nLiZW//MtL2l2wIkRmM7+NuJ7ukJLTpvO64lhA
         2tSBsRSl57M8UnyJXUK7OBhuD09MGnodJIGo/dclKNC1CXJpmYRXCrC4M2K5J5O1lCT/
         C33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4Qy4wUhDH5Xhze+eb6ArM9+MXeHPXd6rx4E89Zh3o0=;
        b=VoJ+AIpzdXO1JKb1sGkxnDYZdpt6xLxURZp8eQgKogoU2w6yRNNI/vrGfoU1RE3bIm
         uwIwX9+N64bAyCB83S2ejkZd2HTaIjEzEbxlrpN/NpBcmJD3dQmbrMu1CTadMgPP4wcC
         m9uvrJZ96cOXVrcfGHzuyN8AS5CZi8eM1JHT27lY4lrd/pDoDIqDFHO/q52M3/v4Jyah
         XkkFZN5zitxInClEta9qtKLwUF4sdDnDQU2lpBkDNf0D/g/1WeGnf8cOJiGhIouHCmbj
         vHw2ombUdK06bkZJDlHKxlIn+hKlMXdtHIWk6BzoMWCgd5wpr9FYqYhUYuyp7C5dQk4f
         USCQ==
X-Gm-Message-State: AOAM531vfD9zlGOiednph4FewfkSyLMzqPJKFKsMCtZZC1rwaCSDWzIz
        Sns4Oxucso7vDCwhSCCNsvYXD4QBC03xOE59CYjX/Q==
X-Google-Smtp-Source: ABdhPJz/MQmaRwMBlZrBRQBj7nKunvfyDrbTxaAL2zsuQ89V/bYCS1lJwB4Isa1BAtyheXxEJF+wb59TAr/aT2U3gB0=
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr12906405ljj.43.1591100174869;
 Tue, 02 Jun 2020 05:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
 <20200522144100.GE14199@quack2.suse.cz> <CAB0TPYF+Nqd63Xf_JkuepSJV7CzndBw6_MUqcnjusy4ztX24hQ@mail.gmail.com>
 <20200522153615.GF14199@quack2.suse.cz> <CAB0TPYGJ6WkaKLoqQhsxa2FQ4s-jYKkDe1BDJ89CE_QUM_aBVw@mail.gmail.com>
 <20200525073140.GI14199@quack2.suse.cz> <CAB0TPYHVfkYyFYqp96-PfcP60PKRX6VqrfMHJPkG=UT2956EqQ@mail.gmail.com>
 <20200529152036.GA22885@quack2.suse.cz> <CAB0TPYFuT7Gp=8qBCGBKa3O0=hkUMTZsmhn3VqZuoKYM4bZOSw@mail.gmail.com>
 <20200601090931.GA3960@quack2.suse.cz>
In-Reply-To: <20200601090931.GA3960@quack2.suse.cz>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 2 Jun 2020 14:16:03 +0200
Message-ID: <CAB0TPYGCB+EUPOz61Hc6XpozN04N4Jro2FbkcTTYOOmDr-bUuA@mail.gmail.com>
Subject: Re: Writeback bug causing writeback stalls
To:     Jan Kara <jack@suse.cz>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, miklos@szeredi.hu, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 1, 2020 at 11:09 AM Jan Kara <jack@suse.cz> wrote:
> Thanks for testing! My test run has completed fine so I'll submit patches
> for review. But I'm curious what's causing the dips in throughput in your
> test...

It turned out to be unrelated to your patch. Sorry for the noise! We
have the patch in dogfood on some of our devices, and I will let you
know if we run into any issues. I'll also spend some more time
reviewing your patches and will respond to them later.

Thanks,
Martijn
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
