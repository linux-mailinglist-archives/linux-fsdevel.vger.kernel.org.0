Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53115B2A80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 01:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIHXk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 19:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIHXk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:40:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C13758DFD;
        Thu,  8 Sep 2022 16:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XjxPO2gx8/ZRjoRujkZFtZwwfAjki0m/BAiBLxT6Ui4=; b=iJyD2NAhZ4H4PY4phmTFpsDggS
        6yTyonULSS51/tP2qhdbShlZ6wqHXkJy6s9Rturc0AKL6AS3IweMhxNT5wTBPcTeKHApfHSWywOde
        KdBoHO0O93fa/3tTjkwne0X6toDaFkYGmKdIqevG+mT8Fmeqcm8YbFBhEGYprweyfbjInk2oQQxNS
        qjpamBh5NAdgQ+KmuFMq0vaEADcasPM/HXblNMQesNjJM/YJbUCKmF8nha63EZ5kHK6xCCD7VL5Ty
        96gKcx/3aWwsrojCdGo8x6QElUxIKyvUuf2nnN/4fdcvWYyLwC6WVpPRv12aIbWPPmw1VT8v9lNwS
        J11EnCHA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWR85-009tQR-Q2; Thu, 08 Sep 2022 23:40:17 +0000
Date:   Thu, 8 Sep 2022 16:40:17 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: remove initialization assignment
Message-ID: <Yxp9Yeq5Q7LUshv7@bombadil.infradead.org>
References: <20220801085117.4313-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801085117.4313-1-zeming@nfschina.com>
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

On Mon, Aug 01, 2022 at 04:51:17PM +0800, Li zeming wrote:
> The allocation address of the core_parent pointer variable is first
> executed in the function, no initialization assignment is required.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Thanks!

Queued up for sysctl-testing, if that comes back without issues, I'll
move it to sysctl-next.

  Luis
