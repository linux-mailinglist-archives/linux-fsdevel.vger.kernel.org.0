Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0594B012F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 00:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiBIX1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 18:27:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiBIX1M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:27:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDD0E099842;
        Wed,  9 Feb 2022 15:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ynnTgMbvVWKSQsVfOzStHfFke6XshJTpmNm3xJzH+X4=; b=agGMeBIMJH3voNdaZyCkkDK2nE
        y/fkwVRTl+WQ4JkL2hgjQW8mEWUM/nAQvcxTCRu+xdOvoxrOR1vMEecb6rWi+pV1nOzDIQnhHqckz
        fluSdwbPkxdXNhsTwR+yDh6Ahni7JE6WXc90FFZJe5Uyxm40oOPYwC51Cptfy1XLTEBpsqXjWw5ZC
        Oi5GT26aA9QST92vo84PMCWZBXKqZqfW2EO4ebbcByT8pWo349UCk7GPGjBwPsdnr06K2wbUGYERo
        omQ5/lq0yqpHRHJHJZAWHLx4DhNaIXsMzk3XEyH4ZKxdJ1/02D3YhuCzWUgWjcURKWBSC584bK33y
        JcYqbBPQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHwMI-0022sc-Fn; Wed, 09 Feb 2022 23:26:46 +0000
Date:   Wed, 9 Feb 2022 15:26:46 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhen Ni <nizhen@uniontech.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched: move energy_aware sysctls to topology.c
Message-ID: <YgRNtm0sxfnW9bB0@bombadil.infradead.org>
References: <20220209013444.9522-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209013444.9522-1-nizhen@uniontech.com>
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

On Wed, Feb 09, 2022 at 09:34:44AM +0800, Zhen Ni wrote:
> move energy_aware sysctls to topology.c and use the new
> register_sysctl_init() to register the sysctl interface.
> 
> Signed-off-by: Zhen Ni <nizhen@uniontech.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
