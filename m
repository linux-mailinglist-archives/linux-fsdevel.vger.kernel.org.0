Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DE13FBC83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 20:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhH3Sfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 14:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhH3Sfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:35:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BD1C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 11:34:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so128376pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=K3k7s0tk5eH6iPVl7FoiuOgyi60Lr2QqZx1htKYsqdo=;
        b=Zll8QDHW5Z29yxm1dJ36mXm8hA/F92MyD8wzv5OlJM77C3FFV/YuajMXfv0fTnSJxm
         ilQm43Dfo8Ktc4DvoctzUitEOlW4bDwMMNVF0yQTRjmyazG0ZSo54kPAyhut57BeAojR
         0rwR5NnZ2xvAhg0XkNQ6nwsoRoMt7c3BpG3KKCejGmaAZbxjtvWJ+rLtLEbelImB2+/S
         bTPk3SxRgLnqPEAycisuW3/keMaOlrWjMYKli33Btj6NL7SUblQHc81pWpLIGjw1UpYM
         aRzBfbwE9HSdSUQdeXsWuB0ca0wV0sHvHHrMZr8yHSicvLDheT1Jmkw7y5lUKLqD5MLe
         mUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=K3k7s0tk5eH6iPVl7FoiuOgyi60Lr2QqZx1htKYsqdo=;
        b=B8CScYWGVSbR1vOyWZkHpUF6zHSzmRxVNMVpcxnbXnSVyRR6w54dj3464Yl1aIenua
         KqYrZtXhtH5y4s36BxHaTjEvUv/TkoePAxESa+dPOtLI72x7PvEMBXZBE7GHYPx6EBDy
         s7Dl3Z7jGloLvZ8zlpJIFHzXuKrnbHU+/zexaZifCss6Bx13gjfVB1EB2pA18cW5YwGM
         Pi7a4GR5k1kgknQOVHTapd7q7T6T/V8KonWgXF76/ZQ/ceSevG3PkJRQ2slxWaqLrU0d
         Gp+KNFLtRyDdAA7d4RXXPay5rkblveLtkCeLFF9cvjSEhzNwPvkxdap6mBaozf+Gwb9L
         2uig==
X-Gm-Message-State: AOAM533YIsN/dkcJm7ch7f+twihM7bB1lcLPC0ElpgNfVIF9v7qe1Pwy
        /d4csOjCmo9B56Zn8xBsBQVnUA==
X-Google-Smtp-Source: ABdhPJyFbCGQkBJrHEYGqFicAoIw2y3LiDyPSfY74cnJhCzbjJ93dkAFlZHwQspdYcSmoLPdksybJA==
X-Received: by 2002:a17:902:c410:b0:138:ad8f:865b with SMTP id k16-20020a170902c41000b00138ad8f865bmr872993plk.79.1630348497479;
        Mon, 30 Aug 2021 11:34:57 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id w188sm14566273pfd.32.2021.08.30.11.34.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Aug 2021 11:34:56 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8FEED5A6-DABE-4F29-9C1F-95A1B2E20190@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CEB5A37B-2F31-4800-8BF9-FF29B194CBBA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Discontiguous folios/pagesets
Date:   Mon, 30 Aug 2021 12:35:05 -0600
In-Reply-To: <20210830182818.GA9892@magnolia>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
To:     "Darrick J. Wong" <djwong@kernel.org>
References: <YSqIry5dKg+kqAxJ@casper.infradead.org>
 <1FC3646C-259F-4AA4-B7E0-B13E19EDC595@dilger.ca>
 <20210830182818.GA9892@magnolia>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_CEB5A37B-2F31-4800-8BF9-FF29B194CBBA
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On Aug 30, 2021, at 12:28 PM, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> On Sat, Aug 28, 2021 at 01:27:29PM -0600, Andreas Dilger wrote:
>> On Aug 28, 2021, at 1:04 PM, Matthew Wilcox <willy@infradead.org> wrote:
>>> 
>>> The current folio work is focused on permitting the VM to use
>>> physically contiguous chunks of memory.  Both Darrick and Johannes
>>> have pointed out the advantages of supporting logically-contiguous,
>>> physically-discontiguous chunks of memory.  Johannes wants to be able to
>>> use order-0 allocations to allocate larger folios, getting the benefit
>>> of managing the memory in larger chunks without requiring the memory
>>> allocator to be able to find contiguous chunks.  Darrick wants to support
>>> non-power-of-two block sizes.
>> 
>> What is the use case for non-power-of-two block sizes?  The main question
>> is whether that use case is important enough to add the complexity and
>> overhead in order to support it?
> 
> For copy-on-write to a XFS realtime volume where the allocation extent
> size (we support bigalloc too! :P) is not a power of two (e.g. you set
> up a 4 disk raid5 with 64k stripes, now the extent size is 192k).
> 
> Granted, I don't think folios handling 192k chunks is absolutely
> *required* for folios; the only hard requirement is that if any page in
> a 192k extent becomes dirty, the rest have to get written out all the
> same time, and the cow remap can only happen after the last page
> finishes writeback.

OK, they are still multiples of PAGE_SIZE.  That wasn't clear, I thought
these were byte-granular IOs or something...

Cheers, Andreas






--Apple-Mail=_CEB5A37B-2F31-4800-8BF9-FF29B194CBBA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmEtJNkACgkQcqXauRfM
H+BMbg//WkPjoSqpO0uyJFtCnuPsruBwvQiUx/noIiD9R/7TPNFhjVPixtkm/LM9
yx09eEuDtlHFZs3j4ZCD/mBpyy8GR6nXi7pE7nXv6PgMMweEQ5vkyc+G5IwMLgyD
GQoDKAt5GG4yVvcYsNbd6jn6AFhj0nIZKD//OQL7oCqoqd6i9n7/W+pRt8nvOY/N
Lr6eOjRNwdg1jWCkr5FgO+F4zl1OG1NXZ5UCLOGNlT3KhQpVjfxyvsZCyhjQxpjx
reNZX3g2H6/6WWnBV+FAwlqh9G5mt8Fyh4Oqvt3i3nmYhwfJCIeMxM2i5i2O8EJG
2Gy8vxRRxFaBi2Nwh8R7Ne2BEL3YGwRPQzkWmC9s1ju6QhNdYjK62ZIHT34veBRE
3ehtF/xA0UISzVBwEkbY6HOVdfTVfUBxzKJwFsoceeerc4EdIymfeesANm31uLT8
yKFng+ZKBDodH6YhvxODf+wARzDBkrfXP1jMCvdvcvvab/uCYFpV2zeKBbj4DiAm
9d2MKIhbqXQiXjieAiJaXbAdg3zat8ajF9yuE1GM6I2bfXvBAhxdMnTwNtBKeZml
5vRNMlDiYMht0rdQY/aHPnTll6L7kExd9R5PjeVg75x57D3mdsVl/9N3Y9VVUAEr
8xWBdJ4RAuF3BON4LApuIFLEicxejOJo+8zKgEZNJGoSpGgCD8Y=
=dDZs
-----END PGP SIGNATURE-----

--Apple-Mail=_CEB5A37B-2F31-4800-8BF9-FF29B194CBBA--
