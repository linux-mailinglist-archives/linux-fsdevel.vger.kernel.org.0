Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A53655A3F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 23:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiFXVvd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 17:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiFXVvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:51:31 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F9987B58;
        Fri, 24 Jun 2022 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RugUo34b7kCX3LS4yaSCG7V8DF6G5u7h9IVqRfflc0E=; b=Cegwfc+PtG7lEnEWfGVoHIRS8R
        0xyb2p3uwzzNEDJ0rv4JSmuKjKEzf2zj5jPmXKN6bSw47XLAwo1tZBzJWPo88d/QE92XagyU8HtVg
        ghw9ljzMy+wB+hkMifiocy/piN1OTPSowf+gRQXSmt1mMohRIlOBvGNGBS92At4yrYSYGhLNb0RMC
        zx3ous8TlqEPpnFSVm1/uQPXEGXg99uCwh+85islUFSHoS4gPY/HWTdc3wbsfU8EcgoqDvFp1h4e8
        qx7V/lpqds9t6bD8G65SkpaHoT2IAt8tw9SSo+N63aC0EeFvU0bAZoMj/ECy1O46h4MZLSCfZS6V9
        GTliDX1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o4rD5-0044yO-E5;
        Fri, 24 Jun 2022 21:51:27 +0000
Date:   Fri, 24 Jun 2022 22:51:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 5/6] dma-buf: remove useless FMODE_LSEEK flag
Message-ID: <YrYx31qr52aXfZU9@ZenIV>
References: <20220624165631.2124632-1-Jason@zx2c4.com>
 <20220624165631.2124632-6-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624165631.2124632-6-Jason@zx2c4.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 06:56:30PM +0200, Jason A. Donenfeld wrote:
> This is already on by default.

ITYM "anon_inode_getfile() has already set it, since dma_buf_fops has
non-NULL ->llseek".
