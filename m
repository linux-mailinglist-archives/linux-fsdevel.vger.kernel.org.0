Return-Path: <linux-fsdevel+bounces-73873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD90D225E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 05:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07D923019B4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 04:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36479274FE3;
	Thu, 15 Jan 2026 04:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Svz2/n1q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B96F200113
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 04:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768451809; cv=none; b=F75CzQm/pzUopq3TpMTM42RinTSCVCz1E5MqvVyykivEhJWLpDmr62xTcIV8eweXZR2WhveDGUFsGwEReJzHyU2AuP6VBLSYd6mditRLrIFX06hsx1OmLrgTqcXDR9gWN+kXe+YukyAfMOlpp9AcYAbNsF7nqiv7pPI3mzhsrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768451809; c=relaxed/simple;
	bh=nTuOwcK3WdpSBj6/qmWfkjx26neN6SQ02742KmHEqqM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uE6UpN7VbWaEwzarjAeIqkOk1coR1IoXs02cotdCqVvmEz6KRo0NdBnvOYx+v5PnYensyaY9kn5PD+amBMFNzdiEd1hFiXoCJOiKu12CMi97BbKfpKilHTT4aZhpFGEFmQLCL7c2O+igkgRxouYhNE+cMsw+GtnHW/uW7mT/3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Svz2/n1q; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768451797; bh=jS0kSi1uGjzmcE2HffwvJFezQq5pW9yVnyUwZ/f9szI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Svz2/n1qwmXeAjabggwqehIZJtR3JiOS7E5c/BSKB5zzvTFb57kQGg0d3mhBo/LIy
	 zClVKHU5Xh6KsSE8FGEJUawwuRnC5zQG1gcj5iTy7ICRMetcUbNUsy5dHbEYwSIGDy
	 kPUz2R1lch0McK7UGDklk8rdfHcJbg7CNV5dlAKk=
Received: from OptiPlex-9020.. ([58.32.209.43])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 8CBACA1C; Thu, 15 Jan 2026 12:35:11 +0800
X-QQ-mid: xmsmtpt1768451711tr30nzvoa
Message-ID: <tencent_66D3FC4CD38DC41105DE342C4FC15D0C5309@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+xDQSwPY3ch2q4/yjFzDcb+rklaMP8QPhxM0kwHoWoFjvg2LJD+
	 AOCnyzCpiHauIVhHgl0wq3PnNde1pBRLjBNslSPiuNZ63/8JCgshjTTbc028pLowRtLTNstWjVq3
	 hjVt9vx6l5zymkD9LS+noy+oJ8EEsSYs3Igyq22+0DQxNyCiiBfiQhhHimVvF/YvKXKUzVkGwN8z
	 +26FJfL64wwDt6QoNj5PwhqejatUcHiuzolG/QYIaHyLBdhR9c+OHYhCIV4WGrUstdUuyRmFZIub
	 ATH0LaOeULYcNOpAHasc+UBIH/QjRyCm/uhGwzkZGmDWV4Bcw3Z/TdAtPJc5cI00GRQ7wMZ3CMQr
	 +RClT1OKc5dVsK7qQUGW9phJMfxfxLYvpp/uUmw5Z3Bi3s49FcobeNd0ZSy6ut5jKVopanhCZvQ0
	 JbCSaj6YcGOVHlA1RFk4JLHzUHLp7mxCwlsJFZAjLd1QHj5c4ZNmWuagBY/DyJXq+bsTA+YJejcT
	 6OmNvE1an5kw4ILlOn+SWADO/dZidNUUlGm80Mo2vsUCr1KugOAQPNYyjhmFDHlsr4EuaFRokNgi
	 LozZq4VbiCfct1qhytxhPF2WlvOdsebN0KdeS3de/2UFI36p6Qypv15AkZTciR52BwP0+ybiiwOf
	 UyEL4UoQMY/mZJv9Fd6ag2RjXx/O+8PR0do+sc/IGEu4FHeh7iYIqz2rOP0jP+oKGhIdq9RlcU5k
	 QMRn1aWdTENyOV+G4JiYs1oCHv2V9Upx3KdniUJNjPQWusjr1lP8uy2GoI95uon10uT8PNMt5IHf
	 /3I8YU+rU43ipAFg/Gi3vt7SpfkvWiQzAUUx3C37KVXolcxPTSJv7Fy52+KFXspwMobCYPR2Jfrd
	 iytw1Nc7ivQ7u6bi3bP7OSluoLGQv6++29fIzrOiyDVi+/MObobaOEwI3sRkkZqhaKfYHOu66qAu
	 aiU6Xl06SzZpOdHWJ0x5ItQxARxWfw8bX9h02m+HkQON9KHpNpijDwk9zYGpihJC2UXyyPUM7fWH
	 XU6rrz8uXk/oMwQHlhWLS2OKi9cqaKHTKMVH4fFppUQubdqZtxnYIdySpn6icB+VxOmxh8FJEfWv
	 GBl7CXUP2yaO4vDRw=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: yuling-dong@qq.com
To: linkinjeon@kernel.org
Cc: Yuezhang.Mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	sj1557.seo@samsung.com,
	willy@infradead.org
Subject: Re: [PATCH v1] exfat: reduce unnecessary writes during mmap write
Date: Thu, 15 Jan 2026 12:33:44 +0800
X-OQ-MSGID: <20260115043343.1033074-2-yuling-dong@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAKYAXd9zEBvOOz+5fnozEzRLDnGeY8ZiXv1o87aHOY+rkqFOEQ@mail.gmail.com>
References: <CAKYAXd9zEBvOOz+5fnozEzRLDnGeY8ZiXv1o87aHOY+rkqFOEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jan 15, 2026 at 9:50 AM Namjae Jeon <linkinjeon@kernel.org> wrote:
> On Tue, Jan 13, 2026 at 10:36 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Jan 12, 2026 at 07:48:59AM +0000, Yuezhang.Mo@sony.com wrote:
> > > Oh no, sorry, there's something wrong with my environment. Resend the email.
> > >
> > > On Sun, Jan 11, 2026 at 05:51:34AM +0000, Matthew Wilcox wrote:
> > > > On Sun, Jan 11, 2026 at 05:19:55AM +0000, Matthew Wilcox wrote:
> > > > > On Thu, Jan 08, 2026 at 05:38:57PM +0800, yuling-dong@qq.com wrote:
> > > > > > -       start = ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> > > > > > -       end = min_t(loff_t, i_size_read(inode),
> > > > > > -                       start + vma->vm_end - vma->vm_start);
> > > > > > +       new_valid_size = (loff_t)vmf->pgoff << PAGE_SHIFT;
> > > > >
> > > > > Uh, this is off-by-one.  If you access page 2, it'll expand the file
> > > > > to a size of 8192 bytes, when it needs to expand the file to 12288
> > > > > bytes.  What testing was done to this patch?
> > > >
> > > > Oh, and we should probably make this function support large folios
> > > > (I know exfat doesn't yet, but this is on your roadmap, right?)
> > > > Something like this:
> > > >
> > > >     struct folio *folio = page_folio(vmf->page)
> > > >     loff_t new_valid_size = folio_next_pos(folio);
> > > >
> > > > ... although this doesn't lock the folio, so we could have a race
> > > > where the folio is truncated and then replaced with a larger folio
> > > > and we wouldn't've extended the file enough.  So maybe we need to
> > > > copy the guts of filemap_page_mkwrite() into exfat_page_mkwrite().
> > > > It's all quite tricky because exfat_extend_valid_size() also needs
> > > > to lock the folio that it's going to write to.
> > > >
> > > > Hm.  So maybe punt on all this for now and just add the missing "+ 1".
> > >
> > > Hi Matthew,
> > >
> > > Thank you for your feedback!
> > >
> > > There are two ways to extend valid_size: one is by writing 0 through
> > > exfat_extend_valid_size(), and the other is by writing user data.
> > > Before writing user data, we just need to extend valid_size to the
> > > position of user data.
> > >
> > > In your example above, valid_size is extended to 8192 by
> > > exfat_extend_valid_size(), and when page 2(user data) is written,
> > > valid_size will be expanded to 12288.
> >
> > This _is_  the point where we write user data to page 2 though.
> > There's no other call to the filesystem after page_mkwrite; on return
> > the page is dirty and in the page tables.  Userspace gets to write to
> > it without further kernel involvement until writeback comes along and
> > unmaps it from the page table.
> Okay, And using pgoff + 1 sets new_valid_size can be larger than
> ->i_size, which causes generic/029 test failure. We need to ensure
> ->valid_size stays within ->i_size like this.
>
> +       new_valid_size = ((loff_t)vmf->pgoff + 1) << PAGE_SHIFT;
> +       new_valid_size = min(new_valid_size, i_size_read(inode));

Okay, I will update this to v2.


