Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E65663A7EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 13:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiK1ME2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 07:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiK1MDN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:03:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9550D1C915
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 04:01:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02EA060DDE
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 12:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6970CC433C1;
        Mon, 28 Nov 2022 12:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669636912;
        bh=5xu6aGnTH20sij743zAG4T/NL/9smcfC8kIVClQ6x68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WajcSX6Na081dTUFfaxeIw5+54VAyCn9CwyBvCrQMZhvpVuH9MjjyW7j806MtZP5x
         6t3y8wyNsFpoxGe9goLXRdAzhi8D/5htFjvlD4TFmU8K/wxW/vn1wG0lQ2GkKzuGex
         /Tdxzy9FoiZ8v9VdEH34IqcLxJVLyG5trIPFYO081OawUSfalTJGsKB2vMadUUz9+F
         wu+W0sw41qqEM49sFQwzknimhsG6aXkpXEe4+BCYzwJRxn8wcqeV3CrbZ8mY4oDS9V
         1kxhGLORbJ2btlwT6XKyGMOIsBzVGj0Ctttq0Mog9q1fkrCs7+VADMy83BQm46ml4x
         oa/qLPopok8WA==
Date:   Mon, 28 Nov 2022 13:01:47 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: simplify vfs_get_super
Message-ID: <20221128120147.7ye7b6gmjlpmgamc@wittgenstein>
References: <20221031124626.381838-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221031124626.381838-1-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 01:46:26PM +0100, Christoph Hellwig wrote:
> Remove the pointless keying argument and associated enum and pass the
> fill_super callback and a "bool reconf" instead.  Also mark the function
> static given that there are no users outside of super.c.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
