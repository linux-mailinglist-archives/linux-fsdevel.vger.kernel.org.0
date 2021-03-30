Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE14834DDCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 03:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhC3BxZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 21:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhC3BxQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:53:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E37260C41;
        Tue, 30 Mar 2021 01:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617069196;
        bh=GevyNR3XBe9JE7jNR+C8DY51gkGc4pzFml1BcSA406Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5qJ0nFahBP6GKD/dJ8ZoylIMmracSMkrLJT/lMIaVQsirQQDmobUKooTFBmZAnPu
         aUwiEKocTK2IblXOwGicPfx1kesw3uK2nQsdYUsHfnxUiMUPKbo3T/H8G9t/0CdZIt
         hFZkDNzfyTkzmR4LWgY49O/sziwlogOrSFqsLze3HfXi4hNB0yzSGYSQ2jsYTxs7hp
         /B0Vpj7pfQxQT5cB07v69yDt1Ui/WQ+RkhTrCJoCMpyICo6Kz6yPnS1tqWwvU1mWqT
         bl7OzwZIWaIDZ8IkHPfltNPTxBNaXYgCfcTI8WxfMjcLG/G51Nr4zM9r0Z7oGC7+Aq
         gKk3hrBJYGQCg==
Date:   Mon, 29 Mar 2021 18:53:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, drosen@google.com,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v5 2/4] fs: unicode: Rename function names from utf8 to
 unicode
Message-ID: <YGKEitULkZmMwk3f@gmail.com>
References: <20210329204240.359184-1-shreeya.patel@collabora.com>
 <20210329204240.359184-3-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329204240.359184-3-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 02:12:38AM +0530, Shreeya Patel wrote:
> utf8data.h_shipped has a large database table which is an auto-generated
> decodification trie for the unicode normalization functions and it is not
> necessary to carry this large table in the kernel.
> Goal is to make UTF-8 encoding loadable by converting it into a module
> and adding a unicode subsystem layer between the filesystems and the
> utf8 module.
> This layer will load the module whenever any filesystem that
> needs unicode is mounted.
> utf8-core will be converted into this layer file in the future patches,
> hence rename the function names from utf8 to unicode which will denote the
> functions as the unicode subsystem layer functions and this will also be
> the first step towards the transformation of utf8-core file into the
> unicode subsystem layer file.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> Changes in v5
>   - Improve the commit message.

This didn't really answer my questions about the reason for this renaming.
Aren't the functions like unicode_casefold() still tied to UTF-8 (as opposed to
e.g. supporting both UTF-8 and UTF-16)?  Is that something you're trying to
change?

- Eric
