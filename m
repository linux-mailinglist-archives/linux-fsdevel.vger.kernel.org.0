Return-Path: <linux-fsdevel+bounces-108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EFE7C5B4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552791C20F6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434B522330;
	Wed, 11 Oct 2023 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jsXPe6t3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9B1B29C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 18:27:49 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7317BB6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 11:27:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c3c8adb27so18262066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1697048866; x=1697653666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HfuTTDR+nJ6o/M0eow0TQoImOGAmMP0qEOP+RWPlF7Y=;
        b=jsXPe6t32aXYqLf16ejPQffnyIQK+RRE24WPNmawlpZtdmpeGPbzpKF+UpGQGNv8gj
         ExM725dg2iExTK56lZUkjLkg+p83sL/u75VgT0Ne5Mbl4RWNxWZjVnt2EsPXkyYGx6NK
         K/cvq8KZCQlS7Ldw1R984Q5zJhAEkGBume2yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697048866; x=1697653666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfuTTDR+nJ6o/M0eow0TQoImOGAmMP0qEOP+RWPlF7Y=;
        b=kKCtlIAOFMxaYMvw3M5Q6fViKxR9gJL1t6UA+3GCW1CxM7btpoSbZGDkZAekJxgqYX
         XcyMb7erqyKE9wQm6v0Nhl95VNwWiZpfJXZ5wSSe8rt2twbnj7M3EFHkNqtQuY7f03zm
         pye91AZkVyCeEkkDC1u3/x8Y4u95ua9jqLM19zPwFWXZftOdc/QV/VahxhAPUaGvkwkf
         +iBTKaIpnzlEq3T245b/icSRdq+8/O6bYKm+mNa0lA40rX4ryCQQPBm9hJNObs5ryETw
         cMmiOKuM5ZuaPYQ9Kbg+Ho8jVbaKqeJhUv4SjoaysLg+4sIdfxNgXt5Hn4XUjHScZS0P
         EHog==
X-Gm-Message-State: AOJu0YzZ2EHKhmFwNtXn+H5j9ijim4MPkeU7DVQN5fEG3yznYWnnxSx2
	nqX33YT/OTPt4shDwl3CvqKQVTtcejzw+xZzVxxs2A==
X-Google-Smtp-Source: AGHT+IEJB43UBIJkWXU/+yP7anQC/n2l6c6US9J/b6MClEUeWkTP8XSWSjTPJvy9IenYfNOmz1l4zjbgc9TJFxEEOO8=
X-Received: by 2002:a17:906:8a50:b0:99c:e38d:e484 with SMTP id
 gx16-20020a1709068a5000b0099ce38de484mr19331684ejc.6.1697048865820; Wed, 11
 Oct 2023 11:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1696043833.git.kjlx@templeofstupid.com> <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com>
 <20231010023507.GA1983@templeofstupid.com> <CAJfpegvr0cHj53jSPyBxVZnMpReq_RFhT-P1jv8eUu4pqxt9HA@mail.gmail.com>
 <20231011012545.GA1977@templeofstupid.com> <CAJfpegukL5bj6U0Kvvw_uTW1jstoD2DTLM7kByx2HAhOP02HEg@mail.gmail.com>
 <20231011163220.GA1970@templeofstupid.com>
In-Reply-To: <20231011163220.GA1970@templeofstupid.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 Oct 2023 20:27:34 +0200
Message-ID: <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their parent
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-kernel@vger.kernel.org, German Maglione <gmaglione@redhat.com>, 
	Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 11 Oct 2023 at 18:32, Krister Johansen <kjlx@templeofstupid.com> wrote:
>
> On Wed, Oct 11, 2023 at 09:07:33AM +0200, Miklos Szeredi wrote:
> > On Wed, 11 Oct 2023 at 03:26, Krister Johansen <kjlx@templeofstupid.com> wrote:
> >
> > > I am curious what you have in mind in order to move this towards a
> > > proper fix?  I shied away from the approach of stealing a nlookup from
> > > mp_fi beacuse it wasn't clear that I could always count on the nlookup
> > > in the parent staying positive.  E.g. I was afraid I was either going to
> > > not have enough nlookups to move to submounts, or trigger a forget from
> > > an exiting container that leads to an EBADF from the initial mount
> > > namespace.
> >
> > One idea is to transfer the nlookup to a separately refcounted object
> > that is referenced from mp_fi as well as all the submounts.
>
> That seems possible.  Would the idea be to move all tracking of nlookup
> to a separate refcounted object for the particular nodeid, or just do
> this for the first lookup of a submount?

Just for submounts.  And yes, it should work if the count from the
first lookup is transferred to this object (fuse_iget()) and
subsequent counts (fuse_dentry_revalidate()) go to the mountpoint
inode as usual.  This will result in more than one FORGET in most
cases, but that's okay.

> Would you like me to put together a v3 that heads this direction?

That would be great, thanks.

Miklos

