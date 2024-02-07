Return-Path: <linux-fsdevel+bounces-10546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F3084C221
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 02:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFB628FB00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 01:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D89D2EE;
	Wed,  7 Feb 2024 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI9/krqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06583D271;
	Wed,  7 Feb 2024 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270454; cv=none; b=tEgJ8YIawUV+owZQ6oXohRAzNOLdKsZxZrFCc7lzN+S39Rt5W8Oz1ptntkxcc2cRulUpNBgkzR9oUSAX4knqF/q3Jt5KwRenM13bFSj1EMf1iMXMRPfE/+PBPklGFu5dweg6wlEwF8q4sh6MjlAAtbWKU3Wd84CeGsMlhg07LSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270454; c=relaxed/simple;
	bh=xWoR0ZKxvLLFyhiSSg2oVlIbFnNgIJaoB8AXT4Fz8kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYzxuRMtD+NmEUcpezVxuCXQYMS1vjSqpMHInz6bATwY+A1pQbtTTzi/SMN0ZsRvHLNFn80EaT+naDkn00pW8rCqDeQ9wGsc5OlXWRGijCOeMPYGZpg0/qWJ11s1albSs9doKwOqEa0fK43HHCkDdCxNp5IxkXLuijc2yChXxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI9/krqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6721DC433C7;
	Wed,  7 Feb 2024 01:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707270451;
	bh=xWoR0ZKxvLLFyhiSSg2oVlIbFnNgIJaoB8AXT4Fz8kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MI9/krqiJyzPoXKvPjbyKqU53iXZB+OLOJMVCer+Y5vkY5jb4N5t+eF8UACp6cn/g
	 Hc5rQT8JMkAJNjBTSw+RYxW8RAwLI85qMXnf2qPK2L/ejWL4Ij1Spw9Xme5DgFccAj
	 /ifM0l+HWZkHUUFYHPKvmVzaADyV5p4RJ9gjwixlKq1tQ4CbEuarB50EhnmAfK7ewo
	 /8Fj3HarU2XS4RBvzI2FT8/Hh+3+UN8WVUS2uXYIl0Bo7P1IOg88adJOJmaCX+/Lbe
	 Agd8+crlNeYv/T3g66hHdrRJIkGSNzKx+YjsgERteeaw6L71RSV6FEKFJFJMV9b5S0
	 +XVSRtD+9VI2A==
Date: Tue, 6 Feb 2024 17:47:29 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] filesystem visibililty ioctls
Message-ID: <20240207014729.GC35324@sol.localdomain>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206201858.952303-1-kent.overstreet@linux.dev>

On Tue, Feb 06, 2024 at 03:18:48PM -0500, Kent Overstreet wrote:
> 
> Darrick also noticed that fscrypt (!) is using sb->s_uuid, which looks
> busted - they want to be using the "this can never change" UUID, but
> that is not an item for this patchset.
> 

fscrypt only uses sb->s_uuid if FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64 or
FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32 is being used in the encryption policy.
These flags are only supported by ext4 and f2fs, and they are only useful when
the file contents encryption is being done with inline encryption hardware that
only allows 64-bits or less of the initialization vector to be specified and
that has poor performance when switching keys.  This hardware is currently only
known to be present on mobile and embedded systems that use eMMC or UFS storage.

Note that these settings assume the inode numbers are stable as well as the
UUID.  So, when they are in use, filesystem shrinking is prohibited as well as
changing the filesystem UUID.  (In ext4, both operations are forbidden using the
stable_inodes feature flag.  f2fs doesn't support either operation regardless.)

These restrictions are unfortunate, but so far they haven't been a problem for
the only known use case for these non-default settings.

In the case of s_uuid, for both ext4 and f2fs it's true that we could have used
s_encrypt_pw_salt instead, or added a new general-purpose internal UUID field
and used that.  Maybe we even should have, considering the precedent of ext4's
metadata_csum migrating away from using the UUID to its own internal seed.  I do
worry that relying on an internal UUID for these settings would make it easier
for people to create insecure setups where they're using the same fscrypt key on
multiple filesystems with the same internal UUID.  With the external UUID, such
misconfigurations are obvious and will be noticed and fixed.  With the internal
UUID, such vulnerabilities would not be noticed, as things will "just work".
Which is better?  It's not entirely clear to me.  We do encourage the use of
different fscrypt keys on different filesystems anyway, but this isn't required.

Of course, even if the usability improvement outweighs that concern, switching
these already-existing encryption settings over to use an internal UUID can't be
done trivially; it would have to be controlled by a new filesystem feature flag.
We probably shouldn't bother unless/until there's a clear use case for it.

If anyone does have any new use case for these weird and non-default encryption
settings (and I hope you don't!), I'd be interested to hear...

- Eric

