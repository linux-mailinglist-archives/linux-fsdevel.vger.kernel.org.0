Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4692543A1C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 21:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbhJYTmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 15:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237191AbhJYTj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635190656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9aAky+o+A3o8orvEWSZgWo8dAX6pVohf78faelvH+XE=;
        b=GnGMcLhE+usm1Nj2t2QZPQorJZ+Y/fs9IM0frnSNf8eHWuOAyialCV9EqU1CvjVe+GJMlP
        k6UBzcNeO2OF0NYXX/mIMDJ/JUB+5AH/BA7P/zhBpXuvyyXRnYpJyYEtgxbYI8BHb2TTLI
        MzXtSKiymcD/F4GRz/1L9PNJooI9zmY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-WqnWIqBAOZq_oKyWnyJ2sg-1; Mon, 25 Oct 2021 15:37:34 -0400
X-MC-Unique: WqnWIqBAOZq_oKyWnyJ2sg-1
Received: by mail-wm1-f70.google.com with SMTP id z20-20020a05600c221400b0032cb38a76a9so392117wml.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 12:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9aAky+o+A3o8orvEWSZgWo8dAX6pVohf78faelvH+XE=;
        b=QgtrgdkbZdOYmtnG14hXmQFjQJp3fE1Ipv8oc8ci8xiluJhNO6pzUmlt/1MnlvMRWy
         ojQVve5ywumEZzd+VlvkVfSlJDTh+MFXggRfxSZwC6oCGAfyRGpZFQFMHYGWb2/nC7Ks
         JeDYve75iXmnwDZy03kShk7ARtdS+upfgbVVx//vNNLpA65iAAIlI6iUvpXXF03icfED
         WNR64A6kZRkKTBDtbwyjzpByBGuxuXjCWfvKmkBcdIZXFrgDcoHoHApTJnIeyoJExMcB
         zYTrnK5IdKtq+PFr8q9MpXUE9fc5OnwokeZUJ7jqN1CM8u1x8JMpRUMSC1lLDOX3sdPI
         poGQ==
X-Gm-Message-State: AOAM5309DAapDGP8PEcY6WtoyrlZbIutlucuNzqUAUz5U5LH4bC+Cbkg
        EyYJH+5LtmoEEFsT8lLLx9rpUKSCdcGBy6dRMbRZuBINRwDhZWWHDV+Vc49NHcKNnIc4PJeArbw
        8Z7XbRpJlA/3a/sxEltvLK3yVE+JhS81DCfLhQ5wC+Q==
X-Received: by 2002:adf:e411:: with SMTP id g17mr24943044wrm.228.1635190653766;
        Mon, 25 Oct 2021 12:37:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4ZUW3Mo472pPGFPqydjyYBJNjFGoCJJfUViSULsVvl27H2hHnmzQ8wgBE36rQvAagQBtIOpD1/zpOLrWd37Q=
X-Received: by 2002:adf:e411:: with SMTP id g17mr24943016wrm.228.1635190653583;
 Mon, 25 Oct 2021 12:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk> <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com> <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
 <CAHc6FU7bpjAxP+4dfE-C0pzzQJN1p=C2j3vyXwUwf7fF9JF72w@mail.gmail.com>
 <YXE7fhDkqJbfDk6e@arm.com> <CAHc6FU5xTMOxuiEDyc9VO_V98=bvoDc-0OFi4jsGPgWJWjRJWQ@mail.gmail.com>
 <YXGexrdprC+NTslm@arm.com> <CAHc6FU7im8UzxWCzqUFMKOwyg9zoQ8OZ_M+rRC_E20yE5RNu9g@mail.gmail.com>
 <YXMFw34ZpW+CwlmI@arm.com>
In-Reply-To: <YXMFw34ZpW+CwlmI@arm.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 25 Oct 2021 21:37:22 +0200
Message-ID: <CAHc6FU43-n3tk+vvhXKCX+oyUu4x23-vh8pg18wRgYsB0rt+rA@mail.gmail.com>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 8:41 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Oct 21, 2021 at 08:00:50PM +0200, Andreas Gruenbacher wrote:
> > On Thu, Oct 21, 2021 at 7:09 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > This discussion started with the btrfs search_ioctl() where, even if
> > > some bytes were written in copy_to_sk(), it always restarts from an
> > > earlier position, reattempting to write the same bytes. Since
> > > copy_to_sk() doesn't guarantee forward progress even if some bytes are
> > > writable, Linus' suggestion was for fault_in_writable() to probe the
> > > whole range. I consider this overkill since btrfs is the only one that
> > > needs probing every 16 bytes. The other cases like the new
> > > fault_in_safe_writeable() can be fixed by probing the first byte only
> > > followed by gup.
> >
> > Hmm. Direct I/O request sizes are multiples of the underlying device
> > block size, so we'll also get stuck there if fault-in won't give us a
> > full block. This is getting pretty ugly. So scratch that idea; let's
> > stick with probing the whole range.
>
> Ah, I wasn't aware of this. I got lost in the call trees but I noticed
> __iomap_dio_rw() does an iov_iter_revert() only if direction is READ. Is
> this the case for writes as well?

It's the EOF case, so it only applies to reads:

        /*
         * We only report that we've read data up to i_size.
         * Revert iter to a state corresponding to that as some callers (such
         * as the splice code) rely on it.
         */
        if (iov_iter_rw(iter) == READ && iomi.pos >= dio->i_size)
                iov_iter_revert(iter, iomi.pos - dio->i_size);

Andreas

