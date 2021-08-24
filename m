Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9228E3F6910
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 20:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhHXS1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 14:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhHXS1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:27:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521A8C061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 11:26:49 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l18so31678991lji.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qmh74cK/fKKYlnQIEMxmE3fRPyy9EeyGsyNOi20k3fE=;
        b=AuYIqRWW5Gcs2BY+Yzc+3uSi8UFsEH0E9t26aJ0dmGyJqmYDtfj6HiP8QlQBFwPNaD
         8C1tCdCACpYUF2UhKt+/W9chQfUpM2uKiQRD9nWlXkiuv5+1R5nSpj0kK4XsZMzHJqSg
         QKeP+49MEEsVl8cQ/juKRhOBxK3gTxq/V0btY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qmh74cK/fKKYlnQIEMxmE3fRPyy9EeyGsyNOi20k3fE=;
        b=tZLv/g24uRhUIOnlTG+cnLxSANfX4bVYNRq/AilP1emeglz3W5vYGCJOfQ1ilNMUpz
         +DLVaJyB9mk6J6Yoy6iP+CwnL5/zXFNlKATRAUvq8NyvgMZLkCnv2LRIMC7xuk3onjx6
         Ivb7pPH5oXG7kfd4guD2irPCdO8h379QKoYqyL/xZNlK25ES9gGe+YLxkjdv9vvpTJgH
         V+WMo8iyHxouVkeb+xdpxcJoZ1CcTYI6tuhbPP45TZLgsJB00XzCauXQYUUve/OQOvUP
         Oj572/FgguYEXR2V2ugZJwKDp710LLmUp45CS/Qdm2GDrIH3IDKzZQfHdnQPobeHRkEt
         UoLg==
X-Gm-Message-State: AOAM532oexMSjojZ+vuFDSiBhYxqn7KK4XbFaRp0C+op4FNR8F++7NFp
        BQ3E5MPSNza/9w35LiOkHEVyfHad/A2x09LC
X-Google-Smtp-Source: ABdhPJy0Z7mGO46j2rTZJhUXesl8Cj2vuwDTljIrQcMb25l2SJ1Kkx8WWClNCfz+LTjk0IqWlSL3iQ==
X-Received: by 2002:a2e:7a12:: with SMTP id v18mr7542226ljc.204.1629829607598;
        Tue, 24 Aug 2021 11:26:47 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id j13sm307068lfu.214.2021.08.24.11.26.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 11:26:47 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x27so47423800lfu.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 11:26:46 -0700 (PDT)
X-Received: by 2002:a05:6512:104b:: with SMTP id c11mr25943148lfb.201.1629829606492;
 Tue, 24 Aug 2021 11:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org>
In-Reply-To: <YSUy2WwO9cuokkW0@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 11:26:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
Message-ID: <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
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

On Tue, Aug 24, 2021 at 11:17 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> If the only thing standing between this patch and the merge is
> s/folio/ream/g,

I really don't think that helps. All the book-binding analogies are
only confusing.

If anything, I'd make things more explicit. Stupid and
straightforward. Maybe just "struct head_page" or something like that.
Name it by what it *is*, not by analogies.

None of this cute/clever stuff. I think making it obvious and
descriptive would be the much better approach, not some clever "book
binders call a collection of pages XYZ".

             Linus
