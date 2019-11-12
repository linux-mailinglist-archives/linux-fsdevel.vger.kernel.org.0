Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9AF96D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 18:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKLRPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 12:15:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41835 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLRP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:15:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id 94so14968183oty.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 09:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVzIXHrO764GfG4Qiqm8/IBriT7RsdH75hTLmp9BmRA=;
        b=BV3xxOHWbIQpFI5CB7uozaEEkwDC3lyWKTSTyPa4TC3Rd1nV/7MnrtvXeaQ1Zn/abG
         nhzwgNg+HMP/zc7thH3+NozpyQbz1ePQ/ASz5y+YgICE0CRqSZzdHbEDliWn//CnYMRu
         vHRCY+Y8CVfx8lHiYzbdQMlPFcMr0aCT+stJMsIb3zLNuQGMY/pTwW26u1A1i3C9XOW+
         nw+Nq64NnYGla6dF2P9v2y4kMFTef25LsJwSzbFUjnSsxuStNJXwc4PC154fjf3VfdPF
         5LsksQleIaBa3iFOcbqYVbhweUIDtdGWopLOAv0G/rosJkOeTyOR/j9fGyVuxi7E4yrJ
         BsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVzIXHrO764GfG4Qiqm8/IBriT7RsdH75hTLmp9BmRA=;
        b=HwvZGc1uTMMmioa4SA0NHQyKz5UpsBRDFsKmJ+csJTAu5O2qkCM0XufxnFF9ysu3uI
         e+LBMN86mEd4kOQe/ftF7jhyyev5Ic4rx4cQfyCS6/0SCiM5SI6GPVT1sB84i05qLv4I
         /kv15pq3sihET9TBxf4PHpRj2C93a5RqR02gGiC4DmHRiobLHp6prWkB9/wnFeiaBFts
         6Ik9AIdRFOhiuH5HYvOeBA4U53aKUHDrybj23R3Sus4ctv4Zev+Ys4GBSU6TgsTXdY+N
         pNJEygpqYgFGpQxah0o2j8vLOV5XKTvNYivY8w5DtmokUub+WkD9vHHO9p0zuBC8pktI
         0I5w==
X-Gm-Message-State: APjAAAVvjphMeHBNtDw8552yLKho4MmfveImANtWmSvDmvmYa0zsBzll
        AUzmFsmZX6CTWAPMVP01e8lqwFdTiFSTH5NquJs36g==
X-Google-Smtp-Source: APXvYqxBWRXUbhgUeJAvflllA99xOkq97GoI6xicPLh5pWfFwhtbLObGxHb1Ub62atqTxWhI8Bsq8hQNoxBqMIRsSJw=
X-Received: by 2002:a9d:5f11:: with SMTP id f17mr4555105oti.207.1573578928797;
 Tue, 12 Nov 2019 09:15:28 -0800 (PST)
MIME-Version: 1.0
References: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Nov 2019 09:15:18 -0800
Message-ID: <CAPcyv4j75cQ4dSqyKGuioyyf0O9r0BG0TjFgv+w=64gLah5z6w@mail.gmail.com>
Subject: Re: DAX filesystem support on ARMv8
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 6:12 PM Bharat Kumar Gogada <bharatku@xilinx.com> wrote:
>
> Hi All,
>
> As per Documentation/filesystems/dax.txt
>
> The DAX code does not work correctly on architectures which have virtually
> mapped caches such as ARM, MIPS and SPARC.
>
> Can anyone please shed light on dax filesystem issue w.r.t ARM architecture ?

The concern is VIVT caches since the kernel will want to flush pmem
addresses with different virtual addresses than what userspace is
using. As far as I know, ARMv8 has VIPT caches, so should not have an
issue. Willy initially wrote those restrictions, but I am assuming
that the concern was managing the caches in the presence of virtual
aliases.
