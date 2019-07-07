Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701656158F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2019 18:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfGGQgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 12:36:24 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54495 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbfGGQgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 12:36:24 -0400
Received: from callcc.thunk.org (75-104-86-74.mobility.exede.net [75.104.86.74] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x67GYGms007613
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 7 Jul 2019 12:34:23 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 26D6A42002E; Sun,  7 Jul 2019 12:34:15 -0400 (EDT)
Date:   Sun, 7 Jul 2019 12:34:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     dm-devel@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, dan.j.williams@intel.com,
        zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        mst@redhat.com, jasowang@redhat.com, willy@infradead.org,
        rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org,
        jack@suse.cz, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
        jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
        stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
        david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pbonzini@redhat.com,
        yuval.shaia@oracle.com, kilobyte@angband.pl, jstaron@google.com,
        rdunlap@infradead.org, snitzer@redhat.com
Subject: Re: [PATCH v15 6/7] ext4: disable map_sync for async flush
Message-ID: <20190707163415.GA19775@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Pankaj Gupta <pagupta@redhat.com>, dm-devel@redhat.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, dan.j.williams@intel.com,
        zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        mst@redhat.com, jasowang@redhat.com, willy@infradead.org,
        rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
        jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
        stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
        david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pbonzini@redhat.com,
        yuval.shaia@oracle.com, kilobyte@angband.pl, jstaron@google.com,
        rdunlap@infradead.org, snitzer@redhat.com
References: <20190705140328.20190-1-pagupta@redhat.com>
 <20190705140328.20190-7-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705140328.20190-7-pagupta@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 05, 2019 at 07:33:27PM +0530, Pankaj Gupta wrote:
> Dont support 'MAP_SYNC' with non-DAX files and DAX files
> with asynchronous dax_device. Virtio pmem provides
> asynchronous host page cache flush mechanism. We don't
> support 'MAP_SYNC' with virtio pmem and ext4.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Theodore Ts'o <tytso@mit.edu>

