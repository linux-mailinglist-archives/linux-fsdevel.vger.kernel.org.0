Return-Path: <linux-fsdevel+bounces-1319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F07D7D8FB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 09:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4649B21362
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 07:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36ECBA33;
	Fri, 27 Oct 2023 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5F58489
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 07:24:37 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE141B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 00:24:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B9BE67373; Fri, 27 Oct 2023 09:24:32 +0200 (CEST)
Date: Fri, 27 Oct 2023 09:24:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] fs,block: yield devices
Message-ID: <20231027072432.GB11134@lst.de>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org> <20231025172057.kl5ajjkdo3qtr2st@quack3> <20231025-ersuchen-restbetrag-05047ba130b5@brauner> <20231026103503.ldupo3nhynjjkz45@quack3> <20231026-marsch-tierzucht-0221d75b18ea@brauner> <20231026130442.lvfsjilryuxnnrp6@quack3> <20231026-zugreifen-impuls-15b38acf1a8c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-zugreifen-impuls-15b38acf1a8c@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 26, 2023 at 05:08:00PM +0200, Christian Brauner wrote:
> > your taste it could be also viewed as kind of layering violation so I'm not
> > 100% convinced this is definitely a way to go.
> 
> Yeah, I'm not convinced either. As I said, I really like that right now
> ti's a vfs thing only and we don't have specific requirements about how
> devices are closed which is really nice. So let's just leave it as is?

Yes, I can't really get excited about this change in any way.

