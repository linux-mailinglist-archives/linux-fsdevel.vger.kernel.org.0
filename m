Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC81632D32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 20:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiKUTq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 14:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiKUTqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:46:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64413CFE83;
        Mon, 21 Nov 2022 11:46:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B0ED61455;
        Mon, 21 Nov 2022 19:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36061C4347C;
        Mon, 21 Nov 2022 19:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669060009;
        bh=pHzctSC+3S79oH24mEHkCYNAjNLCVnOPYHO4iVExqp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gu4ApRO7ShKYUQt/o5rHuO7/e7edxcAQL2sz08D3vSZo4B4Yk7qIg2vN3+Vq3zb0+
         Znpn4doRVYY6VPlWQoh0Ki+1FycncWJEWYrgpqSxcxLrGTrUT1KzhrLmH0QIH+WGGj
         kbpFVJ/bYVorYvawbiwdS8l/ZzBij6GvGFI/CdCUsg6olmZxihCSuvgv3LaAYT0/7+
         TvDA9gIAJkZJCq0ErkkUytJZssk6IIHLmwxHEAxykGzz/dfMEiK9/q/3cZw4EHXrxq
         Ifz0K/JPBw7GfKC1syS2sIBKVLiEYwTrzvlu5GZqxy0pUPLAeBf3gY4OKNS1eYWpm/
         4m6ENAR20nqXg==
Date:   Mon, 21 Nov 2022 19:46:47 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/5] fs: affs: initialize fsdata in affs_truncate()
Message-ID: <Y3vVp/2A9nao8HZ2@gmail.com>
References: <20221121112134.407362-1-glider@google.com>
 <20221121112134.407362-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121112134.407362-2-glider@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:21:31PM +0100, Alexander Potapenko wrote:
> When aops->write_begin() does not initialize fsdata, KMSAN may report
> an error passing the latter to aops->write_end().
> 
> Fix this by unconditionally initializing fsdata.
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Are you sure that is the correct Fixes commit?  What about commit f2b6a16eb8f5
("fs: affs convert to new aops")?

- Eric
