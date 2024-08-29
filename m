Return-Path: <linux-fsdevel+bounces-27766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9B963A2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 08:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02B01C23D83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 06:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D192814A4C0;
	Thu, 29 Aug 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="kMPkj9Fh";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="QkeS4DfA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FAC1514FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911215; cv=none; b=GyNWX2f2Ht9Iz+ymynzPxnx34TsaGkbAPGNVNsz0t0UmpHSU76GQkjdpo7waOrltj5pxY0bF9q7fqasHf9iHyRQEsKl/RRBkh3ATlm+Ru9X6yDbIcYxo+0Nr2jqXJPYOIbTchvVyuoIqOqG/ybsZoG7FBn8OxiMXlWeDTyasCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911215; c=relaxed/simple;
	bh=c5+BxaXWvRBxDUcjcZvL61zh83/XIf0pWGMRioPHBrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZgEdnGyT5iJTu/iN2I32ASQrseQVm5jV6xVRc1zPABS1zuXJa+lzjhbd2s/Y1iGCThnF6+JkigojwG86Fq6uvqrglE2DjtXj57zkEgXHrR55q+w6i5ebt197+ITU47AFICkzaZVx/KZ/BZWVmBVxIPGetreKHbZ1S3Y30lPuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=kMPkj9Fh; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=QkeS4DfA; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724911214; x=1756447214;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=c5+BxaXWvRBxDUcjcZvL61zh83/XIf0pWGMRioPHBrM=;
  b=kMPkj9FhsdO/dLY4XssPFKBcpA9YxViRQjHf/5cB8sKjpwNFnTXnh2DD
   m87mbtpE9/QQjifI1Za9VKI4NeRaDnVYU/euMvTyfqmxeLyZB3kLNqAoU
   CRplgIQH1zHItE9mbzUQS7gXUZJhZXRjoD5/oOchB6KAsIHnFPeQN1cwk
   i7Ps5Zuno5b3BUobWtFB8AlG4wHaWvtyc9kcqLn6U/cSCojiErsJu9IQV
   im5fMTd0tNn1pRoOkeJDxxADo3TV/XCIv91Li8JjxTK1ONU4lbLiz0YMa
   JrwvvXn4UJI37ZNPErqshCRISQBTa5P2T2gE5Q77gpJuy/1cBfAEP/pQm
   A==;
X-CSE-ConnectionGUID: A7A8P3pUQYqGnnWhKM+1Vw==
X-CSE-MsgGUID: /Jb2DGS5QYW8ddu01Y5g5w==
Received: from mail-oo1-f71.google.com ([209.85.161.71])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 23:00:13 -0700
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5d5b62ee8b9so341969eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 23:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724911212; x=1725516012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5+BxaXWvRBxDUcjcZvL61zh83/XIf0pWGMRioPHBrM=;
        b=QkeS4DfA5radHqhO5NnmoXAwsA/fp8W/3HjlHc8St2abWeXHk/+lL7ojmH6POomTdd
         ekllmsLHAIUx66w/ia6xeGdEvidDl2B6SBbnD62CHPJOFG4QmxHrmPfAkCXB5Dyla9n1
         Cv8UcEuSvfyEnA+Tgtk3gccU2BifXsY6fLDUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724911212; x=1725516012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5+BxaXWvRBxDUcjcZvL61zh83/XIf0pWGMRioPHBrM=;
        b=fbX3z9yYH/dpi4V39vOPJfaiWAEixYkHQZYAvczTP8GD73KDkTWMT2TVpdzKkoi6fo
         2mBSxc/wBeYfLY3DSmUzle591cE30Qz8MCP+fWckU0iT/cXf+oEjGl5OFxTconYa8BZO
         VywZRQ8ys/lrvLJ+zUCVg4hBjgYbxXZ5RR0LzqWF8MrXHxJQufmao74uO5nmvD6XHKVl
         3oXD2/U1k27xFI7tKspo0M88NWK7FXJDmwhRm4egyMAJvWak1dvuL+95YeJYJ5vfNEg4
         6zwYOfoXxeiVtG9zfEH2eAMU5GTXICBlKzt0OYokWESjTySA6AL4rlxJYW6SBaQi05AG
         a1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUMyv4kI2sPZvE5aXvD7iiVCSrmz6U9TntvVY7L3C61YRPkD/Mh+arcMARKiPpuXZa6WzW5/5lWejBOJoiF@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHVKo7EhwqTxayxuH7mraGSsEOAlZl8SppRjw6z6mYQNVkcyG
	uqxgb5GAMjloiJaDMSZ8dfpAwSouuhEISG5Um59o/YE7q7pO6pMisScGthDLhnduC0tivCId3Hg
	8OHrxgd/1+5rzJWVCeSukkTStrsTciUWiVKue9nRiDBi8FmFUkgkdVD9iErs1Gp+scZrbFg75e1
	xCXoKaJzziNVGc9P85mAIMAXDzBR/q/uY0cSMzDQ0=
X-Received: by 2002:a05:6820:2295:b0:5dc:a733:d98a with SMTP id 006d021491bc7-5df980cf733mr2263971eaf.7.1724911211520;
        Wed, 28 Aug 2024 23:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5thjR14Ks+6judAwL4nDPvcXZjzFPCcbYGPrB7DoyTxw6g4i4UpkLaTzBuGzQKTfzqhlcGKfYt1vxkUxvhM0=
X-Received: by 2002:a05:6820:2295:b0:5dc:a733:d98a with SMTP id
 006d021491bc7-5df980cf733mr2263936eaf.7.1724911211146; Wed, 28 Aug 2024
 23:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-4uup-u-7rVLpFqKWqeVVVnf5-88vqHOKD-TnGeYmHbQw@mail.gmail.com>
 <202408281812.3F765DF@keescook> <CALAgD-6CptEMjtkwEfSZyzPMwhbJ_965cCSb5B9pRcgxjD_Zkg@mail.gmail.com>
 <BA3EA925-5E5E-4791-B820-83A238A2E458@kernel.org>
In-Reply-To: <BA3EA925-5E5E-4791-B820-83A238A2E458@kernel.org>
From: Yu Hao <yhao016@ucr.edu>
Date: Wed, 28 Aug 2024 23:00:01 -0700
Message-ID: <CA+UBctBGbAc5rDV97DaJGJopqTKkeuC8hHiMrN6irt84r0NoRw@mail.gmail.com>
Subject: Re: BUG: WARNING in retire_sysctl_set
To: Kees Cook <kees@kernel.org>
Cc: Xingyu Li <xli399@ucr.edu>, mcgrof@kernel.org, j.granados@samsung.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Waiman Long <longman@redhat.com>, 
	Sven Eckelmann <sven@narfation.org>, Thomas Gleixner <tglx@linutronix.de>, anna-maria@linutronix.de, 
	frederic@kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:33=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> That's excellent that you've developed better templates! Can you submit t=
hese to syzkaller upstream? Then the automated fuzzing CI dashboard will be=
nefit (and save you the work of running and reporting the new finds).
Yes, we are also working on this.
And it also takes some time to figure out the differences in the
syscall descriptions and to satisfy syzkaller's style requirements.
So we are still working on the patch of syscall descriptions for Syzkaller.

Once again, we apologize for our mistakes of some helpless report
emails and thank you for your reminder and understanding.

