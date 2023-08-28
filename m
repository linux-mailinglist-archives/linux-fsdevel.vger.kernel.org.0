Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0E578A8DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 11:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjH1JXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 05:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjH1JXk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:23:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCA0195;
        Mon, 28 Aug 2023 02:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8324763547;
        Mon, 28 Aug 2023 09:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AADC433C8;
        Mon, 28 Aug 2023 09:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693214531;
        bh=4JTtntQJ/NbwBTWKqklvrhhuPSQIyVYP0+tYzQL0wBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nY4xVvl6au1X8wNynKHrXNV35Ky9cSoElaE8ZJ9vcYSKgp4XAkU9jhmk+XKsxGKkd
         kiWTb49Sl07lBfy0PSMqXg2jTs7+nQ86J9QYHVQdFas48mr54897QjeyPF8x2UqZYU
         VqpWOEGaFXPhiJjc8wpZQrOFN1zKK4IoBomsio3xt/OMnIAlNgoPE33jLC0Y0eAdPw
         fPMYt4phWrZCkEbkTuM1IwRZbk7d5khZ2k9lo84Wmu9Jvb3RFZivJPLQcnhEQnoE4m
         lWeV1JECF1zM+Ht1vSrujbBNLFdEKF47b1otWrD97KTFz/adktBZjYeDulvFvbIP3K
         7p8JnWhNSv2cw==
Date:   Mon, 28 Aug 2023 11:22:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+f25c61df1ec3d235d52f@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: [syzbot] [kernfs?] KASAN: slab-use-after-free Read in
 kernfs_test_super
Message-ID: <20230828-esstisch-lastwagen-df699ff31994@brauner>
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

#syz dup: KASAN: slab-use-after-free Read in fuse_test_super
