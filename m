Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2055972D846
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 05:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbjFMD5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 23:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFMD5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:57:45 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7B8E4E;
        Mon, 12 Jun 2023 20:57:43 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b28fc7a6dcso3508019a34.0;
        Mon, 12 Jun 2023 20:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686628663; x=1689220663;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gtLfJeozAFQCeMk3W1p4wvZMhqNmxJ/dZdZNt6XLDIY=;
        b=S8LYsu5IbuZR1CEMAIS/pnhEiONkLAfQ/CHKKfe8It/aoUv6Ef9Ps9QcvFzBYR+oQm
         8IcZZpi2mYdVMzfCgneNLGx5PsgPFd4eWWk2YngCksSj42pnzmzl6zrvOEMi9GbIHDWT
         yriMIPcw9TT7QS6gRmKOYWss7LUXi6dM0pfq09OzElpfrqi1EITA3rwv+BaQwGusg8UT
         ztjTcSDcwtIfn/R3KhKkoYutAeUOl4iQAeaswi+1daOvTSPHiE8+nMdfUwgchPEiOmFj
         PO96Wk2lJKoYHizXJxtdsMHVQd1cQ39qm/r/j4nKvmgMkhEw5fzF/+KczB9voBi++RyI
         maTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686628663; x=1689220663;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtLfJeozAFQCeMk3W1p4wvZMhqNmxJ/dZdZNt6XLDIY=;
        b=IbSA6is7J28YHcw+T+kLh/96G93ulVNyeo3C59UgYSsjl2jADA3CwbNNFdRDxnWjgw
         +Nwd46sq73L5gYm9DQo8KhOYyJHAVitdTCuR8ic0YhXBKs0+m52FvMn3WYSuxa35c7pG
         yeHurMgT84E3msxqjxP9NUk2ku+v+0HbLlXSQ/nyNp3hV8dyE5t75a5JyR/ua/UqGM41
         QA8MRamAAuucfB9HHpy8oWY9bDfRK/vI8Kj5A+2SBjGzwYndLl+9f9p/w4qcQnjJVLJb
         RsJsETL193Agj+xhVgbbGRgROPSHdhYzq/puMelSRWAKkg7VeHwsayvkiHj241oGJ9z/
         nzdg==
X-Gm-Message-State: AC+VfDx6gwASOX6MUGo91zxCy32h61O4ybqt/uRco+LJM0/7yRbtGORf
        WrRepPbiYCb2fVy68dE2ejVhOX1zlWs=
X-Google-Smtp-Source: ACHHUZ7JM6f5BCdsbTZ87jYEwfwM6Dk+uhFF/kc0sHbasP1GuxpvYaW5d0UTPgihArjG8WvJkBzzBQ==
X-Received: by 2002:a05:6359:69d:b0:129:b8e9:b73b with SMTP id ei29-20020a056359069d00b00129b8e9b73bmr5940319rwb.4.1686628662846;
        Mon, 12 Jun 2023 20:57:42 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id d3-20020aa78143000000b0064d681c753csm7583332pfn.40.2023.06.12.20.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 20:57:42 -0700 (PDT)
Date:   Tue, 13 Jun 2023 09:27:38 +0530
Message-Id: <87zg54580d.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv2 2/5] ext4: Remove PAGE_SIZE assumption of folio from mpage_submit_folio
In-Reply-To: <ZIdvJLE945Qbzy+H@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I am hoping Jan and Ted could correct me if any of my understanding
is incorrect. But here is my view...

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Jun 12, 2023 at 11:55:55PM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> I couldn't respond to your change because I still had some confusion
>> around this suggestion -
>>
>> > So do we care if we write a random fragment of a page after a truncate?
>> > If so, we should add:
>> >
>> >         if (folio_pos(folio) >= size)
>> >                 return 0; /* Do we need to account nr_to_write? */
>>
>> I was not sure whether if go with above case then whether it will
>> work with collapse_range. I initially thought that collapse_range will
>> truncate the pages between start and end of the file and then
>> it can also reduce the inode->i_size. That means writeback can find an
>> inode->i_size smaller than folio_pos(folio) which it is writing to.
>> But in this case we can't skip the write in writeback case like above
>> because that write is still required (a spurious write) even though
>> i_size is reduced as it's corresponding FS blocks are not truncated.
>>
>> But just now looking at ext4_collapse_range() code it doesn't look like
>> it is the problem because it waits for any dirty data to be written
>> before truncate. So no matter which folio_pos(folio) the writeback is
>> writing, there should not be an issue if we simply return 0 like how
>> you suggested above.
>>
>>     static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>>
>>     <...>
>>         ioffset = round_down(offset, PAGE_SIZE);
>>         /*
>>         * Write tail of the last page before removed range since it will get
>>         * removed from the page cache below.
>>         */
>>
>>         ret = filemap_write_and_wait_range(mapping, ioffset, offset);
>>         if (ret)
>>             goto out_mmap;
>>         /*
>>         * Write data that will be shifted to preserve them when discarding
>>         * page cache below. We are also protected from pages becoming dirty
>>         * by i_rwsem and invalidate_lock.
>>         */
>>         ret = filemap_write_and_wait_range(mapping, offset + len,
>>                         LLONG_MAX);
>>         truncate_pagecache(inode, ioffset);
>>
>>         <... within i_data_sem>
>>         i_size_write(inode, new_size);
>>
>>     <...>
>>
>>
>> However to avoid problems like this I felt, I will do some more code
>> reading. And then I was mostly considering your second suggestion which
>> is this. This will ensure we keep the current behavior as is and not
>> change that.
>>
>> > If we simply don't care that we're doing a spurious write, then we can
>> > do something like:
>> >
>> > -               len = size & ~PAGE_MASK;
>> > +               len = size & (len - 1);
>
> For all I know, I've found a bug here.  I don't know enough about ext4; if
> we have truncated a file, and then writeback a page that is past i_size,
> will the block its writing to have been freed?

I don't think so. If we look at truncate code, it first reduces i_size,
then call truncate_pagecache(inode, newsize) and then we will call
ext4_truncate() which will free the corresponding blocks.
Since writeback happens with folio lock held until completion, hence I
think truncate_pagecache() should block on that folio until it's lock
has been released.

- IIUC, if truncate would have completed then the folio won't be in the
foliocache for writeback to happen. Foliocache is kept consistent
via
    - first truncate the folio in the foliocache and then remove/free
    the blocks on device.

- Also the reason we update i_size "before" calling truncate_pagecache()
  is to synchronize with mmap/pagefault.

> Is this potentially a silent data corruptor?

- Let's consider a case when folio_pos > i_size but both still belongs
to the last block. i.e. it's a straddle write case.
In such case we require writeback to write the data of this last folio
straddling i_size. Because truncate will not remove/free this last folio
straddling i_size & neither the last block will be freed. And I think
writeback is supposed to write this last folio to the disk to keep the
cache and disk data consistent. Because truncate will only zero out
the rest of the folio in the foliocache. But I don't think it will go and
write that folio out (It's not required because i_size means that the
rest of the folio beyond i_size should remain zero).

So, IMO writeback is supposed to write this last folio to the disk. And,
if we skip this writeout, then I think it may cause silent data corruption.

But I am not sure about the rest of the write beyond the last block of
i_size. I think those could just be spurious writes which won't cause
any harm because truncate will eventually first remove this folio from
file mapping and then will release the corresponding disk blocks.
So writing those out should does no harm


-ritesh
