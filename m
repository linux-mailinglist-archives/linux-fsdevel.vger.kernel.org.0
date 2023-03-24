Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089436C768B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 05:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCXE2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 00:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXE2U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:28:20 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DFC49C1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 21:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1679632097; i=@fujitsu.com;
        bh=s6RZsZqbfbtXqKbnfMrffLOPk3NPYNtNyb7ouRoUp3c=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=AFOR02K9JxLG5X3tfZr8pX1lw1bHlNjZpIfXLbIHJR3bon9GlqvtMhqz/gr0mXMVg
         v0O0BmG9ZwpWhu2OiaaGuo0e+g+ByOzrjKPsVvpighbEZb04ZE7CAgsIF4O+339VSy
         3B8jilsch+J8HXSUiaFmFIyKbum4MtXjg0T47UNWb2CTUiHeUEfXKfW9lLxH7mQ1FZ
         S2IIski+eZl1N+JwU+xyn301W77ktyPK61f14cwsYLYozHPrmhOhTI/mBI5Mblkf7/
         QqXNhuc4fjjKTybcJduozCKuNHIFgsUziD1xT69+EsKXJJzr+9llQvWogwTBuSjIvc
         /UUdXZFxM4wfQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRWlGSWpSXmKPExsViZ8MxSfeBmmy
  Kwd878hZz1q9hs5g+9QKjxeUnfBazpzczWezZe5LFYuWPP6wWv3/MYXNg99i8Qstj8Z6XTB6b
  VnWyeZyY8ZvF48XmmYweZxYcYff4vEkugD2KNTMvKb8igTXj7fUW5oL3ghW7T05iaWC8ytfFy
  MkhJLCFUaLreHkXIxeQvZxJ4s/N5YwQzjZGidnLpjB1MXJw8ArYSVyc4QDSwCKgKrF8yXQmEJ
  tXQFDi5MwnLCC2qECyxLHzrWwg5cICoRJH1ziChEUEQiSaPp0AK2EWqJdYPecnC8T4jcwS555
  9YwRJsAnoSFxY8JcVxOYUMJF4uuURM0SDhcTiNwfZIWx5ieats8HiEgJKEhe/3mGFsCskGqcf
  YoKw1SSuntvEPIFRaBaS82YhGTULyagFjMyrGM2KU4vKUot0TfSSijLTM0pyEzNz9BKrdBP1U
  kt18/KLSjJ0DfUSy4v1UouL9Yorc5NzUvTyUks2MQKjK6U4IW0HY2vfX71DjJIcTEqivBKh0i
  lCfEn5KZUZicUZ8UWlOanFhxhlODiUJHjXqsqmCAkWpaanVqRl5gAjHSYtwcGjJMIrLQaU5i0
  uSMwtzkyHSJ1iVJQS502QAkoIgCQySvPg2mDJ5RKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYl
  Yd5sZaApPJl5JXDTXwEtZgJa7FwjA7K4JBEhJdXApMd1he3D7+Px1w/eisvym1LY8nT+4mCTn
  kNKjWUnNE8GzWzw/fr37QPrpaH+21PzBKXr5Xqc9rg9CXprtjX/2MJvO1Urt+RbOf3kuu9yov
  o2d7OqmpbelXpWAwGZFI0Sf0vXXQYMu44lzJ29+SEvk+X36DUPHaJW6+U3V5Quc7nEPN9yfmR
  lX+6dX6XLGe5lsSZf01brd3dlNSspc9y26O+C/PY/nWVfzQTPeWWt11k6O+zkLo4ZSx8LyBbz
  uBdOYti4ZEqOk/88GyuJE8yP99+9tzdecL++Z/pjC59duyq/b779Q3//Wo441kkuHWvnXXhWE
  3Fxzf/vDzZVypb71PIU7l3RoLZF0PmC+bodSizFGYmGWsxFxYkAPKIFM6kDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-14.tower-728.messagelabs.com!1679632096!261671!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28637 invoked from network); 24 Mar 2023 04:28:16 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-14.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Mar 2023 04:28:16 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id CFCD91000F5;
        Fri, 24 Mar 2023 04:28:15 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id C30201000D2;
        Fri, 24 Mar 2023 04:28:15 +0000 (GMT)
Received: from [192.168.50.5] (10.167.234.230) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 24 Mar 2023 04:28:12 +0000
Message-ID: <cf8419ae-e1ce-ee8b-6346-3bcb49f59cc2@fujitsu.com>
Date:   Fri, 24 Mar 2023 12:28:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] fsdax: unshare: zero destination if srcmap is HOLE or
 UNWRITTEN
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <jack@suse.cz>, <djwong@kernel.org>
References: <1679483469-2-1-git-send-email-ruansy.fnst@fujitsu.com>
 <20230322160311.89efea3493db4c4ccad40a25@linux-foundation.org>
 <a41f0ea1-c704-7a2e-db6d-93e8bd4fcdea@fujitsu.com>
 <20230323151112.1cc3cf57b35f2dc704ff1af8@linux-foundation.org>
 <a30006e8-2896-259e-293b-2a5d873d42aa@fujitsu.com>
 <ZB0aB7DzhzuyaM9Z@casper.infradead.org>
 <4aee7cfd-09d6-43a1-3d8c-15fe5274446b@fujitsu.com>
 <ZB0kRXVFXOJg0rQC@casper.infradead.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <ZB0kRXVFXOJg0rQC@casper.infradead.org>
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



在 2023/3/24 12:17, Matthew Wilcox 写道:
> On Fri, Mar 24, 2023 at 11:42:53AM +0800, Shiyang Ruan wrote:
>>
>>
>> 在 2023/3/24 11:33, Matthew Wilcox 写道:
>>> On Fri, Mar 24, 2023 at 09:50:54AM +0800, Shiyang Ruan wrote:
>>>>
>>>>
>>>> 在 2023/3/24 6:11, Andrew Morton 写道:
>>>>> On Thu, 23 Mar 2023 14:50:38 +0800 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>>>>>
>>>>>>
>>>>>>
>>>>>> 在 2023/3/23 7:03, Andrew Morton 写道:
>>>>>>> On Wed, 22 Mar 2023 11:11:09 +0000 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>>>>>>>
>>>>>>>> unshare copies data from source to destination. But if the source is
>>>>>>>> HOLE or UNWRITTEN extents, we should zero the destination, otherwise the
>>>>>>>> result will be unexpectable.
>>>>>>>
>>>>>>> Please provide much more detail on the user-visible effects of the bug.
>>>>>>> For example, are we leaking kernel memory contents to userspace?
>>>>>>
>>>>>> This fixes fail of generic/649.
>>>>>
>>>>> OK, but this doesn't really help.  I'm trying to determine whether this
>>>>> fix should be backported into -stable kernels and whether it should be
>>>>> fast-tracked into Linus's current -rc tree.
>>>>>
>>>>> But to determine this I (and others) need to know what effect the bug
>>>>> has upon our users.
>>>>
>>>> I didn't get any bug report form users.  I just found this by running
>>>> xfstests.  The phenomenon of this problem is: if we funshare a reflinked
>>>> file which contains HOLE extents, the result of the HOLE extents should be
>>>> zero but actually not (unexpectable data).
>>>
>>> You still aren't answering the question.  If this did happen to a user,
>>> what would they see in the file?  Random data?  Something somebody else
>>> wrote some time ago?  A copy of /etc/passwd, perhaps?  A copy of your
>>> credit card number?
>>
>> Ok.  If this happenned to a user, the HOLE or UNWRITTEN part will be old
>> data of the new allocated extent because it didn't be cleared.
> 
> ie it's the data that was in whatever file happened to use that space
> last, so this is a security bug because it's a data leak, and a backport
> is needed, and you should have indicated that by putting a cc: stable
> tag on the patch?

Yes, cc stable is needed.  Then should I send a new patch with the tag 
added?


--
Thanks,
Ruan.
