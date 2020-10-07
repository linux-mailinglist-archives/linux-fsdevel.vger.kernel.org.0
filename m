Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00FD286183
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 16:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgJGOtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 10:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728535AbgJGOtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602082145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nG6n8iQw6ndSbR0MV2n6BWmlRza/GffluKmq0dVxVlg=;
        b=HLToJCYGkzEWh11G0epCeOud1ToWSWEq6CFt476W7gxn8hOelsmTWBxswGF6cwrYxq6CFR
        Yr1nRX8NEZ1oX1U3IYgxi1NWI2auBd4tBAMRp7BzBSKvG5Otag0PFlUPF0Ib/0t2y786bT
        jzQLs7mrtOCUlA5eysc0Q9fcmNP8QMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-4qnaVhh2M-CFZ1ehWGyQdQ-1; Wed, 07 Oct 2020 10:49:03 -0400
X-MC-Unique: 4qnaVhh2M-CFZ1ehWGyQdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EEA3804024;
        Wed,  7 Oct 2020 14:48:38 +0000 (UTC)
Received: from redhat.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 383A95579D;
        Wed,  7 Oct 2020 14:48:37 +0000 (UTC)
Date:   Wed, 7 Oct 2020 10:48:35 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 00/14] Small step toward KSM for file back page.
Message-ID: <20201007144835.GA3471400@redhat.com>
References: <20201007010603.3452458-1-jglisse@redhat.com>
 <20201007032013.GS20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007032013.GS20115@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 07, 2020 at 04:20:13AM +0100, Matthew Wilcox wrote:
> On Tue, Oct 06, 2020 at 09:05:49PM -0400, jglisse@redhat.com wrote:
> > The present patchset just add mapping argument to the various vfs call-
> > backs. It does not make use of that new parameter to avoid regression.
> > I am posting this whole things as small contain patchset as it is rather
> > big and i would like to make progress step by step.
> 
> Well, that's the problem.  This patch set is gigantic and unreviewable.
> And it has no benefits.  The idea you present here was discussed at
> LSFMM in Utah and I recall absolutely nobody being in favour of it.
> You claim many wonderful features will be unlocked by this, but I think
> they can all be achieved without doing any of this very disruptive work.

You have any ideas on how to achieve them without such change ? I will
be more than happy for a simpler solution but i fail to see how you can
work around the need for a pointer inside struct page. Given struct
page can not grow it means you need to be able to overload one of the
existing field, at least i do not see any otherway.

Cheers,
Jérôme

