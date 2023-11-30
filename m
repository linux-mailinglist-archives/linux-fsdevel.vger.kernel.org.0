Return-Path: <linux-fsdevel+bounces-4428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CC97FF667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459DE1C20B8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E68F55779
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNet9PkU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0AA10C2;
	Thu, 30 Nov 2023 07:50:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so10603375ad.0;
        Thu, 30 Nov 2023 07:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701359445; x=1701964245; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0goqKxcMvIJg1pJ3dIpaV32YvQD1iKsLBU0J6I6POoM=;
        b=UNet9PkUMUWAi+mNvOH7/re46y2cCXkSAI+rpqNgHRvLEZVXFb6ykWIrxxztLQrY6x
         N7ZRZ1KwM6RHnpAbRG3YPA7ajDXHQNw1YyLaJnJsKE49V7Byr1QIVo8yNajLx20gA2+z
         pdHBtx/f/QQ8deFEMvM5d6IWM3gZDBq9ZC6naTp0Qmb8hBBTuYRtyei3plEaroCnPSYN
         XoiwXfX3UXyPknbPNvhIN+wPkXXWjwQl3bPxc0ofqb5KmOO0odglbPG5Uef9k6UGUpsX
         tZhobva+vkNDqOUgAex5RZsHjUlQLlDPBQ9qcv1wPDh7skzmYoBmgdcqKUjJUiIl/UZH
         CX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701359445; x=1701964245;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0goqKxcMvIJg1pJ3dIpaV32YvQD1iKsLBU0J6I6POoM=;
        b=qt/sCTJlAuUqCmze19Kk8UwfGK6pGkwc0yDma7uINx9NAJmHoJm9ojkpiQbcxTZbjx
         NUsRc3J8JdUjuudT43+2Hc4GYPyoe/JZcD53ylSs6JQPuBcusuhP7u0z3jNAHUxqCEEZ
         UR94HJNgWr6ap9QyQ09+uCsAn7QMEvZvLm4Txtc+JiOB4a9/HJ7mgTJ3UVxtGCoQMT2n
         BJernmZXmEKk/sotaf4nRDT/g5uqzU8Y8DVB8rckaSSfP6MLnUZupHYmfo2Kw1I46r6F
         QTHbrVHzrezFewV5qCdKihmhNd3DS53MPNEuFatPCqmQ6tjmWAsqkZ1pEg+T5YWlkbWl
         u5JA==
X-Gm-Message-State: AOJu0YwiAVTkdT/VKE0YrwWBrqcn4963VFeNK0WB1ea5Du4rZFxtT85J
	0KhUTUWVvGpJVq31NG6YVcsxir+w05U=
X-Google-Smtp-Source: AGHT+IGdap1fY+hdiW9rf57FH+UUFxX0y4rzB1XJCsf63DYJene+At1Jk0OkGeCton6qc09H/hEz1Q==
X-Received: by 2002:a17:902:d50d:b0:1cf:c3ae:490e with SMTP id b13-20020a170902d50d00b001cfc3ae490emr15355078plg.44.1701359445505;
        Thu, 30 Nov 2023 07:50:45 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001c0cb2aa2easm1535541plg.121.2023.11.30.07.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:50:44 -0800 (PST)
Date: Thu, 30 Nov 2023 21:20:41 +0530
Message-Id: <878r6fi6jy.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use iomap
In-Reply-To: <20231130140859.hdgvf24ystz2ghdv@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Jan Kara <jack@suse.cz> writes:

> On Thu 30-11-23 16:29:59, Ritesh Harjani wrote:
>> Jan Kara <jack@suse.cz> writes:
>> 
>> > On Thu 30-11-23 13:15:58, Ritesh Harjani wrote:
>> >> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>> >> 
>> >> > Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>> >> >
>> >> >> Christoph Hellwig <hch@infradead.org> writes:
>> >> >>
>> >> >>> On Wed, Nov 22, 2023 at 01:29:46PM +0100, Jan Kara wrote:
>> >> >>>> writeback bit set. XFS plays the revalidation sequence counter games
>> >> >>>> because of this so we'd have to do something similar for ext2. Not that I'd
>> >> >>>> care as much about ext2 writeback performance but it should not be that
>> >> >>>> hard and we'll definitely need some similar solution for ext4 anyway. Can
>> >> >>>> you give that a try (as a followup "performance improvement" patch).
>> >> 
>> >> ok. So I am re-thinknig over this on why will a filesystem like ext2
>> >> would require sequence counter check. We don't have collapse range
>> >> or COW sort of operations, it is only the truncate which can race,
>> >> but that should be taken care by folio_lock. And even if the partial
>> >> truncate happens on a folio, since the logical to physical block mapping
>> >> never changes, it should not matter if the writeback wrote data to a
>> >> cached entry, right?
>> >
>> > Yes, so this is what I think I've already mentioned. As long as we map just
>> > the block at the current offset (or a block under currently locked folio),
>> > we are fine and we don't need any kind of sequence counter. But as soon as
>> > we start caching any kind of mapping in iomap_writepage_ctx we need a way
>> > to protect from races with truncate. So something like the sequence counter.
>> >
>> 
>> Why do we need to protect from the race with truncate, is my question here.
>> So, IMO, truncate will truncate the folio cache first before releasing the FS
>> blocks. Truncation of the folio cache and the writeback path are
>> protected using folio_lock()
>> Truncate will clear the dirty flag of the folio before
>> releasing the folio_lock() right, so writeback will not even proceed for
>> folios which are not marked dirty (even if we have a cached wpc entry for
>> which folio is released from folio cache).
>> 
>> Now coming to the stale cached wpc entry for which truncate is doing a
>> partial truncation. Say, truncate ended up calling
>> truncate_inode_partial_folio(). Now for such folio (it remains dirty
>> after partial truncation) (for which there is a stale cached wpc entry),
>> when writeback writes to the underlying stale block, there is no harm
>> with that right?
>> 
>> Also this will "only" happen for folio which was partially truncated.
>> So why do we need to have sequence counter for protecting against this
>> race is my question. 
>
> That's a very good question and it took me a while to formulate my "this
> sounds problematic" feeling into a particular example :) We can still have
> a race like:
>
> write_cache_pages()
>   cache extent covering 0..1MB range
>   write page at offset 0k
> 					truncate(file, 4k)
> 					  drops all relevant pages
> 					  frees fs blocks
> 					pwrite(file, 4k, 4k)
> 					  creates dirty page in the page cache
>   writes page at offset 4k to a stale block

:) Nice! 
Truncate followed by an append write could cause this race with writeback
happening in parallel. And this might cause data corruption.

Thanks again for clearly explaining the race :) 

So I think just having a seq. counter (no other locks required), should
be ok to prevent this race. Since mostly what we are interested in is
whether the stale cached block mapping got changed for the folio which
writeback is going to continue writing to.

i.e. the race only happens when 2 of these operation happen while we
have a cached block mapping for a folio - 
- a new physical block got allocated for the same logical offset to
which the previous folio belongs to 
- the folio got re-instatiated in the page cache as dirty with the new
physical block mapping at the same logical offset of the file.

Now when the writeback continues, it will iterate over the same
dirty folio in question, lock it, check for ->map_blocks which will
notice a changed seq counter and do ->get_blocks again and then
we do submit_bio() to the right physical block.

So, it should be ok, if we simply update the seq counter everytime a
block is allocated or freed for a given inode... because when we
check the seq counter, we know the folio is locked and the other
operation of re-instating a new physical block mapping for a given folio
can also only happen while under a folio lock. 

OR, one other approach to this can be... 

IIUC, for a new block mapping for the same folio, the folio can be made to
get invalidated once in between right? So should this be handled in folio
cache somehow to know if for a given folio the underlying mapping might
have changed for which iomap should again query  ->map_blocks() ? 
... can that also help against unnecessary re-validations against cached
block mappings?

Thoughts?

-ritesh


>
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

