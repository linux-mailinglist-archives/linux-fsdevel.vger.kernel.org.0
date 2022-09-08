Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1695B2AA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 01:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIHX4H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 19:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIHX4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:56:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54E2F3BED;
        Thu,  8 Sep 2022 16:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZxxXdgK+QZEdMG2Xq83ITALtD1puva6rC7k3Bv2qGiI=; b=RznmVomxowzVrviveupXNh2jhq
        Rsi5/RaCx8j9SZxgph4qqAcWNtRUZzrKZmj2Y2VYwLOKl0frprpSoj7oKVhxfPXHAR2MD+StNKNsH
        hib/svI+NAfIs3e+NBFfCKlM6eyiy7LueFAjj2tU3njYCyiqjDOCfLRLim4YnnyUdDU0ZkBDyCH15
        FLKrDDOcQ5nMAWy7P6lgqUwGd8sMqk+LH7Y2dx/hoq0/L+wd/hQ3R+7gn5sKzWgKuWuoPTDy7j3AZ
        tJm0TUcpNP/bLPdrRE07NTetJ/sMJ2WvYPNhVA0G2PdcjGh5zkmx60Sa/xG3Sc6itsCEY4BWq5mPX
        Fqng2Uvg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWRNH-00A0nt-2B; Thu, 08 Sep 2022 23:55:59 +0000
Date:   Thu, 8 Sep 2022 16:55:59 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] sysctl: remove max_extfrag_threshold
Message-ID: <YxqBD4Xu62Z5F3uJ@bombadil.infradead.org>
References: <20220905124724.2233267-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905124724.2233267-1-liushixin2@huawei.com>
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

On Mon, Sep 05, 2022 at 08:47:24PM +0800, Liu Shixin wrote:
> Remove max_extfrag_threshold and replace by SYSCTL_ONE_THOUSAND.
> 
> No functional change.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Thanks, queued up on sysctl-testing.

  Luis
