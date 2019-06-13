Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9B944EDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 00:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfFMV75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 17:59:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:39798 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfFMV75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:59:57 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hbXlC-0003f5-9X; Thu, 13 Jun 2019 15:59:54 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hbXl1-0005In-SA; Thu, 13 Jun 2019 15:59:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <20190612225431.p753mzqynxpsazb7@brauner.io>
        <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
        <20190613132250.u65yawzvf4voifea@brauner.io>
        <871rzxwcz7.fsf@xmission.com>
        <CAJfpegvZwDY+zoWjDTrPpMCS01rzQgeE-_z-QtGfvcRnoamzgg@mail.gmail.com>
Date:   Thu, 13 Jun 2019 16:59:24 -0500
In-Reply-To: <CAJfpegvZwDY+zoWjDTrPpMCS01rzQgeE-_z-QtGfvcRnoamzgg@mail.gmail.com>
        (Miklos Szeredi's message of "Thu, 13 Jun 2019 22:25:44 +0200")
Message-ID: <878su5tadf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hbXl1-0005In-SA;;;mid=<878su5tadf.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/SZanX4kiIZau4CCkkUy83QNZgHjgF9e8=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_12
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <miklos@szeredi.hu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 9982 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 2.8 (0.0%), b_tie_ro: 1.93 (0.0%), parse: 1.07
        (0.0%), extract_message_metadata: 18 (0.2%), get_uri_detail_list: 3.8
        (0.0%), tests_pri_-1000: 18 (0.2%), tests_pri_-950: 1.07 (0.0%),
        tests_pri_-900: 0.82 (0.0%), tests_pri_-90: 27 (0.3%), check_bayes: 26
        (0.3%), b_tokenize: 8 (0.1%), b_tok_get_all: 10 (0.1%), b_comp_prob:
        2.8 (0.0%), b_tok_touch_all: 4.0 (0.0%), b_finish: 0.66 (0.0%),
        tests_pri_0: 3411 (34.2%), check_dkim_signature: 0.66 (0.0%),
        check_dkim_adsp: 3018 (30.2%), poll_dns_idle: 9496 (95.1%),
        tests_pri_10: 2.8 (0.0%), tests_pri_500: 6496 (65.1%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: Regression for MS_MOVE on kernel v5.1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Thu, Jun 13, 2019 at 8:35 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Christian Brauner <christian@brauner.io> writes:
>>
>> > On Wed, Jun 12, 2019 at 06:00:39PM -1000, Linus Torvalds wrote:
>> >> On Wed, Jun 12, 2019 at 12:54 PM Christian Brauner <christian@brauner.io> wrote:
>> >> >
>> >> > The commit changes the internal logic to lock mounts when propagating
>> >> > mounts (user+)mount namespaces and - I believe - causes do_mount_move()
>> >> > to fail at:
>> >>
>> >> You mean 'do_move_mount()'.
>> >>
>> >> > if (old->mnt.mnt_flags & MNT_LOCKED)
>> >> >         goto out;
>> >> >
>> >> > If that's indeed the case we should either revert this commit (reverts
>> >> > cleanly, just tested it) or find a fix.
>> >>
>> >> Hmm.. I'm not entirely sure of the logic here, and just looking at
>> >> that commit 3bd045cc9c4b ("separate copying and locking mount tree on
>> >> cross-userns copies") doesn't make me go "Ahh" either.
>> >>
>> >> Al? My gut feel is that we need to just revert, since this was in 5.1
>> >> and it's getting reasonably late in 5.2 too. But maybe you go "guys,
>> >> don't be silly, this is easily fixed with this one-liner".
>> >
>> > David and I have been staring at that code today for a while together.
>> > I think I made some sense of it.
>> > One thing we weren't absolutely sure is if the old MS_MOVE behavior was
>> > intentional or a bug. If it is a bug we have a problem since we quite
>> > heavily rely on this...
>>
>> It was intentional.
>>
>> The only mounts that are locked in propagation are the mounts that
>> propagate together.  If you see the mounts come in as individuals you
>> can always see/manipulate/work with the underlying mount.
>>
>> I can think of only a few ways for MNT_LOCKED to become set:
>> a) unshare(CLONE_NEWNS)
>> b) mount --rclone /path/to/mnt/tree /path/to/propagation/point
>> c) mount --move /path/to/mnt/tree /path/to/propgation/point
>>
>> Nothing in the target namespace should be locked on the propgation point
>> but all of the new mounts that came across as a unit should be locked
>> together.
>
> Locked together means the root of the new mount tree doesn't have
> MNT_LOCKED set, but all mounts below do have MNT_LOCKED, right?
>
> Isn't the bug here that the root mount gets MNT_LOCKED as well?

Yes, and the code to remove MNT_LOCKED is still sitting there in
propogate_one right after it calls copy_tree.  It should be a trivial
matter of moving that change to after the lock_mnt_tree call.

Now that I have been elightened about anonymous mount namespaces
I am suspecting that we want to take the user_namespace of the anonymous
namespace into account when deciding to lock the mounts.

>> Then it breaking is definitely a regression that needs to be fixed.
>>
>> I believe the problematic change as made because the new mount
>> api allows attaching floating mounts.  Or that was the plan last I
>> looked.   Those floating mounts don't have a mnt_ns so will result
>> in a NULL pointer dereference when they are attached.
>
> Well, it's called anonymous namespace.  So there *is* an mnt_ns, and
> its lifetime is bound to the file returned by fsmount().

Interesting.  That has changed since I last saw the patches.

Below is what will probably be a straight forward fix for the regression.

Eric

diff --git a/fs/namespace.c b/fs/namespace.c
index ffb13f0562b0..a39edeecbc46 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2105,6 +2105,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
                /* Notice when we are propagating across user namespaces */
                if (child->mnt_parent->mnt_ns->user_ns != user_ns)
                        lock_mnt_tree(child);
+               child->mnt.mnt_flags &= ~MNT_LOCKED;
                commit_tree(child);
        }
        put_mountpoint(smp);
diff --git a/fs/pnode.c b/fs/pnode.c
index 7ea6cfb65077..012be405fec0 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -262,7 +262,6 @@ static int propagate_one(struct mount *m)
        child = copy_tree(last_source, last_source->mnt.mnt_root, type);
        if (IS_ERR(child))
                return PTR_ERR(child);
-       child->mnt.mnt_flags &= ~MNT_LOCKED;
        mnt_set_mountpoint(m, mp, child);
        last_dest = m;
        last_source = child;


