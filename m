Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0732CC414
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 18:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgLBRnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 12:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730914AbgLBRnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:43:25 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AC2C061A04;
        Wed,  2 Dec 2020 09:42:10 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id 81so1079930ioc.13;
        Wed, 02 Dec 2020 09:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SU2667MQNtAIEDDUA9sQyXfNq/LH/Dr/dctHqxLpERE=;
        b=sgpyQzMIgWTsyfxgCY2mLTF757SetyFuKlcBRuQ/iwmBQP0Eu+a5mMkx+ekzkUxyTl
         bJFVWJ73+EIEcopDc1n61uRUC2vWcIrNyLkFr7sJCqa8+iGP0hewVw6AEBxrT7jUJYtH
         m7T/mJGeQnONBUxD4baolU62DMmvT4/pzdYnRuGos7FXiMmdGgsrAqxt27U75Zr2zvzN
         Jl9ZUMr3bWMUGldk1jbu8GjKjbCH6e9Km60hntvfuioSZsIzN5Hs0VvfxYI6X+HVpHKI
         2jRu6i2YSKjaBxg/cO7wvP5c6DBW5neoRZ8VsFTrE5Faq5ENdrciBk55YZCmalbzL303
         7zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SU2667MQNtAIEDDUA9sQyXfNq/LH/Dr/dctHqxLpERE=;
        b=ory+hh2dHEwR6LSgd0KLYDhF9Xyb770NEImLswpxkqwEnTdeE0SwGfADH9cqsN3Ci3
         g+BPEz9r4+BptcAjL7AaNoeYYmqEiMqKKDJNUKYnG8YbotLoGi3taqD3H/qeWquVh2ML
         pgEtFHJqfG5ryQfqCDNboFALIri+tzLpDShnLm5ywRJXGig4GdW8bURWyrE/7eYjWmlc
         wAyRFN7xIoIAKk/bCQLvtz3U05/N2jABb0rkltEmHONdzcAZb1AQ9iJCYCQGzluTheoU
         9ojSKEJEMvldfYgnqY8gXNy1YObDhbp5yaV2U9/ofeqvnbZGqFHNTSiyH6D3yj4PQixF
         kxVg==
X-Gm-Message-State: AOAM530SlpYUPPd8+TpO6omdE9TiVR/+/YVVxzVVLN3E719pdsIynqkZ
        kdcCGW3YzcyNE6C7+eNzBz4i2hwpvvkqbvZfBKg=
X-Google-Smtp-Source: ABdhPJzgVccBZ3lm0HQ6lozVeGujXueHHWGocCl1fhlxOmyBX611+HaOw+S0c+MsTD93Rrj1P2FQnG04P6iZ/HZIRlI=
X-Received: by 2002:a5d:964a:: with SMTP id d10mr2904208ios.5.1606930930065;
 Wed, 02 Dec 2020 09:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20201202092720.41522-1-sargun@sargun.me> <20201202150747.GB147783@redhat.com>
In-Reply-To: <20201202150747.GB147783@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 2 Dec 2020 19:41:59 +0200
Message-ID: <CAOQ4uxh0CuGGYYjV+H2MpqN+nmbmogGuYt70sOnE2rX+iw36kQ@mail.gmail.com>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error behaviour
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I asked this question in last email as well. errseq_sample() will return
> 0 if current error has not been seen yet. That means next time a sync
> call comes for volatile mount, it will return an error. But that's
> not what we want. When we mounted a volatile overlay, if there is an
> existing error (seen/unseen), we don't care. We only care if there
> is a new error after the volatile mount, right?
>
> I guess we will need another helper similar to errseq_smaple() which
> just returns existing value of errseq. And then we will have to
> do something about errseq_check() to not return an error if "since"
> and "eseq" differ only by "seen" bit.
>
> Otherwise in current form, volatile mount will always return error
> if upperdir has error and it has not been seen by anybody.
>
> How did you finally end up testing the error case. Want to simualate
> error aritificially and test it.
>

Good spotting!

Besides the specialized test for sync error,
I wonder if anybody ever tested "volatile" setup with xfstests or unionmount?

In xfsftest can set envvar OVERLAY_MOUNT_OPTIONS="-o volatile"

In unionmount I have a branch [1] with support for envvar
UNIONMOUNT_MNTOPTIONS.

I did not merge this change to master because nobody (but me) tested
it, so that would be a good opportunity (hint hint)

Thanks,
Amir.

[1] https://github.com/amir73il/unionmount-testsuite/commits/envvars
