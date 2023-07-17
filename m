Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962E8756538
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGQNjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjGQNju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:39:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FE994;
        Mon, 17 Jul 2023 06:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA6E261074;
        Mon, 17 Jul 2023 13:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A494C433CA;
        Mon, 17 Jul 2023 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689601189;
        bh=Id+reBJyUs3EtIOjUfUwT0F59yUypbbEDsxmRcaul30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLdjO31gndkZ3v19ndUg216eD5L14WUmZZnJJLm0j+EZWQ8c7g+jAxtVsK4LQ2g5o
         1g32669l/gwZS5qY+hzlMr+4cp86AfnNK7x5zka5VmssUwigW5y/t4OIdGg8o/Urjr
         l2jVUQ5B3I9UMhUq5C3aGjubIycSRMnYhqUNI0to=
Date:   Mon, 17 Jul 2023 15:39:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     almaz.alexandrovich@paragon-software.com, stable@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        van fantasy <g1042620637@gmail.com>
Subject: Re: [PATCH 1/1] fs/ntfs3: Check fields while reading
Message-ID: <2023071733-basically-snub-5570@gregkh>
References: <20230717125013.1246975-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717125013.1246975-1-lee@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:50:13PM +0100, Lee Jones wrote:
> commit 0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b upstream.
> 
> Added new functions index_hdr_check and index_buf_check.
> Now we check all stuff for correctness while reading from disk.
> Also fixed bug with stale nfs data.
> 
> Reported-by: van fantasy <g1042620637@gmail.com>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

What stable tree(s) is this for?

thanks,

greg k-h
