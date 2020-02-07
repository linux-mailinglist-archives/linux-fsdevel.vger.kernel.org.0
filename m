Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D992155BDA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 17:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGQeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 11:34:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52401 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726936AbgBGQeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581093253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3QRTAga3VQ9v/y6z6auDep6PqNUpoH7brYD9i0zJlUs=;
        b=VdDj+iDd5ju97kc6DezwxjQ/KbTDbwwMS5SHZKZC5JoL95iy2d4VGbMd6EpwhUY6ZjF9jq
        qbjW2H0jAu+Wb4y8SWGX3kWjmTFIGExNmVq5RGFxTaemeOfdwpf4W51gRdqZ7yJfA1/fVx
        BIJyAh66IsuAdrYe82pSzRUuSris+Q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-FcrUSCs0P4araZ4RMEpJ8Q-1; Fri, 07 Feb 2020 11:34:05 -0500
X-MC-Unique: FcrUSCs0P4araZ4RMEpJ8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 896671005513;
        Fri,  7 Feb 2020 16:34:04 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F08FD790E1;
        Fri,  7 Feb 2020 16:34:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 63FFF220A24; Fri,  7 Feb 2020 11:34:01 -0500 (EST)
Date:   Fri, 7 Feb 2020 11:34:01 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, dm-devel@redhat.com
Subject: Re: [PATCH 3/5] dm,dax: Add dax zero_page_range operation
Message-ID: <20200207163401.GB11998@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-4-vgoyal@redhat.com>
 <20200205183304.GC26711@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205183304.GC26711@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:33:04AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 03, 2020 at 03:00:27PM -0500, Vivek Goyal wrote:
> > This patch adds support for dax zero_page_range operation to dm targets.
> 
> Any way to share the code with the dax copy iter here?

Had a look at it and can't think of a good way of sharing the code. If
you have something specific in mind, I am happy to make changes.

Vivek

