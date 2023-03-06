Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4AF6AB9BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 10:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCFJ0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 04:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCFJ0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:26:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10557231E0;
        Mon,  6 Mar 2023 01:26:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D4E3B80D27;
        Mon,  6 Mar 2023 09:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2167C433EF;
        Mon,  6 Mar 2023 09:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678094799;
        bh=57FrCCZ2Wq+YAZlBEbTVLCXLXyHrbe4LXgxzAP6Rt70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGpHk5/EASsEtl4vKnAkGUaXhtbPzA/d2cXgftsQx8PVrRgVXQNsAAnUOBX1GgX6I
         G/6gfIFXfw4GETwfv8Vqa+2mueXnJba6vq4doCPeNTZ+42jYFYMi/XGYUBkeA8X/oD
         ElKS799bOnXufZBGOEBscaDcXEpJHRp87DtATu56G0m7hUhBUbQpW3gm1nxMrdfglF
         0ZbBUcHJGIkJmz/Hsybihbq8zOv2if13KJ/EEandIpN1dFYg7WzDuihAtyiEKIBsW3
         NHz3uKORaef+IPel5P8LpgPELeV5dFcgKzByHGHs4b9oIVc5RyT13xsoOqXUWsxf3W
         aynSxAyBPrijQ==
Date:   Mon, 6 Mar 2023 10:26:33 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-mtd@lists.infradead.org, reiserfs-devel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 00/10] acl: drop posix acl handlers from xattr handlers
Message-ID: <20230306092633.tobpejvw7mwcx22v@wittgenstein>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
 <20230201133020.GA31902@lst.de>
 <20230201134254.fai2vc7gtzj6iikx@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230201134254.fai2vc7gtzj6iikx@wittgenstein>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:42:54PM +0100, Christian Brauner wrote:
> On Wed, Feb 01, 2023 at 02:30:20PM +0100, Christoph Hellwig wrote:
> > This version looks good to me, but I'd really prefer if a reiserfs
> > insider could look over the reiserfs patches.
> 
> I consider this material for v6.4 even with an -rc8 for v6.3. So there's
> time but we shouldn't block it on reiserfs. Especially, since it's
> marked deprecated.

So I've applied this now. If there's still someone interested in
checking the reiserfs bits more than what we did with xfstests they
should please do so. But I don't want to hold up this series waiting for
that to happen.

> 
> Fwiw, I've tested reiserfs with xfstests on a kernel with and without
> this series applied and there's no regressions. But it's overall pretty
> buggy at least according to xfstests. Which is expected, I guess.
