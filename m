Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D02E782DE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 18:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbjHUQJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjHUQJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A9F3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 09:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E64063CD7
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 16:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E206BC433C8;
        Mon, 21 Aug 2023 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692634139;
        bh=+SqSORKXaA0gg6k/jjSAXzBI6wG9dt4uxsiz9CJnPAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nO4S+EwrMcO8WahHVxVkPjrHRKq6JR1ZdRtmCZQsLLPEpc25FBQ/rxmL+mqW+4nas
         sh3PKGO7k6mNDDMRcZRgQVqRLTT9py7p+/fDcRVOwcBxR0ZW6s7CKT1uQ2/k2i2ma7
         ILuOdcYoXdW42MKFuSJF1wIdSBP6rz8oQBZWZQ9xR5hWuYz051ORzhfxteOrFSznAN
         LMlRuiKnpssKezcQ68VY5Ta+YoSoJr9Af5SKVObiwwSN2KbNCjnnuIM+EgOQ30lqNz
         PbvsZrMaMCp5lrq28GV69XH4SnqrEufahPfZRSS2WlpSxKzCy7/9wDN4oMClc6cvE6
         N2XrghSAFzcig==
Date:   Mon, 21 Aug 2023 18:08:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] super: wait for nascent superblocks
Message-ID: <20230821-hemmung-exzess-ae58cb895900@brauner>
References: <20230818-vfs-super-fixes-v3-v3-0-9f0b1876e46b@kernel.org>
 <20230818-vfs-super-fixes-v3-v3-3-9f0b1876e46b@kernel.org>
 <20230821155237.d4luoqrzhnlffbti@quack3>
 <20230821160224.ees2jmlddqtupvsc@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821160224.ees2jmlddqtupvsc@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Ah, in both of the above cases we actually need smp_mb() (as you properly

No worries, I got what you meant and that's what I did.

> 
> BTW, if you pick one of these two schemes, feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Ok, thanks!
