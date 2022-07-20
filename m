Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF457B152
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 09:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiGTHCE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 03:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGTHCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:02:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE56BE05;
        Wed, 20 Jul 2022 00:01:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d7-20020a17090a564700b001f209736b89so1200182pji.0;
        Wed, 20 Jul 2022 00:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lujkhd3wY54wcb90SIT8uAOyFvI2Fm968wecBcqgYO4=;
        b=O8m4GMS4UK9s9FeDbNMv5PS6p/Ss837cA1pqIsg6ExRq1N/qT/KEfcWnN0mhha+CnJ
         aNmEGe0yMPtWDFCCOZXNCIGa3knFUPK57+NhK5KnDIsz6KrqQ9HRu54T0GxVqMji7CYy
         utscfe0VBdQu/yr+vNhy1YmBwvlPutdJsRI2v8YhdPKu/Xp9MP1BRVeF4ZgjONqxDv4J
         C5Qg+Eyu2kYIYjL2Ws18BssbL8E+YJ16AH87x12/KKLk7TaONBkIGP01ICOgJrd9yHue
         VE9O+7dePHqamAsuP9TqbLg649OcK3u8D/VrDtwYo801RrxKhkRbNyBSkHKlM7ESE9Qu
         1V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lujkhd3wY54wcb90SIT8uAOyFvI2Fm968wecBcqgYO4=;
        b=cP8izjZvNmgegiT4Uq1/8AKLsdAUEjMRRR0523mG8j/kykp4vbLVAgRpNDPSUDmkLu
         tvWqRmQTcqEzq5qyyQ6sfMbDKV0VWwlEjbKpRPaUA/iI/3qY+irlBUOExbTJExSumpxg
         CO9YyXZeLYZotbjHsvqMXe+TLuMJXqSmgpUrcZk2MEactwDTQF87aRZfEcQznAsGCQ02
         hAljwYrj3tPIKxPvNVDg6UwmoOHqMvm/KKzbtPRrRoZv980gCEMe+FXLIYYExcWxfofo
         7vfAd444nMvF0b2yWFKQ8+LUJ3k4OxhSR0Fxj5rTL7m/nle0fBKry/3msSNPAXz+I/KQ
         Q7Cw==
X-Gm-Message-State: AJIora80avfcjfkjY365Z1YO1tVjoDV2T9ceLKEslkWygGgb/g43YBhk
        xIx8NnZVniMpSQA+DgLTAVg=
X-Google-Smtp-Source: AGRyM1sVVTbH4ksSo3N4xkGw2M2P6n7iDsshnn0P6s/BAqZ6bIG4+PkpfkMBQM8CZgfWDojYn7MCqw==
X-Received: by 2002:a17:90b:38c1:b0:1f1:f1c1:469c with SMTP id nn1-20020a17090b38c100b001f1f1c1469cmr3748928pjb.106.1658300518545;
        Wed, 20 Jul 2022 00:01:58 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ij20-20020a170902ab5400b0016d02b0fa25sm761179plb.164.2022.07.20.00.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 00:01:57 -0700 (PDT)
Message-ID: <62d7a865.1c69fb81.76782.1476@mx.google.com>
X-Google-Original-Message-ID: <20220720070156.GA1497135@cgel.zte@gmail.com>
Date:   Wed, 20 Jul 2022 07:01:56 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        hughd@google.com, akpm@linux-foundation.org,
        hsiangkao@linux.alibaba.com, yang.yang29@zte.com.cn,
        axboe@kernel.dk, yangerkun@huawei.com, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] fs: drop_caches: skip dropping pagecache which is always
 dirty
References: <20220720022118.1495752-1-yang.yang29@zte.com.cn>
 <YtdwULpWfSR3JI/u@casper.infradead.org>
 <62d79a79.1c69fb81.e4cba.37f5@mx.google.com>
 <Ytea9M3D/CuzQ1se@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytea9M3D/CuzQ1se@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:04:36PM -0700, Christoph Hellwig wrote:
> On Wed, Jul 20, 2022 at 06:02:32AM +0000, CGEL wrote:
> > For example, some systems will create a lot of pagecache when boot up
> > while reading bzImage, ramdisk, docker images etc. Most of this pagecache
> > is useless after boot up. It may has a longterm negative effects for the
> > workload when trigger page reclaim. It is especially harmful when trigger
> > direct_reclaim or we need allocate pages in atomic context. So users may
> > chose to drop_caches after boot up.
> 
> It is purely a debug interface.  If you want to drop specific page cache
> that needs to be done through madvise.

It's not easy for users to use madvise in complex system, it takes cost.
Since drop_caches is not forbidden, and users may want simply use it in
the scene above mail described.
