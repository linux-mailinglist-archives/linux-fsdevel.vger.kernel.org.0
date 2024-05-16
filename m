Return-Path: <linux-fsdevel+bounces-19584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C424E8C77CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 15:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BEDBB20BBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AA2147C75;
	Thu, 16 May 2024 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNlMIP63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2D145A13;
	Thu, 16 May 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866573; cv=none; b=gUzcIZ5AX5ZoC9+m/vSNLee4kEqk+0ju4tFRgsQAWKwmt71wfQ5+6UkNCuzZeUhcL6j6O3gbArBVR4ZCGL3YY4qD5iFkzCYaDZA3ke2J0IY5u5nvl6wQAAP6S4cW9P6gXGB5iMaaKjgivFMXGbK4Dh/XZxlqWEszzoPhOButK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866573; c=relaxed/simple;
	bh=+X/pJ+cjQTPvyiXa9RlyRxNcuMfpjhyz9k+r/NmP/WY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rtAlH9yOLkMMnYH2jO5AstpDVL0HLGqtneCf/jPmDsrUIY5TWKysJ+9RqMN2S3E74YFCnp0sDMZt7y+DX6AbH1CjAKQjxQd04GnTUeCSzKvbKATEM5/nFnxUP1VD1FCbg/JMGQETO4CgEBGPrbb0/yX+kOfYqa0Hu6GSrwrc0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNlMIP63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34313C113CC;
	Thu, 16 May 2024 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715866572;
	bh=+X/pJ+cjQTPvyiXa9RlyRxNcuMfpjhyz9k+r/NmP/WY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=dNlMIP63DMon7wdup7/PSlufCpBM3kgmim23PNWd6NN5hxQJ8SEk1godal4HV4LOu
	 v4v8ECOM+6olmSSSzmjeu0I5ABuCHFHBISDIcUH6ptvx2R6lyLAmBb5QknQej8tHRw
	 VxDVmPXSZRuoiAaa+15rP9BOwcFfzwob5/7KWhM83/oeean4xO/gksPZD2LYKmp7hd
	 /mv22xlDcQaKuqTZWkrYtzhu3PrmJcMm0Vf0NEDr+5FZy0QBsai5s0ptdkKDcht2xH
	 /ceZkDUqvklKuy5QUkE2BpfHwf7mVisucs5zNM8ujHMPvMVF2grFmO3vF+HJqQUcG6
	 61xV0KeMa+GqA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 May 2024 16:36:07 +0300
Message-Id: <D1B3XN42A6DR.1RSMLZ6R7VRHT@kernel.org>
Cc: <brauner@kernel.org>, <ebiederm@xmission.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Kees Cook" <keescook@chromium.org>, "Joel Granados"
 <j.granados@samsung.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "David Howells"
 <dhowells@redhat.com>, <containers@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <keyrings@vger.kernel.org>
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ben Boeckel" <me@benboeckel.net>, "Jonathan Calmels"
 <jcalmels@3xx0.net>
X-Mailer: aerc 0.17.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <ZkYKgNltq2hlBzbx@farprobe>
In-Reply-To: <ZkYKgNltq2hlBzbx@farprobe>

On Thu May 16, 2024 at 4:30 PM EEST, Ben Boeckel wrote:
> On Thu, May 16, 2024 at 02:22:02 -0700, Jonathan Calmels wrote:
> > Jonathan Calmels (3):
> >   capabilities: user namespace capabilities
> >   capabilities: add securebit for strict userns caps
> >   capabilities: add cap userns sysctl mask
> >=20
> >  fs/proc/array.c                 |  9 ++++
> >  include/linux/cred.h            |  3 ++
> >  include/linux/securebits.h      |  1 +
> >  include/linux/user_namespace.h  |  7 +++
> >  include/uapi/linux/prctl.h      |  7 +++
> >  include/uapi/linux/securebits.h | 11 ++++-
> >  kernel/cred.c                   |  3 ++
> >  kernel/sysctl.c                 | 10 ++++
> >  kernel/umh.c                    | 16 +++++++
> >  kernel/user_namespace.c         | 83 ++++++++++++++++++++++++++++++---
> >  security/commoncap.c            | 59 +++++++++++++++++++++++
> >  security/keys/process_keys.c    |  3 ++
> >  12 files changed, 204 insertions(+), 8 deletions(-)
>
> I note a lack of any changes to `Documentation/` which seems quite
> glaring for something with such a userspace visibility aspect to it.
>
> --Ben

Yeah, also in cover letter it would be nice to refresh what is
a bounding set. I had to xref that (recalled what it is), and
then got bored reading the rest :-)

Not exactly in the nutshell cover letter tbh, but maybe the
content in that would be better put to Documentation/

BR, Jarkko

