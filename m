Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788685BF7F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 09:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiIUHkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 03:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiIUHkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:40:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A5327CF5;
        Wed, 21 Sep 2022 00:40:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72DD11F388;
        Wed, 21 Sep 2022 07:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663745999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnuXU4UZnRZGUPWDNH2YDDT/Zs/oJ/xBk/61+cuL7yk=;
        b=Oka4W+OSOQHj5c2rLmWBL8Xjvq7VzpEzzQB4tDhWafzhs38MCqENmdBWFWeEgrYCuXiPrr
        Usz7li0+SflrwVaGVWa1hli+JnHNueftR14iAItHD7JzJ+6bGwgf/1CTsziSK2yJsfV5VG
        g+/bP8Jp/4+dyH0LiClu4XMVz8a12a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663745999;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnuXU4UZnRZGUPWDNH2YDDT/Zs/oJ/xBk/61+cuL7yk=;
        b=8qBsyoM9PZ67Zm/jPRszdv92ksT1R84+Fv4fJELUuJeXASTjI66U4tbw5GMQH/r58S4Otd
        NNrFV78ovfGkJhDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60CCC13A00;
        Wed, 21 Sep 2022 07:39:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ywiZF8+/KmO7EQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Sep 2022 07:39:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C0833A0684; Wed, 21 Sep 2022 09:39:58 +0200 (CEST)
Date:   Wed, 21 Sep 2022 09:39:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     jack@suse.com, tytso@mit.edu, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH 0/3] Check content after reading from quota file
Message-ID: <20220921073958.77i7fj6s2qa7chbv@quack3>
References: <20220820110514.881373-1-chengzhihao1@huawei.com>
 <bd9bf3a4-70f9-f7bf-b133-a68e4e16deb8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd9bf3a4-70f9-f7bf-b133-a68e4e16deb8@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 13-09-22 09:16:11, Zhihao Cheng wrote:
> 在 2022/8/20 19:05, Zhihao Cheng 写道:
> 
> friendly ping.

I'm sorry for the delay. Somehow our corporate spam filter decided to
discard your patches. I'll have a look into your fixes shortly.

								Honza

> > 1. Fix invalid memory access of dquot.
> > 2. Cleanup, replace places of block number checking with helper function.
> > 3. Add more sanity checking for the content read from quota file.
> > 
> > Zhihao Cheng (3):
> >    quota: Check next/prev free block number after reading from quota file
> >    quota: Replace all block number checking with helper function
> >    quota: Add more checking after reading from quota file
> > 
> >   fs/quota/quota_tree.c | 81 ++++++++++++++++++++++++++++++++++++-------
> >   1 file changed, 69 insertions(+), 12 deletions(-)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
