Return-Path: <linux-fsdevel+bounces-14226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA4879A7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 18:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7561F23797
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683501384AC;
	Tue, 12 Mar 2024 17:17:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD04138480;
	Tue, 12 Mar 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263831; cv=none; b=G58tqCpToqnimXNCHxLIJ/8Pbb9HCduM1AgNI0370tEU1mbPp7m/J6FFB0KiX/S0vTGi60PonUa48IByUB9GTcruROO5pCrlWt+myvYqmui7PHBZglHWxgARUggTskfzysUhx275Sn28CeFp4iLV9IGVWFS8J7S7VTCAF6d6pKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263831; c=relaxed/simple;
	bh=xITrj0ehdBMV87TPdyYS9Phjx8PUceH6XM0wnoicC/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOY/2ifI0MTstP7SKaYApcUkXYDZiu93gktg2MbGs2Ga6EV/eBAr4Olnld0vOfAJ4kIhmKWq5Jk77s9fXZEm5lTNlcrKPAv6/HrTVxq8+UFgYebIGxrt1R019YVga6tusyTo5a5Y3LQdN2akkZPUZUfiN5a41jpzvQ96xz+SWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46444dac18so132082266b.0;
        Tue, 12 Mar 2024 10:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263827; x=1710868627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xITrj0ehdBMV87TPdyYS9Phjx8PUceH6XM0wnoicC/I=;
        b=NNaSa+wJ5qME0h95LmGLW9z2WOImnFYOsibVV/cFTPFC5rZFfcmEGZziZslCS5xm66
         dSSjrTn/XokScXh3lnR10Asvt8fJ8/MzGjXyyAXok3e3v1iulT5UzLzwzcBOpU3JfujR
         CVhJ5l/V43jerWnepipgiRpYY0MitDygCFgoRH8jsReX9G2mAoHYYnx6g5fEtbLEuTYa
         g9plXP8rNsMGmFxJExByQQhmFy3woza/dK9bJIJQg9xCTMdVM7G8r5wfvao4LQ8wpgh7
         055FtY12e621/7JcEPfBxgEYZG8GIJcs0Zd+YQJ8QFMQarC+HMCjwGMYp8ImKVWYKhLL
         Es5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeadtC+q7UYEHHSBOiByyvewcpkdoc6B2kpV4xwPqbY5hMIzT0MtB/VI74tDZBvSw/glu7tuhaNDbQTFsTJkTOweBcyIzN1g6pG1ZEX6WalhmnoJbeGQpb5vitk7L6dA4nl5PJ27K068Nbxg==
X-Gm-Message-State: AOJu0YxK62kM0hVpBh9b3Us4Mdm/i05h/XPH+Ab00dEtl0lOI0RuQ6rx
	0lhBTMcfvWvhyFgD3akQRhmC14xWDHc9cYZCxtGu0MBI99H/v78pSZMmZUAjijk=
X-Google-Smtp-Source: AGHT+IHs4umArvdDmXE2LyWjRb2UQjVN9XWjK98TGkM4+qORMPFfSZ5TkmaPj72V4y13uvOemmNjmw==
X-Received: by 2002:a17:907:a644:b0:a46:134c:ae8c with SMTP id vu4-20020a170907a64400b00a46134cae8cmr7337176ejc.50.1710263826903;
        Tue, 12 Mar 2024 10:17:06 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id x8-20020a170906b08800b00a4646051f25sm709850ejy.203.2024.03.12.10.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 10:17:06 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56840d872aeso4403946a12.0;
        Tue, 12 Mar 2024 10:17:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjPc9lt/vw0RBOO83W5nkceYH/7wtdcj/CBo2LUXkamlOi/FoyMrwiT7nm9/lFcCl+nteT18j3ZF2D3r8Np5705fWFOXaCe++OXU661pCJWaEG6C8JNU5cqWyGue1kRRxgyvtI8Sc3Z4dg5w==
X-Received: by 2002:a17:906:99cf:b0:a46:269b:4dae with SMTP id
 s15-20020a17090699cf00b00a46269b4daemr4577332ejn.25.1710263825864; Tue, 12
 Mar 2024 10:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <76j2jzc7zwuvfl4nlyycoufp75nkwwngho67rwz6ipg26lnge6@66olqpcffwa5>
In-Reply-To: <76j2jzc7zwuvfl4nlyycoufp75nkwwngho67rwz6ipg26lnge6@66olqpcffwa5>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 12 Mar 2024 10:16:28 -0700
X-Gmail-Original-Message-ID: <CAEg-Je-s4K3eCVtq+sRN+fcb50yZyVVvWa+FbDtT-eyMfTAXJg@mail.gmail.com>
Message-ID: <CAEg-Je-s4K3eCVtq+sRN+fcb50yZyVVvWa+FbDtT-eyMfTAXJg@mail.gmail.com>
Subject: Re: more on subvolumes
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 1:51=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
>
>

Is there something you meant to send here?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

