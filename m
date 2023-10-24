Return-Path: <linux-fsdevel+bounces-1122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033377D5BAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 21:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CDD1C20B80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 19:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B3A3D386;
	Tue, 24 Oct 2023 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JMfidq6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646B3D385
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 19:40:53 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B8210D7
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 12:40:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so695004566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698176447; x=1698781247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dQAl0rC44IDpm4wzCCiFnwdE9x2WCYlyNzW0Sdf0Q28=;
        b=JMfidq6EgMaFyyDQKdWBkNW5O5IXK/RwKfZjZaLbgAGaF8LoDV1WIQbcplr4wCBJun
         NH7wHqSHxmoDmo9/XoQgUrOQ6skmklRePpSPdzmgJysshchS4FoE+noAZGLhd0VaOEIc
         peLSrEJoImRqd+55FZ4V0T3Gcho7mdAlbOkHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176447; x=1698781247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQAl0rC44IDpm4wzCCiFnwdE9x2WCYlyNzW0Sdf0Q28=;
        b=ihUA1dL6ZNV0mYcI28P008Wiu8A1bjqSyv38H+xpHPHdeMyxXTGpQ+UMQsU+4JQa5G
         suh2r7u1GLOi3XusiA3rJ8j+NyE6F6EN2Wyrm/T8yDJbF5h/60HwQBUyUCNNxpOYStqd
         BSpJ1AlkC7hbpk7jDvTvs0aKgl+2hOtwdgbfw8iAogKD+VdCWEF/FzrWWEZa6eZeQcGy
         wzb+gm+3uvTuO4n5/7Q/vVKvVSU47gyWcGPEPxleCTlx+VRasYQebQ9KGkA7JJHLJHzw
         oUXQgPX23qmjuRyvsewYYD8kVNmXzZjC/F6J0Ob+zqvTtMNkbIN9EMH8DwJyrbNqdD0J
         md0g==
X-Gm-Message-State: AOJu0Yx27x58pflGjGvYLhFlvy8TfE9d0eKdKfe2nao/n3IP+D+3hwUK
	T6ShflD/Z0MCynuYCwCw4t8jfY/Hy7q4SVe2mJtGiaLi
X-Google-Smtp-Source: AGHT+IFmURlDdecg2MTYGh3reZA/iW++ngdDp/qeJlXJyW8HkKmIxYcV5qIwFaPTFhqdn+fH0Yf+aA==
X-Received: by 2002:a17:906:6a19:b0:9c7:5a01:ffe7 with SMTP id qw25-20020a1709066a1900b009c75a01ffe7mr10483179ejc.12.1698176447289;
        Tue, 24 Oct 2023 12:40:47 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id jg36-20020a170907972400b0099d798a6bb5sm8737536ejc.67.2023.10.24.12.40.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 12:40:47 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9c75ceea588so693002866b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 12:40:46 -0700 (PDT)
X-Received: by 2002:a17:906:eecd:b0:9bd:9bfe:e410 with SMTP id
 wu13-20020a170906eecd00b009bd9bfee410mr9262779ejb.72.1698176425825; Tue, 24
 Oct 2023 12:40:25 -0700 (PDT)
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
 <ZTcBI2xaZz1GdMjX@dread.disaster.area> <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <2c74660bc44557dba8391758535e4012cbea3724.camel@kernel.org>
In-Reply-To: <2c74660bc44557dba8391758535e4012cbea3724.camel@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Oct 2023 09:40:08 -1000
X-Gmail-Original-Message-ID: <CAHk-=wibJqQGBXAr2S69FifUXdJJ=unAQT5ag0qRSQNxGk31Lw@mail.gmail.com>
Message-ID: <CAHk-=wibJqQGBXAr2S69FifUXdJJ=unAQT5ag0qRSQNxGk31Lw@mail.gmail.com>
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

On Tue, 24 Oct 2023 at 09:07, Jeff Layton <jlayton@kernel.org> wrote:
>
> The new flag idea is a good one. The catch though is that there are no
> readers of i_version in-kernel other than NFSD and IMA, so there would
> be no in-kernel users of I_VERSION_QUERIED_STRICT.

I actually see that as an absolute positive.

I think we should *conceptually* do those two flags, but then realize
that there are no users of the STRICT version, and just skip it.

So practically speaking, we'd end up with just a weaker version of
I_VERSION_QUERIED that is that "I don't care about atime" case.

I really can't find any use that would *want* to see i_version updates
for any atime updates. Ever.

We may have had historical user interfaces for i_version, but I can't
find any currently.

But to be very very clear: I've only done some random grepping, and I
may have missed something. I'm not dismissing Dave's worries, and he
may well be entirely correct.

Somebody would need to do a much more careful check than my "I can't
find anything".

             Linus

