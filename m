Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D057305FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjFNRWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 13:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjFNRWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:22:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E011B3;
        Wed, 14 Jun 2023 10:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C761C64517;
        Wed, 14 Jun 2023 17:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5445C433C8;
        Wed, 14 Jun 2023 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686763328;
        bh=w5/LJ9VL/tOf3UMtuc4O4E9fW27si5j7tY7DpTj4pss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CxR8M3oxJ/8tD5K4WiBXG9FURLGXMbDB+KLaO4hVqKynleUbR2BRf6KBkeaADyGz9
         1lbBHibfKX9JBkMZEjk1Pogn6Kj8fnfsfDkp2ykJxWpLc0aZblP0DSJYP3zDyDNO1F
         FGUw+56BiggUXhFxKiyA5RfA4ZrzZOMLM+gCmrSgl9VB6hdntTuE7YGpSd0rGdcoZ1
         Qdl/Y0WXIHOFiVWxTwMXypMcsV+77ogcE8w+HreNHPVx5Bddq89B7q6V68bn/kiNbS
         gsRwg54n7A8fNuHGDLyySHM5P3qiloRKc+z9uWrsrT85gW3qUfvtlACqDnr1eU0dBK
         a0ezyBCLOWW1Q==
Date:   Wed, 14 Jun 2023 10:22:05 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux@weissschuh.net" <linux@weissschuh.net>,
        "jack@suse.cz" <jack@suse.cz>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 00/11] blksnap - block devices snapshots module
Message-ID: <20230614172205.GB1146@sol.localdomain>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612161911.GA1200@sol.localdomain>
 <20a5802d-424d-588a-c497-1d1236c52880@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20a5802d-424d-588a-c497-1d1236c52880@veeam.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:12:19PM +0200, Sergei Shtepa wrote:
> On 6/12/23 18:19, Eric Biggers wrote:
> > This is the first time you've received an email from this sender 
> > ebiggers@kernel.org, please exercise caution when clicking on links or opening 
> > attachments.
> > 
> > 
> > On Mon, Jun 12, 2023 at 03:52:17PM +0200, Sergei Shtepa wrote:
> >  > Hi all.
> >  >
> >  > I am happy to offer a improved version of the Block Devices Snapshots
> >  > Module. It allows to create non-persistent snapshots of any block devices.
> >  > The main purpose of such snapshots is to provide backups of block devices.
> >  > See more in Documentation/block/blksnap.rst.
> > 
> > How does blksnap interact with blk-crypto?
> > 
> > I.e., what happens if a bio with a ->bi_crypt_context set is submitted to a
> > block device that has blksnap active?
> > 
> > If you are unfamiliar with blk-crypto, please read
> > Documentation/block/inline-encryption.rst
> 
> Thank you, this is an important point. Yes, that's right.
> The current version of blksnap can cause blk-crypto to malfunction while
> holding a snapshot. When handling bios from the file system, the
> ->bi_crypt_context is preserved. But the bio requests serving the snapshot
> are executed without context. I think that the snapshot will be unreadable.

Well not only would the resulting snapshot be unreadable, but plaintext data
would be written to disk, contrary to the intent of the submitter of the bios.
That would be a security vulnerability.

If the initial version of blksnap isn't going to be compatible with blk-crypto,
that is tolerable for now, but there needs to be an explicit check to cause an
error to be returned if the two features are combined, before anything is
written to disk.

- Eric
