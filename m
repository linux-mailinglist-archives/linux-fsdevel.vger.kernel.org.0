Return-Path: <linux-fsdevel+bounces-24202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E02893B31A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 16:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7DB282595
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D11115ECCD;
	Wed, 24 Jul 2024 14:48:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7377415ADB1;
	Wed, 24 Jul 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832523; cv=none; b=pI2EvqdbYeddi/laMUewOjLJa7oSOJvNusmmAGo4gn+eS13esAkxuPxkl7D9p1SdG5VhUSu3XtypqAt7WDbeIeFESUpSaQ+F8ysy3iZcXVLQ6vnsjz2AWgjI8XtONXyL9kzNlW9aPrKgLlGn/sGDRIbi79erh8ynCD2+Mi+HUdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832523; c=relaxed/simple;
	bh=T+ulhWIm7OxdPfrllI5IXV7d4dNrirUImH8j6eguePc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bITDCMIScibV6YiCy2uTtdDGSPssXD0Q464rWnSz1K84NG3nDA2FZLPYmTIh8Idit8oFjOK98ODCIhqWLvKiZs7H7rBxtd1eFc2NUin6mye4kfoFYSiQspra1dQICLzZPQvylVoLdMDjD2dOBirzHGs3/Mtc1gZgarM27xHmbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4C731809A6;
	Wed, 24 Jul 2024 13:30:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id BB66C20033;
	Wed, 24 Jul 2024 13:30:30 +0000 (UTC)
Message-ID: <7a1be8c1f49fc6356a0a79591af3c3de8d4675ec.camel@perches.com>
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
From: Joe Perches <joe@perches.com>
To: Julian Sun <sunjunchao2870@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, 
 masahiroy@kernel.org, akpm@linux-foundation.org, n.schier@avm.de,
 ojeda@kernel.org,  djwong@kernel.org, kvalo@kernel.org
Date: Wed, 24 Jul 2024 06:30:29 -0700
In-Reply-To: <20240723091154.52458-1-sunjunchao2870@gmail.com>
References: <20240723091154.52458-1-sunjunchao2870@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: BB66C20033
X-Rspamd-Server: rspamout06
X-Stat-Signature: dygo7hh9suumde5wq6rx4q5om1rufokh
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/fvNBWSgMGUWhLnXnfZzVKwnFzTAH8G7s=
X-HE-Tag: 1721827830-563549
X-HE-Meta: U2FsdGVkX195GkyrA4sk36qOW5p+w2HDp4R4rLq+fgSm/KoyU+MGiJ7hUrzOpvOGY3lLi99STFrXjT7Yh9jfGBlrXw/v8yXiSxhuxfxxweywk3d/wtnp8b1dZklK1941vVH1OtYE1G0NxZUvGeWeLfTiReZR+E/n5I5hxpZ00gefJU74Fl+xN0GInipTgceXpQ7XbEPfGjtrEuEQVuvB1xbJTWO16cEB6Lx3LgSJpUgS5bF4AQGxJCQkch22PNVstu3KNOicTAKE0IL/XLcSCLlwfGuwsuRZslwjV6WzXqkitig4Gm3PYgeJ10tXMd2uqCdXJSqMWADC0NRdZsaHAqiBa9Eml8E30jaLqNmXtuMhaFpGmiLaSZKK/Lj1TR/zGbGQ+4Jk0kndbpsG3u+ILxXye3qlSbaOsQm4rowdxG8=

On Tue, 2024-07-23 at 05:11 -0400, Julian Sun wrote:
> Hi,
>=20
> Recently, I saw a patch[1] on the ext4 mailing list regarding
> the correction of a macro definition error. Jan mentioned
> that "The bug in the macro is a really nasty trap...".
> Because existing compilers are unable to detect
> unused parameters in macro definitions. This inspired me
> to write a script to check for unused parameters in
> macro definitions and to run it.
>=20

checkpatch has a similar test:

https://lkml.kernel.org/r/20240507032757.146386-3-21cnbao@gmail.com

$ git log --format=3Demail -1 b1be5844c1a0124a49a30a20a189d0a53aa10578
From b1be5844c1a0124a49a30a20a189d0a53aa10578 Mon Sep 17 00:00:00 2001
From: Xining Xu <mac.xxn@outlook.com>
Date: Tue, 7 May 2024 15:27:57 +1200
Subject: [PATCH] scripts: checkpatch: check unused parameters for
 function-like macro

If function-like macros do not utilize a parameter, it might result in a
build warning.  In our coding style guidelines, we advocate for utilizing
static inline functions to replace such macros.  This patch verifies
compliance with the new rule.

For a macro such as the one below,

 #define test(a) do { } while (0)

The test result is as follows.

 WARNING: Argument 'a' is not used in function-like macro
 #21: FILE: mm/init-mm.c:20:
 +#define test(a) do { } while (0)

 total: 0 errors, 1 warnings, 8 lines checked

Link: https://lkml.kernel.org/r/20240507032757.146386-3-21cnbao@gmail.com


