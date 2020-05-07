Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB7B1C9C93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 22:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgEGUmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 16:42:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42438 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726644AbgEGUmg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 16:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588884156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b8a0Z2antnJYCUF8WBh734GS5zKFlaHhrNwslLNb//k=;
        b=ZQAoF8RfRWt9jEo9n9vX3LFJroz8L7LxIfzVS624uNmDbQXT8tG6r0Cm71IzfKEx9nAguS
        71FjaKkVENkLFjuWDV28v0BXYlNujwD5rXsqMQTSWX8cQPdtszmFtr/O6X/A/YUWkzuBQf
        Zey9F894gcJ0n5omuJat9/ZicLgWMJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-AT7T8A5AMTS2CeTivjxVYw-1; Thu, 07 May 2020 16:42:31 -0400
X-MC-Unique: AT7T8A5AMTS2CeTivjxVYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0944580183C;
        Thu,  7 May 2020 20:42:29 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63D8019C4F;
        Thu,  7 May 2020 20:42:22 +0000 (UTC)
Date:   Thu, 7 May 2020 16:42:19 -0400
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
Message-ID: <20200507204219.GJ205881@optiplex-lnx>
References: <20200506222815.274570-1-aquini@redhat.com>
 <C5E11731-5503-45CC-9F72-41E8863ACD27@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5E11731-5503-45CC-9F72-41E8863ACD27@lca.pw>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 06, 2020 at 10:50:19PM -0400, Qian Cai wrote:
> 
> 
> > On May 6, 2020, at 6:28 PM, Rafael Aquini <aquini@redhat.com> wrote:
> > 
> > Analogously to the introduction of panic_on_warn, this patch
> > introduces a kernel option named panic_on_taint in order to
> > provide a simple and generic way to stop execution and catch
> > a coredump when the kernel gets tainted by any given taint flag.
> > 
> > This is useful for debugging sessions as it avoids rebuilding
> > the kernel to explicitly add calls to panic() or BUG() into
> > code sites that introduce the taint flags of interest.
> > Another, perhaps less frequent, use for this option would be
> > as a mean for assuring a security policy (in paranoid mode)
> > case where no single taint is allowed for the running system.
> 
> Andrew, you can drop the patch below from -mm now because that one is now obsolete,
> 
> mm-slub-add-panic_on_error-to-the-debug-facilities.patch
>
Please, don't drop it yet. I'll send a patch to get rid of the bits,
once this one gets accepted, if it gets accepted.

-- Rafael 

