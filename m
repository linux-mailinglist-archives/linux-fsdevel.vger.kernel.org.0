Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F4E606A5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 23:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJTVgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 17:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJTVgR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:36:17 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4FA1B5776;
        Thu, 20 Oct 2022 14:36:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 94DE15C0032;
        Thu, 20 Oct 2022 17:36:13 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Thu, 20 Oct 2022 17:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666301773; x=1666388173; bh=h4l4CTUEVF
        0osrYYvRvUOH8bwHt56ZtdskQUIec2rS8=; b=g4WrKdGTxmX7hgPng4nDgVLNfv
        X1x4avihzo6bFgldm2fw+3WGUlecD0Zfs47a0T2MAReGiktla8pAcwpMLiYktOEu
        vxWGClhZGllSh+zvpyrpPa9M3Kgj5hJ1SY5QBkJdndQg5+CHMZEyWkr7c+sWFAit
        283lk3K5X/MBu38a3DVpSL9jGgKwmzKKa6LGc0j9WAw+teWm2T66bm5dhVktYmG4
        1R8QsGAnlqODu9QBUjUZwrmSz1SjMRtjwiZW2jfVKRqXpz65R6T0JQ+LME0eLpMW
        +W/cRmcDRl/JGzo4012r/JTYyLhbXOx/IpQ6sIxy8gK5dQxH6gx+biFd0V6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666301773; x=1666388173; bh=h4l4CTUEVF0osrYYvRvUOH8bwHt5
        6ZtdskQUIec2rS8=; b=NGEItpDyrb9cBSskuo5y/TzhEGR2Y1covduDlKT6Zoha
        hRqX8YqYj5Op0/w6fG8b4Sn+wyxgI310a1dISRn1amYq1jI8Y8yvSCU1vnhB0yBe
        H68gDcOtMpk2kZ0MgIfLyNcYX6gYFqmGbFQnt0xLllmFVNRzNyNDiV80BBPnJTAM
        Vh8Vwx4LCPJ3BQM+Jk/khfcawZDWQ5Tqu/zVi6RhKOy/11ykmv+JlzG9shH+NzGZ
        Tj73cPPlTsEB1HCwtbadcKRClsfEgFuWf6RUx4HsvtTCIUCi4y8mw/IkbEyBRMFb
        cBA9sGhm62Grn7w8AW5P0C0JLWujtKaPKZJb0ZsoGQ==
X-ME-Sender: <xms:Tb9RY0DuTbdUPECU8INDNr6WeDTWLBWwlvsqsdIqX_UmDWVVFf71Kg>
    <xme:Tb9RY2gNMnv_ZFjCYOob7hzS-5PSEpJSgH_4GTw9jXlmWyFvntAuc7r1H1LpYl72B
    S9P1rCcET1TNQ41OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeljedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpeevleettefhffejtedtledtteeutddvlefhgfdtffdt
    jefgudelveetvdekkedvgeenucffohhmrghinheprghlvghphhhsvggtuhhrihhthidrtg
    homhdpohhpvghnfigrlhhlrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Tb9RY3l9m-8TL24MmU6m2Re8tFAr54LUbz0oOLZ4n0tiN5l2wwq-tA>
    <xmx:Tb9RY6yOXpbMMGwFOLkDEqm9DVNBjQzS8zX2aCmObxWax0qz4ssxfw>
    <xmx:Tb9RY5QLReXETOoEoYQIBsr_H5uDNsv8m4dSWENKnR1SzuRCsMsjNg>
    <xmx:Tb9RY4JDAKvau45bm0nNbNN9SVzz9tczsVLldL6VY5NgbrKTZbmoSg>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1A643BC0078; Thu, 20 Oct 2022 17:36:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <e8cc2f80-82ff-4876-bbaa-42ce16e90784@app.fastmail.com>
In-Reply-To: <20221020074440.zdw7gbdjhl4o6z7r@wittgenstein>
References: <f1e63e54-d88d-4b69-86f1-c0b4a0fd8035@app.fastmail.com>
 <20221019132201.kd35firo6ks6ph4j@wittgenstein>
 <6ddd00bd-87d9-484e-8f2a-06f15a75a4df@app.fastmail.com>
 <20221020074440.zdw7gbdjhl4o6z7r@wittgenstein>
Date:   Thu, 20 Oct 2022 15:35:59 -0600
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Christian Brauner" <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Odd interaction with file capabilities and procfs files
Content-Type: text/plain
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022, at 1:44 AM, Christian Brauner wrote:
> On Wed, Oct 19, 2022 at 03:42:42PM -0600, Daniel Xu wrote:
>> Hi Christian,
>> 
>> On Wed, Oct 19, 2022, at 7:22 AM, Christian Brauner wrote:
>> > On Tue, Oct 18, 2022 at 06:42:04PM -0600, Daniel Xu wrote:
>> >> Hi,
>> >> 
>> >> (Going off get_maintainers.pl for fs/namei.c here)
>> >> 
>> >> I'm seeing some weird interactions with file capabilities and S_IRUSR
>> >> procfs files. Best I can tell it doesn't occur with real files on my btrfs
>> >> home partition.
>> >> 
>> >> Test program:
>> >> 
>> >>         #include <fcntl.h>
>> >>         #include <stdio.h>
>> >>         
>> >>         int main()
>> >>         {
>> >>                 int fd = open("/proc/self/auxv", O_RDONLY);
>> >>                 if (fd < 0) {
>> >>                         perror("open");
>> >>                         return 1;
>> >>                 }
>> >>        
>> >>                 printf("ok\n");
>> >>                 return 0;
>> >>         }
>> >> 
>> >> Steps to reproduce:
>> >> 
>> >>         $ gcc main.c
>> >>         $ ./a.out
>> >>         ok
>> >>         $ sudo setcap "cap_net_admin,cap_sys_admin+p" a.out
>> >>         $ ./a.out
>> >>         open: Permission denied
>> >> 
>> >> It's not obvious why this happens, even after spending a few hours
>> >> going through the standard documentation and kernel code. It's
>> >> intuitively odd b/c you'd think adding capabilities to the permitted
>> >> set wouldn't affect functionality.
>> >> 
>> >> Best I could tell the -EACCES error occurs in the fallthrough codepath
>> >> inside generic_permission().
>> >> 
>> >> Sorry if this is something dumb or obvious.
>> >
>> > Hey Daniel,
>> >
>> > No, this is neither dumb nor obvious. :)
>> >
>> > Basically, if you set fscaps then /proc/self/auxv will be owned by
>> > root:root. You can verify this:
>> >
>> > #include <fcntl.h>
>> > #include <sys/types.h>
>> > #include <sys/stat.h>
>> > #include <stdio.h>
>> > #include <errno.h>
>> > #include <unistd.h>
>> >
>> > int main()
>> > {
>> >         struct stat st;
>> >         printf("%d | %d\n", getuid(), geteuid());
>> >
>> >         if (stat("/proc/self/auxv", &st)) {
>> >                 fprintf(stderr, "stat: %d - %m\n", errno);
>> >                 return 1;
>> >         }
>> >         printf("stat: %d | %d\n", st.st_uid, st.st_gid);
>> >
>> >         int fd = open("/proc/self/auxv", O_RDONLY);
>> >         if (fd < 0) {
>> >                 fprintf(stderr, "open: %d - %m\n", errno);
>> >                 return 1;
>> >         }
>> >
>> >         printf("ok\n");
>> >         return 0;
>> > }
>> >
>> > $ ./a.out
>> > 1000 | 1000
>> > stat: 1000 | 1000
>> > ok
>> > $ sudo setcap "cap_net_admin,cap_sys_admin+p" a.out
>> > $ ./a.out
>> > 1000 | 1000
>> > stat: 0 | 0
>> > open: 13 - Permission denied
>> >
>> > So acl_permission_check() fails and returns -EACCESS which will cause
>> > generic_permission() to rely on capable_wrt_inode_uidgid() which checks
>> > for CAP_DAC_READ_SEARCH which you don't have as an unprivileged user.
>> 
>> Thanks for checking on this.
>> 
>> That does explain explain the weirdness but at the expense of another
>> question: why do fscaps cause /proc/self/auxv to be owned by root?
>> Is that the correct semantics? This also seems rather unexpected.
>> 
>> I'll take a look tonight and see if I can come up with any answers.
>
> Sorry I didn't explain this in more detail.
> You mostly uncovered the reasons as evidenced by the Twitter thread.
>
> Yes, this is expected. When a new process that gains privileges during
> exec the kernel will make it non-dumpable. That includes changing of the
> e{g,u}id or fs{g,u}id of the process, s{g,u}id binary execution that
> results in changed e{g,u}id, or if the executed binary has fscaps set if
> the new permitted caps aren't a subset of the currently permitted caps.
>
> The last reason is what causes your sample program's /proc/self to be
> owned by root. The culprit here is cred_cap_issubset() which is called
> during commit_creds() in begin_new_exec().
>
> If the dumpable attribute is set then all files in /proc/<pid> will be
> owned by (userns) root. To get the full picture you'd need to at least
> read man proc(5), man execve(2), and man prctl(2).
>
> The reason behind the dumpability change is to prevent unprivileged user
> to make privilege-elevating-binaries (e.g., s{g,u}id binaries) crash to
> produce (userns-)root-owned coredumps which can be used in exploits. A
> fairly recent example of this is e.g.,
> https://alephsecurity.com/2021/10/20/sudump/
> https://www.openwall.com/lists/oss-security/2021/10/20/2

Thanks for the detailed explanation! I think each sense makes sense to
me now. Even if the final result is a little odd. One of those things I guess
:).

I'll see if a patch to the man-pages is appropriate.

Thanks,
Daniel
