Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67E59E5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfF1PDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:03:52 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:53002 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1PDw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:03:52 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 0412D7C8;
        Sat, 29 Jun 2019 00:03:51 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x5SF3nPq031179
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 29 Jun 2019 00:03:50 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x5SF3n8r014176
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 29 Jun 2019 00:03:49 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x5SF3kNS014175;
        Sat, 29 Jun 2019 00:03:46 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Add nobarrier to workaround the strange behavior of device
References: <871rzdrdxw.fsf@mail.parknet.co.jp>
        <20190628143216.GA538@infradead.org>
Date:   Sat, 29 Jun 2019 00:03:46 +0900
In-Reply-To: <20190628143216.GA538@infradead.org> (Christoph Hellwig's message
        of "Fri, 28 Jun 2019 07:32:16 -0700")
Message-ID: <87pnmxpx9p.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Fri, Jun 28, 2019 at 11:18:19PM +0900, OGAWA Hirofumi wrote:
>> To workaround those devices and provide flexibility, this adds
>> "barrier"/"nobarrier" mount options to fat driver.
>
> We have deprecated these rather misnamed options, and now instead allow
> tweaking the 'cache_type' attribute on the SCSI device.

I see, sounds like good though. Does it work for all stable versions?
Can it disable only flush command without other effect? And it would be
better to be normal user controllable easily.

This happened on normal user's calibre app that mount via udisks.  With
this option, user can workaround with /etc/fstab for immediate users.

> That being said if the device behave this buggy you should also report
> it to to the usb-storage and scsi maintainers so that we can add a
> quirk for it.

It might not be able to say as buggy simply. The device looks work if no
idle and not hit pattern of usage, so quirk can be overkill.

Anyway, I don't have the device, if you can get the device and
investigate, it can be fine.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
