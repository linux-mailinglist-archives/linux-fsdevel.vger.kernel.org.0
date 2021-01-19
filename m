Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB82FC3BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 23:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbhASOfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 09:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405040AbhASMfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:35:10 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164BFC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 04:34:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v15so15916890wrx.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 04:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dy3egPV1ka/EkZOaPATc7EsNx/78Zw3FYs2vUZuq9OU=;
        b=evsZNBcduUb7qJp65mS6n4i2QPR+xQy4POZWrTwxPx77Y6MwQKoj/e/V8dpgSrQkKf
         pnDA5+cIudYS6Id24AKDGGnBLZArqWXyf4SpAvDO8ihFDSjmi5S8OS0IXsdeSgEfQhVC
         dZMyTqT8W3OtlFHmN/j93o2mUX/eBtQObonmgz+5ne8jDjN8gQMebwkmePLHxZrFbXVX
         LA2rabkrQxfIG2aPLngyRY6T3k4T9zGraCI39n7CokXsRaw2g+L/8mlEHMSR1w7Qnb8U
         CIWB6r3Znl9bmzXvyI6STcehT80Dga5yGhuJo8zimw+AQGK7+x30Tp88mE3chkhUebPZ
         BtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dy3egPV1ka/EkZOaPATc7EsNx/78Zw3FYs2vUZuq9OU=;
        b=hgtioPElvV6IvJ39//jKXh5nwzJ3r/r6ZGtntAZGWlY8wo4yaaJJ3Mq/nALHFXD+iP
         lANJyrYYQ1RVbgBk64J8OQ223weoJ+p5m7YIKu4ssosbmupou+o3RDMSh27aLQb6duOn
         Plz3OffXxYzPZSPITEgEVzUuwzM9FxF81aaLTJuhlwPqx2rb2nrl6rOJEYeJMfGp/8Q8
         P4WfI2G4RtgJhlxCrVoaWKF55rHpYtOzwxr9TAYoPr/W4LaRptsxkI8jGX9rf2VqRvap
         zg4l7gy5JgQJaJE7ICmTuwR9aiOjkY3V6mAWRMXlu7C8KXiob9hsg6NHRF+UajB6Fy/l
         mXnQ==
X-Gm-Message-State: AOAM530kQhc5b++yF89jIEv/EjWa6RZxTAPeDT0f8OywOLCaPJz4aPoQ
        EfScYB4Ohzg5lCBAlFyiO1MRuw==
X-Google-Smtp-Source: ABdhPJzuytrtz4oMI/FP+lXgZR8nD44MAhG4BGEMGEvMmaJq/MlcxUctQ8Sg7K6AdXbtI15642DvVg==
X-Received: by 2002:a5d:44c8:: with SMTP id z8mr4160714wrr.366.1611059665813;
        Tue, 19 Jan 2021 04:34:25 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:41d4:8c90:d38:455d])
        by smtp.gmail.com with ESMTPSA id a17sm36904463wrs.20.2021.01.19.04.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:34:25 -0800 (PST)
Date:   Tue, 19 Jan 2021 12:34:23 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Rokudo Yan <wu-yan@tcl.com>
Cc:     balsini@android.com, akailash@google.com, amir73il@gmail.com,
        axboe@kernel.dk, bergwolf@gmail.com, duostefano93@gmail.com,
        dvander@google.com, fuse-devel@lists.sourceforge.net,
        gscrivan@redhat.com, jannh@google.com, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, miklos@szeredi.hu, palmer@dabbelt.com,
        paullawrence@google.com, trapexit@spawn.link, zezeozue@google.com
Subject: Re: [PATCH RESEND V11 0/7] fuse: Add support for passthrough
 read/write
Message-ID: <YAbRz83CV2TyU3wT@google.com>
References: <20210118192748.584213-1-balsini@android.com>
 <20210119110654.11817-1-wu-yan@tcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119110654.11817-1-wu-yan@tcl.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 07:06:54PM +0800, Rokudo Yan wrote:
> on Mon, Jan 18, 2021 at 5:27 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > This is the 11th version of the series, rebased on top of v5.11-rc4.
> > Please find the changelog at the bottom of this cover letter.
> > 
> > Add support for file system passthrough read/write of files when enabled
> > in userspace through the option FUSE_PASSTHROUGH.
> [...]
> 
> 
> Hi Allesio,
> 
> Could you please add support for passthrough mmap too ?
> If the fuse file opened with passthrough actived, and then map (shared) to (another) process
> address space using mmap interface. As access the file with mmap will pass the vfs cache of fuse,
> but access the file with read/write will bypass the vfs cache of fuse, this may cause inconsistency.
> eg. the reader read the fuse file with mmap() and the writer modify the file with write(), the reader
> may not see the modification immediately since the writer bypass the vfs cache of fuse.
> Actually we have already meet an issue caused by the inconsistency after applying fuse passthrough
> scheme to our product.
> 
> Thanks,
> yanwu.

Hi yanwu,

Thank you for your interest in this change.

FUSE passthrough for mmap is an extension that is already in my TODO
list, together with passthrough for directories.
For now I would prefer to keep this series minimal to make the review
process leaner and simpler.
I will start working on extending this series with new features and
addressing more corner cases as soon as these changes get merged, what
do you think?

Thanks,
Alessio
