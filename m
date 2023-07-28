Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC9E766071
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 02:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjG1AAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 20:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjG1AAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:00:53 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787401BF4;
        Thu, 27 Jul 2023 17:00:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E07585C0062;
        Thu, 27 Jul 2023 20:00:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 27 Jul 2023 20:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1690502451; x=1690588851; bh=YDZ5wrTMEoKyUez3DWoQJzeqieGk0xzOSK5
        lvx+th/c=; b=GSezMDM4tpgPyc3/2yAMYOeovTwPFQ7/URTDGh0jIsW5loyQ8qE
        GWsxWPIYJ/CIyon1lVUG5EU3lia2Czq/9Zb19hvLYVenjRQjAugKF/nJqYSyVAfE
        x38Rr5IuEDN2YtRkKhxQanSzwTr45+dIsFGwS//gled2QNrRR5S4qYJKXQebRF3E
        ukO0jYpJ+nRyUBJD7MLQ1+SwoZvLZDImcXOEZa/1XsjrgfmJk4NTn4r0TW0ljKmU
        VDFdfAjvTpWldaoKrP24Lk/va/OHwpNzbZ6+zazYaEOGPPt71MqGscVnMeBSJQHw
        dItriuSzXfG/XHMD0ay65yIn0NCl4SPvnbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690502451; x=1690588851; bh=YDZ5wrTMEoKyUez3DWoQJzeqieGk0xzOSK5
        lvx+th/c=; b=d1GPFATMb4cJnbcHH1SK+5kFcDnmExRbGoPhuS9HZfU8+pSVoXT
        8nsEUUrlbnCB5yRGck7I29Naxwp8cFg42ETug21XERIVGWedYr6+aJTr+DgpZccg
        /f743TBiGg1ZeePRsvgJ+Ud+o1wLo0tNTFs8sZyIDAuCzEb6/+4ape+8s4VIyKuF
        XEtz0gvEcDczaGa+IJaiciMnjDBPYx1i5+Ccv+lu+gCu0sxGb9Yw+3xp8UUPe2zi
        lf1/K6wjFkZurpUmobgyVgSvo6KbiTtXL82nATLQ++cUY3T1VpzPPABhDu+mvI9b
        kQeCKNpQ9m1XEn+o9tnCJJnpX1ncefl5QCg==
X-ME-Sender: <xms:MgXDZPsbMzZG2JJ1FhJfGt2O-xx1nZ0b0ofjI_hQEuY6LLzFnkXZkA>
    <xme:MgXDZAeIQLwlsfv_H2U2x51SsGQzBc4f4GtG-AHbL2JplWx-z736kAEjrzCOj36zs
    KWgb6_w3U86>
X-ME-Received: <xmr:MgXDZCyNhJFNpOLE6kQyVbI_1DSo5lyMfDBLpz__MLwr_TamXGOXwAdReb6AD2Uz2TmurAqqzLqCWt60Qzd6Xa57nQ0x5cwmCjv2tiLZaJl8aIp3aBs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    egvdetvedvfeeivdeuueejgeetvdehlefhheethfekgfejueffgeeugfekudfhjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:MgXDZOMPuZ2rwjy38_bj67LmVzI6SQKZBwmba90NnsGXfFLITaOZuQ>
    <xmx:MgXDZP95mSeASwB53qieoPpGW-IB5UmsECpbCpps_lTh6XinsvKtaA>
    <xmx:MgXDZOWn7tn-FVsctyXctSZIeqm53FwQJGeMecSLrCav_-dG-c1E0Q>
    <xmx:MwXDZCXcUWg9USleDMmSeh4MYAxNlyQrhp-M1pm8Et35nEu4g40gEQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 20:00:44 -0400 (EDT)
Message-ID: <996e11bf-5f22-3ab7-2951-92109649195d@themaw.net>
Date:   Fri, 28 Jul 2023 08:00:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
To:     Imran Khan <imran.f.khan@oracle.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        elver@google.com
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
 <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
 <Y2BMonmS0SdOn5yh@slm.duckdns.org> <20221221133428.GE69385@mutt>
 <7815c8da-7d5f-c2c5-9dfd-7a77ac37c7f7@themaw.net>
 <e25ee08c-7692-4042-9961-a499600f0a49@app.fastmail.com>
 <9e35cf66-79ef-1f13-dc6b-b013c73a9fc6@themaw.net>
 <db933d76-1432-f671-8712-d94de35277d8@themaw.net> <20230718190009.GC411@mutt>
 <76fcd1fe-b5f5-dd6b-c74d-30c2300f3963@themaw.net>
 <ce407424e98bf5f2b186df5d28dd5749a6cbfa45.camel@themaw.net>
 <15eddad0-e73b-2686-b5ba-eaacc57b8947@themaw.net>
 <3505769d-9e7a-e76d-3aa7-286d689345b6@oracle.com>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <3505769d-9e7a-e76d-3aa7-286d689345b6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27/7/23 12:30, Imran Khan wrote:
> Hello Ian,
> Sorry for late reply. I was about to reply this week.
>
> On 27/7/2023 10:38 am, Ian Kent wrote:
>> On 20/7/23 10:03, Ian Kent wrote:
>>> On Wed, 2023-07-19 at 12:23 +0800, Ian Kent wrote:
> [...]
>>> I do see a problem with recent changes.
>>>
>>> I'll send this off to Greg after I've done some testing (primarily just
>>> compile and function).
>>>
>>> Here's a patch which describes what I found.
>>>
>>> Comments are, of course, welcome, ;)
>> Anders I was hoping you would check if/what lockdep trace
>>
>> you get with this patch.
>>
>>
>> Imran, I was hoping you would comment on my change as it
>>
>> relates to the kernfs_iattr_rwsem changes.
>>
>>
>> Ian
>>
>>> kernfs: fix missing kernfs_iattr_rwsem locking
>>>
>>> From: Ian Kent <raven@themaw.net>
>>>
>>> When the kernfs_iattr_rwsem was introduced a case was missed.
>>>
>>> The update of the kernfs directory node child count was also protected
>>> by the kernfs_rwsem and needs to be included in the change so that the
>>> child count (and so the inode n_link attribute) does not change while
>>> holding the rwsem for read.
>>>
> kernfs direcytory node's child count changes in kernfs_(un)link_sibling and
> these are getting invoked while adding (kernfs_add_one),
> removing(__kernfs_remove) or moving (kernfs_rename_ns)a node. Each of these
> operations proceed under kernfs_rwsem and I see each invocation of
> kernfs_link/unlink_sibling during the above mentioned operations is happening
> under kernfs_rwsem.
> So the child count should still be protected by kernfs_rwsem and we should not
> need to acquire kernfs_iattr_rwsem in kernfs_link/unlink_sibling.

Yes, that's exactly what I intended (assuming you mean write lock in 
those cases)

when I did it so now I wonder what I saw that lead to my patch, I'll 
need to look

again ...


>
> Kindly let me know your thoughts. I would still like to see new lockdep traces
> with this change.

Indeed, I hope Anders can find time to get the trace.


Ian

>
> Thanks,
> Imran
>
>>> Fixes: 9caf696142 (kernfs: Introduce separate rwsem to protect inode
>>> attributes)
>>>
>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>> Cc: Anders Roxell <anders.roxell@linaro.org>
>>> Cc: Imran Khan <imran.f.khan@oracle.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Minchan Kim <minchan@kernel.org>
>>> Cc: Eric Sandeen <sandeen@sandeen.net>
>>> ---
>>>    fs/kernfs/dir.c |    4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
>>> index 45b6919903e6..6e84bb69602e 100644
>>> --- a/fs/kernfs/dir.c
>>> +++ b/fs/kernfs/dir.c
>>> @@ -383,9 +383,11 @@ static int kernfs_link_sibling(struct kernfs_node
>>> *kn)
>>>        rb_insert_color(&kn->rb, &kn->parent->dir.children);
>>>          /* successfully added, account subdir number */
>>> +    down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>        if (kernfs_type(kn) == KERNFS_DIR)
>>>            kn->parent->dir.subdirs++;
>>>        kernfs_inc_rev(kn->parent);
>>> +    up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>          return 0;
>>>    }
>>> @@ -408,9 +410,11 @@ static bool kernfs_unlink_sibling(struct
>>> kernfs_node *kn)
>>>        if (RB_EMPTY_NODE(&kn->rb))
>>>            return false;
>>>    +    down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>        if (kernfs_type(kn) == KERNFS_DIR)
>>>            kn->parent->dir.subdirs--;
>>>        kernfs_inc_rev(kn->parent);
>>> +    up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>          rb_erase(&kn->rb, &kn->parent->dir.children);
>>>        RB_CLEAR_NODE(&kn->rb);
>>>
