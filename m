Return-Path: <linux-fsdevel+bounces-6195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1A7814BDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 16:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695001F24EAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174003A8E7;
	Fri, 15 Dec 2023 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nrh95jV+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C343A8D5
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dae7cc31151so521762276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 07:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1702654269; x=1703259069; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Occ1vfgL8dgUQez4tkH7OqyVGPUXn2bu7pkST0J17mE=;
        b=nrh95jV+NFpOyJocpvaatY+pglbIB4xT4G3g/7ZWbFP3OHRvbxdthmW7/5ar9XczIG
         ZrxPw1vC+HpJM6s6kMAjQ1LULJ90icdKgD4mqaj6XGE/LHbVxYoKEvgy3Oife/xUe4Vy
         JMxCyRW1OremL43Ps9ozfMsAAI607A++os/kLyRQ3kQa9cHLa5+z3pSiDhg4F0+M192P
         /h+HpW26MSOr55cL7VP5TgFdee9+YlKunCt/CJzNdOcXjXZD9zrClu8DJLNuAVSyqM6y
         /CXmufOseIx1WcnwYIYjYjPuB4nIDting7RR0MrQxKIvdkiMk6U4HBkyW0xNpGLBPDri
         8Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702654269; x=1703259069;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Occ1vfgL8dgUQez4tkH7OqyVGPUXn2bu7pkST0J17mE=;
        b=VgCIq8hxvmdqE7xiPwk+XZ9ytqrUhYJxKsslB2O5AdcLv1/3e0M3mcDt4VzTFLqq86
         Av9roqI4FXOGDoDz8qykQ+Ll+E6fZyqhF7lRumMD0+s8x/cGwrGrXFvy2QOXCc7YSj1G
         hOpuMPV/sF/8GYyfZ61hRGSBrXV6nPVAP13aTcGV7rFBcRGeTVoLUId99I9/IbFImWP1
         WbR3mKp+yXaJwEIOGYjM3nMvVzqepAR3G91X/b/dyQbSh4oM/vt+m1IiqZ5wMRlD1XPF
         MhbI0mhUhyUhcGVCXWBQ4g9ub9ciuOW79u0nsI6Yr+rdDqDxi421V73aWBve0w69o/Im
         VKrQ==
X-Gm-Message-State: AOJu0YwgC8iO23wjb9FyHfg+SNtraVWKlNdqLXoz+2cs/d6RhkupUQm3
	WtvjCEuONfYiBhVkXJxmuu7igQ==
X-Google-Smtp-Source: AGHT+IHbfEJdXjtO8hrpQfvPmAvGsxZIXIbpOuwmAM7Lg2o2W+hft09gTW1/Eqd2uqMO9r7azV5gsA==
X-Received: by 2002:a25:f826:0:b0:dbc:e39e:bdb9 with SMTP id u38-20020a25f826000000b00dbce39ebdb9mr1813765ybd.88.1702654269541;
        Fri, 15 Dec 2023 07:31:09 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q3-20020a258e83000000b00d815cb9accbsm5454492ybl.32.2023.12.15.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:31:09 -0800 (PST)
Date: Fri, 15 Dec 2023 10:31:08 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission
 response
Message-ID: <20231215153108.GC683314@perftesting>
References: <20231208080135.4089880-1-amir73il@gmail.com>
 <20231213172844.ygjbkyl6i4gj52lt@quack3>
 <CAOQ4uxjMv_3g1XSp41M7eV+Tr+6R2QK0kCY=+AuaMCaGj0nuJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjMv_3g1XSp41M7eV+Tr+6R2QK0kCY=+AuaMCaGj0nuJA@mail.gmail.com>

On Wed, Dec 13, 2023 at 09:09:30PM +0200, Amir Goldstein wrote:
> On Wed, Dec 13, 2023 at 7:28 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 08-12-23 10:01:35, Amir Goldstein wrote:
> > > With FAN_DENY response, user trying to perform the filesystem operation
> > > gets an error with errno set to EPERM.
> > >
> > > It is useful for hierarchical storage management (HSM) service to be able
> > > to deny access for reasons more diverse than EPERM, for example EAGAIN,
> > > if HSM could retry the operation later.
> > >
> > > Allow userspace to response to permission events with the response value
> > > FAN_DENY_ERRNO(errno), instead of FAN_DENY to return a custom error.
> > >
> > > The change in fanotify_response is backward compatible, because errno is
> > > written in the high 8 bits of the 32bit response field and old kernels
> > > reject respose value with high bits set.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > So a couple of comments that spring to my mind when I'm looking into this
> > now (partly maybe due to my weak memory ;):
> >
> > 1) Do we still need the EAGAIN return? I think we have mostly dealt with
> > freezing deadlocks in another way, didn't we?
> 
> I was thinking about EAGAIN on account of the HSM not being able to
> download the file ATM.
> 
> There are a bunch of error codes that are typical for network filesystems, e.g.
> ETIMEDOUT, ENOTCONN, ECONNRESET which could be relevant to
> HSM failures.
> 
> >
> > 2) If answer to 1) is yes, then there is a second question - do we expect
> > the errors to propagate back to the unsuspecting application doing say
> > read(2) syscall? Because I don't think that will fly well with a big
> > majority of applications which basically treat *any* error from read(2) as
> > fatal. This is also related to your question about standard permission
> > events. Consumers of these error numbers are going to be random
> > applications and I see a potential for rather big confusion arising there
> > (like read(1) returning EINVAL or EBADF and now you wonder why the hell
> > until you go debug the kernel and find out the error is coming out of
> > fanotify handler). And the usecase is not quite clear to me for ordinary
> > fanotify permission events (while I have no doubts about creativity of
> > implementors of fanotify handlers ;)).
> >
> 
> That's a good question.
> I prefer to delegate your question to the prospect users of the feature.
> 
> Josef, which errors did your use case need this feature for?
> 
> > 3) Given the potential for confusion, maybe we should stay conservative and
> > only allow additional EAGAIN error instead of arbitrary errno if we need it?
> >
> 
> I know I was planning to use this for EDQUOT error (from FAN_PRE_MODIFY),
> but I certainly wouldn't mind restricting the set of custom errors.
> I think it makes sense. The hard part is to agree on this set of errors.
> 

I'm all for flexibility here.

We're going to have 2 classes of applications interacting with HSM backed
storage, normal applications and applications that know they're backed by HSM.
The normal applications are just going to crash if they get an error on read(2),
it doesn't matter what errno it is.  The second class would have different
things they'd want to do in the face of different errors, and that's what this
patchset is targeting.  We can limit it to a few errno's if that makes you feel
better, but having more than just one would be helpful.  Thanks,

Josef

