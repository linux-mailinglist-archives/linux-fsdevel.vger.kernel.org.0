Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0D76B7398
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 11:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCMKQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 06:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCMKQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A873D56148;
        Mon, 13 Mar 2023 03:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4673A6119E;
        Mon, 13 Mar 2023 10:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5EDC433D2;
        Mon, 13 Mar 2023 10:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678702564;
        bh=h+yWYDPnPhzCm0GTY175gB450CDOyJEA9NV7+JKMF6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nf6tuHfvv7nCwZXgqm9DJob39yfmArAxJact89zs9kE6BwYoJnEXsMLbprwHr636r
         jyzmx1HTqWyWqHfGpLjdOVVu4tDahAvpf8TfiA89v1kpq4IiQVM4Ms/FYL9T0oUj/I
         9+TT4YNvr7/K2NYJcc71k5inWNDlG6Q+T8/kTjws=
Date:   Mon, 13 Mar 2023 11:16:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
Cc:     security@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: Patch for a overwriting/corruption of the file system
Message-ID: <ZA734rBwf4ib2u9n@kroah.com>
References: <CADZg-m0Z+dOGfG=ddJxqPvgFwG0+OLAyP157SNzj6R6J2p7L-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADZg-m0Z+dOGfG=ddJxqPvgFwG0+OLAyP157SNzj6R6J2p7L-g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 13, 2023 at 03:25:45PM +0530, Kirtikumar Anandrao Ramchandani wrote:
> Hello,
> 
> I am sending this patch which addresses a bug in the fs/affs/.

Your attachment was from a public patch on the f2fs mailing list, not
affs, are you sure you attached the correct one?

And the public mailing lists reject HTML email, please fix up your email
client to be able to send properly.

thanks,

greg k-h
