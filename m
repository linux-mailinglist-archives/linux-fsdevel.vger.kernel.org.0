Return-Path: <linux-fsdevel+bounces-58-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C77C5379
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 14:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A80E281D88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 12:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB971F17E;
	Wed, 11 Oct 2023 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VGX47blj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992191F16C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 12:19:02 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F23E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 05:18:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bffa8578feso84286381fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1697026736; x=1697631536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NVfn9PXw+Xc7MOe9fBZyAc2Mg1C5gfNmbgZDWe8PI8=;
        b=VGX47blj49EGrJ3Z5hHasUthk7DzLZsCCfk4YiMoEI87jCFY+FmJatANiEvjbBy9Tm
         GvLX6PdMgj9ca3VQPHysOOoQgJemxewJlrWkI3KrnNYZ2T631HHURKz04nHAjUiWSRd3
         6JSf11rQkI0jIzjQEENUe4Hhy/yis8tPBXXvmmoh+hAGH6I4lK5K/6RDFFqMjAK0iwIz
         oruZ1zA6IdJi0BZPLjWlrHZznIKHfLGtdSpgzGv+qw2ZehUV8xk+xtriqlU/S520lybN
         5Kv6GmahJdsu8vOvANa+mszqLW5k5ti17nyP+ACw1DQdLAAPsuUdO1DtKJsg/qo5bWPQ
         yUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026736; x=1697631536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NVfn9PXw+Xc7MOe9fBZyAc2Mg1C5gfNmbgZDWe8PI8=;
        b=n2vYx8nvCwjPWi7slMhRXiFtHf/LaKKgUx58Jz0KQliXRF1W/Tifmy3sqATyOn/1BX
         5xRT64imEH8V5qMKJ8Y/WZpYOhENNeU8//jctO5YaD06QIcEJT3N6/U/ys9yVcywdQNL
         OHNZ+njEb+51DJB2Gcv6vszmABLyydoI9WcqN4IMUYNua03PYLB4WSlZAoe/36TTa2Of
         UJJ+RyQ3RuIePx3Sz0M2flqt7HAtxVGrIXsisIlaTqqAPT5jN3+R89AZhMK8hRwyD+BV
         Rp1g7ekwVDK1h6RRj1QSrJ8Q6aIPS1kgKnh0Ml/psFFGBaq9J5NnFdy7rdIrrlLlru+U
         krHg==
X-Gm-Message-State: AOJu0YzUtP9mMeJBmrKfvfWNQ/4y6Rr36fuWepNGZZxRfU8/kthohjpQ
	NNkj5c0fVYkndmMsCUBCWUjaKMN1iy04+Fj+58tlqA==
X-Google-Smtp-Source: AGHT+IEyeSqa4UE2CD7oJKjtgieZak6mpqiXIKqLTMmoHN4AgmJWnb4Frkvq70Bdg5zQYImvAjshCXozVjO2zOmw3gU=
X-Received: by 2002:a2e:93c5:0:b0:2bf:f3a0:2f9f with SMTP id
 p5-20020a2e93c5000000b002bff3a02f9fmr15021916ljh.4.1697026736637; Wed, 11 Oct
 2023 05:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
 <20231009144340.418904-1-max.kellermann@ionos.com> <20231010131125.3uyfkqbcetfcqsve@quack3>
 <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
 <20231011100541.sfn3prgtmp7hk2oj@quack3> <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3>
In-Reply-To: <20231011120655.ndb7bfasptjym3wl@quack3>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 11 Oct 2023 14:18:45 +0200
Message-ID: <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
To: Jan Kara <jack@suse.cz>
Cc: Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, Dave Kleikamp <shaggy@kernel.org>, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	Christian Brauner <brauner@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 2:07=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Indeed, *that* looks like a bug. Good spotting! I'd say posix_acl_create(=
)
> defined in include/linux/posix_acl.h for the !CONFIG_FS_POSIX_ACL case
> should be stripping mode using umask. Care to send a patch for this?

You mean like the patch you're commenting on right now? ;-)

But without the other filesystems. I'll resend it with just the
posix_acl.h hunk.

