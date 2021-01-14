Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1396D2F5956
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 04:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbhANDYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 22:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbhANDX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:23:58 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3329FC06179F
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 19:23:18 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id n11so4937835lji.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 19:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FEfB7z2Pg3tEbsUuKrEZpLqRqQiSI7cwvfIpRmMaPsg=;
        b=ERDheW9rkL9QnlcBk+gjMEWNicKOrODmm03n00UhTyuOanz3yIf+tVQ2IhyWO8CwON
         GKpMHZiqMwxQyAHoTp5gWGJ9T/9Cv+QqTqzD/Q0j7l6WJ3FK2LOR2lYJleXMUi/HaPtq
         hAo0tLKKn2Q7t/UBKM4+ZCJT32+rgjpcSTro39e8R9WGksf2PWbqS4pLDiAzVnHdQwFS
         cKqbNI76NaFU69m3LsyPmjdP3CzRq2oPRT9ho+fOAmBKu1eGIxoQiB5laGLfmKCFbLTh
         A+1wPcGioLznXyUUcakh1ovdoJ4a55uHhp/zcRprrvdM7164eLO9rwAW7zpziuw26kme
         wiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FEfB7z2Pg3tEbsUuKrEZpLqRqQiSI7cwvfIpRmMaPsg=;
        b=InG8nVgSNY3r6o4SHFqOrOSDpvcmhsTKuogZ3Njy9QlC1IVG2A9wpiZpI6Ix8HJURd
         yCAZgwsC7WlJm5ZZb3NJsRWUhcwm2+CmjEg1u5HmIBnzUOBvRxX57mr43R5JH0fxk5ls
         tUJrYrMbGvSsZ/yPoW+8kt5mTp0iGSaEqAAT3Mw/MkKFmFHdkQSsrQM1qppwE/02eqcp
         XifkP3NZw6zKqt8vah1c1chhEudm0jR0+151HUYYWM0CrFWL4NY9D0FeHFekploa6M7O
         ne/Ev8nsTDIg+nB9T5clDK6uxT1Jk2C2Y7MJIMclAdjhrjbjvGi8HrMtuCORTOFIbg0L
         6Z5Q==
X-Gm-Message-State: AOAM5308hFZrnV4UHqEVTjEzRek3268aS71HlG8MRfdey2wgJeIpKLEu
        fB17a1Oauhv4OJFJzfHriMsBuUy5JiIAdVuNMk7cOQ==
X-Google-Smtp-Source: ABdhPJzfRhrd1kMrfF3j3pfT5UxcaTNs6jz7zJ40MKXw+hJC73ejwL+h4IUubxMUXNGPVLdYIr3TdisY3PE9ZGevcmg=
X-Received: by 2002:a2e:593:: with SMTP id 141mr2267937ljf.86.1610594596352;
 Wed, 13 Jan 2021 19:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20201209192839.1396820-1-mic@digikod.net>
In-Reply-To: <20201209192839.1396820-1-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 14 Jan 2021 04:22:50 +0100
Message-ID: <CAG48ez3DE8xgr_etVGV5eNjH2CXXo9MR7jTcu+_LCkJUchLXcQ@mail.gmail.com>
Subject: Re: [PATCH v26 00/12] Landlock LSM
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 8:28 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
> This patch series adds new built-time checks, a new test, renames some
> variables and functions to improve readability, and shift syscall
> numbers to align with -next.

Sorry, I've finally gotten around to looking at v26 - I hadn't
actually looked at v25 either yet. I think there's still one remaining
small issue in the filesystem access logic, but I think that's very
simple to fix, as long as we agree on what the expected semantics are.
Otherwise it basically looks good, apart from some typos.

I think v27 will be the final version of this series. :) (And I'll try
to actually look at that version much faster - I realize that waiting
for code reviews this long sucks.)
