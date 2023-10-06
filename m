Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BC37BAF92
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 02:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjJFA1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 20:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJFA1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:27:22 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238CFD6;
        Thu,  5 Oct 2023 17:27:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D6DBD5C022E;
        Thu,  5 Oct 2023 20:27:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 05 Oct 2023 20:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1696552034; x=1696638434; bh=T0KKGiY1Q8zqQlnDql/yrnMneNPlqDlkRnN
        aCenas50=; b=NsjPxZnjfyHwzZfOHHXiexldWr+qApfmB0/vePs04hlPTprXeLP
        muo00EbDjfVB1reJo4Gi4OS1KB2yKHJLXypX7FP9f8SiFiuTTmSrdGnGbT4K689r
        z66w+t1ZqKIb1NIjSbKd+C3UTVrNSLtPth5mcA3FYufCXiws+vpJmy2O516DHjyJ
        ihdQSZ38omannW+GHVLJOeh9SQ6MZquPLile5x3UrWcDg4Q2JEJiJD9zcQTBoNRr
        6x/a/6VF9DRNQK9BxCUhL2jfUfE394R7CcxAHV7hxrIaVlniEjAEaUKbHFTqMYQa
        fqyo8jR86/CgH3mfBPaM3dcgHcKEAjlyiog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696552034; x=1696638434; bh=T0KKGiY1Q8zqQlnDql/yrnMneNPlqDlkRnN
        aCenas50=; b=X888C7YOEFoEUmRM8CxSfxcrCdN9fA9Y5Wy6nLVEg9ywh69eNaa
        6W3pVRhpXRkpqInMSTExphzKk98r8O/8dVuEsTt+gm6V9pxt9eSkQ0j65XTkkWJ0
        MNvfAOLtcJrmVR4FChTj/BXwfRhGsHO0CZN6T1pxihIcqNsUqpLgodWcxVVSjxe/
        J7WaYl4kaoT0sRg5jCO/jRjX+EIu36obx3yapz54vniMmrIyIrQVRmJgS2iIcYTP
        sEUVz7bYc3OLvHqkLUkELZaiyWx+0oNyWsIpVwsggmP9Jww+pZlAhtsozkL3qGOp
        +1/5oNgpXRGev7OaRgAzJ4sTXuSzyXpcK/Q==
X-ME-Sender: <xms:YVQfZfmuJNp-n-wtUgJgsFbSLdiR22bouAjj_2tgWzTIrIUUBX2gCQ>
    <xme:YVQfZS1SVFoihWiBusOuFwPtyP31D50Ca_GbiWm7abTAAL_2bs4isr20RLkFfjAcL
    BxjfhFtL5fb>
X-ME-Received: <xmr:YVQfZVrDl_aaip9HvCknlI6jRPyGFHmp4XIR2As3mc0fM0hq9NcHh2YOfCQYeFPLTHjC0FB7jevxc-zpl4gQfd14McbIogeQGtJNcrdmu93JGq2r-eLXH8Xs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeehgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:YlQfZXl1_L8TMWe7RLDu62ZvUSa2BREvMrbrCCOrXMfOn5Qm8b3OIw>
    <xmx:YlQfZd1-2AUNUqJXnkVrBopvHNDc9gw-i0J_3MpQWHS7GRNgMX9LPw>
    <xmx:YlQfZWsuyxmLje11F-KKbJnHXS9c6kPzsNYDWePd3DSoN72GFSt7dw>
    <xmx:YlQfZXMBhWMqKgsB-pnkEyij8sgxlC3Mdp0aHMAxo11bXMPdJ4_mbQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Oct 2023 20:27:07 -0400 (EDT)
Message-ID: <7fe3c01f-c225-394c-fac5-cabfc70f3606@themaw.net>
Date:   Fri, 6 Oct 2023 08:27:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Paul Moore <paul@paul-moore.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230928130147.564503-1-mszeredi@redhat.com>
 <20230928130147.564503-5-mszeredi@redhat.com>
 <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
 <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com>
 <a25f2736-1837-f4ca-b401-85db24f46452@themaw.net>
 <CAJfpegv78njkWdaShTskKXoGOpKAndvYYJwq7CLibiu+xmLCvg@mail.gmail.com>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <CAJfpegv78njkWdaShTskKXoGOpKAndvYYJwq7CLibiu+xmLCvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/10/23 23:47, Miklos Szeredi wrote:
> On Thu, 5 Oct 2023 at 06:23, Ian Kent <raven@themaw.net> wrote:
>
>> The proc interfaces essentially use <mount namespace>->list to provide
>>
>> the mounts that can be seen so it's filtered by mount namespace of the
>>
>> task that's doing the open().
>>
>>
>> See fs/namespace.c:mnt_list_next() and just below the m_start(), m_next(),
> /proc/$PID/mountinfo will list the mount namespace of $PID.  Whether
> current task has permission to do so is decided at open time.
>
> listmount() will list the children of the given mount ID.  The mount
> ID is looked up in the task's mount namespace, so this cannot be used
> to list mounts of other namespaces.  It's a more limited interface.

Yep. But isn't the ability to see these based on task privilege?


Is the proc style restriction actually what we need here (or some variation

of that implementation)?


An privileged task typically has the init namespace as its mount namespace

and mounts should propagate from there so it should be able to see all 
mounts.


If the file handle has been opened in a task that is using some other mount

namespace then presumably that's what the program author wants the task 
to see.

So I'm not sure I see a problem obeying the namespace of a given task.


Ian

>
> I sort of understand the reasoning behind calling into a security hook
> on entry to statmount() and listmount().  And BTW I also think that if
> statmount() and listmount() is limited in this way, then the same
> limitation should be applied to the proc interfaces.  But that needs
> to be done real carefully because it might cause regressions.  OTOH if
> it's only done on the new interfaces, then what is the point, since
> the old interfaces will be available indefinitely?
>
> Also I cannot see the point in hiding some mount ID's from the list.
> It seems to me that the list is just an array of numbers that in
> itself doesn't carry any information.
>
> Thanks,
> Miklos
