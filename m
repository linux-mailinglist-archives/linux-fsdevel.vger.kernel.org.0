Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA81BC56D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 18:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgD1Qkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 12:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgD1Qkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:40:41 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFCBC03C1AB
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 09:40:41 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w20so22225049ljj.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHXIK5KG4MM6NL6ZnqDyJCo1++3O5tMDxa0Oox/FCk0=;
        b=Qu+2TQv0OYiYE16287sogB8uDjS8JZz9MFHDIwMmE4QWXix8Yj3Rir/mLPwz00RjUg
         hnk6uNKaE0hzn5zlYIZTWKFCs2u3Lk4U9c8hgRG4h/3lWuPoDD91flVvK19N8QzMsCzs
         vJ6aDNedAL1ptIzuTwxhsiNW9/aiFum9pNkTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHXIK5KG4MM6NL6ZnqDyJCo1++3O5tMDxa0Oox/FCk0=;
        b=e1lzc1J0NU7fyhDGar3U6iGtpzgtfk1pGVZ86jEMklyyq7Cc6sJnbBiyjGsPqwPBvI
         T4/aZmQoAb4msWxfINbnE1bAhJgEL91oG6gdtWI5BNFZP9mkvoH1xXTcQHkhLRUwYVPx
         HR2fnxAijT3MGWPhhupm0RFQGgptP7sbABit/AR9eWDWyAch/RncNWzb7y0YddmO5x/j
         AxpxL7IemRGqFYUTOEOqM6IytGqCm6mdNjfiO7ZmKXWW3Ydc+v0xLvJ2q3svQxgLBBoh
         qgp+/y7oe+8LQ4aqN65gBYf/0hB8ivPsBPt9F7yJVjOIu6Td5apscz20Z8u6xoG+BhRl
         6GzA==
X-Gm-Message-State: AGi0PuYRrdPHFw4ZURVS+2ifK0tp+Ywnb4n3x03wYljGUeIde0nMAF4q
        99Mh6xLq+P/oJg/q3bZ0GVK5ttdmtNo=
X-Google-Smtp-Source: APiQypK6oald/QWFZnPPdl0JwR6ecRcNxCSUHL9xTmww+g9ldh5rYq5q/4fOsx2b+SRilnrEgBTELw==
X-Received: by 2002:a05:651c:1121:: with SMTP id e1mr18048491ljo.205.1588092039626;
        Tue, 28 Apr 2020 09:40:39 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id u7sm11903731ljk.32.2020.04.28.09.40.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 09:40:38 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id r17so17446459lff.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 09:40:38 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr19924040lfk.30.1588092037785;
 Tue, 28 Apr 2020 09:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200428032745.133556-1-jannh@google.com> <20200428032745.133556-3-jannh@google.com>
 <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com> <94141fbb-9559-1851-54c1-cdc5fc529a1a@landley.net>
In-Reply-To: <94141fbb-9559-1851-54c1-cdc5fc529a1a@landley.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Apr 2020 09:40:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2uw09tJMKTooQBr=AJPzzLTaq95b+SSS513Gm0gy5sw@mail.gmail.com>
Message-ID: <CAHk-=wg2uw09tJMKTooQBr=AJPzzLTaq95b+SSS513Gm0gy5sw@mail.gmail.com>
Subject: Re: [PATCH 2/5] coredump: Fix handling of partial writes in dump_emit()
To:     Rob Landley <rob@landley.net>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
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

On Tue, Apr 28, 2020 at 9:34 AM Rob Landley <rob@landley.net> wrote:
>
> Writes to a local filesystem should never be short unless disk full/error.

Well, that code is definitely supposed to also write to pipes.

But it also has "was I interrupted" logic, which stops the core dump.

So short writes can very much happen, it's just that they also imply
that the core dump should be aborted.

So the loop seems to be unnecessary. The situations where short writes
can happen are all the same situations where we want to abort anyway,
so the loop count should probably always be just one.

The same would go for any potential network filesystem with the
traditional NFS intr-like behavior.

            Linus
