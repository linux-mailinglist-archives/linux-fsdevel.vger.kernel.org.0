Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE15778FDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 14:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjHKMtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 08:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHKMtE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8187C2696;
        Fri, 11 Aug 2023 05:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17E9E64FE4;
        Fri, 11 Aug 2023 12:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03536C433C8;
        Fri, 11 Aug 2023 12:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691758143;
        bh=ejIUNFO7vD5+JAhPZ7uJRR/J5AhcRrudBRP7+EnTl0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXvwatSPGWudGtF+0zb3+i8/8EZHT7CDtvPfZ616wj4sSEBiDQgFyK/j+9BklCYkk
         iOrOrH/Ny9lYKv95OxHW08M0OPf1yx+XLb9hxxzHb/Z6lXMRl2R4lnNX5ofV2zkz/O
         54yTbvDXGqTl2PhJUYM8Ej9ZIYpkH1Zz8aOkUPWDus44pXDpu7RduXHF+ic//DHz6p
         FjxNNGnvPVFnAkUyzcU6X7Mjqt8Zc+tHEz0sME0qV7LgBoEAUAZA40crjocb6FnwlM
         cQr1Up+zWrGYLXCZ4uLZ1+4PaZaj3rjfx4BchygqFQqqyIeWJyfQ4jmCsuPTYWM7Ik
         zsd4Mia8YDZAg==
Date:   Fri, 11 Aug 2023 14:48:57 +0200
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
Subject: Re: [PATCH 17/17] fs: simplify invalidate_inodes
Message-ID: <20230811-warnt-vorhaben-54641d422810@brauner>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-18-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:08:28PM +0200, Christoph Hellwig wrote:
> kill_dirty has always been true for a long time, so hard code it and
> remove the unused return value.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
