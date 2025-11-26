Return-Path: <linux-fsdevel+bounces-69859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65B9C880B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 05:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848263B14E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 04:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BF41D6187;
	Wed, 26 Nov 2025 04:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJrSSoUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2E301027;
	Wed, 26 Nov 2025 04:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764130909; cv=none; b=squGPwIt2xRIiEBaK0E+NEnXldxMEPXOwXTa3x4EStAUF5uHDxQRafalpnyQ/vd36doejZAa0SOPIhqHjG5LYXFk288MLH9CNStySrGA9vszLQP5/deTRfnGXOVbGn/WPLVPlgZX+VGPPYcce5ryDoZAd4ut/AV8b2lct2B/fP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764130909; c=relaxed/simple;
	bh=9tx2q44HQ52dPuHretfgXk3zMXM/Shb9u3C+hqWq+sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdRMoi9ermTA9IdvMkE0hwSspq0tk5QM5Yxe2EITHGJ9yE3DI7Js6bP2N15Fw+AFkokSm2DPg4MbnlF9AXeF+cLlegrkHkfRhYpnwd4mIf8bMEZf1XuQbtM76LvWsTH796p8d01Y3Fyh+DNNY/ae9YDXBTXX5jDJLY9JeK+RTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJrSSoUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AD3C113D0;
	Wed, 26 Nov 2025 04:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764130907;
	bh=9tx2q44HQ52dPuHretfgXk3zMXM/Shb9u3C+hqWq+sE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qJrSSoUAkQ/+dh8jM1mmyJcF1Ytk5+9gXlDegEXiqasZhm4A1AwlKj3FuuN5vK6oe
	 JURzwZoQD2xJ3Hq1KM+GypyvbDDuFQDIlTKqtU098W3EGu3aYYRgf37dooj0OoBkRz
	 qV4Gt5lLYvw27hLfnl7efQDgBwZ2f6pOYb+EpXMRj0lsXWYG69RTsIloyZEwIT5SY1
	 sJvLvWXR0kTyNIUF06hPD3KiRwy5N/QijkTKNim9tUcmO4z2qy38YsW0qrMsxvdNLa
	 uhho3hLNgnaTeTJEMT+Mv+4WPWaxahX4eRnrlfrbF6PIO5kRhaY/YVTDFLqg0xLBJJ
	 l3XgOXPoeXI3g==
Message-ID: <99c38c74-7553-47c7-b4d3-4f291f976409@kernel.org>
Date: Wed, 26 Nov 2025 13:17:33 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] Documentation: zonefs: Format error processing table
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux AFS <linux-afs@lists.infradead.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, Jonathan Corbet <corbet@lwn.net>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Daniel Palmer <daniel.palmer@sony.com>
References: <20251126025511.25188-1-bagasdotme@gmail.com>
 <20251126025511.25188-6-bagasdotme@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251126025511.25188-6-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 11:55 AM, Bagas Sanjaya wrote:
> Format zonefs I/O error processing table as reST grid table.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thank you for fixing this.

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

