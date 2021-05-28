Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8385D39458E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 18:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhE1QEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 12:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhE1QEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 12:04:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF968C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 May 2021 09:03:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id s22so6066875ejv.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 May 2021 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2mkp1VfbRLXyX9BQ4/sufzNob6zQwJ5kWZnckwzjKg=;
        b=XN2MWTRNcK+CU7plcx6VTpATsrmsKATolYVbfOniDSO21Y5pEf6h2GpH8bMm+fAQho
         QkHK8FyZQLQNtBE7JZYv/2AnbIH+DDVekQS3/V/7JGJXqrvtdcZ/O8kYGScYEv9Z4bvm
         mdJga8p/z8HPfzRFgQd00MyNZTUULOc2FUKYxpVnBTLbNs5wuq9ktq8W1/70TYiNFkVk
         Ev6r8oW4NAs4E+07r1ee8XbEzaXNon4sr681aBZAPumTSWH3ZQkf0lAdxkmo08ApAqhs
         +UyR+OvZme+Ckor57XsUteckvvq93NYjoNNkVka6PbHUHdjO+PIkjvAcitoS4O5QKSkb
         T3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2mkp1VfbRLXyX9BQ4/sufzNob6zQwJ5kWZnckwzjKg=;
        b=Ye970dB71zCYTdScgotGo7GLTrwj9gcVeoSk8XEoGfk2FvPUtGOfQbcowhANkUPDVt
         qJUlwupBXNE/aqnmKjUbr4YTtHELN9phQaOsRzKWIGdGffpJ7LktV6j8wMW6b+e8cVry
         WEfb6wj1DztqOtJyaGhXA4q1yNviz98ZE+aGOsxr7LmGds75dfkoOrAxX/qFxvsyI8tE
         6Sxi+zyDlazKBCx5HHhfHa4On6TwLwt6883ZZc6eMOb3zNyZVeyxiincDpf6o7TXYPPd
         h1Yvv4EW6mJX1ouj0Lzw1TQU4757UB5hJWM5rwb6/cCb9oWEicSTR4O5yv6y2K7dCa3D
         dvbA==
X-Gm-Message-State: AOAM53086tErIQJ1rYF3d24iblgx2m30QaWoDvMAyASISade7qvDMVpx
        KA5ZUhovwh57MJpGdSfF/dBEIRbvis7Zrmf/xwab
X-Google-Smtp-Source: ABdhPJxRjX3Ws7VBEcmMgQB006OahZcwDvgkWQ9e4I1WzulhYU5E4GfGyPMI6cxRYYL7k/JKuuFBrGiK18GyCTgkyuA=
X-Received: by 2002:a17:906:4111:: with SMTP id j17mr150091ejk.488.1622217789328;
 Fri, 28 May 2021 09:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <162163367115.8379.8459012634106035341.stgit@sifl>
 <162163379461.8379.9691291608621179559.stgit@sifl> <f07bd213-6656-7516-9099-c6ecf4174519@gmail.com>
 <CAHC9VhRjzWxweB8d8fypUx11CX6tRBnxSWbXH+5qM1virE509A@mail.gmail.com>
 <162219f9-7844-0c78-388f-9b5c06557d06@gmail.com> <CAHC9VhSJuddB+6GPS1+mgcuKahrR3UZA=1iO8obFzfRE7_E0gA@mail.gmail.com>
 <8943629d-3c69-3529-ca79-d7f8e2c60c16@kernel.dk> <CAHC9VhTYBsh4JHhqV0Uyz=H5cEYQw48xOo=CUdXV0gDvyifPOQ@mail.gmail.com>
 <9e69e4b6-2b87-a688-d604-c7f70be894f5@kernel.dk> <3bef7c8a-ee70-d91d-74db-367ad0137d00@kernel.dk>
 <fa7bf4a5-5975-3e8c-99b4-c8d54c57da10@kernel.dk> <a7669e4a-e7a7-7e94-f6ce-fa48311f7175@kernel.dk>
 <CAHC9VhSKPzADh=qcPp7r7ZVD2cpr2m8kQsui43LAwPr-9BNaxQ@mail.gmail.com>
 <b20f0373-d597-eb0e-5af3-6dcd8c6ba0dc@kernel.dk> <CAHC9VhRZEwtsxjhpZM1DXGNJ9yL59B7T_p2B60oLmC_YxCrOiw@mail.gmail.com>
In-Reply-To: <CAHC9VhRZEwtsxjhpZM1DXGNJ9yL59B7T_p2B60oLmC_YxCrOiw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 May 2021 12:02:58 -0400
Message-ID: <CAHC9VhSK9PQdxvXuCA2NMC3UUEU=imCz_n7TbWgKj2xB2T=fOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] audit,io_uring,io-wq: add some basic audit
 support to io_uring
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 4:19 PM Paul Moore <paul@paul-moore.com> wrote:
> ... If we moved the _entry
> and _exit calls into the individual operation case blocks (quick
> openat example below) so that only certain operations were able to be
> audited would that be acceptable assuming the high frequency ops were
> untouched?  My initial gut feeling was that this would involve >50% of
> the ops, but Steve Grubb seems to think it would be less; it may be
> time to look at that a bit more seriously, but if it gets a NACK
> regardless it isn't worth the time - thoughts?
>
>   case IORING_OP_OPENAT:
>     audit_uring_entry(req->opcode);
>     ret = io_openat(req, issue_flags);
>     audit_uring_exit(!ret, ret);
>     break;

I wanted to pose this question again in case it was lost in the
thread, I suspect this may be the last option before we have to "fix"
things at the Kconfig level.  I definitely don't want to have to go
that route, and I suspect most everyone on this thread feels the same,
so I'm hopeful we can find a solution that is begrudgingly acceptable
to both groups.

-- 
paul moore
www.paul-moore.com
