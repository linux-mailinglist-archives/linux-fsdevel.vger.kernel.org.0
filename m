Return-Path: <linux-fsdevel+bounces-288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A95627C89C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FFEB20FC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00C11CABC;
	Fri, 13 Oct 2023 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CgWHbEBf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EED2137B
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:05:15 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB6A192
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:05:12 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d77ad095f13so2261156276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697213111; x=1697817911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJIUpMJ5wACe5qVMzOsP9GUn7pUpbtvNyTj02yy63pw=;
        b=CgWHbEBf4CeGZwSS+Iwwm7byS3IDHNWp24uKKZbOOQe7dvaAXNdUmD2AJS0AlaY6sf
         d0dNs2V8Yx4bft/zp19dYJpFSOCybDGaO0SxkkkHbHggJitkqpdvjzzc/zxDC1VutWWo
         eBrQBRYfYzbB3gn5kZiKQ+7IG2xTbLmOqF4qeuiy5Kj9MD9bVqQm85nL5hoPoCEuDVMw
         fjmE5kscePYUzzT9NpAO3YQT2KxY9ct7Lvi6C1pYu+Ox85r7gYrZ7LwGpVt00JOjJLqo
         w4s7HGy/IeKKkaYgQkPVJ267XujjkI8KpkoFnhcLOwjZ5yI+UZAMpMvB5E8mh9KykRAG
         VevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697213111; x=1697817911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJIUpMJ5wACe5qVMzOsP9GUn7pUpbtvNyTj02yy63pw=;
        b=l6HayjqT6zqWqQWZlQ8AcJoUq6hPqHB7J+1vOkbdn9asbQDBmMGe1jv89NiZmXhBk5
         I1wT+eRPxBeSEYeNNB/OcGS26Iydm4OsQx8T7XyOFlLOsicvN4Sp1Cvqac1FLX23Ycua
         1n59Jm71C73hQvVObv/eQRJxs/mXI77Fqv34Ll3rcu/Y27wDClQyNQYTp5fuBWfDD17W
         rRBsS84usQVbxlqpavCtm43sh+DOR8xz/sl+hoAALzjwEnhX3S+esUDdfMayQ7l21aDA
         jSDwt664UNVgkSsmsDghzlMTUs/5gVi27aoq+SJ5AfF812HBmiHPI6JG0AAFKvZX+za+
         zgJQ==
X-Gm-Message-State: AOJu0YxDjlIVG5bB641tyVOVcriQF273F/Ovh9V83bHXXVQm0qHe5aFO
	/N85aDFgE6FQCMufW0Q7h0KJIUxyngc6iWT2fBCq
X-Google-Smtp-Source: AGHT+IHpOSANOrQKBQgtUgStfgXLEaTDhiwuX8RmP+7vz4a8DNxO1ohlNmWN6m1GXQ9c27fFcBbMW4NNTEH1Lhj5YvE=
X-Received: by 2002:a25:4e05:0:b0:d69:8faa:5a28 with SMTP id
 c5-20020a254e05000000b00d698faa5a28mr24864064ybb.55.1697213111288; Fri, 13
 Oct 2023 09:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20231013-karierte-mehrzahl-6a938035609e@brauner> <CAHC9VhTQFyyE59A3WG3Z0xkP6m31h1M0bvS=yihE7ukpUiDMug@mail.gmail.com>
 <55620008-1d90-4312-921e-cef348bc7b85@kernel.dk>
In-Reply-To: <55620008-1d90-4312-921e-cef348bc7b85@kernel.dk>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Oct 2023 12:05:00 -0400
Message-ID: <CAHC9VhTb6T6fiVTQTBKP6t-zQnDtSck1TuBbETBjs4bt=ryh=Q@mail.gmail.com>
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>, Dan Clash <daclash@linux.microsoft.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	dan.clash@microsoft.com, audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 12:00=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
> On 10/13/23 9:56 AM, Paul Moore wrote:
> > * You didn't mention if you've marked this for stable or if you're
> > going to send this up to Linus now or wait for the merge window.  At a
> > minimum this should be marked for stable, and I believe it should also
> > be sent up to Linus prior to the v6.6 release; I'm guessing that is
> > what you're planning to do, but you didn't mention it here.
>
> The patch already has a stable tag and the commit it fixes, can't
> imagine anyone would strip those...

I've had that done in the past with patches, although admittedly not
with VFS related patches and not by Christian.  I just wanted to make
sure since it wasn't clear from the (automated?) merge response.

> But yes, as per my email, just
> wanting to make sure this is going to 6.6 and not queued for 6.7.

Agreed.

--=20
paul-moore.com

