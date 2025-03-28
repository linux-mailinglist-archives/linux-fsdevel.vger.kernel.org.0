Return-Path: <linux-fsdevel+bounces-45197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CADA74873
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 11:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1967A44E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B742212FB4;
	Fri, 28 Mar 2025 10:39:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ida.uls.co.za (ida.uls.co.za [154.73.32.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA171C174E;
	Fri, 28 Mar 2025 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.73.32.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158342; cv=none; b=dJhtWKEBfXT+Hw6gmlwbmet6k3aYexf4afnzRuhyS5IUITM1Cpgypesf5Y9P16Uy25pklAr7kJMlkrwARZQtq6ckGz5/aOfh8aJZdX3U+l6H64YNSRdZzWJHNbGeMwkwFglUC5nPuxIrYswdOVYpDX7RMhygfT/InXnW9MLYZUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158342; c=relaxed/simple;
	bh=6zs68KjFBc2NWuANq0MsVCZr21SX+bieOksWA+N9xu8=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:To:From:
	 In-Reply-To:Content-Type; b=LdIk21iHe6yD+DBsj6Bgi0LK9QD3syn5wTkUibJuvSa12+N+iAuEksOFzoUPZsYvrCcnydNNR80hU37HS7IKvmw2NeAOX5HGzet27eUTaOMO1LGuO3tshXAXm/GO2ogDEJ5GKA+a45dfpUaR/zRp+EKfMFaqcOdfIXAo4r0oLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za; spf=pass smtp.mailfrom=uls.co.za; arc=none smtp.client-ip=154.73.32.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uls.co.za
Received: from [192.168.241.128]
	by ida.uls.co.za with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <jaco@uls.co.za>)
	id 1ty6kg-000000004ga-0JvK;
	Fri, 28 Mar 2025 12:15:50 +0200
Message-ID: <05b36be3-f43f-4a49-9724-1a0d8d3a8ce4@uls.co.za>
Date: Fri, 28 Mar 2025 12:15:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse: increase readdir() buffer size
Cc: bernd.schubert@fastmail.fm, miklos@szeredi.hu, rdunlap@infradead.org,
 trapexit@spawn.link
References: <20230727081237.18217-1-jaco@uls.co.za>
 <20250314221701.12509-1-jaco@uls.co.za>
Content-Language: en-GB
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jaco Kroon <jaco@uls.co.za>
Autocrypt: addr=jaco@uls.co.za; keydata=
 xsBNBFXtplYBCADM6RTLCOSPiclevkn/gdf8h9l+kKA6N+WGIIFuUtoc9Gaf8QhXWW/fvUq2
 a3eo4ULVFT1jJ56Vfm4MssGA97NZtlOe3cg8QJMZZhsoN5wetG9SrJvT9Rlltwo5nFmXY3ZY
 gXsdwkpDr9Y5TqBizx7DGxMd/mrOfXeql57FWFeOc2GuJBnHPZQMJsQ66l2obPn36hWEtHYN
 gcUSPH3OOusSEGZg/oX/8WSDQ/b8xz1JKTEgcnu/JR0FxzjY19zSHmbnyVU+/gF3oeJFcEUk
 HvZu776LRVdcZ0lb1bHQB2K9rTZBVeZLitgAefPVH2uERVSO8EZO1I5M7afV0Kd/Vyn9ABEB
 AAHNG0phY28gS3Jvb24gPGphY29AdWxzLmNvLnphPsLAdwQTAQgAIQUCVe2mVgIbAwULCQgH
 AgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAILcSxr/fungCPB/sHrfufpRbrVTtHUjpbY4bTQLQE
 bVrh4/yMiKprALRYy0nsMivl16Q/3rNWXJuQ0gR/faC3yNlDgtEoXx8noXOhva9GGHPGTaPT
 hhpcp/1E4C9Ghcaxw3MRapVnSKnSYL+zOOpkGwye2+fbqwCkCYCM7Vu6ws3+pMzJNFK/UOgW
 Tj8O5eBa3DiU4U26/jUHEIg74U+ypYPcj5qXG0xNXmmoDpZweW41Cfo6FMmgjQBTEGzo9e5R
 kjc7MH3+IyJvP4bzE5Paq0q0b5zZ8DUJFtT7pVb3FQTz1v3CutLlF1elFZzd9sZrg+mLA5PM
 o8PG9FLw9ZtTE314vgMWJ+TTYX0kzsBNBFXtplYBCADedX9HSSJozh4YIBT+PuLWCTJRLTLu
 jXU7HobdK1EljPAi1ahCUXJR+NHvpJLSq/N5rtL12ejJJ4EMMp2UUK0IHz4kx26FeAJuOQMe
 GEzoEkiiR15ufkApBCRssIj5B8OA/351Y9PFore5KJzQf1psrCnMSZoJ89KLfU7C5S+ooX9e
 re2aWgu5jqKgKDLa07/UVHyxDTtQKRZSFibFCHbMELYKDr3tUdUfCDqVjipCzHmLZ+xMisfn
 yX9aTVI3FUIs8UiqM5xlxqfuCnDrKBJjQs3uvmd6cyhPRmnsjase48RoO84Ckjbp/HVu0+1+
 6vgiPjbe4xk7Ehkw1mfSxb79ABEBAAHCwF8EGAEIAAkFAlXtplYCGwwACgkQCC3Esa/37p7u
 XwgAjpFzUj+GMmo8ZeYwHH6YfNZQV+hfesr7tqlZn5DhQXJgT2NF6qh5Vn8TcFPR4JZiVIkF
 o0je7c8FJe34Aqex/H9R8LxvhENX/YOtq5+PqZj59y9G9+0FFZ1CyguTDC845zuJnnR5A0lw
 FARZaL8T7e6UGphtiT0NdR7EXnJ/alvtsnsNudtvFnKtigYvtw2wthW6CLvwrFjsuiXPjVUX
 825zQUnBHnrED6vG67UG4z5cQ4uY/LcSNsqBsoj6/wsT0pnqdibhCWmgFimOsSRgaF7qsVtg
 TWyQDTjH643+qYbJJdH91LASRLrenRCgpCXgzNWAMX6PJlqLrNX1Ye4CQw==
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <20250314221701.12509-1-jaco@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-report: Relay access (ida.uls.co.za).

Hi All,

I've not seen feedback on this, please may I get some direction on this?

Kind regards,
Jaco

On 2025/03/15 00:16, Jaco Kroon wrote:
> This is a follow up to the attempt made a while ago.
>
> Whist the patch worked, newer kernels have moved from pages to folios,
> which gave me the motivation to implement the mechanism based on the
> userspace buffer size patch that Miklos supplied.
>
> That patch works as is, but I note there are changes to components
> (overlayfs and exportfs) that I've got very little experience with, and
> have not tested specifically here.  They do look logical.  I've marked
> Miklos as the Author: here, and added my own Signed-off-by - I hope this
> is correct.
>
> The second patch in the series implements the changes to fuse's readdir
> in order to utilize the first to enable reading more than one page of
> dent structures at a time from userspace, I've included a strace from
> before and after this patch in the commit to illustrate the difference.
>
> To get the relevant performance on glusterfs improved (which was
> mentioned elsewhere in the thread) changes to glusterfs to increase the
> number of cached dentries is also required (these are pushed to github
> but not yet merged, because similar to this patch, got stalled before
> getting to the "ready for merge" phase even though it's operational).
>
> Please advise if these two patches looks good (I've only done relatively
> basic testing now, and it's not running on production systems yet)
>
> Kind regards,
> Jaco
>

