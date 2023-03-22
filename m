Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DB06C5A76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 00:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCVXdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 19:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCVXdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:33:41 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA2F211EC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679528019; x=1711064019;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MH56pcFSkJPYr+IGjg0SEwtb90roDYAAh0io8KA4j4U=;
  b=lYbnwsPQiK9NsKE/28szRZ61GgKipl1DcJx0Ghluze4uD/5CKf7pNI4s
   9UwJ2zGhH3C9CcDtmTiYWm5bZP6sAVubt4jBF1fIEmaHkVtLTKEQEZBgR
   n/r8y8BOIhPizbGxxTuY6WELu7Z5or62Mu78+KOrGX0PMilJRNMsytpD3
   47IRkRbnrcptt+Y/W77wEyqRrpotx4YwIDPTH1OUjMBOnSNeNaOfUDRgt
   8FvxUxPVOlQRAQo37w65waX8tI4RMbypeqQGjNjBFlYymlXqXeShyExPc
   CMxO0cbxjmCE38R16bXh6w2tTxlKawCaxjTBsLZlgXah3TBBR9RZzArcA
   g==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="226084165"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:33:39 +0800
IronPort-SDR: 9FHWuiEnnQQ9qjfGVhGl6iXFc0a+0UwYoT8TaaZVeyAFi5MK9NLHVikbtc0VNY4sm9t8LZYxUe
 Bw2HH/bOuKKMeeOh6bW4CAS9eVW0Y7GEhuQ75V/irXzrPyxz0k0vw+NMPciwLCFjoPbxH6j84l
 Ryr2Evb0M3DHa0zs6BnG9A5W+tvLUesg6fwPS0BLed99nmffCLvLREHzCHGI56iMvi/5PEunFy
 yPDAtXG3tw27M1/tWvpA7Jzsqt1SyLhppyQ1hWUwWayfMSwTofbvDViEUaO/2YcoEnSHf2nX1m
 NYM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:49:56 -0700
IronPort-SDR: XWPx+s9FKU5VyVGbY3fiYaCBVlWCrqdp1S1IgxKSGPpctaWCg+RBwTntgiYFS5ZRr41Eb/dm4z
 KLxX55oDs+RSESnXlM/aN++dPZpieoe9lbTproUMpvIyhb7pJdQRqNW0UfevBm5fAZtvZCna75
 7QKDNoa+PqGKIuaVW2STSJz/0oEApxF4c1glR6jnw7OPVL0RsiuxZEcFzgORzLnAV+FvZKCrCA
 ua6WCTgOb0E52ttVb78450UTG6jk+OCEkjY/2LGZ16t7JvAN4SlePX3/YBFbX9vTG8j2BeoXdH
 LlY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:33:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlCk6WL8z1RtVt
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 16:33:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679528018; x=1682120019; bh=MH56pcFSkJPYr+IGjg0SEwtb90roDYAAh0i
        o8KA4j4U=; b=lsOZKzyr8mqqr5xUx7uIgSjqJfaBO7rblgZod6RTwXifHlSAwz1
        4UJ3yufvjeP7FMVtoeBsdAu85G3yu6KZze281Lal71XhB7kNIGIoqef64mPlQdAg
        0djcxVCO1pL/Jmk7+gSb+pgBT3jVGZ9Cfrec4yXtepZB0a+lPTJP1v9KMnNmOUuY
        G55r5eX6c4LZrxZbrFTj1nhfwpzsm3JCS/xYWLXV8cN3WIKEw3dyNf4DSPnU64jE
        6HNCzo1IvHZMJzvX/Z/5TRcwVLql9KR7hLFO1VLr9Uo6xNULpH3Ewb1ppfCGXj1C
        uU9nCSuxmGq1IULB8b+7jQHFFpcVr4ACChw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4bxisS7wX-Ee for <linux-fsdevel@vger.kernel.org>;
        Wed, 22 Mar 2023 16:33:38 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlCj3CZbz1RtVm;
        Wed, 22 Mar 2023 16:33:37 -0700 (PDT)
Message-ID: <89dd308e-2140-921e-6c08-91bf7b1eee63@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:33:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 04/10] zonefs: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-3-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-3-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/23/23 01:58, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research

