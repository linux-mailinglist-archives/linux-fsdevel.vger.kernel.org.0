Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18951711371
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 20:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjEYSQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjEYSQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 14:16:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D49E2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 11:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E294564869
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 18:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49726C433EF;
        Thu, 25 May 2023 18:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685038569;
        bh=plBJVTHIMNPxcCqmOhrk0aN7CkZvTcCEBw7bXx82tQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3TyY1yja8Fmqzn5aiEZ7pnLerGIQKRXBOPpO+u/hvc5xTmh40b99yp4q+J+qpDsG
         vDfWBAr3FtApI0Kz/xDp4oZbFBKaRcllZPCsCre5eSoLFrS9dii07EliOGRc0hBIax
         ZQYh1WPVBDGHySw05A5r161lBwkFqBHNt3fqIZh/AX/RcsdWA/+772hvJ4T75Ym24k
         f/FpXTUZYBVYcwbtIG5Mhp0WwV5vCFH01DPHTHzB/SiRWj5mbz19JnnWcuobfu69/s
         VFNTITaIOniSFaZAqK+MVomAIn2ZOvP/Xk43GBEPL7L3gwZjlN3mf1NQbLLdqrnRhn
         GCjwUVIOYQ04w==
Date:   Thu, 25 May 2023 20:16:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] fs: Drop wait_unfrozen wait queue
Message-ID: <20230525-vorenthalten-drama-aafc614c20df@brauner>
References: <20230525141710.7595-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230525141710.7595-1-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 04:17:10PM +0200, Jan Kara wrote:
> wait_unfrozen waitqueue is used only in quota code to wait for
> filesystem to become unfrozen. In that place we can just use
> sb_start_write() - sb_end_write() pair to achieve the same. So just
> remove the waitqueue.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Removing code. I'm all here for it...
Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/quota/quota.c   | 5 +++--
>  fs/super.c         | 4 ----
>  include/linux/fs.h | 1 -
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 
> Guys, I can merge this cleanup through my tree since I don't expect any
> conflicts and the generic part is pure removal of unused code.

There'll likely be another set of fixes I'll take next week but I
honestly don't care. But seems that this isn't really urgent so why not
just wait for the merge window?
