Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD4957B0B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 08:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiGTGCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 02:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGTGCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:02:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD59A599D5;
        Tue, 19 Jul 2022 23:02:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o18so2631248pjs.2;
        Tue, 19 Jul 2022 23:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=GOSt91VjSu2VEl8kfFKkP6kjxkw8pyT1JGZchTh4yMY=;
        b=GLSGwJBy1rmLnKP1MXZ0CO0xCE4X6vPyM/fWH8VRnVDjlmRGpOSwneEepnYklWVeF/
         ZTjMBCl7PqNo0CMCaY60xA/3fTcMChuPwZiyEvL4cdfhGaE3Qfk4nLXpKpNnlWtspZAN
         d5AczfT5RwSxskHXde0l+u/3Bfi09SK9iNU5jus42l3dV6UuWVpOyUfVYAc3+qG22I/r
         Y9eMiV8P0EJS5SbfvAG9v7/ECoWA3YL+lHUNFpj9oa/tPLxIEygHAHEjr68zv9Dln6YV
         qfeagsCXbnvQ2BPk08R7ZkgsM9U4PKjG2ximOq52TlP0514aNgJGFeG8J6U4uWnlswtV
         OHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=GOSt91VjSu2VEl8kfFKkP6kjxkw8pyT1JGZchTh4yMY=;
        b=yQ3S7swpHbdBosv+aYZStc+jCVYyc7JCCMDUpkscEN9AnbM9bQR8msuZGaFs9cN8Bm
         DRxPLdPl85gJ07PgM+a6gMV8A3J4W80zaM5YPzRkGpiCg4KZ144wg7e3yHT+l+pqdCdr
         FqaJDGrAJV3/biZAa2EUPQC0JbiQG8xNivNZCmTmJUZ1GcdmH4PCLh8+jUtrrpNRrewf
         U/p9+RdsZwOpLqGDD2Uh9IhmOHahw5X4Homk557eZj7tnrGgraG32iNJk7rDxX2tfdCf
         2VuzG8yWdpNQVlFUOzEIPtwnE0lTL38MEa8A6qgO78T5dpssz9NeD/l5stJYgbfiKBOI
         vwqQ==
X-Gm-Message-State: AJIora/FBrrb8oumzHewfX5qMeWIoxDtKdfIrOK9ht/N/Usr/o4DJo8B
        lxirtwTfomVRdsAtP3h0yO8=
X-Google-Smtp-Source: AGRyM1vERw1W/biXDH3FHaCl6/KCF9/jCHaZI3rf3jbENK8Cgsc77M9GgyGmnnEQZwZZ9eOL6dkDNw==
X-Received: by 2002:a17:90a:5513:b0:1f1:c93c:7ad8 with SMTP id b19-20020a17090a551300b001f1c93c7ad8mr3483937pji.88.1658296955363;
        Tue, 19 Jul 2022 23:02:35 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902c40400b0016782c55790sm12961802plk.232.2022.07.19.23.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 23:02:33 -0700 (PDT)
Message-ID: <62d79a79.1c69fb81.e4cba.37f5@mx.google.com>
X-Google-Original-Message-ID: <20220720060232.GA1496592@cgel.zte@gmail.com>
Date:   Wed, 20 Jul 2022 06:02:32 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, hughd@google.com,
        akpm@linux-foundation.org, hch@infradead.org,
        hsiangkao@linux.alibaba.com, yang.yang29@zte.com.cn,
        axboe@kernel.dk, yangerkun@huawei.com, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] fs: drop_caches: skip dropping pagecache which is always
 dirty
References: <20220720022118.1495752-1-yang.yang29@zte.com.cn>
 <YtdwULpWfSR3JI/u@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtdwULpWfSR3JI/u@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 04:02:40AM +0100, Matthew Wilcox wrote:
> On Wed, Jul 20, 2022 at 02:21:19AM +0000, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > Pagecache of some kind of fs has PG_dirty bit set once it was
> > allocated, so it can't be dropped. These fs include ramfs and
> > tmpfs. This can make drop_pagecache_sb() more efficient.
> 
> Why do we want to make drop_pagecache_sb() more efficient?

Some users may use drop_caches besides testing or debugging.

For example, some systems will create a lot of pagecache when boot up
while reading bzImage, ramdisk, docker images etc. Most of this pagecache
is useless after boot up. It may has a longterm negative effects for the
workload when trigger page reclaim. It is especially harmful when trigger
direct_reclaim or we need allocate pages in atomic context. So users may
chose to drop_caches after boot up.
