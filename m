Return-Path: <linux-fsdevel+bounces-41171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019D6A2BEC2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 10:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACE93AA7DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 09:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4121D5CE5;
	Fri,  7 Feb 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQIt3oj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165CA1B4F0C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919228; cv=none; b=PhIn2ytgyJGtZ/ho/Bt5LAZwe3aA2D0pPUm91Fvl8zyN+VL7yTSzXpDmvfkq/7f9jMBL8ChRLPPLtgR+fXoHaRcRrHrNiewW1TBBeF/h0iNSSXwUk9pAgmVT71TifW4v9EF6Peg4yQDmL4hVA7AJ2+CUDBFM2SecAjyuvQaEP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919228; c=relaxed/simple;
	bh=HaTr9grLxr5ptKgxmPfwlLtW1LyAQim7m58eyLTdgWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTdW4EN0vcCuWOmX6q2KDY4k3qlCmG4VbLh9ba/DDecfHGUPSAkSFIZeFYUruFbTrQkvpRc4VQjcedmXtoEgRr65f5uCif1LiYqTv/pA2bqlGAjNVRZYu9k28/P007DyavLrH7O2myplaXprMIDR4u4UyFdAv5/TjzUK8wR/jAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQIt3oj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E41C4CED1;
	Fri,  7 Feb 2025 09:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738919227;
	bh=HaTr9grLxr5ptKgxmPfwlLtW1LyAQim7m58eyLTdgWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQIt3oj4u8bpD8CgZu7HCtPiEcvSSDlYbIcTHmkdTqHhS15iOS9kbMxz1qg+//+9x
	 ajlvtjJJkxwoegDLTEQXl89Oa17JiWx8BxybrRH1/Ytfzaxu/cI/fOgVKV8zQ5NrtD
	 lcaOvv4ED0bdOQhIL/tes1aMVbNP71/n6pN18WVjWL6NKXuieARUuukgogLDB6D6p9
	 s83E5xsd4EbWVz/h579H0mXD8nHoMY4VRBoOFmKq4rMkh6F2kYhn9WemwARGhQ6EQe
	 srd2GVeVw6szOBvMU5ChX1Pk3W1MxDK5Ksg/Si1F+VCIjejJEcgpzj3uF+9vqfPT6r
	 WToeM1MSu8ZTA==
Date: Fri, 7 Feb 2025 10:07:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] statmount: allow to retrieve idmappings
Message-ID: <20250207-herben-abstrahiert-9bf48ad63a78@brauner>
References: <a4ef5f7d-9a6c-4f24-b377-557c3af0182f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4ef5f7d-9a6c-4f24-b377-557c3af0182f@stanley.mountain>

On Fri, Feb 07, 2025 at 12:03:23PM +0300, Dan Carpenter wrote:
> Hello Christian Brauner,
> 
> Commit f8c6e8bd9ad5 ("statmount: allow to retrieve idmappings") from
> Feb 4, 2025 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	fs/namespace.c:5468 statmount_string()
> 	error: uninitialized symbol 'offp'.

Oh right, that's after Miklos' changes. That is an annoying subtle
interaction between two branches. I'll fix that once vfs.fixes lands
upstream.

Thanks for the report.

> 
> fs/namespace.c
>     5388 static int statmount_string(struct kstatmount *s, u64 flag)
>     5389 {
>     5390         int ret = 0;
>     5391         size_t kbufsize;
>     5392         struct seq_file *seq = &s->seq;
>     5393         struct statmount *sm = &s->sm;
>     5394         u32 start, *offp;
>     5395 
>     5396         /* Reserve an empty string at the beginning for any unset offsets */
>     5397         if (!seq->count)
>     5398                 seq_putc(seq, 0);
>     5399 
>     5400         start = seq->count;
>     5401 
>     5402         switch (flag) {
>     5403         case STATMOUNT_FS_TYPE:
>     5404                 offp = &sm->fs_type;
>     5405                 ret = statmount_fs_type(s, seq);
>     5406                 break;
>     5407         case STATMOUNT_MNT_ROOT:
>     5408                 offp = &sm->mnt_root;
>     5409                 ret = statmount_mnt_root(s, seq);
>     5410                 break;
>     5411         case STATMOUNT_MNT_POINT:
>     5412                 offp = &sm->mnt_point;
>     5413                 ret = statmount_mnt_point(s, seq);
>     5414                 break;
>     5415         case STATMOUNT_MNT_OPTS:
>     5416                 offp = &sm->mnt_opts;
>     5417                 ret = statmount_mnt_opts(s, seq);
>     5418                 break;
>     5419         case STATMOUNT_OPT_ARRAY:
>     5420                 offp = &sm->opt_array;
>     5421                 ret = statmount_opt_array(s, seq);
>     5422                 break;
>     5423         case STATMOUNT_OPT_SEC_ARRAY:
>     5424                 offp = &sm->opt_sec_array;
>     5425                 ret = statmount_opt_sec_array(s, seq);
>     5426                 break;
>     5427         case STATMOUNT_FS_SUBTYPE:
>     5428                 offp = &sm->fs_subtype;
>     5429                 statmount_fs_subtype(s, seq);
>     5430                 break;
>     5431         case STATMOUNT_SB_SOURCE:
>     5432                 offp = &sm->sb_source;
>     5433                 ret = statmount_sb_source(s, seq);
>     5434                 break;
>     5435         case STATMOUNT_MNT_UIDMAP:
>     5436                 sm->mnt_uidmap = start;
>     5437                 ret = statmount_mnt_uidmap(s, seq);
> 
> offp not initialized
> 
>     5438                 break;
>     5439         case STATMOUNT_MNT_GIDMAP:
>     5440                 sm->mnt_gidmap = start;
>     5441                 ret = statmount_mnt_gidmap(s, seq);
> 
> Same here
> 
>     5442                 break;
>     5443         default:
>     5444                 WARN_ON_ONCE(true);
>     5445                 return -EINVAL;
>     5446         }
>     5447 
>     5448         /*
>     5449          * If nothing was emitted, return to avoid setting the flag
>     5450          * and terminating the buffer.
>     5451          */
>     5452         if (seq->count == start)
>     5453                 return ret;
>     5454         if (unlikely(check_add_overflow(sizeof(*sm), seq->count, &kbufsize)))
>     5455                 return -EOVERFLOW;
>     5456         if (kbufsize >= s->bufsize)
>     5457                 return -EOVERFLOW;
>     5458 
>     5459         /* signal a retry */
>     5460         if (unlikely(seq_has_overflowed(seq)))
>     5461                 return -EAGAIN;
>     5462 
>     5463         if (ret)
>     5464                 return ret;
>     5465 
>     5466         seq->buf[seq->count++] = '\0';
>     5467         sm->mask |= flag;
> --> 5468         *offp = start;
>                  ^^^^^^^^^^^^^^
> 
>     5469         return 0;
>     5470 }
> 
> regards,
> dan carpenter

