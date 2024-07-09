Return-Path: <linux-fsdevel+bounces-23382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B23892B8E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40425284DB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 11:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E76E158A30;
	Tue,  9 Jul 2024 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhm5gC6f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A4155382;
	Tue,  9 Jul 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526285; cv=none; b=Pk7Fyhe67J91Is0+21G3+zJZxvs35fX+rEVDlSp+30ft2TG7URiGa+R95EiRnVYC5DEAKKIX3uck0hBrTONTcuOQPj8ZPxpjrCTkiWf8Rmdem6yU3mq52TOEydLjivAdFeyLLa1/PNfL8btAJ6hPgUlrnOOqX2DhxHRn96Kme8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526285; c=relaxed/simple;
	bh=ytuKm+J68F8Du0utfZT0wy06NyswShgjN+kzFNx4WOU=;
	h=Message-ID:Subject:From:To:Cc:Date:References:Content-Type:
	 MIME-Version; b=RURBEnb5vlsORLwust3NImncytI2oJ5LylfRlghwNDTY9eHFPoEvuUa9u48benNqkn6EphXEtnDJ07UO1PKBC6f0mxIwmwJg542kES2aMxUlq7Y94JIheTnhpAF2qtYeH2P1L0mspxD1KBxpd3Cb5F9v/Npr1UWAvSsWQ8U7/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhm5gC6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D01C32786;
	Tue,  9 Jul 2024 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720526284;
	bh=ytuKm+J68F8Du0utfZT0wy06NyswShgjN+kzFNx4WOU=;
	h=Subject:From:To:Cc:Date:References:From;
	b=bhm5gC6f4bCaGf3KYMmeuVuQjvH0KO3dkOoFciI0MmFOsKeltmooRos9N+Ej3wLGa
	 Js/IfZdjkVxGJFfmi2rz97ANQTTKcs37dnHtKWwurblAly5HY/TUukrgDovG+UwzIk
	 az1K+AoMPMU1o2jJPbn127Bzr1jDCzAxPKaRUgWl9cqm3SOU93LcLtAaclUIzWUQVr
	 HSiRg4XPbgGihsKw9yRPpAaVrbnsx140HjBVJo5GSQV91cDtlMyj+TmVYrZbqUH/yH
	 WQxWZ/BphRO7la+J00np5BGuGmALjUjgsd7LC/z3Qlfpsb7FIaDyI8FaZ5PdqMOGzg
	 WPe+Z+rf+9Fvg==
Message-ID: <c1d4fcee3098a58625bb03c8461b92af02d93d15.camel@kernel.org>
Subject: Fwd: [jlayton:mgtime 5/13] inode.c:undefined reference to
 `__invalid_cmpxchg_size'
From: Jeff Layton <jlayton@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Date: Tue, 09 Jul 2024 07:58:03 -0400
References: <202407091931.mztaeJHw-lkp@intel.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: multipart/mixed; boundary="=-pI+W7gA8jU7BvhCoJ/+E"
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-pI+W7gA8jU7BvhCoJ/+E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've been getting some of these warning emails from the KTR. I think
this is in reference to this patch, which adds a 64-bit try_cmpxchg in
the timestamp handling code:

    https://lore.kernel.org/linux-fsdevel/20240708-mgtime-v4-0-a0f3c6fb57f3=
@kernel.org/

On m68k, there is a prototype for __invalid_cmpxchg_size, but no actual
function, AFAICT. Should that be defined somewhere, or is this a
deliberate way to force a build break in this case?

More to the point though: do I need to do anything special for m86k
here (or for other arches that can't do a native 64-bit cmpxchg)?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>

--=-pI+W7gA8jU7BvhCoJ/+E
Content-Disposition: inline
Content-Description: Forwarded message =?UTF-8?Q?=E2=80=94?= [jlayton:mgtime
 5/13] inode.c:undefined reference to `__invalid_cmpxchg_size'
Content-Type: message/rfc822

Delivered-To: jlayton@poochiereds.net
Received: by 2002:a05:6840:a05a:b0:1868:30e0:1b91 with SMTP id
 s26csp2141718nlm; Tue, 9 Jul 2024 04:41:32 -0700 (PDT)
X-Forwarded-Encrypted: i=2;
 AJvYcCVmB1k3maNpx1LDNc1A91iZlu6jOn1vFp6JYZa0a/MyZJBGCaQOsnxUCSdNL3wuTBZUfnyPVfsvIkwRFSD2AiJbZYr/J8T3gA==
X-Google-Smtp-Source:
 AGHT+IGO4p0CRHr1++kSKxppOqzc9unXWajhJMXaYuWUPZIiFaYUeK2qVsj3NggYMRIIpbZ2bGd0
X-Received: by 2002:a17:902:e5c2:b0:1fb:75b6:a40e with SMTP id
 d9443c01a7336-1fbb6d601dcmr18995115ad.45.1720525292732; Tue, 09 Jul 2024
 04:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1720525292; cv=none; d=google.com;
 s=arc-20160816;
 b=OxDrk1F4jlBzkr4XEJtM25mCkyRvQXZpVI2sqE+amYspGExFlRbhZrd8mh1wQn8Pps
 c01F6WIarIgL2QrIGsuA9ThI/wk/fWQ1VgBE0YTGqBbpW13316YYQlxgOL59r1Gup9c0
 NRKfB8LAyLLRrD9V2K5xEw3kPH4fPQgDq15goajWPZaWLLDFTCJExE/Fs90jd5wHZ7dl
 ogP53L8MsPuov5YXdmNj8/PlSWLEryx2Aq+WzkOmUCoRCvGa5QkHBjYhrz7VIPzTqCpb
 Sqsi+h4UMZMc3e3sbbvz/LdFL1f/iz9993+1oDX5+XYx8JCSXMkaAigBhBZ2XZ+oi5bZ +6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20160816;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :dkim-signature:dmarc-filter:delivered-to;
 bh=fp4wInhpYjV2aixZjBcpP8sNJTgUz58P0dXQltVokMs=;
 fh=pVpjrWokx+suM3VInIbJAR8sYUQKzjSbDwxWk5bUObQ=;
 b=z0CLAn09s+qJcsvQojLxvCX8xMjzqPjGa1VRXn2dxZJA6BgIuuCXViSpBMZyCDHgsX
 4d+3/luio8Y4lKwPJZfD1UplNEXWGmfgHH0zhkCMd2YQ0f4jrlpH9eEYSO8nQ1LfgpX7
 k4z3iLE4VEu8xAsQ3mXtGfMh8M0xzzulDAHhLAKEjKLZ838Inyf2r6C3Na3Z3ZX4wF6n
 AFpYMfXilw5fU7HKfrhL6qD9UnHhgtC3SlYcj/v957QnuDx/0E4iJgG8mVclmKzBhb5K
 M7KoHcHhiGscicZKDK1arJ2ks3DXoPLdHWnHF344YNmjDydIuxnXc+RJhnoYtqxxEKs/
 vWYQ==; dara=google.com
ARC-Authentication-Results: i=1; mx.google.com; dkim=pass
 header.i=@intel.com header.s=Intel header.b=nrrnfaux; spf=pass (google.com:
 domain of srs0=yxw6=oj=intel.com=lkp@kernel.org designates 145.40.73.55 as
 permitted sender) smtp.mailfrom="SRS0=YXW6=OJ=intel.com=lkp@kernel.org";
 dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
Return-Path: <SRS0=YXW6=OJ=intel.com=lkp@kernel.org>
Received: from sin.source.kernel.org (sin.source.kernel.org.
 [145.40.73.55]) by mx.google.com with ESMTPS id
 d9443c01a7336-1fbb6ad51f1si17765385ad.606.2024.07.09.04.41.32 for
 <jlayton@poochiereds.net> (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384
 bits=256/256); Tue, 09 Jul 2024 04:41:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of
 srs0=yxw6=oj=intel.com=lkp@kernel.org designates 145.40.73.55 as permitted
 sender) client-ip=145.40.73.55;
Authentication-Results: mx.google.com; dkim=pass header.i=@intel.com
 header.s=Intel header.b=nrrnfaux; spf=pass (google.com: domain of
 srs0=yxw6=oj=intel.com=lkp@kernel.org designates 145.40.73.55 as permitted
 sender) smtp.mailfrom="SRS0=YXW6=OJ=intel.com=lkp@kernel.org"; dmarc=pass
 (p=NONE sp=NONE dis=NONE) header.from=intel.com
Received: from smtp.kernel.org (transwarp.subspace.kernel.org
 [100.75.92.58]) by sin.source.kernel.org (Postfix) with ESMTP id
 5D51BCE1171 for <jlayton@poochiereds.net>; Tue,  9 Jul 2024 11:41:29 +0000
 (UTC)
Received: by smtp.kernel.org (Postfix)
	id 9AFAAC4AF0A; Tue,  9 Jul 2024 11:41:28 +0000 (UTC)
Delivered-To: jlayton@kernel.org
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CC7FC4AF0C
	for <jlayton@kernel.org>; Tue,  9 Jul 2024 11:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.kernel.org 1CC7FC4AF0C
Authentication-Results: smtp.kernel.org; dmarc=pass (p=none dis=none)
 header.from=intel.com
Authentication-Results: smtp.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720525287; x=1752061287;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RP32T3RKQMQt+vShPXINsjabD/ZiGWavrgUppvPjLTA=;
  b=nrrnfauxz2cLnLs2NivJrNRKBSaCVa1Z1JlTkvmRQx1USrk9LUT4e7h0
   6/JBhjatas60/5PwuO1mvjjB0a/t85HH/wF42NEJp+puGQ5dBsyipd9jc
   PdbjBK8bpRVCqOBb32dbsY+RI/Aw4Iwg619BqGBCgJJvTArLJKNYWrUTD
   Cinqcp/ih8fOMO8iZ7aM3GOAoVtxQCCDnFW5lyFaNUAEShgV3Gx/0kn73
   0OtNEnY3qs6QU7YYDScXtMc7YT2myUiutHmlk2XTxKQTHWf+H/LZxzxSU
   MeEDbL7KvLIEHnRK2WmRDE7FRfTusoNXPuHK50dHqgK38U1uegud8nlTP
   A==;
X-CSE-ConnectionGUID: YaidnIlWRn+StATDhIXh3g==
X-CSE-MsgGUID: 3szOpmabTzG9WoMNNg77Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17642825"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="17642825"
Received: from fmviesa006.fm.intel.com ([10.60.135.146]) by
 fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul
 2024 04:41:26 -0700
X-CSE-ConnectionGUID: GjLOCiQoSoSfgSNueGojzQ==
X-CSE-MsgGUID: h6VGuvMzRLao1b8rIoCisQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="47615286"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b)
 ([10.239.97.150]) by fmviesa006.fm.intel.com with ESMTP; 09 Jul 2024
 04:41:24 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sR9Dm-000Wcp-2s;
	Tue, 09 Jul 2024 11:41:22 +0000
Date: Tue, 9 Jul 2024 19:40:55 +0800
From: kernel test robot <lkp@intel.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: [jlayton:mgtime 5/13] inode.c:undefined reference to
 `__invalid_cmpxchg_size'
Message-ID: <202407091931.mztaeJHw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git mgtime
head:   81b2439edd7c9f966afcb091f414b7f219cda8f6
commit: 2265b64634f4af479ffb0c478409cfd56ec6dc4d [5/13] fs: add infrastructure for multigrain timestamps
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240709/202407091931.mztaeJHw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240709/202407091931.mztaeJHw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407091931.mztaeJHw-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: fs/inode.o: in function `inode_set_ctime_current':
>> inode.c:(.text+0x167a): undefined reference to `__invalid_cmpxchg_size'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--=-pI+W7gA8jU7BvhCoJ/+E--

