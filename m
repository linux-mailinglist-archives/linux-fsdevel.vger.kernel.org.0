Return-Path: <linux-fsdevel+bounces-855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1A7D16C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 22:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E01B1C21025
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B82241EF;
	Fri, 20 Oct 2023 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EfK/H/GL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6651DA59
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 20:06:55 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB84D63
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 13:06:54 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso18486351fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697832412; x=1698437212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FJwcfh7XT4p/d8xdEQd3o4yb8QA8P7Clkcjdf6k/CEg=;
        b=EfK/H/GLHx0/aqNqd/ehf8SerD5bueKNAIIvBIi/aGQCOt1XlGC78879l7Zp7buCuL
         t2CV3kMlUg1OVKtRm9uNuIoRI+jylsojzmhVpdG7jt/RF28GUQkpJqfmQYQpuga5Npo8
         yLM/mZfrOpsTh504cehZyfwfrx15cTdPW5KAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697832412; x=1698437212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJwcfh7XT4p/d8xdEQd3o4yb8QA8P7Clkcjdf6k/CEg=;
        b=tRcBk2OUw1wDx04K7N4wLL2Idottv1ZlkoOcWVOB2JfF4JFkotmfuUHEndGe5tupfE
         saXn8XH3Bjyl7E8Km0cVh7RxGzqP8CxKGxMmz+VSQ17URPC3bljJPqbgPNggj/3BVVSX
         LQzxrkB3WdkCll8f6E34KAwJFI/TmubJWZpSA2xKTJjoyeEQvkd+7NzIUclLe+nOs+vC
         8kUg5EWBzMj1aFeFv2N3um5ukIgO+oWwLUaqWdRfiBdQCiSPcsGs8vBbMhqlMBXYBQRy
         Cnk4GXSECCtjjZGRQL9mQYKZj33IL5tA1E95NAwKSGGn8V4eykZ0uFQVOsdRDjKIjHix
         L24w==
X-Gm-Message-State: AOJu0YyESFOKKc1EdZUlLTGvDcZ4mXu8YMIgcuckzLgUUoweX2N/DCL8
	ZPjahT1DpPUFwdlY7XMLAxy+R/BwP+SIgg+EJGKjUqBg
X-Google-Smtp-Source: AGHT+IFja2SAnKeLs1TZFJrYJVyRwu1Fit9Wzi7Bpo3sIdPzvLQw3ZXeYPyXyvlv2+C/c+vZTzE+Hw==
X-Received: by 2002:a2e:b790:0:b0:2c2:a337:5ea with SMTP id n16-20020a2eb790000000b002c2a33705eamr2117652ljo.27.1697832411744;
        Fri, 20 Oct 2023 13:06:51 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9913000000b002c514b5931esm512867lji.7.2023.10.20.13.06.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 13:06:51 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-507c5249d55so1682604e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 13:06:51 -0700 (PDT)
X-Received: by 2002:a17:907:c1f:b0:9ba:65e:752b with SMTP id
 ga31-20020a1709070c1f00b009ba065e752bmr2061794ejc.39.1697832390868; Fri, 20
 Oct 2023 13:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org> <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner> <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
In-Reply-To: <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Oct 2023 13:06:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjma9_TSwXosG7GBXQaZ465VH1t4a4iQ8J=PFpE=4bhVA@mail.gmail.com>
Message-ID: <CAHk-=wjma9_TSwXosG7GBXQaZ465VH1t4a4iQ8J=PFpE=4bhVA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To: Jeff Layton <jlayton@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
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

On Fri, 20 Oct 2023 at 05:12, Jeff Layton <jlayton@kernel.org> wrote:.
>
> I'd _really_ like to see a proper change counter added before it's
> merged, or at least space in the on-disk inode reserved for one until we
> can get it plumbed in.

Hmm. Can we not perhaps just do an in-memory change counter, and try
to initialize it to a random value when instantiating an inode? Do we
even *require* on-disk format changes?

So on reboot, the inode would count as "changed" as far any remote
user is concerned. It would flush client caches, but isn't that what
you'd want anyway? I'd hate to waste lots of memory, but maybe people
would be ok with just a 32-bit random value. And if not...

But I actually came into this whole discussion purely through the
inode timestamp side, so I may *entirely* miss what the change counter
requirements for NFSd actually are. If it needs to be stable across
reboots, my idea is clearly complete garbage.

You can now all jump on me and point out my severe intellectual
limitations. Please use small words when you do ;)

              Linus

