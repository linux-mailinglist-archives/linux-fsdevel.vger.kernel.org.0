Return-Path: <linux-fsdevel+bounces-79560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLkEGdUlqmkPMAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:54:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B51B221A0B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ADD5304020A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 00:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F052F1FDE;
	Fri,  6 Mar 2026 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJzrGXRI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C6429AAFD
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758334; cv=pass; b=bAnhxF1NEMcpG9hvFyQY1DOVKzTG/hWVczaA51WnAhyB4w3ZZqWgM6SeQtBFXt6yd/YpjRGpfckDL8n0DnfvtqXQ5zWrfRMAtFTsJkEWy4OP7GrZi2rKQ7qtgz+E3RXugv0ge53lsd2tBFkObOLyusYYOAnSYD7SfAZbVEbziWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758334; c=relaxed/simple;
	bh=EFo2fmOfIwFoC74mkGMJHWgt/5X7cWbyvrs7bqVkz3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqc33/irDF2mCGLRP8lKzMjzp82rFFVba2WPAg7cdx9vj4L34iB+nTV1u8PD/xAJDy7cJLIcqONMYfXNFA4ohepZIf+ZvQU1zf9yaQxyDYTT+uK3CqCFCx5//i5A6OXH4scwmreMbP42BZ6nhE5uB0BEa6o9xx6rbGEikNMhNUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJzrGXRI; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506a019a7f3so104449121cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 16:52:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772758332; cv=none;
        d=google.com; s=arc-20240605;
        b=IkXkTCfiHyekysWNpnqooUGEg1Oz7qmwwjK2EOakioLGufx+DPjIoCO1NYUt4WzY8W
         pOLBOFun9U79aQHoJRqOyfofo5OPjD2zrp6WDBAWkXcs2LfTTA1btEtMY8PpK/3vB4TU
         bxsCoE+A7MZTeIkcFGY11ACKUJNWlZh6XSXH0dP/5xRMBSoeFbDCkviJjfSkIaRAzCHD
         3Pu1X+Ohgq7rOQC2St9ZqiZsXqO7PrLi6iUiOeXyXnZ24fUfuLwzHXBorI8iagXeuvqi
         ERb1XhEdZDNENHOY7nAyWp0tsxf3JWF3iUESBxHohJJAfxIm59OXejKfLrI+b8jiZ/XN
         y26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=chlcYmLU4f9C6gMX0tL82B+BlLisCsu2pr6uW8UrABk=;
        fh=ihcQ0ihZ1Pw/AMnmJPGweN6SZpx8yaX77YdLd4Qc/98=;
        b=Wf1hg7MkGiDtksQb4APchSpvnVQ4qeqn37m2qaib50J491kXHSmQqWYQBJ/DUIw739
         USg6Q6ntk2hYh6Y/5mOEh8jCTAaziNvKqVc7QiU1IDJjGWeyn75ylfjiKBAV6eSRWmXx
         xLSotT09CECvHJlpE9eCb1pBaterpm5bbzAuX2q74s6DQkQR+LGMY2BadyDo51ATBIYf
         p71DbxWUOSp3LAgCIYFheSYSOrAfZnpj1Iqp6tjWn4RakL9l/HZCbnsbT3z3e4ebjfIW
         K/XeedCHdCVro50+QM0XkFK2NBfMgelY6Z9OiOgGvTE4TFWO1ZRLf5Bq1V0X0jFAr8au
         aTVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772758332; x=1773363132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chlcYmLU4f9C6gMX0tL82B+BlLisCsu2pr6uW8UrABk=;
        b=bJzrGXRIXexBSW7RjfRMcX4VnSixpnsL1KRhfqV/pjUK/grQJcjIKcYXMAEGMQcR2H
         cQn9tnmpm5ohn/z4ZqQQ281PUJRIJRXlLXAhhlwWzz/aYRimdcjoeiJAx0vj8bBDt9oy
         6DY3j6+buDCb+96GKV02orp30RjmGErVU+diiEXq9mEpMWqmBOowPfYPQ8pKupWiCueA
         kc4IBtOXpnG6BSYMJSIqvOb8moW1QZgMPBg8SasBM86At0BTk8Owk79hmQ7mWK2vFQVU
         En0VrnqExB0WV0DoIJYdKZYhPscVEqyJpPU4Es4GTGXbk1jz+r9H9c1wS054TaK0Y+Va
         p0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772758332; x=1773363132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chlcYmLU4f9C6gMX0tL82B+BlLisCsu2pr6uW8UrABk=;
        b=XZ9b4bsZdM83tNG1HJjb+9PiZ99AUWkkq3vYl2YKZcp+mfme2FVkMz8CDU5ZViyXCp
         O++uETAEvhOZoiRNJDpwHQExuGFWpZzjxJ6VAkcwRU0Kq3Q+kpn2reBptSZDl9Khuiut
         LfFdnLX5RZJsBTur59gxK1OFzeewXARN4zFk/e/PV+tUXbvYU+HmkzrANduPLf2oH++V
         A70STkNzERq8emWVILYAZcXXpJ3l6ThQfMhOO/E4PNQyYUKkFBsdTzvtIy7GncNzoIWQ
         79RA/FOYtj4eCMEXhhhEuN3f/ZMzOxiZUW6Mvsmxbg+9PYkYSJVpA1WtB1c//W+gPHg8
         hNZg==
X-Forwarded-Encrypted: i=1; AJvYcCVEeUhoI+J/bx7rmrNV8Hv3Yh4TG4d99r6x+iXeh91N0LggzrlnohliYocsvOhk/50NzUOR0fSnUGKcBkxg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1f+Poy2XVI+3B7XqUxGuV/77Omwzw+TukN/kFzLEqYARpxERH
	Gt2yih7SBIs+ctyHz5qXbl9p7s2RHyc7XffrNCA4JW8I7B9PnDLKlcQ4Cf+GQXSCd5/ozX/mwR8
	Phkwf1C7qMvxDHQB/EyYznISWR3WvGG0=
X-Gm-Gg: ATEYQzyzJpz7ia/N36u74Mi++MFLX2F0nQwqnZDmvC2N/1Y1wa2ml4JrgjDgMU+u7yA
	RrB/ucc/w1b+FA/lftB3UahZiYCfgW3qh6S/u0I+OsouSmwZlgz59Mxu5gI1GIrChHyU3tI4Pzm
	IWi6Gc9E9x5ir2TWpCRPCWQtVSGxNcXZvJJ43kcKWywGOC19Hm3gSXxI+RCjdSmYPawP3Oo4YBp
	OPr6f+VhJBUToAV1Rq49+K7h4DPYbkmAWUWJWILhmA3QCk4QDokMqEDcfzLJvIjipOTMOvjOBww
	lnuxRw==
X-Received: by 2002:a05:622a:10d:b0:4f3:565b:c52c with SMTP id
 d75a77b69052e-508f493b52cmr5311131cf.39.1772758332127; Thu, 05 Mar 2026
 16:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com> <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com> <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
 <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com> <aY25uu56irqfFVxG@fedora-2.fritz.box>
 <CAJnrk1bg+GG8RkDtrunHW-P-7o=wtVUvjbiwQa_5Te4aPkbw1g@mail.gmail.com> <aZC0WdZKA7ohRuHN@fedora>
In-Reply-To: <aZC0WdZKA7ohRuHN@fedora>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 5 Mar 2026 16:52:01 -0800
X-Gm-Features: AaiRm533igGZQ-MKpugukcuJtcmvqq8V3uXkeO7jYMLMRqevrig7qGzjhMVdkjQ
Message-ID: <CAJnrk1YUf7xw9s8Bo1YZXVvfe8U-D4E+j-3iZNtOkog4QRZaMw@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B51B221A0B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79560-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 9:51=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
de> wrote:
>
> On Fri, Feb 13, 2026 at 05:35:30PM -0800, Joanne Koong wrote:
> > On Thu, Feb 12, 2026 at 3:44=E2=80=AFAM Horst Birthelmer <horst@birthel=
mer.de> wrote:
> > > I have a feeling we have different use cases in mind and misunderstan=
d each other.
> > >
> > > As I see it:
> > > From the discussion a while ago that actually started the whole thing=
 I understand
> > > that we have combinations of requests that we want to bunch together =
for a
> > > specific semantic effect. (see OPEN+GETATTR that started it all)
> > >
> > > If that is true, then bunching together more commands to create 'comp=
ounds' that
> > > semantically linked should not be a problem and we don't need any alg=
orithm for
> > > recosntructing the args. We know the semantics on both ends and craft=
 the compounds
> > > according to what is to be accomplished (the fuse server just provide=
s the 'how')
> > >
> > > From the newer discussion I have a feeling that there is the idea flo=
ating around
> > > that we should bunch together arbitrary requests to have some perform=
ance advantage.
> > > This was not my initial intention.
> > > We could do that however if we can fill the args and the requests are=
 not
> > > interdependent.
> >
> > I have a series of (very unpolished) patches from last year that does
> > basically this. When libfuse does a read on /dev/fuse, the kernel
> > crams in as many requests off the fiq list as it can fit into the
> > buffer. On the libfuse side, when it iterates through that buffer it
> > offloads each request to a worker thread to process/execute that
> > request. It worked the same way on the dev uring side. I put those
> > changes aside to work on the zero copy stuff, but if there's interest
> > I can go back to those patches and clean them up and put them through
> > some testing. I don't think the work overlaps with your compound
> > requests stuff though. The compound requests would be a request inside
> > the larger batch.
>
> I would like to have your patch for the processing of multiple requests
> and the compound for handling semantically related requests.
>

the kernel-side changes for the /dev/fuse request batching are pretty
self-contained [1] but the libfuse changes are very ugly. The
benchmarks didn't look promising. I think it only really helps if the
server has metadata-heavy bursty behavior that saturates all the
libfuse threads, but I don't think that's typical. I dont think it's
worth pursuing further.

Thanks,
Joanne

[1]  https://github.com/joannekoong/linux/commit/308ebbde134ac98d3b3d3e2f3a=
bc2c52ef444759

