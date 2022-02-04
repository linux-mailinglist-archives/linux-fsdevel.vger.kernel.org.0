Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FF84A9E54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 18:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377166AbiBDRvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 12:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376981AbiBDRvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:51:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9362CC06173D
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Feb 2022 09:51:10 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d10so21600864eje.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Feb 2022 09:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4hiJqR1yEZtQsqmzLlZSfYU8B7IPxJQai2V7jYSZc4=;
        b=RcFLddjHA0EwraDsXQJEq58cJTr2gUXIr9LfLuW9F/h0ucvYyxLmquBUMGKrYcyOpg
         NgOZnAMU8LjKRuXzparft+8yKW1fLvguR3OCDmH/Axos054DyKeWO1ZHsTYpT3+ztQzS
         AnA0982jKYnR0SSr8xJr9VFHphFQNA+Ixj/mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4hiJqR1yEZtQsqmzLlZSfYU8B7IPxJQai2V7jYSZc4=;
        b=rMGwGusA3brrqIi6ZMccqYokz4MqBgFzGAL8vJuQqfjecs2P3yFfcav/Ad2AyoClwP
         C8BhSuSn8H7QQ92gP6Jjvp/zZ6TtvMvEEhHytXlp2j7oYCKd8I0a7A+f9BmoPgQd8f0k
         4lJFTt/TGaJBh7r+uh4EWN8HDHmV1+gL83RROCJCRnm0srJp8Hlnxq7P6DqYwt8kiZdC
         tqnpdvpmCRnGV4Jt73qMPN+EjsgqHjyDs7O7bQXWc8HjGoxf0/inYE/4RO1+6Tgjlhqo
         h6jEgtBA06ztFP12cS/eTLZoUZgDk6xH6a/aZgGiV+B14sjHPn72PNzq2pcmy2Us9Noy
         Gx0Q==
X-Gm-Message-State: AOAM5313KXfZJcsYzT6e9o1HUXm1E8L1xfGo1KAN9D27GmmG86L7C5WG
        d7Pu5lCcupxve3gXIhzKAT7mnykFSeZ3/STt
X-Google-Smtp-Source: ABdhPJx/iHnKfVKYlPbJl4KHN93hg0tWkMF0tRACE30hvnT0hd8yEr0UmbIvWIoyx3twmWVlD4vrXg==
X-Received: by 2002:a17:907:7289:: with SMTP id dt9mr54811ejc.62.1643997069049;
        Fri, 04 Feb 2022 09:51:09 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id i14sm1089509edr.100.2022.02.04.09.51.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 09:51:08 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id e8so12827736wrc.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Feb 2022 09:51:08 -0800 (PST)
X-Received: by 2002:adf:f90c:: with SMTP id b12mr7765wrr.97.1643997067773;
 Fri, 04 Feb 2022 09:51:07 -0800 (PST)
MIME-Version: 1.0
References: <20220130130651.712293-1-asmadeus@codewreck.org> <Yf0Fh7xIgJuoxuSB@codewreck.org>
In-Reply-To: <Yf0Fh7xIgJuoxuSB@codewreck.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Feb 2022 09:50:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgeEada1nT7yqc4SBKr9q9WeuBxDyJGZ9ebjP631ry81A@mail.gmail.com>
Message-ID: <CAHk-=wgeEada1nT7yqc4SBKr9q9WeuBxDyJGZ9ebjP631ry81A@mail.gmail.com>
Subject: Re: [GIT PULL] 9p for 5.17-rc3
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 4, 2022 at 2:53 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> I rarely send fixes out small things before rc1, for single patches do
> you have a preference between a pull request or just resending the patch
> again with you added to recipients after reviews?

Generally, pull requests are what I prefer, partly for the workflow,
partly for the signed tags, and partly because then the patch also
gets that same base commit that you tested on.

That said, despite all those reasons, it's a _very_ weak preference
when we're talking a single individual patch.

So if it's easier for you to just send a change as a patch, I still
very much apply individual patches too.

             Linus
