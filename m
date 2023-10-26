Return-Path: <linux-fsdevel+bounces-1220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B89D7D7B04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 04:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEAB1F22E74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 02:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD038465;
	Thu, 26 Oct 2023 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f2HOwWQi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A1623
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 02:43:03 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1A910A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 19:43:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso537596a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 19:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698288181; x=1698892981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOsJ0jv24GZNwV9BzuCoCH+allJmFIIls6BBRXFIG8w=;
        b=f2HOwWQi94eEjfuZNRFSKwwHG29NORyDUa9dblaYLSP1MZIToRJ6hqz2FAS3jU+8Ij
         IKL88JvdrHXbJjtdEUhntpML57nqzudkCfT/xNIxz2p8A4J8J627sYYhzRg9g6LyahXY
         WZTxTt/mx+IeDOd93OOx1vGd/zbwhtt7UiiEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698288181; x=1698892981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOsJ0jv24GZNwV9BzuCoCH+allJmFIIls6BBRXFIG8w=;
        b=m1+tg9HuY5HtjxQPMq7HN84RMkWQiLxr45RzdNbWbGWy2ngYDTucers4f4Chw6rD2S
         hkdB824UpG+TNl0k0cl7atdoriC2PK+kWcLVHLuHkt2mzlzUZl4DGggaxtcTkkTBR6JE
         SRVJCPyRcQCRTU8l1MN8H8MZF9jymMwAedns2af9xeNRUMAguKJ2/0dUeAFOGo6azrb/
         Q9pS82MyEXcj/3DmuyTZMdBXaVecatEhfAIGSZqGHYwlMZnXiHBD6cOb+sTsJAv/uSMn
         Z3b5HbJnqF3xWrom7j3hFJbKCCIBY0ZqtzBvCvTq3bI5vEZcx+RUgNavZ6CCO70ex3vK
         eDWg==
X-Gm-Message-State: AOJu0Yxy+3ipKnS0nxQq6tVthprBctEQN71wFUkF1hDD9mD1qg3FUG6a
	pvWC3IjyWnIFfg+3Q76kpWQYFxuYDeTNwzzVub0KoQI55AG4UeBfTQ==
X-Google-Smtp-Source: AGHT+IFs3ahbd7cWJ1KFLD1dw9ZqnP+K876+3apQoV0Aei/q1prsrm/UnMJpyMMCHdISclwgNyDEOchlHy8eb1Bb4m0=
X-Received: by 2002:a17:907:6e8d:b0:9be:6395:6b12 with SMTP id
 sh13-20020a1709076e8d00b009be63956b12mr14680283ejc.27.1698288180785; Wed, 25
 Oct 2023 19:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023183035.11035-1-bschubert@ddn.com> <20231023183035.11035-3-bschubert@ddn.com>
 <CAOJyEHZUq0xWBaMet8s1O5Bpz-M-pR39wWCfwFtm66rySzm6vg@mail.gmail.com> <89d180e6-65c5-47f8-82ad-cc5a4b2e1e63@fastmail.fm>
In-Reply-To: <89d180e6-65c5-47f8-82ad-cc5a4b2e1e63@fastmail.fm>
From: Yuan Yao <yuanyaogoog@chromium.org>
Date: Thu, 26 Oct 2023 11:42:49 +0900
Message-ID: <CAOJyEHaoRF7uVdJs25EaeBMbezT0DHV-Qx_6Zu+Kbdxs84BpkA@mail.gmail.com>
Subject: Re: [PATCH v10 2/8] fuse: introduce atomic open
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	dsingh@ddn.com, Horst Birthelmer <hbirthelmer@ddn.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Keiichi Watanabe <keiichiw@chromium.org>, Takaya Saeki <takayas@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently, if _fuse_atomic_open receives an -ENOSYS error, the
no_open_atomic flag is set, preventing further use of atomic_open.
However, even with the no_open feature enabled, atomic_open can still
provide performance benefits when creating new files due to its
ability to combine FUSE lookup and FUSE create operations into a
single atomic request. Therefore, I think it would be advantageous to
allow these two features to coexist.


Thanks,
Yuan

On Tue, Oct 24, 2023 at 9:36=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 10/24/23 12:12, Yuan Yao wrote:
> > Thank you for addressing the symbolic link problems!
> > Additionally, I found an incompatibility with the no_open feature.
> > When the FUSE server has the no_open feature enabled, the atomic_open
> > FUSE request returns a d_entry with an empty file handler and open
> > option FOPEN_KEEP_CACHE (for files) or FOPEN_CACHE_DIR (for
> > directories). With this situation, if we can set fc->no_open =3D 1 or
> > fc->no_opendir =3D 1 after receiving the such FUSE reply, as follows,
> > will make the atomic_open compatible with no_open feature:
> > +       if (!inode) {
> > +               flags &=3D ~(O_CREAT | O_EXCL | O_TRUNC);
> > +               fuse_sync_release(NULL, ff, flags);
> > +               fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> > +               err =3D -ENOMEM;
> > +               goto out_err;
> > +       }
> > +
> > + if(ff->fh =3D=3D 0) {
> > +        if(ff->open_flags & FOPEN_KEEP_CACHE)
> > +            fc->no_open =3D 1;
> > +        if(ff->open_flags & FOPEN_CACHE_DIR)
> > +          fc->no_opendir =3D 1;
> > +       }
> > +
> > +       /* prevent racing/parallel lookup on a negative hashed */
> >
>
> Thanks again for your review!
>
> Hmm, are you sure atomic open needs to handle no-open? fuse_file_open
> sets no-open / no-opendir on -ENOSYS. _fuse_atomic_open has a handler
> for -ENOSYS and falls back to the existing create_open. So why does
> atomic open need a no-open handling?
>
>
> Thanks,
> Bernd
>
>
>
>

