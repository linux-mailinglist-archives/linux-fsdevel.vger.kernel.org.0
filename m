Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA84B38E44A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 12:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhEXKpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 06:45:34 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39445 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232422AbhEXKpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 06:45:33 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 293055C00E0;
        Mon, 24 May 2021 06:44:05 -0400 (EDT)
Received: from imap38 ([10.202.2.88])
  by compute3.internal (MEProxy); Mon, 24 May 2021 06:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        williammanley.net; h=mime-version:message-id:date:from:reply-to
        :to:cc:subject:content-type; s=fm3; bh=/W3r2ZsBs1R/xUKNF3ES+WT4X
        MT4SUaIH3uCSOJxyO8=; b=A35FqJjbbXAhngZap2uN4+eSwAj9VHNLEfAYKyqEH
        +dI+m3EwgwYq7fqJNrVwu56+dYfDtjbjfxsmPdR0Js1iArDGK1AlUKuP9Fn0WeuM
        MbKhdQJboJWLsnzJIZ47GFPRqj2mQcUR9JotCmtTSbhBHflF8SUnTTFBqGI7WZ6d
        5+2NusztXe9ZB/phbCL3sf+zpLZS1Q0Y41AF+7wSof26jHXTwRur1W98aS5VIa7V
        Y2MA6xR0lz/JHlSvkh0qxhRAbNzvGzOytuR3ntbsp5WnUObXYzpnD4AA79w2UYMz
        xokPIw1ckA8kgaWD0BV/Z9lvFnkqkr4MyG2C4XITzSEVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:reply-to:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/W3r2ZsBs1R/xUKNF
        3ES+WT4XMT4SUaIH3uCSOJxyO8=; b=Xt6gHh5wb1vikgm+nArxd4B9TY3nGxnyd
        LhuxTk4CdgVlzEtPBiI91NijF7/llEe0U/k2E3Ev50thhlNcbY4D1a1gthS+Sf0z
        WIeN6a/15WR44x5HCS30O6TQhmDB0MA9+xk/C4NJVbLbxQ9fR+bnMkUr0XdhKw5+
        pfIx2N6YsOY+mH/EELY2GJNpxecovdzTGdb8n7FbOhXi43Vte6mQUrNHNoTgfOwy
        BuC/a5f86sZq7ngFd9pMm7WAwFjqxOky3A8TuAHLOGRl77GZonBc+jKPER1Awpc6
        Fg6U+NmTZ/FOndbBtoeoy4mh6/+13frRosXb2enh0JiW2QMh9H+8w==
X-ME-Sender: <xms:dIOrYOG5ERlqBK7qsND-bsoYhpX6ybhAOT1Zl2T-JoSNSKpTKdz6sw>
    <xme:dIOrYPVm7lpM7qmqgP27Bw2tOi6WgKA6DHNcHJ4J7akwPI2FHe5W1S0RMjoBuQ6SW
    LElbYK2jmfuv5lP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhrhfvufgtsehttdertderredtnecuhfhrohhmpedfhghilhhl
    ucforghnlhgvhidfuceofihilhhlseifihhllhhirghmmhgrnhhlvgihrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpefffefgkeffteekhfelueeuteffleeitdfgkeeiieeljeffueej
    keeftedvveeuhfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfihilhhlseifihhllhhirghm
    mhgrnhhlvgihrdhnvght
X-ME-Proxy: <xmx:dIOrYIJMPj-9_QryQir3k0G-qfNrlwRrD3GQybNONIE6sRWluEhvOA>
    <xmx:dIOrYIHL_m6JLa6XEYQI1Q_bWcKsz9_GtEri1xJxrdbWWm_yccNuuA>
    <xmx:dIOrYEVQguLSLRlkKjXeVwoTaE7BmvOfyIqCDh8EbJhLOnAcaIWzuA>
    <xmx:dYOrYOc07fl-4RWA8Gb0KetrfKGnccMu9rjtRgD4qRUPmG-97AZmoA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8CF7ACA005E; Mon, 24 May 2021 06:44:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <fea8b16d-5a69-40f9-b123-e84dcd6e8f2e@www.fastmail.com>
Date:   Mon, 24 May 2021 11:42:52 +0100
From:   "Will Manley" <will@williammanley.net>
Reply-To: will@williammanley.net
To:     linux-fsdevel@vger.kernel.org
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Jens Axboe" <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        "Alice Ryhl" <alice@ryhl.io>, br0adcast <br0adcast.007@gmail.com>
Subject: BUG: preadv2(.., RWF_NOWAIT) returns spurious EOF
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All

We've seen preadv2(..., -1, RWF_NOWAIT) return 0 when at offset 4096 in a file much larger than 4096B.  This breaks code that reads an entire file because the 0 return makes it believe that it's already read the whole file. We came across this when investigating a bug reported against the Rust async I/O library tokio. The latest release now takes advantage of RWF_NOWAIT for file I/O, but it's caused problems for users.

https://github.com/tokio-rs/tokio/issues/3803

The issue is readily reproducible. We've tested on armv7, i686 and x86_64 with the ext4 filesystem.  Here's the strace output:

preadv2(9, [{iov_base=..., iov_len=32}], 1, -1, RWF_NOWAIT) = 32
preadv2(9, [{iov_base=..., iov_len=32}], 1, -1, RWF_NOWAIT) = 32
preadv2(9, [{iov_base=..., iov_len=64}], 1, -1, RWF_NOWAIT) = 64
preadv2(9, [{iov_base=..., iov_len=128}], 1, -1, RWF_NOWAIT) = 128
preadv2(9, [{iov_base=..., iov_len=256}], 1, -1, RWF_NOWAIT) = 256
preadv2(9, [{iov_base=..., iov_len=512}], 1, -1, RWF_NOWAIT) = 512
preadv2(9, [{iov_base=..., iov_len=1024}], 1, -1, RWF_NOWAIT) = 1024
preadv2(9, [{iov_base=..., iov_len=2048}], 1, -1, RWF_NOWAIT) = 2048
preadv2(9, [{iov_base="", iov_len=4096}], 1, -1, RWF_NOWAIT) = 0

I'm not certain that it's caused by the offset being 4096.  Maybe it's that the data will be written into an uncommitted page causes the bug? I'm not certain.

The bug is present in Linux 5.9 and 5.10, but was fixed in Linux 5.11.  I've run a bisect and it was introduced in 

    efa8480a831 fs: RWF_NOWAIT should imply IOCB_NOIO

and fixed in

    06c0444290 mm/filemap.c: generic_file_buffered_read() now uses find_get_pages_contig

This is already fixed but I thought it would be important to report it as the fix seems to be incidental.  The fix commit message doesn't mention anything about bugs so I wonder if the underlying issue still exists.

Our current plan is to add a uname check and to disable using the RWF_NOWAIT optimisation on 5.9 and 5.10.  Given that we don't understand the bug I thought it would be best to check with you. Maybe there's a better way of detecting the presence of this bug?

There's more information at https://github.com/tokio-rs/tokio/issues/3803

Thanks

Will
