Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CEA459A3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 03:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhKWC6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 21:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhKWC6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:58:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD58C061746
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 18:54:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n8so15797663plf.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 18:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzu6WTfZUrCey1J7m6mzu3SyuG3mlb0cV5bc4AfptPs=;
        b=beaUT1FtsNFsra95ne0owHh0REAyyuUzujf6WfZCqbHVqWDCseUjZNBp1imtZrvl25
         Tle8IyUp3iiK6T7rSedrQcl9c/h0UQVa4ff4523mpAef4KYGb1TbGvy3lfGAL4G4Ooqr
         TH0f0Xw5heidYTCEKZrSbgx6eXucck48D1PdG9bQqnHF3xFKgaR12HFK4qLWfYdcBAaW
         hyr06oXivq4GX87hiZVUip/cxW8DPPmY1DWSzEzAGLteKQgqOmlnE0Fzbh+eO2i8dmuO
         d0czzqQ7InLmIRWHjnUfTxiVsP9Xg6prNyjUDIVMDnnmk947ZrGB8bNv0YUysQL48hVn
         bE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzu6WTfZUrCey1J7m6mzu3SyuG3mlb0cV5bc4AfptPs=;
        b=qymlUHYFWGf52lyNJIIqFtuPUSZkKT/+6QAtrcUS+nAVQdwl76xTcoi4NEM4522HG2
         oCEFCTUzvWSEfzLRxQeHPfzXPFdSjN3S/N3L2y+dJ8TLCFLB+4BIjcDpHgCXFcCr67uW
         /y0x40AwAsXEoP7Gi4Oom8JqSblz4EA3RQV7Omx9iGTrS/tJJG3Q6owVCj92UxC6FqVs
         YWgLwHnGC6+DLNnaMjeBItJLbhAuBxR9ZpcmyBZhDBTODCxsh955EevIBBRBTIMfG/jl
         IEdGrlXLUxcK8T4dQPyii4FEKW3M030K0YRrvXPOLx88QmAq3Ibn5kbzgmSZn8ifo+c0
         hvFw==
X-Gm-Message-State: AOAM531hKhU6hT/vhuoXrzuBiVSw3ulOUySPYbozZCv2jClqlVA7oG4/
        bVJUohZSyIu+8R5ihBykGdmeCqJnT9Rh/SAlecdfRg==
X-Google-Smtp-Source: ABdhPJxeiX5ifpjvIOpWVxQMDUuHcOe3OIdJeR8Imw/gLHmEQwl4x/JiO/uU+o3bH9o5PQYkURGBJLUFMItHEKRZD78=
X-Received: by 2002:a17:902:a50f:b0:143:7dec:567 with SMTP id
 s15-20020a170902a50f00b001437dec0567mr2776615plq.18.1637636093077; Mon, 22
 Nov 2021 18:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-4-hch@lst.de>
 <CAPcyv4hzWBZfex=C2_+nNLFKODw8+E9NSgK50COqE748cfEKTg@mail.gmail.com>
In-Reply-To: <CAPcyv4hzWBZfex=C2_+nNLFKODw8+E9NSgK50COqE748cfEKTg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 18:54:42 -0800
Message-ID: <CAPcyv4g=KgKZR6JF8_=mTs7Ndgq7DSU+5_sTJ7gQuwUgC5dRYg@mail.gmail.com>
Subject: Re: [PATCH 03/29] dax: remove CONFIG_DAX_DRIVER
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 9:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > CONFIG_DAX_DRIVER only selects CONFIG_DAX now, so remove it.
>
> Applied.

Unapplied,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
