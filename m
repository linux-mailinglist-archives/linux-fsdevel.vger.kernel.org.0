Return-Path: <linux-fsdevel+bounces-971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B006D7D46A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 06:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32FC1C208D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 04:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E401749D;
	Tue, 24 Oct 2023 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H1znKBTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D46FD5
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 04:10:58 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B099010E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 21:10:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso6014476a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 21:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698120655; x=1698725455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R/DnLkXKcbtHeIdj2lNteiEcRFjQW0/FCeNT137Lkzs=;
        b=H1znKBTvR8Dtpn1RvannnzT4eVrs+3dMxIZaC1Wj9QVCzSTtvguQaXDVvDiWR/ImXr
         iV/IZ2Ra7f6Gwu2EgfX+fW/ekeTCtJiGi1SkF46h7/HG+oM/LeA6YqQ750mQ6oVmZLW2
         358cLs0K2urRk0tB0K0VA5haX4+C5LgHDrEE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698120655; x=1698725455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/DnLkXKcbtHeIdj2lNteiEcRFjQW0/FCeNT137Lkzs=;
        b=vRSodmaBjY5HPQJqjP8PhINn2rzTPvviTKKluebj0gZVPA2DZ6MVfqFOramFIi4etx
         ZhNY3nqE37+kr1iQOf6CqDLn2hwaCnKXUWrcO7zb3paZMU6kvlV7Va0MWYUlXxfTFv2A
         HFWsDhc3vpTUZPMMEugJ7tRVskoohdRu5dPdC+eBt5ZSs/5TfKdW8VAGdlnWPDdfR0TQ
         LcymLrBLVcCVFRmjc5eZTwo58daCRoLTAraaaHfIOdCILlc0Pp3djQxJL2ukJMIfNmHO
         qZ27FBjqKjQON2s8IcnGBMB2IOQQXRtmoSKfBteJmS+p5c2zvuu3+2qHV4VTxCwqE0s/
         BI2g==
X-Gm-Message-State: AOJu0YxKN6iW0qLlrJ2tpkgfOJWl7Iss4N/TN4k9EwCMWqRt1Hq6j46Y
	djP6GOUXu56YIG6lnkVtMzo2XeSpTb/ZO5EjgWlap8lP
X-Google-Smtp-Source: AGHT+IHcf5gdWKaGilnpvDa8NkHVyY/gPtgNC8BVlF8rdg/hW2GjHe95vBLQ8mk5rAyMDa4qsYmGGw==
X-Received: by 2002:a50:cbc4:0:b0:53e:3a80:e6f1 with SMTP id l4-20020a50cbc4000000b0053e3a80e6f1mr7630991edi.32.1698120654929;
        Mon, 23 Oct 2023 21:10:54 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id s21-20020a056402037500b0053e0395059csm7086235edw.21.2023.10.23.21.10.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 21:10:54 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-32da7ac5c4fso2763698f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 21:10:54 -0700 (PDT)
X-Received: by 2002:a05:6402:274e:b0:53e:8e09:524d with SMTP id
 z14-20020a056402274e00b0053e8e09524dmr2329463edd.5.1698120632873; Mon, 23 Oct
 2023 21:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner> <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area> <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area> <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area>
In-Reply-To: <ZTc8tClCRkfX3kD7@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Oct 2023 18:10:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjUWM8VVJxUYb=XfqvrS38ACS8RxK2ac9qGp9FDT=USkw@mail.gmail.com>
Message-ID: <CAHk-=wjUWM8VVJxUYb=XfqvrS38ACS8RxK2ac9qGp9FDT=USkw@mail.gmail.com>
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

On Mon, 23 Oct 2023 at 17:40, Dave Chinner <david@fromorbit.com> wrote:
> >
> > Maybe we don't even need a mode, and could just decide that atime
> > updates aren't i_version updates at all?
>
> We do that already - in memory atime updates don't bump i_version at
> all. The issue is the rare persistent atime update requests that
> still happen - they are the ones that trigger an i_version bump on
> XFS, and one of the relatime heuristics tickle this specific issue.

Yes, yes, but that's what I kind of allude to - maybe people still
want the on-disk atime updates, but do they actually want the
i_version updates just because they want more aggressive atime
updates?

> > Or maybe i_version can update, but callers of getattr() could have two
> > bits for that STATX_CHANGE_COOKIE, one for "I care about atime" and
> > one for others, and we'd pass that down to inode_query_version, and
> > we'd have a I_VERSION_QUERIED and a I_VERSION_QUERIED_STRICT, and the
> > "I care about atime" case ould set the strict one.
>
> This makes correct behaviour reliant on the applicaiton using the
> query mechanism correctly. I have my doubts that userspace
> developers will be able to understand the subtle difference between
> the two options and always choose correctly....

I don't think we _have_ a user space interface.

At least the STATX_CHANGE_COOKIE bit isn't exposed to user space at
all. Not in the uapi headers, but not even in xstat():

        /* STATX_CHANGE_COOKIE is kernel-only for now */
        tmp.stx_mask = stat->result_mask & ~STATX_CHANGE_COOKIE;

So the *only* users of STATX_CHANGE_COOKIE seem to be entirely
in-kernel, unless there is something I'm missing where somebody uses
i_version through some other interface (random ioctl?).

End result: splitting STATX_CHANGE_COOKIE into a "I don't care about
atime" and a "give me all change events" shouldn't possibly break
anything that I can see.

The only other uses of inode_query_iversion() seem to be the explicit
directory optimizations (ie the "I'm caching the offset and don't want
to re-check that it's valid unless required, so give me the inode
version for the directory as a way to decide if I need to re-check"
thing).

And those *definitely* don't want i_version updates on any atime updates.

There might be some other use of inode_query_iversion() that I missed,
of course.  But from a quick look, it really looks to me like we can
relax our i_version updates.

              Linus

