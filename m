Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A696C166A7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 23:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgBTWn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 17:43:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38345 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgBTWn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:43:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so169392ljh.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 14:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsBAqEZQag0ypHqg0PyTqrCBxrLtLK/vf3m5Pbo+Q1I=;
        b=HocGqZaPvPbj2Rc3tHfIsXtvsU9ZExNqDhyGTd1FkLfg2CixXSIhWg+lhtFLFy7LH5
         Ll9ajjeSCLGyVGJFCP3pr8MzRIUlhdaSf4zT2trYK3NmUY7kfmF8q56qyO7AFc70i6vi
         mx1gRvncgXwtZTQp0OujHwfoGsQovufSXPaY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsBAqEZQag0ypHqg0PyTqrCBxrLtLK/vf3m5Pbo+Q1I=;
        b=i2lfbY1qb7K3bJqwTKVw+3Xt5nMdwnl5xjR92IIn2An8bq2Ys0+QUXitOHBOuWkA1S
         imGVkw/d/5DofuD0/KSbjLgde6jrHaLj4cI9KXWtEHs3AqGw2rjB1CsuYOQ1phvMtYEU
         GDbixhFtrpBidSYwkMIl2ijN/Ya1cZkyQHA1XQJ076JCBnE4YcARmwzmEaKAb4bfGt1d
         1+sNUs0hp0bAbEOWzyYwlOnSM/DIu+qQNCXWzBcDmsHBaAQa8xIJmgv7/IoOLPmn2Cb3
         Y2iqc7j4QOsUqe0wmoISYR6tKwvmrsmZfBg9eLJSbBVPRuqv/LHvlk/N6RJoLBsDB5sX
         vriQ==
X-Gm-Message-State: APjAAAWmPfKUU7cWHJFqfTy73e0mdCHRK0kpJSNLZDLmUGyHQ44vg146
        x9WKlnI/vHigczceekA8h72dZeO9yHI=
X-Google-Smtp-Source: APXvYqz7lTsDr3QFsdKE7+RAGGrPLPAtHeR3HixMZWFDzqraqaQ4lFNEjp2rAkT/ylK4SmGuv5n07g==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr20324068ljl.83.1582238634660;
        Thu, 20 Feb 2020 14:43:54 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id d26sm482313lfa.44.2020.02.20.14.43.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:43:54 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id q8so140239ljj.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 14:43:53 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr20465844ljk.201.1582238633679;
 Thu, 20 Feb 2020 14:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
 <87blpt9e6m.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87blpt9e6m.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 14:43:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmwfv6zGwTRR8zTyTdfxgYoc7SE3Z0nKHu_srG_8NPWw@mail.gmail.com>
Message-ID: <CAHk-=whmwfv6zGwTRR8zTyTdfxgYoc7SE3Z0nKHu_srG_8NPWw@mail.gmail.com>
Subject: Re: [PATCH 4/7] proc: Use d_invalidate in proc_prune_siblings_dcache
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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

On Thu, Feb 20, 2020 at 12:51 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> To use d_invalidate replace d_prune_aliases with d_find_alias
> followed by d_invalidate and dput.  This is safe and complete
> because no inode in proc has any hardlinks or aliases.

Are you sure you can't create them some way?  This makes em go "what
if we had multiple dentries associated with that inode?" Then the code
would just invalidate the first one.

I guess we don't have export_operations or anything like that, but
this makes me worry...

            Linus
