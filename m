Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C3E3C630C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 20:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhGLTAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbhGLTAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:00:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B11C0613DD
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 11:58:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b26so12946556lfo.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6GsSMYaQI588Ffnw4CVBQ3sZ6gvGzoY3yVC41+xYYto=;
        b=WaihP7jKxzYCMxQCcBtDaK9LmZeQKKvPkG1ySyIo4LNPgwjRqAFy7a5dztQR5tpjJW
         YkETbz91Hcae6AiCzUcs4RkrgDln8zvMEF3keoZqq8wekngRzxIpRwji7vR9b7EZtHpU
         ttvfKt8Tq2Mkm5tGIfvw2FFs73bO9TNxQBXaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GsSMYaQI588Ffnw4CVBQ3sZ6gvGzoY3yVC41+xYYto=;
        b=g1xoWbqbRHjaMcJW0OEJnFLQDCpX3+15zeZmxIjKlt+uftu+7dXfqKUv9so4Napxk1
         aS8uLTqvwLsjRbbuONrtGFBuXNY6wfit8VE1MzmI6ZHtlLJUn5YO8Z9KrM9qDmZcgP5z
         MsP3kv8SmUMFJO7q6cQWISTk1HgGBMXWECg+BQBcpu4XtvTt6LWHmVcjzTgRgwOnJcFj
         Idb3Xnn5pxDkbGEbklBTSydceOEMaN3gvbRKKlApWXvtmh1Tw63C5K9WRjBX9+7cf2nf
         g6DB6s0YOTuDt80llzcfN6CxoeL414s4kauEM2pFYIKfASr2j5qhJ1cK9r9M6phwcbIi
         GJqQ==
X-Gm-Message-State: AOAM531kZdHBIGeVGS6S0RMA+sK4WAJedpSdaik8buKWmCQZQr8VpsZ9
        AMFzTHPAqXCt5ssZ5Va78NymYW+cR7QvDWTv
X-Google-Smtp-Source: ABdhPJyd0cVoPhC7zCZipkojLiBr0goTlPWu2ArefOHbWDmcFS18O6IOj8TzP1CZSnflXJhXJkMiNQ==
X-Received: by 2002:a05:6512:3baa:: with SMTP id g42mr179255lfv.142.1626116283329;
        Mon, 12 Jul 2021 11:58:03 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id s8sm1638623ljp.35.2021.07.12.11.58.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 11:58:02 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id f30so45332217lfj.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 11:58:02 -0700 (PDT)
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr163067lfl.41.1626116282616;
 Mon, 12 Jul 2021 11:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210712123649.1102392-1-dkadashev@gmail.com> <20210712123649.1102392-7-dkadashev@gmail.com>
In-Reply-To: <20210712123649.1102392-7-dkadashev@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jul 2021 11:57:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiE_JVny73KRZ6wuhL_5U0RRSmAw678_Cnkh3OHM8C7Jg@mail.gmail.com>
Message-ID: <CAHk-=wiE_JVny73KRZ6wuhL_5U0RRSmAw678_Cnkh3OHM8C7Jg@mail.gmail.com>
Subject: Re: [PATCH 6/7] namei: clean up do_linkat retry logic
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 5:37 AM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>
> Moving the main logic to a helper function makes the whole thing much
> easier to follow.

Ok, this has the same thing as the previous patches had.

I see why the old code tried to avoid the repeat of some tests, but
honestly, that "retry_estale()" might as well be marked "unlikely()",
and we might as well do the test again if it triggers.

That said, in this case we actually end up doing other things too in
"do_linkat()", so I guess it could go either way.

              Linus
