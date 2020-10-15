Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3294428FB1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 00:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbgJOWT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 18:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731740AbgJOWT1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:19:27 -0400
Subject: Re: [GIT PULL] configfs updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602800366;
        bh=m7c1l+DRcwhkgf9lEo2LWg2ofKjCkNRUF4lCb8bgJ/k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ARNp+0ALIbv+rG6MXd1GyxrRdgwuXiz7bNaHDil1KaWQ5LIxwj0hS8kxUKixXtHUl
         w3Is29H6B3yT2+Nk9ztIQoTjrKxQ2Ln3/Rk+p1Z9Y90S5NvAjOaLdCVA3EFpbm29K7
         4uyIfw9InCDyOwP/w8YPFoLjBsoAqWRF5Tso2+Kw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201015175312.GA2648919@infradead.org>
References: <20201015175312.GA2648919@infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201015175312.GA2648919@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git tags/configfs-5.10
X-PR-Tracked-Commit-Id: 76ecfcb0852eb0390881a695a2f349b804d80147
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca5387e448e1f88440dc93e143b353592f8a8af6
Message-Id: <160280036655.16623.15583862310603439840.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 22:19:26 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Becker <jlbec@evilplan.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 19:54:01 +0200:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca5387e448e1f88440dc93e143b353592f8a8af6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
