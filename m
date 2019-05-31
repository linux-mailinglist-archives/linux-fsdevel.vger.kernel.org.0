Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA87B31131
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 17:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfEaPV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 11:21:57 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33810 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfEaPV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 11:21:57 -0400
Received: by mail-yw1-f68.google.com with SMTP id n76so4287627ywd.1;
        Fri, 31 May 2019 08:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hVB+3wva8lYYaR85t5N42o/6t3+e71DhQnwd4VnHZ2s=;
        b=cauG1fiQiQ8aQQCenQLcHSPvx0I4gcwkiAsElwldIFkEwXd6bYpDga4KE1UvqPxFYC
         C8/0vrf8SnlO5U59qZrpnpGjhw5zk8B7tlhZVZRPNe5eBn8+dsEMlymmRjxE6XAUo8Rw
         89R6HOiMiLK/x6SZZLku+9dBLsBrO0EkuRiGBtzTpuZ9T8+dsuYh+F8koLzFKFj9gxLV
         rSNEGiJfEK1+a7Ch9m7iB8v80YQyb7g3nwL86B6ImAWB8wkibU6jLHFhJZt0rhlwAYfe
         VZa78TlWWnngrFEhPzRJrqciRm+n6AvzQdvQckUGzVxmq3lL+wpgUSSQAn2bGqKQRwEe
         t82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVB+3wva8lYYaR85t5N42o/6t3+e71DhQnwd4VnHZ2s=;
        b=H72TB05u5pYQneDC07Bvl1/fvkhke8w1+dqcJa64WBg0Z8uD5Lghd1F8qIXdRT1LAa
         gZr20WdGv184b0Ce6F8v/+Jd5BdfkHzvFgStUUyIIfwf7Y+7E5L1JYtvQ9m9V3iALTFh
         YSU7sF/1el3tnswVj8A7Pz10vgysfL604fif/owBMaBTOSpMg12Z+a0os9UX9xu+0A3o
         EG63JExlaaA821n1v1nDzvfg0508CSIG4jmEH9ebOTTmefIDCeN6NnmklOQtxv2mepYu
         0AhtpjetvZMRooUgAnRhWOlP+kThhPF0PXZvWHrpHogXR8zDdaXTWIuy87TA6wzNbUe5
         8MjQ==
X-Gm-Message-State: APjAAAXgALxsnD6DPRzB7h+wj8Uxl77P20VpCdsUL8Fq9MyJiSHu/M+I
        AhM00izP88U5skJjcgOoXSIv3lJqjEN/QH1aYtA=
X-Google-Smtp-Source: APXvYqzweoHJN024aJFPsVRMFJeZ7erwv8ogr3cR1VHrvMTSMSfOoUXoORxVBwUVuv3Wftm9yea1zNU3KdGTZeHMwbg=
X-Received: by 2002:a81:7096:: with SMTP id l144mr6198986ywc.294.1559316116397;
 Fri, 31 May 2019 08:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190527172655.9287-1-amir73il@gmail.com> <20190528202659.GA12412@mit.edu>
 <CAOQ4uxgo5jmwQbLAKQre9=7pLQw=CwMgDaWPaJxi-5NGnPEVPQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgo5jmwQbLAKQre9=7pLQw=CwMgDaWPaJxi-5NGnPEVPQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 31 May 2019 18:21:45 +0300
Message-ID: <CAOQ4uxgj94WR82iHE4PDGSD0UDxG5sCtr+Sv+t1sOHHmnXFYzQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >
> > So instead of saying "A filesystem that accepts this flag will
> > guaranty, that old inode data will not be exposed in the new linked
> > name."  It's much clearer to state this in the affirmative:
> >
> >         A filesystem which accepts this flag will guarantee that if
> >         the new pathname exists after a crash, all of the data written
> >         to the file at the time of the linkat(2) call will be visible.
> >
>
> Sounds good to me. I will take a swing at another patch.
>

So I am down to single flag documented with 3 tweets ;-)

What do you think of:

"AT_ATOMIC_DATA (since Linux 5.x)
A filesystem which accepts this flag will guarantee that if the linked file
name exists after a system crash, then all of the data written to the file
and all of the file's metadata at the time of the linkat(2) call will be
visible.

The way to achieve this guarantee on old kernels is to call fsync (2)
before linking the file, but doing so will also results in flushing of
volatile disk caches.

A filesystem which accepts this flag does NOT
guarantee that any of the file hardlinks will exist after a system crash,
nor that the last observed value of st_nlink (see stat (2)) will persist."


Thanks,
Amir.
