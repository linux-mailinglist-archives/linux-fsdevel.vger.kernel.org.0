Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D97D11A8EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfEKRup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 13:50:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40520 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfEKRup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 13:50:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id d15so7648571ljc.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2019 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaeXZZDv7nk/NFiZCevhSY5ipAOiI6kKAyNxXRM162A=;
        b=gYUKeQFkZfPF+SBFGZsaxSPX55GAIAS/b1OL8l3HnOId4D1oRMFa3K7gUFrPcwRrwy
         APK5QWg5R2UiE0UN3c1Dva/PzQWGeJlJ5tHgbq3gjrlKhO0guDRYzfDmlm0/LX/2qE9B
         K7S0QKKNg6ex1rQUDLj3zMpwysbA0a21x1Q6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaeXZZDv7nk/NFiZCevhSY5ipAOiI6kKAyNxXRM162A=;
        b=uKBSvYTs1mz8TlmVaVMoxfOA4Y8rSTck/gdIoNJUWE1qtEvcbP+5NsE69TvAZk3Wxs
         f2oJcVNauyxLBUVCl768+sP+am/COXkgRTHKgB53rDFN+HZfvR7v8RsVGUDJsaXwifVq
         zn+nkbxCX5qDToDVaJ5A86WWiWDAfcChUWBrIjaYYcxR177AgDW+j60OSuhCqieQfIYk
         5ohPdBl4l0Jf7SaHJ8wA9P6IzOj4VRbbby1s8Mu/cWj94+kKoYvZ37REVJSzZqxERc7a
         /MLRW9jCR8kBCudGnQNw9U8S4UFEppNi10vQscdE8vQf9axicQEbCzpESwW9gZkJiLoH
         Wj0g==
X-Gm-Message-State: APjAAAXx8scBIpM3V3Ovs6reIozJy4LqQBCEhXWZ8Q/Icnn7vSmqTje9
        sAqgMREC/YrhzU4F9ZobS8aRQjo8mZo=
X-Google-Smtp-Source: APXvYqysy3BTdYUHNqZbm4zO/rQTcQqTfnolQyDTQMgrBT7pqm+NoP1xBYdM1VKnrUk347WWKDAT1A==
X-Received: by 2002:a2e:5501:: with SMTP id j1mr9054915ljb.58.1557597043561;
        Sat, 11 May 2019 10:50:43 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id k10sm2166972ljh.86.2019.05.11.10.50.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 10:50:43 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id z5so7636748lji.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2019 10:50:43 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr8365865ljj.79.1557596640790;
 Sat, 11 May 2019 10:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
 <CAHk-=whOL-NBso8X5S8s597yZEOMBoU8chkMFVTi8b-ff2qARg@mail.gmail.com> <20190511173113.qhqmv5q5f74povix@yavin>
In-Reply-To: <20190511173113.qhqmv5q5f74povix@yavin>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 May 2019 13:43:44 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgo-X9pDbVf8khfDsgEKn3wSvLJkB890OxHL+42Hosypw@mail.gmail.com>
Message-ID: <CAHk-=wgo-X9pDbVf8khfDsgEKn3wSvLJkB890OxHL+42Hosypw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 11, 2019 at 1:31 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> Yup, I've dropped the patch for the next version. (To be honest, I'm not
> sure why I included any of the other flags -- the only one that would've
> been necessary to deal with CVE-2019-5736 was AT_NO_MAGICLINKS.)

I do wonder if we could try to just set AT_NO_MAGICLINKS
unconditionally for execve() (and certainly for the suid case).

I'd rather try to do these things across the board, than have "suid
binaries are treated specially" if at all possible.

The main use case for having /proc/<pid>/exe thing is for finding open
file descriptors, and for 'ps' kind of use, or to find the startup
directory when people don't populate the execve() environment fully
(ie "readlink(/proc/self/exe)" is afaik pretty common.

Sadly, googling for

    execve /proc/self/exe

does actually find hits, including one that implies that chrome does
exactly that.  So it might not be possible.

Somewhat odd, but it does just confirm the whole "users will at some
point do everything in their power to use every odd special case,
intended or not".

                  Linus
