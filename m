Return-Path: <linux-fsdevel+bounces-6300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DB6815777
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 05:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39721C22664
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A3F1118E;
	Sat, 16 Dec 2023 04:32:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A110965;
	Sat, 16 Dec 2023 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D710C68B05; Sat, 16 Dec 2023 05:31:55 +0100 (CET)
Date: Sat, 16 Dec 2023 05:31:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 05/14] adfs: Remove writepage implementation
Message-ID: <20231216043155.GE9284@lst.de>
References: <20231215200245.748418-1-willy@infradead.org> <20231215200245.748418-6-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215200245.748418-6-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 15, 2023 at 08:02:36PM +0000, Matthew Wilcox (Oracle) wrote:
> If the filesystem implements migrate_folio and writepages, there is
> no need for a writepage implementation.

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(with the usual caveat for basically untestable otheros fses that'll
also apply to various later patches)

