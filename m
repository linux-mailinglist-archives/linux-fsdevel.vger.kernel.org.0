Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49CB5191F62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 03:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgCYCm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 22:42:28 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51932 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgCYCm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:42:27 -0400
Received: by mail-pj1-f68.google.com with SMTP id w9so404838pjh.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2020 19:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=tJVGZmmA1bFjoevn7/qDYyyvIJ/eyc0u4ubgnC7ziTY=;
        b=H4706YZqf8/zScGoFg12vybnR9M2VsIQVJgSz3rS1dHY9dQHDGFEdxDFbUd7d1zTgX
         a1SAGpNqJGQq66/k++qcyoET2sxmyH3emD3uXnYHai1yW2TdH35PONdQL7aDm0PfPzyp
         tYlxhgWpkpR2jgcSCMS6Pg5GkhF65IhQxffKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=tJVGZmmA1bFjoevn7/qDYyyvIJ/eyc0u4ubgnC7ziTY=;
        b=sKa9hGRzLZ606ZyH9anlD+tT6G3psvsMk+JbxBvQfxPQL0A2xMP1IFgXEYUAJly8Lb
         NjCbm9/7fk9OAs2yJy8a65ZxHIydhK8fjjAbvCAy4+K2CQJ21iEj/0BrZKGvYpDGDyhS
         2ghN6dCILh3KxSe/KCEmpio1rIpkFaGQ1NrFipOov8ew1RO4FrGZ2NRpkGT+mLSiQqK3
         bInQ37lcM8lWbLpmpyrX4r3CGetUMWLHGnOjffCX2GmKKt9Nr3U6JzA2O1Yjunn0Jd+I
         2RMrIPN1yBi9uMUvVbUR/mxXN0UkNNkZUWama9mKPedCxV0jcVOeO2LZ8xdwR85vi29r
         zzKg==
X-Gm-Message-State: ANhLgQ1juJcyErYPeKeqNl04dJfKgsGzY+gspUzTy11qoubo8AwU/+AA
        CMlAcf7tHQ3pBN86GWzh/CN3dQ==
X-Google-Smtp-Source: ADFU+vtS5LbLrzS1jhzDwYVrTj6A9lZWX06g/Mga4Nlp7aFIrRyOCBB7aq2FIo/kyw4uUBQ1+JG/MQ==
X-Received: by 2002:a17:90a:33d1:: with SMTP id n75mr1033588pjb.167.1585104145832;
        Tue, 24 Mar 2020 19:42:25 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x4sm858194pgr.9.2020.03.24.19.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 19:42:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5cfeed6df208b74913312a1c97235ee615180f91.1582361737.git.mchehab+huawei@kernel.org>
References: <cover.1582361737.git.mchehab+huawei@kernel.org> <5cfeed6df208b74913312a1c97235ee615180f91.1582361737.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH 3/7] docs: fix broken references to text files
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arch@vger.kernel.org, linux-nfs@vger.kernel.org,
        kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        netdev@vger.kernel.org, linux-unionfs@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Tue, 24 Mar 2020 19:42:24 -0700
Message-ID: <158510414428.125146.17397141028775937874@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Mauro Carvalho Chehab (2020-02-22 01:00:03)
> Several references got broken due to txt to ReST conversion.
>=20
> Several of them can be automatically fixed with:
>=20
>         scripts/documentation-file-ref-check --fix
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/hwtracing/coresight/Kconfig                  |  2 +-
>=20
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/core=
sight/Kconfig
> index 6ff30e25af55..6d42a6d3766f 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -107,7 +107,7 @@ config CORESIGHT_CPU_DEBUG
>           can quickly get to know program counter (PC), secure state,
>           exception level, etc. Before use debugging functionality, platf=
orm
>           needs to ensure the clock domain and power domain are enabled
> -         properly, please refer Documentation/trace/coresight-cpu-debug.=
rst
> +         properly, please refer Documentation/trace/coresight/coresight-=
cpu-debug.rst
>           for detailed description and the example for usage.
> =20
>  endif

I ran into this today and almost sent a patch. Can you split this patch
up into more pieces and send it off to the respective subsystem
maintainers?
