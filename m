Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 020B61A180
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 18:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfEJQaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 12:30:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39885 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfEJQaI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 12:30:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id z128so4028294qkb.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 09:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QYV9CSnlMGLW/+YNa74BGVcmOFFVV0pQn9SNX0XEZO8=;
        b=V9+kzdfA4AoABJtfvl6l2qqxiz6b0LuVCCXth7NH1jmKnnRIPSAuwXXpvmu+hT15xU
         QPYtmpZuehWZbczaiX8eZO2pEPx6c0Xma6gHeBIqp7y5K2UkmU3bubls3n8T9m1u2P/C
         1K1aCJ10zuwORwvnOhcVmXaO9W55jRYjz9PJggWMnmUdSZJV7PSJajPbjFjOuz6KZ81Y
         fe5RQZiLFCZK58+q0VI9XutPKQcK4XGaorZJiHesFqrNGy5yJ42t4hMDzprExzuXjlQc
         Qa+jvedW32c5/j80mCj1bLb4u4MJye6U3gkvujtyam9v73y37u+ogbTHWz9kUeQU5CME
         5Nmw==
X-Gm-Message-State: APjAAAXnMmkeBmNPbRqeHaiISphtP5D5p91WA8Hl+U3Jbnh177Z2VbIB
        oFVsgqYPT0eBu4NJlJlcoV6utA==
X-Google-Smtp-Source: APXvYqwqGw0tLN1kosrPHP/TgqH7/k5vTToiHq0KOvopgumJI2PV5SFzvIHY16911D9Xeql9Y6Q8tA==
X-Received: by 2002:a37:4f95:: with SMTP id d143mr9608061qkb.253.1557505806901;
        Fri, 10 May 2019 09:30:06 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id j4sm3556590qti.49.2019.05.10.09.30.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 09:30:05 -0700 (PDT)
Date:   Fri, 10 May 2019 12:30:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, dan.j.williams@intel.com,
        zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
        jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
        stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
        david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pbonzini@redhat.com,
        kilobyte@angband.pl, yuval.shaia@oracle.com, jstaron@google.com
Subject: Re: [PATCH v8 0/6] virtio pmem driver
Message-ID: <20190510122935-mutt-send-email-mst@kernel.org>
References: <20190510155202.14737-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190510155202.14737-1-pagupta@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 10, 2019 at 09:21:56PM +0530, Pankaj Gupta wrote:
>  Hi Michael & Dan,
> 
>  Please review/ack the patch series from LIBNVDIMM & VIRTIO side.

Thanks!
Hope to do this early next week.

>  We have ack on ext4, xfs patches(4, 5 & 6) patch 2. Still need
>  your ack on nvdimm patches(1 & 3) & virtio patch 2. 
> 
>  Changes done from v7 are only in patch(2 & 3) and not
>  affecting existing reviews. Request to please review.
>  ----
> 
>  This patch series has implementation for "virtio pmem". 
>  "virtio pmem" is fake persistent memory(nvdimm) in guest 
>  which allows to bypass the guest page cache. This also
>  implements a VIRTIO based asynchronous flush mechanism.  
>  
>  Sharing guest kernel driver in this patchset with the 
>  changes suggested in v4. Tested with Qemu side device 
>  emulation [6] for virtio-pmem. Documented the impact of
>  possible page cache side channel attacks with suggested
>  countermeasures.
> 
>  Details of project idea for 'virtio pmem' flushing interface 
>  is shared [3] & [4].
> 
>  Implementation is divided into two parts:
>  New virtio pmem guest driver and qemu code changes for new 
>  virtio pmem paravirtualized device.
> 
> 1. Guest virtio-pmem kernel driver
> ---------------------------------
>    - Reads persistent memory range from paravirt device and 
>      registers with 'nvdimm_bus'.  
>    - 'nvdimm/pmem' driver uses this information to allocate 
>      persistent memory region and setup filesystem operations 
>      to the allocated memory. 
>    - virtio pmem driver implements asynchronous flushing 
>      interface to flush from guest to host.
> 
> 2. Qemu virtio-pmem device
> ---------------------------------
>    - Creates virtio pmem device and exposes a memory range to 
>      KVM guest. 
>    - At host side this is file backed memory which acts as 
>      persistent memory. 
>    - Qemu side flush uses aio thread pool API's and virtio 
>      for asynchronous guest multi request handling. 
> 
>    David Hildenbrand CCed also posted a modified version[7] of 
>    qemu virtio-pmem code based on updated Qemu memory device API. 
> 
>  Virtio-pmem security implications and countermeasures:
>  -----------------------------------------------------
> 
>  In previous posting of kernel driver, there was discussion [9]
>  on possible implications of page cache side channel attacks with 
>  virtio pmem. After thorough analysis of details of known side 
>  channel attacks, below are the suggestions:
> 
>  - Depends entirely on how host backing image file is mapped 
>    into guest address space. 
> 
>  - virtio-pmem device emulation, by default shared mapping is used
>    to map host backing file. It is recommended to use separate
>    backing file at host side for every guest. This will prevent
>    any possibility of executing common code from multiple guests
>    and any chance of inferring guest local data based based on 
>    execution time.
> 
>  - If backing file is required to be shared among multiple guests 
>    it is recommended to don't support host page cache eviction 
>    commands from the guest driver. This will avoid any possibility
>    of inferring guest local data or host data from another guest. 
> 
>  - Proposed device specification [8] for virtio-pmem device with 
>    details of possible security implications and suggested 
>    countermeasures for device emulation.
> 
>  Virtio-pmem errors handling:
>  ----------------------------------------
>   Checked behaviour of virtio-pmem for below types of errors
>   Need suggestions on expected behaviour for handling these errors?
> 
>   - Hardware Errors: Uncorrectable recoverable Errors: 
>   a] virtio-pmem: 
>     - As per current logic if error page belongs to Qemu process, 
>       host MCE handler isolates(hwpoison) that page and send SIGBUS. 
>       Qemu SIGBUS handler injects exception to KVM guest. 
>     - KVM guest then isolates the page and send SIGBUS to guest 
>       userspace process which has mapped the page. 
>   
>   b] Existing implementation for ACPI pmem driver: 
>     - Handles such errors with MCE notifier and creates a list 
>       of bad blocks. Read/direct access DAX operation return EIO 
>       if accessed memory page fall in bad block list.
>     - It also starts backgound scrubbing.  
>     - Similar functionality can be reused in virtio-pmem with MCE 
>       notifier but without scrubbing(no ACPI/ARS)? Need inputs to 
>       confirm if this behaviour is ok or needs any change?
> 
> Changes from PATCH v7: [1]
>  - Corrected pending request queue logic (patch 2) - Jakub Staroń
>  - Used unsigned long flags for passing DAXDEV_F_SYNC (patch 3) - Dan
>  - Fixed typo =>  vma 'flag' to 'vm_flag' (patch 4)
>  - Added rob in patch 6 & patch 2
> 
> Changes from PATCH v6: [1]
>  - Corrected comment format in patch 5 & patch 6. [Dave]
>  - Changed variable declaration indentation in patch 6 [Darrick]
>  - Add Reviewed-by tag by 'Jan Kara' in patch 4 & patch 5
> 
> Changes from PATCH v5: [2]
>   Changes suggested in by - [Cornelia, Yuval]
> - Remove assignment chaining in virtio driver
> - Better error message and remove not required free
> - Check nd_region before use
> 
>   Changes suggested by - [Jan Kara]
> - dax_synchronous() for !CONFIG_DAX
> - Correct 'daxdev_mapping_supported' comment and non-dax implementation
> 
>   Changes suggested by - [Dan Williams]
> - Pass meaningful flag 'DAXDEV_F_SYNC' to alloc_dax
> - Gate nvdimm_flush instead of additional async parameter
> - Move block chaining logic to flush callback than common nvdimm_flush
> - Use NULL flush callback for generic flush for better readability [Dan, Jan]
> 
> - Use virtio device id 27 from 25(already used) - [MST]
> 
> Changes from PATCH v4:
> - Factor out MAP_SYNC supported functionality to a common helper
> 				[Dave, Darrick, Jan]
> - Comment, indentation and virtqueue_kick failure handle - Yuval Shaia
> 
> Changes from PATCH v3: 
> - Use generic dax_synchronous() helper to check for DAXDEV_SYNC 
>   flag - [Dan, Darrick, Jan]
> - Add 'is_nvdimm_async' function
> - Document page cache side channel attacks implications & 
>   countermeasures - [Dave Chinner, Michael]
> 
> Changes from PATCH v2: 
> - Disable MAP_SYNC for ext4 & XFS filesystems - [Dan] 
> - Use name 'virtio pmem' in place of 'fake dax' 
> 
> Changes from PATCH v1: 
> - 0-day build test for build dependency on libnvdimm 
> 
>  Changes suggested by - [Dan Williams]
> - Split the driver into two parts virtio & pmem  
> - Move queuing of async block request to block layer
> - Add "sync" parameter in nvdimm_flush function
> - Use indirect call for nvdimm_flush
> - Don’t move declarations to common global header e.g nd.h
> - nvdimm_flush() return 0 or -EIO if it fails
> - Teach nsio_rw_bytes() that the flush can fail
> - Rename nvdimm_flush() to generic_nvdimm_flush()
> - Use 'nd_region->provider_data' for long dereferencing
> - Remove virtio_pmem_freeze/restore functions
> - Remove BSD license text with SPDX license text
> 
> - Add might_sleep() in virtio_pmem_flush - [Luiz]
> - Make spin_lock_irqsave() narrow
> 
> Pankaj Gupta (6):
>    libnvdimm: nd_region flush callback support
>    virtio-pmem: Add virtio-pmem guest driver
>    libnvdimm: add nd_region buffered dax_dev flag
>    dax: check synchronous mapping is supported
>    ext4: disable map_sync for virtio pmem
>    xfs: disable map_sync for virtio pmem
> 
> [1] https://lkml.org/lkml/2019/4/26/36
> [2] https://lkml.org/lkml/2019/4/23/1092
> [3] https://www.spinics.net/lists/kvm/msg149761.html
> [4] https://www.spinics.net/lists/kvm/msg153095.html  
> [5] https://lkml.org/lkml/2018/8/31/413
> [6] https://marc.info/?l=linux-kernel&m=153572228719237&w=2 
> [7] https://marc.info/?l=qemu-devel&m=153555721901824&w=2
> [8] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html
> [9] https://lkml.org/lkml/2019/1/9/1191
> 
>  drivers/acpi/nfit/core.c         |    4 -
>  drivers/dax/bus.c                |    2 
>  drivers/dax/super.c              |   13 +++
>  drivers/md/dm.c                  |    3 
>  drivers/nvdimm/Makefile          |    1 
>  drivers/nvdimm/claim.c           |    6 +
>  drivers/nvdimm/nd.h              |    1 
>  drivers/nvdimm/nd_virtio.c       |  129 +++++++++++++++++++++++++++++++++++++++
>  drivers/nvdimm/pmem.c            |   18 +++--
>  drivers/nvdimm/region_devs.c     |   33 +++++++++
>  drivers/nvdimm/virtio_pmem.c     |  117 +++++++++++++++++++++++++++++++++++
>  drivers/virtio/Kconfig           |   10 +++
>  fs/ext4/file.c                   |   10 +--
>  fs/xfs/xfs_file.c                |    9 +-
>  include/linux/dax.h              |   25 ++++++-
>  include/linux/libnvdimm.h        |    9 ++
>  include/linux/virtio_pmem.h      |   60 ++++++++++++++++++
>  include/uapi/linux/virtio_ids.h  |    1 
>  include/uapi/linux/virtio_pmem.h |   10 +++
>  19 files changed, 436 insertions(+), 25 deletions(-)
