Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744C56B76B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 12:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCMLwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 07:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjCMLw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:52:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF029029;
        Mon, 13 Mar 2023 04:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7A9CCE0E34;
        Mon, 13 Mar 2023 11:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0620CC433EF;
        Mon, 13 Mar 2023 11:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678708330;
        bh=sHeQsCoZRxl3XJ7ciUSxbOkWttg7iLdAWLL9MzYSwfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDqsuIKSUyBuGtAQmMxckr+bLLDGB9amqdBK0T9yJxZcCfZMFOQGQ/NP4AcCG0R3t
         XCS3lA06QIpaiAdtQXtP+1Twq2MijgwKptX5xPKJ2B4K84VMM1AX9jDBK7H6nUEjIs
         iJnqqCfgoRHtEGWtqxiM1QHaAUJnsbSwJLRapD1YCw1ZhdVvBbTLYcENmG8499dbLy
         uSe/UmSKGmemIT1H/51TlQXY+Sh8S/WWSFknqjovvDkZUniar9UmSVC8SKiaEXIF3j
         zN9zQISUeK/vn/N3xtRTk6g4GhgRfjQPn8VV9ofBCbx/6vbDF4ju9YHi2jwt/bLE1v
         5Ysa6Sv8UAZpw==
Date:   Mon, 13 Mar 2023 12:52:05 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHES] fget()-to-fdget() whack-a-mole
Message-ID: <20230313115205.mw2dud27lcjszqij@wittgenstein>
References: <20230310212536.GX3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310212536.GX3390869@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 09:25:36PM +0000, Al Viro wrote:
> 	fget()/fget_raw() should be used when we are going to keep
> struct file reference; for temporary references fdget()/fdget_raw()
> ought to be used.  That kind of stuff keeps cropping up on a regular

Fwiw, might be worth to mention/document that explicitly anywhere.
I didn't see anything but might've missed it.

> basis, and it needs periodic pruning.
> 
> 	The current pile is in vfs.git #work.fd; individual patches
> in followups.

Reviewed-by: Christian Brauner <brauner@kernel.org>
