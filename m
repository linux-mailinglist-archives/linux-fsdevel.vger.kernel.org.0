Return-Path: <linux-fsdevel+bounces-20526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F68D4DBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68237B20F7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 14:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B4D16F0E8;
	Thu, 30 May 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="mKnzwg8w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783E1186E2F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078880; cv=none; b=MaciZpJxYbQj+RMy+T70ERmfqpNGUuHp4Yj/oW5vyvZX1SBFvwHWrnh3YyqHwUMdSyn0U4nvtc40DdqB6x0z2sEBeyVdfV3MShFs+49zaVGhhP/gUkiwQHtahQUE//MqpiwOlDT3JrRzgb6UoPf/ya/AzNiNHQ2DLO85rvKg8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078880; c=relaxed/simple;
	bh=wkDahDd8Er439gFASwWDGZ4+VoW0Cb93W6+lXHw1SDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUfxv0o2Jf5i+TdB/Md8UB3cBiBtZx2QONVyvC7id2n2dcPkW2FQBbIBZ9oJnB+FjDRRz4GT5zvQ5VVmI3i0OYARhKrQIMIAqk2aVYhUoX1SdgR4JGuGrxmswaT2E1sWB4l9E7K4GwKMpaZS0oU0NOEVe4ULT5KPZ8aZbppS/YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=mKnzwg8w; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id AABD611674;
	Thu, 30 May 2024 09:21:14 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net AABD611674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1717078874;
	bh=iQJObCKvk6E+Oyh1uOCC0CqiVP4MphWm/XSd6tBUbw0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mKnzwg8wrSikt0JLvoF8RwZ8WBdI5Ruq0YfOF9NVWziERBFg/vIWyCBDmuxzqFEZs
	 HQlolxGMmA+cx+9jc1J758jW2rS0sNJesvNoTSdzidhaca3xj0ee0QJtigmbX2PyAJ
	 CO392itO1oNwQidrlFffbURSNqgDRXuUQmjl3+Yrzov479SJvf1IgGjevapnGqKNuz
	 2YToL9aA4ledJmWkIhDVDzMpu0dv1bHa5GSFscA9yxhuUuuaDdZV4c+zc8AgM+3DvD
	 PdfdrOkvh25c29eJkLpqsVQNPQQqITS4nVfRkVwkmGMEUK6v22efEODC21YkL7dYdx
	 YRIbYDXPj+ZVw==
Message-ID: <8242b35c-b352-45f1-9476-056bf8a1b347@sandeen.net>
Date: Thu, 30 May 2024 09:21:13 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfs: Convert debugfs to use the new mount API
To: Christian Brauner <brauner@kernel.org>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
References: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
 <49d1f108-46e3-443f-85a3-6dd730c5d076@redhat.com>
 <20240306-beehrt-abweichen-a9124be7665a@brauner>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240306-beehrt-abweichen-a9124be7665a@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/24 4:50 AM, Christian Brauner wrote:
> Fwiw, Opt_{g,u}d I would like to see that either moved completely to the
> VFS or we need to provide standardized helpers.
> 
> The issue is that for a userns mountable filesytems the validation done
> here isn't enough and that's easy to miss (Obviously, debugfs isn't
> relevant as it's not userns mountable but still.). For example, for
> in tmpfs I recently fixed a bug where validation was wrong:
> 
>         case Opt_uid:
>                 kuid = make_kuid(current_user_ns(), result.uint_32);
>                 if (!uid_valid(kuid))
>                         goto bad_value;
> 
>                 /*
>                  * The requested uid must be representable in the
>                  * filesystem's idmapping.
>                  */
>                 if (!kuid_has_mapping(fc->user_ns, kuid))
>                         goto bad_value;
> 
>                 ctx->uid = kuid;
>                 break;
> 
> The crucial step where the {g,u}id must also be representable in the
> superblock's namespace not just in the caller's was missing. So really
> we should have a generic helper that we can reycle for all Opt_{g,u}id
> mount options or move that Opt_{g,u}id to the VFS itself. There was some
> nastiness involved in this when I last looked at this though. And all
> that invalfc() reporting should then also be identical across
> filesystems.
> 
> So that's a ToDo for the future.

Just FWIW, I started looking at this, and making i.e. an fsparam_uid() and
moving all the checking into the parser seemed like a nice idea, and it
removed a lot of boilerplate from several filesystems. Option parsing was
then looking like simply:

        fsparam_uid     ("uid",         Opt_uid),

...

        case Opt_uid:
               opts->uid = result.uid;
               break;

which is pretty nice, I think.

But unfortunately after 7f5d38141e30 ("new primitive: __fs_parse()"), parsers
no longer get an *fc, which means we can't get to fc->user_ns while parsing,
which I guess we need for proper validation.

It seems that 7f5d38141e30 was done for the benefit of rbd (?) - I'll have
to look more closely at that and see if we can resurrect access to fc, unless
there are other ways around this.

-Eric

