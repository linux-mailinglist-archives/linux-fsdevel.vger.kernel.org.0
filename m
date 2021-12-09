Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDBE46F68F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 23:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhLIWOj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 17:14:39 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57831 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231334AbhLIWOi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:14:38 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-106.corp.google.com [104.133.8.106] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B9M9tbh002091
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Dec 2021 17:09:56 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DD76E4205DB; Thu,  9 Dec 2021 17:09:54 -0500 (EST)
Date:   Thu, 9 Dec 2021 17:09:54 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v4 00/13] ext4: new mount API conversion
Message-ID: <YbJ+slpTZvsaDMPd@mit.edu>
References: <20211027141857.33657-1-lczerner@redhat.com>
 <YbJWN+6nmhpQOZR1@mit.edu>
 <20211209195520.z7vv4jtvgpu4omxx@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209195520.z7vv4jtvgpu4omxx@work>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 09, 2021 at 08:55:20PM +0100, Lukas Czerner wrote:
> > 
> > Should I use the v4 patch set or do you have a newer set of changes
> > that you'd like me to use?  There was a minor patch conflict in patch
> > #2, but that was pretty simple to fix up.
> 
> I don't have anything newer than this. I could rebase it if you'd like
> me to, but it sounds like you've already done that pretty easily?

Yep, I've done that and have run tests against it (including ext4/053
to test ext2/3/4 mount options).  I just haven't pushed it out pending
your confirmation that the v4 patchset was the one I should use.

Thanks!

						- Ted
