Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DF064F73C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 03:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiLQC7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 21:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQC7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 21:59:21 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D561A05E;
        Fri, 16 Dec 2022 18:59:20 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id c14so2881316qvq.0;
        Fri, 16 Dec 2022 18:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtschH8KK2zLO2/6Dnx0kwtWLWL6zEaxhg3WAhEmZ9Q=;
        b=Zt61PqYqtSFKHMnj+eu2uzug4lAHY2q6hOFD5HwLOXGcH2Uv6VwelUY001Avabdo0f
         4RI7hLnV5/gjQNLS7VXclTjSVstwy6A7O25ppubrLLgjwULnMq0V7umoIVq9x2Gozj6k
         Z1/C5+KucVBK28QMREooxzGQg/6PU+aWsR8yraMRrUYns4HufuXTzwu11mnAvW9CEttt
         TpLGOFGMz3TTFmRFdMe7jav+D48i7TNYVBC9z4hjq9ZVayqQgCnP5KTVn3ICsbB1zsX9
         PJOgF5hiS54YUwR3jrjY0MTvqHAQkUd1K4IGes9A+OlcysFF7B2XWAklPJMcAWbeA2TC
         zPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtschH8KK2zLO2/6Dnx0kwtWLWL6zEaxhg3WAhEmZ9Q=;
        b=v2zJVtuQ1xRkeqizsmefgmdv9DvLnR38rk9eH1cuKFYYp1L2YuL6B5F85UuLJhU0JQ
         Em+ahDrNr81SLVydQn04aJHRQAz3j7VWdjNUAMpLQ2nW34pLSsW2+skj3Lt284hgSm2t
         qNLe0FoY7pMVhJ1kBm4ssByHjclHodZ/JLWrexwXVRc8i+D/m0zmegYJM4npl1V77z9i
         ihfS8gY603urWJdy7LTGCoCEAl5uwBfLZekibWzfk4W7ne4PGlioO7WGskkd+h0ffXIh
         yXp6lVwWnLhKiSFZzTbN/6FWDZcqoNM2+UpYp6rNPSwTMpd6ClfBmDW4Lonb4c/+x7V2
         G9mQ==
X-Gm-Message-State: ANoB5pm/Vg4Jg4vf4s790IPCM5RpgQQMkriol6pQMW7k0SMz9cBegRf1
        UHvtk0DEvQJSp5r97jTqaoE=
X-Google-Smtp-Source: AA0mqf5IADHg7C5/KviKYiM1STMfiRryPOl5+A4HORUt0z5oy0Qt13cBNND8t3pGvi5pZsgYyeKDRA==
X-Received: by 2002:a05:6214:5f0f:b0:4c7:602d:7e29 with SMTP id lx15-20020a0562145f0f00b004c7602d7e29mr46271082qvb.45.1671245959536;
        Fri, 16 Dec 2022 18:59:19 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d16-20020a05620a241000b006ec62032d3dsm2868856qkn.30.2022.12.16.18.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 18:59:19 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7525327C0054;
        Fri, 16 Dec 2022 21:59:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 16 Dec 2022 21:59:18 -0500
X-ME-Sender: <xms:hTCdY3CVfEWHnqKzEE4gZYZt8Lw3gMOUzKRZNF4rYuCRf_tapipn9g>
    <xme:hTCdY9hchK-rUhRaqyheeJzaB2zsk-U8d-794xlDwjF-MDw_61LKjsfesn9_JPPZW
    vAotZ8hdgh28XBkZA>
X-ME-Received: <xmr:hTCdYynwRYUNXW0HDvzM5yuOx1UYlZpcfpjzhmbArNXhE4MqO19zdC_6Qh3ds_-JmNh4QoULTEyzAsUjfNDHtxuCOqV44cdtZzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:hTCdY5yDO81aGIZ6OtKJ8pyWfwjXgcDQtSSuq_LKt0ECn0CPrKoLAA>
    <xmx:hTCdY8T1qLKeZP8wgwjc5tDvffXv6y2yamxSMIlpSQkkLKhHsfFRug>
    <xmx:hTCdY8ZYVehiUc3JgjM91gsRWkOptrvWyeMMXs5vDEIjLz7lhwuN6A>
    <xmx:hjCdYzJfDt69G1nr1cLsK_zfyozgTTfcN9YJa0xHD6-BOzeK6-AcMg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Dec 2022 21:59:17 -0500 (EST)
Date:   Fri, 16 Dec 2022 18:59:15 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible deadlock in __ata_sff_interrupt
Message-ID: <Y50wg46lO8VuBPAe@Boquns-Mac-mini.local>
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
 <Y5s7F/4WKe8BtftB@ZenIV>
 <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com>
 <Y5vo00v2F4zVKeug@ZenIV>
 <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
 <Y50BqT3nSF7+JEzt@ZenIV>
 <Y50FIckzrV9sWlid@boqun-archlinux>
 <CAHk-=wj7FpAXZ0hnPKh-5CG-ZW8BmOhd4tEW+J7ryW26fkcDNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7FpAXZ0hnPKh-5CG-ZW8BmOhd4tEW+J7ryW26fkcDNA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 08:31:54PM -0600, Linus Torvalds wrote:
> Ok, let's bring in Waiman for the rwlock side.
> 
> On Fri, Dec 16, 2022 at 5:54 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Right, for a reader not in_interrupt(), it may be blocked by a random
> > waiting writer because of the fairness, even the lock is currently held
> > by a reader:
> >
> >         CPU 1                   CPU 2           CPU 3
> >         read_lock(&tasklist_lock); // get the lock
> >
> >                                                 write_lock_irq(&tasklist_lock); // wait for the lock
> >
> >                                 read_lock(&tasklist_lock); // cannot get the lock because of the fairness
> 
> But this should be ok - because CPU1 can make progress and eventually
> release the lock.
> 

Yes.

> So the tasklist_lock use is fine on its own - the reason interrupts
> are special is because an interrupt on CPU 1 taking the lock for
> reading would deadlock otherwise. As long as it happens on another
> CPU, the original CPU should then be able to make progress.
> 
> But the problem here seems to be thst *another* lock is also involved
> (in this case apparently "host->lock", and now if CPU1 and CPU2 get
> these two locks in a different order, you can get an ABBA deadlock.
> 

Right.

> And apparently our lockdep machinery doesn't catch that issue, so it
> doesn't get flagged.
> 

I'm confused. Isn't the original problem showing that lockdep catches
this?

> I'm not sure what the lockdep rules for rwlocks are, but maybe lockdep
> treats rwlocks as being _always_ unfair, not knowing about that "it's
> only unfair when it's in interrupt context".
> 

The rules nowadays are:

*	If the reader is in_interrupt() or queued-spinlock implemention
	is not used, it's an unfair reader, i.e. it won't wait for
	any existing writer.

*	Otherwise, it's a fair reader.

> Maybe we need to always make rwlock unfair? Possibly only for tasklist_lock?
> 

That's possible, but I need to make sure I understand the issue for
lockdep. It's that lockdep misses catching something or it has a false
positive?

Regards,
Boqun

> Oh, how I hate tasklist_lock. It's pretty much our one remaining "one
> big lock". It's been a pain for a long long time.
> 
>             Linus
