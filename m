Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4080AE2814
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 04:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408204AbfJXCXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 22:23:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406400AbfJXCXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vJ7j9LQd7S7QIAAJzEdisIEukG2BKKmKMweulQXxzDw=; b=Re+5E5SJ0jwb4h7tx1tKt41ND
        PeDNgCRrmipVa7pyo+jZIxfMWf1NbM2RePcepJW+xE5WfV/+DQCMvKyMTaa3+PgcjOK1rEC69jm6L
        DKK83WfnhzWet6fflSqycfuoXAitJYP2oWwbaQeYfRkozqwsg/pf1NWfm1aMvFJ6HybT0Yg/HkpnM
        aNWhX7W5JJRf9vGzR0DQlFLeMmk2VbgzrmmtVquYET++Cu5vEsbj1hOoRg/PRO0mYnkDWsbv1Gb5x
        uXrJzFxeO9CAsXrPLXqJSnSenHl8dz0hbbY1+Ur/CUMfkOU7qjmM8u4k8Lz1upn7eRaAKXLmpa2n2
        IIGkYZyWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNSmJ-0004Zs-So; Thu, 24 Oct 2019 02:23:07 +0000
Date:   Wed, 23 Oct 2019 19:23:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Suchanek <msuchanek@suse.de>
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
Subject: Re: [PATCH v2 7/8] scsi: sr: workaround VMware ESXi cdrom emulation
 bug
Message-ID: <20191024022307.GC11485@infradead.org>
References: <cover.1571834862.git.msuchanek@suse.de>
 <abf81ec4f8b6139fffc609df519856ff8dc01d0d.1571834862.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf81ec4f8b6139fffc609df519856ff8dc01d0d.1571834862.git.msuchanek@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 02:52:46PM +0200, Michal Suchanek wrote:
> 
> The drive claims to have a tray and claims to be able to close it.
> However, the UI has no notion of a tray - when medium is ejected it is
> dropped in the floor and the user must select a medium again before the
> drive can be re-loaded.  On the kernel side the tray_move call to close
> the tray succeeds but the drive state does not change as a result of the
> call.
> 
> The drive does not in fact emulate the tray state. There are two ways to
> get the medium state. One is the SCSI status:

Given that this is a buggy software emulation we should not add more
than 100 lines of kernel code to work around it.  Ask VMware to fix
their mess instead.
