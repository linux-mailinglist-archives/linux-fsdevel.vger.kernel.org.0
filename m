Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DFD6E29C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDNSDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 14:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjDNSDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:03:12 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5361A76B8
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 11:03:11 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id c7so5024074ybn.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681495390; x=1684087390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKDw7OMIZVnUYlLnZnbeGeiBwQIxHaZo+ZsFo8B2vdM=;
        b=DxJ961Fg2EXYXS9CDvA0zoP8ZcMkZEJ6MFIa0BvcGMWn+mABbL1vW6aP2hTrxy4Wzw
         bE3mOjku/Zd2hA84K5SrckCnV1dI7ZruOWw5FoEWmPuo7UaBQe1iLywqBPk+hmiUoS2w
         yHq/cS6GybVZNdlCt3XFNFexKej6lWkkCg+/5popkqmEbhw2Xen1DBodwZQwTN+cqw+q
         ytTU3j12sfJ1/04NcNaSmacUFSYssTmoAT3E+y9tcbM4OE5R2yjKNLcXnNi7KYNTjry+
         xkBxUCCwehH8Ziu+FaQJMW/LSBBavsWhDStiQb6IbhqejCC75K5PIL8EkR7ytDvU9hFP
         lnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681495390; x=1684087390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKDw7OMIZVnUYlLnZnbeGeiBwQIxHaZo+ZsFo8B2vdM=;
        b=gRVj7MRNnvHDJ7nElMgZDSvL6m+XRsxUsQeafE06h+sygRLnnwUVMn+C8vXzxuxr3+
         TVxujRyAkXTx/jzxjtpog/SnEhFJ1TbgIeMMkXOxv83K4sRukhLQFJOMmC5hemHjxRQK
         6cBKE9HAQwFZu+9LwJWe5w5h1RzwwY5T+3WXCKhwE8jeI5X2wJN9Ro+oSRPh4oJVprmm
         QtY1UJS4sVYoe9felID18UnIHW/mk6p+XNVK9lpwHMs2gc8owpM2p2BvArkFApTg87d2
         no84EiAPSZa3Ra0UhsPAybWMyKz5xMD4ZmarYOZgQz5eJvgqzj5JzXZBNpAlMPO6ocVe
         z65A==
X-Gm-Message-State: AAQBX9d3uTD2iInDuYLIBKthcogYtUKvloJIYYesnvvqjSTwMY53ZPgw
        KJGrnQhMDu4mjl19VSzzqG3+Q/6vy9zYR00BAxHX+J2ZLG9eXErZAhBwdg==
X-Google-Smtp-Source: AKy350bgZ+8bUqtU8jUmvVI6chm9ORr6sN6LYpcmHD2Xf4VoanUico7K7J1M4W+lBXqwKX05ITd8KR0i1nnlwdxg0c8=
X-Received: by 2002:a25:7602:0:b0:b8b:ee74:c9d4 with SMTP id
 r2-20020a257602000000b00b8bee74c9d4mr4335988ybc.12.1681495390240; Fri, 14 Apr
 2023 11:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230404135850.3673404-1-willy@infradead.org> <20230404135850.3673404-2-willy@infradead.org>
 <CAJuCfpGPYNerqu6EjRNX2ov4uaFOawmXf1bS_xYPX5b6BAnaWg@mail.gmail.com>
 <ZDB5OsBc3R7o489l@casper.infradead.org> <CAJuCfpGMsSRQU1Oob2HNn8PFxTx2REtiUOZfB87hYokLCBU=Bw@mail.gmail.com>
 <ZDCM8hGnqgsHyP0a@casper.infradead.org>
In-Reply-To: <ZDCM8hGnqgsHyP0a@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 14 Apr 2023 11:02:57 -0700
Message-ID: <CAJuCfpGxQMEuvg1FgT0BRDdWF8kzah4BLCNfGdByFjVHyDrQLw@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: Allow per-VMA locks on file-backed VMAs
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 7, 2023 at 2:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Fri, Apr 07, 2023 at 01:26:08PM -0700, Suren Baghdasaryan wrote:
> > True. do_swap_page() has the same issue. Can we move these
> > count_vm_event() calls to the end of handle_mm_fault():
>
> I was going to suggest something similar, so count that as an
> Acked-by.  This will change the accounting for the current retry
> situation, where we drop the mmap_lock in filemap_fault(), initiate I/O
> and return RETRY.  I think that's probably a good change though; I don't
> see why applications should have their fault counters incremented twice
> for that situation.
>
> >        mm_account_fault(regs, address, flags, ret);
> > +out:
> > +       if (ret !=3D VM_FAULT_RETRY) {
> > +              count_vm_event(PGFAULT);
> > +              count_memcg_event_mm(vma->vm_mm, PGFAULT);
> > +       }
>
> Nit: this is a bitmask, so we should probably have:
>
>         if (!(ret & VM_FAULT_RETRY)) {
>
> in case somebody's ORed it with VM_FAULT_MAJOR or something.

The fix is posted at
https://lore.kernel.org/all/20230414175444.1837474-1-surenb@google.com/

>
> Hm, I wonder if we're handling that correctly; if we need to start I/O,
> do we preserve VM_FAULT_MAJOR returned from the first attempt?  Not
> in a position where I can look at the code right now.
