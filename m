Return-Path: <linux-fsdevel+bounces-18190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DEA8B63C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 22:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7611C21FB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 20:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BBF1779B1;
	Mon, 29 Apr 2024 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="hD0xxNtV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4886B1420DD;
	Mon, 29 Apr 2024 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423215; cv=none; b=LBgk+lnmkIj/9l2v8Kkcqa83QjVoQVpP2KzztYE/+eUdHB3pvEpfO8ynMmOdM8J4VEkXve8KpcNDblW5B+vcnTc4XV/HakzBlfwsyHmOMCV64gI2tIHHwv/MGORUNYi8vnp+YNCGjnV384JV+tXeLIgiEZGSZ1020jjbb8yX1f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423215; c=relaxed/simple;
	bh=dpVuKJaAI/3uU1ofF38ClOBxco65tUkbk4vkbZXEgLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3wLVEILbCs5BeBbtYkhCzjy/bAcCR7CU4XAHdB+Bt/5Difx2PkYtp+NTy2ffUzTl57szv+v9Y9ajCV0jYX9XOfj+BnIW3114owecTvY0VrSD5fLClc/qPqRLk17/9SwZSX4G6f+1MOd/ZakR1w+JvvMMnT6Tufg9K5i4WcEG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=hD0xxNtV; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VSwDz4JFwz9skk;
	Mon, 29 Apr 2024 22:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714423203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bdRxYw1alqzNEbQvn6ARArUKP3stX6EgitWPX7yq5ok=;
	b=hD0xxNtVSR4T/Vlszjoy5hAcIZofGysKkXAsrGwq+vDPpa8RNVQf8vdF2fv47nyhZdBL4V
	+4OXXRw4TQPLZSlNHnxJQEOrnNj7djzlCEhBSzUWHxWtm0jWRZwcmDCl3pUhQ8kahz5f/v
	IAgSEzuiZzvZ/Bv1OM58yCoZ8Hus9c3NblwPF+iTOTBPyGEuK2EjNkjst1McFU4uI1eDkG
	9C3foAG2ODYHNvAGPzt3f/d1lZ6TbEWklnlI8wP+vgt8+rjLZTO7eocyL8WpQ2OnIzS0Gt
	HNQdGac5fDgTc3ZWfOiM1R84oyVNrH5fTyAN7E42qsJwjDrMA+j3liAapF76cw==
Date: Mon, 29 Apr 2024 20:39:58 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: willy@infradead.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 00/11] enable bs > ps in XFS
Message-ID: <20240429203958.gtwqfmdhcwb36kq7@quentin>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <87y18zxvpd.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y18zxvpd.fsf@gmail.com>

On Sat, Apr 27, 2024 at 10:12:38AM +0530, Ritesh Harjani wrote:
> "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:
> 
> > From: Pankaj Raghav <p.raghav@samsung.com>
> >
> > This is the fourth version of the series that enables block size > page size
> > (Large Block Size) in XFS. The context and motivation can be seen in cover
> > letter of the RFC v1[1]. We also recorded a talk about this effort at LPC [3],
> > if someone would like more context on this effort.
> >
> > This series does not split a folio during truncation even though we have
> > an API to do so due to some issues with writeback. While it is not a
> > blocker, this feature can be added as a future improvement once we
> > get the base patches upstream (See patch 7).
> >
> > A lot of emphasis has been put on testing using kdevops. The testing has
> > been split into regression and progression.
> >
> > Regression testing:
> > In regression testing, we ran the whole test suite to check for
> > *regression on existing profiles due to the page cache changes.
> >
> > No regression was found with the patches added on top.
> >
> > Progression testing:
> > For progression testing, we tested for 8k, 16k, 32k and 64k block sizes.
> > To compare it with existing support, an ARM VM with 64k base page system
> > (without our patches) was used as a reference to check for actual failures
> > due to LBS support in a 4k base page size system.
> >
> > There are some tests that assumes block size < page size that needs to
> > be fixed. I have a tree with fixes for xfstests here [6], which I will be
> > sending soon to the list. Already a part of this has been upstreamed to
> > fstest.
> >
> > No new failures were found with the LBS support.
> 
> I just did portability testing by creating XFS with 16k bs on x86 VM (4k
> pagesize), created some files + checksums. I then moved the disk to
> Power VM with 64k pagesize and mounted this. I was able to mount and
> all the file checksums passed.
> 
> Then I did the vice versa, created a filesystem on Power VM with 64k
> blocksize and created 10 files with random data of 10MB each. I then
> hotplugged this device out from Power and plugged it into x86 VM and
> mounted it.
> 
> <Logs of the 2nd operation>
> ~# mount /dev/vdk /mnt1/
> [   35.145350] XFS (vdk): EXPERIMENTAL: Filesystem with Large Block Size (65536 bytes) enabled.
> [   35.149858] XFS (vdk): Mounting V5 Filesystem 91933a8b-1370-4931-97d1-c21213f31f8f
> [   35.227459] XFS (vdk): Ending clean mount
> [   35.235090] xfs filesystem being mounted at /mnt1 supports timestamps until 2038-01-19 (0x7fffffff)
> ~# cd /mnt1/
> ~# sha256sum -c checksums 
> file-1.img: OK
> file-2.img: OK
> file-3.img: OK
> file-4.img: OK
> file-5.img: OK
> file-6.img: OK
> file-7.img: OK
> file-8.img: OK
> file-9.img: OK
> file-10.img: OK
> 
> So thanks for this nice portability which this series offers :) 

That is indeed nice. Thanks a lot for testing this Ritesh. :)

> 
> -ritesh
> 

