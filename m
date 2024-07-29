Return-Path: <linux-fsdevel+bounces-24505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB1A93FDA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C5A28331E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C6C187344;
	Mon, 29 Jul 2024 18:45:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D9186E39
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278707; cv=none; b=nic2v9hFAXee4aAJUI9S7ZyuDNGHwN0yWkAYpYoNguCFhYnxXvJ3+LYnJ/uwfsA3eF0H0PRagUx7MiakT6cEuH0twk5QMz5lQ9daMHJlZVbA+tea9fe+vTAYTjaEl2DEyiOBxrUYN9Vuntq9jwmOWIAhI0DTKaPh8eZPTUeqWqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278707; c=relaxed/simple;
	bh=MR43JElauZcxGfoEcodOsvNZEz70kV5x0fhorIgesi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQaFRYWSgx8QSjp7+83l9+E7C4yApuhuVu4oSsW9pn3tkOMsrOyTg6frj3DwJWGiapwCzM9b3GUPL3zsmZ+FfOshBXumDHfjx1+KSr2mE+XssjV9vmk1VH580xMukQhc6LCoYdR5FeF2mH0PjUi8dOecY5Ib8L2cwRIyC+JhFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB4AF68B05; Mon, 29 Jul 2024 20:45:01 +0200 (CEST)
Date: Mon, 29 Jul 2024 20:45:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Cristian =?iso-8859-1?Q?Rodr=EDguez?= <cristian@rodriguez.im>
Cc: Christoph Hellwig <hch@lst.de>, Paul Eggert <eggert@cs.ucla.edu>,
	Trond Myklebust <trondmy@hammerspace.com>,
	libc-alpha@sourceware.org, linux-fsdevel@vger.kernel.org
Subject: Re: posix_fallocate behavior in glibc
Message-ID: <20240729184501.GB1010@lst.de>
References: <20240729160951.GA30183@lst.de> <91e405eb-0f55-4ffc-a01d-660e2e5d0b84@cs.ucla.edu> <20240729174344.GA31982@lst.de> <CAPBLoAf11hM0PLhqPG5gUyivU9U1manpOOhDWCPugUmWc1VVUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPBLoAf11hM0PLhqPG5gUyivU9U1manpOOhDWCPugUmWc1VVUw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 29, 2024 at 02:40:00PM -0400, Cristian Rodríguez wrote:
> Do you mean glibc copyright assigment ? DCO is now ok.

Oh, I completely missed that.  Thanks or the headsup.

