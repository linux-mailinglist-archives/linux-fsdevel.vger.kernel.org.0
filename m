Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A429B16EA16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 16:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgBYP27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 10:28:59 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53494 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730777AbgBYP27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:28:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 765FB8EE182;
        Tue, 25 Feb 2020 07:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582644538;
        bh=PkpUkxLpGWOdx6HfrHxNBnALquJdf02iFDN5a3jW11U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Mpw1M92xQnIy2vMoW7fwE3YGPeYa1T3tnUWgUT1KOIAPglW1xtRTovgvRMHTATHWX
         tH9f9t6iy0WtBkrXHB7Fy1GALE/eY1s2lIgwU4D//c3UtDSphCq4YvDs/C3yvcVMny
         TnQqyrVLknCLhPntq34+IVQ8X3ryPHD9DP7Q+nAY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id maiN6ePynVDb; Tue, 25 Feb 2020 07:28:57 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3E9738EE17D;
        Tue, 25 Feb 2020 07:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582644537;
        bh=PkpUkxLpGWOdx6HfrHxNBnALquJdf02iFDN5a3jW11U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wneVPa161HTFmd39fucopQFeRuZ1hih/9tGkAzwnfjfGuSw8KaUSra/eBTrcIar3b
         eF+jTeU+nVSzkwRQddN2LkPHuJZYSWHv/zjSG+Ud77XTIFE6jA/FLNjINQmVpLV/CI
         L1jmQFh5Tr5lfu/8IgtyuEbON/QLRWVKgUXWxAVQ=
Message-ID: <1582644535.3361.8.camel@HansenPartnership.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Feb 2020 07:28:55 -0800
In-Reply-To: <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
         <1582316494.3376.45.camel@HansenPartnership.com>
         <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
         <1582556135.3384.4.camel@HansenPartnership.com>
         <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
         <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-02-25 at 12:13 +0000, Steven Whitehouse wrote:
> Hi,
> 
> On 24/02/2020 15:28, Miklos Szeredi wrote:
> > On Mon, Feb 24, 2020 at 3:55 PM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > > Once it's table driven, certainly a sysfs directory becomes
> > > possible. The problem with ST_DEV is filesystems like btrfs and
> > > xfs that may have multiple devices.
> > 
> > For XFS there's always  a single sb->s_dev though, that's what
> > st_dev will be set to on all files.
> > 
> > Btrfs subvolume is sort of a lightweight superblock, so basically
> > all such st_dev's are aliases of the same master superblock.  So
> > lookup of all subvolume st_dev's could result in referencing the
> > same underlying struct super_block (just like /proc/$PID will
> > reference the same underlying task group regardless of which of the
> > task group member's PID is used).
> > 
> > Having this info in sysfs would spare us a number of issues that a
> > set of new syscalls would bring.  The question is, would that be
> > enough, or is there a reason that sysfs can't be used to present
> > the various filesystem related information that fsinfo is supposed
> > to present?
> > 
> > Thanks,
> > Miklos
> > 
> 
> We need a unique id for superblocks anyway. I had wondered about
> using s_dev some time back, but for the reasons mentioned earlier in
> this thread I think it might just land up being confusing and
> difficult to manage. While fake s_devs are created for sbs that don't
> have a device, I can't help thinking that something closer to
> ifindex, but for superblocks, is needed here. That would avoid the
> issue of which device number to use.
> 
> In fact we need that anyway for the notifications, since without
> that  there is a race that can lead to missing remounts of the same
> device, in  case a umount/mount pair is missed due to an overrun, and
> then fsinfo returns the same device as before, with potentially the
> same mount options too. So I think a unique id for a superblock is a
> generically useful feature, which would also allow for sensible sysfs
> directory naming, if required,

But would this be informative and useful for the user?  I'm sure we can
find a persistent id for a persistent superblock, but what about tmpfs
... that's going to have to change with every reboot.  It's going to be
remarkably inconvenient if I want to get fsinfo on /run to have to keep
finding what the id is.

The other thing a file descriptor does that sysfs doesn't is that it
solves the information leak: if I'm in a mount namespace that has no
access to certain mounts, I can't fspick them and thus I can't see the
information.  By default, with sysfs I can.

James

