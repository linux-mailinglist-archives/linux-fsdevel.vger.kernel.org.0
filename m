Return-Path: <linux-fsdevel+bounces-12434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1957785F42D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 10:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0F528423B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494B3717C;
	Thu, 22 Feb 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7C49E1c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27692C696
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593726; cv=none; b=LlGHAa6pHslMsaTiEL0hp5aVzi3o4GJZWnrbBxvDG5GinCWOhSzt5320YMnY8yKtU+E+l13XNQ+vP0kNq9+gybGsifH9vdHnE7pgy7qT7NQkMGBps6g0Jg0b+bzezdmDDL/EwqgHVN+rcknNcz2PBU7qVx2foe5OFFdbSkaZFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593726; c=relaxed/simple;
	bh=T/HZ3GYVWLFtM2zhHV4Z2VAB4aMNm0Jf2btvvVej3E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRuEtBIzqv+bbzw8FC5t8amH7gPl4WQEP2YEcf3pnr8jJmK3cmYrYFlj2exisAevOLXTrg6DKOuJMGNG5mtYS1di5kg2GYK7kAuYDfJKgcSZerEjoPA+9uRqjc8BSKOXiWWj6VOIWLiy9qoN7N43EOS2fZUXaVRRH2SzZls3PQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7C49E1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA65C433F1;
	Thu, 22 Feb 2024 09:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708593726;
	bh=T/HZ3GYVWLFtM2zhHV4Z2VAB4aMNm0Jf2btvvVej3E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7C49E1cJthpWVDnHP/Hl0VruUPz0SaGqODdngX9jGCibo7cjrwpkTr16YWiRFzcd
	 EtKn9Y3N6AbjBpsiW4+JdokrxGk4C6Z3o9zTdQ7gCPVNwc2G9YWVD7Wets410x0S1M
	 YAwHiyd6D5qbTibxr4i5Aw6OekJ6Kz2+FLtq7Fwk3tgK/H3bQ9BcCDk1CNzbl96vj3
	 qvazlMHmckCoMa953UCcmMaD6tsF2Y9lLE7e8YkFgITx9h3d1WtMqIIRMjp8Mgcn0r
	 GOEt6Rcm4VbDlzhdEAzWAD4pkWTpHQMsltxW7mMV52eH4dq1NIJ7vA8coS+lUk2Hg5
	 n+2pcUYuZhoTg==
Date: Thu, 22 Feb 2024 10:22:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Kassey Li <quic_yingangl@quicinc.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Add processed for iomap_iter
Message-ID: <20240222-codewort-lageplan-e66fa901d0e7@brauner>
References: <20240219021138.3481763-1-quic_yingangl@quicinc.com>
 <20240221163105.GG6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221163105.GG6184@frogsfrogsfrogs>

On Wed, Feb 21, 2024 at 08:31:05AM -0800, Darrick J. Wong wrote:
> On Mon, Feb 19, 2024 at 10:11:38AM +0800, Kassey Li wrote:
> > processed: The number of bytes processed by the body in the
> > most recent  iteration, or a negative errno. 0 causes the iteration to
> > stop.
> > 
> > The processed is useful to check when the loop breaks.
> > 
> > Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> 
> Heh, sorry I didn't even see this one before it got merged, but:
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Yep, don't worry. I'm grabbing all your RVBs/ACKs later. :)

