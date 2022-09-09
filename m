Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE45B2AC1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 02:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIIAGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 20:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIIAGU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:06:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10F610D73A;
        Thu,  8 Sep 2022 17:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iPJz2Pig1hAg9smj9divRwadF1JoDkJDa+bzZ0lcohU=; b=oQP3Lx6ZxC4IhtdjWdMY7/BycT
        OP3S12jlxmujvpFwaDlcrUQNnUIPqA5/0OBzMtJgtL7DYQUj5W9zkh2Y0+ww75s7TtBnss7zPLu7r
        0psnR5KdapMmREBKAgu0N09G00P8ym6tpArsViTh26i05IVSKR5q5SpNkL8/rIT8KENZJkU9R/QId
        RvIykvUeoqmYlNfIoN8vpc0rOJkntaZeGsutmMs0FfYmUNUNUHy3CM+7am2iEeDoVw0Lak27YrYnt
        63FSkYE5bHjisA12KjM2NUW8/SACxUJo1Platj1yVF5ZxWrSZnaEwLSePKpkIepx9TbCKbp4gIWlG
        n1hX4cXw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWRX1-00A7ZR-On; Fri, 09 Sep 2022 00:06:03 +0000
Date:   Thu, 8 Sep 2022 17:06:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched: Move numa_balancing sysctls to its own file
Message-ID: <YxqDa+WALRr8L7Q8@bombadil.infradead.org>
References: <20220908072531.87916-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908072531.87916-1-wangkefeng.wang@huawei.com>
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

On Thu, Sep 08, 2022 at 03:25:31PM +0800, Kefeng Wang wrote:
> The sysctl_numa_balancing_promote_rate_limit and sysctl_numa_balancing
> are part of sched, move them to its own file.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

There is quite a bit of random cleanup on each kernel release
for sysctls to do things like what you just did. Because of this it has its
own tree to help avoid conflicts. Can you base your patches on the
sysctl-testing branch here and re-submit:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing

If testing goes fine, then I'd move this to sysctl-next which linux-next
picks up for yet more testing.

Are scheduling folks OK with this patch and me picking it up on the
sysctl-next tree if all tests are a go?

  Luis
