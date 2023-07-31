Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B2D76965E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjGaMcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 08:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjGaMcI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:32:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9339C6;
        Mon, 31 Jul 2023 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yl+YZw/dDiykkFFQcCYFX/OpU02NdfZgnjCcB5WxFLo=; b=pKTK2F9ye8xZ5ugSuJ28buwPlp
        ZF8EcuWxlWY137wKZ6+DAMkuGNuhl68CORA6uOQ8cDD1LR3HIuowHK9wzS9GnFOxnZ/T8Of9LMhl0
        7RgJD6zDt2KNhdPfWsNJmsdshwsfm3aDlARB1SD+E53dqdo8FmFBwUMM73MILWOBKYrgHcpXSAd7e
        21Bkkyj6ArvQvpTIGQ24MS3Kp0Oxq1iOk9xkD48FV67pEvcqTq5R6gtfjt5OanU6xrBU2R3SvRKql
        iHEHCCP6rL5GDOejN1E00UGMn1lOZ1wBJ5utqX1FWAqVe/9hSuylYpthQr3STBKlWRd9DHAXze00w
        rm5ormkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQS4C-001buN-Cy; Mon, 31 Jul 2023 12:32:04 +0000
Date:   Mon, 31 Jul 2023 13:32:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] fs: fix request_mask variable in generic_fillattr
 kerneldoc comment
Message-ID: <ZMepxLLgo/Iqtj0N@casper.infradead.org>
References: <20230731-mgctime-v1-1-1aa1177841ed@kernel.org>
 <ZMemr1EzBCRrvv3g@casper.infradead.org>
 <20230731-gefeiert-ermangelung-077409c95c9d@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-gefeiert-ermangelung-077409c95c9d@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 02:28:49PM +0200, Christian Brauner wrote:
> On Mon, Jul 31, 2023 at 01:18:55PM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 31, 2023 at 06:37:10AM -0400, Jeff Layton wrote:
> > >  /**
> > >   * generic_fillattr - Fill in the basic attributes from the inode struct
> > > - * @idmap:	idmap of the mount the inode was found from
> > > - * @req_mask	statx request_mask
> > > - * @inode:	Inode to use as the source
> > > - * @stat:	Where to fill in the attributes
> > > + * @idmap:		idmap of the mount the inode was found from
> > > + * @request_mask	statx request_mask
> > 
> > Missing the colon after request_mask.
> 
> Fixed in-tree, thanks!

FWIW, a W=1 build will catch this:

../mm/filemap.c:254: warning: Function parameter or member 'folio' not described in 'filemap_remove_folio'

(after having deliberately removed the colon on that line)
