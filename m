Return-Path: <linux-fsdevel+bounces-19709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AEA8C908B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 13:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B891EB21444
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 11:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAE129CE3;
	Sat, 18 May 2024 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIvX89AP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5C2E3FE;
	Sat, 18 May 2024 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716030496; cv=none; b=SJ3RX0OMFqCMybf4M8fqyf6NhssIjo2cwE82sO9/++jvmh3iWz8VJvVA+uYJQe479jvYrC1KKR/BgZQyQ5uN+f0/7xNwGQC23m1PRSLX0zbjPaCSl2FNG0n8gqC2W/x8Lyr3F8qqj0OTf4+mCZVCrSETZTUXIjQrOxxVIEDfH3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716030496; c=relaxed/simple;
	bh=HXbBUzug7U+V2vfPNBsz3+xipJXzt7YurgJFoKWIqEY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=pQA6Q9lGwB7HjqXcXm+psMkasU7FLnPqjiW4S3OXY+qO4lxJ7POIpYDflKgQWBdo0VsJ5aKAAkgd5rCxcI0DzECy5e2YuSbkoZCSQ3E4Pv4V2Z8ADthOkmQ69rXT1inde0OYbvy/pd9d/6SRHuJetySs5TdEfKXifg6A8HWhots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIvX89AP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A66C113CC;
	Sat, 18 May 2024 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716030495;
	bh=HXbBUzug7U+V2vfPNBsz3+xipJXzt7YurgJFoKWIqEY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=MIvX89AP8dU1e/0W56FnUOvYR2BFANvmkcxTg2AB4Wnt120QafMqu6ehIH5wtutsp
	 dpA4LSS4tO/2rqt2FrV3umvujxDxwyzQsFe3oGQLH83pqZdOXa+MuTrEVZwAU2fbQ9
	 Ht2e/3ir19vOGbCjsWFfds8D/JYEwJJMiDTXo5Zf2i/gxq56OWSCvkBH0meGFq1f4H
	 ZS1P4e6txqfRk72du09hjUJPsdfJKvioOypaDP7GFkkmPBVuFosDwDDdIz/j9eOf2V
	 M5LKNG1L7i0ifUk6/8uilS2EdBe4EOS8Q3lvvIwcmwOdIdtbks9O/XWqRnb+v180pN
	 aH53POQPngOhQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 May 2024 14:08:09 +0300
Message-Id: <D1CQ1FZ72NIW.2U7ZH0GU6C5W5@kernel.org>
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jonathan Calmels" <jcalmels@3xx0.net>, "Casey Schaufler"
 <casey@schaufler-ca.com>
Cc: <brauner@kernel.org>, <ebiederm@xmission.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Kees Cook" <keescook@chromium.org>, "Joel Granados"
 <j.granados@samsung.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "David Howells"
 <dhowells@redhat.com>, <containers@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <keyrings@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
 <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>
 <D1BBI1LX2FMW.3MTQAHW0MA1IH@kernel.org>
 <D1BC3VWXKTNC.2DB9JIIDOFIOQ@kernel.org>
 <jvy3npdptyro3m2q2junvnokbq2fjlffljxeqitd55ff37cydc@b7mwtquys6im>
 <df3c9e5c-b0e7-4502-8c36-c5cb775152c0@schaufler-ca.com>
 <vhpmew3kyay3xq4h3di3euauo43an22josvvz6assex4op3gzw@xeq63mqb2lmh>
In-Reply-To: <vhpmew3kyay3xq4h3di3euauo43an22josvvz6assex4op3gzw@xeq63mqb2lmh>

On Fri May 17, 2024 at 10:11 PM EEST, Jonathan Calmels wrote:
> On Fri, May 17, 2024 at 10:53:24AM GMT, Casey Schaufler wrote:
> > Of course they do. I have been following the use of capabilities
> > in Linux since before they were implemented. The uptake has been
> > disappointing in all use cases.
>
> Why "Of course"?
> What if they should not get *all* privileges?

They do the job given a real-world workload and stress test.

Here the problem is based on a theory and an experiment.

Even a formal model does not necessarily map all "unknown unknowns".

BR, Jarkko

