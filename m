Return-Path: <linux-fsdevel+bounces-24221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7080093BB4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 05:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244FE1F23FD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 03:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AB118040;
	Thu, 25 Jul 2024 03:40:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E83A1429B;
	Thu, 25 Jul 2024 03:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721878831; cv=none; b=Q5s60Hrz3SukCz4NquQZs0P3Mc0No6UDKMClzM1H6zWHzVFbW9wzEENMZAcTOlMNzBthemU5ROloOQvv4+tD4HaMNCmymkXZoKLbQnV5ZKMbf2CkW7gS/Vs3FIu2+Lbupd3we2IjHl5UmzBedG56BrkX6Jr/o5+5mO0aLnb2UAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721878831; c=relaxed/simple;
	bh=kJbT8KCYoWxqA6gfroVgrglJwJ6fwcbcmRrH3HHizIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JlYgoaZbObsUy/1TZ3b2ss2/QcXe16+fsNQQeKnJLmkC+FIIG/y0sPKEKTI0LEu+ZumpQVUHX70kk3QTMSgC0TYN86MiST00B7ka4l/8jIiKRDwdJkNnmHNXtGUaSxZD0tYkAEmK6vVIur/ywlVCNhm/L5cSseho29oM/f5SymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 5AFF01C1911;
	Thu, 25 Jul 2024 03:40:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id F22A62F;
	Thu, 25 Jul 2024 03:40:24 +0000 (UTC)
Message-ID: <778f1ccf1945f79c317dd0a4d2a90d3855770713.camel@perches.com>
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
From: Joe Perches <joe@perches.com>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, masahiroy@kernel.org, akpm@linux-foundation.org, 
	n.schier@avm.de, ojeda@kernel.org, djwong@kernel.org, kvalo@kernel.org
Date: Wed, 24 Jul 2024 20:40:23 -0700
In-Reply-To: <CAHB1NaijJ16haCsH3uHy_zVZFXJ7_-qFOk8mFx7QSeqD+X6Z3g@mail.gmail.com>
References: <20240723091154.52458-1-sunjunchao2870@gmail.com>
	 <7a1be8c1f49fc6356a0a79591af3c3de8d4675ec.camel@perches.com>
	 <CAHB1NaijJ16haCsH3uHy_zVZFXJ7_-qFOk8mFx7QSeqD+X6Z3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: F22A62F
X-Rspamd-Server: rspamout03
X-Stat-Signature: yinzfwq4jaoadypbkc6ti5igxoggrznt
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18qSFkmYW5eJfxlaISbbW3zRe0lZKf/5tU=
X-HE-Tag: 1721878824-479549
X-HE-Meta: U2FsdGVkX19G+4F8RoQBavyX6/XNgNral746x0owj110I2rlFdAT6u1sj6Ku7mBgwUdRnembhetu/E2gQkzZJ4Y31zy6IlS0zSjkdyy1Qt+6JJ0i07HFjwgYNNmje6N31P9doFss33sue8wMw19P+U2RUy8KmXprpLXYhg+h2ePjal1/Idl9H9qemdpeM3QTgt5imcZnH+T5oVc8UtcyrFULxU8I/PmjXd6zw/TRn0Wdpj+K7iFsMjrwp6y2miLlIadVciflbfpVFOupVt1y43oPbrW3dY5iIVLk6A69ruS4EHDsNf8FR2GVcivJnPivegGTnmLXnXbY6sScvTJ4mdf+gS1zIONhl5DDDSNIHqbT1Go2JhGwe+R+HHS39gxDOldw06vs434rbhUkJHhQiO5sm76RA2q//FxPvXFlJkf2cOvTG3Mczj3BkJAjtth0ocJph7CR2y7bzBgMGyg3GoGnpqaV8Vw9spnjPwN/SBA=

On Wed, 2024-07-24 at 22:09 -0400, Julian Sun wrote:
> Joe Perches <joe@perches.com> =E4=BA=8E2024=E5=B9=B47=E6=9C=8824=E6=97=A5=
=E5=91=A8=E4=B8=89 09:30=E5=86=99=E9=81=93=EF=BC=9A
> >=20
> > On Tue, 2024-07-23 at 05:11 -0400, Julian Sun wrote:
> > > Hi,
> > >=20
> > > Recently, I saw a patch[1] on the ext4 mailing list regarding
> > > the correction of a macro definition error. Jan mentioned
> > > that "The bug in the macro is a really nasty trap...".
> > > Because existing compilers are unable to detect
> > > unused parameters in macro definitions. This inspired me
> > > to write a script to check for unused parameters in
> > > macro definitions and to run it.
> > >=20
> >=20
> > checkpatch has a similar test:
> >=20
> > https://lkml.kernel.org/r/20240507032757.146386-3-21cnbao@gmail.com
> >=20
> > $ git log --format=3Demail -1 b1be5844c1a0124a49a30a20a189d0a53aa10578
> > From b1be5844c1a0124a49a30a20a189d0a53aa10578 Mon Sep 17 00:00:00 2001
> > From: Xining Xu <mac.xxn@outlook.com>
> > Date: Tue, 7 May 2024 15:27:57 +1200
> > Subject: [PATCH] scripts: checkpatch: check unused parameters for
> >  function-like macro
> >=20
> > If function-like macros do not utilize a parameter, it might result in =
a
> > build warning.  In our coding style guidelines, we advocate for utilizi=
ng
> > static inline functions to replace such macros.  This patch verifies
> > compliance with the new rule.
> >=20
> > For a macro such as the one below,
> >=20
> >  #define test(a) do { } while (0)
> >=20
> > The test result is as follows.
> >=20
> >  WARNING: Argument 'a' is not used in function-like macro
> >  #21: FILE: mm/init-mm.c:20:
> >  +#define test(a) do { } while (0)
> >=20
> >  total: 0 errors, 1 warnings, 8 lines checked
> >=20
> >=20
> > > Link: https://lkml.kernel.org/r/20240507032757.146386-3-21cnbao@gmail=
.com
> Yeah, I noticted the test. The difference between checkpatch and
> macro_checker is that checkpatch only checks the patch files, instead
> of the entire source files, which results in the inability to check
> all macros in source files.

Another possibility:

$ git ls-files -- '*.[ch]' | \
  xargs ./scripts/checkpatch -f --terse --no-summary --types=3DMACRO_ARG_UN=
USED

Though I agree the addition of a test for "do {} while (0)" and
no content would be also be useful for unused macro args tests.
---
 scripts/checkpatch.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504f..285d29b3e9010 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6060,7 +6060,9 @@ sub process {
 				}
=20
 # check if this is an unused argument
-				if ($define_stmt !~ /\b$arg\b/) {
+				if ($define_stmt !~ /\b$arg\b/ &&
+				    $define_stmt !~ /^$/ &&
+				    $define_stmt !~ /^do\s*\{\s*\}\s*while\s*\(\s*0\s*\)$/) {
 					WARN("MACRO_ARG_UNUSED",
 					     "Argument '$arg' is not used in function-like macro\n" . "$herec=
tx");
 				}


