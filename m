Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD95E7572
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 10:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiIWIJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiIWIJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:09:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFA812E40B
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 01:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2D9DB822E7
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB3AC433D6;
        Fri, 23 Sep 2022 08:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663920561;
        bh=sZ3NylF7ornirBWllBxSSz+kfPZFUm8qzwABTwwEhKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c2MnCYCbVgMMZwRMtRkboz3ziad9isWTdsLQ9D5RYh0HL4Xb8C2XbcxtgyupqmbHC
         RCO1R7iQZ3+9+aQKVIqz0b/XbKPMjK7FSqbHUjmf8UsiqAiFfBWwGfyXVsjkmy5RfM
         bLJQc13hE7SdxnLgYffEiiA3mseNh3+THexaCWzdiH8uemE8G7Z4c5SsWI1MpP7WcN
         j2nmlOT3LUEjPYLvBM1UsWihoh2jXB/qac5N1WpN1ntjP4278moXneEpu+q6YenWQf
         vskdEXO5/uM/Mkul/DQByBkw3MEXYxWUpfuVi7p+jWxxUYxtdGd6OQr/Ck6foxWrG9
         QnY4FzeSVDcWg==
Date:   Fri, 23 Sep 2022 10:09:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 01/29] fs: pass dentry to set acl method
Message-ID: <20220923080915.ieluypp3vfsdvntp@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-2-brauner@kernel.org>
 <20220923064322.GA16489@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220923064322.GA16489@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 08:43:22AM +0200, Christoph Hellwig wrote:
> This looks generally good to me.  Can you split the non-tivial
> orangefs refactoring into a prep patch so that it stands out
> and can be properly documented?
> 
> Also there's a bunch of externs that can be dropped in the lines
> you touch.

Ok, will do!
