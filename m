Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F861681B48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 21:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjA3UWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 15:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjA3UWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:22:00 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE89470AF;
        Mon, 30 Jan 2023 12:21:55 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so4357221pjb.4;
        Mon, 30 Jan 2023 12:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=29JgEGmO6OyNOmpiy/QTe4G1jO/yNhMzxTaKRpOdeIU=;
        b=F3DjW7fEdT4AYcTtsZ8N3SNJTvGAoGFNQxJfMFdGkB8Ii5bEw6qmZXisPWrY5clMHO
         xN1QH7pUQ1aH32XNOW1rDLSDfN2J9W3Hnx1mlQxPCiJJtT+/PTSuTffaxucqJA3xI2Ij
         4k7x2dUqRwl9a6rJu1K6RrEo8y7mrnAgHLuxAAOC0uxDPuoimdsXx79AadpljUlCtUnE
         G9wtdNiCFi2CBX/MmBBrs6pXG9W84IGNO9uOFWZaQel/ecCZqpeFcSW8JRjtcxOXaz++
         u+q0Plq6VLeVjBFYDN+8RafLt+6XVQguGJzpJaulSF4sutTo9O87e+neq6wu9iXIkzKb
         puig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29JgEGmO6OyNOmpiy/QTe4G1jO/yNhMzxTaKRpOdeIU=;
        b=TFHAyL3kh6y0opWlHpZVWPbQ1WD8NYoJhfH9SY0Hare7i+MggJTAESMjV93ehWlsxq
         WzQO9tns0e7EkfGlI6MkALBsZU0/c2a+IIQrR8OIp0Dj1tvppb110GiaFc5VYxHMBzJ+
         MoSwDmCYWZii6hRpulE05tKjNgVWVNkOWDJeHnv3RojV3jhaH8JOA1J2WPLpNSZm5Ix3
         MrWKeGVMQToVCe7mQ11//V9BuhzncY7tU3SyrGwrdQTIvmVH0D73kPNO1wB7sjJzyvLg
         3/u8Otrlc/qchO3wV6JI05AbYeFiz9kqcF5uTXde4uFJhs9xvqyrfSSmYEvdNoIuBdkk
         kWug==
X-Gm-Message-State: AO0yUKVDGlXascbA62lVhc3BWYzaHMUyNwOkf8mHN1qLOVAXesqfjE/1
        iUm6J9zq92h4MOx31DcnjJ2hxozP5DA=
X-Google-Smtp-Source: AK7set8sB2HDWU7OjRDAQmT99Z/HW8p8+MN5aB2kQpZKrRyrTvNil9TA4XgZ7QZlWNmb8SWv2yLljw==
X-Received: by 2002:a17:90b:3805:b0:22c:4e1:93e with SMTP id mq5-20020a17090b380500b0022c04e1093emr23632477pjb.15.1675110114591;
        Mon, 30 Jan 2023 12:21:54 -0800 (PST)
Received: from localhost ([2406:7400:63:1fd8:5041:db86:706c:f96b])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090a414a00b002270155254csm7410914pjg.24.2023.01.30.12.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:21:54 -0800 (PST)
Date:   Tue, 31 Jan 2023 01:51:50 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 1/3] iomap: Move creation of iomap_page early in
 __iomap_write_begin
Message-ID: <20230130202150.pfohy5yg6dtu64ce@rh-tp>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <d879704250b5f890a755873aefe3171cbd193ae9.1675093524.git.ritesh.list@gmail.com>
 <Y9f4MFzpFEi73E6P@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9f4MFzpFEi73E6P@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/01/30 09:02AM, Christoph Hellwig wrote:
> On Mon, Jan 30, 2023 at 09:44:11PM +0530, Ritesh Harjani (IBM) wrote:
> > The problem is that commit[1] moved iop creation later i.e. after checking for
> > whether the folio is uptodate. And if the folio is uptodate, it simply
> > returns and doesn't allocate a iop.
> > Now what can happen is that during __iomap_write_begin() for bs < ps,
> > there can be a folio which is marked uptodate but does not have a iomap_page
> > structure allocated.
> > (I think one of the reason it can happen is due to memory pressure, we
> > can end up freeing folio->private resource).
> >
> > Thus the iop structure will only gets allocated at the time of writeback
> > in iomap_writepage_map(). This I think, was a not problem till now since
> > we anyway only track uptodate status in iop (no support of tracking
> > dirty bitmap status which later patches will add), and we also end up
> > setting all the bits in iomap_page_create(), if the page is uptodate.
>
> delayed iop allocation is a feature and not a bug.  We might have to
> refine the criteria for sub-page dirty tracking, but in general having
> the iop allocates is a memory and performance overhead and should be
> avoided as much as possible.  In fact I still have some unfinished
> work to allocate it even more lazily.

So, what I meant here was that the commit[1] chaged the behavior/functionality
without indenting to. I agree it's not a bug.
But when I added dirty bitmap tracking support, I couldn't understand for
sometime on why were we allocating iop only at the time of writeback.
And it was due to a small line change which somehow slipped into this commit [1].
Hence I made this as a seperate patch so that it doesn't slip through again w/o
getting noticed/review.

Thanks for the info on the lazy allocation work. Yes, though it is not a bug, but
with subpage dirty tracking in iop->state[], if we end up allocating iop only
at the time of writeback, than that might cause some performance degradation
compared to, if we allocat iop at ->write_begin() and mark the required dirty
bit ranges in ->write_end(). Like how we do in this patch series.
(Ofcourse it is true only for bs < ps use case).

[1]: https://lore.kernel.org/all/20220623175157.1715274-5-shr@fb.com/


Thanks again for your quick review!!
-ritesh

