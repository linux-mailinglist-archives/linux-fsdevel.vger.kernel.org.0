Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93F1778E80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 14:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjHKMAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjHKMAo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:00:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B6E2D55;
        Fri, 11 Aug 2023 05:00:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F7A86695B;
        Fri, 11 Aug 2023 12:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484DEC433C8;
        Fri, 11 Aug 2023 12:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691755240;
        bh=h1A0pwSYdGRiztn+35Ytfz2xZHIvLutIoQC+rYe6Fps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pes/7yPQXcZvN/dCKMTT7ZhnFt60oysAwfX2rnFI4NoJLDnY11LtAqJpe5SHprOFs
         rAxkvtmIit6vO3r1XFrM/YcvQvye2QTKkl2E74IQEZBC4Xx+LHCjRngmnw/Td7AhWh
         S/ahThn24vkazsk2fwITtYHKT415rfuI6XnFl1wEyOIKDoszqDjv1j/zoUPiUq0jgy
         UH0XBfehpFUpXEOG3H75Ms+rfiTsX8kpwbU2mouO62XGIuZzuVnkQQFV02gGV/YRlF
         0VQUls9O6tkqucucmvr2htcKNnUef6roGv5FxasF0LcnwRAtDUOJzyR2uJSjBwlLFe
         Hqp0sW3YKbD5Q==
Date:   Fri, 11 Aug 2023 14:00:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/17] btrfs: always open the device read-only in
 btrfs_scan_one_device
Message-ID: <20230811-ereignen-mitangeklagt-84cf0f213549@brauner>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-3-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:08:13PM +0200, Christoph Hellwig wrote:
> btrfs_scan_one_device opens the block device only to read the super
> block.  Instead of passing a blk_mode_t argument to sometimes open
> it for writing, just hard code BLK_OPEN_READ as it will never write
> to the device or hand the block_device out to someone else.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
