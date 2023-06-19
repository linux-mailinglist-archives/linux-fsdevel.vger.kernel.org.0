Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2A2735C28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 18:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjFSQ0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 12:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjFSQ0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:26:01 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD8AE5C;
        Mon, 19 Jun 2023 09:26:00 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1678223a12.2;
        Mon, 19 Jun 2023 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687191960; x=1689783960;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=APXlTDLutIxBIyPIY9h/jzfqHyPKwoOlep4ipNwsgmw=;
        b=jiPtjBf0VMktGHgI9mv/6WT6MJYHu/w1cpOeZ3t0Xnlq149COEPEANz3KoAqdymb+m
         5PFSQDifKkcf5mZRCC8iypimI4wS66Lq2SddjSl9Vz9V1Z2A+J6DJ4WDJP/PhkCUIdR3
         msNT9DdyyjZquFyEx+QZ6F382gWGpHgG44oXO94VSXF/nI5mhsSRYBHzmNUBXfXu0UZZ
         b1sn/zE8Oiv8IbKmyT6v1sCC62uhlXijRZSTwLZ2qihKiJTabZckHfg8e59RsJ/Z7Z4y
         UnGAPwgE+wKjHe7+M6ckAFtDNoNR3L1boAC9SB4YkiHu2dKZ5Ll6BdncxJ+VY18atwXe
         ZbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191960; x=1689783960;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APXlTDLutIxBIyPIY9h/jzfqHyPKwoOlep4ipNwsgmw=;
        b=Yb52KSJEx8vNjSm15BZzgNdhgzIWKqu5ScF2iAPeeo4RzKiuIHk8LBL7Fujt94wpwr
         tcvSBB8SolgF55JYG8v6CuLSYwwm9gDZ2fAyQqGVpdsMmVhzksi1KBy4EBqQ9iwS+MMK
         XesxE33Xh8YcTtp83UIf/dqQWsWQ0VXlUOuwsdTyhcxDsuMFPEnJNqaxmRrdbTO0dExe
         r6yZNR5qghOr8/cFhOGCQk8YYRgDT8ftGTFgHrViwl9Q7tRrq6DhkhefRP2sJS/zwq4p
         ZEmtaErVIC2LJ5jqnfUC3Fxr5cdO7VH87MHkIXqJMZqpBVRntq6V0Ktp46EcbFoMrmYB
         Kw9g==
X-Gm-Message-State: AC+VfDyW5ixxhsArPk13hL7bZ5RFgTc8EXPPlxwu3BpiCvI3KzzCF9ml
        ma3V633o+5UmtqoV4s9u029lXT6pQ3M=
X-Google-Smtp-Source: ACHHUZ7+yHJ8xlT6qmC7u/ihoY6Iu9Gnxp5STpEKT7X3vOqdYYvyA+Een2U80LkCsOXMCQkiwjpz8w==
X-Received: by 2002:a17:90a:6c63:b0:250:acb7:21da with SMTP id x90-20020a17090a6c6300b00250acb721damr1184092pjj.38.1687191959449;
        Mon, 19 Jun 2023 09:25:59 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id g14-20020a17090a290e00b0025e9d16f95bsm62631pjd.28.2023.06.19.09.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:25:58 -0700 (PDT)
Date:   Mon, 19 Jun 2023 21:55:53 +0530
Message-Id: <87o7lbmnam.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv10 8/8] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <ZJBli4JznbJkyF0U@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Jun 19, 2023 at 07:58:51AM +0530, Ritesh Harjani (IBM) wrote:
>> +static void ifs_calc_range(struct folio *folio, size_t off, size_t len,
>> +		enum iomap_block_state state, unsigned int *first_blkp,
>> +		unsigned int *nr_blksp)
>> +{
>> +	struct inode *inode = folio->mapping->host;
>> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +	unsigned int first = off >> inode->i_blkbits;
>> +	unsigned int last = (off + len - 1) >> inode->i_blkbits;
>> +
>> +	*first_blkp = first + (state * blks_per_folio);
>> +	*nr_blksp = last - first + 1;
>> +}
>
> As I said, this is not 'first_blkp'.  It's first_bitp.  I think this
> misunderstanding is related to Andreas' complaint, but it's not quite
> the same.
>

We represent each FS block as a bit in the bitmap. So first_blkp or
first_bitp or first_blkbitp essentially means the same. 
I went with first_blk, first_blkp in the first place based on your
suggestion itself [1].

[1]: https://lore.kernel.org/linux-xfs/Y%2FvxlVUJ31PZYaRa@casper.infradead.org/

>>  static inline bool ifs_is_fully_uptodate(struct folio *folio,
>>  					       struct iomap_folio_state *ifs)
>>  {
>>  	struct inode *inode = folio->mapping->host;
>> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +	unsigned int nr_blks = (IOMAP_ST_UPTODATE + 1) * blks_per_folio;
>>  
>> -	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
>> +	return bitmap_full(ifs->state, nr_blks);
>
> I think we have a gap in our bitmap APIs.  We don't have a
> 'bitmap_range_full(src, pos, nbits)'.  We could use find_next_zero_bit(),
> but that's going to do more work than necessary.
>
> Given this lack, perhaps it's time to say that you're making all of
> this too hard by using an enum, and pretending that we can switch the
> positions of 'uptodate' and 'dirty' in the bitmap just by changing
> the enum.

Actually I never wanted to use the the enum this way. That's why I was
not fond of the idea behind using enum in all the bitmap state
manipulation APIs (test/set/).

It was only intended to be passed as a state argument to ifs_calc_range()
function to keep all the first_blkp and nr_blksp calculation at one
place. And just use it's IOMAP_ST_MAX value while allocating state bitmap.
It was never intended to be used like this.

We can even now go back to this original idea and keep the use of the
enum limited to what I just mentioned above i.e. for ifs_calc_range().

And maybe just use this in ifs_alloc()?
BUILD_BUG_ON(IOMAP_ST_UPTODATE == 0);
BUILD_BUG_ON(IOMAP_ST_DIRTY == 1);

> Define the uptodate bits to be the first ones in the bitmap,
> document it (and why), and leave it at that.

Do you think we can go with above suggestion, or do you still think we
need to drop it?

In case if we drop it, then should we open code the calculations for
first_blk, last_blk? These calculations are done in exact same fashion
at 3 places ifs_set_range_uptodate(), ifs_clear_range_dirty() and
ifs_set_range_dirty().
Thoughts?

-ritesh
