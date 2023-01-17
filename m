Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C4E66E727
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 20:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjAQTkY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 14:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjAQTfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:35:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA07728C
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 10:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673980858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iFiAegt8WNgL5MZXxVPS9mQqy9Ss59WQtK/8IB6U8eA=;
        b=e64CGQzgoWWxzLt1NxdyG/2ppUm2USZNKL8eHJt+DX7RVrIDtFl8IaRlYdTL7XcrJpcA5D
        dn+7tQKIW7s9reX1ssxXzNRFRUFWsd+Wyl+Vov1nAB/xkQ/qJeC3IQm27xqDwSH2VGdkWw
        Yrh14UBjitF3cwGeBkRemE8Bg78vKq4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-7Q5xTnuUMu6dbfLp4O-8ag-1; Tue, 17 Jan 2023 13:40:55 -0500
X-MC-Unique: 7Q5xTnuUMu6dbfLp4O-8ag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2A11857A84;
        Tue, 17 Jan 2023 18:40:54 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA68B2166B29;
        Tue, 17 Jan 2023 18:40:51 +0000 (UTC)
Message-ID: <0110b1d1-17c4-49a3-64c0-ad7d7b8cbd29@redhat.com>
Date:   Tue, 17 Jan 2023 13:40:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
 <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
 <Y8bmeffIQ3iXU3Ux@boqun-archlinux>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y8bmeffIQ3iXU3Ux@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/17/23 13:18, Boqun Feng wrote:
> [Cc Waiman]
>
> On Mon, Jan 16, 2023 at 10:00:52AM -0800, Linus Torvalds wrote:
>> [ Back from travel, so trying to make sense of this series.. ]
>>
>> On Sun, Jan 8, 2023 at 7:33 PM Byungchul Park <byungchul.park@lge.com> wrote:
>>> I've been developing a tool for detecting deadlock possibilities by
>>> tracking wait/event rather than lock(?) acquisition order to try to
>>> cover all synchonization machanisms. It's done on v6.2-rc2.
>> Ugh. I hate how this adds random patterns like
>>
>>          if (timeout == MAX_SCHEDULE_TIMEOUT)
>>                  sdt_might_sleep_strong(NULL);
>>          else
>>                  sdt_might_sleep_strong_timeout(NULL);
>>     ...
>>          sdt_might_sleep_finish();
>>
>> to various places, it seems so very odd and unmaintainable.
>>
>> I also recall this giving a fair amount of false positives, are they all fixed?
>>
>  From the following part in the cover letter, I guess the answer is no?
>
> 	...
>          6. Multiple reports are allowed.
>          7. Deduplication control on multiple reports.
>          8. Withstand false positives thanks to 6.
> 	...
>
> seems to me that the logic is since DEPT allows multiple reports so that
> false positives are fitlerable by users?
>
>> Anyway, I'd really like the lockdep people to comment and be involved.
> I never get Cced, so I'm unware of this for a long time...
>
> A few comments after a quick look:
>
> *	Looks like the DEPT dependency graph doesn't handle the
> 	fair/unfair readers as lockdep current does. Which bring the
> 	next question.
>
> *	Can DEPT pass all the selftests of lockdep in
> 	lib/locking-selftests.c?
>
> *	Instead of introducing a brand new detector/dependency tracker,
> 	could we first improve the lockdep's dependency tracker? I think
> 	Byungchul also agrees that DEPT and lockdep should share the
> 	same dependency tracker and the benefit of improving the
> 	existing one is that we can always use the self test to catch
> 	any regression. Thoughts?
>
> Actually the above sugguest is just to revert revert cross-release
> without exposing any annotation, which I think is more practical to
> review and test.
>
> I'd sugguest we 1) first improve the lockdep dependency tracker with
> wait/event in mind and then 2) introduce wait related annotation so that
> users can use, and then 3) look for practical ways to resolve false
> positives/multi reports with the help of users, if all goes well,
> 4) make it all operation annotated.

I agree with your suggestions. In fact, the lockdep code itself is one 
of major overheads when running a debug kernel. If we have another set 
of parallel dependency tracker, we may slow down a debug kernel even 
more. So I would rather prefer improving the existing lockdep code 
instead creating a completely new one.

I do agree that the lockdep code itself is now rather complex. A 
separate dependency tracker, however, may undergo similar transformation 
over time to become more and more complex due to the needs to meet 
different requirement and constraints.

Cheers,
Longman

