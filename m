Return-Path: <linux-fsdevel+bounces-47986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71736AA7E9D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 07:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF88985954
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 05:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E8819CC0C;
	Sat,  3 May 2025 05:40:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF318EFD1
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 May 2025 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746250808; cv=none; b=JSoq/Cs+An7tnbQIjPLTXQ5sa+XryWrIRzOMjrMp96Zuzr20Fq6EK8vTYxfpQWbeFKZUygh8JyirhlddErvVQYWwAiVWLihPRqsIVYo1TbIetyjgxegGL+QtR31//XltbRsr7BGvL8a4LebHmFgBpOsewj0ekrEddxTs1jcEMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746250808; c=relaxed/simple;
	bh=Wdt/88mNaoI8AmgXr5/wdpsx182xcW7cctpKcSz9r90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJEgoWV/d/2wjo6sk2BmxVVKF2KRqmcFQlHv9PK42CVLiFZw2m0ADc6DpQyHTSnPFYo8sLlCNZwcalZqZnBtPOKMTKDjFU5HHKkJHdnxB4HzsVoPwokvqL7quy+/8ydk4e8FnkxpnT6l+RuS/Ix4BjyDhtJkft0x6OsGgKA/RZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-148.bstnma.fios.verizon.net [173.48.82.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5435dcbE016163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 May 2025 01:39:39 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B4D1B2E00E9; Sat, 03 May 2025 01:39:38 -0400 (EDT)
Date: Sat, 3 May 2025 01:39:38 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiAg5Zue5aSNOiAg5Zue?=
 =?utf-8?B?5aSNOiDlm57lpI06?= HFS/HFS+ maintainership action items
Message-ID: <20250503053938.GD205188@mit.edu>
References: <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
 <84ebd3fb27957d926fc145a28b38c1ac737c5953.camel@physik.fu-berlin.de>
 <SEZPR06MB5269CBE385E73704B368001AE8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <d35a7b6e8fce1e894e74133d7e2fbe0461c2d0a5.camel@ibm.com>
 <SEZPR06MB5269BB960025304C687D6270E8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <97cd591a7b5a2f8e544f0c00aeea98cd88f19349.camel@ibm.com>
 <SEZPR06MB52699F3D7B651C40266E4445E8872@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <7b76ad938f586658950d2e878759d9cbcd8644e1.camel@ibm.com>
 <20250502030108.GC205188@mit.edu>
 <471a4f96e399d84ead760528cb0b049464f83845.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <471a4f96e399d84ead760528cb0b049464f83845.camel@ibm.com>

On Fri, May 02, 2025 at 07:14:26PM +0000, Viacheslav Dubeyko wrote:
> On Thu, 2025-05-01 at 23:01 -0400, Theodore Ts'o wrote:
> > Hey, in case it would be helpfui, I've added hfs support to the
> > kvm-xfstests/gce-xfstests[1] test appliance.  Following the
> > instructions at [2], you can now run "kvm-xfstests -c hfs -g auto" to
> > run all of the tests in the auto group.  If you want to replicate the
> > failure in generic/001, you could run "kvm-fstests -c hfs generic/001".
> > 
> 
> Yes, it is really helpful! Sounds great! Let me try this framework for HFS/HFS+.
> Thanks a lot.

FYI, I'm using the hfsprogs from Debian, which at the moment only
supports HFS+.  The prebuilt test appliance for {kvm,gce}-xfstests are
based on Debian Stable (Bookworm), but I am building test appliances
using Debian Testing (Trixie).  However, for the purposes of hfsprogs,
both Debian Bookwrm and Trixie are based on the 540.1 version of
hfsprogs.

But there are plenty of bugs to fix until we can manage to get a
version of hfsprogs that supports HFS --- also I'd argue that for many
users support of HFS+ is probably more useful.

If you find some test failures which are more about test bugs than
kernel bug, so we can add them to exclude files.  For example, in
/root/fs/ext4/exclude I have things like:

// generic/04[456] tests how truncate and delayed allocation works
// ext4 uses the data=ordered to avoid exposing stale data, and
// so it uses a different mechanism than xfs.  So these tests will fail
generic/044
generic/045
generic/046

Since I aso test LTS kernels, and sometimes it's not practcal to
backport fixes to older kernels we can also do versioned excludes.
For example, I have in /root/fs/global_exclude entries like:

#if LINUX_VERSION_CODE < KERNEL_VERSION(6,6,30)
// This test failure is fixed by commit 631426ba1d45q ("mm/madvise:
// make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly"),
// which first landed in v6.9, and was backported to 6.6.30 as commit
// 631426ba1d45.  Unfortunately, it's too involved to backport it and its
// dependencies to the 6.1 or earlier LTS kernels
generic/743
#endif

Finally, I have things set up to automatically run tests when a branch
on a git tree that I'm watching changes.  For exmaple:

gce-xfstests ltm -c ext4/all,xfs/all,btrfs/all,f2fs/all -g auto --repo https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next --watch fs-next

gce-xfstests ltm -c ext4/all,xfs/all -g auto --repo stable-rc.git --watch linux-6.12.y

gce-xfstests ltm -c ext4/all,xfs/all -g auto --repo stable-rc.git --watch linux-6.6.y

If it's helpful, I can set up watchers for hfs and send them to you or
some mailing list once the number of failures are reduced toa
manageable number.

Cheers,

					- Ted

P.S.   An example e-mail report:


TESTRUNID: ltm-20250416105110-0009
KERNEL:    kernel 6.12.25-rc1-xfstests-g56d2398227a2 #6 SMP PREEMPT_DYNAMIC Wed Apr 23 10:48:50 EDT 2025 x86_64
CMDLINE:   -c ext4/all,xfs/all -g auto --repo stable-rc.git --watch linux-6.12.y
CPUS:      2
MEM:       7680

ext4/4k: 587 tests, 1 failures, 55 skipped, 5596 seconds
  Flaky: generic/234: 20% (1/5)
ext4/1k: 581 tests, 2 failures, 59 skipped, 7807 seconds
  Failures: generic/363 generic/758
ext4/ext3: 579 tests, 1 failures, 149 skipped, 4646 seconds
  Failures: ext4/028
ext4/encrypt: 562 tests, 175 skipped, 3795 seconds
ext4/nojournal: 579 tests, 127 skipped, 4038 seconds
ext4/ext3conv: 584 tests, 57 skipped, 5044 seconds
ext4/adv: 580 tests, 2 failures, 63 skipped, 4933 seconds
  Failures: generic/757 generic/764
ext4/dioread_nolock: 585 tests, 55 skipped, 5135 seconds
ext4/data_journal: 580 tests, 1 failures, 135 skipped, 5776 seconds
  Failures: generic/127
ext4/bigalloc_4k: 558 tests, 58 skipped, 4870 seconds
ext4/bigalloc_1k: 559 tests, 2 failures, 69 skipped, 5141 seconds
  Failures: generic/363 generic/758
ext4/dax: 571 tests, 1 failures, 160 skipped, 3196 seconds
  Failures: generic/363
xfs/4k: 1181 tests, 2 failures, 173 skipped, 12295 seconds
  Failures: xfs/273 xfs/820
xfs/1k: 1181 tests, 2 failures, 173 skipped, 12407 seconds
  Failures: xfs/273 xfs/820
xfs/adv: 1181 tests, 4 failures, 173 skipped, 12416 seconds
  Failures: xfs/273 xfs/820
  Flaky: generic/234: 20% (1/5)   generic/370: 20% (1/5)
xfs/quota: 1181 tests, 3 failures, 174 skipped, 11305 seconds
  Failures: xfs/273 xfs/820
  Flaky: generic/370: 60% (3/5)
xfs/quota_1k: 1181 tests, 4 failures, 177 skipped, 21927 seconds
  Failures: xfs/273 xfs/629 xfs/820
  Flaky: generic/627: 60% (3/5)
xfs/dirblock_8k: 1181 tests, 2 failures, 175 skipped, 15638 seconds
  Failures: xfs/273 xfs/820
xfs/realtime: 1180 tests, 4 failures, 531 skipped, 9820 seconds
  Failures: generic/455 xfs/013 xfs/273 xfs/609
xfs/realtime_28k_logdev: 1216 tests, 41 failures, 1 errors, 613 skipped, 12164 seconds
  Failures: generic/757 xfs/253 xfs/273 xfs/598 xfs/629 xfs/630 xfs/631 
    xfs/632
  Flaky: xfs/609: 20% (1/5)
  Errors: xfs/137
xfs/realtime_logdev: 1200 tests, 21 failures, 1 errors, 586 skipped, 11650 seconds
  Failures: generic/757 xfs/253 xfs/273 xfs/598
  Flaky: xfs/609: 20% (1/5)
  Errors: xfs/137
xfs/logdev: 1209 tests, 31 failures, 1 errors, 245 skipped, 15002 seconds
  Failures: generic/757 xfs/234 xfs/253 xfs/273 xfs/598 xfs/820
  Flaky: generic/234: 20% (1/5)
  Errors: xfs/137
xfs/dax: 1191 tests, 7 failures, 344 skipped, 8396 seconds
  Failures: xfs/550 xfs/551 xfs/552 xfs/629 xfs/632 xfs/820
  Flaky: generic/363: 40% (2/5)
Totals: 20139 tests, 4526 skipped, 264 failures, 3 errors, 192766s

FSTESTIMG: gce-xfstests/xfstests-amd64-202504110828
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests 236edfd (Tue, 18 Mar 2025 12:56:26 +0900)
FSTESTVER: fio  fio-3.39 (Tue, 18 Feb 2025 08:36:57 -0700)
FSTESTVER: fsverity v1.6-2-gee7d74d (Mon, 17 Feb 2025 11:41:58 -0800)
FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
FSTESTVER: ltp  20250130-195-ge2bbba0c1 (Fri, 11 Apr 2025 18:06:15 +0800)
FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
FSTESTVER: util-linux v2.41 (Tue, 18 Mar 2025 13:50:51 +0100)
FSTESTVER: xfsprogs v6.13.0-2-gf0d16c9e (Tue, 1 Apr 2025 20:23:42 -0400)
FSTESTVER: xfstests-bld 42bcd9aa (Wed, 9 Apr 2025 07:51:57 -0400)
FSTESTVER: xfstests v2025.03.30-11-g344015670 (Mon, 31 Mar 2025 13:50:06 -0400)
FSTESTVER: zz_build-distro bookworm
FSTESTSET: -g auto
FSTESTOPT: aex

