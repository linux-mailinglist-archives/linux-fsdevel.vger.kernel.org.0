Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD8F5A0C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 18:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfF1Q16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 12:27:58 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:53008 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfF1Q16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:27:58 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id BBD6D1B457B;
        Sat, 29 Jun 2019 01:27:56 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x5SGRtVw032135
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 29 Jun 2019 01:27:56 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x5SGRtdk014802
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 29 Jun 2019 01:27:55 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x5SGRtXF014801;
        Sat, 29 Jun 2019 01:27:55 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Add nobarrier to workaround the strange behavior of device
References: <871rzdrdxw.fsf@mail.parknet.co.jp>
        <20190628143216.GA538@infradead.org>
        <87pnmxpx9p.fsf@mail.parknet.co.jp>
        <20190628160230.GA24232@infradead.org>
Date:   Sat, 29 Jun 2019 01:27:55 +0900
In-Reply-To: <20190628160230.GA24232@infradead.org> (Christoph Hellwig's
        message of "Fri, 28 Jun 2019 09:02:30 -0700")
Message-ID: <87ftntptdg.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Sat, Jun 29, 2019 at 12:03:46AM +0900, OGAWA Hirofumi wrote:
>> I see, sounds like good though. Does it work for all stable versions?
>> Can it disable only flush command without other effect? And it would be
>> better to be normal user controllable easily.
>
> The option was added in 2.6.17, so it's been around forever.  But
> no, it obviously is not user exposed as using it on a normal drive
> can lead to data loss.

I see. It sounds like good as long term solution though (if no effect
other than disabling flush command), it may need some monitor daemon and
detect the device, and apply user policy as root. (BTW, I meant,
workaround is normal user controllable with config by root or such)

I think, it may not be good as short term solution for especially stable
users. If there is no better short term solution, I would like to still
push this patch as short term workaround.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
