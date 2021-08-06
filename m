Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2A33E2729
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 11:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244484AbhHFJXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 05:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbhHFJXM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:23:12 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A09C061798;
        Fri,  6 Aug 2021 02:22:55 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id az7so9194693qkb.5;
        Fri, 06 Aug 2021 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=CMsmmLe070UmWwr4znuaFaK+prUVayJ14rPFcIrKVzs=;
        b=NGkl4Dl/yMygd8Y2VWGA2keG/LEtrEGfTiP/5VZ9bFG2f7ETuV3fS1hVEJyUUxzxsy
         /dQgjVennMhknl4yNtbIa4kBL4SWuxiqac2KA71a6KQDbTBu85cCZ1UdLt8/kwK5MlmU
         76N9Js/SAt6sAa7g4LCBttRWSvBRRT2X9AM+2C2VPxCZeirDVqaNvwWIulMD97z1mOdo
         qsFeOhaw8ExrvKdnTR8ucXoCDefrhHjx3ZVAUEVwN6lOkMQ1w/L8zuTwVWBU8qbiA+RB
         LEoPmov53nQudg5+l0rMr6CeJuQiDPi9oX5KxMqBJPLqUkCOvNsmIUfTt/elpEIFTG+a
         t6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=CMsmmLe070UmWwr4znuaFaK+prUVayJ14rPFcIrKVzs=;
        b=ZideW9ZhmRgrM5hsrvyb9dapPo4AdnMhGKCxNyhmIjWkCGd0FoZ8E2/lQ8wQuo/21T
         AzVQOzOg5VnfRLApe/AE/juO0/ISJJgotObR6i2R85ggUpkwGT7yqrd0a+CAoN6cId14
         qh9JPtyi1QQgcp5K56zgvB9SzyGdk/PGEFsQuLyv1TYVQtDeTjAnKjny763ZHz+DNRcs
         ujOgQyskk1zRAjDPIxpAWQ8nyBKECqa63omZm78yhzlLwASxD7QqnxAXnJYMLeDuhXCp
         yj1muQq5k5C1tdZC3XNbEqikqEtZjUVOb7fmrcOIDS5k5peSVBxVKHnaKFKD7P+EyuHi
         IVqw==
X-Gm-Message-State: AOAM5335KnFWzMs/q2i+6idNTLZVR5gpQPb88Z9NSCDaMBRpaAxS6gxu
        S5hweIL1unZUBs5414zwN5FjP4+Puro=
X-Google-Smtp-Source: ABdhPJyrme3xLBPC4a8NUEb8cvLc9wRMeNJl6RI/6UaUHnI853QRF1eczjBxoNx6PBui3Pr6t4I0ww==
X-Received: by 2002:ae9:f005:: with SMTP id l5mr1738905qkg.355.1628241775125;
        Fri, 06 Aug 2021 02:22:55 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id r202sm2106039qke.45.2021.08.06.02.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 02:22:54 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: mmotm 2021-08-05-19-46 uploaded (mm/filemap.c)
Date:   Fri,  6 Aug 2021 09:22:46 +0000
Message-Id: <20210806092246.30301-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <43bf8d13-505c-35b3-c865-a62bdcbafcf8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello Randy,

On Thu, 5 Aug 2021 22:00:11 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

[...]
> 
> on i386, I am seeing lots of build errors due to references to
> some PAGE_ flags that are only defined for 64BIT:
> 
> In file included from ../mm/filemap.c:44:0:
> ../include/linux/page_idle.h: In function ‘folio_test_young’:
> ../include/linux/page_idle.h:25:18: error: ‘PAGE_EXT_YOUNG’ undeclared (first use in this function); did you mean ‘PAGEOUTRUN’?
>    return test_bit(PAGE_EXT_YOUNG, &page_ext->flags);
>                    ^~~~~~~~~~~~~~
>                    PAGEOUTRUN
[...]
> 
> See:
> --- a/include/linux/page_ext.h~mm-idle_page_tracking-make-pg_idle-reusable
> +++ a/include/linux/page_ext.h
> @@ -19,7 +19,7 @@ struct page_ext_operations {
>   enum page_ext_flags {
>   	PAGE_EXT_OWNER,
>   	PAGE_EXT_OWNER_ALLOCATED,
> -#if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
> +#if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
>   	PAGE_EXT_YOUNG,
>   	PAGE_EXT_IDLE,
>   #endif

Thanks for this report!  However, the flag is not defined for only-64BIT but
none-64BIT.

'enum page_ext_flags' is defined when 'CONFIG_PAGE_EXTENSION' is set.  It is
automatically set for non-64BIT when 'CONFIG_IDLE_PAGE_TRACKING' or
'CONFIG_DAMON_VADDR' is set.  However, 'CONFIG_PAGE_IDLE_FLAG' doesn't.  So, if
'CONFIG_PAGE_IDLE_FLAG' is set but 'CONFIG_PAGE_EXTENSION' is not, this issue
can be reproduced.

I was able to reproduce this issue with:

    make ARCH=i386 allnoconfig
    echo 'CONFIG_PAGE_IDLE_FLAG=y' >> .config
    make olddefconfig
    make ARCH=i386

And, confirmed below change fixes it.

--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -741,6 +741,7 @@ config DEFERRED_STRUCT_PAGE_INIT
 
 config PAGE_IDLE_FLAG
 	bool "Add PG_idle and PG_young flags"
+	select PAGE_EXTENSION if !64BIT
 	help
 	  This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
 	  Accessed bit writers can set the state of the bit in the flags to let

Also, below change would make more sense:

@@ -749,7 +750,6 @@ config PAGE_IDLE_FLAG
 config IDLE_PAGE_TRACKING
 	bool "Enable idle page tracking"
 	depends on SYSFS && MMU && BROKEN
-	select PAGE_EXTENSION if !64BIT
 	select PAGE_IDLE_FLAG
 	help
 	  This feature allows to estimate the amount of user pages that have
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 455995152697..37024798a97c 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -27,7 +27,6 @@ config DAMON_KUNIT_TEST
 config DAMON_VADDR
 	bool "Data access monitoring primitives for virtual address spaces"
 	depends on DAMON && MMU
-	select PAGE_EXTENSION if !64BIT
 	select PAGE_IDLE_FLAG
 	help
 	  This builds the default data access monitoring primitives for DAMON

I will format these as patches and post soon.


Thanks,
SeongJae Park

> 
> 
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
