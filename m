Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD26753236
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 08:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjGNGqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 02:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjGNGqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:46:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E9C2D68
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689317114; x=1689921914; i=quwenruo.btrfs@gmx.com;
 bh=2RqRfOySB/d54zssUdyCO5fi8djNfoM6ZaMHoZzxly8=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=Gzs4NZS1XP3l0pWYurVkYMNKYzR7sAoWMvHqr75ZPQy4a0BieYqT+eftXfjlvCCyV77aHFJ
 MD1idzP7UDNEuId3sQ4E4Wd/bPT+Q+WWTR4i1bHics8LdH2cKVsaosA0Gy+xduYdXk2hz6c5p
 7qjEQiFJURavA7YUEU+CHtLo0FtIqPDinK9ULqNbS2IfhOjKz6j/Lq0RS7P1ao+p/zyxMSdCY
 2Na88SH+DL9cZNs60GS59mIzWEPBZxks3bonH7L6YXXGbj8poNAoBbikA1I1egxNwrO4kUTie
 LZ/ZG6AkLc29Ihr/zdPeJIrRkpXfeZPiRkKiZn1xNB33iMGhbgKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiPl-1qWSbE0vV7-00U4Jt for
 <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 08:45:13 +0200
Message-ID: <b7ef3326-5dcf-8dab-327e-96c385d05e57@gmx.com>
Date:   Fri, 14 Jul 2023 14:45:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Mount option "atime" cause all common filesystems to fail
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fgEpjJI62S/jL11T0EhhYcvzOz9RMpvDn+5zIvvwGDL9aiWqVPl
 Ig8+OaXx0XrPfCRmWC6DKlgY9AnRFU5OZHvX3VXY/xcCNYvaEf+t0sudXC1QB1tCwJkQigQ
 eFoHQask3M1QbLjrEBthOpWtr4L6espQgKZsA2b6s4PfTHovOeAJIU2Ud3FeUUJV3/swGWM
 bPDvY46Tqc6POvVBTNxfA==
UI-OutboundReport: notjunk:1;M01:P0:RRNMAr4luq4=;R7GgogOjdxaAF2jpRmacrlvI0KQ
 IfqgKzQLBP8/4GRq811MYJgxtQwMJ4tb8qCXWUMrWV+D2sBUML+4Qbh+waBpspvVYJi21famO
 a8VTiKSfybqi9uBzhG8ZOYhyhxLlOu2YzgkzE7b7eYV3uy2EPN9SdbQHSlnHFDWI5vybhSKSt
 8RXjM8C5nAChWkqRyLmD17Nu4blFgCFFE14yiKhZ1If/yheNaDagWmCwPsrIqiHXn4cS8/uHg
 GMMtaCuv3r6yuSHj8PkgDONkpQh7EoeGraQYbi3PLUq3oU6wYX2hdcbLdI6EfQ/qvaJF1Zi/z
 GwYsY46Kj8C+DIqSxt0A9LMTtqGYyigzBq4Q5dyRA/DZsWDwHPRf9Gj4Db7uTtp3+Xh/o5k9i
 Y7P01aYajwKC0eJkvSvR1Sa2Lc+fMpDXSVBsSzNmwcq0Bz3AvZWTwcemnEnMu7HCv74AkfsfZ
 Y/acGXALk1XaPKzZNe11XXR3rqhLPb2+S/AgY2pwln+vrBPieVGfxi6pwyuGMkr5vftY10QDE
 3qkdZPXFi60QDTHd+LA2+QIpEmQB7/y3O9RPgSI713K7LVA+pKWY669koAAruOiir5X7l40Rn
 XOaWoXHk+cKSNlct3Zc/1Y4EVNLT6P80GoAimpbrAmANhKaS+YiwBsJa7He2bwjOA9ni4xC+4
 d+rNgzFyGfOWIAQiQJAurp2XeR2UbljIzXumwlLAu1E1dINjWXVmz66HZbYET5RSBV5MbqsQH
 1Su/MpfMNE3kiFheSGFAea9MaQmxK64VDTrJYun11nY1lhSTIURt5lkyynAr0znI/o+xNz191
 PiDfTRfJ0EBc15J3dhWNe/rV1+5Z8TjtbQPebPqdO6p+Eyf0RdTriNLQ0xP6w3H0678cf0kBU
 rgWZSfcrWvHMS1jQimIOCFWzMjM0fzQ7FGXakhqUdeea0Ra+DxuFFFUqhNBXcm0NI9/nlPp9X
 /EFwkRYmOhSzJ87WzRnVPMF0ubM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Not sure if it's the kernel or the mount tool (more likely to be mount
tool? As switching back to v6.3 doesn't help), but 'atime' mount option
caused Btrfs/Ext4/Xfs to fail without any useful error messages:

  # mkfs.ext4 test.img
  # mount -o atime test.img /mnt/data/
  mount: /mnt/data: not mount point or bad option.
         dmesg(1) may have more information after failed mount system call=
.
  # dmesg | tail -n 4
  [  161.802061] loop0: detected capacity change from 0 to 2097152
  [  168.729867] loop0: detected capacity change from 0 to 2097152
  [  168.741244] EXT4-fs (loop0): mounted filesystem
3ed71bc6-d7d0-43d3-9f9a-7187133d83d4 r/w with ordered data mode. Quota
mode: none.
  [  168.742701] EXT4-fs (loop0): unmounting filesystem
3ed71bc6-d7d0-43d3-9f9a-7187133d83d4.

The same applies to XFS and Btrfs, none of the mount tool or dmesg shows
any clue on this.

For the btrfs part, the mount entrance (btrfs_mount()) returned no
error, thus it's pretty weird why the mount can still fail.

Is this a known problem?

Thanks,
Qu
