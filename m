Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8A072BC60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjFLJ3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 05:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjFLJ2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E75D114;
        Mon, 12 Jun 2023 02:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E4D161B51;
        Mon, 12 Jun 2023 09:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7DAC433D2;
        Mon, 12 Jun 2023 09:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686561802;
        bh=4AGHDFZXJC+FCm/NVpyXgkt2lHPyqfXBt+X8NTkBCSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ON3GH5P2qy//yxHT9NshMrMinF/WBeaiyw3InMyLDycyz4vlvfmaB9v8ciXVcFMtk
         aYKXVMos39WBDNn4v2RHAazwwGMtsD93eYzlCFEj8dN3lqbNk9UVa6zZRYdvEoJFsi
         066w69YM60Edb3Cr9E180VKkMAoSlxHKlXJQaLZo=
Date:   Mon, 12 Jun 2023 11:23:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        corbet@lwn.net, snitzer@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, willy@infradead.org, dlemoal@kernel.org,
        wsa@kernel.org, heikki.krogerus@linux.intel.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] blksnap - block devices snapshots module
Message-ID: <2023061204-jigsaw-punch-0e6a@gregkh>
References: <20230609115206.4649-1-sergei.shtepa@veeam.com>
 <ZIaVz62ntyrhHdup@infradead.org>
 <1bfc8c1d-f49a-2128-a457-4651832f3d2a@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bfc8c1d-f49a-2128-a457-4651832f3d2a@veeam.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:03:49AM +0200, Sergei Shtepa wrote:
> 
> 
> On 6/12/23 05:49, Christoph Hellwig wrote:
> > Hi Sergei,
> > 
> > what tree does this apply to?  New block infrastructure and drivers
> > should be against Jen's for-6.5/block tree, and trying to apply the
> > series against that seems to fail in patch 1 already.
> > 
> 
> Hi.
> 
> Thank you. My mistake is that for the base branch I used this:
> Link: https://github.com/torvalds/linux
> 
> > Jen's for-6.5/block tree
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.5/block
> I have to prepare a patch for this branch.
> 
> I'm sorry if I remind you of a kitten who is just learning how to
> properly lap milk from a bowl :)
> 
> I guess I don't need to increment the patch version.
> Is it enough to do a "RESEND"?

It's a new version as you had to rebase it.

thanks,

greg k-h
