Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7C559A46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiFXNTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 09:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiFXNTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:19:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA7E54FB6;
        Fri, 24 Jun 2022 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656076751;
        bh=8pdvQyb+k2BmGabpwCSUldRWU0e7oGT4S+wPW5mQQMk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Lks4ltAevV0Yy8685sdGgkU9Nl/edW/mZ//+LfDPkSuB/fi49LYjclI48kQV5IlyC
         5Q77+W96W7RF58qZxbhJcOgv6Rk8ND2VembvNqZ+KOAbt7jgv+tYzdK0gQ4voVXGET
         +hrwsgRqbRB+OEAzSILW45OqOeh7OpIhafnoN5js=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel81-1nU1Lk1yVR-00aplU; Fri, 24
 Jun 2022 15:19:10 +0200
Message-ID: <1b37cfc6-7369-69c1-bd90-5851cc79960d@gmx.com>
Date:   Fri, 24 Jun 2022 21:19:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com> <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+9DE6A/ouG53CBiuxxd3/caC7uSBK/LnxHOT6sQMxbiOavuNdlR
 WGKzh5sS4R3qVRT/cVAfSKlq3L/FtgMrMdU/gBl9zdVe9nA0wkzMIl/VGrEzclq5VAxdYgs
 fhncX8rwU12bC2xbJsa6rdbkKAgfFQyMDYjInuBBLTSMJyA+H62cP2KfE9+hE/ga2gqpHGI
 KQg6VJR4H0T7j0rbexR6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t5I6BgcEdEk=:LBbVQ5BpFGuao/RH3Z7dqw
 u0dyFPNnLZD6wq+GgZ0KepGs4t43enDEBxWAA9PQNbtvYb+rMnF0lCjSRkdY3I5ZmBrWkLO5O
 PGpnC9/FxBK/Tq/1msEEArAkK53mZwKZR6gsnoSrAwC9PD9H9RCk8HfkAv3liQAufVwVNMYDI
 21on6nARuHZdaFhnMvpb8P7IJuEV32neICP6NNxaIHazdZ0liYKws+iJ0vmQdlHmrscqCD2Oq
 /YpBqxjB1vP5XKIT7TpcUCY/CJEHgaqp5hsNQUeMtBgjs0LYfbp/fyK3VymHTdZpMNrgaZUoc
 pH2NGaN/uv8AsbEKL0kngAhX0anV5wMnFpvnQFnNiJd79Ve7HXHk2igx3KcSGsWmbjgQN7fJB
 LR47Oyvqt0HXB0CvYz1zYBQjGKNCndtu4rScEKxLCbu/ZGqMTlM0Rz9j/vwokN/vij1pYGvUz
 UBPONNC+72QDfvqpHhdh9DZNhZtJNw2XC3fo1nENZg9WtXAdLKOmHhPQsRMuBJIZ3ceWb6eKf
 dTnfcIfml7fXJwA2IHkKbjYHrFjJTl8OJkReYu73NMJwMk0MvmL0bBxYyAuxEIvFYRYbXTZbL
 7yT0lnPC6EFWO7UGC7bw8//fXbO8/JFOm8UBJBCwQ6QPJz6028igAaKUPQk7N5SKcYUXpyw6l
 0n3R+NIXpuNOJXlhhOOJnEn4/JuSY59zgga7POMeZPapRAGlxGeGEVqaTZbNcujhHUZRUPRJu
 QbpBXzW4eWo2tCo0uzXjt9J6PMTl9sukVGQ4qqoNqYs5Kw18LVdD5/IzesWO6yP79cfG4JdqD
 KLzGbAzb6wWpcwpS46QzN/WhvqsuGeldJV+A9T5yNwnMReO2gvD9FIvp4aJQCPZQbaJ9JWA3F
 AKNuyt0NGBNzu/rqapycdpTvYwP2zpxxtYegbtAQgXEJw8LnepRI5joUbMBXz0BVQh39ubViP
 3AmiLmpCvtl0RpT+Pekh2k9r7qphqvfZiUHHDcKESANBBFvbv5vlmC4BczFbEuLuTtnIYOg9K
 VPG192TTvsd4rFItfACcl1jtpHeVhm0nGB/tztiE+wvXiYV6NC+Y/3L/DxgPOH5AIwbCGyPsS
 1PBcUeKpVfnG+c3trDHJJNig8ieB1+3RQNalI0YYalc2vwVYC/MFjZVLw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/6/24 21:07, Jan Kara wrote:
> On Fri 24-06-22 14:51:18, Christoph Hellwig wrote:
>> On Fri, Jun 24, 2022 at 08:30:00PM +0800, Qu Wenruo wrote:
>>> But from my previous feedback on subpage code, it looks like it's some
>>> hardware archs (S390?) that can not do page flags update atomically.
>>>
>>> I have tested similar thing, with extra ASSERT() to make sure the cow
>>> fixup code never get triggered.
>>>
>>> At least for x86_64 and aarch64 it's OK here.
>>>
>>> So I hope this time we can get a concrete reason on why we need the
>>> extra page Private2 bit in the first place.
>>
>> I don't think atomic page flags are a thing here.  I remember Jan
>> had chased a bug where we'd get into trouble into this area in
>> ext4 due to the way pages are locked down for direct I/O, but I
>> don't even remember seeing that on XFS.  Either way the PageOrdered
>> check prevents a crash in that case and we really can't expect
>> data to properly be written back in that case.
>
> I'm not sure I get the context 100% right but pages getting randomly dir=
ty
> behind filesystem's back can still happen - most commonly with RDMA and
> similar stuff which calls set_page_dirty() on pages it has got from
> pin_user_pages() once the transfer is done.

Just curious, things like RMDA can mark those pages dirty even without
letting kernel know, but how could those pages be from page cache? By
mmap()?

> page_maybe_dma_pinned() should
> be usable within filesystems to detect such cases and protect the
> filesystem but so far neither me nor John Hubbart has got to implement t=
his
> in the generic writeback infrastructure + some filesystem as a sample ca=
se
> others could copy...

So the generic idea is just to detect if the page is marked dirty by
traditional means, and if not, skip the writeback for them, and wait for
proper notification to fs?

Thanks,
Qu

>
> 								Honza
