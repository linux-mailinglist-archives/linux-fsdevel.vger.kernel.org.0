Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5588B1A8B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 19:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfEKR1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 13:27:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44065 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfEKR1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 13:27:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id e13so7600407ljl.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2019 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/KXVrXCOoOJzYs9luHiRMdkROvz6GYngOgjcnMA4n3A=;
        b=Hety9aPlucNn5YIwnDgl8T3xjH+kXuoGBPFuY/OFtMOJcXBxT9yY1dN0jhbCAtXCK0
         Fa6aOPlBmmvU40A7F6POImQufHmWg9Vb9DX0ym6/HYmPb7jC+B4zImEGQr9edmzZr+8E
         D7AZsufzimvvqZsX7ErQ2Z7DvHrgK4oj1AIJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/KXVrXCOoOJzYs9luHiRMdkROvz6GYngOgjcnMA4n3A=;
        b=Uo2WyrHvXPp8nf4/lIlo8WVZZbsObb5IMlISL3mWvXf6wblgAQMCj8AZ5VbKBrpxSy
         ljBgn4eg9obdJSBN4AlM3JynpJccrjIGr6gsqWigGrM1dFwVadcMsJcKLm1i+9iJ4VyO
         5vGjyhI6PjQcr2eXvH6Py3Y4+vwr4wbIduLsUj4vYUmO/57orY5AxN7svOsLyNu/eLma
         KrjrosCPREoFZYvNg+Az2SwR88o4eZI+hF/UdGt/ztkgnIwRLoUDTiy6uLx7JHrGD3hC
         YXZ4nrNTSz9wYYq+m4HszBQBo9G0OV2ol8vmdWfQd8CLESHBDGh5D9a//8jUNniVXD0w
         8HWQ==
X-Gm-Message-State: APjAAAWQzLNl4snuLkhdddTnbGJ67J1OLnW6iTkdc0dWy5M/io6yLPOT
        Ry5HB4OZnsbf16fJvSYZpAy1tmRi8ZA=
X-Google-Smtp-Source: APXvYqyb2qgLWEBIavHV4lomwjVazq1Xcui/uVPfyII0vb1moB0sRkL7U49U2C2nQwUKEsxP0VQGKg==
X-Received: by 2002:a2e:9a8f:: with SMTP id p15mr9064596lji.191.1557595642143;
        Sat, 11 May 2019 10:27:22 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id l17sm2282558lfp.49.2019.05.11.10.27.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 10:27:21 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id r76so7598030lja.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2019 10:27:21 -0700 (PDT)
X-Received: by 2002:a2e:9d86:: with SMTP id c6mr9078356ljj.135.1557595287924;
 Sat, 11 May 2019 10:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
In-Reply-To: <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 May 2019 13:21:11 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
Message-ID: <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 11, 2019 at 1:00 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> A better =E2=80=9Cspawn=E2=80=9D API should fix this.

Andy, stop with the "spawn would be better".

Spawn is garbage. It's garbage because it's fundamentally too
inflexible, and it's garbage because it is quite complex to try to
work around the inflexibility by having those complex "action pointer
arrays" to make up for its failings.

And spawn() would fundamentally have all the same permission issues
that you now point to execve() as having, so it doesn't even *solve*
anything.

You've said this whole "spawn would fix things" thing before, and it's
wrong. Spawn isn't better. Really. If fixes absolutely zero things,
and the only reason for spawn existing is because VMS and NT had that
broken and inflexible model.

There's at least one paper from some MS people about how "spawn()" is
wonderful, and maybe you bought into the garbage from that. But that
paper is about how they hate fork(), not because of execve(). And if
you hate fork, use "vfork()" instead (preferably with an immediate
call to a non-returning function in the child to avoid the stack
re-use issue that makes it so simple to screw up vfork() in hard to
debug ways).

execve() is a _fine_ model. That's not the problem in this whole issue
at all - never was, and never will be.

The problem in this discussion is (a) having privileges you shouldn't
have and (b) having other interfaces that make it easyish to change
the filesystem layout to confuse those entities with privileges.

So the reason the open flags can be problematic is exactly because
they effectively change filesystem layout. And no, it's not just
AT_THIS_ROOT, although that's the obvious one. Things like "you can't
follow symlinks" can also effectively change the layout: imagine if
you have a PATH-like lookup model, and you end up having symlinks as
part of the standard filesystem layout.. Now a "don't follow symlinks"
can turn the *standard* executable into something that isn't found,
and then you might end up executing something else instead (think root
having '.' as the last entry in path, which some people used to
suggest as the fix for the completely bad "first entry" case)..

Notice? None of the real problems are about execve or would be solved
by any spawn API. You just think that because you've apparently been
talking to too many MS people that think fork (and thus indirectly
execve()) is bad process management.

                Linus
