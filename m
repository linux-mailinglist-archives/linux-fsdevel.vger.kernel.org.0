Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89A1C9F26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 01:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgEGXgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 19:36:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26567 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbgEGXgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 19:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588894608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IF1gr0Ej8dhAMBdv+LPk159EvF5Y2nzU/01Tj5qgwcY=;
        b=UXF3Xdkps3VlLgGiPy0EaDpr5225trAVWP24qdg9Krh/IAU2J/3+MDDDiDpL8D5ccdL0Uq
        2MjpQFUZ/SzNfvP1Q+9eHtvF/vSDfB0GMDLZEKgWau2yob7U+WrKjRLl7zeXQTvDo+1jHb
        WuQB5ZEPzImpCXL0nlIIW+ju+qVnulE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-wTxwCdqhMDe1rHI9QmCmlw-1; Thu, 07 May 2020 19:36:46 -0400
X-MC-Unique: wTxwCdqhMDe1rHI9QmCmlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 196B21899520;
        Thu,  7 May 2020 23:36:45 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6101707B0;
        Thu,  7 May 2020 23:36:37 +0000 (UTC)
Date:   Thu, 7 May 2020 19:36:34 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] kernel: add panic_on_taint
Message-ID: <20200507233634.GA367616@optiplex-lnx>
References: <20200507221503.GL205881@optiplex-lnx>
 <6B423101-ACF4-49A3-AD53-ACBF87F1ABE0@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6B423101-ACF4-49A3-AD53-ACBF87F1ABE0@lca.pw>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 07, 2020 at 07:07:20PM -0400, Qian Cai wrote:
> 
> 
> > On May 7, 2020, at 6:15 PM, Rafael Aquini <aquini@redhat.com> wrote:
> > 
> > It's a reasonable and self-contained feature that we have a valid use for. 
> > I honestly fail to see it causing that amount of annoyance as you are 
> > suggesting here.
> 
> It is not a big trouble yet, but keeping an obsolete patch that not very straightforward to figure out that it will be superseded by the panic_on_taint patch will only cause more confusion the longer it has stayed in linux-next.
> 
> The thing is that even if you can’t get this panic_on_taint (the superior solution) patch accepted for some reasons, someone else could still work on it until it get merged.
> 
> Thus, I failed to see any possibility we will go back to the inferior solution (mm-slub-add-panic_on_error-to-the-debug-facilities.patch) by all means.
>

There are plenty of examples of things being added, changed, and
removed in -next. IOW, living in a transient state. I think it's 
a reasonable compromise to keep it while the other one is beind 
ironed out.

The fact that you prefer one solution to another doesn't
invalidate the one you dislike. 

Cheers,
-- Rafael

