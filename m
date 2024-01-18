Return-Path: <linux-fsdevel+bounces-8226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B348311F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 04:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB4D286802
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 03:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD109474;
	Thu, 18 Jan 2024 03:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqFavts6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9F9447;
	Thu, 18 Jan 2024 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705550357; cv=none; b=iOc+ko5yJNHEjAYuEtJRhFFAGng3ggBjgeGFDeKiTSjwmoUULNKurq2vHOG3jV1tbsWqFUkBJhwUUNQMR5iR3lQQhiry9dBQJnuVNfg1JrSo6aQ3zYgDgaRc6c4BRAFj1w+UHw5hjkWAd0jZ0gHGuEkEFO6d2BbAOx20OVa43eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705550357; c=relaxed/simple;
	bh=EisvP7808GQ7Gd+G+RGaBK/S/ilhFW8YlA8hHIV+KLY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=ai6mVohVFsHASz+PHk8PcDeKJBsX8R+2j9SJWk49otMA0MbBo/y6yYyngy3k8I5T19eTIOCVXsLtQOAqp2HVmngbsqlvf8JM047uvMlfCe6l+sPlJyoqmreA0+n4Gm5OLGSGx3TPW/eis9vLCZCD9mmFovxOYQ9HWQwp59R8NOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqFavts6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ACCC433C7;
	Thu, 18 Jan 2024 03:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705550356;
	bh=EisvP7808GQ7Gd+G+RGaBK/S/ilhFW8YlA8hHIV+KLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqFavts6afhViVUETjFIIPgQNjDJ5ZJz/RUuuVZKAblZLKKAZ+5HzRlF4TFRxxcsP
	 mu+wpF9nNVwul9Y5ixlvKS7TC5NmPt5FMMM8T7TOx9DQC/NOgXtNbe7CejvaK2vw2g
	 YqurD4C21Y6lh6oFBBrrkMKe7fuEoCI7VCJLycfVCuc+cXJnmEHK4GdJWxv7ut1OxT
	 5KxPRyZU9U3KinUxzhOI8p3uOtXHZKctnsA7Fxgt0oE/aYV3oMq9qWC7McbSowM/P8
	 dVk+UOMu6Hv112qGQrMevEBEriYWL5fyddc+duD4ZYbsn2VGl5FfXRd3PRVhd/OoIW
	 Dq7shWO2x3Z4A==
Date: Wed, 17 Jan 2024 19:59:14 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: syzbot <syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com>
Cc: chao@kernel.org, hdanton@sina.com, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in
 kill_f2fs_super
Message-ID: <20240118035914.GD1103@sol.localdomain>
References: <0000000000006cb174060ec34502@google.com>
 <000000000000d65af9060ece0537@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d65af9060ece0537@google.com>

On Fri, Jan 12, 2024 at 10:38:04PM -0800, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 275dca4630c165edea9abe27113766bc1173f878
> Author: Eric Biggers <ebiggers@google.com>
> Date:   Wed Dec 27 17:14:28 2023 +0000
> 
>     f2fs: move release of block devices to after kill_block_super()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16071613e80000
> start commit:   70d201a40823 Merge tag 'f2fs-for-6.8-rc1' of git://git.ker..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15071613e80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11071613e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4607bc15d1c4bb90
> dashboard link: https://syzkaller.appspot.com/bug?extid=8f477ac014ff5b32d81f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112b660be80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c1df5de80000
> 
> Reported-by: syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com
> Fixes: 275dca4630c1 ("f2fs: move release of block devices to after kill_block_super()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: f2fs: fix double free of f2fs_sb_info

