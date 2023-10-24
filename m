Return-Path: <linux-fsdevel+bounces-968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FBC7D43DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 02:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62029281776
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 00:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47C91118;
	Tue, 24 Oct 2023 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NFkz4IY8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28510E5
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 00:18:54 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129BF10C
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 17:18:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ba081173a3so616449166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 17:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698106731; x=1698711531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iY8F6Fplz1VZOzDrso9gBBR3Wotc9sRtBic5aJbz6WE=;
        b=NFkz4IY8yN89v12HPfLxH+qlwrs2qNUsUulQ5ZRSJHMsg3pU5tq9gXsABmSrkxlrZd
         +cRzmR+NOKzFXMaXPlivzyfHFXat73apu1eFNdnDXH/Jv4LOkb2G1Qk1OMkR5mP7BlgM
         pFm3IGzM7xd1KOPF2yN8/pws6EU2LMbNoCyFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106731; x=1698711531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iY8F6Fplz1VZOzDrso9gBBR3Wotc9sRtBic5aJbz6WE=;
        b=UotUBdGADB1QSd2Ft1rWAekYU5G7i3KroiQ0MHE4Ro00fFwiDYYSYvTDSVEKQUBV1G
         3VDgipAtzLBogH4sUZcWk765MzZi0VfIQTN20wtWbdgfi1W1+y9atIzRmUPX0wbIPiiP
         UBBRfH0teLNrqcIT2p4STZbbIkxTRl+4+Wn9oftB2l/XfhUUMS54DbFgnIKgn9bF3SMq
         3NXjIgQNpwsMVXFeGezH6a4C6bzFy6wYncyNLHnIMQ22RAmoDA+miLFXCAtaEZCmdLGq
         wIslwCo/paMH9c1u+pfD9xLkOsL2qPQchU5kKpyenw5FOD7PavbO5aS3mQAnNsOCcZkC
         ULZw==
X-Gm-Message-State: AOJu0YzzHWGMYzo3S92sBr85sRFSfmtlu5jg5N2nJs5XIb9h6o5P5apo
	0Jvv7Hp0EJAG9O2iBYvH8IC+tk+wI+8ZGWXDfpzfSy/Z
X-Google-Smtp-Source: AGHT+IFvsknSifydLT3sEfbyChttVxkBQ0dI10QmiuHMlpJH2lalXQOLBe74QB6ybg5VStbdF4IbZw==
X-Received: by 2002:a17:906:dace:b0:9c7:db3:8b31 with SMTP id xi14-20020a170906dace00b009c70db38b31mr9542847ejb.59.1698106731473;
        Mon, 23 Oct 2023 17:18:51 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id ga23-20020a170906b85700b009b65b2be80bsm7310887ejb.76.2023.10.23.17.18.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 17:18:51 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9a6190af24aso618505966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 17:18:50 -0700 (PDT)
X-Received: by 2002:a50:d795:0:b0:53e:467c:33f1 with SMTP id
 w21-20020a50d795000000b0053e467c33f1mr8315209edi.8.1698106710154; Mon, 23 Oct
 2023 17:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner> <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area> <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
In-Reply-To: <ZTcBI2xaZz1GdMjX@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Oct 2023 14:18:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
Message-ID: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To: Dave Chinner <david@fromorbit.com>
Cc: Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> wrote:
>
> The problem is the first read request after a modification has been
> made. That is causing relatime to see mtime > atime and triggering
> an atime update. XFS sees this, does an atime update, and in
> committing that persistent inode metadata update, it calls
> inode_maybe_inc_iversion(force = false) to check if an iversion
> update is necessary. The VFS sees I_VERSION_QUERIED, and so it bumps
> i_version and tells XFS to persist it.

Could we perhaps just have a mode where we don't increment i_version
for just atime updates?

Maybe we don't even need a mode, and could just decide that atime
updates aren't i_version updates at all?

Yes, yes, it's obviously technically a "inode modification", but does
anybody actually *want* atime updates with no actual other changes to
be version events?

Or maybe i_version can update, but callers of getattr() could have two
bits for that STATX_CHANGE_COOKIE, one for "I care about atime" and
one for others, and we'd pass that down to inode_query_version, and
we'd have a I_VERSION_QUERIED and a I_VERSION_QUERIED_STRICT, and the
"I care about atime" case ould set the strict one.

Then inode_maybe_inc_iversion() could - for atome updates - skip the
version update *unless* it sees that I_VERSION_QUERIED_STRICT bit.

Does that sound sane to people?

Because it does sound completely insane to me to say "inode changed"
and have a cache invalidation just for an atime update.

              Linus

