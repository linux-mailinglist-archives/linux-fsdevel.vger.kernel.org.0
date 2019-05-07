Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC39916706
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfEGPks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 11:40:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45561 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfEGPkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 11:40:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id a10so15336589otl.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDjq30ddseBaIw6socWxfPv6NTtk+5QW4X1Ug5iEyJk=;
        b=P0NmBCU8zUOfaF8xaYZsuZ8crvxFB33fl7wDNB9MZv5fgE9bufZ9uXOFacVBRIyhyk
         7jy7cEut0ZZu1RaoDtrr50BVaB/CX/skGeBOtXxoGAGKW89ZemgDpFwl6g0BCyZNTY71
         c96Bv/+lzcoe4YYcd5EMePUR4gTK7GrAqK6itLr2obeqWzYKb3Dql3mDDHzIv1x+/JnT
         zIvYGvdBDonXfV8sEZV0PvMIvA63l1OoRV+8kWQPCfuhVRSXMOb+jYMxWFhFzCGAXSHH
         RES21PeWYeTfPIbRNgVP3JVS3PVW0F6JNq0X1vpUrTbfXgSQ4Ev5ZlVumch1kGRMghci
         mHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDjq30ddseBaIw6socWxfPv6NTtk+5QW4X1Ug5iEyJk=;
        b=Idpdcjgpyl6iglF4tdp+TvkKt5mW19X+rFZizfNs7x9Au5thNuIBobtRX8ShgtqeOU
         FRQRU+tjOV+Et8GmRUN7JEvKAHIxUyx7eD88Q/ew7vCbrGKwVu2b2BgqTdiz8RH9aup0
         3U3ZqOMf8QeZYA1PXlin8O2edGm6OAcZ73S7Fc4ZxteZKWy50WADRt7Plxr4X7B38Vx0
         JahXuaTcaKgzP9aF/Z+pL2oVpSyP7B+MbWzvTh1npIhN0bONsMRKj6DsXDOTMEJzA29o
         NkvstzZF9AYY6iFrNB351AHFBl4L+UYCTMV6TMqaH8laUs5iS5Hq78sGsdgNCGvwOAMa
         F4dw==
X-Gm-Message-State: APjAAAUn9E/3tvpamcq9wBIFJM4756c4EyHIOpb8rw1KnjDgCVYA+gcW
        DdgqbA+zy5AZsU4F1bROYuJQH9f36zhqReW4uQ5vkg==
X-Google-Smtp-Source: APXvYqxgIWANkc/KHq9kAogc8tqlkqRrOccsWEIKbqAeeZcNH5LiQg3MPoGwMh9hdCCYG0LuKCXgqpIi0akzNLzuZFI=
X-Received: by 2002:a9d:222c:: with SMTP id o41mr22033787ota.353.1557243640877;
 Tue, 07 May 2019 08:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190426050039.17460-1-pagupta@redhat.com> <20190426050039.17460-4-pagupta@redhat.com>
In-Reply-To: <20190426050039.17460-4-pagupta@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 May 2019 08:40:30 -0700
Message-ID: <CAPcyv4hRdvypEj4LBTMfUFm80BdpRYbOugrkkj-3Kk_LErXPqQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] libnvdimm: add dax_dev sync flag
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        KVM list <kvm@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christoph Hellwig <hch@infradead.org>,
        Len Brown <lenb@kernel.org>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        jmoyer <jmoyer@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        david <david@fromorbit.com>, cohuck@redhat.com,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kilobyte@angband.pl,
        yuval shaia <yuval.shaia@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:02 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds 'DAXDEV_SYNC' flag which is set
> for nd_region doing synchronous flush. This later
> is used to disable MAP_SYNC functionality for
> ext4 & xfs filesystem for devices don't support
> synchronous flush.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
[..]
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 0dd316a74a29..c97fc0cc7167 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -7,6 +7,9 @@
>  #include <linux/radix-tree.h>
>  #include <asm/pgtable.h>
>
> +/* Flag for synchronous flush */
> +#define DAXDEV_F_SYNC true

I'd feel better, i.e. it reads more canonically, if this was defined
as (1UL << 0) and the argument to alloc_dax() was changed to 'unsigned
long flags' rather than a bool.
