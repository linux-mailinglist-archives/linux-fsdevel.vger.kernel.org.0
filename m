Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BBF36A3F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 03:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhDYBoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Apr 2021 21:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhDYBoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Apr 2021 21:44:12 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21F2C061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Apr 2021 18:43:33 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id m13so53062396oiw.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Apr 2021 18:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MaH5IEF293uSN+4+Rm4iEauuL/yrDdZcYtSWoWCey0w=;
        b=cPXzYRhM2KmOwXunw9Ehc7BUtC22RDGrcl1fQWdXAuK8Hqd951e6mdRu6ALWYVTmJN
         RArctaIxdQPGXioo2pNlGEANRF8P21BvAK3SRnkTSc+d61gDMY5IgaKeFes9tksvplyZ
         vBH9CbVA4kpjRNanQf3RRUzUlFHNFEu0C9Uh7rsZfdoNbfnP4CJeWtOhbCyUYs1OedAU
         Xu/R5aqe4NweujC2v0Htj3BeXttUZxMxrZA3gW7sDXqxWHsW27oWI+qgaJAp7sfCAgRo
         MDMKGwtTezLV6WT0behi9zt96viuPLoiiLyRil4RFo3n6C2AkzLvNHq0MNlcyNPcnymN
         GDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaH5IEF293uSN+4+Rm4iEauuL/yrDdZcYtSWoWCey0w=;
        b=chSte6I8P6IgiuG50X3X6aCzR2gMxCLCxuN4+NGkhaMsKOaQY4R2LtkMBE+l3uQbSk
         QnChupaR0pRrIHj7iH8EEzJrYnUUL2gltxIw75k5Q5RIdD4Y+V3r32x7RHIvPbyPeIkX
         agIQLewawI2QTh3PKdNJqN81mLC4IArUWUqfwSTBsasT7ue7wwCUm30l3k/40EsEVL5C
         igIc9phjCOCG0qlfj5UAZTAsC6ChTaPDYe9Mt271ngBiG79PB7cSGrk4yivbPXmVIDx9
         dsHnuaeg8ecjGEdmWgTXr12kvXWcsNyH44H1HHmOruUu/UHuKo1hpGDV8aVDwd+peaeN
         aOgA==
X-Gm-Message-State: AOAM532kU4RlrfokugfzU+5fS9Fhp0glC3uWuFHIp9oMC8Tu2pEynh2U
        05qORnbvxSVPi+8TYbjaSiaEVJzKdZV5LqzHDnmVJA==
X-Google-Smtp-Source: ABdhPJz2L0cltSAslkNPHz7LuEFy1hZX7m+teq4aDz52He1Hbpn9osgEUTMisHmwT7WWLOlRxgvHye7Pbndqi0Pjv6U=
X-Received: by 2002:aca:ea06:: with SMTP id i6mr7745642oih.82.1619315011546;
 Sat, 24 Apr 2021 18:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210327035019.GG1719932@casper.infradead.org>
 <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
 <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
 <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org>
 <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com>
 <20210327155630.GJ1719932@casper.infradead.org> <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com>
 <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com>
 <1720948.1617010659@warthog.procyon.org.uk> <CAOg9mSTEepP-BjV85dOmk6hbhQXYtz2k1y5G1RbN9boN7Mw3wA@mail.gmail.com>
 <1268214.1618326494@warthog.procyon.org.uk> <CAOg9mSSxZUwZ0-OdCfb7gLgETkCJOd-9PCrpqWwzqXffwMSejA@mail.gmail.com>
 <1612829.1618587694@warthog.procyon.org.uk>
In-Reply-To: <1612829.1618587694@warthog.procyon.org.uk>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Sat, 24 Apr 2021 21:43:20 -0400
Message-ID: <CAOg9mSTwNKPdRMwr_F87YCeUyxT775pBd5WcewGpcwSZFVz5=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     David Howells <dhowells@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> What happens if bytes_remaining < PAGE_SIZE?

I think on a call where that occurs, new_len won't get set
and readahead_expand won't get called. I don't see how that's
not correct, but I question me more than I question you :-) ...

>> what happens if bytes_remaining % PAGE_SIZE != 0

I think bytes_remaining % PAGE_SIZE worth of bytes won't get read on
that call, but that the readahead callout keeps getting called until all
the bytes are read? After you asked this, I thought about adding 1 to
new_len in such cases, and did some tests that way, it seems to me like it
works out as is.

>> I wonder if you should use iov_length(&iter)

iov_length has two arguments. The first one would maybe be iter.iov and
the second one would be... ?

>> should you cache inode->i_size lest it change under you due to truncate

That seems important, but I can't return an error from the void
readahead callout. Would I react by somehow returning the pages
back to their original condition, or ?

Anywho... I see that you've force pushed a new netfs... I think you
have it applied to a linus-tree-of-the-day on top of 5.12-rc4?
I have taken these patches from
git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git (netfs-lib)

0001-iov_iter-Add-ITER_XARRAY.patch
0002-mm-Add-set-end-wait-functions-for-PG_private_2.patch
0003-mm-filemap-Pass-the-file_ra_state-in-the-ractl.patch
0004-fs-Document-file_ra_state.patch
0005-mm-readahead-Handle-ractl-nr_pages-being-modified.patch
0006-mm-Implement-readahead_control-pageset-expansion.patch
0007-netfs-Make-a-netfs-helper-module.patch
0008-netfs-Documentation-for-helper-library.patch
0009-netfs-mm-Move-PG_fscache-helper-funcs-to-linux-netfs.patch
0010-netfs-mm-Add-set-end-wait_on_page_fscache-aliases.patch
0011-netfs-Provide-readahead-and-readpage-netfs-helpers.patch
0012-netfs-Add-tracepoints.patch
0013-netfs-Gather-stats.patch
0014-netfs-Add-write_begin-helper.patch
0015-netfs-Define-an-interface-to-talk-to-a-cache.patch
0016-netfs-Add-a-tracepoint-to-log-failures-that-would-be.patch
0017-fscache-cachefiles-Add-alternate-API-to-use-kiocb-fo.patch

... and added them on top of Linux 5.12-rc8 and added my
readahead patch to that.

Now I fail one extra xfstest, I fail generic/075, generic/112,
generic/127, generic/263 and generic/438. I haven't found an
obvious (to me) problem with my patch and I can't claim to understand
everything that is going on in the patches I have of yours...

I'll keep looking...

-Mike

On Fri, Apr 16, 2021 at 11:41 AM David Howells <dhowells@redhat.com> wrote:
>
> In orangefs_readahead():
>
>         loff_t bytes_remaining = inode->i_size - readahead_pos(rac);
>         loff_t pages_remaining = bytes_remaining / PAGE_SIZE;
>
> What happens if bytes_remaining < PAGE_SIZE?  Or even what happens if
> bytes_remaining % PAGE_SIZE != 0?
>
>         if ((ret = wait_for_direct_io(ORANGEFS_IO_READ, inode,
>                         &offset, &iter, readahead_length(rac),
>                         inode->i_size, NULL, NULL, file)) < 0)
>
> I wonder if you should use iov_length(&iter) rather than
> readahead_length(rac).  They *should* be the same.
>
> Also, should you cache inode->i_size lest it change under you due to truncate?
>
> David
>
