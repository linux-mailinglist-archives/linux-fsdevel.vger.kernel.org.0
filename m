Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63DA6EEC5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 04:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbjDZC2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 22:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbjDZC16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 22:27:58 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0298A54;
        Tue, 25 Apr 2023 19:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1682476074; i=@fujitsu.com;
        bh=SRX4u1hksNOjXaqCfLCkjPKJjm0vVvSWrZQKjRlWJBE=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=y9XAIRO3UnvWls8edPx/JKSDG30bnlFMQTApijHQlM9c/PZEbb9kWZnAE6HHaax4H
         ytq7SGDlvynfydVZ8mHP3IV7VGIf4kQS0vIQOQXIlbq9FRAhK+nbQ/YJX5aEkS292a
         pOZEzLS48jBxUQVsC5wVe2D/0Wvds5Q3jV4VqItcuI5yDokvmfbcfRfhmEuyYzhrjr
         UgPoZ+l4YH/CtnmGj4d2fa7lUq2rGHOpyGUgOY0uw+Yb7uNDtUkG2XcMxj0zLAeJKK
         Zz99n24GFF3/pH41uWhLmixoqvH88FxdjFIWguBmkHYI6CrhlPLp0Jt/rASKtJvnju
         3Y3Kl3V0KYLDg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRWlGSWpSXmKPExsViZ8ORqKvR45F
  icPYXs8Wc9WvYLKZPvcBocfkJn8Xs6c1MFnv2nmSxuLfmP6vFrj872C1uTHjKaLHyxx9Wi98/
  5rA5cHlsXqHlsXjPSyaPTas62Tw2fZrE7nFixm8WjxebZzJ6nFlwhN3j8ya5AI4o1sy8pPyKB
  NaMQ89XMBVclau4dFamgbFPsouRi0NIYAujxLprz9ghnBVMEguubWCEcLYzSly7v4Wti5GTg1
  fATqLh8ysWEJtFQFWi58UnZoi4oMTJmU/A4qICKRIzNi4GiwsLhEos/DOHCcQWEciUOP/kDRP
  IUGaBw4wSSzpvskFseMwkMXnaL7AqNgEdiQsL/rJ2MXJwcAqYSSx6zQcSZhawkFj85iA7hC0v
  0bx1NtgCCQEliYtf77BC2JUSrR9+sUDYahJXz21insAoNAvJfbOQjJqFZNQCRuZVjKbFqUVlq
  UW6ZnpJRZnpGSW5iZk5eolVuol6qaW65anFJbpGeonlxXqpxcV6xZW5yTkpenmpJZsYgXGYUq
  youYPxw86/eocYJTmYlER5ucLcUoT4kvJTKjMSizPii0pzUosPMcpwcChJ8Jp1eqQICRalpqd
  WpGXmAFMCTFqCg0dJhDeyAyjNW1yQmFucmQ6ROsWoy7Gt/+peZiGWvPy8VClxXt1uoCIBkKKM
  0jy4EbD0dIlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO/KdqApPJl5JXCbXgEdwQR0RDkD2
  BEliQgpqQamnIxTtxTzYnfPuZh08/Adcd4LV3TtMr5lvWlLnbdB7m2eotQr68kS2VyuBj8/Wf
  65sKWlxd1Eq2limlU4r0v7/MZl8/N6O8T0tX8rv/BPOqbpcHE5ywzmByZHNi2acqvOUuVKtcw
  Ej2X8ebJHXeRjJzNZdHcH/bBcftG19KVZ/4ovXE92Bu+Y3/ZrAt8vv3uu1x89KdtT93S36Xmj
  edb8fCUc6x3i7jb7/WE70HSr3z/0+b2OlQsihZ+8XHpawVNwatnvjFlrL156wDfXeptp/8cKo
  wiJqVsfzs9elH0vySh0acHk1IrI56eZ5vzy0UnIlvr178uq6zvSSxVtXnvZqF/d0fjGZpP1fM
  a5mrXuSizFGYmGWsxFxYkAIn4hIsoDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-3.tower-571.messagelabs.com!1682476071!252115!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8290 invoked from network); 26 Apr 2023 02:27:52 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-3.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2023 02:27:52 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id AFBBB100191;
        Wed, 26 Apr 2023 03:27:51 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id A214F10018D;
        Wed, 26 Apr 2023 03:27:51 +0100 (BST)
Received: from [192.168.50.5] (10.167.234.230) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 26 Apr 2023 03:27:47 +0100
Message-ID: <baabaf6d-151b-9667-c766-bf3e89b085cb@fujitsu.com>
Date:   Wed, 26 Apr 2023 10:27:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v11.1 2/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for
 unbind
To:     "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <dan.j.williams@intel.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
References: <1679996506-2-3-git-send-email-ruansy.fnst@fujitsu.com>
 <1681296735-2-1-git-send-email-ruansy.fnst@fujitsu.com>
 <0a53ee26-5771-0808-ccdc-d1739c9dacac@fujitsu.com>
 <20230420120956.cdxcwojckiw36kfg@quack3>
 <d557c0cb-e244-6238-2df4-01ce75ededdf@fujitsu.com>
 <20230425132315.u5ocvbneeqzzbifl@quack3>
 <20230425151800.GS360889@frogsfrogsfrogs>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20230425151800.GS360889@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/4/25 23:18, Darrick J. Wong 写道:
> On Tue, Apr 25, 2023 at 03:23:15PM +0200, Jan Kara wrote:
>> On Tue 25-04-23 20:47:35, Shiyang Ruan wrote:
>>>
>>>
>>> 在 2023/4/20 20:09, Jan Kara 写道:
>>>> On Thu 20-04-23 10:07:39, Shiyang Ruan wrote:
>>>>> 在 2023/4/12 18:52, Shiyang Ruan 写道:
>>>>>> This is a RFC HOTFIX.
>>>>>>
>>>>>> This hotfix adds a exclusive forzen state to make sure any others won't
>>>>>> thaw the fs during xfs_dax_notify_failure():
>>>>>>
>>>>>>      #define SB_FREEZE_EXCLUSIVE	(SB_FREEZE_COMPLETE + 2)
>>>>>> Using +2 here is because Darrick's patch[0] is using +1.  So, should we
>>>>>> make these definitions global?
>>>>>>
>>>>>> Another thing I can't make up my mind is: when another freezer has freeze
>>>>>> the fs, should we wait unitl it finish, or print a warning in dmesg and
>>>>>> return -EBUSY?
>>>>>>
>>>>>> Since there are at least 2 places needs exclusive forzen state, I think
>>>>>> we can refactor helper functions of freeze/thaw for them.  e.g.
>>>>>>      int freeze_super_exclusive(struct super_block *sb, int frozen);
>>>>>>      int thaw_super_exclusive(struct super_block *sb, int frozen);
>>>>>>
>>>>>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=repair-fscounters&id=c3a0d1de4d54ffb565dbc7092dfe1fb851940669
>>>>
>>>> I'm OK with the idea of new freeze state that does not allow userspace to
>>>> thaw the filesystem. But I don't really like the guts of filesystem
>>>> freezing being replicated inside XFS. It is bad enough that they are
>>>> replicated in [0], replicating them *once more* in another XFS file shows
>>>> we are definitely doing something wrong. And Luis will need yet another
>>>> incantation of the exlusive freeze for suspend-to-disk. So please guys get
>>>> together and reorganize the generic freezing code so that it supports
>>>> exclusive freeze (for in-kernel users) and works for your usecases instead
>>>> of replicating it inside XFS...
>>>
>>> I agree that too much replicating code is not good.  It's necessary to
>>> create a generic exclusive freeze/thaw for all users.  But for me, I don't
>>> have the confidence to do it well, because it requires good design and code
>>> changes will involve other filesystems.  It's diffcult.
>>>
>>> However, I hope to be able to make progress on this unbind feature. Thus, I
>>> tend to refactor a common helper function for xfs first, and update the code
>>> later when the generic freeze is done.
>>
>> I think Darrick was thinking about working on a proper generic interface.
>> So please coordinate with him.
> 
> I'll post a vfs generic kernelfreeze series later today.
> 
> One thing I haven't figured out yet is what's supposed to happen when
> PREREMOVE is called on a frozen filesystem.

call PREREMOVE when:
1. freezed by kernel:    we wait unitl kernel thaws -> not sure
2. freezed by userspace: we take over the control of freeze state:
      a. userspace can't thaw before PREREMOVE is done
      b. kernel keeps freeze state after PREREMOVE is done and before 
userspace thaws

Since the unbind interface doesn't return any other errcode except 
-ENODEV, the only thing I can think of to do is wait for the other one 
done?  If another one doesn't thaw after a long time waitting, we print 
a "waitting too long" warning in dmesg.  But I'm not sure if this is good.

> We don't want userspace to
> be able to thaw the fs while PREREMOVE is running, so I /guess/ that
> means we need some method for the kernel to take over a userspace
> freeze and then put it back when we're done?

As is designed by Luis, we can add sb->s_writers.frozen_by_user flag to 
distinguish whether current freeze state is initiated by kernel or 
userspace.  In his patch, userspace can take over kernel's freeze.  We 
just need to switch the order.


--
Thanks,
Ruan.

> 
> --D
> 
>> 								Honza
>>
>> -- 
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
