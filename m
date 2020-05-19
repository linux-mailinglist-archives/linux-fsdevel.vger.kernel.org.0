Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512711D9F7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 20:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgESS2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 14:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbgESS2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 14:28:36 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9064C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 11:28:35 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a9so350591lfb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAQPJr9ukcoBKjOXNq0ngI2FbToix/GR1U4DwPpfSy0=;
        b=JjHp/TA1wdi209GQDxk83iIpqXnffl3eJS5MEEAgukuWcKDbwj37gts7DFLkHruGuU
         nuDn1vvGhdSeq273vqMgVsMiaMP4nc1F6Pk64YouAMejNS/pKU4WwKHY+HH7P561hq9G
         XIbucUyW2ftN8EdLLtxsWXuyZC+00nekrisfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAQPJr9ukcoBKjOXNq0ngI2FbToix/GR1U4DwPpfSy0=;
        b=HyQ6RRbBjkvnSaFlyXykVuocU6lcRDYzcM9Oabltm0Qhgst1wt9fnjJ460lJ3nkj8+
         WMCXvtvyoamnef9LUJR/voWVwKnspryrn0yANAIuBTpRwln4ogOAmnKo459dCwWniKSI
         oWzBzWHIyBbXar8Y+NTyyP8Uq68GB2KMkqcOR8gOh6n9RLzEA9pE5SDkj/yNrUb9tHbO
         ctLCgijezQVlhzY6OLIWrIC1dGTgsNufDg167KO6DoWWIlhe/aGP9RWZytnD8KI8qJD4
         23AXH8wWhWg7F7mT8QUliUOO/hcwiZGTwweQ01vyHaxRB3yZbQTsjnDyvULt5c0qD/Mj
         CjEg==
X-Gm-Message-State: AOAM531oZGlucDboIuUedh7bUSO9viApA+L1ABquYRkWSogWApcZlZcO
        1mTqMy07gO6NcUOdXFLLmMdvZ9yaa0g=
X-Google-Smtp-Source: ABdhPJwQctWklkGPyZwvWrLG2TqQ6+6fkfDJhv+Gbiyj/N/8rU4b3y4zviuQGFiYvOv8ET8Dqh5ZXg==
X-Received: by 2002:ac2:5473:: with SMTP id e19mr130007lfn.21.1589912913220;
        Tue, 19 May 2020 11:28:33 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 6sm215494lju.54.2020.05.19.11.28.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 11:28:31 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id c21so375186lfb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 11:28:30 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr156726lfn.10.1589912910469;
 Tue, 19 May 2020 11:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <871rng22dm.fsf_-_@x220.int.ebiederm.org> <202005191101.1D420E03@keescook>
In-Reply-To: <202005191101.1D420E03@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 11:28:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeoeh-F-PJmpYRpR_HoiB4r4qYgd3U6igtrUD6q5d_cg@mail.gmail.com>
Message-ID: <CAHk-=wjeoeh-F-PJmpYRpR_HoiB4r4qYgd3U6igtrUD6q5d_cg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] exec: Teach prepare_exec_creds how exec treats
 uids & gids
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 11:03 AM Kees Cook <keescook@chromium.org> wrote:
>
> One question, though: why add this, since the repeat calling of the caps
> LSM hook will do this?

I assume it's for the "preserve_creds" case where we don't even end up
setting creds at all.

Yeah, at some point we'll hit a bprm handler that doesn't set
'preserve_creds', and it all does get set in the end, but that's not
statically all that obvious.

I think it makes sense to initialize as much as possible from the
generic code, and rely as little as possible on what the binfmt
handlers end up actually doing.

              Linus
