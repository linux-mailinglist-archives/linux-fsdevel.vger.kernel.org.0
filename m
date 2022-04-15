Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92D85030DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Apr 2022 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349909AbiDOWDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 18:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbiDOWDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:03:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFF021833;
        Fri, 15 Apr 2022 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s7o68MSBtZYvWNPoZUbTaqfg0RUdF4pgpXLRfXox2NI=; b=xrVaEZOIeM2YSamm31r/Xo+oKb
        c6jHCB9BtYJD33I0MFiiNBPN60wr9DlVMZdTs00toEasHTgvvXLicl4VcK6lurnjoBKMVktwgLV/K
        pzwym7OfIHbYLSBu74YyG7auTd6edWo2HCrZbcnUe9e/i0DH9DaPMz2cucmcxPP99tZoQtNYL8RVQ
        IIWuddSqbmcjXmL8i7Ktr5mlmZd1FSQ36QzXlSz4H//1Qau260Y/EMloX2pKpzwH5MESzv7ZGjlBo
        W8XB0c9aIHn8WiaHe1WyepH3LbrucqQEvo72r3IyrNY/IJf3Dad3Zf6J74Ie0nq+daGOLEkb16hH7
        bESE2cwQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfU03-00BSp8-Jt; Fri, 15 Apr 2022 22:01:07 +0000
Date:   Fri, 15 Apr 2022 15:01:07 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Liao Hua <liaohua4@huawei.com>
Cc:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangfangpeng1@huawei.com
Subject: Re: [PATCH sysctl-next v3] latencytop: move sysctl to its own file
Message-ID: <YlnrIyQErKNO+ChE@bombadil.infradead.org>
References: <20220407072948.55820-1-liaohua4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407072948.55820-1-liaohua4@huawei.com>
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

On Thu, Apr 07, 2022 at 03:29:48PM +0800, Liao Hua wrote:
> From: liaohua <liaohua4@huawei.com>
> 
> This moves latencytop sysctl to kernel/latencytop.c
> 
> Signed-off-by: liaohua <liaohua4@huawei.com>

Thanks! Queued onto sysctl-testing.

  Luis
