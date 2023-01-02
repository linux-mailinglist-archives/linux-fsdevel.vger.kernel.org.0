Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4190165B1D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jan 2023 13:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjABMNb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 07:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjABMN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:13:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322E63C6;
        Mon,  2 Jan 2023 04:13:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6097A340C4;
        Mon,  2 Jan 2023 12:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672661606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLH69wvDgw4zlrii5ssfaa8PJzW+0Xgf+S3GjAQjclc=;
        b=O3X5uNr30fACrbTuGy88BO/nRLzdSVEm2bxn/xKiI+MpkbqJN5mRMd7HJ8HvLHcTYgjnul
        T1kABhab6ZerssRLV+082h0drbFI0NxPisaG4yhBbgoUD7mZ3K5JF5IzFQSqBa4eM7UCjy
        zsC5iKSZreJNKK8xkH3kwsC2ep5D8lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672661606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLH69wvDgw4zlrii5ssfaa8PJzW+0Xgf+S3GjAQjclc=;
        b=aB8cuOBt2GCeTl1/MOPlOVFJIPokVJ83QnUy+vrqechFA1EvlGXkDRJFBrSsx+awFiQdU7
        tAP9c4Iwzy8UA7BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EF21139C8;
        Mon,  2 Jan 2023 12:13:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 12o6E2bKsmOoCQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 12:13:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D6987A073E; Mon,  2 Jan 2023 13:13:25 +0100 (CET)
Date:   Mon, 2 Jan 2023 13:13:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/6] fs: remove an outdated comment on mpage_writepages
Message-ID: <20230102121325.swmgrnjgvvnxz2fh@quack3>
References: <20221229161031.391878-1-hch@lst.de>
 <20221229161031.391878-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229161031.391878-2-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-12-22 06:10:26, Christoph Hellwig wrote:
> mpage_writepages doesn't do any of the page locking itself, so remove
> and outdated comment on the locking pattern there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/mpage.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 0f8ae954a57903..910cfe8a60d2e4 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -641,14 +641,6 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
>   *
>   * This is a library function, which implements the writepages()
>   * address_space_operation.
> - *
> - * If a page is already under I/O, generic_writepages() skips it, even
> - * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
> - * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
> - * and msync() need to guarantee that all the data which was dirty at the time
> - * the call was made get new I/O started against them.  If wbc->sync_mode is
> - * WB_SYNC_ALL then we were called for data integrity and we must wait for
> - * existing IO to complete.
>   */
>  int
>  mpage_writepages(struct address_space *mapping,
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
