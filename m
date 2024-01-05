Return-Path: <linux-fsdevel+bounces-7444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D9C824FA1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 09:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC501F23970
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F121356;
	Fri,  5 Jan 2024 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwNM06PZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538920B29;
	Fri,  5 Jan 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d604b4b30so1537015e9.1;
        Fri, 05 Jan 2024 00:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704442828; x=1705047628; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UirpifrpW6YIRosDr0Ki+l8kjsuIejuWaHX21FvuZXo=;
        b=kwNM06PZJap/F/hq6cDd3/9e4mf8q16HbuxZEfDrYasfWHM1ar3BENGRDj1mbRnnl3
         F/qugWH8GA8d3jbB9fJ7CkSImbnIGgoPX2awJhAKJVlKf/9Z6ImYfSvFuGvvyDYBfl2k
         8imbrymeTOCgfYO/1vuzl/QEzU8C+R66JNjt7LLPl7Bv7vX32eApSBgyH07b9TQD3mSw
         1R5jvZPD4iIFVnKDJ1HPA3lqxoLvCnywOF9ZYGrc5p/UCGRMe8SnjAdJfGJuPuhvilnW
         dSOaPKQL9m4Dns6yItaMygiZYitM2uwmEGQ9CPZqPs+iYwO+2rgKNK5B7Uv0nsiba6ZF
         kWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704442828; x=1705047628;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UirpifrpW6YIRosDr0Ki+l8kjsuIejuWaHX21FvuZXo=;
        b=hxsl7IgTR8Fxrt+MlQ6WpS0aA3ZmCAN+vBh0fRK07Z7PAaO++WlJjYaltmuzXrobYv
         kvzVwYUW24YFCiZsZdXItDKK0sEVO2qCjj5xqxY1ipZzL7DAZsIQZDCfPSMZhnP4ZFSW
         i/dW76/dQng7Jz6iS1aEpuwSNGOWThp+60189kHLhKDDccTkRXRqhxADOlR3x2UHkQhx
         Wz5eAJzDzO0adYOHaThdZNaU1av6CB+VVoWVJY9IV6/YlwKzHd3RU1KQ7pkeZTe/k91+
         3S/7aHzZJg58GPe4OKMYZb/jVV1AcmXXVNyn+USxlDqMVvmZRnUxDuw0VrUTQzuY24Vp
         LmeQ==
X-Gm-Message-State: AOJu0YzmupXOIr08XptNYHj92un+/DWZNKxFSqYIozxjdI1CLZGVnfcK
	ivHmsG38hnt3j/T+HjX0SIY=
X-Google-Smtp-Source: AGHT+IHMgrGKGIkfpqwpUlWkD6o90yPervTOv/x0T4n2N+OmVuREFRfDKOS87FVN6VWMXcJ9sQ/Mcw==
X-Received: by 2002:a05:600c:5486:b0:40e:3538:a5c0 with SMTP id iv6-20020a05600c548600b0040e3538a5c0mr821797wmb.1.1704442827675;
        Fri, 05 Jan 2024 00:20:27 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id j26-20020a05600c1c1a00b0040e3804ea71sm806474wms.10.2024.01.05.00.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:20:26 -0800 (PST)
Date: Fri, 5 Jan 2024 09:20:23 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	baolu.lu@linux.intel.com, bhelgaas@google.com,
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
	iommu@lists.linux.dev, jernej.skrabec@gmail.com,
	jonathanh@nvidia.com, joro@8bytes.org,
	krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
	marcan@marcan.st, mhiramat@kernel.org, m.szyprowski@samsung.com,
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
	samuel@sholland.org, suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev, tj@kernel.org, tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com, wens@csie.org, will@kernel.org,
	yu-cheng.yu@intel.com, rientjes@google.com
Subject: Re: [PATCH v3 08/10] iommu/tegra-smmu: use page allocation function
 provided by iommu-pages.h
Message-ID: <ZZe7x-l3Lxwp-4kq@orome.fritz.box>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
 <20231226200205.562565-9-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8IeHlBnAmdcVLGIU"
Content-Disposition: inline
In-Reply-To: <20231226200205.562565-9-pasha.tatashin@soleen.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--8IeHlBnAmdcVLGIU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 08:02:03PM +0000, Pasha Tatashin wrote:
> Convert iommu/tegra-smmu.c to use the new page allocation functions
> provided in iommu-pages.h.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: David Rientjes <rientjes@google.com>
> ---
>  drivers/iommu/tegra-smmu.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--8IeHlBnAmdcVLGIU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmWXu8cACgkQ3SOs138+
s6HXkg//YOz2qzNPS3zbXb9R+gceE/gBdW73WaBVARCvXhhc5PWwWZctFyPH4Hf7
KDyc0njiNk3tDVY28wbWI3Ex8fbdkb+B8CUlZihhhRxtYaEUiHjkUK7cyR8i81Dq
pv2Bw67wRrXUthITgzpBOOqdeI+FpB/ch6GKIH0S13F/NpIwmLemg/u5THAgTAyw
IBi+44VeFWXKky8rT2s/rENv2JAhz5ltYql0CGxFEYhqiIunEb2eqDPgbfr8vLKv
2mvQmIOZsY04NO86V6eTKTM7+Ue5tzt+jHrMVr0gH/DkHkcmbOoPTn/lBsZ8IFi/
3nhtBB5ofmX/+80r6w9u/reWpqxUWyvRcJYsE06Nw/AAZN6IZM1ds+6bal1QJ8Zn
Cw+zagqq5Sqj2ah/tQ/W3rOzbs/XLMD0xLkRl7/kcjjOq+LfZFAzx3zqNyB3Vzlp
/q+60iAGtwkI04MSGlkKjVkHpIrtSKQFWXbnM79/c5GEevy4r/W2/d7k+phM0y/Y
GrblcAFFlQfSm4K19PEWARzu0mHOHFqIIcd6vfRONCuGFSAcmtvdB3KOfap5jP4H
ebZ1R6zDoreUq4hYVBSiRxYxmfDgRUyTQcOTDhEGy/JyteRgvKVhDwgPH+ql3OGS
wSPkv6/wg5Y8w2lR1QHCG/KXFjZ84iBLdT38/7QZqAR6hfMBGno=
=MX0T
-----END PGP SIGNATURE-----

--8IeHlBnAmdcVLGIU--

