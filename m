Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7067AD3C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 10:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjIYIvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjIYIvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:51:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89916C0;
        Mon, 25 Sep 2023 01:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hkw5Z4WC4lZYGudn69KXiB2GzJT82+Vg3Fjbl4SJmcE=; b=NFmFHCneVSRxAZqKvgwXa1IAP7
        5MsoOrxdVB20Ox2Qiyt/uMnsm0+pLVgc3P2j6Kt3p8iMIKMAm71+F4xHbq/DvMmPdc20nDHqWNXFo
        J4qFZSZyW8sdPiEVQkuIq6C/AoiMoPOxNaozPlG6ngb0Cyj8mjRXW5gK6sVOWvZTGduVRARdehiIf
        I5kpZoc8J5kJj1/SxsAguCRp7XNUj38/aDFsq3NlAQNf1twfy3d6jlnKVwouYnVxofJNe2M2VQ/UU
        hcR+X7qxzhZkZKEKVmN9r+/LtywymPO3TXaMPDYlBu6BQVu3MvW130S8+sPqO9GTEGb/r7wkVYmG5
        +hELIVEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qkhJH-00DmBg-1R;
        Mon, 25 Sep 2023 08:51:19 +0000
Date:   Mon, 25 Sep 2023 01:51:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, brauner@kernel.org, david@fromorbit.com,
        djwong@kernel.org, hare@suse.de, hch@lst.de,
        johannes.thumshirn@wdc.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, mcgrof@kernel.org, nogikh@google.com,
        p.raghav@samsung.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block] INFO: task hung in clean_bdev_aliases
Message-ID: <ZRFKBxoRjVQclPS0@infradead.org>
References: <000000000000e534bb0604959011@google.com>
 <0000000000001486250605ad5abc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001486250605ad5abc@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz test: git://git.infradead.org/users/hch/misc.git bdev-iomap-fix
