Return-Path: <linux-fsdevel+bounces-50502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93BACC9A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38391895100
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EC2239E94;
	Tue,  3 Jun 2025 14:51:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6154A1EEF9
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962265; cv=none; b=uxXQjf2yGKtkIBBFOsPgGDEENZHkti7stVulzi6HuwzohB8Sd8+rVH/Ug0pKEZrjmYAY0ImAHjqPPbOML1ITLICHeXNYvRywX1nco6qT+7zPVCQ72Gl7svF1jqZKTdZbe6ygJuX40KKKiKCi+ObZjLX6UGn5hnQBnG/DDXTVCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962265; c=relaxed/simple;
	bh=rdR/lFV3wEVKgEelL5+JOv8HCfXG1aeb8hNfe6Ubbe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzI9tnLlk368ZkxBg4VNIoFDehO89Dbs+xx2ocjcmbaIRQHZZCEa+fy5lTIB0Vfx+7q8QdAcgZ73BOgA1bmEd+/0HgrRZ68HW/G4qJy4yqQYNATMB3tCMc5xU+kvw7o5OZcM9Tg6q0ivfpakYcsteJjrBR0YogDKdRDuBN4uX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net; spf=pass smtp.mailfrom=poettering.net; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poettering.net
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id CE274E80FD7;
	Tue,  3 Jun 2025 16:44:32 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 6CFBC16005E; Tue,  3 Jun 2025 16:44:32 +0200 (CEST)
Date: Tue, 3 Jun 2025 16:44:32 +0200
From: Lennart Poettering <lennart@poettering.net>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Daan De Meyer <daan.j.demeyer@gmail.com>, Jan Kara <jack@suse.cz>,
	Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v2 0/5] coredump: allow for flexible coredump handling
Message-ID: <aD8KUDks9NvIOVV9@gardel-login>
References: <20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>

On Di, 03.06.25 15:31, Christian Brauner (brauner@kernel.org) wrote:

Thanks for working on this! Love it! But you know that already, I guess.

[...]

> will enable flexible coredump handling. Current kernels already enforce
> that "@" must be followed by "/" and will reject anything else. So
> extending this is backward and forward compatible.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Lennart Poettering <lennart@poettering.net>

Lennart

--
Lennart Poettering, Berlin

