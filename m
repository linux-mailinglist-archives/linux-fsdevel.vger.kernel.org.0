Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB4D1C0373
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgD3RCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727804AbgD3RCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:02:06 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1562C035494
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 10:02:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u6so100228ljl.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jusIkjp3Dz4is1PZPLtprnCAT5bOhq5lF7YlVU3AWyQ=;
        b=K/L1x2WLoEDVhKcajWjRfk8di4UnhY9fQ857BctryF99FXnh8lvm/+FMFP7To9VzLC
         Oeh5Zl2gS6/3rwg+PAIfEpUDm0vFKxb3sBkuIMd/j+tdM33ErRljDKSRox35DyrhVqQy
         cxTvpJRHT1GSdzAq5WmfU86CiiQNmQ4AcXgOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jusIkjp3Dz4is1PZPLtprnCAT5bOhq5lF7YlVU3AWyQ=;
        b=Js2SPqj3Jyy0sVw2gZx0Z3KrOfDfhd4qAxiRo/w6zG0QC01+C+50KqvaIgJidLFj7R
         xKgrYJ17ihO3bojqBdY5Dn48b267Mmuy9YWKiYrfP1P7QFwcjBzzCRTLpoHu4n3aOnd9
         fw2zcYnfNHIQQq2WDcBhhdrYDvuKSVEE01aNRrbund271Kzl0M6H7ZvQpwFCvQmSLnRv
         YujnxK7KGq/pniVCXGpVdR7prqyxxBRLOyJvToZ0jhlIiMaPnUXaG43ToXFovb1ivJT3
         pwef9RrYpXN1ZR7RYkllVxICOi6S1WOtQHifDbU8cXyxsKYHaS5221N6YtVqRh+xpTBW
         uhkw==
X-Gm-Message-State: AGi0PuZviB2SpN7BedCIG7Uy3FPkTHjRT8Zy5lBE+ciQKDUTVyQ6v+SZ
        NmN+qbQ3c6p3+NLTr+tXkaleOVrnlqU=
X-Google-Smtp-Source: APiQypKnxVHW/KOwpgiTzYHiL3IQjAQFoxq2QxgjIeLR7b0fHSsvng1QwHtU/R4sYEbxnqnnHWTCsg==
X-Received: by 2002:a2e:9011:: with SMTP id h17mr181310ljg.138.1588266123325;
        Thu, 30 Apr 2020 10:02:03 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u12sm186951ljo.102.2020.04.30.10.02.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 10:02:03 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id w20so138317ljj.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 10:02:02 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr2728777lfk.192.1588265685113;
 Thu, 30 Apr 2020 09:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200429214954.44866-1-jannh@google.com> <20200429215620.GM1551@shell.armlinux.org.uk>
 <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com> <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
In-Reply-To: <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Apr 2020 09:54:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjau_zmdLaFDLcY3xnqiFaC7VZDXnnzFG9QDHL4kqStYQ@mail.gmail.com>
Message-ID: <CAHk-=wjau_zmdLaFDLcY3xnqiFaC7VZDXnnzFG9QDHL4kqStYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jann Horn <jannh@google.com>, Nicolas Pitre <nico@fluxnic.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 7:10 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>
> > in load_flat_file() - which is also used to loading _libraries_. Where
> > it makes no sense at all.
>
> I haven't looked at the shared lib support in there for a long time,
> but I thought that "id" is only 0 for the actual final program.
> Libraries have a slot or id number associated with them.

Yes, that was my assumption, but looking at the code, it really isn't
obvious that that is the case at all.

'id' gets calculated from fields that very much look like they could
be zero (eg by taking the top bits from another random field).

> > Most of that file goes back to pre-git days. And most of the commits
> > since are not so much about binfmt_flat, as they are about cleanups or
> > changes elsewhere where binfmt_flat was just a victim.
>
> I'll have a look at this.

Thanks.

> Quick hack test shows moving setup_new_exec(bprm) to be just before
> install_exec_creds(bprm) works fine for the static binaries case.
> Doing the flush_old_exec(bprm) there too crashed out - I'll need to
> dig into that to see why.

Just moving setup_new_exec() would at least allow us to then join the
two together, and just say "setup_new_exec() does the credential
installation too".

So to some degree, that's the important one.

But that flush_old_exec() does look odd in load_flat_file(). It's not
like anything but executing a binary should flush the old exec.
Certainly not loading a library, however odd that flat library code
is.

My _guess_ is that the reason for this is that "load_flat_file()" also
does a lot of verification of the file and does that whole "return
-ENOEXEC if the file format isn't right". So we don't want to flush
the old exec before that is done, but we obviously also don't want to
flush the old exec after we've actually loaded the new one into
memory..

So the location of flush_old_exec() makes that kind of sense, but it
would have made it better if that flat file support had a clear
separation of "check the file" from "load the file".

Oh well. As mentioned, the whole "at least put setup_new_exec() and
install_exec_creds() together" is the bigger thing.

But if it's true that nobody really uses the odd flat library support
any more and there are no testers, maybe we should consider ripping it
out...

                Linus
