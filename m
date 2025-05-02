Return-Path: <linux-fsdevel+bounces-47885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB2AA68ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 05:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2406E1B6196C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092A1149C4A;
	Fri,  2 May 2025 03:01:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938A33F7
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746154896; cv=none; b=shKoyc/qnzrJSDbgDJAC+2EB+HQ5RHuQrSuBYHqBeQBwkQvTLobO4bl/r2qFu0M/GS6UgWY+FrVHznDuK5by6X4kQbDNrVpXRH0D2GBjK2y89v3Iyo8eoIqi8Csir3mEI6AEn+mknzcglrqCE+EFraaGixet+lNOZh5vSRP0178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746154896; c=relaxed/simple;
	bh=hJXX/RPHrJxrJn8ATlbZPgs/xNKoJm8YK+BH/tr3dys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0gGGxUv58EWZVueKy1Ub5gCEzt1u5WDJY/D9fNM60puInjBCVIWhrsioXXQN6/7MY4oGo3GMO1fZq4rgYeYRNo+cY4gznzW1CyFVEC4R/vz6hCKISPzXdmIccWlto+mtMjrpXGB1wCFGWwo9hr3YjPNtQ6cXRJrDs9jgdXb2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-120.bstnma.fios.verizon.net [108.26.156.120])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 542318gb012316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 May 2025 23:01:09 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 8483D2E00E9; Thu, 01 May 2025 23:01:08 -0400 (EDT)
Date: Thu, 1 May 2025 23:01:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiAg5Zue5aSNOiAg5Zue?=
 =?utf-8?B?5aSNOiDlm57lpI06?= HFS/HFS+ maintainership action items
Message-ID: <20250502030108.GC205188@mit.edu>
References: <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
 <787a6449b3ba3dce8c163b6e5b9c3d1ec1b302e4.camel@ibm.com>
 <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
 <84ebd3fb27957d926fc145a28b38c1ac737c5953.camel@physik.fu-berlin.de>
 <SEZPR06MB5269CBE385E73704B368001AE8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <d35a7b6e8fce1e894e74133d7e2fbe0461c2d0a5.camel@ibm.com>
 <SEZPR06MB5269BB960025304C687D6270E8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <97cd591a7b5a2f8e544f0c00aeea98cd88f19349.camel@ibm.com>
 <SEZPR06MB52699F3D7B651C40266E4445E8872@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <7b76ad938f586658950d2e878759d9cbcd8644e1.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b76ad938f586658950d2e878759d9cbcd8644e1.camel@ibm.com>

Hey, in case it would be helpfui, I've added hfs support to the
kvm-xfstests/gce-xfstests[1] test appliance.  Following the
instructions at [2], you can now run "kvm-xfstests -c hfs -g auto" to
run all of the tests in the auto group.  If you want to replicate the
failure in generic/001, you could run "kvm-fstests -c hfs generic/001".

[1] http://thunk.org/gce-xfstests
[2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

Your IBM colleages Ritesh Harjani and Ojaswin Mujoo use this framework
for testing ext4, and have contributed towards this test framework.
So if you have any questions, you could reach out to them.  I'm quite
willing to help as well, of course!

					- Ted

