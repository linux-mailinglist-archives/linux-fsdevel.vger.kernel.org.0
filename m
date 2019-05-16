Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6920A5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 16:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfEPO40 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 10:56:26 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39639 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfEPO4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 10:56:24 -0400
Received: by mail-vs1-f66.google.com with SMTP id m1so2503704vsr.6;
        Thu, 16 May 2019 07:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7nEL+WPfPN1rBA+/PuN1J/S5uyKwnA6j8/pFf9zHN4=;
        b=NCrTt6RyqZlchwKIYN4hIjLDoEN7HbpLxjgvLemvF7pMHGzMZMvfE+sr5ur5KMOfvW
         hVQHUxWD4D6/PMk6ih05MU3ICJtzKCFnebxvfvQv7CopgIlKaI0N6pbI/VWM8aMQSIbC
         TyiJAV6p/pUpjtTtqvMQFnBHeZB+wmWWxI+Btal7EkfsVAbNn2X5wNmwUPKr0DpFB9rC
         iEx70k7EvV2oWcFQFGve95waCY0xefukjc15RAnd2S1NOlBhL5BF3D/SC6Fcrw56vLoS
         FYlfwL6oySeN9e/TBEOg+yTJ9yxQ+yejspkkOgYq0TWWnQBnZKbIp0Yh4DLOjO4ag5/C
         Qrew==
X-Gm-Message-State: APjAAAVtXmcFbfYsO+cjcOZGO7qTr0bwGlGTxyI8vXP7BTTBloVLvjpX
        qJIwbFh3Am9DNyNq0ZmvF9Wev7wdX4uBKeMS5lY=
X-Google-Smtp-Source: APXvYqzEce0hna+NIpEAjAwxrp3WXHdhwiLZYzNSambp2Tqp9lbWiT2Er/sNJ/Cyun4+1E0OoRvh7/Hb9d7XNywa1WI=
X-Received: by 2002:a67:8e03:: with SMTP id q3mr24527906vsd.152.1558018583276;
 Thu, 16 May 2019 07:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
 <155800755482.4037.14407450837395686732.stgit@warthog.procyon.org.uk>
In-Reply-To: <155800755482.4037.14407450837395686732.stgit@warthog.procyon.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 May 2019 16:56:10 +0200
Message-ID: <CAMuHMdWsgSWC2AFGf_XBaEc0g=FDkGB1=UH+Ekh9n6k3W4ifWQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] uapi: Wire up the mount API syscalls on non-x86
 arches [ver #2]
To:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David, Christian,

On Thu, May 16, 2019 at 1:54 PM David Howells <dhowells@redhat.com> wrote:
> Wire up the mount API syscalls on non-x86 arches.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> +428    common  open_tree                       sys_open_tree
> +429    common  move_mount                      sys_move_mount
> +430    common  fsopen                          sys_fsopen
> +431    common  fsconfig                        sys_fsconfig
> +432    common  fsmount                         sys_fsmount
> +433    common  fspick                          sys_fspick

The first number conflicts with "[PATCH v1 1/2] pid: add pidfd_open()".

Note that none of this is part of linux-next.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
