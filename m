Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B452652B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 23:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgIJVW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 17:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgIJVW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:22:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7B9C061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 14:22:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id r7so10805182ejs.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N10c9+tEMvd+V1v5/kjFg7uIplbi+YryLR/t+QNnqsU=;
        b=Pmbtzx/w5PJRKpuyzWZgUthB5SqsFujhymQl5gJo8f6W3hvApNoms7SWH1Ie3t+Xhv
         G4BzucZpRgNaCDRkBPiUSWCjEuLpi8agAsdGI/QBUu92rYGZ8Pp3MkAt2a24+m/S5x3B
         6epqPgVItTvZ5dHCiaBsFReRRMDht3h8fKCaRGh1IkHnw2lateEx0y9mDjHKtpX8Y8Nz
         pj8E/O7vvbiRPAFHA3pzg1fCXA5Q5JExBVpXPTHZUF0gtsfus/hcwcxmf9RfgHDwtSxq
         1bx0ofN7Nm21fcXiPRlbKh/d5ruR2ePp3ji5Py5uWlztcfvuDu+7GtC29bjR7vEOzNWS
         NI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N10c9+tEMvd+V1v5/kjFg7uIplbi+YryLR/t+QNnqsU=;
        b=FWnfbHdvG6UW1ScxTJvIuC/uDbgrY+QT4/j/ldWfYTBBK6T2koZa5FOvSlcBx7jG4W
         FmHJ6m75OALFlGe5i2OlZnelZSFXGKCUqZJGXO/CzoLUEkPl/dZYoqauledikNu1TnD9
         0dOHW2Bevkcnu5RF1eee2TPaxUu6HK/mVFpGxhk/YskPyOy7drLghS3H66vge3L4BFuO
         2eWglqtr3bYBa7hb67h560GX20kR9fG4iVyHmpNIjhBfuBUrHZy5EJ9du/04RkGznBmh
         YoxQCRw3WkVK/pnEJUVAyKQ66LB54gt2ofGg+XomwdKoHVSh/6YzF7DAu6FYdeRp2lxc
         zdEQ==
X-Gm-Message-State: AOAM530jU5iffkq3/pSMQuuNQ9SQxjGQEJTlTvf1n/gNdbDsnk38cQ9N
        pRpIqhaD3BDotriaYZl1CeTytgDSNuxAIdTVHt7mQw==
X-Google-Smtp-Source: ABdhPJz1ZXFqvRU0UEmWsJMjbaIMk2L+dkrdUn+tEviQSYc6CnuQg/EudEOu/jzT2CS0AbLrfEZiZReKFnSsXFJuWYE=
X-Received: by 2002:a17:906:4088:: with SMTP id u8mr11408126ejj.184.1599772945031;
 Thu, 10 Sep 2020 14:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202107.3799376-1-keescook@chromium.org> <20200910202107.3799376-2-keescook@chromium.org>
In-Reply-To: <20200910202107.3799376-2-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 10 Sep 2020 23:21:58 +0200
Message-ID: <CAG48ez1V=oVczCCSuRaWX=bbN2cOi0Y9q48=e-Fuhg7mwMOi0A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] security/fbfam: Add a Kconfig to enable the fbfam feature
To:     Kees Cook <keescook@chromium.org>, John Wood <john.wood@gmx.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:21 PM Kees Cook <keescook@chromium.org> wrote:
> From: John Wood <john.wood@gmx.com>
>
> Add a menu entry under "Security options" to enable the "Fork brute
> force attack mitigation" feature.
[...]
> +config FBFAM

Please give this a more descriptive name than FBFAM. Some name where,
if a random kernel developer sees an "#ifdef" with that name in some
random piece of kernel code, they immediately have a rough idea for
what kind of feature this is.

Perhaps something like THROTTLE_FORK_CRASHES. Or something else that
is equally descriptive.

> +       bool "Fork brute force attack mitigation"
> +       default n

"default n" is superfluous and should AFAIK be omitted.

> +       help
> +         This is a user defense that detects any fork brute force attack
> +         based on the application's crashing rate. When this measure is
> +         triggered the fork system call is blocked.

This help text claims that the mitigation will block fork(), but patch
6/6 actually kills the process hierarchy.
