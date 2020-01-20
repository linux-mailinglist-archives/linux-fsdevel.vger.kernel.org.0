Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE021428CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 12:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgATLEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 06:04:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38078 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgATLEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:04:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so14239463wmc.3;
        Mon, 20 Jan 2020 03:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fMgA2IlKF4foqDDRTZWDuHqhdy+ZvLnJ5Qyt7SeTruM=;
        b=dNQchdWMDUMBcm43vAZi9xHzgG48+QTzA5Yk4xkSraJNGabUPdFREFLNWGbZaNJTeb
         YfLk+DqiBu6HZqrEPRYZPpI+Gq88KatexOKxR+juNKcYum72+M5JCYsQSKhG+rxOucfN
         yKX2XLpMCeGtnxau/FBKVpwtC1KcjyMrBffPY95z57ToDV1rO2F6+Kgb8Apxfb9rM8v2
         cyv+ofpb0hmmS+GAqDlLqWjIp7RxuvmZPE+UlM+M2OKlvzHEy8lv0V/ImZqq1KEs29lH
         Pcl3gszfCU3GGbS29Kla3GfB6OPJYEVGSJeqSi7JFOpVOYw8KFWnE62E/DDIMi5nEJv7
         GkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fMgA2IlKF4foqDDRTZWDuHqhdy+ZvLnJ5Qyt7SeTruM=;
        b=tyUwMJppI3Y6pEWBHwHTAkPezHMNZnRltQPip7lfowiFcYoK2AavD0gXzR/zcNAIZv
         GXRpM8+lWBwGNvUla4zEp62sl7+xLu1Nl/pCCcfBrpUovYYcpeiWOjB9tAm7S97e4Jk3
         hzVnV3j7A+Y0F+SCh2eYrhGlIS+XnTg3mAGk1eQujM5yFYkRxmySbxjUrXvH8xiUPLRK
         RJhzZLkMt3ZnnWFsl7RpglX3cEMTYHiQjYy3JZB5iJV+wobEZhU29xaJ52R7A6c/BgT9
         OatCbyfdF4Vsb+OsRUPExXBi3R9/sf6PId4pIBlH23S8VM5P7/Pz9WAL2P9Eoz7Q12NX
         v0ZA==
X-Gm-Message-State: APjAAAU5gg1CDDgsMug7MmNTZfo9PM+/w+Qf95Onf1HIdyfyvMntN299
        3UudZLlI7usM4cC3ZF1EENg=
X-Google-Smtp-Source: APXvYqzCEwZgPjh2AuOswAnz+eK0J2sTtoJ4EKUpM50fjy57ge9GqU4FjN1ocoeV8Yh/rINzvYAaaw==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr18967871wmg.66.1579518280431;
        Mon, 20 Jan 2020 03:04:40 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t8sm47371962wrp.69.2020.01.20.03.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:04:39 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:04:38 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120110438.ak7jpyy66clx5v6x@pali>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sgkan57p.fsf@mail.parknet.co.jp>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 20 January 2020 13:04:42 OGAWA Hirofumi wrote:
> Pali Rohár <pali.rohar@gmail.com> writes:
> 
> > Which means that fat_name_match(), vfat_hashi() and vfat_cmpi() are
> > broken for vfat in UTF-8 mode.
> 
> Right. It is a known issue.

Could be this issue better documented? E.g. in mount(8) manpage where
are written mount options for vfat? I think that people should be aware
of this issue when they use "utf8=1" mount option.

> > I was thinking how to fix it, and the only possible way is to write a
> > uni_tolower() function which takes one Unicode code point and returns
> > lowercase of input's Unicode code point. We cannot do any Unicode
> > normalization as VFAT specification does not say anything about it and
> > MS reference fastfat.sys implementation does not do it neither.
> >
> > So, what would be the best option for implementing that function?
> >
> >   unicode_t uni_tolower(unicode_t u);
> >
> > Could a new fs/unicode code help with it? Or it is too tied with NFD
> > normalization and therefore cannot be easily used or extended?
> 
> To be perfect, the table would have to emulate what Windows use. It can
> be unicode standard, or something other.

Windows FAT32 implementation (fastfat.sys) is opensource. So it should
be possible to inspect code and figure out how it is working.

I will try to look at it.

> And other fs can use different what Windows use.
> 
> So the table would have to be switchable in perfect world (if there is
> no consensus to use 1 table).  If we use switchable table, I think it
> would be better to put in userspace, and loadable like firmware data.
> 
> Well, so then it would not be simple work (especially, to be perfect).

Switchable table is not really simple and I think as a first step would
be enough to have one (hardcoded) table for UTF-8. Like we have for all
other encodings.

> Also, not directly same issue though. There is related issue for
> case-insensitive. Even if we use some sort of internal wide char
> (e.g. in nls, 16bits), dcache is holding name in user's encode
> (e.g. utf8). So inefficient to convert cached name to wide char for each
> access.

Yes, this is truth. But this conversion is already doing exFAT
implementation. I think we do not have other choice if we want Windows
compatible implementation.

> Relatively recent EXT4 case-insensitive may tackled this though, I'm not
> checking it yet.
> 
> > New exfat code which is under review and hopefully would be merged,
> > contains own unicode upcase table (as defined by exfat specification) so
> > as exfat is similar to FAT32, maybe reusing it would be a better option?
> 
> exfat just put a case conversion table in fs. So I don't think it helps
> fatfs.

exfat has fallback conversion table (hardcoded in driver) which is used
when fs itself does not have conversion table. This is mandated by exfat
specification. Part of exFAT specification is that default conversion
table.

I was thinking... as both VFAT and exFAT are MS standard and exFAT is
just evolved FAT32 we could use that exFAT default conversion table
(which is prevent in that exfat driver).

-- 
Pali Rohár
pali.rohar@gmail.com
