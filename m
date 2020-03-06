Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C4F17C24C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 16:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCFP4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 10:56:20 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53388 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726642AbgCFP4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:56:19 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 026FuBGe022773
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Mar 2020 10:56:12 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8B97642045B; Fri,  6 Mar 2020 10:56:11 -0500 (EST)
Date:   Fri, 6 Mar 2020 10:56:11 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
Message-ID: <20200306155611.GA167883@mit.edu>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:35:41AM -0500, Josef Bacik wrote:
> This has been a topic that I've been thinking about a lot recently, mostly
> because of the giant amount of work that has been organizing LSFMMBPF.  I
> was going to wait until afterwards to bring it up, hoping that maybe it was
> just me being done with the whole process and that time would give me a
> different perspective, but recent discussions has made it clear I'm not the
> only one.....

I suggest that we try to decouple the question of should we have
LSF/MM/BPF in 2020 and COVID-19, with the question of what should
LSF/MM/BPF (perhaps in some transfigured form) should look like in
2021 and in the future.

A lot of the the concerns expressed in this e-mails are ones that I
have been concerned about, especially:

> 2) There are so many of us....

> 3) Half the people I want to talk to aren't even in the room.  This may be a
> uniquely file system track problem, but most of my work is in btrfs, and I
> want to talk to my fellow btrfs developers....

> 4) Presentations....

These *exactly* mirror the dynamic that we saw with the Kernel Summit,
and how we've migrated to a the Maintainer's Summit with a Kernel
centric track which is currently colocated with Plumbers.

I think it is still useful to have something where we reach consensus
on multi-subsystem contentious changes.  But I think those topics
could probably fit within a day or maybe a half day.  Does that sound
familiar?  That's essentially what we now have with the Maintainer'st
Summit.

The problem with Plumbers is that it's really, really full.  Not
having invitations doesn't magically go away; Plumbers last year had
to deal with long waitlist, and strugglinig to make sure that all of
the critical people who need be present so that the various Miniconfs
could be successful.

This is why I've been pushing so hard for a second Linux systems
focused event in the first half of the year.  I think if we colocate
the set of topics which are currently in LSF/MM, the more file system
specific presentations, the ext4/xfs/btrfs mini-summits/working
sessions, and the maintainer's summit / kernel summit, we would have
critical mass.  And I am sure there will be *plenty* of topics left
over for Plumbers.

Cheers,

						- Ted
