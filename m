Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74001769699
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 14:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjGaMoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjGaMop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178D3170D;
        Mon, 31 Jul 2023 05:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B62B561121;
        Mon, 31 Jul 2023 12:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42F6C433C7;
        Mon, 31 Jul 2023 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690807480;
        bh=o8RuZV2Az6ztb0yWKcnWaLwR6M/+NlplTbSN2qpVsNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVUb5gyU9dMrWEL+LnfOrHLuI+cb8x6OYxvJqbt6krbVoM17MsynmsZqmxMkBPHDA
         dAz2/ZPrbzuCRz9/7rTiiz0e4GA/kwldekkNaFDeFUH5rF1Y3Ua+DGG7/7G7Cxd49Y
         D5oNCyzaGQ3mtY7wK5FJSrI1OGqjIGufO5qkNcUc8XNcPD3tFtEq4mdQ8hzgt4nyYt
         emj1NWz/j/mlHWR4Olq7BMtgonEiuw3Kzoy9clyhMjkrWCw473UR5HWGp2S23METjj
         JkK7vLj1WNQDnOkTwFQtTEEU4yGeOdIKwLLaxXWriFfHL6XW3nQvw9LZEu9YmjVxc0
         iA/uC64Hicnqg==
Date:   Mon, 31 Jul 2023 14:44:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] fs: fix request_mask variable in generic_fillattr
 kerneldoc comment
Message-ID: <20230731-regie-reitschule-f540e269c348@brauner>
References: <20230731-mgctime-v1-1-1aa1177841ed@kernel.org>
 <ZMemr1EzBCRrvv3g@casper.infradead.org>
 <20230731-gefeiert-ermangelung-077409c95c9d@brauner>
 <ZMepxLLgo/Iqtj0N@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMepxLLgo/Iqtj0N@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 01:32:04PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 31, 2023 at 02:28:49PM +0200, Christian Brauner wrote:
> > On Mon, Jul 31, 2023 at 01:18:55PM +0100, Matthew Wilcox wrote:
> > > On Mon, Jul 31, 2023 at 06:37:10AM -0400, Jeff Layton wrote:
> > > >  /**
> > > >   * generic_fillattr - Fill in the basic attributes from the inode struct
> > > > - * @idmap:	idmap of the mount the inode was found from
> > > > - * @req_mask	statx request_mask
> > > > - * @inode:	Inode to use as the source
> > > > - * @stat:	Where to fill in the attributes
> > > > + * @idmap:		idmap of the mount the inode was found from
> > > > + * @request_mask	statx request_mask
> > > 
> > > Missing the colon after request_mask.
> > 
> > Fixed in-tree, thanks!
> 
> FWIW, a W=1 build will catch this:
> 
> ../mm/filemap.c:254: warning: Function parameter or member 'folio' not described in 'filemap_remove_folio'
> 
> (after having deliberately removed the colon on that line)

Thanks! I often only do W=1 builds by hand on specific files because
otherwise there's such a wall of warnings that it's hard to see what's
going on.
