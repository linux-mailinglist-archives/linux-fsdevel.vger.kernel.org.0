Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCCA52EB1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 13:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348693AbiETLsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 07:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345130AbiETLsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 07:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073EB132A2E
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 04:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96ED761DF1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 11:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22379C385A9;
        Fri, 20 May 2022 11:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653047295;
        bh=+6OZj1v6nyJLazRYLkk7nUdM5DGQBtWsZ8iLJdKkxQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7BsipLEIImglf6bIwfrrmi5oxmn5u6paG7TfsHHffnWAl11Sweb5hfZlsUYV/hIw
         fit+B26C+DG2FIyV2PaC8viTGAVBZMFHaaUEC31UDAALEzkWHgMdPiDa93+Ostt0Y/
         K2RDV8WlqgIvJrlEodzgR7DrAa1WwjMV2Uz8n0EyBEiizjfaEQlrHH67qno+1acgLs
         ZT9y9TuLDUNx6xMPnEfuBs3T/SwE0DHQPpYSnqGKV55MMPh631oVbriVOzAqKXEQb2
         Swak5sM6XEXnMaHwhiO8mVmkjTLKZetUR3Rav7L2j5W769GsYfvZbTIO0Yuf0YbLhe
         UwbAgKe7MO0bQ==
Date:   Fri, 20 May 2022 13:48:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/namei.c:reserve_stack(): tidy up the call of
 try_to_unlazy()
Message-ID: <20220520114811.qkb4e53nnfaegvx4@wittgenstein>
References: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
 <YocIYPe1p5dJTBXc@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YocIYPe1p5dJTBXc@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 03:17:52AM +0000, Al Viro wrote:
> !foo() != 0 is a strange way to spell !foo(); fallout from
> "fs: make unlazy_walk() error handling consistent"...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
