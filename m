Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAA85B2AB3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 01:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIHX7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 19:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIHX7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:59:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43732100420;
        Thu,  8 Sep 2022 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AUDBarZI07DgR4Zlpi/s24TYXEza/zI6g7WZ55XKIw8=; b=1eAZrt3nkACHlOToVGoHvBOwRg
        GS8pxpXRKluhuEpsYwxdHAqWK6Bs6D5CJgf943aeWz7FxSyFeYSEJLApfbtyPKrsu8r4S4vyzAPm6
        FfxmhfGagjzZV7sTzPYqZWGGW1Fckl6zl8TfIXLqEvhdT+ytpIaRPXHaBTpr/wPdJ/p43hGu2Pgkm
        KSnnCgqfeI0mDJFJCWK9e3VaBHogsTriI54+sJ2g9YzSpBLEmN5ni33mnJkFpRJjE1BPNx21I+AaB
        +YDhzzzNBhNaM+7S2JOOBUPZ1zaMyFT5X5aQpr15kn/gy/8HKJqHH4H1VauqEreC6DRC/VHJV41zN
        GuH18AUQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWRQM-00A2zq-Af; Thu, 08 Sep 2022 23:59:10 +0000
Date:   Thu, 8 Sep 2022 16:59:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Use sysctl_vals in sysctl-test.c
Message-ID: <YxqBzqRVYDBoWRDN@bombadil.infradead.org>
References: <20220908082947.2842179-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908082947.2842179-1-liushixin2@huawei.com>
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

On Thu, Sep 08, 2022 at 04:29:45PM +0800, Liu Shixin wrote:
> v1->v2: fix build error when !CONFIG_PROC_SYSCTL
> 
> Liu Shixin (2):
>   kernel/sysctl.c: move sysctl_vals and sysctl_long_vals to sysctl.c
>   kernel/sysctl-test: use SYSCTL_{ZERO/ONE_HUNDRED} instead of
>     i_{zero/one_hundred}
> 
>  fs/proc/proc_sysctl.c |  7 -------
>  kernel/sysctl-test.c  | 43 ++++++++++++++++++++-----------------------
>  kernel/sysctl.c       |  9 ++++++++-
>  3 files changed, 28 insertions(+), 31 deletions(-)

Queued up on sysctl-testing thanks!

  Luis
