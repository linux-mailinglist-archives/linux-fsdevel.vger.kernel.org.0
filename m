Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C73A5AA519
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 03:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiIBBc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 21:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIBBc5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:32:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A816CF71;
        Thu,  1 Sep 2022 18:32:56 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MJgNT71ClzHncr;
        Fri,  2 Sep 2022 09:31:05 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 09:32:54 +0800
Subject: Re: [PATCH v2 13/14] ext2: replace bh_submit_read() helper with
 bh_read_locked()
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cluster-devel@redhat.com>,
        <ntfs3@lists.linux.dev>, <ocfs2-devel@oss.oracle.com>,
        <reiserfs-devel@vger.kernel.org>, <jack@suse.cz>, <tytso@mit.edu>,
        <akpm@linux-foundation.org>, <axboe@kernel.dk>,
        <rpeterso@redhat.com>, <agruenba@redhat.com>,
        <almaz.alexandrovich@paragon-software.com>, <mark@fasheh.com>,
        <dushistov@mail.ru>, <hch@infradead.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
References: <20220901133505.2510834-1-yi.zhang@huawei.com>
 <20220901133505.2510834-14-yi.zhang@huawei.com> <YxFOqimAyJNxuPM9@ZenIV>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <3fdab5fd-1efa-9668-da5c-889e9bfa1524@huawei.com>
Date:   Fri, 2 Sep 2022 09:32:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YxFOqimAyJNxuPM9@ZenIV>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/9/2 8:30, Al Viro wrote:
> On Thu, Sep 01, 2022 at 09:35:04PM +0800, Zhang Yi wrote:
>> bh_submit_read() and the uptodate check logic in bh_uptodate_or_lock()
>> has been integrated in bh_read() helper, so switch to use it directly.
> 
> s/bh_read_locked/bh_read/ in the summary?
> 

Sorry, I don't get your question, I have already replace bh_read_locked()
with bh_read() in the commit message, there is no bh_read_locked in the whole
patch. Am I missing something?

Thanks,
Yi.
