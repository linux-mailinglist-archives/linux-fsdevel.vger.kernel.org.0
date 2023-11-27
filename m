Return-Path: <linux-fsdevel+bounces-3904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EE17F9A75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 08:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC8A280C98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334E4DF53;
	Mon, 27 Nov 2023 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk1kOr3O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623E285;
	Sun, 26 Nov 2023 23:02:44 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so2391910a12.0;
        Sun, 26 Nov 2023 23:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701068563; x=1701673363; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xt6ff0BteCwmLGhRcA4Ev0siZyxpQtZ/YLHieZDGHgk=;
        b=Hk1kOr3ObzbcMEX7sdsldEPgWYTvr37bh/JFd3cMVSVV0XP/ZzbaBFZQdpXIWCrwHG
         ZWVFB4CQcuW9OaV0LBVXJjCMNHX8M19mMUIKh8lhuuByrRXtbeAinBPlN0YHy8Vbfvw0
         db5/ihBaaHz6nM8YwhbNHve4rB8feiMJwQhayeSVsPCd/HiT9PV6Laa9QJHJ8CHao0NT
         h6xN/yojmLl7Ye31awwyPRaWmxpWD6cehfp3iFr/3bKXkqsFOVXri0kAPTmVoHxfAumv
         veykiGe7OIktE6QC/JHUEDAEj+3KMTVth0EUEl3ppnOxCP/FoFPn6omMk3oz1lKjYCzH
         oZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068563; x=1701673363;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xt6ff0BteCwmLGhRcA4Ev0siZyxpQtZ/YLHieZDGHgk=;
        b=k+6dHY+s4+gO7wk+CMwO0bAssYkKw4a/3jbZv8M0GHQ3Q73VkvscleajJuvAf0R4wt
         bRT7wmuVLbOlx+9gY942+arwxIafLs3zSysSdLacYGBhzWhD/DQ/SII98x+R0m6esJYY
         LclyWWxU9uBeHSKxtqJf3ekhrapNx0GTI5GLOiTUKtxV/tjx9k++ER9gHNygvQ0cDr3y
         silEa75GtkjEaL+brZj/1paY5WuK2F7CDB2GCweexDg7yV0fKnFiHpUUnvgbfYHXTuPW
         Kxl3wKuo8IQXJzwW9GWm+T/nTyN/hD8K8CJkin1L/J6kYfLjhZpyLOVlonTTrbell3FU
         Ev/A==
X-Gm-Message-State: AOJu0YwPnwhbN22lzUtBpAerUh5+4Ra9GiSZc15FahtHMIzavBwU1Na2
	17VCKNXbIBEDFY9qWSa4KTM663tCMV8=
X-Google-Smtp-Source: AGHT+IEyySjK8LO0AHbGmtnnGAzB6SGhGabmpGa1u31LXYrGK0yd8uDuQIXbUBy2VedHU7BPGSc5WQ==
X-Received: by 2002:a17:90b:388d:b0:285:da91:69d9 with SMTP id mu13-20020a17090b388d00b00285da9169d9mr978889pjb.9.1701068562766;
        Sun, 26 Nov 2023 23:02:42 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 102-20020a17090a09ef00b002800e0b4852sm7833551pjo.22.2023.11.26.23.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 23:02:42 -0800 (PST)
Date: Mon, 27 Nov 2023 12:32:38 +0530
Message-Id: <87zfyzr84x.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/13] iomap: factor out a iomap_writepage_handle_eof helper
In-Reply-To: <8734wrsmy5.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Christoph Hellwig <hch@lst.de> writes:
>
>> Most of iomap_do_writepage is dedidcated to handling a folio crossing or
>> beyond i_size.  Split this is into a separate helper and update the
>> commens to deal with folios instead of pages and make them more readable.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  fs/iomap/buffered-io.c | 128 ++++++++++++++++++++---------------------
>>  1 file changed, 62 insertions(+), 66 deletions(-)
>
> Just a small nit below.
>
> But otherwise looks good to me. Please feel free to add - 
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 8148e4c9765dac..4a5a21809b0182 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -1768,6 +1768,64 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
>>  	wbc_account_cgroup_owner(wbc, &folio->page, len);
>>  }
>>  
>> +/*
>> + * Check interaction of the folio with the file end.
>> + *
>> + * If the folio is entirely beyond i_size, return false.  If it straddles
>> + * i_size, adjust end_pos and zero all data beyond i_size.
>> + */
>> +static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
>> +		u64 *end_pos)
>> +{
>> +	u64 isize = i_size_read(inode);
>
> i_size_read(inode) returns loff_t type. Can we make end_pos also as
> loff_t type. We anyway use loff_t for
> folio_pos(folio) + folio_size(folio), at many places in fs/iomap. It
> would be more consistent with the data type then.
>
> Thoughts?

aah, that might also require to change the types in
iomap_writepage_map(). So I guess the data type consistency change
should be a follow up change as this patch does only the refactoring.

>
> -ritesh
>
>
>> +
>> +	if (*end_pos > isize) {
>> +		size_t poff = offset_in_folio(folio, isize);
>> +		pgoff_t end_index = isize >> PAGE_SHIFT;
>> +
>> +		/*
>> +		 * If the folio is entirely ouside of i_size, skip it.
>> +		 *
>> +		 * This can happen due to a truncate operation that is in
>> +		 * progress and in that case truncate will finish it off once
>> +		 * we've dropped the folio lock.
>> +		 *
>> +		 * Note that the pgoff_t used for end_index is an unsigned long.
>> +		 * If the given offset is greater than 16TB on a 32-bit system,
>> +		 * then if we checked if the folio is fully outside i_size with
>> +		 * "if (folio->index >= end_index + 1)", "end_index + 1" would
>> +		 * overflow and evaluate to 0.  Hence this folio would be
>> +		 * redirtied and written out repeatedly, which would result in
>> +		 * an infinite loop; the user program performing this operation
>> +		 * would hang.  Instead, we can detect this situation by
>> +		 * checking if the folio is totally beyond i_size or if its
>> +		 * offset is just equal to the EOF.
>> +		 */
>> +		if (folio->index > end_index ||
>> +		    (folio->index == end_index && poff == 0))
>> +			return false;
>> +
>> +		/*
>> +		 * The folio straddles i_size.
>> +		 *
>> +		 * It must be zeroed out on each and every writepage invocation
>> +		 * because it may be mmapped:
>> +		 *
>> +		 *    A file is mapped in multiples of the page size.  For a
>> +		 *    file that is not a multiple of the page size, the
>> +		 *    remaining memory is zeroed when mapped, and writes to that
>> +		 *    region are not written out to the file.
>> +		 *
>> +		 * Also adjust the writeback range to skip all blocks entirely
>> +		 * beyond i_size.
>> +		 */
>> +		folio_zero_segment(folio, poff, folio_size(folio));
>> +		*end_pos = isize;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  /*
>>   * We implement an immediate ioend submission policy here to avoid needing to
>>   * chain multiple ioends and hence nest mempool allocations which can violate
>> @@ -1906,78 +1964,16 @@ static int iomap_do_writepage(struct folio *folio,
>>  {
>>  	struct iomap_writepage_ctx *wpc = data;
>>  	struct inode *inode = folio->mapping->host;
>> -	u64 end_pos, isize;
>> +	u64 end_pos = folio_pos(folio) + folio_size(folio);
>>  
>>  	trace_iomap_writepage(inode, folio_pos(folio), folio_size(folio));
>>  
>> -	/*
>> -	 * Is this folio beyond the end of the file?
>> -	 *
>> -	 * The folio index is less than the end_index, adjust the end_pos
>> -	 * to the highest offset that this folio should represent.
>> -	 * -----------------------------------------------------
>> -	 * |			file mapping	       | <EOF> |
>> -	 * -----------------------------------------------------
>> -	 * | Page ... | Page N-2 | Page N-1 |  Page N  |       |
>> -	 * ^--------------------------------^----------|--------
>> -	 * |     desired writeback range    |      see else    |
>> -	 * ---------------------------------^------------------|
>> -	 */
>> -	isize = i_size_read(inode);
>> -	end_pos = folio_pos(folio) + folio_size(folio);
>> -	if (end_pos > isize) {
>> -		/*
>> -		 * Check whether the page to write out is beyond or straddles
>> -		 * i_size or not.
>> -		 * -------------------------------------------------------
>> -		 * |		file mapping		        | <EOF>  |
>> -		 * -------------------------------------------------------
>> -		 * | Page ... | Page N-2 | Page N-1 |  Page N   | Beyond |
>> -		 * ^--------------------------------^-----------|---------
>> -		 * |				    |      Straddles     |
>> -		 * ---------------------------------^-----------|--------|
>> -		 */
>> -		size_t poff = offset_in_folio(folio, isize);
>> -		pgoff_t end_index = isize >> PAGE_SHIFT;
>> -
>> -		/*
>> -		 * Skip the page if it's fully outside i_size, e.g.
>> -		 * due to a truncate operation that's in progress.  We've
>> -		 * cleaned this page and truncate will finish things off for
>> -		 * us.
>> -		 *
>> -		 * Note that the end_index is unsigned long.  If the given
>> -		 * offset is greater than 16TB on a 32-bit system then if we
>> -		 * checked if the page is fully outside i_size with
>> -		 * "if (page->index >= end_index + 1)", "end_index + 1" would
>> -		 * overflow and evaluate to 0.  Hence this page would be
>> -		 * redirtied and written out repeatedly, which would result in
>> -		 * an infinite loop; the user program performing this operation
>> -		 * would hang.  Instead, we can detect this situation by
>> -		 * checking if the page is totally beyond i_size or if its
>> -		 * offset is just equal to the EOF.
>> -		 */
>> -		if (folio->index > end_index ||
>> -		    (folio->index == end_index && poff == 0))
>> -			goto unlock;
>> -
>> -		/*
>> -		 * The page straddles i_size.  It must be zeroed out on each
>> -		 * and every writepage invocation because it may be mmapped.
>> -		 * "A file is mapped in multiples of the page size.  For a file
>> -		 * that is not a multiple of the page size, the remaining
>> -		 * memory is zeroed when mapped, and writes to that region are
>> -		 * not written out to the file."
>> -		 */
>> -		folio_zero_segment(folio, poff, folio_size(folio));
>> -		end_pos = isize;
>> +	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
>> +		folio_unlock(folio);
>> +		return 0;
>>  	}
>>  
>>  	return iomap_writepage_map(wpc, wbc, inode, folio, end_pos);
>> -
>> -unlock:
>> -	folio_unlock(folio);
>> -	return 0;
>>  }
>>  
>>  int
>> -- 
>> 2.39.2

