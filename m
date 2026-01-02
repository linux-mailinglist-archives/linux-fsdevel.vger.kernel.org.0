Return-Path: <linux-fsdevel+bounces-72320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E2CEEC51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 15:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A779A3007288
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4466157480;
	Fri,  2 Jan 2026 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMqn08zB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396B1C28E
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jan 2026 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767364496; cv=none; b=mlqiBWi7+NVO+e9SSit6n376uK1Rmj8265mtpodOvtO+H/ub5wM+g6am952DMe67yST324O4xVwLSXWsNSVsUtWnQvZACXdqnWDOBq/qTHk98YsB3FD0fX3Nds2DInwkkedBvIc1vLebEoKnbsPPX7fKrZeTjUmPMVUJvpzvQT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767364496; c=relaxed/simple;
	bh=TELarO23MSfAM9iY6A1YcDG/q/qwxBPR9xcJ38ahsCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdOcpsA6veEUJTbrTsFpkTRJV2JaGtJDTMzptvpJADrkcdtheURlZ7DW6nk9NZqmlBkLUKM/VA72S/kKL7yWXy2v1r9UwS2XYtuTomkslI92i036LHAMnbGM/vnroTt1oTRN7awPEAN98YZl1KFc6GAETrTxc7+crxGrsvDGqUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMqn08zB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b736ffc531fso2196405866b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jan 2026 06:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767364493; x=1767969293; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vwnxI3Yh+PC+lgwoiNcA+XdysMGpWJnMhSYk6HzGCg=;
        b=dMqn08zBZFm414kuCGUFaxaq4u1tNQ6ItzrqzBpKWnDarBytaZdmGRq3TXHj5tsHTX
         mFU4Cm2PCNM5tQpQYDWxCVQuNJnZfIXqq08d3iiOFwEE9IklntBfRd23AHoRcO91cqex
         g6587ZrF/OUW/qxdUSVdLaZ4cqK9POtZXN2Z1Xw49/QdeBTNOCfjScf742uSPuRUoZJ+
         AmSo11I76SWnpXODi7/WWgzCDjiWe6igVBkXZZtiuXRTq6ttDmSE5VX0pvxEUPn9spp9
         rMpSE3m7k05hvWqI6XNq2NwxY/Ug/bfGDOtdwf9eRuuMHfMc6WHEvYJIrIPd/X7aqjZO
         umKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767364493; x=1767969293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vwnxI3Yh+PC+lgwoiNcA+XdysMGpWJnMhSYk6HzGCg=;
        b=F+UtdPi8qYjJK3BPNuqVDOfVrD8xdC7vhKhsoz1odGDNJhikxudhoGAOJt8cOa3GNf
         oi35iOov+4kePCwPaCXagS38tRTBpf2gybonSehh42t9OnkRsT/cioD/97reSc+KAamP
         +RWkGnI6mXTCbdjhganljhbEkmq9bxjqewTnpDR+77+aFlXUECgtsVbwoSK85oDyrs/5
         gKNpeWrIRSeyDTByY+gSddvGTf+7i0OlBp4lCmLFBbA3ZNwE9vV02WqVR4OT37ra2ATU
         DdHH7/NU1QPu/uBqY3zMZSet7vVrmtPzRPRviVUP88aW3TEZ4P4RlhtwlQTE4aNW7xge
         H0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU3cyf/FHrxQpinBAJeqHIZ1N4zMuToNHg7qbBGL8kVFWqhh6XCk1f3nDe5Tb6J4DV55YGyt8Yi9Skeulhv@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGN44ySRgU8SwMIkuBiWdEJCnl2LInrsPVexBBv+cYdsqSJ+0
	i72aBN1GoqboJgysn2KZdezIJ8JZEtT2ah0rARsrGlQ7VwGOHKFH2PsYekxBb9c8
X-Gm-Gg: AY/fxX5cDIku0hHreHXIQlNuU6Ws1zQ+yAXOpg2B7eGaek4iLxU06CBlpS0LFKFUqNL
	PROpjXUVgL/Y4Qc7ZCG6P48NAdm3hOjFRbM64vBp9O5oX8A73/WeWTCzXw6kl3nk7O1HWq+b81g
	HZvc/hkx9LCreZG89ghJNQ1V0oBPoQBrS5cs292nHtpSvDRuiQrbYwmqE6eCLShBdvokHmRiyWz
	iTUDHKy8W1Am98I5m/0MMmla90/VysrIDgGxpMqEC2/8cSYOw9xaSAzAJplS0To0xcUEpU4Xojk
	uezgkBZCamsk9FBXhUR/L/ZF8wy7BvDPEx0rSD7qoh4x4o7FCJqVysv5AXMXAwkbhHTVXQOQrvi
	03B/XCKn2A5/ZJSp2tomg1QUz0kvb0c5AxBpMQm+JOglhpYUbYs19hWO64zmkgldZDiiztrwtJB
	44qIFhXpYMo4sTswzWtFLk8WqLN7AiXSDUhY/XGnkAn7GY
X-Google-Smtp-Source: AGHT+IH1KBuo6JG6vASIeb2V7qRjpvjk+kkYcpah7AGYC5IaaeIeL01hwyaf5hmN+BVXy1Rk+MzVCA==
X-Received: by 2002:a05:600c:310c:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-47d1953b941mr402475615e9.7.1767358284358;
        Fri, 02 Jan 2026 04:51:24 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a4651bsm311220285e9.7.2026.01.02.04.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:51:23 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 9EBF0BE2DE0; Fri, 02 Jan 2026 13:51:22 +0100 (CET)
Date: Fri, 2 Jan 2026 13:51:22 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	1120058@bugs.debian.org, Jingbo Xu <jefflexu@linux.alibaba.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [regression] 0c58a97f919c ("fuse: remove tmp folio for
 writebacks and internal rb tree") results in suspend-to-RAM hang on AMD
 Ryzen 5 5625U on test scenario involving podman containers, x2go and openjdk
 workload
Message-ID: <aVe_SgcXz5CKa92B@eldamar.lan>
References: <aQrcFyO7tlFF0TyD@lorien.valinor.li>
 <aSl-iAefeJJfjPJB@probook>
 <aSoBsX5MZXYCq2qZ@eldamar.lan>
 <176227232774.2636.13973205036417925311.reportbug@probook>
 <aSxCcapas1biHwBk@probook>
 <aT7JRqhUvZvfUQlV@eldamar.lan>
 <CAJnrk1Ygu_erR0W2wTOdYzVhm2ZowWDdULQbXpp2AZR1Y=jkJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Ygu_erR0W2wTOdYzVhm2ZowWDdULQbXpp2AZR1Y=jkJA@mail.gmail.com>

Hi Joanne,

On Mon, Dec 15, 2025 at 06:37:42AM +0800, Joanne Koong wrote:
> On Sun, Dec 14, 2025 at 10:27 PM Salvatore Bonaccorso <carnil@debian.org> wrote:
> >
> > Hi Joanne,
> >
> > In Debian J. Neuschäfer reported an issue where after 0c58a97f919c
> > ("fuse: remove tmp folio for writebacks and internal rb tree") a
> > specific, but admittely not very minimal workload, involving podman
> > contains, x2goserver and a openjdk application restults in
> > suspend-to-ram hang.
> >
> > The report is at https://bugs.debian.org/1120058 and information on
> > bisection and the test setup follows:
> >
> > On Sun, Nov 30, 2025 at 02:11:13PM +0100, J. Neuschäfer wrote:
> > > On Fri, Nov 28, 2025 at 09:10:25PM +0100, Salvatore Bonaccorso wrote:
> > > > Control: found -1 6.17.8-1
> > > >
> > > > Hi,
> > > >
> > > > On Fri, Nov 28, 2025 at 11:50:48AM +0100, J. Neuschäfer wrote:
> > > > > On Wed, Nov 05, 2025 at 06:09:43AM +0100, Salvatore Bonaccorso wrote:
> > > [...]
> > > > > I can reproduce the bug fairly reliably on 6.16/17 by running a specific
> > > > > podman container plus x2go (not entirely sure which parts of this is
> > > > > necessary).
> > > >
> > > > Okay if you have a very reliable way to reproduce it, would you be
> > > > open to make "your hands bit dirty" and do some bisecting on the
> > > > issue?
> > >
> > > Thank you for your detailed instructions! I've already started and completed
> > > the git bisect run in the meantime. I had to restart a few times due to
> > > mistakes, but I was able to identify the following upstream commit as the
> > > commit that introduced the issue:
> > >
> > > https://git.kernel.org/linus/0c58a97f919c24fe4245015f4375a39ff05665b6
> > >
> > >     fuse: remove tmp folio for writebacks and internal rb tree
> > >
> > > The relevant commit history is as follows:
> > >
> > >   *   2619a6d413f4c3 Merge tag 'fuse-update-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse  <-- bad
> > >   |\
> > >   | * dabb9039102879 fuse: increase readdir buffer size
> > >   | * 467e245d47e666 readdir: supply dir_context.count as readdir buffer size hint
> > >   | * c31f91c6af96a5 fuse: don't allow signals to interrupt getdents copying
> > >   | * f3cb8bd908c72e fuse: support large folios for writeback
> > >   | * 906354c87f4917 fuse: support large folios for readahead
> > >   | * ff7c3ee4842d87 fuse: support large folios for queued writes
> > >   | * c91440c89fbd9d fuse: support large folios for stores
> > >   | * cacc0645bcad3e fuse: support large folios for symlinks
> > >   | * 351a24eb48209b fuse: support large folios for folio reads
> > >   | * d60a6015e1a284 fuse: support large folios for writethrough writes
> > >   | * 63c69ad3d18a80 fuse: refactor fuse_fill_write_pages()
> > >   | * 3568a956932621 fuse: support large folios for retrieves
> > >   | * 394244b24fdd09 fuse: support copying large folios
> > >   | * f09222980d7751 fs: fuse: add dev id to /dev/fuse fdinfo
> > >   | * 18ee43c398af0b docs: filesystems: add fuse-passthrough.rst
> > >   | * 767c4b82715ad3 MAINTAINERS: update filter of FUSE documentation
> > >   | * 69efbff69f89c9 fuse: fix race between concurrent setattrs from multiple nodes
> > >   | * 0c58a97f919c24 fuse: remove tmp folio for writebacks and internal rb tree              <-- first bad commit
> > >   | * 0c4f8ed498cea1 mm: skip folio reclaim in legacy memcg contexts for deadlockable mappings
> > >   | * 4fea593e625cd5 fuse: optimize over-io-uring request expiration check
> > >   | * 03a3617f92c2a7 fuse: use boolean bit-fields in struct fuse_copy_state
> > >   | * a5c4983bb90759 fuse: Convert 'write' to a bit-field in struct fuse_copy_state
> > >   | * 2396356a945bb0 fuse: add more control over cache invalidation behaviour
> > >   | * faa794dd2e17e7 fuse: Move prefaulting out of hot write path
> > >   | * 0486b1832dc386 fuse: change 'unsigned' to 'unsigned int'
> > >   *   0fb34422b5c223 Merge tag 'vfs-6.16-rc1.netfs' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs   <-- good
> > >
> > > The first and last commits shown are merge commits done by Linus Torvalds. The
> > > fuse-update branch was based on v6.15-rc1, under which I can't run my test due
> > > to an unrelated bug, so I ended up merging in 0fb34422b5c223 to test the
> > > commits within the fuse-update branch. e.g.:
> > >
> > >   git reset --hard 394244b24fdd09 && git merge 0fb34422b5c223 && make clean && make
> > >
> > >
> > > I have also verified that the issue still happens on v6.18-rc7 but I wasn't
> > > able to revert 0c58a97f919 on top of this release, because a trivial revert
> > > is not possible.
> > >
> > > My test case consists of a few parts:
> > >
> > >  - A podman container based on the "debian:13" image (which points to
> > >    docker.io/library/debian via /etc/containers/registries.conf.d/shortnames.conf),
> > >    where I installed x2goserver and a openjdk-21-based application; It runs the
> > >    OpenSSH server and port 22 is exposed as localhost:2001
> > >  - x2goclient to start a desktop session in the container
> > >
> > > Source code: https://codeberg.org/neuschaefer/re-workspace
> > >
> > > I suspect, but haven't verified, that the X server in the container somehow
> > > uses the FUSE-emulated filesystem in the container to create a file that is
> > > used with mmap (perhaps to create shared pages as frame buffers).
> > >
> > >
> > > Raw bisect notes:
> > >
> > > good:
> > > - v6.12.48+deb13-amd64
> > > - v6.12.59
> > > - v6.12
> > > - v6.14
> > > - v6.15-1304-g14418ddcc2c205
> > > - v6.15-10380-gec71f661a572
> > > - v6.15-10888-gb509c16e1d7cba
> > > - v6.15-rc7-357-g8e86e73626527e
> > > - v6.15-10933-g4c3b7df7844340
> > > - v6.15-10954-gd00a83477e7a8f
> > > - v6.15-rc7-366-g438e22801b1958 (CONFIG_X86_5LEVEL=y)
> > > - v6.15-rc4-126-g07212d16adc7a0
> > > - v6.15-10958-gdf7b9b4f6bfeb1    <-- first parent, 5LEVEL doesn't exist
> > > - v6.15-rc4-00127-g4d62121ce9b5
> > > - v6.15-rc7-375-g61374cc145f4a5  <-- second parent, `X86_5LEVEL=y`
> > > - v6.15-rc7-375-g61374cc145f4a5  <-- second parent, `X86_5LEVEL=n`
> > > - v6.15-11061-g7f9039c524a351: "first bad", actually good. merge of df7b9b4f6bfeb1 61374cc145f4a5
> > > - v6.15-11093-g0fb34422b5c223
> > > - v6.15-rc1-7-g0c4f8ed498cea1 + merge = v6.15-11101-gaec20ffad33068
> > >
> > > testing:
> > > - v6.18-rc7 + revert: doesn't apply
> > >
> > > weird (ssh doesn't work):
> > > - v6.15-rc1-1-g0486b1832dc386
> > > - v6.15-rc1-10-g767c4b82715ad3
> > > - v6.15-rc1-13-g394244b24fdd09: folio stuff
> > > - v6.15-rc1-22-gf3cb8bd908c72e
> > > - v6.15-rc1-23-gc31f91c6af96a5
> > > - next-20251128
> > >
> > > bad:
> > > - v6.15-rc1-8-g0c58a97f919c24 + merge = v6.15-11102-gdfc4869c8ef1f0  first bad commit
> > > - v6.15-rc1-9-g69efbff69f89c9 + merge = v6.15-11103-ga7b103c57680ce
> > > - v6.15-rc1-11-g18ee43c398af0b + merge = v6.15-11105-g4ad0d4fa61974c
> > > - v6.15-rc1-13-g394244b24fdd09 + merge = v6.15-11107-g37da056b3b873b
> > > - v6.15-11119-g2619a6d413f4c3: merge of 0fb34422b5c223 (last good) dabb9039102879 (fuse branch)
> > > - v6.15-11165-gfd1f8473503e5b: confirmed bad
> > > - v6.15-11401-g69352bd52b2667
> > > - v6.15-12422-g2c7e4a2663a1ab
> > > - regulator-fix-v6.16-rc2-372-g5c00eca95a9a20
> > > - v6.16.12
> > > - v6.16.12 again
> > > - v6.16.12+deb14+1-amd64
> > > - v6.18-rc7
> >
> > Would that ring some bells to you which make this tackable?
> 
> Hi Salvatore,
> 
> This looks like the same issue reported in this thread [1]. The lockup
> occurs when there's a faulty fuse server on the system that doesn't
> complete a write request. Prior to commit 0c58a97f919c24 ("fuse:
> remove tmp folio for writebacks and internal rb tree"), syncs on fuse
> filesystems were effectively no-ops. This patch upstream [2] reverts
> the behavior back to that. I'll send v2 of that patch and work on
> getting it merged as soon as possible.

Do you know did that felt trough the cracks or is it just delayed
because of vacation/holiday times?

Regards,
Salvatore

