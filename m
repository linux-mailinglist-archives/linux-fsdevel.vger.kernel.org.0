Return-Path: <linux-fsdevel+bounces-72865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A0AD03B80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0ACA43029827
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7763590CD;
	Thu,  8 Jan 2026 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4OcK0/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A6357A3A
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885158; cv=none; b=k0S2t8RFs3aNk8dSN3PoA2lbE3sTOOcHuR95XQhfPOC9DogevA+w+bXG6bm0SLX6rhp+mYpVapGfH7GWbMVbpXiqu2Qc4cjP73AL+vmMlpwusjgYDifmUto8UlYJYiuy7Tx2SalLTzFNszZ0cCSgpvMQFJ4F+JC5VNiKUkC9Yto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885158; c=relaxed/simple;
	bh=jtYdl2t6rzb7r+mbWvmvVNZ0lh3ErThLQjz03GiTx3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZnBHg4RI/JOoDZqBT2nxn3FOert9KwqAuTa//eklV+/7komN7Lud5QV0VbZjsRrsHu4na6LFhBWKeuzAssiyzESO9WVKvpFzmXSVSt6X750YeEvQ3ukXGyWXukz5Kwj3LN4L9xifqIApPEVe1pf7Sb26NVG/odOYfHl0VjUhR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4OcK0/o; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-65cf3d51c95so1775150eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 07:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767885154; x=1768489954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsGnYTzondw31+n75eOvnobuzn+cZ2qwJK8EEZW82L8=;
        b=S4OcK0/otuqnY9RP5vmuPvPLxSYvDPXV7oK9vImnWW3ZcP5fTRGXYM+82SMdngsyfm
         G6SWB09b1ToQNRSiRtj8sbDBqDAjVMqH/47CMuy+CVz1bHs88StJY8tsd9DtlMAGE/9B
         Qot0nTsB9ejWenTnQ3VDNaesQFHCmpXK1mjc2bqCSDXI2PvOzerXMSnW5leASmp+5Bzy
         lN7NLLU+iuc/HQ5/P6ia75VikGFeAW0AmU/5IN03FyXHVfVYEgPuP2AgoCisRhS5+Z06
         Yi8jFRX1KiWL111ONz6qbsPxyc67tw5+1NfJ+MZDZLxcQEpzxeIzTQTHxp8G4elKEgR+
         ZDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767885154; x=1768489954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nsGnYTzondw31+n75eOvnobuzn+cZ2qwJK8EEZW82L8=;
        b=k/Lsp2MRcwdm1qZNqL6k+qKK1gl/h5U/UYybo7om8C2Rkxrh3iBWW9j0RIQ7KDZmLX
         HelnUgnhfYuZ7hbBzXQ481e84p41CJnm5S4+CXZWvQv55yoLezftOfC8gn+87p2lHHQ/
         8KwmF+Tdw+WraA+f8MSFYAOTQ/ksFb+yjlaf2QvqPNRPK4JZsqHUfEAOoCZ7EDhTXRpE
         jaHYwop8bXnNsRXrxsm2+WYK767h37kl7KJjWLMEh3mvV4sMY4ADuJ7Pys4rrBtmMG+o
         BKVqVECUg17/5qPefci+gYbmkgDfXTrK8l03KcOb062pfR9pJx4hqmV239iKI6UVd3Sl
         CB7A==
X-Forwarded-Encrypted: i=1; AJvYcCVS3NzxB+4siz5RfisAl6RBNy0Fy0JS/oqRP/AebmcE0g7ZKFT41SqyplMpV4gKvaGpiN6+jNd8qm6ncBQJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTvTVUeQMOyTIaala5Zjx6d/GkHI3ow4VS5WMt9ubbHf96d68
	2fgstMIlph6mB0esQPNN8p+hI2n8g3O3dUyCoa6YxqpwaU26MLbCCH0r
X-Gm-Gg: AY/fxX71YvDMBR09U5OEgmca66d9ag6Ch/Dn6hzdNDpEyjbFcKBt3QOK1JwHZfgWRCA
	owXqPxO3kwM4xoDdFhDaRwUyydHndBQ/74lM8l+9PWHnRs8pPQVM95q25Y+123awBawGsaeHlFk
	QgF2WHsIDl60wjPQie56nS6P5ZL+i2yM+3uPALws7+R0afdUt92CmF/R+GYHYY51/ib4+DSo16d
	D1pBeLHOxyvFxOJxmzku/r6whlahMbTmUPh33kOTfVPQSkW+tBB1FNDkU0W3TrBDBI1HmweVMU2
	kMirxTUuZGm3R9Dt8vuaudQFZpda3udTjC/g2tIqp3aTkkMcDn4vzs3UUhqysNWLe+NP0h7Uk4y
	P8twnBlKGcqTwGJmDWxnlYTDM5lEn+DsJ9VS0rO+y9D+cBgP+WYztOvK2lKKgrV4Nd07hESX6Wp
	QVQPBe8+bC9fJwH/LjD2ecds4jYZDY0U5UWhoaEHyM
X-Google-Smtp-Source: AGHT+IFZyDwPdkeqNSyDSqdmsf84bOQBFu+dUs1b2EahO7yvP66QCwradMj+XO+4P5+KO3vwRZ/fdA==
X-Received: by 2002:a4a:d661:0:b0:65c:fb36:f232 with SMTP id 006d021491bc7-65f55082bd4mr1868554eaf.50.1767885153692;
        Thu, 08 Jan 2026 07:12:33 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:902b:954a:a912:b0f5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa50721a6sm5268922fac.10.2026.01.08.07.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 07:12:33 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 8 Jan 2026 09:12:31 -0600
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
Subject: Re: [PATCH V3 02/21] dax: add fsdev.c driver for fs-dax on character
 dax
Message-ID: <6ibgx5e2lnzjqln2yrdtdt3vordyoaktn4nhwe3ojxradhattg@eo2pdrlcdrt2>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-3-john@groves.net>
 <20260108113134.000040fd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108113134.000040fd@huawei.com>

On 26/01/08 11:31AM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:33:11 -0600
> John Groves <John@Groves.net> wrote:
> 
> > The new fsdev driver provides pages/folios initialized compatibly with
> > fsdax - normal rather than devdax-style refcounting, and starting out
> > with order-0 folios.
> > 
> > When fsdev binds to a daxdev, it is usually (always?) switching from the
> > devdax mode (device.c), which pre-initializes compound folios according
> > to its alignment. Fsdev uses fsdev_clear_folio_state() to switch the
> > folios into a fsdax-compatible state.
> > 
> > A side effect of this is that raw mmap doesn't (can't?) work on an fsdev
> > dax instance. Accordingly, The fsdev driver does not provide raw mmap -
> > devices must be put in 'devdax' mode (drivers/dax/device.c) to get raw
> > mmap capability.
> > 
> > In this commit is just the framework, which remaps pages/folios compatibly
> > with fsdax.
> > 
> > Enabling dax changes:
> > 
> > * bus.h: add DAXDRV_FSDEV_TYPE driver type
> > * bus.c: allow DAXDRV_FSDEV_TYPE drivers to bind to daxdevs
> > * dax.h: prototype inode_dax(), which fsdev needs
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Suggested-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: John Groves <john@groves.net>
> 
> > diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> > index d656e4c0eb84..491325d914a8 100644
> > --- a/drivers/dax/Kconfig
> > +++ b/drivers/dax/Kconfig
> > @@ -78,4 +78,21 @@ config DEV_DAX_KMEM
> >  
> >  	  Say N if unsure.
> >  
> > +config DEV_DAX_FS
> > +	tristate "FSDEV DAX: fs-dax compatible device driver"
> > +	depends on DEV_DAX
> > +	default DEV_DAX
> 
> What's the logic for the default? Generally I'd not expect a
> default for something new like this (so default of default == no)

My thinking is that this is harmless unless you use it, but if you
need it you need it. So defaulting to include the module seems
viable.

[ ... ]

John


