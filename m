Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6650425551
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbhJGOZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 10:25:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34262 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbhJGOZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:25:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EC38B223E7;
        Thu,  7 Oct 2021 14:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633616602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFEKiIBTn+CjBgLGXHRnRoi7JrtR2uDp77Zyo1Vcf5g=;
        b=nGDa2MSErI40aGSeSUWDqH0bPVnGgEJcXKjSSvpFhDOhnhgzoNwp7qbRta3onSuZzlEwtq
        bsY8pRddmS7OqvLcDkALEnKKurV4dhlw/D5aNajZ5l8/PX9fDz7xYaqhU6+Qbof3Xp7FEa
        Yd8bV1/TSz1X75cgVePouo9cakbA8ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633616602;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFEKiIBTn+CjBgLGXHRnRoi7JrtR2uDp77Zyo1Vcf5g=;
        b=Dh82T1xR/4fj+Sq7yve2DNnd4XLFn67He+oHC0mKOZYazdNddQCev+qDB/otiHaKMqPTL1
        9Vmz+yoOl6s6vsDg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 58B2DA3B83;
        Thu,  7 Oct 2021 14:23:22 +0000 (UTC)
Date:   Thu, 7 Oct 2021 16:23:22 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/12] selftests: add tests_sysfs module
In-Reply-To: <20210927163805.808907-4-mcgrof@kernel.org>
Message-ID: <alpine.LSU.2.21.2110071620130.19025@pobox.suse.cz>
References: <20210927163805.808907-1-mcgrof@kernel.org> <20210927163805.808907-4-mcgrof@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 27 Sep 2021, Luis Chamberlain wrote:

> This adds a new selftest module which can be used to test sysfs, which
> would otherwise require using an existing driver. This lets us muck
> with a template driver to test breaking things without affecting
> system behaviour or requiring the dependencies of a real device
> driver.
> 
> A series of 28 tests are added. Support for using two device types are
> supported:
> 
>   * misc
>   * block

I suppose the selftests will run for more than 45 seconds (default 
kselftest timeout), so you probably also want to set timeout to something 
sensible in tools/testing/selftests/sysfs/settings file (0 would disable 
it).

Miroslav
