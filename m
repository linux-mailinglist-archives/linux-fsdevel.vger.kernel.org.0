Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446DA57C1CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 03:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiGUBA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 21:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGUBA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 21:00:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5139C14016;
        Wed, 20 Jul 2022 18:00:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so3678470pjq.4;
        Wed, 20 Jul 2022 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=cE98CASMbH5mx65VuYel96FPiYp84qn1nOJorTFAy+A=;
        b=PcvjKGlO0ZnIRTCObWKULvH0h7EFXO+hUWezU3GGHK46jKXG8s9MkP7kpv7OF3RoI3
         4EazV0j6IdHVP5Qorosbxtkd25MublbGf9Z26/iVy4utxO4GIR/MNVLXg5s+y0ytDcxp
         GIxqiuJIb6AQYKB25jyNRQe9qOOldYsDAQbOM7WYzY8DDI8akb2YoIHeRtJ35Ym7e/Wd
         wulVKE4cFQvYtFhF+eEwf/2a4Tl0r6E/VVc3mgmhCC/CnfvT2e9vVelPReAiLpRKMLM4
         9PaLoscm0HcJr+wEZEQWInHHedmfr+PUQ3udmwDmPGJ6jSIG6HyuNFwEXre7lILWO7y+
         Jlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=cE98CASMbH5mx65VuYel96FPiYp84qn1nOJorTFAy+A=;
        b=ual290GypQKO+2dkK65kIuIiOcVIgm5A16sJj0WjpnlAhhzhvEYbMaOiRJ/nMM35sw
         TefVkLfKz3Ff5QrmsnuDU3Zquf8W4SHMB0KA/7Q36zDZLYl9wWQLD05WjIZdtZXEk5XF
         yww8IGMu60BzWRQX24qiLKJGsIZTcIh79oRBhizcVO+YcmojWuyNjVlo4w7lfal0F4HB
         hTORBPZJQHt+9qMMfiGEvS9ihH+4MkrvJQa9kpFy7fjislTiMFI26Z/F9f/TAD7LNE/z
         FMZZcnzGO6CQnA7NE3Wd7eyL7ySyPNEJzbX4AR5oLgnSO86cfCUW7YVDEIPyhBstZfBX
         O0Rg==
X-Gm-Message-State: AJIora9qBwoik0CCFAW/H/OgypMoEu/KKI6PyZw9mZ+frqzGTGUScRuT
        TJv837NuN3gXQ8dVei2o4oY=
X-Google-Smtp-Source: AGRyM1vFZnNRdBqA+FcKcKAPaI4/ri5Y0FLeviGuRwjH4lFRhkMkDQ4e2y2Woe3VqB+T2IJUenKg/Q==
X-Received: by 2002:a17:902:f683:b0:16c:3752:e332 with SMTP id l3-20020a170902f68300b0016c3752e332mr41156086plg.18.1658365222687;
        Wed, 20 Jul 2022 18:00:22 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 24-20020a630f58000000b00419b66846fcsm100870pgp.91.2022.07.20.18.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 18:00:22 -0700 (PDT)
Message-ID: <62d8a526.1c69fb81.e02e3.04ac@mx.google.com>
X-Google-Original-Message-ID: <20220721010020.GA1498096@cgel.zte@gmail.com>
Date:   Thu, 21 Jul 2022 01:00:20 +0000
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
 <62d79a79.1c69fb81.e4cba.37f5@mx.google.com>
 <YtgY7CEWvcqywK1/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtgY7CEWvcqywK1/@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 04:02:04PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 20, 2022 at 06:02:32AM +0000, CGEL wrote:
> > On Wed, Jul 20, 2022 at 04:02:40AM +0100, Matthew Wilcox wrote:
> > > On Wed, Jul 20, 2022 at 02:21:19AM +0000, cgel.zte@gmail.com wrote:
> > > > From: Yang Yang <yang.yang29@zte.com.cn>
> > > > 
> > > > Pagecache of some kind of fs has PG_dirty bit set once it was
> > > > allocated, so it can't be dropped. These fs include ramfs and
> > > > tmpfs. This can make drop_pagecache_sb() more efficient.
> > > 
> > > Why do we want to make drop_pagecache_sb() more efficient?
> > 
> > Some users may use drop_caches besides testing or debugging.
> 
> This is a terrible reason.
>

Another case that may use drop_caches: "Migration of virtual machines
will go faster if there are fewer pages to copy, so administrators would
like to be able to force a virtual machine to reclaim as much memory as
possible before the migration begins. "

See https://lwn.net/Articles/894849/

> > For example, some systems will create a lot of pagecache when boot up
> > while reading bzImage, ramdisk, docker images etc. Most of this pagecache
> > is useless after boot up. It may has a longterm negative effects for the
> > workload when trigger page reclaim. It is especially harmful when trigger
> > direct_reclaim or we need allocate pages in atomic context. So users may
> > chose to drop_caches after boot up.
> 
> If that's actually a problem, work on fixing that.
