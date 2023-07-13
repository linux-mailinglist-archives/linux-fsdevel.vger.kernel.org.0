Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E4D751809
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 07:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGMF1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 01:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjGMF1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:27:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44C2172C;
        Wed, 12 Jul 2023 22:27:46 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-262c42d3fafso189561a91.0;
        Wed, 12 Jul 2023 22:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689226066; x=1691818066;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IDH+14RjLP1nxP7o79HBuoVn78mlKcoL6JZz+d4UCnM=;
        b=eL6odXB1XQ5BhPoFUuPneuZ62FYdc8eWRnhd7kICDdDnzj7bASQE77LZshWs/XDB0k
         8WwEAS+rlacGUa8cr3s9nNISi7+iGxbQC5zeHOhyZxp2X3oc8i3BjtGSF+hnh8UbO3c4
         Dw3xC48n9AW2kzgWWGEuUkcHMeTWjmet0vpfHysZPbl0zsI0TBexak04E+131FiM2Kwh
         zGcJOJIAMIgYPl5t1DOgmj02grfxMZ3YzRfq/rrKT5xh1yd0eEkyjDQvt6/qmtM/nWul
         i5lUVoPTZsbzUUm9sXSpTSkjqIokFUopXorvlP4MZkkwxxzWs7pVVZj97OEFfCIc0B4d
         kalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689226066; x=1691818066;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDH+14RjLP1nxP7o79HBuoVn78mlKcoL6JZz+d4UCnM=;
        b=QLGSvSUsLfvCttZequ1qWOvNngqjB7NPrOhpnXoZ/aMTNy6sfCaMI6SyyObNS0oRxJ
         QQn/847z3W1DPsEEGBHb7YRCfEQ2hf+3Om4XkBShokTJxk2VFnCm0DPpXO8KYemd89l6
         PefjPg2EXQzY5cFJS0r7l2SoT52BsmPEwhwQzI4GkmSttb0P+UKYgCI5+1o5I8WokxQ+
         f35NnGPFf4iQTGmAD6xXRBG0iMwl3vXuAuB9ppY+gfb03tVkERmNqH08/0wnCM2vo+Dc
         XQTDhKKTBgpM0QA1GVrO1rpEMIQwZMCt9ViDjsXoLBZAjGd7E0Ssomod7xRpS27/IZwb
         fnjw==
X-Gm-Message-State: ABy/qLY5AoSNoYrUvy7kO/HUf7Cb3krcKMjebIQu/psLkZxScG30duFn
        pMH3358yzGNGBXvivbuwPBI=
X-Google-Smtp-Source: APBJJlEbxLtp1t09pVji5X/BSBlRzSmDYKCAD+qHc+AccZY6PGBrXFfwY3QqpPxeH1tX5VOJYMyVJA==
X-Received: by 2002:a17:90b:68c:b0:265:d5be:8bf0 with SMTP id m12-20020a17090b068c00b00265d5be8bf0mr1207917pjz.7.1689226066140;
        Wed, 12 Jul 2023 22:27:46 -0700 (PDT)
Received: from dw-tp (175.101.8.98.static.excellmedia.net. [175.101.8.98])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a0f8e00b0025bfda134ccsm4988293pjz.16.2023.07.12.22.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:27:45 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:57:40 +0530
Message-Id: <87zg40754j.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Aravinda Herle <araherle@in.ibm.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHv11 8/8] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <20230713043804.GG108251@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Mon, Jul 10, 2023 at 11:49:15PM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> Sorry for the delayed response. I am currently on travel.
>> 
>> > On Fri, Jul 07, 2023 at 08:16:17AM +1000, Dave Chinner wrote:
>> >> On Thu, Jul 06, 2023 at 06:42:36PM +0100, Matthew Wilcox wrote:
>> >> > On Thu, Jul 06, 2023 at 08:16:05PM +0530, Ritesh Harjani wrote:
>> >> > > > @@ -1645,6 +1766,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>> >> > > >  	int error = 0, count = 0, i;
>> >> > > >  	LIST_HEAD(submit_list);
>> >> > > >  
>> >> > > > +	if (!ifs && nblocks > 1) {
>> >> > > > +		ifs = ifs_alloc(inode, folio, 0);
>> >> > > > +		iomap_set_range_dirty(folio, 0, folio_size(folio));
>> >> > > > +	}
>> >> > > > +
>> >> > > >  	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) != 0);
>> >> > > >  
>> >> > > >  	/*
>> >> > > > @@ -1653,7 +1779,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>> >> > > >  	 * invalid, grab a new one.
>> >> > > >  	 */
>> >> > > >  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
>> >> > > > -		if (ifs && !ifs_block_is_uptodate(ifs, i))
>> >> > > > +		if (ifs && !ifs_block_is_dirty(folio, ifs, i))
>> >> > > >  			continue;
>> >> > > >  
>> >> > > >  		error = wpc->ops->map_blocks(wpc, inode, pos);
>> >> > > > @@ -1697,6 +1823,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>> >> > > >  		}
>> >> > > >  	}
>> >> > > >  
>> >> > > > +	iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
>> >> > > >  	folio_start_writeback(folio);
>> >> > > >  	folio_unlock(folio);
>> >> > > >  
>> >> > > 
>> >> > > I think we should fold below change with this patch. 
>> >> > > end_pos is calculated in iomap_do_writepage() such that it is either
>> >> > > folio_pos(folio) + folio_size(folio), or if this value becomes more then
>> >> > > isize, than end_pos is made isize.
>> >> > > 
>> >> > > The current patch does not have a functional problem I guess. But in
>> >> > > some cases where truncate races with writeback, it will end up marking
>> >> > > more bits & later doesn't clear those. Hence I think we should correct
>> >> > > it using below diff.
>> >> > 
>> >> > I don't think this is the only place where we'll set dirty bits beyond
>> >> > EOF.  For example, if we mmap the last partial folio in a file,
>> >> > page_mkwrite will dirty the entire folio, but we won't write back
>> >> > blocks past EOF.  I think we'd be better off clearing all the dirty
>> >> > bits in the folio, even the ones past EOF.  What do you think?
>> 
>> Yup. I agree, it's better that way to clear all dirty bits in the folio.
>> Thanks for the suggestion & nice catch!! 
>> 
>> >> 
>> >> Clear the dirty bits beyond EOF where we zero the data range beyond
>> >> EOF in iomap_do_writepage() via folio_zero_segment()?
>> >
>> > That would work, but I think it's simpler to change:
>> >
>> > -	iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
>> > +	iomap_clear_range_dirty(folio, 0, folio_size(folio));
>> 
>> Right. 
>> 
>> @Darrick,
>> IMO, we should fold below change with Patch-8. If you like I can send a v12
>> with this change. I re-tested 1k-blocksize fstests on x86 with
>> below changes included and didn't find any surprise. Also v11 series
>> including the below folded change is cleanly applicable on your
>> iomap-for-next branch.
>
> Yes, please fold this into v12.  I think Matthew might want to get these

sure, I can fold this into Patch-8 in v12 then. I need to also rebase it
on top of Matthew's changes then right? 

> iomap folio changes out to for-next even sooner than -rc4.  If there's
> time during this week's ext4 call, let's talk about that.

Sure. Post out call, I can prepare and send a v12.

-ritesh
