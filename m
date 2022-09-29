Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3DA5EF477
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 13:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiI2Lj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 07:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiI2Lj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE7A14F8D0;
        Thu, 29 Sep 2022 04:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE9E161032;
        Thu, 29 Sep 2022 11:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F8BC433C1;
        Thu, 29 Sep 2022 11:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664451565;
        bh=rQDTzrXTterZ1Cn2Ac6CQ/I9r2LXiXCBGwWtNKTHfLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIFQdHmkyUFs+8O9Jo1p5AsH7JaV52l0qbkGO2Xz6oIdiIh6D4jWVgO+PwJFHxa48
         KhPsMIStetAEcIIeokb5oyS4WwOqIieB24kzgc/juwM8CP8L4pm+EZE+RU3mxonqzb
         R3picy2Tu4d1x6aaI4Vw0LAwsY8GisVF3g09nvoE0tlxljxZV/Ajhmnvjr7RT8mIRR
         xiMziw4jG5I+LvvxxzIfTSgWGkcLbMiyTOtl/rzNGYwQj0CQdwVqsAtUxeUJFFBbG+
         KQ6qVjcdLD41eKWDVNTR2Ljb56dnzHTMWRczRIYo+aJKsKiH+MWjYsnn7uCv0oUmgN
         UiDlhK3Kz6WiA==
Date:   Thu, 29 Sep 2022 13:39:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 23/29] xattr: use posix acl api
Message-ID: <20220929113920.nkmhmg3si7s7hpbk@wittgenstein>
References: <20220928160843.382601-1-brauner@kernel.org>
 <20220928160843.382601-24-brauner@kernel.org>
 <20220929082535.GC3699@lst.de>
 <20220929091027.ddw6kbdy2s7ywvh4@wittgenstein>
 <20220929094623.ajw7kauqwwwovd44@wittgenstein>
 <20220929105128.GA16410@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929105128.GA16410@lst.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:51:28PM +0200, Christoph Hellwig wrote:
> On Thu, Sep 29, 2022 at 11:46:23AM +0200, Christian Brauner wrote:
> > +int do_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > +	       struct xattr_ctx *ctx)
> 
> I'd just pass name, value an size instead of this weird context thing,
> same for the read size.  Otherwise this looks fine, though.

Ok.

> 
> > index 84180afd090b..b766ddfc6bc3 100644
> > --- a/io_uring/xattr.c
> > +++ b/io_uring/xattr.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/namei.h>
> >  #include <linux/io_uring.h>
> >  #include <linux/xattr.h>
> > +#include <linux/posix_acl_xattr.h>
> 
> This looks spurious.
> 

Yes, leftover and already removed in the tree. Thanks!
