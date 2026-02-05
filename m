Return-Path: <linux-fsdevel+bounces-76485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH1hLhH+hGl47QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 21:31:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6002BF72AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 21:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6B37301E227
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 20:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15C326B756;
	Thu,  5 Feb 2026 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7+vB0mE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D028002B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323463; cv=pass; b=QZFsDrsuwnRnHczkRU68zCqqP0DKELHtczOx19nTnaPIkkQzf2QWYWC+wQSjO0ZxOiFrLnv3mCdoN1N78hc+4vtIdn5fr0yPYuxkGuVnIfZZ/CUZrUOcvC96s4gd41op6Uyr4coCkO3Ub+ySWcADcbo+AR3ekF2b4/1C5S+0MaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323463; c=relaxed/simple;
	bh=gpu5Ho3szeRH1AdrKbXvhnoFA1prjEfwo7xkCapBcjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEA58E64XEYnRDSdyFAODvJhQtlCKL8Oad+YyYA8fc+eNU0dwLZZIceg539Hf/sowzHt6xUSUcNMcmCI7W40xjyJHIQNF255QqjI9ZxzIDX/W3gu4T2u8j5D9XwArKqJCJphUGX6aTyKhNQSPcujS7HpxWoUr+Afa1ltf1XLlNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7+vB0mE; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50146483bf9so15990361cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 12:31:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770323462; cv=none;
        d=google.com; s=arc-20240605;
        b=Aj+tag5wnCGrlt+RuL+gFaIauGJUURwxzRqDRjtOZfuypKStrMNaalzgdXpwhf2w0N
         88Vq36AZap/teDLRpcKuu9Uio2moXgucdkAGg3Oil1YpiTrlmiFJlFe1MZjH5o5rZnMz
         GErlf1zbAc8EdIQm1egHAAEYngs1YCC5Xgv8U1GRBnnnVHC9wrLOKwosTfYdsyIsq+lY
         2dgPy6c/GI/6Mma11PYMO4GnOdqMUAu0bh7OK9hXsqIM2F1gcrZDX1UcGlJhheNtt5Yc
         kLVps+DZFIPNvNCFuU7rYPaZjAl1ql7m2nqTtAJjRlOiYiTdVG2V+9wSuqn6ZtrYbpA7
         u4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dujC8EZ0g/eXilP7iS2dUm5q35I+VRrC70mkElRqhg4=;
        fh=w0DDtOeqsD8XqCfWpuyP3h57W81ilvAvMx0+gfLv9R0=;
        b=Eu5Mpf1Ysxb2sL1KXIRnBIxLJttZ/8E8vjymuAJrU00Ok1X5oR9KI+FYXvZfkHE3Hg
         rMnuQu/IOrahEQJDxtVNcBuw03oGHLsrcT2HJFbsS0IMH+4Cat742mOpgsCcFiyndiK4
         ugIe872m3uPxO+SrMAtddR4R+90IOADxEYLfLFV7XwlF6EOd+agrv7mnXPo46Q0H1snC
         DkfhcwKDxHrwtUEe8omvehpN357rVQlX3vd+uvmoUAbcqmUd5ro2hhetAHyiim4GTzdm
         D80JeDXpJSseUMONa42Ejw25wcBtsDdkYhPn6+dD4XymY7x4hXL6etVH5MAwWmHoLxqN
         btpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323462; x=1770928262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dujC8EZ0g/eXilP7iS2dUm5q35I+VRrC70mkElRqhg4=;
        b=f7+vB0mEYnUyMsMY+3dDA+xiUsfrPzSlESd/PfQvnNbRHalLfSRXUEQ6LLejmorCct
         rY6jWtkCahRnvOBqYYgy1wv+w3AnLy3BkB+ojsnq+hkyv1aYJJyoWEuWaMxFE6J1NsM6
         rbc/fYc7rE9p2ZUQzTPndGjLd0vmyE/Q90PQQcsLDqj3tHSIEVM+3Q+ir5a2/IjTfMSO
         e1qyL0t+Uw4iVwmVTPP5x+Yenf02rRHB5bB2guGoVvFcbGmUzF7xGv5O3S3GgaeYnfYl
         3ixQulMdYSmtsiDtPah+KcHUygPrKcdSzsIe9aLbTKrxr3GiikTOOxaBOWmXie7DfnJW
         O9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323462; x=1770928262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dujC8EZ0g/eXilP7iS2dUm5q35I+VRrC70mkElRqhg4=;
        b=QJ87RnpNPZdw/tLWqZEp6IkO3KqtAobTmJG0kRnqnAPAUDM/2rzZohfsIjpk5BxmVl
         t+wPHPEadWB5VkaajnJNX91jEog2hh1w/tyYam+xr+R6Bs+RCE/EZmjxBnEkfOLSoF8R
         Nk3WEs5sZqN6GB7BF1UDDoeTW9GRosVdicrc9M+LLaaIT4K32Ii882Oib7D/s8mKFdNU
         mGQn10BQraKh7pGm6mg1ecGtnaj8V6UWtDxiwkwSbxVNDU2m7Eho8oaOwb2jVNq9zr7S
         w/S4B2q5dbSLjO62uyyK8ZE5mH0/8VVc5DD31pMcc1kOcNNWS26wzgVbYHKX/HduZ7ii
         5thQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoiLleydlwJlDxoCRZwQ/l28hfmb40LWwgU6YDHE9DjvLwJy+7nMG2E9qX/u3Mjq1JGmr5aDDB44aGse+x@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/LJdXEV+aPpd1rMesqJSmmJB7u45TqWkD84jj0lLjFh99ft4
	TKK/PZsUS1HBVI+4FAdS0tGYHnStpuV7r5KXmvi76gTPzSlIc+G80WQTvgWxo591o9GYtdgjJ7C
	aw/SPeHR/NIitj14Q7bkPChqFu/rhsCU=
X-Gm-Gg: AZuq6aI4Mn9d/tlSA+8NN/WMblPMcKjmb+pjvZmwKdU7oWpeLilSZ9cXHuHvfdOamqR
	VzByg3F6uS489zH7ZlcIL+NnJfIdgMQqBMy+h+7BsZ8E40u2Xhn/5fIaTbpLFMGalzIjFhba8Sv
	qmHLi6zWCt/GGpVXsOp+PbPSYQjHRFfoI5czv93ezdnZL2weRXAgb26Vntb7XZSqqrtYRaETVmh
	pLEiZ/Zrw5rlMElS9WZfwDDvQVrnwweHS1KIL10DwdLhsEcL/BFMry/ogLsdyo7nx9CFA==
X-Received: by 2002:ac8:5fd2:0:b0:4f3:530f:d752 with SMTP id
 d75a77b69052e-506399e3540mr5186681cf.81.1770323461651; Thu, 05 Feb 2026
 12:31:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
 <20260116233044.1532965-26-joannelkoong@gmail.com> <4b609081-89e9-41b7-bea2-b3fa4e8b9e3e@bsbernd.com>
In-Reply-To: <4b609081-89e9-41b7-bea2-b3fa4e8b9e3e@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 5 Feb 2026 12:30:50 -0800
X-Gm-Features: AZwV_Qg8zfQkLEaRSDbkx58VruVjYpcaGPLQvXOo3VEGvGW0ck6ffCgQN_OrEKc
Message-ID: <CAJnrk1YLb-t3aqSG2LLu1c3AKiXr=guOVr_sLqSBSfk3-2s+rA@mail.gmail.com>
Subject: Re: [PATCH v4 25/25] docs: fuse: add io-uring bufring and zero-copy documentation
To: Bernd Schubert <bernd@bsbernd.com>
Cc: axboe@kernel.dk, miklos@szeredi.hu, bschubert@ddn.com, 
	csander@purestorage.com, krisman@suse.de, io-uring@vger.kernel.org, 
	asml.silence@gmail.com, xiaobing.li@samsung.com, safinaskar@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76485-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,szeredi.hu,ddn.com,purestorage.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,bsbernd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6002BF72AD
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 10:56=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 1/17/26 00:30, Joanne Koong wrote:
> > Add documentation for fuse over io-uring usage of kernel-managed
> > bufrings and zero-copy.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  .../filesystems/fuse/fuse-io-uring.rst        | 59 ++++++++++++++++++-
> >  1 file changed, 58 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/filesystems/fuse/fuse-io-uring.rst b/Documen=
tation/filesystems/fuse/fuse-io-uring.rst
> > index d73dd0dbd238..11c244b63d25 100644
> > --- a/Documentation/filesystems/fuse/fuse-io-uring.rst
> > +++ b/Documentation/filesystems/fuse/fuse-io-uring.rst
> > @@ -95,5 +95,62 @@ Sending requests with CQEs
> >   |    <fuse_unlink()                         |
> >   |  <sys_unlink()                            |
> >
> > +Kernel-managed buffer rings
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >
> > -
> > +Kernel-managed buffer rings have two main advantages:
> > +
> > +* eliminates the overhead of pinning/unpinning user pages and translat=
ing
> > +  virtual addresses for every server-kernel interaction
> > +* reduces buffer memory allocation requirements
> > +
> > +In order to use buffer rings, the server must preregister the followin=
g:
> > +
> > +* a fixed buffer at index 0. This is where the headers will reside
> > +* a kernel-managed buffer ring. This is where the payload will reside
>
> Would you mind to add the actual liburing call for this? I think it
> would be helpful for anyone who wants to implement it.

Good idea, I think what might be even more helpful is to refer them to
the libfuse lib/lowlevel_fuse.c file for reference on how to set this
up. Then they could just copy/paste the code directly from libfuse if
they're trying to do something similar. I'll add this in for the next
version.

Thanks,
Joanne

>
> > +
> > +At a high-level, this is how fuse uses buffer rings:

