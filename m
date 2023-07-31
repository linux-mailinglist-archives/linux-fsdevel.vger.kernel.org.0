Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E3976964E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjGaM3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 08:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjGaM3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:29:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D95510FB;
        Mon, 31 Jul 2023 05:28:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE1F6106D;
        Mon, 31 Jul 2023 12:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C63C433C8;
        Mon, 31 Jul 2023 12:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690806538;
        bh=gucAJxQzB4fig8Bm7pwza70ovSvStEeXYbXN0idyvPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+3szwEX33/RaVQJk/TRFp71p73DxviAyxLw590rScKH2UyVgesQlTiZWvnnFoPVf
         UwW8rEbAe7dRc8mqUVkTnOSEXU+pAvPwkzJCggYoFjbH2OiIx/kIbebX6SLsDCJ9aY
         jDtJDPhqTDzxu19oyE8hukb0ZgIqqiXveyg97h1G15umu60TQEJ1c/MR5PKB1ukGh2
         EsBPhIv2dzUVYpDQV4+Oi6I5PFL9T7NdQp+HKarx1NdbGctjEa1gngWeOPlpe7n0oM
         ZOs6eYMrHUXcq2iPtq88cdDvP43iLtSYYu7Gv/hbDu0l9MOrTBZ35WLor56MdC6qG1
         WFWcSzct4gkaw==
Date:   Mon, 31 Jul 2023 14:28:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] fs: fix request_mask variable in generic_fillattr
 kerneldoc comment
Message-ID: <20230731-gefeiert-ermangelung-077409c95c9d@brauner>
References: <20230731-mgctime-v1-1-1aa1177841ed@kernel.org>
 <ZMemr1EzBCRrvv3g@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMemr1EzBCRrvv3g@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 01:18:55PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 31, 2023 at 06:37:10AM -0400, Jeff Layton wrote:
> >  /**
> >   * generic_fillattr - Fill in the basic attributes from the inode struct
> > - * @idmap:	idmap of the mount the inode was found from
> > - * @req_mask	statx request_mask
> > - * @inode:	Inode to use as the source
> > - * @stat:	Where to fill in the attributes
> > + * @idmap:		idmap of the mount the inode was found from
> > + * @request_mask	statx request_mask
> 
> Missing the colon after request_mask.

Fixed in-tree, thanks!
