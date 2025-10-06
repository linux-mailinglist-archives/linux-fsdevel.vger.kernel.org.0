Return-Path: <linux-fsdevel+bounces-63496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C99BBE395
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 15:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EA01898B01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6612D3A7B;
	Mon,  6 Oct 2025 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkhHGDHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E852D3737;
	Mon,  6 Oct 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758495; cv=none; b=eNwnk+Y3Kr/0bnh0pYNT+0UDdcpkqmfNhtM2AF8zejEf1W1RoZskyE/s+v4bEbfOE4NyPwNoOpys1Yx29Cl8+8uRCZwB8RWdmU+VWuGlEYHIkVxK/6SK6IItJLeFpD/PzCqMgknn5PVnfPhizWozobklvNy+HFt2dtrEjXYqMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758495; c=relaxed/simple;
	bh=a3fbl9hcRnJigtNyb65q1kXzImttOOFN4Xgy15CAkyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/fryjV9B4HwLxMYTkXL2/BL9h0O1AcKEcr8gMVGhASC7Nm/W34Ft9kX2xX+zOF1vHPjadKiKoyrWp+fMO13k8KnijaanRzmgw04qpjHqI1n4oUGE0Ch0hrrqwgFt1Nqfd4pPTGXZTrMkVLOg2T2YkN1VjGr6m9etur+eVDDhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkhHGDHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF955C4CEF9;
	Mon,  6 Oct 2025 13:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759758495;
	bh=a3fbl9hcRnJigtNyb65q1kXzImttOOFN4Xgy15CAkyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkhHGDHO0QCvclgTT83NhIR868hXzyMxNQ2v5cbK6nBC0hrnC0Sod0Z5xD8h1d4S5
	 G81FeB7UmaQ5Xdb/N+y5aq7mDgxbxnChfnwGMhqIsi2oAMxlkefKX3OmZWxJUAy5Dq
	 OUlR4HRXY+3PliRprgCYitoTCQeYoO9fup/DqAIROARUf/Ufs21QnNvyZ0z+JSQxpv
	 FoqTkpSxMqk4njjvu8Clng6BKHlV4pySXivMf2dharjmaN8zXc6PTc+2eEoTXP6ik6
	 Wp2g9LU9T2yFQra88Kxd0t2LdNg8IctDlxld899c4Tw5SY/ePxR0eLAPOJ/yDgDztW
	 aEjFQT1cgKr1w==
Date: Mon, 6 Oct 2025 15:48:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [GIT PULL 05/12 for v6.18] pidfs
Message-ID: <20251006-liedgut-leiden-f3d51f4242c2@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
 <20250926-vfs-pidfs-3e8a52b6f08b@brauner>
 <20251001141812.GA31331@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251001141812.GA31331@redhat.com>

On Wed, Oct 01, 2025 at 04:18:12PM +0200, Oleg Nesterov wrote:
> On 09/26, Christian Brauner wrote:
> >
> > Oleg Nesterov (3):
> >       pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers
> ...
> > gaoxiang17 (1):
> >       pid: Add a judgment for ns null in pid_nr_ns
> 
> Oh... I already tried to complain twice
> 
> 	https://lore.kernel.org/all/20250819142557.GA11345@redhat.com/
> 	https://lore.kernel.org/all/20250901153054.GA5587@redhat.com/
> 
> One of these patches should be reverted. It doesn't really hurt, but it makes
> no sense to check ns != NULL twice.

Sorry, those somehow got lost.
Do you mind sending me a revert?

