Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725F66E35FF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 10:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDPIK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 04:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjDPIKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:10:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE7B1996;
        Sun, 16 Apr 2023 01:10:53 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOiDX-1pzJ5l0uMh-00QDC7; Sun, 16
 Apr 2023 10:10:46 +0200
Message-ID: <9b689664-095c-f2cf-7ba5-86303df3722b@gmx.com>
Date:   Sun, 16 Apr 2023 16:10:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <Y/5ovz6HI2Z47jbk@magnolia>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [LSF TOPIC] online repair of filesystems: what next?
In-Reply-To: <Y/5ovz6HI2Z47jbk@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:V4pVXMCXojE0YM0/XA3/4hgs7OVEQjrjZ/Dfd2GhcVCBhjVDpcE
 Cv/VGvLswBB/oNNGDJK6w6abejLVPDkTgEQ4Q4ULNVylaDDoQiJ9RIUF+KLZfLMqNKfBjQe
 Y+d5EqAuhNONLnrxBTwhXJw1uVHLJCip+U3IDLHTCLVO3Z8bQ4gnimAwYPwuv4FwmcjL728
 gwgka44kXhlz/wJneNqQA==
UI-OutboundReport: notjunk:1;M01:P0:675/jOOtOH8=;n4XsUOlanE0Snd1VK1pjMQko73i
 lPfW19Vrvl8NjcWoR0P2fA5+CvYpAfKGlKtSjZQ2YNueFlIimRqcnBjjgQXL8Q80sUCmaOqPo
 IdOiqIX2Pvf/ZphRjp0Q/NXaxxh5cDtOcbXldJoUiNK6Pxvum1lp4gJqqU2v3vMsOW/pOdk5k
 TFekJDrsC+wUExpVEFIBk6Xj0nAaY4bLOnC/BgzGFz9H8l8x2jLtMPw/OKoXP8KFlFBhgXkGq
 A5gMW3TK4lmckY2xBKN1f8Yq9jdsctyAoMZCy0KOtZiWmUTy8mRcpdvrMndaErHG675420kqh
 8jg9RfHDLYqeOiURzII4LpA0LfKZH0n4yIv5Q0mtKD8FmCNPIxgoGSfvCoNTZX8IPLuhmkNw3
 NiwHHPA3G/P5VM+SeqlujSU+jCIM1kNIn80jBSksGFPyfoWtflkvezzFx7kIPEnLVUJm2IP38
 C2QukNZcCgxzRQdDkZV4yVd0J7+67KGZkFETgXy31pyEuKUyqkD11PHQ6Y4q4BkunNkz0KLZY
 yakdiCThY5pvX5DS+T++87pk7JZV+WjrnRdrgS0J3XiKZzrtNrAOJkJXduHq/LYqIBkQtc+w1
 bDj3E5Z1q4uRwcHf+oFVkofXpWompzGuMH75Gr4ek4rR71z8HRWHnHwqMvf8KMWT5AY5A+gm6
 DCcSmWt7eLV3cPxmfjVyiZ/VTiflmFpt/OTbfBmxovKRDKbthB6FALLJpJzy57jtpAPFEihPK
 BZxCWHuqV9qTTpy+ejY5pFHhwIWKFFTYPdzJtThfXv/YmbnquZaPBP46GHDMQ+MMiY2vKEzYT
 WObhC5MbmJ8RfEriJBQiG7z4pccrY9NMUkUPV74FOcJIVMy8vdlqJWUFAG8XU5TBIWi6YTdlf
 qETUXvgUwk3wfL4XsSorQOIH6JAbCyd6oW9je9WIFVTaCFS1/Z8D9ysP78jOiBqJm6ctSrzDk
 8oRZn/0SaofGGFCTVQbHmW8AATY=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/1 04:49, Darrick J. Wong wrote:
> Hello fsdevel people,
> 
> Five years ago[0], we started a conversation about cross-filesystem
> userspace tooling for online fsck.  I think enough time has passed for
> us to have another one, since a few things have happened since then:
> 
> 1. ext4 has gained the ability to send corruption reports to a userspace
>     monitoring program via fsnotify.  Thanks, Collabora!

Not familiar with the new fsnotify thing, any article to start?

I really believe we should have a generic interface to report errors, 
currently btrfs reports extra details just through dmesg (like the 
logical/physical of the corruption, reason, involved inodes etc), which 
is far from ideal.

> 
> 2. XFS now tracks successful scrubs and corruptions seen during runtime
>     and during scrubs.  Userspace can query this information.
> 
> 3. Directory parent pointers, which enable online repair of the
>     directory tree, is nearing completion.
> 
> 4. Dave and I are working on merging online repair of space metadata for
>     XFS.  Online repair of directory trees is feature complete, but we
>     still have one or two unresolved questions in the parent pointer
>     code.
> 
> 5. I've gotten a bit better[1] at writing systemd service descriptions
>     for scheduling and performing background online fsck.
> 
> Now that fsnotify_sb_error exists as a result of (1), I think we
> should figure out how to plumb calls into the readahead and writeback
> code so that IO failures can be reported to the fsnotify monitor.  I
> suspect there may be a few difficulties here since fsnotify (iirc)
> allocates memory and takes locks.
> 
> As a result of (2), XFS now retains quite a bit of incore state about
> its own health.  The structure that fsnotify gives to userspace is very
> generic (superblock, inode, errno, errno count).  How might XFS export
> a greater amount of information via this interface?  We can provide
> details at finer granularity -- for example, a specific data structure
> under an allocation group or an inode, or specific quota records.

The same for btrfs.

Some btrfs specific info like subvolume id is also needed to locate the 
corrupted inode (ino is not unique among the full fs, but only inside 
one subvolume).

And something like file paths for the corrupted inode is also very 
helpful for end users to locate (and normally delete) the offending inode.

> 
> With (4) on the way, I can envision wanting a system service that would
> watch for these fsnotify events, and transform the error reports into
> targeted repair calls in the kernel.

Btrfs has two ways of repair:

- Read time repair
   This happens automatically for both invovled data and metadata, as
   long as the fs is mount RW.

- Scrub time repair
   The repair is also automatic.
   The main difference is, scrub is manually triggered by user space.
   Otherwise it can be considered as a full read of the fs (both metadata
   and data).

But the repair of btrfs only involves using the extra copies, never 
intended to repair things like directories.
(That's still the work of btrfs-check, and the complex cross reference 
of btrfs is not designed to repair those problems at runtime)

Currently both repair would result a dmesg based report, while scrub has 
its own interface to report some very basis accounting, like how many 
sectors are corrupted, and how many are repaired.

A feature full and generic interface to report errors are definitely a 
good direction to go.

>  This of course would be very
> filesystem specific, but I would also like to hear from anyone pondering
> other usecases for fsnotify filesystem error monitors.

Btrfs also has an internal error counters, but that's accumulated value, 
sometimes it's not that helpful and can even be confusing.

If we have such interface, we can more or less get rid of the internal 
error counters, and rely on the user space to do the history recording.

> 
> Once (3) lands, XFS gains the ability to translate a block device IO
> error to an inode number and file offset, and then the inode number to a
> path.  In other words, your file breaks and now we can tell applications
> which file it was so they can failover or redownload it or whatever.
> Ric Wheeler mentioned this in 2018's session.

Yeah, if user space deamon can automatically (at least by some policy) 
delete offending files, it can be a great help.

As we have hit several reports that corrupted files (no extra copy to 
recover from) are preventing btrfs balance, and users have to locate the 
file from dmesg, and then delete the file and retry balancing.

Thus such interface can greatly improve the user experience.

Thanks,
Qu

> 
> The final topic from that 2018 session concerned generic wrappers for
> fsscrub.  I haven't pushed hard on that topic because XFS hasn't had
> much to show for that.  Now that I'm better versed in systemd services,
> I envision three ways to interact with online fsck:
> 
> - A CLI program that can be run by anyone.
> 
> - Background systemd services that fire up periodically.
> 
> - A dbus service that programs can bind to and request a fsck.
> 
> I still think there's an opportunity to standardize the naming to make
> it easier to use a variety of filesystems.  I propose for the CLI:
> 
> /usr/sbin/fsscrub $mnt that calls /usr/sbin/fsscrub.$FSTYP $mnt
> 
> For systemd services, I propose "fsscrub@<escaped mountpoint>".  I
> suspect we want a separate background service that itself runs
> periodically and invokes the fsscrub@$mnt services.  xfsprogs already
> has a xfs_scrub_all service that does that.  The services are nifty
> because it's really easy to restrict privileges, implement resource
> usage controls, and use private name/mountspaces to isolate the process
> from the rest of the system.
> 
> dbus is a bit trickier, since there's no precedent at all.  I guess
> we'd have to define an interface for filesystem "object".  Then we could
> write a service that establishes a well-known bus name and maintains
> object paths for each mounted filesystem.  Each of those objects would
> export the filesystem interface, and that's how programs would call
> online fsck as a service.
> 
> Ok, that's enough for a single session topic.  Thoughts? :)
> 
> --D
> 
> [0] https://lwn.net/Articles/754504/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-optimize-by-default
