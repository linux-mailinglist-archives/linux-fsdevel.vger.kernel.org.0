Return-Path: <linux-fsdevel+bounces-79724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOq/GvEZrmk0/gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 01:53:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC32232F53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 01:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6485302F394
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 00:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9172C23EAB3;
	Mon,  9 Mar 2026 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoalRqgi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC0B240611
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 00:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017545; cv=none; b=UTCAZDMcYi40EP33fr6TaFvG4oiJm+ARIMFhrdS7dKUKYeuhKrXvkr+gsx7mvYe6YnEW0ksNwX4HubUFR29q/Fcg06voDlcCco+t8BAE+wmd0lnYAejkYtqlLfPyiRwOfsp1MlQ9HAIuUNPNhmQvgERHQK6Y3O/Cb4XChlPMJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017545; c=relaxed/simple;
	bh=AWaD+SFeJHfnp4O++vyKZKD14vizSRwUkG0CBTCkz1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHNS1gpVU2pH3AxedLfymm+r/ylAK6Xi7ZWg09VeQZwkoXFTO69oJoBwoD3CmMz8IOOvbLb/GDDVixmJ4I7m6Dt3XoQLHpCl1V0uS/ZoDmpaYozcLiNfqNfBlY9xQZoidjGxNCiGDOrTufl9wYoNiD7VKDruoNTm5QArjWqNzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoalRqgi; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3598581ed7bso3039879a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Mar 2026 17:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773017543; x=1773622343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gnlpU1QytQS1AGvQv77WKTVXXQRLYUL/qqpprLh0/k=;
        b=KoalRqgiInfp5pNG2Al4GgiaBRK5jx/5jd5N9cmV3fgZpOzNK40pjA1Kr/4JU4fBRQ
         TrP707uZVtTFt8Zb/GHFd0YqiObJpJWCgvwS4COgjdeYG5NKNJhcl2rfGa76YgkP0Xsg
         HpcUZ8C4NY96XajWnmEh0Zi2kY5iMJPMqhM/FHKJ0+E3J/Ia3n4zOEohoxcUY1Tof1g7
         mGRuciI3IABD6tYa7cS3guD5Gwpo0CfzIjN3GUamRtHV28nPhrAVle0U0lnczR999V1W
         ldNh1nt2sKTLY240Pk/WLKQno42YbQWvxLZGxawwTQW0bVZYWOIZyLh3y4TXFYfgDe9g
         NeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773017543; x=1773622343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gnlpU1QytQS1AGvQv77WKTVXXQRLYUL/qqpprLh0/k=;
        b=hnLc5xeSRF48BeS7Gjk4wTmj8EoAbibuPuTRpeeOn9DFQeGisNmqSvgzQCX/oGK8XV
         YZL/I4xoGF9WrAMxozNqqKOD1iuCUVW5OgLLClCUlqLqQktZLpIe3PD/S4qBpxVOATuA
         0VuZNOhd0cxg7z9TSChI81khTMZbRdcrYa3NQZPzgDnPTzh5mozDKyLVnPT8TGe26PkP
         A+F5qry+LX8vbMjJwk9gC3ZfDMweSoIWpXi/EgIGxdhADfFID5qwiY9J7KYDQ07R9gNn
         r33KjZjuDIAyG8jV9a1SFoPT3lOVjjQwZ2JZKOi/nvCgLvm9Byp0Wztn2SnP0MOrGuaz
         UIpA==
X-Forwarded-Encrypted: i=1; AJvYcCV47tIVseE4dWzPj7SLZXh53URc7dbKwq+smwBd3S3Ho/3PrXVsNGtmxWYDI0NSwJ2+8Wupte7ToSM5Un0V@vger.kernel.org
X-Gm-Message-State: AOJu0YzQxkRT+Ovc4OJHu2NtcTQ60+AF9WpXh1EgxQ2nGDx7KV+G0ySu
	f0XppVO2gygoxGt49ymkRUAIw2FE0sEDUlQEqerlLM686r+CZaLdxQWj
X-Gm-Gg: ATEYQzwN4aO+OAPiG9cNuS77JyV7PzvrrTelCyfeodSxrZEds8QhkclXa16tifYATqa
	tWnjOuXn1W+KYzs2TkXhXzZH1FA0SJJbEpgYpepvKIbOIcpdbn6Mf4dyTMLeIwiDqJ+YzPpdyUi
	uyWpVPlnNxAbiouZt0TAvK1UaeUbR1jnXCAVRnlDPXI2s79t3n4i0Q+MVqHSKAzPXXLfEAJ5TyE
	nvEAC8bFxsYqhda2OMczVcNZEnTlAlCfFhzN98CZfa2jpsbbX4/64jDGg+1Ct/kGTfaDY3ds081
	U0T7zflkK5fizE2O0q4cRt6OCj3tlmhSJzw5s35ZpxREOYlRpjbIyZjaUWV7EQb3ZZHs62TQOzf
	o/YRmNLjEFUzT+i5ttp6cjK74a8TciEvubTc+oaUm6B+0uKS/H0DsuUA1atxzOA5CyHtzPCwEou
	9P8qb0DO4v4pXLPQ==
X-Received: by 2002:a17:90b:1dcc:b0:352:d59a:b28 with SMTP id 98e67ed59e1d1-359be31d2dfmr8333919a91.19.1773017543110;
        Sun, 08 Mar 2026 17:52:23 -0700 (PDT)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c0154a09sm8888074a91.12.2026.03.08.17.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 17:52:22 -0700 (PDT)
Date: Mon, 9 Mar 2026 09:52:20 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"cheol.lee@lge.com" <cheol.lee@lge.com>
Subject: Re: [PATCH] hfsplus: limit sb_maxbytes to partition size
Message-ID: <aa4ZxJ1Lkk_9-f-C@hyunchul-PC02>
References: <aaguv09zaPCgdzWO@infradead.org>
 <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
 <aajObSSRGVXG3sI_@hyunchul-PC02>
 <532c5cdf12ced8eee5e5a93efe592937b63b889d.camel@ibm.com>
 <CANFS6bZm3G9HA3X5Bi2_KGZDNGuguQzG44-cMcQHto2+qe_05g@mail.gmail.com>
 <e979abaf61fa6d7fab444eac293fcbc2993c78ee.camel@ibm.com>
 <aaomj9LgbfSem-aF@hyunchul-PC02>
 <f174f7f928c9ee29f1c138d9ca1b23abfbc77d0c.camel@ibm.com>
 <aao2Ua94b16am-BE@hyunchul-PC02>
 <cecaebb4c333439ea6e10808908f69cd3f3dbf95.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cecaebb4c333439ea6e10808908f69cd3f3dbf95.camel@ibm.com>
X-Rspamd-Queue-Id: DBC32232F53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79724-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 08:08:40PM +0000, Viacheslav Dubeyko wrote:
> On Fri, 2026-03-06 at 11:05 +0900, Hyunchul Lee wrote:
> > On Fri, Mar 06, 2026 at 01:23:16AM +0000, Viacheslav Dubeyko wrote:
> > > On Fri, 2026-03-06 at 09:57 +0900, Hyunchul Lee wrote:
> > > > On Thu, Mar 05, 2026 at 11:21:19PM +0000, Viacheslav Dubeyko wrote:
> > > > > On Thu, 2026-03-05 at 10:52 +0900, Hyunchul Lee wrote:
> > > > > > > > 
> > > > > > > > Sorry it's generic/285, not generic/268.
> > > > > > > > in generic/285, there is a test that creates a hole exceeding the block
> > > > > > > > size and appends small data to the file. hfsplus fails because it fills
> > > > > > > > the block device and returns ENOSPC. However if it returns EFBIG
> > > > > > > > instead, the test is skipped.
> > > > > > > > 
> > > > > > > > For writes like xfs_io -c "pwrite 8t 512", should fops->write_iter
> > > > > > > > returns ENOSPC, or would it be better to return EFBIG?
> > > > > > > > > 
> > > > > > > 
> > > > > > > Current hfsplus_file_extend() implementation doesn't support holes. I assume you
> > > > > > > mean this code [1]:
> > > > > > > 
> > > > > > >         len = hip->clump_blocks;
> > > > > > >         start = hfsplus_block_allocate(sb, sbi->total_blocks, goal, &len);
> > > > > > >         if (start >= sbi->total_blocks) {
> > > > > > >                 start = hfsplus_block_allocate(sb, goal, 0, &len);
> > > > > > >                 if (start >= goal) {
> > > > > > >                         res = -ENOSPC;
> > > > > > >                         goto out;
> > > > > > >                 }
> > > > > > >         }
> > > > > > > 
> > > > > > > Am I correct?
> > > > > > > 
> > > > > > Yes,
> > > > > > 
> > > > > > hfsplus_write_begin()
> > > > > >   cont_write_begin()
> > > > > >     cont_expand_zero()
> > > > > > 
> > > > > > 1) xfs_io -c "pwrite 8t 512"
> > > > > > 2) hfsplus_begin_write() is called with offset 2^43 and length 512
> > > > > > 3) cont_expand_zero() allocates and zeroes out one block repeatedly
> > > > > > for the range
> > > > > > 0 to 2^43 - 1. To achieve this, hfsplus_write_begin() is called repeatedly.
> > > > > > 4) hfsplus_write_begin() allocates one block through hfsplus_get_block() =>
> > > > > > hfsplus_file_extend()
> > > > > 
> > > > > I think we can consider these directions:
> > > > > 
> > > > > (1) Currently, HFS+ code doesn't support holes. So, it means that
> > > > > hfsplus_write_begin() can check pos variable and i_size_read(inode). If pos is
> > > > > bigger than i_size_read(inode), then hfsplus_file_extend() will reject such
> > > > > request. So, we can return error code (probably, -EFBIG) for this case without
> > > > > calling hfsplus_file_extend(). But, from another point of view, maybe,
> > > > > hfsplus_file_extend() could be one place for this check. Does it make sense?
> > > > > 
> > > > > (2) I think that hfsplus_file_extend() could treat hole or absence of free
> > > > > blocks like -ENOSPC. Probably, we can change the error code from -ENOSPC to -
> > > > > EFBIG in hfsplus_write_begin(). What do you think?
> > > > > 
> > > > Even if holes are not supported, shouldn't the following writes be
> > > > supported?
> > > > 
> > > > xfs_io -f -c "pwrite 4k 512" <file-path>
> > > > 
> > > > If so, since we need to support cases where pos > i_size_read(inode),
> > > 
> > > The pos > i_size_read(inode) means that you create the hole. Because,
> > 
> > That's correct. However I believe that not supporting writes like the
> > one mentioned above is a significant limitation. Filesystems that don't
> > support sparse files, such as exFAT, allocate blocks and fill them with
> > zeros.
> > 
> 
> You are welcomed to write the code for HFS/HFS+. :) I'll be happy to see such
> support.
> 
> > > oppositely, when HFS+ logic tries to allocate new block, then it expects to have
> > > pos == i_size_read(inode). And we need to take into account this code [1]:
> > > 
> > > 	if (iblock >= hip->fs_blocks) {
> > > 		if (!create)
> > > 			return 0;
> > > 		if (iblock > hip->fs_blocks) <-- This is the rejection of hole
> > > 			return -EIO;
> > > 		if (ablock >= hip->alloc_blocks) {
> > > 			res = hfsplus_file_extend(inode, false);
> > > 			if (res)
> > > 				return res;
> > > 		}
> > > 	}
> > > 
> > > The generic_write_end() changes the inode size: i_size_write(inode, pos +
> > > copied).
> > 
> > I think that it's not problem.
> > 
> > hfsplus_write_begin()
> >   cont_write_begin()
> >     cont_expand_zero()
> > 
> > cont_expand_zero() calls hfsplus_get_block() to allocate blocks between
> > i_size_read(inode) and pos, if pos > i_size_read(inode).
> > 
> 
> Currently, HFS/HFS+ expect that file should be extended without holes. It means
> that next allocating block should be equal to number of allocated blocks in
> file. If pos > i_size_read(inode), then it means that next allocating block is
> not equal to number of allocated blocks in file.
> 
> If you imply that requested length could include multiple blocks for allocation,
> then next allocating block should be equal to number of allocated blocks on
> every step. And if the next allocating block is bigger than number of allocated
> blocks in file, then hole creation is requested.
> 
> So, what are we discussing here? :)
> 

The email is getting lengty, so I will try to summarize the
discussion. :)

As mentioned before, if hfsplus_write_begin() returns an error when
pos > i_size_read(inode), the following write will fail:

xfs_io -f -c "pwrite 4k 512" <file-path>

However, currently hfsplus allows this write.

Therefore, the condition, pos - i_size_read(inode) > free space is
necessary, and futhermore, I think it is better to check the condtion
in write_iter() instead of write_begin().


> > > 
> > > > wouldn't the condition "pos - i_size_read(inode) > free space" be better?
> > > > Also instead of checking every time in hfsplus_write_begin() or
> > > > hfsplus_file_extend(), how about implementing the check in the
> > > > file_operations->write_iter callback function, and returing EFBIG?
> > > 
> > > Which callback do you mean here? I am not sure that it's good idea.
> > > 
> > 
> > Here is a simple code snippet.
> > 
> >  static const struct file_operations hfsplus_file_operations = {
> > ...
> > -       .write_iter     = generic_file_write_iter,
> > +       .write_iter     = hfsplus_file_write_iter,
> > ...
> > 
> > +ssize_t hfsplus_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
> > +{
> > ...
> > +       // check iocb->ki_pos is beyond i_size
> > +
> > +       ret = generic_file_write_iter(iocb, iter);
> > 
> 
> The hfsplus_write_begin() will be called before hfsplus_file_write_iter() if we
> are trying to extend the file. And hfsplus_get_block() calls
> hfsplus_file_extend() that will call hfsplus_block_allocate(). So, everything
> will happen before hfsplus_file_write_iter() call. What's the point to have the
> check here?

The callstack for write(2) is as follows. Am I misunderstanding
something?

write()
  do_sync_write()
    fops->write_iter()
    generic_file_write_iter()
      aops->write_begin()
      hfsplus_write_begin()

> 
> Thanks,
> Slava.
> 
> > 

-- 
Thanks,
Hyunchul

