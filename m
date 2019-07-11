Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 981566513A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 06:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfGKEkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 00:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfGKEkD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 00:40:03 -0400
Subject: Re: [GIT PULL] file lease fix and tracepoint for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562820003;
        bh=SmffSHejj8/vFnTanZ8UKnlDr/bkiUf1EEekyBWaPvU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rSiSqYIKSaLhtWj2Cr//X6Jkk9H/zbTvCpqpcK3EAavAC6k9JiZmojo0utaJVpVa6
         9a18HXV5yUgU9/9T5mhjVYro1c5zpyDn0UsimWf4h9qrgmcyjFftqeuuJre6aAfgxh
         RHew1RN50Nxgh3/fYDlwLIDC38hrVRmz4fel6nhg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fc29b04c3efadbde6ac0352a124a6f436cdf5146.camel@redhat.com>
References: <fc29b04c3efadbde6ac0352a124a6f436cdf5146.camel@redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fc29b04c3efadbde6ac0352a124a6f436cdf5146.camel@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
 tags/locks-v5.3-1
X-PR-Tracked-Commit-Id: 387e3746d01c34457d6a73688acd90428725070b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 988052f47adc5c3b0b004180b59bb3761d91b752
Message-Id: <156282000312.18259.6427529917215200252.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 04:40:03 +0000
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>, ira.weiny@intel.com,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 08:43:10 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v5.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/988052f47adc5c3b0b004180b59bb3761d91b752

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
