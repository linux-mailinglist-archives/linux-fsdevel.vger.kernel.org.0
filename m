Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AE7242E57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 19:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHLR7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 13:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHLR7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:59:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9069CC061383
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 10:59:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c16so3234811ejx.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/cIJeE2yfgVM1ZrtP/9jp14hYxY3Vu0/YCadb84AWQ=;
        b=jI3J/b3sbr7lMKeERD0GITknMh9Uxa+SplZKxUOvdDtzVOtMq4sbbMjULlVaTTjPsl
         b6ZbrqiZvtr1sqNoBR0Z/OPksGY4OjXSaOovTptxM1hz6ZDb++D2GV0IE+GzOKqYA1mF
         Rk5bbZ3M7f75UO+LZE8T1d84BJjKfgSc9gyZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/cIJeE2yfgVM1ZrtP/9jp14hYxY3Vu0/YCadb84AWQ=;
        b=hf5A2RBp+pesSwjBd3QrDroiFKVRlz5OgGfYSmJHessLXpfpF1uoqOiW2cH4VYMCv4
         CHTt5enTyzACCLroptc4qbsXoBwdheJoh+hF7HkBesk/auoMqnbly8OugPSMD+kD4QWZ
         Cj9QLzgGS7dtuAnvU6csDnbKswDbt+JOoT6fhXeK7vMObba1vabq7jHHU7hHan1QOt4X
         9FYUc1MOf8lY3ODhtQdcqLI1XL4orVGKU+yVrWA5z6eua5rq4prUx3NWz1bGVbR3yKvX
         ad6dE1mUzYFFgUuqgc7b6zSPqqQxmjsLWKUm8iazrszTOLMT/xZy4aabZJKtqomjecw9
         aWwg==
X-Gm-Message-State: AOAM530yFrzwaBI0sxuBT4o/6G6UFWX8yMyYnzZK75eLsCMh1hG/U0r1
        /5HieVvg4QkRe2OZe2M5OON0NoxAh5lkLQ==
X-Google-Smtp-Source: ABdhPJw1IE2sW2GvTi3DKaXc5veQ3JS2n1ueqA72PGTro/huhJW6EauggxBUpImiYR6+IGnnaaWA3g==
X-Received: by 2002:a17:906:54d3:: with SMTP id c19mr1023982ejp.408.1597255168777;
        Wed, 12 Aug 2020 10:59:28 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id qk30sm1953909ejb.125.2020.08.12.10.59.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 10:59:25 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id bo3so3228158ejb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 10:59:25 -0700 (PDT)
X-Received: by 2002:a17:906:4d4f:: with SMTP id b15mr946622ejv.534.1597255164979;
 Wed, 12 Aug 2020 10:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200811222803.3224434-1-zwisler@google.com> <20200812014324.rtvlhvopifgkw4mi@yavin.dot.cyphar.com>
In-Reply-To: <20200812014324.rtvlhvopifgkw4mi@yavin.dot.cyphar.com>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Wed, 12 Aug 2020 11:59:13 -0600
X-Gmail-Original-Message-ID: <CAGRrVHwQ4EpZy73n4NTLhDZNGN4Gi_FUL4BjWw7ruEoGHENZEg@mail.gmail.com>
Message-ID: <CAGRrVHwQ4EpZy73n4NTLhDZNGN4Gi_FUL4BjWw7ruEoGHENZEg@mail.gmail.com>
Subject: Re: [PATCH v7] Add a "nosymfollow" mount option.
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 7:43 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2020-08-11, Ross Zwisler <zwisler@chromium.org> wrote:
> > From: Mattias Nissler <mnissler@chromium.org>
> >
> > For mounts that have the new "nosymfollow" option, don't follow symlinks
> > when resolving paths. The new option is similar in spirit to the
> > existing "nodev", "noexec", and "nosuid" options, as well as to the
> > LOOKUP_NO_SYMLINKS resolve flag in the openat2(2) syscall. Various BSD
> > variants have been supporting the "nosymfollow" mount option for a long
> > time with equivalent implementations.
> >
> > Note that symlinks may still be created on file systems mounted with
> > the "nosymfollow" option present. readlink() remains functional, so
> > user space code that is aware of symlinks can still choose to follow
> > them explicitly.
> >
> > Setting the "nosymfollow" mount option helps prevent privileged
> > writers from modifying files unintentionally in case there is an
> > unexpected link along the accessed path. The "nosymfollow" option is
> > thus useful as a defensive measure for systems that need to deal with
> > untrusted file systems in privileged contexts.
> >
> > More information on the history and motivation for this patch can be
> > found here:
> >
> > https://sites.google.com/a/chromium.org/dev/chromium-os/chromiumos-design-docs/hardening-against-malicious-stateful-data#TOC-Restricting-symlink-traversal
>
> Looks good. Did you plan to add an in-tree test for this (you could
> shove it in tools/testing/selftests/mount)?

Sure, that sounds like a good idea.  I'll take a look.

> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

Thank you for the review.
