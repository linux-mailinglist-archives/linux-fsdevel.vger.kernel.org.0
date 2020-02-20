Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C726166AC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 00:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgBTXIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 18:08:35 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39349 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgBTXIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:08:34 -0500
Received: by mail-ed1-f67.google.com with SMTP id m13so50422edb.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 15:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oW+dHyuXcdgcpFOp9rkCYNNzyvxL/1mmVUWMW1tVkn8=;
        b=HsJYplXHj9WIosfuyYDxgCIpizr4Q2QTncG0r8kQoBcqx1jdtsR9fFVeYAPGlhnI5Y
         7UWBHhKU9LT9oEd08VowjnmWRULPbdq+faWGzRjHU4lCzwffnnc4X3O8+YTbupxrOXam
         he3lTa6POmGxUb6ylyx451mYPhWfQQq6/MfdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oW+dHyuXcdgcpFOp9rkCYNNzyvxL/1mmVUWMW1tVkn8=;
        b=BazxuZR/ddefnlynsgFdIjrsaL6nUhGw4FpHw6H/Dksfw66unH89tBmLrlNVP6okcq
         +O+PjutDKLLgHSI8KHLM/UUt6f58w1rhztDVl5394/V2WYZ25d89CkLndvvZcVDjhbJs
         CEtIxooYXMofMu+9wUHlCtIauiBHmDsAVrCRcnZhGeE8spmXdpKSPceMoirS+vPCHFJF
         bXpKwWcX98bthVLNWSSzfUjVsxImpIam3/+3ufYXJcCx15hN643iWoQQ5W5ijZMcTS7S
         4dhSW90lZeKklGs0QcJdr02DrzDpH7cMZZwbBXGi2X64ujXk34iutzz7xUyPRbKqdcBt
         BbNw==
X-Gm-Message-State: APjAAAX5YP8ZBGV7wPu8X73S+XPbDkqMewUFjW2pv9RsVTuEXiUJ8fgu
        uxmIAZ7u28yIzWVatHNzpiuZT5XrKkI=
X-Google-Smtp-Source: APXvYqy4QnN1ahhrav9yDHN0JZ7lyt0kZlRCM10sjrRQEJ/R7am1VIPhNoBddAE6xL14kiTRaND4Iw==
X-Received: by 2002:aa7:d9c2:: with SMTP id v2mr30476095eds.88.1582240112644;
        Thu, 20 Feb 2020 15:08:32 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id h61sm92555edd.49.2020.02.20.15.08.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 15:08:32 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id p14so14360edy.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 15:08:32 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr20496205ljk.201.1582239629960;
 Thu, 20 Feb 2020 15:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
 <87blpt9e6m.fsf_-_@x220.int.ebiederm.org> <20200220225420.GR23230@ZenIV.linux.org.uk>
In-Reply-To: <20200220225420.GR23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 15:00:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPwMTTaGtphubBXeiKitKigutddx9Fcp4Sf1sw4tpyeA@mail.gmail.com>
Message-ID: <CAHk-=whPwMTTaGtphubBXeiKitKigutddx9Fcp4Sf1sw4tpyeA@mail.gmail.com>
Subject: Re: [PATCH 4/7] proc: Use d_invalidate in proc_prune_siblings_dcache
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
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

On Thu, Feb 20, 2020 at 2:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> s/no inode.*/it's a directory inode./

That actually makes my worry go away too. We don't allow aliases for
directory inodes, iirc.

So then it doesn't depend on some /proc implementation issue any more,
then it's fundamental that there's only one dentry.

            Linus
