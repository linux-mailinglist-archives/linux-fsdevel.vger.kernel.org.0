Return-Path: <linux-fsdevel+bounces-32012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA599F37B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105DB1F244DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B4B1F76D3;
	Tue, 15 Oct 2024 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOL0ad3a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B561F667D;
	Tue, 15 Oct 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011368; cv=none; b=p7y05Saz3TbzLtc1ytu/8yU2+hP57hF6I8xr8S56b4w6jvYjtHHwqH5PWNFUtcWsY7GKSngsqvFmo+TQe6Wi19VrFMkuCIVjvg/lddxzTLb9XnJCg21Y5pothaPIPw4A5olQszI65nOaT3aU0NVBOQqanpI6o89G4R7UtKEWXqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011368; c=relaxed/simple;
	bh=hfqJKue+3XYOgvEDE+ykbHkzEUEGlHvjzIkhYRO8y10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGAu07RjuPUwXoOeQUS9XDh70VN1IsyvcU8G1YSFZmLBuIawba3bO//dcMOxvWrqvbtOXoS0EdAUQFebmXOzwC1ga665Opp/u8HoFHFNFIpqLdYa48uYZHuPKwnkRtRkg14/zZLwUCVb6MNS+qLKZaxOD4o94ED2glv345FYK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOL0ad3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB58FC4CEC6;
	Tue, 15 Oct 2024 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729011368;
	bh=hfqJKue+3XYOgvEDE+ykbHkzEUEGlHvjzIkhYRO8y10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOL0ad3a5QF4D6nDEDi6WusaMnXL8w3i+ooPdvVVEo5G0E0G2oPhKjYBWvQRjzh/m
	 fSmqcwvIsq1FOrvt7YVrhexSOl6xXfLw6ccABZHDJhbDoWnSryKGYppZe52OCy6jTf
	 FgOyT3CmQ8DIsB+K106HfNz3tQsXEOji+qDUHTl7fIibCmNCauC2KinUDgRy+SA2RB
	 mNe3QyOwshLGSTY5Pmi5GlGYOb3Qu2kHKOd9dzw2Q8TWiEOrDaPAGn0hzboIO8cNBD
	 jir7BiC3OKObuUy/QOCxSFQDgexAEgXGjXVvvhLGeShCvqD3foJsGo7pwPaXXwKtss
	 C/Jw4Qd1fZdDg==
Date: Tue, 15 Oct 2024 16:56:05 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Daeho Jeong <daeho43@gmail.com>, Daeho Jeong <daehojeong@google.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: introduce device aliasing file
Message-ID: <Zw6epcWDc13p1yCM@google.com>
References: <20241010192626.1597226-1-daeho43@gmail.com>
 <ZwyyiG0pqXoBFIW5@infradead.org>
 <CACOAw_yvb=jacbXVr76bSbCEcud=D1vw5rJVDO+TjZbMLYzdZQ@mail.gmail.com>
 <Zw1J30Fn48uYCwK7@google.com>
 <Zw34CMxJB-THlGW0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw34CMxJB-THlGW0@infradead.org>

On 10/14, Christoph Hellwig wrote:
> On Mon, Oct 14, 2024 at 04:42:07PM +0000, Jaegeuk Kim wrote:
> > > 
> > > Plz, refer to this patch and the description there.
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=8cc4e257ec20bee207bb034d5ac406e1ab31eaea
> > 
> > Also, I added this in the description.
> > 
> > ---
> >     For example,
> >     "mkfs.f2fs -c /dev/block/test@test_alias /dev/block/main" gives
> >     a file $root/test_alias which carves out /dev/block/test partition.
> 
> What partition?
> 
> So mkfs.f2fs adds additional devices based on the man page.
> 
> So the above creates a file system with two devices, but the second
> device is not added to the general space pool, but mapped to a specific
> file?  How does this file work.  I guess it can't be unlinked and
> renamed.  It probably also can't be truncated and hole punched,
> or use insert/collapse range.  How does the user find out about this
> magic file?  What is the use case?  Are the exact semantics documented
> somewhere?

Let me ask for putting some design in Documentation. Just for a quick reference,
the use-case looks like:

# ls /dev/vd*
/dev/vdb (32GB) /dev/vdc (32GB)
# mkfs.ext4 /dev/vdc
# mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
# mount /dev/vdb /mnt/f2fs
# ls -l /mnt/f2fs
vdc.file
# df -h
/dev/vdb                            64G   33G   32G  52% /mnt/f2fs

# mount -o loop /dev/vdc /mnt/ext4
# df -h
/dev/vdb                            64G   33G   32G  52% /mnt/f2fs
/dev/loop7                          32G   24K   30G   1% /mnt/ext4
# umount /mnt/ext4

# f2fs_io getflags /mnt/f2fs/vdc.file 
get a flag on /mnt/f2fs/vdc.file ret=0, flags=nocow(pinned),immutable
# f2fs_io setflags noimmutable /mnt/f2fs/vdc.file
get a flag on noimmutable ret=0, flags=800010
set a flag on /mnt/f2fs/vdc.file ret=0, flags=noimmutable
# rm /mnt/f2fs/vdc.file
# df -h
/dev/vdb                            64G  753M   64G   2% /mnt/f2fs

So, key idea is, user can do any file operations on /dev/vdc, and
reclaim the space after the use, while the space is counted as /data.
That doesn't require modifying partition size and filesystem format.

