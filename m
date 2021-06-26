Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0409C3B4FB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jun 2021 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFZREp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Jun 2021 13:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFZREo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Jun 2021 13:04:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E2BC061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jun 2021 10:02:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i13so22237825lfc.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jun 2021 10:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ctIXdUKpJejkVwrHGwaovBS1OaqH6yohK5/qSMXJwIM=;
        b=bbCgi7VG5oVF2e5aiEuOc+fpffvOAvOaKnjYr/Dn+R0NuFDbpZTBQyopLUkaVkvO/o
         vUiPEv0+luwtBDUQ6VcHTrH7AmllBMvlf2yTIVgKRSHnnVd7henLah2eXyF/eKO9Eg8z
         j63JuUbhdqI6bMlcL/BxcH3ShOQ/QtCFGIkj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ctIXdUKpJejkVwrHGwaovBS1OaqH6yohK5/qSMXJwIM=;
        b=TjC8rv9SFhm91Ub9M20yhA4NavQGoA5CLOTC2yG7fj6/5udImizlAaG6P3mqf0XWYX
         j8IbYWqjXEQSEnH8BoQy46iTYncZGmJiVe5jWxjxTnHDA3mQbeLzpjZoRTJDwzV5O763
         7iqk/Bq2LrMGhq8ZwEKHZFNJmyHCr1eezQuoZotb4dYfAf+Lp1KJ00KC7hp18Rx07WBk
         YrVZB3/ALh9Up4P4bKEhaOhhuo5X23qxLHvNHW5xPhxOJnr7HObKxlfcXjaAGapCpxSI
         zRY4J9mj8cP+OAqG65UboO1RXniDxFjqZfBbCxXX1lpZc6FlYO8TvhK4rnYBNoubtpjj
         FeWw==
X-Gm-Message-State: AOAM533klNCYPvQb8ULYlywMAWzpiaXdahQzz7Q/3phjeW8iPcPQ1Dqk
        wEKHcOt21m2P/cDuga5x5nC3IfZMVOYEPEOW
X-Google-Smtp-Source: ABdhPJw9qBweKRhpmAy3aX3GYzHsDNPizt+tnqwywpyqOuP1wQcvtsjK7RMqy+QEKfRJDYVl7HjPkw==
X-Received: by 2002:a05:6512:3f92:: with SMTP id x18mr12347771lfa.369.1624726939014;
        Sat, 26 Jun 2021 10:02:19 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t24sm941189ljj.97.2021.06.26.10.02.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jun 2021 10:02:18 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id f13so17263073ljp.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jun 2021 10:02:18 -0700 (PDT)
X-Received: by 2002:a2e:2201:: with SMTP id i1mr5233250lji.61.1624726938027;
 Sat, 26 Jun 2021 10:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAOg9mSR9CM-DV1eqL58HM+m_6fbwgU7KFs3Sab0=A7BOvqoPYQ@mail.gmail.com>
In-Reply-To: <CAOg9mSR9CM-DV1eqL58HM+m_6fbwgU7KFs3Sab0=A7BOvqoPYQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Jun 2021 10:02:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgL3d6iZz5s=pCQAx+tz8BMPFUNp8dMmBtGqYCUKg50uQ@mail.gmail.com>
Message-ID: <CAHk-=wgL3d6iZz5s=pCQAx+tz8BMPFUNp8dMmBtGqYCUKg50uQ@mail.gmail.com>
Subject: Re: [GIT PULL] orangefs: an adjustment and a fix...
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 26, 2021 at 7:14 AM Mike Marshall <hubcap@omnibond.com> wrote:
>
> If it is not too late for these... the readahead adjustment
> was suggested by Matthew Wilcox and looks like how I should
> have written it in the first place...

It wasn't too late - I pulled these.

And then I un-pulled them. You removed all the uses of "file", but
left the variable, so it all warns about

  fs/orangefs/inode.c: In function =E2=80=98orangefs_readahead=E2=80=99:
  fs/orangefs/inode.c:252:22: warning: unused variable =E2=80=98file=E2=80=
=99
[-Wunused-variable]
    252 |         struct file *file =3D rac->file;
        |                      ^~~~

so clearly this has gotten absolutely zero testing.

           Linus
