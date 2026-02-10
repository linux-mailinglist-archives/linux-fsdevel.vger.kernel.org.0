Return-Path: <linux-fsdevel+bounces-76854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLw3K9Vbi2mTUAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:24:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C40411D195
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA5C53019501
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 16:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCA1389E1A;
	Tue, 10 Feb 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXoHp7nY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E8531B114
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740675; cv=pass; b=AmE3/9wDbD7xZjw1u9OQ2TIR5L4mr2JML0vH6JZnS5bNtn0y18WxRW8U7VvY7buB3RzcRxH9n6IUY6mYo+40KnGY7/1GQBZCBOxDWZ+i6SHeewdkBJG2Rnq/70CdqJKnsMQBmlgFzwbD7OD5UKEWwk9hmoG2SDvQ0g4aiLfVEg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740675; c=relaxed/simple;
	bh=BkWtyYpqejlmByRC727LdbfV/RYqAERDreFY/UP2Aa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FiOSAxCpqrkF0So9EGLnrz848rxo0cfWT0UKvSmCZnC+x01h9HLH6iWjOZ8UsbRueGp6NGDrxTflHyMD/ozqlukrd4MUiS1lufd4L+SvDHBMfXXWzghhkKiyHm3ULaFLikkcAzhxKsx7/WnRajirePpQQdLsRu/rZscQ+5LJxWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXoHp7nY; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-463208653d6so1639734b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 08:24:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770740674; cv=none;
        d=google.com; s=arc-20240605;
        b=afYWxOzeXwoUohWg+XDIIEkhR/v7TcoNW6qvDiFytzRGAYQY93G/65GOlnTTmO7tmY
         QA5bZZZnudz55OIdlxZt0HTA43C6S6AERzLE+OBNqrxT0Tb0uGWB6yNblkuHVFgbqvjQ
         eqhqC+T9/uzqCthhfQL9sIRx/3QllSGnt6Ux8VWbYaY3atB/pRx5sfoKleg4jnhrPii1
         WNktIMA1otqfwLjr5PxRGrO8HBKDwbp0uG2Z1J/MMoIq0GpqPpLAGbYjAW+rumXc4u1s
         TlxVHKLn0AHWirqf1EVEpaxx19ZMavGD6IJS6gaoxSXa2qV+NX7TjvKmY4p/GOQyBXu/
         MkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e87k8iFish9q2Uq3v9Uy7Fjw166hMufB5O7qErb387U=;
        fh=vzzogfYqNYnYtyJlHcE0PKZawQI9Mesv3FZYAA0CDn8=;
        b=BiaTMvz7+vPwK7ecU0myHPvhhlHCUuywpRnkMf1Y8/lRbqisXdpI0DbHK1ppFEC6IL
         nShA0/rK+7OPlFX2YkEUQ4qCyrzBaiIQX/c9FMfwLRESrCWbUns/ah3WbGXtbUMGOMbW
         f9+WlJi+75LL8eof2kr288OcSNkcrvcbLHwt3TwdvBtcQiMSRNOWaluD/CmFhAxSqVCN
         rJdG2wNUYgjPjJ4+1h2OpoFj93fq7KoNYEgE/0+9udntXsQmIB84Xbyzx0/ML4N/esHp
         G2qxx1Cty/OKlNszLNU2Cajrvl9obhIws+zKn9vPs/qYe8OLYZxPVa6ahUy6r0vm/LSs
         iGKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770740674; x=1771345474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e87k8iFish9q2Uq3v9Uy7Fjw166hMufB5O7qErb387U=;
        b=jXoHp7nY23Kq85huTPiHL1JsEK6nChfn2n6ItO9mJhQQLQMLKOQUwAVBSk5naFxJhY
         R/CAa71VMkrHO+oF8K/OeGmgfjlswwdenQw7JEPsknyqg9LfdHHw0qjAjeMFHb7LmAQ0
         sJGdIejhGm1kpLSexdcYBGDFglcXyj/uHKnuemJHLlww8nLSGLHYaDtZaLpyytNS4u7q
         5lZFsffLsIby593IrGgzTQKuGXwsc2GUrRsA2zUNcdHq2LR4zmXIHCTuBkFVCbD5V0Zm
         maODHoWpBu+PpgywObJIsMVDxwDufhdioUxtB/jrMD9+mMy1p548uzR+djRpr1ECBXDU
         x+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770740674; x=1771345474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e87k8iFish9q2Uq3v9Uy7Fjw166hMufB5O7qErb387U=;
        b=nD3a70U2zsAMCA5uaZ17RlbNE1aUp7ppYUHY1FY2IYWBtfGp+yYVPD0XRZ9uD4qOrD
         ndwVZSHEPUnZjVuq0wSHnIC2f9++2Icnlih21ZlaVjEnwhDIR6mpMNFR+XjYelnCdqxP
         mp/s6jHnfDi7Uvs9lTpBoleP6B6pn0aWE8i1ZDD/31phG2VIDwJmR8SGxUo4R46ob4Cf
         Cf/Whc7bx4p09j5I/0abWKikGgZWBIZKPtSlIUDNyXmfHMvDSEvdsTN1T49wX73Tee2/
         hzp9qe8rdnn+QKKl47tYCHKo3QswnXjmUDeGulMjv8oqCxTOPAUaN2eZllBLyLP0yxYt
         uFrg==
X-Gm-Message-State: AOJu0Yworh82+DE/cKM0W6c1h5Gn7cQla/4KAPfofx+1i3KW8v0Ce5MJ
	QUgUfn5bC5LzBL0B2hDxXXGDLLAVvoLERIPTnkSGWz1PJa+IPl+747Npzw+PHvxqI/0ehd4tnpt
	bfEAM0pjWB+CitPyTLHaOE72vaGGUt2M=
X-Gm-Gg: AZuq6aJhRd8kpBHrXk4dRz9WtQ09Ug/68/5eAhSss+YGNYCTAc1cI4oP4YARq26bb43
	dkxfI8HAmfPlMKKwGKXtEdYusijMoIHGByoY6KurUsUvVmVUpV9q8HL/g/Q45T0nJH74ZUpEnhK
	DDYeB0ArgTR9x5Z/d4c76ft/zfK6E+aTP/FkrFktTYk2hG7phwYIZBzngqCY7giKrvPwt9H2f4W
	qYXCBQ1buEH8ioTAqn9+noJhem7kgNfyeLzYPxXMe4R9XhY0YnzbagfZqCI5Wt5+Kpo52lTn4mN
	3lPwK9Y=
X-Received: by 2002:a05:6808:4f23:b0:45f:42d6:2ffb with SMTP id
 5614622812f47-462fd051fdamr6992569b6e.41.1770740673692; Tue, 10 Feb 2026
 08:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120142439.1821554-1-cel@kernel.org> <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
 <41b1274b-0720-451d-80db-210697cdb6ac@app.fastmail.com> <20260124-gezollt-vorbild-4f65079ab1f1@brauner>
 <a1692040-58d0-412d-b0fc-c7b7a62585c4@app.fastmail.com>
In-Reply-To: <a1692040-58d0-412d-b0fc-c7b7a62585c4@app.fastmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 10 Feb 2026 17:23:57 +0100
X-Gm-Features: AZwV_Qjy3M0uZY-NRx3otdHnq6x-9RSVjw1ETeNOu6B1p4FZNE0JCUf2MFslsk8
Message-ID: <CALXu0UcJf+R3HuzwUrUTjsuYWdFrLZOwAsEtSyto2T9Rtg4rsw@mail.gmail.com>
Subject: Re: [PATCH v6 00/16] Exposing case folding behavior
To: linux-nfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76854-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C40411D195
X-Rspamd-Action: no action

On Sun, 25 Jan 2026 at 23:05, Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Sat, Jan 24, 2026, at 7:52 AM, Christian Brauner wrote:
> > On Fri, Jan 23, 2026 at 10:39:55AM -0500, Chuck Lever wrote:
> >>
> >>
> >> On Fri, Jan 23, 2026, at 7:12 AM, Christian Brauner wrote:
> >> >> Series based on v6.19-rc5.
> >> >
> >> > We're starting to cut it close even with the announced -rc8.
> >> > So my current preference would be to wait for the 7.1 merge window.
> >>
> >> Hi Christian -
> >>
> >> Do you have a preference about continuing to post this series
> >> during the merge window? I ask because netdev generally likes
> >> a quiet period during the merge window.
> >
> > It's usually most helpful if people resend after -rc1 is out because
> > then I can just pull it without having to worry about merge conflicts.
> > But fwiw, I have you series in vfs-7.1.casefolding already. Let me push
> > it out so you can see it.
>
> There will be at least one more revision of this series (and it can
> happen in a few weeks) to split 1/16 as Darrick requested, and
> address the nit that Jan noted.

Are you targeting LInux 7.0 or Linux 7.1?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

