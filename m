Return-Path: <linux-fsdevel+bounces-716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE84B7CED9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 03:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C53B2116D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 01:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB1164F;
	Thu, 19 Oct 2023 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B/hriZb/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523138C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 01:39:24 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70F89F
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 18:39:21 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso7834425276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 18:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697679561; x=1698284361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX68/OE0qLrF3A1/NDlCjZF1ajE8ZMP/wy8PcFgCC1k=;
        b=B/hriZb/a5usUFTona5xSSGqFGx7M7E+IQoS3ZNjotoDDqZoV2dWm77wY8kONdLpMi
         N1XfykBCX1djn41p8RS7XMmDUowa3OP5AGT0mp4MQbIQZ6RRVQgB8apci73hwTR4ETbG
         p0fUcSOar50eWTrlnQjWQmv+TuMa8nhx/RAoIK9QlbtHYk8066iD5kEeRtTJXtijmwLn
         2TnHslHatbWcO+iatBIhBDSXlPgZbIA10sVt6AgKHuk4YlXxeRSCceqeBiDHOdMUvbxP
         zAKAJNby7R85c1iq1QJtEkEGUMIsh3vYjRTAfnoYpeUj4DgnNMDe2dL1SQvgapZKCN7k
         zWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697679561; x=1698284361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX68/OE0qLrF3A1/NDlCjZF1ajE8ZMP/wy8PcFgCC1k=;
        b=MdCKB5bVZ3wYQn96RdamD1FWCgug1ygmL1jPFEgk5BHvf4qpnQyUk2oSqyMMGM6AUe
         B1gTEM7rVoVFeub1QW0IsV/+2+txtrG/wOb2zb80wXG3zKxl6ZXOYoyX4TLLrIeoavdT
         7fyXiYVmt70XlnpCgrs5eEX+/pSGgHwx0pTiESFfA4KTN7Z0q2Jj45+KPKTXeDbR6YtW
         OBoc0mGXvwo4VloyCNPqyAsAi32fh3toldy8f6I0vqKynou/MZS5HV4XL8QG9OvUPsJM
         QuhBX9pF1i3YAci0VsoSrQEPkocFEuDxeZoEUIu2YdboJ6li/gsXjp5/MU666F4unkzG
         zcVA==
X-Gm-Message-State: AOJu0Yz4L2GgQNuT4TQ8IXdky8Ku5cv7uX/YwO7raS89PV6E1tADmAou
	kBhhFoADaQkmgid+eyx/YQI3BG/FEU5ncxqp0vHt
X-Google-Smtp-Source: AGHT+IHhIoDNFAW1nx6xHUnFoODV7tpJlxCRuJvySLom8kFciPpNz1TSp3WvEUHvnPNxYR6g8vN0WkWsdcb6Dfh3VC4=
X-Received: by 2002:a25:ada4:0:b0:d9a:4da4:b793 with SMTP id
 z36-20020a25ada4000000b00d9a4da4b793mr1172039ybi.62.1697679561081; Wed, 18
 Oct 2023 18:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016220835.GH800259@ZenIV> <CAHC9VhTToc-rELe0EyOV4kRtOJuAmPzPB_QNn8Lw_EfMg+Edzw@mail.gmail.com>
 <20231018043532.GS800259@ZenIV>
In-Reply-To: <20231018043532.GS800259@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Oct 2023 21:39:10 -0400
Message-ID: <CAHC9VhSx0UiHyQYR-=va4X0r3XpEFz9n9f96DkQ9bhbB97RnnQ@mail.gmail.com>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 12:35=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> On Tue, Oct 17, 2023 at 04:28:53PM -0400, Paul Moore wrote:
> > Thanks Al.
> >
> > Giving this a very quick look, I like the code simplifications that
> > come out of this change and I'll trust you on the idea that this
> > approach is better from a VFS perspective.
> >
> > While the reject_all() permission hammer is good, I do want to make
> > sure we are covered from a file labeling perspective; even though the
> > DAC/reject_all() check hits first and avoids the LSM inode permission
> > hook, we still want to make sure the files are labeled properly.  It
> > looks like given the current SELinux Reference Policy this shouldn't
> > be a problem, it will be labeled like most everything else in
> > selinuxfs via genfscon (SELinux policy construct).  I expect those
> > with custom SELinux policies will have something similar in place with
> > a sane default that would cover the /sys/fs/selinux/.swapover
> > directory but I did add the selinux-refpol list to the CC line just in
> > case I'm being dumb and forgetting something important with respect to
> > policy.
> >
> > The next step is to actually boot up a kernel with this patch and make
> > sure it doesn't break anything.  Simply booting up a SELinux system
> > and running 'load_policy' a handful of times should exercise the
> > policy (re)load path, and if you want a (relatively) simple SELinux
> > test suite you can find one here:
> >
> > * https://github.com/SELinuxProject/selinux-testsuite
> >
> > The README.md should have the instructions necessary to get it
> > running.  If you can't do that, and no one else on the mailing list is
> > able to test this out, I'll give it a go but expect it to take a while
> > as I'm currently swamped with reviews and other stuff.
>
> It does survive repeated load_policy (as well as semodule -d/semodule -e,
> with expected effect on /booleans, AFAICS).  As for the testsuite...
> No regressions compared to clean -rc5, but then there are (identical)
> failures on both - "Failed 8/76 test programs. 88/1046 subtests failed."
> Incomplete defconfig, at a guess...

Thanks for the smoke testing, the tests should run clean, but if you
didn't adjust the Kconfig you're likely correct that it is the source
of the failures.  I'll build a kernel with the patch and give it a
test.

From what I can see, it doesn't look like this is a candidate for
stable, correct?

--=20
paul-moore.com

