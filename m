Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0ACAC1F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 23:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbfIFV1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 17:27:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40015 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388210AbfIFV1M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 17:27:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so4230879pgj.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zp8c9FLNMZEWCL0gNT+yehsPSnrA53ER9UiJIJvS9kA=;
        b=wX83E0tAgpuMSlrvnQlUEHKcpX5XUX5HJzrMkrU3esWVFeEgDzrhtcRT2QsymIDQOL
         xCt83E1f6ryxUP4gLRCutSrzRr/Tna7ygXnmUSDT9yN8LpuQvBVrXFGQdmUIsjcpk/b0
         zXv4wfPyEd18BNo3Xd+r0eYL/BjjJR3JgebuUMHkk4PTTtC6HWix/kD59iw7Ic702cgn
         nBRQMdQkY/5HHpGkbLtMEjwW/KHT9uSBbduiQRJ6PIrQ9VRHSs/Cr7A2OQD0JAO1K7I8
         QilkiX5g6C1AR/39podaVYWxBZildqnNLP+HkigAwuSw7WPQvP92rJZEl9QWQvkumq8J
         0ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zp8c9FLNMZEWCL0gNT+yehsPSnrA53ER9UiJIJvS9kA=;
        b=euAjM3Q1zilGrnEoUO7IYceLscTLSTJvzf7SI9tNhgP9k1GJo/mQoU8avQ9w54bxRa
         qpBa3u/J3Gh0pHW8Yo7ctoWkAwcmzV1RtnXE44gvmq6LA1kRanuC89e1ZDUprksXY3yO
         4o+3EnR9NCJw1nJbryTlpd2B2S48rxdgU+iw2SQxcKsYrPygXFJa2Gp0771v6bWRnwDJ
         qLzwmMwBUMIS4NsrYy8fPU2nNkrmYp4IS86mLeRWx8AhVRsg5fsYopPKe3+sml8JSr50
         yhZEO48KuwLw+s5gmObxgpfd+hXojaJumxfiqhSsPX1/H0RZ4fAb5eyQD017G8IxJaZf
         CgEQ==
X-Gm-Message-State: APjAAAWNd9urAB3SoZvEYnGxYQd65E6x4bbEz93o5kZyOZf7IkU1hXcg
        qIv4w5zvArdqtDncrOCpbM9Vlf0GXF0=
X-Google-Smtp-Source: APXvYqyUm6quYg3c6vRJijWkBpXGA45Rp2tgZqej7qLENQJHh5dHW8BIZnRuebMhjYIUsW66JyYq7A==
X-Received: by 2002:a65:4786:: with SMTP id e6mr9584057pgs.448.1567805231533;
        Fri, 06 Sep 2019 14:27:11 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:4069])
        by smtp.gmail.com with ESMTPSA id y15sm8992813pfp.111.2019.09.06.14.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 14:27:10 -0700 (PDT)
Date:   Fri, 6 Sep 2019 14:27:10 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: add ioctl for directly writing compressed data
Message-ID: <20190906212710.GI7452@vader>
References: <cover.1567623877.git.osandov@fb.com>
 <8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com>
 <20190905021012.GL7777@dread.disaster.area>
 <20190906181949.GG7452@vader>
 <20190906210717.GN7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906210717.GN7777@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 07, 2019 at 07:07:17AM +1000, Dave Chinner wrote:
> On Fri, Sep 06, 2019 at 11:19:49AM -0700, Omar Sandoval wrote:
> > On Thu, Sep 05, 2019 at 12:10:12PM +1000, Dave Chinner wrote:
> > > On Wed, Sep 04, 2019 at 12:13:26PM -0700, Omar Sandoval wrote:
> > > > From: Omar Sandoval <osandov@fb.com>
> > > > 
> > > > This adds an API for writing compressed data directly to the filesystem.
> > > > The use case that I have in mind is send/receive: currently, when
> > > > sending data from one compressed filesystem to another, the sending side
> > > > decompresses the data and the receiving side recompresses it before
> > > > writing it out. This is wasteful and can be avoided if we can just send
> > > > and write compressed extents. The send part will be implemented in a
> > > > separate series, as this ioctl can stand alone.
> > > > 
> > > > The interface is essentially pwrite(2) with some extra information:
> > > > 
> > > > - The input buffer contains the compressed data.
> > > > - Both the compressed and decompressed sizes of the data are given.
> > > > - The compression type (zlib, lzo, or zstd) is given.
> > 
> > Hi, Dave,
> > 
> > > So why can't you do this with pwritev2()? Heaps of flags, and
> > > use a second iovec to hold the decompressed size of the previous
> > > iovec. i.e.
> > > 
> > > 	iov[0].iov_base = compressed_data;
> > > 	iov[0].iov_len = compressed_size;
> > > 	iov[1].iov_base = NULL;
> > > 	iov[1].iov_len = uncompressed_size;
> > > 	pwritev2(fd, iov, 2, offset, RWF_COMPRESSED_ZLIB);
> > > 
> > > And you don't need to reinvent pwritev() with some whacky ioctl that
> > > is bound to be completely screwed up is ways not noticed until
> > > someone else tries to use it...
> > 
> > This is a good suggestion, thanks. I hadn't considered (ab?)using iovecs
> > in this way.
> 
> Yeah, it is a bit of API abuse to pass per-iovec context in the next
> iovec, but ISTR it being proposed in past times for other
> mechanisms. I think it's far better than a whole new filesystem
> private ioctl interface and structure to do what is effectively
> direct IO...
> 
> > One modification I'd make would be to put the encoding into the second
> > iovec and use a single RWF_ENCODED flag so that we don't have to keep
> > stealing from RWF_* every time we add a new compression
> > algorithm/encryption type/whatever:
> > 
> >  	iov[0].iov_base = compressed_data;
> >  	iov[0].iov_len = compressed_size;
> >  	iov[1].iov_base = (void *)IOV_ENCODING_ZLIB;
> >  	iov[1].iov_len = uncompressed_size;
> >  	pwritev2(fd, iov, 2, offset, RWF_ENCODED);
> > 
> > Making every other iovec a metadata iovec in this way would be a major
> > pain to plumb through the iov_iter and VFS code, though. Instead, we
> > could put the metadata in iov[0] and the encoded data in iov[1..iovcnt -
> > 1]:
> > 
> > 	iov[0].iov_base = (void *)IOV_ENCODING_ZLIB;
> > 	iov[0].iov_len = unencoded_len;
> > 	iov[1].iov_base = encoded_data1;
> > 	iov[1].iov_len = encoded_size1;
> > 	iov[2].iov_base = encoded_data2;
> > 	iov[2].iov_len = encoded_size2;
> >  	pwritev2(fd, iov, 3, offset, RWF_ENCODED);
> > 
> > In my opinion, these are both reasonable interfaces. The former allows
> > the user to write multiple encoded "extents" at once, while the latter
> > allows writing a single encoded extent from scattered buffers. The
> > latter is much simpler to implement ;) Thoughts?
> 
> Both reasonable, and I have no real concern about how it is done as
> long as the format is well documented and works for both read and
> write.
> 
> The only other thing I think we need to be careful of is that
> interface works with AIO (via the RWF flag) and the new uioring async
> interface  - I think thw RWF flag is all that is needed there). I
> think that's another good reason for taking the preadv2/pwritev2
> path, as that should all largely just work with the right iocb
> frobbing in the syscall context...

A symmetric interface for preadv2 would look something like this:

	iov[1].iov_base = encoded_data1;
	iov[1].iov_len = encoded_size1;
	iov[2].iov_base = encoded_data2;
	iov[2].iov_len = encoded_size2;
	preadv2(fd, iov, 3, offset, RWF_ENCODED);
	/*
	 * iov[0].iov_base gets filled in with the encoding flags,
	 * iov[0].iov_len gets filled in with unencoded length.
	 */

But, iov is passed as a const struct iovec *, so it'd be nasty to write
to it in the RWF_ENCODED case. Maybe we actually want to pass the
encoding information through an extra indirection. Something along the
lines of this for writes:

	struct encoded_rw {
		size_t unencoded_len;
		int compression;
		int encryption;
		...
	};
	
	struct encoded_rw encoded = {
		unencoded_len,
		ENCODED_RW_ZLIB,
	};
	iov[0].iov_base = &encoded;
	iov[0].iov_len = sizeof(encoded);
	iov[1].iov_base = encoded_data1;
	iov[1].iov_len = encoded_size1;
	iov[2].iov_base = encoded_data2;
	iov[2].iov_len = encoded_size2;
	pwritev2(fd, iov, 3, offset, RWF_ENCODED);

And similar for reads:

	struct encoded_rw encoded;
	iov[0].iov_base = &encoded;
	iov[0].iov_len = sizeof(encoded);
	iov[1].iov_base = encoded_data1;
	iov[1].iov_len = encoded_size1;
	iov[2].iov_base = encoded_data2;
	iov[2].iov_len = encoded_size2;
	preadv2(fd, iov, 3, offset, RWF_ENCODED);
	/* encoded gets filled in with the encoding information. */

I'll draft something with this interface.
