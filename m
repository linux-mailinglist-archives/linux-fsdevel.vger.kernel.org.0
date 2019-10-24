Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5561E33E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 15:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502526AbfJXNXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 09:23:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502515AbfJXNXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gcU9exE6Bvro/lea/dgeXKEnFVXdIrFpf/E5Hgk7fI4=; b=OQCC9foswnxnaiFBJw3Vkn25h
        EYAPQY1qAspChDW7b9MiGr3xvZzEnkoJFlItmOqqQMuKR/ZYbKaWpl0U9RQ6lloZL7osMS1qn6Ow6
        aWk1g63FvYQPN6aNWq8gvaLOVZyaCumFoludpul3tgKhob/nbDJjq4uR8cgUloPmSKzZOdRHtfHyc
        1UEDbFuUYEkAqqinWPFaWz9z9C38x6reQS3b0Xysu8mwc3wpIZ2RSFOLNGZBxKZ2r2GPE5LpIDBIU
        vujiXu4n4Pz9PYh+gTk9i8t8xxMcbqb4UwrxGsXaSU391MPAxVU6XeAr3dY8/2Ul4JmJa15oFEhnX
        0/GSrw+7Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNd58-0000Lv-KB; Thu, 24 Oct 2019 13:23:14 +0000
Date:   Thu, 24 Oct 2019 06:23:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Michal Suchanek <msuchanek@suse.de>, linux-scsi@vger.kernel.org,
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
Message-ID: <20191024132314.GG2963@bombadil.infradead.org>
References: <cover.1571834862.git.msuchanek@suse.de>
 <da032629db4a770a5f98ff400b91b44873cbdf46.1571834862.git.msuchanek@suse.de>
 <20191024021958.GA11485@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024021958.GA11485@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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

It's OK to have the static on a line by itself; it's having 'static int'
on a line by itself that Linus gets unhappy about because he can't use
grep to see the return type.

But there's no need for it to be on a line by itself here, it all fits fine
in 80 columns.

