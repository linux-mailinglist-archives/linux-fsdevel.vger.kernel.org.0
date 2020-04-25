Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176181B8516
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 11:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgDYJML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDYJMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:12:10 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80A2C09B04A;
        Sat, 25 Apr 2020 02:12:10 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s10so11658334iln.11;
        Sat, 25 Apr 2020 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JiF46ZwtYgzykMP2bAYyR3RdTXwf5kcYUzddJm9Noug=;
        b=tYtoHpf8qxrW4bKVwRQKtdE6QRrW+t0V57SFn7AsayuIVTCPlDBbDs0Qib3Bxe1noz
         WhNWBlNfx09ht0maHEIHm6+DDa3mfLVTPDmR87jSD56AHH47p0SkXQdxYb89y64VfZU3
         gwxZu86SPQpB+q1sofehRlOSsNaiC1jCpNe4LeyduzsogWAr/9SLsUhni64OIjStAYVH
         yTcr2nLlUGd5+Rz3/mHerbTEh2JheFcCtiVLSchOlHokryLMmqlc3PQngZDNddTX1OZf
         Na7+Zd7DKT6PJisKErRYBJTJRseUe7aWpSlQdbqsh/Qp7cgqqyeJAY3GqvRVMuQljAKh
         dwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JiF46ZwtYgzykMP2bAYyR3RdTXwf5kcYUzddJm9Noug=;
        b=iPsBOZmLw31cw1icvQ/YQYWOV+N2x83eoZLTxUwByGag0XgdVLn94MZoxDeFzurVA1
         9qYy2yUThMLimZC5YrWJwQjDIakv3cCR60s+lYKr8f00KVS6PHH38CDVxnUEqxqj/2oY
         63jtOJL6jlif80n/00lL8lL5boxfua7H41KX9Fp02glJSH7Vb5dVWljVbxt5HZevFovq
         mYZRfbE7IMU9f/EP47MsXsQuomVWr3g3XnbYYtBJcj//zmWF8LebvtHiVSADIWEFS8am
         hDQ8bdLaq+/SxQaszFTen8CJs2kgCVSsJ3Xq+tYLvrl58jLvYFHZOZdSyXSwMOZVJQQm
         TytQ==
X-Gm-Message-State: AGi0PuYtgOkBuGserbhuQmhdAEb+z1t10CLbo1KiWZYAC8CYzAgOA9qw
        zqci26bvh3uzDtvtGmcqeCbtuaXcWKSkGroZn4M=
X-Google-Smtp-Source: APiQypINknRRLSHrl/1vZgvgOwOhkfYEXQaXj4TsJV72rgTB39ueeIC66tFsxs1ucKYCMCEq5iqYCqptn/KatSCtl1E=
X-Received: by 2002:a92:7e86:: with SMTP id q6mr12884945ill.9.1587805930062;
 Sat, 25 Apr 2020 02:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587555962.git.riteshh@linux.ibm.com> <20200424101153.GC456@infradead.org>
 <20200424232024.A39974C046@d06av22.portsmouth.uk.ibm.com>
In-Reply-To: <20200424232024.A39974C046@d06av22.portsmouth.uk.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 25 Apr 2020 12:11:59 +0300
Message-ID: <CAOQ4uxgiome-BnHDvDC=vHfidf4Ru3jqzOki0Z_YUkinEeYCRQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
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

On Sat, Apr 25, 2020 at 2:20 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> Hello Christoph,
>
> Thanks for your review comments.
>
> On 4/24/20 3:41 PM, Christoph Hellwig wrote:
> > I think the right fix is to move fiemap_check_ranges into all the ->fiemap
>
> I do welcome your suggestion here. But I am not sure of what you are
> suggesting should be done as a 1st round of changes for the immediate
> reported problem.
> So currently these patches take the same approach on overlayfs on how
> VFS does it. So as a fix to the overlayfs over ext4 reported problems in
> thread [1] & [2]. I think these patches are doing the right thing.
>
> Also maybe I am biased in some way because as I see these are the right
> fixes with minimal changes only at places which does have a direct
> problem.
>

FWIW, I agree with you.
And seems like Jan does as well, since he ACKed all your patches.
Current patches would be easier to backport to stable kernels.

Plus, if we are going to cleanup the fiemap interface, need to look into
FIEMAP_FLAG_SYNC handling.
Does it makes sense to handle this flag in vfs ioctl code and other flags
by filesystem code?
See, iomap_fiemap() takes care of FIEMAP_FLAG_SYNC in addition
to ioctl_fiemap(), so I would think that FIEMAP_FLAG_SYNC should
probably be removed from ioctl_fiemap() and handled by
generic_block_fiemap() and other filesystem specific implementation.

Thanks,
Amir.
