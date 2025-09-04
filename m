Return-Path: <linux-fsdevel+bounces-60314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C7EB44A08
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 00:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBAAE4E1DA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 22:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F5A2F5307;
	Thu,  4 Sep 2025 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mcbridemail.com header.i=@mcbridemail.com header.b="YDtYIOkP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756902ECD12
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757026709; cv=none; b=OdaPzFvHx+7PFJe3BNt+G6zoJW5Fx+aAk6nG60n+PBqNQwo5JiVeYc7lmfl2+L4d+Nrc/ieqscyapA8tj+6lDTYdRaJCXgwH0Nrli0DPgVosJXf8vb6C7nEPMM/C1kF4v+zT+z29gC8P/QKwDn1p80Xd97QzSOHqR07gcuOMi4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757026709; c=relaxed/simple;
	bh=8l/6BmPBR116ag/v3kLyMnKDhueZgJc1gDk9h3MAFv0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQxFR3S0tNE4zxgjwOho0Eo5F4RBwwjiEuMdJ/fChNygIaasikKrBsr7KyIkEN32CPfeokNzNuBcVb6FRarmmLYcaAR1b3aXFatu4aNHDFa/dtwA05508omISTMQ7G0fUVmzL/FkHlbtJrZ4pTsmVzObU58z/cvyDH3zSq2M574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcbridemail.com; spf=pass smtp.mailfrom=mcbridemail.com; dkim=pass (2048-bit key) header.d=mcbridemail.com header.i=@mcbridemail.com header.b=YDtYIOkP; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcbridemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcbridemail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcbridemail.com;
	s=protonmail; t=1757026697; x=1757285897;
	bh=8l/6BmPBR116ag/v3kLyMnKDhueZgJc1gDk9h3MAFv0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YDtYIOkPAn6WUpaoypTpagePiba5iDiRXinkK97O36dsGdOr3RnqWZfLTbXLSY/NL
	 6CGA4/WyndGgVRx1Dv/dF/i9Ll1GUFiR1/NbNHeJxQJitX4htntHfpoFYt7/FI/nrN
	 AR0xRY488N16t1Hujj1pqBQPowoCWwxzZ/AUHwUC58uTfMQUYOk9Mp4Fdvovc9L/Om
	 lwZU+Gc3qF0bHFEyLVB60pJn9drdSyMp0e3BqhjM1AkhBsQRObztF+5u4Tt1zBOkZK
	 s66wpcd8aK4YfZiEfRNya+7kLRxm8+Bm+LjzvXTTnMCSQOSNRslKkK/Q8w4vz4wRWV
	 aXtjz1xJp0NUw==
Date: Thu, 04 Sep 2025 22:58:12 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
From: Blake McBride <blake@mcbridemail.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Colby Wes McBride <colbym84@gmail.com>
Subject: Re: [RFC] View-Based File System Model with Program-Scoped Isolation
Message-ID: <DHMURiMioUDX6Ggo4Qy8C43EUoC_ltjjS52i2kgC9tl6GhjGuJXOwyf9Nb-WkI__cM0NXECZw_HdKeIUmwShKkAmP7PwqZcmGz-vBrdWYL8=@mcbridemail.com>
In-Reply-To: <20250904220650.GQ39973@ZenIV>
References: <Oa1N9bTNjTvfRX39yqCcQGpl9FJVwfDT2fTq-9NXTT8HqTIqG2Y-Gy0f7QHKcp2-TIv7NZ3bu_YexmKiGuo9FBTeCtRnVzABBVnhx5EiShk=@mcbridemail.com> <20250904220650.GQ39973@ZenIV>
Feedback-ID: 30086830:user:proton
X-Pm-Message-ID: 38bbc2060b93ffce28ed449576454f9d573c5413
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Off the cuff, I'd say it is an mv option. It defaults to changing all occur=
rences, with an option to change it only in the current view.

--blake





On Thursday, September 4th, 2025 at 5:12 PM, Al Viro <viro@zeniv.linux.org.=
uk> wrote:

>=20
>=20
> On Thu, Sep 04, 2025 at 09:52:22PM +0000, Blake McBride wrote:
>=20
> > Proposed Model
> > --------------
> > The key concept is the introduction of views. A view is a named,
> > use-case-specific file hierarchy that contains a subset of the overall
> > files on the system. Each view presents its own hierarchy, which can
> > be completely different from others. Files may appear in multiple
> > views, and may even have different names per view.
>=20
>=20
>=20
> What happens on cross-directory rename? Within the same "view", that is.
> How does it map to changes observable in other views of yours?

