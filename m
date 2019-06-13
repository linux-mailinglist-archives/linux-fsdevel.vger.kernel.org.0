Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3876244AC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 20:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfFMSfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 14:35:14 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57340 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfFMSfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:35:13 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hbUZ5-000421-61; Thu, 13 Jun 2019 12:35:11 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hbUZ4-0007q5-8w; Thu, 13 Jun 2019 12:35:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <20190612225431.p753mzqynxpsazb7@brauner.io>
        <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
        <20190613132250.u65yawzvf4voifea@brauner.io>
Date:   Thu, 13 Jun 2019 13:34:52 -0500
In-Reply-To: <20190613132250.u65yawzvf4voifea@brauner.io> (Christian Brauner's
        message of "Thu, 13 Jun 2019 15:22:51 +0200")
Message-ID: <871rzxwcz7.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hbUZ4-0007q5-8w;;;mid=<871rzxwcz7.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+JzB9Pk1jfWwta+BptGM8qAR+dHIiNwEY=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_12,
        T_XMDrugObfuBody_14 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christian Brauner <christian@brauner.io>
X-Spam-Relay-Country: 
X-Spam-Timing: total 534 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.7 (0.5%), b_tie_ro: 1.72 (0.3%), parse: 1.19
        (0.2%), extract_message_metadata: 13 (2.4%), get_uri_detail_list: 2.6
        (0.5%), tests_pri_-1000: 5 (1.0%), tests_pri_-950: 1.37 (0.3%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 43 (8.0%), check_bayes: 41
        (7.6%), b_tokenize: 17 (3.1%), b_tok_get_all: 11 (2.1%), b_comp_prob:
        5 (0.9%), b_tok_touch_all: 4.3 (0.8%), b_finish: 0.70 (0.1%),
        tests_pri_0: 456 (85.4%), check_dkim_signature: 0.84 (0.2%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.35 (0.1%), tests_pri_10:
        2.00 (0.4%), tests_pri_500: 6 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Regression for MS_MOVE on kernel v5.1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> On Wed, Jun 12, 2019 at 06:00:39PM -1000, Linus Torvalds wrote:
>> On Wed, Jun 12, 2019 at 12:54 PM Christian Brauner <christian@brauner.io> wrote:
>> >
>> > The commit changes the internal logic to lock mounts when propagating
>> > mounts (user+)mount namespaces and - I believe - causes do_mount_move()
>> > to fail at:
>> 
>> You mean 'do_move_mount()'.
>> 
>> > if (old->mnt.mnt_flags & MNT_LOCKED)
>> >         goto out;
>> >
>> > If that's indeed the case we should either revert this commit (reverts
>> > cleanly, just tested it) or find a fix.
>> 
>> Hmm.. I'm not entirely sure of the logic here, and just looking at
>> that commit 3bd045cc9c4b ("separate copying and locking mount tree on
>> cross-userns copies") doesn't make me go "Ahh" either.
>> 
>> Al? My gut feel is that we need to just revert, since this was in 5.1
>> and it's getting reasonably late in 5.2 too. But maybe you go "guys,
>> don't be silly, this is easily fixed with this one-liner".
>
> David and I have been staring at that code today for a while together.
> I think I made some sense of it.
> One thing we weren't absolutely sure is if the old MS_MOVE behavior was
> intentional or a bug. If it is a bug we have a problem since we quite
> heavily rely on this...

It was intentional.

The only mounts that are locked in propagation are the mounts that
propagate together.  If you see the mounts come in as individuals you
can always see/manipulate/work with the underlying mount.

I can think of only a few ways for MNT_LOCKED to become set:
a) unshare(CLONE_NEWNS)
b) mount --rclone /path/to/mnt/tree /path/to/propagation/point
c) mount --move /path/to/mnt/tree /path/to/propgation/point

Nothing in the target namespace should be locked on the propgation point
but all of the new mounts that came across as a unit should be locked
together.

> So this whole cross-user+mnt namespace propagation mechanism comes with
> a big hammer that Eric indeed did introduce a while back which is
> MNT_LOCKED (cf. [1] for the relevant commit).
>
> Afaict, MNT_LOCKED is (among other cases) supposed to prevent a user+mnt
> namespace pair to get access to a mount that is hidden underneath an
> additional mount. Consider the following scenario:
>
> sudo mount -t tmpfs tmpfs /mnt
> sudo mount --make-rshared /mnt
> sudo mount -t tmpfs tmpfs /mnt
> sudo mount --make-rshared /mnt
> unshare -U -m --map-root --propagation=unchanged
>
> umount /mnt
> # or
> mount --move -mnt /opt
>
> The last umount/MS_MOVE is supposed to fail since the mount is locked
> with MNT_LOCKED since umounting or MS_MOVing the mount would reveal the
> underlying mount which I didn't have access to prior to the creation of
> my user+mnt namespace pair.
> (Whether or not this is a reasonable security mechanism is a separate
> discussion.)
>
> But now consider the case where from the ancestor user+mnt namespace
> pair I do:
>
> # propagate the mount to the user+mount namespace pair                 
> sudo mount -t tmpfs tmpfs /mnt
> # switch to the child user+mnt namespace pair
> umount /mnt
> # or
> mount --move /mnt /opt
>
> That umount/MS_MOVE should work since that mount was propagated to the
> unprivileged task after the user+mnt namespace pair was created.
> Also, because I already had access to the underlying mount in the first
> place and second because this is literally the only way - we know of -
> to inject a mount cross mount namespaces and this is a must have feature
> that quite a lot of users rely on.

Then it breaking is definitely a regression that needs to be fixed.

I believe the problematic change as made because the new mount
api allows attaching floating mounts.  Or that was the plan last I
looked.   Those floating mounts don't have a mnt_ns so will result
in a NULL pointer dereference when they are attached.

So I suspect fixing this is not as simple as reverting a single patch.

Eric
