Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26469ABF49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 20:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395327AbfIFSTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 14:19:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44315 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730881AbfIFSTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:19:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so3908680pgl.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EUmWS9lL8CScD6T71EGXevEnPMn/Vfly3HdRvbtdM8U=;
        b=HYJ9De48qK6Y+6o4uucU+lgCjbliE0cb1V0eNmJ3NOyygFQ2gZjZ6+GGbk+eP20ffc
         h58gYfzMLss0hx278f3xXWJrg/1kQkc0WoEOuFFVdvNKBIVxW06ESDETybb3ixFaMJhE
         LuwhaiPabUwxYGIE4Ckcfe7Js0S/OwJMDyl9QtwsWbk1lSD+UjTu4EOtf699punllEto
         pTKvCvkWlcZvjfldZaONWi77OugbZ+8GaBYAsdo9eNm7AdT2cQIwa/Xwns47sQdOt6kv
         JB66a+HSXAeInkGn8xcxnCJ/ZOLB0d+nZKz9IeNfI+lOZT/lQ2Z5vHW+HE6NdkFbEEWi
         sXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EUmWS9lL8CScD6T71EGXevEnPMn/Vfly3HdRvbtdM8U=;
        b=dvIHlKyQRzmb99ntpguXCOa2/paMdyf5erEuCHeyTBscIiT9sUhePvuSAjpRf/D0Ek
         d8d3uT780OHSKaoV09HCj3sl3mzJDE4z1ejVfTcrHQL7ZgMnsYtrsoelIEYBANTUG7O9
         IKillEST7Ei6t2/ntFRt23XjpAgLU8QFAOLiAGI7dqyEqTFPh6BqAnSWij6VIfXnv65e
         5ZL+yX8+ZE0U9ZxEssTzVKCWjrOUqD7v88iU/btcUUIQrL1Rmd6JakgThz4EXnhTKgZJ
         UOp9cQbaHOuAbFj20kXeLyB7ZbFZ3XOOu4JIkBiP4AFt7jCUIHCrl7DoOX5imcIpkhmT
         KGuQ==
X-Gm-Message-State: APjAAAVCXeFJvLyrGGXAXOwxFWCwpWpKtnbabNfkzytb3LRW08B1455i
        NbwPAmezE5+yRqHPJehISagCDg==
X-Google-Smtp-Source: APXvYqyYJOpis5AFTUOCiGhdeIEZS0XBc4BSrxFv1Y3FisMf/4EDKY7vAw/hGsS3bpyPbosA9RhSWg==
X-Received: by 2002:a17:90a:284c:: with SMTP id p12mr11382801pjf.87.1567793990407;
        Fri, 06 Sep 2019 11:19:50 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:4069])
        by smtp.gmail.com with ESMTPSA id c6sm4773763pgd.66.2019.09.06.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 11:19:49 -0700 (PDT)
Date:   Fri, 6 Sep 2019 11:19:49 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: add ioctl for directly writing compressed data
Message-ID: <20190906181949.GG7452@vader>
References: <cover.1567623877.git.osandov@fb.com>
 <8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com>
 <20190905021012.GL7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905021012.GL7777@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 12:10:12PM +1000, Dave Chinner wrote:
> On Wed, Sep 04, 2019 at 12:13:26PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This adds an API for writing compressed data directly to the filesystem.
> > The use case that I have in mind is send/receive: currently, when
> > sending data from one compressed filesystem to another, the sending side
> > decompresses the data and the receiving side recompresses it before
> > writing it out. This is wasteful and can be avoided if we can just send
> > and write compressed extents. The send part will be implemented in a
> > separate series, as this ioctl can stand alone.
> > 
> > The interface is essentially pwrite(2) with some extra information:
> > 
> > - The input buffer contains the compressed data.
> > - Both the compressed and decompressed sizes of the data are given.
> > - The compression type (zlib, lzo, or zstd) is given.

Hi, Dave,

> So why can't you do this with pwritev2()? Heaps of flags, and
> use a second iovec to hold the decompressed size of the previous
> iovec. i.e.
> 
> 	iov[0].iov_base = compressed_data;
> 	iov[0].iov_len = compressed_size;
> 	iov[1].iov_base = NULL;
> 	iov[1].iov_len = uncompressed_size;
> 	pwritev2(fd, iov, 2, offset, RWF_COMPRESSED_ZLIB);
> 
> And you don't need to reinvent pwritev() with some whacky ioctl that
> is bound to be completely screwed up is ways not noticed until
> someone else tries to use it...

This is a good suggestion, thanks. I hadn't considered (ab?)using iovecs
in this way.

One modification I'd make would be to put the encoding into the second
iovec and use a single RWF_ENCODED flag so that we don't have to keep
stealing from RWF_* every time we add a new compression
algorithm/encryption type/whatever:

 	iov[0].iov_base = compressed_data;
 	iov[0].iov_len = compressed_size;
 	iov[1].iov_base = (void *)IOV_ENCODING_ZLIB;
 	iov[1].iov_len = uncompressed_size;
 	pwritev2(fd, iov, 2, offset, RWF_ENCODED);

Making every other iovec a metadata iovec in this way would be a major
pain to plumb through the iov_iter and VFS code, though. Instead, we
could put the metadata in iov[0] and the encoded data in iov[1..iovcnt -
1]:

	iov[0].iov_base = (void *)IOV_ENCODING_ZLIB;
	iov[0].iov_len = unencoded_len;
	iov[1].iov_base = encoded_data1;
	iov[1].iov_len = encoded_size1;
	iov[2].iov_base = encoded_data2;
	iov[2].iov_len = encoded_size2;
 	pwritev2(fd, iov, 3, offset, RWF_ENCODED);

In my opinion, these are both reasonable interfaces. The former allows
the user to write multiple encoded "extents" at once, while the latter
allows writing a single encoded extent from scattered buffers. The
latter is much simpler to implement ;) Thoughts?

> I'd also suggest atht if we are going to be able to write compressed
> data directly, then we should be able to read them as well directly
> via preadv2()....
> 
> > The interface is general enough that it can be extended to encrypted or
> > otherwise encoded extents in the future. A more detailed description,
> > including restrictions and edge cases, is included in
> > include/uapi/linux/btrfs.h.
> 
> No thanks, that bit us on the arse -hard- with the clone interfaces
> we lifted to the VFS from btrfs. Let's do it through the existing IO
> paths and write a bunch of fstests to exercise it and verify the
> interface's utility and the filesystem implementation correctness
> before anything is merged.
> 
> > The implementation is similar to direct I/O: we have to flush any
> > ordered extents, invalidate the page cache, and do the io
> > tree/delalloc/extent map/ordered extent dance.
> 
> Which, to me, says that this should be a small bit of extra code
> in the direct IO path that skips the compression/decompression code
> and sets a few extra flags in the iocb that is passed down to the
> direct IO code.
> 
> We don't need a whole new IO path just to skip a data transformation
> step in the direct IO path....

Eh, at least for Btrfs, it's much hairier to retrofit this onto the mess
of callbacks that is __blockdev_direct_IO() than it is to have a
separate path. But that doesn't affect the interface, and other
filesystems may be able to share more code with the direct IO path.
