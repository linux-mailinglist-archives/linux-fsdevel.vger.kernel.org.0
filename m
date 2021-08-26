Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52D3F8160
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 06:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhHZEDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 00:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhHZEDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 00:03:05 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5366DC061757;
        Wed, 25 Aug 2021 21:02:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a21so1603824pfh.5;
        Wed, 25 Aug 2021 21:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Oxi9GUAjjrXy9o+mfocb/qAIFBiI2+i+SCUd2qrmcNw=;
        b=KBWp4VV/tma8GhuwcgInEq6+v0E/KDzWIAj4q6+lCzaMwhrcTIp4CAY5KfRn6FuEj6
         rlGE9NFn1zDx/GE3uRHKnVAckcviFbUHoxjtoGIq11g0rFx4wGGvPXYt9qSh2uo1TrTE
         BQcrWbOo6aQ2aol/fVg1Z56EyDujPB2TfTq/mwq4FTB4CYj9WboyQcbJi8fQzhyIqP4m
         eOskRNMFTUmun3l8A3PpKQpTPrvyJUG3m9idTpVOdNvaDQvhxavq3uMLRy3SpHRyQNf6
         BuRRDzskc/DcMZ44tS25C4LE773m60DLYZEd4BoVLZT+xMpqeCfgL5dbxCjv3qUizz12
         EbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Oxi9GUAjjrXy9o+mfocb/qAIFBiI2+i+SCUd2qrmcNw=;
        b=CcfzUrpeOPw7BL4oW0tKnwZYzU1ti9BPupJ3CrMGqF4ERH1JvmBoABgbNiSAsqZp4P
         I7Q/j0eBX7+scnkDQlQyyt92SPPc/8DKBgCNrJ52gY/O3IjrYF+wJsS8PJw0yng5wv9z
         7Cz+OCir5Tn2HKuc8N4gIBeLygO/3PkOMYhUJrFs6gnWFMqEZAoS1AEZShxfBdosryfo
         WVoc7IG6CIxJ0pkTdgyOxZ4jbBXz8JG2U1vX2SsBvE3AEFVgM5eeogei4unaE/XO5ZFk
         4Dck8qkouryFsV9+rEyzOM5S2pB1sv5xwUyu8jgLJQbgejgqHIBBvdVWmCz3e2CyvIja
         ZALQ==
X-Gm-Message-State: AOAM530SR4Vh7sUiDnJZJDlmzLSZePetW5rCXkpSC/qku0eSilXdNWIO
        fnslF0Mk9zcxxomcS1wl6sD5fbscecU=
X-Google-Smtp-Source: ABdhPJydBAdee6sGWXe83G6Ns/w8FokBMmc8JUE3YPOEccITJ0OIC4vkV+1jKPQfauwz8oDFC0Rj9Q==
X-Received: by 2002:a63:1504:: with SMTP id v4mr1529124pgl.151.1629950537851;
        Wed, 25 Aug 2021 21:02:17 -0700 (PDT)
Received: from localhost (193-116-119-33.tpgi.com.au. [193.116.119.33])
        by smtp.gmail.com with ESMTPSA id x40sm1078266pfh.145.2021.08.25.21.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 21:02:17 -0700 (PDT)
Date:   Thu, 26 Aug 2021 14:02:11 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
        <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
        <1957060.1629820467@warthog.procyon.org.uk>
        <YSUy2WwO9cuokkW0@casper.infradead.org>
        <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
        <YSVCAJDYShQke6Sy@casper.infradead.org>
        <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
        <YSVHI9iaamxTGmI7@casper.infradead.org> <YSVMMMrzqxyFjHlw@mit.edu>
        <YSXkDFNkgAhQGB0E@infradead.org>
In-Reply-To: <YSXkDFNkgAhQGB0E@infradead.org>
MIME-Version: 1.0
Message-Id: <1629948817.v8xwzejw2u.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Excerpts from Christoph Hellwig's message of August 25, 2021 4:32 pm:
> On Tue, Aug 24, 2021 at 03:44:48PM -0400, Theodore Ts'o wrote:
>> The problem is whether we use struct head_page, or folio, or mempages,
>> we're going to be subsystem users' faces.  And people who are using it
>> every day will eventually get used to anything, whether it's "folio"
>> or "xmoqax", we sould give a thought to newcomers to Linux file system
>> code.  If they see things like "read_folio()", they are going to be
>> far more confused than "read_pages()" or "read_mempages()".
>=20
> Are they?  It's not like page isn't some randomly made up term
> as well, just one that had a lot more time to spread.
>=20
>> So if someone sees "kmem_cache_alloc()", they can probably make a
>> guess what it means, and it's memorable once they learn it.
>> Similarly, something like "head_page", or "mempages" is going to a bit
>> more obvious to a kernel newbie.  So if we can make a tiny gesture
>> towards comprehensibility, it would be good to do so while it's still
>> easier to change the name.
>=20
> All this sounds really weird to me.  I doubt there is any name that
> nicely explains "structure used to manage arbitrary power of two
> units of memory in the kernel" very well.

Cluster is easily understandable to a filesystem developer as contiguous=20
set of one or more, probably aligned and sized to power of 2.  Swap=20
subsystem in mm uses it (maybe because it's disk adjacent, but it does=20
have page clusters) so mm developers would be fine with it too. Sadly
you might have to call it page_cluster to avoid confusion with block=20
clusters in fs then it gets a bit long.

Superpage could be different enough from huge page that implies one page=20
of a particular large size (even though some other OS might use it for=20
that), but a super set of pages, which could be 1 or more.

Thanks,
Nick
