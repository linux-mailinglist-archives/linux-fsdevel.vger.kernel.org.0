Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F153F76B8FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjHAPs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjHAPs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:48:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489E3171C
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 08:48:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C0C976732D; Tue,  1 Aug 2023 17:48:51 +0200 (CEST)
Date:   Tue, 1 Aug 2023 17:48:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] fs: add vfs_cmd_create()
Message-ID: <20230801154851.GA12525@lst.de>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org> <20230801-vfs-super-exclusive-v1-2-1a587e56c9f3@kernel.org> <20230801154333.GC12035@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801154333.GC12035@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 05:43:33PM +0200, Christoph Hellwig wrote:
> > +	ret = vfs_get_tree(fc);
> > +	if (ret)
> > +		return ret;
> 
> The error handling here now fails to set FS_CONTEXT_FAILED.

Actually that's still done in the caller.  But that just reconfirms
my opinion on the shape of the pre-existing code..

