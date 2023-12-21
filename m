Return-Path: <linux-fsdevel+bounces-6683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B553281B5B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D8D1F253D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F06EB5D;
	Thu, 21 Dec 2023 12:23:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EC42206F;
	Thu, 21 Dec 2023 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EBAC68B05; Thu, 21 Dec 2023 13:23:14 +0100 (CET)
Date: Thu, 21 Dec 2023 13:23:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] writeback: Factor should_writeback_folio() out
 of write_cache_pages()
Message-ID: <20231221122314.GD17956@lst.de>
References: <20231218153553.807799-1-hch@lst.de> <20231218153553.807799-9-hch@lst.de> <20231221112206.f6biqpkpwl6w64mo@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221112206.f6biqpkpwl6w64mo@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 21, 2023 at 12:22:06PM +0100, Jan Kara wrote:
> > +static bool should_writeback_folio(struct address_space *mapping,
> > +		struct writeback_control *wbc, struct folio *folio)
> > +{
> 
> I'd call this function folio_prepare_writeback() or something like that to
> make it clearer that this function is not only about the decision whether
> we want to write folio or not but we also clear the dirty bit &
> writeprotect the folio in page tables.

Fine with me.  I'll wait for willy to chime in if he has a strong
preference.


