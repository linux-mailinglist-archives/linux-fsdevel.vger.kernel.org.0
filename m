Return-Path: <linux-fsdevel+bounces-21562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59404905BA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 21:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18E0B21BFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 19:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614F824A4;
	Wed, 12 Jun 2024 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmCQtJzC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3561C14;
	Wed, 12 Jun 2024 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219205; cv=none; b=OdYJkTwH8cxxUg8W1OyjM2pSg6Fw4HUnvSwU1gjclQCfm9M4gm6D6KObgzysqBPMHPRIvIyqAfufhVvbUucd2NyRBDzQ9pM6y6c6raAknp5jAyuKrFjauH71kVvkfZQqcNfPCY0CfXOAsyFBehnLQ8YkcH15XPMwUMIz2QSs4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219205; c=relaxed/simple;
	bh=whXhspxRaLQxdSmsmTL0/6hVFbkMp6ekeTUg+19VkDY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TdYamlyCwkKRsLBj6ug20mLr79T/Ii8WFqWBJ64iTAwzf9hzJGHiF2uNHe9uY7qzWEc+rYRZuY3GUkKJbzS4Qqo49KeSNH1nuIXgQEm7cyrbOeK10kCXgrjb1GFDHyA0Xb1glZza3zTtFyNbTpk+Cipf/2ZNUU6isaWGtXN/ok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmCQtJzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F067BC116B1;
	Wed, 12 Jun 2024 19:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718219205;
	bh=whXhspxRaLQxdSmsmTL0/6hVFbkMp6ekeTUg+19VkDY=;
	h=Date:From:To:Cc:Subject:From;
	b=WmCQtJzCDqjCYrVKpkf0MwzV9I+FQmYd0WY8eFc2encmpWoWtyd0m8k9C0W1KmXkk
	 xkk7nM5hOGg9/oAfz6IhwYN4vaMD85Hn1FbbVm9d38QDtZvsPu3wIvshJoMAKmUvGD
	 T0tgNSXX0vAMOraSKRGx+6VevUFbwuFsmqdVeXCZ0nA3YclgpiexMR2lc25cODuhaR
	 e1JlGII3pSdPJIAZhVq4GtQQUuTJ8goHT/1PnILTJN1NebXV2V65sFp7iizn5Ci3K3
	 uFRumUTs3Dv5aKYr+2W6qhl7WaXnO/0WR7fSW+YmZ7cg7ahVreo0TehnOGvjmNKNBb
	 +rNnbVXkFf5Vw==
Date: Wed, 12 Jun 2024 12:06:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>, xfs <linux-xfs@vger.kernel.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	fsverity@lists.linux.dev, Eric Sandeen <sandeen@redhat.com>,
	Shirley Ma <shirley.ma@oracle.com>
Subject: Handing xfs fsverity development back to you
Message-ID: <20240612190644.GA3271526@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrey,

Yesterday during office hours I mentioned that I was going to hand the
xfs fsverity patchset back to you once I managed to get a clean fstests
run on my 6.10 tree.  I've finally gotten there, so I'm ready to
transfer control of this series back to you:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity_2024-06-12
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=fsverity_2024-06-12
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fsverity_2024-06-12

At this point, we have a mostly working implementation of fsverity
that's still based on your original design of stuffing merkle data into
special ATTR_VERITY extended attributes, and a lightweight buffer cache
for merkle data that can track verified status.  No contiguously
allocated bitmap required, etc.  At this point I've done all the design
and coding work that I care to do, EXCEPT:

Unfortunately, the v5.6 review produced a major design question that has
not been resolved, and that is the question of where to store the ondisk
merkle data.  Someone (was it hch?) pointed out that if xfs were to
store that fsverity data in some post-eof range of the file (ala
ext4/f2fs) then the xfs fsverity port wouldn't need the large number of
updates to fs/verity; and that a future xfs port to fscrypt could take
advantage of the encryption without needing to figure out how to encrypt
the verity xattrs.

On the other side of the fence, I'm guessing you and Dave are much more
in favor of the xattr method since that was (and still is) the original
design of the ondisk metadata.  I could be misremembering this, but I
think willy isn't a fan of the post-eof pagecache use either.

I don't have the expertise to make this decision because I don't know
enough (or anything) about cryptography to know just how difficult it
actually would be to get fscrypt to encrypt merkle tree data that's not
simply located in the posteof range of a file.  I'm aware that btrfs
uses the pagecache for caching merkle data but stores that data
elsewhere, and that they are contemplating an fscrypt implementation,
which is why Sweet Tea is on the cc list.  Any thoughts?

(This is totally separate from fscrypt'ing regular xattrs.)

If it's easy to adapt fscrypt to encrypt fsverity data stored in xattrs
then I think we can keep the current design of the patchset and try to
merge it for 6.11.  If not, then I think the rest of you need to think
hard about the tradeoffs and make a decision.  Either way, the depth of
my knowledge about this decision is limited to thinking that I have a
good enough idea about whom to cc.

Other notes about the branches I linked to:

I think it's safe to skip all the patches that mention disabling
fsverity because that's likely DOA anyway.

Christoph also has a patch to convert the other fsverity implementations
(btrfs/ext4/f2fs) to use the read/drop_merkle_tree_block interfaces:
https://lore.kernel.org/linux-xfs/ZjMZnxgFZ_X6c9aB@infradead.org/

I'm not sure if it actually handles PageChecked for the case that the
merkle tree block size != base page size.

If you prefer I can patchbomb the list with this v5.7 series.

--Darrick

