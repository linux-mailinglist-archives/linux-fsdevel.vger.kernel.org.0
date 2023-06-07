Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF17260A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbjFGNJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 09:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjFGNJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:09:03 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590EF211B;
        Wed,  7 Jun 2023 06:08:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25676b4fb78so3419751a91.2;
        Wed, 07 Jun 2023 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686143331; x=1688735331;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x/OHhMu6fMRl6GGY7K8zW/3JV+fF4BllBPQ+XefdwZs=;
        b=FHJC9NgOaj6oRRcZCrWPATdCOC8V8R1VRCboZ7N20QQ1uKLEQIGTIp8JEcaezXciC0
         dV4rlzt06PxtoEcQzAku5PRdu9ilBwpFmje8nm8gCVf1QKMKj1yXvgJJxTwGAfKl8abU
         uT3Tbb51ZTwiWGbRwImtLhDX1DmLYo5ChxKBvvo/SepedKGDthdIvS535oTl6Sm+594A
         rz+WoptbY052v+qzItrnvJN+IeZbrqS7xxwh60V4Q3LuLopzoF4G+nuF+zX3kAykKdQP
         YX71YvJydepZRuhFwkutYFaN5He+6Weg2g3doFv+PlDkvoXqM/PcmZoLryG/3sIPKJ0P
         a0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686143331; x=1688735331;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/OHhMu6fMRl6GGY7K8zW/3JV+fF4BllBPQ+XefdwZs=;
        b=iTq/PxBcu4Zg9xO1c3kvGFWaCP0UaagC3AGep8m2G8di8z6KmYaUDGsTfpUivq8XKK
         nDX6pKxAoFmHQxjKNQJ57ykfPnUU7TspHbJIf7PQ7VA0E2kzWIS9hr4GdxN5I1MVcmsk
         x+rRClV7pHNUyPIQOgZltynWdR0jndYf4rvuPHXVA9S+I2EhtBaK+Fm1Yt8YhzEOmsXb
         XtPTfZrp92EShsA3N8e4qM98PPABAoe5bz0TvR36bLb/RLPqvptGoECU5PCtky1a7K0o
         T81OjOFY8ePoNJUxHFEg6kcfJot6OlnhA0hOJwW/Jbeylv8dsm6ZF97mxqZIp3W9tEyc
         8BwQ==
X-Gm-Message-State: AC+VfDzBrn755iEMAD7sn70idHyrBGdFLpbb11FLSn3IMlqsSC29HU4g
        bL8HmDWXkEo6uYz4OO/FD08=
X-Google-Smtp-Source: ACHHUZ6OXY64By/1DrfVGI0cmwpYr+bivKOQ53zylB/hxRJGtbYP5YsaBKUoiC4jnXJa0GS6LSj3KA==
X-Received: by 2002:a17:90a:5894:b0:258:99d1:6b84 with SMTP id j20-20020a17090a589400b0025899d16b84mr1849611pji.41.1686143331082;
        Wed, 07 Jun 2023 06:08:51 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id q66-20020a17090a1b4800b002533ce5b261sm1422363pjq.10.2023.06.07.06.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:08:50 -0700 (PDT)
Date:   Wed, 07 Jun 2023 18:38:46 +0530
Message-Id: <87r0qnifmp.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv7 3/6] iomap: Refactor some iop related accessor functions
In-Reply-To: <ZH9e/GpsIR6FnXWM@casper.infradead.org>
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

> On Tue, Jun 06, 2023 at 09:03:17AM -0700, Darrick J. Wong wrote:
>> On Tue, Jun 06, 2023 at 05:21:32AM +0530, Ritesh Harjani wrote:
>> > So, I do have a confusion in __folio_mark_dirty() function...
>> > 
>> > i.e. __folio_mark_dirty checks whether folio->mapping is not NULL.
>> > That means for marking range of blocks dirty within iop from
>> > ->dirty_folio(), we can't use folio->mapping->host is it?
>> > We have to use inode from mapping->host (mapping is passed as a
>> > parameter in ->dirty_folio).
>
> It probably helps to read the commentary above filemap_dirty_folio().
>
>  * The caller must ensure this doesn't race with truncation.  Most will
>  * simply hold the folio lock, but e.g. zap_pte_range() calls with the
>  * folio mapped and the pte lock held, which also locks out truncation.
>
> But __folio_mark_dirty() can't rely on that!  Again, see the commentary:
>
>  * This can also be called from mark_buffer_dirty(), which I
>  * cannot prove is always protected against truncate.
>
> iomap doesn't do bottom-up dirtying, only top-down.  So it absolutely
> can rely on the VFS having taken the appropriate locks.
>

Right.

>> Ah, yeah.  folio->mapping can become NULL if truncate races with us in
>> removing the folio from the foliocache.
>> 
>> For regular reads and writes this is a nonissue because those paths all
>> take i_rwsem and will block truncate.  However, for page_mkwrite, xfs
>> doesn't take mmap_invalidate_lock until after the vm_fault has been
>> given a folio to play with.
>
> invalidate_lock isn't needed here.  You take the folio_lock, then you
> call folio_mkwrite_check_truncate() to make sure it wasn't truncated
> before you took the folio_lock.  Truncation will block on the folio_lock,
> so you're good unless you release the folio_lock (which you don't,
> you return it to the MM locked).

ohhk. Thanks for explaining this. So most callers hold the folio_lock()
which prevents agains the race from truncation while calling
->dirty_folio(). Some of the callers cannot use folio_lock() so instead
they hold the page table lock which can as well prevent against
truncation.

So I can just go ahead and use folio->mapping->host in
iomap_dirty_folio() function as well. 

Thanks a lot!! This helped. Will drop the inode from the function
argument then and will use folio->mapping->host instead. 

-ritesh
