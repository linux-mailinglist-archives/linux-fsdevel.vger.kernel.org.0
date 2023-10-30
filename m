Return-Path: <linux-fsdevel+bounces-1541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396C97DBBC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 15:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE0F2814F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C868179BC;
	Mon, 30 Oct 2023 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ok5Psb1G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36432171DE
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 14:28:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28799F
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698676125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIZMjEJ0unwch+/xbrgX1dR7Es/DPi6eBHIG0w2M6uI=;
	b=Ok5Psb1G8k7UbJPq+nQNlf2eDoWlvKivqhyTKNB8iFGIbM8HQc3FVdwbSgKDOYPX5ipv3k
	NScdzPuv8af20MMIXguaCBsrNryOHvMeW/RYFDg9Zcs5TzTYQQF/cZApSxmfDPG7HAsTT9
	8kKMgryCyCpnEqc9CmxW653rGVRSVek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-R6A-FZZFOEuUyUffcUXunQ-1; Mon, 30 Oct 2023 10:28:37 -0400
X-MC-Unique: R6A-FZZFOEuUyUffcUXunQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1323830967;
	Mon, 30 Oct 2023 14:28:35 +0000 (UTC)
Received: from redhat.com (unknown [10.22.17.207])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F0E6492BE0;
	Mon, 30 Oct 2023 14:28:35 +0000 (UTC)
Date: Mon, 30 Oct 2023 09:28:34 -0500
From: Bill O'Donnell <bodonnel@redhat.com>
To: Ian Kent <raven@themaw.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL for v6.7] autofs updates
Message-ID: <ZT+9kixqhgsRKlav@redhat.com>
References: <20231027-vfs-autofs-018bbf11ed67@brauner>
 <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Sun, Oct 29, 2023 at 03:54:52PM +0800, Ian Kent wrote:
> On 27/10/23 22:33, Christian Brauner wrote:
> > Hey Linus,
> > 
> > /* Summary */
> > This ports autofs to the new mount api. The patchset has existed for
> > quite a while but never made it upstream. Ian picked it back up.
> > 
> > This also fixes a bug where fs_param_is_fd() was passed a garbage
> > param->dirfd but it expected it to be set to the fd that was used to set
> > param->file otherwise result->uint_32 contains nonsense. So make sure
> > it's set.
> > 
> > One less filesystem using the old mount api. We're getting there, albeit
> > rather slow. The last remaining major filesystem that hasn't converted
> > is btrfs. Patches exist - I even wrote them - but so far they haven't
> > made it upstream.
> 
> Yes, looks like about 39 still to be converted.
> 
> 
> Just for information, excluding btrfs, what would you like to see as the
> 
> priority for conversion (in case me or any of my colleagues get a chance
> 
> to spend a bit more time on it)?

I'm just starting to have a look at zonefs as a candidate.
-Bill


