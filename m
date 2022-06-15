Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E301854C32C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 10:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243058AbiFOILs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 04:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbiFOILr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:11:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B402AE02;
        Wed, 15 Jun 2022 01:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4C4FCCE1D62;
        Wed, 15 Jun 2022 08:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353B6C34115;
        Wed, 15 Jun 2022 08:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655280703;
        bh=G8h+IDpJR0CvhZVQBHmA8xXUGMUALrZIeamkPUOOwAc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J6Y3XOcwoC/TgUHQEi+SmCxARb6tPwZNqAYZg5XUTUI3Q/ll5OApOdFtKbROVKu0J
         G3wBk9/2zrpVCGzGGdhz1ESbgkoh73YGsKSRIOJUxvsHV+/K5Zd6avT4WMepRjY9H4
         wamp6FUhQPTuGWEhQiYvx6IJuRvj3n1pbZp2ZHUm41s47toXZ4TP69nqNoX31VqQXs
         PJkwswu6LBuH667SA02KF13mHrfORzWm/2zDlI2HgW90bjJCTh4CmOq+CyWlVyareR
         TNZ8wmpjenOnCxxJfBdf7GMJYbuk/uABYuIiv48owX1ckCCiZaFExYBEBPHV4h2PdO
         DbPuKfjHUQGOA==
Message-ID: <5fdec03e-efb6-554b-55b3-49e7e7f2be5e@kernel.org>
Date:   Wed, 15 Jun 2022 16:11:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [f2fs-dev] [PATCH v2 14/19] f2fs: Convert to
 filemap_migrate_folio()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-aio@kvack.org, linux-nfs@vger.kernel.org,
        cluster-devel@redhat.com, linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-15-willy@infradead.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220608150249.3033815-15-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/6/8 23:02, Matthew Wilcox (Oracle) wrote:
> filemap_migrate_folio() fits f2fs's needs perfectly.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
