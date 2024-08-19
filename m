Return-Path: <linux-fsdevel+bounces-26281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41FC95708D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFCB2832F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 16:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F06177982;
	Mon, 19 Aug 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="he7M3R6G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0E13211A;
	Mon, 19 Aug 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085592; cv=none; b=PnuNTD+VklC5TCOgH9xXaWr2Rs2qKiCuBED8ta/JDFTgdXTAhpmOGUvZONiKbUW4uP+uNJ2dOm/0DGG0kXabI33TtuMoggWGraRSm0vEBajZNfQqQR37Bce3pRB+PTnn7K+tDJFBGi5n1SEUHEcJguXTZl6qYjgtwYIpD8eAqTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085592; c=relaxed/simple;
	bh=T59eX/EsBUKmee77GmmGHgFUj/XXmuXJCIw/1ikkTww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2ZMmznm13yyOshYC0OrrZGMTsUbGShdki7Ru/6pbNNibtr05o6q4BZJ6gZcAsqh5szzSaLruXIK0GfuVv6cPxU9amZwcWQIF2d/SHWjtKpZ2HuFOawx2pQr7/065fAaPYQuJoSQ9CGU4Acmvkf+Qqxu0SySib/i6zqA8XQGP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=he7M3R6G; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Wndc12bHsz9sjQ;
	Mon, 19 Aug 2024 18:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724085585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zHZf6l7SvG4/hCJDbBwd8yZbMsE33hc0REoLdH7Jm04=;
	b=he7M3R6GWXkRiOlZobuMtaxrzuauIaRakC1efjnTxmG7tLGplbnh/x+KKh1VeGhIHLQqpe
	SyypPhTNXZ1QdIPnxrQTOWfLI3BKLYHdQGvmhcIIIMcKmLefNdrlDGFU22PfT5ZqEHDfJO
	u58h65RHaIDkizoqDgi0RTKgB2de5uACJQUj4wo0ocWpe7WHZuuETB1d16AebMCpwLJgCO
	B3bhlfrFe2d+BVImcm8m5eefM2dshMT2FZx61L3s8zxOxcEV7tD9cGoGgjE2sPnic4+jei
	he4Us/5cFvayLVzHw1BSCoprOTIhamRvxac1cQMqqfhB7H6N2x2l11U6qvfQ9w==
Date: Mon, 19 Aug 2024 16:39:38 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Howells <dhowells@redhat.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
	david@fromorbit.com, Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, john.g.garry@oracle.com,
	cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v12 00/10] enable bs > ps in XFS
Message-ID: <20240819163938.qtsloyko67cqrmb6@quentin>
References: <20240818165124.7jrop5sgtv5pjd3g@quentin>
 <20240815090849.972355-1-kernel@pankajraghav.com>
 <2924797.1723836663@warthog.procyon.org.uk>
 <3402933.1724068015@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3402933.1724068015@warthog.procyon.org.uk>

> ---
> /* Distillation of the generic/393 xfstest */
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <fcntl.h>
> 
> #define ERR(x, y) do { if ((long)(x) == -1) { perror(y); exit(1); } } while(0)
> 
> static const char xxx[40] = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
> static const char yyy[40] = "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy";
> static const char dropfile[] = "/proc/sys/vm/drop_caches";
> static const char droptype[] = "3";
> static const char file[] = "/xfstest.test/wubble";
> 
> int main(int argc, char *argv[])
> {
>         int fd, drop;
> 
> 	/* Fill in the second 8K block of the file... */
>         fd = open(file, O_CREAT|O_TRUNC|O_WRONLY, 0666);
>         ERR(fd, "open");
>         ERR(ftruncate(fd, 0), "pre-trunc $file");
>         ERR(pwrite(fd, yyy, sizeof(yyy), 0x2000), "write-2000");
>         ERR(close(fd), "close");
> 
> 	/* ... and drop the pagecache so that we get a streaming
> 	 * write, attaching some private data to the folio.
> 	 */
>         drop = open(dropfile, O_WRONLY);
>         ERR(drop, dropfile);
>         ERR(write(drop, droptype, sizeof(droptype) - 1), "write-drop");
>         ERR(close(drop), "close-drop");
> 
>         fd = open(file, O_WRONLY, 0666);
>         ERR(fd, "reopen");
> 	/* Make a streaming write on the first 8K block (needs O_WRONLY). */
>         ERR(pwrite(fd, xxx, sizeof(xxx), 0), "write-0");
> 	/* Now use truncate to shrink and reexpand. */
>         ERR(ftruncate(fd, 4), "trunc-4");
>         ERR(ftruncate(fd, 4096), "trunc-4096");
>         ERR(close(fd), "close-2");
>         exit(0);
> }

I tried this code on XFS, and it is working as expected (I am getting
xxxx).

[nix-shell:~/xfstests]# hexdump -C /media/test/wubble
00000000  78 78 78 78 00 00 00 00  00 00 00 00 00 00 00 00  |xxxx............|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00001000

I did some tracing as well and here are the results.

$ trace-cmd record -e xfs_file_fsync -e xfs_file_buffered_write -e xfs_setattr -e xfs_zero_eof -F -c ./a.out

[nix-shell:~/xfstests]# trace-cmd report
cpus=4
           a.out-3872  [003] 84120.161472: xfs_setattr:          dev 259:0 ino 0x103 iflags 0x0
           a.out-3872  [003] 84120.172109: xfs_setattr:          dev 259:0 ino 0x103 iflags 0x20 
           a.out-3872  [003] 84120.172151: xfs_zero_eof:         dev 259:0 ino 0x103 isize 0x0 disize 0x0 pos 0x0 bytecount 0x2000 // First truncate
           a.out-3872  [003] 84120.172156: xfs_file_buffered_write: dev 259:0 ino 0x103 disize 0x0 pos 0x2000 bytecount 0x28
           a.out-3872  [003] 84120.185423: xfs_file_buffered_write: dev 259:0 ino 0x103 disize 0x2028 pos 0x0 bytecount 0x28
           a.out-3872  [003] 84120.185477: xfs_setattr:          dev 259:0 ino 0x103 iflags 0x0
           a.out-3872  [003] 84120.186493: xfs_setattr:          dev 259:0 ino 0x103 iflags 0x20
           a.out-3872  [003] 84120.186495: xfs_zero_eof:         dev 259:0 ino 0x103 isize 0x4 disize 0x4 pos 0x4 bytecount 0xffc // Third truncate

First and third truncate result in calling xfs_zero_eof as we are
increasing the size of the file.

When we do the second ftruncate(fd, 4), we call into iomap_truncate_page() with
offset 0:

int
iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
		const struct iomap_ops *ops)
{
	unsigned int blocksize = i_blocksize(inode);
	unsigned int off = pos & (blocksize - 1);

	/* Block boundary? Nothing to do */
	if (!off)
		return 0;
	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
}

As you can see, we take into account the blocksize (which is set as
minorder during inode init) and make sure the sub-block zeroing is done
correctly.

Also if you see iomap_invalidate_folio(), we don't remove the folio
private data until the whole folio is invalidated.

I doubt we are doing anything wrong from the page cache layer with these
patches.

All we do with minorder support is to make sure we always allocate folios
in the page cache that are at least min order in size and aligned to the
min order (PATCH 2 and 3) and we maintain this even we do a split (PATCH
4).

I hope this helps!

--
Pankaj

