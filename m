Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5EB203C9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgFVQcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgFVQcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:32:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C644DC061795
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 09:32:20 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z9so20032977ljh.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TV9vbk2srZd0i6ieR89D2XCZp2Oy3hSU0itcsj4ofg8=;
        b=JPzybZthSg1toEDZXkxqiJgE55OU7mI6WORVXw3g2Mm8e2WJXoZLGP8rDgvvkpas8y
         jaiRzJb5zTdTyXw75RB0rvpiAteBIkkg2rm8Xc4VriNk+N95AD443ACer69TnOeQp5tn
         ohZMfZLjiLHaef4fjK1xhfQyNq+NhroN+hwrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TV9vbk2srZd0i6ieR89D2XCZp2Oy3hSU0itcsj4ofg8=;
        b=GnulgDspOMxu/IhjJL/RcHGug+G5OhHA5bzHDJOSTJ25mS5sOT7QbhymzViHH/U/pe
         rwFcty0TcN6Y9EPpRqozmE520yd1EAUwFvQ4KDr5bbyfAvSORXNEIpN1hPcN57I6LYTK
         4ti1LQxmyrt2XZV94wpV6/IrXV2XJmkkK1nat0W4MG/zIxNFn1N9aI4GdcG4UnJZTMBK
         JQkfEHPAKTCgDQjexnhco+cmzCOKDeIiyP5JgO+fSj4+/ZJxerI1g5/7i2MXvTIelDnH
         0msUwVWCjqU5QNB9ARcaiKRrokx0BW2e2bBKhow3vSIwUs3kvJTNV+AeG+ZXx/TBzI7r
         zm8g==
X-Gm-Message-State: AOAM533kuJj+8R8Hcij1ceI1nkhlDnAeWNwmOQUfTqZZmwkm2L+82w9q
        lyS2aRx6TyI3n1mw3wytwfdgMiDHj9Y=
X-Google-Smtp-Source: ABdhPJzaVfs03fKJGJpcug8aK5mvtr05nE0If4q1DGmAC3+Cs2pxDun7u3exP3AIwDoVVgHtvKwRag==
X-Received: by 2002:a2e:8e27:: with SMTP id r7mr8773428ljk.382.1592843538366;
        Mon, 22 Jun 2020 09:32:18 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id s20sm3269692ljs.36.2020.06.22.09.32.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 09:32:17 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id n24so20009849lji.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 09:32:17 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr8480791ljn.70.1592843536797;
 Mon, 22 Jun 2020 09:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org> <87k1026h4x.fsf@x220.int.ebiederm.org>
 <CAHk-=wgczNRMP-DK3Ga-e_HXvZMBbQNxthdGt=MqMZ0CFDHHcg@mail.gmail.com> <87eeq7xebo.fsf@x220.int.ebiederm.org>
In-Reply-To: <87eeq7xebo.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Jun 2020 09:32:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiwWj9CKYvdKqLtOivozqwowcGXxQL6yhPC+euHa5j2Q@mail.gmail.com>
Message-ID: <CAHk-=wiiwWj9CKYvdKqLtOivozqwowcGXxQL6yhPC+euHa5j2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] exec: Don't set group_exit_task during a coredump
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 9:24 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Why do you think the test sig->group_exit_task != NULL should be removed
> for the commit to make sense?

Because that's what your commit message _said_.

It still implies that with your changed language.

And honestly, wouldn't it be a lot more understandable if the state
was tracked with a single variable? The whole point of this series has
been "clarify exec".

So let's clarify it. There aren't that many places that set
sig->group_exit_task (whether renamed or not). How about we just
change _all_ of those to set 'sig->flags', and really clarify things?

                 Linus
