Return-Path: <linux-fsdevel+bounces-77581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LtfF8fVlWlLVQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:07:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0BC15744C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BDD530066A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31D72FD1C5;
	Wed, 18 Feb 2026 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="InhnU+3m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03F11A23AC
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771427266; cv=none; b=P3LKEnatHfC51vzU07ZMVjoSOJ/tM0+yd4Jqvi8jOU3/TGecKi0DiNUBtvsVAFv4ryDzb9Ot60OyJ3yB9fCp2Y61oHJ6k2n/OGC0Ler9LoM2vS3Tu4tk8epRYbv0GE6sJZOzTgte7n5q7X4n0rffnFcW76UmY148kJRLGFhD1YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771427266; c=relaxed/simple;
	bh=YZW2iQGAtFKQ/7s6trAhvZ2qOD64bzw2KXhFs7nSpLc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cpx/wV+7Qj+FyJ5qL6g6E/aZJwgMfQXnVXdZFUjAmm61rR39TRg0TpnAWDO8qH7nr/e4YtAFiu+4b0BB2iwvvhgDKMEEPk7xk5FRxSSmqnBTmxCAN/OsHAutCqMnqPWDoDDdgjggmqV3q2J9ejyJ54ZRk6sM9vA6YjE+u6m30uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=InhnU+3m; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-113-47.bstnma.fios.verizon.net [173.48.113.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61IF7akg012888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 10:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1771427258; bh=27ui8DBGO2taK8Y0P9IqDtg96wYN5Ppdu7rSi2jn/VE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=InhnU+3m2GyB9O5iN8aWPlbYGLm1SfabyaSv3okWKtALTgYg1K+AEewiuhDyHwgKv
	 uiimoA0sKneFcjXL3Clkuu5XPez+4Pyf6srfpBXFqU8wWMlQ8y8q4W1tLr29bC3FnD
	 24QjbYNWES313aiXgJAUekYHYJcVL7TtGk8pN7Lb+zL9rwxTIyPg/pG9LVD5yvGgve
	 gAGgTmvy7kG8lz2ccz0qXMASfqY+6z7oBjH0nnBt5FkxmeKmTAD62g41mblhEfIlKm
	 AbfdPA74KswtW7FX64WngngP9S3e19HWbLGHjrFaJvm8FOT7OxYmbZbH2efcqSdcSt
	 lWHG5fsrwkhIg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id BE1145902FF3; Wed, 18 Feb 2026 10:07:36 -0500 (EST)
Date: Wed, 18 Feb 2026 10:07:36 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Subject: [LSF/MM/BPF TOPIC] File system testing
Message-ID: <20260218150736.GD45984@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,macsyma-wired.lan:mid];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77581-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+]
X-Rspamd-Queue-Id: EB0BC15744C
X-Rspamd-Action: no action

I'd like to propose a perennial favorite file system testing as a
topic for the FS track.  Topics to cover would include:

1) Standardizing test scenarios for various file systems.

   I have test scenarios for ext4 and xfs in my test appliance (e.g.,
   4k, 64k, and 1k blocksizes, with fscrypt enabled, with dax enabled,
   etc.)  But I don't have those for other file systems, such as
   btrfs, etc.  It would be nice if this could be centrally documented
   some where, perhaps in the kernel sources?

2) Standardized way of expressing that certain tests are expected to
   fail for a given test scenario.  Ideally, we can encode this in
   xfstests upstream (an example of this is requiring metadata
   journalling for generic/388).  But in some cases the failure is
   very specific to a particular set of file system configurations,
   and it may vary depending on kernel version (e.g., a problem that
   was fixed in 6.6 and later LTS kernels, but it was too hard to
   backport to earlier LTS kernels).

3) Automating the use of tests to validate file system backports to
   LTS kernels, so that commits which might cause file system
   regressions can be automatically dropped from a LTS rc kernel.

   	       	      		    	    	 - Ted

