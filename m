Return-Path: <linux-fsdevel+bounces-2466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DA57E62D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 05:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1340281340
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 04:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037645685;
	Thu,  9 Nov 2023 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCuKaqWY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F50D289;
	Thu,  9 Nov 2023 04:33:36 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDED7269E;
	Wed,  8 Nov 2023 20:33:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50970c2115eso527833e87.1;
        Wed, 08 Nov 2023 20:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699504414; x=1700109214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uARwUxv/UYrp6wNzIbsXPz6fPeG3+1Fv5fcoBTua164=;
        b=fCuKaqWYzj+Jq0B9UHhZoZ2Q8jymTN1hIy/Ad/8Er/rx67Jjngvn8Uf+y+Bxtkn76P
         1PERSQBdqD4Mj3mNsvGcHItnhHb//0VR/yuy/mVeg9btgFbTkUpGIhLoIZXJKsJbXF9r
         TkWzOTahdnuTF7+DJr81u0k2C7S2WdQvvss/Fld9o6qqaopVr2ogFKQP6l7XTw3GsvEJ
         P+sNjt+NGhBjntrF1X9TqtFcw25C/WIk9v3tqTaUHFG49XRc5JfnUttoiEduk2kmO1o5
         123tLVjhTZAdEstq9qWTsKrKMBbIiqj6mNe142r120GVzRCv9Ub/NiOv+obHOkXmeXRx
         Ie0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699504414; x=1700109214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uARwUxv/UYrp6wNzIbsXPz6fPeG3+1Fv5fcoBTua164=;
        b=gga9Afx5x03rFT2xdh1kIDL+T1Dw8Ass6BpxLWkCy2t3uLimAD4kal1WC6uGmNbJX2
         75NbMlsaajUW+abCPuinzVxXSX7CCc5wVfCwvp4h1pq3Yr4Nx7uH23BabCBjpAQ/xKwS
         lAqYNIkxtr4Wy9upKOn/0GCZI/LVga7EbvZ4F0f5zEY03C++U3DN5b2L9hjA0Ct8ekLH
         /cPXjgebVJSwVWYXGFhGoxF3FyL7EEu8WSCCDIHZmUhuJa8ZmeLLGDtKazrY3cyR30Tr
         2m3tXXDl0rHU+VEdT59nq2VYB/MmnV0zelHg5RlO+47OIKT4GvzDF0AYN3vcH9ZRoCvZ
         P6xQ==
X-Gm-Message-State: AOJu0Yx/MmqSRRb4Z73oXJ5ljWZQUOS40wCzXiXHSky5jvDSrTuoyjWI
	CiQJ0d53pL1AOfD/CGVwx6SUvP0SC3xcze1Qh9A=
X-Google-Smtp-Source: AGHT+IFxK/NdnqiJnvQ+O8Zvgtfo8sP9UTidQ/djiDCyJLw41a9fLg6N1910uFJqGkrMWCXHAOvKRn33p4aLDFMmX1w=
X-Received: by 2002:a19:5e18:0:b0:509:cc4:f23a with SMTP id
 s24-20020a195e18000000b005090cc4f23amr415376lfb.64.1699504413704; Wed, 08 Nov
 2023 20:33:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108204605.745109-1-willy@infradead.org> <20231108204605.745109-4-willy@infradead.org>
 <28c55c338790757034b7a207de64bb2e.pc@manguebit.com>
In-Reply-To: <28c55c338790757034b7a207de64bb2e.pc@manguebit.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 8 Nov 2023 22:33:21 -0600
Message-ID: <CAH2r5mv5UHwe-8D7=qq4ctH=+ymE1Nxgsu=eYzf9MG9ycD9buw@mail.gmail.com>
Subject: Re: [PATCH 3/4] smb: Do not test the return value of folio_start_writeback()
To: Paulo Alcantara <pc@manguebit.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Steve French <stfrench@microsoft.com>

On Wed, Nov 8, 2023 at 9:46=E2=80=AFPM Paulo Alcantara <pc@manguebit.com> w=
rote:
>
> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
>
> > In preparation for removing the return value entirely, stop testing it
> > in smb.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/smb/client/file.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
>
> Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
>


--=20
Thanks,

Steve

