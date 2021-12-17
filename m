Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F33A4785C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 08:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhLQH5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 02:57:24 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11744 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLQH5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639727842; x=1671263842;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WqR+b1F2GvJwVGtS5Rd5MuJKJZz/y8R/Aft7pHqSkwU=;
  b=QyJLu6gJem9MA2/lAFk2aXHcgtIijQNglc9feusGUC9kY6JJS7Xq/Ac7
   0Iinp9KELYIkIXPBlsBvoDDqt10HRqgQ7p8KGQTdeUeANo77i1Nlp1328
   b52aeYDnubRzaoovnMy45sQrjA9cnAdG2l7yUXwQOyMeY9LGHcMRvS1K1
   OgTdx8wIissukxVx+qckr+zQyH1u0mp6icb14DuajgPG4fV2cXT3PpxbI
   8Hky3ej/wLiqkWry2yqGdBHBEK9RXUxFw5hJS9n6lOs//fkdh2cRRyYck
   LjvZAuo4PDKkI1ryrTQr5tDHhk4wjh/HMYOg4ek+aG7cWXv7BerxkAXSL
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,213,1635177600"; 
   d="scan'208";a="193287320"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2021 15:57:22 +0800
IronPort-SDR: cIkya6VSHqB6pDIgkv7MiFpE6QsuY4yOczfN++Ut5FrH4vh+vc7vOupXUAucDPi9t23U2Yq2/H
 NrILaEwby8BI1eXPXq+4PvFYO4XkKKIkpTpbgPSfA9r0QiLMbC4/4p5VWForD2z92N+dTyyX3v
 9smC1XklWiTFxor+vQHDF6OFfSNLJmy4fNIsHiU5PMfCQF1en70HJ7d3Ab8GaC6HDXOrOuWa1d
 P0ZdBgEPpPICfuuQNUPspBHLz+sIINrE1bN1roHlvBooxH+EpUsrFsX7dzD8/1o3Rn47RQSN4D
 xMq7jMhiLcZsw5AzUdY6nKUC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 23:30:16 -0800
IronPort-SDR: doOyyYtwUaM6YUPy31LIPjSnxyZZo8v1RNy8Foc1H/xH3+twpfs++9w9n5xvLIJUGdZTM0EUiO
 YY7MjQGQ2YzWCwuAqSgSPrFZg/s/XCg4DwmHcOrnkRx35NTHuzh0hz5MsyfjjrBkiRiCg3ZJ70
 /dasQYK+4cSEK8G5prhv2QLRQ9MVX3huMY8X/IRLdRzqgQYdajd0C00IpaDC73rcAJ63prqWgU
 TgZZHykSgGHpVAp6ZOYQ3kruIjak/OAL5seNHNV99/sZgG40s9GyCqfg2wcY7b67vnR4SJI7OU
 gec=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 23:57:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JFhCl3Nfyz1RwFN
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 23:57:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639727843; x=1642319844; bh=WqR+b1F2GvJwVGtS5Rd5MuJKJZz/y8R/Aft
        7pHqSkwU=; b=MEqXQBhaFgKEELUDhi5mhZIBv8cKQVd/RElqfQ+CMtvfSHH0oyJ
        j4aDUG1klnbYx/kO9ZqqOXYIQ20H4eV7uE4pZ/Ydpi8vwz6sKEqJfwy3fM9XEOpD
        Xl9AR8b+IAiLEZKiLcTA9pTRRPW0EG0MRW3zzmdGzdAZbsQc4oNWQOA4Q/Slev03
        iJblcLT2124qcruXD0qbn5Bl5EbeHOX7VILWBJJehkJviSzOCnyr01g8yKxaVfzl
        rmY+37egd5JxzDBvbDAgKwLOcryqkBdlx4sLuApDPU4wYiHrTcli6CzozFhpobpL
        7v5B36TW29IPbKbaN3SWmSZs1979CO/q0fQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9qpfR2GYlJaq for <linux-fsdevel@vger.kernel.org>;
        Thu, 16 Dec 2021 23:57:23 -0800 (PST)
Received: from [10.225.163.18] (unknown [10.225.163.18])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JFhCk35sXz1RtVG;
        Thu, 16 Dec 2021 23:57:22 -0800 (PST)
Message-ID: <fe186879-cd98-8df5-f1e2-cc5d63eb6f81@opensource.wdc.com>
Date:   Fri, 17 Dec 2021 16:57:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] zonefs: add MODULE_ALIAS_FS
Content-Language: en-US
To:     Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20211217061545.2843674-1-naohiro.aota@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211217061545.2843674-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/17/21 15:15, Naohiro Aota wrote:
> Add MODULE_ALIAS_FS() to load the module automatically when you do "mount
> -t zonefs".
> 
> Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
> Cc: stable <stable@vger.kernel.org> # 5.6+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
> - v2
>   - Add Fixes and Cc tags
> ---
>  fs/zonefs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 259ee2bda492..b76dfb310ab6 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1787,5 +1787,6 @@ static void __exit zonefs_exit(void)
>  MODULE_AUTHOR("Damien Le Moal");
>  MODULE_DESCRIPTION("Zone file system for zoned block devices");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS_FS("zonefs");
>  module_init(zonefs_init);
>  module_exit(zonefs_exit);
> 

Applied. Thanks !

-- 
Damien Le Moal
Western Digital Research
