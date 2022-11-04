Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE261A563
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Nov 2022 00:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKDXKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 19:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKDXKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:10:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199EC3FB87
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 16:10:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u6so6179088plq.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Nov 2022 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v41aR+fvCPwEW38c0zQwYORa4YZaL+9uHI9anuTfL3I=;
        b=qpscRrmEJ7uTmd385Usx44T6RA4IPEPAzY1Xh9ydCT4SxoeCROHCQJcEJnzWsWnrpA
         tG9CMEnNWuJMe+Sb2ExWu3fsMicKc8N4MhFYMMfQt3QEqpWxW4QfqUwSxJ65ekyFVA83
         8q5e8su9vvL8J5dVvrfkCciQOjmGAHf9bZvVIMQnrXBkFOkNfWr3Y76dxyegfMM3Prkj
         GN40x+zS28Q9tFCL9YGqVsH7Zj+yWg1X+ABFpU5o59oj1dVbk6HgCyC27OaNV+DFIzBJ
         33chVFTKaMsnmngg1bot+TsjUSZ/RG1K8DgB7HQQsOZdTJYWUhIpfMP4+2gvMh27KrYf
         j7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v41aR+fvCPwEW38c0zQwYORa4YZaL+9uHI9anuTfL3I=;
        b=z4UyJgsamTaABNebbtDrN1YSuYdO9RHSydDXM6a1Sq3v3M4YVohrX324Lui7zn6rOJ
         ac8DK2jmy3GWdim4fInOC6uT955s+bHoCrdpDdJ2bSDR/lDaQbRnPFGNd570++7zafUw
         P88mz+m/ek8tSBgCeW+6WREDDPd0WUka5QsPt8IVjZbfyCWXslkkTDfJVgk3OtYwSiWp
         5piz5ntGZUaS+ZnDwxFvGF4bUuKP7xzsjVzAVSFRoC2TjcpAMm8F6mqt+1P3ZRScGo/a
         +o06zDdDKaSRvSd0ya5CbAHiEkOfS10x5jVGnhKnvJeMy3PhVzQ5JXVuJkssDdoRj2R6
         ALOw==
X-Gm-Message-State: ACrzQf31EHfp3qh2dWZAvnG/GYb7FYs+vzdwPq8WBfiWg3BuFkXj233O
        eZ6/a6COaYd/gdHLD+nPP4r65g==
X-Google-Smtp-Source: AMsMyM69hdpa9UOgqHnM6JcT/xzW9NA5PMADyKmBwcPYl9+2jORadgUqbDOOmtJYEjrRVqNzN/9THg==
X-Received: by 2002:a17:90b:3b4c:b0:213:f05:6a8 with SMTP id ot12-20020a17090b3b4c00b002130f0506a8mr54974387pjb.108.1667603440565;
        Fri, 04 Nov 2022 16:10:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id e2-20020a056a0000c200b005623f96c24bsm142984pfj.89.2022.11.04.16.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 16:10:40 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1or5pc-00ALWW-G7; Sat, 05 Nov 2022 10:10:36 +1100
Date:   Sat, 5 Nov 2022 10:10:36 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] xfs: buffered write failure should not truncate the
 page cache
Message-ID: <20221104231036.GM3600936@dread.disaster.area>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-5-david@fromorbit.com>
 <Y2TIkvGMyjlXz7jp@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2TIkvGMyjlXz7jp@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 04, 2022 at 01:08:50AM -0700, Christoph Hellwig wrote:
> So, the whole scan for delalloc logic seems pretty generic, I think
> it can an should be lifted to iomap, with
> xfs_buffered_write_delalloc_punch provided as a callback.

Maybe. When we get another filesystem that has the same problem with
short writes needing to punch delalloc extents, we can look at
lifting it into the generic code. But until then, it is exclusively
an XFS issue...

> As for the reuse of the seek hole / data helpers, and I'm not sure
> this actually helps all that much, and certainly is not super
> efficient.  I don't want you to directly talk into rewriting this
> once again, but a simple

[snip]

I started with the method you are suggesting, and it took me 4 weeks
of fighting with boundary condition bugs before I realised there was
a better way.

Searching for sub-folio discontiguities is highly inefficient
however you look at it - we have to scan dirty folios block by block
determine the uptodate state of each block. We can't do a range scan
because is_partially_uptodate() will return false if any block
within the range is not up to date.  Hence we have to iterate one
block at a time to determine the state of each block, and that
greatly complicates things.

i.e. we now have range boundarys at the edges of the write() op,
range boundaries at the edges of filesysetm blocks, and range
boundaries at unpredictable folio_size() edges. I couldn't keep all
this straight in my head - I have to be able to maintain and debug
this code, so if I can't track all the edge cases in my head, I sure
as hell can't debug the code, nor expect to understand it when I
next look at it in a few months time.

Just because one person is smart enough to be able to write code
that uses multiply-nested range iterations full of boundary
conditions that have to be handled correctly, it doesn't mean that
it is the best way to write slow-path/error handling code that *must
be correct*. The best code is the code that anyone can understand
and say "yes, that is correct".

So, yes, using the seek hole / data helpers might be a tiny bit more
code, but compactness, efficiency and speed really don't matter.
What matters is that the code is correct and that the people who
need to track down the bugs and data corruptions in this code are
able to understand and debug the code.  i.e. to make the code
maintainable we need to break the complex problems down into
algorithms and code that can be understood and debugged by anyone,
not just the smartest person in the room.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
