Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23143AD47D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 23:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhFRVnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 17:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFRVnT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:43:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79B6C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 14:41:09 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r16so15862915ljk.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 14:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1r2JNcGiZYGEsYXKAn8qdNAkS9jkXxdkGrKjRmIacM0=;
        b=W9WgSMPNxsi6UNVwDFOvRq4okEhNaCNzDakMc0cvqSwcUVgvkkcz8ZcfCsH+hgFs5k
         M687Bx4DVFcOT3GjS/qoFgbSOFd1xSAEce+22UPK2itBj11GTffU3KUg8hTc6ns7oObl
         GTyi3Kk1pl2MJYCc42QRxWGeDH/y3b0qmQLpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1r2JNcGiZYGEsYXKAn8qdNAkS9jkXxdkGrKjRmIacM0=;
        b=YORvmSoeSipBXyBIucQJeNSs0Q50XTsKU0D5SAl3/EsAIWRESaV94TopUZYgL+Jr8u
         GIJUZn9qODEnUanMAIrznAJM4+cgoKqDbwQ8u8FMlZDkUfgkjypZgTAnfxKh4l+7I0iV
         v70xlb4/dhV6PGFERfEaDkx9lX9Q4TJsgrlb0KwZjHbdAovz6/iyRKekW9FUdp1rSL7y
         KVs68B6WMj2PCz1mPdRQil9+lw/8Hh1UfVefuuuLjlwWIwZAJIVmDsPsTDecqMdvWPv5
         qs2oLp2q4IwjZXykWBAis11fwodfQU1yyG1zQUH3khQ+ZrQ3q9SgMCzrZjWMKdUB/bxD
         HSew==
X-Gm-Message-State: AOAM533FFDOHC6/3OH1YqsrUpyVRQ/sNu0kVrPoQ7Fsu7QMfXJwQ5Vvx
        sKOhRi2jqNk2c+iiJkKPmCw+PNglFOy8jN2P
X-Google-Smtp-Source: ABdhPJyb5HiwVThYCy/cDCLqiJlnNvX6VM+ecsPhYetM+HXyImR/P9zB4SwauFnvr2TFcYgX8RPVFg==
X-Received: by 2002:a2e:9b10:: with SMTP id u16mr10962546lji.167.1624052467803;
        Fri, 18 Jun 2021 14:41:07 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id v21sm230701lfr.192.2021.06.18.14.41.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 14:41:07 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id k8so15764979lja.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 14:41:07 -0700 (PDT)
X-Received: by 2002:a2e:7a14:: with SMTP id v20mr10866300ljc.465.1624052467049;
 Fri, 18 Jun 2021 14:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623972518.git.osandov@fb.com> <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
 <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk> <YM0C2mZfTE0uz3dq@relinquished.localdomain>
 <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk> <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
 <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
In-Reply-To: <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jun 2021 14:40:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
Message-ID: <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 2:32 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Huh?  All corner cases are already taken care of by copy_from_iter{,_full}().
> What I'm proposing is to have the size as a field in 'encoded' and
> do this

Hmm. Making it part of the structure does make it easier (also for the
sending userspace side, that doesn't now have to create yet another
iov or copy the structure or whatever).

Except your code doesn't actually handle the "smaller than expected"
case correctly, since by the time it even checks for that, it will
possibly already have failed. So you actually had a bug there - you
can't use the "xyz_full()" version and get it right.

That's fixable.

So I guess I'd be ok with that version.

             Linus
