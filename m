Return-Path: <linux-fsdevel+bounces-7816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F85982B6A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 22:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A071F22038
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 21:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459DA58138;
	Thu, 11 Jan 2024 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpiqWC9B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1856B7D;
	Thu, 11 Jan 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbed430ef5eso4957177276.1;
        Thu, 11 Jan 2024 13:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705008642; x=1705613442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LgYFTnwAu8/MG526Kevc0lB/NXqtyQR3bdvsNZmg0k=;
        b=TpiqWC9BAulrWnKhiektgUYIuvMwTCd+X2zr4TqSlrxihckuzECKrmvEAm8V9e9kpA
         /N+oDmiactnrJLUJ7ZSoR+s6rTGTXd+TrCmE9PIVlwWvW3EUwb2iE6zWDSpkKNK8lf53
         oQ2cgwTItkorl2Zhy0GlbTrFJW2T5z51jh93Zf8kiwBjme28UOP6OR3VWokw1C/kUs2e
         s2J2GJ7pvkhpkHlbOkLv3awL2X6zzfMBH6ThST6l7LnyxKTvvHyBvQWTtUex4BMZB2wb
         UgHiPzOvJBpywXuiVz0J13UvyfeYJvXUATqI6dDnV45OPS6mubNjrEngbwSwV7+lvUFS
         Drjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705008642; x=1705613442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LgYFTnwAu8/MG526Kevc0lB/NXqtyQR3bdvsNZmg0k=;
        b=FXBYeKdsK5RHYTG3RYkENq+6iRA8sCJGWoLPg1T1KcgbnOmCmNc+qCbYLS/A/enWfD
         xt+pjnGeOqbYsiushc0GLMZi5Lm8Snc73IaZa8oZ+3GRIoTjOL8S8MlTuC2Ij71PlvIK
         BUrfkqlQSKaf4sZK9Bd0hoNH2y0FkajaA1roihqj2RuTh7g0eNpvUGFhU96HLAhXe1/S
         gsG0nG0yznQT9EjcQmiJ6FT4WvU83iH6oSLJ1SZXYKk//iPbNC0xSzTuqgpkaK8Rfjgo
         n7FgpMftTePy9E74WXPeSaDdzQeNDIZ0EhsxRXh3Naz9QAkjaGbUNf+ITIZT66w1mr0k
         aqwA==
X-Gm-Message-State: AOJu0Yzg+WjPG2diOmovuGSav/tUDndg1q6X4cEZPR4qSEG1RD0oppig
	o8VIz9HXCOU02RJcIanPSpu4hTXaer2uz0Tkd/k=
X-Google-Smtp-Source: AGHT+IHwmH+A2IQ0AogjWxAMvzBiF3cSFHiqvOmPkUcvH7iqX/OVfLICPOYHsW9aFA0OozZ2CFnaG7nwOMzm3wCWY1Y=
X-Received: by 2002:a05:6902:1364:b0:dbf:11e:d09d with SMTP id
 bt4-20020a056902136400b00dbf011ed09dmr294814ybb.84.1705008642089; Thu, 11 Jan
 2024 13:30:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110092109.1950011-1-hch@lst.de> <ZZ6Pfk8tLXbvs4dE@casper.infradead.org>
 <170490002493.164187.5401160425746227111@jlahtine-mobl.ger.corp.intel.com>
 <170490050245.164862.16261803493864298341@jlahtine-mobl.ger.corp.intel.com> <ZZ64/F/yeSymOCcI@casper.infradead.org>
In-Reply-To: <ZZ64/F/yeSymOCcI@casper.infradead.org>
From: Daniel Gomez <dagmcr@gmail.com>
Date: Thu, 11 Jan 2024 22:30:31 +0100
Message-ID: <CAPsT6hkQixVvvE94Rjop-7jOXi3FOMfv8BOFhxYLWUs906x2CQ@mail.gmail.com>
Subject: Re: disable large folios for shmem file used by xfs xfile
To: Matthew Wilcox <willy@infradead.org>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Christoph Hellwig <hch@lst.de>, 
	Hugh Dickins <hughd@google.com>, Chandan Babu R <chandan.babu@oracle.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, x86@kernel.org, linux-sgx@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:35=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jan 10, 2024 at 05:28:22PM +0200, Joonas Lahtinen wrote:
> > Quoting Joonas Lahtinen (2024-01-10 17:20:24)
> > > However we specifically pass "huge=3Dwithin_size" to vfs_kern_mount w=
hen
> > > creating a private mount of tmpfs for the purpose of i915 created
> > > allocations.
> > >
> > > Older hardware also had some address hashing bugs where 2M aligned
> > > memory caused a lot of collisions in TLB so we don't enable it always=
.
> > >
> > > You can see drivers/gpu/drm/i915/gem/i915_gemfs.c function
> > > i915_gemfs_init for details and references.
> > >
> > > So in short, functionality wise we should be fine either default
> > > for using 2M pages or not. If they become the default, we'd probably
> > > want an option that would still be able to prevent them for performan=
ce
> > > regression reasons on older hardware.
> >
> > To maybe write out my concern better:
> >
> > Is there plan to enable huge pages by default in shmem?
>
> Not in the next kernel release, but eventually the plan is to allow
> arbitrary order folios to be used in shmem.  So you could ask it to creat=
e
> a 256kB folio for you, if that's the right size to manage memory in.
>
> How shmem and its various users go about choosing the right size is not
> quite clear to me yet.  Perhaps somebody else will do it before I get
> to it; I have a lot of different sub-projects to work on at the moment,
> and shmem isn't blocking any of them.  And I have a sneaking suspicion
> that more work is needed in the swap code to deal with arbitrary order
> folios, so that's another reason for me to delay looking at this ;-)

I have sent large folios support for shmem for the write and fallocate
path some releases ago. The main problem I was facing was a current
upstream problem with huge pages when seeking holes/data (fstests
generic/285 and generic/436). The strategy suggested was to use large
folios in an opportunistic way based on the file size. This hit the
same problem we currently have with huge pages and I considered that a
regression. We have made some progress to fix seeking in huge pages
upstream but is not yet finished. I can send the patches tomorrow for
further discussion.

>

