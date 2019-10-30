Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFA3CE9A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 11:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfJ3Ky5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 06:54:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39371 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfJ3Ky5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:54:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so2126301ljj.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 03:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtCKRSOH2wHBPxYWft32/SnJnhtK6FCm3n3b1weS2iw=;
        b=BAJsYTc/WnEx9YqK3Q0ZjZ4NLIwdz+jXTH4YfRpJ9sI9RvhB5+3oEy4JGzzu9ikMmj
         JBFxfCmjslc2gcgXJ8TUmf3+BQRpjtIMcUHEHm10Dbx9leMzPLpvUiu9ddeV3+iQwLbO
         aVM+FYR1044gIW56sLGDszs2pmd8cDBgBBeXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtCKRSOH2wHBPxYWft32/SnJnhtK6FCm3n3b1weS2iw=;
        b=sVbBCF3q9LMa0w0/+KiOjIUGUS0EqsXLu37+AMFhrGqbocTNGuDr9IGeYSbRT09HD9
         s0uemNQIZ696J4wr20sIkgOdJRVThjesySYQWmN1DQbIQnC+ouSzFu1a2wr6kmhS5L6h
         yRvtVWrUtKsGE5wEUky7lfTRt2Rt5WSlbjueraos8FYKSPqc3tq/tKMTJ0HA2IVV51Fe
         72yMKhmJ0XCuBT53zLQGFiGsvRNlFm3bT92yXmakTBmMOtxofloEgcBVIrX2fdVun4wx
         jVmtFCFw2XCE6JTYaaW4MrIuuGV8XOWWzieLUsW3USmcu6Hv9iQexjM0ZENgnwsEOi77
         hIEg==
X-Gm-Message-State: APjAAAWYDZLNkVe/rXcZADGbKViXKOtka5mdHUarew/IiLXKhP6SqUOa
        xOOb3wHfxX4jQbZPAyXgwQK5EwfekhDnCA==
X-Google-Smtp-Source: APXvYqzlrxz6OvI5qiirGT+9aeCbYm9ozkft74/bIBWGSMinG+aDx6N17cJLhwck1sZpQq/XLlG/fQ==
X-Received: by 2002:a2e:b5d4:: with SMTP id g20mr2343697ljn.140.1572432893395;
        Wed, 30 Oct 2019 03:54:53 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id g25sm923539ljk.36.2019.10.30.03.54.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 03:54:52 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id f5so1197546lfp.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 03:54:52 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr5783119lfc.79.1572432891872;
 Wed, 30 Oct 2019 03:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box> <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box> <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com> <f0140b13-cca2-af9e-eb4b-82eda134eb8f@redhat.com>
In-Reply-To: <f0140b13-cca2-af9e-eb4b-82eda134eb8f@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Oct 2019 11:54:35 +0100
X-Gmail-Original-Message-ID: <CAHk-=wh4SKRxKQf5LawRMSijtjRVQevaFioBK+tOZAVPt7ek0Q@mail.gmail.com>
Message-ID: <CAHk-=wh4SKRxKQf5LawRMSijtjRVQevaFioBK+tOZAVPt7ek0Q@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:35 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> NFS may be ok here, but it will break GFS2. There may be others too...
> OCFS2 is likely one. Not sure about CIFS either. Does it really matter
> that we might occasionally allocate a page and then free it again?

Why are gfs2 and cifs doing things wrong?

"readpage()" is not for synchrionizing metadata. Never has been. You
shouldn't treat it that way, and you shouldn't then make excuses for
filesystems that treat it that way.

Look at mmap, for example. It will do the SIGBUS handling before
calling readpage(). Same goes for the copyfile code. A filesystem that
thinks "I will update size at readpage" is already fundamentally
buggy.

We do _recheck_ the inode size under the page lock, but that's to
handle the races with truncate etc.

            Linus
