Return-Path: <linux-fsdevel+bounces-4363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1FE7FEF42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8041F20CD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AFF4779E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9vb1tdR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF306D50;
	Thu, 30 Nov 2023 03:00:09 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d011cdf562so7463865ad.2;
        Thu, 30 Nov 2023 03:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701342008; x=1701946808; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=161UqmnxQ3DKjSd1QEA0SwThojNVCkaD+GMutSubUiw=;
        b=T9vb1tdR4hnjLyUVcfkqvM8bwcW/EaHS5KcHBzbg0m1RFlPfLwjzhbmBmJqltsD+WL
         F+owc9AXnA/v4SmGzq1mjZxDad+ddd2ioVutc5FOHykz6SlGoyibqps2IVkvsX7m4ya/
         M19IS6eIsaF4qrbk5oeXnQU3pwoKS4UoWnIMXSY425RfdSLrJC6Nc2agA/LF3SSIs5+f
         7HryIUOeMQvbgFhNSvB9wXyjNbVyIM8gf1f9gaKA3uWWW3ZK2ebXUnXO02uvQOm1vdPP
         nDqp7+VLb/VDI2dKulIaBkLU9qBEgR5D67F1mSwVqe31p0AdzfBgzL250CosWTKqLLFX
         z+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701342008; x=1701946808;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=161UqmnxQ3DKjSd1QEA0SwThojNVCkaD+GMutSubUiw=;
        b=EQF8xeQulhTYmSrLAktSIv+ddQ6/PRC5gmrygLzaELuO5uVV4XBPndlYotObfuqE+4
         LdjSzOwlE9As3SJlLC35hGpimbR2dxaY/Qw9/JAlUBDCLl6b/REUILpVpaOr7spDZRva
         Qn6phE6W1ew4WIo/p5GvHay7lUbXlDxMknq2NYvB7LH1YT15+mJ1n8A1wcNySoKEmbTF
         7rO5WTiUKmMX45DNDwm3n3b7kEMkDLr8whgcDMQ3YTThJWQOGesWedp1ckbcYKLvOjas
         yIYMU5Gt8yggNW2wzfWFAmbnChHh7kG9WTf9ZhISreryCpqQfbgyMqu21FsFuovDS+pk
         njXQ==
X-Gm-Message-State: AOJu0Yydu5fY9/TR5saaFvzgZiXJ1C7rewuoAC6pbRqHecv3tmZ67xU3
	k4ZmlOuI0jIIko67e+3zwEoa1h5mKQE=
X-Google-Smtp-Source: AGHT+IFV8jkNi9ZRhV70nCQs7mPiizkOldCsAvuOoRULWFfyg/8NOEiZW6ULU0j4cf0NJ0G9650Xsg==
X-Received: by 2002:a17:902:ea84:b0:1cc:3b87:8997 with SMTP id x4-20020a170902ea8400b001cc3b878997mr17504748plb.57.1701342007930;
        Thu, 30 Nov 2023 03:00:07 -0800 (PST)
Received: from dw-tp ([2401:4900:1cc4:6c8b:6e63:fbc7:5622:17cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902c38c00b001cfd80d0fe8sm1066431plg.98.2023.11.30.03.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 03:00:07 -0800 (PST)
Date: Thu, 30 Nov 2023 16:29:59 +0530
Message-Id: <87fs0nik0g.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use iomap
In-Reply-To: <20231130101845.mt3hhwbbpnhroefg@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Jan Kara <jack@suse.cz> writes:

> On Thu 30-11-23 13:15:58, Ritesh Harjani wrote:
>> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>> 
>> > Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>> >
>> >> Christoph Hellwig <hch@infradead.org> writes:
>> >>
>> >>> On Wed, Nov 22, 2023 at 01:29:46PM +0100, Jan Kara wrote:
>> >>>> writeback bit set. XFS plays the revalidation sequence counter games
>> >>>> because of this so we'd have to do something similar for ext2. Not that I'd
>> >>>> care as much about ext2 writeback performance but it should not be that
>> >>>> hard and we'll definitely need some similar solution for ext4 anyway. Can
>> >>>> you give that a try (as a followup "performance improvement" patch).
>> 
>> ok. So I am re-thinknig over this on why will a filesystem like ext2
>> would require sequence counter check. We don't have collapse range
>> or COW sort of operations, it is only the truncate which can race,
>> but that should be taken care by folio_lock. And even if the partial
>> truncate happens on a folio, since the logical to physical block mapping
>> never changes, it should not matter if the writeback wrote data to a
>> cached entry, right?
>
> Yes, so this is what I think I've already mentioned. As long as we map just
> the block at the current offset (or a block under currently locked folio),
> we are fine and we don't need any kind of sequence counter. But as soon as
> we start caching any kind of mapping in iomap_writepage_ctx we need a way
> to protect from races with truncate. So something like the sequence counter.
>

Why do we need to protect from the race with truncate, is my question here.
So, IMO, truncate will truncate the folio cache first before releasing the FS
blocks. Truncation of the folio cache and the writeback path are
protected using folio_lock()
Truncate will clear the dirty flag of the folio before
releasing the folio_lock() right, so writeback will not even proceed for
folios which are not marked dirty (even if we have a cached wpc entry for
which folio is released from folio cache).

Now coming to the stale cached wpc entry for which truncate is doing a
partial truncation. Say, truncate ended up calling
truncate_inode_partial_folio(). Now for such folio (it remains dirty
after partial truncation) (for which there is a stale cached wpc entry),
when writeback writes to the underlying stale block, there is no harm
with that right?

Also this will "only" happen for folio which was partially truncated.
So why do we need to have sequence counter for protecting against this
race is my question. 

So could this be only needed when existing logical to physical block
mapping changes e.g. like COW or maybe collapse range?

-ritesh

