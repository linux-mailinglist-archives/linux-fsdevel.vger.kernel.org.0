Return-Path: <linux-fsdevel+bounces-7227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC5F822FEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 15:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C36D285E56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC511BDCF;
	Wed,  3 Jan 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="iUiwPmTT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088A1B286
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336788cb261so9455274f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 06:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1704293832; x=1704898632; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=xNnLe8eCfNONJjjsfqPVQ6sPt/jljKMtvm2sVnHboe4=;
        b=iUiwPmTTau4LqJtkwskVNchaagMPQtffqEkIj9j9UAz/ttUad3ni2V5YzC2mjlYXAw
         ekXANMQKKRxZ9SeBVOme3vCrKnbSQ9199DFeBj0D6830V1UW5fftTb1qCegIvs6/d7tq
         qZysJkn18Pglty5TMEzDPE03z9EbQgE6/6tFwLDRGjFTL+pv8XUEvjl5eQjdisDbplQe
         687OlmHlz8vyIItpDxBOaLrsFbtK9rSjntSRxjVzTfNoYG1DIHVslIgmHolQdO7Vmlla
         dbb/SUvQ/vthJ2XANTtP1g5B3Fw8G3Q5JwFU2RGGve+3SvbdNStBwFNCocNwVhIzMtTO
         trHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293832; x=1704898632;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNnLe8eCfNONJjjsfqPVQ6sPt/jljKMtvm2sVnHboe4=;
        b=H1CnN/dS2vuvlxbkQljyVnQDE/elI03QFnDjjRqz8q8oTmWvM9iqb8PEPfWqEHePwt
         FLYJk7lxO4j7QXppOLWLkw475Sb/r6wfWqiKGFZx71uUAS2SU2f2BW6/lmp45zChuEW0
         inRwmxn0cMJaUlBxqcqu8bayNbLHrHi3pydMHT2ZyOy++7rh2kEZUqFsU3V1OxgQxSXs
         RAvoJlXQ1pWLKRmDDO7hsk0mKqr5b83stkM1FqBpCQLaMD1bCI38do/v96FZBULTREXG
         DqOXqrQGK8un+MAjMvEc8nTsL/aQ7aUy8mx94Aa6UhiWBML6KJkZ+OaCOL2VPbeS0Igz
         rlNQ==
X-Gm-Message-State: AOJu0YyAz+4g1FZMkKb8M5OUo+mi/boReqiJ67UJrJ7ewkCRDmrCbyUg
	KgGGp05YS8xEH+MapRsJFfzEc5bma+b6Hw==
X-Google-Smtp-Source: AGHT+IH4sf2+ssviuTdeEuIGZW/2oKnZ5pOWev31vaXfqEnwHVDi6hIZlpm9eUjYSVujHhpxzm3zKQ==
X-Received: by 2002:a05:6000:1a45:b0:337:39db:2fd7 with SMTP id t5-20020a0560001a4500b0033739db2fd7mr2940403wry.96.1704293832251;
        Wed, 03 Jan 2024 06:57:12 -0800 (PST)
Received: from localhost ([165.225.194.221])
        by smtp.gmail.com with ESMTPSA id s10-20020adfdb0a000000b003367d48520dsm31011203wri.46.2024.01.03.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:57:11 -0800 (PST)
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-13-wedsonaf@gmail.com>
User-agent: mu4e 1.10.8; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent
 Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Wedson Almeida Filho
 <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 12/19] rust: fs: introduce `FileSystem::statfs`
Date: Wed, 03 Jan 2024 15:13:48 +0100
In-reply-to: <20231018122518.128049-13-wedsonaf@gmail.com>
Message-ID: <87frze5uv2.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Wedson Almeida Filho <wedsonaf@gmail.com> writes:

[...]

> +    unsafe extern "C" fn statfs_callback(
> +        dentry: *mut bindings::dentry,
> +        buf: *mut bindings::kstatfs,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The C API guarantees that `dentry` is valid for read. `d_sb` is
> +            // immutable, so it's safe to read it. The superblock is guaranteed to be valid dor

"valid dor" -> "valid for"

BR Andreas

