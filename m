Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9B29D009
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfHZNGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 09:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbfHZNGK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:06:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD1C6307CDD1;
        Mon, 26 Aug 2019 13:06:10 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3993C4524;
        Mon, 26 Aug 2019 13:06:08 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C1B7C22017B; Mon, 26 Aug 2019 09:06:07 -0400 (EDT)
Date:   Mon, 26 Aug 2019 09:06:07 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     piaojun <piaojun@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, kbuild test robot <lkp@intel.com>,
        kvm@vger.kernel.org, miklos@szeredi.hu, virtio-fs@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>
Subject: Re: [Virtio-fs] [PATCH 04/19] virtio: Implement get_shm_region for
 PCI transport
Message-ID: <20190826130607.GB3561@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-5-vgoyal@redhat.com>
 <5D63392C.3030404@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D63392C.3030404@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 26 Aug 2019 13:06:10 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 26, 2019 at 09:43:08AM +0800, piaojun wrote:

[..]
> > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > +			      struct virtio_shm_region *region, u8 id)
> > +{
> > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> > +	u8 bar;
> > +	u64 offset, len;
> > +	phys_addr_t phys_addr;
> > +	size_t bar_len;
> > +	char *bar_name;
> 
> 'char *bar_name' should be cleaned up to avoid compiling warning. And I
> wonder if you mix tab and blankspace for code indent? Or it's just my
> email display problem?

Will get rid of now unused bar_name. 

Generally git flags if there are tab/space issues. I did not see any. So
if you see something, point it out and I will fix it.

Vivek
