Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BD73FA751
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 21:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhH1T2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 15:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhH1T2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 15:28:24 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77448C061756
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 12:27:33 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id y23so9209440pgi.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=pD4CPzXrcDO1ndsla+7M+YU0IOveDPUoeGSLQhEuSzU=;
        b=ANdSm2CKlWlRBh5vwq6Z9GjvKj0dCxGb4of/ThI0DxB7wgYZc6pvj+dh6DntTrV9IJ
         zlo8/sFQRrSqFEpsBsLUVG5sNfxYXXbVthFWrrTsqkmsVk547mD4MXThvOvvmklrlNkf
         ZcTlBk9U9znL6sWQQyXgLTkthaUveW0ww3JkKR46IkCjtOeTEh6bXStX/Yf0jUblWWIK
         ubvXqJvJWMn7UMyF30RIAxF8JZElPmR+ZMlDnKPdV2kBDfQngxO4MAIuQuV2XY/tzJ3+
         5zjCv0LAcLUbk40e/FT9NgVrVJs5opKFAnmaEgluIiysLK7XHC+klMLjq+FdC5abIhxW
         DdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=pD4CPzXrcDO1ndsla+7M+YU0IOveDPUoeGSLQhEuSzU=;
        b=ZR0JP7SzuVBW3Mg/E7uEOrotgA/cxk2XvwKKtWlGJNMoAH5hdeXEwbJiiXRzBWrd2S
         z5i0m+PkghrMPDEtpY+lDn1lwN81DvZBUR/h8uxlLiTvEZvwfJMyDkgc9mYc0xrBhTjd
         1gnL2I4aduf0DCHcjVmsChT1kXSS0SI/DLh8XRa6KZhpNsMxoJkntbowQWO3/YTld9hR
         LeTjTuj/t22MFBI8lsg0gqwZ4GAaDOWfaHWjIrlKJhdi4YV0TWswXqIye/vIdyzfk0Bq
         VV4wGcluW6YVwZEANyuvNFfRK1R06qjE3keiaJ2TKjCxWZCeZBQjeBKGl94ZD4BnR6xf
         9BcA==
X-Gm-Message-State: AOAM532yJ+wiAEcE1oV+Z5YS7tI78spcMR5UrJ9wpFv7KFXlc8d+1Vhs
        BS1xAgdkooPNQN6sBOJ82iW8jQ==
X-Google-Smtp-Source: ABdhPJyfNbe6hI0l0W/fJsQ9ouv9w9304gKlk8alUzmmjl2hHeYxYZdKxPBiMQrk7EVukWryDY9l1A==
X-Received: by 2002:a62:aa15:0:b0:3fb:9dd6:a95f with SMTP id e21-20020a62aa15000000b003fb9dd6a95fmr2549268pff.76.1630178852956;
        Sat, 28 Aug 2021 12:27:32 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id d20sm9709256pfu.36.2021.08.28.12.27.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Aug 2021 12:27:31 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1FC3646C-259F-4AA4-B7E0-B13E19EDC595@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6AEDCF03-E4CC-4258-B9ED-99A286279AC7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Discontiguous folios/pagesets
Date:   Sat, 28 Aug 2021 13:27:29 -0600
In-Reply-To: <YSqIry5dKg+kqAxJ@casper.infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
To:     Matthew Wilcox <willy@infradead.org>
References: <YSqIry5dKg+kqAxJ@casper.infradead.org>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_6AEDCF03-E4CC-4258-B9ED-99A286279AC7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Aug 28, 2021, at 1:04 PM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> The current folio work is focused on permitting the VM to use
> physically contiguous chunks of memory.  Both Darrick and Johannes
> have pointed out the advantages of supporting logically-contiguous,
> physically-discontiguous chunks of memory.  Johannes wants to be able to
> use order-0 allocations to allocate larger folios, getting the benefit
> of managing the memory in larger chunks without requiring the memory
> allocator to be able to find contiguous chunks.  Darrick wants to support
> non-power-of-two block sizes.

What is the use case for non-power-of-two block sizes?  The main question
is whether that use case is important enough to add the complexity and
overhead in order to support it?

Cheers, Andreas






--Apple-Mail=_6AEDCF03-E4CC-4258-B9ED-99A286279AC7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmEqjiEACgkQcqXauRfM
H+Awog/+IxByRyRvXouBeH71ySqebdd49O3ejyn09LUizb6hAPjoVM1KRwcP4URu
KOPb2QomhgCHOPLxnbTYDjQW1uZ4pfAK2YeWxF1SA/KpKytIi1Eot4Hb4e0brfIE
2KkaqZ9iwfuNggrsXPZzmTkouCieamt1+mg3iYKJV79pAhI+w71juShXPFi923Ax
R2fUnd0yxM7FChMSsgdxQe0akf0O1AXfx6Q8QBpVTUcXKqIiLk06ZLP9L3YCIR3+
KgzEbQQ6Gy3Md65mCikmXHtWJrXtbxrhieYl101o7I+BCwqYg1blxIyVW2dh2d4S
lrAulpVuJBbZpzbFuNXls5Z2TES0VG5hOkINEsGUoijryMS+zpo/rH5yyx1/5XAv
KzVNBXesMopDDSKSDX7zfogptHpSo08QS/XSEy/d769T6xBAnFqodzIR3/ZsgG5Q
VsuJf64BTotqnjz8lFRpsy6cZFbDEkXTScybZiTx0O4izfTzGNV74URoXm0tOKIq
Sbfu0M1boO2JWFeNkWH3dA5ndc2/ThwfnH57eFKM+7VFD0cTU1/YTUuMRvEZS/Wl
UReUOhwc9l/C1GXsSIRxpVRrdj3E2fxgw3U2tflr/bjpEwWwn2DFQXMlhDJxHWEh
/sL4K8hTkMcALxF3NC86ek/bfZYYwe0Xr4GII8zGkk3ASRcCHQ4=
=eN/o
-----END PGP SIGNATURE-----

--Apple-Mail=_6AEDCF03-E4CC-4258-B9ED-99A286279AC7--
