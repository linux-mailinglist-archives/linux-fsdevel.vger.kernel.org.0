Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E9172CA1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbjFLPbG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 11:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbjFLPat (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:30:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D3DE7A;
        Mon, 12 Jun 2023 08:30:34 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b3be6c0b4cso9417065ad.3;
        Mon, 12 Jun 2023 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686583834; x=1689175834;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TpBZk0NXfqyM/eC1QcotC76PM/BIZEmiezeZryyR9lM=;
        b=Cxm7eOvMtkymMxywy/ckbNIy7MUnQ14ZSWF4OFfBZ7bZEqYmKQ0+4/169O8iX/eqjF
         El57r+TGbY31yaIwFQavRx30WGt+gPU2ZGAhpghU9F/CzRZF+djMPq0Xsy0wmW3WTO5M
         KSvMpBEHe5hTQyEktKVTer4tVjfc7Xg4D6ZRRO8AOsSRyHiFqQyBGM8SVRQH7jyy8rzG
         RJzUo3c2z9vWd7GbHAtJ9/wN4aVtt+XdaCTsL6GDwTbXAaCO3PWxN0YpSZj97Q3TJpVq
         gVk2XY5Xrx6m1UJo+UfZvL21N/jvzO0r8B4y3iwP6nE/H7aLVGXi3hZxNduqRP9FWuCj
         K4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583834; x=1689175834;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpBZk0NXfqyM/eC1QcotC76PM/BIZEmiezeZryyR9lM=;
        b=c12xFiM1RGIq7ORrR502zoV0DEGHIme+PeBI+dk1b/DqJAcwJ6KBWDI+N6ICBR0yG+
         ErogyWNnxrIVhJQeiF1JkShmF24TzFYZbThFVm+bXkq4ybFj2SYy+tolNHXlGqV9yuIY
         bT3nPuWtFZkNysrqtJ0y9RFp0nXp81d0Vaf6LIyVrXI8HIwVKr2jk2e1jdHt1lEAsrE9
         KQq9vFpelRqPCpma0pPlvQxP1CzZ8YF+K8ixehUX6qIMD1Jbp2kmgL6W+EyK8esuteBD
         TNU+ahm43S+iYMq0JGuturn3LoQpIT4iE2UtjB5MRtEtOcGQgilRsbCqw1h3bNqUftYB
         f+Ow==
X-Gm-Message-State: AC+VfDzAxifH0EuWVB/YVBaqArEFPtAH94k1cpsJjmNQLaiTmiOuetTG
        z9Rs2i+wzXjI/E9VvvZh8bA=
X-Google-Smtp-Source: ACHHUZ4Gh5wFrG4doBK/deZiKGPy8M5AYeFd3YVyyM0yw37rgKR/46+BKwKWJKbItakoe6+zTQbYhg==
X-Received: by 2002:a17:902:ce8a:b0:1aa:e938:3ddf with SMTP id f10-20020a170902ce8a00b001aae9383ddfmr7960205plg.7.1686583834101;
        Mon, 12 Jun 2023 08:30:34 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id ft4-20020a17090b0f8400b0025c0cd8a91bsm74787pjb.9.2023.06.12.08.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:30:33 -0700 (PDT)
Date:   Mon, 12 Jun 2023 21:00:29 +0530
Message-Id: <87ilbshf56.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers for ifs state bitmap
In-Reply-To: <CAHc6FU7Hv71ujeb9oEVOD+bpddMMT0KY+KKUp881Am15u-OVvg@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andreas Gruenbacher <agruenba@redhat.com> writes:

> On Sat, Jun 10, 2023 at 1:39 PM Ritesh Harjani (IBM)
> <ritesh.list@gmail.com> wrote:
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
>> +                                              struct iomap_folio_state *ifs)
>> +{
>> +       struct inode *inode = folio->mapping->host;
>> +
>> +       return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
>
> This should be written as something like:
>
> unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> return bitmap_full(ifs->state + IOMAP_ST_UPTODATE * blks_per_folio,
> blks_per_folio);
>

Nah, I feel it is not required... It make sense when we have the same
function getting use for both "uptodate" and "dirty" state.
Here the function anyways operates on uptodate state.
Hence I feel it is not required.

>> +}
>> +
>> +static inline bool iomap_ifs_is_block_uptodate(struct iomap_folio_state *ifs,
>> +                                              unsigned int block)
>> +{
>> +       return test_bit(block, ifs->state);
>
> This function should be called iomap_ifs_block_is_uptodate(), and
> probably be written as follows, passing in the folio as well (this
> will optimize out, anyway):
>
> struct inode *inode = folio->mapping->host;
> unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> return test_bit(block, ifs->state + IOMAP_ST_UPTODATE * blks_per_folio);
>

Same here.

-ritesh
