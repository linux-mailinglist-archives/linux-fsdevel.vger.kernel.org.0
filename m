Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C736643D915
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 04:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhJ1CDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 22:03:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36336 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1CD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:03:29 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 066AD1F44AB4;
        Thu, 28 Oct 2021 03:01:01 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Track unicode tree in linux-next (was Re: [PATCH 10/11] unicode:
 Add utf8-data module)
Organization: Collabora
References: <20210915070006.954653-1-hch@lst.de>
        <20210915070006.954653-11-hch@lst.de> <87wnmipjrw.fsf@collabora.com>
        <20211012124904.GB9518@lst.de> <87sfx6papz.fsf@collabora.com>
        <20211026074509.GA594@lst.de> <87mtmvevp7.fsf@collabora.com>
        <20211027090208.70e88aab@canb.auug.org.au>
Date:   Wed, 27 Oct 2021 23:00:55 -0300
In-Reply-To: <20211027090208.70e88aab@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 27 Oct 2021 09:02:08 +1100")
Message-ID: <877ddxdi20.fsf_-_@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> You just need to send me a git URL for your tree/branch (not a cgit or
> gitweb URL, please), plus some idea of what the tree include and how it
> is sent to Linus (directly or via another tree).  The branch should
> have a generic name (i.e. not including a version) as I will continuet
> to fetch that branch every day until you tell me to stop.  When your
> code is ready to be included in linux-next, all you have to do is
> update that branch to include the new code.

Hi Stephen,

Thanks for the information.

I'd like to ask you to track the branch 'for-next' of the following repository:

git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git

This branch is used as a staging area for development of the Unicode
subsystem used by native case-insensitive filesystems for file name
normalization and casefolding.  It goes to Linus through Ted Ts'o's ext4
tree.

Thank you,

-- 
Gabriel Krisman Bertazi
