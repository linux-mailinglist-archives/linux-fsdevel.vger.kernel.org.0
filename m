Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135A043CA43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 15:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbhJ0NFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 09:05:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57904 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhJ0NFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:05:45 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 96E881F44480;
        Wed, 27 Oct 2021 14:03:18 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v9 00/31] file system-wide error monitoring
Organization: Collabora
References: <20211025192746.66445-1-krisman@collabora.com>
        <CAOQ4uxhth8NP4hS53rhLppK9_8ET41yrAx5d98s1uhSqrSzVHg@mail.gmail.com>
        <20211027112243.GE28650@quack2.suse.cz>
        <CAOQ4uxgUdvAx6rWTYMROFDX8UOd8eVzKhDcpB0Qne1Uk9oOMAw@mail.gmail.com>
Date:   Wed, 27 Oct 2021 10:03:13 -0300
In-Reply-To: <CAOQ4uxgUdvAx6rWTYMROFDX8UOd8eVzKhDcpB0Qne1Uk9oOMAw@mail.gmail.com>
        (Amir Goldstein's message of "Wed, 27 Oct 2021 15:36:38 +0300")
Message-ID: <87y26ed3hq.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Wed, Oct 27, 2021 at 2:22 PM Jan Kara <jack@suse.cz> wrote:
>>
>> On Tue 26-10-21 12:12:38, Amir Goldstein wrote:
>> > On Mon, Oct 25, 2021 at 10:27 PM Gabriel Krisman Bertazi
>> > <krisman@collabora.com> wrote:
>> > >
>> > > Hi,
>> > >
>> > > This is the 9th version of this patch series.  Thank you, Amir, Jan and
>> > > Ted, for the feedback in the previous versions.
>> > >
>> > > The main difference in this version is that the pool is no longer
>> > > resizeable nor limited in number of marks, even though we only
>> > > pre-allocate 32 slots.  In addition, ext4 was modified to always return
>> > > non-zero errno, and the documentation was fixed accordingly (No longer
>> > > suggests we return EXT4_ERR* values.
>> > >
>> > > I also droped the Reviewed-by tags from the ext4 patch, due to the
>> > > changes above.
>> > >
>> > > Please let me know what you think.
>> > >
>> >
>> > All good on my end.
>> > I've made a couple of minor comments that
>> > could be addressed on commit if no other issues are found.
>>
>> All good on my end as well. I've applied all the minor updates, tested the
>> result and pushed it out to fsnotify branch of my tree. WRT to your new
>> FS_ERROR LTP tests, I've noticed that the testcases 1 and 3 from test
>> fanotify20 fail for me. After a bit of debugging this seems to be a bug in
>> ext4 where it calls ext4_abort() with EXT4_ERR_ESHUTDOWN instead of plain
>> ESHUTDOWN. Not sure if you have that fixed or how come the tests passed for
>> you. After fixing that ext4 bug everything passes for me.
>>
>
> Gabriel mentioned that bug in the cover letter of the LTP series :-)
> https://lore.kernel.org/linux-ext4/20211026173302.84000-1-krisman@collabora.com/T/#u

Yes :)

Also, thank you both for the extensive review and ideas during the
development of this series.  It was really appreciated!

I'm sending out the new version for tests + man pages today.

-- 
Gabriel Krisman Bertazi
