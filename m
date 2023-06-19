Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D002735D07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 19:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjFSR3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 13:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjFSR3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:29:16 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17A197;
        Mon, 19 Jun 2023 10:29:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b539d2f969so19874345ad.0;
        Mon, 19 Jun 2023 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687195755; x=1689787755;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tMnCy7i+HFpbqsqO/5BP7uvkP1/TZW9hG0+jOwlF2Kk=;
        b=J3fV9v06jeBvyHjLkcXP0ZQWudSqeJBqPYKzwMxJTUjwtoYS+gSMH9B1XmYSYq1Azm
         o8MuZTbRMQqGzQ5eDiAu22EIGLGTQsZWWPUKnmfI597aEaQP/INzM8A6QlMrL3eCLuPF
         b+F5TEJZlLmAWlqBHe0dhDFoQ9ohbvEgp+oMIrouEwM9qnRzBH2yzfqR7chzkk1czQ8C
         UFdLxM1XLo40xQxvuSbY21zVpd3gBx7q+0IidbxEK4UtTlQ5npLjoNFCYUVenvBQmUb2
         ugTHeVJGGV8P7G7ouM5FtzeMbmfuXOifWJCl50XO2yqysY34wyYGSil0thLLnhrTdKYK
         +JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687195755; x=1689787755;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMnCy7i+HFpbqsqO/5BP7uvkP1/TZW9hG0+jOwlF2Kk=;
        b=YjtOlNNmT0wVtYljvuCdTEmU8+zo9A4CGNA8RIYFSyuGA19rdONunClU/fs6DcQwOF
         x4iB+PbzTaWF1VBzSFqXFxy9txquBn38ucfz+SjAChT+ghpoxwTLeSJVNbLcbJBW2CWF
         W4Q69rJ26MIjjOiuDc5Yd/hqRdSiQRIZP2bZHrp6D6Ctcf1jnUe38rr1eiI3YvJ3KEoC
         biUTvN3sY4boTqvuf/59crU+gUKL0iIWlz/vwQ2xqD8j4Er21GaoqjF1N1j/YPcHenTi
         Rt0LqvjIHniMBbEZAiyPFE32oWJgZi1l/EGweBLc3xkfVqlFt5OGbhS4qNLCxeNULo3Z
         +n1g==
X-Gm-Message-State: AC+VfDzqlgu6yJnTyRhpdzs/QBImYPV0as6o2l7Mx9xC6haYKhLRMXYE
        9GuRkj+jsOB2YLiIdqxjZVg=
X-Google-Smtp-Source: ACHHUZ6mNyqdlQXsc0O7xjSAmAMVAmcm+QChFQO5eo3ihtwVrHvuGGnUgzWhRVKAjGoDxl6N+vT4XQ==
X-Received: by 2002:a17:902:e892:b0:1b2:3e9f:69d1 with SMTP id w18-20020a170902e89200b001b23e9f69d1mr22073012plg.18.1687195754851;
        Mon, 19 Jun 2023 10:29:14 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id kg14-20020a170903060e00b001b67a2896bdsm83234plb.274.2023.06.19.10.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 10:29:14 -0700 (PDT)
Date:   Mon, 19 Jun 2023 22:59:09 +0530
Message-Id: <87ilbjmkd6.fsf@doe.com>
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
In-Reply-To: <ZJCINLpHGifRHewa@casper.infradead.org>
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

> On Mon, Jun 19, 2023 at 09:55:53PM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> > On Mon, Jun 19, 2023 at 07:58:51AM +0530, Ritesh Harjani (IBM) wrote:
>> >> +static void ifs_calc_range(struct folio *folio, size_t off, size_t len,
>> >> +		enum iomap_block_state state, unsigned int *first_blkp,
>> >> +		unsigned int *nr_blksp)
>> >> +{
>> >> +	struct inode *inode = folio->mapping->host;
>> >> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> >> +	unsigned int first = off >> inode->i_blkbits;
>> >> +	unsigned int last = (off + len - 1) >> inode->i_blkbits;
>> >> +
>> >> +	*first_blkp = first + (state * blks_per_folio);
>> >> +	*nr_blksp = last - first + 1;
>> >> +}
>> >
>> > As I said, this is not 'first_blkp'.  It's first_bitp.  I think this
>> > misunderstanding is related to Andreas' complaint, but it's not quite
>> > the same.
>> >
>> 
>> We represent each FS block as a bit in the bitmap. So first_blkp or
>> first_bitp or first_blkbitp essentially means the same. 
>> I went with first_blk, first_blkp in the first place based on your
>> suggestion itself [1].
>
> No, it's not the same!  If you have 1kB blocks in a 64kB page, they're
> numbered 0-63.  If you 'calc_range' for any of the dirty bits, you get
> back a number in the range 64-127.  That's not a block number!  It's
> the number of the bit you want to refer to.  Calling it blkp is going
> to lead to confusion -- as you yourself seem to be confused.
>
>> [1]: https://lore.kernel.org/linux-xfs/Y%2FvxlVUJ31PZYaRa@casper.infradead.org/
>
> Those _were_ block numbers!  off >> inode->i_blkbits calculates a block
> number.  (off >> inode->i_blkbits) + blocks_per_folio() does not calculate
> a block number, it calculates a bit number.
>

Yes, I don't mind changing it to _bit. It is derived out of an FS block
representation only. But I agree with your above argument using _bit in
variable name makes it explicit and clear.

>> >> -	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
>> >> +	return bitmap_full(ifs->state, nr_blks);
>> >
>> > I think we have a gap in our bitmap APIs.  We don't have a
>> > 'bitmap_range_full(src, pos, nbits)'.  We could use find_next_zero_bit(),
>> > but that's going to do more work than necessary.
>> >
>> > Given this lack, perhaps it's time to say that you're making all of
>> > this too hard by using an enum, and pretending that we can switch the
>> > positions of 'uptodate' and 'dirty' in the bitmap just by changing
>> > the enum.
>> 
>> Actually I never wanted to use the the enum this way. That's why I was
>> not fond of the idea behind using enum in all the bitmap state
>> manipulation APIs (test/set/).
>> 
>> It was only intended to be passed as a state argument to ifs_calc_range()
>> function to keep all the first_blkp and nr_blksp calculation at one
>> place. And just use it's IOMAP_ST_MAX value while allocating state bitmap.
>> It was never intended to be used like this.
>> 
>> We can even now go back to this original idea and keep the use of the
>> enum limited to what I just mentioned above i.e. for ifs_calc_range().
>> 
>> And maybe just use this in ifs_alloc()?
>> BUILD_BUG_ON(IOMAP_ST_UPTODATE == 0);
>> BUILD_BUG_ON(IOMAP_ST_DIRTY == 1);
>> 
>> > Define the uptodate bits to be the first ones in the bitmap,
>> > document it (and why), and leave it at that.
>> 
>> Do you think we can go with above suggestion, or do you still think we
>> need to drop it?
>> 
>> In case if we drop it, then should we open code the calculations for
>> first_blk, last_blk? These calculations are done in exact same fashion
>> at 3 places ifs_set_range_uptodate(), ifs_clear_range_dirty() and
>> ifs_set_range_dirty().
>> Thoughts?
>
> I disliked the enum from the moment I saw it, but didn't care enough to
> say so.
>
> Look, an abstraction should have a _purpose_.  The enum doesn't.  I'd
> ditch this calc_range function entirely; it's just not worth it.

I guess enum is creating more confusion with almost everyone than adding value.
So I don't mind ditching it (unless anyone else opposes for keeping it).

Also it would be helpful if you could let me know of any other review
comments on the rest of the patch? Does the rest looks good to you?

-ritesh
