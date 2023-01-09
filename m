Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEB1662CFA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 18:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbjAIRix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 12:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbjAIRio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:38:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF622658;
        Mon,  9 Jan 2023 09:38:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D15F06124C;
        Mon,  9 Jan 2023 17:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4CFC433D2;
        Mon,  9 Jan 2023 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673285923;
        bh=A/Wg7s9P/2Y1HbN5fBlhTvxDCGhhiuEK438+ZivawnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2CjRiwR5coVPsn0Ls2v4tlJm1/GeKIXIKDZeKo++33grnflplgpBlp4XW5R3oZIk
         gIsFiYsgGt+5katADlENyvKPPscsvqBXjsS0koU8qNoT8PagVGnBMrzAW9W0ZyUZUa
         yZjnoqWbVpRcq4JVPHDIun66WsjfwvWtDm+izCjmW+tnFekWIIcTQ2IQw/NypD7l0+
         cVFQzjgeSiC7O09NmbU8NhVUiJN5mWFGe2XxlGoCGP8x1QYRF6/3BYCY+1YoxsUGLp
         gjPfIPcEe8sTWpJYMs58CJnAqjAQ9ZcLQA6eAFCzwQVCp2EMspM9JodyfWfSi6BkFl
         gbpaIO5Aa/ccg==
Date:   Mon, 9 Jan 2023 09:38:41 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 00/11] fsverity: support for non-4K pages
Message-ID: <Y7xRIZfla92yzK9N@sol.localdomain>
References: <20221223203638.41293-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223203638.41293-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 23, 2022 at 12:36:27PM -0800, Eric Biggers wrote:
> [This patchset applies to mainline + some fsverity cleanups I sent out
>  recently.  You can get everything from tag "fsverity-non4k-v2" of
>  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git ]

I've applied this patchset for 6.3, but I'd still greatly appreciate reviews and
acks, especially on the last 4 patches, which touch files outside fs/verity/.

(I applied it to
https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git/log/?h=fsverity for now,
but there might be a new git repo soon, as is being discussed elsewhere.)

- Eric
