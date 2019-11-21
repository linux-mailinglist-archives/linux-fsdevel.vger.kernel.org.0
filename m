Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93876105D53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 00:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKUXnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 18:43:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:44088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfKUXnp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:43:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2D6CAECB;
        Thu, 21 Nov 2019 23:43:42 +0000 (UTC)
Date:   Fri, 22 Nov 2019 00:43:39 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 00/10] Fix cdrom autoclose
Message-ID: <20191121234339.GL11661@kitsune.suse.cz>
References: <cover.1574355709.git.msuchanek@suse.de>
 <4ba670de-80d4-130e-91f3-c6e1cc9c7a47@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ba670de-80d4-130e-91f3-c6e1cc9c7a47@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 12:00:03PM -0700, Jens Axboe wrote:
> On 11/21/19 10:13 AM, Michal Suchanek wrote:
> > Hello,
> > 
> > there is cdrom autoclose feature that is supposed to close the tray,
> > wait for the disc to become ready, and then open the device.
> > 
> > This used to work in ancient times. Then in old times there was a hack
> > in util-linux which worked around the breakage which probably resulted
> > from switching to scsi emulation.
> > 
> > Currently util-linux maintainer refuses to merge another hack on the
> > basis that kernel still has the feature so it should be fixed there.
> > The code needs not be replicated in every userspace utility like mount
> > or dd which has no business knowing which devices are CD-roms and where
> > the autoclose setting is in the kernel.
> 
> This is a lot of code/churn (and even an fops addition...) to work around
> a broken hw emulation, essentially. Why aren't we just pushing vmware
> to fix this?

This is fix for kernel feature: cdrom autoclose.

There is one patch that deals with blacklisting the feature on VMWare
becase their emulation is broken and triggers an issue with the feature
when it actually works.

Thanks

Michal
