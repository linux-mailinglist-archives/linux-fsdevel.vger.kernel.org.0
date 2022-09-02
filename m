Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92705AA46F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 02:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiIBAar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 20:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiIBAaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:30:46 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC4B95AD4;
        Thu,  1 Sep 2022 17:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GX5ACSnHUYsKqlVKsOWkZfXxafThifKnGC34uwcAjqA=; b=DbYmmMXXFvXNfgDpO9j4482+k4
        Nz/X9ykWbPXR+tXPE74oUAJ0OHbE9QtvPBH0RB+KhOhadNfv/9vrgLGMZ9+wcWqW7VAXVhOOV75o3
        Lyp0DTiKeqdG5X5L/wcgq6AV2KQXb4YXndw/JP/Aa8QfHL/MY5TYTY5oBTXvdipUZI4bUozQSc62V
        G79pth6KqCUyuRd1yAmlYDzOefDPBD5+eWrkNtYFbHAmu/C5JyvgY4VkVrl2IKWqdL9t6r60x7975
        QXEarjETVKU4mXg3H7dYxd785+hlc7hbFdkioaIy61Ow0kOmryox7Ch1xu45qKOEIBiD7GapJh6M8
        S1/0C80A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTuZu-00BA5L-Bu;
        Fri, 02 Sep 2022 00:30:34 +0000
Date:   Fri, 2 Sep 2022 01:30:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        akpm@linux-foundation.org, axboe@kernel.dk, rpeterso@redhat.com,
        agruenba@redhat.com, almaz.alexandrovich@paragon-software.com,
        mark@fasheh.com, dushistov@mail.ru, hch@infradead.org,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 13/14] ext2: replace bh_submit_read() helper with
 bh_read_locked()
Message-ID: <YxFOqimAyJNxuPM9@ZenIV>
References: <20220901133505.2510834-1-yi.zhang@huawei.com>
 <20220901133505.2510834-14-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901133505.2510834-14-yi.zhang@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:35:04PM +0800, Zhang Yi wrote:
> bh_submit_read() and the uptodate check logic in bh_uptodate_or_lock()
> has been integrated in bh_read() helper, so switch to use it directly.

s/bh_read_locked/bh_read/ in the summary?
