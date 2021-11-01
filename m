Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8026D441F3B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 18:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhKARbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 13:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhKARbV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:31:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3772660E52;
        Mon,  1 Nov 2021 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635787728;
        bh=EQHg2GeHNBsLzSfsTle0c8cZZvbtibfsedVbLRWRcQc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DeLTsto7MqeYpYYSnSoKlX0kLaXO7TlwwioChCp5ilSEMBhH61DrseeMuFCIwLCy/
         MO8BHdioP9MeWRXu7DXVk++w2b7ZC1mHYS62cEpx66ztjKa2oHSVy/kacNVDezbGAg
         t7+k6iWbuomEFRBMyHv7K7YeSFdt+1y/AIhvdPtsWBjM+UFevm0WECq7i4gEBnvO9B
         zwFfnEDtcH8YAu6UYKxKrbaSgU8lUvcoBjEsCb/HjzrDYdFVFhX8LuuzBiNqLA7xv0
         3/USPf88tKWQikZIDnfImghlJTjTHvj6PFhuRUV9e6sTIo4hi93quDX5cIGy9UFCoZ
         MtWQH++98G05A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3167E609B9;
        Mon,  1 Nov 2021 17:28:48 +0000 (UTC)
Subject: Re: [GIT PULL] Remove ->ki_complete() res2 argument
From:   pr-tracker-bot@kernel.org
In-Reply-To: <966b2cbc-8f25-edd9-29b7-f390a85bba61@kernel.dk>
References: <966b2cbc-8f25-edd9-29b7-f390a85bba61@kernel.dk>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <966b2cbc-8f25-edd9-29b7-f390a85bba61@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.16/ki_complete-2021-10-29
X-PR-Tracked-Commit-Id: 6b19b766e8f077f29cdb47da5003469a85bbfb9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6773cdb0e9fa75993946753d12f05eb3bbf3bce
Message-Id: <163578772819.18307.12262007310015801805.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 17:28:48 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 31 Oct 2021 13:42:10 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.16/ki_complete-2021-10-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6773cdb0e9fa75993946753d12f05eb3bbf3bce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
