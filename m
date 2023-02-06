Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CA468B5BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 07:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBFGqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 01:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjBFGqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:46:15 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B5E12F3E;
        Sun,  5 Feb 2023 22:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1675665972; i=@fujitsu.com;
        bh=8tDYHNWMpUBfn2W8rtNUEQrr/Lx/KtmFpqOm7bf5zQI=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=x/XU+I3vkY/snNMoCAM/Q/te6FSxTJEf60Xnb/zrFJUUov70ue0p8e8wke8j4UX/s
         I6AT7V8sLv+JvrsjvpmMjJ895YeTQH1WjKo13SltqC/C4oY2+HqJsDVjZiZiuNUVEi
         5Tmrk/9cWpNqCZ5Zc8XfeuMeaizZwi4kh54eoQEkU759+tqQ04D+yaItl+JMdgHfSG
         WqoyWHzlLgCmdn0OIhhRVYZ4NJLTL9pnwWdm9KLG9NHjiJUKA8pEMYBfdDAaD/Z/Ao
         4iTpnSnDMaMZUCsPfJ+DBXYcrFL/2efiwCAJpqfhIxVItcNut4/dirdG69CiOdVd1v
         Lji+JGr0wwiUQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRWlGSWpSXmKPExsViZ8ORqKuz6EG
  ywemHFhbTp15gtNhy7B6jxeUnfBanJyxistj9+iabxZ69J1ksLu+aw2Zxb81/Votdf3awW6z8
  8YfV4vePOWwO3B6nFkl4bF6h5bF4z0smj02rOtk8Nn2axO7xYvNMRo+PT2+xeHzeJBfAEcWam
  ZeUX5HAmvHywxrmgg1sFa09v5gaGC+xdDFycQgJbGGUeHnqOzuEs4JJYt6/g1DONkaJi19+sH
  YxcnLwCthJ/Jr1hA3EZhFQkehq6WWEiAtKnJz5hAXEFhVIljh2vhWsRljATaJh5x0gm4NDREB
  D4s0WI5CZzAIdTBJ712xkhFiwnFGiY/ZLZpAGNgEdiQsL/oIt4xQwkfi49wU7iM0sYCGx+M1B
  KFteonnrbGaQoRICShIzu+NBwhIClRKtH36xQNhqElfPbWKewCg0C8l5s5BMmoVk0gJG5lWMZ
  sWpRWWpRbqGZnpJRZnpGSW5iZk5eolVuol6qaW65anFJbqGeonlxXqpxcV6xZW5yTkpenmpJZ
  sYgRGZUsz8cgfjib6/eocYJTmYlER5+/3vJgvxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4A2Y8yB
  ZSLAoNT21Ii0zB5gcYNISHDxKIryXpwOleYsLEnOLM9MhUqcYFaXEeYMXAiUEQBIZpXlwbbCE
  dIlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMK/oPKApPJl5JXDTXwEtZgJa3G1wF2RxSSJCS
  qqBSXCR5j0pid67FqWLbqzXV/yWLZOa47+8+Lvp5YhWqwkHGOf7NZ+f9+HP5Ou75VdP4Vtiln
  jIQX3alssRHoyyzu92mayYsKLx89Ok5y8FdIXM98yZvsCBXy9RYEKbhlzx7qtKv5enHDSbnCO
  yeHFAUc7LEE/dV/fKbi86XjXDp+TysUrZC88OFFZ/2Nm2rn+G59W26lt398WrqWwoDTpfVetq
  127/gV3z0/HEA3+23DSvyjI26rGtc6rcvNw+ZbNF9U+pFpO1J4L3eq94f917SdKEVfWWpa4lf
  q+SGxke2xp5nX37e11s3KmDz9lbC9/O+bWH8QtzrqmmfdsfeebHUWUn+TjDtji9PuPocUEtUY
  mlOCPRUIu5qDgRAPjkbkDDAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-23.tower-585.messagelabs.com!1675665964!299649!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2381 invoked from network); 6 Feb 2023 06:46:04 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-23.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 6 Feb 2023 06:46:04 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 77186100188;
        Mon,  6 Feb 2023 06:46:04 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 6A116100182;
        Mon,  6 Feb 2023 06:46:04 +0000 (GMT)
Received: from [192.168.50.5] (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 6 Feb 2023 06:46:00 +0000
Message-ID: <0b8551a2-1d46-8ac8-5073-5b094507975a@fujitsu.com>
Date:   Mon, 6 Feb 2023 14:45:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v9 1/3] xfs: fix the calculation of length and end
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>,
        <hch@infradead.org>, <jane.chu@oracle.com>
References: <1675522718-88-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1675522718-88-2-git-send-email-ruansy.fnst@fujitsu.com>
 <Y9+WHXyA2GufLWpw@casper.infradead.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <Y9+WHXyA2GufLWpw@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/2/5 19:42, Matthew Wilcox 写道:
> On Sat, Feb 04, 2023 at 02:58:36PM +0000, Shiyang Ruan wrote:
>> @@ -222,8 +222,8 @@ xfs_dax_notify_failure(
>>   		len -= ddev_start - offset;
>>   		offset = 0;
>>   	}
>> -	if (offset + len > ddev_end)
>> -		len -= ddev_end - offset;
>> +	if (offset + len - 1 > ddev_end)
>> +		len -= offset + len - 1 - ddev_end;
> 
> This _looks_ wrong.  Are you sure it shouldn't be:
> 
> 		len = ddev_end - offset + 1;
> 

It is to make sure the range won't beyond the end of device.

But actually, both of us are rgiht.
   Mine: len -= offset + len - 1 - ddev_end;
      => len = len - (offset + len - 1 - ddev_end);
      => len = len - offset - len + 1 + ddev_end;
      => len = ddev_end - offset + 1;          --> Yours

I forgot to simplify it.  Will fix.


--
Thanks,
Ruan.
