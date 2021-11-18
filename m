Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C42456077
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 17:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhKRQdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 11:33:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51640 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbhKRQdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:33:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7F684212BE;
        Thu, 18 Nov 2021 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637252999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ckE0MaVpKLz8C9grpO4SuuzKdZKSGWqSFzftHMv44i8=;
        b=e2zMxJWIbgfmGK7L+3Fm0x1lMGTY0L9Q1MThlbaW3bBP1I0wCnY/6EWT7soCHnSVcI8nYE
        wAS7veky6uv2ACTboAzylAq1kV36BxT1MCkCATsL+zmoCdPQJjZynz0p2YNpO+qgPioW1O
        SHn6aEQAiTHbtKZB2JCVzwKjMVaCrNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637252999;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ckE0MaVpKLz8C9grpO4SuuzKdZKSGWqSFzftHMv44i8=;
        b=gvz50dO4Q/7SLzPJx/+sLqIhi469cY8RLKm+b8Kp7uz9btxULHsQI96VQ4yMbWbenVtPpl
        4sML8WZmpe0rrVDA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 69935A3B81;
        Thu, 18 Nov 2021 16:29:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B3B1B1F2C95; Thu, 18 Nov 2021 17:29:56 +0100 (CET)
Date:   Thu, 18 Nov 2021 17:29:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 0/7] Report more information in fanotify dirent events
Message-ID: <20211118162956.GA8267@quack2.suse.cz>
References: <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
 <20211112163955.GA30295@quack2.suse.cz>
 <CAOQ4uxgT5a7UFUrb5LCcXo77Uda4t5c+1rw+BFDfTAx8szp+HQ@mail.gmail.com>
 <CAOQ4uxgEbjkMMF-xVTdfWcLi4y8DGNit5Eeq=evby2nWCuiDVw@mail.gmail.com>
 <20211115102330.GC23412@quack2.suse.cz>
 <CAOQ4uxiBFkkbKU=yimLXoYKHFWOoUYrXfg4Kw_CkF=hcSGOm3A@mail.gmail.com>
 <20211115143750.GE23412@quack2.suse.cz>
 <CAOQ4uxgBncZjuTo-K+vxRovd36AuaEKUfBDQwgU86B9qwWWNVw@mail.gmail.com>
 <20211116101232.GA23464@quack2.suse.cz>
 <CAOQ4uxgfCmWCt=NNxj53+eKtVE-FMWBDNgFuQpGiFooZpne6zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgfCmWCt=NNxj53+eKtVE-FMWBDNgFuQpGiFooZpne6zw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-11-21 14:47:18, Amir Goldstein wrote:
> > > So let's say this - we can add support for OLD_DFID, NEW_DFID types
> > > later if we think they may serve a purpose, but at this time, I see no
> > > reason to complicate the UAPI anymore than it already is and I would
> > > rather implement only:
> > >
> > > /* Info types for FAN_RENAME */
> > > #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME       10
> > > /* Reserved for FAN_EVENT_INFO_TYPE_OLD_DFID    11 */
> > > #define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME       12
> > > /* Reserved for FAN_EVENT_INFO_TYPE_NEW_DFID    13 */
> > >
> > > Do you agree?
> >
> > I agree the utility of FAN_RENAME without FAN_REPORT_NAME is very limited
> > so I'm OK with not implementing that at least for now.
> 
> OK. The patches are staged at [1], but I ran into one more UAPI question
> that I wanted to run by you before posting the patches.
> 
> The question may be best described by the last commit on the tests branch [2]:
> 
>     syscalls/fanotify16: Test FAN_RENAME with ignored mask
> 
>     When a file is moved between two directories and only one of them is
>     watching for FAN_RENAME events, the FAN_RENAME event will include only
>     the information about the entry in the watched directory.
> 
>     When one of the directories is watching FAN_RENAME, but the other is
>     ignoring FAN_RENAME events, the FAN_RENAME event will not be reported
>     at all.
> 
>     This is not the same behavior as MOVED_FROM/TO events. User cannot
>     request to ignore MOVED_FROM events according to destination directory
>     nor MOVED_TO events according to source directory.
> 
> I chose this behavior because I found it to be useful and consistent with
> other behaviors involving ignored masks. Maybe "chose" is a strong word
> here - I did not do anything to implement this specific behavior - it is just
> how the code in fanotify_group_event_mask() works for merging masks
> and ignored masks of different marks.
> 
> Let me know if you approve of those ignored FAN_RENAME semantics
> and I will post the patches for review.

Yeah, I guess ignore masks with FAN_RENAME are going to be a bit
non-intuitive either way and what you suggest makes sense. I suppose when
SB has FAN_RENAME mark and either source or target have FAN_RENAME in the
ignore mask, nothing will get reported as well, do it? If we are consistent
like this, I guess fine by me.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
