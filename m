Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE62172A77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 22:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgB0Vwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 16:52:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42944 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729872AbgB0Vwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582840359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UXkdCtTkO49ytr+egfYOWUQHFCGfaWE6lMIRwlJTVOE=;
        b=PfZO1glI+Xxg6MnP0YjLFyV7KsMu49az6GEro0Gb68q08TmPoz45e1CqkUhZcu3pKdSDT9
        GosKo8susoNutoSIaPKESq+9TFu8yYxEX+RRM4XMgXRChcBx/lThs5Tuw9mTcLXY0Ismj+
        g69zeut4erEmzyAkt2tRvsiiyo10bGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-SOFEDrlRNbWXKgxjkOOMeg-1; Thu, 27 Feb 2020 16:52:31 -0500
X-MC-Unique: SOFEDrlRNbWXKgxjkOOMeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3444800D5E;
        Thu, 27 Feb 2020 21:52:28 +0000 (UTC)
Received: from treble (ovpn-121-128.rdu2.redhat.com [10.10.121.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91E1460BE0;
        Thu, 27 Feb 2020 21:52:26 +0000 (UTC)
Date:   Thu, 27 Feb 2020 15:52:24 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: mmotm 2020-02-24-19-53 uploaded (objtool warning)
Message-ID: <20200227215224.5q7slx2eikkxwhwi@treble>
References: <20200225035348.xf9KRK471%akpm@linux-foundation.org>
 <c15a7c7e-df7c-8a30-0bb1-03f8b04b7be5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c15a7c7e-df7c-8a30-0bb1-03f8b04b7be5@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 09:01:54AM -0800, Randy Dunlap wrote:
> On 2/24/20 7:53 PM, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2020-02-24-19-53 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> 
> Still seeing this one:
> 
> on x86_64:
> 
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x5b7: call to gen8_canonical_addr() with UACCESS enabled

Forgot I had a patch for this.  Posting shortly.

-- 
Josh

