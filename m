Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E87132CFC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgAGR33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:29:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46234 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgAGR32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:29:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id r9so661878otp.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 09:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpnN1Qc4KdEV6DUorcFDZqPBu69hsxGWQC1ntViNntM=;
        b=dp9Ew5g9lYMzS264P2PLif4UMUWCdr0VxT5zi507EuXBe/GMDwox3up8SHuWHmyP4T
         9aWUzrwZZDBJ6e5ckod8FgFlwxFutDfkUszACYcESvmIW3XIRV87+SRZuMXXtbIyoQnr
         36d1hgke3/f7kFbjgfq67/qmBh4nPMy73TncwwP+OrJFn+zy/Yh/gSHc+AM6QsIpzji/
         ogpxDvLch5e5wIwoi8Ss33m+jQRUpS2XaDudai5FQj1dEvDxONyce8hVVSaWIe/Ykdba
         T3kDRLJpPGsYI1zX26cb0kYkqz4k+sQ2qT01KO03k9YXXRxw4xHsrGJs2VcqvSfUTgmk
         GPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpnN1Qc4KdEV6DUorcFDZqPBu69hsxGWQC1ntViNntM=;
        b=Bq2w7Pn2g6dgI/VtNv2mdCoPMnu7o4iUOuLeFm7Vxr1sHFnI7B6kOAjtpJioBL+AtJ
         /iwvgUSc1NjnFquhYiHLNBv16HTYwxuo45qJ3kawgbodtyg1M3Vr6jhaANWmWqwRgjnE
         Ulmapec7nWBpa+Ls2B5fVjQI5ScWgi2NyycNbsCJH7MQfZPY3infWOdjNmVToWyUf5iL
         N2wKvwI9AAg03PMrgJHKOteTzBjNTCzU3LA1LAovqNPm9PIjkxTp3mX95aUhw1xNPdWF
         xx14RreqOKNREtDChH3BZR2hfoEKdJuNpPIu+qmnrSvotZf/q+SgPGbI4FFQXokNOmPx
         oo8w==
X-Gm-Message-State: APjAAAUoYTJBoKzlTOfYAx1E0Y+nAkfIYMvlHNPg7leXkg8N76xkzzaC
        IE/WIYZ78YeiRLgiSDwdJ/Ckhshuj9boCBhkLLfq3A==
X-Google-Smtp-Source: APXvYqwKo20I0n5xbnSQdFnOTztBVQs28N/hQCqru2njBZbSH8O8dd6qzeslV9G/Fnx0Sql1iukKgVWgGb0ZcMiHKVw=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr817574otm.247.1578418168350;
 Tue, 07 Jan 2020 09:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20190821175720.25901-2-vgoyal@redhat.com> <20190826115152.GA21051@infradead.org>
 <20190827163828.GA6859@redhat.com> <20190828065809.GA27426@infradead.org>
 <20190828175843.GB912@redhat.com> <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com> <20200107170731.GA472641@magnolia>
In-Reply-To: <20200107170731.GA472641@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Jan 2020 09:29:17 -0800
Message-ID: <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 7, 2020 at 9:08 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Tue, Jan 07, 2020 at 06:22:54AM -0800, Dan Williams wrote:
> > On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > > > Agree. In retrospect it was my laziness in the dax-device
> > > > > implementation to expect the block-device to be available.
> > > > >
> > > > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > > > dax_device could be dynamically created to represent the subset range
> > > > > indicated by the block-device partition. That would open up more
> > > > > cleanup opportunities.
> > > >
> > > > Hi Dan,
> > > >
> > > > After a long time I got time to look at it again. Want to work on this
> > > > cleanup so that I can make progress with virtiofs DAX paches.
> > > >
> > > > I am not sure I understand the requirements fully. I see that right now
> > > > dax_device is created per device and all block partitions refer to it. If
> > > > we want to create one dax_device per partition, then it looks like this
> > > > will be structured more along the lines how block layer handles disk and
> > > > partitions. (One gendisk for disk and block_devices for partitions,
> > > > including partition 0). That probably means state belong to whole device
> > > > will be in common structure say dax_device_common, and per partition state
> > > > will be in dax_device and dax_device can carry a pointer to
> > > > dax_device_common.
> > > >
> > > > I am also not sure what does it mean to partition dax devices. How will
> > > > partitions be exported to user space.
> > >
> > > Dan, last time we talked you agreed that partitioned dax devices are
> > > rather pointless IIRC.  Should we just deprecate partitions on DAX
> > > devices and then remove them after a cycle or two?
> >
> > That does seem a better plan than trying to force partition support
> > where it is not needed.
>
> Question: if one /did/ have a partitioned DAX device and used kpartx to
> create dm-linear devices for each partition, will DAX still work through
> that?

The device-mapper support will continue, but it will be limited to
whole device sub-components. I.e. you could use kpartx to carve up
/dev/pmem0 and still have dax, but not partitions of /dev/pmem0.
