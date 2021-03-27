Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406AC34B59A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 10:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhC0JPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 05:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhC0JPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 05:15:03 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B908C0613B1;
        Sat, 27 Mar 2021 02:15:03 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id r17so923688ilt.0;
        Sat, 27 Mar 2021 02:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lRguUrj+Do6M5eEzfByFdFuJEjwyRduDVTOBo9yEBo=;
        b=R/djMivm1iqsiXDOdVttTn+WEjCJOgRN8UdEAeyFGNffTlkfYDfPKRJk+shqQiIsGU
         v/2LReRniz/yq0V/ZxnQXa5FkNLlXC8Vpf/6k5U8mDkxLLHvXlqXVpGV9PjfW5kvzXLl
         lEBa96ebdAIVcpKU1B4KRketUqzlfFQcTxxP31JkWZ9kvcyd/4qrGvQRUAk9Wof9rCj3
         tPisCQ9QFA0FaAX/phRb84RPvRdN4N8BtbiBU09F90pFtdEIW79ZKVmFv83t8YglCM2u
         UQyXTZj4lqWw1tzRFOULdBALLRYeU5CDAV+i5dGfDDHuiQItnlw9QoTVRNhUbMGtbztG
         AThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lRguUrj+Do6M5eEzfByFdFuJEjwyRduDVTOBo9yEBo=;
        b=bwVbJNzC6dlYWSZB6YRFj30Ff5mTDwx5/gFqwJTTmPCiTC6R3v3F2UtYu97/EIJ89c
         KXlvWnCTAEkyt5zKCwb2+4XYt/cgVab+c0v020iR/8sAgrY3qBRbBEIK4f/5fBW+5cBf
         LsNNQ9v87m2/lSX8ePbRvzzuLH5FjDcuX+PNa88Jz9pXP9GiGzmqaniN/pFaLyHWEPCv
         dMnTzdnu3obPSF1A3MoZ0wO8dNibaMtlwecwPWtzAs1AJ33Y8mLlWiIazGr+k/ki6R06
         wa4RqNyYLyRVaw4c+pJLOL/xJN0QK1HdmTEi8q7Lpm27JYmokqi6gEKQEjyQ9zmaWqKz
         0ZRQ==
X-Gm-Message-State: AOAM5330VUDkYmZKkw0lQ6iwZyoeMK0HSiMY7pjskk9HJHYIv5DgUO+g
        9bJB6RBXw+B7xsprClUnou9Mu5lvZqm0CGxEC/o=
X-Google-Smtp-Source: ABdhPJwXJobi6g1SYm1vNWyXXBov4yK4w6+Z/J2j0vbdbl3eKOz+P1yYCf1tvpKvJkHLwY1759AubGMZ1iRWxeKaR9Q=
X-Received: by 2002:a92:b74e:: with SMTP id c14mr7869202ilm.275.1616836502466;
 Sat, 27 Mar 2021 02:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210322171118.446536-1-amir73il@gmail.com> <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
 <20210323072607.GF63242@dread.disaster.area> <CAOQ4uxgAddAfGkA7LMTPoBmrwVXbvHfnN8SWsW_WXm=LPVmc7Q@mail.gmail.com>
 <20210324005421.GK63242@dread.disaster.area> <CAOQ4uxhhMVQ4XE8DMU1EjaXBo-go3_pFX3CCWn=7GuUXcMW=PA@mail.gmail.com>
 <20210325225305.GM63242@dread.disaster.area> <CAOQ4uxgAxUORpUJezg+oWKXEafn0o33+bP5EN+VKnoQA_KurOg@mail.gmail.com>
 <YF5ha6TZlVocDpSY@mit.edu>
In-Reply-To: <YF5ha6TZlVocDpSY@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 27 Mar 2021 12:14:51 +0300
Message-ID: <CAOQ4uxiz4hjMSd9POFF-vjpCPZ42MbpJ5K5_xO1sApRbDhcbCg@mail.gmail.com>
Subject: Re: [PATCH] xfs: use a unique and persistent value for f_fsid
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 27, 2021 at 1:34 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> I've been reading through this whole thread, and it appears to me that
> the only real, long-term solution is to rely on file system UUID's
> (for those file systems that support real 128-bit UUID's), and
> optionally, for those file systems which support it, a new, "snapshot"
> or "fs-instance" UUID.
>
> The FS UUID is pretty simple; we just need an ioctl (or similar
> interface) which returns the UUID for a particular file system.
>
> The Snapshot UUID is the one which is bit trickier.  If the underlying
> block device can supply something unique --- for example, the WWN or
> WWID which is defined by FC, ATA, SATA, SCSI, NVMe, etc. then that
> plus a partition identifier could be hashed to form a Snapshot UUID.
> LVM volumes have a LV UUID that could be used for a similar purpose.
>
> If you have a block device which doesn't relibly provide a WWN or
> WWID, or we could could imagine that a file system has a field in the
> superblock, and a file system specific program could get used to set
> that field to a random UUID, and that becomes part of the snapshot
> process.  This may be problematic for remote/network file systems
> which don't have such a concept, but life's a bitch....
>
> With that, then userspace can fetch the st_dev, st_ino, the FS UUID,
> and the Snapshot UUID, and use some combination of those fields (as
> available) to try determine whether two objects are unique or not.
>
> Is this perfect?  Heck, no.  But ultimately, this is a hard problem,
> and trying to wave our hands and create something that works given one
> set of assumptions --- and completely breaks in a diferent operating
> environment --- is going lead to angry users blaming the fs
> developers.  It's a messy problem, and I think all we can do is expose
> the entire mess to userspace, and make it be a userspace problem.
> That way, the angry users can blame the userspace developers instead.  :-)

Sounds like a plan ;-)

FWIW, if and when we will have a standard userspace API (fsinfo()?) to
export fs instance uuid to userspace, fanotify can use the uuid instead of
fsid when available (opt-in by new faotify_init() flag).

The fanotify_event_info_header contains an "info_type" field, so it's not
a problem for some events to report fsid (as today) and for other events
to report uuid, depending on availability of the information per filesystem.

Thanks,
Amir.
