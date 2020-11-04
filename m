Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7D42A67E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 16:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgKDPkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 10:40:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729992AbgKDPkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604504409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPvtNi0fWtu3e7U/ZEYRHIyUhMYOakG1awB8Vk3JXsQ=;
        b=HMTKkOgiF/Y5KhiyJnczxLvpnzXb/JqNsC3/TTOh2o2AhE5o0kmUKGBlWeWP2nRyfG8BVB
        rkyNyhx4YIDWeMSHG56fYtrD0Iz1g9COCA9hOfFJrzF8uoN9dDne0hKdkG3to+ZpTkzPDI
        D+0i0os+VByIyBGhbI5mfLmt+vn1P+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-ejY8Y8HcOJisIPjKOwABkw-1; Wed, 04 Nov 2020 10:40:07 -0500
X-MC-Unique: ejY8Y8HcOJisIPjKOwABkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82A398030DD;
        Wed,  4 Nov 2020 15:40:05 +0000 (UTC)
Received: from ovpn-112-92.rdu2.redhat.com (ovpn-112-92.rdu2.redhat.com [10.10.112.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59F0D610F3;
        Wed,  4 Nov 2020 15:40:04 +0000 (UTC)
Message-ID: <37abe67a5a7d83b361932464b4af499fdeaf5ef7.camel@redhat.com>
Subject: Re: kernel BUG at mm/page-writeback.c:2241 [
 BUG_ON(PageWriteback(page); ]
From:   Qian Cai <cai@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 04 Nov 2020 10:40:03 -0500
In-Reply-To: <20201104151605.GG5600@quack2.suse.cz>
References: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
         <20201022004906.GQ20115@casper.infradead.org>
         <20201026094948.GA29758@quack2.suse.cz>
         <20201026131353.GP20115@casper.infradead.org>
         <d06d3d2a-7032-91da-35fa-a9dee4440a14@kernel.dk>
         <aa3dfe1f9705f02197f9a75b60d4c28cc97ddff4.camel@redhat.com>
         <20201104151605.GG5600@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-11-04 at 16:16 +0100, Jan Kara wrote:
> On Mon 26-10-20 10:26:26, Qian Cai wrote:
> > On Mon, 2020-10-26 at 07:55 -0600, Jens Axboe wrote:
> > > I've tried to reproduce this as well, to no avail. Qian, could you perhaps
> > > detail the setup? What kind of storage, kernel config, compiler, etc.
> > > 
> > 
> > So far I have only been able to reproduce on this Intel platform:
> > 
> > HPE DL560 gen10
> > Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz
> > 131072 MB memory, 1000 GB disk space (smartpqi nvme)
> 
> Did you try running with the debug patch Matthew sent? Any results?
Running every day, but no luck so far.

