Return-Path: <linux-fsdevel+bounces-5631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734E180E718
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1359BB21092
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E67E5812F;
	Tue, 12 Dec 2023 09:10:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A38BD2;
	Tue, 12 Dec 2023 01:10:47 -0800 (PST)
Received: from [141.14.31.7] (theinternet.molgen.mpg.de [141.14.31.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 10D4461E646CF;
	Tue, 12 Dec 2023 10:10:24 +0100 (CET)
Message-ID: <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de>
Date: Tue, 12 Dec 2023 10:10:23 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: file handle in statx
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-bcachefs@vger.kernel.org, Stefan Krueger <stefan.krueger@aei.mpg.de>,
 David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20231208013739.frhvlisxut6hexnd@moria.home.lan>
 <170200162890.12910.9667703050904306180@noble.neil.brown.name>
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
From: Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <ZXf1WCrw4TPc5y7d@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/23 06:53, Dave Chinner wrote:

> So can someone please explain to me why we need to try to re-invent
> a generic filehandle concept in statx when we already have a
> have working and widely supported user API that provides exactly
> this functionality?

name_to_handle_at() is fine, but userspace could profit from being able to retrieve
the filehandle together with the other metadata in a single system call.

One argument regarding stx_vol was that userspace tools, which walk the
filesystem tree, might want to avoid to run blindly into snapshots.

Additionally, if a volume defines the namespace for a set of unique inode numbers,
the tools could continue to use inode numbers just on a per-volume basis.

Best

  Donald

> Cheers,
> 
> Dave.

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433


