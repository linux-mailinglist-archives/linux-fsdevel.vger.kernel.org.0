Return-Path: <linux-fsdevel+bounces-78388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FRCIH0sn2lXZQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 18:08:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E893719B425
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 18:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC7D130AEBFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A1C3DA7EB;
	Wed, 25 Feb 2026 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="laWGrQqY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8433B8BB5;
	Wed, 25 Feb 2026 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039187; cv=none; b=Dgi77O+TIjGLlUfU0oZm6j6UzN9mk79d8ArpYQMd1jtucz6KIF7bk+O2STMlWpL57ua1dkjzTWYg96wXQ/npPNvN73dATP0JXWNT0U0kcFtn0yneCj1in2zpZWqDEOwvVqdcEX31zrlRtvo/PoLK1XK+g76Dd7xu8RedtTLjjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039187; c=relaxed/simple;
	bh=A3PLd94xudRepnpKhMw8haIj3+kJ/EszHl7f+1fNdTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ezPQuERkAdbaztmXRgkJbuwmCCYHZhquICtkdqAKaM8CuE85cd4qPbpEz/Br51lwYy2cuIaK9HB37OM25gY9ECA2y6B03J5vxM4tpTjbHj7QoPWVn1oC+E8/68ITRReim82964JOJn7Xo7Uhr2hJXTbzpGZmGbefH4Ud9YYtQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=laWGrQqY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hqkuoz/MkJY4m/fFqEasEA7KJnKOaK0BWrQPd1cBPBE=; b=laWGrQqYb7pOtwS0brkWHtGRML
	DdZEEL9MmzJW8GPGu6yNLnNeY23yrWJ3XTIkk7PTXmoi6ncr8GKaqMvBkPfWD7qANIIef52uEEVUp
	L/ewDwrzZbXjpo/ctE3VMHCkZh5c1Pi7t379SYZM5sMbGm6/fEHKvPiiVaoRmr/86I4qovoBpCAfL
	W5JCpvJzWbPvXPLh0jy8ELk2MP6EDbJ7oMHGA5YfGpkGkz5smOOqnBWc/LUl8t34L6Q8n+3HKyGMl
	pujjogYJvUmuNpRsqRHbHS0nHC7ceuoF9/Py1dB1LRSywf3a4W3eHXCDF4lKVSGfoN0wPOO+Fi77a
	UKH3P/+g==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvIKv-005K4n-Gn; Wed, 25 Feb 2026 18:06:09 +0100
From: Luis Henriques <luis@igalia.com>
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Bernd Schubert <bschubert@ddn.com>,  Bernd Schubert
 <bernd@bsbernd.com>,  "Darrick J. Wong" <djwong@kernel.org>,  Horst
 Birthelmer <hbirthelmer@ddn.com>,  Joanne Koong <joannelkoong@gmail.com>,
  Kevin Chen <kchen@ddn.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matt Harvey <mharvey@jumptrading.com>,
  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v3 0/8] fuse: LOOKUP_HANDLE operation
In-Reply-To: <aZ8RJFhnYA0519sv@fedora.fritz.box> (Horst Birthelmer's message
	of "Wed, 25 Feb 2026 16:14:56 +0100")
References: <20260225112439.27276-1-luis@igalia.com>
	<aZ8RJFhnYA0519sv@fedora.fritz.box>
Date: Wed, 25 Feb 2026 17:06:08 +0000
Message-ID: <87h5r469dr.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78388-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,ddn.com,bsbernd.com,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E893719B425
X-Rspamd-Action: no action

Hey Horst,

On Wed, Feb 25 2026, Horst Birthelmer wrote:

> On Wed, Feb 25, 2026 at 11:24:31AM +0000, Luis Henriques wrote:
>> Hi,
>>=20
>> I'm sending a new version of my work on lookup_handle, even though it's
>> still incomplete.  As suggested elsewhere, it is now based on compound
>> commands and thus it sits on top of Horst's patchset [0].  Also, because
>> this version is a complete re-write of the approach presented in my prev=
ious
>> RFC [1] I'm not going to detail what changed.
>>=20
>> Here's a few notes:
>>=20
>> - The code isn't yet fully testable as there are several pieces missing.
>>   For example, the FUSE_TMPFILE and FUSE_READDIRPLUS operations are not =
yet
>>   implemented.  The NFS-related changes have also been dropped in this
>>   revision.
>>=20
>> - There are several details still to be sorted out in the compound
>>   operations.  For example, the nodeid for the statx operation in the
>>   lookup+statx is set to FUSE_ROOT_ID.
>>=20
>> - The second operation (mkobj_handle+statx+open) is still draft (or maybe
>>   just wrong!).  It's not handling flags correctly, and the error handli=
ng
>>   has to be better thought out.
>>=20
>> - Some of the patches in this set could probably be picked independently
>>   (e.g. patch 4 or even patch 1)
>>=20
>> So, why am I sending this broken and incomplete patchset?  Well, simply
>> because I'd feel more confidence getting this approach validated.  I don=
't
>> expect any through review, but I would appreciate feedback on anything t=
hat
>> would help me correct major flaws.
>
> I, personally, appreciate the fact that you sent this out, so I can under=
stand how
> you are using the compounds for this real world problem, and it gives me =
confidence
> that I'm not completely off with the compounds.=20
>
> Do you by any chance have implemented the fuse server part, too, or looke=
d at it?
> I'm just curious.

I do have _something_ for testing, yes.  Obviously, I will eventually
share it but I wasn't planning to share it at this stage yet (it's ugly
and full of debug code).  But if you'd like to have a look I can do a quick
clean-up and push it somewhere.

Cheers,
--=20
Lu=C3=ADs

