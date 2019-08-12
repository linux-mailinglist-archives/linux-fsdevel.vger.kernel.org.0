Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C9989FEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 15:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfHLNlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 09:41:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:55264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfHLNlu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:41:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03807AD4E;
        Mon, 12 Aug 2019 13:41:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C0A151E400B; Mon, 12 Aug 2019 15:41:45 +0200 (CEST)
Date:   Mon, 12 Aug 2019 15:41:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fanotify, inotify, dnotify, security: add security hook
 for fs notifications
Message-ID: <20190812134145.GA11343@quack2.suse.cz>
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov>
 <CAHC9VhQUoDwBiLi+BiW=_Px18v3xMhhGYDD2mLdu9YZJDWw1yg@mail.gmail.com>
 <CAOQ4uxigYZunXgq0BubRFNM51Kh_g3wrtyNH77PozUX+3sM=aQ@mail.gmail.com>
 <CAHC9VhRpTuL2Lj1VFwHW4YLpx0hJVSxMnXefooHqsxpEUg6-0A@mail.gmail.com>
 <CAOQ4uxiGNXbZ-DWeXTkNM4ySFbBbo1XOF1=3pjknsf+EjbNuOw@mail.gmail.com>
 <16c7c0c4a60.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c7c0c4a60.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 10-08-19 11:01:16, Paul Moore wrote:
> On August 10, 2019 6:05:27 AM Amir Goldstein <amir73il@gmail.com> wrote:
> 
> >>>> Other than Casey's comments, and ACK, I'm not seeing much commentary
> >>>> on this patch so FS and LSM folks consider this your last chance - if
> >>>> I don't hear any objections by the end of this week I'll plan on
> >>>> merging this into selinux/next next week.
> >>>
> >>> Please consider it is summer time so people may be on vacation like I was...
> >>
> >> This is one of the reasons why I was speaking to the mailing list and
> >> not a particular individual :)
> >
> > Jan is fsnotify maintainer, so I think you should wait for an explicit ACK
> > from Jan or just merge the hook definition and ask Jan to merge to
> > fsnotify security hooks.
> 
> Aaron posted his first patch a month ago in the beginning of July and I
> don't recall seeing any comments from Jan on any of the patch revisions.
> I would feel much better with an ACK/Reviewed-by from Jan, or you - which
> is why I sent that email - but I'm not going to wait forever and I'd like
> to get this into -next soon so we can get some testing.

Yeah, sorry for the delays. I'm aware of the patch but I was also on
vacation and pretty busy at work so Amir always beat me in commenting on
the patch and I didn't have much to add. Once Aaron fixes the latest
comments from Amir, I'll give the patch the final look and give my ack.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
