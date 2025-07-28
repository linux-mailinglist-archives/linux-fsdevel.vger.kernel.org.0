Return-Path: <linux-fsdevel+bounces-56140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D550B13DF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847063AB8E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130F126FA76;
	Mon, 28 Jul 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="rgA+2Xiu";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="7w1OAFFb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0871F1517;
	Mon, 28 Jul 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715445; cv=none; b=bOTtstLU725tsjJaGT1Bg7Fs6qy9Vrkxp7oiWi8h2qfy8A7ijzPHohbX31aMGhKIWUNzzMFMpJ0Ek/njsdAHZqbFvMXVBdXTIweQPfxeVjdPnvC+VJkAZZJvuD75Kd+lfySkxYKp/d7OKpB9gB5LcnZhXDFbqQ0lfmwF0y0isbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715445; c=relaxed/simple;
	bh=y3O17yF6OPOSNbZuaED7N7zoZamz2jnz/0qwkNUR9A4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E/qhxDnMj7pPIyOvr+0pRlKkxO4q9n6GDXqYEuQWO8YFs24EUbYUcRCup+/ClTRYAzmJ5U5amFM8LJxAjr7dt3iBKz7NvMp7t/mDmhoLReJPahGwj6QtVz8vwgVDrA1IRqy4V6wpbnRW60gdBpaAGaWQYLIIPR9qdd0pjlkuP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=rgA+2Xiu; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=7w1OAFFb; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id A2EEA2096798;
	Tue, 29 Jul 2025 00:10:33 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1753715433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3nk93NjHHk9vOcXrtlULci5a5hCR0YeSKMM2/RWppiI=;
	b=rgA+2XiuL+QfhYbqXXo/u1z5NoLhNRbSO7LM7dM5/TCBnLzKp3NeOZQtQ9xne6hhZCn3zE
	WVhv/Rw+E3PA2blSQi2ppskyUJEP7p3IHNMEPHDQNbkrnoeFibmpEHtit1ZBQYw75Ra/zc
	IqiYeBuqj/BbHe8PUYG+FjZSc0w5F4n8gVLlfPn5R8+uRed7sXLDMb4Zi0eRBUJrc0rtZD
	tprRkdxFS7RyQrHpYa+cSbeVD96J4YLzjYWxZu/Fa1M+MMDn0moXDlIFtBeOV376qkj83Q
	ulyBnKT77bSfyykMhWld+HqiZtl5ci2COcS0o3RC1ezkipXx/uuyBR+hcvVCmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1753715433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3nk93NjHHk9vOcXrtlULci5a5hCR0YeSKMM2/RWppiI=;
	b=7w1OAFFbI+y9veaNACWCLvIOCF7dtlrKK1SQKfVpn1jW1lyt5hfaWGczuK2H9ftiBKe4X7
	IQcgNO+mLI+ZxFAA==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 56SFAWsP182221
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 00:10:33 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 56SFAWib512076
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 00:10:32 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 56SFAV9e512074;
	Tue, 29 Jul 2025 00:10:31 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fat: Prevent the race of read/write the FAT16 and FAT32
 entry
In-Reply-To: <tencent_E34B081B4A25E3BA9DBBB733019E4E1BD408@qq.com>
References: <6887321b.a00a0220.b12ec.0096.GAE@google.com>
	<tencent_E34B081B4A25E3BA9DBBB733019E4E1BD408@qq.com>
Date: Tue, 29 Jul 2025 00:10:31 +0900
Message-ID: <874iuwxsew.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Edward Adam Davis <eadavis@qq.com> writes:

> The writer and reader access FAT32 entry without any lock, so the data
> obtained by the reader is incomplete.
>
> Add spin lock to solve the race condition that occurs when accessing
> FAT32 entry.
>
> FAT16 entry has the same issue and is handled together.

What is the real issue? Counting free entries doesn't care whether EOF
(0xffffff) or allocate (0x000068), so it should be same result on both
case.

We may want to use READ_ONCE/WRITE_ONCE though, I can't see the reason
to add spin_lock.

Thanks.

> Reported-by: syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d3c29ed63db6ddf8406e
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/fat/fatent.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> index a7061c2ad8e4..0e64875e932c 100644
> --- a/fs/fat/fatent.c
> +++ b/fs/fat/fatent.c
> @@ -19,6 +19,8 @@ struct fatent_operations {
>  };
>  
>  static DEFINE_SPINLOCK(fat12_entry_lock);
> +static DEFINE_SPINLOCK(fat16_entry_lock);
> +static DEFINE_SPINLOCK(fat32_entry_lock);
>  
>  static void fat12_ent_blocknr(struct super_block *sb, int entry,
>  			      int *offset, sector_t *blocknr)
> @@ -137,8 +139,13 @@ static int fat12_ent_get(struct fat_entry *fatent)
>  
>  static int fat16_ent_get(struct fat_entry *fatent)
>  {
> -	int next = le16_to_cpu(*fatent->u.ent16_p);
> +	int next;
> +
> +	spin_lock(&fat16_entry_lock);
> +	next = le16_to_cpu(*fatent->u.ent16_p);
>  	WARN_ON((unsigned long)fatent->u.ent16_p & (2 - 1));
> +	spin_unlock(&fat16_entry_lock);
> +
>  	if (next >= BAD_FAT16)
>  		next = FAT_ENT_EOF;
>  	return next;
> @@ -146,8 +153,13 @@ static int fat16_ent_get(struct fat_entry *fatent)
>  
>  static int fat32_ent_get(struct fat_entry *fatent)
>  {
> -	int next = le32_to_cpu(*fatent->u.ent32_p) & 0x0fffffff;
> +	int next;
> +
> +	spin_lock(&fat32_entry_lock);
> +	next = le32_to_cpu(*fatent->u.ent32_p) & 0x0fffffff;
>  	WARN_ON((unsigned long)fatent->u.ent32_p & (4 - 1));
> +	spin_unlock(&fat32_entry_lock);
> +
>  	if (next >= BAD_FAT32)
>  		next = FAT_ENT_EOF;
>  	return next;
> @@ -180,15 +192,21 @@ static void fat16_ent_put(struct fat_entry *fatent, int new)
>  	if (new == FAT_ENT_EOF)
>  		new = EOF_FAT16;
>  
> +	spin_lock(&fat16_entry_lock);
>  	*fatent->u.ent16_p = cpu_to_le16(new);
> +	spin_unlock(&fat16_entry_lock);
> +
>  	mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
>  }
>  
>  static void fat32_ent_put(struct fat_entry *fatent, int new)
>  {
>  	WARN_ON(new & 0xf0000000);
> +	spin_lock(&fat32_entry_lock);
>  	new |= le32_to_cpu(*fatent->u.ent32_p) & ~0x0fffffff;
>  	*fatent->u.ent32_p = cpu_to_le32(new);
> +	spin_unlock(&fat32_entry_lock);
> +
>  	mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

