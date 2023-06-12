Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1D372BB9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjFLJE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 05:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjFLJD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:03:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C924686;
        Mon, 12 Jun 2023 02:00:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b3cc77ccbfso4626595ad.1;
        Mon, 12 Jun 2023 02:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686560412; x=1689152412;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vwAnSv3gRombx0EqlbwbUh+TEz0wTaqk905f3XF/Ynw=;
        b=KMSWjXpALt2LN4sAGcDkMRqaZGoCpMNbfqH7y54A1LAZBIPxTVwc3bY9a94K7zNnoP
         gkszhUjq1OlDEol5P0DWbgf1qAyqnywoDDsMFt9Wm3lMHObbERvHLwRr8gzd5Ks/54sF
         6vY8NuJp3QoY+9Ww/Oy2QKRUQLz/OSoD81xSeDfSvFm1Wnca43KD6CswXDmdLm152wwW
         l1Sjh+/FZUktcMRH9EIcW6/Z5elXur8IhARbPHC16u1pKRuCtn1QVO5lE1m3Q+KAsdmH
         9GiGY+L7dORJyEdILwWg/QbP1mMO5j/Uzlf0crXe1jp4sscegxjJm/h++zkOdD9Sk1wR
         irYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686560412; x=1689152412;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwAnSv3gRombx0EqlbwbUh+TEz0wTaqk905f3XF/Ynw=;
        b=O9BPG+vLN6qlB22wKZCCgZEqWquLkQf2vmvuk0BhIDaUF4zDumbRhXlxWj8c1gbV9V
         nhev6r6P404NcgZwrlVdu0WAftfbHMv1N51CeI6xStX2UkheaJm78ITlKp+cSro8GWdN
         Ju65N0N73GVdMo6NEq/gEvgItV53KJxXf5Sv9kb7NWWXfC6QH0SPrfpnTKg1eEDDaF53
         AdU1bV5bnr6DC8pN11nDI84WI/nmL8cimGd7WR0+yJo8UGV2ViJwHfqEsWNJe2OwYbW5
         wdpGvkkbr6+JuVzAfg6pBsuYv7wPpzDoOmKt/qGqF0y7SWBVJC0lavFFYDchTjy6U8ga
         w2wQ==
X-Gm-Message-State: AC+VfDxaRdIoQZCZjw9VDl8Rh30dKYSKZp44a+RXN45oIRq2hrU2q5k6
        IlRLLFsuv2Lnd5QCUhpRRMk=
X-Google-Smtp-Source: ACHHUZ6foTcIrsFUqabvqs8ScvaYRDBKOHkybKdnGzWPKCmDHl2U7fJnFS0RQdqNByi7FOgQ9vlMhw==
X-Received: by 2002:a17:902:cec5:b0:1aa:ef83:34be with SMTP id d5-20020a170902cec500b001aaef8334bemr6354597plg.47.1686560411666;
        Mon, 12 Jun 2023 02:00:11 -0700 (PDT)
Received: from dw-tp ([129.41.58.23])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902968600b001ae469ca0c0sm7702232plp.245.2023.06.12.02.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:00:11 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:30:05 +0530
Message-Id: <875y7thx7u.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv9 6/6] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <ZIa7dFb42FkI5jgp@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> Just some nitpicks,

Sure.

> this otherwise looks fine.

Thanks for the review.

>
> First during the last patches ifs as a variable name has started
> to really annoy me and I'm not sure why.  I'd like to hear from the
> others, bu maybe just state might be a better name that flows easier?
>

Ok. Let's hear from others too.

>> +static void iomap_clear_range_dirty(struct folio *folio, size_t off, size_t len)
>> +{
>> +	struct iomap_folio_state *ifs = iomap_get_ifs(folio);
>> +
>> +	if (!ifs)
>> +		return;
>> +	iomap_ifs_clear_range_dirty(folio, ifs, off, len);
>
> Maybe just do
>
> 	if (ifs)
> 		iomap_ifs_clear_range_dirty(folio, ifs, off, len);
>
> ?

Sure.

>
> But also do we even need the ifs argument to iomap_ifs_clear_range_dirty
> after we've removed it everywhere else earlier?
>

Some of the previous discussions / reasoning behind it -

- In one of the previous discussions we discussed that functions which
has _ifs_ in their naming, then it generally should imply that we will
be working on iomap_folio_state struct. So we should pass that as a
argument.

- Also in most of these *_ifs_* functions we have "ifs" as a non-null
  function argument.

- At some places where we are calling these _ifs_ functions, we
already have derived ifs, so why not just pass it.

FYI - We dropped "ifs" argument in one of the function which is
iomap_set_range_uptodate(), because we would like this function
to work in both cases.
    1. When we have non-null folio->private (ifs)
    2. When it is null.

So API wise it looks good in my humble opinion. But sure, in
case if someone has better ideas, I can look into that.

>> +	/*
>> +	 * When we have per-block dirty tracking, there can be
>> +	 * blocks within a folio which are marked uptodate
>> +	 * but not dirty. In that case it is necessary to punch
>> +	 * out such blocks to avoid leaking any delalloc blocks.
>> +	 */
>> +	ifs = iomap_get_ifs(folio);
>> +	if (!ifs)
>> +		goto skip_ifs_punch;
>> +
>> +	last_byte = min_t(loff_t, end_byte - 1,
>> +		(folio_next_index(folio) << PAGE_SHIFT) - 1);
>> +	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
>> +	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
>> +	for (i = first_blk; i <= last_blk; i++) {
>> +		if (!iomap_ifs_is_block_dirty(folio, ifs, i)) {
>> +			ret = punch(inode, folio_pos(folio) + (i << blkbits),
>> +				    1 << blkbits);
>> +			if (ret)
>> +				goto out;
>> +		}
>> +	}
>> +
>> +skip_ifs_punch:
>
> And happy to hear from the others, but to me having a helper for
> all the iomap_folio_state manipulation rather than having it in
> the middle of the function and jumped over if not needed would
> improve the code structure.

I think Darrick was also pointing towards having a separate funciton.
But let's hear from him & others too. I can consider adding a separate
function for above.

Does this look good?

static int iomap_write_delalloc_ifs_punch(struct inode *inode, struct folio *folio,
		struct iomap_folio_state *ifs, loff_t start_byte, loff_t end_byte,
		int (*punch)(struct inode *inode, loff_t offset, loff_t length))

The function argument are kept similar to what we have for
iomap_write_delalloc_punch(), except maybe *punch_start_byte (which is
not required).

-ritesh
