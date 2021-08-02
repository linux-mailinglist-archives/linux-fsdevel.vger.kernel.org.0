Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AA93DE234
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 00:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhHBWLZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 18:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhHBWLZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:11:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F9476054F;
        Mon,  2 Aug 2021 22:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627942275;
        bh=MNUeBv9ft0RetGTZOlxcl7eTzXfcUZrSdI1kZW4bs8Q=;
        h=Date:From:To:Cc:Subject:From;
        b=lNeRU9LWMtuPdcxfrzLFogG8H0lDUaXVUqfKVdYP8ESHS9VlNn0nRQYzjojXFiuJL
         zmuhtVZO0hsZ2ZXEwyweI5Y8QfBW1qGqFI3tXRr1d7gThfj18O4eEo7US+gR2zsV4p
         YWjFiBDqwVFyZ+O6VxgGW9ptpvgJyJ747+BZko1CEkirHM9SqjnbTcVxo6nOtZy5y3
         /aH/m4Ab5O8aL7UYigGUtX4NoKKWOobckHhhkarGa/ptFA+zI7TqdaApKPPdRjZhQM
         a+V5Xaaxx8QS1z+cdhYYwfcia3IErl4H2VM6Z54Ck8e/j0xyL/4pin3VJmtAazIH1w
         dPKtTTReJr5Wg==
Date:   Mon, 2 Aug 2021 15:11:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: iomap 5.15 branch construction ...
Message-ID: <20210802221114.GG3601466@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi everyone!

iomap has become very popular for this cycle, with seemingly a lot of
overlapping patches and whatnot.  Does this accurately reflect all the
stuff that people are trying to send for 5.15?

1. So far, I think these v2 patches from Christoph are ready to go:

	iomap: simplify iomap_readpage_actor
	iomap: simplify iomap_add_to_ioend

2. This is the v9 "iomap: Support file tail packing" patch from Gao,
with a rather heavily edited commit:

	iomap: support reading inline data from non-zero pos

Should I wait for a v10 patch with spelling fixes as requested by
Andreas?  And if there is a v10 submission, please update the commit
message.

3. Matthew also threw in a patch:

	iomap: Support inline data with block size < page size

for which Andreas also sent some suggestions, so I guess I'm waiting for
a v2 of that patch?  It looks to me like the last time he sent that
series (on 24 July) he incorporated Gao's patch as patch 1 of the
series?

4. Andreas has a patch:

	iomap: Fix some typos and bad grammar

which looks more or less ready to go.

5. Christoph also had a series:

	RFC: switch iomap to an iterator model

Which I reviewed and sent some comments for, but (AFAICT) haven't seen a
non-RFC resubmission yet.  Is that still coming for 5.15?

6. Earlier, Eric Biggers had a patchset that made some iomap changes
ahead of porting f2fs to use directio.  I /think/ those changes were
dropped in the latest submission because the intended use of those
changes (counters of the number of pages undergoing reads or writes,
iirc?) has been replaced with something simpler.  IOWs, f2fs doesn't
need any iomap changes for 5.15, right?

7. Andreas also had a patchset:

	gfs2: Fix mmap + page fault deadlocks

That I've left unread because Linus started complaining about patch 1.
Is that not going forward, then?

So, I /think/ that's all I've received for this next cycle.  Did I miss
anything?  Matthew said he might roll some of these up and send me a
pull request, which would be nice... :)

--D
