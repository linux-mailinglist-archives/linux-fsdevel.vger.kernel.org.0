Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645F3631949
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 05:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKUE6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 23:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUE6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:58:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93567175A5;
        Sun, 20 Nov 2022 20:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=Cyzrg4NUx+C8AVwO8MTBK2ejjwtBd3UCLk4yw74Afy0=; b=u1LHi+NFCxDkLv3NvMHFFPNw6M
        trjfDEJBNLTefMSN41xusn/bedpQU/JQ50euWLpLq/XtnulEXwqtGcVTcDqAoGpYHv3W8X3zKxaVj
        wdjwPp33RJ5zmohJe+L9g0lgGOB5klRIeaPRaHrw/Hqc6CEFQpKzMStjo5IrFo9Hgdl+zQD2gVmlX
        pw8dDWE+n013GSTIv1yeqMLPwc7yo5FIuW5mQvJjQ+d+1FdDjKpgpYoL2FNXz/b3MHBs+DvKGRfTb
        ArVOGzJ+X/zvMzc7fQLreOJVNN6608ifYi+Ct0l7IbwyMwXHSGPwSiJZPg0/akbhEubxGMvH2P3eD
        zPQm8/nw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owysh-009RTE-DY; Mon, 21 Nov 2022 04:58:07 +0000
Date:   Sun, 20 Nov 2022 20:58:07 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sched: Move numa_balancing sysctls to its own file
Message-ID: <Y3sFX1W811zz4YIW@bombadil.infradead.org>
References: <20220908072531.87916-1-wangkefeng.wang@huawei.com>
 <YxqDa+WALRr8L7Q8@bombadil.infradead.org>
 <679d8f0c-f8cc-d43e-5467-c32a78bcb850@huawei.com>
 <d99630ed-0753-da9e-ab03-848b66bc3c63@huawei.com>
 <YxuXqF63RIMstdEN@bombadil.infradead.org>
 <c97d4819-a1aa-b8ad-523a-d60cf3a149fb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c97d4819-a1aa-b8ad-523a-d60cf3a149fb@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:09:27AM +0800, Kefeng Wang wrote:
> Hi Luis and Andrew，
> 
> As the c6833e10008f （"memory tiering: rate limit NUMA migration
> throughput"),
> could
> 
> anyone help to pick it up, thanks.

Queued up now on sysctl-next, thanks!

BTW if you do the cleanup on kernel/sysctl.c for the rest of CONFIG_NUMA
It would be appreciated. :)

  Luis
