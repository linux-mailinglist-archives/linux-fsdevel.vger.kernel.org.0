Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1E0AE8D50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 17:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfJ2Qw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 12:52:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41599 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfJ2Qw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:52:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id m9so6385235ljh.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCP0gTNW0nrKOjfGXUDHkeT9LXYh8gTwBFSl8WQWe9E=;
        b=PCQcPN9krk/MLfnozI5e+YmrRxCY8nQ2YUphNRQ+Q7PWvraCFUevYyKeC3hb6cSU+E
         ptoftGM6aIVugo0NJ5Sj7+8ikD83EWAw+XBoNW6982A8TmkIVBVLCjVZXretXxGE0hIE
         uxSzFEmOYqjXztMzAKG2M3avS6nE/p3Mb230Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCP0gTNW0nrKOjfGXUDHkeT9LXYh8gTwBFSl8WQWe9E=;
        b=J277m49cFwovqiejFyqSlcGDdtE6p4tiemVniZRuhyWxSWAAr9FGB+iQFntWC9wRdZ
         62G81/0iY3kU15+b1j2tEDkPilUeOT/fWOI/2OcabvojqBRZUgtETO4rt5KgsUBO/Cze
         0y92dKjWjoryGn6AjTFCZJFirZYyoxZeGzybnmIzaeMWktZBxQVC3L43iFMMcmFDQv9v
         jFaHcnalFpXAsX/ZbQeYl9ShXwAbiY9JUz4+uJZDP4yBxlt7gPWiceMn2PAAjQbsZRw/
         1tKAooabH46NuAML8JWS63rajvqIHlueoAnhP0+CnCCkuQe+4qk0L9fmksMqYhamfCo/
         VFLw==
X-Gm-Message-State: APjAAAVUHc7vNwi2ptIVVPdyUcUkuvKZlanvwswJeaQ9K7b59WDGm6s8
        WYs1iG1+P/rQla0ZNL2MoEAc7OxfEADvxg==
X-Google-Smtp-Source: APXvYqzN9nFbbdVISSQz74kq0DmK1FDtMdtEuswBevN8fZR+vqC+c1LyxDAqQIpBtihKXYc4ojnVuA==
X-Received: by 2002:a2e:9942:: with SMTP id r2mr3448881ljj.168.1572367943055;
        Tue, 29 Oct 2019 09:52:23 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id r19sm769343lfi.13.2019.10.29.09.52.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 09:52:22 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id q28so11074503lfa.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 09:52:21 -0700 (PDT)
X-Received: by 2002:a19:820e:: with SMTP id e14mr3088342lfd.29.1572367941598;
 Tue, 29 Oct 2019 09:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box> <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box> <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
In-Reply-To: <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Oct 2019 17:52:05 +0100
X-Gmail-Original-Message-ID: <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
Message-ID: <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 29, 2019 at 3:25 PM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> I think all network filesystems which synchronize metadata lazily should be
> marked. For example as "SB_VOLATILE". And vfs could handle them specially.

No need. The VFS layer doesn't call generic_file_buffered_read()
directly anyway. It's just a helper function for filesystems to use if
they want to.

They could (and should) make sure the inode size is sufficiently
up-to-date before calling it. And if they want something more
synchronous, they can do it themselves.

But NFS, for example, has open/close consistency, so the metadata
revalidation is at open() time, not at read time.

               Linus
