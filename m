Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2444E4C84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiCWGHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 02:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiCWGHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:07:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D336E8DB;
        Tue, 22 Mar 2022 23:06:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6232D68AFE; Wed, 23 Mar 2022 07:06:12 +0100 (CET)
Date:   Wed, 23 Mar 2022 07:06:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/40] btrfs: remove the submit_bio_hook argument to
 submit_read_repair
Message-ID: <20220323060612.GD24302@lst.de>
References: <20220322155606.1267165-1-hch@lst.de> <20220322155606.1267165-18-hch@lst.de> <49d2563e-a611-0b44-569e-8e88053b7385@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49d2563e-a611-0b44-569e-8e88053b7385@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:20:41AM +0800, Qu Wenruo wrote:
>
>
> On 2022/3/22 23:55, Christoph Hellwig wrote:
>> submit_bio_hooks is always set to btrfs_submit_data_bio, so just remove
>> it.
>>
>
> The same as my recent cleanup for it.
>
> https://lore.kernel.org/linux-btrfs/9e29ec4e546249018679224518a465d0240912b0.1647841657.git.wqu@suse.com/T/#u
>
> Although I did extra renaming as submit_read_repair() only works for
> data read.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

I'm fine doing either version.  This was just getting in the way of
other repair changes, which is why we probbaly both came up with it.
