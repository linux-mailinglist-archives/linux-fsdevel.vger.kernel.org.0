Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF62228C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 19:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgGPRNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 13:13:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:60016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbgGPRNe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:13:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92DCDB88D;
        Thu, 16 Jul 2020 17:13:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6CCE81E0E81; Thu, 16 Jul 2020 19:13:32 +0200 (CEST)
Date:   Thu, 16 Jul 2020 19:13:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v5 00/22] fanotify events with name info
Message-ID: <20200716171332.GK5022@quack2.suse.cz>
References: <20200716084230.30611-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Thu 16-07-20 11:42:08, Amir Goldstein wrote:
> This patch set implements the FAN_REPORT_NAME and FAN_REPORT_DIR_FID
> group flags.
> 
> I previously posted v3 of prep patch series [1] and v4 of follow up
> series [2].  Since then you pick up several prep patches, so this
> posting includes the rest of the prep patches along with the followup
> patches with most of your comments addressed.
> 
> Regarding the use of flag FS_EVENT_ON_CHILD and the TYPE_CHILD mark
> iterator, I did not change that because I was not sure about it and it
> is an internal implementation detail that we can change later.
> But the discussion about it made me realize that dnotify event handler
> wasn't properly adapted, so I added a patch to fix it.
> 
> The patches are available on github [3] based on your fsnotify branch.
> man-pages [4] LTP tests [5] and a demo [6] are also available.

Phew! So I went through the patches. I didn't find any bug besides couple
of typos I've fixed and then couple of things I've flagged at individual
patches (which I've fixed up locally as well). There's just that
ignore_mask handling issue outstanding. Overall I have to say I'm unhappy
about the complexity of juggling with dir/inode/child, dirfh vs objfh, etc.
I acknowledge that the stuff is at least well commented so I was able to
grok it but still... That being said I don't have a great idea how to
simplify all this so at this point I'm ok with merging things as they are
but once all the functionality is in I want to have a look at how to
simplify all the special cases.

Anyway, for now, thanks for your persistence and work when developing this
series!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
