Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5126D4E34
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 18:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjDCQmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 12:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjDCQmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5BEA8;
        Mon,  3 Apr 2023 09:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 762E4621BD;
        Mon,  3 Apr 2023 16:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D236C433D2;
        Mon,  3 Apr 2023 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680540121;
        bh=9mYHEuYtdoiX94py9bx7LQ5TvOMc0Uj/nhoapI/BKZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBw0dz5Bd+j2XPDQAozX5o29aHSz1JGfZmvpTfeWNMoxaT1Jl9H/m/TQRaY8Z7o3x
         2FZERpuR2zRNrAsTCngfenay/ExqydOhwwTAsYd4kVTU6wPpwfiNGgULmP8f7BCt9H
         arAp/yzKQKzzqOUcV+JCyV9pGJEUDzVg1FsETv56J2m8fN3AOUJtxcuUJ4NErxpNVS
         9J7VQ3d9KgG7a5Ogi9aLDwLllnb/bb1eCTVfBXetX8p1QQfThedeoCnGfJ2IsEdNXC
         5NHDm/ZDAW+HVneUorrmhQfKBgoBfVvZl2JMWF0L8YkI1zL7yGoZSUwf/XUzJveeP4
         icICQq+4EqMWQ==
Date:   Mon, 3 Apr 2023 18:41:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs/buffer: Remove redundant assignment to err
Message-ID: <20230403-battered-crusher-46d00c43a7a4@brauner>
References: <20230323023259.6924-1-jiapeng.chong@linux.alibaba.com>
 <167990444020.1656778.1662705570875208111.b4-ty@kernel.org>
 <ZCr7H9NqkPlmR/jk@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZCr7H9NqkPlmR/jk@casper.infradead.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 03, 2023 at 05:13:19PM +0100, Matthew Wilcox wrote:
> On Mon, Mar 27, 2023 at 10:10:10AM +0200, Christian Brauner wrote:
> > 
> > On Thu, 23 Mar 2023 10:32:59 +0800, Jiapeng Chong wrote:
> > > Variable 'err' set but not used.
> > > 
> > > fs/buffer.c:2613:2: warning: Value stored to 'err' is never read.
> > > 
> > > 
> > 
> > Applied to
> 
> I think you should exercise extreme care with patches from "Abaci Robot".
> It's wrong more often than it's right, and the people interpreting the
> output from it do not appear to be experienced programmers.

Thank you! I've tried to be extra careful with these patches and will
continue to do so.
