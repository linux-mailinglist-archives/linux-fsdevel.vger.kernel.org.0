Return-Path: <linux-fsdevel+bounces-73175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C933D0F9BC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 19:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C773306026E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B62352929;
	Sun, 11 Jan 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F63BRgnI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3060734E746
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768157606; cv=none; b=IVhTCGeSl1pzrQiwuIrN1Wv8ws8nsImOuwIbaKkwX1zndrJ3wWa8gG1f+ZOlOxGJZnRrWhCPpCITDseadJ4FbyQ4YjuFp6DznqMpTGbWATM1lmVnf2JnoNLEfJJrH4gwJQJ5yS48k0FXVKY04dIeb8gm/p8nOE3MZ2Naq9phMjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768157606; c=relaxed/simple;
	bh=bjkXAEN8Y+D7IMRxZaq/hvH2dXf/omJq+KCOtFcy/ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpUDQ17rQqEMjrN+QbzZduIg39yiGZP7nXVhNB9q8U2RcAaa+4M9KtTYNrL2qiar8urhrcNPBMI2scYKBvUloDJfZRMyGPIaDnR1kMYrj/U2RYkUD1iK0TwosWIle6xcfFPDk7dDH/IrDjAHzr2ZOfsY7N8Dv8HZaRfBhzqgy24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F63BRgnI; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-3ec47e4c20eso3603670fac.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 10:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768157604; x=1768762404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTBNax6FoYZ8tcOGsMgyI0isYvrnMxJ74iIpUsR2X1Q=;
        b=F63BRgnI+OUmaOB+0+k1IxNZ3TWWLFmBQlF7fxrgy6Znr2JbqRJG3Kblt1RQxBBzql
         PCYWGSFEtrqc+luf+2yh1ZrIlGwgkK+aeMUL0iWTEHZy0iQq82WqHCdBMuqOLctTZRbw
         8hfPztQY3xwKs0a3QyBmF9wtKfW6k+IYhltm2JMhk/Mm9UeT6BLOQ0VRy0pgPyAHV6TM
         GuCt4hDnLTewylGhWscOFSylfWBkMTgTC69xcSYsEF94qOdK3E4Jm0R/Vb4XQIXwqdTj
         pyOay13vf52fwuAX5UT/iavS70M8CEWbgqu2EBm2piRf8NX6Ek5ibiSC5vV/curN9Is/
         jBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768157604; x=1768762404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vTBNax6FoYZ8tcOGsMgyI0isYvrnMxJ74iIpUsR2X1Q=;
        b=G4Q7EgTghAy4zIgEsvMScdS5vmQELzS+iKjmQqfWJWNcGhs4WDOXsx6UpLwutuhllK
         ER5PIWZ+MV7mk8QprhbLYMZhc/lwrimFlvRVTiO88cN/f8XwQhegDuLPj4pAIF7Wa8FF
         cLnQQ+CJVXCMV5UM3wsz0U9dAUczGXlyZz0Gs43m6SGoItNtQ/pujdIrvgpvSzOcM20R
         Wu5SbmHvtWzmmDebmzR/J4mb/ET46wU0iLciJi0Ep183ox8HS8hWUQCqS/nKGgKrqIe4
         QI1fi/G/iX1mdGsOvXh3O7oM1gCOz/yNkPcS9U22f4ynLNf1j4h1aocGJ2GWLZQT6eui
         P7EA==
X-Forwarded-Encrypted: i=1; AJvYcCVAE1t3a0dQS6l+E/8JCM+YrsqTQXcuC2Asrj+E/EWG0F+OyOx7Jj58/P94ay+iH7e2rann7GIANmVHRIW/@vger.kernel.org
X-Gm-Message-State: AOJu0YyJxskMlhg4dQmVEiWfxAdSE9pyRobgK2pxadKEatbX5b6IqkR+
	wCHF2T/v0ddRGZIHRlpzqOet6mW0ux2TyVLg0TWDbb5V2YzALrgvLmfV
X-Gm-Gg: AY/fxX66JG658XS1xdH2O/NIHsxi9Fk+/AGXLibF6sMkjVPyMNb+5y1LyrYsSPwVzaj
	v8e3VWOAWSF4SWRYgjFFtvCDXjYrsGsMrXWmDh5Yt67aeqRSQVf67xd+NzTLjyBh3a41p0WJ6iR
	EhN4uGOdZOXalwdx1SLSdPiv/u4OoKOSXBq2qRB1mgWfjCSmzN1lE9yQv/LBXH2DY3vUTvt4ss/
	0QYZntfhpnC7bG0ROZDoprj8ybsOMxNNkJ7/bXXfoNxTxdWFsWOd6Yrj6uTIfmpGg8npSxhEzW8
	FUQeI43+MCIiMCRNtwJB1vA3P/M5dZLalwZPXyLjnPTMvpfq9uqyjYsdEoVL8pzaf0aMmNmdz/+
	iY8ZLWDetDXJD9cYsVFQ5o0VnniSjkjpHiFRd+FfQD1LfwO7j0L2MXdOQPtYtMkI1qql45Xl9FW
	fev0KtxIqgkBF1U/ohb7YJQXTwrCwE6ccx2Zw3X9V/
X-Google-Smtp-Source: AGHT+IFCDAYjOU7Tv/QzCofEX4QjQQf7VTkE0/1bWiSzEnwsQJCLaG0COOECS73BVhT6La3jE2HlAQ==
X-Received: by 2002:a05:6870:b525:b0:3d3:5ea0:5dd3 with SMTP id 586e51a60fabf-3ffc08f67c1mr8587303fac.10.1768157603977;
        Sun, 11 Jan 2026 10:53:23 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:cc0c:a1b0:fd82:1d57])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa516150fsm10835406fac.20.2026.01.11.10.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 10:53:23 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sun, 11 Jan 2026 12:53:20 -0600
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
Subject: Re: [PATCH V3 21/21] famfs_fuse: Add documentation
Message-ID: <2v2f3kfrbjolx3gaeo3273beah4msor6vpojusrf5ekd4rg7rf@tgnvcuxh3sgo>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-22-john@groves.net>
 <20260108152713.00001b42@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108152713.00001b42@huawei.com>

On 26/01/08 03:27PM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:33:30 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Add Documentation/filesystems/famfs.rst and update MAINTAINERS
> > 
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  Documentation/filesystems/famfs.rst | 142 ++++++++++++++++++++++++++++
> >  Documentation/filesystems/index.rst |   1 +
> >  MAINTAINERS                         |   1 +
> >  3 files changed, 144 insertions(+)
> >  create mode 100644 Documentation/filesystems/famfs.rst
> > 
> > diff --git a/Documentation/filesystems/famfs.rst b/Documentation/filesystems/famfs.rst
> > new file mode 100644
> > index 000000000000..0d3c9ba9b7a8
> > --- /dev/null
> > +++ b/Documentation/filesystems/famfs.rst
> 
> > +Principles of Operation
> > +=======================
> ....
> > +When an app accesses a data object in a famfs file, there is no page cache
> > +involvement. The CPU cache is loaded directly from the shared memory. In
> > +some use cases, this is an enormous reduction read amplification compared
> > +to loading an entire page into the page cache.
> > +
> Trivial but this double blank line seems inconsistent.
> I don't mind if it's one or two, but do the same everywhere.

This doc is identical to the the previous series, becuase I kept the Reviewed-by
and Tested-by tags from Randy. I'm happy to remove the extra blank line if he
or somebody from the doc team thinks I should.

> 
> > +
> > +Famfs is Not a Conventional File System
> > +---------------------------------------
> 
> Nice doc.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks Jonathan!

John


