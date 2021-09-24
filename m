Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D766B416A68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 05:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbhIXD2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 23:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbhIXD2I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:28:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB85CC061574;
        Thu, 23 Sep 2021 20:26:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x7so16142025edd.6;
        Thu, 23 Sep 2021 20:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18+5whvcDDqdfxVcWTrxiz/OMweHZu0w3dsMvDPd2x0=;
        b=QeO0RCPobSsavCWYY1RbFVToa8iXjat5Qhm4VBQxlUm8I2uKeCUnUZqnUXZPWvTP3I
         3DkSgeXKY1Vt64niNrSkNlCd4fBfPVoA/UGBmSCZMmAoVvWUWiLpk4QXMB0w7kjeR4DZ
         0+BsnPbGwScxAb5hvUFXNw5mAyFEP6imQdbAYvmmKMqsd7QuiLKIlkXZ0dm+Ls9Pe30H
         Ac1b3UVSbo2CZwTPGiDFVSTZaomfC6ERWSf88p5yWuIuC2R9FQyBOI3Vgw31py0Tun6e
         3Cz2Zr0Umq4IAQIn1kMpdQPKZBuQKoeDNs12wOujkEONRU9qJoAuxbXO9D78tqXS4kCr
         cajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18+5whvcDDqdfxVcWTrxiz/OMweHZu0w3dsMvDPd2x0=;
        b=6XP3S/OwN79O+aSQAMsGo3RLapv25g56YARkgjZprtX62ETPI9kSe+cAkpZ+vKihtO
         tbqjg412RP7iCGoHD6e/TKQE+9T2ISsadJPbH+Xzql6jxs04jMZlHH65gEPpt0Ri7QXj
         LUFno5T4IkfzogYmRzgR6kjQeEn7HsSeqwazRlgKDumhP5iEo6jd00SNzqPyunJJ3quh
         66v0r23II2rXhtAhN0oKXeqVwayGZVBD5SxupP/rBmPjv07JaofWCVBCw9Qh/g1TLa28
         RbFFC9QTrGYZx6J3WQF5h7tm8/5DITVOk+LX9ciCncDZmxMGKkUXS8X67RdTl30ChRbg
         eDZQ==
X-Gm-Message-State: AOAM530wKJQiKWbRHI6M1LQ61CwY1gak5THlX2FUy0bbjUm8swX4Kkjv
        vvYtb98+FqCXEF8a7SB0roFzFcro5SNqc4dpv0Y=
X-Google-Smtp-Source: ABdhPJyTRNRz76PPApx+1focabGvQlQuAjrXjZcFxgXozpU4UGlOYiDD19uR1USNsAf/p6R92BCFoG9sqmBxkPq4bJ4=
X-Received: by 2002:a17:906:3f83:: with SMTP id b3mr2452641ejj.233.1632453994521;
 Thu, 23 Sep 2021 20:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <YUvWm6G16+ib+Wnb@moria.home.lan> <YUvzINep9m7G0ust@casper.infradead.org>
 <YUwNZFPGDj4Pkspx@moria.home.lan> <YUxnnq7uFBAtJ3rT@casper.infradead.org>
 <20210923124502.nxfdaoiov4sysed4@box.shutemov.name> <72cc2691-5ebe-8b56-1fe8-eeb4eb4a4c74@google.com>
 <CAHbLzkrELUKR2saOkA9_EeAyZwdboSq0HN6rhmCg2qxwSjdzbg@mail.gmail.com>
 <2A311B26-8B33-458E-B2C1-8BA2CF3484AA@nvidia.com> <77b59314-5593-1a2e-293c-b66e8235ad@google.com>
 <CAHbLzkp__irFweEZMEM-CMF_-XQpJcW1dNDFo=RnqaSTGtdJkg@mail.gmail.com> <YU0qdpbjK5Hdfk2p@casper.infradead.org>
In-Reply-To: <YU0qdpbjK5Hdfk2p@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 23 Sep 2021 20:26:22 -0700
Message-ID: <CAHbLzkpTXxzR7=5mYAOFfu0M2jN5cnvbQMHu3bTba8PSdRDSXg@mail.gmail.com>
Subject: Re: Mapcount of subpages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 6:32 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Sep 23, 2021 at 06:11:19PM -0700, Yang Shi wrote:
> > On Thu, Sep 23, 2021 at 4:49 PM Hugh Dickins <hughd@google.com> wrote:
> > > I believe Yang Shi is right insofar as the decision on whether it's worth
> > > queuing for deferred split is being done based on those subpage _mapcounts.
> > > That is a use I had not considered, and I've given no thought to how
> > > important or not it is.
> >
> > Anyway deferred split is anon THP specific. We don't have to worry
> > about this for file THP. So your suggestion about just counting total
> > mapcount seems feasible to me for file THP at least.
>
> But I think we probably *should* do deferred split for file THP.
> At the moment, when we truncate to the middle of a shmem THP, we try
> a few times to split it and then just give up.  We should probably try
> once and then queue it for deferred split.

Yes, probably. Anyway this doesn't need _mapcount of subpages.
