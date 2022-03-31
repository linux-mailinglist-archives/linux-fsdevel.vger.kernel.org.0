Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A944D4EE48F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 01:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbiCaXQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 19:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbiCaXQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:16:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FB524CEE2;
        Thu, 31 Mar 2022 16:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=vSuDqO1mBWaRpB9pMyPQmfeFPj52J4m6p+U+XX+jzGk=; b=z/+63mxYdii+hr9hKP7wTPDhLi
        shZ57JUlb8IsF0nNtcU4ki81rNDpAONMfizJYx1ZdWJ5dFO9rCUlaW9WJxiGxh6/ASs/iwuEwPtMM
        oTqFWEq4Rv5RmnXNLGH7WoG3v7uTsoYcxYAOtoinLtGHg279YK1GtzzJ9VYrpnfJSP/DcwjO/T8Ht
        BilpOy/6iVOK1fvKuSzej9ZhFvTlld2/8mTNgh95avoCoDGdLJU4U29+DasDgoE0Eu61XYPmolXx8
        /a76e6PMhK3zK6D1cmGRXNZkjUnhOvVTjHjND9shYBcTOreN4FupP/j81i3mjYGJt0+T0/wzekcMN
        OrtTLTvw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1na3zc-003vkn-Ud; Thu, 31 Mar 2022 23:14:16 +0000
Date:   Thu, 31 Mar 2022 16:14:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: Re: mmotm 2022-03-30-13-01 uploaded (kernel/sched/ and sysctls)
Message-ID: <YkY1yNjfdT3E4iiG@bombadil.infradead.org>
References: <20220330200158.2F031C340EC@smtp.kernel.org>
 <8d27a9f5-047b-05d5-3594-a51cef06222c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d27a9f5-047b-05d5-3594-a51cef06222c@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:50:23PM -0700, Randy Dunlap wrote:
> Luis-
> 
> On 3/30/22 13:01, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2022-03-30-13-01 has been uploaded to
> > 
> >    https://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > https://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > https://ozlabs.org/~akpm/mmotm/series
> 
> 
> # CONFIG_SYSCTL is not set
> # CONFIG_PROC_SYSCTL is not set
> 
> In file included from ../kernel/sched/build_policy.c:43:0:
> ../kernel/sched/rt.c:3017:12: warning: ‘sched_rr_handler’ defined but not used [-Wunused-function]
>  static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
>             ^~~~~~~~~~~~~~~~
> ../kernel/sched/rt.c:2978:12: warning: ‘sched_rt_handler’ defined but not used [-Wunused-function]
>  static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
>             ^~~~~~~~~~~~~~~~
> 
> 
> This was also reported on Feb.22/2022:
>   https://lore.kernel.org/all/fbfc360c-d68f-d83b-5124-d6d930235b8c@infradead.org/

Yes, I'm on it, thanks!

 Luis
