Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF94368A994
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 12:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjBDLHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 06:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjBDLHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 06:07:35 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD729E35;
        Sat,  4 Feb 2023 03:07:30 -0800 (PST)
Received: from [2001:67c:1810:f055:bde0:6d5b:d664:e19a]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pOGOD-0007HW-7T; Sat, 04 Feb 2023 12:07:25 +0100
Message-ID: <c5259e81-631e-7877-d3b0-5a5a56d35b42@leemhuis.info>
Date:   Sat, 4 Feb 2023 12:07:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: git regression failures with v6.2-rc NFS client
Content-Language: en-US, de-DE
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Charles Edward Lever <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
 <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
 <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
 <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
 <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com>
 <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com>
 <41813D21-95C8-44E3-BB97-1E9C03CE7FE5@redhat.com>
 <79261B77-35D0-4E36-AA29-C7BF9FB734CC@oracle.com>
 <104B6879-5223-485F-B099-767F741EB15B@redhat.com>
 <966AEC32-A7C9-4B97-A4F7-098AF6EF0067@oracle.com>
 <545B5AB7-93A6-496E-924E-AE882BF57B72@hammerspace.com>
 <FA8392E6-DAFC-4462-BDAE-893955F9E1A4@oracle.com>
 <4dd32d-9ea3-4330-454a-36f1189d599@google.com>
 <0D7A0393-EE80-4785-9A83-44CF8269758B@hammerspace.com>
 <ab632691-7e4c-ccbf-99a0-397f1f7d30ec@google.com>
 <8B4F6A20-D7A4-4A22-914C-59F5EA79D252@hammerspace.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <8B4F6A20-D7A4-4A22-914C-59F5EA79D252@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675508850;7ec2fc98;
X-HE-SMSGID: 1pOGOD-0007HW-7T
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.02.23 01:59, Trond Myklebust wrote:
>> On Feb 3, 2023, at 19:15, Hugh Dickins <hughd@google.com> wrote:
>> On Sat, 4 Feb 2023, Trond Myklebust wrote:
>>>> On Feb 3, 2023, at 18:53, Hugh Dickins <hughd@google.com> wrote:
>>>> On Fri, 3 Feb 2023, Chuck Lever III wrote:
>>>>>> On Feb 3, 2023, at 5:26 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
>>>>>> The bottom line is that you’ve always been playing the lottery when mounting tmpfs over NFS.
>>>>>
>>>>> I'm not debating the truth of that. I just don't think we should
>>>>> be making that situation needlessly worse.
>>>>>
>>>>> And I would be much more comfortable with this if it appeared in
>>>>> a man page or on our wiki, or ... I'm sorry, but "some email in
>>>>> 2001" is not documentation a user should be expected to find.
>>>>
>>>> I very much agree with you, Chuck.  Making something imperfect
>>>> significantly worse is called "a regression".
>>>>
>>>> And I would expect the (laudable) optimization which introduced
>>>> that regression to be reverted from 6.2 for now, unless (I imagine
>>>> not, but have no clue) it can be easily conditionalized somehow on
>>>> not-tmpfs or not-simple_dir_operations.  But that's not my call.
>>>>
>>>> What is the likelihood that simple_dir_operations will be enhanced,
>>>> or a satisfactory complicated_dir_operations added?  I can assure
>>>> you, never by me!  If Al or Amir or some dcache-savvy FS folk have
>>>> time on their hands and an urge to add what's wanted, great: but
>>>> that surely will not come in 6.2, if ever.
>>>>
>>>> More likely that effort would have to come from the NFS(D) end,
>>>> who will see the benefit.  And if there's some little tweak to be
>>>> made to simple_dir_operations, which will give you the hint you need
>>>> to handle it better, I expect fsdevel would welcome a patch or two.
>>>
>>> No! If it was impossible to hit this problem before the patch, then I might agree with you. However what it does is exposes a problem that has always existed, but was a lot less likely to happen timing wise when we were allowing glibc to suck in all 50000 or so directory entries in one gulp.
>>>
>>> IOW: this patch doesn’t cause the problem, it just makes it easier to hit when you are using a high performance setup like Chuck's. It was always easy to hit when you were using slower networking and/or smaller rsize values against a remote server with multiple clients creating + deleting files in the same NFS exported tmpfs directory.
>>
>> I can only repeat,
>> making something imperfect significantly worse is called "a regression".
>
> It is exposing a problem which was always there. [...]

But as you said: people are more likely to run into this problem now.
This in the end makes the kernel worse and thus afaics is a regression,
as Hugh mentioned.

There sadly is no quote from Linus in
https://docs.kernel.org/process/handling-regressions.html
that exactly matches and helps in this scenario, but a few that come
close; one of them:

```
Because the only thing that matters IS THE USER.

How hard is that to understand?

Anybody who uses "but it was buggy" as an argument is entirely missing
the point. As far as the USER was concerned, it wasn't buggy - it
worked for him/her.
```

Anyway, I guess we get close to the point where I simply explicitly
mention the issue in my weekly regression report, then Linus can speak
up himself if he wants. No hard feeling here, I think that's just my duty.

BTW, I CCed the regression list, as it should be in the loop for
regressions per
https://docs.kernel.org/admin-guide/reporting-regressions.html]

BTW, Benjamin, you earlier in this thread mentioned:

```
Thorsten's bot is just scraping your regression report email, I doubt
they've carefully read this thread.
```

Well, kinda. It's just not the bot that adds the regression to the
tracking, that's me doing it. But yes, I only skim threads and sometimes
simply when adding lack knowledge or details to decide if something
really is a regression or not. But often that sooner or later becomes
clear -- and then I'll remove an issue from the tracking, if it turns
out it isn't a regression.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
