Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F22C19CE09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 03:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390186AbgDCBCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 21:02:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20734 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731842AbgDCBCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585875761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bO3hj+XmbvjHKiWwQG5/9JyKi4fYtwG5ksjHsl3Ubkw=;
        b=d0Qb5UHnBuHDm59bEJ4IYZO10oRe5vLFz65KKfURM0bpury6AZDsiK/MWdHXUkSPgyIqWR
        S+73AE8r6eTIJts0jr9y2k2hl13a8GbbYGJoSZ6Ak1k36wUlv/Gdm+hBRpLv/kC3qgQhaR
        6hcECErkOjiTXn1rQFbK/Sk4McvkjVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-tU0DVqRKPReeeNCAHzbbSQ-1; Thu, 02 Apr 2020 21:02:37 -0400
X-MC-Unique: tU0DVqRKPReeeNCAHzbbSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF3998017CE;
        Fri,  3 Apr 2020 01:02:35 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 124255D9CA;
        Fri,  3 Apr 2020 01:02:33 +0000 (UTC)
Date:   Thu, 2 Apr 2020 21:02:32 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        david <david@fromorbit.com>, jmoyer <jmoyer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH v6 4/6] dm,dax: Add dax zero_page_range operation
Message-ID: <20200403010231.GA4475@redhat.com>
References: <20200228163456.1587-1-vgoyal@redhat.com>
 <20200228163456.1587-5-vgoyal@redhat.com>
 <CAPcyv4iWfL+KQjjUXqrTKOL8F4M05Vu=imm5tqsD6MO=XLzoMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iWfL+KQjjUXqrTKOL8F4M05Vu=imm5tqsD6MO=XLzoMA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31 2020 at  3:34pm -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> [ Add Mike ]
> 
> On Fri, Feb 28, 2020 at 8:35 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > This patch adds support for dax zero_page_range operation to dm targets.
> 
> Mike,
> 
> Sorry, I should have pinged you earlier, but could you take a look at
> this patch and ack it if it looks ok to go through the nvdimm tree
> with the rest of the series?

Yes, looks fine to me.

Acked-by: Mike Snitzer <snitzer@redhat.com>

