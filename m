Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF5FA79E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 04:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfKMDxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 22:53:10 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45237 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKMDxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:53:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id 30so1033557qtz.12;
        Tue, 12 Nov 2019 19:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Nq/J9uMGWrTnPkmQnrMD87MZeTWzLPk7BmlVxfF/ZKA=;
        b=YQYN9B7q/wgS02JIZyJ0TAbsW8KYwpEAmBGKKUlx67Z7+6Vb4gWCGYfdoBoMWpFmRG
         JVRzh/a7fNH7ZVcp5hhFNu0tJdkpkvhEBYO3GcQXtfMh6XlNAEnA0s3rLwGvWwOzWHgz
         t+uoeEU60G60xNt5bn0fN264JrnqVH7LkgqLnwRd2JEfGizjDV+sNR7dmO02endZWrwW
         ZKeu1amBq3VjCe67KsNjpIBxIO6K6bfMg8Fg2Ugj2fbBDMNOxibjfnGDQz4U1nZssUvY
         R9BZb48yYeyquwzTljIX1QXZlgf+Zd6mcJH4XrF98K94LJ7FYMxc5NsvHjIHQp8tX4Gm
         JosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Nq/J9uMGWrTnPkmQnrMD87MZeTWzLPk7BmlVxfF/ZKA=;
        b=d3MAqTFpGNagPFJwnGiXlfX2s0PqzZkLtppbwFh1sI2PI/hcbXThvwMhYOY4QNetya
         1CncQEUIvYydCkfvnPmxF8KqKxxUGa3OIwha+FMXcdwugNLSUTKyEJGrboQpFxzyZdZC
         tNlknB5UXOw7Am3SKxnFJ2HzCBFCqwaDDxqMEVEt78dTIdhAoBl10q9KDxquk0t3hC8e
         HgO/Bwy6aLhyi6DVjd3kg7RO8cSLh94pNrmKJIHL3p4Cylk+5yNzIfh8D8u9leYpFadY
         +sm0gzv0Qlwv5FAAvXJcI/PW0lUrAJOc+mOybU4nk8Rk+nxiEzOhAnj8eMjxXs0pXVlx
         GxzA==
X-Gm-Message-State: APjAAAXcya2ukUjf1PTDPz5HGlzGxcgE8R+dXsXpv6f1GIC6MxVj1Ge4
        xE3wVZMR71oqtcqeDOh1J/JdHgP+
X-Google-Smtp-Source: APXvYqyl3AbKpUGwgYcN0lQfHM1ZMlimpb/l1TpYE32YfSHOe37RyNtLc93445Ah2lYB3H0h1G7iug==
X-Received: by 2002:ac8:23d3:: with SMTP id r19mr753535qtr.297.1573617189374;
        Tue, 12 Nov 2019 19:53:09 -0800 (PST)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id a4sm358914qkk.113.2019.11.12.19.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 19:53:08 -0800 (PST)
Date:   Wed, 13 Nov 2019 00:53:04 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/16] hfs/hfsplus: use 64-bit inode timestamps
Message-ID: <20191113035304.GA8753@eaf>
References: <20191108213257.3097633-1-arnd@arndb.de>
 <20191108213257.3097633-14-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191108213257.3097633-14-arnd@arndb.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 08, 2019 at 10:32:51PM +0100, Arnd Bergmann wrote:
> The interpretation of on-disk timestamps in HFS and HFS+ differs
> between 32-bit and 64-bit kernels at the moment. Use 64-bit timestamps
> consistently so apply the current 64-bit behavior everyhere.
> 
> According to the official documentation for HFS+ [1], inode timestamps
> are supposed to cover the time range from 1904 to 2040 as originally
> used in classic MacOS.
> 
> The traditional Linux usage is to convert the timestamps into an unsigned
> 32-bit number based on the Unix epoch and from there to a time_t. On
> 32-bit systems, that wraps the time from 2038 to 1902, so the last
> two years of the valid time range become garbled. On 64-bit systems,
> all times before 1970 get turned into timestamps between 2038 and 2106,
> which is more convenient but also different from the documented behavior.
> 
> Looking at the Darwin sources [2], it seems that MacOS is inconsistent in
> yet another way: all timestamps are wrapped around to a 32-bit unsigned
> number when written to the disk, but when read back, all numeric values
> lower than 2082844800U are assumed to be invalid, so we cannot represent
> the times before 1970 or the times after 2040.
> 
> While all implementations seem to agree on the interpretation of values
> between 1970 and 2038, they often differ on the exact range they support
> when reading back values outside of the common range:
> 
> MacOS (traditional):		1904-2040
> Apple Documentation:		1904-2040
> MacOS X source comments:	1970-2040
> MacOS X source code:		1970-2038
> 32-bit Linux:			1902-2038
> 64-bit Linux:			1970-2106
> hfsfuse:			1970-2040
> hfsutils (32 bit, old libc)	1902-2038
> hfsutils (32 bit, new libc)	1970-2106
> hfsutils (64 bit)		1904-2040
> hfsplus-utils			1904-2040
> hfsexplorer			1904-2040
> 7-zip				1904-2040
> 
> Out of the above, the range from 1970 to 2106 seems to be the most useful,
> as it allows using HFS and HFS+ beyond year 2038, and this matches the
> behavior that most users would see today on Linux, as few people run
> 32-bit kernels any more.
> 
> Link: [1] https://developer.apple.com/library/archive/technotes/tn/tn1150.html
> Link: [2] https://opensource.apple.com/source/hfs/hfs-407.30.1/core/MacOSStubs.c.auto.html
> Link: https://lore.kernel.org/lkml/20180711224625.airwna6gzyatoowe@eaf/
> Cc: Viacheslav Dubeyko <slava@dubeyko.com>
> Suggested-by: "Ernesto A. Fernández" <ernesto.mnd.fernandez@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
