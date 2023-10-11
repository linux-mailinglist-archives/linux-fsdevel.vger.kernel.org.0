Return-Path: <linux-fsdevel+bounces-12-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B9D7C46C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 02:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B591C20CF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 00:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7402106;
	Wed, 11 Oct 2023 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nB1eJAcY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FC810
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 00:36:11 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA1F98
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 17:36:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-69af8a42066so3807334b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 17:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696984569; x=1697589369; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xq+AEqzmHiQrj4BnporbT5EC448/0KDAPw5SaA543wQ=;
        b=nB1eJAcYFJ0WLMPTTNQOXv2BCX7Ec5DJFEKhjnvMV9Vld0Zp32P1axIpbHBLQ5Lq4v
         FQodCej3Z/SjpXgBuDwPh2e0kyGFaWsrmL++BKMFs1K78r1i/vgEk5Oww39LhAoU61Ja
         PZ3U28c+2dfi0CE/gXBQ7OdORBHZFdy9XztaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696984569; x=1697589369;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xq+AEqzmHiQrj4BnporbT5EC448/0KDAPw5SaA543wQ=;
        b=HGkoLFJ38H2qAe7W+1DCbYI6h572AwzVuZLWSxJDSmD/Sr8eMCHar7CNkBe+PvsEnZ
         dHv6WmuZhioxhqdQF5no8zMVBtiVQL0lI6Os+oethAd9mnhn5fuqSkIwUs2xb15AD7Pl
         1KHuY9YC47yuwkXKFoUzhd1gGPsRlZX92b0B3/HXkSK61zXYv7sfrAk89JPtx+CbjlKn
         TJiY3QBMFmTsax13Lul7A2io4wxEuYyd6foQkkJ5LW4+q6hCOequ799Pk/5C7Aha195I
         /1u8ao70cnjjfnKEHtfFUbVwC5CiGuG31ngTmWN8iBuch8OGERypSASLW5piw2/bMWFy
         MO/A==
X-Gm-Message-State: AOJu0Yw30WhJomwPGD6NATEQ4NUv20q+QvzQoLUUjewEENSSUyN21c2t
	KWREGAJQ9WnSmTJS59CJEs3xdQ==
X-Google-Smtp-Source: AGHT+IFMfsjVmKnXm10wsvKLck/lh98ypo1T0gT+eWGMkht127PX3Zx9fbqq+35mlCoTyk2gMLVQoA==
X-Received: by 2002:a05:6a20:12d6:b0:13d:a903:88e6 with SMTP id v22-20020a056a2012d600b0013da90388e6mr21244798pzg.48.1696984569634;
        Tue, 10 Oct 2023 17:36:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g25-20020aa78759000000b006934704bf56sm8887859pfo.64.2023.10.10.17.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:36:08 -0700 (PDT)
Date: Tue, 10 Oct 2023 17:36:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Norbert Lange <nolange79@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	containers@lists.linux-foundation.org, jan.kiszka@siemens.com,
	jannh@google.com, avagin@gmail.com, dima@arista.com,
	James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v8 1/1] ns: add binfmt_misc to the user namespace
Message-ID: <202310101735.94C17F0@keescook>
References: <8eb5498d-89f6-e39e-d757-404cc3cfaa5c@vivier.eu>
 <20230630083852.3988-1-norbert.lange@andritz.com>
 <e8161622-beb0-d8d5-6501-f0bee76a372d@vivier.eu>
 <20230630-hufen-herzallerliebst-fde8e7aecba0@brauner>
 <202307121239.1EB4D324@keescook>
 <CADYdroNw5ZPPUqXQ5Psb8ffzi47SzvJAixQgxm+vsmV9eX_kYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADYdroNw5ZPPUqXQ5Psb8ffzi47SzvJAixQgxm+vsmV9eX_kYg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 06, 2023 at 12:28:27PM +0200, Norbert Lange wrote:
> Am Mi., 12. Juli 2023 um 21:40 Uhr schrieb Kees Cook <keescook@chromium.org>:
> >
> > On Fri, Jun 30, 2023 at 11:06:59AM +0200, Christian Brauner wrote:
> > > On Fri, Jun 30, 2023 at 10:52:22AM +0200, Laurent Vivier wrote:
> > > > Hi Norbert,
> > > >
> > > > Le 30/06/2023 à 10:38, Norbert Lange a écrit :
> > > > > Any news on this? What remains to be done, who needs to be harrassed?
> > > > >
> > > > > Regards, Norbert
> > > >
> > > > Christian was working on a new version but there is no update for 1 year.
> > > >
> > > > [PATCH v2 1/2] binfmt_misc: cleanup on filesystem umount
> > > > https://lkml.org/lkml/2021/12/16/406
> > > > [PATCH v2 2/2] binfmt_misc: enable sandboxed mounts
> > > > https://lkml.org/lkml/2021/12/16/407
> > > >
> > > > And personally I don't have the time to work on this.
> > >
> > > I've actually rebased this a few weeks ago:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.binfmt_misc
> > > It has Acks, it's done. The only thing back then was Kees had wanted to
> > > take this but never did. I'll ping him.
> >
> > Hi! Can you resend this now that the merge window is closed? I looked at
> > it in your tree and it seems okay. I remain a bit nervous about exposing
> > it to unpriv access, but I'd like to give it a try. It'd be very useful!
> >
> > -Kees
> >
> > --
> > Kees Cook
> 
> Hate to be that guy, but did anything move closer towards upstream
> since that post?

No rebase was needed -- I've dropped this in -next now. Let's see how it
goes!

-- 
Kees Cook

