Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BBB1CC6F6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 07:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgEJFRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 01:17:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52838 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726389AbgEJFRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 01:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589087823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tCJf3aD47ctQEj0+bjTncfKWspILH0i2eRAlZk7YIas=;
        b=YkA+bNRDfKCq+NmOCS2CsehwT+8p7u3Brk/3C/kSzRC9vUa2Op3Gz+55ebaBTpU36NAr4H
        E5zKt1n3A53puuQihq9HHS4raC005hHPJExsTnMw+PlCBCWzTtcGejx5XythiSwYiwu2pe
        J2nJBDeTQ5Lme2XAvcWZdpPUP+l19WA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-1wSi7USNNkmzpDGYI08JnQ-1; Sun, 10 May 2020 01:17:00 -0400
X-MC-Unique: 1wSi7USNNkmzpDGYI08JnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23DD980058A;
        Sun, 10 May 2020 05:16:57 +0000 (UTC)
Received: from localhost (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8EB7704C6;
        Sun, 10 May 2020 05:16:48 +0000 (UTC)
Date:   Sun, 10 May 2020 13:16:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Rafael Aquini <aquini@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, dyoung@redhat.com, corbet@lwn.net,
        mcgrof@kernel.org, keescook@chromium.org,
        akpm@linux-foundation.org, cai@lca.pw, tytso@mit.edu,
        bunk@kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, labbott@redhat.com, jeffm@suse.com,
        jikos@kernel.org, jeyu@suse.de, tiwai@suse.de, AnDavis@suse.com,
        rpalethorpe@suse.de
Subject: Re: [PATCH v3] kernel: add panic_on_taint
Message-ID: <20200510051646.GF5029@MiWiFi-R3L-srv>
References: <20200509135737.622299-1-aquini@redhat.com>
 <20200510025921.GA10165@MiWiFi-R3L-srv>
 <acab7971-7522-3511-c976-e0237ceda4d0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acab7971-7522-3511-c976-e0237ceda4d0@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/09/20 at 09:10pm, Randy Dunlap wrote:
> On 5/9/20 7:59 PM, Baoquan He wrote:
> > Read admin-guide/tainted-kernels.rst, but still do not get what 'G' means.
> 
> I interpret 'G' as GPL (strictly it means that no proprietary module has
> been loaded).  But I don't see why TAINT_PROPRIETARY_MODULE is the only
> taint flag that has a non-blank c_false character.  It could just be blank
> also AFAICT.  Then the 'G' would not be there to confuse us.  :)

Yeah, seems c_false character is not so necessary. If no 'P' set, then
it means no proprietary modules loaded naturally. We may need clean up
the c_false in struct taint_flag, since c_true is enough to indicate
what want to check.


