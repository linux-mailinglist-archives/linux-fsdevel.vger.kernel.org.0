Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7851955D321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344532AbiF1Mns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiF1Mnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:43:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1428C1D0FE
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5F6560FFD
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ED4C341CA;
        Tue, 28 Jun 2022 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656420225;
        bh=vGyHnOQpqUQ4xSSiP4wtM7fTO3JGzSQ5g+x5aP73rQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ds7Nf6U17IYcj5SLkBAQGnldFRkJjOxmJGFjhJnRbTmu4x8QhwGWWEpgLGEZ9j0Fe
         H4G88ku3wdNK/UaofDYdDjQbAUvGj10c4OIs1YQEPmeIHJOeFy6D/mWTjwCeXOuPR4
         UM08VcPglYO+YmQjpRcuVDPOr0N6S7+iUxZeYsM8OKegNs4Okvg40z0AZU4n0F+ktX
         pmlgq8DeJnl1GRf2UhyLbs9mRoafYwHcKsa7pBYOiQ4V4xFA7yAelHbjrxMJZCow9/
         OvWYlGZUDU2MbxIv0y/FpVNqItic2mK61+Bj7phpr9ANuXkzm25GA6SNBY56TwsI18
         G5O0QsxhCcemg==
Date:   Tue, 28 Jun 2022 14:43:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 13/44] splice: stop abusing iov_iter_advance() to flush a
 pipe
Message-ID: <20220628124340.ilprz75zxydjctun@wittgenstein>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-13-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622041552.737754-13-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:15:21AM +0100, Al Viro wrote:
> Use pipe_discard_from() explicitly in generic_file_read_iter(); don't bother
> with rather non-obvious use of iov_iter_advance() in there.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
