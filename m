Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A3FE48BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 12:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394432AbfJYKmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 06:42:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:53626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730471AbfJYKmf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:42:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6C93B2FC;
        Fri, 25 Oct 2019 10:42:32 +0000 (UTC)
Date:   Fri, 25 Oct 2019 12:42:30 +0200
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
Message-ID: <20191025104230.GN938@kitsune.suse.cz>
References: <cover.1571834862.git.msuchanek@suse.de>
 <da032629db4a770a5f98ff400b91b44873cbdf46.1571834862.git.msuchanek@suse.de>
 <20191024021958.GA11485@infradead.org>
 <20191024085014.GF938@kitsune.suse.cz>
 <20191025023908.GB14108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191025023908.GB14108@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 07:39:08PM -0700, Christoph Hellwig wrote:
> On Thu, Oct 24, 2019 at 10:50:14AM +0200, Michal Suchánek wrote:
> > Then I will get complaints I do unrelated changes and it's hard to
> > review. The code gets removed later anyway.
> 
> If you refactor you you pretty much have a card blanche for the
> refactored code and the direct surroundings.

This is different from what other reviewers say:

https://lore.kernel.org/lkml/1517245320.2687.14.camel@wdc.com/

Either way, this code is removed in a later patch so this discussion is
moot. It makes sense to have a bisection point here in case something
goes wrong but it is pointless to argue about the code structure
inherited from the previous revision.

Thanks

Michal
