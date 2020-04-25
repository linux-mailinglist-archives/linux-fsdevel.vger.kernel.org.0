Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D531B85C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 12:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgDYKtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 06:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726053AbgDYKtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:49:55 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03576C09B04A;
        Sat, 25 Apr 2020 03:49:54 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w6so11816118ilg.1;
        Sat, 25 Apr 2020 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMcPi5VjfPl8mPXcZ/holvg8POywsqDxfT7fng+NEug=;
        b=ABhkI+gBjawXjYOy4NgUZ0bwfzqurQvvoFX0E+rwvV2MvD1H5wgdpyqOG9E725RKEo
         1ZbzxgXRlp7ArpqalO7i27/RRlQRCB8TmzOPMf3M3m2p/D+4v4t6JEK8iQiOww0FAEVY
         Hywcuo2zXdVUhok96kgi67yv3FX/+v3KEaikL5mZEaCNJezHVUSGMPKE22nQ0zmwpXbN
         rEE9jxERLrD5VqtH9KNRW1moAqihtcQSRx8aiZzSNpvlywAQVPyCJn19zd3+EEWdfQFM
         bPHdkd4JNgXOeNO+Wj5KD/UMXSTtxcVMmWNBx02+u0EHldpvDC4QvEK3wZfUUTktRtdA
         0GcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMcPi5VjfPl8mPXcZ/holvg8POywsqDxfT7fng+NEug=;
        b=o/uM5t/21fr61WZ8mMR2Ed/tZZ96rSsIU7d0NhD25oXdf/W7MaAt54Wu4rWTo3wTj/
         hPtTYghlI8B6B8aNwoFcwL1R1Khbl97i0n7wiZWy0rylJL0aEhc9pzJ+mYwh+EqRrFs3
         smMz+WjEizLWuKZ5iKhP9Dlir1DooMfFfQhshjHpvxnX8Z6V1BcrP77aECZJ1A4bcmSP
         Pj2M/d2VpL1d3z6pZXN5/fVqWPTT8FuGyju8o7XRqAEXxCR2/qCa5VO2bZy9aon3nPKg
         1JmfL6sQj5/TMVQFYqnzSFNo2LbAjZS02AQ+ysWImMXVs5KXmPjfnWMlSLFZxlAdCBNr
         M/Tg==
X-Gm-Message-State: AGi0PuZhy+nQpUBm48SvWaswNSoRV2ehks7t/s3QxBGOX5XgVRyrzlGf
        m3Qvkj1TxzjcHTXQgdmkBZW+PgzrCM0ebQsvzjs=
X-Google-Smtp-Source: APiQypKo5VY/NJGbMJ88ZgPvlocPrZAHeEf44NKIx/HeafSwt/R0Sv6ybsWvheL8DVHl8G1l5L5YlyZkXcoZIu1IFek=
X-Received: by 2002:a92:9e11:: with SMTP id q17mr13265129ili.137.1587811794273;
 Sat, 25 Apr 2020 03:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587555962.git.riteshh@linux.ibm.com> <20200424101153.GC456@infradead.org>
 <20200424232024.A39974C046@d06av22.portsmouth.uk.ibm.com> <CAOQ4uxgiome-BnHDvDC=vHfidf4Ru3jqzOki0Z_YUkinEeYCRQ@mail.gmail.com>
 <20200425094350.GA11881@infradead.org>
In-Reply-To: <20200425094350.GA11881@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 25 Apr 2020 13:49:43 +0300
Message-ID: <CAOQ4uxg2KOVBxqF400KW3VaQEaX4JGqfb_vCW=esTMkJqZWwvA@mail.gmail.com>
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 25, 2020 at 12:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Apr 25, 2020 at 12:11:59PM +0300, Amir Goldstein wrote:
> > FWIW, I agree with you.
> > And seems like Jan does as well, since he ACKed all your patches.
> > Current patches would be easier to backport to stable kernels.
>
> Honestly, the proper fix is pretty much trivial.  I wrote it up this
> morning over coffee:
>
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/fiemap-fix
>
> Still needs more testing, though.

Very slick!

I still think Ritesh's patches are easier for backporting because they are
mostly contained within the ext4/overlayfs subsystems and your patch
can follow up as interface cleanup.

I would use as generic helper name generic_fiemap_checks()
akin to generic_write_checks() and generic_remap_file_range_prep() =>
generic_remap_checks().

Thanks,
Amir.
