Return-Path: <linux-fsdevel+bounces-73277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B18D14294
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 231283059699
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5BC36B07D;
	Mon, 12 Jan 2026 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVNtrd9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDB30DECC
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236417; cv=none; b=TmweZo71brVIe3I52gs2PmXJb/G/2/S31xR2KLiTPh00lLknXB+4zm3lMZYWE2EYJLTYuc58XnPDFAYDNBvtLpesFNlTck434Y3k7F6Xvao/NWDmih1JRSTUDmI8xSn/jvO+RHT1WJ2qSGIWhpiskdpxht2TL6eYWAUwy3QQP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236417; c=relaxed/simple;
	bh=8lgp9tnyFzGocHb8jl6w1NG/N7Zcs3J+oUbbLZskDQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du9zBdpFGlxbrRI4rfTe94p/GoKr1c+iCoNjee5WlTMbGvJIEaw1xJE68np3L90eCm4ndjcutJ9z12S/CdkO+XiWwIhRW96cpflhhQsjCLUlrmdQPxnyYBs0hYogRjBfT9fGqz9lUvNOlfSi1DRhOSo1BeWq/dhuNZbj9tOUilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVNtrd9w; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6dbdaced8so5498955a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 08:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768236405; x=1768841205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6deLDrT44WMlKVvRfzJXPGGgj/xg0j1HG9++H6LUz0=;
        b=FVNtrd9wO5lp/y8ML5TJtEg2LVNoKpMuvXUTY8BKHqCPebt7zyvkOdNSz2l9+PqKFo
         g1dosaCKVbNh7nUAtxpC2VtVFARScgjWXE5Pz+6Uo/4nrd/IExc7v7gWNOC22kbRMvAU
         U36Y+xhtUulxquh0ORokEYUGuGNP+XSQOzgVwv9S9ON1yGVWuBmbCV7ALcPPYMWtjDwP
         sNHUg7roftqLGiWVbgqkQVdPdaZMytBn4QK+AXfgkuR72v2is+0n0Gcco/vlTwyt/XVd
         EelSYEx3zxMxi1BNWTzDtUiWRxiu+YdbC+09h3mMg5fQItDlIRyxROasaNCaV6pVlHwE
         Gj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768236405; x=1768841205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n6deLDrT44WMlKVvRfzJXPGGgj/xg0j1HG9++H6LUz0=;
        b=VBJsOqVUISgVnlztFGv0NRcPE3KGbN+XBX4GxsxFUpjdI3UdaEhYnUDyuHuj766pIq
         yHRVUd2HhjBp5+Ym1IXzCEXFvzzF4Z3iXXRTNIIc9XuryrUnobvgwKa8MIwWyow6Ly+6
         24v0f3tCRrAaWaRP1FQ74pp0PjTfrI4H7856mYfTuLUXS+R2DsC2RtfjDGQDPZ4kwX74
         C7LG+8QTx3zB1fqDd2rTw36xojBydstH7ePQn1z/HzaqqfUFgrtEPldIZ5MwiceHjHp7
         az2d0pcJEyuvVJNLUVjcJIdwsGMNnjLcVYMY9aTpbkjAQIhxixpphEtA6EhSI1m1MKfM
         X3jw==
X-Forwarded-Encrypted: i=1; AJvYcCXMg756aqWxCNgRga+Mop3jCKmgy6vU58wfTSI//cYHGk3Px+f3DntH5ncQZ5gqcbV0ZIO2dINTpMGYKomB@vger.kernel.org
X-Gm-Message-State: AOJu0YzVfQETrKjqlPmnx0sWsR21LV5epZzsX8WlPQhuVTx4Vs+iz/lu
	RZ5YhCaFLTQFWJrh7qUyo43sB+TyC8nuaN+s//nQF1igQJowHnds+PTI
X-Gm-Gg: AY/fxX4BLLQAw2FoZnytoMoTk4kO54H40vF6PgpaL3RwaGyK1+lgqagITvrE6RhmpqR
	JfCZWt9aG9T6ZrYBKYTxo7pncfuDUQVG+M0/GwADeRTlPjtLgf32NpQcd5/u2kGZENRO0KEGURH
	a425JqKsZxsDxVYvshr4mZb+6bfokuaC4PUgkJ42vI9COUWqlaBB2at/kxUmvuxqvEsFemIi+35
	ujHGjPHLSa9WOzvPfhMglqvFfhoE6fCnkJO+5d8YqdPIV5oasx5QF59DxSZIf5nnhM6h9H5s6pm
	7sjWroNFR/nAiQZdxO/xgokr/ZfCjLa91f+FpTbIAGY4OnNIhf5DMYOppxTifzPAQtY9Ar2A1Lm
	8Isj6t4KDAYcQ2yPmwngmVuh3fxcegvwA16fFfGspY9au1ZNkYNKBS8k7CaISdr+mP9tKWYPQbW
	ReD7rYxqMX7b3GK6HK9lSAUdQeDzoKyw==
X-Google-Smtp-Source: AGHT+IGkPS/NCs2Mk5Oq2bbD5I5Nrr2IjEdlrsoDxvBDNYRoKgitfj+LmMDnnes+e1yquAKJv+M8AA==
X-Received: by 2002:a05:6830:2e07:b0:7cb:1270:1255 with SMTP id 46e09a7af769-7ce50932573mr13073106a34.16.1768236405392;
        Mon, 12 Jan 2026 08:46:45 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:b02d:f13b:7588:7191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4781c286sm14241471a34.8.2026.01.12.08.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:46:45 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 12 Jan 2026 10:46:42 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 10/21] famfs_fuse: Kconfig
Message-ID: <26sfkgpuqdle2nmj4kcv7j2bgnrlpfo3wglfzqiuagjucnufx5@b4ggxnalmcwr>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-11-john@groves.net>
 <20260108123638.0000442e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108123638.0000442e@huawei.com>

On 26/01/08 12:36PM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:33:19 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Add FUSE_FAMFS_DAX config parameter, to control compilation of famfs
> > within fuse.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> 
> A separate commit for this doesn't obviously add anything over combining
> it with first place the CONFIG_xxx is used.
> 
> Maybe it's a convention for fs/fuse though. If it is ignore me.

I've squashed this into the first commit that uses FUSE_FAMFS_DAX,
which is 2 commits later...

Thanks,
John


