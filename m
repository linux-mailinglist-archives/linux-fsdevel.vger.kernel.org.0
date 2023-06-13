Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB03572EC18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 21:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjFMTkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 15:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFMTkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:40:12 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C094199;
        Tue, 13 Jun 2023 12:40:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b3c0c476d1so25036055ad.1;
        Tue, 13 Jun 2023 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686685210; x=1689277210;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kSSnaNT4Vg+fuqw41pHt2Y9yS3NvfA3MNwTbL33YeF8=;
        b=FwUIZ00VuhQjqklK7xWtVRDUFtQV7IGrmvO88qw0FYxl9zFAPCiW2EvWcBQpRF62AT
         A7MgnALz5wxRqsJtCh3sETlyvISOIDtc0MJGAej1KD877nn5lDqA9jqn33tBTTFjO+px
         /gLU1mEMvdohVnbx0at7YTHpHpkXC10DuMX9yyiOOzr3B3edH63eeE0I9ZYf9qZ/aO4I
         uN82+5qreL8aFUjrNEuWmdSB7I2RNtXMet33pj+6gZYzGb2ML9ZAXBMJKHnRnqOuGKik
         a+yHHxFRSR6bwBM3zGK/5RczIDV+7R+xDXUynD2VXYoHho+HNyFU1HDuzsLfyIm6Gp/z
         g1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685210; x=1689277210;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSSnaNT4Vg+fuqw41pHt2Y9yS3NvfA3MNwTbL33YeF8=;
        b=itYSvMWEZeae6ay0I5vf5zqoLiid5kyeaNg03mESAKsbBGEik4gzqc9yG1IUuAXd1X
         doz4aR814fcpyT8OPa96nZB9ibEhTw4ShjVXtTvfoxAyO38j661wWuJdUEREDvlvl9yM
         l2Ame1mHZSseiEkXeu52aqe0Q1weBypnooIUT0IyYfIO+ZTGw4hRqCgFHddn0hNlDmhk
         g1jYIr17aiNop2YmKpr+FFNR/2w/lYWcBYm/iWIM7LzMMEzYWzME6d4DJKR0VAo2CgJ4
         x/S+ZT7+vEbVLbwm5nHmakxfz4ab5DAsvmwfbubXHHghDD1GNOyOenbKCZJwsb89lyR+
         A0SA==
X-Gm-Message-State: AC+VfDyrRxXvXuxYFWjVoBlFI0sidBsN2lMftcHhpYe5dl8Fc3gJsadJ
        VsxMGwfhvPTt8ExEPXHrlzE=
X-Google-Smtp-Source: ACHHUZ48JIap55FGdA5nyDTdWD8SzewMQkxwV1G1E6NlphTRc0oJPOo5IpIY9Qnceoh3hNQpz+WNwg==
X-Received: by 2002:a17:902:7c85:b0:1b0:3a03:50d0 with SMTP id y5-20020a1709027c8500b001b03a0350d0mr11670818pll.26.1686685210290;
        Tue, 13 Jun 2023 12:40:10 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id o24-20020a170902779800b001afbc038492sm10569431pll.299.2023.06.13.12.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:40:09 -0700 (PDT)
Date:   Wed, 14 Jun 2023 01:09:59 +0530
Message-Id: <87o7ljw3qo.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv2 2/5] ext4: Remove PAGE_SIZE assumption of folio from mpage_submit_folio
In-Reply-To: <20230613095917.trpqw2iv2f7kutaz@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Tue 13-06-23 09:27:38, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> > On Mon, Jun 12, 2023 at 11:55:55PM +0530, Ritesh Harjani wrote:
>> >> Matthew Wilcox <willy@infradead.org> writes:
>> >> I couldn't respond to your change because I still had some confusion
>> >> around this suggestion -
>> >>
>> >> > So do we care if we write a random fragment of a page after a truncate?
>> >> > If so, we should add:
>> >> >
>> >> >         if (folio_pos(folio) >= size)
>> >> >                 return 0; /* Do we need to account nr_to_write? */
>> >>
>> >> I was not sure whether if go with above case then whether it will
>> >> work with collapse_range. I initially thought that collapse_range will
>> >> truncate the pages between start and end of the file and then
>> >> it can also reduce the inode->i_size. That means writeback can find an
>> >> inode->i_size smaller than folio_pos(folio) which it is writing to.
>> >> But in this case we can't skip the write in writeback case like above
>> >> because that write is still required (a spurious write) even though
>> >> i_size is reduced as it's corresponding FS blocks are not truncated.
>> >>
>> >> But just now looking at ext4_collapse_range() code it doesn't look like
>> >> it is the problem because it waits for any dirty data to be written
>> >> before truncate. So no matter which folio_pos(folio) the writeback is
>> >> writing, there should not be an issue if we simply return 0 like how
>> >> you suggested above.
>> >>
>> >>     static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>> >>
>> >>     <...>
>> >>         ioffset = round_down(offset, PAGE_SIZE);
>> >>         /*
>> >>         * Write tail of the last page before removed range since it will get
>> >>         * removed from the page cache below.
>> >>         */
>> >>
>> >>         ret = filemap_write_and_wait_range(mapping, ioffset, offset);
>> >>         if (ret)
>> >>             goto out_mmap;
>> >>         /*
>> >>         * Write data that will be shifted to preserve them when discarding
>> >>         * page cache below. We are also protected from pages becoming dirty
>> >>         * by i_rwsem and invalidate_lock.
>> >>         */
>> >>         ret = filemap_write_and_wait_range(mapping, offset + len,
>> >>                         LLONG_MAX);
>> >>         truncate_pagecache(inode, ioffset);
>> >>
>> >>         <... within i_data_sem>
>> >>         i_size_write(inode, new_size);
>> >>
>> >>     <...>
>> >>
>> >>
>> >> However to avoid problems like this I felt, I will do some more code
>> >> reading. And then I was mostly considering your second suggestion which
>> >> is this. This will ensure we keep the current behavior as is and not
>> >> change that.
>> >>
>> >> > If we simply don't care that we're doing a spurious write, then we can
>> >> > do something like:
>> >> >
>> >> > -               len = size & ~PAGE_MASK;
>> >> > +               len = size & (len - 1);
>> >
>> > For all I know, I've found a bug here.  I don't know enough about ext4; if
>> > we have truncated a file, and then writeback a page that is past i_size,
>> > will the block its writing to have been freed?
>> 
>> I don't think so. If we look at truncate code, it first reduces i_size,
>> then call truncate_pagecache(inode, newsize) and then we will call
>> ext4_truncate() which will free the corresponding blocks.
>> Since writeback happens with folio lock held until completion, hence I
>> think truncate_pagecache() should block on that folio until it's lock
>> has been released.
>> 
>> - IIUC, if truncate would have completed then the folio won't be in the
>> foliocache for writeback to happen. Foliocache is kept consistent
>> via
>>     - first truncate the folio in the foliocache and then remove/free
>>     the blocks on device.
>
> Yes, correct.
>
>> - Also the reason we update i_size "before" calling truncate_pagecache()
>>   is to synchronize with mmap/pagefault.
>
> Yes, but these days mapping->invalidate_lock works for that instead for
> ext4.
>
>> > Is this potentially a silent data corruptor?
>> 
>> - Let's consider a case when folio_pos > i_size but both still belongs
>> to the last block. i.e. it's a straddle write case.
>> In such case we require writeback to write the data of this last folio
>> straddling i_size. Because truncate will not remove/free this last folio
>> straddling i_size & neither the last block will be freed. And I think
>> writeback is supposed to write this last folio to the disk to keep the
>> cache and disk data consistent. Because truncate will only zero out
>> the rest of the folio in the foliocache. But I don't think it will go and
>> write that folio out (It's not required because i_size means that the
>> rest of the folio beyond i_size should remain zero).
>> 
>> So, IMO writeback is supposed to write this last folio to the disk. And,
>> if we skip this writeout, then I think it may cause silent data corruption.
>> 
>> But I am not sure about the rest of the write beyond the last block of
>> i_size. I think those could just be spurious writes which won't cause
>> any harm because truncate will eventually first remove this folio from
>> file mapping and then will release the corresponding disk blocks.
>> So writing those out should does no harm
>
> Correct. The block straddling i_size must be written out, the blocks fully
> beyond new i_size (but below old i_size) may or may not be written out. As
> you say these extra racing writes to blocks that will get truncated cause
> no harm.
>

Thanks Jan for confirming. So, I think we should make below change.
(note the code which was doing "size - folio_pos(folio)" in
mpage_submit_folio() is dropped by Ted in the latest tree).

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 43be684dabcb..006eba9be5e6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1859,9 +1859,9 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
         */
        size = i_size_read(mpd->inode);
        len = folio_size(folio);
-       if (folio_pos(folio) + len > size &&
+       if ((folio_pos(folio) >= size || (folio_pos(folio) + len > size)) &&
            !ext4_verity_in_progress(mpd->inode))
-               len = size & ~PAGE_MASK;
+               len = size & (len - 1);
        err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
        if (!err)
                mpd->wbc->nr_to_write--;
@@ -2329,9 +2329,9 @@ static int mpage_journal_page_buffers(handle_t *handle,
        folio_clear_checked(folio);
        mpd->wbc->nr_to_write--;

-       if (folio_pos(folio) + len > size &&
+       if ((folio_pos(folio) >= size || (folio_pos(folio) + len > size)) &&
            !ext4_verity_in_progress(inode))
-               len = size - folio_pos(folio);
+               len = size & (len - 1);

        return ext4_journal_folio_buffers(handle, folio, len);
 }


I will give it some more thoughts and testing.

-ritesh
