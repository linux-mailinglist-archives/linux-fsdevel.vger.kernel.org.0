Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD46320C9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfEPQKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 12:10:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33231 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfEPQKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 12:10:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so3672619ljw.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 09:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJVoHOdwqPmtIGZYRe7rwFLvOITb6Eou9scimDVik8g=;
        b=JBL1tXAneD2P7JzHehKu6All1l+r9l2U+WQBkVg/moWc907ohcWYVQg0L+OHvLyG5O
         9tCXeL3wmQx1AWaJA5k8oJ2JLq3BU7IUhjxPXitYEdXkTp0CAkU/Dg9PgpirSWV4raFh
         lVG2cRQs3CIuRMTLQslyR3ys0dSb11KxtNDiOsM5k4jC8EP8TLD536D52rBC3T+yWhTd
         x0JGCgqgtMYQdCrGrgLh6GqR1RwAWRgk6RZdUyiLf/FzhCi5PzuJ39flRBKQT5qN0nQc
         OrUWWTdXk7i0rAdnt1erlK6esOWEDKMNI4DuDLZXOicGvtnY4xe57oydDwoReFgHXx3b
         4HiA==
X-Gm-Message-State: APjAAAWmmPUGFKIbA/zEqAI5HjttqnPXj+oIOyt3+RvydDy/fI6SZXHn
        e3uJNA+jyexoUj6CDJF/G5Lqs2POTW8Saa4KgbdMrA==
X-Google-Smtp-Source: APXvYqytsMIKpyzg6Sr7Ma0RrX3P9yIKHhEzTRRSX0gI9JlTBX9wZXbT94dI4qFs37peKTqIzS8XBfKzh47Ff2ccEeY=
X-Received: by 2002:a2e:2b81:: with SMTP id r1mr22861818ljr.138.1558023029982;
 Thu, 16 May 2019 09:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190430180111.10688-1-mcroce@redhat.com> <CAGXu5jJG1D6YvTaSY3hpB8_APmwe=rGn8FkyAfCGuQZ3O2j1Yg@mail.gmail.com>
In-Reply-To: <CAGXu5jJG1D6YvTaSY3hpB8_APmwe=rGn8FkyAfCGuQZ3O2j1Yg@mail.gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 16 May 2019 18:09:53 +0200
Message-ID: <CAGnkfhyjmpPAjQFpm-w3v0kMWTKRHTq5v6w0m9KScN2a7bMgeg@mail.gmail.com>
Subject: Re: [PATCH v5] proc/sysctl: add shared variables for range check
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 8:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Apr 30, 2019 at 11:01 AM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > In the sysctl code the proc_dointvec_minmax() function is often used to
> > validate the user supplied value between an allowed range. This function
> > uses the extra1 and extra2 members from struct ctl_table as minimum and
> > maximum allowed value.
> >
[...]
> >
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

Hi all,

just a ping about this patch. Any tought, suggestion, concern or criticism?

Regards,
-- 
Matteo Croce
per aspera ad upstream
