Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE7874DD34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 20:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjGJSTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 14:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGJST3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:19:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB512B;
        Mon, 10 Jul 2023 11:19:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8baa836a5so35949795ad.1;
        Mon, 10 Jul 2023 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689013168; x=1691605168;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yElckTdbmcf0KkUywCsmMpmQ6l3geOOBU6dJNETfdPw=;
        b=jhyjrFWklAUZu55a6j70dOCRccVkE3wOq/O0r5vQJI476puEFGxNnBltLWpE2RsXBx
         Az3TMzhmE0m/rHezKsPD7CFOFJvBTAh/Q8bw8eDZOkgsqWaLsK6C5EW0GH3FN+xhYOlQ
         Ms7+4bUvg+MMuJRC7ck4w3Vr2iqBtFgejaQGhthKc1CSUTrUXOu5i33/ga3nax5sn/pn
         6LT+rQPX/5kudU7KqdCPKLsZpzeiTYi/Y27IOdKUm+gdFuSAmZ8X0hdtU3lMlG4ZZVPP
         XFPXcQjrAfGIy++02GhKr76HGaj7FzefeoBVi8sJ67PHxrDJGLKxb0Zm3vAQTpHYCnCf
         SfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689013168; x=1691605168;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yElckTdbmcf0KkUywCsmMpmQ6l3geOOBU6dJNETfdPw=;
        b=ScPWWLNFM6E5twJI2uxoIIZSzGWQb5bj/268DKf0VySwX1n4nE33E1A6o4tVe97daL
         Qlprcr+18rUDodt9NyTmtG99k5qPvXFpiTQ91k6LWHwOuQfVyTBlHlb16tsh4vdZ8Ebs
         dW+sQPsM4N4Ldzgdsy4kRtrlbAHu+Ql469RhsoFP+uENVt4rLK+TyT7//pcVstUd/ueG
         4UqsuAFLuvdOqTxmkSnc1RAnr5nsqPiKTwh1deEeLAti7RA6A6uiZ5W/WO8B55MB52l9
         SYTEBO5YBywgvxSNyiG/g9q0p95ez9rP3WOnrCcJTmpydF8wdWbXHLRo9M/0e7waBY2+
         7NWA==
X-Gm-Message-State: ABy/qLZnPRTAhIVUp292KdFltaefWKKQ7iLu9mkYP+LfKgxwNeJgGjlx
        qnG2mvfbpDzFw0QV6gdhC6M=
X-Google-Smtp-Source: APBJJlFrSMcifx1FyUk65hbM3kqeG/HeW2UemkNPzlQLN+qvIMKjXWnKVKxy/tYOVckMRpAeaG4Nkg==
X-Received: by 2002:a17:903:11c8:b0:1b8:3601:9bf7 with SMTP id q8-20020a17090311c800b001b836019bf7mr16555752plh.24.1689013167727;
        Mon, 10 Jul 2023 11:19:27 -0700 (PDT)
Received: from dw-tp (175.101.8.98.static.excellmedia.net. [175.101.8.98])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709027d8200b001b8622c1ad2sm206527plm.130.2023.07.10.11.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:19:26 -0700 (PDT)
Date:   Mon, 10 Jul 2023 23:49:15 +0530
Message-Id: <87cz0z4okc.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Aravinda Herle <araherle@in.ibm.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHv11 8/8] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <ZKdUN7ALMSCKPBV/@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

Sorry for the delayed response. I am currently on travel.

> On Fri, Jul 07, 2023 at 08:16:17AM +1000, Dave Chinner wrote:
>> On Thu, Jul 06, 2023 at 06:42:36PM +0100, Matthew Wilcox wrote:
>> > On Thu, Jul 06, 2023 at 08:16:05PM +0530, Ritesh Harjani wrote:
>> > > > @@ -1645,6 +1766,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>> > > >  	int error = 0, count = 0, i;
>> > > >  	LIST_HEAD(submit_list);
>> > > >  
>> > > > +	if (!ifs && nblocks > 1) {
>> > > > +		ifs = ifs_alloc(inode, folio, 0);
>> > > > +		iomap_set_range_dirty(folio, 0, folio_size(folio));
>> > > > +	}
>> > > > +
>> > > >  	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) != 0);
>> > > >  
>> > > >  	/*
>> > > > @@ -1653,7 +1779,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>> > > >  	 * invalid, grab a new one.
>> > > >  	 */
>> > > >  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
>> > > > -		if (ifs && !ifs_block_is_uptodate(ifs, i))
>> > > > +		if (ifs && !ifs_block_is_dirty(folio, ifs, i))
>> > > >  			continue;
>> > > >  
>> > > >  		error = wpc->ops->map_blocks(wpc, inode, pos);
>> > > > @@ -1697,6 +1823,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>> > > >  		}
>> > > >  	}
>> > > >  
>> > > > +	iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
>> > > >  	folio_start_writeback(folio);
>> > > >  	folio_unlock(folio);
>> > > >  
>> > > 
>> > > I think we should fold below change with this patch. 
>> > > end_pos is calculated in iomap_do_writepage() such that it is either
>> > > folio_pos(folio) + folio_size(folio), or if this value becomes more then
>> > > isize, than end_pos is made isize.
>> > > 
>> > > The current patch does not have a functional problem I guess. But in
>> > > some cases where truncate races with writeback, it will end up marking
>> > > more bits & later doesn't clear those. Hence I think we should correct
>> > > it using below diff.
>> > 
>> > I don't think this is the only place where we'll set dirty bits beyond
>> > EOF.  For example, if we mmap the last partial folio in a file,
>> > page_mkwrite will dirty the entire folio, but we won't write back
>> > blocks past EOF.  I think we'd be better off clearing all the dirty
>> > bits in the folio, even the ones past EOF.  What do you think?

Yup. I agree, it's better that way to clear all dirty bits in the folio.
Thanks for the suggestion & nice catch!! 

>> 
>> Clear the dirty bits beyond EOF where we zero the data range beyond
>> EOF in iomap_do_writepage() via folio_zero_segment()?
>
> That would work, but I think it's simpler to change:
>
> -	iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
> +	iomap_clear_range_dirty(folio, 0, folio_size(folio));

Right. 

@Darrick,
IMO, we should fold below change with Patch-8. If you like I can send a v12
with this change. I re-tested 1k-blocksize fstests on x86 with
below changes included and didn't find any surprise. Also v11 series
including the below folded change is cleanly applicable on your
iomap-for-next branch.


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b6280e053d68..de212b6fe467 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1766,9 +1766,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
        int error = 0, count = 0, i;
        LIST_HEAD(submit_list);

+       WARN_ON_ONCE(end_pos <= pos);
+
        if (!ifs && nblocks > 1) {
                ifs = ifs_alloc(inode, folio, 0);
-               iomap_set_range_dirty(folio, 0, folio_size(folio));
+               iomap_set_range_dirty(folio, 0, end_pos - pos);
        }

        WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) != 0);
@@ -1823,7 +1825,12 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
                }
        }

-       iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
+       /*
+        * We can have dirty bits set past end of file in page_mkwrite path
+        * while mapping the last partial folio. Hence it's better to clear
+        * all the dirty bits in the folio here.
+        */
+       iomap_clear_range_dirty(folio, 0, folio_size(folio));
        folio_start_writeback(folio);
        folio_unlock(folio);

--
2.30.2


-ritesh
