Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263B46FBB5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 01:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjEHXTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 19:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjEHXTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 19:19:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCFE55B2;
        Mon,  8 May 2023 16:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683587929; i=quwenruo.btrfs@gmx.com;
        bh=UsCrcLK3MizUNwHdpTmi6WWXmqjS11Fyjc4KsngQ9pU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Wv5q1lzJAMp/M+2EBozUqAtehip/fs2amFB+A8JvE5Ms0/MJKOje58Ciphi9/l+mv
         o1v/ul1Ax3mdQl+I2f/BOreXOlLIyP5H7qslnvslT/1U7wWNvSl2BjURmW5ACNvfnd
         4+PLs6LKDW+KzxCQWY43WVOaon3sWPXbOeEKBq4+1jfyiwR/cd8rMaailBhRKalcu7
         PgdJHrIUil6vFbVVIRJFy5Pew8XxPiVS5rUyIEDlVi03Uivg5spvs3INZumKfOh2dK
         L4/VfoSstxTKfv6fev5RXp6fp6BNgj2eKOqeDzw2JrGenZLogMZUnqdKZPcYbzp1nD
         RgnT71iZx/1qw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M42nY-1pwA801q0u-00038o; Tue, 09
 May 2023 01:18:49 +0200
Message-ID: <f04cfb6d-9b1f-b5bf-0a41-a93efff47c15@gmx.com>
Date:   Tue, 9 May 2023 07:18:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, dsterba@suse.cz,
        Dave Chinner <david@fromorbit.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <20230505131825.GN6373@twin.jikos.cz>
 <a28b9ff4-c16c-b9ba-8b4b-a00252c32857@igalia.com>
 <20230505230003.GU6373@twin.jikos.cz>
 <ed84081e-3b92-1253-2cf5-95f979c6c2f0@igalia.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ed84081e-3b92-1253-2cf5-95f979c6c2f0@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OkO0kkepp3wUydN4EgtbglTNzyso65XnRr0HwT59coA8Y4gS11k
 7Sg2wC2d1236Nddkujm1ZVGnDOP2nD8TX1zgbpKzGzGUprsUeENsyuhhno571Phwa+3lem6
 k29jEpprdQX7c0Qk2NZfhKdp36kPWf7QCHCL2Z0XZyhhEHFexoZI2OlaPJvOIgmnoIi+3uS
 23llZ6u6w/Pzb7P9yUP6A==
UI-OutboundReport: notjunk:1;M01:P0:/NOB7YIfwHc=;Gp9sLXhFja33PM4qpw/PIV3OLbh
 moL63mDWxOKayT86Vu04p3KN1sj/F+kHf3J2CH7msh5qNj+UIpNPA80Aa40SQLGCgW1NjP+hj
 nyveIiBWH+sOqnXxBjVtAMyn8ho3VXxURtlBAiz7qi2Q6CyaTOKCUwuOnRnVnTVZ9TqMyr/7s
 Dv/ZgJyELeLlbNE5bhh5GmnlhsBbqyAAqNRcaj7ljjHrY1Bp6lPpP/TDnplZHpwJbV98AMgFf
 0Rzc69jiqqCORY1kLpy44pJ8Jpj1aO8Mlx+hQyXHw8bssmqxEc9p/Cdr/+CTBNWoYW+oV4XF7
 eRDdPjgQU11/Mn8DBHJWnTdUSETa2xw1wtP3XYxZ/XzuWd2Bfj+lL6ELKwbuzWim+SVIo7Hdy
 Wnc+SIVUlihgveLvkJ36TpGqkaVxUbGvZk3oGQXVJMjKaeXxMnhcNGZgDS4+QSxum/cSlR4xF
 1j1cMYBxxby92WOJs+qmzFfmBcEaCgmUTVamNd92QvHL/uX+sgaj8T07HrumYSTJ2yZIxGO5j
 ZpKAjgF62MEdfjKG7HTSCXPIf5lGzN/2OerhGtcuFnoSkibffkcvJlXbLP97wEHONRtVN4uP6
 zE7TmdKCiQcOMEwH6VjqdFlw+JCX+AJ5GF8EwB/LYGkhg8elW9PlLw/+X2c4Ptacc5SZ7hd/x
 g1OpFvfnVV1NkuCbXMNh4a2ZhIXAXGBm0cUVGg8BEQ6dgnLsK8dMew5rU13tJRKw1WBT1B+0G
 tPsRnKxghOtd+XidSuGWQCXhomqo34SI+/wgWtwvZLhd2d359o+aHZX6cNehbkveDuFh5CM9K
 HxsUARVrJDana9tncALlVzUe/9RTHuLJjVd+t4IhTYyFLz7kZsyqORY4IABL3N9rGFIsATvin
 tIf3rv5SW3LQ5urTGxiN5GLFYolcq1zPJGFDpsI3Tjx1A5J9i5tgPe/cVy11vunLEEA/Een6/
 1sQz/Bjxj9oZYPNkKhwZZPdGZDM=
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/9 06:59, Guilherme G. Piccoli wrote:
> On 05/05/2023 20:00, David Sterba wrote:
>> [...]
>>> Hi David, thanks for your suggestion!
>>>
>>> It might be possible, it seems a valid suggestion. But worth notice th=
at
>>> we cannot modify the FS at all. That's why I've implemented the featur=
e
>>> in a way it "fakes" the fsid for the driver, as a mount option, but
>>> nothing changes in the FS.
>>>
>>> The images on Deck are read-only. So, by using the metadata_uuid purel=
y,
>>> can we mount 2 identical images at the same time *not modifying* the
>>> filesystem in any way? If it's possible, then we have only to implemen=
t
>>> the skip scanning idea from Qu in the other thread (or else ioclt scan=
s
>>> would prevent mounting them).
>>
>> Ok, I see, the device is read-only. The metadata_uuid is now set on an
>> unmounted filesystem and we don't have any semantics for a mount option=
.
>>
>> If there's an equivalent mount option (let's say metadata_uuid for
>> compatibility) with the same semantics as if set offline, on the first
>> commit the metadata_uuid would be written.
>>
>> The question is if this would be sane for read-only devices. You've
>> implemented the uuid on the metadata_uuid base but named it differently=
,
>> but this effectively means that metadata_uuid could work on read-only
>> devices too, but with some necessary updates to the device scanning.
>>
>>  From the use case perspective this should work, the virtual uuid would
>> basically be the metadata_uuid set and on a read-only device. The
>> problems start in the state transitions in the device tracking, we had
>> some bugs there and the code is hard to grasp. For that I'd very much
>> vote for using the metadata_uuid but we can provide an interface on top
>> of that to make it work.
>
> OK, being completely honest here, I couldn't parse fully what you're
> proposing - I blame it to my lack of knowledge on btrfs, so apologies he=
h
>
> Could you clarify it a bit more? Are you suggesting we somewhat rework
> "metadata_uuid", to kinda overload its meaning to be able to accomplish
> this same-fsid mounting using "metadata_uuid" purely?
>
> I see that we seem to have 3 proposals here:
>
> (a) The compat_ro flag from Qu;
>
> (b) Your idea (that requires some clarification for my fully
> understanding - thanks in advance!);
>
> (c) Renaming the mount option "virtual_fsid" to "nouuid" to keep
> filesystem consistency, like XFS (courtesy of Dave Chinner) - please
> correct me here if I misunderstood you Dave =3D)

To me, (a) and (c) don't conflict at all.

We can allow "nouuid" only to work with SINGLE_DEV compat_ro.

That compat_ro flags is more like a better guarantee that the fs will
never have more disks.

As even with SINGLE_DEV compat_ro flags, we may still want some checks
to prevent the same fs being RW mounted at different instances, which
can cause other problems, thus dedicated "nouuid" may still be needed.

Thanks,
Qu

>
> I'd like to thank you all for the suggestions, and I'm willing to follow
> the preferred one - as long we have a consensus / blessing from the
> maintainers, I'm happy to rework this as the best possible approach for
> btrfs.
>
> Also, what about patch 2, does it make sense or should we kinda "embed"
> the idea of scan skipping into the same-fsid mounting? Per my current
> understanding, the idea (a) from Qu includes/fixes the scan thing and
> makes patch 2 unnecessary.
>
> Thanks,
>
>
> Guilherme
