Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EDC5EF619
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiI2NKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 09:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiI2NKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E6D1F2C3;
        Thu, 29 Sep 2022 06:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A44F96121E;
        Thu, 29 Sep 2022 13:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA593C433D6;
        Thu, 29 Sep 2022 13:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664457013;
        bh=rNwEOxiImgPZMG+zmokZJPk1Hmit7NX2H+didLYQ+PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ot2oepJ96Lpup0GtsSPhIXjoq65Y3Ok2flgWRm3hU3vJWuJIClQELcVi1zcBRlueM
         0ZoGr1murzoHxCsr0SJu9HvWeYLBv1ZDjWLm/xROUPbPuh6BSWWs+rHmeRbNyldcNc
         XJtQu6LMkq05stbTwcb5wKpaB5bgpPfnAbpQNAfGsLHUq7Nw6OwlPwv+2l3axr/q7U
         NxXTm6CHqxo7KpQEge1bWZGq3uZftxaOwe8pVRjdDzh5WUmIzWpZU2Wh7KIeKHsbUc
         k6kKT+NJVphvSSFVFiCisIacREqS2N0H1Lgs/M2M/WW8keFcYkbXW28UsYMrblxDP1
         Tyeh1Y0JdPnow==
Date:   Thu, 29 Sep 2022 15:10:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 29/29] acl: remove a slew of now unused helpers
Message-ID: <20220929131008.r7sbltbtbrgrr5ux@wittgenstein>
References: <20220928160843.382601-1-brauner@kernel.org>
 <20220928160843.382601-30-brauner@kernel.org>
 <20220929082555.GD3699@lst.de>
 <20220929082822.yhy7szlt3gpbqh34@wittgenstein>
 <20220929114044.GA19911@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929114044.GA19911@lst.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 01:40:44PM +0200, Christoph Hellwig wrote:
> On Thu, Sep 29, 2022 at 10:28:22AM +0200, Christian Brauner wrote:
> > I would like to do this in a follow-up series because afaict we need to
> > massage how the ->list() handler is currently used to infer xattrs
> > support. I think adressing this in a follow-up series would be better.
> > There'll be more cleanups possibly anyway, I think.
> 
> True, the weird list handling complicates things a bit.  But it is a lot
> of dead wood now and we should clean it up rather sooner than later.

My plan was to have the basic series in a shape were we can stuff it in
a tree and then send a follow-up series basically almost immediately.
And everything would be merged together of course.
