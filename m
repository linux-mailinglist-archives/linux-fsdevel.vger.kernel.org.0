Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D41A15396B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 21:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgBEUKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 15:10:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49921 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbgBEUKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 15:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580933439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/vQfSuPBtx1Q3O/BwmRCIp9E8kAYEBhXKXHh0n/79/0=;
        b=XLjR6HIFLt7D6vQLmCCGoNCb6yuqDHAb6+cI1+Tpvj7eiWTQxEKnGvyl44PbqQeA31zuDN
        SBaP6Ljf492kn8ekKBjUwS1qBon8fPqO+peK4kAloRZlUnnXqnTsPVRr2dWCYyiqUdoohe
        8qpAiKTLB1E0qzqp+J/SI4UipWPdhUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-jI6uKsIZOAO6my92dghB-g-1; Wed, 05 Feb 2020 15:10:35 -0500
X-MC-Unique: jI6uKsIZOAO6my92dghB-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 234C71007277;
        Wed,  5 Feb 2020 20:10:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98BC4100164D;
        Wed,  5 Feb 2020 20:10:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 272472202E9; Wed,  5 Feb 2020 15:10:31 -0500 (EST)
Date:   Wed, 5 Feb 2020 15:10:31 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, dm-devel@redhat.com
Subject: Re: [PATCH 4/5] dax,iomap: Start using dax native zero_page_range()
Message-ID: <20200205201031.GG14544@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-5-vgoyal@redhat.com>
 <20200205183356.GD26711@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205183356.GD26711@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:33:56AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 03, 2020 at 03:00:28PM -0500, Vivek Goyal wrote:
> > +	id = dax_read_lock();
> > +	rc = dax_zero_page_range(dax_dev, pgoff, offset, size);
> > +	dax_read_unlock(id);
> > +	return rc;
> 
> Is there a good reason not to move the locking into dax_zero_page_range?

No reason. I can move locking inside dax_zero_page_range(). Will do.

Vivek

