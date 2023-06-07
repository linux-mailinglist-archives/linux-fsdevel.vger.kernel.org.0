Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6B7264C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 17:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbjFGPh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 11:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjFGPh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:37:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507F8FC;
        Wed,  7 Jun 2023 08:37:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2563a4b6285so3549229a91.2;
        Wed, 07 Jun 2023 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686152246; x=1688744246;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEs7KJ8SvZuv+NhuLmUlilQ7jAx4saueD4RgWAAKXFw=;
        b=dYl37FUIYVZh1uhjjp9u77boKJhVIsDIQPs4Xo8Efs6ZuCjbUNeomey8FGgE7XBckN
         Fp4kP7POVzPrH6hqWIZukI4oiIRWVLUUIqpmDRQ6eLwkycYTSY66slGdw26994t7MRAX
         TLNCVG67mqQP6b+icnH1xyHUHoCijH6M7xvdEqialQK6rTZOjFclScjX3GZQEoFyevEM
         RC1Kl3w97Fw9cqIXADNvE3tX6Y4Nh0nL+sCfD1SCMgABEa7jN3mvPR5opYh/jNKzalEi
         f12cJM7gkOZcLkNoDfDd4Y6bu82SJRrDhRjNvRjxqweQMPZdKe3qOq8Z0oJp6UvwdnJg
         F5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152246; x=1688744246;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEs7KJ8SvZuv+NhuLmUlilQ7jAx4saueD4RgWAAKXFw=;
        b=fm/Innzuxm30pzIzcCRnE9rpC/7dkpeM4f56QFCad1Tl+1KNNaLcxP2PCpK5wW9EY4
         8FKi6+xnxZ046/AzOQQElk9Zw/K7BaNP2mcGtyJACojrl7ybbMpt0C0q44vXHvweucXx
         BBdikr5r35YLgrljwucWswePKteH68y0gRc/MeXmhbMxuFHl8BA/HGd2N4wfm4X3gCBg
         l7MwDz6eJj5+Qk17eVaC6V+8fsmMTM1+ZdlLZ7KzUMw8/KmptnNxC0l4EwDEZKhpWE2S
         6t57WGCACmOeVpTibU0TNyVADKS8//kMiWLoKBQ4QeIzpkCmZWKi/yslQZ8KeTcHXepa
         ZlDw==
X-Gm-Message-State: AC+VfDxGLtTqcwerWNi5D8Gh/aA/cUcwQ4bxMZmVUjAtfj29V/QV6bOs
        T7s5Fg+P6zATxjxhTBZ2FnY=
X-Google-Smtp-Source: ACHHUZ42Vde0pzHPQzUCF0PTCr2zT0iS3fJv097kXkFF9HzLENtzqJbUrPbaJkqLEJK04xoTnNhVvg==
X-Received: by 2002:a17:90a:31a:b0:255:63e0:1248 with SMTP id 26-20020a17090a031a00b0025563e01248mr3439864pje.0.1686152245615;
        Wed, 07 Jun 2023 08:37:25 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090aa90200b002565cd237cdsm3244216pjq.3.2023.06.07.08.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:37:25 -0700 (PDT)
Date:   Wed, 07 Jun 2023 21:07:19 +0530
Message-Id: <87o7lri8r4.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv8 5/5] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <ZIAsEkURZHRAcxtP@infradead.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        MALFORMED_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>> +static inline bool iomap_iof_is_block_dirty(struct folio *folio,
>> +			struct iomap_folio *iof, int block)
>
> Two tabs indents here please and for various other functions.
>

Sure. 

>> +{
>> +	struct inode *inode = folio->mapping->host;
>> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +	unsigned int first_blk = off >> inode->i_blkbits;
>> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
>> +	unsigned int nr_blks = last_blk - first_blk + 1;
>
> Given how many places we we opencode this logic I wonder if a helper
> would be usefuļ, even if the calling conventions are a bit odd.

I agree that moving it to a common helper would come useful as it is
open coded at 3 places.

>
> To make this nicer it would also be good an take a neat trick from
> the btrfs subpage support and use an enum for the bits, e.g.:
>
> enum iomap_block_state {
> 	IOMAP_ST_UPTODATE,
> 	IOMAP_ST_DIRTY,
>
> 	IOMAP_ST_MAX,
> };
>

I think the only remaining piece is the naming of this enum and struct
iomap_page.

Ok, so here is what I think my preference would be -

This enum perfectly qualifies for "iomap_block_state" as it holds the
state of per-block.
Then the struct iomap_page (iop) should be renamed to struct
"iomap_folio_state" (ifs), because that holds the state information of all the
blocks within a folio.

Is this something which sounds ok to others too? 

>
> static void iomap_ibs_calc_range(struct folio *folio, size_t off, size_t len,
> 		enum iomap_block_state state, unsigned int *first_blk,
> 		unsigned int *nr_blks)
> {
> 	struct inode *inode = folio->mapping->host;
> 	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> 	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
>
> 	*first_blk = state * blks_per_folio + (off >> inode->i_blkbits);
> 	*nr_blks = last_blk - first_blk + 1;
> }
>

Sure, like the idea of the state enum. Will make the changes.

>> +	/*
>> +	 * iof->state tracks two sets of state flags when the
>> +	 * filesystem block size is smaller than the folio size.
>> +	 * The first state tracks per-block uptodate and the
>> +	 * second tracks per-block dirty state.
>> +	 */
>> +	iof = kzalloc(struct_size(iof, state, BITS_TO_LONGS(2 * nr_blocks)),
>>  		      gfp);
>
> with the above this can use IOMAP_ST_MAX and make the whole thing a
> little more robus.
>

yes.

>>
>>  	if (iof) {
>
> No that this adds a lot more initialization I'd do a
>
> 	if (!iof)
> 		return NULL;
>
> here and unindent the rest.

Sure. Is it ok to fold this change in the same patch, right?
Or does it qualify for a seperate patch?

-ritesh
