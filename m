Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D976215B017
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 19:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgBLSp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 13:45:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34117 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLSp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:45:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id x7so3550271ljc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 10:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8S2w7jKfhj8nqr2BEN6cbFr7nckGF3MBI5pTAOk2Bgk=;
        b=E/vN3AE3iyzGDOzjrhIyYOh5wyK5H3COrkDAy4Yb/0fuIwlyf50yEW7S/x5cDf9tHW
         zWbCuDLoLaAGtRSBjikTyE8yY06byotE/cGEhEbxOklsxfNCa9G0PsCjeYAs62WP1DSa
         M2BG1IabKnVo1IvqnOENDDauUUlMg+SJyMK4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8S2w7jKfhj8nqr2BEN6cbFr7nckGF3MBI5pTAOk2Bgk=;
        b=a31vmeJ+t7UuirMyS3SnQGklk/HLC8W8NGg2HakRpnp6RnVnMU7sBLGrOXEypNAo/3
         7W1uvLD0sMuKDE9UiFhlNsbYRj1c6+USVtcIy+y0TFxJDrMw6OQ3tB0gFzUvliJIPYHk
         eF3o5b2po75LfSeAXxMIQZfW/EAP87LvkRPyPk4OL7NGIO7N3aFsIPtgJot3v11m660q
         G7l/ZoIXgwYTUDq0CSuBNQGHhB6+sV27c69QWUt2SipP1l3zOvUhrlz3cBPTfsIQ6iOo
         i5whr9OpofpexA3pfYY88JV+WTnqAtjCR3SfGQ2EMZkQGWEWQktCMPgPV8fSXZXgYOne
         QqtQ==
X-Gm-Message-State: APjAAAWgi+qIJvi+5Mi4uMQafItDFRiLwUK+xzckAd9UYSVW59VRNWE0
        /qmxxKpz+5bJD9UlR9zJKqfNhnsTSwE=
X-Google-Smtp-Source: APXvYqx9/67K8Av4IizlPdIXQVPVNSssbTKjtY0Exxdc7Tv5dVdsaQxFsQi1GKhJ4sXNBF1hhtIy+Q==
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr8610656ljm.53.1581533124442;
        Wed, 12 Feb 2020 10:45:24 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w29sm892583ljd.99.2020.02.12.10.45.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 10:45:23 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id e18so3500581ljn.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 10:45:23 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr8440902ljj.241.1581533122702;
 Wed, 12 Feb 2020 10:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com> <87v9odlxbr.fsf@x220.int.ebiederm.org>
 <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6> <87tv3vkg1a.fsf@x220.int.ebiederm.org>
In-Reply-To: <87tv3vkg1a.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 10:45:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
Message-ID: <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 7:01 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Fundamentally proc_flush_task is an optimization.  Just getting rid of
> dentries earlier.  At least at one point it was an important
> optimization because the old process dentries would just sit around
> doing nothing for anyone.

I'm pretty sure it's still important. It's very easy to generate a
_ton_ of dentries with /proc.

> I wonder if instead of invalidating specific dentries we could instead
> fire wake up a shrinker and point it at one or more instances of proc.

It shouldn't be the dentries themselves that are a freeing problem.
They're being RCU-free'd anyway because of lookup. It's the
proc_mounts list that is the problem, isn't it?

So it's just fs_info that needs to be rcu-delayed because it contains
that list. Or is there something else?

               Linus
