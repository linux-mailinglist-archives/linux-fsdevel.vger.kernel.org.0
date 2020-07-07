Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE502165F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 07:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGGFoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 01:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgGGFoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:44:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0CAC061755;
        Mon,  6 Jul 2020 22:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=VZkOok0klgYFwIIGzlVgtaFmTD1Z+sQAb+yB5lFvhOw=; b=LywVwyGX/TJ2DZv2pe2/K08L5r
        MJDRPMQ6dPYqEoL75gE7NLMEC2Gk+iIYvxkj5BYB9ir7uaGoEI3KTdZTpUy2dK34VvxQ5IFnAkwfj
        Z53fC+wV1m6YnNgod2y063+J0kDfkvSfL/JwxNnlgomj7ITPpGPt+ZMG2WaX8F9AreLeNJrdSXecK
        C33ZP48O7t5qd6WBZhZZe6Ns+2Q9Rie0b8hfMh7t/uoX8Nx7NBckcI4Euv6qnOwbdA3LL2fhNu/Dg
        In2bIpTuJuOw3SGWeK3oz3vCTfaZLo+AtgrZSyUq4n4nu7vRqZyNWxQyd5eeNefJn6MixQuYJg1XN
        ttz4h/7A==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsgOj-00019U-FU; Tue, 07 Jul 2020 05:44:06 +0000
Subject: Re: mmotm 2020-07-06-18-53 uploaded
 (sound/soc/amd/renoir/rn-pci-acp3x.c:)
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        sfr@canb.auug.org.au, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
References: <20200707015344.U9ep-OO5Z%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b54188c7-47b4-b7e4-2f74-6394320df5df@infradead.org>
Date:   Mon, 6 Jul 2020 22:44:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707015344.U9ep-OO5Z%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/6/20 6:53 PM, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2020-07-06-18-53 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 

on i386:

when CONFIG_ACPI is not set/enabled:

../sound/soc/amd/renoir/rn-pci-acp3x.c: In function ‘snd_rn_acp_probe’:
../sound/soc/amd/renoir/rn-pci-acp3x.c:222:9: error: implicit declaration of function ‘acpi_evaluate_integer’; did you mean ‘acpi_evaluate_object’? [-Werror=implicit-function-declaration]
   ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
         ^~~~~~~~~~~~~~~~~~~~~
         acpi_evaluate_object



-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
