Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9326C4ED428
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 08:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiCaGw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 02:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiCaGwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:52:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C462496B9;
        Wed, 30 Mar 2022 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=DRge7l3ttZrXWScsHhhl5X1CTJgtzPSv3mBORS3+N6Q=; b=vd1kfE2Ptip72ppeYspJnEo9a6
        hhO/7mmfOkA8hH05g2dQ2dNGNl00RBwKtO+WOeclt33lqQc+HRE6duoL3fqqwCPceBE4vZ0Udz2ZL
        QMTVKj35tNFPDxTxShy6Yewh2CPv+Ki7p24CKrDNdkTJhtq0EfK3drpkNyx6ADGym9gSpS8MakC7d
        X6ISTNuS3KOumgIE9sp1F34vryrfJ+saqQ6ckNV8UgwRwBuBfrHpg+WrB8JyZDeW/AB85fS26aoOO
        tWg9PpuXkI+bTl7OO+MOPjUUQHPiiPviKW+cZQgM/0Crb0UsmbkDSJhrdRCNIU1VFWg9xcz2/FyX5
        SxpxiEjg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZodZ-001zER-BF; Thu, 31 Mar 2022 06:50:29 +0000
Message-ID: <8d27a9f5-047b-05d5-3594-a51cef06222c@infradead.org>
Date:   Wed, 30 Mar 2022 23:50:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: mmotm 2022-03-30-13-01 uploaded (kernel/sched/ and sysctls)
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220330200158.2F031C340EC@smtp.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220330200158.2F031C340EC@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis-

On 3/30/22 13:01, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2022-03-30-13-01 has been uploaded to
> 
>    https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series


# CONFIG_SYSCTL is not set
# CONFIG_PROC_SYSCTL is not set

In file included from ../kernel/sched/build_policy.c:43:0:
../kernel/sched/rt.c:3017:12: warning: ‘sched_rr_handler’ defined but not used [-Wunused-function]
 static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
            ^~~~~~~~~~~~~~~~
../kernel/sched/rt.c:2978:12: warning: ‘sched_rt_handler’ defined but not used [-Wunused-function]
 static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
            ^~~~~~~~~~~~~~~~


This was also reported on Feb.22/2022:
  https://lore.kernel.org/all/fbfc360c-d68f-d83b-5124-d6d930235b8c@infradead.org/

and by Baisong Zhong <zhongbaisong@huawei.com>
on Mar.17/2022.

-- 
~Randy
