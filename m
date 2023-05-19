Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B8E709ACF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 17:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjESPCB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 11:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjESPB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 11:01:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668CCC7;
        Fri, 19 May 2023 08:01:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so1119624b3a.1;
        Fri, 19 May 2023 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684508515; x=1687100515;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JBc9YrxvbYjejsKl+F5Pqxz2DtC64tdrlhepiTOshuE=;
        b=V1NDgn1OtjZYesBfiUNAVfX+RVW/0Rrj1F0Y1FOYXaEGm/XxFQw+rSX3Kcs+WmLRZy
         Iv/vZu2Tcg5FwHryRCEFEDhDVBg7TbIZVTdfwrxcSsLhuqDnCK7tXlP/cO6oeSBeJ3ru
         Qd+ywtM57WDsbifVFlWrPDBwCdJblfdsH5gZPfeVMAaK2bchGmfbHP9f5QS+nnRFd7Zx
         drQca0BGS/p8mj0LghSBleDwUfk9YjBs9u32MvJrrVB5ueSTCPli6X+bzmQRps1xUiIY
         1Wsg8P6uDvMaGMuabXyGtr+ITf01owBe+ajJ2Y9d1W/1qRxU1HnGgfajhoweLSMFYo24
         kiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684508515; x=1687100515;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBc9YrxvbYjejsKl+F5Pqxz2DtC64tdrlhepiTOshuE=;
        b=Fqs48XqS1TyKv8gx+2ntUcb4/eKlvtY9jDy+0OhY/9FAXgjIk7jjuYGdp3S1tAUj6d
         q4B79HJaHl63LrmFTimSj7FYPOrm8C1yVIMwB+Cq2A5TDSEMHAUcxOQPtYBIr4aN00yg
         li5fVBJMcmW4uG2WS5bxXvo2r09iDyuE0gGHSrb3Biv9PwnDq0GneSnDsX2iVrTdhhYT
         Ys3Hgc0iz6Y7jUMxDrm44D3bZz2/oEQdb9WjCVD5d+3KOaCkW2rcrlSKOGVOFvdrM0Ky
         YEDNeNrCYpILWT4JObNPGsPxuM1Y44k+8YUnEYfWKNOpat2YjqtV/qVM6NLG7yKsc/0j
         p1RA==
X-Gm-Message-State: AC+VfDyB7u4TUmDfIeWXauzLdHGQwt5dI95IMv0YWj0zPeCK/0HYVhl0
        t/3F/sCo11AnSoCFF+1Ojjg=
X-Google-Smtp-Source: ACHHUZ4ArbowHIV8H57ORsYngFfbK5Bp2xLZh/KvSZbs3iqQ5OKRLuIJhG+GPaAlGJaRkoIIAy9cOg==
X-Received: by 2002:a05:6a20:429b:b0:101:73a9:1680 with SMTP id o27-20020a056a20429b00b0010173a91680mr2691699pzj.8.1684508514628;
        Fri, 19 May 2023 08:01:54 -0700 (PDT)
Received: from rh-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b0063d375ca0cbsm3121165pfu.151.2023.05.19.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:01:54 -0700 (PDT)
Date:   Fri, 19 May 2023 20:31:39 +0530
Message-Id: <87edncwejw.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 1/5] iomap: Rename iomap_page_create/release() to iop_alloc/free()
In-Reply-To: <ZGXCCoGFXhtcbkBX@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Mon, May 08, 2023 at 12:57:56AM +0530, Ritesh Harjani (IBM) wrote:
>> This patch renames the iomap_page_create/release() functions to
>> iop_alloc/free() calls. Later patches adds more functions for
>> handling iop structure with iop_** naming conventions.
>> Hence iop_alloc/free() makes more sense.
>
> I can't say I like the iop_* naming all that much, especially as we
> it is very generic and we use an iomap_ prefix every else.
>

I can prefix iomap_ so it will then become iomap_iop_alloc()/iomap_iop_free().
All other helpers will be like...
- iomap_iop_set_range_uptodate()
- iomap_iop_set_range_dirty()
- ...

'iomap_iop' prefix just helps distinguish all the APIs which are
working over iomap_page (iop) structure.

>> Note, this patch also move folio_detach_private() to happen later
>> after checking for bitmap_full(). This is just another small refactor
>> because in later patches we will move bitmap_** helpers to iop_** related
>> helpers which will only take a folio and hence we should move
>> folio_detach_private() to the end before calling kfree(iop).
>
> Please don't mix renames and code movements.

Sure. Will take care of it in the next rev.
