Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D08A1E6A17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 21:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406118AbgE1TIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 15:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406081AbgE1TIV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 15:08:21 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763FFC08C5C6
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 12:08:21 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so17245587lfd.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HTVBakDVN8XNdtT+CkYT4htvCqU+BWizMrhpaCpVUU=;
        b=aFMSYB2ECpaxe8CY18ljTFJv4xRZ5bv1Zi4GWChAC1vehbJjLJ6zd3EKxvcmaiQMve
         SRJN/ivKuQqNVzeGQp3DjmIyYFrTa8FYINcRjHaUHAuPfavRik3b9xZHsSgl1vMIU6Gg
         uFypusNji8uKclzDC/fRxY3b+szIfbFvyasjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HTVBakDVN8XNdtT+CkYT4htvCqU+BWizMrhpaCpVUU=;
        b=fOKkvDNZwAUAhG8FbeFz3Pu7xooeAQpfaXF69B2+2WAobYwFSrgjr6drhjrDS8rpPV
         37K/5B5JncOEKTumissElZ0xzkqLUt4KEDksHKBsx0giaKytI39vyI1g0SC2cUt05riT
         4HOPX+LwKTdgCr2i03nn0aQ7fDP9RuNmitxpWw0WGqIetOG1Uw5DDaqszmHJVyJ8Srp1
         A73GWqAPUrromn+IPA45i26n5vmZbN1nG1ziVtGWYRoatbeihiw+eGKvOgUstC+HjzCM
         tew6z0lEqeqk8f+sJOdB5GxuELQIGwp1CasHciXj5ZTrK3suJWjU/tlNXhl4j91UOgUc
         cGfw==
X-Gm-Message-State: AOAM531KuSP7Tc9HqVN6Jgj0Osgm2qEu/Q48XBrGdXneas23jovQAAlF
        /ME6uuSZ18nM+TOWIPl10XvS+uUeEXc=
X-Google-Smtp-Source: ABdhPJzTq80o52eOstsXSxY/SqK3e2sAYuOpm6Hwq9EtwAfvsVNmrYLjt++7mmu3NapwwCmC1brBvw==
X-Received: by 2002:a19:6914:: with SMTP id e20mr2403388lfc.27.1590692899985;
        Thu, 28 May 2020 12:08:19 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 6sm1821668lju.54.2020.05.28.12.08.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:08:19 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id s1so1942687ljo.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 12:08:19 -0700 (PDT)
X-Received: by 2002:a2e:150f:: with SMTP id s15mr2157651ljd.102.1590692898773;
 Thu, 28 May 2020 12:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org> <87y2pcvz3b.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87y2pcvz3b.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 12:08:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAG4tpPoWsWSqHbyMZDnWR8RHUpbwxB9_tdAqbE59NxA@mail.gmail.com>
Message-ID: <CAHk-=wiAG4tpPoWsWSqHbyMZDnWR8RHUpbwxB9_tdAqbE59NxA@mail.gmail.com>
Subject: Re: [PATCH 09/11] exec: In bprm_fill_uid only set per_clear when
 honoring suid or sgid
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
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

On Thu, May 28, 2020 at 8:53 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> It makes no sense to set active_per_clear when the kernel decides not
> to honor the executables setuid or or setgid bits.  Instead set
> active_per_clear when the kernel actually decides to honor the suid or
> sgid permission bits of an executable.

You seem to be confused about the naming yourself.

You talk about "active_per_clear", but the code is about "per_clear". WTF?

              Linus
