Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1431813F949
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 20:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389580AbgAPTYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 14:24:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51890 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731007AbgAPTYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579202644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8HBHJP/uq6LLcUiW9DMmgfjF72wvEE4C0oRW83XDZw=;
        b=VcEOirFKhZ/qGMHCRLahr+bltd2l1gTxwfk5EDwDmKEoDSyWqgJEWy7o1n6L7SEvhvykxz
        hE6uzNQaU+jZx3E9qOdEBE1+E1NV4ECevJvap0VSJnxtEuADcPMLB5NyAcL/q8EG4JOPuC
        FWwffG4wDRPc+hjx2L9hdGdZ7pPsrdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-Wpe1cMcoOoGBY_oRiv4oYg-1; Thu, 16 Jan 2020 14:24:00 -0500
X-MC-Unique: Wpe1cMcoOoGBY_oRiv4oYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 119012F2E;
        Thu, 16 Jan 2020 19:23:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BC035D9C9;
        Thu, 16 Jan 2020 19:23:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C1B6B220A24; Thu, 16 Jan 2020 14:23:53 -0500 (EST)
Date:   Thu, 16 Jan 2020 14:23:53 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200116192353.GD25291@redhat.com>
References: <20200114203138.GA3145@redhat.com>
 <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com>
 <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com>
 <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
 <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
 <20200116183900.GC25291@redhat.com>
 <CAPcyv4irezimk8m4hysrd0rst_f0Rr+iiNxeFesqbxQnWYA2Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4irezimk8m4hysrd0rst_f0Rr+iiNxeFesqbxQnWYA2Xw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:09:00AM -0800, Dan Williams wrote:

[..]
> > > True, but if kpartx + udev can make this transparent then I don't
> > > think users lose any functionality. They just gain a device-mapper
> > > dependency.
> >
> > So udev rules will trigger when a /dev/pmemX device shows up and run
> > kpartx which in turn will create dm-linear devices and device nodes
> > will show up in /dev/mapper/pmemXpY.
> >
> > IOW, /dev/pmemXpY device nodes will be gone. So if any of the scripts or
> > systemd unit files are depenent on /dev/pmemXpY, these will still be
> > broken out of the box and will have to be modified to use device nodes
> > in /dev/mapper/ directory instead. Do I understand it right, Or I missed
> > the idea completely.
> 
> No, I'd write the udev rule to create links from /dev/pmemXpY to the
> /dev/mapper device, and that rule would be gated by a new pmem device
> attribute to trigger when kpartx needs to run vs the kernel native
> partitions.

Got it. This sounds much better.

Vivek

