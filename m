Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B5313DEC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 16:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgAPPaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 10:30:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34229 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPPaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:30:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id w5so7404857wmi.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 07:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=O2z4n8RO8/tzUwxriTyw0M9sRnVtCTjAscvkNdepNLw=;
        b=RhVwzne/xdCamnA3jCcDoOS9ABTbj+EwOCjuwBQ78Vcbh2VPhnq2ce7m4/rt2w/Sbg
         fCc1JWfOTUXpFfJLN80uDA+qKcDKmDIqQre6HMIIUMN0GrYnlIkYCRwQKQ6VFhc7CluY
         QTcxkeQMoIPJKswXDLLTL9czMWf2lrTBjAcltQXNwCxt8kHSD3kZ5hgnpQrg6K+jsh/9
         BVocYK89pmnKFGaeUdBOscWjGMHmkW5X9hq47MZK0FiEWYOk531eY6XHYxtSbTJxngOO
         AwCoSJsmLRqip6zvj4fN0WZvCmhM1p1Gb6+EhJrtNxJKG+dK5Z8ExknXN99TUNSzcWJA
         UqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O2z4n8RO8/tzUwxriTyw0M9sRnVtCTjAscvkNdepNLw=;
        b=HWM3lD2Y7q4dXMslIcidcrdNlk0y7oRw5SvHZifwzYq9M/iYsguq6MqzHDWfKvKtzm
         xYX2JbY0Aw81CzL7eOssCPDhNJIet3I5e9RomLel2su7Jdb9WY6tuVIfN+yrK83SS+uq
         8P7kfoGW8P+IIOJjBbQsDFM1VxZaCethVdTI3shUun+w/9JH/PCEAz0zLQ7YtMMPxudj
         +qAF6JTQDQ3Ky0LvAqYQM3Tb1d2giXQBIPifeCrM65rPQmQHHXWmNwVpgmopnxdF4B3G
         w8Z8Y1YvWrLHrMnSRliX3dpPb0orWh+vlhVzsjA+9FFxE/9xqrgjpNGye3mY6egKuxiN
         dgYA==
X-Gm-Message-State: APjAAAWAnjETs2AgTT7Wdkn0vLO8xHUnyPKeMRkDRq9SfEkxz7i3i03I
        LXHK/u9NvNl/X0+VuD7jfbw=
X-Google-Smtp-Source: APXvYqz2MnsiLTzlarD712BGQKPgzhqE05fejS2znb0Iq4a6EEQd5zx3ZmCauVWOy/sQ9phzcpG2vA==
X-Received: by 2002:a05:600c:48a:: with SMTP id d10mr6654356wme.87.1579188621611;
        Thu, 16 Jan 2020 07:30:21 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i11sm30498438wrs.10.2020.01.16.07.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 07:30:20 -0800 (PST)
Date:   Thu, 16 Jan 2020 16:30:19 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: udf: Suspicious values in udf_statfs()
Message-ID: <20200116153019.5awize7ufnxtjagf@pali>
References: <20200112162311.khkvcu2u6y4gbbr7@pali>
 <20200113120851.GG23642@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113120851.GG23642@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 13 January 2020 13:08:51 Jan Kara wrote:
> Hello,
> 
> On Sun 12-01-20 17:23:11, Pali Rohár wrote:
> > I looked at udf_statfs() implementation and I see there two things which
> > are probably incorrect:
> > 
> > First one:
> > 
> > 	buf->f_blocks = sbi->s_partmaps[sbi->s_partition].s_partition_len;
> > 
> > If sbi->s_partition points to Metadata partition then reported number
> > of blocks seems to be incorrect. Similar like in udf_count_free().
> 
> Oh, right. This needs similar treatment like udf_count_free(). I'll fix it.
> Thanks for spotting.

Ok.

> > Second one:
> > 
> > 	buf->f_files = (lvidiu != NULL ? (le32_to_cpu(lvidiu->numFiles) +
> > 					  le32_to_cpu(lvidiu->numDirs)) : 0)
> > 			+ buf->f_bfree;
> > 
> > What f_files entry should report? Because result of sum of free blocks
> > and number of files+directories does not make sense for me.
> 
> This is related to the fact that we return 'f_bfree' as the number of 'free
> file nodes' in 'f_ffree'. And tools generally display f_files-f_ffree as
> number of used inodes. In other words we treat every free block also as a
> free 'inode' and report it in total amount of 'inodes'. I know this is not
> very obvious but IMHO it causes the least confusion to users reading df(1)
> output.

So current code which returns sum of free blocks and number of
files+directories is correct. Could be this information about statvfs
f_files somewhere documented? Because this is not really obvious nor for
userspace applications which use statvfs() nor for kernel filesystem
drivers.

-- 
Pali Rohár
pali.rohar@gmail.com
