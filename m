Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7982C50EAF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 23:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbiDYVF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDYVF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:05:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3CC31517;
        Mon, 25 Apr 2022 14:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PfGioTml6cPmh6VyXoKsJCpmQbsB8e94rK/d9pVoUOw=; b=xpOjU/FnS6ikJxzvK26UGQ5Jr7
        aYOiQtxxfdIxlt6Sq2mU3POd4w3RO1QUnceUF9Hqi7BUB3+c4D5qoAtmo+kmv1d946951/vvLNkdC
        ZCSOuPqJs/sM5bJuK7vBzVW2OPhW9yy8mTVfkOx/pTCmn4EOPh7Yf9ZgX0mAqY9jJ4jOlt3kxPq5y
        mmUMV3jr9rlavGzu0krLrf8vQmw58atOoQs7Zu9YdFEAdpQ4n0fUgjoHUmyzPEvqlKwYwMImvz3oO
        7HFGbjftrx39lbP799mslmLNAI9DVSzfsoyrvQD6SqolZrBNlgDtdjvh6SodE2hOKv0oWIJNGmLPU
        amOFLMmQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj5qM-00BRiA-B9; Mon, 25 Apr 2022 21:02:02 +0000
Date:   Mon, 25 Apr 2022 14:02:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     yingelin <yingelin@huawei.com>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjianguo3@huawei.com,
        nixiaoming@huawei.com, qiuguorui1@huawei.com,
        young.liuyang@huawei.com, zengweilin@huawei.com
Subject: Re: [PATCH sysctl-testing v2] kernel/kexec_core: move kexec_core
 sysctls into its own file
Message-ID: <YmcMSkI8ea/Ncz4y@bombadil.infradead.org>
References: <20220424025740.50371-1-yingelin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424025740.50371-1-yingelin@huawei.com>
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

On Sun, Apr 24, 2022 at 10:57:40AM +0800, yingelin wrote:
> This move the kernel/kexec_core.c respective sysctls to its own file.
> 
> kernel/sysctl.c has grown to an insane mess, We move sysctls to places
> where features actually belong to improve the readability and reduce
> merge conflicts. At the same time, the proc-sysctl maintainers can easily
> care about the core logic other than the sysctl knobs added for some feature.
> 
> We already moved all filesystem sysctls out. This patch is part of the effort
> to move kexec related sysctls out.
> 
> Signed-off-by: yingelin <yingelin@huawei.com>

Thanks! Queued onto sysctl-testing.

  Luis
