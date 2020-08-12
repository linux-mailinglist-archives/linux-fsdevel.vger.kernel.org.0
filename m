Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8664324236B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 02:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgHLAfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 20:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgHLAfH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:35:07 -0400
Subject: Re: [GIT PULL] orangefs pull request for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597192506;
        bh=Zr5ihicGN4t7aVhNivJLAf5fbpdP6qf2Mts7P0LGX3I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HshZz5UqzmhDIlKJAWEqcerQaBhjAZixBQqoSKpFjT4joXoJ6GmaVbKbsG+kOaXJJ
         1exq/eniX9fdCyfR/Tg75uM3AUTLjp19orm+mCdWoWe5UurOGz8eUaXv13beF/d234
         r/LTK/nUshwcLIkLtHSS9zb3l468ENQDd3nhQ18o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSQvhvavaUK94Y3XRdvRCOzEDc_rbOQV-NT4vjWzepf0zA@mail.gmail.com>
References: <CAOg9mSQvhvavaUK94Y3XRdvRCOzEDc_rbOQV-NT4vjWzepf0zA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSQvhvavaUK94Y3XRdvRCOzEDc_rbOQV-NT4vjWzepf0zA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.9-ofs1
X-PR-Tracked-Commit-Id: e848643b524be9c10826c2cf36eebb74eef643d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d668e848293fb57826771a0375a97a6cd1970a63
Message-Id: <159719250683.21709.10751564209402869970.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Aug 2020 00:35:06 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 11 Aug 2020 16:19:25 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.9-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d668e848293fb57826771a0375a97a6cd1970a63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
