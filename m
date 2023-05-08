Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7E76FAF12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 13:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbjEHLwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 07:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbjEHLw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 07:52:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EE1473E8;
        Mon,  8 May 2023 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683546666; i=quwenruo.btrfs@gmx.com;
        bh=RbOR+wvnNGsRTrnJPjo+92s5OuOpCNmax3K4T/qjYRE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=olA1a/UzzXwuS42+1ShDixr5TXbUK8Qv3Z+qTOKdhTdgyknr/EJT5swEyPwXWlbTF
         HYQyrjZ6QJmoiKBtLm/W4HEeuH61uCiU5VHo2gz+trnuCg/n9HD2Chr9PgibAMBBOl
         45ztlDoFYJYW5huxVkDJ3IbDgeQEWqENhgLmdN22mQqEoFG0/p/g6VIQqQmYbcfayB
         ho2WIw+pAPOZSxWOY/ZEeBwGpYga5wi8e3fvDeiV/EZ6TkVPycW85aCYn9his+u9Gb
         5R5s9k22MX7yV67E9fg8ZQvcJmgOSOHFu+UM/piJCDG1siZ7OGM1pes543o0lrcmHM
         xgW/hZ7QjdEMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzjt-1pgmzA1s2j-00XOdC; Mon, 08
 May 2023 13:51:06 +0200
Message-ID: <7eaf251e-2369-1a07-a81f-87e4da8b6780@gmx.com>
Date:   Mon, 8 May 2023 19:50:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
 <20230505133810.GO6373@twin.jikos.cz>
 <9839c86a-10e9-9c3c-0ddb-fc8011717221@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9839c86a-10e9-9c3c-0ddb-fc8011717221@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kerb16AerRTbKT78OBETkkwJmsnftnRH6x+4gZHI4Gnri3+oHTL
 JOwL49fC7KByRCMo7x94OXMvtaOJ10EsLSmuGGOYCnZcGwFTME60DzI9mWGUg2FQ7evE0my
 XIlRa01yiu/8mT2PnA3jjlq8rXXnfmRCunV3oP2jpBzA22NkIPGOnvqS1xWY6E3sc/0XN4B
 vA0d47ESWPpUsFlONS+vw==
UI-OutboundReport: notjunk:1;M01:P0:ysjUo3Xz5AI=;kibXP5r2cKSp9BeShMToBBbwj+n
 7t4uAr/dmx5J87oHCfzqsbZmS6iK+L58cTj57ahYYZ8xB3lVw45sQUfVVmQnDTDaeEBUM1ne3
 5KVPCoeGVbYokYS2gkQM2XsoWWlkCKXmY8+XxitVJyr3VmPbTSijbay0aKIrbUBt/K9UjVtmN
 hu8FA9bGPS6KeZzJLXmHpego5GxXKwjvBGVAVYPYAe9eR2OOLA9Ti+CI75PM2FUe59gZzF7q3
 X0z/G2r1iudnG5D6J+gVE0YF5cMgRGXTV7DsJZtYzmtDoelWhKU3kZLnJlT5ZgJjMKXHhAJht
 AtqTgCLTscjCTOTiAF4TJsP28/1dGC9VWC5RGjCjsM/IGveWiO/YnXnsQzLtHTQ95ne0ztSUB
 JcWIYLK3T996w5RaZB0WxJ9nIQpb7KcbwqvtvN2BaEr89AZgePvIJ+wiQumpopPyD3E35OcW5
 UEAtX/C3SX1eB4lwDPBHpseynrwzhTYWL8be8lj4/bpTs0QbLe8dyBTpk1XkyAItK8E7/2oWs
 J/V9sv3+hxuZ2lHVqLYq2nC6/FYUR+8oOTULHkAfuE0TjiIFTU19lpqhBw8dEI+O4i1aNFF/k
 uLKw/FYYqoJQJN87EptBi/nT/DuNNo+vxHTZ/cUn0oI3++AJ5W5YBaNGLvzl5HcCac3fvza7b
 nMCgAe8IwAmmrb7MTxmuz0eZ7xydqNNsLgSBjuSku2rC7RMnkQOEfFOaIAwf9/bFHdVIRGULE
 Z8Q23utEN3bElflWwqbM+l8m0Wk2OWk+bH1Ft4EblFAVJ0T8G6MuGGMMq/U5ZgzIcIzPjfmgv
 JCKyWNJd5YE3VlsiEcAlfOX4wBFC9IizW+KB/U14cv7WuhaZ9LFg/aZNH64birBiEvWW41S5L
 RT2XvZ8cbleazVJLQoMnu6n53+jFXXn89Ubt+MEaNZqkdSKHE6Wx1ts41gS6iUUcbziEkouBB
 d6k/uqQXnukrEgUcb+gP1efoKkY=
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/8 19:27, Anand Jain wrote:
> On 05/05/2023 21:38, David Sterba wrote:
>> On Fri, May 05, 2023 at 03:21:35PM +0800, Qu Wenruo wrote:
>>> On 2023/5/5 01:07, Guilherme G. Piccoli wrote:
>>>> Btrfs doesn't currently support to mount 2 different devices holding
>>>> the
>>>> same filesystem - the fsid is used as a unique identifier in the
>>>> driver.
>>>> This case is supported though in some other common filesystems, like
>>>> ext4; one of the reasons for which is not trivial supporting this cas=
e
>>>> on btrfs is due to its multi-device filesystem nature, native RAID,
>>>> etc.
>>>
>>> Exactly, the biggest problem is the multi-device support.
>>>
>>> Btrfs needs to search and assemble all devices of a multi-device
>>> filesystem, which is normally handled by things like LVM/DMraid, thus
>>> other traditional fses won't need to bother that.
>>>
>>>>
>>>> Supporting the same-fsid mounts has the advantage of allowing btrfs t=
o
>>>> be used in A/B partitioned devices, like mobile phones or the Steam
>>>> Deck
>>>> for example. Without this support, it's not safe for users to keep th=
e
>>>> same "image version" in both A and B partitions, a setup that is quit=
e
>>>> common for development, for example. Also, as a big bonus, it allows =
fs
>>>> integrity check based on block devices for RO devices (whereas
>>>> currently
>>>> it is required that both have different fsid, breaking the block devi=
ce
>>>> hash comparison).
>>>>
>>>> Such same-fsid mounting is hereby added through the usage of the
>>>> mount option "virtual_fsid" - when such option is used, btrfs generat=
es
>>>> a random fsid for the filesystem and leverages the metadata_uuid
>>>> infrastructure (introduced by [0]) to enable the usage of this
>>>> secondary
>>>> virtual fsid. But differently from the regular metadata_uuid flag, th=
is
>>>> is not written into the disk superblock - effectively, this is a
>>>> spoofed
>>>> fsid approach that enables the same filesystem in different devices t=
o
>>>> appear as different filesystems to btrfs on runtime.
>>>
>>> I would prefer a much simpler but more explicit method.
>>>
>>> Just introduce a new compat_ro feature, maybe call it SINGLE_DEV.
>>>
>>> By this, we can avoid multiple meanings of the same super member, nor
>>> need any special mount option.
>>> Remember, mount option is never a good way to enable/disable a new
>>> feature.
>>>
>>> The better method to enable/disable a feature should be mkfs and
>>> btrfstune.
>>>
>>> Then go mostly the same of your patch, but maybe with something extra:
>>>
>>> - Disbale multi-dev code
>>> =C2=A0=C2=A0=C2=A0 Include device add/replace/removal, this is already=
 done in your
>>> =C2=A0=C2=A0=C2=A0 patch.
>>>
>>> - Completely skip device scanning
>>> =C2=A0=C2=A0=C2=A0 I see no reason to keep btrfs with SINGLE_DEV featu=
re to be added to
>>> =C2=A0=C2=A0=C2=A0 the device list at all.
>>> =C2=A0=C2=A0=C2=A0 It only needs to be scanned at mount time, and neve=
r be kept in the
>>> =C2=A0=C2=A0=C2=A0 in-memory device list.
>>
>> This is actually a good point, we can do that already. As a conterpart
>> to 5f58d783fd7823 ("btrfs: free device in btrfs_close_devices for a
>> single device filesystem") that drops single device from the list,
>> single fs devices wouldn't be added to the list but some checks could b=
e
>> still done like superblock validation for eventual error reporting.
>
> Something similar occurred to me earlier. However, even for a single
> device, we need to perform the scan because there may be an unfinished
> replace target from a previous reboot, or a sprout Btrfs filesystem may
> have a single seed device. If we were to make an exception for replace
> targets and seed devices, it would only complicate the scan logic, which
> goes against our attempt to simplify it.

If we go SINGLE_DEV compat_ro flags, then no such problem at all, we can
easily reject any multi-dev features from such SINGLE_DEV fs.

Thanks,
Qu

>
> Thanks, Anand
>
>
