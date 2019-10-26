Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA48E58E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2019 08:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfJZGw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Oct 2019 02:52:28 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58690 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJZGw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Oct 2019 02:52:28 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Oct 2019 02:52:27 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id E98AF2A49A;
        Sat, 26 Oct 2019 02:46:09 -0400 (EDT)
Date:   Sat, 26 Oct 2019 17:46:08 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     =?ISO-8859-15?Q?Michal_Such=E1nek?= <msuchanek@suse.de>
cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
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
In-Reply-To: <20191025104230.GN938@kitsune.suse.cz>
Message-ID: <alpine.LNX.2.21.1910261652580.8@nippy.intranet>
References: <cover.1571834862.git.msuchanek@suse.de> <da032629db4a770a5f98ff400b91b44873cbdf46.1571834862.git.msuchanek@suse.de> <20191024021958.GA11485@infradead.org> <20191024085014.GF938@kitsune.suse.cz> <20191025023908.GB14108@infradead.org>
 <20191025104230.GN938@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 25 Oct 2019, Michal Such?nek wrote:

> On Thu, Oct 24, 2019 at 07:39:08PM -0700, Christoph Hellwig wrote:
> > On Thu, Oct 24, 2019 at 10:50:14AM +0200, Michal Such?nek wrote:
> > > Then I will get complaints I do unrelated changes and it's hard to
> > > review. The code gets removed later anyway.
> > 
> > If you refactor you you pretty much have a card blanche for the
> > refactored code and the direct surroundings.
> 
> This is different from what other reviewers say:
> 
> https://lore.kernel.org/lkml/1517245320.2687.14.camel@wdc.com/
> 

I don't see any inconsistency there. Both reviews are valuable.

In general, different reviewers may give contradictory advice. Reviewers 
probably even contradict themselves eventually. Yet it rarely happens that 
the same patch gets contradictory reviews. If it did, you might well 
complain.

> Either way, this code is removed in a later patch so this discussion is
> moot.
> 
> It makes sense to have a bisection point here in case something
> goes wrong but it is pointless to argue about the code structure
> inherited from the previous revision.

A patch may refactor some code only to have the next patch remove that 
code. This doesn't generally mean that the former patch is redundant.

The latter patch may end up committed and subsequently reverted. The 
latter patch may become easier to review because of the former. The former 
patch may be eligible for -stable. The former patch may be the result of 
an automatic process. And so on.

I don't know what Christoph had in mind here but he's usually right, so 
it's worth asking.

-- 

> 
> Thanks
> 
> Michal
> 
