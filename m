Return-Path: <linux-fsdevel+bounces-5727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862C680F456
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 18:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A53282260
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5157D893;
	Tue, 12 Dec 2023 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="P0+UqP9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Dec 2023 09:21:15 PST
Received: from mta-102a.earthlink-vadesecure.net (mta-102a.earthlink-vadesecure.net [51.81.61.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F57A0;
	Tue, 12 Dec 2023 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; bh=QLgKdeI1YofNbiS/FOWwaRkB1buWzAVPYqmRcM
 eNmgk=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1702401331;
 x=1703006131; b=P0+UqP9Q7efKX8QFIRYo4b1UjSvBp8kD/qsqoNx4RPIB3dsFvpSY7nV
 lzFqEyCkw5eNdspzxtXs9tfAKllEEx5sStOx5YdAk5z88/N3ycDG8AbQx1PRSCCI2EBJ3Dc
 WPr7JU0O4uBqYfDcWbIpdK9seqAdRlAYTpM9uv0wkwQ+cPdlBqGA+I+Op6LDQ8+z7EYfbh5
 nk5oP/gnGIjQPbtVJZcuXmnLvHHOAOHq+e7wGGl6FmHBsiSpCH29EuXl69MDkJqkPSyT2e1
 jW9M/ikV++GKX8k/97teNIBlIr7/f5WV+R/uZnu+qV+/637f3XIlOSLeWVXFpvjy36DGCOs
 aPg==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by vsel1nmtao02p.internal.vadesecure.com with ngmta
 id 48a1b7b4-17a024fd67e3209c; Tue, 12 Dec 2023 17:15:30 +0000
From: "Frank Filz" <ffilzlnx@mindspring.com>
To: "'Theodore Ts'o'" <tytso@mit.edu>,
	"'Donald Buczek'" <buczek@molgen.mpg.de>
Cc: "'Dave Chinner'" <david@fromorbit.com>,
	"'NeilBrown'" <neilb@suse.de>,
	"'Kent Overstreet'" <kent.overstreet@linux.dev>,
	<linux-bcachefs@vger.kernel.org>,
	"'Stefan Krueger'" <stefan.krueger@aei.mpg.de>,
	"'David Howells'" <dhowells@redhat.com>,
	<linux-fsdevel@vger.kernel.org>
References: <20231208024919.yjmyasgc76gxjnda@moria.home.lan> <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de> <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan> <170233460764.12910.276163802059260666@noble.neil.brown.name> <20231211233231.oiazgkqs7yahruuw@moria.home.lan> <170233878712.12910.112528191448334241@noble.neil.brown.name> <20231212000515.4fesfyobdlzjlwra@moria.home.lan> <170234279139.12910.809452786055101337@noble.neil.brown.name> <ZXf1WCrw4TPc5y7d@dread.disaster.area> <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de> <20231212152016.GB142380@mit.edu>
In-Reply-To: <20231212152016.GB142380@mit.edu>
Subject: RE: file handle in statx
Date: Tue, 12 Dec 2023 09:15:29 -0800
Message-ID: <0b4c01da2d1e$cf65b930$6e312b90$@mindspring.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQI2jiBebf/oJPBNRzSpvij1RIkwjAJNcH/PAj0PmP4Bx04wjwGrb0drAjE7wAEBipc+KAKTzaQNAUh2UVECn5o3SAFneCXlr1A9N2A=
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
X-Spam-Level: *

> On Tue, Dec 12, 2023 at 10:10:23AM +0100, Donald Buczek wrote:
> > On 12/12/23 06:53, Dave Chinner wrote:
> >
> > > So can someone please explain to me why we need to try to re-invent
> > > a generic filehandle concept in statx when we already have a have
> > > working and widely supported user API that provides exactly this
> > > functionality?
> >
> > name_to_handle_at() is fine, but userspace could profit from being
> > able to retrieve the filehandle together with the other metadata in a
> > single system call.
> 
> Can you say more?  What, specifically is the application that would want
to do
> that, and is it really in such a hot path that it would be a user-visible
> improveable, let aloine something that can be actually be measured?

A user space NFS server like Ganesha could benefit from getting attributes
and file handle in a single system call.

Potentially it could also avoid some of the challenges of using
name_to_handle_at that is a privileged operation.

Frank



