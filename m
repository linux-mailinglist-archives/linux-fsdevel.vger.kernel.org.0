Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0CA730095
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245243AbjFNNuj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 09:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245268AbjFNNu0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:50:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F7C2116;
        Wed, 14 Jun 2023 06:50:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 732882188F;
        Wed, 14 Jun 2023 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686750616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9V/45eMabXhdU3ckOTW7r4gN0IDt7PkTYtZbqmL44k=;
        b=rM+JpluVe+Jr5/j6YYpyU/tVWR/032uTsXQmf0akGKqtBrnqiv9J2ECp2dp2GKBapSJiXs
        QGq8CdA6TdZb3np0SgEl3xUSJE8P3IAl7b5W/2sMk1YyzpH+Wz3z2p3wTwSGLQOwdVZAmd
        zgfwwotfrMbVoYFAIGR6JRBsQKJky7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686750616;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9V/45eMabXhdU3ckOTW7r4gN0IDt7PkTYtZbqmL44k=;
        b=GkxWrTsFLuSl8ecpM41owT4NXQNz3dJex//nhOgFxl6AD5O6J64r/oYvOmqg9aD9ojvowo
        Aweo7KXZa1tq22Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6101E1357F;
        Wed, 14 Jun 2023 13:50:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0/wZF5jFiWRuaAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 14 Jun 2023 13:50:16 +0000
Message-ID: <6c6bb81e-04cd-f813-c06c-59a706685d63@suse.de>
Date:   Wed, 14 Jun 2023 15:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/7] brd: convert to folios
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-3-hare@suse.de> <ZInEeq1lfDUxye58@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZInEeq1lfDUxye58@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/14/23 15:45, Matthew Wilcox wrote:
> On Wed, Jun 14, 2023 at 01:46:32PM +0200, Hannes Reinecke wrote:
>>   /*
>> - * Each block ramdisk device has a xarray brd_pages of pages that stores
>> - * the pages containing the block device's contents. A brd page's ->index is
>> - * its offset in PAGE_SIZE units. This is similar to, but in no way connected
>> - * with, the kernel's pagecache or buffer cache (which sit above our block
>> - * device).
>> + * Each block ramdisk device has a xarray of folios that stores the folios
>> + * containing the block device's contents. A brd folio's ->index is its offset
>> + * in PAGE_SIZE units. This is similar to, but in no way connected with,
>> + * the kernel's pagecache or buffer cache (which sit above our block device).
> 
> Having read my way to the end of the series, I can now circle back and
> say this comment is wrong.  The folio->index is its offset in PAGE_SIZE
> units if the sector size is <= PAGE_SIZE, otherwise it's the offset in
> sector size units.  This is _different from_ the pagecache which uses
> PAGE_SIZE units and multi-index entries in the XArray.
> 
Hmm. I am aware that brd is using the ->index field in a different way,
but I thought I got it straigtened out ...

>> @@ -144,29 +143,29 @@ static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
>>   static void copy_to_brd(struct brd_device *brd, const void *src,
>>   			sector_t sector, size_t n)
>>   {
>> -	struct page *page;
>> +	struct folio *folio;
>>   	void *dst;
>>   	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
>>   	size_t copy;
>>   
>>   	copy = min_t(size_t, n, PAGE_SIZE - offset);
>> -	page = brd_lookup_page(brd, sector);
>> -	BUG_ON(!page);
>> +	folio = brd_lookup_folio(brd, sector);
>> +	BUG_ON(!folio);
>>   
>> -	dst = kmap_atomic(page);
>> -	memcpy(dst + offset, src, copy);
>> -	kunmap_atomic(dst);
>> +	dst = kmap_local_folio(folio, offset);
>> +	memcpy(dst, src, copy);
>> +	kunmap_local(dst);
> 
> This should use memcpy_to_folio(), which doesn't exist yet.
> Compile-tested patch incoming shortly ...
> 
Ah. You live and learn.

>> +	folio = brd_lookup_folio(brd, sector);
>> +	if (folio) {
>> +		src = kmap_local_folio(folio, offset);
>> +		memcpy(dst, src, copy);
>> +		kunmap_local(src);
> 
> And this will need memcpy_from_folio(), patch for that incoming too.
> 
>> @@ -226,15 +225,15 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
>>   			goto out;
>>   	}
>>   
>> -	mem = kmap_atomic(page);
>> +	mem = kmap_local_folio(folio, off);
>>   	if (!op_is_write(opf)) {
>> -		copy_from_brd(mem + off, brd, sector, len);
>> -		flush_dcache_page(page);
>> +		copy_from_brd(mem, brd, sector, len);
>> +		flush_dcache_folio(folio);
> 
> Nngh.  This will need to be a more complex loop.  I don't think we can
> do a simple abstraction here.  Perhaps you can base it on the two
> patches you're about to see?
> 
Sure.
Might explain the strange crashes I've seen ...

Cheers,

Hannes

