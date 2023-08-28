Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7655278A8CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjH1JVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 05:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjH1JU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:20:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD8019F;
        Mon, 28 Aug 2023 02:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72ADB617A3;
        Mon, 28 Aug 2023 09:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C77EC433C9;
        Mon, 28 Aug 2023 09:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693214442;
        bh=2Jz6MwB5q9EjiEODTH2uREHsQFEeyxWdlot1lPdULao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbbTSw9VnWcCI+i95j+p1H9ZsrrEwyCYm3QJkBcZi40SE9NRjr9DFfAgSOC1CSUs2
         wF5CFGRfWQox7idr5N/2yLS9VEGawGFkinUJTtNXvhrLAwBqGe4xoXafdjwa4AUvOC
         fOyuBS+BsJyN98ZtPpLBMb3KxmEJ7C6C7HRGf0yPA6ilkujMVMWpemgZHx26/jJwG4
         nVSQBblhAhQNdOYjDCOSMxGkBErKa1Km1CQ+499c7G2h2PIr6WS/fy+7TbD2B/xryb
         5yVI6FkK0T8zZa6EwZZ2vn3C/S8OsJ1tE6Msjt640EAhzNmc6zKoZitriqvoK6jBZ7
         uKsqi5IswLBjQ==
Date:   Mon, 28 Aug 2023 11:20:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+f25c61df1ec3d235d52f@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: [syzbot] [kernfs?] KASAN: slab-use-after-free Read in
 kernfs_test_super
Message-ID: <20230828-schande-hungrig-b2a6ebffb5f6@brauner>
References: <0000000000005231870603d64bac@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000005231870603d64bac@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz dup: [syzbot] [fuse?] KASAN: slab-use-after-free Read in fuse_test_super
