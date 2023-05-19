Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D981E709ADA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 17:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjESPHN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 11:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjESPHM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 11:07:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C13121;
        Fri, 19 May 2023 08:07:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51b33c72686so2305185a12.1;
        Fri, 19 May 2023 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684508829; x=1687100829;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p3jaXn6ewxRaNtoINF6pbHhzTFNpw3kEuQPfPQZhLeM=;
        b=bcrCDeMSbsVJ3ZrGNRH0ddoyqIai267IEFQGZekk5oOgHeJbgXGf3c6ZadPb9/EaDf
         SGedNj96MqqPy9qV78u8v1xKAMT+VB9edzUzMbjQRO5jMTzl0bb55a/ljlkwGy1Sdw56
         q4KVANnlgDbga4BZicozKXbPnesXdmZHkQzlcMGKu48thiBaNAESpDz2DaOkPFfEvx51
         Nk0PkMXBnFaOS0lp7l+u0O9Lvgl9lJt2JcLNenApUDdJm9uZKP7WalBtQ1f/6Bv8DCw6
         plq5gvO8xCfs6O0I4aqE+XIdXfk1yDjfp235QYk4317DSFqmTPioTmhbFc8tSqlUeARB
         0sSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684508829; x=1687100829;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3jaXn6ewxRaNtoINF6pbHhzTFNpw3kEuQPfPQZhLeM=;
        b=Ixp0kNkob5Cs3QOjnwxIZRLGWnzhm5ySMjKGulfJTB3TDqeqFDiAvj9Liv59b+6PXr
         qY7KFrZDAvi6sutTxJ4STd32TRGmPfIMOC+aO7US7WfcQeJOUSgCKusCuZSw8Dl6rIL0
         /va+uhsSynGV5qTk1S/VSQN4/yTND/wRKeCT6Zg4toM0b92PcWiKCg/a2+/natPpXApH
         idieAeEfPsLQOooUjJw0U64yRRc2CSlSFTuhghLIpdZdE0x+goGIxC0KptyGnCWcqCDI
         VA4fsRpQcFYjEflAnomaX7lDhOhHtMLEqH+9p68pCFFH0mtZuX+Z0RaBlzhFWeRUkE6r
         NL7w==
X-Gm-Message-State: AC+VfDyhKvIX2JqLW1s7qdtGsKxz9gzRvgxN4azGGw6b84eodmUE0bZ4
        oGME7u11N0zkKfrDSolhJw3yPaXx9fU=
X-Google-Smtp-Source: ACHHUZ76BpTSO8SBnq6xik7Pocx9t+ZTKFrvUL7VuBBM/Am/Y0a3ED62wW/N3YCP5hZK3F2WZJm08Q==
X-Received: by 2002:a17:90b:1d90:b0:253:78c0:b129 with SMTP id pf16-20020a17090b1d9000b0025378c0b129mr2448427pjb.18.1684508829207;
        Fri, 19 May 2023 08:07:09 -0700 (PDT)
Received: from rh-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id e24-20020a17090ab39800b0024c1ac09394sm1618411pjr.19.2023.05.19.08.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:07:08 -0700 (PDT)
Date:   Fri, 19 May 2023 20:37:01 +0530
Message-Id: <878rdkweay.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 3/5] iomap: Add iop's uptodate state handling functions
In-Reply-To: <ZGXDQ4RGslszaIIk@infradead.org>
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

>> + * inline helpers for bitmap operations on iop->state
>> + */
>> +static inline void iop_set_range(struct iomap_page *iop, unsigned int start_blk,
>> +				 unsigned int nr_blks)
>> +{
>> +	bitmap_set(iop->state, start_blk, nr_blks);
>> +}
>> +
>> +static inline bool iop_test_block(struct iomap_page *iop, unsigned int block)
>> +{
>> +	return test_bit(block, iop->state);
>> +}
>> +
>> +static inline bool iop_bitmap_full(struct iomap_page *iop,
>> +				   unsigned int blks_per_folio)
>> +{
>> +	return bitmap_full(iop->state, blks_per_folio);
>> +}
>
> I don't really see much poin in these helpers, any particular reason
> for adding them?
>

We ended up modifying the APIs in v5. The idea on v4 was we will keep
iop_set_range() function which will be same for both uptodate and dirty.
The caller can pass start_blk depending upon whether we dirty/uptodate
needs to be marked.
But I guess with the API changes, we don't need this low level helpers
anymore. So If no one has any objection, I can kill this one liners.

>> +/*
>> + * iop related helpers for checking uptodate/dirty state of per-block
>> + * or range of blocks within a folio
>> + */
>
> I'm also not sure this comment adds a whole lot of value.
>
> The rest looks good modulo the WARN_ONs already mentined by Brian.

Sure. Thanks for the review!

-ritesh
