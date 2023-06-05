Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CED7231B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 22:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjFEUs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 16:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjFEUs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:48:28 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7047692;
        Mon,  5 Jun 2023 13:48:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5289ce6be53so4621237a12.0;
        Mon, 05 Jun 2023 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685998107; x=1688590107;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F7euxcNCuST71EOpyrQmdn5AC8OKdt31Zo+Y7pZ6fLI=;
        b=qY5Z5JcPdPbP6agRdZnELXIu3QlZ5wqn9vIG/zAotdAQzz0K4mgOvJYuZFl7tYNx5x
         LCYxMFMWecdL1bKNwXO79kvwsN04RNuvVUbJ8hmci4efx1RBujDL7aynfkdU5Z7QsVlz
         e4AnOzP5NtXRNOam6okEDxeK3rC7sgT2atrSlrwOydFl2Vhp8/EkaHMhuULdbYykiEMF
         SSzoQp4x38KDrBB/sGaN2v9qQAhbwdEusrHPfv0weuLxirH8egv5zUWyPYKVA4axpbbC
         PJ8Rn4q7CvutGHsqtoT7d3zArPTl8Ql99m6JaPEUvHegnOAZ/vr4+Zn8adtL5awr8++l
         CeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685998107; x=1688590107;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7euxcNCuST71EOpyrQmdn5AC8OKdt31Zo+Y7pZ6fLI=;
        b=eexku4Rs3nfThFyFh+omCDCxu9av+GaRiRH1Os8sMUStKapry0uB1v4oondo72T1FG
         AuzudppkY2fYmooYeeleQxwYq6awvEWFTDgUkk+M5DwNp4zExuv40pZNHHVc4yl6bF4a
         zx08nkIjNWhtYaLRjPffDYBc08MRnIGj1RZhvne22eFwMDHQbbtAZM5ay1PqI3J0L0Xu
         6I9JVBb6/93yacZYAfaIdFyxjwv7VHwjdjQ/JO3sBhAaQkzfgP/8HOA2bgFkjYGbz0sX
         E1ThkrwB6kac0i+s0K/15t4HYwfQm8ITS/5ryF8mrKstXBolYfH5o3gI2pp1T78sg30G
         CN9Q==
X-Gm-Message-State: AC+VfDzJ9w5xFnnP1QP69gJXB4zbp/nvY+NBzc5qoUJyIQ/KbF/TGF54
        M4ZoviO8CgLZKtDobjR3cvTftFm9N8I=
X-Google-Smtp-Source: ACHHUZ5UAz4HJ8bUJQfsxdqE0vrsZSzuq085XYJxEl0PKF9tfvgjtzn5bq4AnzysTgLe70Q2ljzo1Q==
X-Received: by 2002:a17:903:2289:b0:1b1:1168:656b with SMTP id b9-20020a170903228900b001b11168656bmr129718plh.26.1685998106751;
        Mon, 05 Jun 2023 13:48:26 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001ac94b33ab1sm6940728pli.304.2023.06.05.13.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 13:48:26 -0700 (PDT)
Date:   Tue, 06 Jun 2023 02:18:05 +0530
Message-Id: <87sfb5k54q.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv7 3/6] iomap: Refactor some iop related accessor functions
In-Reply-To: <ZH3xt3npT9jeBFMG@casper.infradead.org>
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

> On Mon, Jun 05, 2023 at 04:15:31PM +0200, Andreas Gruenbacher wrote:
>> Note that to_iomap_page() does folio_test_private() followed by
>> folio_get_private(), which doesn't really make sense in places where
>> we know that iop is defined. Maybe we want to split that up.
>
> The plan is to retire the folio private flag entirely.  I just haven't
> got round to cleaning up iomap yet.  For folios which we know to be
> file-backed, we can just test whether folio->private is NULL or not.
>
> So I'd do this as:
>
> -	struct iomap_page *iop = to_iomap_page(folio);
> +	struct iomap_page *iop = folio->private;
>
> and not even use folio_get_private() or to_iomap_page() any more.
>

In that case, shouldn't we just modify to_iomap_page(folio) function
to just return folio_get_private(folio) or folio->private ?

>> > +       unsigned int first_blk = off >> inode->i_blkbits;
>> > +       unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
>> > +       unsigned int nr_blks = last_blk - first_blk + 1;
>> > +       unsigned long flags;
>> > +
>> > +       spin_lock_irqsave(&iop->state_lock, flags);
>> > +       bitmap_set(iop->state, first_blk, nr_blks);
>> > +       if (iop_test_full_uptodate(folio))
>> > +               folio_mark_uptodate(folio);
>> > +       spin_unlock_irqrestore(&iop->state_lock, flags);
>> > +}
>> > +
>> > +static void iomap_iop_set_range_uptodate(struct inode *inode,
>> > +               struct folio *folio, size_t off, size_t len)
>> > +{
>> > +       struct iomap_page *iop = to_iomap_page(folio);
>> > +
>> > +       if (iop)
>> > +               iop_set_range_uptodate(inode, folio, off, len);
>> > +       else
>> > +               folio_mark_uptodate(folio);
>> > +}
>>
>> This patch passes the inode into iomap_iop_set_range_uptodate() and
>> removes the iop argument. Can this be done in a separate patch,
>> please?
>>
>> We have a few places like the above, where we look up the iop without
>> using it. Would a function like folio_has_iop() make more sense?
>
> I think this is all a symptom of the unnecessary splitting of
> iomap_iop_set_range_uptodate and iop_set_range_uptodate.

Thanks for the review. The problem in not splitting this would be a lot
of variable initialization for !iop case as well.
Hence in one of the previous versions it was discussed that splitting it
into a helper routine for iop case would be a better approach.

-ritesh
