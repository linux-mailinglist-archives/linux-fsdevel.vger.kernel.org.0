Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D4C4F6DE5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 00:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiDFWl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 18:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiDFWlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:41:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC378A88AD;
        Wed,  6 Apr 2022 15:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=idC6pWqopksYm3NGMnw9eBdiv+RE1amfMyzk2187tLE=; b=WgwbXRyfvz5QsQmPVdpFr7wl2M
        dJwhAVrsEtq228j5L1Fi/GKKwIgeJegiDDf1lPOrU4CSKK7WvkGaK7dgB/cspm4VLkZaE0R1Xoux1
        0C4mEDoM6yN0lKSujNNU8nOZtJsrRJlam15SNyvmZge+lqBLO2Xe4ZobOLCokJvzVJ7oadeT5uvL7
        psLIIcngozql9DOGaDV7tFvWffFM0f3MKXoXwgv4Jo3VBKDfNQ0nDr+hAHC5Mc528i+1bXVlgHQKE
        P0Fy2H0aTJcDdMwBNuixJqz4I5/rIFH7wji8l/GGZZUy5ynY/2LurjqJ1unK/3teqptGIhEld2gL7
        RsQxWmuQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncEJb-0089XL-4k; Wed, 06 Apr 2022 22:39:51 +0000
Date:   Wed, 6 Apr 2022 15:39:51 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Liao Hua <liaohua4@huawei.com>
Cc:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangfangpeng1@huawei.com
Subject: Re: [PATCH sysctl-next v2] latencytop: move sysctl to its own file
Message-ID: <Yk4Wt4sVICvW+ksa@bombadil.infradead.org>
References: <20220223094710.103378-1-liaohua4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223094710.103378-1-liaohua4@huawei.com>
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

On Wed, Feb 23, 2022 at 05:47:10PM +0800, Liao Hua wrote:
> From: liaohua <liaohua4@huawei.com>
> 
> This moves latencytop sysctl to kernel/latencytop.c
> 
> Signed-off-by: liaohua <liaohua4@huawei.com>

Please base your patch on the latest sysctl-next and resubmit.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next

  Luis
