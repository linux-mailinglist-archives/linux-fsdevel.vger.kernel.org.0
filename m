Return-Path: <linux-fsdevel+bounces-79251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ1zJcL5pmk7bgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:09:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA3F1F2188
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1426C306283D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343D747DF8A;
	Tue,  3 Mar 2026 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGQrrBBe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76509480971
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550327; cv=pass; b=sgJkXWMWBhLvZDzO5zmFeeUcjtULIrpc7/oMqStpU8WWuefVdFxepxEhe2/3ENmYrTEfa3bEqBXE7dwmQruFE/vdZRkiJLl3wBsrQr3t+eiKtnUs4/SHFR0zfPsIHqwJwm1+JPxKbN596t9dKUWPHnjb6HiGQwo2ycGbjVQTWXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550327; c=relaxed/simple;
	bh=XkNCKSgj+RwcHym9E75Kpiq8e6HraWdP0YhcGOTQrPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0kOp13bBSq9ftE5ZYwHPQ1JXxG6CxNEK8m4BFkh5G0gZmbuacdqaO2u6WrBG81IEXV7EoTSHczud00BDaAAwVfJburIgtYNqL4UtFRczS3//2v0qK0IrPS66/JOG7yO2CbLOso8/tHSEMNlpYf68hqzIqEfvsPBs0eFvKaAsIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGQrrBBe; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b939cfc1e83so371970766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 07:05:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772550322; cv=none;
        d=google.com; s=arc-20240605;
        b=dqcNxUm3Wx6P1tlcNT05nVeEBhW96WVtX2XVlcUVpFqZctg/J3H9ZgOCojLq2azh1A
         wPKvd70oM5pksj1pdVkPU0Hd10s0f5j5mUaOBCl8apUHudteMxY3R75EUu5LeSmM12TR
         AbfAtIhZUI3zojigeEaVU5IPfIAQYzpdzmUi43xhUDSJLfPNLpv3IDU3o3TuS2pQPaBL
         Bmaj1I21HwZOdaPM6MxLy/qx8Ekb/h0hsVFxW2mb+FdHuGF18BJT+U4F3CFNwD844Q9g
         zJ+27D7LXT6RoGWrVZ5IWPzrSHhT5lB4ZcBuVPBXFg5HpZ78pWkj0gnw0K9PwwO2Blzv
         F0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Br7Xsw5y96ZFYyqT9BFxaTLiG7xvUwQoo0QpCoqYcGU=;
        fh=HzMYePlYcBtbaL14dTY6G6jY6CQjB1nkrxcs+pFQujY=;
        b=eyfgxM0p3BlgiA1TiIn5e4IjwaZGccICS3eQ3PV/tJ9ELXtrU1iDjkbWd4M53HfFbJ
         2dGkqXtIPpNB3Js9iCa4Qvac1vIrlilRNFlUiLwZPXk3HCOcFS1P8pbEJAdaUmDVZZ3N
         wqKDYEFHBbrERfDyIoV2FEL3E74P71c0JaDh8XoC17eNmAQwLqrG4JjsACYMzhNJMYAL
         0nJDf0vpVFH8k+DBuRubdBQ13uonAwmwmqn4TJAt7Y4se/H68i0LZcKVevrbZui5kmNU
         rllkSUOPpwFPUnf1LtuDqFbpDp1gyLlLPd6uu3pB51ItHUrCP9fhXUJ59vxqlTFexC5d
         VArA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772550322; x=1773155122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br7Xsw5y96ZFYyqT9BFxaTLiG7xvUwQoo0QpCoqYcGU=;
        b=VGQrrBBejPTmC4kbrdVJ0iArLnCl6LVl0yKlqvQSRO54DVZ6+QgPdlSIuN/5tTbVPH
         8QzNAgbMuiuBlsO0eVckyCKdDml+1MQ6rUaqytieVuR2QOztQHTTnnhk4XSQSnT4Dnpm
         do1wj21dF4LJ6h69dQLhOcCogBnaCEeMwFRfIYg6iQbNBOWCn3FxFR6UBmxxMZZtAjPP
         9jIKSQaXSCw/h418DCoAVEm7P295vVZcbCD+rLVSwutOlkeLXux6zk8ZlhslNgK66qeG
         yjgTesNlxOanAGkcpEy7FkHfHBKf7ft+dRzpXPO9yGU5+lpdENZzzyuRlW94w9DuK32D
         P3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772550322; x=1773155122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Br7Xsw5y96ZFYyqT9BFxaTLiG7xvUwQoo0QpCoqYcGU=;
        b=fYBgnufnfP4J2oLn6E9vhEDPTTbWzziVxX/aGzr/a+J/i88iUasSnV+PXmQyQ6k2AT
         E28GIpJwQkd3KhFnlR/naGKdsB5SiLzuico8isP9o3V07L4OxwGMv7GinYlJqjK6w2U5
         bNl5rtKVUuxCy3yUA8AQlMPBu5t5k2OhLGanQG+R/JUIFlSqnwV/wrB0um/lWrrk+A8l
         OBhfOvvs0wVR5W7yAHN4YI1E3mq/tF/VMElV/ajt2yjtHgyortngl3LGozfUAJWvVStc
         ++5jGIOW7+5doBcp2fSZp60c/HE3XBCQNykrFvlGHRtogavb1kjudxf2Sfcw42YeA3L0
         I79g==
X-Forwarded-Encrypted: i=1; AJvYcCWSARRkZ8bIG+dl5dymql4GJeXM/KKHqsXayH/OLla061DASL+AjdNcUb32aw0ZD0dS7U7sQ1Hj+b7Vv22j@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd26zjxBb+s3D8ZXROrsCpGvsv5n5c8nwSNcwpPOJ+cP3r2uOy
	w4nDaERrVjMP216vuRWTXRtx3PeKp0ruzetbS3PwFjna3BJAR5EjwN3xT8YkpzWZD98Nl0n4UfW
	GfE+ilwPF4Q/UYDHHzykLRg/8eNa9YDE=
X-Gm-Gg: ATEYQzw8Og7O05Zkzz3CrGhZGOLSEbyNVexTZWIz31bqDGx2a6B/ru76yZoGG4yDpHJ
	bGMW8L8r0rL9sS3pCUov8p2q6p2Efapky/x76QKi4EVFHsrOETBg0AUxp7Sz64AKlle9iNVq141
	ivwAlt8pl5EeqPeIEvwbZARRjI5x7S5nujpDOjQWth0Od7zlOljEyYWtTRrY1t69ElyQQVOcgjj
	JC9K6PehrDmF9CnXa2dFxJzXqAchLg1w1hzCZN+ie+Xdg8oeUVmCorDfEruUXy5O7MrBYvXhTOz
	000HdCGKOTDeRXCFEShSONsdWahQICrpPDCl6VWsuw==
X-Received: by 2002:a17:906:c250:b0:b93:3792:4b0a with SMTP id
 a640c23a62f3a-b9376511b51mr703453566b.31.1772550321998; Tue, 03 Mar 2026
 07:05:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302183741.1308767-1-amir73il@gmail.com> <cf1cb14e9b74bfd5ca5bfcaf4d6a820ee2d4324b.camel@kernel.org>
 <CAOQ4uxhWZBrcPXRtP5Vq3GcPZpZ3LkHD9D5A6LtfaqnJFeC+mg@mail.gmail.com> <aab3haz7W4ZqTT-3@infradead.org>
In-Reply-To: <aab3haz7W4ZqTT-3@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 16:05:09 +0100
X-Gm-Features: AaiRm52SW-kcHAWHzI5ljO79CzUqVxR2eJdOcfo_M9xy2je_RZdIRI72j0olvYU
Message-ID: <CAOQ4uxhZHnSDJbLwvymJqkqKe5XhQG_W-HSNi7MnhChvuyK4vA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fsnotify hooks consolidation
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2EA3F1F2188
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79251-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 4:00=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Tue, Mar 03, 2026 at 02:18:47PM +0100, Amir Goldstein wrote:
> > > simple_done_creating_notify() is a better name?
> >
> > I will go with simple_end_creating_notify() because what it does is:
>
> Shouldn't the notify case be the default one and the nonotify one
> stand out with a prefix like _nonotify?  I.e., steer people to the
> more useful one by default.
>

It may sound like that, but in reality, it is quite hard to differentiate
in pseduo fs code between creations that are auto initialized
at mount time and creations that are user triggerred.

Only the user triggerred ones should be notified and also we only
have a handful of pseduo fs who opted in so far, so I think in this case
staying with opt in is the right way, but open to hear what folks think.

Thanks,
Amir.

