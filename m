Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE875725C19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbjFGKzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 06:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjFGKzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:55:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B07192;
        Wed,  7 Jun 2023 03:55:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-256932cea7aso3381475a91.3;
        Wed, 07 Jun 2023 03:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686135309; x=1688727309;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DXcSj4PrfsZrq4V14qzU6bDT+alY4EjtK9f4jZCZvsk=;
        b=eNTJ8DHeD1Nfka5xZ1JuN1xuxhgP2xYZzQ15OPWHe/0UX6AaFLxZnQmDtG/t6apSCL
         FIuu7mPToh3T2E2IPkahccKd6+eglJ4pZb6cIs95hZbxFYQ+BxHdqDXfpsuu2Fth94hc
         KgSdgQJSTMKcJCoJREngM81bqvCdNkaO0ANR+5lYRuGdW8DmvPSDQ/f6gfRG1H1WcyS0
         ZLh0BefngAl93pcuqcTqjdZXqyq6EcmXSlvX6jtqpi/AWmw2mLu+Ehjx6Qb0Fb6QHeK0
         Y2ny9XArRShvTB0PjhmK3FmDooCKyx9azxjYuGzRjg+37JPHIkHy7ljlBnUub8un7vym
         D7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135309; x=1688727309;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXcSj4PrfsZrq4V14qzU6bDT+alY4EjtK9f4jZCZvsk=;
        b=DH19SYEoJd6rJ++ImCV6bcCOUXrWTd/NIiHzdXO1KCJCeFfzEM6LqCGLJZqEW/pk2M
         7YJsSfxDyPnbhCHW+OOVH9UShMv7FKm76Hpj070cDSkoKwgotKWQoYXzx6COlmP0BPk7
         1KJjk7R0pdPRtblR6wNuAvFc1eER6AghDoUnnINPmem6QV6LVdwatQFpl5ut9X+dM7EF
         /nYdRsmMd4K8JKoYaWzS+PSeAQGr2biLj3LiYLRYzNAma4g2XAPnGjUkFyqaXmhTB8RU
         lepRUj+CTXBDRCsMlbFCWGppXrHvB3c4CZ2lXrP+q8bxAMlh3J4shD+VvuW+pC+BbyYG
         9URw==
X-Gm-Message-State: AC+VfDw1SNOdzChOLqSZCrow1Tx3FI16/S5+BtJvCv6a6EiwjevX2441
        2V4vBcEuUlUOZMgqlRQVjZc=
X-Google-Smtp-Source: ACHHUZ4uxP4oNOd5ywv8ty+D00bGhJSmoeoZDwOkoTvlNq6rGF1pea+EaBJF0t11MUwiFWvkiPTdaQ==
X-Received: by 2002:a17:902:d481:b0:1a9:433e:41e7 with SMTP id c1-20020a170902d48100b001a9433e41e7mr3482381plg.43.1686135309535;
        Wed, 07 Jun 2023 03:55:09 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b001b0305757c3sm10149834plo.51.2023.06.07.03.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:55:09 -0700 (PDT)
Date:   Wed, 07 Jun 2023 16:25:04 +0530
Message-Id: <87ttvjiltj.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 3/5] iomap: Refactor iomap_write_delalloc_punch() function out
In-Reply-To: <ZIApHVHrTVcPoiUn@infradead.org>
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

> On Tue, Jun 06, 2023 at 05:13:50PM +0530, Ritesh Harjani (IBM) wrote:
>> This patch moves iomap_write_delalloc_punch() out of
>> iomap_write_delalloc_scan(). No functionality change in this patch.
>
> Please chose one refactor (the existing function), or factor (the
> new function) out.  The mix doesn't make much sense.
>
> Also please explain why you're doing that.  The fact tha a new helper
> is split out is pretty obvious from the patch, but I have no idea why
> you want it.

This patch factors iomap_write_delalloc_punch() function out. This function
is resposible for actual punch out operation.
The reason for this is, to avoid deep indentation when we bring
punch-out of individual non-dirty blocks within a dirty folio in a later patch
to avoid delalloc block leak. This later patch is what adds per-block
dirty status handling to iomap.

I will rephrase commit message to above ^^^.
Let me know if any other changes requried.

-ritesh
