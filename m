Return-Path: <linux-fsdevel+bounces-70547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B04AC9EA44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 11:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF993A1459
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 10:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401C02E7641;
	Wed,  3 Dec 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EO7KiwLQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EDD23EA97;
	Wed,  3 Dec 2025 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756462; cv=none; b=GurjjBo0wu/7laWgMvrj9RGC/H4lGQFsc4Uv4qoQYp/ZAhAK4vPaWeDPaEWBonkP+IzGNaVvFc9KI9lA5cxDAm8vo/UQquT65MiihdszkKyVxi83GDq5Z12JeaHih5lVNj4KwcCr8Ui4GYspULNPRggxuyq/47QcHIl9U1IsXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756462; c=relaxed/simple;
	bh=W6GJrzF8QFFTEt+wP1e4fBwAnQy6jbMZvsPFvrg914c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re16jfcir96AwRkwU1MXb20uKDrQb5KZZ0F4VcwCt7PWIAFISg+78yBOqMELVRy5u5/766RaXFN7Bb3yAyuO7yqCRX0JJ3HmRVoMgNAg2FQU7SKO587PFS72whQNGtcX626NaQ+BCTvDWnscocE3LhzcsrfBYvakvVInhprj1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EO7KiwLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C74C4CEFB;
	Wed,  3 Dec 2025 10:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764756462;
	bh=W6GJrzF8QFFTEt+wP1e4fBwAnQy6jbMZvsPFvrg914c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EO7KiwLQLVt1z7souf+Qlcl1tZvCBs7s4kSXG/cx1BDIiprULVn92MeWaBgDbsC5C
	 fn5oPv+SRGmkuaHs4/ce3scb6VHns+a4qlJWT+G2CRxLeTPHDDGai+HXqZ21sXsXUz
	 uxibz+HuV8EPh87NNMsTkaszRTUpVMLDO+/pGV7PJnANxXe0/5fUvS1Re67Pv2yLSa
	 7gZOun8+HNkxa32VZp2ZxXL+T5OVdP7Vwfs9HZQRJKiDey60zgoJ61dE0W3caT0zwF
	 gZGAae/inw5q8mpm0EGYPFM7ZCKogxaDPimeBoDgodJghrIctCuEhFFRxwZvIIIW1e
	 9L2/Sn/qArnmw==
Date: Wed, 3 Dec 2025 11:07:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux Containers <containers@lists.linux.dev>
Subject: Re: [GIT PULL 05/17 for v6.19] namespaces
Message-ID: <20251203-aussaat-anreden-1df55ee85463@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
 <20251128-kernel-namespaces-v619-28629f3fc911@brauner>
 <87ecperpid.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whPpVs67fAYWo4=SeD20cxjYoAE3d5RXgeHpXZ81uM7Lg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whPpVs67fAYWo4=SeD20cxjYoAE3d5RXgeHpXZ81uM7Lg@mail.gmail.com>

On Tue, Dec 02, 2025 at 09:00:57AM -0800, Linus Torvalds wrote:
> On Mon, 1 Dec 2025 at 11:06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > The reason such as system call has not been introduced in the past
> > is because it introduces the namespace of namespace problem.
> >
> > How have you solved the namespace of namespaces problem?
> 
> So I think Christian would be better at answering this, but to a first
> approximation I think the explanation from commit 76b6f5dfb3fd
> ("nstree: add listns()") gives some high-level rules:

After last year's round I've caught another lung infection so I'm a bit
incapacitated and not working. Visibility is currently based on the user
namespace. It's possible to list all namespaces that are owned by a
given user namespaces. So a caller in an unprivileged container is only
able to list namespaces that they directly own or namespaces owned by
descendant namespaces. That's tracked in the namespace tree. The
self-tests verify this as well. So it is not possible to break out of
that hierarchy. As this is expressily an introspection system call it
allows to list sibling namespaces owned by the same user namespace ofc
as its tailored for container managers. This will be used in
high-privileged container managers and in systemd for service
supervision so if there's any concerns that the current standard access
regulation and seccomp() isn't enough I'm more than happy to require
global CAP_SYS_ADMIN.

