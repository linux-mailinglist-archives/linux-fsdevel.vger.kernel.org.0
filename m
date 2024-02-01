Return-Path: <linux-fsdevel+bounces-9912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18974845EAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 18:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C804428784C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6537784047;
	Thu,  1 Feb 2024 17:38:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1A84024
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809086; cv=none; b=Gl9YhWYZl6Kg4ZmBwVhrfGowA3K5XCp490zteEFgEkRuKbb6Rd262eQ39yXan5GQgH4v4W+wY87/715tAPRWQ+QtA6zR92ZvMHkNrd/FnBqBN8N85x+QZeEOzbNT41zEGL3oGIRK4BJetomI74icrwiKbLdinPTnoxg9BwaKgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809086; c=relaxed/simple;
	bh=F6aEyGx8n2KD1Dc+SF07MuC9HJNGbCCubSaI49hxeTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVoJJuCMhhD/J+WAyxuaPwEuIjW2OoGy7ogmCSI3/Rv329ffrUgv78UVDF5qIQVuFd/was416WrNh47h7JdPmQ2mbkK5+LNT8fVEhGVp3z20YtHDOoo0SqZVocKqcQf5VMjGyZ38cGveRdm6BQVvbFgwfREpCCa02VsWW5QzOJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso963165a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 09:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706809084; x=1707413884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gw83YyakVHHUi2A5N9A7N9A49UYycmoToICzHtmT4o=;
        b=I8BxEdR0I33F3jtQXA3XyLO/mdGTSMHkHmJAvhCXm7wkPEXk2Fm7FShONCwaa9nPsX
         rN65QRYbQuHc6vD3qax8TzR6rodFs8PK3T5YzRD6K+e67pn2ao+dBJ9B20wh1dCOtuJY
         gvaVDZPEcvmGY3LrsHdHDX1OqUVvk034gyn4+N1DjQ121Hqu9yNsM1yl886umtyy/IPc
         4hkQvg2+nAZBIXTYrpA3g7VH+nR+1AM3iWJebbI3vrJ6OOA31fsckQHRe6VnEUftOoPJ
         CmYEkiVZBbDB+dlPAYBDjP0EZ7YFtM9i/1L3vqymO/zJ71H/BHbyMDyG5HU5KT0/h9gb
         J+gg==
X-Gm-Message-State: AOJu0Yxzf9Tq1o0mtUaiaidgTREBeWELRpQvn1+52YJq9+Y4PhL205iD
	Fh4iRijPUw6crqyfH3pV2FRd90RYYNoXw1g5w9ZEMLA5B7V9p2bi
X-Google-Smtp-Source: AGHT+IELnjmzwRGy9RhratFzwYzzql1bfvD+AZLk+FDhP7YT5eSpgHFfpmZV/fljE+Ym/HpRleSQFQ==
X-Received: by 2002:a05:6a21:3984:b0:19e:4816:e71a with SMTP id ad4-20020a056a21398400b0019e4816e71amr1464965pzc.27.1706809083920;
        Thu, 01 Feb 2024 09:38:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXMiBB7pw4sQLlt9cMv+cvmShsgApSOhCrj4f/X8ZpKVHPI+W/xuOxNdGLYxXyZ9CcnKN6zwC6nfuO68m8zm1kwduqJ975K16A7RYJmNh7a/FLiUqkM/IgGXgGZKgI4rV0P3VZG8eH0DF3LvIcKdsuNRJLTVRuvEMjWIlz/kr9fcveOKSCTDMv3HEokeMmSu5PS5y0dbxF6+5137w5NywDIABtSrAeIg4hiyg2Fr8uIQlgs6B/1NmyhZnqJOB8S4zIxdvxdRQUEANY3q4S14Osmv7BwLV73pacUTlq6HNZrjI0IgEBUEah0W5lQdIdnbd6dKU100A0=
Received: from ?IPV6:2620:0:1000:8411:170e:a1a5:1887:adb2? ([2620:0:1000:8411:170e:a1a5:1887:adb2])
        by smtp.gmail.com with ESMTPSA id i17-20020aa78b51000000b006d98ae070c3sm2548pfd.135.2024.02.01.09.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 09:38:03 -0800 (PST)
Message-ID: <ab80ec3c-db9c-439e-8476-e4404574dfed@acm.org>
Date: Thu, 1 Feb 2024 09:38:02 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] fs: Split fcntl_rw_hint()
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20240131205237.3540210-1-bvanassche@acm.org>
 <20240131205237.3540210-4-bvanassche@acm.org>
 <Zbq2e7e8Ba1Df6O7@dread.disaster.area>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Zbq2e7e8Ba1Df6O7@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 13:07, Dave Chinner wrote:
> On Wed, Jan 31, 2024 at 12:52:34PM -0800, Bart Van Assche wrote:
>> +	inode_lock(inode);
>> +	inode->i_write_hint = hint;
>> +	inode_unlock(inode);
> 
> What is this locking serialising against? The inode may or may not
> be locked when we access this in IO path, so why isn't this just
> WRITE_ONCE() here and READ_ONCE() in the IO paths?

How about using WRITE_ONCE()/READ_ONCE() in the fcntl implementations and
regular reads in the I/O paths? Using F_SET_RW_HINT while I/O is ongoing
is racy - there are no guarantees about how F_SET_RW_HINT will affect I/O
that has already been submitted. Hence, I think that it is acceptable to
use regular reads for i_write_hint in the I/O paths.

Thanks,

Bart.


