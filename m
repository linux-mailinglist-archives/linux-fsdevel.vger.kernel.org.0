Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C1A72C6D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 16:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjFLODg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 10:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjFLODf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:03:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9682EE65;
        Mon, 12 Jun 2023 07:03:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-655d1fc8ad8so3572314b3a.1;
        Mon, 12 Jun 2023 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686578614; x=1689170614;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E34Qnj2BYRMuX9RqWZqo8l/XR/cFX7aCEouA7uavgY8=;
        b=SwBEIzdK8NM4DDykaPpDVbQ9spO6KiLourBes9u7j+fvZuVVKW9WgNXx5FVbCTPj+c
         a8aCMDLAcqvO1V2R9b8WPLsE0EfbcQjRrDhdtmDOuy0n7GdYPqcNzRSEjUadIIvlaykp
         5E6K3KpiAxGeXYUnftW3II9q/qffvvwmghKIyreNiOHj5dZ8mfSl1ypDdVbtdURleOh7
         yiKZg/OCDHHipMA/r2N+u3kKibF6GrYb616A/Qd9ekPbF0V97QJpTkQxe/Xl48KlZNtU
         OUw8+oJJlnlddVmWcssxXR45hScRBknZg/MA/UbanVBSY2S8vNye8OAuQBnUk8WkXggQ
         Q+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686578614; x=1689170614;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E34Qnj2BYRMuX9RqWZqo8l/XR/cFX7aCEouA7uavgY8=;
        b=ZFtdFAl4GQ213HGMDbUsXRt1dZSSpZvh6xni1eRxSFOtlRaIdyj5JpMyei8HVtx6ku
         s8SFgEKiqAuEBCy13KpAPeh1+M3sUkFEcZXkQZJ7AqY0MPib93l/V8VmCSt5y41F052s
         v2hqCqJXKc8BLHOWnbcFDrF3ttYdmzK3B9ePq/0rZOOD6Cyasvw3W6ysZoQFNBET7tLB
         a9gmEYIuOT2xtEoGe5jEEGCS1RAtf7QdDiKNobKmcknVQ7tMosPZJk24ew+ljNgl4Bop
         17LfLgbT+nZX0hawcjp5GImgITFoFlHEo6CLCfFFInhWbTAtOL6lNVek/b14erxLZRpJ
         kgYg==
X-Gm-Message-State: AC+VfDyX3T4i4LaEaLfGG848AoPRnjB3InaugaqKw1BoR7LiR8u4rE4Y
        pp49BexHjEiI5xwk2Lk4FVI=
X-Google-Smtp-Source: ACHHUZ769VhHojGTiT9XMHuUwWhbDDYmwYriLIglmsQysTxDDfUpGWUbv1RlHLSntJoHmXXE23cD9w==
X-Received: by 2002:a05:6a00:180e:b0:659:ae1c:c9e2 with SMTP id y14-20020a056a00180e00b00659ae1cc9e2mr11576585pfa.17.1686578613774;
        Mon, 12 Jun 2023 07:03:33 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78690000000b006505bae11bcsm6976010pfo.23.2023.06.12.07.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:03:33 -0700 (PDT)
Date:   Mon, 12 Jun 2023 19:33:29 +0530
Message-Id: <87ttvchj66.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 4/6] iomap: Refactor iomap_write_delalloc_punch() function out
In-Reply-To: <ZIccDjZQdAMXcnJQ@casper.infradead.org>
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

> On Sat, Jun 10, 2023 at 05:09:05PM +0530, Ritesh Harjani (IBM) wrote:
>> +static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>> +		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
>> +		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
>
> I can't help but feel that a
>
> typedef iomap_punch_t(struct inode *, loff_t offset, loff_t length);
>
> would make all of this easier to read.
>

Sure. Make sense.

>> +	/*
>> +	 * Make sure the next punch start is correctly bound to
>> +	 * the end of this data range, not the end of the folio.
>> +	 */
>> +	*punch_start_byte = min_t(loff_t, end_byte,
>> +				  folio_next_index(folio) << PAGE_SHIFT);
>
> 	*punch_start_byte = min(end_byte, folio_pos(folio) + folio_size(folio));

Current code was also correct only. But I guess this just avoids
min_t/loff_t thing. No other reason right?

-ritesh
