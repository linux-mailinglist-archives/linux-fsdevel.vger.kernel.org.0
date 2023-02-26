Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEBC6A34C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 23:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBZWla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 17:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBZWl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:41:29 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B586FF02
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 14:41:28 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id c23so4242317pjo.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 14:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9LhfR0oodBx3v7W5v+LRBO7Sex8xkiGdEA6BEM38VQ=;
        b=SvMf/Aa/hINJJK+A+0OAUPBYjkwfLODutr5QpRE0rg1W8Iq5vTf3M4UE8AJWoV+5zl
         LI/4/IDP3sBM7wlBOja43On1clJdCw0olIaoc+GmkzcNXBkt0USZzXXyxBci/twPcKnr
         RXRLgoSjUY6Sr3p+RTm0fID5OGz+wxWz6CVvROp5B7u8ANhf2w9JPixQKi5JJiEy0069
         5CieO5FxYVv3MUoR2Tf5gGFykJSu/erhYiUtk9oSE8LD+Mr/fovKJqlURyJh7eTCGOj+
         OrwxmqaSCALAuwdMKcC4ETrTjHJ0+qtN6ac7LKdtcAlX+Hkz9T/x8HybTJHi9eLgCCyh
         lKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9LhfR0oodBx3v7W5v+LRBO7Sex8xkiGdEA6BEM38VQ=;
        b=H7FPPkogHmagsTttv47hIEXq+dhb8f94y0W514/vXgcJnfiprB7UF0ERkcdcH7ON7P
         goi92KriiLu46dcuYSVYKEd+rdqjTKlY539d83n1RiiTutcoWWzhdD+Fae2ZE2MU7Z36
         9ryFSrTVylhc2tJxT6Uv+61/RaXx+/jCzrzIphXdaabq6Np2RZBpQqw5SFkHj9OJltRs
         WGib8XxUT4xK3wvthXaoQjYKwoA9EjU4L5rQ/nMIQjvXufBz8slW2SxV5lDzZgfoIlhS
         OtG7VhCL6ppdP1w7rfDWNf0/zs5xNL21NM8jJBppPhT7HsKLK3cdxohVxIpFDiLl3iMY
         yprA==
X-Gm-Message-State: AO0yUKV2w6IaCF+8M+ikBeFiHpVl117s5l9zDs5BVN9WYuQfvfA3Ee6j
        veGXV2hIzs5J26mtEdB3MGJTOg==
X-Google-Smtp-Source: AK7set9rIu1VwsvuZMj29s1m7LcQVqvU+Ge0CGfxHX2/i2DEr3oYvC3iX93Ew+Vjg8xwyFgYKGjPGg==
X-Received: by 2002:a05:6a20:a004:b0:cc:a93:2b82 with SMTP id p4-20020a056a20a00400b000cc0a932b82mr15675687pzj.58.1677451287966;
        Sun, 26 Feb 2023 14:41:27 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id t20-20020a62ea14000000b005809d382016sm2907282pfh.74.2023.02.26.14.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:41:27 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pWPhs-002VTc-R0; Mon, 27 Feb 2023 09:41:24 +1100
Date:   Mon, 27 Feb 2023 09:41:24 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFCv3 1/3] iomap: Allocate iop in ->write_begin() early
Message-ID: <20230226224124.GV360264@dread.disaster.area>
References: <cover.1677428794.git.ritesh.list@gmail.com>
 <34dafb5e15dba3bb0b0e072404ac6fb9f11561b8.1677428794.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34dafb5e15dba3bb0b0e072404ac6fb9f11561b8.1677428794.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 01:13:30AM +0530, Ritesh Harjani (IBM) wrote:
> Earlier when the folio is uptodate, we only allocate iop at writeback
> time (in iomap_writepage_map()). This is ok until now, but when we are
> going to add support for subpage size dirty bitmap tracking in iop, this
> could cause some performance degradation. The reason is that if we don't
> allocate iop during ->write_begin(), then we will never mark the
> necessary dirty bits in ->write_end() call. And we will have to mark all
> the bits as dirty at the writeback time, that could cause the same write
> amplification and performance problems as it is now (w/o subpage dirty
> bitmap tracking in iop).
> 
> However, for all the writes with (pos, len) which completely overlaps
> the given folio, there is no need to allocate an iop during
> ->write_begin(). So skip those cases.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 356193e44cf0..c5b51ab1184e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -535,11 +535,16 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  	size_t from = offset_in_folio(folio, pos), to = from + len;
>  	size_t poff, plen;
>  
> +	if (pos <= folio_pos(folio) &&
> +	    pos + len >= folio_pos(folio) + folio_size(folio))
> +		return 0;

This is magic without a comment explaining why it exists. You have
that explanation in the commit message, but that doesn't help anyone
looking at the code:

	/*
	 * If the write completely overlaps the current folio, then
	 * entire folio will be dirtied so there is no need for
	 * sub-folio state tracking structures to be attached to this folio.
	 */

-Dave.

-- 
Dave Chinner
david@fromorbit.com
