Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45538749F6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjGFOqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjGFOqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:46:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1121FDA;
        Thu,  6 Jul 2023 07:46:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8a44ee159so3528185ad.3;
        Thu, 06 Jul 2023 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688654770; x=1691246770;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sHK40quW1VFjXNzQRez3EQrvgJhxVXz9e4IagyBzLD8=;
        b=c5n7Jg3Lsah3E/CXz4AWL/3gKXDM9ZEgZahf3gngVTi6Z/obI3gD4NZuHs28A4CGr0
         9PujRmHWL1YnLDdyurHkU+Od10fZbC/nap2JGuE4HCWOo5gHAEQwVz2e8l2Eyq5CXnne
         ulTFmJQVEJd6/p61XjGo963QxBtbcCiKerQxvNzoKfU9Ss+galO6ftKPVR+nLN2sYeCm
         PsuOOHtoyc5RAV2bRww9ltgWX6Llo1X3d1VxO2Yfrro+mok6VNCb2V3rHY+N2JxvJ8+9
         e2WogF6misfH1q2r/XnHJCpzTAfabsP9wa/BQ8130DJhC8fy6qtdN3Jaabv3fLp497uq
         I2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688654770; x=1691246770;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHK40quW1VFjXNzQRez3EQrvgJhxVXz9e4IagyBzLD8=;
        b=g4UjJspitdsJO6gph15nUhOHfvdVZz/2mQdCL7TI87ECeRgiNF/n8+3M7O+RI90Klf
         VgPhovb8cjw2Gd7dd7kufA8cpmbdWpHkjIA00NthapUAGBuA2ooTORi8qXtlkrM4oRGo
         6lXJY7B/MV8QcRB/YjCKTUgIN5ZsKQ9UWAhFO0bTRxtnCNekoQbAYZczzhgVklM73pho
         1RtZ4aidlnzNW0zsy2g13YN42pbAFF2GIw78Qk7ID2b5GLS0maRJ5K/EIGewSpOYaKrm
         AURu5Thb4onqk/lylJdbZ5QM3JCQE84apFHcLub9eX9929l0kTs9juJQ8LHg60Uawjw8
         oUkA==
X-Gm-Message-State: ABy/qLYNU0C7q+0TRE/EbrSWMBk5jAfSEKT7oX6bAR3VJmwepjKoJox7
        fhr2adrBSeuldDQ14cdvseo=
X-Google-Smtp-Source: APBJJlEYbuUW9q0fLRSQAUQCyF8zF5TtNNIK58nurBfcGgmcrQ8OiUV8MMepZet3d0GK5qR3+09+mw==
X-Received: by 2002:a17:903:244e:b0:1b5:edd:e3c7 with SMTP id l14-20020a170903244e00b001b50edde3c7mr1945804pls.16.1688654770404;
        Thu, 06 Jul 2023 07:46:10 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id ij24-20020a170902ab5800b001ac897026cesm1552555plb.102.2023.07.06.07.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:46:09 -0700 (PDT)
Date:   Thu, 06 Jul 2023 20:16:05 +0530
Message-Id: <87jzvdjdxu.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv11 8/8] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <bb0c58bf80dcdec96d7387bc439925fb14a5a496.1688188958.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> @@ -1637,7 +1758,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode,
>  		struct folio *folio, u64 end_pos)
>  {
> -	struct iomap_folio_state *ifs = ifs_alloc(inode, folio, 0);
> +	struct iomap_folio_state *ifs = folio->private;
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
> @@ -1645,6 +1766,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	int error = 0, count = 0, i;
>  	LIST_HEAD(submit_list);
>  
> +	if (!ifs && nblocks > 1) {
> +		ifs = ifs_alloc(inode, folio, 0);
> +		iomap_set_range_dirty(folio, 0, folio_size(folio));
> +	}
> +
>  	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) != 0);
>  
>  	/*
> @@ -1653,7 +1779,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * invalid, grab a new one.
>  	 */
>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> -		if (ifs && !ifs_block_is_uptodate(ifs, i))
> +		if (ifs && !ifs_block_is_dirty(folio, ifs, i))
>  			continue;
>  
>  		error = wpc->ops->map_blocks(wpc, inode, pos);
> @@ -1697,6 +1823,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		}
>  	}
>  
> +	iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
>  	folio_start_writeback(folio);
>  	folio_unlock(folio);
>  

I think we should fold below change with this patch. 
end_pos is calculated in iomap_do_writepage() such that it is either
folio_pos(folio) + folio_size(folio), or if this value becomes more then
isize, than end_pos is made isize.

The current patch does not have a functional problem I guess. But in
some cases where truncate races with writeback, it will end up marking
more bits & later doesn't clear those. Hence I think we should correct
it using below diff.

I have added a WARN_ON_ONCE, but if you think it is obvious and not
required, feel free to drop it.

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2fd9413838de..6c03e5842d44 100644
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

-ritesh
