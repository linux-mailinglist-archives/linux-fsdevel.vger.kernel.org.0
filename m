Return-Path: <linux-fsdevel+bounces-73098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F37AD0C803
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 23:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6772D3017F95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 22:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DF0346ACC;
	Fri,  9 Jan 2026 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN4cMneL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF8344054
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767999505; cv=none; b=W17oQbNEYzZN3BJLn8sC5VddxcU/0csGn4Iqo6RVfVDMdHRChG6yavX52MT3UlkOyl7t4OaLnYajCwFPnWqB9fOJZzuboF9xKNIew2aq2WVaedz8CpG/rNDZ5zmeyJSCjqzPk8pGFTdl3qdRD4nPGtvxzs8Y3y/oKfCyUKByNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767999505; c=relaxed/simple;
	bh=bfOlHfz2d97lpJdcssjhFC6DH34X+brsAi4ooodTEnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvM0tsa8BwJcTyWGCH+LmbByJCnvYGWYwGh+Sk+N5v/ic/u0oe9wKQBYb9SSgSmlMUgkkef24Aj2DLEqvdBu/ZJvigBhASTHuKS7+ZKgmhT0jpRnBg2z63u9NKYQngFn+OthY98Bz9SB5ctrGO8VK6GgFSvQw2ScYqjGDy5gGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JN4cMneL; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6598413b604so2959193eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 14:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767999502; x=1768604302; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jl0CYGdZkEy3SnbyPzW+uVfkekcUJUWsyBrwQPbpYso=;
        b=JN4cMneLWjZYBMVHZUIoTS2mTqDSWHaf9xegQX4oeP0pZhFpnLjlSM/9a8akGQ4Eq3
         U8f31ZB1jld4XlNQQJJd/lQF1xhz/gZs5YpBwoAgWMvRQ5Hgp5Tc55RGMhXNKmA4JE+r
         oqXphrVBH2q5nZkQyt96vNZjdMrPAfesW/yiXyYVutXqVpXF1Xn94oZDvHeJAWSA36Ot
         yO4iSzQZ5KZX5eGdfkipxwXIjRHyXq5eh+dgxIx+91MrpYYweUHgJrDWgUDxtAyvCZF7
         RJENFEfMP4v4mrCMc1nbDwWzSHcSoIGZxrD2haCAFKwIle3KkFVmRya9s5eFddfmh9D4
         4rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767999502; x=1768604302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl0CYGdZkEy3SnbyPzW+uVfkekcUJUWsyBrwQPbpYso=;
        b=egRSJIgh/h6PyYop6KqxoJiIt1xmdMtQzHDEuW9+XUf+YksfMqd6OhOanEqBOKWGly
         HGxeNRIwr8bqJ7Tbk/4EBK4SdlmgcpP+9tMiCehg94yJj0v41v61UbuGp+XkMI6PqEyX
         QCp5AAH33y0N5V4Rqft3Mk92lWU1yqwuD5mbem0Uf8LhDlVnutu7YNTJX/AelbSTGnZD
         ZFrCiS6Oy6+hMvVo8aSv1DlV+coffxhng1VdGyBBcwrKOLmT0pwodpW6/e3ZsP2t9962
         wHEN9y4Faed/7ecF9bBKuQ6OAoN5ouVyIltWJw7B7wpZ9GcGzJOqYtZfUDuPSlaGyExO
         +bYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgrVJv7hxGggcETiJZZhj1+EWZjVtY+ZZEx3WO907x4f94c5iO4Nu7z+11XI9gI2MDYm6AhL+F3p3M5y7l@vger.kernel.org
X-Gm-Message-State: AOJu0YyaA7QvtiIJP7sM0BWX3zEdwpKFUpS5ne+JcEloNzeIxyaLlTBS
	ZrrNUl7KhLLSpV4kqeRG/wqChN4kk4DU8lW+Kxjv7lCRVw8w+l7OTyNj
X-Gm-Gg: AY/fxX6ajJb5hFl8Fvly9YmVsN9qwh2MxwP39UomYZI6tfTAICrIsHv9/hlwBjfz/Ge
	ScALSXz89QdcBCKS5gJ5dWpV/60pff3UX0i35jJbf/DIWCfCftvjADEYEuf+SgHX/Agaj2HDXob
	EG9jkxahmBI6jARUULAjqZU/u5OQYafAzd5ZyZIhUrixGIn+8w8Nqh3MZRQAj1yKKiuQvNiyWPO
	oeKOqcaCpTrguX3ORdnuN3qMwuV3lKXpnGmpU9IRwpPDly0oaCTU9M1R3mShacAk/QC9ob2Ok+y
	xLhmavLvGqChPTFoiqbj7Zk5+XISaBtv3pJhpQjiIgJdA0RyV1ltvm5GeXYbBAQ3RvwlkAm1lWx
	WEbY3E/7v/Hd8qrX4mR5W+d9EpK8zPsN3LtioEGcGudjTvwkx5en+4THwK+HwOpTuW59gbgGzqy
	1i9AkEbstuyfi1+G2a111gg+4Rzv3xKg==
X-Google-Smtp-Source: AGHT+IGcrXJh4xfE4lkfSVHPI8XEPFwP3dHD2B/pDcAOyuoAiez1IjT5czUxIie9qoy4hzIPDogU5Q==
X-Received: by 2002:a05:6820:3013:b0:65f:564f:34b1 with SMTP id 006d021491bc7-65f564f373dmr4235710eaf.16.1767999501751;
        Fri, 09 Jan 2026 14:58:21 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:184d:823f:1f40:e229])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ccff66sm4496483eaf.16.2026.01.09.14.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 14:58:21 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 9 Jan 2026 16:58:18 -0600
From: John Groves <John@groves.net>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 12/21] famfs_fuse: Basic fuse kernel ABI enablement
 for famfs
Message-ID: <hhqgn4n5mnr2onutmn4pri7gaaavl56op6amsdsqwlaggsi63f@pombhppmc2l2>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-13-john@groves.net>
 <CAJnrk1ZcY3R-iL2jNU3CYsrWBDY4phHM3ujtZybpYH2hZGpxCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZcY3R-iL2jNU3CYsrWBDY4phHM3ujtZybpYH2hZGpxCA@mail.gmail.com>

On 26/01/09 10:29AM, Joanne Koong wrote:
> On Wed, Jan 7, 2026 at 7:34 AM John Groves <John@groves.net> wrote:
> >
> > * FUSE_DAX_FMAP flag in INIT request/reply
> >
> > * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
> >   famfs-enabled connection
> >
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/fuse_i.h          | 3 +++
> >  fs/fuse/inode.c           | 6 ++++++
> >  include/uapi/linux/fuse.h | 5 +++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index c13e1f9a2f12..5e2c93433823 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -240,6 +240,9 @@
> >   *  - add FUSE_COPY_FILE_RANGE_64
> >   *  - add struct fuse_copy_file_range_out
> >   *  - add FUSE_NOTIFY_PRUNE
> > + *
> > + *  7.46
> > + *    - Add FUSE_DAX_FMAP capability - ability to handle in-kernel fsdax maps
> 
> very minor nit: the extra spacing before this line (and subsequent
> lines in later patches) should be removed
> 
> >   */
> >
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks Joanne - fixed!

John


