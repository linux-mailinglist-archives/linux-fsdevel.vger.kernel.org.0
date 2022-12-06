Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777C66447D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 16:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiLFPTq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 10:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiLFPT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:19:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EE12FFDB;
        Tue,  6 Dec 2022 07:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RX+gBtNPo0jox8vOogdECCX3Yny3klvQJhbz+8vpSmw=; b=UEDwqfA57XHr3+ZjFgxt5TmyJz
        N4q15ZvYDY266he684LdAuLiTjEytLSmqTEdPAduFW3l6WT9uWVWEXpbZotSMuOupZOaP16dEtDqa
        hLB47BWW0T6mWIMDiS51Us0womBC7SIBBJScbnYK/zaL2JeLiVyez52wcJFpcDuLPvvfD07sicNAt
        meS/eeZXf4v9sJVJ+VTja8MunYSKYUF28l01sXo8oaxtr0PLcN5fW3p0LGs9Do1o/On0Wj5fxnq8e
        CsBIB5m95Nj3fTfzxceX/Bi75d/oURKGhavnuMTqnY7tKnYAb8DbrUk3GuRJvO1Yf14dtNSeDzrOG
        jGMdMgIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2ZhH-004XwD-DE; Tue, 06 Dec 2022 15:17:27 +0000
Date:   Tue, 6 Dec 2022 15:17:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     kernel test robot <lkp@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH v2] hfsplus: Add module parameter to enable force writes
Message-ID: <Y49dBzDtwy83+yRT@casper.infradead.org>
References: <79C58B25-8ECF-432B-AE90-2194921DB797@live.com>
 <202212040836.kykb1foO-lkp@intel.com>
 <E3567E25-C2EE-4DA3-AAFD-2833E15A98B9@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E3567E25-C2EE-4DA3-AAFD-2833E15A98B9@live.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 04, 2022 at 06:43:43AM +0000, Aditya Garg wrote:
> 
> 
> > On 04-Dec-2022, at 6:35 AM, kernel test robot <lkp@intel.com> wrote:
> > 
> > Hi Aditya,
> > 
> > Thank you for the patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on akpm-mm/mm-everything]
> > [also build test WARNING on linus/master v6.1-rc7 next-20221202]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Garg/hfsplus-Add-module-parameter-to-enable-force-writes/20221203-151143
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > patch link:    https://lore.kernel.org/r/79C58B25-8ECF-432B-AE90-2194921DB797%40live.com
> > patch subject: [PATCH v2] hfsplus: Add module parameter to enable force writes
> > reproduce:
> >        # https://github.com/intel-lab-lkp/linux/commit/dfb483e3c16e562d768f9bddc63252f1cccb0275
> >        git remote add linux-review https://github.com/intel-lab-lkp/linux
> >        git fetch --no-tags linux-review Aditya-Garg/hfsplus-Add-module-parameter-to-enable-force-writes/20221203-151143
> >        git checkout dfb483e3c16e562d768f9bddc63252f1cccb0275
> >        make menuconfig
> >        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
> >        make htmldocs
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >>> Documentation/filesystems/hfsplus.rst:65: WARNING: Unexpected indentation.
> > 
> 
> Do I need to fix this or should I consider it as a false positive?

Your patch creates the warning, so yes you need to fix it.
