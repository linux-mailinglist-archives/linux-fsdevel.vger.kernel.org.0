Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6CE4B15BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 20:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbiBJTCb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 14:02:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiBJTCa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:02:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A689310B7;
        Thu, 10 Feb 2022 11:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V52I0DAAX6dK6jU5ZQnW77DWoP+74i7YLOYDRfZ7xfg=; b=SBeXG6y7UHu3bmflQARvf/COca
        PTtDYV3rZzXz3F8hO1BgtSGNhydwz7yRwzCQJpJxUHzP1/HCDmMHNrJOx7hdhFUDwjdzaxO0pzHhq
        RkV+r2ecEDIzdoBfytSNri/mng6bNbvvkJxq58H9y41owGzFV1pLSDC7GMmgDbN2Bwt2IBGlqqv+I
        0UBteM1W5lj7Ks8kF8iwwNmA73iku8RrSCtASh1fYmZm3pEz0spuNSAdPc22UrP536tJsk2kKYCy0
        R0KjmJMFOdGOBh5PWXm5S2akpq1W/kZaEquaxEx+rY7GglNBcZF2jT0x872a5smvdCBUnCiJq0Rdl
        /m9C9VkA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIEi1-004iKF-5D; Thu, 10 Feb 2022 19:02:25 +0000
Date:   Thu, 10 Feb 2022 11:02:25 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhen Ni <nizhen@uniontech.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched: move rt_period/runtime sysctls to rt.c
Message-ID: <YgVhQZQ1LayVcWFi@bombadil.infradead.org>
References: <20220210012030.8813-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210012030.8813-1-nizhen@uniontech.com>
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

On Thu, Feb 10, 2022 at 09:20:30AM +0800, Zhen Ni wrote:
> move rt_period/runtime sysctls to rt.c and use the new
> register_sysctl_init() to register the sysctl interface.
> 
> Signed-off-by: Zhen Ni <nizhen@uniontech.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
