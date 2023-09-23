Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B607ABE03
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 07:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjIWF4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 01:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjIWF4q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 01:56:46 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD5E1A5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 22:56:40 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-65af18cac71so5948116d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 22:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695448599; x=1696053399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYWvm/4SgJ1DnOwyE8GnR0KsTumSCWlYc7xSynW0xVM=;
        b=jKVojSRnuVNxUXZ8YxKWFQnFlMvb4kQIO7tRlAhyplhv72r2MAt4jI+uGhu2tVoa2L
         uT1rJo2dFINsBKoQEFODlFH+0O1BZ04urRZKUJMwzhOL4Od67cAYnTpRABEuDJ1d7V0j
         cXdI3RiMB1EZP29d0wFg9ti2dlJwObqbMCqdknJxhoytxm40S8bUz+Aibhw5YD0TBmbQ
         5yj4cyyWgIhryWu4/qyhP5fUaduC8VTr7dEoSch93N9YS6zaUQMsWdxIYYBpe7rv/6kO
         Gna6L8O8M9HAS5Ite0odJSaG0U1LTN6RkF9k/VsnOtr2LHfKbC0VvcInGH5b/oS2fqDm
         L/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695448599; x=1696053399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYWvm/4SgJ1DnOwyE8GnR0KsTumSCWlYc7xSynW0xVM=;
        b=icyci50E/xYhT7CY3CZg7G0Mmq8HjoKvq+3wQxQM8DQEDsPGzaOvrnCFybI6uQ1u0y
         +h3VYCSmE8s8jR6eMdd/lE5ZrvrDwtDBX9fPO0RMG7+9e8k5GXjvIVu7/bE4UsdkreMN
         XqkiAsOgjTnNvzlWRFQe+IDEXQJ+vwaGemIAVteAX7PsMu27iDoSsOcoiFpRjurOEhqA
         ojF1Nc+P6RqABB1EguBGvf3QvlYz3pXCsMVIw4aPS4mpNFrJk8f/GLL1EKzLqjhbXTTc
         kKsySNE9Unies10Ae4vbJdWMFF80guKyI+p6QNiXs9Knt09HqddYDmt04NjePCte98sV
         u2bw==
X-Gm-Message-State: AOJu0Yx3jfGvQoLvmguO9D4ElVVNnM52ZuHlJoqzmXB16dM3fysfAZzw
        7cKWIofNUzPzI2QsjrDXac/+XVCeThmZ6srqYhI=
X-Google-Smtp-Source: AGHT+IESwen9eFjqESJ1fXAsIxvoYG12qJbJ3e7iD8TUFnc0sKdccyFfxBxcSZoyX985pCpTNSBBQUk4P+HLUNlq+mw=
X-Received: by 2002:a0c:b253:0:b0:656:4af7:ab with SMTP id k19-20020a0cb253000000b006564af700abmr1238352qve.7.1695448599177;
 Fri, 22 Sep 2023 22:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com> <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki> <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
In-Reply-To: <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 23 Sep 2023 08:56:28 +0300
Message-ID: <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
To:     Reuben Hawkins <reubenhwk@gmail.com>
Cc:     Cyril Hrubis <chrubis@suse.cz>, mszeredi@redhat.com,
        brauner@kernel.org, lkp@intel.com, willy@infradead.org,
        linux-fsdevel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 22, 2023 at 11:29=E2=80=AFPM Reuben Hawkins <reubenhwk@gmail.co=
m> wrote:
>
>
>
> On Fri, Sep 22, 2023 at 4:09=E2=80=AFAM Cyril Hrubis <chrubis@suse.cz> wr=
ote:
>>
>> Hi!
>> > ack.  Will try to test.  My Ubuntu 22.04 system wasn't able to find
>> > packages called
>> > for by the test case, so it'll take me a little while to figure out ho=
w to
>> > get the
>> > test case working...
>>
>> Huh? The test is a simple C binary you shouldn't need anything more
>> than:
>>
>> $ git clone https://github.com/linux-test-project/ltp.git
>> $ cd ltp
>> $ make autotools
>> $ ./configure
>>
>> $ cd testcases/kernel/syscalls/readahead
>> $ make
>> $ ./readahead01
>>
>> And this is well described in the readme at:
>>
>> https://github.com/linux-test-project/ltp/
>>
>> And the packages required for the compilation are make, C compiler and
>> autotools nothing extraordinary.
>>
> Awesome.  That was simpler than whatever it was I was trying.  I've
> reproduced the failed test and will try a few variations on the patch.

Cool.

For people that were not following the patch review,
the goal is not to pass the existing test.

We decided to deliberately try the change of behavior
from EINVAL to ESPIPE, to align with fadvise behavior,
so eventually the LTP test should be changed to allow both.

It was the test failure on the socket that alarmed me.
However, if we will have to special case socket in
readahead() after all, we may as well also special case
pipe with it and retain the EINVAL behavior - let's see
what your findings are and decide.

Thanks,
Amir.
