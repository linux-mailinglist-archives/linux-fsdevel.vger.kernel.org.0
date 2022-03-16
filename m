Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A70A4DA923
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 04:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiCPEAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 00:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiCPEAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 00:00:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7E1A3A9;
        Tue, 15 Mar 2022 20:59:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u17so2145481pfk.11;
        Tue, 15 Mar 2022 20:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=2j1k6udki+IUT8t4y+SO0EekjaGf0Ggc9U0FBMw0ySM=;
        b=BVc1Haw4J+7O1LlCY6oEmAcnC24ZZjBwISPZqoKNcNjRuio8hYNKthG4zKv37ASwiQ
         onj26deMuQy3In9hXn9QBh3ZUR1uGOg/q3aIR5iTlnYRKXd55t0NPpdcZ25EdEAfiRZ7
         zwN6Ay3R36Ixs2sIrBNMnggKFkNeAy5tOtX9ZEcYBBX15tbXilwhx3f+p0w/QeOOm+dL
         zPoSko2F57P0V1Vvmbz4tdWqEHrsw4xCBlMnOrOTxn5o8dvtE1fafqrvDvtjdEeVRI9I
         SDf0tzeM+Z0LtifZsGulK8XIEejZIk0wPr+uezkLO5ePd4QjQcwXhhH7dPWpTXVX/La0
         /6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=2j1k6udki+IUT8t4y+SO0EekjaGf0Ggc9U0FBMw0ySM=;
        b=NA7iuhuKmZAl4ctCqX6RiGT6aYv9sLhamBOFw9m/nUR0+E6Xji73VHXpfURd1X3hJP
         KdMH7ksWeIeQnoVxV06rg3O04d8doT2rLzZLYgDGbSOZCNpS8Urz+yVf5y7U7PaLh9Rc
         q/7Q8KROFN//eo+GEHFCh2dk6ZAhtYL3i2ekt55gEssD9GPtjkRkV8e0BR8Vwx4xSBxn
         JOoTfQ7ebXcavcST6YjDVjp2bkeLqRME0clrtS8ndTvoZay7v2QToLKce+90jpRo5FQe
         hqcKPw07bMA9bLtZvLG0xbN9mUE0qdHBfRxxzl22V5bMyBY+2yHP75MSrIquG/Y8uhe8
         Qh/g==
X-Gm-Message-State: AOAM530bNF8FUXWxQZal0evGNJKqkZDsNPywaRYBcDTsShm3QLigiJRb
        Scw6O9r2dVPPYcSejkk8JCnHHB8JZFY=
X-Google-Smtp-Source: ABdhPJzZ3/dfijcnSnsZpDbkM/7YLq9X02KkBhhNGlxjHdwsJHVJ2CrhPH6ylMaFsWRkT2ZebwgZCQ==
X-Received: by 2002:a05:6a00:1515:b0:4f7:6d54:6224 with SMTP id q21-20020a056a00151500b004f76d546224mr31242895pfu.4.1647403147904;
        Tue, 15 Mar 2022 20:59:07 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s8-20020a056a0008c800b004f664655937sm727103pfu.157.2022.03.15.20.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 20:59:07 -0700 (PDT)
Message-ID: <6231608b.1c69fb81.961b0.2e1a@mx.google.com>
X-Google-Original-Message-ID: <20220316035905.GA2127127@cgel.zte@gmail.com>
Date:   Wed, 16 Mar 2022 03:59:05 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: remove PSI annotations from submit_bio
References: <20220309094323.2082884-1-yang.yang29@zte.com.cn>
 <Yij9eygSYy5MSIA0@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yij9eygSYy5MSIA0@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 09, 2022 at 02:18:19PM -0500, Johannes Weiner wrote:
> On Wed, Mar 09, 2022 at 09:43:24AM +0000, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > psi tracks the time spent submitting the IO of refaulting pages[1].
> > But after we tracks refault stalls from swap_readpage[2][3], there
> > is no need to do so anymore. Since swap_readpage already includes
> > IO submitting time.
> > 
> > [1] commit b8e24a9300b0 ("block: annotate refault stalls from IO submission")
> > [2] commit 937790699be9 ("mm/page_io.c: annotate refault stalls from swap_readpage")
> > [3] commit 2b413a1a728f ("mm: page_io: fix psi memory pressure error on cold swapins")
> > 
> > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> It's still needed by file cache refaults!
> 
> NAK
What about submit_bio() only counts file cache refaults?
This will reduce redundant calling of psi_memstall_enter()
for swap_readpage().
