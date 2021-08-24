Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F753F6916
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 20:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhHXSa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 14:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhHXSa5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:30:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D285FC061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 11:30:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r9so47493426lfn.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RuBQdJhQ1k1gyx9+QD8pp0eKOEgTf/y6j0rnTy6eEF0=;
        b=iLUaCmCvcaQsgZ/dKvg6RUX7lHV/WT8/1PxEeDqy/vAPcYeCS7r+Pr6tK4IxraU2dl
         krfcqA8CKRp5ubWmjHoOcohuAYQRT9oOzzmTLAopWy8EXo3vZFoYz8OnEyo0zNHdXRhy
         x/q58ZSBblv/6UFk2LlKRLHs3UAIWUxkdGgqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RuBQdJhQ1k1gyx9+QD8pp0eKOEgTf/y6j0rnTy6eEF0=;
        b=fuE3c3l87gdDrPF1sZp2zUoqp2zGnbkW06sJReKS49sovVsFmxSY19UflcLXbvba78
         wldiEREKtxvesgwX/I9nFUQYzTv0epUuopUoFilPbgOShMpxA28w61gtdfy63rMPaHpX
         F/anLQQgOfBrTqjglMnZo+36zaGRUROu5EAL6v0DVRdZsjTxWTTKMT4udcH17nm+oBEf
         oYPV4G3qo4YGSnMH0OpVzB7yhjuJChN2gn5fDXR4oKaUJARWszwUe3bfIwaY8w7Jy58X
         IZ8BmnUrFfNxtSjfF+9MkrFTtC3UJqYFK0RydociNCJbFToCF6zIu3Q0XCHif7WCt7Ld
         fD5Q==
X-Gm-Message-State: AOAM532RuY5u/DAnCKgpmLFD3eyKwWtFJxQNJ0QQhqpW5E6uhB1o1ff/
        Pn4j82qlvE4keldr59/95jy696QCdUe0XfDg
X-Google-Smtp-Source: ABdhPJz+TTpAb4DQZVdMzmijYgsg6fN/EnDDhvYbSlcuqI24ikt6g8Dd57Z53C/hU9Ez1RShgUkjTg==
X-Received: by 2002:ac2:558e:: with SMTP id v14mr821332lfg.424.1629829811082;
        Tue, 24 Aug 2021 11:30:11 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id x16sm1818253lfa.244.2021.08.24.11.30.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 11:30:10 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id y6so39270709lje.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 11:30:09 -0700 (PDT)
X-Received: by 2002:a2e:3004:: with SMTP id w4mr30557535ljw.465.1629829809573;
 Tue, 24 Aug 2021 11:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
In-Reply-To: <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 11:29:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com>
Message-ID: <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:26 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If anything, I'd make things more explicit. Stupid and
> straightforward. Maybe just "struct head_page" or something like that.
> Name it by what it *is*, not by analogies.

Btw, just to clarify: I don't love "struct head_page" either. It looks
clunky. But at least something like that would be a _straightforward_
clunky name.

Something like just "struct pages" would be less clunky, would still
get the message across, but gets a bit too visually similar.

Naming is hard.

             Linus
