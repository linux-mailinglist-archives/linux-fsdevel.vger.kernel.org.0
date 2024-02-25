Return-Path: <linux-fsdevel+bounces-12688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6EA86288C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 01:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A4E1C21060
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 00:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F9E28EC;
	Sun, 25 Feb 2024 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="qZUwava2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4871C01
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708820329; cv=none; b=MLzG+D+FQ4nyC3oug/ovVApoZ/XOkOd9EzlUzdVUG0uxjhJsiTIB6zvwxwCpW6BcVA05QBwzwLxqVJu5l+FAswSvEHJVevrdFCQBja8QKF50OBpdOzJp2ZKfyNTdoorzG9SLvP1yfF4mx9wLZeEjIeOevtOLiCpW6NLd2cCIMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708820329; c=relaxed/simple;
	bh=t0Whknsd1rGK9WjcBPJS2L+1+d1bj/rB5MlxkCLpJD0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uU/7BicMLwohv8sxW4ST+SdJ7LltrEB6Qi1H5zfVN9aibn4bRkAiegXWYlZOmqRMuqrSptpOv99yjLB1UVsqoTTXp9NKbwI9EYyX/DBDFVs7tNWJgbyDw+fh+u2ULdCqFFvJBEeicufW4zPEZdjne0WQNfs8BvaYhb0/ZouVvyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=qZUwava2; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail3; t=1708820317; x=1709079517;
	bh=BahbE5CKCTdmjXFR2X7BjIhEsp3u+hubVspL4UCDtP8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qZUwava2T9473lT+lmu2sgFJYbp2WeswytrlrRx3GCLTdIS6v7Q8BTPOSzTVZdwaR
	 uwyeiIPjRpeaNYTt+UXZYhF/YVClP2LFc8UwDo0YK/l4BIEE/f3CGmyNMp38AvPcsM
	 BXuBCT3Uv5XNSG1dfUPSYIY5VXCxRredUbNxLXfz2BJB9h5cF95fpJ02+gUL912ORk
	 9URiriGCfUMu/IVdqSnLXabpl66hZ8fTmacJLUQ6FmouxqXU5YYBOaOtl2A8zgIkvt
	 9rIM09WEvZ7gaJYsh/S2PmvMzqeey7RBvzL36o598xHhqkv7+BdvW2la+TmpP5IWpL
	 fyDPGwIxnOOLA==
Date: Sun, 25 Feb 2024 00:18:11 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
Message-ID: <f70732f8-4d67-474a-a4b8-320f78c3394d@spawn.link>
In-Reply-To: <CAJfpegscxYn9drVRkbVhRztL-+V0+oge8ZqPhgt4BAnvzaPzwQ@mail.gmail.com>
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link> <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm> <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link> <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com> <5b7139d5-52fd-4fd0-8fa0-df0a38d96a33@spawn.link> <CAJfpeguvX1W2M9kY-4Tx9oJhSYE2+nHQuGXDNPw+1_9jtMO7zA@mail.gmail.com> <CAJfpegssrySj4Yssu4roFHZn1jSPZ-FLfb=HX4VDsTP2jY5BLA@mail.gmail.com> <6fb38202-4017-4acd-8fb8-673eee7182b9@spawn.link> <CAJfpegscxYn9drVRkbVhRztL-+V0+oge8ZqPhgt4BAnvzaPzwQ@mail.gmail.com>
Feedback-ID: 55718373:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/22/24 05:09, Miklos Szeredi wrote:
> On Thu, 22 Feb 2024 at 02:26, Antonio SJ Musumeci <trapexit@spawn.link> w=
rote:
>=20
>> I'll try it when I get some cycles in the next week or so but... I'm not
>> sure I see how this would address it.  Is this not still marking the
>> inode bad. So while it won't forget it perhaps it will still error out.
>> How does this keep ".." of root being looked up?
>>
>> I don't know the code well but I'd have thought the reason for the
>> forget was because the lookup of the parent fails.
>=20
> It shouldn't be looking up the parent of root.   Root should always be
> there, and the only way I see root disappearing is by marking it bad.
>=20
> If the patch makes a difference, then you need to find out why the
> root is marked bad, since the filesystem will still fail in that case.
> But at least the kernel won't do stupid things.
>=20
> I think the patch is correct and is needed regardless of the outcome
> of your test.  But there might be other kernel bugs involved, so
> definitely need to see what happens.
>=20
> Thanks,
> Miklos

With the patch it doesn't issue forget(nodeid=3D1) anymore. Nor requesting=
=20
parent of nodeid=3D1.

However, I'm seeing different issues.

I instrumented FUSE to print when it tags an inode bad.

After it gets into the bad state I'm seeing nfsd hammering the mount=20
even when I've umounted the nfs share and killed the FUSE server. nfsd=20
is pegging a CPU core and the kernel log is filled with=20
fuse_stale_inode(nodeid=3D1) fuse_make_bad(nodeid=3D1) calls. Have to reboo=
t.

What's triggering the flagging the inode as bad seems to be in=20
fuse_iget() at fuse_stale_inode() check. inode->i_generation is 0 while=20
the generation value is as I set it originally.

 From the FUSE server I see:

lookup(nodeid=3D3,name=3D".")
lookup(nodeid=3D3,name=3D"..") which returns ino=3D1 gen=3Dexpected_val
getattr(nodeid=3D2) inodeid=3D2 is the file I'm reading in a loop
forget(nodeid=3D2)

after which point it's no longer functional.





