Return-Path: <linux-fsdevel+bounces-7045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0D882098E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 03:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B8A1F22526
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 02:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41189E544;
	Sun, 31 Dec 2023 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qNfxXoEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0DCDF51;
	Sun, 31 Dec 2023 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703989946; bh=iyShud6ixGTGsi+8mJNqmZ+hFsJHCavb2SUbHPreU00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qNfxXoEW9RXLPKNEew1XFVQlk2pQsnQ6L3FOfLCfFvkjerGRZ+JDWtjNcs7f0gbKR
	 4oeKbn9iZJPSNTxhsKQC7LpkTIGkIelvd583Xd+GuJKSazbhOisXW16cELDMx9MMc/
	 96MLbvR6kH5BTECkl/pYLdOxE9L5OtmBnlCIbB50=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 8172203F; Sun, 31 Dec 2023 10:32:23 +0800
X-QQ-mid: xmsmtpt1703989943t611qma8z
Message-ID: <tencent_2F7B3A6ED02C496EFC965CE96EEDFECDB40A@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69Y3XCpPld6XvBHv0DEOlzwgQbasw5H9sw/KRxE79V04YJPjICau
	 0khGOH6y0rPQC8PAAv9PLU53DGZAjSypnDwmSAH4IoK8BhHH4jlYzDo8oqQQ6s4h3gc9BdjdrPEu
	 hTy++H9Lu18YA9XUO316W4NenV/LiZK8eBrqf+trppOiO3Q7jIu6ZL52vm9oUHTDQm/cSjJo7z60
	 xUPj86X8JzQyNo5za5opCjfc0Jvi4uG3/fzcxCQHgIv07uSupg8akCwAKq6JG1gFGaqcI/nnh6pT
	 9BoSYLzhrkKGz8kPwlCL1ULbYIBfqnWH/eaMfQthua0euumPvwZoaUM2H4ZRXkeTGQJ1+nIohvsO
	 yk6UWgHHaKli6vQL+DlPcL+apXpR0tBeMnL2R4SKkQBvjSF03m3XdklL0pX2kJpEbAFNB0cAzoKC
	 nRpqlVd/6SkxfhwzKFtNYnCxEJaouUXAQhPpZEUGA3k//fvHnCL82axVfS/HRpBByYvRTgaCAbZZ
	 cA9JXShPiZ5btS2h4SgFXSZi5sOE10YH/2Ug170Mt+U9MujVWc3qMRXyF8GoZkh1yQ2xp3kYnQ+O
	 WZ0lfp3W9BNUwOX7wA3HXwU19+iOBQ2ZCWjXjQgWt5iF8XLMheszUjkOIZTWkokxU5QLTlROq85q
	 MLDKy354VBpm5zB8J1g6YGTkYYLVRXwlKX7lch1QFC0TkIUP8ErXakyw8cHvwIL29/TBxbZPZEUH
	 Lq64zpE8bI48AzpfhOl5uT5iqpe5PIQkGFE3m4LPxVnUUMWPt1DTxqLIKYtO0mw+Sc/2G4Mw4dMA
	 wHxGNKoFNLQT0ABNwGIdqWZX5chb8W+VpAVK7zpg94dXOuutJhxZNgrtNpL5nGJhzdUt54OZbMga
	 K+I6VU/YydhKuXKT/9e9BlcBfHdUXWhOkdXDs2U+0g/2W3I0OQdDAv5R1dX0F8gYjUxnEJID2smq
	 ohnB/DlKMrSzR6UMxlWEpkEUZjwULm
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: hsiangkao@linux.alibaba.com
Cc: chao@kernel.org,
	eadavis@qq.com,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	xiang@kernel.org
Subject: Re: [PATCH] erofs: fix uninit-value in z_erofs_lz4_decompress
Date: Sun, 31 Dec 2023 10:32:24 +0800
X-OQ-MSGID: <20231231023223.3143138-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8f0dd1ed-8849-46ef-af2a-4baf4dc91422@linux.alibaba.com>
References: <8f0dd1ed-8849-46ef-af2a-4baf4dc91422@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 31 Dec 2023 09:14:11 +0800, Gao Xiang wrote:
> > When LZ4 decompression fails, the number of bytes read from out should be
> > inputsize plus the returned overflow value ret.
> >
> > Reported-and-tested-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >   fs/erofs/decompressor.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index 021be5feb1bc..8ac3f96676c4 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -250,7 +250,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
> >   		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
> >   			       16, 1, src + inputmargin, rq->inputsize, true);
> >   		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
> > -			       16, 1, out, rq->outputsize, true);
> > +			       16, 1, out, (ret < 0 && rq->inputsize > 0) ?
> > +			       (ret + rq->inputsize) : rq->outputsize, true);
> 
> It's incorrect since output decompressed buffer has no relationship
> with `rq->inputsize` and `ret + rq->inputsize` is meaningless too.
In this case, the value of ret is -12. 
When LZ4_decompress_generic() fails, it will return "return (int) (- ((const char *) ip) - src) -1;"

Therefore, it can be clearly stated that the decompression has been carried out
to the 11 bytes of src, so reading the value of the first 11 bytes of out is 
effective. Therefore, my patch should be more accurate as follows:
-			       16, 1, out, rq->outputsize, true);
+			       16, 1, out, (ret < 0 && rq->inputsize > 0) ?
+			       (0 - ret) : rq->outputsize, true);
> 
> Also, the issue was already fixed by avoiding debugging messages as
> https://lore.kernel.org/r/20231227151903.2900413-1-hsiangkao@linux.alibaba.com
This just deleted the output.

BR,
Edward


