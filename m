Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DA2778C31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjHKKom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHKKol (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:44:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16E4127;
        Fri, 11 Aug 2023 03:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5290366A3D;
        Fri, 11 Aug 2023 10:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34573C433C7;
        Fri, 11 Aug 2023 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691750679;
        bh=kkdQzEAQ0sF7AzB1JBDDbcTt7pWf3ymQ9Td1BynCWLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RoukUon9sfsiciMjSOY6TVc8EqeSY93QZK24KKaNj5aMyzR1vasllKfU2NqxsS/Zh
         EtlioH+wUgbrpcyyQ0zx+wE9vlXqiBdKjTAr8YnpePsR44z+Qm9LZK/Bz9G8K3nTJa
         5Ods4z2uo8rS9DrNWHOQd+SdXc7YW5KImIAA6o4zV54G6XJUskvE6Ey9YPVOjCtHBY
         Zte5IHKP0ey9bj+a4MDF8Tu7nUd5Vu3GOblEdr/EPvwu7Z35f8uyfvbpFAnN4lWt/W
         kt9R3ElV7dxMZKEJjzdeyjx33visFZlFuUQFdyVLiisybuY3eXpzPSHHwP/UMB60FJ
         sLHOFxaZCM2Vg==
Date:   Fri, 11 Aug 2023 12:44:33 +0200
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
Subject: Re: [PATCH 01/17] FOLD: reverts part of "fs: use the super_block as
 holder when mounting file systems"
Message-ID: <20230811-codiert-ballen-159707b5d20e@brauner>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-2-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:08:12PM +0200, Christoph Hellwig wrote:
> The btrfs hunk should be dropped because the prerequisite btrfs changes were
> dropped from the branch.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

I've already got that dropped in vfs.super.
So no need to for this.
