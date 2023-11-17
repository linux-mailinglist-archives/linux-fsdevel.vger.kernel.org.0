Return-Path: <linux-fsdevel+bounces-3019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBB77EF4EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C202811F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A537152;
	Fri, 17 Nov 2023 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JrPCTJa+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B255D1AD
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 07:13:58 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso3199475a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 07:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1700234037; x=1700838837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Oo189R36r9S1P5c11qiLhRbRaLL1RPe2gX3RGHrDug=;
        b=JrPCTJa+oNx/yxLHdc3BtbQcpBIUyO8JIu7mx0UHx5aE5JWC+19EWeeF19Y7fdRYi9
         AhrY69cGPvg+Mi4vQ4aNRVd2QRVykNAtY5UGKg4lv9v6YULNBQVHuvaDyGlPeHoZ1YFd
         6zvucP6pd1P3jlWeBnTgXS5sy2q823MHMHBrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700234037; x=1700838837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Oo189R36r9S1P5c11qiLhRbRaLL1RPe2gX3RGHrDug=;
        b=ugzZ2lFXLsMlyors/oSSDbrSPWNNAAwPBd8d3PBcAYESKA/xtFd48eqY2QFEvPubBI
         HgA09ReDV/iuyO7gU0+X4qAzFNca86o7xB3/Eb5Zxp782KMjyTJQnqg1HPMxuBMMazmL
         +k/X3F5jEAW13BFqBUiJhtgeBkRmV+9M0ptDR9oOuKOV9o1miFIUERZzadfRIRlsNObE
         FJnUI7S8+xwbfgiBjhxy2jTKMelb5PhjzhbPLGVMV4TGjfviFHae1BxuavBL/xLRNyxi
         b+NUp5C/Jh9BLIeR6BDfNZjBpm+0JUZeY6e4H1jqvxID6iW7IhF0KhAu+MUtCF5aSE43
         3isA==
X-Gm-Message-State: AOJu0YzAkCDeKuR1+XGM0CcOZFXbFjrNXTKsVjUGRK6PqfGT9DZcnsEv
	oqYn7vai9u2vQhhW0B5mONMYsEJ0GyL1ABECkImHEQ==
X-Google-Smtp-Source: AGHT+IHMUXnjmlNoD8wvqNvaWmdh3jNGp37NhE+vXpAEq21urujA7z030N8vV5bqDLo2H5+mjckvnRSnPDlR0gomq3o=
X-Received: by 2002:a17:906:738d:b0:9f8:a622:d670 with SMTP id
 f13-20020a170906738d00b009f8a622d670mr1439944ejl.19.1700234037204; Fri, 17
 Nov 2023 07:13:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
 <87fs15qvu4.fsf@oldenburg.str.redhat.com> <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
 <87leawphcj.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87leawphcj.fsf@oldenburg.str.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 17 Nov 2023 16:13:45 +0100
Message-ID: <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
Subject: Re: proposed libc interface and man page for statmount(2)
To: Florian Weimer <fweimer@redhat.com>
Cc: libc-alpha@sourceware.org, linux-man <linux-man@vger.kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, Linux API <linux-api@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Nov 2023 at 15:47, Florian Weimer <fweimer@redhat.com> wrote:

> The strings could get fairly large if they ever contain key material,
> especially for post-quantum cryptography.

A bit far fetched, but okay.

> We have plenty of experience with these double-buffer-and-retry
> interfaces and glibc, and the failure mode once there is much more data
> than initially expected can be quite bad.  For new interfaces, I want a
> way to avoid that.  At least as long applications use statmount_allloc,
> we have a way to switch to a different interface if that becomes
> necessary just with a glibc-internal change.

Fair enough.

And that brings us to listmount(2) where I'm less sure that the
alloc+retry strategy is the right one.  I still think that a namespace
with millions of mounts is unlikely, but it's not completely out of
the question.   Also a listmount_alloc(3) API is less obvious since
the mount ID array as well as its size needs to be returned.    So I'm
thinking whether it's a good idea to turn this into a
open/list/.../close style of interface in libc?  We could do that in
the kernel as well, but I'm not sure it's worth it at this point.

Thanks,
Miklos

