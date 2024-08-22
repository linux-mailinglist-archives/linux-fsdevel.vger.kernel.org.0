Return-Path: <linux-fsdevel+bounces-26725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E39295B6B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE9F1C23327
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0A183CB0;
	Thu, 22 Aug 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitron.ch header.i=@bitron.ch header.b="JtHCWIrP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nov-007-i673.relay.mailchannels.net (nov-007-i673.relay.mailchannels.net [46.232.183.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D526AAD
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.183.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333469; cv=none; b=mEMNKxssniedVXoOGiqieW3JE8J1E3BxLB35jkMSy/7xHXBdrILAuhiXYkrJKpLL40qx1qai/gryUk8PZYv7Giu0aTbXaayHS9nPdI+3OB2KpIaXKYyYr/w4UoQbPs1jFjfXSD6ysy5go2UBPlPC+WxXnhMeRSfiZVplsoFp3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333469; c=relaxed/simple;
	bh=9TRe6WVCR6xIbOW019EwIUNlEDEwTVQNcYHJnTqmPnw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MXSv+KuOrmMDnA0wlenAgfRDbcmdya50TXgs1pZ6rCS0fJrS+ekiavhKB0+LumyKtlCX7K1GhTApRiD5u1bEyCOLwaWz9YOo3aofxkC1IqCBPmLEwRIgBSHQtStxIJBcZZhSgT6eRkhUqj0f3S1pcG/Q7Hlt2prUq9hCIVxdxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch; spf=pass smtp.mailfrom=bitron.ch; dkim=pass (2048-bit key) header.d=bitron.ch header.i=@bitron.ch header.b=JtHCWIrP; arc=none smtp.client-ip=46.232.183.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitron.ch
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D55707E005A;
	Thu, 22 Aug 2024 13:12:27 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Thread-Print: 417fee7c78503739_1724332346888_3025538205
X-MC-Loop-Signature: 1724332346888:2589923851
X-MC-Ingress-Time: 1724332346888
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitron.ch;
	s=default; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9TRe6WVCR6xIbOW019EwIUNlEDEwTVQNcYHJnTqmPnw=; b=JtHCWIrPjZ/WBfC/2VP1/99KkY
	BIKE5/geO11QMuFV+tSTbMNwnOPCqhEkG/gRRcqsl3VDzVBctJ1kArXxhb4Q4uk/WOh5kFgAK3H6o
	zjKiGwJNgURPKc02jwrIiEzd0MPH2yVzVGJQaO8+XjCb3yhB+TuVXGcqgWsN+hORT7Ldtr6dPiVL8
	pGRyEUnJsRj8QmceA2TCTNZFgyMTp1bkRuwkLSzgeZc0KdO0b1x79K4MMVraeaD1tTt+rWgFM+OI/
	1InUR0RL+5VnJS4VmhX1JT8wS/isEzeI2c+pNi5bGbxJ1pa2Xjb1dY4IEspOmDuAXF2/jUDp7SdYM
	YV2xDK5Q==;
Message-ID: <ea297a16508dbf8ecfa4417cc88eef95b5d697e8.camel@bitron.ch>
Subject: Re: [REGRESSION] fuse: copy_file_range() fails with EIO
From: =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To: Miklos Szeredi <miklos@szeredi.hu>, Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev
Date: Thu, 22 Aug 2024 15:12:17 +0200
In-Reply-To: <CAJfpegvVc_bZbL1bjcEbEh4+WU=XVS94NMyBPKbcHzAzyxM6_Q@mail.gmail.com>
References: <792a3f54b1d528c2b056ae3c4ebaefe46bca8ef9.camel@bitron.ch>
	 <ZrY97Pq9xM-fFhU2@casper.infradead.org>
	 <5b54cb7e5bfdd5439c3a431d4f86ad20c9b22e76.camel@bitron.ch>
	 <ZreDcghI8t_1iXzQ@casper.infradead.org>
	 <CAJfpegvVc_bZbL1bjcEbEh4+WU=XVS94NMyBPKbcHzAzyxM6_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: juerg@bitron.ch

On Thu, 2024-08-22 at 15:04 +0200, Miklos Szeredi wrote:
> On Sat, 10 Aug 2024 at 17:12, Matthew Wilcox <willy@infradead.org> wrote:
> > That's what I suspected was going wrong -- we're trying to end a read o=
n
> > a folio that is already uptodate.=C2=A0 Miklos, what the hell is FUSE d=
oing
> > here?
>=20
> Ah, this is the fancy page cache replacement done in
> fuse_try_move_page().
>=20
> I understand how this triggers VM_BUG_ON_FOLIO() in folio_end_read().
>=20
> What I don't understand is how this results in the -EIO that J=C3=BCrg
> reported.

I'm not really familiar with this code but it seems `folio_end_read()`
uses xor to update the `PG_uptodate` flag. So if it was already set, it
will incorrectly clear the `PG_uptodate` set, which I guess triggers
the issue.

J=C3=BCrg

