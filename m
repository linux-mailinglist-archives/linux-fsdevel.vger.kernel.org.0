Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C4F15CE4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 23:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBMWsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 17:48:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35473 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBMWsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:48:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so8532686ljb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 14:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVdHJ1r/9FxJmwhDqRkVHSIn1Ry+lO3z+KpnaUuqwYk=;
        b=dRYW8MemR37cE0uru6NTUES5Od7vEqzfZmb/KMY93QEjURoq6DE5QcXLZ6JJL9HB8V
         KfvM/ZKQbYsF7Zy+x1PnUgqdmV3x1lbxpWU+BFmhJglL6UqALgYvF3IltbUH8c3PxzFq
         KRLtkM5e8bHrUc0004IuGa/Hy6940Rjrv4zzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVdHJ1r/9FxJmwhDqRkVHSIn1Ry+lO3z+KpnaUuqwYk=;
        b=JDC/w2mnE06o1Apg+OW2QJXf2jHUPkk2CakDhlEAvra1NamXkG42J4S3x4e3H1SEKN
         sI9ThGKG35b7qsVOhmkTN9bfShQ0ye9983AvrQ9DkMB/6ks0OYvpkxobHmKX/Ualolwr
         oGPMDph0DuHjoqIR1VUwcDsobfDmQ15wbjWSpdABmm1beSpeKrbGhk9+XW1ip26lRSZ4
         czFlA11utFP20Bu5AUC/ppp5Fkfk3uBmonSBlWTzhP477YVSunQWhIgcS35vjKRKewbT
         N8xJViAilkq6Efn0q1YRGRQvSCbUCYnzcl9P22DG80j4KOveOOWdQt5Winpgstlrv6tN
         1Vtw==
X-Gm-Message-State: APjAAAVc2LsZi69mS1EMCoXA+ZFkmV+9g/7xBBpPcK0xsRx7wWdQJ51P
        7CuU4nS6QC6GLEuZ2WaYFfmBYzwiieA=
X-Google-Smtp-Source: APXvYqyCnzNWrp/WWfxKN40kv7ge5us0qFcW6gfMZnOxWEahe/r8VX/9a3Ocd1uqee7EzeXQgNf56A==
X-Received: by 2002:a2e:914d:: with SMTP id q13mr53349ljg.198.1581634086497;
        Thu, 13 Feb 2020 14:48:06 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id m16sm2401054ljb.47.2020.02.13.14.48.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 14:48:05 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id h23so8514085ljc.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 14:48:05 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr35496ljk.201.1581634084790;
 Thu, 13 Feb 2020 14:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <20200213055527.GS23230@ZenIV.linux.org.uk>
 <CAHk-=wgQnNHYxV7-SyRP=g9vTHyNAK9g1juLLB=eho4=DHVZEQ@mail.gmail.com> <20200213222350.GU23230@ZenIV.linux.org.uk>
In-Reply-To: <20200213222350.GU23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Feb 2020 14:47:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjePLiQqUfQGCrNb0wp+EtgRddQbcK-pHH=6rxbdYNNOA@mail.gmail.com>
Message-ID: <CAHk-=wjePLiQqUfQGCrNb0wp+EtgRddQbcK-pHH=6rxbdYNNOA@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
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

On Thu, Feb 13, 2020 at 2:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I'd been thinking of ->d_fsdata pointing to a structure with list_head
> and a (non-counting) task_struct pointer for those guys.  Allocated
> on lookup, of course (as well as readdir ;-/) and put on the list
> at the same time.

Hmm. That smells like potentially a lot of small allocations, and
making readdir() even nastier.

Do we really want to create the dentries at readdir time? We do now
(with proc_fill_cache()) but do we actually _need_ to?

I guess a lot of readdir users end up doing a stat on it immediately
afterwards. I think right now we do it to get the inode number, and
maybe that is a basic requirement (even if I don't think it's really
stable - an inode could be evicted and then the ino changes, no?)

Ho humm. This all doesn't make me happy. But I guess the proof is in
the pudding - and if you come up with a good patch, I won't complain.

              Linus
