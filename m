Return-Path: <linux-fsdevel+bounces-33977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67499C11E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 23:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFF71F219F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 22:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490D721A4AA;
	Thu,  7 Nov 2024 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="hQSbh+rl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A17215C43;
	Thu,  7 Nov 2024 22:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018873; cv=none; b=I9B3CMqUQdYmzD5PD7k8dmccT1bC7FIHT7flZrN2vKL0YNpp1oToq7QUCNZd3hlaCO3OrZPprUe/Re50hQ1V1xA8xQTYLd31JQN05F/qQIeClJIMNokkDGFIdX27YTThDPG0ZtHyyjOlWWzYVCT6rJ6UWGkxSpHzPxtm5gpiXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018873; c=relaxed/simple;
	bh=ZxtAFmqRyaL65o3iODo/mU+qk8X/7FdzrLxnMlUsyEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pESJqX44aNJLoxMdwZfiWE5xvjxK0/P80hQqhKmbdR203JsJ1c9hOCpz/v7xCLpZ4bAEbF5nIHmxAEb1bjHJTEM20fOtSHTKs9M3a7h+At1ZRdsyi8oYzYH1Dk9z5rQPu14ejdiFN6VN/FxVqjevTkqIcuCVi8Quy1TD6/Wuguo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=hQSbh+rl; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id EB6BF41A48;
	Thu,  7 Nov 2024 22:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1731018867;
	bh=ZxtAFmqRyaL65o3iODo/mU+qk8X/7FdzrLxnMlUsyEI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hQSbh+rlc3sFazzd5eQwlhQPvaqWDd5n+eAUfrmgOFjidXW9nDdCqlnmysXzFtEL9
	 VVrmW/+zJ8zJ9O1aMHJXkhROaPFaOXtl3qBKON+UjwFXB2EfIBvyLluOwDOuA3s3Lr
	 OOPFeBSYf+3sNR5Bpp9yv8HUBDeSNgUjXzGIuj8+msQNxNEWqvMkaI+gGKtKnOEbTy
	 qZ5ENd7Jx1bcoGvg2VTDCoxKq8lf0adGjSbQSdLgRUwj3HnbEfGTO2NFAIYznB3xzI
	 0HniB+frkhhhJSOIxQVkVEulUikvCVYjejvtz7eNeHz1PWkSf1yUiwfaKZUas5A9NY
	 aOglUrMfgVByQ==
Message-ID: <6c8024f4-bfea-4934-9120-b17ab0770a1f@asahilina.net>
Date: Fri, 8 Nov 2024 07:34:26 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
To: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Sergio Lopez Pascual
 <slp@redhat.com>, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
 <20241104105711.mqk4of6frmsllarn@quack3>
 <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
 <ZylHyD7Z+ApaiS5g@dread.disaster.area>
 <21f921b3-6601-4fc4-873f-7ef8358113bb@asahilina.net>
 <20241106121255.yfvlzcomf7yvrvm7@quack3>
 <672bcab0911a2_10bc62943f@dwillia2-xfh.jf.intel.com.notmuch>
 <20241107100105.tktkxs5qhkjwkckg@quack3>
 <28308919-7e47-49e4-a821-bcd32f73eecb@asahilina.net>
 <672d300566c69_10bb7294d7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <672d300566c69_10bb7294d7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/8/24 6:24 AM, Dan Williams wrote:
> Asahi Lina wrote:
> [..]
>> I don't think that's how it actually works, at least on arm64.
>> arch_wb_cache_pmem() calls dcache_clean_pop() which is either dc cvap or
>> dc cvac. Those are trapped by HCR_EL2<TPC>, and that is never set by KVM.
>>
>> There was some discussion of this here:
>> https://lore.kernel.org/all/20190702055937.3ffpwph7anvohmxu@US-160370MP2.local/
>>
>> But I'm not sure that all really made sense then.
>>
>> msync() and fsync() should already provide persistence. Those end up
>> calling vfs_fsync_range(), which becomes a FUSE fsync(), which fsyncs
>> (or fdatasyncs) the whole file. What I'm not so sure is whether there
>> are any other codepaths that also need to provide those guarantees which
>> *don't* end up calling fsync on the VFS. For example, the manpages kind
>> of imply munmap() syncs, though as far as I can tell that's not actually
>> the case. If there are missing sync paths, then I think those might just
>> be broken right now...
> 
> IIRC, from the pmem persistence dicussions, if userspace fails to call
> *sync then there is no obligation to flush on munmap() or close(). Some
> filesystems layer on those guarantees, but the behavior is
> implementation specific.

Then I think your patch should be fine then, since there's nothing to do
for writepages(). The syncing is handled via fsync() for FUSE/virtiofs
and I don't think the dax_writeback_mapping_range() is actually doing
anything in KVM anyway.

~~ Lina


