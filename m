Return-Path: <linux-fsdevel+bounces-1363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40567D990E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 14:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52731C20F7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733EC179B2;
	Fri, 27 Oct 2023 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUy87ifH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36B945A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 12:55:45 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD8D187;
	Fri, 27 Oct 2023 05:55:44 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d332f23e4so13367506d6.0;
        Fri, 27 Oct 2023 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698411343; x=1699016143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RRmUeiCvRSHcsxJCKASs1PrAktNtGUy04A9EKT5KbU=;
        b=EUy87ifHp5zHg5LhP5NAIWVdKnWdaNLnMdcGU4QgRa4c+x6HCGEBOGsmz6n/dD9QwL
         bdqDN3XGi0J5jZH7sz0CA5jmWTV9aF9mG9M+74Dm7jwwlBhtrV9h5jzxokvYLnMDmPgX
         gtVb6dleuOUpwxp4/nvjvB31lhaxngoLT4sbTPCmWLoRwIcLJGChpHEcG48w3vz7Hzvn
         D++I4o7Gn4/7Z64iR6MqLV7SW0hvxTpiwD4yCbhkMhJZe5aN8bsSKPju6v55Vr18Dhkb
         fFBae72lnTo1fiOMQTsqIONFeLpMiQ0V+t6jfvP6EWxe+Kt59ZY9aHgpHLSqfSRq37IP
         agxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698411343; x=1699016143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RRmUeiCvRSHcsxJCKASs1PrAktNtGUy04A9EKT5KbU=;
        b=Ck3xgqhDtORl/nnhKI3Ur9XaM7WqhK5dXBOQKmaHY9dkR5uAkluLhayJ+I7IOxSZSI
         yrS8gTX8NNwGUIWjrXqpm8rV8z9gt+YzcJZ/fy/AYWtl5kfItPuUPa73yVvhbGhveHND
         g576CMKmA3C1QcFkghzNz80dKFYHsX04EWFMrJfCAqj5qtFIlT6tfe/c7BXNeuFdwBsj
         uFHmFp0qy+YcTkNGuYIkhxJEekisGswT5BQsG4M62DBsbQEtpdCAAhnR2NSIkFpGOYbd
         0IuuBIKp13QMj8YT3fWOMNm/TnEg+rvOoGV7GbHJxJXo8bOJt0nTFY+bjBpwhzTAYwaq
         b7/Q==
X-Gm-Message-State: AOJu0Yy0p5MHrArEgsQMGv7kd1InMeIwGjKKAV0cHi92oiMUmiIBHr/V
	SfcwHj3T39caKQSvN8//gtToLChsq7ugfg3zhSYtQYAD
X-Google-Smtp-Source: AGHT+IEfcBCmWVyeW2UIwGeT/7eOWSuBo1A4xW/t7xM8WQD6QajXWLB2YpGeEw2WFU/QWXQcEjwo3z9pgsPrPNzVpn8=
X-Received: by 2002:a05:6214:2406:b0:65b:232c:1546 with SMTP id
 fv6-20020a056214240600b0065b232c1546mr3591642qvb.24.1698411343423; Fri, 27
 Oct 2023 05:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026205553.143556-1-amir73il@gmail.com> <ZTtT+8Hudc7HTSQt@infradead.org>
 <CAOQ4uxh+hWrMrP5A=fGRMK7uTxFFPKvJRNu+=Sc3ygXA1PzxvQ@mail.gmail.com> <ZTtnMYJdfdIMuZnj@infradead.org>
In-Reply-To: <ZTtnMYJdfdIMuZnj@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Oct 2023 15:55:32 +0300
Message-ID: <CAOQ4uxg-SWUsQp0cdpWRxJnwy3A0ZqnGy=RUkxqGh2SaKNa_mA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: create an entry for exportfs
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 10:30=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Fri, Oct 27, 2023 at 09:35:29AM +0300, Amir Goldstein wrote:
> > On Fri, Oct 27, 2023 at 9:08=E2=80=AFAM Christoph Hellwig <hch@infradea=
d.org> wrote:
> > >
> > > On Thu, Oct 26, 2023 at 11:55:53PM +0300, Amir Goldstein wrote:
> > > > Split the exportfs entry from the nfsd entry and add myself as revi=
ewer.
> > >
> > > I think exportfs is by now very much VFS code.
> > >
> >
> > Yes, that's the idea of making it a vfs sub-entry in MAINTAINERS.
> >
> > Is that an ACK? or did you mean that something needs to change
> > in the patch?
>
> I as mostly thinking of dropping the diretory and the separate entry.
> That would also go along with your patch of making it a bool.
>
> But if you feel strongly about that we can add you as an extra reviewer
> for it :)

I don't have a strong opinion about this.
I am submitting this patch on behalf of the current export
maintainers who requested to stay as maintainers of fs/exportfs
and offered that I join as a reviewer of fs/exportfs.
I cannot join as a reviewer of nfsd, hence this needs an entry.

Thanks,
Amir.

