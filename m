Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D29752481
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjGMOAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 10:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjGMOAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6247D1FF1;
        Thu, 13 Jul 2023 07:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C32CC6153A;
        Thu, 13 Jul 2023 14:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C91C433C9;
        Thu, 13 Jul 2023 14:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689256852;
        bh=qAVi5GjCnGFTZVoZ8BbhnYuhY9QEIH07fK7bqIq6/7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cu/7Br3w3aPCIg499KFH3bgsecNBcc4vh4ypzDpKy1Utcv2d+D9j85m4nKwzxw0sr
         QKWlVOs2M6MvghyIIMmySmyJVMysvMb4WlfgFEyN6cPOAOM5N4r2vM/+v7EFlww0RS
         KR2HY6LebQjQw4d/WFvcMZAhGNeq+145VBEm4BzUwMAwgwzVshG+IOSWVP+vHJ7HMz
         dFvZpofiXZ4mNhANEv80GG34KCP7afloXRxFoFj2nZG8C416hwhv40M3t1bzyaPV8s
         dq8NjXP6nK8OOxsw2p9kJ6ophjw4SgCoPzAgYKHNNw/duWBsZtLF83bMYCphN2pKVp
         hxH7TEHCdKBpg==
Date:   Thu, 13 Jul 2023 16:00:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Petr Machata <petrm@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] eventfd: simplify eventfd_signal_mask()
Message-ID: <20230713-jenen-unreflektiert-26bb6cc816fa@brauner>
References: <20230713-vfs-eventfd-signal-v1-0-7fda6c5d212b@kernel.org>
 <20230713-vfs-eventfd-signal-v1-2-7fda6c5d212b@kernel.org>
 <877cr4uidk.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877cr4uidk.fsf@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:59:01PM +0200, Petr Machata wrote:
> 
> Christian Brauner <brauner@kernel.org> writes:
> 
> > @@ -82,9 +83,9 @@ __u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask)
> >   *
> >   * Returns the amount by which the counter was incremented.
> 
> This should be reworded to reflect the fact that the function now
> returns a bool.

Thanks, I'll update that in-tree to avoid respamming everyone.
