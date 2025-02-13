Return-Path: <linux-fsdevel+bounces-41639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC4BA33D70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 12:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D25A188CC3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54962147F7;
	Thu, 13 Feb 2025 11:05:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346472153C9;
	Thu, 13 Feb 2025 11:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444754; cv=none; b=gp7j/6dOz5eM9vcTqLHP/lw9Ms/SIIoKDeKgH9Nvb1FYkqL+XqyxYg02mgOmd3EzsAeTrj9J7U1dOtMOrwmfM96LWwLOsTcGcKAE17bbiANVR+7raG32QgOqVDog+/y7J7Gfoyqt/xV2ZaR0VMXtjSrS3f8ZXJ6ezWsKpn/iWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444754; c=relaxed/simple;
	bh=9rOLz9j8ukC3IBY52vM/5h5W1WC8cIF0s1Y3lhZBTyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBeOaYLNWXAmxracL8GR3x8Wsy/pSg5pxdrVQx6T9Wh5zFuo4Tu2dKdBME/TpE8bU7Y0uwga2TEKqsqS6MwFalsQrOdfiDC4rZsY2OY+fvfKhs8jH83kWNJJURhEsgzFhHw9Di/W4OtjRxyYgYszq5C3c+ASVbg+AHt9M1T7Apk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4b68cb2abacso203288137.3;
        Thu, 13 Feb 2025 03:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739444750; x=1740049550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAeciXbZsCKyuzMnsNDc2dPCf1u4qXoSEiFxuqZqCsA=;
        b=vntZmvvnQreM+ezUrnCpupT91dKldOPD+u/Q/Z3koobZQ3g/raju3tlzgE0z1WYNrD
         w7MOwhrjQbSdVDJsXXtFo6V0srsE25qvGIbO8L4y9n+X9G4YZdzXJYX+aVrTjwsyBnNx
         I66g3msj/vX/UnSSph9JTawaBiMonGVfxYfua7hV6CW8CxW62fL6qva+iWzGt/F4nbh0
         9ErJuvwl6LWeSGf+KUpdWfQkdnEjYf9kCUu+e0/M2oMp+jcGoIf5HaHB5/JJevydo+HB
         gg5QCPQ5E48mVzcn5JCWjjCCs1O3gCJJUl4mysluEFcRTEoztuq561CJMrVs1qgH9K1q
         OYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4lxG4i/W0VPOuHmnraCVOc0VJCI5Izfgz6bdTPlXvIf/h3DXOBM/nZQt0mWgNFE258LEWIBaWABWsRUd0@vger.kernel.org, AJvYcCXYE7rcAUCo1ZQfcYlFnWnh3PMDX3c1cFxF+O6YGC25GRHnjSXBGRQxtu9UK+LGOVDGZJsG9X3Oj5Wkfif8@vger.kernel.org
X-Gm-Message-State: AOJu0YzsmTRmgagp0fXs1PdeDyaOvPVDZWjcxVR+4V/wB/nkS7HO6NCn
	wkHi5KPdd24cJnk3UAwA03q8tdCtzAqL91Y57PtVHdDZ9zpSA+X44KCN6UC4wF8=
X-Gm-Gg: ASbGncuZXwJH/Yd4go9bLsS7A/XkRyi2j3w41f5zAHtGFyMA1PGwDkDWe9sUtzrxxnC
	7oeqn2/09qgiV8LmlBr1CGlqQ2mjhN8KbtoVSray3eiPT9cnDrw2OolXTjaR+bJbEtX4Ac132wV
	PulooRZ4VKwnVBHvASlgbIlHY9b/9pBTZ1sCu/K8sG8LHVmPVsqiLSyYvSLZ1aHGW6baGhPx4om
	mZY9PnjhgRHFTOynJ0LbuEllbCC2za4n7pWlMgfP9PVc3Y9bDdY1jM91TpqbNpENEKRu8b94v/s
	yiYzA6HXXQQDudVrPv1k44eSsl3bXpHiO5/Hv0umBE5lPxjBLSnyMQ==
X-Google-Smtp-Source: AGHT+IEolASiqlYK/JFFz4j7e1J27pOf9s+NdDPw3bvSPvtfigBwTEE5MSLCkDSWQ26AUEo/9NVJgg==
X-Received: by 2002:a67:e7c4:0:b0:4bb:d7f0:6e65 with SMTP id ada2fe7eead31-4bc0351efd8mr3608845137.2.1739444750590;
        Thu, 13 Feb 2025 03:05:50 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bc077916dbsm146351137.6.2025.02.13.03.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 03:05:49 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8670fd79990so216223241.3;
        Thu, 13 Feb 2025 03:05:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/esfLHqfyoeFdaYZwzC2XxD9/GktugWPB8qOfwJ56+yPDP4l3NsKY25advCfUkTgcrC6IV9c1nACSI6Nu@vger.kernel.org, AJvYcCXzYxERYa0WUZ3LSYUHUK5GBCdgvP4g+S31zuk67CNY9RonMG/UMg7EiPK/BIvQXgf72qLlm5/+IBSRKCp8@vger.kernel.org
X-Received: by 2002:a05:6102:4191:b0:4bb:c76d:39ec with SMTP id
 ada2fe7eead31-4bc037ed546mr2901047137.21.1739444749243; Thu, 13 Feb 2025
 03:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213163659.414309-1-shikemeng@huaweicloud.com>
In-Reply-To: <20250213163659.414309-1-shikemeng@huaweicloud.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Feb 2025 12:05:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV6ekVdtzVxN6gCOUX5GzO08t+pouJuosfvGz7uRtgeeg@mail.gmail.com>
X-Gm-Features: AWEUYZnHf2rYoOMv80GeHY-uBNi4bTK5uU1XQydU8dNetDolpRg56K4qRZqIqP0
Message-ID: <CAMuHMdV6ekVdtzVxN6gCOUX5GzO08t+pouJuosfvGz7uRtgeeg@mail.gmail.com>
Subject: Re: [PATCH] test_xarray: fix failure in check_pause when
 CONFIG_XARRAY_MULTI is not defined
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kemeng,

On Thu, 13 Feb 2025 at 08:40, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> In case CONFIG_XARRAY_MULTI is not defined, xa_store_order can store a
> multi-index entry but xas_for_each can't tell sbiling entry from valid
> entry. So the check_pause failed when we store a multi-index entry and
> wish xas_for_each can handle it normally. Avoid to store multi-index
> entry when CONFIG_XARRAY_MULTI is disabled to fix the failure.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, this fixes the selftest on m68k/ARAnyM.

Closes: https://lore.kernel.org/r/CAMuHMdU_bfadUO=0OZ=AoQ9EAmQPA4wsLCBqohXR+QCeCKRn4A@mail.gmail.com
Fixes: c9ba5249ef8b080c ("Xarray: move forward index correctly in xas_pause()")
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

