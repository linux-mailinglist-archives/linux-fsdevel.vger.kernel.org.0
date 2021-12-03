Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EDA467A0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 16:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245140AbhLCPNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 10:13:00 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:35092 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhLCPNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sAqY2ItcPTL4yq67aRjsMBtRjWD9oCqTbjsTTeG8NSg=; b=Eo0VdgPeVBJkg1XCd5vYx7924t
        I74eCBpnx57SieS1E/5Rf3rCu9ujov069lhj8U+RQjg+svn7sqmlpG9/o0g/yeiLvtMIJO6CGrAH/
        VsBhwCnTpZjxa0X0Us8se+gpKidYEgdohoazAVGbZgvs1A71bvscFNForutDsYvu85kOdbZDNDq5b
        bLcoOhN/bABNyR5GuJQJrEDmkJ9pVbhk64dT1KPaMXD6dk9y1W1kDrQJb7OCD5phNWmdipKTfKfzI
        T6VJxyj+1uYXtbQAbYhV9tALBJlyu4RZdCn0RuxnK/yiv72PCeSWsymIGAbAVB85ydQISm0UCvdxT
        G5p07huQ==;
Received: from [152.254.228.176] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1mtABf-0006Rs-Ej; Fri, 03 Dec 2021 16:09:23 +0100
Subject: Re: [PATCH 2/3] panic: Add option to dump all CPUs backtraces in
 panic_print
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, siglesias@igalia.com,
        kernel@gpiccoli.net
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-3-gpiccoli@igalia.com>
 <20211130051206.GB89318@shbuild999.sh.intel.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <6f269857-2cbe-b4dd-714a-82372dc3adfc@igalia.com>
Date:   Fri, 3 Dec 2021 12:09:06 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211130051206.GB89318@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/11/2021 02:12, Feng Tang wrote:
> On Tue, Nov 09, 2021 at 05:28:47PM -0300, Guilherme G. Piccoli wrote:
>> [...]
> This looks to be helpful for debugging panic.
> 
> Reviewed-by: Feng Tang <feng.tang@intel.com>
> 
> Thanks,
> Feng

Thanks a lot Feng, for both your reviews! Do you have any opinions about
patch 3?

Also, as a generic question to all CCed, what is the way forward with
this thread?
Cheers,


Guilherme
