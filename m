Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E6A709C09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 18:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjESQI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 12:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjESQI4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 12:08:56 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A50FE;
        Fri, 19 May 2023 09:08:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d24136685so763468b3a.1;
        Fri, 19 May 2023 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684512534; x=1687104534;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pYuk3v0XPo2OdF3QLRiX62bwkCy75DsZ3cNVRzjLINE=;
        b=Xf4CeRaq4j8SiHTJWhjzogd6coTLnnaCOoNTi4hPPiwfyUN6Fh7dzcmKCT0x4XA/Zm
         0vhzWPQCteyoFVeJMZPQjiIFivg8UTNut9eKFA/w6KrI31/xJxbVJQllRSyc9zE/ntKH
         JXmtpxqSmJx7OJbCZyIiFMQuZwxpm8BFpqlLPFqU20rCJXIeJnu5QP7Z649ndbFBI3+2
         NSbd7qmYTJjQM8HiZVHU6SJeBJZ26xujdA7SRpOr65hghZn0dtufCjCxo8nEZPMe4ExA
         HvgsAEf/YRclJAQk5mKiTJ1fjEty4nsJg5XT1CgDBkzzVMXChs6eh5FVjOI63hlmBFq3
         jPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684512534; x=1687104534;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pYuk3v0XPo2OdF3QLRiX62bwkCy75DsZ3cNVRzjLINE=;
        b=KwD0YK4icTI3cbPDDy6OrvPEARhZVDcU7fsU7auFjNw55UoSwRQ3/ekCyb8DwN6ouX
         loiA3RbTAgrPHrzV748cC97KHAths7NwjYL0HQlV2aKt1jRit7Ta6DH4O415NXTige+c
         qgz35cgGzgGibuS32kFXIbODnW3emjmXADsoGhtLgiJogL4wbNQR0QolJW7Jfl4MCtrW
         9Ma9xbmrUTOLPXI9ZLBkm6lh5RF6MqR+lur+B/CJDc3grNMQQGEKFm0uBhAl7nQ5AZlu
         GYfVRl+yFjvKN2shwURqgx7G+kUMH37BmU/odbOgPAHXKLOJwRS0huzmYUNPeWejqr8h
         vQkA==
X-Gm-Message-State: AC+VfDzMb1r7SoRboyodA5PEf5NDljyl8JwnR6xyIRgvAr2pzqet+iu5
        L0iicAt/UBxfmsM0jsf4f5JpH6rXIIY=
X-Google-Smtp-Source: ACHHUZ5C66YkR4r5DMPzujxtfrBiPYDJL4qtgHx8NcI/f+UmEWwdbvUDxeu/ZqrxXztYVPxKrv+lZQ==
X-Received: by 2002:a05:6a21:6d98:b0:102:c96b:f147 with SMTP id wl24-20020a056a216d9800b00102c96bf147mr3483454pzb.17.1684512534500;
        Fri, 19 May 2023 09:08:54 -0700 (PDT)
Received: from rh-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id i9-20020aa78b49000000b00643aa9436c9sm2889469pfd.172.2023.05.19.09.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 09:08:53 -0700 (PDT)
Date:   Fri, 19 May 2023 21:38:46 +0530
Message-Id: <87353swbg1.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <ZGYnzcoGuzWKa7lh@infradead.org>
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

> On Mon, May 08, 2023 at 12:58:00AM +0530, Ritesh Harjani (IBM) wrote:
>> +static inline void iop_clear_range(struct iomap_page *iop,
>> +				   unsigned int start_blk, unsigned int nr_blks)
>> +{
>> +	bitmap_clear(iop->state, start_blk, nr_blks);
>> +}
>
> Similar to the other trivial bitmap wrappers added earlier in the
> series I don't think this one is very useful.
>
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +	unsigned int first_blk = (off >> inode->i_blkbits);
>> +	unsigned int last_blk = ((off + len - 1) >> inode->i_blkbits);
>> +	unsigned int nr_blks = last_blk - first_blk + 1;
>> +	unsigned long flags;
>> +
>> +	if (!iop)
>> +		return;
>> +	spin_lock_irqsave(&iop->state_lock, flags);
>> +	iop_set_range(iop, first_blk + blks_per_folio, nr_blks);
>> +	spin_unlock_irqrestore(&iop->state_lock, flags);
>
> All the variable initializations except for ios should really move
> into a branch here.

Branch won't be needed I guess, will just move the initialization after
the return.

> Or we just use separate helpers for the case
> where we actually have an iops and isolate all that, which would
> be my preference (but goes counter to the direction of changes
> earlier in the series to the existing functions).
>
>> +static void iop_clear_range_dirty(struct folio *folio, size_t off, size_t len)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +	struct inode *inode = folio->mapping->host;
>> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +	unsigned int first_blk = (off >> inode->i_blkbits);
>> +	unsigned int last_blk = ((off + len - 1) >> inode->i_blkbits);
>> +	unsigned int nr_blks = last_blk - first_blk + 1;
>> +	unsigned long flags;
>> +
>> +	if (!iop)
>> +		return;
>> +	spin_lock_irqsave(&iop->state_lock, flags);
>> +	iop_clear_range(iop, first_blk + blks_per_folio, nr_blks);
>> +	spin_unlock_irqrestore(&iop->state_lock, flags);
>> +}
>
> Same here.

Sure.

-ritesh
