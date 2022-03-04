Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA504CD9CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 18:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbiCDRLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 12:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiCDRLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:11:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CE91CBA97;
        Fri,  4 Mar 2022 09:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=WbFFgJ3TOElNmD+ADc11e8q9EbVb53G89PRSG/O0iSU=; b=HABnBLdjCuVOVOvY7g92QYd3LH
        wL06Bw1jB1JQ0fhcGnX9IeNAMOKhbYyKMn74p8qAX1S9CnfsPzk8tWDPTR1RwhmdoHcn3zabgqNIS
        kZIbAumkfljep8Cw1F2aHRJd/q1z4FV+86aIq/QhJ4uTFO6hJWDhT5FplV7UQ2EFf37eIjz9/yfRK
        dwLUdLUtlOamhoIx/CZJMOi3+TI3nCfdH6qqP8bAAD8oZ6YYwZ4X6JuvmisnBDPMqk5VU5e3uJRju
        7XWGaHiJOEssEykkqemoPAI7vu+tTUJEjdokwmJPf3vHSS6yEpdOd66k/NiJrCQJULU6WGlo941Wl
        8SRcBXzg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQBRP-00CoTk-7I; Fri, 04 Mar 2022 17:10:07 +0000
Message-ID: <e1a5f3ad-c33d-46f1-48c6-9c6b377ea211@infradead.org>
Date:   Fri, 4 Mar 2022 09:10:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: mmotm 2022-03-03-21-24 uploaded
 [drivers/platform/x86/x86-android-tablets.ko]
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
References: <20220304052444.C157EC340E9@smtp.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220304052444.C157EC340E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hans,

On 3/3/22 21:24, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2022-03-03-21-24 has been uploaded to
> 
>    https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series

on i386:
when CONFIG_SPI is not set/enabled:

ERROR: modpost: "spi_bus_type" [drivers/platform/x86/x86-android-tablets.ko] undefined!

-- 
~Randy
