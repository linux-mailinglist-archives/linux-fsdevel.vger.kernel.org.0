Return-Path: <linux-fsdevel+bounces-5996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1457811E41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 20:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70FA2826AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 19:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EA068261;
	Wed, 13 Dec 2023 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4vYAq8k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7D6F3
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 11:09:43 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67ef4c73e02so7077826d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 11:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702494583; x=1703099383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38sPdOE6OALNzgWIIObIDoaR0CPLaXLTk2JBUUTxeMA=;
        b=E4vYAq8k/P74iLUWG6Oq0OLIf6x1vu7O8oL7UqWXKS0Gvcn+Wf4UDEds45AqFzrlzi
         JWzeG/qqOwJ3sF6J1k3c7p6jPmoIgI28AAzevPIATqlcX+HXiDrWZkcJK/b28GNXmbOt
         rkFbPEAq1+Q2QHvVifEQIixt6UZNFeScXLieJ2/izKE5/PiZWSrTZxCCP4MpkRKzqr8J
         lbby8baNREmEdO8AaNIZ2sJLHr9i+pgK4U5x5w8ugOpqAI/E7kDFi8yRrI5DjfPXzuRb
         q8YHbPXruKXn5inoWySlvfd8cmVWvtT01VuOoxyuMwK8ZrtaHIfOdOX0GGIiDuIkY1O+
         VYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494583; x=1703099383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38sPdOE6OALNzgWIIObIDoaR0CPLaXLTk2JBUUTxeMA=;
        b=CnNDWjCm8msO7to0fnksWw1aw0ux4cBih7h7hGfwNJqDGH5Y3AlBN+yqE+16R14iFI
         Qu3eXPs/ZQMdRwqUD/bNewKBEDC/rXpCv4kzjtoLvIttAIAEhMTmaqqaS8Br+2Eq9hRN
         GvkBStB8QymH1q94Zve/xeb3vdg/rv12bsFhADmS4Yvti7imBf7MZORUe3wxXpXfO7xS
         A17sbpaVLrudZTVrxXLfw3+u4IsTtPGooPjiUv/kLU4UCTCdQTs4+U0qobYMHJyRYpxP
         +QlhBnayGv3c0TJDR3yZ4jVsvk4uZKLlGEkasFycm3Wi4I/uq7WBKK6JwcYjos3yOWM+
         MK5Q==
X-Gm-Message-State: AOJu0YzE91lswxwDW9oKG0s5drcffPbYvB+AfnuzlSuK9Q9bYAB/35dU
	2xQNFcl7gMLIGOnWV8BcYmCcgGG11XWG5ItJUdar4SUM5cE=
X-Google-Smtp-Source: AGHT+IGOxAeG0tQ7YZoPppZNoCeJWXJWj4WPfE8FclKUTFPP4TmBEFUUS2cfNYMUnCSpdigmN+lEC/eUqWTywDGE8Xc=
X-Received: by 2002:a05:6214:84a:b0:67e:cf71:3a7c with SMTP id
 dg10-20020a056214084a00b0067ecf713a7cmr5278293qvb.16.1702494582755; Wed, 13
 Dec 2023 11:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208080135.4089880-1-amir73il@gmail.com> <20231213172844.ygjbkyl6i4gj52lt@quack3>
In-Reply-To: <20231213172844.ygjbkyl6i4gj52lt@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Dec 2023 21:09:30 +0200
Message-ID: <CAOQ4uxjMv_3g1XSp41M7eV+Tr+6R2QK0kCY=+AuaMCaGj0nuJA@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
To: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 7:28=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 08-12-23 10:01:35, Amir Goldstein wrote:
> > With FAN_DENY response, user trying to perform the filesystem operation
> > gets an error with errno set to EPERM.
> >
> > It is useful for hierarchical storage management (HSM) service to be ab=
le
> > to deny access for reasons more diverse than EPERM, for example EAGAIN,
> > if HSM could retry the operation later.
> >
> > Allow userspace to response to permission events with the response valu=
e
> > FAN_DENY_ERRNO(errno), instead of FAN_DENY to return a custom error.
> >
> > The change in fanotify_response is backward compatible, because errno i=
s
> > written in the high 8 bits of the 32bit response field and old kernels
> > reject respose value with high bits set.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> So a couple of comments that spring to my mind when I'm looking into this
> now (partly maybe due to my weak memory ;):
>
> 1) Do we still need the EAGAIN return? I think we have mostly dealt with
> freezing deadlocks in another way, didn't we?

I was thinking about EAGAIN on account of the HSM not being able to
download the file ATM.

There are a bunch of error codes that are typical for network filesystems, =
e.g.
ETIMEDOUT, ENOTCONN, ECONNRESET which could be relevant to
HSM failures.

>
> 2) If answer to 1) is yes, then there is a second question - do we expect
> the errors to propagate back to the unsuspecting application doing say
> read(2) syscall? Because I don't think that will fly well with a big
> majority of applications which basically treat *any* error from read(2) a=
s
> fatal. This is also related to your question about standard permission
> events. Consumers of these error numbers are going to be random
> applications and I see a potential for rather big confusion arising there
> (like read(1) returning EINVAL or EBADF and now you wonder why the hell
> until you go debug the kernel and find out the error is coming out of
> fanotify handler). And the usecase is not quite clear to me for ordinary
> fanotify permission events (while I have no doubts about creativity of
> implementors of fanotify handlers ;)).
>

That's a good question.
I prefer to delegate your question to the prospect users of the feature.

Josef, which errors did your use case need this feature for?

> 3) Given the potential for confusion, maybe we should stay conservative a=
nd
> only allow additional EAGAIN error instead of arbitrary errno if we need =
it?
>

I know I was planning to use this for EDQUOT error (from FAN_PRE_MODIFY),
but I certainly wouldn't mind restricting the set of custom errors.
I think it makes sense. The hard part is to agree on this set of errors.

> I'm leaving the API question aside for a moment until I have a clearer
> picture of what we actually want to implement :).

Fair enough ;)

Thanks,
Amir.

