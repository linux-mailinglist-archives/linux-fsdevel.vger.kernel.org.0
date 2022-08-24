Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8659F2C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 06:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiHXEm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 00:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiHXEm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 00:42:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720248C476;
        Tue, 23 Aug 2022 21:42:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w29so9832583pfj.3;
        Tue, 23 Aug 2022 21:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ocxT1JDH7H0ayD0p5Sl9WUobRg+2sXtb14mCi8PzQ8w=;
        b=axccxcBG8/CAMaLGLSv268V8rfdZWKaDj95406vRQRgAQhNOZPt1wT0SBBCyT0YmoB
         bd6LfEGWvD/4FH8UTO4lin1REhLHhla15pIKDjZM+eODuQr2DCjZ2NZmkQAD9rLFlhYD
         PoKSL/vFJsi2X7uxUw79KDfis5i3leyqV4iN9iXvT3X2KpNtLSg0gAoRcJroUJedjH1z
         7Womim6DlC/hrp2L41vfvEpZMM0Fd0HPW7Fiy7Km2It9662JboNC+sLk0jC8BBU5fAlr
         5Yaxk6AVDqzOoiuRq4M11bdhhZUqDB9z6U5ZQpnbA23tvckBEHyAofPoZGjs/EZBdZwF
         EdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ocxT1JDH7H0ayD0p5Sl9WUobRg+2sXtb14mCi8PzQ8w=;
        b=NDWSEQmqtGdSPWrifHYLSaiU2kdJ5rUErqIGyFvPEoSvXEh5fQmb9DFZ9pzJQ4mVBO
         tnCjzwftKB1tnitekhmYJDMnGqOWaE+WCtvJD2MzKfQ1pJCC3Bkwwc3Ac2AjjHL6aRDF
         xPpU+/sIWhzfNrppJZByTBkB74Av2NfLfNUwzO7goitvXvjyPoCXZ3QnzQ2/OOSCUfpO
         8/Qzy/s7GCQViCW2glvt9DVXTqrcbbtbKCGEeazHMMNnp70guZuRKTPzUtoJmiOv5fSn
         obr90aisNWjchCQtMPqIC0Hs3dYVAsv8jwatlM9E0v8oxZ1G102hkIOpp2xLZzd4nnRb
         60lQ==
X-Gm-Message-State: ACgBeo1IgCHwWMxRdRfKsLKdrqc9Hml4EM1FA2exnM7sev82FyVbA8Ur
        Yo2dSZA+JOlWsObTv0dEWFM=
X-Google-Smtp-Source: AA6agR5Sn4qcNQPF8JA9bDbZ4W3bArYh5fq/M2t1WkLaKzSjjkZzIpEDD/YJt9wjurvSIsGwfDSROQ==
X-Received: by 2002:a05:6a00:10ca:b0:536:ec31:827c with SMTP id d10-20020a056a0010ca00b00536ec31827cmr7336655pfu.67.1661316145858;
        Tue, 23 Aug 2022 21:42:25 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-51.three.co.id. [116.206.12.51])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b00172897952a0sm11460568plh.283.2022.08.23.21.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 21:42:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 995C9103D8E; Wed, 24 Aug 2022 11:42:22 +0700 (WIB)
Date:   Wed, 24 Aug 2022 11:42:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     xu xin <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        willy@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH v2 1/2] ksm: count allocated ksm rmap_items for each
 process
Message-ID: <YwWsLqYbl20pYg8N@debian.me>
References: <20220824040036.215002-1-xu.xin16@zte.com.cn>
 <20220824040153.215059-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220824040153.215059-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 24, 2022 at 04:01:53AM +0000, xu xin wrote:
> KSM can save memory by merging identical pages, but also can consume
> additional memory, because it needs to generate rmap_items to save
> each scanned page's brief rmap information. Some of these pages may
> be merged, but some may not be abled to be merged after being checked
> several times, which are unprofitable memory consumed.
> 
> The information about whether KSM save memory or consume memory in
> system-wide range can be determined by the comprehensive calculation
> of pages_sharing, pages_shared, pages_unshared and pages_volatile.
> A simple approximate calculation:
> 
> 	profit =~ pages_sharing * sizeof(page) - (all_rmap_items) *
> 	         sizeof(rmap_item);
> 
> where all_rmap_items equals to the sum of pages_sharing, pages_shared,
> pages_unshared and pages_volatile.
> 
> But we cannot calculate this kind of ksm profit inner single-process wide
> because the information of ksm rmap_item's number of a process is lacked.
> For user applications, if this kind of information could be obtained,
> it helps upper users know how beneficial the ksm-policy (like madvise)
> they are using brings, and then optimize their app code. For example,
> one application madvise 1000 pages as MERGEABLE, while only a few pages
> are really merged, then it's not cost-efficient.
> 
> So we add a new interface /proc/<pid>/ksm_rmp_items for each process to
> indicate the total allocated ksm rmap_items of this process. Similarly,
> we can calculate the ksm profit approximately for a single-process by:
> 
> 	profit =~ ksm_merging_pages * sizeof(page) - ksm_rmp_items *
> 		 sizeof(rmap_item);
> 
> where ksm_merging_pages and ksm_rmp_items are both under /proc/<pid>/.
> 

Hmm...

I can't apply this patch on linux-next. On what commit this patch series
is based on?

When submitting patches, don't forget to include --base to git
format-patch.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
