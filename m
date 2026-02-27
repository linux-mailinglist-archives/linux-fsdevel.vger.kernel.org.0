Return-Path: <linux-fsdevel+bounces-78766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM/IAybwoWnYxQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:27:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5891BCC5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F18B0300E27F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 19:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4CD41B34D;
	Fri, 27 Feb 2026 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in4yj3fF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F33559C0
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220319; cv=none; b=FM3pgkJ7RTa+1WvfS45lmCzQreKGyH0OT04C2YdAV5DahIgZd900dcIlXEAsaQiXk2UXdj2STztcFep9ZRe2jXgot+SvTOMmsNNzoHnZ0SBmic411RSqrAz/+aOJ9I175alY0gXgVtU0hMQ1rKrSTXwe6AZkg/PmqRotaGlqFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220319; c=relaxed/simple;
	bh=WHms4B5b1NrOXlJhK9GRYXMGsi7elSdcIpIXJGcM3YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxA0cnwmF9OKsas2jE8DlaYP5tjBuZt1ddEzex2L8SD3XcWCKpSOrohPM/yYJzUDEygTCA+jVcquMKiaV8VdleDqhCnwgr+BQIIEiB+Yl/o8xJD7NsurwBXbedv3RsVu0dzr+HhYX/ZyLp/CaokvEir7YRbTjhCkunqLFqp4akU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in4yj3fF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DB0C116C6;
	Fri, 27 Feb 2026 19:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772220319;
	bh=WHms4B5b1NrOXlJhK9GRYXMGsi7elSdcIpIXJGcM3YQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=in4yj3fFSb9YHwJPk3UyuQE1RENT3g6/7Kt7CrmfDC50mZ7IIKCkKyDzo+LPKk2SC
	 2gf0D4aSJEqN/6lYjf+titE71lCQbijm7/7YYcWDKyblwVPp8XR3DlsBDKa97FV+QH
	 an2U8o6Sr9gNZ0c2BlYDR32x7gdh6nKSevKKwB4iuIRj2rIH5O6skAgQMLO9u4m+9l
	 Bbg5nBG+Jm69K1h2x2YI/If7REc7MLSJJywi+MdvDjf6MDmFlrAJLT/zlakPfV/nDg
	 GTdTKiNoRbyBzuq1wMG5pr3VW0PhcCnQ7wB33V+Kk/AoCB5/fC5Ny15N0wT04P1ADX
	 4QvimUcNKVrIg==
Date: Fri, 27 Feb 2026 19:25:17 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, Nanzhe Zhao <nzzhao@126.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	yi.zhang@huaweicloud.com, Chao Yu <chao@kernel.org>, wqu@suse.com
Subject: Re: [LSF/MM/BPF TOPIC] Large folio support: iomap framework changes
 versus filesystem-specific implementations
Message-ID: <aaHvnbiX-qs0tEQk@google.com>
References: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
 <aZiCV2lPYhiQzYUJ@infradead.org>
 <aZiqsQsWFSCjcfE_@casper.infradead.org>
 <aZzIUnYprj_wTyqn@google.com>
 <CAGsJ_4yN+RyF5hh-=sBfnRGp-r8KZBYY-ByT_V9KjiiKy1FgSA@mail.gmail.com>
 <aaD7Qf1ljl4yFB8e@google.com>
 <CAGsJ_4zNvSYa+fyBVkt1eOqpMPGi0Wrckb+fxn8Pqt5erZbTfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zNvSYa+fyBVkt1eOqpMPGi0Wrckb+fxn8Pqt5erZbTfw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,126.com,lists.linux-foundation.org,vger.kernel.org,huaweicloud.com,kernel.org,suse.com];
	TAGGED_FROM(0.00)[bounces-78766-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D5891BCC5E
X-Rspamd-Action: no action

On 02/27, Barry Song wrote:
> On Fri, Feb 27, 2026 at 10:02 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > On 02/26, Barry Song wrote:
> > > On Tue, Feb 24, 2026 at 5:36 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > > >
> > > > On 02/20, Matthew Wilcox wrote:
> > > > > On Fri, Feb 20, 2026 at 07:48:39AM -0800, Christoph Hellwig wrote:
> > > > > > Maybe you catch on the wrong foot, but this pisses me off.  I've been
> > > > > > telling you guys to please actually fricking try converting f2fs to
> > > > > > iomap, and it's been constantly ignored.
> > > > >
> > > > > Christoph isn't alone here.  There's a consistent pattern of f2fs going
> > > > > off and doing weird shit without talking to anyone else.  A good start
> > > > > would be f2fs maintainers actually coming to LSFMM, but a lot more design
> > > > > decisions need to be cc'd to linux-fsdevel.
> > > >
> > > > What's the benefit of supporting the large folio on the write path? And,
> > > > which other designs are you talking about?
> > > >
> > > > I'm also getting the consistent pattern: 1) posting patches in f2fs for
> > > > production, 2) requested to post patches modifying the generic layer, 3)
> > > > posting the converted patches after heavy tests, 4) sitting there for
> > > > months without progress.
> > >
> > > It can sometimes be a bit tricky for the common layer and
> > > filesystem-specific layers to coordinate smoothly. At times,
> > > it can be somewhat frustrating.
> > >
> > > Privately, I know how tough it was for Nanzhe to decide whether
> > > to make changes in the iomap layer or in filesystem-specific code.
> > > Nevertheless, he has the dedication and care to implement F2FS
> > > large folio support in the best possible way, as he has discussed
> > > with me many times in private.
> > >
> > > I strongly suggest that LSF/MM/BPF invite Kim (and Chao, if possible)
> > > along with the iomap team to discuss this together—at least
> > > remotely if not everyone can attend in person.
> >
> > We don't have a plan to attend this year summit. But I'm open to have an offline
> 
> It’s truly a shame, but I understand that you have prior commitments.
> 
> > call to discuss about what we can do in f2fs, if you guys are interested in.
> > Let me know.
> 
> Many thanks for your willingness to have an offline call.
> 
> Absolutely, I’m very interested. I spoke with Nanzhe today, and he’ll
> prepare documents and code to review with you, gather your feedback,
> and incorporate all your guidance.

Thanks. Let's talk in a separate thread.

> 
> Nanzhe can then bring all the points to LSF afterward
> if the topic is scheduled.
> 
> > > >
> > > > E.g.,
> > > > https://lore.kernel.org/lkml/20251202013212.964298-1-jaegeuk@kernel.org/
> > >
> 
> Thanks
> Barry

