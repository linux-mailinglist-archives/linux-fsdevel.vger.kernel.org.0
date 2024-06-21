Return-Path: <linux-fsdevel+bounces-22110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFF4912505
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 14:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE538B24505
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BAB1509A5;
	Fri, 21 Jun 2024 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ZRD6OMol"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C128399;
	Fri, 21 Jun 2024 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972362; cv=none; b=ndAci0OCoEkNitFYlJKBJPFZadIOljcUetUFPJXdd+Mp0QMfizDS6YGUnjWf48h8mhrUplqWxolLdhKnk955CUp2SE/hxnmNhpjl/Uj8AfiD8oPGxXHP2NnDH0iXMM6Dv1ptrDoMb09HbpWtiMvtjwaesq3RI6TZMYksX5QL5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972362; c=relaxed/simple;
	bh=a1mihZG1lHcPV7HaoxsEzDesMFbiaYmJjBF6OYYxoI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsGzS+Ybn+2hrG5v5ljBv6Qa9lrKz2uzqvfXu6lEuNbh3r8pR8vj90f764CTAo4Zq5aZDvxLNIcF0miAO2ZqYkKVtkY/yNDNv3/otE/x8x0IEx5tgBe44hPjArObI1pUJK8uJWVjXcAqaLceDacP0CKWyJ7OnyMma1fhGXJiMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ZRD6OMol; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W5GcY4hghz9sRt;
	Fri, 21 Jun 2024 14:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1718972349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FhklCvUMZIPSHQOWeqSqeXZ11wze5Ce0+xk5qHDK2E=;
	b=ZRD6OMol1+Im+tzEVQvrGSNx7W/8EBp/UXeyvzTwRIaDEuX+yAFtJ7OyyeW8j+lITVmeE8
	r79jDBFXzKdxy5rvedN/lAWp30mZ0N5ZoyGuqK2m8nMlho0Igzyy6kxkK72i3EAY6poxvU
	vf0aoa4iAQ9dek2h/iPT7f0F2X/udWImBsbumyGB22185XSIXCKdqO10U4tbFRhwOdKp7I
	uYAKKXPcxPP4o8AKc+3/S1PDQODA5sVQSazLSVW+JBDcRYpGx562gvwxiDz5RrZH43XP7A
	8KErXtYeus774GNTp4q+YwJIT+Ad2/zjh25xcTRtYM6RZY/6mJi7Ou5ZRch4JQ==
Date: Fri, 21 Jun 2024 12:19:03 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, david@fromorbit.com,
	djwong@kernel.org, chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, mcgrof@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 04/11] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <20240621121903.xbw4j2ijy4k32owv@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-5-kernel@pankajraghav.com>
 <ZmnuCQriFLdHKHkK@casper.infradead.org>
 <20240614092602.jc5qeoxy24xj6kl7@quentin>
 <ZnAs6lyMuHyk2wxI@casper.infradead.org>
 <20240617160420.ifwlqsm5yth4g7eo@quentin>
 <ZnBf5wXMOBWNl52x@casper.infradead.org>
 <20240617163931.wvxgqdxdbwsbqtrx@quentin>
 <ac136000-1ae0-4cab-9858-abb68ff53b66@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac136000-1ae0-4cab-9858-abb68ff53b66@suse.de>

On Tue, Jun 18, 2024 at 08:56:53AM +0200, Hannes Reinecke wrote:
> On 6/17/24 18:39, Pankaj Raghav (Samsung) wrote:
> > On Mon, Jun 17, 2024 at 05:10:15PM +0100, Matthew Wilcox wrote:
> > > On Mon, Jun 17, 2024 at 04:04:20PM +0000, Pankaj Raghav (Samsung) wrote:
> > > > On Mon, Jun 17, 2024 at 01:32:42PM +0100, Matthew Wilcox wrote:
> > > > So the following can still be there from Hannes patch as we have a
> > > > stable reference:
> > > > 
> > > >   		ractl->_workingset |= folio_test_workingset(folio);
> > > > -		ractl->_nr_pages++;
> > > > +		ractl->_nr_pages += folio_nr_pages(folio);
> > > > +		i += folio_nr_pages(folio);
> > > >   	}
> > > 
> > > We _can_, but we just allocated it, so we know what size it is already.
> > Yes.
> > 
> > > I'm starting to feel that Hannes' patch should be combined with this
> > > one.
> > 
> > Fine by me. @Hannes, is that ok with you?
> 
> Sure. I was about to re-send my patchset anyway, so feel free to wrap it in.
Is it ok if I add your Co-developed and Signed-off tag?
This is what I have combining your patch with mine and making willy's
changes:

diff --git a/mm/readahead.c b/mm/readahead.c
index 389cd802da63..f56da953c130 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -247,9 +247,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
                struct folio *folio = xa_load(&mapping->i_pages, index + i);
                int ret;
 
-
                if (folio && !xa_is_value(folio)) {
-                       long nr_pages = folio_nr_pages(folio);
                        /*
                         * Page already present?  Kick off the current batch
                         * of contiguous pages before continuing with the
@@ -259,18 +257,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
                         * not worth getting one just for that.
                         */
                        read_pages(ractl);
-
-                       /*
-                        * Move the ractl->_index by at least min_pages
-                        * if the folio got truncated to respect the
-                        * alignment constraint in the page cache.
-                        *
-                        */
-                       if (mapping != folio->mapping)
-                               nr_pages = min_nrpages;
-
-                       VM_BUG_ON_FOLIO(nr_pages < min_nrpages, folio);
-                       ractl->_index += nr_pages;
+                       ractl->_index += min_nrpages;
                        i = ractl->_index + ractl->_nr_pages - index;
                        continue;
                }
@@ -293,8 +280,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
                if (i == mark)
                        folio_set_readahead(folio);
                ractl->_workingset |= folio_test_workingset(folio);
-               ractl->_nr_pages += folio_nr_pages(folio);
-               i += folio_nr_pages(folio);
+               ractl->_nr_pages += min_nrpages;
+               i += min_nrpages;
        }
 
        /*


