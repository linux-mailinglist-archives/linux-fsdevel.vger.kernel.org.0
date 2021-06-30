Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DBF3B7CDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 07:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhF3FNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 01:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhF3FNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 01:13:20 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837C3C061766;
        Tue, 29 Jun 2021 22:10:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a6so1733810ioe.0;
        Tue, 29 Jun 2021 22:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TwOTgfXi+shXUX1bdywFyVD0OPq8JVzqjg9/kRcoj8=;
        b=s02tSWDMYLUO/yPq6RDasC0+nvQ/FcjglFNR2jzgrSho317n/QGXVpDxg6Q6VLYQhn
         k1sfTuZ7nV5ocdy/RIL2XH5sn1MCNscUL8hPo+UKonuLcH6xGP879s5/sTpchoPYkbcp
         4oZD9H0Au+SOBUsqGN9/3ZV5mJ0kSwbiaotmrYsOwUeHd2NT8ZXvKbN8ZzbpQeYXAuwQ
         pN2HBBWBwkbXBtJ97BSuxSNDvZuiIA7xIJnprdV8dgJ92f7pgYUln2hcSH1evb2CTkQX
         tNW+dILeZnDZBfZt7C8Z6iu9gFZ/n4iYgGZvQUZbtbHVkirZBc0uX+xXUNWt/oTP4wWV
         JocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TwOTgfXi+shXUX1bdywFyVD0OPq8JVzqjg9/kRcoj8=;
        b=lmBM+bjKubRtQT8/HQAt6fy+s6V7JAZhqmEoxn7YzxNOOpT8oNj8yVbdkTxlGPi3mp
         uOST8GapMMGRfR8SYPj1IkSNXpYvf/i24GNwCQ4uSafTmVoKT44lTTydEd9cyDeb11pc
         vji5+yTwPsddBriuZSnK60RB84UBsXmJT9zyA66NHkInz3a4Gc5dss0tXWpzlQrrL9AG
         z1t7L2Z47D6NzBV35ixpy8Gacg3lGL7mz/1e06w5lAUsvVIw58LpfNnwVy9Sa4MbfcOc
         jXdVC2pzmxDTuBSy+OCV58/pQpoYCOZj8omhYIJHIsHzsVgLMqDRtNVRWooQt6VljQEj
         U6cg==
X-Gm-Message-State: AOAM531yzVjmG549kMiz4iAR0R1HwYoQT3O52/xbA3Y9M+EbdkiOWqZ1
        y3SGCs2yLX+OcGd6P5eRjlXfe9JTSQpIABL5+6k=
X-Google-Smtp-Source: ABdhPJznP3KVEFn5wIPYGZmIbPCiEpltZKJL2MEuIsziN6LREOeG9QCw9NTsxtqPEuoi4Xdlj0RIvvqKpBQHrL2NrC0=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr6439392ion.203.1625029850864;
 Tue, 29 Jun 2021 22:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com>
In-Reply-To: <20210629191035.681913-1-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 08:10:39 +0300
Message-ID: <CAOQ4uxgigXTtGgEC3yzt3f4HDHUiYqL7vk73v6E5LGx0OoFWHg@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] File system wide monitoring
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+CC linux-api

On Tue, Jun 29, 2021 at 10:10 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hi,
>
> This is the third version of the FAN_FS_ERROR patches.  The main change
> in this version is the inode information being reported through an FID
> record, which means it requires the group to be created with
> FAN_REPORT_FID.  It indeed simplifies a lot the FAN_FS_ERROR patch
> itself.

I am glad that you took this path.
Uniformity across the UAPI is important.

>
> This change raises the question of how we report non-inode errors.  On
> one hand, we could omit the FID report, but then fsid would also be
> ommited.  I chose to report these kind of errors against the root
> inode.
>

There are other option to consider.

To avoid special casing error events in fanotify event read code,
it would is convenient to use a non-zero length FID, but you can
use a 8 bytes zero buffer as NULL-FID

If I am not mistaken, that amounts to 64 bytes of event_len
including the event_metadata and both records which is pretty
nicely aligned.

All 3 handle_type options below are valid options:
1. handle_type FILEID_ROOT
2. handle_type FILEID_INVALID
3. handle_type FILEID_INO32_GEN (i.e. ino=0;gen=0)

The advantage of option #3 is that the monitoring program
does not need to special case the NULL_FID case when
parsing the FID to informative user message.

> The other changes in this iteration were made to attend to Amir
> feedback.  Thank you again for your very detailed input.  It is really
> appreciated.
>
> This was tested with LTP for regressions, and also using the sample on
> the last patch, with a corrupted image.  I can publish the bad image
> upon request.

Just to set expectations, we now have an official standard for fanotify [1]
where we require an LTP test and man page update patch before merge
of UAPI changes.

That should not stop us from continuing the review process - it's just
a heads up, but I think that we are down to implementation details in
the review anyway and that the UAPI (give or take root inode) is
pretty much clear at this point, so spreading the review of UAPI to
wider audience is not a bad idea.

w.r.t man page update, I know you have created the admin-guide book,
but it's not the same. For linux-api reviewers, reviewing the changed to
fanotify man pages is good way to make sure we did not miss any corners.

w.r.t LTP test, I don't think that using a corrupt image will be a good way
for an LTP test. LTP tests can prepare and mount an ext4 loop image.
Does ext4 have some debugging method to inject an error?
Because that would be the best way IMO.
If it doesn't, you can implement this in ext4 and use it in the test if that
debug file exists - skip the test otherwise - it's common practice.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/YMKv1U7tNPK955ho@google.com/
