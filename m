Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923C316AA13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 16:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBXP2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 10:28:53 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36823 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgBXP2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:28:53 -0500
Received: by mail-io1-f68.google.com with SMTP id d15so10669487iog.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2020 07:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPLy+I1kf18awADSJ+a+kXYkss5ko3QnxlgaP18iAaI=;
        b=hR91BNo0v9W2lKGsQ+28dV2f5cukj0J5Cq2WtUwQzy8DbroeQONE8wkNp/8DXGAj0b
         wS2gR97Spg4fao+tg+p7ub4Y30ipXiXecLYvggLQhPDsYbVIzad1QzrJYKXyFNitudhw
         elclO4ETUa54GEeb88QHzma/x6byZ9ENFz9rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPLy+I1kf18awADSJ+a+kXYkss5ko3QnxlgaP18iAaI=;
        b=fMghMyJ+YjPLO4hXHyybvkTd5g9lOzKQQbLm0clQ+DMMbXTbgmFlXUjMwfbA6rkExt
         aTor/0ieVaKcdF8Pr/LFAowB6Qr5YeFTAKpaewfqgK7hyYn8lXR4Qn2/F+4LJ1ZwjB6P
         ch09Fkr7cAu6IEqEiuY72OuRryN0hYl31I7MY+J9OV0qr4YEgHvcsFRM8zPuWZ86goZ8
         4pv0vRUOYldLphahzNAZlniEpRW9xHXgBNyDJhzF3q6jrpE3eejDhEiodTcDOtD/4T7+
         VG7iKPuOY2Y++9mFleB182QOTTeRzNAbXZzfwFxAA7Wrwnx227/Kc1DK/8maKPnk/n/W
         1VzQ==
X-Gm-Message-State: APjAAAWGwGahbncNlZ1TIYSigXKA+7iXnbMx8tpOdZlRxvUh7R7r66zz
        kZz7dqusMKCykuTYW+ZC8TFfgiVlb65PJOcLDHkKtA==
X-Google-Smtp-Source: APXvYqyvNJZ5VSWFSREvni1YMdamiTezkJiBrYDHxTOY/6jEk+6CRYsk62v8jxoGiT8VHnrEWrOj1S3gMbDf4tiBSQw=
X-Received: by 2002:a02:cc59:: with SMTP id i25mr50551851jaq.78.1582558131274;
 Mon, 24 Feb 2020 07:28:51 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com>
In-Reply-To: <1582556135.3384.4.camel@HansenPartnership.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Feb 2020 16:28:40 +0100
Message-ID: <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 3:55 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

> Once it's table driven, certainly a sysfs directory becomes possible.
> The problem with ST_DEV is filesystems like btrfs and xfs that may have
> multiple devices.

For XFS there's always  a single sb->s_dev though, that's what st_dev
will be set to on all files.

Btrfs subvolume is sort of a lightweight superblock, so basically all
such st_dev's are aliases of the same master superblock.  So lookup of
all subvolume st_dev's could result in referencing the same underlying
struct super_block (just like /proc/$PID will reference the same
underlying task group regardless of which of the task group member's
PID is used).

Having this info in sysfs would spare us a number of issues that a set
of new syscalls would bring.  The question is, would that be enough,
or is there a reason that sysfs can't be used to present the various
filesystem related information that fsinfo is supposed to present?

Thanks,
Miklos
