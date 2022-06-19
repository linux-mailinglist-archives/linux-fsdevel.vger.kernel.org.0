Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5104C550BEB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 17:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiFSPtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 11:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFSPtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:49:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A82BC8C
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U92yyUeaEbPUkRlwQXr365y8ttWAXDyeFeYfGpCoh9Q=; b=v7z1GZoGlNpMxL/e/m6B4W2GT3
        tVXBNkFNHT/T2msWOAkQpeVsPV/9t6J8rX+QO38uIgYBxm9GgC8uEyg1totX1RaGn5g+xKQOPAI/0
        atsWSgow5IoHlbHxMjtLedsv51ilU3DP6wuBQ1OrY0L7Ths8sQALD25oxb2SUAvrFCvXqgUfuTiPo
        YflbgVRrlsr/h96X4Eur5mom3qQpYCffehhP1WiRdhvPYlbxGn2cT6kLRUynca7CtxPwU8Jy66XGu
        pDUA82iqsUZzM45EIZv+MTewQaGGM00wXZTAD2cBbzMCiZNlzv7x5Kxsdy6TFnYLFNe9B9nbJ8Frv
        yR3tCZdA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2xAU-0026H6-52;
        Sun, 19 Jun 2022 15:48:54 +0000
Date:   Sun, 19 Jun 2022 16:48:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.iov_iter_get_pages 24/33] lib/iov_iter.c:1295
 iter_xarray_get_pages() warn: unsigned 'count' is never less than zero.
Message-ID: <Yq9FZnyna9BiwzDK@ZenIV>
References: <202206192306.POJg04ej-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206192306.POJg04ej-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 19, 2022 at 11:40:37PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter_get_pages
> head:   fe8e2809c7db0ec65403b31b50906f3f481a9b10
> commit: e64d637d648390e4ac0643747ae174c3be15f243 [24/33] iov_iter: saner helper for page array allocation
> config: mips-randconfig-m031-20220619 (https://download.01.org/0day-ci/archive/20220619/202206192306.POJg04ej-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> lib/iov_iter.c:1295 iter_xarray_get_pages() warn: unsigned 'count' is never less than zero.

Joy...  Should've been int all along, obviously (pgoff_t for number of array
elements?)
