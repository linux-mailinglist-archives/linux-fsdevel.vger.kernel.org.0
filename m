Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871E22C136A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 20:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgKWSdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 13:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgKWSdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:33:50 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FC3C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 10:33:50 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id oq3so24741014ejb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 10:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqcYLKj/NZRsqtATYR+P+/ypK5dgCZ+R6Ix8LeOTgdM=;
        b=XOYSyXSCBiFCeiwN5T3mq03mJVEfjBlNTRNj+97JpTIv9QNoYcq4KVTHoZKM0RHUiZ
         aMU5eBLcUVn2oepe6LrQnnte++28IjEawjsUcGYm7bg7xVWSL0ZVXbri92VAFRnzmk1D
         ELGEE8c/OC8+MrV/MShiQvK0KfsI5O3l0+7BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqcYLKj/NZRsqtATYR+P+/ypK5dgCZ+R6Ix8LeOTgdM=;
        b=FIkvkubp1bOy8upKSrmCw90UV39PtceYw8TmAVlxGttt11g/uit8GTeoAHzDhwcqJY
         lKKuJJRZBfcq0aRf8qovzktgV9t94KwL1NitYE8XbWX58GgUUjlmqdoGNSb5+7E27uMU
         mRaplon2Zfols8R9qe67oM3qJU5C11CtNY3zqTQXikUbsQ/2n5mS0JDoVnlraDy7f4EY
         zIXPCmWa1bGQ4kqdOqlW5yT885mbU5qUjSHd2luQhqyy5rGI/B9e6G9029dr+DF5fINX
         QV0rNPsjAusyBsCKGPdtr2xdat1WYf6LWWZLcxpVESOxU8S81f0Tn8lXwNNQCBs63a9f
         YnCg==
X-Gm-Message-State: AOAM531NbdQV02WepombxBvv/jg3xJCb8r+U0+ZhGL2/D1I5MpwIcGgo
        Qb9IPi4iXP27taUe11v4D5fe6g2Sr9S5Wg==
X-Google-Smtp-Source: ABdhPJxK2phljQlT80wEyL5QlhMUH8l8ZX4hr7PfDIwJdvvLOtOFs8anZAT5qVc0Xx/smvDuC0eX4Q==
X-Received: by 2002:a17:906:7e43:: with SMTP id z3mr908167ejr.67.1606156428437;
        Mon, 23 Nov 2020 10:33:48 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id t11sm5344596ejx.68.2020.11.23.10.33.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 10:33:47 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id gj5so24752266ejb.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 10:33:47 -0800 (PST)
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr281899ljk.102.1606155929844;
 Mon, 23 Nov 2020 10:25:29 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-2-ebiederm@xmission.com>
 <20201123175052.GA20279@redhat.com>
In-Reply-To: <20201123175052.GA20279@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Nov 2020 10:25:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
Message-ID: <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 9:52 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Can anyone explain why does do_coredump() need unshare_files() at all?

Hmm. It goes back to 2012, and it's placed just before calling
"->core_dump()", so I assume some core dumping function messed with
the file table back when..

I can't see anything like that currently.

The alternative is that core-dumping just keeps the file table around
for a long while, and thus files don't actually close in a timely
manner. So it might not be a "correctness" issue as much as a latency
issue.

             Linus
