Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2A43CC492
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jul 2021 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhGQQu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jul 2021 12:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230386AbhGQQu5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jul 2021 12:50:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 975BF61159;
        Sat, 17 Jul 2021 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626540480;
        bh=F2cQxMmvBTPCYCi6oBbR2Z1X00LvbmuUKTmvk4lba7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipv+4BZ11TkDehbsUZ/WaEi+KS4ajyJqGpIXGwea9RWBVeD8okngJEODoMMfPiIQJ
         QMCZIGJAbdHKDww1YxLtLJ+u6HgY78l1Dh1bL7BoLt7jbLnWrIGJaM2QQw6TbPHyYh
         Qu5B9YW0jV2WpSwIa266gEStjmLiuLvzUhdN0+L4+YaEXwEi6k02fSDXSTrbfCMr30
         3k3x/yu3JbXhF7wmmeTRdx3N9hGqehgIyn9eBqF/I2JA6ZJuv2C9G/MjbJToVkNgJQ
         HNIw2Mf++EPXJKU7HElG+jAkZQEmiTnAR0EASiJyKTJfeRybLE8bWPZLYR3zTi6N1o
         vPa0jNETTKqCw==
Received: by pali.im (Postfix)
        id 0B79A95D; Sat, 17 Jul 2021 18:47:57 +0200 (CEST)
Date:   Sat, 17 Jul 2021 18:47:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Leonidas P. Papadakos" <papadakospan@gmail.com>
Cc:     zajec5@gmail.com, almaz.alexandrovich@paragon-software.com,
        djwong@kernel.org, gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <20210717164757.dwhcbacgi5jf6qwh@pali>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716114635.14797-1-papadakospan@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 16 July 2021 14:46:35 Leonidas P. Papadakos wrote:
> It would mean having good support for a cross-platform filesystem suitable for hard drives. exFAT is welcome, but it's a simple filesystem for flash storage.

FYI: There is also another cross-platform filesystem (Linux kernel,
Windows NT kernel, Mac OS X kernel) suitable for hard disks too with
POSIX permissions about which people do not know too much. It is UDF.
