Return-Path: <linux-fsdevel+bounces-6365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EAF8174AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AD21C24CF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A713D3D55D;
	Mon, 18 Dec 2023 15:04:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AB22088;
	Mon, 18 Dec 2023 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2ADA168AFE; Mon, 18 Dec 2023 16:04:02 +0100 (CET)
Date: Mon, 18 Dec 2023 16:04:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 08/14] hfsplus: Really remove hfsplus_writepage
Message-ID: <20231218150401.GA19279@lst.de>
References: <20231215200245.748418-1-willy@infradead.org> <20231215200245.748418-9-willy@infradead.org> <20231216043328.GF9284@lst.de> <50696fa1-a7b9-4f5f-b4ef-73ca99a69cd2@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50696fa1-a7b9-4f5f-b4ef-73ca99a69cd2@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 18, 2023 at 10:41:27AM +0000, Johannes Thumshirn wrote:
> > although I had some reason to be careful back then.  hfsplus should
> > be testable again that the hfsplus Linux port is back alive.  Is there
> > any volunteer to test hfsplus on the fsdevel list?
> 
> What do you have in mind on that side? "Just" running it through fstests 
> and see that we don't regress here or more than that?

Yeah.  Back in the day I ran hfsplus through xfstests, IIRC that might
even have been the initial motivation for supporting file systems
that don't support sparse files.  I bet a lot has regressed or isn't
support since, though.

