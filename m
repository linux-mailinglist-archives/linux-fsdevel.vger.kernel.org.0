Return-Path: <linux-fsdevel+bounces-72860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D59E2D03E7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EF963228FF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D529438B65F;
	Thu,  8 Jan 2026 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQpYH1dj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44766227EA8
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882737; cv=none; b=B6aLRzEKn/g6kkEkpi84QkA3NYOftEdnsVlIH78GNx51ofoNMeouXglT6m36s2TP46rGcZK6dkQebIzqZnRQuAVj/p4fAo4IuMztgRFAc0aw3XF13vO+GStMRZnMtWMtVSHhlM3uFbVuz7fPQTChLDo+KpXMWOviCh7srrum9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882737; c=relaxed/simple;
	bh=pbqRtzJmnFz7qVgaziGfd6jJfZ3vd7LYJHqTLJj2IT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqnmwKhdThEURoMV/EF1le7UJ1Ejed3mEpjMuXZKO+oVqBjUq4HaWmiLxowhwWJyB3R57iggFa/FHUVP60hBZAgjGMVVcksTxnWsCn/0m5IPEJlwPhgL+tYk05woFbX3VTHiqaiblMyeuTuVXu92p2nP8GKV5Qw+zkaxX/XKDiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQpYH1dj; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c7613db390so1920169a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 06:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767882732; x=1768487532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcvhJVMJSLcgThl24zmnCju/8c8u6/w/mgJ2Q9NyyaM=;
        b=YQpYH1djGTXIfWUC3rwfwUFGL+i6HHr81p7AjWRXKQjy1LsyDRutUnCOJT9kyzX7Bx
         +IN/1yda815Lxkaj1PwX4L58I07FoHCjOrDkEi1TfCUFx1qCbxY5Dre61UzLeaOolaUz
         S3RYw2o+yVt8XDs73fzsoE8dBVo19xhIUkU35+KA2kX7l/piVtmaGK6qlHjr1D2UndHj
         H72BZZtTfQqNMJmBQWlSKGdkpqO0quA6//Jcl2Tjw6mEOijirgqu2/72MccFjzwuRXYH
         0rGlp/6+S3A63TnTji5BJsu0U8s2WGIXyaVcz4HWbGeykUIrd8MUQgLYxQZq4TcnkICS
         phGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767882732; x=1768487532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PcvhJVMJSLcgThl24zmnCju/8c8u6/w/mgJ2Q9NyyaM=;
        b=C+obe4sWSMOeCd7RIihaLrHsPFTsR5R/9QSQUfJkHSdRBZswerkmvG1KNxVxjJpoYj
         3f9gPAJVDKVk7nLaAg5+vK3h25pqDJzmINjZIxTJ8RJBS875woaKqmN2JnwJHQ1ylDTb
         yUGMLlhKskxfGzTNs1/W+h4Fpb17aK7lOUYrINo5gq+UDVonZRT9mNNIhuXWbpu6t7/y
         qm/Y2mN7htBWPlBpbydcRmr1swSVK+h4wPYRryVyp6q62dh+sKQSR0bKHaeZdMnJFxkM
         OW2d/CSmoBefm7upW2KD3Kr+qyayMtyZq5ROU4/VyXAMNVF6U5JOrAm13kBIN3aSaRaU
         Gu5A==
X-Forwarded-Encrypted: i=1; AJvYcCV/IcZiIsLE/9q0dVcg2H9KKhfggWO2lGV1fjSYze1YBuVY9w93I7v/8A/Zly65qEJGuyl2T5VVSvNzn2tS@vger.kernel.org
X-Gm-Message-State: AOJu0YyavdtZEdRnX2cip21rvtMaiC6i1slYQh3xfyq/Z5yTSWupDM1A
	zX8iTzCnPHbrcGThCOMR4is/DTr/j2k38i42Pa9gGYJHTv2Q7WuBnN7o
X-Gm-Gg: AY/fxX6jSqhMtmbcV5GDdRLaOWNBLj1BEmW0Tc4fPChoKWYh2crvpOPXXX/8cLJJCS6
	fLN2LEY0Ilo5yBPFFZ9hYWdAbjraFrIsHXjSCDAPCRmIxp5OlQz1t4j3pWgpdiP0lqp0k/PU9WV
	R1zu4FfwUixWNHW91VOVhWUITs3Oq7hKR6aOsg+L0nxKTKf548upRl9u566+uP1m1lDzegZ++/b
	Mwz7eRnByeJ7GDP51Ya6I37FYnYo8XqEQViJ8w4JuwcbqJKArlzKMIa8UfB6k+uT2P54ZMSSdlh
	kEGh5YS05agL/zv8hnqdw7xsIBjatP8C+P0LX+g9MQN+0KJEqE3FiHwP0/47FFsHLyOl1xLZR0R
	H65Vlab5iWi2OfKmUhpBJD/X5hjPCmo0bB7+YsNQO3IAgO032VgbcfMgZlDSmy7IG7DMWXVWbi1
	U72CIOZ1mltgk5ZdnbIf6CQ0bJHbyCTL/3lwhlgIOv
X-Google-Smtp-Source: AGHT+IEHvfV1Iw8iN3fDKTIAumG7RfgWLKSt/fkw13rZiQStoTVjQFDK3t+UOB8hh2x7AAzrKmk9bg==
X-Received: by 2002:a4a:cb1a:0:b0:65f:5be8:285f with SMTP id 006d021491bc7-65f5be8290emr1186453eaf.37.1767882731888;
        Thu, 08 Jan 2026 06:32:11 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:902b:954a:a912:b0f5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48bec1c4sm3254651eaf.8.2026.01.08.06.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:32:11 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 8 Jan 2026 08:32:09 -0600
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
Message-ID: <ypbz735oinozgm5bsxk7gyzgjpfpzzeb3k4f2fxq5ogm3hthb2@ict4rjvogy25>
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
> 
> > +	help
> > +	  Support a device-dax driver mode that is compatible with fs-dax
> 
> ...
> 
> 
> 
> >  struct dax_device_driver {
> > diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> > new file mode 100644
> > index 000000000000..2a3249d1529c
> > --- /dev/null
> > +++ b/drivers/dax/fsdev.c
> > @@ -0,0 +1,276 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2026 Micron Technology, Inc. */
> > +#include <linux/memremap.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/cdev.h>
> > +#include <linux/slab.h>
> > +#include <linux/dax.h>
> > +#include <linux/fs.h>
> > +#include <linux/mm.h>
> > +#include "dax-private.h"
> > +#include "bus.h"
> 
> ...
> 
> > +static void fsdev_cdev_del(void *cdev)
> > +{
> > +	cdev_del(cdev);
> > +}
> > +
> > +static void fsdev_kill(void *dev_dax)
> > +{
> > +	kill_dev_dax(dev_dax);
> > +}
> 
> ...
> 
> > +/*
> > + * Clear any stale folio state from pages in the given range.
> > + * This is necessary because device_dax pre-initializes compound folios
> > + * based on vmemmap_shift, and that state may persist after driver unbind.
> 
> What's the argument for not cleaning these out in the unbind path for device_dax?
> I can see that it might be an optimization if some other code path blindly
> overwrites all this state.

I prefer this because it doesn't rely on some other module having done the
right thing. Dax maintainers might have thoughts too though.

> 
> > + * Since fsdev_dax uses MEMORY_DEVICE_FS_DAX without vmemmap_shift, fs-dax
> > + * expects to find clean order-0 folios that it can build into compound
> > + * folios on demand.
> > + *
> > + * At probe time, no filesystem should be mounted yet, so all mappings
> > + * are stale and must be cleared along with compound state.
> > + */
> > +static void fsdev_clear_folio_state(struct dev_dax *dev_dax)
> > +{
> > +	int i;
> 
> It's becoming increasingly common to declare loop variables as
> for (int i = 0; i <...
> 
> and given that saves us a few lines here it seems worth doing.

Done thanks

> 
> > +
> > +	for (i = 0; i < dev_dax->nr_range; i++) {
> > +		struct range *range = &dev_dax->ranges[i].range;
> > +		unsigned long pfn, end_pfn;
> > +
> > +		pfn = PHYS_PFN(range->start);
> > +		end_pfn = PHYS_PFN(range->end) + 1;
> 
> Might as well do
> 		unsigned long pfn = PHY_PFN(range->start);
> 		unsigned long end_pfn = PHYS_PFN(range->end) + 1;

Sounds good, done

> > +
> > +		while (pfn < end_pfn) {
> > +			struct page *page = pfn_to_page(pfn);
> > +			struct folio *folio = (struct folio *)page;
> > +			struct dev_pagemap *pgmap = page_pgmap(page);
> > +			int order = folio_order(folio);
> > +
> > +			/*
> > +			 * Clear any stale mapping pointer. At probe time,
> > +			 * no filesystem is mounted, so any mapping is stale.
> > +			 */
> > +			folio->mapping = NULL;
> > +			folio->share = 0;
> > +
> > +			if (order > 0) {
> > +				int j;
> > +
> > +				folio_reset_order(folio);
> > +				for (j = 0; j < (1UL << order); j++) {
> > +					struct page *p = page + j;
> > +
> > +					ClearPageHead(p);
> > +					clear_compound_head(p);
> > +					((struct folio *)p)->mapping = NULL;
> 
> This code block is very similar to a chunk in dax_folio_put() in fs/dax.c
> 
> Can we create a helper for both to use?
> 
> I note that uses a local struct folio *new_folio to avoid multiple casts.
> I'd do similar here even if it's a long line.
>  
> If not possible to use a common helper, it is probably still worth
> having a helper here for the stuff in the while loop just to reduce indent
> and improve readability a little.

Good catch! You shall have a Suggested-by in the next version, which will
inject a commit right before this that factors out dax_folio_reset_order()
from dax_folio_put(). Then fsdev_clear_folio_state() will also call that.

> 
> > +					((struct folio *)p)->share = 0;
> > +					((struct folio *)p)->pgmap = pgmap;
> > +				}
> > +				pfn += (1UL << order);
> > +			} else {
> > +				folio->pgmap = pgmap;
> > +				pfn++;
> > +			}
> > +		}
> > +	}
> > +}
> > +
> > +static int fsdev_open(struct inode *inode, struct file *filp)
> > +{
> > +	struct dax_device *dax_dev = inode_dax(inode);
> > +	struct dev_dax *dev_dax = dax_get_private(dax_dev);
> > +
> > +	dev_dbg(&dev_dax->dev, "trace\n");
> 
> Hmm. This is a somewhat odd, but I see dax/device.c does
> the same thing and I guess that's because you are using
> dynamic debug with function names turned on to provide the
> 'real' information.

Actually I just have it from the gut-and-repurpose of device.c.
Dropping from fsdev.c as I'm not using it.

> 
> 
> 
> > +	filp->private_data = dev_dax;
> > +
> > +	return 0;
> > +}
> 
> > +static int fsdev_dax_probe(struct dev_dax *dev_dax)
> > +{
> > +	struct dax_device *dax_dev = dev_dax->dax_dev;
> > +	struct device *dev = &dev_dax->dev;
> > +	struct dev_pagemap *pgmap;
> > +	u64 data_offset = 0;
> > +	struct inode *inode;
> > +	struct cdev *cdev;
> > +	void *addr;
> > +	int rc, i;
> > +
> 
> A bunch of this is cut and paste from dax/device.c
> If it carries on looking like this, can we have a helper module that
> both drivers use with the common code in it? That would make the
> difference more obvious as well.

Makes sense. I'll wait for thoughts from the dax people before
flipping bits on this though.

> 
> > +	if (static_dev_dax(dev_dax))  {
> > +		if (dev_dax->nr_range > 1) {
> > +			dev_warn(dev,
> > +				"static pgmap / multi-range device conflict\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		pgmap = dev_dax->pgmap;
> > +	} else {
> > +		if (dev_dax->pgmap) {
> > +			dev_warn(dev,
> > +				 "dynamic-dax with pre-populated page map\n");
> Unless dax maintainers are very fussy about 80 chars, I'd go long on these as it's
> only just over 80 chars on one line.
> 
> Given you are failing probe, not sure why dev_warn() is considered sufficient.
> To me dev_err() seems more sensible. What you have matches dax/device.c though
> so maybe there is a sound reason.

I'm personally a bit fussy about 80 column code, being kinda old and favoring
80 column emacs windows :D - mulling it over.

> 
> > +			return -EINVAL;
> > +		}
> > +
> > +		pgmap = devm_kzalloc(dev,
> > +			struct_size(pgmap, ranges, dev_dax->nr_range - 1),
> > +				     GFP_KERNEL);
> Pick an alignment style and stick to it.  Either.
> 		pgmap = devm_kzalloc(dev,
> 			struct_size(pgmap, ranges, dev_dax->nr_range - 1),
> 			GFP_KERNEL);
> 
> or go long for readability and do
> 		pgmap = devm_kzalloc(dev,
> 				     struct_size(pgmap, ranges, dev_dax->nr_range - 1),
> 				     GFP_KERNEL);

Will do something cleaner. This is the aforementioned 80 column curmudgeonliness
at work...

> 
> 
> 
> > +		if (!pgmap)
> > +			return -ENOMEM;
> > +
> > +		pgmap->nr_range = dev_dax->nr_range;
> > +		dev_dax->pgmap = pgmap;
> > +
> > +		for (i = 0; i < dev_dax->nr_range; i++) {
> > +			struct range *range = &dev_dax->ranges[i].range;
> > +
> > +			pgmap->ranges[i] = *range;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < dev_dax->nr_range; i++) {
> > +		struct range *range = &dev_dax->ranges[i].range;
> > +
> > +		if (!devm_request_mem_region(dev, range->start,
> > +					range_len(range), dev_name(dev))) {
> > +			dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve range\n",
> > +					i, range->start, range->end);
> > +			return -EBUSY;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * FS-DAX compatible mode: Use MEMORY_DEVICE_FS_DAX type and
> > +	 * do NOT set vmemmap_shift. This leaves folios at order-0,
> > +	 * allowing fs-dax to dynamically create compound folios as needed
> > +	 * (similar to pmem behavior).
> > +	 */
> > +	pgmap->type = MEMORY_DEVICE_FS_DAX;
> > +	pgmap->ops = &fsdev_pagemap_ops;
> > +	pgmap->owner = dev_dax;
> > +
> > +	/*
> > +	 * CRITICAL DIFFERENCE from device.c:
> > +	 * We do NOT set vmemmap_shift here, even if align > PAGE_SIZE.
> > +	 * This ensures folios remain order-0 and are compatible with
> > +	 * fs-dax's folio management.
> > +	 */
> > +
> > +	addr = devm_memremap_pages(dev, pgmap);
> > +	if (IS_ERR(addr))
> > +		return PTR_ERR(addr);
> > +
> > +	/*
> > +	 * Clear any stale compound folio state left over from a previous
> > +	 * driver (e.g., device_dax with vmemmap_shift).
> > +	 */
> > +	fsdev_clear_folio_state(dev_dax);
> > +
> > +	/* Detect whether the data is at a non-zero offset into the memory */
> > +	if (pgmap->range.start != dev_dax->ranges[0].range.start) {
> > +		u64 phys = dev_dax->ranges[0].range.start;
> > +		u64 pgmap_phys = dev_dax->pgmap[0].range.start;
> > +
> > +		if (!WARN_ON(pgmap_phys > phys))
> > +			data_offset = phys - pgmap_phys;
> > +
> > +		pr_debug("%s: offset detected phys=%llx pgmap_phys=%llx offset=%llx\n",
> > +		       __func__, phys, pgmap_phys, data_offset);
> > +	}
> > +
> > +	inode = dax_inode(dax_dev);
> > +	cdev = inode->i_cdev;
> > +	cdev_init(cdev, &fsdev_fops);
> > +	cdev->owner = dev->driver->owner;
> > +	cdev_set_parent(cdev, &dev->kobj);
> > +	rc = cdev_add(cdev, dev->devt, 1);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = devm_add_action_or_reset(dev, fsdev_cdev_del, cdev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	run_dax(dax_dev);
> > +	return devm_add_action_or_reset(dev, fsdev_kill, dev_dax);
> > +}
> > +
> > +static struct dax_device_driver fsdev_dax_driver = {
> > +	.probe = fsdev_dax_probe,
> > +	.type = DAXDRV_FSDEV_TYPE,
> > +};
> > +
> > +static int __init dax_init(void)
> > +{
> > +	return dax_driver_register(&fsdev_dax_driver);
> > +}
> > +
> > +static void __exit dax_exit(void)
> > +{
> > +	dax_driver_unregister(&fsdev_dax_driver);
> > +}
> If these don't get more complex, maybe it's time for a dax specific define
> using module_driver()

I'll defer to the dax folks here

> 
> > +
> > +MODULE_AUTHOR("John Groves");
> > +MODULE_DESCRIPTION("FS-DAX Device: fs-dax compatible devdax driver");
> > +MODULE_LICENSE("GPL");
> > +module_init(dax_init);
> > +module_exit(dax_exit);
> > +MODULE_ALIAS_DAX_DEVICE(0);
> 
> Curious macro. Always has same parameter...  Maybe ripe for just dropping the parameter?
> 
> 

Thanks!
John

