Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D096834AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 19:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjAaSFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 13:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAaSFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:05:35 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB6B3C2E;
        Tue, 31 Jan 2023 10:05:34 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q9so10649712pgq.5;
        Tue, 31 Jan 2023 10:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ayhmt1bjcyH34Hbp3VAqnSdphdGsktgey7tJdOS13fw=;
        b=H5M7kmoOc8yHgw0JZ/4hZItw3ZpWyIkm8ED+KkuvGgnpEmiDhZH2gIjsCeAF4FUDPj
         XlsI1iXF50eHxVgcfBFsRKIP98zffx6mEyhBZeDdtK79EEYaZwqn9guiY38pnOjCGpXH
         Hb4El+CZ8noDFBIJf1Zy00c4udlp+PpIQ4Gv+i1JeoZEk4HU2M1kHPxpzKxYCW8Q55Pv
         hPMiQMH8Brk0JibS6ivtabkfvvNzUpcMEC0RlAFToSO955hMnRHMuJpsdlwax75exRmG
         0MFeMuYRkGkuxtd0UY6smQESYZDRV7WESu7jRGeKtket0PVg3JWl3zcaY8bKDP946cmi
         qYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayhmt1bjcyH34Hbp3VAqnSdphdGsktgey7tJdOS13fw=;
        b=und4/TKmgstATezlrpeLriqE5WnOB/uq/hY2r631HHoC+TYtkprrpSZKO6q+AQd9Ii
         5TDZnQNB7coftCcVLvw98z7nScfCXNh8GNt0AU1bS+IumLB0+Keb3PZlhXArqnLHYdL9
         wPDoF4o4STwyA+8cAvcwlb/v2UETkUH2yjo3DfHzfAQjUtt5nsTFM4PyI/5ew4X08bIS
         C5iGfTu6sk+YvpUU1+ymU26+115wJ55ZmCoBwee+VKwEbTd9mucDBI6q2hdEAXrFRoxX
         vZIle+STX0aGpKtSznC8yO4klQaNsHisf56jv5ZhQaC0vvHHJ3rFDQd07BYhTJbI86nX
         jvmw==
X-Gm-Message-State: AO0yUKWuUfMyxZW6Cz4xGUV130eJv11vef4BJJWERG6zKQJtxgJ3iWFO
        7o6eqgqy3aEHzOZnoC40cXY=
X-Google-Smtp-Source: AK7set9UX0lHFbyPF5sSXW+BrBRTkRU6JrZBOIMtMKm5RAktPd2katgZp9ftOT2wWhotDMHwyNRmlQ==
X-Received: by 2002:aa7:8f16:0:b0:593:b491:40b8 with SMTP id x22-20020aa78f16000000b00593b49140b8mr8961504pfr.4.1675188333369;
        Tue, 31 Jan 2023 10:05:33 -0800 (PST)
Received: from localhost ([2406:7400:63:1fd8:5041:db86:706c:f96b])
        by smtp.gmail.com with ESMTPSA id c7-20020aa78c07000000b00576259507c0sm9786743pfd.100.2023.01.31.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:05:32 -0800 (PST)
Date:   Tue, 31 Jan 2023 23:35:29 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 2/3] iomap: Change uptodate variable name to state
Message-ID: <20230131180529.ioujrstxxkurpcti@rh-tp>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <bf30b7bfb03ef368e6e744b3c63af3dbfa11304d.1675093524.git.ritesh.list@gmail.com>
 <20230130215623.GP360264@dread.disaster.area>
 <Y9hDu8hVBa3qJTNw@casper.infradead.org>
 <Y9kulWxXxcYye09a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9kulWxXxcYye09a@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/01/31 07:07AM, Christoph Hellwig wrote:
> On Mon, Jan 30, 2023 at 10:24:59PM +0000, Matthew Wilcox wrote:
> > > a single bitmap of undefined length, then change the declaration and
> > > the structure size calculation away from using array notation and
> > > instead just use pointers to the individual bitmap regions within
> > > the allocated region.
> >
> > Hard to stomach that solution when the bitmap is usually 2 bytes long
> > (in Ritesh's case).  Let's see a version of this patchset with
> > accessors before rendering judgement.
>
> Yes.  I think what we need is proper helpers that are self-documenting
> for every bitmap update as I already suggsted last round.  That keeps
> the efficient allocation, and keeps all the users self-documenting.
> It just adds a bit of boilerplate for all these helpers, but that
> should be worth having the clarity and performance benefits.

Are these accessor apis looking good to be part of fs/iomap/buffered-io.c
The rest of the changes will then be just using this to set/clear/test the
uptodate/dirty bits of iop->state bitmap.
I think, after these apis, there shouldn't be any place where we need to
directly manipulate iop->state bitmap. These APIs are all what I think are
required for current changeset.

Please let me know your thoughts/suggestions on these.
If it looks good, then I can fold these in, in different patches which
implements uptodate/dirty functionality and send rfcv3 along with other
review comments addressed.

/*
 * Accessor functions for setting/clearing/checking uptodate and
 * dirty bits in iop->state bitmap.
 * nrblocks is i_blocks_per_folio() which is passed in every
 * function as the last argument for API consistency.
 */
static inline void iop_set_range_uptodate(struct iomap_page *iop,
                                unsigned int start, unsigned int len,
                                unsigned int nrblocks)
{
        bitmap_set(iop->state, start, len);
}

static inline void iop_clear_range_uptodate(struct iomap_page *iop,
                                unsigned int start, unsigned int len,
                                unsigned int nrblocks)
{
        bitmap_clear(iop->state, start, len);
}

static inline bool iop_test_uptodate(struct iomap_page *iop, unsigned int pos,
                                unsigned int nrblocks)
{
        return test_bit(pos, iop->state);
}

static inline bool iop_full_uptodate(struct iomap_page *iop,
                                unsigned int nrblocks)
{
        return bitmap_full(iop->state, nrblocks);
}

static inline void iop_set_range_dirty(struct iomap_page *iop,
                                unsigned int start, unsigned int len,
                                unsigned int nrblocks)
{
        bitmap_set(iop->state, start + nrblocks, len);
}

static inline void iop_clear_range_dirty(struct iomap_page *iop,
                                unsigned int start, unsigned int len,
                                unsigned int nrblocks)
{
        bitmap_clear(iop->state, start + nrblocks, len);
}

static inline bool iop_test_dirty(struct iomap_page *iop, unsigned int pos,
                             unsigned int nrblocks)
{
        return test_bit(pos + nrblocks, iop->state);
}

-ritesh
