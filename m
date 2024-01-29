Return-Path: <linux-fsdevel+bounces-9401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D19D0840AB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3801F24F37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E55155309;
	Mon, 29 Jan 2024 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eH5y4ydM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0A155304;
	Mon, 29 Jan 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544016; cv=none; b=lVV1Gcy99AQ7/CiGJxFRgi88si9ERyeTQXGY5nS3FIflJYqliWQTH5E+VSPQcYYitLzhjCEs7ONZ/eZQks0jVyUqfNk1tALWzEcgVBQnZ2SCqGNAkpQZ/j05KCQRKtQWjtXn1to9LEnmIkBvfSaA9ODru2zCD1OgFghRjF5QdYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544016; c=relaxed/simple;
	bh=d6TFGi8BNctQDCOOatr9FnKfaGcVCb8rRipdC9S04zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvYOK9a9mCRbWIjEGm5C6tnFMaNwgThrQ4caiL0ywzj/KyxXpVt14l+WQEV428FvfRxLMjr642JRXzP2Jz9TmyoDu7k4I3G0IUjnDpq0PrcyF52jP/rikoJpGOMUhfiBSMHfJP80ZGZ//XkUJ9pMea9HHpw5ZstH5SxPKFPxh38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=eH5y4ydM; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706544004;
	bh=d6TFGi8BNctQDCOOatr9FnKfaGcVCb8rRipdC9S04zA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eH5y4ydMRbjU95Ip5rq/FteulTBNtfQKx8mOIFp1ZYUmBoPKXEL40d2RlYMIfhbVx
	 +TiWTWQ0BxCUziwp5QxjUncNLRFiqB5dptErtl+YbgRmL8yI2BmHrCTtVrZxhiC8Fg
	 vT1kyFfHfAhPY0KG8ueGARoBM3M03Rb543NWzPz3SR0+2DqBH9nSU65sOcCREVE+89
	 n+wSkfoOcBNepLWJTEXGLl/ad+bd4DtyOKSEwmHj4QJ9oOVGZjTHOEo6YPVszVFRZo
	 umqepby1hblCNj/hBrn66bW7B8Y7pR3uwo7moTgpoZ5nVFv38om2wIi9OL7rICI5tC
	 oCqmB+19MyMag==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TNtKw3S5fzVXK;
	Mon, 29 Jan 2024 11:00:04 -0500 (EST)
Message-ID: <3120f1f0-eaf8-4058-9a65-bdbee28c68c9@efficios.com>
Date: Mon, 29 Jan 2024 11:00:04 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20240126150209.367ff402@gandalf.local.home>
 <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home>
 <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com>
 <CAHk-=whAG6TM6PgH0YnsRe6U=RzL+JMvCi=_f0Bhw+q_7SSZuw@mail.gmail.com>
 <29be300d-00c4-4759-b614-2523864c074b@efficios.com>
 <CAHk-=wjpyv+fhxzV+XEQgsC+-HaouKT7Ns8qT31jkpN_Jm84_g@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=wjpyv+fhxzV+XEQgsC+-HaouKT7Ns8qT31jkpN_Jm84_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-26 17:49, Linus Torvalds wrote:
> On Fri, 26 Jan 2024 at 14:41, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Yes, there is even a note about stat.st_size in inode(7) explaining
>> this:
> 
> Good. Send a patch to do the same for st_ino.

This breaks "cp -aH" and "cp -aL". Even setting st_nlink={0,1}
does not help there, from coreutils 9.1:

copy_internal():

[...]
   else if (x->preserve_links
            && !x->hard_link
            && (1 < src_sb.st_nlink
                || (command_line_arg
                    && x->dereference == DEREF_COMMAND_LINE_ARGUMENTS)
                || x->dereference == DEREF_ALWAYS))
     {
       earlier_file = remember_copied (dst_relname,
                                       src_sb.st_ino, src_sb.st_dev);
     }

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


