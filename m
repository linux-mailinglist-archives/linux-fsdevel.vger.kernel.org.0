Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675F8296067
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 15:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368063AbgJVNvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 09:51:31 -0400
Received: from mx4.veeam.com ([104.41.138.86]:45074 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900458AbgJVNva (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:51:30 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 7CB8487A6E;
        Thu, 22 Oct 2020 16:51:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1603374684; bh=hjvmd6gWpnWjR7TnCCxRK2ZgAh717xbXw2Fsp2Yhyhs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=ALHxwxcOkuNdbIv3ZQxhgQea5C5irM83Ao/C9PIEbyxA2wOHfOaKUFsH8tVqHFAmx
         2TADivC59bGpA5YsyjYjUdBS6A9K5R2b9ai6E/KS6adEgpa1mJTe3qiqCyi1WLk925
         EVecl2M+i+3/T1K6q3ON0tWxN0/TkgwWQ38KT3J4=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 22 Oct 2020
 15:51:22 +0200
Date:   Thu, 22 Oct 2020 16:52:13 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Hannes Reinecke <hare@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/2] block layer filter and block device snapshot module
Message-ID: <20201022135213.GB21466@veeam.com>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <71926887-5707-04a5-78a2-ffa2ee32bd68@suse.de>
 <20201021141044.GF20749@veeam.com>
 <ca8eaa40-b422-2272-1fd9-1d0a354c42bf@suse.de>
 <20201022094402.GA21466@veeam.com>
 <BL0PR04MB6514AC1B1FF313E6A14D122CE71D0@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <BL0PR04MB6514AC1B1FF313E6A14D122CE71D0@BL0PR04MB6514.namprd04.prod.outlook.com>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26A677464
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 10/22/2020 13:28, Damien Le Moal wrote:
> On 2020/10/22 18:43, Sergei Shtepa wrote:
> > 
> > Maybe, but the problem is that I can't imagine how to implement
> > dm-intercept yet. 
> > How to use dm to implement interception without changing the stack
> > of block devices. We'll have to make a hook somewhere, isn`t it?
> 
> Once your dm-intercept target driver is inserted with "dmsetup" or any user land
> tool you implement using libdevicemapper, the "hooks" will naturally be in place
> since the dm infrastructure already does that: all submitted BIOs will be passed
> to dm-intercept through the "map" operation defined in the target_type
> descriptor. It is then that driver job to execute the BIOs as it sees fit.
> 
> Look at simple device mappers like dm-linear or dm-flakey for hints of how
> things work (driver/md/dm-linear.c). More complex dm drivers like dm-crypt,
> dm-writecache or dm-thin can give you hints about more features of device mapper.
> Functions such as __map_bio() in drivers/md/dm.c are the core of DM and show
> what happens to BIOs depending on the the return value of the map operation.
> dm_submit_bio() and __split_and_process_bio() is the entry points for BIO
> processing in DM.
> 

Is there something I don't understand? Please correct me.

Let me remind that by the condition of the problem, we can't change
the configuration of the block device stack.

Let's imagine this configuration: /root mount point on ext filesystem
on /dev/sda1.
+---------------+
|               |
|  /root        |
|               |
+---------------+
|               |
| EXT FS        |
|               |
+---------------+
|               |
| block layer   |
|               |
| sda queue     |
|               |
+---------------+
|               |
| scsi driver   |
|               |
+---------------+

We need to add change block tracking (CBT) and snapshot functionality for
incremental backup.

With the DM we need to change the block device stack. Add device /dev/sda1
to LVM Volume group, create logical volume, change /etc/fstab and reboot.

The new scheme will look like this:
+---------------+
|               |
|  /root        |
|               |
+---------------+
|               |
| EXT FS        |
|               |
+---------------+
|               |
| LV-root       |
|               |
+------------------+
|                  |
| dm-cbt & dm-snap |
|                  |
+------------------+
|               |
| sda queue     |
|               |
+---------------+
|               |
| scsi driver   |
|               |
+---------------+

But I cannot change block device stack. And so I propose a scheme with
interception.
+---------------+
|               |
|  /root        |
|               |
+---------------+
|               |
| EXT FS        |
|               |
+---------------+   +-----------------+
|  |            |   |                 |
|  | blk-filter |-> | cbt & snapshot  |
|  |            |<- |                 |
|  +------------+   +-----------------+
|               |
| sda blk queue |
|               |
+---------------+
|               |
| scsi driver   |
|               |
+---------------+

Perhaps I can make "cbt & snapshot" inside the DM, but without interception
in any case, it will not work. Isn't that right?

-- 
Sergei Shtepa
Veeam Software developer.
