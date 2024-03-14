Return-Path: <linux-fsdevel+bounces-14401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A9587BED3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 15:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D759C1C2139B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27056FE17;
	Thu, 14 Mar 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dDnRk0Xh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66B58ACF;
	Thu, 14 Mar 2024 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426278; cv=none; b=R8xmT9Urici1tOS7R7C6r/rRp7bpW+6B0uaIaKG+pFilLetWaXhPK6EI70TSmnrjipDhgpv+R+gEYwrfgODJefdP4pDDxAkLg6QvQBeDeHu5gVZsoXPReyjQjg+jbls8gzmG4IQ5cOWj39vFzu77Xj9qOq2GSLGoGoeQnF/5o+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426278; c=relaxed/simple;
	bh=UNQ3Nf1flabD2MoV69eJ0hCAVp+9WHaurahsKUJFxD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXg2uu5cwYG9mIOUNsXaBHA5xMo8UIJSQJW1jhi3vwyugMefIC2U1HnkXcTNttEUkOS0shhUz0UJYX7fqfqa7jipTdhtd6aAsJUAm/tpA5QYg8vZyf1WL4b1yjaHpiv9HqgeLZ93wRa/9YZMiXR0y6KX96uAy/uRD951mvx3fP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dDnRk0Xh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZiuvoYsNbOuxMT8EwGr6wSm8sPv1upTE63Mx09JCoFo=; b=dDnRk0XhoMo9OmzcS3ZT8tZJBt
	GEO82FAzcjUGQAzEmEPN7PDlhdZ+OLCgMX3R7AHI67K5y7G84v5MHswGNGtD8xmuYtVbnx/vLWb9M
	y+9vFhnTV7If5pWonxtXEIU3XI1z4te8VX+UI5WzPZHvF/gFo0yoz/1LmnX8WJ6IeQOstL3p+0xCd
	TwWq7dYS5aGLpb4XeCQaFUhqB5uZ747jOmUgDUR2BmSndd3TfBJQDjV+NDmwuh0htyL9E0fRZmuN3
	TCw2UwJp45Raz2fTcCGIzrWXo2gj2twWpuGngAu4da9y5g8uYFeqXBrBjLPBM44lmMvFKAQ7T9sdw
	HP7r1X3Q==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkm0X-0000000Ecg7-2G0a;
	Thu, 14 Mar 2024 14:24:33 +0000
Message-ID: <7ea2aec2-cfca-4d78-9164-8be7821a168c@infradead.org>
Date: Thu, 14 Mar 2024 07:24:31 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] afs: Revert "afs: Hide silly-rename files from userspace"
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>,
 Markus Suvanto <markus.suvanto@gmail.com>,
 Jeffrey Altman <jaltman@auristor.com>, Christian Brauner
 <brauner@kernel.org>, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <544d7b9d-ef15-463f-a11c-9a3cca3a49ea@infradead.org>
 <3085695.1710328121@warthog.procyon.org.uk>
 <3341492.1710413737@warthog.procyon.org.uk>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <3341492.1710413737@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/14/24 03:55, David Howells wrote:
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>>> Link: https://lists.infradead.org/pipermail/linux-afs/2024-February/008102html
>>
>> Not Found
>>
>> The requested URL was not found on this server.
> 
> Erm.  Not sure how you came by that.  You lost a dot somehow.  It's in the
> original submission:

Nor am I. Guess I'll blame it on thunderbird.

> https://lore.kernel.org/linux-fsdevel/3085695.1710328121@warthog.procyon.org.uk/

Yep. Thanks.

-- 
#Randy

