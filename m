Return-Path: <linux-fsdevel+bounces-73094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D79D0C3A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 22:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F32A43035AAE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 21:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B10D2F39C2;
	Fri,  9 Jan 2026 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyjCfkll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A1E17A2F6
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992425; cv=none; b=cFMMwoX9bSEMjbnk2EvPKt/AqjiEernGwCwWflrJjjpMo65TB/5GYnkCQJDHJDBvwjbWeF7i8TAjijs08wS6wafStAhMYL3W3ZoCEBjDGURTPG942XcAmnID86efCYsuxmLb9geepBcwL9+WrtvmttsBvIi9zaQQWWfhB18iUK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992425; c=relaxed/simple;
	bh=Lnqx2IsjK6GGMeXoPLfF8Q/0waslPMIHDLq8xmDBOWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vERo6WEfHPO83w8pGn5VZEdbDPqptbT38KK1URxPJsiFLsAzUurAzLEJakz+8a/dbTtfNaZKmn2qRwSvIvMTobvbbwgN8NhbpIQtPjL+gHKN05SVzEyGZe8qDQvHB7jWjyYg6REfCVrcwcgR35AJPyE0lmIpV1/jphYrN35Hlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyjCfkll; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4557e6303a5so1520962b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 13:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767992422; x=1768597222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4M8PfdySXBuLCXo+RLzMIyIY7QrHbUdCMkagyIMvnE=;
        b=OyjCfkllnk+dEHpzz5FgtnAg7Rkugxv9vFlk9Td+hwLC/lC9XD81dUV8Ck/s44Q+F5
         O67jGoBUxpwFFf1aA1UM6vRAbXBlsFY6upEMpt+oUAM6ydKFLgeBwpbqZaA1Ozk9UGqe
         ehhsz9V0MqF9pMp68ica4oBkLLp2W3kugI5lxD5dqKX1jxNszCVYiBNET51866YKKbuc
         mnxUIJq+NAB6J+cFgQenzIOb0U+vt+1FkCgFYaidGJTOUUMKACxjpQh19liPw5wZkJxp
         OfrEnlrJoyCVLAL0Uvz50jfPZwRR5QlzRQ+CwaEKAKlWy2kbTgc5KBagYVP/MJ88x9+l
         fqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767992422; x=1768597222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v4M8PfdySXBuLCXo+RLzMIyIY7QrHbUdCMkagyIMvnE=;
        b=FmIMK25CvUWp2Rn2HnksOwtVFNnfhdqJR1iS0lf31v/PBl6PDbe+cwzENW8YeGCSeX
         7PtbUmI2iB5ycrXnq6xYeBVt6ty200uMFD7LZAj4Dh+2n+d2fQBNYkZ+6h1oA7Qd4scn
         i6vnxNASckLGeYmhj+bP2eOUXzTjC1fslLa+k6V8764IGm5FrW9xUGXpUwEcl8m3oYXE
         zejVtuzqaHFJPu21AThMWuWfHVGEUP6I5vWktNNB+OgEuw64ZU8r0CvJQHDoJJ2+AkXn
         xm48qurBWNiYDZHw/c6f3DM7Uqd63d8cpt5RHw5KWzV3RmN6iU+BYrNWzR7I5eTJMVNE
         iUJg==
X-Forwarded-Encrypted: i=1; AJvYcCUIj5oxvYBtxgAeuVctTQZBmZWrbsKMZ0P7WBUykpfMkkFmWwUvyox9cPaPOpZY7vFdYoXnBWbtpTL5x6XM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyuuo9tHJOr/jPct9UpM356ct5jPbksnc94jd+jPe4mf9+1E2d
	k/Oxm/67XVO2OMrjnLmN25YfFO1P4dXEpj+z8dcfMlNwY7GUNAZs9Izp
X-Gm-Gg: AY/fxX6Z2mKXwbXKb5WMRyDkPJnHdkT4MwWcAVyRk7szscvOkPC5ZBaNPGdiYPhDVUn
	stUkTVZbEZN5I26asJTFU5mSt9Qs7ZP2Ve8VJDuHkQX9bvJ7O1h6vor+JbgRcX3wYc5+ibXpGww
	+BLVDMzgwCDpYZzKjHmr3bWqW9J+G00Bc+kbq+G0UD3fX0ePmVHs5MDutSsYaGnyLiAXWK6iP8N
	L8wDsqsuaLKodhy8Z6msyNqrjDvdmqPNbtD5D62Y+6mTf/bvNr5+MaZ2h9i1PewpicL9NW2x3Yr
	exOnfdArgx3l5vriqoUd5p1yl4VgMyCrDCEhylXLHOOajckcVeAzvxje1c50k68jz0o14EHh8uL
	mwCM04trJWClUTyrAu/HEtq+NFOc9YeZ+WRJYn/1RNtawukURPaELDaoeRbfIUDtAo+8Ne6Zcc4
	2aXw3e1gQpN4xyeGijr6W8oySyAX2+gA==
X-Google-Smtp-Source: AGHT+IGxLlZof8Jy1wQwdG6wIDxdZkGz6jddwYKP+0ZxEiU+0KGp2+NJH27YNyDn7lRSc6+JT5iBCA==
X-Received: by 2002:a05:6808:c1a9:b0:442:522:41a3 with SMTP id 5614622812f47-45a6becae03mr5521861b6e.60.1767992422011;
        Fri, 09 Jan 2026 13:00:22 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:184d:823f:1f40:e229])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e288bc7sm5503964b6e.12.2026.01.09.13.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:00:21 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 9 Jan 2026 15:00:19 -0600
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
Subject: Re: [PATCH V3 18/21] famfs_fuse: Add holder_operations for dax
 notify_failure()
Message-ID: <bonriy66ocy6plo66nryagupftobhlnzjr235fukdx7d6vdyku@gzmq25kktdrb>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-19-john@groves.net>
 <20260108151733.00005f6e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108151733.00005f6e@huawei.com>

On 26/01/08 03:17PM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:33:27 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Memory errors are at least somewhat more likely on disaggregated memory
> > than on-board memory. This commit registers to be notified by fsdev_dax
> > in the event that a memory failure is detected.
> > 
> > When a file access resolves to a daxdev with memory errors, it will fail
> > with an appropriate error.
> > 
> > If a daxdev failed fs_dax_get(), we set dd->dax_err. If a daxdev called
> > our notify_failure(), set dd->error. When any of the above happens, set
> > (file)->error and stop allowing access.
> > 
> > In general, the recovery from memory errors is to unmount the file
> > system and re-initialize the memory, but there may be usable degraded
> > modes of operation - particularly in the future when famfs supports
> > file systems backed by more than one daxdev. In those cases,
> > accessing data that is on a working daxdev can still work.
> > 
> > For now, return errors for any file that has encountered a memory or dax
> > error.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/famfs.c       | 115 +++++++++++++++++++++++++++++++++++++++---
> >  fs/fuse/famfs_kfmap.h |   3 +-
> >  2 files changed, 109 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> > index c02b14789c6e..4eb87c5c628e 100644
> > --- a/fs/fuse/famfs.c
> > +++ b/fs/fuse/famfs.c
> 
> > @@ -254,6 +288,38 @@ famfs_update_daxdev_table(
> >  	return 0;
> >  }
> >  
> > +static void
> > +famfs_set_daxdev_err(
> > +	struct fuse_conn *fc,
> > +	struct dax_device *dax_devp)
> > +{
> > +	int i;
> > +
> > +	/* Gotta search the list by dax_devp;
> > +	 * read lock because we're not adding or removing daxdev entries
> > +	 */
> > +	down_read(&fc->famfs_devlist_sem);
> 
> Use a guard()

Done

> 
> > +	for (i = 0; i < fc->dax_devlist->nslots; i++) {
> > +		if (fc->dax_devlist->devlist[i].valid) {
> > +			struct famfs_daxdev *dd = &fc->dax_devlist->devlist[i];
> > +
> > +			if (dd->devp != dax_devp)
> > +				continue;
> > +
> > +			dd->error = true;
> > +			up_read(&fc->famfs_devlist_sem);
> > +
> > +			pr_err("%s: memory error on daxdev %s (%d)\n",
> > +			       __func__, dd->name, i);
> > +			goto done;
> > +		}
> > +	}
> > +	up_read(&fc->famfs_devlist_sem);
> > +	pr_err("%s: memory err on unrecognized daxdev\n", __func__);
> > +
> > +done:
> 
> If this isn't getting more interesting, just return above.

Right - simplified.

> 
> > +}
> > +
> >  /***************************************************************************/
> >  
> >  void
> > @@ -611,6 +677,26 @@ famfs_file_init_dax(
> >  
> >  static ssize_t famfs_file_bad(struct inode *inode);
> >  
> > +static int famfs_dax_err(struct famfs_daxdev *dd)
> 
> I'd introduce this earlier in the series to reduce need
> to refactor below.

Will mull that over when I further mull the helpers in fuse_i.h that are
hard to rebase...

> 
> > +{
> > +	if (!dd->valid) {
> > +		pr_err("%s: daxdev=%s invalid\n",
> > +		       __func__, dd->name);
> > +		return -EIO;
> > +	}
> > +	if (dd->dax_err) {
> > +		pr_err("%s: daxdev=%s dax_err\n",
> > +		       __func__, dd->name);
> > +		return -EIO;
> > +	}
> > +	if (dd->error) {
> > +		pr_err("%s: daxdev=%s memory error\n",
> > +		       __func__, dd->name);
> > +		return -EHWPOISON;
> > +	}
> > +	return 0;
> > +}
> 
> ...
> 
> > @@ -966,7 +1064,8 @@ famfs_file_bad(struct inode *inode)
> >  		return -EIO;
> >  	}
> >  	if (meta->error) {
> > -		pr_debug("%s: previously detected metadata errors\n", __func__);
> > +		pr_debug("%s: previously detected metadata errors\n",
> > +			 __func__);
> 
> Spurious change.

Derp. Reverted out

Thanks Jonathan


