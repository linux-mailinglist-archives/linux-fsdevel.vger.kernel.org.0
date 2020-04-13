Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B551A697C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 18:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbgDMQMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 12:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbgDMQL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:11:59 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034F8C0A3BDC;
        Mon, 13 Apr 2020 09:11:59 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b18so391252ilf.2;
        Mon, 13 Apr 2020 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OA301vNntdDyfA2VhstFhgzhyLC/fDUHW7Zm+pd6ULM=;
        b=KbdBetJcEP+yZMe7JYDdQTE4d4aFxqf+TLML9GkOW5xiffnh+ymW7VpySyBF1SrQja
         sdAz3Es1hxPJg4A6cn2lstL8uSevJVNswERMAHZcfbtcdvB92r6y4GHLaR0goX3BVaOA
         U1V+al8x0jG5X7DurQ7TUANzIeUajduoh3uEdJKguYGouWC1SZY6XzuUUu9xRSmjk4JA
         qPsBgrdbNGdMzkq9660Ok/WhB39mMI5Rokf/iIThJzywMA7nhGingJLS36JOgktuIbGR
         FjHnc5+TV7Hg3jANxXw5aYY+WOON1sorEkSZJtFJFlC5lLXJShFzZ0BpXv9gsPOA0uK7
         HniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OA301vNntdDyfA2VhstFhgzhyLC/fDUHW7Zm+pd6ULM=;
        b=nc2NUMtjt2u6EK9ZxP1ktmBuQSN53RJqIo6op78TLt0dPSULEtMFp65Mhehrf1GKmS
         bh2sBi8v6HO0rRx1GqKzLTSnozkZOE8Tu1Qu8hjnYk32zw/XqQRRYc+ei9FlXMdD0T1l
         GnwTQMVt8sYAATgyAV2yAiA5oz8s2W/2dL66TvmnvbnQz07ujBEXuOJdkfcpJQmYHxjW
         l12vZr7ZdNO8Tp+wCwTyvWKgAYY1p40iR4FUv+daJrpLYHYYPZ9EeEMZkzBxDBtl3Eir
         7U8A51oAV1ub6jWoBc4wWOkywHewtTFfqIQaHC38fiL5ReYDHDac/vNBq7BXIzdMs21t
         Bcmw==
X-Gm-Message-State: AGi0PuaygwsBI6sfxMZwpLBY6qANIixjrVDz2RAezW14W+1pT9h6zz7u
        XL2vhYlD4pMGSUybEVHWCnpJaVh2VYs/hCyxdJ8=
X-Google-Smtp-Source: APiQypIQi+IE4/jJu+QpuTIrt9Z4n5ruPHVB6/qEDJLkUgTws/lRTlQKBfOmXhCaFoUrPisWqwZ7efO+G+2i8KrMcTM=
X-Received: by 2002:a05:6e02:6c1:: with SMTP id p1mr18324420ils.137.1586794318407;
 Mon, 13 Apr 2020 09:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200413054419.1560503-1-ira.weiny@intel.com> <CAOQ4uxguVRysAuVEtQmPj+x=RDtDnGCtNeGvbvXNuvppwagwDg@mail.gmail.com>
 <20200413155325.GA1560218@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200413155325.GA1560218@iweiny-DESK2.sc.intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 13 Apr 2020 19:11:46 +0300
Message-ID: <CAOQ4uxg4Cr-vqA35TbhD5q7Jd1OgLUiL48nO_XNhkpMsCDW_UQ@mail.gmail.com>
Subject: Re: [PATCH] xfs/XXX: Add xfs/XXX
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >
> > But the kernel patch suggests that there is an intention to make
> > this behavior also applicable to ext4??
> > If that is the case I would recommend making this a generic tests
> > which requires filesystem support for -o dax=XXX
>
> I have a patch set for ext4 which is not quite passing this.  I'm not sure what
> is going on yet.
>
> Once that is working I was going to move this to generic.  (The documentation
> in the kernel patch set also reflects ext4 being different from xfs for the
> time being.)

IMO, if ext4 maintainer is on board with the plan to make this behavior of
ext4 then it is best to add this test as generic from the start.
Any other filesystems that may tag along later?

>
> This is mainly because I'm not sure if ext4 will make 5.8 or not.  Would you
> prefer making this generic now?  I assume there is some way to mark generic
> tests for a subset of FS's?  I have not figured that out yet.
>

There is a way, _supported_fs, see the tests/shared/*,
but the idea it to get rid of those in favor of feature tests such as
_require_scratch_dax

I believe it should be trivial to implement
_require_scratch_dax_never

Thanks,
Amir.
