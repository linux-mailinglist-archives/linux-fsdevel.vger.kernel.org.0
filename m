Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55C76C7532
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 02:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCXBvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 21:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXBvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:51:14 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC45E212A9
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1679622672; i=@fujitsu.com;
        bh=YXDfWY42T6qJONVQUy0U7qSy0bQjE512aKax5Mg1h+g=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=YMGbvUatmXw2F9DWAw+vI/DNEObTeDkrlZ/B5iF7UWOUjmKZOhDwMd9JtgXUHXSjY
         c9QDCJs6vai5ZYrpMDSu7+T0UitzRLgcD6O1AcpOaFB8HUA/P038KcA9wPhvxCFw0b
         3yT6hsOLy66T8gVueejSfOfK8asZcbanugen5DYF6k4dgBwXwF4kBPkkTdJGg8juzk
         f05cbJNUKAtdOe4DeH2mJvQqEw4imivwdNqgOkeiJV6nM7hi2y6Plkg8WvWG7LtRZn
         RkZf2qzQmuyDrxA6oAj39YAFMDHO0+9g1m/DsGgTGyAqwVWfXaUQpGX6mgvTfwtewV
         BIgkRAx0m+Ebw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRWlGSWpSXmKPExsViZ8ORpMvJJJt
  i0NMuYTFn/Ro2i+lTLzBaXH7CZzF7ejOTxZ69J1ksVv74w2rx+8ccNgd2j80rtDwW73nJ5LFp
  VSebx4kZv1k8XmyeyehxZsERdo/Pm+QC2KNYM/OS8isSWDPm/t/OWvCZs6Ll6hy2BsZ+ji5GL
  g4hgY2MEtd+XGSDcJYwSTxbsYgVwtnGKPF/0wOgDCcHr4CdRPfTZywgNouAqsTK1ZNYIeKCEi
  dnPgGLiwokSxw73wpUz8EhLBAqcXSNI0hYREBXYtXzXcwgM5kFpjNKTGpqYYRY8J1RYsLxlWC
  D2AR0JC4s+Atmcwp4S1zbdooZxGYWsJBY/OYgO4QtL9G8dTZYXEJASeLi1zusEHaFROP0Q0wQ
  tprE1XObmCcwCs1Cct8sJKNmIRm1gJF5FaNZcWpRWWqRrqleUlFmekZJbmJmjl5ilW6iXmqpb
  l5+UUmGrqFeYnmxXmpxsV5xZW5yTopeXmrJJkZgjKUUJzPsYOzs+6t3iFGSg0lJlFciVDpFiC
  8pP6UyI7E4I76oNCe1+BCjDAeHkgSv63+ZFCHBotT01Iq0zBxgvMOkJTh4lER45/0DSvMWFyT
  mFmemQ6ROMSpKifMaMMimCAmAJDJK8+DaYCnmEqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh
  3jcg23ky80rgpr8CWswEtNi5BmxxSSJCSqqBScD2l8TrHsllQpN5sgLWbz39MG7Xyua48+oCB
  +f8loqsurt63beF36ZN6Ixnd0jdf+rHlqVrOMv4p57KSb59pkOOVz02bkrSwecXm0xWWd9b9J
  lLcs/5mw93FB+oFo/yP/XlWeGNM/373/+3ET9Y7W67rODTxV0ftY5+E02Rje1POlzJ/94sSGW
  z2P6rbalXm4Ubk/xzphnuO7lwvY3TvLcOUTcDJ6yza7igd2bVZJZrMtIhTN49nOcyLDn3cjRL
  r9ylqKOQxVagrrZs2Z8wt3k6sZkuP4/86f/t6hgnvOWtlsX2J+oL6u4/OHuscWHKwoda9i7Gy
  pVMSyvvppkky37e+P/y7vD3U1O8/ZS/OiuxFGckGmoxFxUnAgAF+rL5rAMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-4.tower-745.messagelabs.com!1679622664!650496!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19407 invoked from network); 24 Mar 2023 01:51:05 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-4.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Mar 2023 01:51:05 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id BB3E21B0;
        Fri, 24 Mar 2023 01:51:04 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id AFBEF1AF;
        Fri, 24 Mar 2023 01:51:04 +0000 (GMT)
Received: from [192.168.50.5] (10.167.234.230) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 24 Mar 2023 01:51:01 +0000
Message-ID: <a30006e8-2896-259e-293b-2a5d873d42aa@fujitsu.com>
Date:   Fri, 24 Mar 2023 09:50:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] fsdax: unshare: zero destination if srcmap is HOLE or
 UNWRITTEN
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <djwong@kernel.org>
References: <1679483469-2-1-git-send-email-ruansy.fnst@fujitsu.com>
 <20230322160311.89efea3493db4c4ccad40a25@linux-foundation.org>
 <a41f0ea1-c704-7a2e-db6d-93e8bd4fcdea@fujitsu.com>
 <20230323151112.1cc3cf57b35f2dc704ff1af8@linux-foundation.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20230323151112.1cc3cf57b35f2dc704ff1af8@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/3/24 6:11, Andrew Morton 写道:
> On Thu, 23 Mar 2023 14:50:38 +0800 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> 
>>
>>
>> 在 2023/3/23 7:03, Andrew Morton 写道:
>>> On Wed, 22 Mar 2023 11:11:09 +0000 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>>>
>>>> unshare copies data from source to destination. But if the source is
>>>> HOLE or UNWRITTEN extents, we should zero the destination, otherwise the
>>>> result will be unexpectable.
>>>
>>> Please provide much more detail on the user-visible effects of the bug.
>>> For example, are we leaking kernel memory contents to userspace?
>>
>> This fixes fail of generic/649.
> 
> OK, but this doesn't really help.  I'm trying to determine whether this
> fix should be backported into -stable kernels and whether it should be
> fast-tracked into Linus's current -rc tree.
> 
> But to determine this I (and others) need to know what effect the bug
> has upon our users.

I didn't get any bug report form users.  I just found this by running 
xfstests.  The phenomenon of this problem is: if we funshare a reflinked 
file which contains HOLE extents, the result of the HOLE extents should 
be zero but actually not (unexpectable data).

The other patch also has no reports from users.


--
Thanks,
Ruan.
