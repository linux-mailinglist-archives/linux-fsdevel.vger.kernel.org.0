Return-Path: <linux-fsdevel+bounces-60015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B27B40E12
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 21:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771EE1B64EAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 19:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D1334DCEF;
	Tue,  2 Sep 2025 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ka5sI0kT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DCB1E3DE5;
	Tue,  2 Sep 2025 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842466; cv=none; b=UELt7n2U+swhbn28VIyas9SxhNxyEfRAL/BMGadvFq6Yh/qxT28OP11F1uPamQGUZpM24ZuGKEEqeckW0IVY3sAaNOSNRD+H8CtwiL5on9KPoOG904d6ZlyTAnFF8dM2dgJDjP5X8RDui4IdvF+ezj+hd53xKctpQNEdP+XY2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842466; c=relaxed/simple;
	bh=NqAh277DzHdMuKPVbLw9C0mN6H+mQbLvDN+EyVfzDTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEVe8CNSiFlL+NrL86TXiPEUHM+HJXPHp+qVX7ojsONdK/4tQqOjmrj7TGgFcXw4w7KQUgQ3va/nRUpTCNIeleBezm91ZotHcKP/S4tOw2G3HTAdvlYi2wKTQTGaAdfVNbb8u3jkLNh4oElJPj0mx/k95/P5TBahhYhQQYKBPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ka5sI0kT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/JczOgDOpgvS8Th6s5dYsBp2O9rwrnIJ+h8WCKgjffQ=; b=Ka5sI0kTLHM7JqnhsDKjtfTtlP
	9OPAvx6NDec1W/xEKfSbq5+jzU074Ud5ERFf2/GygiP43HxCoXtYEdaRoarBJU2w6kX2WOVT5N47O
	z24NHrreq07n/QDMIqyE2E0/Y9g/B6bJt9G0+Gq3Iu24uh8wGPOzw/XXNLctAYYJONDX9m8jUc09M
	himO6eCaBu+5vAeJjsm2TVhN/sLvQ0I2f0lJyLRSkkl7YvJ2aNd4Tt873jC3vDGn0+vEpzRSTVlUH
	+9MoRoYHLN/Z6pbQP82d4Q9GKOvHdI7I/VW1KcCatyoqIZoVTefiJPAlt+SOipeSH2DBdYi/bBpMr
	m9nGON+w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utWyl-00000001mWv-2jCS;
	Tue, 02 Sep 2025 19:47:43 +0000
Message-ID: <25f1f5a7-36ce-489e-b118-6802efccbc71@infradead.org>
Date: Tue, 2 Sep 2025 12:47:41 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Fix spelling mistakes
To: Ranganath V N <vnranganath.20@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 brauner@kernel.org, djwong@kernel.org, corbet@lwn.net, pbonzini@redhat.com,
 laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org
References: <20250902193822.6349-1-vnranganath.20@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250902193822.6349-1-vnranganath.20@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/25 12:38 PM, Ranganath V N wrote:
> Corrected a few spelling mistakes to improve the readability.
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 2 +-
>  Documentation/filesystems/iomap/operations.rst           | 2 +-
>  Documentation/virt/kvm/review-checklist.rst              | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
> index 46d0b036c97e..191085b0d5e8 100644
> --- a/Documentation/devicetree/bindings/submitting-patches.rst
> +++ b/Documentation/devicetree/bindings/submitting-patches.rst
> @@ -66,7 +66,7 @@ I. For patch submitters
>       any DTS patches, regardless whether using existing or new bindings, should
>       be placed at the end of patchset to indicate no dependency of drivers on
>       the DTS.  DTS will be anyway applied through separate tree or branch, so
> -     different order would indicate the serie is non-bisectable.
> +     different order would indicate the series is non-bisectable.
>  
>       If a driver subsystem maintainer prefers to apply entire set, instead of
>       their relevant portion of patchset, please split the DTS patches into
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 067ed8e14ef3..387fd9cc72ca 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -321,7 +321,7 @@ The fields are as follows:
>    - ``writeback_submit``: Submit the previous built writeback context.
>      Block based file systems should use the iomap_ioend_writeback_submit
>      helper, other file system can implement their own.
> -    File systems can optionall to hook into writeback bio submission.
> +    File systems can optionally hook into writeback bio submission.
>      This might include pre-write space accounting updates, or installing
>      a custom ``->bi_end_io`` function for internal purposes, such as
>      deferring the ioend completion to a workqueue to run metadata update
> diff --git a/Documentation/virt/kvm/review-checklist.rst b/Documentation/virt/kvm/review-checklist.rst
> index debac54e14e7..053f00c50d66 100644
> --- a/Documentation/virt/kvm/review-checklist.rst
> +++ b/Documentation/virt/kvm/review-checklist.rst
> @@ -98,7 +98,7 @@ New APIs
>    It is important to demonstrate your use case.  This can be as simple as
>    explaining that the feature is already in use on bare metal, or it can be
>    a proof-of-concept implementation in userspace.  The latter need not be
> -  open source, though that is of course preferrable for easier testing.
> +  open source, though that is of course preferable for easier testing.
>    Selftests should test corner cases of the APIs, and should also cover
>    basic host and guest operation if no open source VMM uses the feature.
>  

-- 
~Randy

