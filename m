Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1B419FAAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 18:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgDFQpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 12:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729590AbgDFQpD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:45:03 -0400
Subject: Re: [GIT PULL] 9p update for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586191502;
        bh=EIuPoQNSYix7s4sCq4hwH7DS5tLlNWpflv/Y9RVVZWE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aqfPjYzLGsBzB/biToNIvc8QOI3jRoPNZwMP9F9oISr8aE4wcX7mXARnXs/98MX/n
         Gbh1qIY1qAVvzwWx2AWB1/q21YaMxk5irBS+bS/+MwLVZ3f6N4wf4g0X6GTnw+u9Kv
         quRkGA/0y+MEmuc9RqjbEx7RwIHM4w3D6FuVZ1qU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200406110702.GA13469@nautica>
References: <20200406110702.GA13469@nautica>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200406110702.GA13469@nautica>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-5.7
X-PR-Tracked-Commit-Id: 43657496e46672fe63bccc1fcfb5b68de6e1e2f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e14679b62d84b8ab9136189fc069d389da43fe71
Message-Id: <158619150269.17891.13555483701597490537.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Apr 2020 16:45:02 +0000
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 6 Apr 2020 13:07:02 +0200:

> https://github.com/martinetd/linux tags/9p-for-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e14679b62d84b8ab9136189fc069d389da43fe71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
