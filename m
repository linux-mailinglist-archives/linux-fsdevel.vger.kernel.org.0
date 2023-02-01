Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB33F686745
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjBANnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjBANnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:43:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50357D88;
        Wed,  1 Feb 2023 05:43:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 281ADB82188;
        Wed,  1 Feb 2023 13:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5161DC433EF;
        Wed,  1 Feb 2023 13:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675258979;
        bh=236qP/C90Z1wdMee922mWauOTL0WF+oXGDgnJ96vQFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMMF4aTsthtPu0qSDZz5BvWT3Pmxnz+NILt33rgl1+vXpJfzqEv41DYzKsqYGtoGo
         RfbSM457WNfz2Hj+9ntpXQApKcCjAJVksXRu34iUU27WSsyzFHxu28zKksBwqEgFjq
         bEmZWftDL1skahY8fxJIf/X2bYWhUr5/ruKGAoT6wF16to0EWnPfOxShNm4aNuTyFH
         TllIEyGeIvTdR60qHVy/Feh2ApS62j8QtGi5QRujJzXjmj7KFrOB8C3HaUwsJdZUwf
         P83wP7ZfiBKmcU8JDkWwvICV8r+9vwyn/20bGSvqbW6MrkafLuuV0989PpLRqSWgss
         U+lNph1qFbXHw==
Date:   Wed, 1 Feb 2023 14:42:54 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-mtd@lists.infradead.org, reiserfs-devel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 00/10] acl: drop posix acl handlers from xattr handlers
Message-ID: <20230201134254.fai2vc7gtzj6iikx@wittgenstein>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
 <20230201133020.GA31902@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230201133020.GA31902@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:30:20PM +0100, Christoph Hellwig wrote:
> This version looks good to me, but I'd really prefer if a reiserfs
> insider could look over the reiserfs patches.

I consider this material for v6.4 even with an -rc8 for v6.3. So there's
time but we shouldn't block it on reiserfs. Especially, since it's
marked deprecated.

Fwiw, I've tested reiserfs with xfstests on a kernel with and without
this series applied and there's no regressions. But it's overall pretty
buggy at least according to xfstests. Which is expected, I guess.
