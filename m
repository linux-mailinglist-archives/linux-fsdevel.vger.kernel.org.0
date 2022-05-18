Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72B052B43B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 10:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiERIAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 04:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiERIAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 04:00:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FE212719D;
        Wed, 18 May 2022 01:00:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C8B2D68C7B; Wed, 18 May 2022 10:00:22 +0200 (CEST)
Date:   Wed, 18 May 2022 10:00:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, pankydev8@gmail.com,
        dsterba@suse.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        jiangbo.365@bytedance.com, linux-block@vger.kernel.org,
        gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <20220518080020.GA3697@lst.de>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com> <20220516165416.171196-1-p.raghav@samsung.com> <20220517081048.GA13947@lst.de> <20220517091834.dvkrab5l63v3b2zn@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517091834.dvkrab5l63v3b2zn@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 17, 2022 at 11:18:34AM +0200, Javier González wrote:
> Does the above help you reconsidering your interest in supporting this
> in NVMe?

Very little.  It just seems like a really bad idea.
