Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADD13BAC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 19:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfFJROV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 13:14:21 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35366 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387456AbfFJROU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:14:20 -0400
Received: by mail-yw1-f68.google.com with SMTP id k128so4079597ywf.2;
        Mon, 10 Jun 2019 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZcaNkyUCHyNNBHCoFIDrPq60f5nJL8w+ttSw5Z4HYU=;
        b=tXKr1ajXOv3jcM26Ep7l86d6gJSnAXkSrsCwbr7KQPUfrYbaTxEHsAIBRAokJLhpyM
         qBCrLvuXnUIbm40qjv3fJG0yOnYQoDqCW4OCC6NynBHBZ5QZ3cQElHVb5Zychgt36kBl
         88w5NO3d/KU8YUZWQAQXVzabVW+m+9yPHmrWOaOV0dm6+FN5fGd3NUK0V0CqB7iG5/5y
         o9YN2ka6v/1Ot4PbM8kngQDDhPrTKMDl7bWWD1Ic1/TePG5cJciif3qeaUuaipfWLpVm
         MtPnP08UW4YmraTfMaYAPf6mJ0+S4uMGkm7Ed7BkVa6URZcIwl3lVOWkEmugGjT2AP9j
         lGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZcaNkyUCHyNNBHCoFIDrPq60f5nJL8w+ttSw5Z4HYU=;
        b=jCze4pHqo+/agVWX6uC/UBFJU/vclrk9ZEWXqmLlSVKa9zimfdoO9KLpd5xtnnyBUd
         azksL7XbHKmS3v+gqvn1Ujwni4pp9S6LJqVwim9HQodY2b5qvak4jl9rQkwBuyA80PY6
         dslaKmt7tWNVXS4eOkCvnn7mfJiEgEKXGQ4OaWQW6tptA7IAsJp0pfMd5yAEtDcY4caw
         ETY02mg5dGg4EfW/oEyaLWr3DjWrOsC2tDvc6TKECYl2iNt4RpSS4IuCoSvlmltYbkb+
         bqE4x8/67MY9EupYjZZjCmMWW8kUmOWAYRwVvxsZyT2hiww06Bxe13EUYx6Qlpok0nAh
         l4HA==
X-Gm-Message-State: APjAAAVcTwGOPjFibPnsBBgHGrvSgU267/KIKGX/70pOMgH1jrgIALZW
        LpnAcWwsOcDAb8XwysH3rglf5ZAIJcvhk0xQPfQ=
X-Google-Smtp-Source: APXvYqylMkXtCRaqRsONVov9vQReTdASSa/0yVxjCKKAD/fKBdISmUPR06X1sfw/WpWVbF/sEM/mSKgtSHDke8IPELg=
X-Received: by 2002:a81:374c:: with SMTP id e73mr27985620ywa.379.1560186859913;
 Mon, 10 Jun 2019 10:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190610160624.GG1871505@magnolia>
In-Reply-To: <20190610160624.GG1871505@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 10 Jun 2019 20:14:08 +0300
Message-ID: <CAOQ4uxhkE_TsN7XMBgzxVhEYDw+gZEOOCiZzn9otVwQtB-XHeA@mail.gmail.com>
Subject: Re: [ANNOUNCE] xfs-linux: copy-file-range-fixes updated to fe0da9c09b2d
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+CC affected maintainers

On Mon, Jun 10, 2019 at 7:06 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> Hi folks,
>
> The copy-file-range-fixes branch of the xfs-linux repository at:
>
>         git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>
> has just been updated.  This is a common branch from which everyone else
> can create their own copy-file-range fix branches for 5.3.  When you
> send your pull request to Linus please let him know that the fixes
> stream out from here like some kind of hydra. :)

Thanks Darrick!
Should we also request to include this branch in linux-next?

Attention nfs/cifs/fuse/ceph maintainers!
This branch includes changes to your filesystems.
At lease nfs/cifs/ceph have been tested with these changes and the
new xfstests.

I think it would be preferred if you merge Darrick's branch into your
5.3 branch as soon as you have one ready to reduce chances of
conflicts down the road.

I will be sending out 2 more patches to cifs/ceph, which depend on
this branch directly to maintainers.

Thanks,
Amir.
