Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F457724A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 14:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjHGMqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 08:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjHGMqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:46:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31451FC7;
        Mon,  7 Aug 2023 05:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D105611B4;
        Mon,  7 Aug 2023 12:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716E5C433C8;
        Mon,  7 Aug 2023 12:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691412347;
        bh=pMGmT/Pou6cIXNxMdsIaUSmMDmATLx/PEP2zAeUDuX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHETf0uokHvoUHbhzYLDcSFcC4vi7PEbJ04Mo71aUABVSfk/V/PTwVS/UIpHyGprP
         ryL5sQTIUOdivJhNyFqjhwODP9uuPU9AG7EezC9YSOOMiNKFak20m4Bvj6qCw8AxM2
         TKpK97mhg6k13SPOyKAKRDNOqxSGcLobCxbKmqFnemyN4RlEcQVYt9LkKx/D7BYxEh
         nickfShRB+v2c59KrbiC8PyUWm5fCJBjBC9RjR8IynGY4hccKZZgd/V7jKMcWAs5hJ
         dr+EjnVtVddP6eLRKkm74zfm5vr2wW5pdnvnFgKmOSVJBR1455bwqCdUVVebLc4XgF
         GPVbin0EDplrQ==
Date:   Mon, 7 Aug 2023 14:45:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] fs, block: remove bdev->bd_super
Message-ID: <20230807-riesig-wehrlos-9f90c87d9a09@brauner>
References: <20230807112625.652089-1-hch@lst.de>
 <20230807112625.652089-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807112625.652089-5-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 12:26:25PM +0100, Christoph Hellwig wrote:
> bdev->bd_super is unused now, remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
