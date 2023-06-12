Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FAF72BBF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 11:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjFLJWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 05:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjFLJV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:21:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6157949EB;
        Mon, 12 Jun 2023 02:14:21 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6532671ccc7so4483108b3a.2;
        Mon, 12 Jun 2023 02:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686561261; x=1689153261;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cl0RgNXc2hMbIwtjX8is3/r9y8iSXaDUKq93XNPycsU=;
        b=mtzX4wTJJxrefw2RdG1JQsAyodnTQHLh68E64C53QNlrFmwZyVhtc4TBs//PVC0+jZ
         Z6fM3QHtzVqgVnxwaOf0IKBsjogery1trfwlXSOEqWx14vxQqvg4aQ9X8+eL8VudroPj
         ujWbU4MFOZXzA233MIaVeVBeq1AtQ40uTvuHuh0yZJE4LCry7gzat7diSSk3D4CeB/H1
         WbYjPOd1ViNenqFf1cCgxPOFGyxpnzcmBSS9QuhcLKfQJT8LPVxj3MLxoMAWflz9wT+V
         8ISq5Y/eIja/QWg3my+MTzK1DgyhmM2zdNDtW0dEoy5P236Fzyb9/Ljx6h7XK8xdzBwm
         omgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561261; x=1689153261;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cl0RgNXc2hMbIwtjX8is3/r9y8iSXaDUKq93XNPycsU=;
        b=Z7oDn6nmfzUJBQgqdtBRvVIgsT3sZFk1czQQrCXbfkytYIo/G3GSbr3vDv6a8+ce3n
         2chSniCB6rzJz08SIPxMnRpKxg2XJWpYzXKgFATWZUcQ1UYjFR/RKbgFOBif3n45XAEw
         OreKSx6pztuvrQJ1UjppWnxLrout936oJ07MsnpncWvOSvtwtizyAu0GZ8cxuZYSX9t8
         qHSs17N5Jr/QiGRFX4CO8rhCKkrNZNSrkMGMoTH08lWlHUt6R6OOpDcfjoAM4HeEdMDh
         wy49xVMDUBk+hoBpOjkv1GNx6zbsCZxftDaffszl/RmeB4jzvQ8cSMl9stkP9iqbnkD4
         rP9Q==
X-Gm-Message-State: AC+VfDylmcMISL23lhgB8AJIXJf8JKxNxa1rw9OPv9wJu+aKC+QfduRE
        NUjZ13DyLPCArSLiN/05HeFmdWD4z74=
X-Google-Smtp-Source: ACHHUZ7XaZgS+GA8AqjGhSpF+GB24Z739dG9acDOLjDXdlNtqjxj0H+EkTgoPMZKo1trjd4GnbbJrQ==
X-Received: by 2002:a05:6a00:b46:b0:64b:f03b:2642 with SMTP id p6-20020a056a000b4600b0064bf03b2642mr13140735pfo.23.1686561260872;
        Mon, 12 Jun 2023 02:14:20 -0700 (PDT)
Received: from dw-tp ([129.41.58.23])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b0062e0515f020sm6435910pfo.162.2023.06.12.02.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:14:20 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:44:15 +0530
Message-Id: <87zg55ghzs.fsf@doe.com>
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
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers for ifs state bitmap
In-Reply-To: <ZIa6WLknzuxoDDT8@infradead.org>
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

> On Sat, Jun 10, 2023 at 05:09:04PM +0530, Ritesh Harjani (IBM) wrote:
>> This patch adds two of the helper routines iomap_ifs_is_fully_uptodate()
>> and iomap_ifs_is_block_uptodate() for managing uptodate state of
>> ifs state bitmap.
>>
>> In later patches ifs state bitmap array will also handle dirty state of all
>> blocks of a folio. Hence this patch adds some helper routines for handling
>> uptodate state of the ifs state bitmap.
>>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++--------
>>  1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index e237f2b786bc..206808f6e818 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -43,6 +43,20 @@ static inline struct iomap_folio_state *iomap_get_ifs(struct folio *folio)
>>
>>  static struct bio_set iomap_ioend_bioset;
>>
>> +static inline bool iomap_ifs_is_fully_uptodate(struct folio *folio,
>> +					       struct iomap_folio_state *ifs)
>> +{
>> +	struct inode *inode = folio->mapping->host;
>> +
>> +	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
>> +}
>> +
>> +static inline bool iomap_ifs_is_block_uptodate(struct iomap_folio_state *ifs,
>> +					       unsigned int block)
>> +{
>> +	return test_bit(block, ifs->state);
>> +}

static inline bool iomap_ifs_is_block_dirty(struct folio *folio,
		struct iomap_folio_state *ifs, int block)
{
	struct inode *inode = folio->mapping->host;
	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);

	return test_bit(block + blks_per_folio, ifs->state);
}

>
> A little nitpicky, but do the _ifs_ name compenents here really add
> value?
>

Maybe if you look at both of above functions together to see the value?

> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!
