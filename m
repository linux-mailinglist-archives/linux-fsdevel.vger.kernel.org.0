Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F862E9CE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 19:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbhADSSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 13:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADSSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:18:09 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D26C061574
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jan 2021 10:17:29 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 23so66481240lfg.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Jan 2021 10:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nxs/g6TU6k+3ccAxWF3RmI3wwmsghsbxSfcyPJnj/yE=;
        b=aU3EveDTHVgrRuQoFlRYqzfsZL5PVBtqBHAghkzv90SxCacKkYgqK0oz8N2aFLuSWv
         o9YlFu+tAfUMqjhpA9cSRvWsPTjus8T+Og3w33OQsA3aR8vIGht1AH7jvtAP8kPvzaS/
         L86nkINnFDxWEccDGvypL8FSTXbiRq6Kack1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nxs/g6TU6k+3ccAxWF3RmI3wwmsghsbxSfcyPJnj/yE=;
        b=jHMNsDgvAopIwKnwRZnTKYjs8o5qdYJCJ1F37yv9XDGySgmjd7gG/gttHz9EYpMbJo
         vAem4OJsDRkuQ8NjbiJcqTMmvrBqfqi8EB/7WNFdlAjDIs7CDi/R1aRAXw33gEluUEoN
         ObqMv+KWLZlqKyOMdA4X/5F32l9BUumV60jGW1MDU+SItgv+SeKg0UsCH9ufUaBiWDzk
         +0+tn9QqYyNCozOE97skgAyDNBAeTvHgOgeJ0s344PuB+FN9tt9C26uhjJI1CuDpPm6D
         spMBL6UL0BVG/1E9WELZqC563Igp7ECiSwvfAzGHWkFwhFuBVDaXenQjRkqoQ1dHtR0U
         bqmA==
X-Gm-Message-State: AOAM530STAQr0LwMcdjpzc76hfk2FVJ9rM5Ckcl1JheZ3lLkgTDAoxR/
        xf0VXJOswUAR2n0XR3UGlG4HMnzh3WykVA==
X-Google-Smtp-Source: ABdhPJxJFE3Bow9rNGEJEdiWhsmFHH90I/N7hj3VeHKP+2abdNmflsYRdCyAX1haO/3OkzV2VorO2w==
X-Received: by 2002:a19:8210:: with SMTP id e16mr17778617lfd.69.1609784247426;
        Mon, 04 Jan 2021 10:17:27 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id s16sm8683876ljj.34.2021.01.04.10.17.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 10:17:26 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id h205so66548339lfd.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Jan 2021 10:17:26 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr34245988ljj.465.1609784245871;
 Mon, 04 Jan 2021 10:17:25 -0800 (PST)
MIME-Version: 1.0
References: <365031.1608567254@warthog.procyon.org.uk> <CAHk-=whRD1YakfPKE72htDBzTKA73x3aEwi44ngYFf4WCk+1kQ@mail.gmail.com>
 <257074.1609763562@warthog.procyon.org.uk>
In-Reply-To: <257074.1609763562@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Jan 2021 10:17:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFom7xhs5SHcWi1toxrBDwmyhBmVmGOqn9e3g6+bf5sw@mail.gmail.com>
Message-ID: <CAHk-=wjFom7xhs5SHcWi1toxrBDwmyhBmVmGOqn9e3g6+bf5sw@mail.gmail.com>
Subject: Re: [RFC][PATCH] afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=y
To:     David Howells <dhowells@redhat.com>
Cc:     Daniel Axtens <dja@axtens.net>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 4, 2021 at 4:32 AM David Howells <dhowells@redhat.com> wrote:
>
> How about the attached, then?  I

That looks like the right thing, but I didn't check how the name[]
array (or the overflow[] one) is actually used. But I assume you've
tested this.

Do you want me to apply the patch as-is, or will I be getting a pull
request with this (and the number-of-slots calculation thing you
mention in the commit message)?

               Linus
