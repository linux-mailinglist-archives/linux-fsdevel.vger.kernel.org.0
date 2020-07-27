Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D5622FBB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 23:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgG0V5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 17:57:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0V5H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:57:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DA9DAC97;
        Mon, 27 Jul 2020 21:57:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B4B781E12C7; Mon, 27 Jul 2020 23:57:05 +0200 (CEST)
Date:   Mon, 27 Jul 2020 23:57:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/9] Fixes for fanotify name events
Message-ID: <20200727215705.GO5284@quack2.suse.cz>
References: <20200722125849.17418-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722125849.17418-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-07-20 15:58:40, Amir Goldstein wrote:
> Jan,
> 
> Following your feedback [1] to fanotify name events, I wrote some LTP
> tests [2] to add missing test coverage:
> 
> 1) dnotify/inotify: report event to both parent and child -
>    catches the dnotify bug I had in v4 after unified event patch
> 
> 2) fanotify10: add groups with FAN_REPORT_NAME to the setup -
>    catches the bug you noticed in fanotify_group_event_mask()
> 
> 3) fanotify10: add test cases with ignored mask on watching parent -
>    catches the inconsistecy with ignored masks that you noticed [*]
> 
> The patches in this series apply to your fsnotify branch and are
> avaiable on my fsnotify-fixes branch [3].
> 
> Patch 1 fixes issue #2 above
> Patch 2 fixes another issue found by tests
> Patch 3 fixes a minor issue found by code review
> Patches 4-6 simplify the code based on your suggestions
> Patch 7 depends on 4-6 and fixes issue #3 above [*]
> 
> Optional patches:
> Patch 8 implements your suggestion of simplified handler_event()
> Patch 9 is a possible fix for kernel test robot reported performance
> regression. I did not get any feedback on it, but it is trivial.

OK, so I've added patches 1-8 to my tree. I've checked that the final
resulting source after my patch reorg is the same as after just applying
the patches. LTP tests pass so I've pushed out everything to linux-next to
give it some more beating. So everything should be ready for the merge
window.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
