Return-Path: <linux-fsdevel+bounces-58901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFCBB3335A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 01:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD01817F02C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 23:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89B4270548;
	Sun, 24 Aug 2025 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZGSTosll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52921FF2A;
	Sun, 24 Aug 2025 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756079694; cv=none; b=iP1KnsL1I5yT4P/K4ATjCszq7GqE6sXuWDx6uCEi0+urzaUXyj0XJT8UKSlhmiWlqG1QheWpVOK/TbHQFohpQo062d1OutM7ZqeNUvBvXcq6mlF0Z9BmLd0mbOKaHcBIUvvoMKoDw5suKthwepCIOmxkRwRWQkYLEcKIQnfqABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756079694; c=relaxed/simple;
	bh=EPvpw/HB0JIK9on+shXgvx1Fgh9VbjJay+vox4FNxD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFaVT6zPvKxQD08xSkiuYse652lHCMezPiCeFw5eg5+KHimQIRyVOL0uxppv28QrSkVgY+Q1Nw2qwRcSgXzSx1Wil2F1rHdqbDMJOyN7fgO0KhYYRwY2pqfr4qknCp8nLKjU0t08lrQtnxKTF2SiZdhUUt0dJn8I0EIYKLDCcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZGSTosll; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IbALCsfsR+MAiQYJZNzeI91q7zOev/5ha7scZVR2jKc=; b=ZGSTosllZqZB0fkvFXI+A3NcTA
	iw280Bnsv6VawvGDy2YjR53X90BvQh5KXR80VUbZWeOOcFuVM56kElkzFr04bK6EDHP/7oYqX7fwn
	3/kRaUlyQcxM1Oof0LNVbv/fIkHjpcgV0gZjnz16W70QFX5GMRncdIoFovZsz++bUahmNQlgQZsoK
	TQ85L8FrBvydryZWP3atiAdgfT6wMtomnUPXcfHTsC6Okg4d13n4SvU2qCzcnHKNrPzRhBsj5LMLt
	m0s7AfRUUePLhGsmas0/Nj+UeMktfnOtlOaOmGlEYPIOHWNzDDL3lSgZiB5d/a53H3Gc6uAywT2AI
	fkHw8LxA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqKXy-00000006ds0-3UN7;
	Sun, 24 Aug 2025 23:54:50 +0000
Message-ID: <9b2c8fe2-cf17-445b-abd7-a1ed44812a73@infradead.org>
Date: Sun, 24 Aug 2025 16:54:50 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uapi/fcntl: conditionally define AT_RENAME* macros
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org
References: <20250824221055.86110-1-rdunlap@infradead.org>
 <aKuedOXEIapocQ8l@casper.infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aKuedOXEIapocQ8l@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/24/25 4:21 PM, Matthew Wilcox wrote:
> On Sun, Aug 24, 2025 at 03:10:55PM -0700, Randy Dunlap wrote:
>> Don't define the AT_RENAME_* macros when __USE_GNU is defined since
>> /usr/include/stdio.h defines them in that case (i.e. when _GNU_SOURCE
>> is defined, which causes __USE_GNU to be defined).
>>
>> Having them defined in 2 places causes build warnings (duplicate
>> definitions) in both samples/watch_queue/watch_test.c and
>> samples/vfs/test-statx.c.
> 
> It does?  What flags?
> 

for samples/vfs/test-statx.c:

In file included from ../samples/vfs/test-statx.c:23:
usr/include/linux/fcntl.h:159:9: warning: ‘AT_RENAME_NOREPLACE’ redefined
  159 | #define AT_RENAME_NOREPLACE     0x0001
In file included from ../samples/vfs/test-statx.c:13:
/usr/include/stdio.h:171:10: note: this is the location of the previous definition
  171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
usr/include/linux/fcntl.h:160:9: warning: ‘AT_RENAME_EXCHANGE’ redefined
  160 | #define AT_RENAME_EXCHANGE      0x0002
/usr/include/stdio.h:173:10: note: this is the location of the previous definition
  173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
usr/include/linux/fcntl.h:161:9: warning: ‘AT_RENAME_WHITEOUT’ redefined
  161 | #define AT_RENAME_WHITEOUT      0x0004
/usr/include/stdio.h:175:10: note: this is the location of the previous definition
  175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT

for samples/watch_queue/watch_test.c:

In file included from usr/include/linux/watch_queue.h:6,
                 from ../samples/watch_queue/watch_test.c:19:
usr/include/linux/fcntl.h:159:9: warning: ‘AT_RENAME_NOREPLACE’ redefined
  159 | #define AT_RENAME_NOREPLACE     0x0001
In file included from ../samples/watch_queue/watch_test.c:11:
/usr/include/stdio.h:171:10: note: this is the location of the previous definition
  171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
usr/include/linux/fcntl.h:160:9: warning: ‘AT_RENAME_EXCHANGE’ redefined
  160 | #define AT_RENAME_EXCHANGE      0x0002
/usr/include/stdio.h:173:10: note: this is the location of the previous definition
  173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
usr/include/linux/fcntl.h:161:9: warning: ‘AT_RENAME_WHITEOUT’ redefined
  161 | #define AT_RENAME_WHITEOUT      0x0004
/usr/include/stdio.h:175:10: note: this is the location of the previous definition
  175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT


> #define AT_RENAME_NOREPLACE     0x0001
> #define AT_RENAME_NOREPLACE     0x0001
> 
> int main(void)
> {
> 	return AT_RENAME_NOREPLACE;
> }
> 
> gcc -W -Wall testA.c -o testA
> 
> (no warnings)
> 
> I'm pretty sure C says that duplicate definitions are fine as long
> as they're identical.
The vales are identical but the strings are not identical.

We can't fix stdio.h, but we could just change uapi/linux/fcntl.h
to match stdio.h. I suppose.

-- 
~Randy


