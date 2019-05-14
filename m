Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19A1C692
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 12:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfENKCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 06:02:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfENKCx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 06:02:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C74C30198BD;
        Tue, 14 May 2019 10:02:52 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96F1A63B8B;
        Tue, 14 May 2019 10:02:51 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 412B818089C8;
        Tue, 14 May 2019 10:02:49 +0000 (UTC)
Date:   Tue, 14 May 2019 06:02:48 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        dan j williams <dan.j.williams@intel.com>,
        zwisler@kernel.org, vishal l verma <vishal.l.verma@intel.com>,
        dave jiang <dave.jiang@intel.com>, mst@redhat.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger kernel <adilger.kernel@dilger.ca>,
        darrick wong <darrick.wong@oracle.com>, lcapitulino@redhat.com,
        kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com,
        nilal@redhat.com, riel@surriel.com, stefanha@redhat.com,
        aarcange@redhat.com, david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        pbonzini@redhat.com, kilobyte@angband.pl,
        yuval shaia <yuval.shaia@oracle.com>, jstaron@google.com
Message-ID: <919431491.28558886.1557828168896.JavaMail.zimbra@redhat.com>
In-Reply-To: <cd5572ac-14d0-f872-6321-c522daa70f49@redhat.com>
References: <20190510155202.14737-1-pagupta@redhat.com> <20190510155202.14737-3-pagupta@redhat.com> <f2ea35a6-ec98-447c-44fe-0cb3ab309340@redhat.com> <752392764.28554139.1557826022323.JavaMail.zimbra@redhat.com> <86298c2c-cc7c-5b97-0f11-335d7da8c450@redhat.com> <712871093.28555872.1557827242385.JavaMail.zimbra@redhat.com> <cd5572ac-14d0-f872-6321-c522daa70f49@redhat.com>
Subject: Re: [PATCH v8 2/6] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.16.148, 10.4.195.1]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: TcH/fzTmTGlr7ZcMfiu1eOEXog6lYw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 14 May 2019 10:02:52 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> >>
> >> I think you should do the same here, vdev->priv is allocated in
> >> virtio_pmem_probe.
> >>
> >> But maybe I am missing something important here :)
> > 
> > Because virtio_balloon use "kzalloc" for allocation and needs to be freed.
> > But virtio pmem uses "devm_kzalloc" which takes care of automatically
> > deleting
> > the device memory when associated device is detached.
> 
> Hehe, thanks, that was the part that I was missing!

Thank you for the review.

Best regards,
Pankaj
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 
