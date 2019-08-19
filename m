Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7851194EF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 22:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfHSU1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 16:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbfHSU1Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:27:25 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B556A214DA;
        Mon, 19 Aug 2019 20:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566246444;
        bh=l2ZRAR87AWhFL23hNA1viPVwXGyIJRgMiRFLxXTrW9c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XMliCWgDsJlHW9HzSHrP5IMKxoytQCWfKhtVm5uQoZiHC+cSWyhP8SmFkP37/emnE
         OPmy0u9zIFWLukIM4WmkgGEqcgDjYfNG7QM8H5uwX+OrnQLEzftk37F3NxIJLw9glq
         lv6sy/wDiVHc/whAMGIZaWe9Mcm/VX3x4lnnpLtA=
Subject: Re: [PATCH 1/3] test_firmware: add support for
 request_firmware_into_buf
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        bjorn.andersson@linaro.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190816000945.29810-1-scott.branden@broadcom.com>
 <20190816000945.29810-2-scott.branden@broadcom.com>
 <20190819052434.GP16384@42.do-not-panic.com>
From:   shuah <shuah@kernel.org>
Message-ID: <c5d53b0a-5c99-8183-6f8b-fa3cac13580e@kernel.org>
Date:   Mon, 19 Aug 2019 14:27:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819052434.GP16384@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/18/19 11:24 PM, Luis Chamberlain wrote:
> On Thu, Aug 15, 2019 at 05:09:43PM -0700, Scott Branden wrote:
>> Add test config into_buf to allow request_firmware_into_buf to be
>> called instead of request_firmware/request_firmware_direct.  The number
>> of parameters differ calling request_firmware_into_buf and support
>> has not been added to test such api in test_firmware until now.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> 
> Thanks for the patch!
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> 
>    Luis
> 

Greg! Pls let me know if you would like me to take this
throough my tree. If not,

Acked-by: Shuah Khan <skhan@linuxfoundation.org>


thanks,
-- Shuah
