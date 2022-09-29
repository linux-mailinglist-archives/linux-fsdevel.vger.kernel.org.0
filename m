Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7BC5EF070
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiI2I2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 04:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiI2I2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:28:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9C81114E7;
        Thu, 29 Sep 2022 01:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37676B823AE;
        Thu, 29 Sep 2022 08:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B2BC433D6;
        Thu, 29 Sep 2022 08:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664440107;
        bh=NFQLnM0Y7pIBQy6gT+tauG6QxQ0FDdDdzcgEgSmGaik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=naT3yPhNw31XW4TGyR7vQZiovPLLmQw1v90KQLxhLFezPJkaBjGlGS12HYnvFHMVu
         2WVNoROX6xWZsBWH8GOY+o9rhPIgtMv3kskvwSXzsW0i2ZnuIOOGSJlmRpPN4z6Btq
         szXWL0kgKfMdFFum+h2z/9wd8kqsnN5UPyNRhq8BhKUCfpms4FtxmDJYMyRpBPCuSg
         2qcWvHnzKTJxx93WmNXOp+3sURs0fnehCtVsKk0QLMDxMJyKkCKX6qne3c6pTwdXG3
         Ljz47b5n0jj/qtp0j4eLaq5iPMhDdFFJJ54LdIJgCvMz/0LHlHG612mcbLdBEbFjBB
         cInngnGISIiPg==
Date:   Thu, 29 Sep 2022 10:28:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 29/29] acl: remove a slew of now unused helpers
Message-ID: <20220929082822.yhy7szlt3gpbqh34@wittgenstein>
References: <20220928160843.382601-1-brauner@kernel.org>
 <20220928160843.382601-30-brauner@kernel.org>
 <20220929082555.GD3699@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929082555.GD3699@lst.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:25:55AM +0200, Christoph Hellwig wrote:
> On Wed, Sep 28, 2022 at 06:08:43PM +0200, Christian Brauner wrote:
> > Now that the posix acl api is active we can remove all the hacky helpers
> > we had to keep around for all these years and also remove the set and
> > get posix acl xattr handler methods as they aren't needed anymore.
> 
> I think we can also remove all the xattr handlers for ACLs now, can't we?

I would like to do this in a follow-up series because afaict we need to
massage how the ->list() handler is currently used to infer xattrs
support. I think adressing this in a follow-up series would be better.
There'll be more cleanups possibly anyway, I think.
