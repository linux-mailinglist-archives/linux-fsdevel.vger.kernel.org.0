Return-Path: <linux-fsdevel+bounces-1369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E749F7D9A5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17CC282504
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8202262A1;
	Fri, 27 Oct 2023 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="c6H+fb8l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30B22F00
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 13:48:06 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1036B18A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:48:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b95622c620so341106966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698414481; x=1699019281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H1XE51H4eKhgCVlGJOwgRMY69+bD+zVcX+hrD/xqNek=;
        b=c6H+fb8lb2C+dj4OL0egeziow8073Rtb/w49STNgoYLwe266Euk3eLbAZHrSW/c300
         GXkUtOpA1KtkaZ5N6xNTz8/NEzQhCAA+h77LrYKP9kXK4WQq/arQhX2RvwmuRvRkY/+Z
         X65AhfDMFSP54EG8PR2gQd0CL2x71naPa2ptk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698414481; x=1699019281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1XE51H4eKhgCVlGJOwgRMY69+bD+zVcX+hrD/xqNek=;
        b=S3Ud8z7vVz+/QOHXJDfqJwYL6qEWLb6u4ube0kBB98Gd3ocktpnJNF2Wny5cvBgFjl
         w/F8oSxnzm40ZW50qgHWfDXcZfjE97+u+sXwRDfpj9kBDEDboBOjrIf9mc7AO0vUPKT5
         BKd/4T4NThXMCfy1QZ9xBWeFYHdm+KTQHD7xL0JLElJ0kNsKkYA+huDDnKd0S5dPtn5M
         3bBHaMKnZb4LFkiLilP1YN3jcU8T478fiVeRGl2xZ26rvu1LukEwE5UxbxqJZDMlyYUW
         nBf7Nwwg5ZN0efjsrlpwjplq4+KioyxupiMz/aJUsHMQvYtaGXBMOXLFwSCEyEcdHcwn
         hAnA==
X-Gm-Message-State: AOJu0Yz5HGMmLmdFjZFd4OpM0DG4lKPy1mMRwd5PAn3C2F2KnqtlsIqd
	/IE8OS2uj4tYbw81UpVHYRAEjKWZqvR4558ByZgKkQ==
X-Google-Smtp-Source: AGHT+IHil2gjjEGrUQKPqSQUgORWJ8HAg7LUAIgtyl2UliZKmVyaYIe5jhhmk8vP47QdenJyVUIHyJ3V+NZ0swDedg8=
X-Received: by 2002:a17:907:2686:b0:9b2:955a:e375 with SMTP id
 bn6-20020a170907268600b009b2955ae375mr2248619ejc.23.1698414481262; Fri, 27
 Oct 2023 06:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025135048.36153-1-amir73il@gmail.com> <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting> <ZTtOmWEx5neNKkez@infradead.org> <20231027131726.GA2915471@perftesting>
In-Reply-To: <20231027131726.GA2915471@perftesting>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Oct 2023 15:47:49 +0200
Message-ID: <CAJfpeguvpp-a3p1FdYyRsVUUzueqGFVqqAB3yoYO7HsQdyqdLQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Oct 2023 at 15:17, Josef Bacik <josef@toxicpanda.com> wrote:

> I have to support this file system in the real world, with real world stupidity
> happening that I can't control.  I wholeheartedly agree that the statx fields
> are not a direct fix, it's a comprimise.  It's a way forward to let the users
> who care about the distinction be able to get the information they need to make
> better decisions about what to do when they run into btrfs's weirdness.  It
> doesn't solve the st_dev problem today, or even for a couple of years, but it
> gives us a way to eventually change the st_dev thing.  Thanks,

This is very similar to the problem that overlayfs is trying hard to
work around: unifying more than one st_ino namespace into a single
st_ino namespace.    Btrfs used st_dev, overlayfs is using the high
bits of st_ino.  Both of these are hacks.

Adding one more 64bit field doesn't look like a proper solution: now
overlayfs will have to fit multiple 128bit namespace into a single
128bit namespace.

Not sure what's the right answer, but file handles come to mind, since
they have some nice properties:

 - not reused after unlink
 - variable length

Thanks,
Miklos

