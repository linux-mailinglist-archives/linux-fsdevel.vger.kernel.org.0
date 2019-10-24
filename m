Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B279E2C80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 10:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438370AbfJXIuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 04:50:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51128 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729514AbfJXIuS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:50:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E726EB087;
        Thu, 24 Oct 2019 08:50:15 +0000 (UTC)
Date:   Thu, 24 Oct 2019 10:50:14 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] cdrom: factor out common open_for_* code
Message-ID: <20191024085014.GF938@kitsune.suse.cz>
References: <cover.1571834862.git.msuchanek@suse.de>
 <da032629db4a770a5f98ff400b91b44873cbdf46.1571834862.git.msuchanek@suse.de>
 <20191024021958.GA11485@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024021958.GA11485@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 07:19:58PM -0700, Christoph Hellwig wrote:
> >  static
> > -int open_for_data(struct cdrom_device_info *cdi)
> > +int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)
> 
> Please fix the coding style.  static never should be on a line of its
> own..

That's fine.

> 
> >  			} else {
> >  				cd_dbg(CD_OPEN, "bummer. this drive can't close the tray.\n");
> > -				ret=-ENOMEDIUM;
> > -				goto clean_up_and_return;
> > +				return -ENOMEDIUM;
> 
> Can you revert the polarity of the if opening the block before and
> return early for the -ENOMEDIUM case to save on leven of indentation?

Then I will get complaints I do unrelated changes and it's hard to
review. The code gets removed later anyway.

Thanks

Michal
