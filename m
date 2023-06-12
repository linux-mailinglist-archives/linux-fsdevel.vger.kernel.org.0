Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD572CE1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 20:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjFLS12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 14:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbjFLS0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:26:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4667A1728;
        Mon, 12 Jun 2023 11:26:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25bd72d7093so976865a91.2;
        Mon, 12 Jun 2023 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686594365; x=1689186365;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kfYH9RceL/YbIBZiRmWXRMihbJmShvxINYsA2kiYv7E=;
        b=jaGS+nDEC+12cRbCuBVDfE/BpQ7+H13/qw5vmr6OwqF5RoI0Xu4hEbGOAdSL8di20J
         VG+QSkH+kqN8XbBhI6rWFv2L/nRJfvt+Z80vt7PVCwOp1xIAeD7UHqwW1hxjg+p5bhsm
         1AHwDpcZsP/N7FAiAFswZ+0Xexa1KHu8kL02eUgEw5wKJEjGwp0sFwkh/5RW29OxpElu
         NuzzUVcpr/qbLnmhj7SfMJBtHRooG08LjvZFeOiuP5xl5VQ2i/FfAcstA8D58eUjPk5P
         WAuzFIE+qLi/JCm4arvhVKEQofuYvmZulElhblv1lbpsQmflnbRfPNTKpwNsGlst+S5X
         gQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594365; x=1689186365;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfYH9RceL/YbIBZiRmWXRMihbJmShvxINYsA2kiYv7E=;
        b=T8SkQSAs67yKHstqJw975ipTojNSvNUav7XxFPk0lpmuAQVg6h4DANyD10nPJUy9Id
         HhJ525ThVuB7A8h2C4pBiUZdg1dJ/7InFQtG9TPckNacPnG91SbgWj+kHcUOon9wmlWJ
         j0vM60UI2CadG9QXO0OlomR+e5xchawF+N+cezA3PEtuPmyd/5/SUe8xenuCK2McYmr4
         4ELyaDP8TjPz8GXjLKm5Ca93bV2cuFCJ8IuP/P4PMspCFV/jusmrkYIp/6r0u6fIgbfr
         iRDcGUGGEIiksBT4zvpJHNuLtynAW4TwCIYK/zUL2JT1UQg+n5wUzwZZ9Q5rkGilwEQQ
         0hnQ==
X-Gm-Message-State: AC+VfDxlxnroh7a/MjZIh5zIUIEaGSAT2sc/sd8gSlTO7daM7ZII/23u
        02NbxMpRyjbeRs4vDJggfFw=
X-Google-Smtp-Source: ACHHUZ744HpdGbuy42mRuVc4RIPkZLgG+RVgq9JPAaiAcCao96FpxL8aFJxUijSlwlKyB5kz6lHmWg==
X-Received: by 2002:a17:90a:4e:b0:25b:ea10:e865 with SMTP id 14-20020a17090a004e00b0025bea10e865mr2572803pjb.19.1686594365498;
        Mon, 12 Jun 2023 11:26:05 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a1a0b00b0025bfda134ccsm1092383pjk.16.2023.06.12.11.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:26:04 -0700 (PDT)
Date:   Mon, 12 Jun 2023 23:55:55 +0530
Message-Id: <87352w7d1o.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv2 2/5] ext4: Remove PAGE_SIZE assumption of folio from mpage_submit_folio
In-Reply-To: <ZIdZKSLidg1o89qX@casper.infradead.org>
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

> On Mon, Jun 12, 2023 at 10:55:37PM +0530, Ritesh Harjani wrote:
>> It is easily recreatable if we have one thread doing buffered-io +
>> sync and other thread trying to truncate down inode->i_size.
>> Kernel panic maybe is happening only with -O encrypt mkfs option +
>> -o test_dummy_encryption mount option, but the size - folio_pos(folio)
>> is definitely wrong because inode->i_size is not protected in writeback path.
>
> Did you not see the email I sent right before you sent your previous
> email?

Aah yes, Matthew. I had seen that email yesterday after I sent my email.
Sorry I forgot to acknowdledge it today and thanks for pointing things
out.

I couldn't respond to your change because I still had some confusion
around this suggestion - 

> So do we care if we write a random fragment of a page after a truncate?
> If so, we should add:
> 
>         if (folio_pos(folio) >= size)
>                 return 0; /* Do we need to account nr_to_write? */

I was not sure whether if go with above case then whether it will
work with collapse_range. I initially thought that collapse_range will
truncate the pages between start and end of the file and then
it can also reduce the inode->i_size. That means writeback can find an
inode->i_size smaller than folio_pos(folio) which it is writing to.
But in this case we can't skip the write in writeback case like above
because that write is still required (a spurious write) even though
i_size is reduced as it's corresponding FS blocks are not truncated.

But just now looking at ext4_collapse_range() code it doesn't look like
it is the problem because it waits for any dirty data to be written
before truncate. So no matter which folio_pos(folio) the writeback is
writing, there should not be an issue if we simply return 0 like how
you suggested above.

    static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)

    <...>
        ioffset = round_down(offset, PAGE_SIZE);
        /*
        * Write tail of the last page before removed range since it will get
        * removed from the page cache below.
        */

        ret = filemap_write_and_wait_range(mapping, ioffset, offset);
        if (ret)
            goto out_mmap;
        /*
        * Write data that will be shifted to preserve them when discarding
        * page cache below. We are also protected from pages becoming dirty
        * by i_rwsem and invalidate_lock.
        */
        ret = filemap_write_and_wait_range(mapping, offset + len,
                        LLONG_MAX);
        truncate_pagecache(inode, ioffset);

        <... within i_data_sem>
        i_size_write(inode, new_size);

    <...>


However to avoid problems like this I felt, I will do some more code
reading. And then I was mostly considering your second suggestion which
is this. This will ensure we keep the current behavior as is and not
change that.

> If we simply don't care that we're doing a spurious write, then we can
> do something like:
> 
> -               len = size & ~PAGE_MASK;
> +               len = size & (len - 1);


-ritesh

