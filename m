Return-Path: <linux-fsdevel+bounces-11295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD3D85280B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 05:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B496B216C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 04:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305D11C82;
	Tue, 13 Feb 2024 04:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FO3zXqG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AD1119F;
	Tue, 13 Feb 2024 04:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707799474; cv=none; b=t1RzCbmgjwnajJgSeqBEgI+3ONDIEn6vXLVYSUiqBAOblZZH0Ez9T3XdbFsAGUFVCrD4LLcyhQcYlBGjcviK6u8ZfCtIxNRGeraHMWYIkAHm2MOFw5DTVH4s1Thuas6xCtiSY9NLlrzTxYuvKxx04zfJX2wmppBqbbIA1ZUxBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707799474; c=relaxed/simple;
	bh=gnalbakfUEoOVuduLGkajwEg9F3QSmxtaFgbnbfzLCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCkJDkPCh5y7CeBoLYP8MGsUvy44QwfDyk2GyRuyVoHUk9xIOQ40aCi7QVciWHce74UizGgUCwBG+/6L4j1nrSKqBlPGrrLi4qOLLnt04rqCKH4HHL1GHBuY7szOTKZw21YJOzko9Odj3kY6KxmXoUGg+DEL5Ru8QUvWh+TFXZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FO3zXqG/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707799465;
	bh=gnalbakfUEoOVuduLGkajwEg9F3QSmxtaFgbnbfzLCg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FO3zXqG/u0XUNzD7u/XRn6hsYQgbLHIKn7VBtzv1ogBR6c1s7hpxxn8ePE0/FcXzy
	 svO99ZISnkx8X5b2W7WUDPDd/lrLIm+wMAouCKv2rf2dZIhHrJxqRcS3jlRxUIU/Tq
	 L5XEKFCNde8m/eP4QyRKASXFVjF2PdTWXBCkqws4lpLUOff1GFaGHQfYZNXg0j85i8
	 cYIgYlM6BEbDBZZWo+CD/pfsj7yeAvWI/DlBJYmwJ+Y7uvLCwDcCgzzSzIPr6RfigF
	 S2o12acOiDEHMtfdtnAzZgyHR+lAB/0UutA1i+4CmUKFIXiwjNvspFJUFgJgQLrTQG
	 0ofxPSOZUnOjA==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B67EF378203B;
	Tue, 13 Feb 2024 04:44:20 +0000 (UTC)
Message-ID: <1b7d51df-4995-4a4a-8ec4-f1ea4975e44c@collabora.com>
Date: Tue, 13 Feb 2024 06:44:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v9 1/3] libfs: Introduce case-insensitive string
 comparison helper
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel@collabora.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
 Eric Biggers <ebiggers@google.com>
References: <20240208064334.268216-1-eugen.hristev@collabora.com>
 <20240208064334.268216-2-eugen.hristev@collabora.com>
 <87ttmivm1i.fsf@mailhost.krisman.be>
 <ff492e0f-3760-430e-968a-8b2adab13f3f@collabora.com>
 <87plx5u2do.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <87plx5u2do.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 16:40, Gabriel Krisman Bertazi wrote:
> Eugen Hristev <eugen.hristev@collabora.com> writes:
> 
>> On 2/8/24 20:38, Gabriel Krisman Bertazi wrote:
> 
>>> (untested)
>>
>> I implemented your suggestion, but any idea about testing ? I ran smoke on xfstests
>> and it appears to be fine, but maybe some specific test case might try the
>> different paths here ?
> 
> Other than running the fstests quick group for each affected filesystems
> looking for regressions, the way I'd do it is create a few files and
> look them up with exact and inexact name matches.  While doing that,
> observe through bpftrace which functions got called and what they
> returned.
> 
> Here, since you are testing the uncached lookup, you want to make sure
> to drop the cached version prior to each lookup.
> 


Hello Gabriel,

With the changes you suggested, I get these errors now :

[  107.409410] EXT4-fs error (device sda1): ext4_lookup:1816: inode #521217: comm
ls: 'CUC' linked to parent dir
ls: cannot access '/media/CI_dir/CUC': Structure needs cleaning
total 8
drwxr-xr-x 2 root root 4096 Feb 12 11:51 .
drwxr-xr-x 4 root root 4096 Feb 12 11:47 ..
-????????? ? ?    ?       ?            ? CUC

Do you have any idea about what is wrong ?

Thanks,
Eugen

