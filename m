Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5570F529BDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiEQIL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242566AbiEQIK4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 04:10:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4E72BF2;
        Tue, 17 May 2022 01:10:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B1EFE67373; Tue, 17 May 2022 10:10:48 +0200 (CEST)
Date:   Tue, 17 May 2022 10:10:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <20220517081048.GA13947@lst.de>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com> <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm a little surprised about all this activity.

I though the conclusion at LSF/MM was that for Linux itself there
is very little benefit in supporting this scheme.  It will massively
fragment the supported based of devices and applications, while only
having the benefit of supporting some Samsung legacy devices.

So my impression was that this work, while technically feasible, is
rather useless.  So unless I missed something important I have no
interest in supporting this in NVMe.
