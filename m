Return-Path: <linux-fsdevel+bounces-73860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0E0D22116
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78AED304A907
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 01:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9794D242925;
	Thu, 15 Jan 2026 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GplqxWvj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47113D891
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768441868; cv=none; b=IDcjwQPFTMfAeuh/k2i5jBXULCBlfiWyJtaJe5Dh7I8p5cniD7htmxSG+Lh1CEFwTNtEV8t2RInV8qNXCColryRQJRrFSXj/mnbInyZ8j1zQCRjqidsFWzSHKQz+VD68f+gBDHshnZiFCNxCRsqGDUlM+qQ89ySJoUGO3Iog420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768441868; c=relaxed/simple;
	bh=QBisRS5BSWGInO68euW8dU9VxoHRijJ9fqZK44zTqoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=es+qDcXJNYp5G2EpMPvt+qTc/GlIEuJ0q0+Vztveqogc5s0cntJOP/2m22zoOTUv+QxjHVvi6u4ax1l+15UUL/jfU2WFRKOtH0zq9HlRtT2RWBJl7XMHxXGjKwzjasy5FswH5/faI53EVUtD5RALhlGllY9qGpeoakH+qOG5xSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GplqxWvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC8FC4CEF7
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 01:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768441867;
	bh=QBisRS5BSWGInO68euW8dU9VxoHRijJ9fqZK44zTqoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GplqxWvjvBD8TAE2YV2zqbr+FYcHiel70d1XIAxy+g4U5E8/hfjuw+Z9osE5e1aOB
	 zNpEMZo0QhJO8pVzi7j7gUbnmBkax+vsQh78303VxJFokfaDC/msSnODO7v/17PweD
	 ofIgfbsbfITnMuKo3upvABPRrl+sNGfzO0fYBbNHqPOs6HDz926NCe/XvSwppVmBM9
	 0E97FB1pVNSim29+NKPDBhYDPhxGqAU0/Bn8XO1VSDi5wHK/Be3M9pU6TAdNUffOLX
	 mhPFypm+Ut4m7Rt7k6XYzTwfZ8Nqe3j47HH3/XcybrITJN4U2qCsZLITXvBjiKejuT
	 OXlYk/+/y1O4w==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8719aeebc8so73858966b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 17:51:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiZkbg6yGV/yR0ZaagQP/HcYUqqxbq8xzXo2HpzbVSWxJMU4ePB02G5iDGt55BL8GVyjqI/m5+rMLe0k/p@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8a3FOkXGSP4ImKSW87CPPAeEsoXHVAmg+qbFrxQIu4EqG+RUF
	7xoYYdjrZg/ZkJPgn8ev9FO/nS57tObojQXzpGJ8pLFMvmxyNhL382iIqEbsnGhxKDaTJ+dGCQo
	FOcsD+6BCVo6xnGSGL9ShhLhE+pUA6Qw=
X-Received: by 2002:a17:906:c10b:b0:b87:365d:26b8 with SMTP id
 a640c23a62f3a-b87677a80a9mr323339566b.35.1768441866153; Wed, 14 Jan 2026
 17:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_E7EF2CBD4DBC5CC047C3EB74D3C52A55C905@qq.com>
 <aWMy-4X75vkHmtDE@casper.infradead.org> <20260112070506.2675963-2-Yuezhang.Mo@sony.com>
 <PUZPR04MB631645EC670C756D3C5D26538181A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <aWZKcGNQtFzHY8yN@casper.infradead.org>
In-Reply-To: <aWZKcGNQtFzHY8yN@casper.infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 15 Jan 2026 10:50:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9zEBvOOz+5fnozEzRLDnGeY8ZiXv1o87aHOY+rkqFOEQ@mail.gmail.com>
X-Gm-Features: AZwV_Qgm82Vwcpx6Dzuyi3xBiCk7qQWoVBjhW-4OnVq-90dgXdJoaCSBl9wfv6o
Message-ID: <CAKYAXd9zEBvOOz+5fnozEzRLDnGeY8ZiXv1o87aHOY+rkqFOEQ@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: reduce unnecessary writes during mmap write
To: Matthew Wilcox <willy@infradead.org>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, "yuling-dong@qq.com" <yuling-dong@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 10:36=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Jan 12, 2026 at 07:48:59AM +0000, Yuezhang.Mo@sony.com wrote:
> > Oh no, sorry, there's something wrong with my environment. Resend the e=
mail.
> >
> > On Sun, Jan 11, 2026 at 05:51:34AM +0000, Matthew Wilcox wrote:
> > > On Sun, Jan 11, 2026 at 05:19:55AM +0000, Matthew Wilcox wrote:
> > > > On Thu, Jan 08, 2026 at 05:38:57PM +0800, yuling-dong@qq.com wrote:
> > > > > -       start =3D ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> > > > > -       end =3D min_t(loff_t, i_size_read(inode),
> > > > > -                       start + vma->vm_end - vma->vm_start);
> > > > > +       new_valid_size =3D (loff_t)vmf->pgoff << PAGE_SHIFT;
> > > >
> > > > Uh, this is off-by-one.  If you access page 2, it'll expand the fil=
e
> > > > to a size of 8192 bytes, when it needs to expand the file to 12288
> > > > bytes.  What testing was done to this patch?
> > >
> > > Oh, and we should probably make this function support large folios
> > > (I know exfat doesn't yet, but this is on your roadmap, right?)
> > > Something like this:
> > >
> > >     struct folio *folio =3D page_folio(vmf->page)
> > >     loff_t new_valid_size =3D folio_next_pos(folio);
> > >
> > > ... although this doesn't lock the folio, so we could have a race
> > > where the folio is truncated and then replaced with a larger folio
> > > and we wouldn't've extended the file enough.  So maybe we need to
> > > copy the guts of filemap_page_mkwrite() into exfat_page_mkwrite().
> > > It's all quite tricky because exfat_extend_valid_size() also needs
> > > to lock the folio that it's going to write to.
> > >
> > > Hm.  So maybe punt on all this for now and just add the missing "+ 1"=
.
> >
> > Hi Matthew,
> >
> > Thank you for your feedback!
> >
> > There are two ways to extend valid_size: one is by writing 0 through
> > exfat_extend_valid_size(), and the other is by writing user data.
> > Before writing user data, we just need to extend valid_size to the
> > position of user data.
> >
> > In your example above, valid_size is extended to 8192 by
> > exfat_extend_valid_size(), and when page 2(user data) is written,
> > valid_size will be expanded to 12288.
>
> This _is_  the point where we write user data to page 2 though.
> There's no other call to the filesystem after page_mkwrite; on return
> the page is dirty and in the page tables.  Userspace gets to write to
> it without further kernel involvement until writeback comes along and
> unmaps it from the page table.
Okay, And using pgoff + 1 sets new_valid_size can be larger than
->i_size, which causes generic/029 test failure. We need to ensure
->valid_size stays within ->i_size like this.

+       new_valid_size =3D ((loff_t)vmf->pgoff + 1) << PAGE_SHIFT;
+       new_valid_size =3D min(new_valid_size, i_size_read(inode));

