Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C41E410757
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbhIRPWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 11:22:41 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:49598 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231204AbhIRPWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 11:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1631978473;
        bh=QvDphOJkD3SeOmzYBk6p6YyJAVO5fjRMOXMjB3iWIC4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=QSEaVC+MyxtDxSFWf9/db0YwieJISemIZaCjNMNngo9x9xmh/bJwWU7MaQKRDuuGm
         b0pTPjiFh7at5JYPZy2l1gcqD5Jfe3UMjeqWPwox0xGfwUKER3t5NI6SxRtV8cuofK
         jtr5gVYGm1xJRuc3DkmuGfO5TX6ooEmAPxzJ1wws=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AFC271280A32;
        Sat, 18 Sep 2021 08:21:13 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MDCnn48E2bYZ; Sat, 18 Sep 2021 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1631978473;
        bh=QvDphOJkD3SeOmzYBk6p6YyJAVO5fjRMOXMjB3iWIC4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=QSEaVC+MyxtDxSFWf9/db0YwieJISemIZaCjNMNngo9x9xmh/bJwWU7MaQKRDuuGm
         b0pTPjiFh7at5JYPZy2l1gcqD5Jfe3UMjeqWPwox0xGfwUKER3t5NI6SxRtV8cuofK
         jtr5gVYGm1xJRuc3DkmuGfO5TX6ooEmAPxzJ1wws=
Received: from jarvis.lan (c-67-166-170-96.hsd1.va.comcast.net [67.166.170.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DE92F12809EF;
        Sat, 18 Sep 2021 08:21:12 -0700 (PDT)
Message-ID: <fb7857e252b9b4577f9a677de28168c571244711.camel@HansenPartnership.com>
Subject: Re: [External] : Shameless plug for the FS Track at LPC next week!
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Sat, 18 Sep 2021 11:21:11 -0400
In-Reply-To: <20210917235007.GC10224@magnolia>
References: <20210916013916.GD34899@magnolia>
         <87ilz0afjt.fsf@debian-BULLSEYE-live-builder-AMD64>
         <20210917221124.GS2361455@dread.disaster.area>
         <20210917235007.GC10224@magnolia>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-09-17 at 16:50 -0700, Darrick J. Wong wrote:
> FWIW I'll try to commandeer one of the LPC hack rooms late Tuesday
> evening (say around 0200 UTC) if people are interested in XFS office
> hours?

The BBB Hack rooms of LPC will be available to all conference
participants at any hour.  However, we contracted with a third party
for the live streaming, so that will only happen within conference
hours.  We still have the streaming to Youtube infrastructure we used
last year, if you really want the hackroom streamed, but a member of
the LPC programme committee will need to be on hand to look after it
for you.  Part of our contract this year was a live stream to china
(great firewall blocks youtube) but our old stream infrastructure can't
reach that end point.

We can also make available BoF rooms that are open to all comers (the
hack rooms are only open to registered conference attendees) since I
know people who can't attend for timezone reasons won't want to stump
up the attendee fee.  Please email contact@linuxplumbersconf.org to
arrange a room if you want to do this.  Note that all rooms can be
recorded and the BBB recording made available to anyone (it's in BBB
format though, so can't be uploaded to youtube).

Regards,

James


