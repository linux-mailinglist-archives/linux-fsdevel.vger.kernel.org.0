Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765561D03FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 02:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbgEMAy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 20:54:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44470 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731910AbgEMAyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 20:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589331291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJeD/aOrfIoQ//ti865M5edH2b+NJXDkUCbs0+81Jmo=;
        b=LH3F3jR9otWKyCi2N1ANooQG/6JjDCv97cLOMmQBqAS9yV5nf4jIbRQEkmTsHuF3xEUAWv
        m2wjIKf94Ww/oHicSC3VPZkJq5rqYXubTMIQTIhwKRaDicJeHgqylrSXrsOMG/2wNEqsEb
        Na+AM8XdF+L3vKkX5BqCFslicSGJFoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-VlDqez_TPr2jz7vpNF2Jwg-1; Tue, 12 May 2020 20:54:47 -0400
X-MC-Unique: VlDqez_TPr2jz7vpNF2Jwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 133FA835B40;
        Wed, 13 May 2020 00:54:46 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 223CC1000079;
        Wed, 13 May 2020 00:54:43 +0000 (UTC)
Date:   Tue, 12 May 2020 20:54:40 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        yzaikin@google.com, tytso@mit.edu
Subject: Re: [PATCH v2] kernel: sysctl: ignore out-of-range taint bits
 introduced via kernel.tainted
Message-ID: <20200513005440.GK367616@optiplex-lnx>
References: <20200512223946.888020-1-aquini@redhat.com>
 <20200513003953.GK11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513003953.GK11244@42.do-not-panic.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 12:39:53AM +0000, Luis Chamberlain wrote:
> On Tue, May 12, 2020 at 06:39:46PM -0400, Rafael Aquini wrote:
> > Users with SYS_ADMIN capability can add arbitrary taint flags
> > to the running kernel by writing to /proc/sys/kernel/tainted
> > or issuing the command 'sysctl -w kernel.tainted=...'.

I just notice 2 minor 'screw ups' on my part in the commit log:

> > These interface, however, are open for any integer value
This one probably needs to be reprhased as:
 "The interface, however, is ... "


> > and this might an invalid set of flags being committed to
and I'm missing a verb here, as it should read:
 "and this might cause an invalid ... "


I hope these are easy fixes, in the pre-merge step. (Sorry!)

> > the tainted_mask bitset.
> > 
> > This patch introduces a simple way for proc_taint() to ignore
> > any eventual invalid bit coming from the user input before
> > committing those bits to the kernel tainted_mask.
> > 
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> 

Thanks!
-- Rafael

