Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5869F3F97C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 12:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbhH0KCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 06:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244753AbhH0KCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:02:31 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF321C0613D9
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 03:01:42 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 2so320572qtw.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rQfDhKdyv4fg+r/Y8tJRlauQXOHaMeoAScvmzQy4FHs=;
        b=RTLv6h70dh2KQII/tDH9L9yJ8miO9zpfOpvNplcUXADClA/t4d04/dUTNNJuQ3shw7
         cizitKFTo0u79Z/fmo8Ln2MzW97bK94RB1e0dJizK4fFMqJTyT1WYhAiMn6IIshUXs3p
         NBvDuATr9/eQf0W6A8AsuNdaLBwYcklIw9yWyR5a9Dj90sit/Oa4s2DBKB9XcaJyj3X9
         tfzrB1/Rqbb2/O8RwETIUQVk9gSJ2brJd9NkuFvst0k7e1vSxkdoqC+jEz7KI691SSv9
         pJqiEDWUJI5KjpFTHzOkrKEWPpUebnJ/6n6TJrckDM/JI2+cwSxa0AAmXl3iSIUoj7fm
         PUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rQfDhKdyv4fg+r/Y8tJRlauQXOHaMeoAScvmzQy4FHs=;
        b=WM9cCEKKGVcMrqM22Vt+hqD9RTqo1WzVNoZHteXUzgZHP3Yzbz7Apt/4lm76lbYLb7
         UO+sNOvwphFj8BD67qLIlgSNh/E+7Jwva0FG6dgf8u+XT57NfgiN4s9ZF2xIMD2iMtd8
         /1fFHkT+UACXd4uU3M1s1Xby7PmC4x0gWshewr2srudyCKzqIE+B3wDM0DE0CdYp2Lcp
         MZRhExWc9njSI1Hh3OV9pWOBX4VHnJ4/IIdqGSisFe4VnC5nsquhas0j7uOWgx06TFgE
         E2GlBgTOG44VILatCoZc8e0ftvp4VWU9xewD20uiw6SLx2gVi2/uzcmiLX8qWLgpU6Kg
         k/3Q==
X-Gm-Message-State: AOAM533c2WZjYOTyuLFUxBU7o7X5U6iVsI0NWdCbdwq+Htcu9SplD3gs
        /eUA6I/+jMjtKWEr3w5SrW/qDg==
X-Google-Smtp-Source: ABdhPJxruXx9GN4mVk4E4paeBiocZ9oJrlEkYPFAGDlecOWvONIdfZd+D1u3UtfMc1kCEo/fHEq7pw==
X-Received: by 2002:a05:622a:13d3:: with SMTP id p19mr3218319qtk.61.1630058501778;
        Fri, 27 Aug 2021 03:01:41 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id c11sm3330069qth.29.2021.08.27.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 03:01:40 -0700 (PDT)
Date:   Fri, 27 Aug 2021 06:03:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSi4bZ7myEMNBtlY@cmpxchg.org>
References: <YSZeKfHxOkEAri1q@cmpxchg.org>
 <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org>
 <2101397.1629968286@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2101397.1629968286@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 26, 2021 at 09:58:06AM +0100, David Howells wrote:
> One thing I like about Willy's folio concept is that, as long as everyone uses
> the proper accessor functions and macros, we can mostly ignore the fact that
> they're 2^N sized/aligned and they're composed of exact multiples of pages.
> What really matters are the correspondences between folio size/alignment and
> medium/IO size/alignment, so you could look on the folio as being a tool to
> disconnect the filesystem from the concept of pages.
>
> We could, in the future, in theory, allow the internal implementation of a
> folio to shift from being a page array to being a kmalloc'd page list or
> allow higher order units to be mixed in.  The main thing we have to stop
> people from doing is directly accessing the members of the struct.

In the current state of the folio patches, I agree with you. But
conceptually, folios are not disconnecting from the page beyond
PAGE_SIZE -> PAGE_SIZE * (1 << folio_order()). This is why I asked
what the intended endgame is. And I wonder if there is a bit of an
alignment issue between FS and MM people about the exact nature and
identity of this data structure.

At the current stage of conversion, folio is a more clearly delineated
API of what can be safely used from the FS for the interaction with
the page cache and memory management. And it looks still flexible to
make all sorts of changes, including how it's backed by
memory. Compared with the page, where parts of the API are for the FS,
but there are tons of members, functions, constants, and restrictions
due to the page's role inside MM core code. Things you shouldn't be
using, things you shouldn't be assuming from the fs side, but it's
hard to tell which is which, because struct page is a lot of things.

However, the MM narrative for folios is that they're an abstraction
for regular vs compound pages. This is rather generic. Conceptually,
it applies very broadly and deeply to MM core code: anonymous memory
handling, reclaim, swapping, even the slab allocator uses them. If we
follow through on this concept from the MM side - and that seems to be
the plan - it's inevitable that the folio API will grow more
MM-internal members, methods, as well as restrictions again in the
process. Except for the tail page bits, I don't see too much in struct
page that would not conceptually fit into this version of the folio.

The cache_entry idea is really just to codify and retain that
domain-specific minimalism and clarity from the filesystem side. As
well as the flexibility around how backing memory is implemented,
which I think could come in handy soon, but isn't the sole reason.
