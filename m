Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C591C5E2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgEEQ7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 12:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729720AbgEEQ7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 12:59:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C73FC061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 09:59:15 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so1951616lfb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtzYgCuKkt/bmV036ncd6lENxrdBs3w2AEjDTg4Jym8=;
        b=BvfMU4FkK4+TYSxq8r2HYJ1G6i+Kwe+It8iHrrdCrMNdjvKKRvhcIByeRqpEBOhvR2
         z1Rngg1akXbqNshURhLPyo3W/aYzamFcP368MXvOl5NWCPy2QD7LKh8VVBEx+hd6Yb06
         EFAluQBX7GxsusBdl6NXz6lGmArzuIOnv0zsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtzYgCuKkt/bmV036ncd6lENxrdBs3w2AEjDTg4Jym8=;
        b=BIayLUYIvxDKHKm3k2LA/Zs0hl0O8ePU4KJkDZYcO8Fygl9e+PZX75mqQKHzJJ+VD1
         ewrrCQhEAsjW/s3PpN4exwfQ0cOvaBDrogsSg6s10DBYLkN/ETuL9gBIROpIRp/NG82y
         /JkR2roq9R7NDL2eFQtP9rClHA7BI61PxUjfIVDvKqxR02UUB5KUi6pUHVB5UOu0vTcP
         fqCHFB7A1qoOmsooNKr565KVV3Hnf2pyAgE18+hEQwlj14O3FMBlYnfCoq1eCAVK9qYr
         zkrqLQkHXbMvivqbERwEU0U4yWBO/6xQB2Kp87gdPnIt0CBo4p18bhyP5tT2Y+L1kwB3
         8hMg==
X-Gm-Message-State: AGi0PuYrKEcatiKYxWRfsFSClqnY/skR0kGTpB/VEAJs4PdFxIwrcYUz
        NkPpTk2/eq/dNaNpSzV27Tb465zKrrA=
X-Google-Smtp-Source: APiQypLsaVTU295HCqgKWrAi8IThS/sE0y0gTqiuMrNs2OADGgRFyUEv9Hwv/9gs/FuNkRmkdXzb3Q==
X-Received: by 2002:ac2:5a1d:: with SMTP id q29mr2308302lfn.27.1588697953473;
        Tue, 05 May 2020 09:59:13 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u12sm2120811ljo.102.2020.05.05.09.59.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 09:59:12 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id b26so1955127lfa.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 09:59:12 -0700 (PDT)
X-Received: by 2002:a19:6e4e:: with SMTP id q14mr2226121lfk.192.1588697952227;
 Tue, 05 May 2020 09:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200505143028.1290686-1-arnd@arndb.de> <b287bb2f-28e2-7a41-e015-aa5a0cb3b5d7@embeddedor.com>
 <CAK8P3a0v-hK+Ury86-1D2_jfOFgR8ZTEFKVQZBWJq3dW=MuSzw@mail.gmail.com>
 <1f33eec3-4851-e423-2d04-e02da25e2e6e@embeddedor.com> <CAK8P3a3wd2DxnUFFOBCC_SVsZCGTYO3ZBU9amMtK_uR+kvQXFA@mail.gmail.com>
In-Reply-To: <CAK8P3a3wd2DxnUFFOBCC_SVsZCGTYO3ZBU9amMtK_uR+kvQXFA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 May 2020 09:58:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whv7ummbSN1H_jFxLJtZbCD4JKAbb3XRf9xFYK54T-=nw@mail.gmail.com>
Message-ID: <CAHk-=whv7ummbSN1H_jFxLJtZbCD4JKAbb3XRf9xFYK54T-=nw@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: avoid gcc-10 zero-length-bounds warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 5, 2020 at 8:24 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Linus, let me know if you would like me to Cc you on the other gcc-10
> warning fixes I have and possibly apply some directly.

Sure. If you have any of the "trivially correct, and doesn't make code
look worse", push them my way.

I only did the ones that looked trivial and fairly core - didn't want
to step on any driver toes etc.

                  Linus
