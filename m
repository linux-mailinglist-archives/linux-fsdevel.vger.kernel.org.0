Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058D57BE1E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 15:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377587AbjJINzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 09:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377585AbjJINzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:55:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9572FAB;
        Mon,  9 Oct 2023 06:55:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E413C433C7;
        Mon,  9 Oct 2023 13:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696859745;
        bh=DRqjrg0j7GONsh5GzBzP+A72WJxZ6ioATyVB0ZfWFBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgXJuTFq9b2AtpFyPlgWucQ5gsgWhVPBRpzC1HCH57pR97eATKKhO311M+eojKtFf
         dxfLLR4SE0Ade5nCZ9vIiZC7Eb9AVk3woNffrmQoY5F5odGs0x5/VvRz6k+NGcl7p9
         bZCAW6gG5YNE4vv2XmpeIj+JBTNikG3losMbQsTsLxgh/m7a0eD1xTrYmjf2BIqWpa
         S0mgG7lwXGz8j3g3BAqZB8v5IMTZBrdszcTLvmucc/88pIJtH8zhR41dTNb1ZShYS/
         ADp9Og1mfInXMn+qXTbv0ylbUqhNBLGyjTqWxBoRAfV1q6Diekq1o3mpVcpJkx/GcP
         DuQfo3zOkvacA==
Date:   Mon, 9 Oct 2023 15:55:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Lizhi Xu <lizhi.xu@windriver.com>,
        syzbot+23bc20037854bb335d59@syzkaller.appspotmail.com,
        axboe@kernel.dk, dave.kleikamp@oracle.com, hare@suse.de,
        hch@lst.de, jfs-discussion@lists.sourceforge.net,
        johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: fix log->bdev_handle null ptr deref in lbmStartIO
Message-ID: <20231009-obendrauf-biodiesel-0d76cdd76ab5@brauner>
References: <0000000000005239cf060727d3f6@google.com>
 <20231009094557.1398920-1-lizhi.xu@windriver.com>
 <20231009100825.dkkaylsrj4db3ekp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009100825.dkkaylsrj4db3ekp@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Christian, please pick up this fixup into your tree. Thanks!

Done!
