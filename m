Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E4A754F52
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 17:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjGPPPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 11:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjGPPPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF71BF;
        Sun, 16 Jul 2023 08:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D684460D30;
        Sun, 16 Jul 2023 15:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51B6C433C7;
        Sun, 16 Jul 2023 15:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689520545;
        bh=HVgHIowxTAUucv+1+VLJcv+mItwae3GlS0Q+K5TZouU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sy1uEO6MdQJ3hmvgpIqDVqE7SavCysZ7oqQx7uI55Y+ZrBiAI5lw3zpJk5PQDbzHB
         9AGzFhnPAjPa2IDUn7gix9b4eBQEuBxcBpN+i12OhZub/3Edbi72CX/y9ahT5csD2d
         vkT03OkMFdBmNb5Dj5or8dWbs8KHFX3iC/wJ/BvE=
Date:   Sun, 16 Jul 2023 17:15:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 5.15] fanotify: disallow mount/sb marks on kernel
 internal pseudo fs
Message-ID: <2023071635-stereo-driven-cb2a@gregkh>
References: <20230710133205.1154168-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710133205.1154168-1-amir73il@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 04:32:05PM +0300, Amir Goldstein wrote:
> commit 69562eb0bd3e6bb8e522a7b254334e0fb30dff0c upstream.
> 
> Hopefully, nobody is trying to abuse mount/sb marks for watching all
> anonymous pipes/inodes.
> 
> I cannot think of a good reason to allow this - it looks like an
> oversight that dated back to the original fanotify API.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20230628101132.kvchg544mczxv2pm@quack3/
> Fixes: 0ff21db9fcc3 ("fanotify: hooks the fanotify_mark syscall to the vfsmount code")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Message-Id: <20230629042044.25723-1-amir73il@gmail.com>
> [backport to 5.x.y]
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Greg,
> 
> This 5.15 backport should cleanly apply to all 5.x.y LTS kernels.
> It will NOT apply to 4.x.y kernels.
> 
> The original upstream commit should apply cleanly to 6.x.y stable
> kernels.

Now queued up, thanks.

greg k-h
