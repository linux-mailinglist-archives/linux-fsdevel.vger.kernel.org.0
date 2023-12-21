Return-Path: <linux-fsdevel+bounces-6684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F8D81B5BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB15C1C236E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02186EB5D;
	Thu, 21 Dec 2023 12:25:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84D6D1CA;
	Thu, 21 Dec 2023 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 467BB68B05; Thu, 21 Dec 2023 13:25:36 +0100 (CET)
Date: Thu, 21 Dec 2023 13:25:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] writeback: Factor writeback_get_folio() out of
 write_cache_pages()
Message-ID: <20231221122535.GE17956@lst.de>
References: <20231218153553.807799-1-hch@lst.de> <20231218153553.807799-14-hch@lst.de> <20231221114153.2ktiwixqedsk5adw@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221114153.2ktiwixqedsk5adw@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 21, 2023 at 12:41:53PM +0100, Jan Kara wrote:
> But I'd note that the call stack depth of similarly called helper functions
> (with more to come later in the series) is getting a bit confusing. Maybe
> we should inline writeback_get_next() into its single caller
> writeback_get_folio() to reduce confusion a bit...

I just hacked that up based on the fully applied series and that looks
good to me.

