Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C44F787D04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 03:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjHYBSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 21:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbjHYBSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E845B211C;
        Thu, 24 Aug 2023 18:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADC7662FE5;
        Fri, 25 Aug 2023 01:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7177DC433C8;
        Fri, 25 Aug 2023 01:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692926254;
        bh=nuT02cuwXdR1JTfC+bASHl/oVTmJzV1HoyNaNG8w9iI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kzJOJuH94QFUSqcTMPA3NRH8Yw9IdvkV9YBpVp5O6fMcJEbo/7H3APF/BQpPrbPUj
         RIc5KI8SzF4HJ3YBLmimvKwENCaA3fnHDRjonZZ8JhnM5/NFx861gbM93ryI/rWgSa
         P6hhsFBxxyVLCPW7Peqw/iDj2z32dTFlc9VkyuOp7AsicWQu1iDDiwJzhqZ/pnZvFV
         8nrZvZaAXmPSn43SwEsJaoFxJqNWI3BVZJtpc507ytM+Y/Z24xjSTJ3kxDffhonN7e
         Z3pqJJCmzLEFOP1Dn1KULKZXCYh/XzWJt5n9/vinPTEY4RSDyL1SZ8uOTfQ62wzKZx
         fNItCgr68S9EQ==
Message-ID: <6712aa60-47e9-9806-bb5c-c1f642de31ca@kernel.org>
Date:   Fri, 25 Aug 2023 09:17:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 07/45] f2fs: dynamically allocate the f2fs-shrinker
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
 <20230824034304.37411-8-zhengqi.arch@bytedance.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230824034304.37411-8-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/8/24 11:42, Qi Zheng wrote:
> Use new APIs to dynamically allocate the f2fs-shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> CC: Jaegeuk Kim <jaegeuk@kernel.org>
> CC: Chao Yu <chao@kernel.org>
> CC: linux-f2fs-devel@lists.sourceforge.net

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
