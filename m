Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2133A1D1FAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 21:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390750AbgEMTwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 15:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390158AbgEMTwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 15:52:20 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F42C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 12:52:19 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d22so543062lfm.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=imHJ5IQrcOcblMTfzv1B9XBBsSAMPE3kPxQA9myjXSo=;
        b=WQAwRDY0UxVZ0mZJR9kVnssScJrq1sN4tD98t4V9W35y8XGCwm/KxMQqToQil5ltO9
         GFUoMNp/kFEbFvuKrggepy5FbHzhYuRUmjv8amxmBrzK6q3yS0RJcPigPs+hBK67907L
         GVp+95DOu4oDEqAYtYvxlr8n8Tbt3B0dOxjF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imHJ5IQrcOcblMTfzv1B9XBBsSAMPE3kPxQA9myjXSo=;
        b=fB+3Zi58ROKu9hpDlaARKp1RO6UKaRycOFB4DfaxuF7HQ5iINX7QyeczhEb1aGRq2F
         MY6pmo9VVJBMHKtLcBPHKJ+Uj95pPTquReiWmNZvn59SOmyFhwG71m9ZfjvvX3txIOJv
         2EyfKmKq1MeKWCqt46hHRkFaNv6VcImWv0h7uBCdOtpf60w3ASLLUjDRjc6gtnLxHhjX
         HPbSzFjEt4rMa5l01paXGcQge46toMiHUWk2a9kVWuSbumMR5fLOdOdm3qWz7ZaSZJK7
         ywCeAIbrVqacGCU6Vs8hCWvWQmuy8p/Axsa20am8ejVnzaTZ4Z3PHmDp0Gee61jlMMiB
         QauQ==
X-Gm-Message-State: AOAM530SdX30EeCoypCJZqvMF5aKJMnd0Fbjl1YAu3lyQpWL6jPIa8U1
        KzOC3XqZ5rcZOuxqF/AGsd20h3+YYec=
X-Google-Smtp-Source: ABdhPJzkOTVTBxtZQ0MNreKoAGiS8MaJrQjnXPfERoja+w8UlyjpqTXOQ0Ic08I5Y/CDtWlQf/26Cg==
X-Received: by 2002:a19:3f51:: with SMTP id m78mr718549lfa.182.1589399537307;
        Wed, 13 May 2020 12:52:17 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id h12sm244285lji.25.2020.05.13.12.52.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:52:16 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id a4so530674lfh.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 12:52:15 -0700 (PDT)
X-Received: by 2002:a19:6e4e:: with SMTP id q14mr699711lfk.192.1589399535404;
 Wed, 13 May 2020 12:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org> <202005111428.B094E3B76A@keescook>
 <874kslq9jm.fsf@x220.int.ebiederm.org> <CAHk-=wjhmoGLcMgcDB0rT-n6waC+rdnjU3FRKAwSTMSG=gaK9Q@mail.gmail.com>
 <6f282d0a-b448-14e9-cd4f-92cce99cc36f@landley.net>
In-Reply-To: <6f282d0a-b448-14e9-cd4f-92cce99cc36f@landley.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 12:51:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgYDMabsEDW_W3iU0jD8RhndQAMhR2HSMkMZ3rTCQbVg@mail.gmail.com>
Message-ID: <CAHk-=wjgYDMabsEDW_W3iU0jD8RhndQAMhR2HSMkMZ3rTCQbVg@mail.gmail.com>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     Rob Landley <rob@landley.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 7:32 PM Rob Landley <rob@landley.net> wrote:
>
> On 5/12/20 7:20 PM, Linus Torvalds wrote:
> > Ack. I think the AT_EXECFD thing is a sign that this isn't internal to
> > binfmt_misc, but it also shouldn't be gating this issue. In reality,
> > ELF is the only real binary format that matters - the script/misc
> > binfmts are just indirection entries - and it supports AT_EXECFD, so
> > let's just ignore the theoretical case of "maybe nobody exposes it".
>
> Would this potentially make the re-exec-yourself case easier to do at some
> point? (Which nommu needs to do, and /proc/self/exe isn't always available.)

AT_EXECFD may be an ELF thing, but normal ELF binaries don't do that
"we have a fd". So it only triggers for binfmt_misc (and only when the
flag is set for "I want the fd").

So no, this wouldn't help re-exec-yourself in general.

Although I guess we could add an ELF section note that does that whole
"executable fd" thing for other things too.

Everything is possible in theory..

               Linus
