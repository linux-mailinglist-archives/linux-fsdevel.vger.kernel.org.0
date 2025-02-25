Return-Path: <linux-fsdevel+bounces-42612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 855D8A4504A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 23:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02E87A2095
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 22:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BC9217677;
	Tue, 25 Feb 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="dlV0iDsD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836912163AB;
	Tue, 25 Feb 2025 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522966; cv=none; b=D3UwF1mwkLhJqQHCQ/Fs9tgiO72ONTi+IUYqzLPai6N1jNldMDtC7SoJHZv1GVWu3s6xSUn7/82sf7NBmaU7cZXNSiDZdW7chIgtlTdKwk9PNx04FXATUJmuqTbw3zF8Ie5QUaV5wyhTjcxBTlbacUfOSeobiG14g4H8h8wL1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522966; c=relaxed/simple;
	bh=LId8wARo8fFkuaheKwyZhfKVheDRdazKR+fWXvZKTSs=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=oD7svAJFlVg4gpqNIBBIT/SwpRiMIYyHjYbYzDS+FQ7JxerfWKof5GEGayewqMYtwDyu1j+NgnvN3WIDYrAhAWkFY6KASMTPwFqxL79O6jFcoaiHT6mSoJsli+dEfqVWNXVUPNIeqOIeqplH2Jcaymw+ZLPCqbQqSgTzHaUpyZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=dlV0iDsD; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <3c4f7265522cb15334aa90cbccdd4733@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1740522954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zvzu9AxG+G7+SM5+BrgtHqFH4W8oArTOexyK6oANXA=;
	b=dlV0iDsDsOcl/HOA4JBhfDjARmCfDUfgWA7urfsKG2sdauhTUhYapj8M1M9JJlQiFFwx18
	BXt2eZuzHCiO6E4m2JrfAwspRaLtH85uzE8OzJl8/M8RM9r6r2zVwchwwk3O2U9ZiBs0rX
	73IRwcmvY+Y+dvDfRoGYIDhj2jUdneYGy7phUJOwZOd39ZVgYDO4rQWUyP6oqOhuKxd09+
	sRhIq0kx7rK7N+bHlPPPg3atMgMvuSqVhYAlZZ5sjnWOSBWu8+70xDzLUrpWL5SDRwwiCT
	wU+eLyElL0GmnM1/5kRBWYzMY9+keTpcmKfMUmEY1zk9QgNyQw6G8FOla8AUdA==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>, Steve French
 <stfrench@microsoft.com>, Jean-Christophe Guillain
 <jean-christophe@guillain.net>
Cc: dhowells@redhat.com, Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>, Jeff
 Layton
 <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix the smb1 readv callback to correctly call netfs
In-Reply-To: <2433838.1740522300@warthog.procyon.org.uk>
References: <2433838.1740522300@warthog.procyon.org.uk>
Date: Tue, 25 Feb 2025 19:35:50 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Howells <dhowells@redhat.com> writes:

>=20=20=20=20=20
> Fix cifs_readv_callback() to call netfs_read_subreq_terminated() rather
> than queuing the subrequest work item (which is unset).  Also call the
> I/O progress tracepoint.
>
> Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use=
 one work item")
> Reported-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219793
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: Pali Roh=C3=A1r <pali@kernel.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/cifssmb.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>

