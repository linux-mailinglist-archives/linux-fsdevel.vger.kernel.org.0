Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52394B012B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 00:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiBIXYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 18:24:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiBIXYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:24:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACAFE063CBD;
        Wed,  9 Feb 2022 15:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Pq4lD97wSPgECMASLnxXwdZR4jJ5DAurzkL++zwWvs=; b=A0YENrCYmrNfAeKw6fdlnc45+n
        D0XskxEffFmlqxXgr1l1AbN0fTCH1L+h/LJZYHMclbmrwNM9OuTMdSeraqmvJGZdH5ihOv3KY09qQ
        x+Yx+84WH8b/3nnUZli5eWRj5ADSz0XCzsw+4dOkc/au2sl9zj1Z24USpi+LiI8ckkY4YFFt1qqk2
        77ARlCh9jRkYJJ7LRaaCD02zi/qp3/NqYZdHVsLC3AeX8Pv7S9mekHYnMBsJ12z2hkRC5YYt2ax+4
        4c9jujeibZZnOrWd/xUFNFcSlZHvV9hMgy1LWUW8JS7G8tXOemR2SSgdX+Vm+iPkQBtvjvjhP0UQD
        l8UrWWvA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHwJm-0022mj-GG; Wed, 09 Feb 2022 23:24:10 +0000
Date:   Wed, 9 Feb 2022 15:24:10 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhen Ni <nizhen@uniontech.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched: move cfs_bandwidth_slice sysctls to fair.c
Message-ID: <YgRNGs1SeZMvfLqj@bombadil.infradead.org>
References: <20220209013020.1420-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209013020.1420-1-nizhen@uniontech.com>
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

On Wed, Feb 09, 2022 at 09:30:20AM +0800, Zhen Ni wrote:
> move cfs_bandwidth_slice sysctls to fair.c and use the
> new register_sysctl_init() to register the sysctl interface.
> 
> Signed-off-by: Zhen Ni <nizhen@uniontech.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
