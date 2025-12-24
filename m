Return-Path: <linux-fsdevel+bounces-72052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1ECDC3CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8195E30FDE86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C59337B8F;
	Wed, 24 Dec 2025 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtI143b2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD7315765;
	Wed, 24 Dec 2025 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766579632; cv=none; b=Q9OyxIi11ZdyLVIiFPpKb/JbiR1QczyJv7jXx9GVCZR6s7MYM+qwE0dPVcm8KodE9RwfBAkw8Ts9jI47mRnUo6oopmEVm+GtdGBcelwaduSDpNepy3sZxA5exgjWbFeHPxS6K4LP1wjzGLRruh2xuLB+Kp24DltAsobWezMK1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766579632; c=relaxed/simple;
	bh=N5EoLbsRMh0OjdruItXhYdxR+NCojts0PAlkMFRBsE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nl91ucipUt3q3s8Lk+19qmuG1nJXN6ccx+l4haBw3OWwq+GCgAcf9H6La2WQ2viYQ5sHTmwhAzVY5lbuU1K5jZdSawlKDiwEAh8VC5+fSLWqWg14g/HHDAH5uRScBrgTEEiP0WGvDgZt2Q0/Abf7P17Zf5idB9bsVa6WOVzFpVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtI143b2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7B6C4CEFB;
	Wed, 24 Dec 2025 12:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766579631;
	bh=N5EoLbsRMh0OjdruItXhYdxR+NCojts0PAlkMFRBsE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BtI143b2o06YkhmeBr04qpDjGZw5KzkDnCavOYfhDnmi8kvuEkl71rKgyvoBAb1FG
	 G4yGad22YUjjGiKciaNn+O4r1lWQyglnIARrs/8I02gFpDbl8LsousuISxvqdRS367
	 D3Dd+4rlVB2OH+9lfUKK2w8U/PEWhUmvhtEf1n4d1RkuCjEk/3AQZY/K12RhjpjrCS
	 eSj8HLSOeYeL7675IIbFYj5JjQmXskWYVbeuF83NBrBkcMEY9C+VQh3JQflcw7iNCt
	 D3Isb34TuXzIX/kamIwyw1xIWTJFY/QuD2ATlxNcc8HkfCIIhAr/QxPXMeehOr3HUh
	 /PFXLcvSjxeRA==
From: Christian Brauner <brauner@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/2] vfs kernel-doc fixes for 6.19
Date: Wed, 24 Dec 2025 13:33:38 +0100
Message-ID: <20251224-gelacht-mitsingen-1e786e2e1c2b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219024620.22880-1-bagasdotme@gmail.com>
References: <20251219024620.22880-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=brauner@kernel.org; h=from:subject:message-id; bh=N5EoLbsRMh0OjdruItXhYdxR+NCojts0PAlkMFRBsE0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR6313FzfktRnLhDzF7h8dR3IIT5VockvVub/RyT1czW R520WhlRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERU9Bn+x0i8nn/Y6aLjW4fA u2KrtW/0WrzZvFbizO3glsLzmWuOlTD8s3h7zbBA4brdpKlSKosl9jlrr89MqfXeLHN+keEnw3t 2bAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 19 Dec 2025 09:46:18 +0700, Bagas Sanjaya wrote:
> Here are kernel-doc fixes for vfs subsystem targetting 6.19. This small
> series is split from much larger kernel-doc fixes series I posted a while
> ago [1].
> 
> Enjoy!
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20251215113903.46555-1-bagasdotme@gmail.com/
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/2] fs: Describe @isnew parameter in ilookup5_nowait()
      https://git.kernel.org/vfs/vfs/c/fe33729d2907
[2/2] VFS: fix __start_dirop() kernel-doc warnings
      https://git.kernel.org/vfs/vfs/c/73a91ef328a9

