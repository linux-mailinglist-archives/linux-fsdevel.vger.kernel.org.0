Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4055712EAFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 22:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgABVB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 16:01:27 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38201 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABVB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:01:27 -0500
Received: by mail-ua1-f68.google.com with SMTP id c7so11052502uaf.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2020 13:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YWrjJx8vHYwlflK6BxVuHgwF4TLF0rS9w0bmwnRJt7M=;
        b=vK9iRyS3LEdw+wyuFd+C+Kjeh7PymEcJLoLoarTKsiMp+SDsmEEKQmGUn6//R/g4le
         hgRNVoZWhYXopimv2Rr7y4tRb59gPrjAiUeH1NdH671Ovo/DrjgFh4d4VvRRuIf2db0R
         Inf4maSdJXZ5Lbve7yZHyPZPbXUEAA906OEcgyxUsDKZ6GcPNVY/y5sQ/9Y/79E6Y1ic
         Ei8lggySKILJpm3Bn4hJVoZzcPN8b3BvFfKjxcVf+0P+Kg2BL0kj2x/IepDmcOLA4kNz
         ZEx3mYE0NQAnraA7KFYXWp9b00Wqma5ZHPscdmTLA+JZp8ux/WB95MuG752n/E6DVBAY
         O1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YWrjJx8vHYwlflK6BxVuHgwF4TLF0rS9w0bmwnRJt7M=;
        b=Qh2ZM7DK7W01SyC2lzzNmJBz2wObj698FI07ssJ1UTW0/Y8+E4QpdWhA1dBRgcaK9K
         s9SL3dwSmzxehvlotZ4KMrrzhF26ugeeyRGcZzuGpknKL4ty2kUscMwKQ8pIYeIdjpN8
         1hAVZJEwwoPRfQZ75JFf42qcdxUwKPqjb/BrfnZmFC1jp9B5lJj4+Rk/7H1ClmuTutAb
         TNgN18QvnLhqEEFCgkSodJle85Nt4SDF/MnpceziBtICvyslZi9Hs1KtwaFcBb4HrZ6j
         bk8c4xwnjPPKss5yf+BVnk5+0s0UcgRbSL9vh4tbjbgXeMqG2XUaMYTVgOhlXX954MKk
         l50A==
X-Gm-Message-State: APjAAAWJdHEw5tqDFpVyGtZY/WcEngYtX0bh5kXNWj1CGbZe+0eMZTi3
        FZxezmITnXN4HzfOeEE5rAiDv0rjwVMYcuRWdfxWUg==
X-Google-Smtp-Source: APXvYqypDEGqnHzXtHBg5Zy4UFxu+6c6BkTukYKTM0aPJqbc9R9tQljr9M9GoKpmnHTHslkUynsT5Wqf/jO+GUtxlI4=
X-Received: by 2002:ab0:1352:: with SMTP id h18mr49143198uae.91.1577998885771;
 Thu, 02 Jan 2020 13:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20200101105248.25304-1-riteshh@linux.ibm.com>
In-Reply-To: <20200101105248.25304-1-riteshh@linux.ibm.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 2 Jan 2020 16:01:14 -0500
Message-ID: <CAOg9mSR17qRJ4VM5=1jndRwHw2Gcz8txgU9+-9GPFOfR34q7OA@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/1] Use inode_lock/unlock class of provided APIs
 in filesystems
To:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ritesh -

I just loaded your patch on top of 5.5-rc4 and it looks fine to me
and xfstests :-) ... I pointed ftrace at the orangefs function you
modified while xfstests was running, and it got called about a
jillion times...

-Mike

On Wed, Jan 1, 2020 at 5:53 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> Al, any comments?
> Resending this after adding Reviewed-by/Acked-by tags.
>
>
> From previous version:-
> Matthew Wilcox in [1] suggested that it will be a good idea
> to define some missing API instead of directly using i_rwsem in
> filesystems drivers for lock/unlock/downgrade purposes.
>
> This patch does that work. No functionality change in this patch.
>
> After this there are only lockdep class of APIs at certain places
> in filesystems which are directly using i_rwsem and second is XFS,
> but it seems to be anyway defining it's own xfs_ilock/iunlock set
> of APIs and 'iolock' naming convention for this lock.
>
> [1]: https://www.spinics.net/lists/linux-ext4/msg68689.html
>
> Ritesh Harjani (1):
>   fs: Use inode_lock/unlock class of provided APIs in filesystems
>
>  fs/btrfs/delayed-inode.c |  2 +-
>  fs/btrfs/ioctl.c         |  4 ++--
>  fs/ceph/io.c             | 24 ++++++++++++------------
>  fs/nfs/io.c              | 24 ++++++++++++------------
>  fs/orangefs/file.c       |  4 ++--
>  fs/overlayfs/readdir.c   |  2 +-
>  fs/readdir.c             |  4 ++--
>  include/linux/fs.h       | 21 +++++++++++++++++++++
>  8 files changed, 53 insertions(+), 32 deletions(-)
>
> --
> 2.21.0
>
