Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C39BFD1D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 01:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKOAJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 19:09:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28026 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726953AbfKOAJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573776586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cHPeeFk62cfhiin+++uryp8ZtcZOe3SLmduzYZNfWM=;
        b=IwJYqkwH/eC82LmcvGmP1/1Xj0B2FwV5AM6HIV5MX5ZmPZOVm/9lQFbSDcQJ/FhmpWVCe0
        UYbUkM7Irfz5xW/+zQhS7IDZYWIeetPxP5dYmhzOnEB1SfbRp70D1f/aD5v4GSN8aTApnn
        nx6NChHjiBTgoPDfYMuM2jFCNCyalsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-zxLGyfdnOxSeWj7D5R9B-A-1; Thu, 14 Nov 2019 19:09:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 356F78048E5;
        Fri, 15 Nov 2019 00:09:41 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56B3260CD0;
        Fri, 15 Nov 2019 00:09:29 +0000 (UTC)
Date:   Fri, 15 Nov 2019 08:09:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191115000925.GB4847@ming.t460p>
References: <20191114113153.GB4213@ming.t460p>
 <20191114131434.GQ4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20191114131434.GQ4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: zxLGyfdnOxSeWj7D5R9B-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 02:14:34PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 14, 2019 at 07:31:53PM +0800, Ming Lei wrote:
> > Hi Guys,
> >=20
> > It is found that single AIO thread is migrated crazely by scheduler, an=
d
> > the migrate period can be < 10ms. Follows the test a):
>=20
> What does crazy mean? Does it cycle through the L3 mask?
>=20

The single thread AIO thread is migrated in several milliseconds once.


Thanks,
Ming

