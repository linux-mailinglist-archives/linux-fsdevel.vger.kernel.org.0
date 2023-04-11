Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F186DDF7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 17:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDKPWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDKPWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:22:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8355261;
        Tue, 11 Apr 2023 08:21:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j8so6729705pjy.4;
        Tue, 11 Apr 2023 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681226490; x=1683818490;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7lhq/v+qbsPhCdc8vPT1tzfkDyW/FEXRjLecDKzEEgU=;
        b=GS17BeUpbmnej+XE4Fe6hg2h73OLk7WefDVYhpoIfFoAh7Lzl+FvhPf5or2SrdeVWp
         DJ3EPczcKzSP9TNtU/TDHcybfek5yPeh/lUBa0lHLTvk13P/fbtw5HIgAkB21RHeMJ9j
         Ewg2bMF1+LFjDhFdM5WFzJBazw7m09IaSZV1apKO6Y33zaZgxOm5sBa37n0Ywf2VPtXi
         7MmERL/QE01gmcgu1fmfpLZGuahdN+btdS6f1mgKMr7dfvSWI7hjvwhI3IFiGFzp50eA
         V67z5WB2tFEfeMaUVhHv7HDA8n5UBd8Qnj9TQ9Wnv3MNkSqTdoRggTjxG1u+/WUpGox5
         WvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681226490; x=1683818490;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lhq/v+qbsPhCdc8vPT1tzfkDyW/FEXRjLecDKzEEgU=;
        b=PivfDScD1LdmghxwltMRoelmSCefNlBiCzn1LToaGVWdF5nCCVsPkKdlcLie8Lb0Sg
         2Xgp5LsBPSg1nCNy3bLdB+7PQQEJWLa+karUACDWpZmYadc6uSzdmNlRSPSPrntYburl
         qifsjunIvkJGL57t1sjKUTsgeMSOpwIU8fdTUbvQZRYeEsf11Xe3F7qClFh2Jn5j22pP
         z2PCdjmNLCaUIpjE8j6iVcygPZsl/iYx6qdAcBViZFFrb3Tsh7w6IddSMz8HegryXjtZ
         6+N6nlJAjCiBrX/ud7Xmd1HXl7mwzBatYglwu+8ju5OS9+rcaVPLk9zcrLF1fzUwnu+G
         /2CA==
X-Gm-Message-State: AAQBX9crePuxPsZkvQ2c5wwdZWFXiSjyZn8XYMmPRbMQcbryg23qUzQt
        q/CEK7UqodKzFHCS/t+fzp+M9luJT0o=
X-Google-Smtp-Source: AKy350bpQbuo7Je/C80QZyADu/vZZK3hcRBcmHIOYoqaKCSCeKTZv1XQuv/La3HFGs9Z6axN0Lqflw==
X-Received: by 2002:a17:902:d511:b0:1a1:b172:5428 with SMTP id b17-20020a170902d51100b001a1b1725428mr21686310plg.18.1681226490464;
        Tue, 11 Apr 2023 08:21:30 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001a0742b0806sm9852218pls.108.2023.04.11.08.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 08:21:30 -0700 (PDT)
Date:   Tue, 11 Apr 2023 20:51:24 +0530
Message-Id: <87wn2izbpn.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 5/8] ext2: Move direct-io to use iomap
In-Reply-To: <ZDT0JFmwg/9ijdcv@infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Apr 11, 2023 at 10:51:53AM +0530, Ritesh Harjani (IBM) wrote:
>> +extern void ext2_write_failed(struct address_space *mapping, loff_t to);
>
> No need for the extern.
>

Sure will drop it.

>> +	/* handle case for partial write and for fallback to buffered write */
>> +	if (ret >= 0 && iov_iter_count(from)) {
>> +		loff_t pos, endbyte;
>> +		ssize_t status;
>> +		int ret2;
>> +
>> +		iocb->ki_flags &= ~IOCB_DIRECT;
>> +		pos = iocb->ki_pos;
>> +		status = generic_perform_write(iocb, from);
>> +		if (unlikely(status < 0)) {
>> +			ret = status;
>> +			goto out_unlock;
>> +		}
>> +
>> +		iocb->ki_pos += status;
>> +		ret += status;
>> +		endbyte = pos + status - 1;
>> +		ret2 = filemap_write_and_wait_range(inode->i_mapping, pos,
>> +						    endbyte);
>> +		if (!ret2)
>> +			invalidate_mapping_pages(inode->i_mapping,
>> +						 pos >> PAGE_SHIFT,
>> +						 endbyte >> PAGE_SHIFT);
>> +		if (ret > 0)
>> +			generic_write_sync(iocb, ret);
>> +	}
>
> Nit, but to me it would seem cleaner if all the fallback handling
> was moved into a separate helper function.  Or in fact by not
> using generic_file_write_iter even for buffered I/O and at doing
> the pre-I/O checks and the final generic_write_sync in common code in
> ext2 for direct and buffered I/O.
>

Make sense. However, since we are on the path to modify ext2 buffered-io
code as well to move to iomap interface, I wouldn't bother too much as
of now for this code as, all of this is going to go away anyways.


>> +	/*
>> +	 * For writes that could fill holes inside i_size on a
>> +	 * DIO_SKIP_HOLES filesystem we forbid block creations: only
>> +	 * overwrites are permitted.
>> +	 */
>> +	if ((flags & IOMAP_DIRECT) && (first_block << blkbits < i_size_read(inode)))
>> +		create = 0;
>
> No need for braes around the < operation, but I think you might need
> them around the shift.

left-shift has a higher precedence. But let me make it more clear in
next rev.

>
> Also an overly long line here.
>

Sure, will see to it.

>> +	if ((flags & IOMAP_WRITE) && (offset + length > i_size_read(inode)))
>
> No need for the second set of inner braces here either.

It's just avoids any confusion this way.

-ritesh
