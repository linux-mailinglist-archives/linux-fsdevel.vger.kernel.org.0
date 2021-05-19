Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DE93884DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 04:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhESCla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 22:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbhESCl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 22:41:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66973C061760
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 19:40:07 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b12so6537427ljp.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 19:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtmNJLU/dhQ9ELu/k2h5VHa5Rzw2bCS2zmPu0hLax+8=;
        b=BVvY6dfBpTLG0lCmqHmrDJcT+SrZNvl2aUJRRzUMfSXvRfy+O8EXPnnwQahXMdao6o
         ADK4xqT8fNsbM2m33sQnw4i2uQ0JMU5+vr1tAi+7ZAg8S9HHsObzS/enEivmT4rgIsLZ
         ILiKKP3sz7olT1g3KLaQqtWqIyrwYxRu/fSqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtmNJLU/dhQ9ELu/k2h5VHa5Rzw2bCS2zmPu0hLax+8=;
        b=L2clrVVYp06Xul5nMX5v+pEZlcCjkcGLAZ0kVexWLZwqy4GM4TGg5UJ6uq2Y+4p31e
         cxGKL8/OB5vNQRfzSX1AFUvYnmvzCxLsg3Vi2+C0dg8aToJeQKKK4MxpC4KcY9G4RHr2
         lT+0UswZTEn1bzhD9HBLIRrIJLmWahASa5oUXpChBdipiOvnFOglGogJOqo34pwcCcAs
         bcRMBZ5v2VzKC9I6J168wT9N+r4Hv9LlpJVOZXV1MzT8Axehz/9Wy5uKw5Orgu8jJlWK
         5dnMpZI6GBg/YMpPuLOFDS8vRZ6bMFZRMRTpVqmRnRFaEESwiezHfVwjy1X4nU9I7cQz
         xh/w==
X-Gm-Message-State: AOAM533Pxj9QjOmXKG9UE5ezkmlFX2Wh99Cg+wvwZkh0aHB/U+N0xZaw
        YI/KqKUbef307c0rb6uJH7ARHlznqduMQPjprxA=
X-Google-Smtp-Source: ABdhPJy8/Q8WhLjt9ZN1RSNjQQGiIODVdiV3fFnWV2VLGB8HwkZU5jfuiZtoCH5P9tE9jwrxcfENLQ==
X-Received: by 2002:a2e:5347:: with SMTP id t7mr6586278ljd.464.1621392005623;
        Tue, 18 May 2021 19:40:05 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id s2sm3547513ljo.14.2021.05.18.19.40.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 19:40:05 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id e11so13731640ljn.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 19:40:05 -0700 (PDT)
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr6863723ljq.220.1621391994583;
 Tue, 18 May 2021 19:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk> <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
 <CAHk-=wiOPkSm-01yZzamTvX2RPdJ0784+uWa0OMK-at+3XDd0g@mail.gmail.com>
 <YJdIx6iiU9YwnQYz@zeniv-ca.linux.org.uk> <CAHk-=wih_O+0xG4QbLw-3XJ71Yh43_SFm3gp9swj8knzXoceZQ@mail.gmail.com>
 <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
In-Reply-To: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 May 2021 16:39:38 -1000
X-Gmail-Original-Message-ID: <CAHk-=whJkHMtf4RYiE3PLTEo8fM_vU6BG43TNJLbHsGYPsSJfQ@mail.gmail.com>
Message-ID: <CAHk-=whJkHMtf4RYiE3PLTEo8fM_vU6BG43TNJLbHsGYPsSJfQ@mail.gmail.com>
Subject: Re: [PATCHSET] d_path cleanups
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 18, 2021 at 2:44 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Here's what I've got for carve-up of cleanups.

Thanks, these all look logical to me.

I only read through the individual patches, I didn't test or check the
end result, but it all looked like good sane cleanups.

              Linus
