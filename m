Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AEF4F0FC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 09:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377603AbiDDHJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377596AbiDDHJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:09:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901D939148;
        Mon,  4 Apr 2022 00:07:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2192768AFE; Mon,  4 Apr 2022 09:07:28 +0200 (CEST)
Date:   Mon, 4 Apr 2022 09:07:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 08/12] btrfs: pass a block_device to btrfs_bio_clone
Message-ID: <20220404070727.GA427@lst.de>
References: <20220404044528.71167-1-hch@lst.de> <20220404044528.71167-9-hch@lst.de> <PH0PR04MB74169A7FEDD5C747CC7B1ACF9BE59@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74169A7FEDD5C747CC7B1ACF9BE59@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 04, 2022 at 07:05:38AM +0000, Johannes Thumshirn wrote:
> On 04/04/2022 06:46, Christoph Hellwig wrote:
> > Pass the block_device to bio_alloc_clone instead of setting it later.
> 
> s/bio_alloc_clone/btrfs_bio_clone

Well, both if we want to be pedantic.
